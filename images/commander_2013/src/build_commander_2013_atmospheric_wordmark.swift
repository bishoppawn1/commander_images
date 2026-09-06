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

guard CommandLine.arguments.count == 4 else {
    fail("Usage: build_commander_2013_atmospheric_wordmark.swift TITLE_FREE_INPUT.png FONT.ttf OUTPUT.png")
}

let inputPath = CommandLine.arguments[1]
let fontPath = CommandLine.arguments[2]
let outputPath = CommandLine.arguments[3]

guard URL(fileURLWithPath: inputPath).standardizedFileURL != URL(fileURLWithPath: outputPath).standardizedFileURL else {
    fail("Input and output must differ; existing targets are never overwritten.")
}

guard let source = CGImageSourceCreateWithURL(URL(fileURLWithPath: inputPath) as CFURL, nil),
      let sourceImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
    fail("Could not read \(inputPath).")
}

var registrationError: Unmanaged<CFError>?
let fontURL = URL(fileURLWithPath: fontPath)
guard CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &registrationError) else {
    fail("Could not register font: \(registrationError?.takeRetainedValue().localizedDescription ?? "unknown error")")
}
guard let fontDescriptor = (CTFontManagerCreateFontDescriptorsFromURL(fontURL as CFURL) as? [CTFontDescriptor])?.first else {
    fail("Could not read a font descriptor from \(fontPath).")
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
    fail("Could not create the output canvas.")
}

context.interpolationQuality = .high
context.draw(sourceImage, in: CGRect(x: 0, y: 0, width: outputWidth, height: outputHeight))

struct PreparedLine {
    let line: CTLine
    let bounds: CGRect
    let origin: CGPoint
}

func prepareLine(
    _ string: String,
    nominalSize: CGFloat,
    tracking: CGFloat,
    maximumWidth: CGFloat,
    center: CGPoint
) -> PreparedLine {
    func make(_ size: CGFloat) -> (CTLine, CGRect) {
        let font = CTFontCreateWithFontDescriptor(fontDescriptor, size, nil)
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(kCTFontAttributeName as String): font,
            NSAttributedString.Key(kCTForegroundColorFromContextAttributeName as String): true,
            NSAttributedString.Key(kCTLigatureAttributeName as String): 0,
            NSAttributedString.Key(kCTKernAttributeName as String): tracking
        ]
        let line = CTLineCreateWithAttributedString(NSAttributedString(string: string, attributes: attributes))
        return (line, CTLineGetBoundsWithOptions(line, [.useGlyphPathBounds]))
    }

    var size = nominalSize
    var (line, bounds) = make(size)
    if bounds.width > maximumWidth {
        size *= maximumWidth / bounds.width
        (line, bounds) = make(size)
    }
    let origin = CGPoint(x: center.x - bounds.midX, y: center.y - bounds.midY)
    return PreparedLine(line: line, bounds: bounds, origin: origin)
}

let commander = prepareLine(
    "COMMANDER",
    nominalSize: 270,
    tracking: 7,
    maximumWidth: 1450,
    center: CGPoint(x: 900, y: 1510)
)
let year = prepareLine(
    "2013",
    nominalSize: 130,
    tracking: 20,
    maximumWidth: 410,
    center: CGPoint(x: 900, y: 1360)
)

let black = CGColor(srgbRed: 0.006, green: 0.008, blue: 0.014, alpha: 1)
let graphite = CGColor(srgbRed: 0.08, green: 0.085, blue: 0.095, alpha: 1)
let fineSilver = CGColor(srgbRed: 0.72, green: 0.72, blue: 0.69, alpha: 0.82)

// A feathered atmospheric shadow preserves local art and contrast without creating a band or plaque.
context.saveGState()
context.translateBy(x: 900, y: 1450)
context.scaleBy(x: 1, y: 0.22)
let atmosphericShadow = CGGradient(
    colorsSpace: colorSpace,
    colors: [
        CGColor(srgbRed: 0.008, green: 0.01, blue: 0.018, alpha: 0.54),
        CGColor(srgbRed: 0.008, green: 0.01, blue: 0.018, alpha: 0.26),
        CGColor(srgbRed: 0.008, green: 0.01, blue: 0.018, alpha: 0)
    ] as CFArray,
    locations: [0, 0.58, 1]
)!
context.drawRadialGradient(
    atmosphericShadow,
    startCenter: .zero,
    startRadius: 0,
    endCenter: .zero,
    endRadius: 880,
    options: [.drawsAfterEndLocation]
)
context.restoreGState()

