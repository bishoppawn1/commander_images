#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let outputWidth = 1800
private let outputHeight = 2100
private let outputDPI = 600

private let artCrop = CGRect(x: 0, y: 0, width: 2200, height: 2567)
private let wordmarkCrop = CGRect(x: 120, y: 2840, width: 1960, height: 380)

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 4 else {
    fail("Usage: build_official_wordmark_secondary_v2.swift POSTER.png WORDMARK.png TARGET.png")
}

let posterURL = URL(fileURLWithPath: CommandLine.arguments[1])
let wordmarkURL = URL(fileURLWithPath: CommandLine.arguments[2])
let targetURL = URL(fileURLWithPath: CommandLine.arguments[3])

guard let source = CGImageSourceCreateWithURL(posterURL as CFURL, nil),
      let poster = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
    fail("Could not read \(posterURL.path).")
}

guard poster.width == 2200, poster.height == 3400 else {
    fail("Expected the retained 2200 × 3400 WPN poster raster; found \(poster.width) × \(poster.height).")
}

guard let art = poster.cropping(to: artCrop),
      let titleSource = poster.cropping(to: wordmarkCrop),
      let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
    fail("Could not crop the retained poster or create an sRGB color space.")
}

func rgbaPixels(from image: CGImage) -> [UInt8] {
    let width = image.width
    let height = image.height
    let bytesPerRow = width * 4
    var pixels = [UInt8](repeating: 0, count: bytesPerRow * height)

    let rendered = pixels.withUnsafeMutableBytes { rawBuffer -> Bool in
        guard let address = rawBuffer.baseAddress,
              let context = CGContext(
                data: address,
                width: width,
                height: height,
                bitsPerComponent: 8,
                bytesPerRow: bytesPerRow,
                space: colorSpace,
                bitmapInfo: CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
              ) else {
            return false
        }
        context.interpolationQuality = .none
        context.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
        return true
    }

    guard rendered else { fail("Could not rasterize the official title crop.") }
    return pixels
}

func imageFromRGBA(_ pixels: [UInt8], width: Int, height: Int) -> CGImage {
    let data = Data(pixels)
    guard let provider = CGDataProvider(data: data as CFData),
          let image = CGImage(
            width: width,
            height: height,
            bitsPerComponent: 8,
            bitsPerPixel: 32,
            bytesPerRow: width * 4,
            space: colorSpace,
            bitmapInfo: CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue),
            provider: provider,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
          ) else {
        fail("Could not create the transparent official wordmark image.")
    }
    return image
}

// The retained poster prints the AFR title in clean neutral white over dark blue
// dragon scales. A channel-floor threshold isolates the genuine glyph pixels,
// including antialiased edges, while excluding the colored scale field. The crop
// intentionally excludes the red D&D logo and the small copyright line.
let titleWidth = titleSource.width
let titleHeight = titleSource.height
let sourcePixels = rgbaPixels(from: titleSource)
var wordmarkPixels = [UInt8](repeating: 0, count: sourcePixels.count)

for pixel in 0..<(titleWidth * titleHeight) {
    let offset = pixel * 4
    let red = Int(sourcePixels[offset])
    let green = Int(sourcePixels[offset + 1])
    let blue = Int(sourcePixels[offset + 2])
    let neutralFloor = min(red, min(green, blue))

    // Smooth threshold: dark scale texture remains transparent; white letter
    // interiors stay fully opaque and the source antialiasing is retained.
    let alpha: Int
    if neutralFloor <= 104 {
        alpha = 0
    } else if neutralFloor >= 210 {
        alpha = 255
    } else {
        let normalized = Double(neutralFloor - 104) / 106.0
        let eased = normalized * normalized * (3.0 - 2.0 * normalized)
        alpha = Int((eased * 255.0).rounded())
    }

    // Premultiplied neutral-white supporting asset.
    wordmarkPixels[offset] = UInt8(alpha)
    wordmarkPixels[offset + 1] = UInt8(alpha)
    wordmarkPixels[offset + 2] = UInt8(alpha)
    wordmarkPixels[offset + 3] = UInt8(alpha)
}

let wordmark = imageFromRGBA(wordmarkPixels, width: titleWidth, height: titleHeight)

func writePNG(_ image: CGImage, to url: URL, dpi: Int?) {
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
        fail("Could not create \(url.path).")
    }

    var properties: [CFString: Any] = [:]
    if let dpi {
        properties[kCGImagePropertyDPIWidth] = dpi
        properties[kCGImagePropertyDPIHeight] = dpi
    }
    CGImageDestinationAddImage(destination, image, properties as CFDictionary)
    guard CGImageDestinationFinalize(destination) else {
        fail("Could not finish writing \(url.path).")
    }
}

writePNG(wordmark, to: wordmarkURL, dpi: nil)

guard let context = CGContext(
    data: nil,
    width: outputWidth,
    height: outputHeight,
    bitsPerComponent: 8,
    bytesPerRow: 0,
    space: colorSpace,
    bitmapInfo: CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
) else {
    fail("Could not create the print-target drawing canvas.")
}

