#!/usr/bin/env swift

import CoreGraphics
import CoreText
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
    fail("Usage: build_commander_2013_commander_2016_vertical_split.swift C13_RAW.png C16_RAW.png C13_FONT.ttf C16_FONT.ttf OUTPUT.png PREVIEW.png")
}

let c13RawURL = URL(fileURLWithPath: CommandLine.arguments[1])
let c16RawURL = URL(fileURLWithPath: CommandLine.arguments[2])
let c13FontURL = URL(fileURLWithPath: CommandLine.arguments[3])
let c16FontURL = URL(fileURLWithPath: CommandLine.arguments[4])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[5])
let previewURL = URL(fileURLWithPath: CommandLine.arguments[6])

for fontURL in [c13FontURL, c16FontURL] {
    var error: Unmanaged<CFError>?
    guard CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error) else {
        let message = error?.takeRetainedValue().localizedDescription ?? "unknown font-registration error"
        fail("Could not register \(fontURL.lastPathComponent): \(message)")
    }
}

func loadImage(_ url: URL) -> CGImage {
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(url.path)")
    }
    return image
}

let c13Raw = loadImage(c13RawURL)
let c16Raw = loadImage(c16RawURL)
guard c13Raw.width == 1162, c13Raw.height == 1353 else {
    fail("Expected the accepted clean Commander 2013 v3 raw artwork at 1162 × 1353")
}
guard c16Raw.width == 1162, c16Raw.height == 1353 else {
    fail("Expected the retained Commander 2016 raw artwork at 1162 × 1353")
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
    fail("Could not create sRGB split canvas")
}

context.interpolationQuality = .high

func drawPortraitPanelSection(
    image: CGImage,
    panel: CGRect,
    section: CGRect,
    focalSourceX: CGFloat,
    alpha: CGFloat = 1
) {
    let scale = CGFloat(canvasHeight) / CGFloat(image.height)
    let scaledWidth = CGFloat(image.width) * scale
    let focalScaledX = focalSourceX * scale
    let drawX = panel.midX - focalScaledX

    context.saveGState()
    context.clip(to: panel.intersection(section))
    context.setAlpha(alpha)
    context.draw(
        image,
        in: CGRect(x: drawX, y: 0, width: scaledWidth, height: CGFloat(canvasHeight))
    )
    context.restoreGState()
}

// Recompose each source independently for the much narrower half-panel.
// Commander 2013 uses two source focuses from the clean v3 art so both owned-deck leads
// survive the narrow crop: Oloro owns the lower throne and Jeleva the upper atmosphere.
// A deterministic 24-step painterly transition avoids a second hard seam inside the panel.
drawPortraitPanelSection(
    image: c13Raw,
    panel: CGRect(x: 0, y: 0, width: panelWidth, height: canvasHeight),
    section: CGRect(x: 0, y: 0, width: panelWidth, height: canvasHeight),
    focalSourceX: 520
)
let c13TransitionStart: CGFloat = 1180
let c13TransitionHeight: CGFloat = 420
let c13TransitionSteps = 24
for step in 0..<c13TransitionSteps {
    let bandHeight = c13TransitionHeight / CGFloat(c13TransitionSteps)
    let y = c13TransitionStart + CGFloat(step) * bandHeight
    drawPortraitPanelSection(
        image: c13Raw,
        panel: CGRect(x: 0, y: 0, width: panelWidth, height: canvasHeight),
        section: CGRect(x: 0, y: y, width: CGFloat(panelWidth), height: bandHeight + 1),
        focalSourceX: 820,
        alpha: CGFloat(step + 1) / CGFloat(c13TransitionSteps)
    )
}
drawPortraitPanelSection(
    image: c13Raw,
    panel: CGRect(x: 0, y: 0, width: panelWidth, height: canvasHeight),
    section: CGRect(x: 0, y: c13TransitionStart + c13TransitionHeight, width: CGFloat(panelWidth), height: CGFloat(canvasHeight) - c13TransitionStart - c13TransitionHeight),
    focalSourceX: 820
)
drawPortraitPanelSection(
    image: c16Raw,
    panel: CGRect(x: panelWidth, y: 0, width: panelWidth, height: canvasHeight),
    section: CGRect(x: panelWidth, y: 0, width: panelWidth, height: canvasHeight),
    focalSourceX: 580
)

