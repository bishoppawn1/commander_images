#!/usr/bin/env swift
import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

guard CommandLine.arguments.count == 4 else {
    fatalError("Usage: build_crystal_commander_v5.swift BRIGHT_ORIGINAL.png EDITED_HEADER.png OUTPUT.png")
}
func load(_ path: String) -> CGImage {
    let source = CGImageSourceCreateWithURL(URL(fileURLWithPath: path) as CFURL, nil)!
    return CGImageSourceCreateImageAtIndex(source, 0, nil)!
}
let original = load(CommandLine.arguments[1]), header = load(CommandLine.arguments[2])
let output = URL(fileURLWithPath: CommandLine.arguments[3])
precondition(!FileManager.default.fileExists(atPath: output.path))
let cs = CGColorSpace(name: CGColorSpace.sRGB)!
let ctx = CGContext(data: nil, width: 1800, height: 2100, bitsPerComponent: 8,
    bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
ctx.interpolationQuality = .high
let canvas = CGRect(x: 0, y: 0, width: 1800, height: 2100)
ctx.draw(original, in: canvas)
// Only the edited sky/header is used. Preserve all original landscape/character pixels.
ctx.saveGState()
ctx.clip(to: CGRect(x: 0, y: 1600, width: 1800, height: 500))
ctx.draw(header, in: canvas)
ctx.restoreGState()
for row in 0..<40 {
    ctx.saveGState()
    ctx.clip(to: CGRect(x: 0, y: 1599-row, width: 1800, height: 1))
    ctx.setAlpha(1-CGFloat(row+1)/40)
    ctx.draw(header, in: canvas)
    ctx.restoreGState()
}
let dest = CGImageDestinationCreateWithURL(output as CFURL, UTType.png.identifier as CFString, 1, nil)!
CGImageDestinationAddImage(dest, ctx.makeImage()!, [kCGImagePropertyDPIWidth:600, kCGImagePropertyDPIHeight:600] as CFDictionary)
precondition(CGImageDestinationFinalize(dest))
print("Wrote \(output.path)")
