#!/usr/bin/env swift

import CoreGraphics
import CoreText
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let canvasWidth = 1800
private let canvasHeight = 2100
private let outputDPI = 600
private let title = "COMMANDER 2013"
private let titleCenter = CGPoint(x: 900, y: 1390)
private let titleMaximumWidth: CGFloat = 1535

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 4 else {
    fail("Usage: build_commander_2013_gothic_wordmark.swift INPUT.png FONT.ttf OUTPUT.png")
}

let inputPath = CommandLine.arguments[1]
let fontPath = CommandLine.arguments[2]
let outputPath = CommandLine.arguments[3]

guard URL(fileURLWithPath: inputPath).standardizedFileURL != URL(fileURLWithPath: outputPath).standardizedFileURL else {
    fail("Input and output must differ; existing finished targets are never overwritten.")
}

var registrationError: Unmanaged<CFError>?
let fontURL = URL(fileURLWithPath: fontPath)
guard CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &registrationError) else {
    fail("Could not register font: \(registrationError?.takeRetainedValue().localizedDescription ?? "unknown error")")
}
guard let fontDescriptor = (CTFontManagerCreateFontDescriptorsFromURL(fontURL as CFURL) as? [CTFontDescriptor])?.first else {
    fail("Could not read a font descriptor from \(fontPath).")
}

guard let source = CGImageSourceCreateWithURL(URL(fileURLWithPath: inputPath) as CFURL, nil),
      let sourceImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
    fail("Could not read \(inputPath).")
}
guard sourceImage.width == canvasWidth, sourceImage.height == canvasHeight else {
    fail("Expected 1800 × 2100 input; found \(sourceImage.width) × \(sourceImage.height).")
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
    fail("Could not create the drawing canvas.")
}

context.interpolationQuality = .high
context.draw(sourceImage, in: CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))

func makeCartouche(inset: CGFloat = 0) -> CGPath {
    let path = CGMutablePath()
    let left = 70 + inset
    let right = 1730 - inset
    let centerY = titleCenter.y
    let halfHeight = 150 - inset * 0.18

    path.move(to: CGPoint(x: left, y: centerY))
    path.addCurve(
        to: CGPoint(x: left + 105, y: centerY + halfHeight),
        control1: CGPoint(x: left + 42, y: centerY + 18),
        control2: CGPoint(x: left + 52, y: centerY + halfHeight - 26)
    )
    path.addCurve(
        to: CGPoint(x: 900, y: centerY + halfHeight - 8),
        control1: CGPoint(x: left + 430, y: centerY + halfHeight - 36),
        control2: CGPoint(x: 650, y: centerY + halfHeight + 15)
    )
    path.addCurve(
        to: CGPoint(x: right - 105, y: centerY + halfHeight),
        control1: CGPoint(x: 1150, y: centerY + halfHeight + 15),
        control2: CGPoint(x: right - 430, y: centerY + halfHeight - 36)
    )
    path.addCurve(
        to: CGPoint(x: right, y: centerY),
        control1: CGPoint(x: right - 52, y: centerY + halfHeight - 26),
        control2: CGPoint(x: right - 42, y: centerY + 18)
    )
    path.addCurve(
        to: CGPoint(x: right - 105, y: centerY - halfHeight),
        control1: CGPoint(x: right - 42, y: centerY - 18),
        control2: CGPoint(x: right - 52, y: centerY - halfHeight + 26)
    )
    path.addCurve(
        to: CGPoint(x: 900, y: centerY - halfHeight + 8),
        control1: CGPoint(x: right - 430, y: centerY - halfHeight + 36),
        control2: CGPoint(x: 1150, y: centerY - halfHeight - 15)
    )
    path.addCurve(
        to: CGPoint(x: left + 105, y: centerY - halfHeight),
        control1: CGPoint(x: 650, y: centerY - halfHeight - 15),
        control2: CGPoint(x: left + 430, y: centerY - halfHeight + 36)
    )
    path.addCurve(
        to: CGPoint(x: left, y: centerY),
        control1: CGPoint(x: left + 52, y: centerY - halfHeight + 26),
        control2: CGPoint(x: left + 42, y: centerY - 18)
    )
    path.closeSubpath()
    return path
}

