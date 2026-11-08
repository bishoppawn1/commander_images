#!/usr/bin/env swift

import CoreGraphics
import CoreText
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
    fail("Usage: build_marvel_super_heroes_commander_target.swift KEY_ART.jpg OFFICIAL_SET_LOGO.png OUTPUT.png")
}

func loadImage(_ path: String) -> CGImage {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(path).")
    }
    return image
}

let keyArt = loadImage(CommandLine.arguments[1])
let officialSetLogo = loadImage(CommandLine.arguments[2])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[3])

guard keyArt.width == 1080, keyArt.height == 1350 else {
    fail("Expected the official 1080 × 1350 WPN portrait key art; found \(keyArt.width) × \(keyArt.height).")
}
guard officialSetLogo.width == 2222, officialSetLogo.height == 672 else {
    fail("Expected the official 2222 × 672 print set logo; found \(officialSetLogo.width) × \(officialSetLogo.height).")
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
    fail("Could not create the sRGB output canvas.")
}

context.interpolationQuality = .high

// The upper 1080 × 1260 pixels are an exact 6:7 crop. This removes only the
// final 90 source pixels of legal/footer space while preserving the complete
// dense hero composition. The original small split lockup is subsequently
// covered by the replacement title field.
guard let croppedKeyArt = keyArt.cropping(to: CGRect(x: 0, y: 0, width: 1080, height: 1260)) else {
    fail("Could not crop the official key art.")
}
context.draw(croppedKeyArt, in: CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))

let nearBlack = CGColor(srgbRed: 0.018, green: 0.018, blue: 0.026, alpha: 1.0)
let deepRed = CGColor(srgbRed: 0.48, green: 0.015, blue: 0.025, alpha: 1.0)
let darkerRed = CGColor(srgbRed: 0.19, green: 0.008, blue: 0.018, alpha: 1.0)
let antiqueGold = CGColor(srgbRed: 0.83, green: 0.63, blue: 0.27, alpha: 1.0)
let ivory = CGColor(srgbRed: 0.98, green: 0.95, blue: 0.82, alpha: 1.0)
let outline = CGColor(srgbRed: 0.025, green: 0.016, blue: 0.018, alpha: 1.0)

// Opaque lower field completely removes the source's smaller split lockup.
// A feather above it retains rubble, motion, and leg detail behind the large
// licensed title without leaving a blank or featureless panel.
context.setFillColor(nearBlack)
context.fill(CGRect(x: 0, y: 0, width: canvasWidth, height: 515))

let veilColors = [
    CGColor(srgbRed: 0.018, green: 0.018, blue: 0.026, alpha: 0.96),
    CGColor(srgbRed: 0.018, green: 0.018, blue: 0.026, alpha: 0.72),
    CGColor(srgbRed: 0.018, green: 0.018, blue: 0.026, alpha: 0.00)
] as CFArray
let veilLocations: [CGFloat] = [0.0, 0.48, 1.0]
guard let veil = CGGradient(colorsSpace: colorSpace, colors: veilColors, locations: veilLocations) else {
    fail("Could not create the title veil.")
}
context.drawLinearGradient(
    veil,
    start: CGPoint(x: 0, y: 500),
    end: CGPoint(x: 0, y: 1010),
    options: []
)

// A low red Commander band and subtle alternating speed lines keep the base
// dense while reserving the lower-right standard count-marker zone.
let commanderBand = CGRect(x: 0, y: 0, width: canvasWidth, height: 236)
context.setFillColor(deepRed)
context.fill(commanderBand)

context.saveGState()
context.clip(to: commanderBand)
context.setFillColor(darkerRed)
var stripeX: CGFloat = -260
while stripeX < CGFloat(canvasWidth) + 260 {
    context.beginPath()
    context.move(to: CGPoint(x: stripeX, y: 0))
    context.addLine(to: CGPoint(x: stripeX + 92, y: 0))
    context.addLine(to: CGPoint(x: stripeX + 330, y: 236))
    context.addLine(to: CGPoint(x: stripeX + 238, y: 236))
    context.closePath()
    context.fillPath()
    stripeX += 190
}
context.restoreGState()

context.setFillColor(antiqueGold)
context.fill(CGRect(x: 0, y: 236, width: canvasWidth, height: 10))

// Composite the official logo directly and near full safe width. Its original
// aspect ratio and licensed letterforms are unchanged.
let logoWidth: CGFloat = 1660
let logoHeight = logoWidth * CGFloat(officialSetLogo.height) / CGFloat(officialSetLogo.width)
context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -10),
    blur: 22,
    color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.92)
)
context.draw(
    officialSetLogo,
    in: CGRect(
        x: (CGFloat(canvasWidth) - logoWidth) / 2,
        y: 286,
        width: logoWidth,
        height: logoHeight
    )
)
context.restoreGState()

// Fit exact secondary format identification left of the future 210-pixel seal.
let commanderFont = CTFontCreateWithName("Copperplate-Bold" as CFString, 154, nil)
let commanderAttributes: [NSAttributedString.Key: Any] = [
    NSAttributedString.Key(kCTFontAttributeName as String): commanderFont,
    NSAttributedString.Key(kCTForegroundColorAttributeName as String): ivory,
    NSAttributedString.Key(kCTStrokeColorAttributeName as String): outline,
    NSAttributedString.Key(kCTStrokeWidthAttributeName as String): -3.0,
    NSAttributedString.Key(kCTLigatureAttributeName as String): 0
]
let commanderText = NSAttributedString(string: "COMMANDER", attributes: commanderAttributes)
let commanderLine = CTLineCreateWithAttributedString(commanderText)
let commanderBounds = CTLineGetBoundsWithOptions(commanderLine, [.useGlyphPathBounds])
let commanderMaxWidth: CGFloat = 1300
let commanderScale = min(1.0, commanderMaxWidth / commanderBounds.width)
let commanderPosition = CGPoint(
    x: 90 - commanderBounds.minX * commanderScale,
    y: 46 - commanderBounds.minY * commanderScale
)

context.saveGState()
context.translateBy(x: commanderPosition.x, y: commanderPosition.y)
context.scaleBy(x: commanderScale, y: commanderScale)
context.setShadow(
    offset: CGSize(width: 0, height: -7),
    blur: 12,
    color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.78)
)
context.textPosition = .zero
CTLineDraw(commanderLine, context)
context.restoreGState()

guard let outputImage = context.makeImage() else {
    fail("Could not render the finished target.")
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
