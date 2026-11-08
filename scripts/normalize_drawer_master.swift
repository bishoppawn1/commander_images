#!/usr/bin/env swift
import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

// Mechanical normalization only: the complete generated composition is retained.
guard CommandLine.arguments.count == 3 else {
    fatalError("Usage: normalize_drawer_master.swift INPUT OUTPUT")
}
let input = URL(fileURLWithPath: CommandLine.arguments[1])
let output = URL(fileURLWithPath: CommandLine.arguments[2])
guard input.standardizedFileURL != output.standardizedFileURL,
      !FileManager.default.fileExists(atPath: output.path),
      let source = CGImageSourceCreateWithURL(input as CFURL, nil),
      let image = CGImageSourceCreateImageAtIndex(source, 0, nil),
      abs(CGFloat(image.width) / CGFloat(image.height) - 6.0 / 7.0) < 0.015,
      let space = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(data: nil, width: 1800, height: 2100,
          bitsPerComponent: 8, bytesPerRow: 0, space: space,
          bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
    fatalError("Expected a new output path and a readable 6:7 input")
}
context.interpolationQuality = .high
context.draw(image, in: CGRect(x: 0, y: 0, width: 1800, height: 2100))
guard let rendered = context.makeImage(),
      let destination = CGImageDestinationCreateWithURL(output as CFURL, UTType.png.identifier as CFString, 1, nil) else {
    fatalError("Cannot write image")
}
CGImageDestinationAddImage(destination, rendered, [kCGImagePropertyDPIWidth: 600, kCGImagePropertyDPIHeight: 600] as CFDictionary)
guard CGImageDestinationFinalize(destination) else { fatalError("Cannot finish PNG") }
print(output.path)
