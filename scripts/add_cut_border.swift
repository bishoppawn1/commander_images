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
      let border = Int(CommandLine.arguments[3]),
      border > 0 else {
    fail("Usage: add_cut_border.swift INPUT.png OUTPUT.png BORDER_PIXELS")
}

let inputURL = URL(fileURLWithPath: CommandLine.arguments[1]).standardizedFileURL
let outputURL = URL(fileURLWithPath: CommandLine.arguments[2]).standardizedFileURL
guard inputURL != outputURL else {
    fail("Input and output must be different; write to a temporary file before replacing an active target.")
}
guard !FileManager.default.fileExists(atPath: outputURL.path) else {
    fail("Output already exists: \(outputURL.path)")
}

guard let source = CGImageSourceCreateWithURL(inputURL as CFURL, nil),
      let sourceImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
    fail("Could not read \(inputURL.path).")
}
guard border * 2 < sourceImage.width, border * 2 < sourceImage.height else {
    fail("Border is too large for \(sourceImage.width) × \(sourceImage.height).")
}

guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(
        data: nil,
        width: sourceImage.width,
        height: sourceImage.height,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
      ) else {
    fail("Could not create the output canvas.")
}

context.interpolationQuality = .none
context.draw(sourceImage, in: CGRect(x: 0, y: 0, width: sourceImage.width, height: sourceImage.height))
context.setFillColor(CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1))
context.fill(CGRect(x: 0, y: 0, width: sourceImage.width, height: border))
context.fill(CGRect(x: 0, y: sourceImage.height - border, width: sourceImage.width, height: border))
context.fill(CGRect(x: 0, y: 0, width: border, height: sourceImage.height))
context.fill(CGRect(x: sourceImage.width - border, y: 0, width: border, height: sourceImage.height))

guard let outputImage = context.makeImage() else {
    fail("Could not render the bordered image.")
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