let cartouche = makeCartouche()
let innerCartouche = makeCartouche(inset: 17)

let blackShadow = CGColor(srgbRed: 0.005, green: 0.006, blue: 0.012, alpha: 0.94)
let ironEdge = CGColor(srgbRed: 0.14, green: 0.15, blue: 0.18, alpha: 1)
let antiqueSilver = CGColor(srgbRed: 0.47, green: 0.46, blue: 0.43, alpha: 1)
let edgeHighlight = CGColor(srgbRed: 0.72, green: 0.72, blue: 0.68, alpha: 0.72)

context.saveGState()
context.setShadow(offset: CGSize(width: 0, height: -12), blur: 28, color: blackShadow)
context.setFillColor(CGColor(srgbRed: 0.018, green: 0.021, blue: 0.03, alpha: 1))
context.addPath(cartouche)
context.fillPath()
context.restoreGState()

context.saveGState()
context.addPath(cartouche)
context.clip()
let plateGradient = CGGradient(
    colorsSpace: colorSpace,
    colors: [
        CGColor(srgbRed: 0.13, green: 0.15, blue: 0.19, alpha: 1),
        CGColor(srgbRed: 0.025, green: 0.03, blue: 0.045, alpha: 1),
        CGColor(srgbRed: 0.055, green: 0.035, blue: 0.045, alpha: 1),
        CGColor(srgbRed: 0.11, green: 0.07, blue: 0.075, alpha: 1)
    ] as CFArray,
    locations: [0, 0.38, 0.70, 1]
)!
context.drawLinearGradient(
    plateGradient,
    start: CGPoint(x: 70, y: titleCenter.y),
    end: CGPoint(x: 1730, y: titleCenter.y),
    options: []
)

let topSheen = CGGradient(
    colorsSpace: colorSpace,
    colors: [
        CGColor(srgbRed: 0.42, green: 0.46, blue: 0.53, alpha: 0.24),
        CGColor(srgbRed: 0.08, green: 0.09, blue: 0.12, alpha: 0.02),
        CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.32)
    ] as CFArray,
    locations: [0, 0.40, 1]
)!
context.drawLinearGradient(
    topSheen,
    start: CGPoint(x: 900, y: titleCenter.y + 150),
    end: CGPoint(x: 900, y: titleCenter.y - 150),
    options: []
)

var scratchState: UInt64 = 0xC013C013
func randomUnit() -> CGFloat {
    scratchState = scratchState &* 6364136223846793005 &+ 1442695040888963407
    return CGFloat((scratchState >> 33) & 0xFFFF) / 65535
}
for _ in 0..<145 {
    let x = 95 + randomUnit() * 1610
    let y = titleCenter.y - 118 + randomUnit() * 236
    let length = 8 + randomUnit() * 46
    let opacity = 0.025 + randomUnit() * 0.055
    context.setStrokeColor(CGColor(srgbRed: 0.76, green: 0.78, blue: 0.82, alpha: opacity))
    context.setLineWidth(0.7 + randomUnit() * 1.2)
    context.move(to: CGPoint(x: x, y: y))
    context.addLine(to: CGPoint(x: min(x + length, 1710), y: y + (randomUnit() - 0.5) * 4))
    context.strokePath()
}
context.restoreGState()

context.addPath(cartouche)
context.setStrokeColor(blackShadow)
context.setLineWidth(22)
context.strokePath()
context.addPath(cartouche)
context.setStrokeColor(antiqueSilver)
context.setLineWidth(10)
context.strokePath()
context.addPath(cartouche)
context.setStrokeColor(ironEdge)
context.setLineWidth(5)
context.strokePath()
context.addPath(innerCartouche)
context.setStrokeColor(edgeHighlight)
context.setLineWidth(2.2)
context.strokePath()

