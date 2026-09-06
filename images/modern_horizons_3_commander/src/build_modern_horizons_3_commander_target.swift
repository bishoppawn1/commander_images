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

guard CommandLine.arguments.count == 3 else {
    fail("Usage: build_modern_horizons_3_commander_target.swift POSTER_RENDER.png OUTPUT.png")
}

let inputURL = URL(fileURLWithPath: CommandLine.arguments[1])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[2])

guard let source = CGImageSourceCreateWithURL(inputURL as CFURL, nil),
      let poster = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
    fail("Could not read \(inputURL.path).")
}

guard poster.width == 4917, poster.height == 7317 else {
    fail("Expected the retained 200-DPI poster raster at 4917 × 7317 pixels; found \(poster.width) × \(poster.height).")
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

// The official poster is taller than 6:7. This crop removes the large airy
// upper margin and the printer marks while preserving Ajani's complete face,
// axe, torso, official MODERN HORIZONS word treatment, and lower title field.
let sourceRect = CGRect(x: 18, y: 1240, width: 4881, height: 5695)
guard let crop = poster.cropping(to: sourceRect) else {
    fail("Could not crop the official WPN poster raster.")
}
context.draw(crop, in: CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight))

// Wizards' poster spells the final number as the Roman numeral III. The drawer
// title is required to read exactly MODERN HORIZONS 3, so replace only that
// final numeral field. The sampled color is the poster's own uniform title-field
// teal (#369E85), making the repair continuous with the untouched source.
context.setFillColor(CGColor(srgbRed: 54.0 / 255.0, green: 158.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0))
context.fill(CGRect(x: 0, y: 0, width: targetWidth, height: 260))

let font = CTFontCreateWithName("Copperplate-Bold" as CFString, 265, nil)
let attributes: [NSAttributedString.Key: Any] = [
    NSAttributedString.Key(kCTFontAttributeName as String): font,
    NSAttributedString.Key(kCTForegroundColorAttributeName as String): CGColor(
        srgbRed: 0.96, green: 0.94, blue: 0.94, alpha: 1.0
    ),
    NSAttributedString.Key(kCTStrokeColorAttributeName as String): CGColor(
        srgbRed: 0.77, green: 0.06, blue: 0.47, alpha: 1.0
    ),
    NSAttributedString.Key(kCTStrokeWidthAttributeName as String): -3.5,
    NSAttributedString.Key(kCTLigatureAttributeName as String): 0
]
let numeral = CTLineCreateWithAttributedString(NSAttributedString(string: "3", attributes: attributes))
let bounds = CTLineGetBoundsWithOptions(numeral, [.useGlyphPathBounds])
let numeralCenter = CGPoint(x: CGFloat(targetWidth) / 2, y: 122)
let textPosition = CGPoint(x: numeralCenter.x - bounds.midX, y: numeralCenter.y - bounds.midY)

context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -5),
    blur: 10,
    color: CGColor(srgbRed: 0.10, green: 0.26, blue: 0.25, alpha: 0.86)
)
context.textPosition = textPosition
CTLineDraw(numeral, context)
context.restoreGState()
context.textPosition = textPosition
CTLineDraw(numeral, context)

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
