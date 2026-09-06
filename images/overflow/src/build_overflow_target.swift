#!/usr/bin/env swift

import CoreGraphics
import CoreText
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let width = 1800
private let height = 2100

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 4 else {
    fail("Usage: build_overflow_target.swift RAW.png OUTPUT.png PREVIEW.png")
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
guard source.width == 1163, source.height == 1353,
      let crop = source.cropping(to: CGRect(x: 1, y: 0, width: 1160, height: 1353)),
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
    fail("Could not prepare the Overflow canvas.")
}

context.interpolationQuality = .high
context.draw(crop, in: CGRect(x: 0, y: 0, width: width, height: height))

guard let veil = CGGradient(
    colorsSpace: colorSpace,
    colors: [
        CGColor(srgbRed: 0.015, green: 0.01, blue: 0.05, alpha: 0.0),
        CGColor(srgbRed: 0.015, green: 0.01, blue: 0.05, alpha: 0.82),
        CGColor(srgbRed: 0.015, green: 0.01, blue: 0.05, alpha: 0.82),
        CGColor(srgbRed: 0.015, green: 0.01, blue: 0.05, alpha: 0.0)
    ] as CFArray,
    locations: [0, 0.28, 0.72, 1]
) else {
    fail("Could not create the title veil.")
}
context.saveGState()
context.clip(to: CGRect(x: 0, y: 700, width: width, height: 700))
context.drawLinearGradient(
    veil,
    start: CGPoint(x: 0, y: 700),
    end: CGPoint(x: 0, y: 1400),
    options: []
)
context.restoreGState()

func line(_ fill: CGColor, stroke: CGColor, strokeWidth: CGFloat) -> (CTLine, CGRect) {
    var size: CGFloat = 400
    while size >= 250 {
        let font = CTFontCreateWithName("AvenirNextCondensed-HeavyItalic" as CFString, size, nil)
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(kCTFontAttributeName as String): font,
            NSAttributedString.Key(kCTForegroundColorAttributeName as String): fill,
            NSAttributedString.Key(kCTStrokeColorAttributeName as String): stroke,
            NSAttributedString.Key(kCTStrokeWidthAttributeName as String): strokeWidth,
            NSAttributedString.Key(kCTLigatureAttributeName as String): 0,
            NSAttributedString.Key(kCTKernAttributeName as String): 1.0
        ]
        let candidate = CTLineCreateWithAttributedString(NSAttributedString(string: "OVERFLOW", attributes: attributes))
        let bounds = CTLineGetBoundsWithOptions(candidate, [.useGlyphPathBounds])
        if bounds.width <= 1640 {
            return (candidate, bounds)
        }
        size -= 2
    }
    fail("Could not fit OVERFLOW.")
}

func draw(_ item: (CTLine, CGRect), baseline: CGFloat, dx: CGFloat = 0, dy: CGFloat = 0) {
    context.textPosition = CGPoint(
        x: (CGFloat(width) - item.1.width) / 2 - item.1.minX + dx,
        y: baseline + dy
    )
    CTLineDraw(item.0, context)
}

let shadow = line(
    CGColor(srgbRed: 0.21, green: 0.03, blue: 0.35, alpha: 1),
    stroke: CGColor(srgbRed: 0.005, green: 0.01, blue: 0.03, alpha: 1),
    strokeWidth: -7
)
draw(shadow, baseline: 890, dx: 18, dy: -22)

let rim = line(
    CGColor(srgbRed: 0.06, green: 0.78, blue: 0.92, alpha: 1),
    stroke: CGColor(srgbRed: 0.92, green: 0.36, blue: 0.75, alpha: 1),
    strokeWidth: -4
)
draw(rim, baseline: 890, dx: 7, dy: -8)

let face = line(
    CGColor(srgbRed: 0.98, green: 0.92, blue: 0.67, alpha: 1),
    stroke: CGColor(srgbRed: 0.18, green: 0.88, blue: 0.94, alpha: 1),
    strokeWidth: -2.2
)
context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -10),
    blur: 18,
    color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.9)
)
draw(face, baseline: 890)
context.restoreGState()
draw(face, baseline: 890)

guard let output = context.makeImage() else {
    fail("Could not finish the Overflow target.")
}
writePNG(output, to: CommandLine.arguments[2], dpi: 600)

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
previewContext.draw(output, in: CGRect(x: 0, y: 0, width: 300, height: 350))
guard let preview = previewContext.makeImage() else {
    fail("Could not finish the drawer preview.")
}
writePNG(preview, to: CommandLine.arguments[3], dpi: 100)
print("Wrote \(CommandLine.arguments[2])")
print("Wrote \(CommandLine.arguments[3])")
