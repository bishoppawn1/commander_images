#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let canvasWidth = 1800
private let canvasHeight = 2100
private let panelWidth = 900
private let outputDPI = 600
private let logoWidth: CGFloat = 820
private let logoBottom: CGFloat = 310

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 7 else {
    fail("Usage: build_vertical_split.swift BRO_ART.pdf WOE_ART.png BRO_LOGO.png WOE_LOGO.png OUTPUT.png PREVIEW.png")
}

let brothersArtURL = URL(fileURLWithPath: CommandLine.arguments[1])
let wildsArtURL = URL(fileURLWithPath: CommandLine.arguments[2])
let brothersLogoURL = URL(fileURLWithPath: CommandLine.arguments[3])
let wildsLogoURL = URL(fileURLWithPath: CommandLine.arguments[4])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[5])
let previewURL = URL(fileURLWithPath: CommandLine.arguments[6])

func loadImage(_ url: URL) -> CGImage {
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(url.path).")
    }
    return image
}

guard let brothersDocument = CGPDFDocument(brothersArtURL as CFURL),
      let brothersPage = brothersDocument.page(at: 1) else {
    fail("Could not read the retained Brothers' War PDF.")
}

let brothersBounds = brothersPage.getBoxRect(.mediaBox)
guard Int(brothersBounds.width.rounded()) == 5184,
      Int(brothersBounds.height.rounded()) == 3456 else {
    fail("Expected the retained 72 x 48-inch Brothers' War art page at 5184 x 3456 points.")
}

let wildsArt = loadImage(wildsArtURL)
guard wildsArt.width == 1163, wildsArt.height == 1353 else {
    fail("Expected the retained Wilds of Eldraine approved clean artwork at 1163 x 1353 pixels.")
}

let brothersLogoCanvas = loadImage(brothersLogoURL)
let wildsLogoCanvas = loadImage(wildsLogoURL)
for (name, logo) in [("Brothers' War", brothersLogoCanvas), ("Wilds of Eldraine", wildsLogoCanvas)] {
    guard logo.width == 900, logo.height == 407 else {
        fail("Expected the retained \(name) official logo at 900 x 407 pixels.")
    }
}

// Wizards' 900 x 407 Brothers' War PNG includes generous transparent side
// padding. Remove only fully transparent horizontal columns so the visible
// official wordmark—not its storage canvas—can span the panel.
func cropTransparentHorizontalMargins(_ image: CGImage) -> CGImage {
    let width = image.width
    let height = image.height
    let bytesPerRow = width * 4
    var pixels = [UInt8](repeating: 0, count: bytesPerRow * height)
    guard let scanSpace = CGColorSpace(name: CGColorSpace.sRGB),
          let scanContext = CGContext(
            data: &pixels,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: scanSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
          ) else {
        fail("Could not inspect logo transparency.")
    }
    scanContext.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))

    var minimumX = width
    var maximumX = -1
    for y in 0..<height {
        for x in 0..<width where pixels[y * bytesPerRow + x * 4 + 3] > 0 {
            minimumX = min(minimumX, x)
            maximumX = max(maximumX, x)
        }
    }
    guard maximumX >= minimumX,
          let cropped = image.cropping(
            to: CGRect(x: minimumX, y: 0, width: maximumX - minimumX + 1, height: height)
          ) else {
        fail("Could not crop transparent logo margins.")
    }
    return cropped
}

let brothersLogo = cropTransparentHorizontalMargins(brothersLogoCanvas)
let wildsLogo = cropTransparentHorizontalMargins(wildsLogoCanvas)

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

// Left: use the full height of the official red-and-black WPN oversized art.
// A focal point at 61% of source width retains the central artifact creature
// and its forge-bright core in the narrower 900-pixel panel.
let brothersPanel = CGRect(x: 0, y: 0, width: panelWidth, height: canvasHeight)
let brothersScale = CGFloat(canvasHeight) / brothersBounds.height
let brothersFocalX = brothersBounds.width * 0.61
let brothersDrawX = brothersPanel.midX - brothersFocalX * brothersScale

context.saveGState()
context.clip(to: brothersPanel)
context.translateBy(x: brothersDrawX, y: 0)
context.scaleBy(x: brothersScale, y: brothersScale)
context.drawPDFPage(brothersPage)
context.restoreGState()

