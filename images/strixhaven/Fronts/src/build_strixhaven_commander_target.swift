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
    fail("Usage: build_strixhaven_commander_target.swift ART.png LOGO.png OUTPUT.png")
}

func loadImage(_ path: String) -> CGImage {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(path).")
    }
    return image
}

let art = loadImage(CommandLine.arguments[1])
let logo = loadImage(CommandLine.arguments[2])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[3])

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

// Center-crop the nearly 6:7 ImageGen portrait by less than one percent, then
// resample it to the exact print dimensions without introducing empty space.
let targetAspect = CGFloat(canvasWidth) / CGFloat(canvasHeight)
let artAspect = CGFloat(art.width) / CGFloat(art.height)
var sourceRect = CGRect(x: 0, y: 0, width: art.width, height: art.height)
if artAspect > targetAspect {
    let croppedWidth = CGFloat(art.height) * targetAspect
    sourceRect.origin.x = (CGFloat(art.width) - croppedWidth) / 2
    sourceRect.size.width = croppedWidth
} else if artAspect < targetAspect {
    let croppedHeight = CGFloat(art.width) / targetAspect
    sourceRect.origin.y = (CGFloat(art.height) - croppedHeight) / 2
    sourceRect.size.height = croppedHeight
}

guard let croppedArt = art.cropping(to: sourceRect.integral) else {
    fail("Could not crop the source art.")
}
context.draw(croppedArt, in: CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))

// Darken only the upper architecture enough to give the gold logo a clean
// silhouette while preserving visible shelves, windows, lamps, and ornament.
let gradientColors = [
    CGColor(srgbRed: 0.015, green: 0.012, blue: 0.02, alpha: 0.08),
    CGColor(srgbRed: 0.015, green: 0.012, blue: 0.02, alpha: 0.45)
] as CFArray
let gradientLocations: [CGFloat] = [0.0, 1.0]
guard let gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors, locations: gradientLocations) else {
    fail("Could not create the title gradient.")
}
context.saveGState()
context.clip(to: CGRect(x: 0, y: 1310, width: canvasWidth, height: 790))
context.drawLinearGradient(
    gradient,
    start: CGPoint(x: 0, y: 1310),
    end: CGPoint(x: 0, y: 2100),
    options: []
)
context.restoreGState()

// Official transparent Strixhaven wordmark: 100 px left/right print-safe inset.
let logoWidth: CGFloat = 1600
let logoHeight = logoWidth * CGFloat(logo.height) / CGFloat(logo.width)
let logoRect = CGRect(
    x: (CGFloat(canvasWidth) - logoWidth) / 2,
    y: CGFloat(canvasHeight) - 112 - logoHeight,
    width: logoWidth,
    height: logoHeight
)
context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -12),
    blur: 24,
    color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.95)
)
context.draw(logo, in: logoRect)
context.restoreGState()
context.draw(logo, in: logoRect)

guard let outputImage = context.makeImage() else {
    fail("Could not render the output image.")
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