let nearBlack = CGColor(srgbRed: 0.012, green: 0.015, blue: 0.025, alpha: 1)
let coldBlack = CGColor(srgbRed: 0.018, green: 0.027, blue: 0.043, alpha: 1)
let ivory = CGColor(srgbRed: 0.96, green: 0.94, blue: 0.84, alpha: 1)
let antiqueGold = CGColor(srgbRed: 0.78, green: 0.57, blue: 0.24, alpha: 1)
let paleGold = CGColor(srgbRed: 0.94, green: 0.80, blue: 0.48, alpha: 1)
let moonSilver = CGColor(srgbRed: 0.82, green: 0.83, blue: 0.82, alpha: 1)
let midnightBlue = CGColor(srgbRed: 0.14, green: 0.27, blue: 0.39, alpha: 1)
let etheriumCyan = CGColor(srgbRed: 0.42, green: 0.75, blue: 0.86, alpha: 1)
let carmotMagenta = CGColor(srgbRed: 0.88, green: 0.25, blue: 0.52, alpha: 1)

func drawPanelVignette(panelX: CGFloat, fromY: CGFloat, toY: CGFloat, topAlpha: CGFloat) {
    guard let gradient = CGGradient(
        colorsSpace: colorSpace,
        colors: [
            CGColor(srgbRed: 0.005, green: 0.008, blue: 0.018, alpha: topAlpha),
            CGColor(srgbRed: 0.008, green: 0.014, blue: 0.028, alpha: topAlpha * 0.40),
            CGColor(srgbRed: 0.008, green: 0.014, blue: 0.028, alpha: 0)
        ] as CFArray,
        locations: [0, 0.60, 1]
    ) else { return }

    context.saveGState()
    context.clip(to: CGRect(x: panelX, y: min(fromY, toY), width: CGFloat(panelWidth), height: abs(fromY - toY)))
    context.drawLinearGradient(
        gradient,
        start: CGPoint(x: panelX, y: fromY),
        end: CGPoint(x: panelX, y: toY),
        options: []
    )
    context.restoreGState()
}

func drawAtmosphericShadow(center: CGPoint, radiusX: CGFloat, radiusY: CGFloat, alpha: CGFloat) {
    guard let gradient = CGGradient(
        colorsSpace: colorSpace,
        colors: [
            CGColor(srgbRed: 0.006, green: 0.008, blue: 0.014, alpha: alpha),
            CGColor(srgbRed: 0.006, green: 0.008, blue: 0.014, alpha: alpha * 0.48),
            CGColor(srgbRed: 0.006, green: 0.008, blue: 0.014, alpha: 0)
        ] as CFArray,
        locations: [0, 0.58, 1]
    ) else { return }

    context.saveGState()
    context.translateBy(x: center.x, y: center.y)
    context.scaleBy(x: 1, y: radiusY / radiusX)
    context.drawRadialGradient(
        gradient,
        startCenter: .zero,
        startRadius: 0,
        endCenter: .zero,
        endRadius: radiusX,
        options: [.drawsAfterEndLocation]
    )
    context.restoreGState()
}

// Left identification sits in the natural smoky interval between Jeleva and Oloro. The
// feathered ellipse also dissolves the change in crop focus without a rectangular band.
drawAtmosphericShadow(center: CGPoint(x: 450, y: 1420), radiusX: 470, radiusY: 290, alpha: 0.72)
// Right identification uses the dark Etherium arch above Breya.
drawPanelVignette(panelX: 900, fromY: 2100, toY: 1560, topAlpha: 0.73)

