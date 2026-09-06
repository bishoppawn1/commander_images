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
    fail("Usage: build_warhammer_40000_commander_target.swift ART.png OFFICIAL_LOGO.png OUTPUT.png")
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
let officialCombinedLogo = loadImage(CommandLine.arguments[2])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[3])

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

// Center-crop the near-6:7 ImageGen portrait by under one percent, then
// resample to the exact print dimensions without blank edges.
let targetAspect = CGFloat(canvasWidth) / CGFloat(canvasHeight)
let artAspect = CGFloat(art.width) / CGFloat(art.height)
var sourceRect = CGRect(x: 0, y: 0, width: art.width, height: art.height)
if artAspect > targetAspect {
    let croppedWidth = CGFloat(art.height) * targetAspect
    sourceRect.origin.x = (CGFloat(art.width) - croppedWidth) / 2
    sourceRect.size.width = croppedWidth
} else if artAspect < targetAspect {
    let croppedHeight = CGFloat(art.width) / targetAspect
    sourceRect.origin.y = (CGFloat(art.height) - croppedHeight) / 2
    sourceRect.size.height = croppedHeight
}

guard let croppedArt = art.cropping(to: sourceRect.integral) else {
    fail("Could not crop the source art.")
}
context.draw(croppedArt, in: CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))

// Deepen the upper fleet-filled sky just enough to give the official metal
// wordmark a clean silhouette while retaining ships, lightning, and texture.
let gradientColors = [
    CGColor(srgbRed: 0.01, green: 0.012, blue: 0.016, alpha: 0.10),
    CGColor(srgbRed: 0.01, green: 0.012, blue: 0.016, alpha: 0.58)
] as CFArray
let gradientLocations: [CGFloat] = [0.0, 1.0]
guard let gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors, locations: gradientLocations) else {
    fail("Could not create the title gradient.")
}
context.saveGState()
context.clip(to: CGRect(x: 0, y: 1320, width: canvasWidth, height: 780))
context.drawLinearGradient(
    gradient,
    start: CGPoint(x: 0, y: 1320),
    end: CGPoint(x: 0, y: 2100),
    options: []
)
context.restoreGState()

// Crop the exact official Wizards WARHAMMER 40,000 metal plate from the
// combined Magic x Warhammer transparent logo. Never redraw the trademark.
let plateSourceRect = CGRect(x: 78, y: 170, width: 504, height: 130)
guard let officialPlate = officialCombinedLogo.cropping(to: plateSourceRect) else {
    fail("Could not crop the official WARHAMMER 40,000 plate.")
}

let plateWidth: CGFloat = 1650
let plateHeight = plateWidth * CGFloat(officialPlate.height) / CGFloat(officialPlate.width)
let plateRect = CGRect(
    x: (CGFloat(canvasWidth) - plateWidth) / 2,
    y: CGFloat(canvasHeight) - 55 - plateHeight,
    width: plateWidth,
    height: plateHeight
)
context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -12),
    blur: 28,
    color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.98)
)
context.draw(officialPlate, in: plateRect)
context.restoreGState()
context.draw(officialPlate, in: plateRect)

// Separate format identifier beneath the official brand plate. It is large,
// horizontal, high-contrast, and contains no ancillary copy.
let commanderFont = CTFontCreateWithName("Copperplate-Bold" as CFString, 154, nil)
let commanderAttributes: [NSAttributedString.Key: Any] = [
    NSAttributedString.Key(kCTFontAttributeName as String): commanderFont,
    NSAttributedString.Key(kCTForegroundColorAttributeName as String): CGColor(
        srgbRed: 0.91, green: 0.91, blue: 0.87, alpha: 1
    ),
    NSAttributedString.Key(kCTStrokeColorAttributeName as String): CGColor(
        srgbRed: 0.01, green: 0.012, blue: 0.016, alpha: 1
    ),
    NSAttributedString.Key(kCTStrokeWidthAttributeName as String): -5.0,
    NSAttributedString.Key(kCTKernAttributeName as String): 25.0,
    NSAttributedString.Key(kCTLigatureAttributeName as String): 0
]
let commanderString = NSAttributedString(string: "COMMANDER", attributes: commanderAttributes)
let commanderLine = CTLineCreateWithAttributedString(commanderString)
let commanderBounds = CTLineGetBoundsWithOptions(commanderLine, [.useGlyphPathBounds])
let desiredCommanderWidth: CGFloat = 1480
let horizontalScale = desiredCommanderWidth / commanderBounds.width

context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -8),
    blur: 18,
    color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.95)
)
context.translateBy(
    x: (CGFloat(canvasWidth) - desiredCommanderWidth) / 2,
    y: 1395
)
context.scaleBy(x: horizontalScale, y: 1)
context.textPosition = CGPoint(x: -commanderBounds.minX, y: -commanderBounds.minY)
CTLineDraw(commanderLine, context)
context.restoreGState()

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
