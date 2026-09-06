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
    fail("Usage: build_official_wpn_poster_target.swift INPUT.png OUTPUT.png")
}

let inputURL = URL(fileURLWithPath: CommandLine.arguments[1])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[2])

guard let source = CGImageSourceCreateWithURL(inputURL as CFURL, nil),
      let sourceImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
    fail("Could not read \(inputURL.path).")
}

guard sourceImage.width == targetWidth, sourceImage.height >= targetHeight else {
    fail("Expected an 1800-pixel-wide source at least 2100 pixels tall; found \(sourceImage.width) × \(sourceImage.height).")
}

guard let crop = sourceImage.cropping(to: CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight)),
      let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(
        data: nil,
        width: targetWidth,
        height: targetHeight,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue
      ) else {
    fail("Could not create the crop or drawing canvas.")
}

context.interpolationQuality = .high
context.draw(crop, in: CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight))

// Coordinates below are expressed in the normal top-left image convention.
func canvasRect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CGRect {
    CGRect(x: x, y: CGFloat(targetHeight) - y - height, width: width, height: height)
}

let titlePlate = canvasRect(x: 45, y: 1490, width: 1710, height: 320)

context.saveGState()
context.setShadow(offset: CGSize(width: 0, height: -10), blur: 22, color: CGColor(gray: 0, alpha: 0.82))
let platePath = CGPath(roundedRect: titlePlate, cornerWidth: 24, cornerHeight: 24, transform: nil)
context.addPath(platePath)
context.setFillColor(CGColor(srgbRed: 0.055, green: 0.012, blue: 0.008, alpha: 0.78))
context.fillPath()
context.restoreGState()

context.addPath(CGPath(roundedRect: titlePlate, cornerWidth: 24, cornerHeight: 24, transform: nil))
context.setStrokeColor(CGColor(srgbRed: 0.86, green: 0.59, blue: 0.20, alpha: 0.92))
context.setLineWidth(5)
context.strokePath()

let innerRuleTop = canvasRect(x: 75, y: 1511, width: 1650, height: 3)
let innerRuleBottom = canvasRect(x: 75, y: 1786, width: 1650, height: 3)
context.setFillColor(CGColor(srgbRed: 0.95, green: 0.76, blue: 0.35, alpha: 0.86))
context.fill(innerRuleTop)
context.fill(innerRuleBottom)

let fillColor = CGColor(srgbRed: 1.0, green: 0.83, blue: 0.42, alpha: 1.0)
let strokeColor = CGColor(srgbRed: 0.13, green: 0.035, blue: 0.015, alpha: 1.0)

func fittedLine(_ text: String, maxFontSize: CGFloat, maxWidth: CGFloat) -> (CTLine, CGRect, CGFloat) {
    var size = maxFontSize
    while size >= 60 {
        let font = CTFontCreateWithName("Copperplate-Bold" as CFString, size, nil)
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(kCTFontAttributeName as String): font,
            NSAttributedString.Key(kCTForegroundColorAttributeName as String): fillColor,
            NSAttributedString.Key(kCTStrokeColorAttributeName as String): strokeColor,
            NSAttributedString.Key(kCTStrokeWidthAttributeName as String): -4.0,
            NSAttributedString.Key(kCTKernAttributeName as String): 0.8,
            NSAttributedString.Key(kCTLigatureAttributeName as String): 0
        ]
        let line = CTLineCreateWithAttributedString(NSAttributedString(string: text, attributes: attributes))
        let bounds = CTLineGetBoundsWithOptions(line, [.useGlyphPathBounds])
        if bounds.width <= maxWidth {
            return (line, bounds, size)
        }
        size -= 1
    }
    fail("Could not fit title line: \(text)")
}

func drawCentered(_ text: String, displayRect: CGRect, maxFontSize: CGFloat) {
    let (line, bounds, _) = fittedLine(text, maxFontSize: maxFontSize, maxWidth: displayRect.width)
    let rect = canvasRect(x: displayRect.minX, y: displayRect.minY, width: displayRect.width, height: displayRect.height)
    context.saveGState()
    context.setShadow(offset: CGSize(width: 0, height: -5), blur: 10, color: CGColor(gray: 0, alpha: 0.92))
    context.textPosition = CGPoint(
        x: rect.midX - bounds.midX,
        y: rect.midY - bounds.midY
    )
    CTLineDraw(line, context)
    context.restoreGState()
}

drawCentered(
    "THE LORD OF THE RINGS:",
    displayRect: CGRect(x: 80, y: 1528, width: 1640, height: 112),
    maxFontSize: 104
)
drawCentered(
    "TALES OF MIDDLE-EARTH",
    displayRect: CGRect(x: 80, y: 1658, width: 1640, height: 112),
    maxFontSize: 108
)

guard let outputImage = context.makeImage() else {
    fail("Could not render output image.")
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