func makeLinePath(
    _ text: String,
    fontName: String,
    initialFontSize: CGFloat,
    kern: CGFloat,
    baselineY: CGFloat,
    centerX: CGFloat,
    maxWidth: CGFloat
) -> CGPath {
    var fontSize = initialFontSize

    while fontSize >= 20 {
        let font = CTFontCreateWithName(fontName as CFString, fontSize, nil)
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
            for case let run as CTRun in CTLineGetGlyphRuns(line) as NSArray {
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
        fontSize -= 2
    }
    fail("Could not fit title line: \(text)")
}

func drawMetalText(
    path: CGPath,
    range: ClosedRange<CGFloat>,
    outlineWidth: CGFloat,
    rimWidth: CGFloat,
    keylineWidth: CGFloat,
    rim: CGColor,
    keyline: CGColor,
    colors: [CGColor],
    locations: [CGFloat],
    glow: CGColor
) {
    context.saveGState()
    context.setShadow(
        offset: CGSize(width: 0, height: -7),
        blur: 15,
        color: nearBlack.copy(alpha: 0.92)
    )
    context.addPath(path)
    context.setFillColor(nearBlack)
    context.fillPath()
    context.restoreGState()

    context.setLineJoin(.round)
    context.setLineCap(.round)
    context.addPath(path)
    context.setStrokeColor(nearBlack)
    context.setLineWidth(outlineWidth)
    context.strokePath()
    context.addPath(path)
    context.setStrokeColor(rim)
    context.setLineWidth(rimWidth)
    context.strokePath()
    context.addPath(path)
    context.setStrokeColor(keyline)
    context.setLineWidth(keylineWidth)
    context.strokePath()

    guard let gradient = CGGradient(
        colorsSpace: colorSpace,
        colors: colors as CFArray,
        locations: locations
    ) else { return }

    context.saveGState()
    context.addPath(path)
    context.clip()
    context.drawLinearGradient(
        gradient,
        start: CGPoint(x: 0, y: range.lowerBound),
        end: CGPoint(x: 0, y: range.upperBound),
        options: []
    )
    context.restoreGState()

    context.addPath(path)
    context.setStrokeColor(ivory.copy(alpha: 0.62)!)
    context.setLineWidth(1.3)
    context.strokePath()
    context.addPath(path)
    context.setStrokeColor(glow.copy(alpha: 0.26)!)
    context.setLineWidth(0.7)
    context.strokePath()
}

func drawOpenSilverText(path: CGPath, range: ClosedRange<CGFloat>, outlineWidth: CGFloat) {
    context.saveGState()
    context.setShadow(
        offset: CGSize(width: 0, height: -4),
        blur: 10,
        color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.78)
    )
    context.addPath(path)
    context.setStrokeColor(nearBlack)
    context.setLineWidth(outlineWidth + 4)
    context.strokePath()
    context.restoreGState()

    context.setLineJoin(.round)
    context.addPath(path)
    context.setStrokeColor(CGColor(srgbRed: 0.08, green: 0.085, blue: 0.095, alpha: 1))
    context.setLineWidth(outlineWidth)
    context.strokePath()

    guard let gradient = CGGradient(
        colorsSpace: colorSpace,
        colors: [
            CGColor(srgbRed: 0.70, green: 0.71, blue: 0.72, alpha: 1),
            CGColor(srgbRed: 0.82, green: 0.82, blue: 0.81, alpha: 1),
            CGColor(srgbRed: 0.94, green: 0.94, blue: 0.91, alpha: 1)
        ] as CFArray,
        locations: [0, 0.46, 1]
    ) else { return }

    context.saveGState()
    context.addPath(path)
    context.clip()
    context.drawLinearGradient(
        gradient,
        start: CGPoint(x: 0, y: range.lowerBound),
        end: CGPoint(x: 0, y: range.upperBound),
        options: []
    )
    context.restoreGState()

    context.addPath(path)
    context.setStrokeColor(moonSilver.copy(alpha: 0.78)!)
    context.setLineWidth(1.3)
    context.strokePath()
}

func drawOpenRule(panelX: CGFloat, y: CGFloat, centerX: CGFloat, gapHalfWidth: CGFloat, color: CGColor) {
    let leftStart = panelX + 65
    let leftEnd = centerX - gapHalfWidth
    let rightStart = centerX + gapHalfWidth
    let rightEnd = panelX + CGFloat(panelWidth) - 65

    for (start, end) in [(leftStart, leftEnd), (rightStart, rightEnd)] {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: start, y: y))
        path.addCurve(
            to: CGPoint(x: end, y: y),
            control1: CGPoint(x: start + (end - start) * 0.35, y: y + 11),
            control2: CGPoint(x: start + (end - start) * 0.65, y: y - 11)
        )
        context.addPath(path)
        context.setStrokeColor(nearBlack.copy(alpha: 0.92)!)
        context.setLineWidth(9)
        context.strokePath()
        context.addPath(path)
        context.setStrokeColor(color.copy(alpha: 0.88)!)
        context.setLineWidth(3)
        context.strokePath()
    }

    let diamond = CGMutablePath()
    diamond.move(to: CGPoint(x: centerX, y: y + 11))
    diamond.addLine(to: CGPoint(x: centerX + 11, y: y))
    diamond.addLine(to: CGPoint(x: centerX, y: y - 11))
    diamond.addLine(to: CGPoint(x: centerX - 11, y: y))
    diamond.closeSubpath()
    context.addPath(diamond)
    context.setFillColor(coldBlack)
    context.fillPath()
    context.addPath(diamond)
    context.setStrokeColor(color)
    context.setLineWidth(3)
    context.strokePath()
}

// Commander 2013: accepted v3 Alegreya SC Medium direction, rebuilt at half-panel scale.
let c13Commander = makeLinePath(
    "COMMANDER",
    fontName: "AlegreyaSC-Medium",
    initialFontSize: 150,
    kern: 3.5,
    baselineY: 1472,
    centerX: 450,
    maxWidth: 790
)
drawOpenSilverText(
    path: c13Commander,
    range: 1460...1588,
    outlineWidth: 5
)
let c13Year = makeLinePath(
    "2013",
    fontName: "AlegreyaSC-Medium",
    initialFontSize: 102,
    kern: 10,
    baselineY: 1342,
    centerX: 450,
    maxWidth: 280
)
drawOpenSilverText(
    path: c13Year,
    range: 1335...1430,
    outlineWidth: 4
)

