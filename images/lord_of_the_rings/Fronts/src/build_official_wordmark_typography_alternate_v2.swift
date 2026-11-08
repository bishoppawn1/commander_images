#!/usr/bin/env swift

import CoreGraphics
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

guard CommandLine.arguments.count == 4 else {
    fail("Usage: build_official_wordmark_typography_alternate_v2.swift POSTER.png WORDMARK.png OUTPUT.png")
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
let wordmark = loadImage(CommandLine.arguments[2])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[3])

guard poster.width == targetWidth, poster.height >= targetHeight else {
    fail("Expected an 1800-pixel-wide poster at least 2100 pixels tall; found \(poster.width) × \(poster.height).")
}

guard wordmark.width == 601, wordmark.height == 209 else {
    fail("Expected the retained official title-only wordmark crop at 601 × 209; found \(wordmark.width) × \(wordmark.height).")
}

guard let posterCrop = poster.cropping(to: CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight)),
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
    fail("Could not create the poster crop or output canvas.")
}

context.interpolationQuality = .high
context.draw(posterCrop, in: CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight))

// All layout values below use the normal top-left image coordinate convention.
func canvasRect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CGRect {
    CGRect(x: x, y: CGFloat(targetHeight) - y - height, width: width, height: height)
}

func canvasPoint(x: CGFloat, y: CGFloat) -> CGPoint {
    CGPoint(x: x, y: CGFloat(targetHeight) - y)
}

// A soft, edge-fading ember/smoke veil replaces the prior hard modern plaque.
// It preserves the official artwork and only quiets the mountains immediately
// behind the fine strokes of the licensed wordmark.
let veilColors: [CGColor] = [
    CGColor(srgbRed: 0.028, green: 0.009, blue: 0.006, alpha: 0.86),
    CGColor(srgbRed: 0.070, green: 0.014, blue: 0.009, alpha: 0.73),
    CGColor(srgbRed: 0.20, green: 0.030, blue: 0.012, alpha: 0.34),
    CGColor(srgbRed: 0.18, green: 0.020, blue: 0.008, alpha: 0.0)
]
let veilLocations: [CGFloat] = [0.0, 0.48, 0.77, 1.0]
guard let veilGradient = CGGradient(
    colorsSpace: colorSpace,
    colors: veilColors as CFArray,
    locations: veilLocations
) else {
    fail("Could not create the atmospheric title gradient.")
}

context.saveGState()
let veilCenter = canvasPoint(x: 750, y: 1605)
context.translateBy(x: veilCenter.x, y: veilCenter.y)
context.scaleBy(x: 1.0, y: 0.39)
context.drawRadialGradient(
    veilGradient,
    startCenter: .zero,
    startRadius: 0,
    endCenter: .zero,
    endRadius: 845,
    options: []
)
context.restoreGState()

// Retained official English set-title wordmark, extracted unchanged from
// MTGLTR_EN_SetLogo_LockUp.png. The 1500-pixel width uses almost the full
// print-safe span while the compact lower line remains clear of the count seal.
let wordmarkWidth: CGFloat = 1500
let wordmarkHeight = wordmarkWidth * CGFloat(wordmark.height) / CGFloat(wordmark.width)
let wordmarkDisplayRect = CGRect(x: 30, y: 1320, width: wordmarkWidth, height: wordmarkHeight)

context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -7),
    blur: 17,
    color: CGColor(srgbRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.88)
)
context.draw(
    wordmark,
    in: canvasRect(
        x: wordmarkDisplayRect.minX,
        y: wordmarkDisplayRect.minY,
        width: wordmarkDisplayRect.width,
        height: wordmarkDisplayRect.height
    )
)
context.restoreGState()

// The supplied licensed artwork already contains the canonical hyphen in
// MIDDLE-EARTH. Its stylized main line omits the colon, so append one as two
// compact jewel-like stops using the wordmark's ivory/gold/oxide materials.
func drawColonStop(center displayCenter: CGPoint) {
    let outerRect = canvasRect(
        x: displayCenter.x - 14,
        y: displayCenter.y - 14,
        width: 28,
        height: 28
    )
    let innerRect = outerRect.insetBy(dx: 5, dy: 5)

    context.saveGState()
    context.setShadow(
        offset: CGSize(width: 4, height: -5),
        blur: 7,
        color: CGColor(srgbRed: 0.20, green: 0.018, blue: 0.010, alpha: 0.95)
    )
    context.setFillColor(CGColor(srgbRed: 0.83, green: 0.31, blue: 0.10, alpha: 1.0))
    context.fillEllipse(in: outerRect)
    context.restoreGState()

    context.setFillColor(CGColor(srgbRed: 0.99, green: 0.91, blue: 0.66, alpha: 1.0))
    context.fillEllipse(in: innerRect)
    context.setStrokeColor(CGColor(srgbRed: 0.96, green: 0.63, blue: 0.20, alpha: 1.0))
    context.setLineWidth(3)
    context.strokeEllipse(in: outerRect.insetBy(dx: 1.5, dy: 1.5))
}

drawColonStop(center: CGPoint(x: 1552, y: 1555))
drawColonStop(center: CGPoint(x: 1552, y: 1640))

guard let outputImage = context.makeImage() else {
    fail("Could not render the alternate target.")
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
