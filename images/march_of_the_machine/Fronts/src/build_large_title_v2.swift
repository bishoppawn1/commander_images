#!/usr/bin/env swift
import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

// Recompose the title from its retained official transparent wordmark.
// ImageGen repairs only the rock behind the former title; lock the upper art.
guard CommandLine.arguments.count == 5 else {
    fatalError("Usage: build_large_title_v2.swift ORIGINAL.png REPAIRED.png LOGO.png OUTPUT.png")
}
func load(_ path: String) -> CGImage {
    let source = CGImageSourceCreateWithURL(URL(fileURLWithPath: path) as CFURL, nil)!
    return CGImageSourceCreateImageAtIndex(source, 0, nil)!
}
let original = load(CommandLine.arguments[1])
let repaired = load(CommandLine.arguments[2])
let logo = load(CommandLine.arguments[3])
let output = URL(fileURLWithPath: CommandLine.arguments[4])
precondition(!FileManager.default.fileExists(atPath: output.path))
let cs = CGColorSpace(name: CGColorSpace.sRGB)!
let ctx = CGContext(data: nil, width: 1800, height: 2100, bitsPerComponent: 8,
                    bytesPerRow: 0, space: cs,
                    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
ctx.interpolationQuality = .high
let canvas = CGRect(x: 0, y: 0, width: 1800, height: 2100)
ctx.draw(repaired, in: canvas)
ctx.saveGState()
ctx.clip(to: CGRect(x: 0, y: 1100, width: 1800, height: 1000))
ctx.draw(original, in: canvas)
ctx.restoreGState()
for row in 0..<40 {
    ctx.saveGState()
    ctx.clip(to: CGRect(x: 0, y: 1099 - row, width: 1800, height: 1))
    ctx.setAlpha(1 - CGFloat(row + 1) / 40)
    ctx.draw(original, in: canvas)
    ctx.restoreGState()
}
let width: CGFloat = 1580
let height = width * CGFloat(logo.height) / CGFloat(logo.width)
// Full-width centered logo begins below the heroes and ends above the seal.
let rect = CGRect(x: (1800 - width) / 2, y: 315, width: width, height: height)
ctx.saveGState()
ctx.setShadow(offset: CGSize(width: 0, height: -8), blur: 18,
              color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.90))
ctx.draw(logo, in: rect)
ctx.restoreGState()
let destination = CGImageDestinationCreateWithURL(output as CFURL, UTType.png.identifier as CFString, 1, nil)!
CGImageDestinationAddImage(destination, ctx.makeImage()!, [kCGImagePropertyDPIWidth: 600, kCGImagePropertyDPIHeight: 600] as CFDictionary)
precondition(CGImageDestinationFinalize(destination))
print("Wrote \(output.path)")
