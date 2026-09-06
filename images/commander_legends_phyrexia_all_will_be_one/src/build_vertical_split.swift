#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let canvasWidth = 1800
private let canvasHeight = 2100
private let panelWidth = 900
private let outputDPI = 600

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 7 else {
    fail("Usage: build_vertical_split.swift LEGENDS_POSTER.png LEGENDS_WORDMARK.png ONE_POSTER.png ONE_LOGO.png OUTPUT.png PREVIEW.png")
}

func loadImage(_ path: String) -> CGImage {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(path).")
    }
    return image
}

let legendsPoster = loadImage(CommandLine.arguments[1])
let legendsWordmark = loadImage(CommandLine.arguments[2])
let onePoster = loadImage(CommandLine.arguments[3])
let oneLogo = loadImage(CommandLine.arguments[4])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[5])
let previewURL = URL(fileURLWithPath: CommandLine.arguments[6])

guard legendsPoster.width == 5100, legendsPoster.height == 6600 else {
    fail("Expected the retained Commander Legends poster at 5100 × 6600.")
}
guard legendsWordmark.width == 2735, legendsWordmark.height == 839 else {
    fail("Expected the retained Commander Legends wordmark at 2735 × 839.")
}
guard onePoster.width == 3600, onePoster.height == 5400 else {
    fail("Expected the retained Phyrexia poster at 3600 × 5400.")
}
guard oneLogo.width == 900, oneLogo.height == 407 else {
    fail("Expected the retained Phyrexia wordmark at 900 × 407.")
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
    fail("Could not create the split canvas.")
}
context.interpolationQuality = .high

func tint(_ source: CGImage, color: CGColor) -> CGImage {
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
    guard let result = tintContext.makeImage() else {
        fail("Could not finish a wordmark tint layer.")
    }
    return result
}

func tealMetalFace(_ source: CGImage) -> CGImage {
    guard let faceContext = CGContext(
        data: nil,
        width: source.width,
        height: source.height,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
        fail("Could not create the Commander Legends wordmark face.")
    }
    faceContext.draw(source, in: CGRect(x: 0, y: 0, width: source.width, height: source.height))
    faceContext.setBlendMode(.sourceIn)
    guard let gradient = CGGradient(
        colorsSpace: colorSpace,
        colors: [
            CGColor(srgbRed: 0.97, green: 0.97, blue: 0.87, alpha: 1),
            CGColor(srgbRed: 0.74, green: 0.88, blue: 0.82, alpha: 1),
            CGColor(srgbRed: 0.29, green: 0.57, blue: 0.57, alpha: 1),
            CGColor(srgbRed: 0.08, green: 0.22, blue: 0.31, alpha: 1)
        ] as CFArray,
        locations: [0, 0.34, 0.68, 1]
    ) else {
        fail("Could not create the Commander Legends wordmark gradient.")
    }
    faceContext.drawLinearGradient(
        gradient,
        start: CGPoint(x: 0, y: source.height),
        end: CGPoint(x: 0, y: 0),
        options: []
    )
    guard let result = faceContext.makeImage() else {
        fail("Could not finish the Commander Legends wordmark face.")
    }
    return result
}

func drawCommanderLegendsBand() {
    guard let gradient = CGGradient(
        colorsSpace: colorSpace,
        colors: [
            CGColor(srgbRed: 0.012, green: 0.015, blue: 0.035, alpha: 0.66),
            CGColor(srgbRed: 0.012, green: 0.015, blue: 0.035, alpha: 0.04)
        ] as CFArray,
        locations: [0, 1]
    ) else {
        fail("Could not create the Commander Legends title veil.")
    }
    let rect = CGRect(x: 0, y: 215, width: panelWidth, height: 500)
    context.saveGState()
    context.clip(to: rect)
    context.drawLinearGradient(
        gradient,
        start: CGPoint(x: rect.midX, y: rect.minY),
        end: CGPoint(x: rect.midX, y: rect.maxY),
        options: []
    )
    context.restoreGState()
}

func drawPhyrexiaVeil() {
    guard let gradient = CGGradient(
        colorsSpace: colorSpace,
        colors: [
            CGColor(srgbRed: 0.027, green: 0.002, blue: 0.005, alpha: 0.76),
            CGColor(srgbRed: 0.09, green: 0.006, blue: 0.015, alpha: 0.41),
            CGColor(srgbRed: 0.09, green: 0.006, blue: 0.015, alpha: 0)
        ] as CFArray,
        locations: [0, 0.48, 1]
    ) else {
        fail("Could not create the Phyrexia title veil.")
    }
    context.saveGState()
    context.clip(to: CGRect(x: panelWidth, y: 0, width: panelWidth, height: 980))
    context.drawLinearGradient(
        gradient,
        start: CGPoint(x: panelWidth, y: 40),
        end: CGPoint(x: panelWidth, y: 980),
        options: []
    )
    context.restoreGState()
}

func drawLogo(_ logo: CGImage, in rect: CGRect) {
    context.saveGState()
    context.setShadow(
        offset: CGSize(width: 0, height: -8),
        blur: 18,
        color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.96)
    )
    context.draw(logo, in: rect)
    context.restoreGState()
    context.draw(logo, in: rect)
}

let legendsArtRect = CGRect(x: 1700, y: 350, width: 1993, height: 4650)
let oneArtRect = CGRect(x: 964, y: 100, width: 1671, height: 3899)
guard let legendsArt = legendsPoster.cropping(to: legendsArtRect),
      let oneArt = onePoster.cropping(to: oneArtRect) else {
    fail("Could not crop the official poster art.")
}
context.draw(legendsArt, in: CGRect(x: 0, y: 0, width: panelWidth, height: canvasHeight))
context.draw(oneArt, in: CGRect(x: panelWidth, y: 0, width: panelWidth, height: canvasHeight))

