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

guard CommandLine.arguments.count == 6 else {
    fail("Usage: build_final_fantasy_commander_target.swift ART.png MAGIC_WORDMARK.png FINAL_FANTASY_WORDMARK.png FIC_SYMBOL.png OUTPUT.png")
}

func loadImage(_ path: String) -> CGImage {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(path).")
    }
    return image
}

let art = loadImage(CommandLine.arguments[1])
let magicWordmark = loadImage(CommandLine.arguments[2])
let finalFantasyWordmark = loadImage(CommandLine.arguments[3])
let commanderSymbol = loadImage(CommandLine.arguments[4])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[5])

guard art.width == 1163, art.height == 1353 else {
    fail("Expected the unmodified 1163 × 1353 ImageGen artwork; found \(art.width) × \(art.height).")
}
guard magicWordmark.width == 970, magicWordmark.height == 340 else {
    fail("Expected the derived 970 × 340 official Magic wordmark crop.")
}
guard finalFantasyWordmark.width == 970, finalFantasyWordmark.height == 230 else {
    fail("Expected the derived 970 × 230 official FINAL FANTASY wordmark crop.")
}
guard commanderSymbol.width == 900, commanderSymbol.height == 900 else {
    fail("Expected the official 900 × 900 FIC Commander expansion symbol.")
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

// The generated artwork is already almost exactly 6:7. Remove only 3 pixels
// from its sides, preserving the complete four-character ensemble, then scale
// to the exact print canvas.
let sourceRect = CGRect(x: 1, y: 0, width: 1160, height: 1353)
guard let croppedArt = art.cropping(to: sourceRect) else {
    fail("Could not crop the ImageGen artwork to 6:7.")
}
context.draw(croppedArt, in: CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))

// A translucent obsidian veil crosses the lower torso/leg region, allowing the
// untouched official white wordmarks to remain exact and drawer-readable while
// the crystalline art remains visible and informative underneath.
let plateColors = [
    CGColor(srgbRed: 0.015, green: 0.025, blue: 0.070, alpha: 0.02),
    CGColor(srgbRed: 0.010, green: 0.018, blue: 0.052, alpha: 0.80),
    CGColor(srgbRed: 0.008, green: 0.014, blue: 0.040, alpha: 0.88),
    CGColor(srgbRed: 0.012, green: 0.022, blue: 0.060, alpha: 0.76),
    CGColor(srgbRed: 0.020, green: 0.030, blue: 0.075, alpha: 0.02)
] as CFArray
let plateLocations: [CGFloat] = [0.0, 0.16, 0.48, 0.84, 1.0]
guard let plate = CGGradient(colorsSpace: colorSpace, colors: plateColors, locations: plateLocations) else {
    fail("Could not create the title readability veil.")
}
context.saveGState()
context.clip(to: CGRect(x: 0, y: 300, width: canvasWidth, height: 800))
context.drawLinearGradient(
    plate,
    start: CGPoint(x: 0, y: 300),
    end: CGPoint(x: 0, y: 1100),
    options: []
)
context.restoreGState()

// Very subtle edge vignette improves print-safe subject and logo separation
// without introducing a border or featureless region.
let edgeColors = [
    CGColor(srgbRed: 0.0, green: 0.0, blue: 0.02, alpha: 0.28),
    CGColor(srgbRed: 0.0, green: 0.0, blue: 0.02, alpha: 0.0)
] as CFArray
let edgeLocations: [CGFloat] = [0.0, 1.0]
guard let edgeGradient = CGGradient(colorsSpace: colorSpace, colors: edgeColors, locations: edgeLocations) else {
    fail("Could not create the edge vignette.")
}
for rect in [
    CGRect(x: 0, y: 0, width: 125, height: canvasHeight),
    CGRect(x: canvasWidth - 125, y: 0, width: 125, height: canvasHeight)
] {
    context.saveGState()
    context.clip(to: rect)
    let startX = rect.minX == 0 ? rect.minX : rect.maxX
    let endX = rect.minX == 0 ? rect.maxX : rect.minX
    context.drawLinearGradient(
        edgeGradient,
        start: CGPoint(x: startX, y: 0),
        end: CGPoint(x: endX, y: 0),
        options: []
    )
    context.restoreGState()
}

func drawOfficialAsset(_ image: CGImage, in rect: CGRect, shadowBlur: CGFloat, shadowAlpha: CGFloat) {
    context.saveGState()
    context.setShadow(
        offset: CGSize(width: 0, height: -6),
        blur: shadowBlur,
        color: CGColor(srgbRed: 0.0, green: 0.0, blue: 0.0, alpha: shadowAlpha)
    )
    context.draw(image, in: rect)
    context.restoreGState()
    context.draw(image, in: rect)
}

// These are lossless crops from Wizards' official stacked transparent lockup,
// not recreated typography. FINAL FANTASY spans nearly the entire width and is
// the largest information element. Both logos stay above the count-seal zone.
let magicWidth: CGFloat = 760
let magicHeight = magicWidth * CGFloat(magicWordmark.height) / CGFloat(magicWordmark.width)
drawOfficialAsset(
    magicWordmark,
    in: CGRect(x: (CGFloat(canvasWidth) - magicWidth) / 2, y: 785, width: magicWidth, height: magicHeight),
    shadowBlur: 18,
    shadowAlpha: 0.92
)

let titleWidth: CGFloat = 1660
let titleHeight = titleWidth * CGFloat(finalFantasyWordmark.height) / CGFloat(finalFantasyWordmark.width)
drawOfficialAsset(
    finalFantasyWordmark,
    in: CGRect(x: 70, y: 365, width: titleWidth, height: titleHeight),
    shadowBlur: 22,
    shadowAlpha: 0.96
)

// Retain a restrained strip of the official lockup's crystal-divider motif.
context.saveGState()
context.setStrokeColor(CGColor(srgbRed: 0.88, green: 0.77, blue: 0.48, alpha: 0.76))
context.setLineWidth(3)
context.move(to: CGPoint(x: 150, y: 770))
context.addLine(to: CGPoint(x: 1650, y: 770))
context.strokePath()
context.restoreGState()

// The official mythic FIC expansion symbol doubles as a small licensed accent.
// Its bottom-left placement balances the lower-right deck-count seal.
drawOfficialAsset(
    commanderSymbol,
    in: CGRect(x: 78, y: 72, width: 220, height: 220),
    shadowBlur: 14,
    shadowAlpha: 0.88
)

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