// The accepted v3's two faint energy hairlines flank the year without forming a frame.
func drawC13EnergyHairline(from start: CGPoint, to end: CGPoint, color: CGColor, reverseFade: Bool) {
    let path = CGMutablePath()
    path.move(to: start)
    path.addCurve(
        to: end,
        control1: CGPoint(x: start.x + (end.x - start.x) * 0.36, y: start.y + 2),
        control2: CGPoint(x: start.x + (end.x - start.x) * 0.72, y: end.y - 2)
    )
    context.saveGState()
    context.addPath(path)
    context.setStrokeColor(nearBlack.copy(alpha: 0.70)!)
    context.setLineWidth(5)
    context.strokePath()
    context.addPath(path)
    context.setStrokeColor(color.copy(alpha: reverseFade ? 0.55 : 0.62)!)
    context.setLineWidth(1.4)
    context.strokePath()
    context.restoreGState()
}
drawC13EnergyHairline(
    from: CGPoint(x: 90, y: 1383),
    to: CGPoint(x: 305, y: 1383),
    color: etheriumCyan,
    reverseFade: false
)
drawC13EnergyHairline(
    from: CGPoint(x: 595, y: 1383),
    to: CGPoint(x: 810, y: 1383),
    color: carmotMagenta,
    reverseFade: true
)

// Commander 2016: preserve the approved v2 Cinzel/Etherium direction, rebuilt for a 900-pixel panel.
let c16Commander = makeLinePath(
    "COMMANDER",
    fontName: "CinzelDecorative-Black",
    initialFontSize: 112,
    kern: 0,
    baselineY: 1920,
    centerX: 1350,
    maxWidth: 780
)
drawMetalText(
    path: c16Commander,
    range: 1910...2020,
    outlineWidth: 22,
    rimWidth: 11,
    keylineWidth: 4,
    rim: antiqueGold,
    keyline: midnightBlue,
    colors: [antiqueGold, paleGold, ivory, etheriumCyan, coldBlack],
    locations: [0, 0.25, 0.54, 0.78, 1],
    glow: carmotMagenta
)
drawOpenRule(panelX: 900, y: 1832, centerX: 1350, gapHalfWidth: 145, color: antiqueGold)
let c16Year = makeLinePath(
    "2016",
    fontName: "CinzelDecorative-Black",
    initialFontSize: 150,
    kern: 2,
    baselineY: 1680,
    centerX: 1350,
    maxWidth: 400
)
drawMetalText(
    path: c16Year,
    range: 1670...1815,
    outlineWidth: 24,
    rimWidth: 11,
    keylineWidth: 5,
    rim: antiqueGold,
    keyline: midnightBlue,
    colors: [CGColor(srgbRed: 0.28, green: 0.20, blue: 0.09, alpha: 1), paleGold, ivory, antiqueGold],
    locations: [0, 0.32, 0.67, 1],
    glow: carmotMagenta
)

// One straight, narrow, high-contrast divider. No gutters or panel borders.
context.setFillColor(paleGold)
context.fill(CGRect(x: 897, y: 0, width: 6, height: canvasHeight))

guard let outputImage = context.makeImage() else {
    fail("Could not render split target")
}

try? FileManager.default.createDirectory(at: outputURL.deletingLastPathComponent(), withIntermediateDirectories: true)
guard let destination = CGImageDestinationCreateWithURL(
    outputURL as CFURL,
    UTType.png.identifier as CFString,
    1,
    nil
) else {
    fail("Could not create \(outputURL.path)")
}
let properties: [CFString: Any] = [
    kCGImagePropertyDPIWidth: outputDPI,
    kCGImagePropertyDPIHeight: outputDPI
]
CGImageDestinationAddImage(destination, outputImage, properties as CFDictionary)
guard CGImageDestinationFinalize(destination) else {
    fail("Could not finalize \(outputURL.path)")
}

guard let previewContext = CGContext(
    data: nil,
    width: 450,
    height: 525,
    bitsPerComponent: 8,
    bytesPerRow: 0,
    space: colorSpace,
    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
) else {
    fail("Could not create drawer preview")
}
previewContext.interpolationQuality = .high
previewContext.draw(outputImage, in: CGRect(x: 0, y: 0, width: 450, height: 525))
guard let previewImage = previewContext.makeImage(),
      let previewDestination = CGImageDestinationCreateWithURL(
        previewURL as CFURL,
        UTType.png.identifier as CFString,
        1,
        nil
      ) else {
    fail("Could not create drawer preview output")
}
CGImageDestinationAddImage(previewDestination, previewImage, nil)
guard CGImageDestinationFinalize(previewDestination) else {
    fail("Could not finalize drawer preview")
}

print("Wrote \(outputURL.path)")
print("Wrote \(previewURL.path)")
