#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let canvasWidth = 1800
private let canvasHeight = 2100
private let outputDPI = 600

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 4 else {
    fail("Usage: build_commander_legends_typography_alternate_v1.swift POSTER_PAGE1_600DPI.png OFFICIAL_WORDMARK.png OUTPUT.png")
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

guard poster.width == 5100, poster.height == 6600 else {
    fail("Expected the retained 5100 x 6600 official poster raster; found \(poster.width) x \(poster.height).")
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
    fail("Could not create the output canvas.")
}

context.interpolationQuality = .high

// Use the full-width Jeska illustration from the official poster, stopping
// before its original navy title panel. This preserves the complete Magic
// mark, both weapons, Jeska's face and clothing, and the storm-lit red/navy
// palette while allowing the art to fill the exact 6:7 drawer-face canvas.
let artRect = CGRect(x: 0, y: 0, width: 5100, height: 5000)
guard let officialArt = poster.cropping(to: artRect) else {
    fail("Could not crop the official Jeska illustration.")
}
context.draw(officialArt, in: CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))

// A broad feathered atmosphere gives the lockup a crisp silhouette while
// leaving Jeska's clothing, blades and red fabric visible. There is no footer,
// black rectangle, hard rule or featureless title field.
let lowerVeilColors = [
    CGColor(srgbRed: 0.020, green: 0.018, blue: 0.055, alpha: 0.46),
    CGColor(srgbRed: 0.120, green: 0.030, blue: 0.055, alpha: 0.23),
    CGColor(srgbRed: 0.040, green: 0.025, blue: 0.070, alpha: 0.00)
] as CFArray
let lowerVeilLocations: [CGFloat] = [0.0, 0.48, 1.0]
guard let lowerVeil = CGGradient(
    colorsSpace: colorSpace,
    colors: lowerVeilColors,
    locations: lowerVeilLocations
) else {
    fail("Could not create the lower atmosphere.")
}
context.drawLinearGradient(
    lowerVeil,
    start: CGPoint(x: 0, y: 70),
    end: CGPoint(x: 0, y: 980),
    options: []
)

let titleBloomColors = [
    CGColor(srgbRed: 0.018, green: 0.014, blue: 0.045, alpha: 0.74),
    CGColor(srgbRed: 0.180, green: 0.035, blue: 0.045, alpha: 0.30),
    CGColor(srgbRed: 0.220, green: 0.060, blue: 0.025, alpha: 0.00)
] as CFArray
let titleBloomLocations: [CGFloat] = [0.0, 0.50, 1.0]
guard let titleBloom = CGGradient(
    colorsSpace: colorSpace,
    colors: titleBloomColors,
    locations: titleBloomLocations
) else {
    fail("Could not create the title bloom.")
}
context.saveGState()
context.translateBy(x: 900, y: 520)
context.scaleBy(x: 915, y: 360)
context.drawRadialGradient(
    titleBloom,
    startCenter: .zero,
    startRadius: 0,
    endCenter: .zero,
    endRadius: 1,
    options: []
)
context.restoreGState()

func solidTint(_ source: CGImage, color: CGColor) -> CGImage {
    guard let tintContext = CGContext(
        data: nil,
        width: source.width,
        height: source.height,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
        fail("Could not create a wordmark tint layer.")
    }
    tintContext.draw(source, in: CGRect(x: 0, y: 0, width: source.width, height: source.height))
    tintContext.setBlendMode(.sourceIn)
    tintContext.setFillColor(color)
    tintContext.fill(CGRect(x: 0, y: 0, width: source.width, height: source.height))
    guard let image = tintContext.makeImage() else {
        fail("Could not finish a wordmark tint layer.")
    }
    return image
}

