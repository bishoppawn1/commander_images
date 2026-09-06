#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO

private let expectedDPI = 600.0

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 4,
      let border = Int(CommandLine.arguments[3]),
      border > 0 else {
    fail("Usage: validate_cut_border.swift BEFORE.png AFTER.png BORDER_PIXELS")
}

func load(_ path: String) -> (CGImage, [CFString: Any]) {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil),
          let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [CFString: Any] else {
        fail("Could not read \(path).")
    }
    return (image, properties)
}

func rgbaPixels(_ image: CGImage) -> [UInt8] {
    guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
        fail("Could not create the sRGB color space.")
    }
    let bytesPerRow = image.width * 4
    var pixels = [UInt8](repeating: 0, count: bytesPerRow * image.height)
    guard let context = CGContext(
        data: &pixels,
        width: image.width,
        height: image.height,
        bitsPerComponent: 8,
        bytesPerRow: bytesPerRow,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
    ) else {
        fail("Could not create an inspection canvas.")
    }
    context.interpolationQuality = .none
    context.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
    return pixels
}

let beforePath = CommandLine.arguments[1]
let afterPath = CommandLine.arguments[2]
let (beforeImage, _) = load(beforePath)
let (afterImage, afterProperties) = load(afterPath)
guard beforeImage.width == afterImage.width, beforeImage.height == afterImage.height else {
    fail("Dimensions changed from \(beforeImage.width) × \(beforeImage.height) to \(afterImage.width) × \(afterImage.height).")
}

let dpiWidth = (afterProperties[kCGImagePropertyDPIWidth] as? NSNumber)?.doubleValue ?? -1
let dpiHeight = (afterProperties[kCGImagePropertyDPIHeight] as? NSNumber)?.doubleValue ?? -1
guard abs(dpiWidth - expectedDPI) < 0.01, abs(dpiHeight - expectedDPI) < 0.01 else {
    fail("Expected 600 × 600 DPI; found \(dpiWidth) × \(dpiHeight).")
}

let beforePixels = rgbaPixels(beforeImage)
let afterPixels = rgbaPixels(afterImage)
let bytesPerRow = afterImage.width * 4

for y in 0..<afterImage.height {
    for x in 0..<afterImage.width {
        let offset = (y * bytesPerRow) + (x * 4)
        let isBorder = x < border || x >= afterImage.width - border || y < border || y >= afterImage.height - border
        if isBorder {
            guard afterPixels[offset] == 0,
                  afterPixels[offset + 1] == 0,
                  afterPixels[offset + 2] == 0,
                  afterPixels[offset + 3] == 255 else {
                fail("Non-black cut-guide pixel at (\(x), \(y)).")
            }
        } else {
            guard beforePixels[offset] == afterPixels[offset],
                  beforePixels[offset + 1] == afterPixels[offset + 1],
                  beforePixels[offset + 2] == afterPixels[offset + 2],
                  beforePixels[offset + 3] == afterPixels[offset + 3] else {
                fail("Interior changed at (\(x), \(y)).")
            }
        }
    }
}

print("PASS \(afterPath): \(border)-pixel black cut guide, unchanged interior, 600 DPI")
