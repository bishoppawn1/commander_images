#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let outputDPI = 600

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 4,
      let cropPixels = Int(CommandLine.arguments[3]),
      cropPixels > 0 else {
    fail("Usage: crop_white_margin.swift INPUT.png OUTPUT.png CROP_PIXELS_PER_SIDE")
}

let inputURL = URL(fileURLWithPath: CommandLine.arguments[1]).standardizedFileURL
let outputURL = URL(fileURLWithPath: CommandLine.arguments[2]).standardizedFileURL

guard inputURL != outputURL else {
    fail("Input and output must be different files.")
}
guard !FileManager.default.fileExists(atPath: outputURL.path) else {
    fail("Output already exists: \(outputURL.path)")
}

guard let source = CGImageSourceCreateWithURL(inputURL as CFURL, nil),
      let sourceImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
    fail("Could not read \(inputURL.path).")
}

let outputWidth = sourceImage.width - (cropPixels * 2)
let outputHeight = sourceImage.height - (cropPixels * 2)
guard outputWidth > 0, outputHeight > 0 else {
    fail("Crop is too large for \(sourceImage.width) × \(sourceImage.height).")
}

let cropRect = CGRect(
    x: cropPixels,
    y: cropPixels,
    width: outputWidth,
    height: outputHeight
)
guard let outputImage = sourceImage.cropping(to: cropRect) else {
    fail("Could not crop \(inputURL.path).")
}

try? FileManager.default.createDirectory(
    at: outputURL.deletingLastPathComponent(),
    withIntermediateDirectories: true
)

guard let destination = CGImageDestinationCreateWithURL(
    outputURL as CFURL,
    UTType.png.identifier as CFString,
    1,
    nil
) else {
    fail("Could not create \(outputURL.path).")
}

let properties: [CFString: Any] = [
    kCGImagePropertyDPIWidth: outputDPI,
    kCGImagePropertyDPIHeight: outputDPI
]
CGImageDestinationAddImage(destination, outputImage, properties as CFDictionary)
guard CGImageDestinationFinalize(destination) else {
    fail("Could not finish writing \(outputURL.path).")
}

print("Wrote \(outputURL.path)")