func metallicFace(_ source: CGImage) -> CGImage {
    guard let faceContext = CGContext(
        data: nil,
        width: source.width,
        height: source.height,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
        fail("Could not create the metallic wordmark layer.")
    }

    faceContext.draw(source, in: CGRect(x: 0, y: 0, width: source.width, height: source.height))
    faceContext.setBlendMode(.sourceIn)
    let colors = [
        CGColor(srgbRed: 0.29, green: 0.045, blue: 0.030, alpha: 1.0),
        CGColor(srgbRed: 0.62, green: 0.13, blue: 0.045, alpha: 1.0),
        CGColor(srgbRed: 0.88, green: 0.49, blue: 0.17, alpha: 1.0),
        CGColor(srgbRed: 1.00, green: 0.95, blue: 0.78, alpha: 1.0),
        CGColor(srgbRed: 0.70, green: 0.34, blue: 0.12, alpha: 1.0)
    ] as CFArray
    let locations: [CGFloat] = [0.0, 0.19, 0.49, 0.72, 1.0]
    guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations) else {
        fail("Could not create the metallic wordmark gradient.")
    }
    faceContext.drawLinearGradient(
        gradient,
        start: CGPoint(x: 0, y: 0),
        end: CGPoint(x: 0, y: source.height),
        options: []
    )

    // Fine warm/cool engraving scratches keep the large face from reading as
    // a flat fill. Source-atop confines every accent to the exact official
    // letter silhouettes.
    faceContext.setBlendMode(.sourceAtop)
    faceContext.setLineWidth(2.0)
    faceContext.setStrokeColor(CGColor(srgbRed: 1.0, green: 0.86, blue: 0.52, alpha: 0.26))
    let stride = 92
    var x = -source.height
    while x < source.width + source.height {
        faceContext.move(to: CGPoint(x: x, y: 0))
        faceContext.addLine(to: CGPoint(x: x + source.height, y: source.height))
        x += stride
    }
    faceContext.strokePath()
    faceContext.setLineWidth(1.5)
    faceContext.setStrokeColor(CGColor(srgbRed: 0.10, green: 0.20, blue: 0.24, alpha: 0.20))
    x = -source.height + 38
    while x < source.width + source.height {
        faceContext.move(to: CGPoint(x: x, y: 0))
        faceContext.addLine(to: CGPoint(x: x + source.height, y: source.height))
        x += stride
    }
    faceContext.strokePath()

    guard let image = faceContext.makeImage() else {
        fail("Could not finish the metallic wordmark layer.")
    }
    return image
}

let titleWidth: CGFloat = 1660
let titleHeight = titleWidth * CGFloat(wordmark.height) / CGFloat(wordmark.width)
let titleRect = CGRect(x: 70, y: 330, width: titleWidth, height: titleHeight)

let outerInk = solidTint(
    wordmark,
    color: CGColor(srgbRed: 0.018, green: 0.014, blue: 0.026, alpha: 1.0)
)
let emberRim = solidTint(
    wordmark,
    color: CGColor(srgbRed: 0.88, green: 0.20, blue: 0.055, alpha: 1.0)
)
let metalFace = metallicFace(wordmark)

// Heavy dark-and-ember edge establishes one cohesive official lockup and a
// strong drawer-scale silhouette. The repeated offset geometry is exact and
// deterministic, not a font approximation.
context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -14),
    blur: 27,
    color: CGColor(srgbRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.95)
)
context.draw(outerInk, in: titleRect)
context.restoreGState()

for radius in stride(from: 16, through: 4, by: -4) {
    for step in 0..<16 {
        let angle = CGFloat(step) * .pi / 8
        let offset = CGPoint(x: cos(angle) * CGFloat(radius), y: sin(angle) * CGFloat(radius))
        context.draw(outerInk, in: titleRect.offsetBy(dx: offset.x, dy: offset.y))
    }
}
for radius in stride(from: 7, through: 2, by: -1) {
    for step in 0..<16 {
        let angle = CGFloat(step) * .pi / 8
        let offset = CGPoint(x: cos(angle) * CGFloat(radius), y: sin(angle) * CGFloat(radius))
        context.draw(emberRim, in: titleRect.offsetBy(dx: offset.x, dy: offset.y))
    }
}

context.draw(metalFace, in: titleRect)

// A one-pixel-equivalent hot edge catches Jeska's copper lighting without
// changing or redrawing the official letterforms.
context.saveGState()
context.setAlpha(0.34)
context.setBlendMode(.screen)
context.draw(
    solidTint(wordmark, color: CGColor(srgbRed: 1.0, green: 0.68, blue: 0.24, alpha: 1.0)),
    in: titleRect.offsetBy(dx: 0, dy: 2.5)
)
context.restoreGState()

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
