#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let outputWidth = 1800
private let outputHeight = 2100
private let outputDPI = 600
private let margin = 113

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 3 else {
    fail("Usage: apply_white_margin.swift INPUT.png OUTPUT.png")
}

let inputURL = URL(fileURLWithPath: CommandLine.arguments[1]).standardizedFileURL
let outputURL = URL(fileURLWithPath: CommandLine.arguments[2]).standardizedFileURL

guard inputURL != outputURL else {
    fail("Input and output must be different files; original targets are never overwritten.")
}
guard !FileManager.default.fileExists(atPath: outputURL.path) else {
    fail("Output already exists: \(outputURL.path)")
}

guard let source = CGImageSourceCreateWithURL(inputURL as CFURL, nil),
      let sourceImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
    fail("Could not read \(inputURL.path).")
}

guard sourceImage.width == outputWidth, sourceImage.height == outputHeight else {
    fail("Expected an 1800 × 2100 target; found \(sourceImage.width) × \(sourceImage.height).")
}

guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(
        data: nil,
        width: outputWidth,
        height: outputHeight,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
      ) else {
    fail("Could not create the output canvas.")
}

context.setFillColor(CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1))
context.fill(CGRect(x: 0, y: 0, width: outputWidth, height: outputHeight))

let innerRect = CGRect(
    x: margin,
    y: margin,
    width: outputWidth - (margin * 2),
    height: outputHeight - (margin * 2)
)
let scale = max(
    innerRect.width / CGFloat(sourceImage.width),
    innerRect.height / CGFloat(sourceImage.height)
)
let drawSize = CGSize(
    width: CGFloat(sourceImage.width) * scale,
    height: CGFloat(sourceImage.height) * scale
)
let drawRect = CGRect(
    x: innerRect.midX - (drawSize.width / 2),
    y: innerRect.midY - (drawSize.height / 2),
    width: drawSize.width,
    height: drawSize.height
)

context.saveGState()
context.clip(to: innerRect)
context.interpolationQuality = .high
context.draw(sourceImage, in: drawRect)
context.restoreGState()

guard let outputImage = context.makeImage() else {
    fail("Could not render the output image.")
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
