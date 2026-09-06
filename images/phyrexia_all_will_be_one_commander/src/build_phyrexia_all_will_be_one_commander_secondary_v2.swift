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
    fail("Usage: build_phyrexia_all_will_be_one_commander_secondary_v2.swift POSTER.png SET_LOGO.png OUTPUT.png")
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
let setLogo = loadImage(CommandLine.arguments[2])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[3])

guard poster.width == 3600, poster.height == 5400 else {
    fail("Expected the retained 3600 × 5400 official poster raster; found \(poster.width) × \(poster.height).")
}
guard setLogo.width == 900, setLogo.height == 407 else {
    fail("Expected the retained 900 × 407 official transparent set logo; found \(setLogo.width) × \(setLogo.height).")
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

// Reframe the official Magali Villeneuve poster much more tightly than v1.
// This exact 6:7 crop removes the poster footer and small Magic mark, enlarges
// Elesh Norn by 20%, and makes her porcelain halo, exposed crimson anatomy,
// blade-like hand, and oil-dark cathedral fill the drawer face edge to edge.
let sourceRect = CGRect(x: 300, y: 350, width: 3000, height: 3500)
guard let croppedPoster = poster.cropping(to: sourceRect) else {
    fail("Could not crop the official poster raster.")
}
context.draw(croppedPoster, in: CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))

// A transparent oil-and-crimson atmosphere deepens the lower artwork without
// replacing it with a footer. Robes, porcelain, musculature, and architecture
// remain visible through the wordmark and continue to every edge.
let lowerColors = [
    CGColor(srgbRed: 0.018, green: 0.006, blue: 0.010, alpha: 0.46),
    CGColor(srgbRed: 0.090, green: 0.006, blue: 0.016, alpha: 0.20),
    CGColor(srgbRed: 0.025, green: 0.012, blue: 0.018, alpha: 0.00)
] as CFArray
let lowerLocations: [CGFloat] = [0.0, 0.47, 1.0]
guard let lowerVeil = CGGradient(colorsSpace: colorSpace, colors: lowerColors, locations: lowerLocations) else {
    fail("Could not create the lower oil veil.")
}
context.drawLinearGradient(
    lowerVeil,
    start: CGPoint(x: 0, y: 65),
    end: CGPoint(x: 0, y: 1110),
    options: []
)

let bloomColors = [
    CGColor(srgbRed: 0.010, green: 0.004, blue: 0.007, alpha: 0.66),
    CGColor(srgbRed: 0.120, green: 0.004, blue: 0.016, alpha: 0.30),
    CGColor(srgbRed: 0.015, green: 0.006, blue: 0.010, alpha: 0.00)
] as CFArray
let bloomLocations: [CGFloat] = [0.0, 0.44, 1.0]
guard let bloom = CGGradient(colorsSpace: colorSpace, colors: bloomColors, locations: bloomLocations) else {
    fail("Could not create the wordmark bloom.")
}
context.saveGState()
context.translateBy(x: 900, y: 610)
context.scaleBy(x: 925, y: 395)
context.drawRadialGradient(
    bloom,
    startCenter: .zero,
    startRadius: 0,
    endCenter: .zero,
    endRadius: 1,
    options: []
)
context.restoreGState()

// Restore the official high-resolution English set wordmark exactly. Its
// native bone/porcelain material, engraved inner edge, and severe Phyrexian
// letterforms provide the set identity that the generic v1 typography lacked.
// It sits fully above the lower-right count-seal zone.
let logoRect = CGRect(x: 95, y: 248, width: 1510, height: 1510 * 407 / 900)
context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -12),
    blur: 26,
    color: CGColor(srgbRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.96)
)
context.draw(setLogo, in: logoRect)
context.restoreGState()
context.draw(setLogo, in: logoRect)

// The official distribution logo omits the colon required by this drawer-face
// title. Add it deterministically in the same pale porcelain / engraved-rim
// material, immediately after PHYREXIA, so the dominant line reads exactly
// "PHYREXIA:" while leaving the official logo pixels untouched.
let colonCenters = [CGPoint(x: 1682, y: 724), CGPoint(x: 1682, y: 588)]
let colonShadow = CGColor(srgbRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.94)
let colonRim = CGColor(srgbRed: 0.36, green: 0.31, blue: 0.24, alpha: 1.0)
let colonBone = CGColor(srgbRed: 0.88, green: 0.84, blue: 0.73, alpha: 1.0)
let colonHighlight = CGColor(srgbRed: 0.98, green: 0.95, blue: 0.86, alpha: 0.92)

for center in colonCenters {
    context.saveGState()
    context.setShadow(offset: CGSize(width: 0, height: -9), blur: 17, color: colonShadow)
    context.setFillColor(colonRim)
    context.fillEllipse(in: CGRect(x: center.x - 32, y: center.y - 32, width: 64, height: 64))
    context.restoreGState()

    context.setFillColor(colonBone)
    context.fillEllipse(in: CGRect(x: center.x - 25, y: center.y - 25, width: 50, height: 50))
    context.setStrokeColor(colonHighlight)
    context.setLineWidth(3)
    context.strokeEllipse(in: CGRect(x: center.x - 22, y: center.y - 22, width: 44, height: 44))

    context.setStrokeColor(CGColor(srgbRed: 0.52, green: 0.10, blue: 0.10, alpha: 0.56))
    context.setLineWidth(2)
    context.move(to: CGPoint(x: center.x - 9, y: center.y + 15))
    context.addLine(to: CGPoint(x: center.x + 8, y: center.y - 12))
    context.strokePath()
}

guard let outputImage = context.makeImage() else {
    fail("Could not render the secondary target.")
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