context.interpolationQuality = .high
context.setAllowsAntialiasing(true)
context.setShouldAntialias(true)
context.draw(art, in: CGRect(x: 0, y: 0, width: outputWidth, height: outputHeight))

// Convert normal top-left image coordinates to the Core Graphics canvas.
func canvasRect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CGRect {
    CGRect(x: x, y: CGFloat(outputHeight) - y - height, width: width, height: height)
}

// The title sits over a localized translucent vignette rather than an opaque
// footer. The key-art color and texture remain visible above, below, and between
// every line of the lockup.
let scrim = canvasRect(x: 0, y: 1370, width: 1800, height: 520)
let scrimColors = [
    CGColor(srgbRed: 0.025, green: 0.012, blue: 0.020, alpha: 0.00),
    CGColor(srgbRed: 0.025, green: 0.012, blue: 0.020, alpha: 0.30),
    CGColor(srgbRed: 0.025, green: 0.012, blue: 0.020, alpha: 0.38),
    CGColor(srgbRed: 0.025, green: 0.012, blue: 0.020, alpha: 0.18),
    CGColor(srgbRed: 0.025, green: 0.012, blue: 0.020, alpha: 0.00)
] as CFArray
let scrimLocations: [CGFloat] = [0.0, 0.20, 0.50, 0.82, 1.0]
guard let scrimGradient = CGGradient(
    colorsSpace: colorSpace,
    colors: scrimColors,
    locations: scrimLocations
) else {
    fail("Could not create the localized title scrim.")
}
context.saveGState()
context.clip(to: scrim)
context.drawLinearGradient(
    scrimGradient,
    start: CGPoint(x: scrim.midX, y: scrim.maxY),
    end: CGPoint(x: scrim.midX, y: scrim.minY),
    options: []
)
context.restoreGState()

let titleRect = canvasRect(x: 70, y: 1468, width: 1660, height: 322)

func fillWordmark(in rect: CGRect, color: CGColor) {
    context.saveGState()
    context.clip(to: rect, mask: wordmark)
    context.setFillColor(color)
    context.fill(rect)
    context.restoreGState()
}

// Broad dark silhouette establishes a clean, fantasy-poster edge without a box.
let outlineInk = CGColor(srgbRed: 0.018, green: 0.012, blue: 0.018, alpha: 0.96)
context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -7),
    blur: 13,
    color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.88)
)
for step in 0..<24 {
    let angle = Double(step) * 2.0 * Double.pi / 24.0
    let offsetX = CGFloat(cos(angle)) * 9.0
    let offsetY = CGFloat(sin(angle)) * 9.0
    fillWordmark(in: titleRect.offsetBy(dx: offsetX, dy: offsetY), color: outlineInk)
}
context.restoreGState()

// Antique-stone face: the actual WPN title contours are unchanged. The restrained
// warm gradient harmonizes them with firelight and armor at drawer scale.
let titleColors = [
    CGColor(srgbRed: 1.00, green: 0.96, blue: 0.79, alpha: 1.0),
    CGColor(srgbRed: 0.92, green: 0.77, blue: 0.43, alpha: 1.0),
    CGColor(srgbRed: 0.99, green: 0.92, blue: 0.68, alpha: 1.0),
    CGColor(srgbRed: 0.72, green: 0.50, blue: 0.23, alpha: 1.0)
] as CFArray
let titleLocations: [CGFloat] = [0.0, 0.28, 0.58, 1.0]
guard let titleGradient = CGGradient(
    colorsSpace: colorSpace,
    colors: titleColors,
    locations: titleLocations
) else {
    fail("Could not create the antique-stone title gradient.")
}
context.saveGState()
context.clip(to: titleRect, mask: wordmark)
context.drawLinearGradient(
    titleGradient,
    start: CGPoint(x: titleRect.midX, y: titleRect.maxY),
    end: CGPoint(x: titleRect.midX, y: titleRect.minY),
    options: []
)

// Deterministic, very light pitting gives the title a weathered stone/metal face
// while preserving a crisp silhouette and large clear counters.
var state: UInt64 = 0xAF_21_F0_4D
func nextUnit() -> CGFloat {
    state = state &* 6364136223846793005 &+ 1442695040888963407
    return CGFloat((state >> 33) & 0x7FFF_FFFF) / CGFloat(0x7FFF_FFFF)
}
context.setFillColor(CGColor(srgbRed: 0.16, green: 0.08, blue: 0.025, alpha: 0.12))
for _ in 0..<560 {
    let x = titleRect.minX + nextUnit() * titleRect.width
    let y = titleRect.minY + nextUnit() * titleRect.height
    let size = 0.8 + nextUnit() * 2.4
    context.fillEllipse(in: CGRect(x: x, y: y, width: size * 1.7, height: size))
}
context.restoreGState()

guard let output = context.makeImage() else {
    fail("Could not render the v2 target.")
}
writePNG(output, to: targetURL, dpi: outputDPI)

print("Wrote \(wordmarkURL.path)")
print("Wrote \(targetURL.path)")
