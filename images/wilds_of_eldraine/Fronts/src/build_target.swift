#!/usr/bin/env swift

import CoreGraphics
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
    fail("Usage: build_target.swift BACKGROUND.png SET_LOGO.png OUTPUT.png")
}

func loadImage(_ path: String) -> CGImage {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(path).")
    }
    return image
}

let background = loadImage(CommandLine.arguments[1])
let logo = loadImage(CommandLine.arguments[2])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[3])

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

// Crop only the tiny excess width from ImageGen's near-6:7 output, preserving
// the full vertical extension, then perform one high-quality upscale.
let requiredAspect = CGFloat(outputWidth) / CGFloat(outputHeight)
let sourceAspect = CGFloat(background.width) / CGFloat(background.height)
let cropRect: CGRect
if sourceAspect > requiredAspect {
    let cropWidth = CGFloat(background.height) * requiredAspect
    cropRect = CGRect(
        x: (CGFloat(background.width) - cropWidth) / 2,
        y: 0,
        width: cropWidth,
        height: CGFloat(background.height)
    )
} else {
    let cropHeight = CGFloat(background.width) / requiredAspect
    cropRect = CGRect(
        x: 0,
        y: (CGFloat(background.height) - cropHeight) / 2,
        width: CGFloat(background.width),
        height: cropHeight
    )
}

guard let croppedBackground = background.cropping(to: cropRect.integral) else {
    fail("Could not crop the generated background.")
}

context.interpolationQuality = .high
context.draw(
    croppedBackground,
    in: CGRect(x: 0, y: 0, width: outputWidth, height: outputHeight)
)

// A transparent lower vignette preserves the artwork's detail while ensuring
// the official silver-and-gold logo reads instantly at drawer scale.
let gradientColors = [
    CGColor(srgbRed: 0.015, green: 0.012, blue: 0.035, alpha: 0.76),
    CGColor(srgbRed: 0.018, green: 0.012, blue: 0.045, alpha: 0.46),
    CGColor(srgbRed: 0.018, green: 0.012, blue: 0.045, alpha: 0.0)
] as CFArray
let gradientLocations: [CGFloat] = [0.0, 0.54, 1.0]
guard let gradient = CGGradient(
    colorsSpace: colorSpace,
    colors: gradientColors,
    locations: gradientLocations
) else {
    fail("Could not create the title vignette.")
}
context.saveGState()
context.addRect(CGRect(x: 0, y: 0, width: outputWidth, height: 1120))
context.clip()
context.drawLinearGradient(
    gradient,
    start: CGPoint(x: 0, y: 0),
    end: CGPoint(x: 0, y: 1120),
    options: []
)
context.restoreGState()

// Deliberately end at x=1520: the approved 210 px seal begins at x=1520,
// leaving the exact title completely unobscured while spanning 80.6% width.
let logoWidth: CGFloat = 1450
let logoHeight = logoWidth * CGFloat(logo.height) / CGFloat(logo.width)
let logoRect = CGRect(x: 70, y: 150, width: logoWidth, height: logoHeight)

context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -9),
    blur: 22,
    color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.86)
)
context.draw(logo, in: logoRect)
context.restoreGState()
context.draw(logo, in: logoRect)

guard let outputImage = context.makeImage() else {
    fail("Could not render the finished target.")
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
    kCGImagePropertyDPIHeight: outputDPI,
    kCGImagePropertyColorModel: kCGImagePropertyColorModelRGB
]
CGImageDestinationAddImage(destination, outputImage, properties as CFDictionary)
guard CGImageDestinationFinalize(destination) else {
    fail("Could not finish writing \(outputURL.path).")
}

print("Wrote \(outputURL.path)")