func drawEndRivet(at center: CGPoint, tint: CGColor) {
    let outer = CGRect(x: center.x - 17, y: center.y - 17, width: 34, height: 34)
    let inner = outer.insetBy(dx: 6, dy: 6)
    context.saveGState()
    context.setShadow(offset: CGSize(width: 0, height: -3), blur: 5, color: blackShadow)
    context.setFillColor(antiqueSilver)
    context.fillEllipse(in: outer)
    context.restoreGState()
    context.setFillColor(tint)
    context.fillEllipse(in: inner)
    context.setStrokeColor(CGColor(srgbRed: 0.80, green: 0.80, blue: 0.76, alpha: 0.52))
    context.setLineWidth(2)
    context.strokeEllipse(in: inner)
}

drawEndRivet(
    at: CGPoint(x: 128, y: titleCenter.y),
    tint: CGColor(srgbRed: 0.10, green: 0.28, blue: 0.42, alpha: 1)
)
drawEndRivet(
    at: CGPoint(x: 1672, y: titleCenter.y),
    tint: CGColor(srgbRed: 0.42, green: 0.09, blue: 0.10, alpha: 1)
)

func titleLine(fontSize: CGFloat) -> (CTLine, CGRect) {
    let font = CTFontCreateWithFontDescriptor(fontDescriptor, fontSize, nil)
    let attributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key(kCTFontAttributeName as String): font,
        NSAttributedString.Key(kCTForegroundColorFromContextAttributeName as String): true,
        NSAttributedString.Key(kCTLigatureAttributeName as String): 0,
        NSAttributedString.Key(kCTKernAttributeName as String): 6.0
    ]
    let line = CTLineCreateWithAttributedString(NSAttributedString(string: title, attributes: attributes))
    return (line, CTLineGetBoundsWithOptions(line, [.useGlyphPathBounds]))
}

var fontSize: CGFloat = 255
var (line, lineBounds) = titleLine(fontSize: fontSize)
if lineBounds.width > titleMaximumWidth {
    fontSize *= titleMaximumWidth / lineBounds.width
    (line, lineBounds) = titleLine(fontSize: fontSize)
}
let lineOrigin = CGPoint(
    x: titleCenter.x - lineBounds.midX,
    y: titleCenter.y - lineBounds.midY - 2
)

func drawLine(at origin: CGPoint, mode: CGTextDrawingMode, lineWidth: CGFloat, fill: CGColor, stroke: CGColor) {
    context.saveGState()
    context.setTextDrawingMode(mode)
    context.setLineJoin(.round)
    context.setLineWidth(lineWidth)
    context.setFillColor(fill)
    context.setStrokeColor(stroke)
    context.textPosition = origin
    CTLineDraw(line, context)
    context.restoreGState()
}

context.saveGState()
context.setShadow(offset: CGSize(width: 0, height: -10), blur: 15, color: blackShadow)
drawLine(
    at: CGPoint(x: lineOrigin.x, y: lineOrigin.y - 6),
    mode: .fillStroke,
    lineWidth: 18,
    fill: CGColor(srgbRed: 0.015, green: 0.017, blue: 0.022, alpha: 1),
    stroke: CGColor(srgbRed: 0.005, green: 0.006, blue: 0.01, alpha: 1)
)
context.restoreGState()

drawLine(
    at: lineOrigin,
    mode: .fillStroke,
    lineWidth: 14,
    fill: CGColor(srgbRed: 0.15, green: 0.16, blue: 0.18, alpha: 1),
    stroke: CGColor(srgbRed: 0.015, green: 0.016, blue: 0.02, alpha: 1)
)
drawLine(
    at: lineOrigin,
    mode: .stroke,
    lineWidth: 8,
    fill: antiqueSilver,
    stroke: CGColor(srgbRed: 0.54, green: 0.52, blue: 0.48, alpha: 1)
)

