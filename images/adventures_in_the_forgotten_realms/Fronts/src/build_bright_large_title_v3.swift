#!/usr/bin/env swift
import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

guard CommandLine.arguments.count == 4 else {
    fatalError("Usage: build_bright_large_title_v3.swift BRIGHT_ART.png OFFICIAL_WORDMARK.png OUTPUT.png")
}
func load(_ path: String) -> CGImage {
    let source = CGImageSourceCreateWithURL(URL(fileURLWithPath: path) as CFURL, nil)!
    return CGImageSourceCreateImageAtIndex(source, 0, nil)!
}
let art = load(CommandLine.arguments[1])
let logo = load(CommandLine.arguments[2])
let output = URL(fileURLWithPath: CommandLine.arguments[3])
precondition(!FileManager.default.fileExists(atPath: output.path))
precondition(logo.width == 1960 && logo.height == 380)
let cs = CGColorSpace(name: CGColorSpace.sRGB)!
let ctx = CGContext(data: nil, width: 1800, height: 2100, bitsPerComponent: 8,
    bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
ctx.interpolationQuality = .high
ctx.draw(art, in: CGRect(x: 0, y: 0, width: 1800, height: 2100))

// Reflow the retained official letterforms, preserving their shapes and proportions.
// The large final line ends to the left of the separate bottom-right count seal.
func drawTitle(crop: CGRect, top: CGFloat, width: CGFloat) {
    let mask = logo.cropping(to: crop)!
    let height = width * crop.height / crop.width
    let rect = CGRect(x: (1800-width)/2, y: 2100-top-height, width: width, height: height)
    func fill(_ target: CGRect, color: CGColor) {
        ctx.saveGState()
        ctx.clip(to: target, mask: mask)
        ctx.setFillColor(color)
        ctx.fill(target)
        ctx.restoreGState()
    }
    ctx.saveGState()
    ctx.setShadow(offset: CGSize(width: 0, height: -7), blur: 13,
                  color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.9))
    for step in 0..<24 {
        let angle = CGFloat(step) * 2 * .pi / 24
        fill(rect.offsetBy(dx: cos(angle)*7, dy: sin(angle)*7),
             color: CGColor(srgbRed: 0.07, green: 0.025, blue: 0.035, alpha: 1))
    }
    ctx.restoreGState()
    ctx.saveGState()
    ctx.clip(to: rect, mask: mask)
    let gradient = CGGradient(colorsSpace: cs, colors: [
        CGColor(srgbRed: 1, green: 0.98, blue: 0.84, alpha: 1),
        CGColor(srgbRed: 0.98, green: 0.83, blue: 0.49, alpha: 1)
    ] as CFArray, locations: [0, 1])!
    ctx.drawLinearGradient(gradient, start: CGPoint(x: 900, y: rect.maxY),
                           end: CGPoint(x: 900, y: rect.minY), options: [])
    ctx.restoreGState()
}
drawTitle(crop: CGRect(x: 440, y: 62, width: 1074, height: 81), top: 1415, width: 1270)
drawTitle(crop: CGRect(x: 128, y: 157, width: 992, height: 145), top: 1535, width: 1550)
drawTitle(crop: CGRect(x: 1168, y: 157, width: 665, height: 145), top: 1775, width: 1040)
let dest = CGImageDestinationCreateWithURL(output as CFURL, UTType.png.identifier as CFString, 1, nil)!
CGImageDestinationAddImage(dest, ctx.makeImage()!, [kCGImagePropertyDPIWidth: 600, kCGImagePropertyDPIHeight: 600] as CFDictionary)
precondition(CGImageDestinationFinalize(dest))
print("Wrote \(output.path)")
