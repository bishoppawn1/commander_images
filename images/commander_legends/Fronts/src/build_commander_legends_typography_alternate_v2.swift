#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let canvasWidth = 1800
private let canvasHeight = 2100
private let outputDPI = 600

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 4 else {
    fail("Usage: build_commander_legends_typography_alternate_v2.swift POSTER_PAGE1_600DPI.png OFFICIAL_WORDMARK.png OUTPUT.png")
}

func loadImage(_ path: String) -> CGImage {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(path).")
    }
    return image
}

let poster = loadImage(CommandLine.arguments[1])
let wordmark = loadImage(CommandLine.arguments[2])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[3])

guard poster.width == 5100, poster.height == 6600 else {
    fail("Expected the retained 5100 x 6600 official poster raster; found \(poster.width) x \(poster.height).")
}

guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(
        data: nil,
        width: canvasWidth,
        height: canvasHeight,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
      ) else {
    fail("Could not create the output canvas.")
}

context.interpolationQuality = .high

// Keep the established v4/v1 Jeska reframing so this revision isolates the
// typography decision. The original poster footer is completely excluded,
// and the official illustration continues to every edge of the 6:7 canvas.
let artRect = CGRect(x: 0, y: 0, width: 5100, height: 5000)
guard let officialArt = poster.cropping(to: artRect) else {
    fail("Could not crop the official Jeska illustration.")
}
context.draw(officialArt, in: CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))

// Localized indigo/wine atmosphere replaces v1's broad darkening. It supports
// the wordmark silhouette but remains transparent enough to retain Jeska's
// lower clothing, weapon details, cape and the illustrated bottom edge.
let bloomColors = [
    CGColor(srgbRed: 0.020, green: 0.030, blue: 0.085, alpha: 0.68),
    CGColor(srgbRed: 0.125, green: 0.018, blue: 0.060, alpha: 0.36),
    CGColor(srgbRed: 0.220, green: 0.055, blue: 0.045, alpha: 0.00)
] as CFArray
let bloomLocations: [CGFloat] = [0.0, 0.56, 1.0]
guard let bloom = CGGradient(colorsSpace: colorSpace, colors: bloomColors, locations: bloomLocations) else {
    fail("Could not create the localized title atmosphere.")
}
context.saveGState()
context.translateBy(x: 900, y: 525)
context.scaleBy(x: 880, y: 315)
context.drawRadialGradient(
    bloom,
    startCenter: .zero,
    startRadius: 0,
    endCenter: .zero,
    endRadius: 1,
    options: []
)
context.restoreGState()

func solidTint(_ source: CGImage, color: CGColor) -> CGImage {
    guard let tintContext = CGContext(
        data: nil,
        width: source.width,
        height: source.height,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
        fail("Could not create a wordmark tint layer.")
    }
    tintContext.draw(source, in: CGRect(x: 0, y: 0, width: source.width, height: source.height))
    tintContext.setBlendMode(.sourceIn)
    tintContext.setFillColor(color)
    tintContext.fill(CGRect(x: 0, y: 0, width: source.width, height: source.height))
    guard let image = tintContext.makeImage() else {
        fail("Could not finish a wordmark tint layer.")
    }
    return image
}

func officialTealMetalFace(_ source: CGImage) -> CGImage {
    guard let faceContext = CGContext(
        data: nil,
        width: source.width,
        height: source.height,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
        fail("Could not create the official-metal wordmark layer.")
    }

    faceContext.draw(source, in: CGRect(x: 0, y: 0, width: source.width, height: source.height))
    faceContext.setBlendMode(.sourceIn)
    let colors = [
        CGColor(srgbRed: 0.96, green: 0.96, blue: 0.84, alpha: 1.0),
        CGColor(srgbRed: 0.82, green: 0.91, blue: 0.84, alpha: 1.0),
        CGColor(srgbRed: 0.62, green: 0.80, blue: 0.76, alpha: 1.0),
        CGColor(srgbRed: 0.22, green: 0.47, blue: 0.50, alpha: 1.0),
        CGColor(srgbRed: 0.075, green: 0.20, blue: 0.29, alpha: 1.0)
    ] as CFArray
    let locations: [CGFloat] = [0.0, 0.24, 0.53, 0.79, 1.0]
    guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations) else {
        fail("Could not create the official-metal gradient.")
    }
    faceContext.drawLinearGradient(
        gradient,
        start: CGPoint(x: 0, y: source.height),
        end: CGPoint(x: 0, y: 0),
        options: []
    )

    // A single restrained highlight band suggests the bevel visible on the
    // official branded key art without adding v1's conspicuous scratch pattern.
    faceContext.setBlendMode(.sourceAtop)
    let highlightColors = [
        CGColor(srgbRed: 1.0, green: 0.98, blue: 0.84, alpha: 0.00),
        CGColor(srgbRed: 1.0, green: 0.98, blue: 0.84, alpha: 0.32),
        CGColor(srgbRed: 1.0, green: 0.98, blue: 0.84, alpha: 0.00)
    ] as CFArray
    let highlightLocations: [CGFloat] = [0.34, 0.48, 0.62]
    guard let highlight = CGGradient(colorsSpace: colorSpace, colors: highlightColors, locations: highlightLocations) else {
        fail("Could not create the wordmark highlight.")
    }
    faceContext.drawLinearGradient(
        highlight,
        start: CGPoint(x: 0, y: source.height),
        end: CGPoint(x: 0, y: 0),
        options: []
    )

    guard let image = faceContext.makeImage() else {
        fail("Could not finish the official-metal wordmark layer.")
    }
    return image
}

