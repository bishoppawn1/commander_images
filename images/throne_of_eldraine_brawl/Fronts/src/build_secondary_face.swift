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
    fail("Usage: build_secondary_face.swift INPUT.png OUTPUT.png")
}

let inputURL = URL(fileURLWithPath: CommandLine.arguments[1])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[2])

guard let source = CGImageSourceCreateWithURL(inputURL as CFURL, nil),
      let inputImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
    fail("Could not read \(inputURL.path).")
}

let targetRatio = CGFloat(outputWidth) / CGFloat(outputHeight)
let inputRatio = CGFloat(inputImage.width) / CGFloat(inputImage.height)
let cropRect: CGRect
if inputRatio > targetRatio {
    let cropWidth = CGFloat(inputImage.height) * targetRatio
    cropRect = CGRect(
        x: (CGFloat(inputImage.width) - cropWidth) / 2,
        y: 0,
        width: cropWidth,
        height: CGFloat(inputImage.height)
    )
} else {
    let cropHeight = CGFloat(inputImage.width) / targetRatio
    cropRect = CGRect(
        x: 0,
        y: (CGFloat(inputImage.height) - cropHeight) / 2,
        width: CGFloat(inputImage.width),
        height: cropHeight
    )
}

guard let croppedImage = inputImage.cropping(to: cropRect.integral),
      let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(
        data: nil,
        width: outputWidth,
        height: outputHeight,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
      ) else {
    fail("Could not prepare the output canvas.")
}

context.interpolationQuality = .high
context.draw(croppedImage, in: CGRect(x: 0, y: 0, width: outputWidth, height: outputHeight))

let ink = CGColor(srgbRed: 0.075, green: 0.025, blue: 0.070, alpha: 1.0)
let royalWine = CGColor(srgbRed: 0.24, green: 0.055, blue: 0.19, alpha: 1.0)
let antiqueGold = CGColor(srgbRed: 0.72, green: 0.47, blue: 0.13, alpha: 1.0)
let brightGold = CGColor(srgbRed: 0.96, green: 0.75, blue: 0.27, alpha: 1.0)
let warmIvory = CGColor(srgbRed: 1.0, green: 0.95, blue: 0.72, alpha: 1.0)
let pureWhite = CGColor(srgbRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
let shadow = CGColor(srgbRed: 0.02, green: 0.005, blue: 0.02, alpha: 0.86)

// A soft vellum glow supports the letterforms without creating a pasted-on
// rectangle. The generated manuscript texture and gold tracery remain visible.
guard let titleGlow = CGGradient(
    colorsSpace: colorSpace,
    colors: [
        CGColor(srgbRed: 1.0, green: 0.89, blue: 0.60, alpha: 0.23),
        CGColor(srgbRed: 0.72, green: 0.46, blue: 0.20, alpha: 0.07),
        CGColor(srgbRed: 0.20, green: 0.04, blue: 0.15, alpha: 0.0)
    ] as CFArray,
    locations: [0.0, 0.58, 1.0]
) else {
    fail("Could not create the title glow.")
}
context.drawRadialGradient(
    titleGlow,
    startCenter: CGPoint(x: 900, y: 1080),
    startRadius: 45,
    endCenter: CGPoint(x: 900, y: 1080),
    endRadius: 870,
    options: [.drawsAfterEndLocation]
)

func makeLine(
    _ text: String,
    fontName: String,
    fontSize: CGFloat,
    fill: CGColor,
    stroke: CGColor,
    strokeWidth: CGFloat,
    kern: CGFloat
) -> CTLine {
    let font = CTFontCreateWithName(fontName as CFString, fontSize, nil)
    let attributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key(kCTFontAttributeName as String): font,
        NSAttributedString.Key(kCTForegroundColorAttributeName as String): fill,
        NSAttributedString.Key(kCTStrokeColorAttributeName as String): stroke,
        NSAttributedString.Key(kCTStrokeWidthAttributeName as String): strokeWidth,
        NSAttributedString.Key(kCTKernAttributeName as String): kern,
        NSAttributedString.Key(kCTLigatureAttributeName as String): 0
    ]
    return CTLineCreateWithAttributedString(NSAttributedString(string: text, attributes: attributes))
}

func fittedFontSize(
    _ text: String,
    fontName: String,
    maximumFontSize: CGFloat,
    maximumWidth: CGFloat,
    kern: CGFloat
) -> CGFloat {
    var size = maximumFontSize
    while size >= 64 {
        let line = makeLine(
            text,
            fontName: fontName,
            fontSize: size,
            fill: warmIvory,
            stroke: ink,
            strokeWidth: 0,
            kern: kern
        )
        if CTLineGetBoundsWithOptions(line, [.useGlyphPathBounds]).width <= maximumWidth {
            return size
        }
        size -= 2
    }
    return size
}

