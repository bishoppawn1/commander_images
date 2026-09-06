#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO

private let width = 1724
private let height = 2024
private let dpi = 600.0
private let cutGuide = 3
private let leftArtworkEdge = 40
private let rightArtworkEdge = 1684
private let bottomWhiteStart = 1928

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count >= 2 else {
    fail("Usage: validate_final_black_margin.swift IMAGE.png [IMAGE.png ...]")
}

guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
    fail("Could not create the sRGB color space.")
}

for path in CommandLine.arguments.dropFirst() {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil),
          let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [CFString: Any] else {
        fail("Could not read \(path).")
    }
    guard image.width == width, image.height == height else {
        fail("\(path): expected 1724 × 2024; found \(image.width) × \(image.height).")
    }
    let dpiWidth = (properties[kCGImagePropertyDPIWidth] as? NSNumber)?.doubleValue ?? -1
    let dpiHeight = (properties[kCGImagePropertyDPIHeight] as? NSNumber)?.doubleValue ?? -1
    guard abs(dpiWidth - dpi) < 0.01, abs(dpiHeight - dpi) < 0.01 else {
        fail("\(path): expected 600 × 600 DPI; found \(dpiWidth) × \(dpiHeight).")
    }

    let bytesPerRow = width * 4
    var pixels = [UInt8](repeating: 0, count: bytesPerRow * height)
    guard let context = CGContext(
        data: &pixels,
        width: width,
        height: height,
        bitsPerComponent: 8,
        bytesPerRow: bytesPerRow,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
    ) else {
        fail("\(path): could not create an inspection canvas.")
    }
    context.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))

    func pixelIs(_ x: Int, _ y: Int, _ value: UInt8) -> Bool {
        let offset = (y * bytesPerRow) + (x * 4)
        return pixels[offset] == value &&
               pixels[offset + 1] == value &&
               pixels[offset + 2] == value &&
               pixels[offset + 3] == 255
    }

    for y in 0..<height {
        for x in 0..<width where x < cutGuide || x >= width - cutGuide || y < cutGuide || y >= height - cutGuide {
            guard pixelIs(x, y, 0) else {
                fail("\(path): non-black cut-guide pixel at (\(x), \(y)).")
            }
        }
    }

    for y in cutGuide..<(height - cutGuide) {
        for x in cutGuide..<leftArtworkEdge {
            guard pixelIs(x, y, 0) else {
                fail("\(path): left margin is not black at (\(x), \(y)).")
            }
        }
        for x in rightArtworkEdge..<(width - cutGuide) {
            guard pixelIs(x, y, 0) else {
                fail("\(path): right margin is not black at (\(x), \(y)).")
            }
        }
    }

    for y in bottomWhiteStart..<(height - cutGuide) {
        for x in leftArtworkEdge..<rightArtworkEdge {
            guard pixelIs(x, y, 0) else {
                fail("\(path): bottom margin is not black at (\(x), \(y)).")
            }
        }
    }

    print("PASS \(path): 1724 × 2024, 600 DPI, 3px cut guide, 37px side blacks, 93px bottom black, no top margin")
}