// The v2 lockup is deliberately smaller and lower than v1. LEGENDS still
// spans nearly the full safe width at drawer scale, while Jeska's face, chest,
// weapons and most of her costume remain unobstructed. It also clears the
// standardized lower-right deck-count seal zone.
let titleWidth: CGFloat = 1360
let titleHeight = titleWidth * CGFloat(wordmark.height) / CGFloat(wordmark.width)
let titleRect = CGRect(x: 220, y: 310, width: titleWidth, height: titleHeight)

let deepContour = solidTint(
    wordmark,
    color: CGColor(srgbRed: 0.014, green: 0.020, blue: 0.055, alpha: 1.0)
)
let wineDepth = solidTint(
    wordmark,
    color: CGColor(srgbRed: 0.24, green: 0.022, blue: 0.045, alpha: 1.0)
)
let antiqueRim = solidTint(
    wordmark,
    color: CGColor(srgbRed: 0.78, green: 0.58, blue: 0.31, alpha: 1.0)
)
let paleRim = solidTint(
    wordmark,
    color: CGColor(srgbRed: 0.80, green: 0.92, blue: 0.83, alpha: 1.0)
)
let metalFace = officialTealMetalFace(wordmark)

context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -12),
    blur: 25,
    color: CGColor(srgbRed: 0.0, green: 0.0, blue: 0.02, alpha: 0.88)
)
context.draw(deepContour, in: titleRect)
context.restoreGState()

// Deterministic concentric offsets preserve the exact official contours.
// The wine depth is mostly below the letters, echoing Jeska's red storm light.
for radius in stride(from: 12, through: 6, by: -3) {
    for step in 0..<16 {
        let angle = CGFloat(step) * .pi / 8
        let offset = CGPoint(x: cos(angle) * CGFloat(radius), y: sin(angle) * CGFloat(radius))
        context.draw(deepContour, in: titleRect.offsetBy(dx: offset.x, dy: offset.y))
    }
}
for offsetY in stride(from: -9, through: -3, by: 2) {
    context.draw(wineDepth, in: titleRect.offsetBy(dx: 0, dy: CGFloat(offsetY)))
}
for radius in stride(from: 5, through: 3, by: -1) {
    for step in 0..<16 {
        let angle = CGFloat(step) * .pi / 8
        let offset = CGPoint(x: cos(angle) * CGFloat(radius), y: sin(angle) * CGFloat(radius))
        context.draw(antiqueRim, in: titleRect.offsetBy(dx: offset.x, dy: offset.y))
    }
}
for radius in stride(from: 2, through: 1, by: -1) {
    for step in 0..<12 {
        let angle = CGFloat(step) * .pi / 6
        let offset = CGPoint(x: cos(angle) * CGFloat(radius), y: sin(angle) * CGFloat(radius))
        context.draw(paleRim, in: titleRect.offsetBy(dx: offset.x, dy: offset.y))
    }
}
context.draw(metalFace, in: titleRect)

// One fine warm glint ties the official teal-silver treatment into the copper
// weapon light without turning the face orange.
context.saveGState()
context.setAlpha(0.22)
context.setBlendMode(.screen)
context.draw(
    solidTint(wordmark, color: CGColor(srgbRed: 1.0, green: 0.74, blue: 0.38, alpha: 1.0)),
    in: titleRect.offsetBy(dx: 0, dy: 1.5)
)
context.restoreGState()

guard let outputImage = context.makeImage() else {
    fail("Could not render the v2 alternate target.")
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
