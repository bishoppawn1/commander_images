#!/usr/bin/env swift

import CoreGraphics
import CoreText
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let targetWidth = 1800
private let targetHeight = 2100
private let outputDPI = 600

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 4 else {
    fail("Usage: build_modern_horizons_3_commander_cosmic_rift_alternate_v3.swift OVERSIZED_ART.png OFFICIAL_LOGO.png OUTPUT.png")
}

let artURL = URL(fileURLWithPath: CommandLine.arguments[1])
let logoURL = URL(fileURLWithPath: CommandLine.arguments[2])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[3])

func loadImage(_ url: URL) -> CGImage {
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(url.path).")
    }
    return image
}

let art = loadImage(artURL)
let logo = loadImage(logoURL)

guard art.width == 7259, art.height == 4859 else {
    fail("Expected the retained 100-DPI oversized-art raster at 7259 × 4859 pixels; found \(art.width) × \(art.height).")
}
guard logo.width == 900, logo.height == 407 else {
    fail("Expected the retained official transparent logo at 900 × 407 pixels; found \(logo.width) × \(logo.height).")
}

guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(
        data: nil,
        width: targetWidth,
        height: targetHeight,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
      ) else {
    fail("Could not create the output canvas.")
}

context.interpolationQuality = .high

// The selected official WPN oversized artwork is landscape. This exact 6:7
// portrait crop keeps both the spectral blade-wielder and roaring leonin,
// with the violet-white planar impact and red volcanic rift filling the frame.
// It excludes the separate Magic wordmark and both corner credit blocks.
let artCropRect = CGRect(x: 1800, y: 0, width: 4164, height: 4858)
guard let artCrop = art.cropping(to: artCropRect) else {
    fail("Could not crop the official oversized artwork.")
}
context.draw(artCrop, in: CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight))

// Preserve the full-frame art while establishing a high-contrast landing zone
// for the title. This is a transparent plum-to-clear vignette, not a flat footer.
let titleVignetteColors = [
    CGColor(srgbRed: 0.025, green: 0.010, blue: 0.075, alpha: 0.88),
    CGColor(srgbRed: 0.075, green: 0.018, blue: 0.145, alpha: 0.68),
    CGColor(srgbRed: 0.155, green: 0.025, blue: 0.185, alpha: 0.26),
    CGColor(srgbRed: 0.155, green: 0.025, blue: 0.185, alpha: 0.00)
] as CFArray
let titleVignetteLocations: [CGFloat] = [0.0, 0.30, 0.68, 1.0]
guard let titleVignette = CGGradient(
    colorsSpace: colorSpace,
    colors: titleVignetteColors,
    locations: titleVignetteLocations
) else {
    fail("Could not create title vignette.")
}
context.drawLinearGradient(
    titleVignette,
    start: CGPoint(x: 0, y: 0),
    end: CGPoint(x: 0, y: 1040),
    options: [.drawsAfterEndLocation]
)

// Add a restrained rift-colored bloom so the official pale-prismatic logo is
// dimensional and luminous against every part of the official art.
let bloomColors = [
    CGColor(srgbRed: 0.92, green: 0.08, blue: 0.62, alpha: 0.18),
    CGColor(srgbRed: 0.31, green: 0.16, blue: 0.78, alpha: 0.10),
    CGColor(srgbRed: 0.07, green: 0.62, blue: 1.00, alpha: 0.00)
] as CFArray
let bloomLocations: [CGFloat] = [0.0, 0.48, 1.0]
if let bloom = CGGradient(colorsSpace: colorSpace, colors: bloomColors, locations: bloomLocations) {
    context.saveGState()
    context.translateBy(x: 900, y: 540)
    context.scaleBy(x: 1.0, y: 0.48)
    context.drawRadialGradient(
        bloom,
        startCenter: .zero,
        startRadius: 0,
        endCenter: .zero,
        endRadius: 900,
        options: [.drawsAfterEndLocation]
    )
    context.restoreGState()
}

// Two translucent crystal shoulders visually join the Arabic numeral to the
// lower edge of HORIZONS. They echo the official logo's magenta extrusion while
// remaining subordinate to the exact letterforms.
func drawCrystalShoulder(_ points: [CGPoint]) {
    guard let first = points.first else { return }
    let path = CGMutablePath()
    path.move(to: first)
    for point in points.dropFirst() { path.addLine(to: point) }
    path.closeSubpath()

    context.addPath(path)
    context.setFillColor(CGColor(srgbRed: 0.40, green: 0.02, blue: 0.36, alpha: 0.54))
    context.fillPath()
    context.addPath(path)
    context.setLineWidth(5)
    context.setStrokeColor(CGColor(srgbRed: 0.31, green: 0.86, blue: 1.0, alpha: 0.54))
    context.strokePath()
}

drawCrystalShoulder([
    CGPoint(x: 230, y: 438), CGPoint(x: 700, y: 346),
    CGPoint(x: 765, y: 364), CGPoint(x: 710, y: 402)
])
drawCrystalShoulder([
    CGPoint(x: 1570, y: 438), CGPoint(x: 1100, y: 346),
    CGPoint(x: 1035, y: 364), CGPoint(x: 1090, y: 402)
])