// Right: recompose the same accepted clean key-art background used by the
// approved standalone target. Scaling by height preserves the complete
// enchanted canopy-to-forest composition and centers the fae ruler.
let wildsPanel = CGRect(x: panelWidth, y: 0, width: panelWidth, height: canvasHeight)
let wildsScale = CGFloat(canvasHeight) / CGFloat(wildsArt.height)
let wildsFocalX = CGFloat(wildsArt.width) / 2
let wildsDrawX = wildsPanel.midX - wildsFocalX * wildsScale

context.saveGState()
context.clip(to: wildsPanel)
context.draw(
    wildsArt,
    in: CGRect(
        x: wildsDrawX,
        y: 0,
        width: CGFloat(wildsArt.width) * wildsScale,
        height: CGFloat(canvasHeight)
    )
)
context.restoreGState()

func drawTitleVignette(panelX: CGFloat, red: CGFloat, green: CGFloat, blue: CGFloat) {
    guard let gradient = CGGradient(
        colorsSpace: colorSpace,
        colors: [
            CGColor(srgbRed: red, green: green, blue: blue, alpha: 0.88),
            CGColor(srgbRed: red, green: green, blue: blue, alpha: 0.58),
            CGColor(srgbRed: red, green: green, blue: blue, alpha: 0.0)
        ] as CFArray,
        locations: [0.0, 0.56, 1.0]
    ) else {
        fail("Could not create a title vignette.")
    }

    context.saveGState()
    context.clip(to: CGRect(x: panelX, y: 0, width: CGFloat(panelWidth), height: 1080))
    context.drawLinearGradient(
        gradient,
        start: CGPoint(x: panelX, y: 0),
        end: CGPoint(x: panelX, y: 1080),
        options: []
    )
    context.restoreGState()
}

// Atmosphere-matched transparent contrast fields preserve useful art detail.
drawTitleVignette(panelX: 0, red: 0.055, green: 0.015, blue: 0.012)
drawTitleVignette(panelX: CGFloat(panelWidth), red: 0.012, green: 0.014, blue: 0.055)

func drawOfficialLogo(_ logo: CGImage, panelX: CGFloat) {
    let logoHeight = logoWidth * CGFloat(logo.height) / CGFloat(logo.width)
    let rect = CGRect(
        x: panelX + (CGFloat(panelWidth) - logoWidth) / 2,
        y: logoBottom,
        width: logoWidth,
        height: logoHeight
    )

    context.saveGState()
    context.setShadow(
        offset: CGSize(width: 0, height: -8),
        blur: 20,
        color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.94)
    )
    context.draw(logo, in: rect)
    context.restoreGState()
    context.draw(logo, in: rect)
}

// Exact official stacked wordmarks are sized independently for each half.
drawOfficialLogo(brothersLogo, panelX: 0)
drawOfficialLogo(wildsLogo, panelX: CGFloat(panelWidth))

// One straight, narrow, full-height divider overlays the exact x=900 panel
// boundary. The underlying source panels remain exactly 900 pixels each.
let dividerGold = CGColor(srgbRed: 0.91, green: 0.72, blue: 0.35, alpha: 1)
context.setFillColor(dividerGold)
context.fill(CGRect(x: 897, y: 0, width: 6, height: canvasHeight))

guard let outputImage = context.makeImage() else {
    fail("Could not render the split target.")
}

func writePNG(_ image: CGImage, to url: URL, dpi: Int) {
    try? FileManager.default.createDirectory(
        at: url.deletingLastPathComponent(),
        withIntermediateDirectories: true
    )
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
        kCGImagePropertyDPIHeight: dpi,
        kCGImagePropertyColorModel: kCGImagePropertyColorModelRGB
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
    fail("Could not create the drawer-scale preview canvas.")
}
previewContext.interpolationQuality = .high
previewContext.draw(outputImage, in: CGRect(x: 0, y: 0, width: 300, height: 350))
guard let previewImage = previewContext.makeImage() else {
    fail("Could not render the drawer-scale preview.")
}
writePNG(previewImage, to: previewURL, dpi: 100)

print("Wrote \(outputURL.path)")
print("Wrote \(previewURL.path)")
