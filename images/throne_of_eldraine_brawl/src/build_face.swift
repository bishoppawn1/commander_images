#!/usr/bin/env swift

import CoreGraphics
import CoreText
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

guard CommandLine.arguments.count == 3 else {
    fail("Usage: build_face.swift INPUT.png OUTPUT.png")
}

let inputURL = URL(fileURLWithPath: CommandLine.arguments[1])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[2])

guard let imageSource = CGImageSourceCreateWithURL(inputURL as CFURL, nil),
      let inputImage = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) else {
    fail("Could not read \(inputURL.path).")
}

// The source is the 150-DPI render of page 2 of the official 2019 WPN
// large-banner PDF. This crop removes the page-edge white and frames Rowan's
// face, charged sword, armor, and red cloak in a dense 6:7 portrait.
let cropX = 20
let cropY = 105
let cropWidth = 3898
let cropHeight = Int(round(Double(cropWidth) * 7.0 / 6.0))
guard cropX + cropWidth <= inputImage.width,
      cropY + cropHeight <= inputImage.height,
      let croppedImage = inputImage.cropping(to: CGRect(
        x: cropX,
        y: cropY,
        width: cropWidth,
        height: cropHeight
      )) else {
    fail("The expected official-art crop is outside the source image bounds.")
}

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
    fail("Could not create output context.")
}

context.interpolationQuality = .high
context.draw(croppedImage, in: CGRect(x: 0, y: 0, width: outputWidth, height: outputHeight))

// A translucent wine-black field keeps the title readable while retaining
// official cloak, armor, and forest texture throughout the lower composition.
let clear = CGColor(srgbRed: 0.02, green: 0.01, blue: 0.03, alpha: 0.0)
let wine = CGColor(srgbRed: 0.055, green: 0.012, blue: 0.035, alpha: 0.91)
let lowerWine = CGColor(srgbRed: 0.025, green: 0.008, blue: 0.024, alpha: 0.62)
let gradientColors = [clear, wine, wine, lowerWine] as CFArray
let gradientLocations: [CGFloat] = [0.0, 0.24, 0.73, 1.0]
guard let titleGradient = CGGradient(
    colorsSpace: colorSpace,
    colors: gradientColors,
    locations: gradientLocations
) else {
    fail("Could not create title-field gradient.")
}
context.drawLinearGradient(
    titleGradient,
    start: CGPoint(x: 0, y: 1130),
    end: CGPoint(x: 0, y: 165),
    options: []
)

let antiqueGold = CGColor(srgbRed: 0.89, green: 0.69, blue: 0.24, alpha: 1.0)
let brightGold = CGColor(srgbRed: 1.0, green: 0.84, blue: 0.39, alpha: 1.0)
let pureWhite = CGColor(srgbRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
let nearBlack = CGColor(srgbRed: 0.035, green: 0.012, blue: 0.02, alpha: 1.0)
let shadow = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.92)

// Heraldic rules give the title a deliberate integrated structure while
// leaving full bleed intact.
context.saveGState()
context.setStrokeColor(nearBlack)
context.setLineWidth(13)
context.move(to: CGPoint(x: 96, y: 1030))
context.addLine(to: CGPoint(x: 1704, y: 1030))
context.strokePath()
context.setStrokeColor(antiqueGold)
context.setLineWidth(5)
context.move(to: CGPoint(x: 96, y: 1030))
context.addLine(to: CGPoint(x: 1704, y: 1030))
context.strokePath()
context.setFillColor(brightGold)
context.translateBy(x: 900, y: 1030)
context.rotate(by: .pi / 4)
context.fill(CGRect(x: -13, y: -13, width: 26, height: 26))
context.restoreGState()

func drawCenteredText(
    _ text: String,
    centerY: CGFloat,
    maximumFontSize: CGFloat,
    maximumWidth: CGFloat,
    fill: CGColor,
    kern: CGFloat,
    strokeWidth: CGFloat
) {
    var fontSize = maximumFontSize
    var line: CTLine!
    var bounds = CGRect.zero

    repeat {
        let font = CTFontCreateWithName("Copperplate-Bold" as CFString, fontSize, nil)
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(kCTFontAttributeName as String): font,
            NSAttributedString.Key(kCTForegroundColorAttributeName as String): fill,
            NSAttributedString.Key(kCTStrokeColorAttributeName as String): nearBlack,
            NSAttributedString.Key(kCTStrokeWidthAttributeName as String): strokeWidth,
            NSAttributedString.Key(kCTKernAttributeName as String): kern,
            NSAttributedString.Key(kCTLigatureAttributeName as String): 0
        ]
        line = CTLineCreateWithAttributedString(NSAttributedString(string: text, attributes: attributes))
        bounds = CTLineGetBoundsWithOptions(line, [.useGlyphPathBounds])
        if bounds.width <= maximumWidth { break }
        fontSize -= 2
    } while fontSize >= 72

    context.saveGState()
    context.setShadow(offset: CGSize(width: 0, height: -11), blur: 17, color: shadow)
    context.textPosition = CGPoint(
        x: CGFloat(outputWidth) / 2 - bounds.midX,
        y: centerY - bounds.midY
    )
    CTLineDraw(line, context)
    context.restoreGState()
}

drawCenteredText(
    "THRONE OF",
    centerY: 910,
    maximumFontSize: 170,
    maximumWidth: 1450,
    fill: pureWhite,
    kern: 9,
    strokeWidth: -5.0
)
drawCenteredText(
    "ELDRAINE",
    centerY: 720,
    maximumFontSize: 260,
    maximumWidth: 1600,
    fill: pureWhite,
    kern: 2,
    strokeWidth: -4.5
)
drawCenteredText(
    "BRAWL",
    centerY: 410,
    maximumFontSize: 350,
    maximumWidth: 1585,
    fill: pureWhite,
    kern: 12,
    strokeWidth: -5.0
)

// Close the title treatment with a subtle rule above the count-safe corner.
context.setStrokeColor(nearBlack)
context.setLineWidth(11)
context.move(to: CGPoint(x: 105, y: 203))
context.addLine(to: CGPoint(x: 1430, y: 203))
context.strokePath()
context.setStrokeColor(antiqueGold)
context.setLineWidth(4)
context.move(to: CGPoint(x: 105, y: 203))
context.addLine(to: CGPoint(x: 1430, y: 203))
context.strokePath()

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
