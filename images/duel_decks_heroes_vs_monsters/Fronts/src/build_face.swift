#!/usr/bin/env swift

import CoreGraphics
import CoreText
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let outputWidth = 1800
private let outputHeight = 2100
private let outputDPI = 600

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 3 else {
    fail("Usage: build_face.swift INPUT.png OUTPUT.png")
}

let inputURL = URL(fileURLWithPath: CommandLine.arguments[1])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[2])

guard let source = CGImageSourceCreateWithURL(inputURL as CFURL, nil),
      let sourceImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
    fail("Could not read \(inputURL.path)")
}

// The unmodified ImageGen output is 1162 × 1353. A centered 1158 × 1351 crop is
// an exact 6:7 rectangle and removes only two pixels per side and one per top/bottom.
let cropUnit = min(sourceImage.width / 6, sourceImage.height / 7)
let cropWidth = cropUnit * 6
let cropHeight = cropUnit * 7
let cropRect = CGRect(
    x: (sourceImage.width - cropWidth) / 2,
    y: (sourceImage.height - cropHeight) / 2,
    width: cropWidth,
    height: cropHeight
)

guard cropWidth * 7 == cropHeight * 6,
      let croppedImage = sourceImage.cropping(to: cropRect) else {
    fail("Could not make an exact 6:7 crop from \(sourceImage.width) × \(sourceImage.height)")
}

guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(
        data: nil,
        width: outputWidth,
        height: outputHeight,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
      ) else {
    fail("Could not create output canvas")
}

context.interpolationQuality = .high
context.setAllowsAntialiasing(true)
context.setShouldAntialias(true)
context.draw(
    croppedImage,
    in: CGRect(x: 0, y: 0, width: outputWidth, height: outputHeight)
)

// A full-width translucent banner retains the generated stone, smoke, sparks,
// and coils beneath the typography while making the product name drawer-readable.
let bandBottom: CGFloat = 292
let bandTop: CGFloat = 1038
let bandRect = CGRect(x: 0, y: bandBottom, width: CGFloat(outputWidth), height: bandTop - bandBottom)
let gradientColors = [
    CGColor(srgbRed: 0.045, green: 0.020, blue: 0.015, alpha: 0.68),
    CGColor(srgbRed: 0.105, green: 0.025, blue: 0.020, alpha: 0.79),
    CGColor(srgbRed: 0.035, green: 0.025, blue: 0.018, alpha: 0.68)
] as CFArray
let gradientLocations: [CGFloat] = [0.0, 0.48, 1.0]
guard let bannerGradient = CGGradient(
    colorsSpace: colorSpace,
    colors: gradientColors,
    locations: gradientLocations
) else {
    fail("Could not create title-banner gradient")
}

context.saveGState()
context.clip(to: bandRect)
context.drawLinearGradient(
    bannerGradient,
    start: CGPoint(x: 0, y: bandRect.midY),
    end: CGPoint(x: CGFloat(outputWidth), y: bandRect.midY),
    options: []
)
context.restoreGState()

let ruleShadow = CGColor(srgbRed: 0.03, green: 0.01, blue: 0.0, alpha: 0.90)
let antiqueGold = CGColor(srgbRed: 0.78, green: 0.57, blue: 0.23, alpha: 1.0)
let paleIvory = CGColor(srgbRed: 0.98, green: 0.94, blue: 0.77, alpha: 1.0)
let outerInk = CGColor(srgbRed: 0.025, green: 0.018, blue: 0.014, alpha: 1.0)

context.setFillColor(ruleShadow)
context.fill(CGRect(x: 0, y: bandBottom - 7, width: CGFloat(outputWidth), height: 16))
context.fill(CGRect(x: 0, y: bandTop - 9, width: CGFloat(outputWidth), height: 16))
context.setFillColor(antiqueGold)
context.fill(CGRect(x: 0, y: bandBottom, width: CGFloat(outputWidth), height: 5))
context.fill(CGRect(x: 0, y: bandTop - 5, width: CGFloat(outputWidth), height: 5))

