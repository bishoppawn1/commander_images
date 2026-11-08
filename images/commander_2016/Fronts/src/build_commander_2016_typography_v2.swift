#!/usr/bin/env swift

import CoreGraphics
import CoreText
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

guard CommandLine.arguments.count == 5 else {
    fail("Usage: build_commander_2016_typography_v2.swift RAW.png FONT.ttf OUTPUT.png PREVIEW.png")
}

let rawURL = URL(fileURLWithPath: CommandLine.arguments[1])
let fontURL = URL(fileURLWithPath: CommandLine.arguments[2])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[3])
let previewURL = URL(fileURLWithPath: CommandLine.arguments[4])

var registrationError: Unmanaged<CFError>?
guard CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &registrationError) else {
    let message = registrationError?.takeRetainedValue().localizedDescription ?? "unknown font-registration error"
    fail("Could not register font: \(message)")
}

guard let source = CGImageSourceCreateWithURL(rawURL as CFURL, nil),
      let rawImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
    fail("Could not read raw artwork at \(rawURL.path)")
}

guard rawImage.width == 1162, rawImage.height == 1353,
      let croppedArtwork = rawImage.cropping(to: CGRect(x: 1, y: 0, width: 1160, height: 1353)) else {
    fail("Expected the retained 1162 × 1353 v1 raw artwork")
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
    fail("Could not create sRGB target canvas")
}

context.interpolationQuality = .high
context.draw(croppedArtwork, in: CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))

let black = CGColor(srgbRed: 0.012, green: 0.016, blue: 0.025, alpha: 1)
let deepBlue = CGColor(srgbRed: 0.025, green: 0.055, blue: 0.085, alpha: 1)
let antiqueGold = CGColor(srgbRed: 0.77, green: 0.54, blue: 0.19, alpha: 1)
let warmGold = CGColor(srgbRed: 0.96, green: 0.80, blue: 0.40, alpha: 1)
let etheriumSilver = CGColor(srgbRed: 0.87, green: 0.92, blue: 0.94, alpha: 1)
let brightSilver = CGColor(srgbRed: 0.98, green: 0.99, blue: 0.96, alpha: 1)
let cyanSteel = CGColor(srgbRed: 0.40, green: 0.71, blue: 0.84, alpha: 1)
let magentaCarmot = CGColor(srgbRed: 0.90, green: 0.24, blue: 0.55, alpha: 1)

func drawAtmosphericVignette() {
    guard let topGradient = CGGradient(
        colorsSpace: colorSpace,
        colors: [
            CGColor(srgbRed: 0.005, green: 0.009, blue: 0.018, alpha: 0.72),
            CGColor(srgbRed: 0.010, green: 0.018, blue: 0.035, alpha: 0.31),
            CGColor(srgbRed: 0.010, green: 0.018, blue: 0.035, alpha: 0.00)
        ] as CFArray,
        locations: [0, 0.60, 1]
    ), let bottomGradient = CGGradient(
        colorsSpace: colorSpace,
        colors: [
            CGColor(srgbRed: 0.005, green: 0.009, blue: 0.018, alpha: 0.75),
            CGColor(srgbRed: 0.010, green: 0.018, blue: 0.035, alpha: 0.24),
            CGColor(srgbRed: 0.010, green: 0.018, blue: 0.035, alpha: 0.00)
        ] as CFArray,
        locations: [0, 0.58, 1]
    ) else { return }

    context.drawLinearGradient(
        topGradient,
        start: CGPoint(x: 0, y: CGFloat(canvasHeight)),
        end: CGPoint(x: 0, y: 1550),
        options: []
    )
    context.drawLinearGradient(
        bottomGradient,
        start: CGPoint(x: 0, y: 0),
        end: CGPoint(x: 0, y: 390),
        options: []
    )
}

drawAtmosphericVignette()

func makeLinePath(
    _ text: String,
    fontSize: CGFloat,
    kern: CGFloat,
    baselineY: CGFloat,
    centerX: CGFloat,
    maxWidth: CGFloat
) -> CGPath {
    var size = fontSize

    while size >= 20 {
        let font = CTFontCreateWithName("CinzelDecorative-Black" as CFString, size, nil)
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(kCTFontAttributeName as String): font,
            NSAttributedString.Key(kCTKernAttributeName as String): kern,
            NSAttributedString.Key(kCTLigatureAttributeName as String): 0
        ]
        let attributed = NSAttributedString(string: text, attributes: attributes)
        let line = CTLineCreateWithAttributedString(attributed)
        let bounds = CTLineGetBoundsWithOptions(line, [.useGlyphPathBounds])

        if bounds.width <= maxWidth {
            let xOffset = centerX - bounds.midX
            let combined = CGMutablePath()
            let runs = CTLineGetGlyphRuns(line) as NSArray

            for case let run as CTRun in runs {
                let count = CTRunGetGlyphCount(run)
                var glyphs = [CGGlyph](repeating: 0, count: count)
                var positions = [CGPoint](repeating: .zero, count: count)
                CTRunGetGlyphs(run, CFRange(location: 0, length: 0), &glyphs)
                CTRunGetPositions(run, CFRange(location: 0, length: 0), &positions)

                for index in 0..<count {
                    guard let glyphPath = CTFontCreatePathForGlyph(font, glyphs[index], nil) else { continue }
                    let transform = CGAffineTransform(
                        translationX: xOffset + positions[index].x,
                        y: baselineY + positions[index].y
                    )
                    combined.addPath(glyphPath, transform: transform)
                }
            }
            return combined
        }
        size -= 2
    }

    fail("Could not fit text: \(text)")
}

