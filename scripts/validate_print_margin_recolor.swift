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
private let bottomMarginStart = 1928

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 3 else {
    fail("Usage: validate_print_margin_recolor.swift BEFORE.png AFTER.png")
}

guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
    fail("Could not create the sRGB color space.")
}

func load(_ path: String) -> ([UInt8], Double, Double) {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil),
          let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [CFString: Any] else {
        fail("Could not read \(path).")
    }
    guard image.width == width, image.height == height else {
        fail("\(path): expected 1724 × 2024; found \(image.width) × \(image.height).")
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

    let dpiWidth = (properties[kCGImagePropertyDPIWidth] as? NSNumber)?.doubleValue ?? -1
    let dpiHeight = (properties[kCGImagePropertyDPIHeight] as? NSNumber)?.doubleValue ?? -1
    return (pixels, dpiWidth, dpiHeight)
}

let beforePath = CommandLine.arguments[1]
let afterPath = CommandLine.arguments[2]
let (before, beforeDPIWidth, beforeDPIHeight) = load(beforePath)
let (after, afterDPIWidth, afterDPIHeight) = load(afterPath)

for value in [beforeDPIWidth, beforeDPIHeight, afterDPIWidth, afterDPIHeight] {
    guard abs(value - dpi) < 0.01 else {
        fail("Expected both files to retain 600 × 600 DPI metadata.")
    }
}

let bytesPerRow = width * 4
for y in 0..<height {
    for x in 0..<width {
        let offset = (y * bytesPerRow) + (x * 4)
        let visibleSideMargin = y >= cutGuide && y < height - cutGuide &&
            ((x >= cutGuide && x < leftArtworkEdge) ||
             (x >= rightArtworkEdge && x < width - cutGuide))
        let visibleBottomMargin = y >= bottomMarginStart && y < height - cutGuide &&
            x >= leftArtworkEdge && x < rightArtworkEdge

        if visibleSideMargin || visibleBottomMargin {
            guard before[offset] == 255,
                  before[offset + 1] == 255,
                  before[offset + 2] == 255,
                  before[offset + 3] == 255 else {
                fail("\(beforePath): expected white source margin at (\(x), \(y)).")
            }
            guard after[offset] == 0,
                  after[offset + 1] == 0,
                  after[offset + 2] == 0,
                  after[offset + 3] == 255 else {
                fail("\(afterPath): expected black replacement margin at (\(x), \(y)).")
            }
        } else {
            guard before[offset] == after[offset],
                  before[offset + 1] == after[offset + 1],
                  before[offset + 2] == after[offset + 2],
                  before[offset + 3] == after[offset + 3] else {
                fail("Unexpected non-margin change at (\(x), \(y)).")
            }
        }
    }
}

print("PASS \(afterPath): only the visible print margins changed from white to black")