drawCommanderLegendsBand()
drawPhyrexiaVeil()

let legendsTitleWidth: CGFloat = 812
let legendsTitleRect = CGRect(
    x: 44,
    y: 315,
    width: legendsTitleWidth,
    height: legendsTitleWidth * CGFloat(legendsWordmark.height) / CGFloat(legendsWordmark.width)
)
let legendsContour = tint(
    legendsWordmark,
    color: CGColor(srgbRed: 0.012, green: 0.016, blue: 0.045, alpha: 1)
)
let legendsRim = tint(
    legendsWordmark,
    color: CGColor(srgbRed: 0.82, green: 0.61, blue: 0.31, alpha: 1)
)
let legendsFace = tealMetalFace(legendsWordmark)

context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -8),
    blur: 18,
    color: CGColor(srgbRed: 0, green: 0, blue: 0.01, alpha: 0.94)
)
context.draw(legendsContour, in: legendsTitleRect)
context.restoreGState()
for radius in stride(from: 8, through: 4, by: -2) {
    for step in 0..<16 {
        let angle = CGFloat(step) * .pi / 8
        context.draw(
            legendsContour,
            in: legendsTitleRect.offsetBy(
                dx: cos(angle) * CGFloat(radius),
                dy: sin(angle) * CGFloat(radius)
            )
        )
    }
}
for radius in stride(from: 3, through: 1, by: -1) {
    for step in 0..<12 {
        let angle = CGFloat(step) * .pi / 6
        context.draw(
            legendsRim,
            in: legendsTitleRect.offsetBy(
                dx: cos(angle) * CGFloat(radius),
                dy: sin(angle) * CGFloat(radius)
            )
        )
    }
}
context.draw(legendsFace, in: legendsTitleRect)

let oneLogoX: CGFloat = 950
let oneLogoY: CGFloat = 350
let oneLogoWidth: CGFloat = 750
let oneLogoRect = CGRect(
    x: oneLogoX,
    y: oneLogoY,
    width: oneLogoWidth,
    height: oneLogoWidth * CGFloat(oneLogo.height) / CGFloat(oneLogo.width)
)
drawLogo(oneLogo, in: oneLogoRect)

let oneScale: CGFloat = oneLogoWidth / 1510
let colonCenters = [
    CGPoint(x: oneLogoX + (1682 - 95) * oneScale, y: oneLogoY + (724 - 248) * oneScale),
    CGPoint(x: oneLogoX + (1682 - 95) * oneScale, y: oneLogoY + (588 - 248) * oneScale)
]
let colonRadius: CGFloat = 16
let colonRim = CGColor(srgbRed: 0.36, green: 0.31, blue: 0.24, alpha: 1)
let colonBone = CGColor(srgbRed: 0.88, green: 0.84, blue: 0.73, alpha: 1)
let colonHighlight = CGColor(srgbRed: 0.98, green: 0.95, blue: 0.86, alpha: 0.92)

for center in colonCenters {
    context.saveGState()
    context.setShadow(
        offset: CGSize(width: 0, height: -5),
        blur: 9,
        color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.94)
    )
    context.setFillColor(colonRim)
    context.fillEllipse(in: CGRect(x: center.x - colonRadius, y: center.y - colonRadius, width: colonRadius * 2, height: colonRadius * 2))
    context.restoreGState()
    context.setFillColor(colonBone)
    context.fillEllipse(in: CGRect(x: center.x - 12.5, y: center.y - 12.5, width: 25, height: 25))
    context.setStrokeColor(colonHighlight)
    context.setLineWidth(1.6)
    context.strokeEllipse(in: CGRect(x: center.x - 11, y: center.y - 11, width: 22, height: 22))
}

context.setFillColor(CGColor(srgbRed: 0.83, green: 0.63, blue: 0.27, alpha: 1))
context.fill(CGRect(x: 897, y: 0, width: 6, height: canvasHeight))

guard let outputImage = context.makeImage() else {
    fail("Could not render the split target.")
}

func writePNG(_ image: CGImage, to url: URL, dpi: Int) {
    try? FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
    guard let destination = CGImageDestinationCreateWithURL(
        url as CFURL,
        UTType.png.identifier as CFString,
        1,
        nil
    ) else {
        fail("Could not create \(url.path).")
    }
    let properties: [CFString: Any] = [
        kCGImagePropertyDPIWidth: dpi,
        kCGImagePropertyDPIHeight: dpi
    ]
    CGImageDestinationAddImage(destination, image, properties as CFDictionary)
    guard CGImageDestinationFinalize(destination) else {
        fail("Could not finish writing \(url.path).")
    }
}

writePNG(outputImage, to: outputURL, dpi: outputDPI)

guard let previewContext = CGContext(
    data: nil,
    width: 300,
    height: 350,
    bitsPerComponent: 8,
    bytesPerRow: 0,
    space: colorSpace,
    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
) else {
    fail("Could not create the drawer-preview canvas.")
}
previewContext.interpolationQuality = .high
previewContext.draw(outputImage, in: CGRect(x: 0, y: 0, width: 300, height: 350))
guard let previewImage = previewContext.makeImage() else {
    fail("Could not render the drawer preview.")
}
writePNG(previewImage, to: previewURL, dpi: 100)

print("Wrote \(outputURL.path)")
print("Wrote \(previewURL.path)")