struct TitleLine {
    let text: String
    let preferredSize: CGFloat
    let centerY: CGFloat
}

let titleLines = [
    TitleLine(text: "DUEL DECKS:", preferredSize: 184, centerY: 888),
    TitleLine(text: "HEROES VS.", preferredSize: 242, centerY: 652),
    TitleLine(text: "MONSTERS", preferredSize: 252, centerY: 405)
]

let maxTextWidth: CGFloat = 1620

func makeLine(text: String, font: CTFont, fill: CGColor, stroke: CGColor, strokeWidth: CGFloat) -> CTLine {
    let attributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key(kCTFontAttributeName as String): font,
        NSAttributedString.Key(kCTForegroundColorAttributeName as String): fill,
        NSAttributedString.Key(kCTStrokeColorAttributeName as String): stroke,
        NSAttributedString.Key(kCTStrokeWidthAttributeName as String): strokeWidth,
        NSAttributedString.Key(kCTLigatureAttributeName as String): 0,
        NSAttributedString.Key(kCTKernAttributeName as String): 0.8
    ]
    return CTLineCreateWithAttributedString(NSAttributedString(string: text, attributes: attributes))
}

func fittedFont(for text: String, preferredSize: CGFloat) -> CTFont {
    var size = preferredSize
    while size > 80 {
        let font = CTFontCreateWithName("Copperplate-Bold" as CFString, size, nil)
        let probe = makeLine(text: text, font: font, fill: paleIvory, stroke: antiqueGold, strokeWidth: -1)
        let width = CTLineGetBoundsWithOptions(probe, [.useGlyphPathBounds]).width
        if width <= maxTextWidth {
            return font
        }
        size -= 1
    }
    return CTFontCreateWithName("Copperplate-Bold" as CFString, size, nil)
}

func drawCentered(_ title: TitleLine) {
    let font = fittedFont(for: title.text, preferredSize: title.preferredSize)

    // First pass: a broad dark silhouette/shadow. Second pass: antique-gold edge
    // and pale-ivory face. The two-pass treatment stays crisp at drawer scale.
    let outerLine = makeLine(
        text: title.text,
        font: font,
        fill: outerInk,
        stroke: outerInk,
        strokeWidth: -16
    )
    let outerBounds = CTLineGetBoundsWithOptions(outerLine, [.useGlyphPathBounds])

    context.saveGState()
    context.setShadow(
        offset: CGSize(width: 0, height: -8),
        blur: 13,
        color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.82)
    )
    context.textPosition = CGPoint(
        x: CGFloat(outputWidth) / 2 - outerBounds.midX,
        y: title.centerY - outerBounds.midY
    )
    CTLineDraw(outerLine, context)
    context.restoreGState()

    let faceLine = makeLine(
        text: title.text,
        font: font,
        fill: paleIvory,
        stroke: antiqueGold,
        strokeWidth: -6
    )
    let faceBounds = CTLineGetBoundsWithOptions(faceLine, [.useGlyphPathBounds])
    context.textPosition = CGPoint(
        x: CGFloat(outputWidth) / 2 - faceBounds.midX,
        y: title.centerY - faceBounds.midY
    )
    CTLineDraw(faceLine, context)
}

for title in titleLines {
    drawCentered(title)
}

guard let outputImage = context.makeImage() else {
    fail("Could not render output image")
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
    fail("Could not create \(outputURL.path)")
}

let properties: [CFString: Any] = [
    kCGImagePropertyDPIWidth: outputDPI,
    kCGImagePropertyDPIHeight: outputDPI
]
CGImageDestinationAddImage(destination, outputImage, properties as CFDictionary)
guard CGImageDestinationFinalize(destination) else {
    fail("Could not finish writing \(outputURL.path)")
}

print("Wrote \(outputURL.path)")
