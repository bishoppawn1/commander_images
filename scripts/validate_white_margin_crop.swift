#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO

private let expectedDPI = 600.0

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 5,
      let cropPixels = Int(CommandLine.arguments[3]),
      let remainingMargin = Int(CommandLine.arguments[4]),
      cropPixels > 0,
      remainingMargin >= 0 else {
    fail("Usage: validate_white_margin_crop.swift INPUT.png OUTPUT.png CROP_PIXELS_PER_SIDE REMAINING_WHITE_MARGIN")
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
    context.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
    return pixels
}

let inputPath = CommandLine.arguments[1]
let outputPath = CommandLine.arguments[2]
let (inputImage, _) = load(inputPath)
let (outputImage, outputProperties) = load(outputPath)

guard outputImage.width == inputImage.width - (cropPixels * 2),
      outputImage.height == inputImage.height - (cropPixels * 2) else {
    fail("Unexpected output dimensions: \(outputImage.width) × \(outputImage.height).")
}

let dpiWidth = (outputProperties[kCGImagePropertyDPIWidth] as? NSNumber)?.doubleValue ?? -1
let dpiHeight = (outputProperties[kCGImagePropertyDPIHeight] as? NSNumber)?.doubleValue ?? -1
guard abs(dpiWidth - expectedDPI) < 0.01, abs(dpiHeight - expectedDPI) < 0.01 else {
    fail("Expected 600 × 600 DPI; found \(dpiWidth) × \(dpiHeight).")
}

let inputPixels = rgbaPixels(inputImage)
let outputPixels = rgbaPixels(outputImage)
let inputBytesPerRow = inputImage.width * 4
let outputBytesPerRow = outputImage.width * 4

for y in 0..<outputImage.height {
    for x in 0..<outputImage.width {
        let inputOffset = ((y + cropPixels) * inputBytesPerRow) + ((x + cropPixels) * 4)
        let outputOffset = (y * outputBytesPerRow) + (x * 4)
        guard inputPixels[inputOffset] == outputPixels[outputOffset],
              inputPixels[inputOffset + 1] == outputPixels[outputOffset + 1],
              inputPixels[inputOffset + 2] == outputPixels[outputOffset + 2],
              inputPixels[inputOffset + 3] == outputPixels[outputOffset + 3] else {
            fail("Artwork changed at output pixel (\(x), \(y)).")
        }

        if x < remainingMargin || x >= outputImage.width - remainingMargin ||
           y < remainingMargin || y >= outputImage.height - remainingMargin {
            guard outputPixels[outputOffset] == 255,
                  outputPixels[outputOffset + 1] == 255,
                  outputPixels[outputOffset + 2] == 255,
                  outputPixels[outputOffset + 3] == 255 else {
                fail("Non-white margin pixel at (\(x), \(y)).")
            }
        }
    }
}

print("PASS \(outputPath): exact crop, unchanged pixels, \(remainingMargin)-pixel white margin, 600 DPI")
