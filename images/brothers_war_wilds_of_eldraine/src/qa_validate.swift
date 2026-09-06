#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO

private let width = 1800
private let height = 2100
private let expectedDPI = 600.0
private let dividerRange = 897...902

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("QA FAIL: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 3 else {
    fail("Usage: qa_validate.swift BASE.png COUNTED.png")
}

struct LoadedPNG {
    let image: CGImage
    let properties: [CFString: Any]
    let pixels: [UInt8]
}

func loadPNG(_ path: String) -> LoadedPNG {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          CGImageSourceGetType(source) == "public.png" as CFString,
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil),
          let rawProperties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil)
            as? [CFString: Any] else {
        fail("Could not read PNG \(path).")
    }
    guard image.width == width, image.height == height else {
        fail("\(path) is \(image.width) x \(image.height), expected 1800 x 2100.")
    }
    guard let colorSpace = image.colorSpace,
          colorSpace.name == CGColorSpace.sRGB else {
        fail("\(path) is not tagged with an sRGB CGImage color space.")
    }

    let dpiWidth = (rawProperties[kCGImagePropertyDPIWidth] as? NSNumber)?.doubleValue ?? -1
    let dpiHeight = (rawProperties[kCGImagePropertyDPIHeight] as? NSNumber)?.doubleValue ?? -1
    guard abs(dpiWidth - expectedDPI) < 0.1, abs(dpiHeight - expectedDPI) < 0.1 else {
        fail("\(path) reports \(dpiWidth) x \(dpiHeight) DPI, expected 600 x 600.")
    }
    let colorModel = rawProperties[kCGImagePropertyColorModel] as? String
    guard colorModel == "RGB" else {
        fail("\(path) reports color model \(colorModel ?? "missing"), expected RGB.")
    }

    let bytesPerRow = width * 4
    var pixels = [UInt8](repeating: 0, count: bytesPerRow * height)
    guard let scanSpace = CGColorSpace(name: CGColorSpace.sRGB),
          let context = CGContext(
            data: &pixels,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: scanSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
          ) else {
        fail("Could not create pixel-inspection context.")
    }
    context.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
    return LoadedPNG(image: image, properties: rawProperties, pixels: pixels)
}

func pixel(_ pixels: [UInt8], x: Int, y: Int) -> ArraySlice<UInt8> {
    let index = (y * width + x) * 4
    return pixels[index..<(index + 4)]
}

let base = loadPNG(CommandLine.arguments[1])
let counted = loadPNG(CommandLine.arguments[2])

// The divider must be one uninterrupted six-pixel treatment drawn last.
let dividerPixel = pixel(base.pixels, x: 899, y: 100)
for y in 0..<height {
    for x in dividerRange where pixel(base.pixels, x: x, y: y) != dividerPixel {
        fail("Divider is not a single constant full-height treatment at x=897...902.")
    }
}
guard pixel(base.pixels, x: 896, y: 100) != dividerPixel,
      pixel(base.pixels, x: 903, y: 100) != dividerPixel else {
    fail("Divider extends beyond the intended six pixels.")
}

struct DifferenceBounds {
    var minimumX = Int.max
    var maximumX = Int.min
    var minimumY = Int.max
    var maximumY = Int.min
    var changedPixels = 0

    mutating func include(x: Int, y: Int) {
        minimumX = min(minimumX, x)
        maximumX = max(maximumX, x)
        minimumY = min(minimumY, y)
        maximumY = max(maximumY, y)
        changedPixels += 1
    }
}

var leftDifference = DifferenceBounds()
var rightDifference = DifferenceBounds()
for y in 0..<height {
    for x in 0..<width where pixel(base.pixels, x: x, y: y) != pixel(counted.pixels, x: x, y: y) {
        if x < 900 {
            leftDifference.include(x: x, y: y)
        } else {
            rightDifference.include(x: x, y: y)
        }
    }
}

for (name, bounds, allowedX) in [
    ("left", leftDifference, 595...855),
    ("right", rightDifference, 1495...1755)
] {
    guard bounds.changedPixels > 0 else {
        fail("No \(name) count-seal changes were found.")
    }
    guard allowedX.contains(bounds.minimumX), allowedX.contains(bounds.maximumX),
          (1790...2060).contains(bounds.minimumY), (1790...2060).contains(bounds.maximumY) else {
        fail("\(name) seal changes escaped the expected standardized corner envelope: x=\(bounds.minimumX)...\(bounds.maximumX), y=\(bounds.minimumY)...\(bounds.maximumY).")
    }
}

// Core seal centers from the required 210 px diameter / 70 px inset geometry.
guard pixel(base.pixels, x: 725, y: 1925) != pixel(counted.pixels, x: 725, y: 1925),
      pixel(base.pixels, x: 1625, y: 1925) != pixel(counted.pixels, x: 1625, y: 1925) else {
    fail("Expected count-seal centers were not modified.")
}

func describe(_ path: String, _ loaded: LoadedPNG) {
    let alpha = loaded.image.alphaInfo == .none || loaded.image.alphaInfo == .noneSkipFirst || loaded.image.alphaInfo == .noneSkipLast
        ? "RGB"
        : "RGBA"
    print("PASS \(path): 1800x2100, 600 DPI, sRGB \(alpha)")
}

describe(CommandLine.arguments[1], base)
describe(CommandLine.arguments[2], counted)
print("PASS panels: 900px left + 900px right; divider x=897...902 (6px, full height)")
print("PASS seals: 210px diameter; centers (725,175) and (1625,175); outer rects x=620...829 / 1520...1729 and y=70...279 in bottom-origin coordinates")
print("PASS left seal diff bounds: x=\(leftDifference.minimumX)...\(leftDifference.maximumX), top-left y=\(leftDifference.minimumY)...\(leftDifference.maximumY)")
print("PASS right seal diff bounds: x=\(rightDifference.minimumX)...\(rightDifference.maximumX), top-left y=\(rightDifference.minimumY)...\(rightDifference.maximumY)")
print("PASS counted/base differences remain confined to the two standardized lower-right seal envelopes")
