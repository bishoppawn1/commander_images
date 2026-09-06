#!/usr/bin/env swift

import CoreGraphics
import CoreText
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let outputDPI = 600
private let markerDiameter: CGFloat = 210
private let rightBoundaryInset: CGFloat = 70
private let bottomBoundaryInset: CGFloat = 70
private let rimWidth: CGFloat = 11
private let fontSize: CGFloat = 143

struct Marker {
    let count: String
    let rightBoundary: CGFloat
    let bottomBoundaryFromTop: CGFloat
}

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count >= 4 else {
    fail("Usage: apply_deck_count.swift INPUT.png OUTPUT.png COUNT:RIGHT_BOUNDARY[:BOTTOM_BOUNDARY_FROM_TOP] [COUNT:RIGHT_BOUNDARY[:BOTTOM_BOUNDARY_FROM_TOP] ...]")
}

let inputPath = CommandLine.arguments[1]
let outputPath = CommandLine.arguments[2]

guard URL(fileURLWithPath: inputPath).standardizedFileURL != URL(fileURLWithPath: outputPath).standardizedFileURL else {
    fail("Input and output must be different files; base targets are never overwritten.")
}

let markers: [Marker] = CommandLine.arguments.dropFirst(3).map { specification in
    let parts = specification.split(separator: ":", maxSplits: 2)
    guard (parts.count == 2 || parts.count == 3),
          !parts[0].isEmpty,
          let boundary = Double(parts[1]),
          boundary > 0,
          let bottomBoundary = parts.count == 3 ? Double(parts[2]) : 2100,
          bottomBoundary > 0 else {
        fail("Invalid marker '\(specification)'; expected COUNT:RIGHT_BOUNDARY[:BOTTOM_BOUNDARY_FROM_TOP].")
    }
    return Marker(
        count: String(parts[0]),
        rightBoundary: CGFloat(boundary),
        bottomBoundaryFromTop: CGFloat(bottomBoundary)
    )
}

let inputURL = URL(fileURLWithPath: inputPath)
guard let source = CGImageSourceCreateWithURL(inputURL as CFURL, nil),
      let sourceImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
    fail("Could not read \(inputPath).")
}

let width = sourceImage.width
let height = sourceImage.height
guard width == 1800, height == 2100 else {
    fail("Expected an 1800 × 2100 print target; found \(width) × \(height).")
}

for marker in markers where marker.rightBoundary > CGFloat(width) {
    fail("Marker boundary \(marker.rightBoundary) exceeds the image width \(width).")
}
for marker in markers where marker.bottomBoundaryFromTop > CGFloat(height) {
    fail("Marker bottom boundary \(marker.bottomBoundaryFromTop) exceeds the image height \(height).")
}

guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(
        data: nil,
        width: width,
        height: height,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
      ) else {
    fail("Could not create the drawing canvas.")
}

context.interpolationQuality = .high
context.draw(sourceImage, in: CGRect(x: 0, y: 0, width: width, height: height))

let gold = CGColor(srgbRed: 0.83, green: 0.63, blue: 0.27, alpha: 1.0)
let darkSeal = CGColor(srgbRed: 0.035, green: 0.045, blue: 0.055, alpha: 0.91)
let ivory = CGColor(srgbRed: 0.98, green: 0.94, blue: 0.77, alpha: 1.0)
let textOutline = CGColor(srgbRed: 0.06, green: 0.04, blue: 0.02, alpha: 1.0)
let shadow = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.72)

let font = CTFontCreateWithName("Copperplate-Bold" as CFString, fontSize, nil)

for marker in markers {
    let radius = markerDiameter / 2
    let center = CGPoint(
        x: marker.rightBoundary - rightBoundaryInset - radius,
        y: CGFloat(height) - marker.bottomBoundaryFromTop + bottomBoundaryInset + radius
    )
    let sealRect = CGRect(
        x: center.x - radius,
        y: center.y - radius,
        width: markerDiameter,
        height: markerDiameter
    )

    context.saveGState()
    context.setShadow(offset: CGSize(width: 0, height: -7), blur: 13, color: shadow)
    context.setFillColor(gold)
    context.fillEllipse(in: sealRect)
    context.restoreGState()

    context.setFillColor(gold)
    context.fillEllipse(in: sealRect)
    context.setFillColor(darkSeal)
    context.fillEllipse(in: sealRect.insetBy(dx: rimWidth, dy: rimWidth))

    let attributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key(kCTFontAttributeName as String): font,
        NSAttributedString.Key(kCTForegroundColorAttributeName as String): ivory,
        NSAttributedString.Key(kCTStrokeColorAttributeName as String): textOutline,
        NSAttributedString.Key(kCTStrokeWidthAttributeName as String): -3.0,
        NSAttributedString.Key(kCTLigatureAttributeName as String): 0
    ]
    let attributedCount = NSAttributedString(string: marker.count, attributes: attributes)
    let line = CTLineCreateWithAttributedString(attributedCount)
    let bounds = CTLineGetBoundsWithOptions(line, [.useGlyphPathBounds])
    context.textPosition = CGPoint(
        x: center.x - bounds.midX,
        y: center.y - bounds.midY - 4
    )
    CTLineDraw(line, context)
}

guard let outputImage = context.makeImage() else {
    fail("Could not render the output image.")
}

let outputURL = URL(fileURLWithPath: outputPath)
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

print("Wrote \(outputPath)")