// Extract only the two official word lines. The Roman III begins below row 250,
// so this crop preserves the accurate WPN MODERN HORIZONS artwork and excludes
// every source numeral before the deterministic Arabic 3 is added.
guard let officialWordmark = logo.cropping(to: CGRect(x: 0, y: 0, width: 900, height: 240)) else {
    fail("Could not extract the official MODERN HORIZONS wordmark.")
}
let wordmarkRect = CGRect(x: 55, y: 392, width: 1690, height: 451)

// A deep shadow and two subtle chromatic glows bind the whole lockup to the
// violet/cyan rift without changing the official letterforms or source pixels.
context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -18),
    blur: 34,
    color: CGColor(srgbRed: 0.0, green: 0.0, blue: 0.03, alpha: 0.96)
)
context.draw(officialWordmark, in: wordmarkRect)
context.restoreGState()

context.saveGState()
context.setShadow(
    offset: .zero,
    blur: 28,
    color: CGColor(srgbRed: 0.04, green: 0.74, blue: 1.00, alpha: 0.48)
)
context.draw(officialWordmark, in: wordmarkRect)
context.restoreGState()

context.saveGState()
context.setShadow(
    offset: .zero,
    blur: 16,
    color: CGColor(srgbRed: 0.95, green: 0.05, blue: 0.63, alpha: 0.64)
)
context.draw(officialWordmark, in: wordmarkRect)
context.restoreGState()
context.draw(officialWordmark, in: wordmarkRect)

// Build an Arabic 3 in the same pale-prismatic, magenta-edged material as the
// official wordmark. Its slight overlap and shared glow make one cohesive lockup.
let numeralFont = CTFontCreateWithName("BodoniSvtyTwoITCTT-Bold" as CFString, 330, nil)
var character: UniChar = 51
var glyph = CGGlyph()
guard CTFontGetGlyphsForCharacters(numeralFont, &character, &glyph, 1),
      let numeralGlyphPath = CTFontCreatePathForGlyph(numeralFont, glyph, nil) else {
    fail("Could not create the Arabic 3 glyph.")
}
let glyphBounds = numeralGlyphPath.boundingBoxOfPath
let numeralCenter = CGPoint(x: CGFloat(targetWidth) / 2.0, y: 292)
let numeralOrigin = CGPoint(
    x: numeralCenter.x - glyphBounds.midX,
    y: numeralCenter.y - glyphBounds.midY
)
var numeralTransform = CGAffineTransform(translationX: numeralOrigin.x, y: numeralOrigin.y)
let numeralPath = numeralGlyphPath.copy(using: &numeralTransform) ?? numeralGlyphPath

// Render a short crystalline extrusion behind the face of the numeral.
for depth in stride(from: 24, through: 3, by: -3) {
    var transform = CGAffineTransform(translationX: CGFloat(depth) * 0.42, y: CGFloat(-depth) * 0.70)
    guard let extrusionPath = numeralPath.copy(using: &transform) else { continue }
    let t = CGFloat(depth) / 24.0
    context.addPath(extrusionPath)
    context.setFillColor(CGColor(
        srgbRed: 0.34 + 0.20 * (1.0 - t),
        green: 0.015,
        blue: 0.24 + 0.18 * (1.0 - t),
        alpha: 0.98
    ))
    context.fillPath()
}

context.saveGState()
context.setShadow(
    offset: .zero,
    blur: 30,
    color: CGColor(srgbRed: 0.05, green: 0.72, blue: 1.0, alpha: 0.52)
)
context.addPath(numeralPath)
context.setFillColor(CGColor(srgbRed: 0.96, green: 0.20, blue: 0.74, alpha: 1.0))
context.fillPath()
context.restoreGState()

context.addPath(numeralPath)
context.setLineWidth(22)
context.setLineJoin(.round)
context.setStrokeColor(CGColor(srgbRed: 0.47, green: 0.015, blue: 0.33, alpha: 1.0))
context.strokePath()

context.saveGState()
context.addPath(numeralPath)
context.clip()
let numeralColors = [
    CGColor(srgbRed: 1.00, green: 0.93, blue: 0.98, alpha: 1.0),
    CGColor(srgbRed: 0.98, green: 0.70, blue: 0.88, alpha: 1.0),
    CGColor(srgbRed: 0.64, green: 0.95, blue: 1.00, alpha: 1.0),
    CGColor(srgbRed: 1.00, green: 0.97, blue: 0.99, alpha: 1.0),
    CGColor(srgbRed: 0.89, green: 0.57, blue: 0.87, alpha: 1.0)
] as CFArray
let numeralLocations: [CGFloat] = [0.0, 0.26, 0.52, 0.74, 1.0]
if let numeralGradient = CGGradient(
    colorsSpace: colorSpace,
    colors: numeralColors,
    locations: numeralLocations
) {
    context.drawLinearGradient(
        numeralGradient,
        start: CGPoint(x: numeralCenter.x - 170, y: numeralCenter.y + 170),
        end: CGPoint(x: numeralCenter.x + 160, y: numeralCenter.y - 170),
        options: [.drawsBeforeStartLocation, .drawsAfterEndLocation]
    )
}
context.restoreGState()

context.addPath(numeralPath)
context.setLineWidth(7)
context.setLineJoin(.round)
context.setStrokeColor(CGColor(srgbRed: 1.0, green: 0.88, blue: 0.98, alpha: 0.92))
context.strokePath()

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
