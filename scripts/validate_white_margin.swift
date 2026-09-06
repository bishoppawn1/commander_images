#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO

private let expectedWidth = 1800
private let expectedHeight = 2100
private let expectedDPI = 600.0
private let margin = 113

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count >= 2 else {
    fail("Usage: validate_white_margin.swift IMAGE.png [IMAGE.png ...]")
}

guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
    fail("Could not create the sRGB color space.")
}

for path in CommandLine.arguments.dropFirst() {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil),
          let rawProperties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [CFString: Any] else {
        fail("Could not read \(path).")
    }

    guard image.width == expectedWidth, image.height == expectedHeight else {
        fail("\(path): expected 1800 × 2100; found \(image.width) × \(image.height).")
    }

    let dpiWidth = (rawProperties[kCGImagePropertyDPIWidth] as? NSNumber)?.doubleValue ?? -1
    let dpiHeight = (rawProperties[kCGImagePropertyDPIHeight] as? NSNumber)?.doubleValue ?? -1
    guard abs(dpiWidth - expectedDPI) < 0.01, abs(dpiHeight - expectedDPI) < 0.01 else {
        fail("\(path): expected 600 × 600 DPI; found \(dpiWidth) × \(dpiHeight).")
    }

    let bytesPerRow = expectedWidth * 4
    var pixels = [UInt8](repeating: 0, count: bytesPerRow * expectedHeight)
    guard let context = CGContext(
        data: &pixels,
        width: expectedWidth,
        height: expectedHeight,
        bitsPerComponent: 8,
        bytesPerRow: bytesPerRow,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
    ) else {
        fail("\(path): could not create an inspection canvas.")
    }
    context.draw(image, in: CGRect(x: 0, y: 0, width: expectedWidth, height: expectedHeight))

    for y in 0..<expectedHeight {
        for x in 0..<expectedWidth where x < margin || x >= expectedWidth - margin || y < margin || y >= expectedHeight - margin {
            let offset = (y * bytesPerRow) + (x * 4)
            guard pixels[offset] == 255,
                  pixels[offset + 1] == 255,
                  pixels[offset + 2] == 255,
                  pixels[offset + 3] == 255 else {
                fail("\(path): non-white margin pixel at (\(x), \(y)).")
            }
        }
    }

    print("PASS \(path)")
}
