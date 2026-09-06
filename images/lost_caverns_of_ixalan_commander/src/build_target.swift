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
let logoCanvas = loadImage(CommandLine.arguments[2])
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

// The built-in output is already near 6:7. Crop only its tiny excess width,
// preserve the full vertical extension, then perform one high-quality upscale.
let requiredAspect = CGFloat(outputWidth) / CGFloat(outputHeight)
let sourceAspect = CGFloat(background.width) / CGFloat(background.height)
let cropRect: CGRect
if sourceAspect > requiredAspect {
    let cropWidth = CGFloat(Int((CGFloat(background.height) * requiredAspect).rounded()))
    cropRect = CGRect(
        x: CGFloat((background.width - Int(cropWidth)) / 2),
        y: 0,
        width: cropWidth,
        height: CGFloat(background.height)
    )
} else {
    let cropHeight = CGFloat(Int((CGFloat(background.width) / requiredAspect).rounded()))
    cropRect = CGRect(
        x: 0,
        y: CGFloat((background.height - Int(cropHeight)) / 2),
        width: CGFloat(background.width),
        height: cropHeight
    )
}

guard let croppedBackground = background.cropping(to: cropRect) else {
    fail("Could not crop the generated background.")
}

context.interpolationQuality = .high
context.draw(
    croppedBackground,
    in: CGRect(x: 0, y: 0, width: outputWidth, height: outputHeight)
)

// Preserve the detailed cavern floor while increasing contrast behind the
// official gold/red logo. The gradient is transparent by the image midpoint.
let gradientColors = [
    CGColor(srgbRed: 0.018, green: 0.010, blue: 0.030, alpha: 0.68),
    CGColor(srgbRed: 0.028, green: 0.012, blue: 0.040, alpha: 0.38),
    CGColor(srgbRed: 0.028, green: 0.012, blue: 0.040, alpha: 0.0)
] as CFArray
let gradientLocations: [CGFloat] = [0.0, 0.58, 1.0]
guard let gradient = CGGradient(
    colorsSpace: colorSpace,
    colors: gradientColors,
    locations: gradientLocations
) else {
    fail("Could not create the title vignette.")
}
context.saveGState()
context.addRect(CGRect(x: 0, y: 0, width: outputWidth, height: 1040))
context.clip()
context.drawLinearGradient(
    gradient,
    start: CGPoint(x: 0, y: 0),
    end: CGPoint(x: 0, y: 1040),
    options: []
)
context.restoreGState()

// The official article PNG places its exact English logo on a transparent
// 1920x1080 canvas. Crop to the measured visible alpha bounds so the title can
// span 80.6% of the face while ending at x=1520, where the count-seal zone starts.
let logoCropRect = CGRect(x: 2, y: 136, width: 1918, height: 800)
guard logoCanvas.width == 1920,
      logoCanvas.height == 1080,
      let logo = logoCanvas.cropping(to: logoCropRect) else {
    fail("Expected the official 1920 x 1080 set-logo canvas.")
}

let logoWidth: CGFloat = 1450
let logoHeight = logoWidth * CGFloat(logo.height) / CGFloat(logo.width)
let logoRect = CGRect(x: 70, y: 170, width: logoWidth, height: logoHeight)

context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -8),
    blur: 20,
    color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.9)
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
