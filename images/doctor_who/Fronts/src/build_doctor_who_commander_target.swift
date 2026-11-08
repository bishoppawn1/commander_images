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
    fail("Usage: build_doctor_who_commander_target.swift POSTER.pdf DOCTOR_WHO_TITLE.png OUTPUT.png")
}

let posterURL = URL(fileURLWithPath: CommandLine.arguments[1])
let titleURL = URL(fileURLWithPath: CommandLine.arguments[2])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[3])

guard let poster = CGPDFDocument(posterURL as CFURL),
      let posterPage = poster.page(at: 1) else {
    fail("Could not read official poster PDF at \(posterURL.path).")
}

let mediaBox = posterPage.getBoxRect(.mediaBox)
guard abs(mediaBox.width - 1728) < 0.5,
      abs(mediaBox.height - 2592) < 0.5 else {
    fail("Expected the official 1728 × 2592 pt WPN poster; found \(mediaBox.width) × \(mediaBox.height) pt.")
}

guard let titleSource = CGImageSourceCreateWithURL(titleURL as CFURL, nil),
      let title = CGImageSourceCreateImageAtIndex(titleSource, 0, nil) else {
    fail("Could not read exact official title crop at \(titleURL.path).")
}
guard title.width == 640, title.height == 155 else {
    fail("Expected the derived 640 × 155 official title crop; found \(title.width) × \(title.height).")
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
    fail("Could not create the sRGB output canvas.")
}

context.interpolationQuality = .high
context.setFillColor(CGColor(srgbRed: 0.018, green: 0.018, blue: 0.075, alpha: 1.0))
context.fill(CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))

// The official poster is 2:3. This exact 6:7 crop removes its separate top
// marketing lockup and low title/legal region while preserving the full TARDIS,
// its lamp and base, and the dense time-vortex art. Coordinates are in the PDF's
// bottom-left coordinate system. The 1440 × 1680 pt crop scales exactly 1.25×
// to the 1800 × 2100 print canvas, with no generated extension or distortion.
let artCrop = CGRect(x: 144, y: 528, width: 1440, height: 1680)
let artScale: CGFloat = 1.25
context.saveGState()
context.scaleBy(x: artScale, y: artScale)
context.translateBy(x: -artCrop.minX, y: -artCrop.minY)
context.drawPDFPage(posterPage)
context.restoreGState()

// A transparent indigo veil keeps the exact official title readable over the
// still-visible vortex and TARDIS base. Its feathered edges avoid a flat band.
let veilColors = [
    CGColor(srgbRed: 0.012, green: 0.014, blue: 0.065, alpha: 0.0),
    CGColor(srgbRed: 0.010, green: 0.012, blue: 0.055, alpha: 0.77),
    CGColor(srgbRed: 0.008, green: 0.010, blue: 0.045, alpha: 0.82),
    CGColor(srgbRed: 0.012, green: 0.016, blue: 0.070, alpha: 0.0)
] as CFArray
let veilLocations: [CGFloat] = [0.0, 0.20, 0.70, 1.0]
guard let veil = CGGradient(colorsSpace: colorSpace, colors: veilColors, locations: veilLocations) else {
    fail("Could not create the title readability veil.")
}
context.saveGState()
context.clip(to: CGRect(x: 0, y: 245, width: canvasWidth, height: 610))
context.drawLinearGradient(
    veil,
    start: CGPoint(x: 0, y: 245),
    end: CGPoint(x: 0, y: 855),
    options: []
)
context.restoreGState()

// This is the untouched BBC + DOCTOR WHO region losslessly cropped from the
// WPN two-line transparent set lockup. It spans nearly the full usable width,
// remains above the count-seal zone, and is never AI-redrawn.
let titleRect = CGRect(x: 70, y: 335, width: 1660, height: 401.953125)
context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -8),
    blur: 22,
    color: CGColor(srgbRed: 0.0, green: 0.0, blue: 0.025, alpha: 0.96)
)
context.draw(title, in: titleRect)
context.restoreGState()
context.draw(title, in: titleRect)

guard let outputImage = context.makeImage() else {
    fail("Could not render the target image.")
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