func drawMetalText(
    path: CGPath,
    verticalRange: ClosedRange<CGFloat>,
    outerWidth: CGFloat,
    goldWidth: CGFloat,
    innerWidth: CGFloat,
    fillColors: [CGColor],
    fillLocations: [CGFloat],
    shadowBlur: CGFloat,
    shadowOffsetY: CGFloat,
    carmotEdge: Bool = false
) {
    context.saveGState()
    context.setShadow(
        offset: CGSize(width: 0, height: shadowOffsetY),
        blur: shadowBlur,
        color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.92)
    )
    context.addPath(path)
    context.setFillColor(black)
    context.fillPath()
    context.restoreGState()

    context.setLineJoin(.round)
    context.setLineCap(.round)

    context.addPath(path)
    context.setStrokeColor(black)
    context.setLineWidth(outerWidth)
    context.strokePath()

    context.addPath(path)
    context.setStrokeColor(antiqueGold)
    context.setLineWidth(goldWidth)
    context.strokePath()

    context.addPath(path)
    context.setStrokeColor(deepBlue)
    context.setLineWidth(innerWidth)
    context.strokePath()

    guard let gradient = CGGradient(
        colorsSpace: colorSpace,
        colors: fillColors as CFArray,
        locations: fillLocations
    ) else { return }

    context.saveGState()
    context.addPath(path)
    context.clip()
    context.drawLinearGradient(
        gradient,
        start: CGPoint(x: 0, y: verticalRange.lowerBound),
        end: CGPoint(x: 0, y: verticalRange.upperBound),
        options: []
    )
    context.restoreGState()

    context.addPath(path)
    context.setStrokeColor(brightSilver.copy(alpha: 0.60)!)
    context.setLineWidth(1.6)
    context.strokePath()

    if carmotEdge {
        context.addPath(path)
        context.setStrokeColor(magentaCarmot.copy(alpha: 0.30)!)
        context.setLineWidth(0.8)
        context.strokePath()
    }
}

func drawDiamond(center: CGPoint, radius: CGFloat, fill: CGColor, stroke: CGColor) {
    let diamond = CGMutablePath()
    diamond.move(to: CGPoint(x: center.x, y: center.y + radius))
    diamond.addLine(to: CGPoint(x: center.x + radius, y: center.y))
    diamond.addLine(to: CGPoint(x: center.x, y: center.y - radius))
    diamond.addLine(to: CGPoint(x: center.x - radius, y: center.y))
    diamond.closeSubpath()
    context.addPath(diamond)
    context.setFillColor(fill)
    context.fillPath()
    context.addPath(diamond)
    context.setStrokeColor(stroke)
    context.setLineWidth(3)
    context.strokePath()
}

func drawArtifactRule(y: CGFloat, left: CGFloat, right: CGFloat, gap: ClosedRange<CGFloat>) {
    func segment(from: CGFloat, to: CGFloat) {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: from, y: y))
        path.addCurve(
            to: CGPoint(x: to, y: y),
            control1: CGPoint(x: from + (to - from) * 0.34, y: y + 17),
            control2: CGPoint(x: from + (to - from) * 0.66, y: y - 17)
        )
        context.addPath(path)
        context.setStrokeColor(black.copy(alpha: 0.85)!)
        context.setLineWidth(10)
        context.strokePath()
        context.addPath(path)
        context.setStrokeColor(antiqueGold.copy(alpha: 0.88)!)
        context.setLineWidth(4)
        context.strokePath()
        context.addPath(path)
        context.setStrokeColor(cyanSteel.copy(alpha: 0.60)!)
        context.setLineWidth(1.2)
        context.strokePath()
    }

    segment(from: left, to: gap.lowerBound)
    segment(from: gap.upperBound, to: right)
    drawDiamond(center: CGPoint(x: left, y: y), radius: 10, fill: deepBlue, stroke: warmGold)
    drawDiamond(center: CGPoint(x: right, y: y), radius: 10, fill: deepBlue, stroke: warmGold)
}

