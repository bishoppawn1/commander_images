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

guard CommandLine.arguments.count == 3 else {
    fail("Usage: build_phyrexia_all_will_be_one_commander_target.swift POSTER_RASTER.png OUTPUT.png")
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
let outputURL = URL(fileURLWithPath: CommandLine.arguments[2])

guard poster.width == 3600, poster.height == 5400 else {
    fail("Expected the retained 3600 × 5400 poster raster; found \(poster.width) × \(poster.height).")
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

// The official poster is 2:3. Crop its separate lower title panel away and
// retain the upper 3600 × 4200 pixels, which are already the exact 6:7 ratio.
// This keeps the small Magic mark, Elesh Norn's complete headpiece, torso,
// hands, legs, porcelain armor, and detailed oil-dark architecture.
let sourceRect = CGRect(x: 0, y: 0, width: 3600, height: 4200)
guard let croppedPoster = poster.cropping(to: sourceRect) else {
    fail("Could not crop the official poster raster.")
}
context.draw(croppedPoster, in: CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))

// A shallow feathered oil-dark veil gives the exact replacement title a clean
// silhouette while leaving the official robe, legs, porcelain, and background
// texture visible through the entire lower composition.
let veilColors = [
    CGColor(srgbRed: 0.018, green: 0.012, blue: 0.015, alpha: 0.70),
    CGColor(srgbRed: 0.035, green: 0.008, blue: 0.014, alpha: 0.43),
    CGColor(srgbRed: 0.025, green: 0.018, blue: 0.022, alpha: 0.04)
] as CFArray
let veilLocations: [CGFloat] = [0.0, 0.50, 1.0]
guard let veil = CGGradient(colorsSpace: colorSpace, colors: veilColors, locations: veilLocations) else {
    fail("Could not create the title veil.")
}
context.saveGState()
context.clip(to: CGRect(x: 0, y: 150, width: canvasWidth, height: 820))
context.drawLinearGradient(
    veil,
    start: CGPoint(x: 0, y: 150),
    end: CGPoint(x: 0, y: 970),
    options: []
)
context.restoreGState()

let ivory = CGColor(srgbRed: 0.96, green: 0.91, blue: 0.78, alpha: 1.0)
let outline = CGColor(srgbRed: 0.035, green: 0.025, blue: 0.028, alpha: 1.0)
let shadow = CGColor(srgbRed: 0.18, green: 0.015, blue: 0.025, alpha: 0.95)

func drawCenteredTitle(_ text: String, fontSize: CGFloat, baselineY: CGFloat) {
    let font = CTFontCreateWithName("Copperplate-Bold" as CFString, fontSize, nil)
    let attributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key(kCTFontAttributeName as String): font,
        NSAttributedString.Key(kCTForegroundColorAttributeName as String): ivory,
        NSAttributedString.Key(kCTStrokeColorAttributeName as String): outline,
        NSAttributedString.Key(kCTStrokeWidthAttributeName as String): -4.0,
        NSAttributedString.Key(kCTLigatureAttributeName as String): 0
    ]
    let title = NSAttributedString(string: text, attributes: attributes)
    let line = CTLineCreateWithAttributedString(title)
    let bounds = CTLineGetBoundsWithOptions(line, [.useGlyphPathBounds])
    let position = CGPoint(
        x: CGFloat(canvasWidth) / 2 - bounds.midX,
        y: baselineY
    )

    context.saveGState()
    context.setShadow(offset: CGSize(width: 0, height: -10), blur: 19, color: shadow)
    context.textPosition = position
    CTLineDraw(line, context)
    context.restoreGState()

    context.textPosition = position
    CTLineDraw(line, context)
}

// Both lines span nearly the full usable width and remain fully above the
// lower-right 210-pixel count-seal zone (top edge at y=280 in this coordinate
// system). Together they render the exact required title, including the colon.
drawCenteredTitle("PHYREXIA:", fontSize: 300, baselineY: 535)
drawCenteredTitle("ALL WILL BE ONE", fontSize: 175, baselineY: 350)

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