context.saveGState()
context.setTextDrawingMode(.clip)
context.setFillColor(CGColor(gray: 1, alpha: 1))
context.textPosition = lineOrigin
CTLineDraw(line, context)

let metalGradient = CGGradient(
    colorsSpace: colorSpace,
    colors: [
        CGColor(srgbRed: 0.89, green: 0.93, blue: 0.97, alpha: 1),
        CGColor(srgbRed: 0.36, green: 0.39, blue: 0.44, alpha: 1),
        CGColor(srgbRed: 0.73, green: 0.75, blue: 0.76, alpha: 1),
        CGColor(srgbRed: 0.20, green: 0.21, blue: 0.24, alpha: 1),
        CGColor(srgbRed: 0.63, green: 0.62, blue: 0.60, alpha: 1)
    ] as CFArray,
    locations: [0, 0.24, 0.48, 0.72, 1]
)!
context.drawLinearGradient(
    metalGradient,
    start: CGPoint(x: 900, y: lineBounds.maxY + lineOrigin.y),
    end: CGPoint(x: 900, y: lineBounds.minY + lineOrigin.y),
    options: []
)

context.setBlendMode(.overlay)
let energyGradient = CGGradient(
    colorsSpace: colorSpace,
    colors: [
        CGColor(srgbRed: 0.20, green: 0.67, blue: 0.96, alpha: 0.38),
        CGColor(srgbRed: 0.78, green: 0.80, blue: 0.84, alpha: 0.05),
        CGColor(srgbRed: 0.95, green: 0.19, blue: 0.22, alpha: 0.34)
    ] as CFArray,
    locations: [0, 0.57, 1]
)!
context.drawLinearGradient(
    energyGradient,
    start: CGPoint(x: lineBounds.minX + lineOrigin.x, y: titleCenter.y),
    end: CGPoint(x: lineBounds.maxX + lineOrigin.x, y: titleCenter.y),
    options: []
)

scratchState = 0x2013C0DE
for _ in 0..<92 {
    let x = lineBounds.minX + lineOrigin.x + randomUnit() * lineBounds.width
    let y = lineBounds.minY + lineOrigin.y + randomUnit() * lineBounds.height
    let length = 5 + randomUnit() * 23
    context.setStrokeColor(CGColor(srgbRed: 0.95, green: 0.94, blue: 0.90, alpha: 0.11 + randomUnit() * 0.13))
    context.setLineWidth(0.7 + randomUnit() * 1.0)
    context.move(to: CGPoint(x: x, y: y))
    context.addLine(to: CGPoint(x: x + length, y: y + (randomUnit() - 0.5) * 3))
    context.strokePath()
}
context.restoreGState()

drawLine(
    at: lineOrigin,
    mode: .stroke,
    lineWidth: 2.4,
    fill: edgeHighlight,
    stroke: CGColor(srgbRed: 0.88, green: 0.88, blue: 0.83, alpha: 0.65)
)

guard let outputImage = context.makeImage() else {
    fail("Could not render output image.")
}
let outputURL = URL(fileURLWithPath: outputPath)
try? FileManager.default.createDirectory(at: outputURL.deletingLastPathComponent(), withIntermediateDirectories: true)
guard let destination = CGImageDestinationCreateWithURL(
    outputURL as CFURL,
    UTType.png.identifier as CFString,
    1,
    nil
) else {
    fail("Could not create \(outputPath).")
}
let properties: [CFString: Any] = [
    kCGImagePropertyDPIWidth: outputDPI,
    kCGImagePropertyDPIHeight: outputDPI
]
CGImageDestinationAddImage(destination, outputImage, properties as CFDictionary)
guard CGImageDestinationFinalize(destination) else {
    fail("Could not finish writing \(outputPath).")
}

print("Wrote \(outputPath) with exact title \(title) at \(fontSize.rounded()) pt.")