func drawCrownFiligree() {
    let crown = CGMutablePath()
    crown.move(to: CGPoint(x: 660, y: 2050))
    crown.addCurve(
        to: CGPoint(x: 870, y: 2072),
        control1: CGPoint(x: 735, y: 2052),
        control2: CGPoint(x: 790, y: 2092)
    )
    crown.addCurve(
        to: CGPoint(x: 900, y: 2028),
        control1: CGPoint(x: 885, y: 2067),
        control2: CGPoint(x: 888, y: 2040)
    )
    crown.addCurve(
        to: CGPoint(x: 930, y: 2072),
        control1: CGPoint(x: 912, y: 2040),
        control2: CGPoint(x: 915, y: 2067)
    )
    crown.addCurve(
        to: CGPoint(x: 1140, y: 2050),
        control1: CGPoint(x: 1010, y: 2092),
        control2: CGPoint(x: 1065, y: 2052)
    )
    context.addPath(crown)
    context.setStrokeColor(black.copy(alpha: 0.90)!)
    context.setLineWidth(12)
    context.strokePath()
    context.addPath(crown)
    context.setStrokeColor(antiqueGold.copy(alpha: 0.86)!)
    context.setLineWidth(4)
    context.strokePath()
    context.addPath(crown)
    context.setStrokeColor(etheriumSilver.copy(alpha: 0.72)!)
    context.setLineWidth(1.4)
    context.strokePath()
    drawDiamond(center: CGPoint(x: 900, y: 2028), radius: 10, fill: magentaCarmot, stroke: warmGold)
}

drawCrownFiligree()

let commanderPath = makeLinePath(
    "COMMANDER",
    fontSize: 196,
    kern: 0.5,
    baselineY: 1844,
    centerX: 900,
    maxWidth: 1630
)
drawMetalText(
    path: commanderPath,
    verticalRange: 1840...2010,
    outerWidth: 26,
    goldWidth: 13,
    innerWidth: 6,
    fillColors: [
        CGColor(srgbRed: 0.33, green: 0.25, blue: 0.12, alpha: 1),
        warmGold,
        brightSilver,
        cyanSteel,
        CGColor(srgbRed: 0.13, green: 0.19, blue: 0.24, alpha: 1)
    ],
    fillLocations: [0, 0.24, 0.54, 0.78, 1],
    shadowBlur: 18,
    shadowOffsetY: -12,
    carmotEdge: true
)

drawArtifactRule(y: 1787, left: 175, right: 1625, gap: 665...1135)

let yearPath = makeLinePath(
    "2016",
    fontSize: 126,
    kern: 4,
    baselineY: 1724,
    centerX: 900,
    maxWidth: 410
)
drawMetalText(
    path: yearPath,
    verticalRange: 1720...1838,
    outerWidth: 20,
    goldWidth: 10,
    innerWidth: 4,
    fillColors: [
        CGColor(srgbRed: 0.23, green: 0.18, blue: 0.10, alpha: 1),
        warmGold,
        brightSilver,
        antiqueGold
    ],
    fillLocations: [0, 0.30, 0.66, 1],
    shadowBlur: 13,
    shadowOffsetY: -8
)

drawArtifactRule(y: 250, left: 125, right: 1295, gap: 455...935)

let deckPath = makeLinePath(
    "INVENT SUPERIORITY",
    fontSize: 78,
    kern: 1.8,
    baselineY: 112,
    centerX: 710,
    maxWidth: 1190
)
drawMetalText(
    path: deckPath,
    verticalRange: 108...190,
    outerWidth: 15,
    goldWidth: 7,
    innerWidth: 3,
    fillColors: [
        CGColor(srgbRed: 0.20, green: 0.24, blue: 0.29, alpha: 1),
        cyanSteel,
        brightSilver,
        warmGold
    ],
    fillLocations: [0, 0.34, 0.68, 1],
    shadowBlur: 11,
    shadowOffsetY: -6,
    carmotEdge: true
)

guard let outputImage = context.makeImage() else {
    fail("Could not render final target")
}

try? FileManager.default.createDirectory(at: outputURL.deletingLastPathComponent(), withIntermediateDirectories: true)
guard let destination = CGImageDestinationCreateWithURL(
    outputURL as CFURL,
    UTType.png.identifier as CFString,
    1,
    nil
) else {
    fail("Could not create output at \(outputURL.path)")
}

let properties: [CFString: Any] = [
    kCGImagePropertyDPIWidth: outputDPI,
    kCGImagePropertyDPIHeight: outputDPI
]
CGImageDestinationAddImage(destination, outputImage, properties as CFDictionary)
guard CGImageDestinationFinalize(destination) else {
    fail("Could not finalize output at \(outputURL.path)")
}

let previewWidth = 450
let previewHeight = 525
guard let previewContext = CGContext(
    data: nil,
    width: previewWidth,
    height: previewHeight,
    bitsPerComponent: 8,
    bytesPerRow: 0,
    space: colorSpace,
    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
) else {
    fail("Could not create drawer-scale preview canvas")
}
previewContext.interpolationQuality = .high
previewContext.draw(outputImage, in: CGRect(x: 0, y: 0, width: previewWidth, height: previewHeight))
guard let previewImage = previewContext.makeImage(),
      let previewDestination = CGImageDestinationCreateWithURL(
        previewURL as CFURL,
        UTType.png.identifier as CFString,
        1,
        nil
      ) else {
    fail("Could not create preview at \(previewURL.path)")
}
CGImageDestinationAddImage(previewDestination, previewImage, nil)
guard CGImageDestinationFinalize(previewDestination) else {
    fail("Could not finalize preview at \(previewURL.path)")
}

print("Wrote \(outputURL.path)")
print("Wrote \(previewURL.path)")
