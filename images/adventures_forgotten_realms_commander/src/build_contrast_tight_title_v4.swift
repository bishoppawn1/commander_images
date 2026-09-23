#!/usr/bin/env swift
import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

guard CommandLine.arguments.count == 4 else {
    fatalError("Usage: build_contrast_tight_title_v4.swift BRIGHT_ART.png OFFICIAL_WORDMARK.png OUTPUT.png")
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

// Darken only the title ground, preserving the bright dragon and adventurer above.
let scrim = CGGradient(colorsSpace: cs, colors: [
    CGColor(srgbRed: 0.018, green: 0.009, blue: 0.025, alpha: 0),
    CGColor(srgbRed: 0.018, green: 0.009, blue: 0.025, alpha: 0.72),
    CGColor(srgbRed: 0.018, green: 0.009, blue: 0.025, alpha: 0.86),
    CGColor(srgbRed: 0.018, green: 0.009, blue: 0.025, alpha: 0.80),
    CGColor(srgbRed: 0.018, green: 0.009, blue: 0.025, alpha: 0.58)
] as CFArray, locations: [0, 0.23, 0.47, 0.84, 1])!
ctx.drawLinearGradient(scrim, start: CGPoint(x: 900, y: 805),
                       end: CGPoint(x: 900, y: 0), options: [])

// Tighten the existing official glyphs without substituting a font or distorting letters.
func tightMask(_ source: CGImage) -> CGImage {
    let w = source.width, h = source.height
    var pixels = [UInt8](repeating: 0, count: w*h*4)
    pixels.withUnsafeMutableBytes { buffer in
        let scan = CGContext(data: buffer.baseAddress, width: w, height: h, bitsPerComponent: 8,
          bytesPerRow: w*4, space: cs,
          bitmapInfo: CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue)!
        scan.draw(source, in: CGRect(x: 0, y: 0, width: w, height: h))
    }
    let occupied = (0..<w).map { x in (0..<h).contains { y in pixels[(y*w+x)*4+3] > 24 } }
    var runs: [(Int,Int)] = []
    var begin: Int? = nil
    for x in 0...w {
        let filled = x < w && occupied[x]
        if filled && begin == nil { begin = x }
        if !filled, let start = begin { runs.append((start,x)); begin = nil }
    }
    var placed: [(Int,Int,Int)] = []
    var cursor = 0
    for (i,run) in runs.enumerated() {
        if i > 0 {
            let gap = run.0-runs[i-1].1
            cursor += gap > 30 ? 15 : 2
        }
        placed.append((run.0,run.1,cursor))
        cursor += run.1-run.0
    }
    let result = CGContext(data: nil, width: cursor, height: h, bitsPerComponent: 8,
        bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
    for (left,right,dest) in placed {
        let glyph = source.cropping(to: CGRect(x: left, y: 0, width: right-left, height: h))!
        result.draw(glyph, in: CGRect(x: dest, y: 0, width: right-left, height: h))
    }
    print("Tightened title mask: \(w) -> \(cursor) pixels, \(runs.count) glyph groups")
    return result.makeImage()!
}

// Reflow the retained official letterforms, preserving their shapes and proportions.
// The large final line ends to the left of the separate bottom-right count seal.
func drawTitle(crop: CGRect, top: CGFloat, width: CGFloat) {
    let sourceMask = logo.cropping(to: crop)!
    let mask = tightMask(sourceMask)
    let tightenedWidth = width * CGFloat(mask.width) / crop.width
    let height = width * crop.height / crop.width
    let rect = CGRect(x: (1800-tightenedWidth)/2, y: 2100-top-height, width: tightenedWidth, height: height)
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