func drawLayer(
    _ text: String,
    centerY: CGFloat,
    fontName: String,
    fontSize: CGFloat,
    fill: CGColor,
    stroke: CGColor,
    strokeWidth: CGFloat,
    kern: CGFloat,
    withShadow: Bool = false
) {
    let line = makeLine(
        text,
        fontName: fontName,
        fontSize: fontSize,
        fill: fill,
        stroke: stroke,
        strokeWidth: strokeWidth,
        kern: kern
    )
    let bounds = CTLineGetBoundsWithOptions(line, [.useGlyphPathBounds])
    context.saveGState()
    if withShadow {
        context.setShadow(offset: CGSize(width: 0, height: -10), blur: 15, color: shadow)
    }
    context.textPosition = CGPoint(x: CGFloat(outputWidth) / 2 - bounds.midX, y: centerY - bounds.midY)
    CTLineDraw(line, context)
    context.restoreGState()
}

func drawIlluminatedText(
    _ text: String,
    centerY: CGFloat,
    fontName: String,
    maximumFontSize: CGFloat,
    maximumWidth: CGFloat,
    fill: CGColor,
    kern: CGFloat
) {
    let fontSize = fittedFontSize(
        text,
        fontName: fontName,
        maximumFontSize: maximumFontSize,
        maximumWidth: maximumWidth,
        kern: kern
    )
    drawLayer(
        text,
        centerY: centerY,
        fontName: fontName,
        fontSize: fontSize,
        fill: fill,
        stroke: ink,
        strokeWidth: -9.0,
        kern: kern,
        withShadow: true
    )
    drawLayer(
        text,
        centerY: centerY,
        fontName: fontName,
        fontSize: fontSize,
        fill: fill,
        stroke: brightGold,
        strokeWidth: -5.4,
        kern: kern
    )
    drawLayer(
        text,
        centerY: centerY,
        fontName: fontName,
        fontSize: fontSize,
        fill: fill,
        stroke: ink,
        strokeWidth: -1.7,
        kern: kern
    )
}

func drawFlourish(atY y: CGFloat, halfWidth: CGFloat) {
    context.saveGState()
    context.setLineCap(.round)
    context.setStrokeColor(ink)
    context.setLineWidth(12)
    context.move(to: CGPoint(x: 900 - halfWidth, y: y))
    context.addCurve(
        to: CGPoint(x: 850, y: y),
        control1: CGPoint(x: 900 - halfWidth * 0.60, y: y + 16),
        control2: CGPoint(x: 760, y: y - 16)
    )
    context.move(to: CGPoint(x: 900 + halfWidth, y: y))
    context.addCurve(
        to: CGPoint(x: 950, y: y),
        control1: CGPoint(x: 900 + halfWidth * 0.60, y: y + 16),
        control2: CGPoint(x: 1040, y: y - 16)
    )
    context.strokePath()
    context.setStrokeColor(brightGold)
    context.setLineWidth(4)
    context.move(to: CGPoint(x: 900 - halfWidth, y: y))
    context.addCurve(
        to: CGPoint(x: 850, y: y),
        control1: CGPoint(x: 900 - halfWidth * 0.60, y: y + 16),
        control2: CGPoint(x: 760, y: y - 16)
    )
    context.move(to: CGPoint(x: 900 + halfWidth, y: y))
    context.addCurve(
        to: CGPoint(x: 950, y: y),
        control1: CGPoint(x: 900 + halfWidth * 0.60, y: y + 16),
        control2: CGPoint(x: 1040, y: y - 16)
    )
    context.strokePath()
    context.translateBy(x: 900, y: y)
    context.rotate(by: .pi / 4)
    context.setFillColor(ink)
    context.fill(CGRect(x: -19, y: -19, width: 38, height: 38))
    context.setFillColor(brightGold)
    context.fill(CGRect(x: -11, y: -11, width: 22, height: 22))
    context.restoreGState()
}

drawFlourish(atY: 1384, halfWidth: 670)

drawIlluminatedText(
    "THRONE OF",
    centerY: 1282,
    fontName: "BigCaslon-Medium",
    maximumFontSize: 132,
    maximumWidth: 1250,
    fill: pureWhite,
    kern: 8
)
drawIlluminatedText(
    "ELDRAINE",
    centerY: 1098,
    fontName: "Luminari-Regular",
    maximumFontSize: 252,
    maximumWidth: 1580,
    fill: pureWhite,
    kern: -1
)
drawIlluminatedText(
    "BRAWL",
    centerY: 892,
    fontName: "Luminari-Regular",
    maximumFontSize: 300,
    maximumWidth: 1400,
    fill: pureWhite,
    kern: 8
)

drawFlourish(atY: 760, halfWidth: 590)

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
