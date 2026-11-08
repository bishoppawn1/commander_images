#!/usr/bin/env swift

import CoreGraphics
import CoreText
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let width = 1800
private let height = 2100
private let dpi = 600

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 4 else {
    fail("Usage: build_turtle_power_target.swift OFFICIAL_PORTRAIT.jpg OUTPUT.png PREVIEW.png")
}

func loadImage(_ path: String) -> CGImage {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(path).")
    }
    return image
}

func writePNG(_ image: CGImage, to path: String, dpi: Int) {
    let url = URL(fileURLWithPath: path)
    try? FileManager.default.createDirectory(
        at: url.deletingLastPathComponent(),
        withIntermediateDirectories: true
    )
    guard let destination = CGImageDestinationCreateWithURL(
        url as CFURL,
        UTType.png.identifier as CFString,
        1,
        nil
    ) else {
        fail("Could not create \(path).")
    }
    let properties: [CFString: Any] = [
        kCGImagePropertyDPIWidth: dpi,
        kCGImagePropertyDPIHeight: dpi
    ]
    CGImageDestinationAddImage(destination, image, properties as CFDictionary)
    guard CGImageDestinationFinalize(destination) else {
        fail("Could not finish \(path).")
    }
}

let source = loadImage(CommandLine.arguments[1])
guard source.width == 1080, source.height == 1920 else {
    fail("Expected the retained official WPN portrait at 1080 × 1920.")
}

guard let crop = source.cropping(to: CGRect(x: 0, y: 640, width: 1080, height: 1260)),
      let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(
        data: nil,
        width: width,
        height: height,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
      ) else {
    fail("Could not prepare the Turtle Power canvas.")
}

context.interpolationQuality = .high
context.draw(crop, in: CGRect(x: 0, y: 0, width: width, height: height))

guard let topVeil = CGGradient(
    colorsSpace: colorSpace,
    colors: [
        CGColor(srgbRed: 0.015, green: 0.025, blue: 0.055, alpha: 0.96),
        CGColor(srgbRed: 0.04, green: 0.02, blue: 0.09, alpha: 0.72),
        CGColor(srgbRed: 0.04, green: 0.02, blue: 0.09, alpha: 0.0)
    ] as CFArray,
    locations: [0, 0.48, 1]
) else {
    fail("Could not create the title veil.")
}
context.saveGState()
context.clip(to: CGRect(x: 0, y: 1540, width: width, height: 560))
context.drawLinearGradient(
    topVeil,
    start: CGPoint(x: 0, y: 2100),
    end: CGPoint(x: 0, y: 1540),
    options: []
)
context.restoreGState()

guard let bottomVeil = CGGradient(
    colorsSpace: colorSpace,
    colors: [
        CGColor(srgbRed: 0.01, green: 0.015, blue: 0.035, alpha: 0.78),
        CGColor(srgbRed: 0.01, green: 0.015, blue: 0.035, alpha: 0.0)
    ] as CFArray,
    locations: [0, 1]
) else {
    fail("Could not create the lower veil.")
}
context.saveGState()
context.clip(to: CGRect(x: 0, y: 0, width: width, height: 430))
context.drawLinearGradient(
    bottomVeil,
    start: CGPoint(x: 0, y: 0),
    end: CGPoint(x: 0, y: 430),
    options: []
)
context.restoreGState()

func fittedLine(
    _ text: String,
    fontName: String,
    maximumSize: CGFloat,
    minimumSize: CGFloat,
    maximumWidth: CGFloat,
    fill: CGColor,
    stroke: CGColor,
    strokeWidth: CGFloat
) -> (CTLine, CGRect) {
    var size = maximumSize
    while size >= minimumSize {
        let font = CTFontCreateWithName(fontName as CFString, size, nil)
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(kCTFontAttributeName as String): font,
            NSAttributedString.Key(kCTForegroundColorAttributeName as String): fill,
            NSAttributedString.Key(kCTStrokeColorAttributeName as String): stroke,
            NSAttributedString.Key(kCTStrokeWidthAttributeName as String): strokeWidth,
            NSAttributedString.Key(kCTLigatureAttributeName as String): 0,
            NSAttributedString.Key(kCTKernAttributeName as String): -1.0
        ]
        let line = CTLineCreateWithAttributedString(NSAttributedString(string: text, attributes: attributes))
        let bounds = CTLineGetBoundsWithOptions(line, [.useGlyphPathBounds])
        if bounds.width <= maximumWidth {
            return (line, bounds)
        }
        size -= 2
    }
    fail("Could not fit title text.")
}

func drawCentered(_ line: CTLine, bounds: CGRect, baseline: CGFloat, dx: CGFloat = 0, dy: CGFloat = 0) {
    context.textPosition = CGPoint(
        x: (CGFloat(width) - bounds.width) / 2 - bounds.minX + dx,
        y: baseline + dy
    )
    CTLineDraw(line, context)
}

let shadowLine = fittedLine(
    "TURTLE POWER!",
    fontName: "Futura-CondensedExtraBold",
    maximumSize: 292,
    minimumSize: 180,
    maximumWidth: 1620,
    fill: CGColor(srgbRed: 0.33, green: 0.08, blue: 0.46, alpha: 1),
    stroke: CGColor(srgbRed: 0.005, green: 0.01, blue: 0.02, alpha: 1),
    strokeWidth: -7
)
drawCentered(shadowLine.0, bounds: shadowLine.1, baseline: 1780, dx: 15, dy: -18)

let titleLine = fittedLine(
    "TURTLE POWER!",
    fontName: "Futura-CondensedExtraBold",
    maximumSize: 292,
    minimumSize: 180,
    maximumWidth: 1620,
    fill: CGColor(srgbRed: 0.48, green: 0.82, blue: 0.14, alpha: 1),
    stroke: CGColor(srgbRed: 1.0, green: 0.55, blue: 0.08, alpha: 1),
    strokeWidth: -3.2
)
context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -9),
    blur: 14,
    color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.85)
)
drawCentered(titleLine.0, bounds: titleLine.1, baseline: 1780)
context.restoreGState()
drawCentered(titleLine.0, bounds: titleLine.1, baseline: 1780)

let subtitle = fittedLine(
    "COMMANDER DECK",
    fontName: "AvenirNextCondensed-Heavy",
    maximumSize: 82,
    minimumSize: 62,
    maximumWidth: 760,
    fill: CGColor(srgbRed: 0.98, green: 0.97, blue: 0.84, alpha: 1),
    stroke: CGColor(srgbRed: 0.015, green: 0.02, blue: 0.04, alpha: 1),
    strokeWidth: -4
)
drawCentered(subtitle.0, bounds: subtitle.1, baseline: 1662)

guard let outputImage = context.makeImage() else {
    fail("Could not finish the Turtle Power target.")
}
writePNG(outputImage, to: CommandLine.arguments[2], dpi: dpi)

guard let previewContext = CGContext(
    data: nil,
    width: 300,
    height: 350,
    bitsPerComponent: 8,
    bytesPerRow: 0,
    space: colorSpace,
    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
) else {
    fail("Could not create the drawer preview.")
}
previewContext.interpolationQuality = .high
previewContext.draw(outputImage, in: CGRect(x: 0, y: 0, width: 300, height: 350))
guard let preview = previewContext.makeImage() else {
    fail("Could not finish the drawer preview.")
}
writePNG(preview, to: CommandLine.arguments[3], dpi: 100)
print("Wrote \(CommandLine.arguments[2])")
print("Wrote \(CommandLine.arguments[3])")
