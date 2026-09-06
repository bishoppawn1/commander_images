#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let canvasWidth = 1724
private let canvasHeight = 2024
private let outputDPI = 600
private let sourceMargin = 75
private let sourceArtworkWidth = 1574
private let sourceArtworkHeight = 1874
private let outputArtworkWidth = 1644
private let outputArtworkHeight = 1944
private let outputLeftMargin = 40
private let outputBottomMargin = 96
private let cutGuide = 3

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 3 else {
    fail("Usage: reframe_final_black_margin.swift INPUT.png OUTPUT.png")
}

let inputURL = URL(fileURLWithPath: CommandLine.arguments[1]).standardizedFileURL
let outputURL = URL(fileURLWithPath: CommandLine.arguments[2]).standardizedFileURL
guard inputURL != outputURL else {
    fail("Input and output must be different; write to a temporary file before replacing the active target.")
}
guard !FileManager.default.fileExists(atPath: outputURL.path) else {
    fail("Output already exists: \(outputURL.path)")
}

guard let source = CGImageSourceCreateWithURL(inputURL as CFURL, nil),
      let sourceImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
    fail("Could not read \(inputURL.path).")
}
guard sourceImage.width == canvasWidth, sourceImage.height == canvasHeight else {
    fail("Expected 1724 × 2024 input; found \(sourceImage.width) × \(sourceImage.height).")
}

let sourceArtworkRect = CGRect(
    x: sourceMargin,
    y: sourceMargin,
    width: sourceArtworkWidth,
    height: sourceArtworkHeight
)
guard let artwork = sourceImage.cropping(to: sourceArtworkRect) else {
    fail("Could not extract the 1574 × 1874 artwork region.")
}

guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(
        data: nil,
        width: canvasWidth,
        height: canvasHeight,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
      ) else {
    fail("Could not create the output canvas.")
}

context.setFillColor(CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1))
context.fill(CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))
context.interpolationQuality = .high
context.draw(
    artwork,
    in: CGRect(
        x: outputLeftMargin,
        y: outputBottomMargin,
        width: outputArtworkWidth,
        height: outputArtworkHeight
    )
)

context.setFillColor(CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1))
context.fill(CGRect(x: 0, y: 0, width: canvasWidth, height: cutGuide))
context.fill(CGRect(x: 0, y: canvasHeight - cutGuide, width: canvasWidth, height: cutGuide))
context.fill(CGRect(x: 0, y: 0, width: cutGuide, height: canvasHeight))
context.fill(CGRect(x: canvasWidth - cutGuide, y: 0, width: cutGuide, height: canvasHeight))

guard let outputImage = context.makeImage() else {
    fail("Could not render the reframed target.")
}
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