func drawEnergyLine(from start: CGPoint, to end: CGPoint, colors: [CGColor], locations: [CGFloat]) {
    let glowGradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)!
    context.saveGState()
    context.setShadow(offset: .zero, blur: 8, color: colors[colors.count / 2])
    let path = CGMutablePath()
    path.move(to: start)
    path.addCurve(
        to: end,
        control1: CGPoint(x: start.x + (end.x - start.x) * 0.36, y: start.y + 3),
        control2: CGPoint(x: start.x + (end.x - start.x) * 0.72, y: end.y - 3)
    )
    context.addPath(path)
    context.replacePathWithStrokedPath()
    context.clip()
    context.drawLinearGradient(glowGradient, start: start, end: end, options: [])
    context.restoreGState()
}

drawEnergyLine(
    from: CGPoint(x: 285, y: 1360),
    to: CGPoint(x: 675, y: 1360),
    colors: [
        CGColor(srgbRed: 0.18, green: 0.55, blue: 0.80, alpha: 0),
        CGColor(srgbRed: 0.34, green: 0.72, blue: 0.94, alpha: 0.74),
        CGColor(srgbRed: 0.72, green: 0.85, blue: 0.90, alpha: 0.28)
    ],
    locations: [0, 0.73, 1]
)
drawEnergyLine(
    from: CGPoint(x: 1125, y: 1360),
    to: CGPoint(x: 1515, y: 1360),
    colors: [
        CGColor(srgbRed: 0.92, green: 0.70, blue: 0.70, alpha: 0.25),
        CGColor(srgbRed: 0.77, green: 0.18, blue: 0.24, alpha: 0.68),
        CGColor(srgbRed: 0.55, green: 0.10, blue: 0.16, alpha: 0)
    ],
    locations: [0, 0.27, 1]
)

func drawLine(
    _ prepared: PreparedLine,
    at origin: CGPoint? = nil,
    mode: CGTextDrawingMode,
    lineWidth: CGFloat,
    fill: CGColor,
    stroke: CGColor,
    shadow: (CGSize, CGFloat, CGColor)? = nil
) {
    context.saveGState()
    if let shadow {
        context.setShadow(offset: shadow.0, blur: shadow.1, color: shadow.2)
    }
    context.setTextDrawingMode(mode)
    context.setLineJoin(.round)
    context.setLineWidth(lineWidth)
    context.setFillColor(fill)
    context.setStrokeColor(stroke)
    context.textPosition = origin ?? prepared.origin
    CTLineDraw(prepared.line, context)
    context.restoreGState()
}

func drawOpenSilverTitle(_ prepared: PreparedLine, outlineWidth: CGFloat) {
    drawLine(
        prepared,
        at: CGPoint(x: prepared.origin.x, y: prepared.origin.y - 3),
        mode: .fillStroke,
        lineWidth: outlineWidth + 2,
        fill: CGColor(srgbRed: 0.03, green: 0.035, blue: 0.05, alpha: 0.88),
        stroke: CGColor(srgbRed: 0.005, green: 0.007, blue: 0.012, alpha: 0.92),
        shadow: (CGSize(width: 0, height: -3), 10, CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.72))
    )
    drawLine(
        prepared,
        mode: .fillStroke,
        lineWidth: outlineWidth,
        fill: graphite,
        stroke: graphite
    )

    context.saveGState()
    context.setTextDrawingMode(.clip)
    context.setFillColor(CGColor(gray: 1, alpha: 1))
    context.textPosition = prepared.origin
    CTLineDraw(prepared.line, context)
    let titleGradient = CGGradient(
        colorsSpace: colorSpace,
        colors: [
            CGColor(srgbRed: 0.94, green: 0.94, blue: 0.91, alpha: 1),
            CGColor(srgbRed: 0.82, green: 0.82, blue: 0.81, alpha: 1),
            CGColor(srgbRed: 0.70, green: 0.71, blue: 0.72, alpha: 1)
        ] as CFArray,
        locations: [0, 0.58, 1]
    )!
    context.drawLinearGradient(
        titleGradient,
        start: CGPoint(x: 900, y: prepared.origin.y + prepared.bounds.maxY),
        end: CGPoint(x: 900, y: prepared.origin.y + prepared.bounds.minY),
        options: []
    )
    context.restoreGState()

    drawLine(
        prepared,
        mode: .stroke,
        lineWidth: 1.3,
        fill: fineSilver,
        stroke: fineSilver
    )
}

drawOpenSilverTitle(commander, outlineWidth: 5.0)
drawOpenSilverTitle(year, outlineWidth: 4.0)

guard let outputImage = context.makeImage() else {
    fail("Could not render the output image.")
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

print("Wrote \(outputPath) with exact open title COMMANDER / 2013.")
