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
    fail("Usage: build_commander_masters_target.swift POSTER_RENDER.png OFFICIAL_LOGO.png OUTPUT.png")
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
let logo = loadImage(CommandLine.arguments[2])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[3])

guard poster.width == 3600, poster.height == 5400 else {
    fail("Expected the retained 150-DPI poster raster at 3600 x 5400; found \(poster.width) x \(poster.height).")
}
guard logo.width == 900, logo.height == 407 else {
    fail("Expected the retained official logo at 900 x 407; found \(logo.width) x \(logo.height).")
}

guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(
        data: nil,
        width: targetWidth,
        height: targetHeight,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
      ) else {
    fail("Could not create the sRGB output canvas.")
}

context.interpolationQuality = .high

// The poster's upper 3600 x 4200 pixels are exactly 6:7. This crop retains the
// complete dragon focal image and Magic mark while ending just before the
// poster's low integrated title, which would collide with the deck-count seal.
guard let artCrop = poster.cropping(to: CGRect(x: 0, y: 0, width: 3600, height: 4200)) else {
    fail("Could not crop the official WPN poster raster.")
}
context.draw(artCrop, in: CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight))

// Add an edge-fading lower vignette for clean title contrast without creating
// a footer, panel, or featureless band. The official art remains visible.
let vignetteColors = [
    CGColor(srgbRed: 0.015, green: 0.020, blue: 0.010, alpha: 0.62),
    CGColor(srgbRed: 0.015, green: 0.025, blue: 0.012, alpha: 0.40),
    CGColor(srgbRed: 0.015, green: 0.030, blue: 0.015, alpha: 0.0)
] as CFArray
let vignetteLocations: [CGFloat] = [0.0, 0.48, 1.0]
guard let vignette = CGGradient(
    colorsSpace: colorSpace,
    colors: vignetteColors,
    locations: vignetteLocations
) else {
    fail("Could not create the title-support vignette.")
}
context.drawLinearGradient(
    vignette,
    start: CGPoint(x: 0, y: 0),
    end: CGPoint(x: 0, y: 1050),
    options: []
)

// Crop only transparent padding from Wizards' exact English COMMANDER MASTERS
// wordmark. No lettering, spacing, color, outline, or extrusion is redrawn.
guard let croppedLogo = logo.cropping(to: CGRect(x: 90, y: 92, width: 721, height: 220)) else {
    fail("Could not crop the transparent padding from the official wordmark.")
}
let logoRect = CGRect(x: 45, y: 378, width: 1710, height: 522)

context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -13),
    blur: 20,
    color: CGColor(srgbRed: 0.01, green: 0.01, blue: 0.01, alpha: 0.78)
)
context.draw(croppedLogo, in: logoRect)
context.restoreGState()
context.draw(croppedLogo, in: logoRect)

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
