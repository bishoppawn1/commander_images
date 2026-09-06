#!/usr/bin/env swift

import CoreGraphics
import CoreText
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let canvasWidth = 1650
private let canvasHeight = 1180
private let outputDPI = 600

enum ManaColor: String {
    case white = "WHITE"
    case blue = "BLUE"
    case black = "BLACK"
    case red = "RED"
    case green = "GREEN"
}

struct DeckLabel {
    let slug: String
    let deckName: String
    let deckNameLines: [String]
    let setName: String
    let artPath: String
    let colors: [ManaColor]
    let series: Int
}

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 3 else {
    fail("Usage: build_labels.swift REPOSITORY_ROOT OUTPUT_DIRECTORY")
}

let repositoryRoot = URL(fileURLWithPath: CommandLine.arguments[1]).standardizedFileURL
let outputDirectory = URL(fileURLWithPath: CommandLine.arguments[2]).standardizedFileURL

let labels: [DeckLabel] = [
    DeckLabel(
        slug: "heavenly_inferno",
        deckName: "HEAVENLY INFERNO",
        deckNameLines: ["HEAVENLY", "INFERNO"],
        setName: "COMMANDER ANTHOLOGY",
        artPath: "images/commander_anthology_deck_box_labels/src/regenerated_art_v2_7x5/kaalia_of_the_vast_regenerated_v2_7x5.png",
        colors: [.red, .white, .black],
        series: 1
    ),
    DeckLabel(
        slug: "evasive_maneuvers",
        deckName: "EVASIVE MANEUVERS",
        deckNameLines: ["EVASIVE", "MANEUVERS"],
        setName: "COMMANDER ANTHOLOGY",
        artPath: "images/commander_anthology_deck_box_labels/src/regenerated_art_v2_7x5/derevi_empyrial_tactician_regenerated_v2_7x5.png",
        colors: [.green, .white, .blue],
        series: 1
    ),
    DeckLabel(
        slug: "guided_by_nature",
        deckName: "GUIDED BY NATURE",
        deckNameLines: ["GUIDED BY", "NATURE"],
        setName: "COMMANDER ANTHOLOGY",
        artPath: "images/commander_anthology_deck_box_labels/src/regenerated_art_v2_7x5/freyalise_llanowars_fury_regenerated_v2_7x5.png",
        colors: [.green],
        series: 1
    ),
    DeckLabel(
        slug: "plunder_the_graves",
        deckName: "PLUNDER THE GRAVES",
        deckNameLines: ["PLUNDER THE", "GRAVES"],
        setName: "COMMANDER ANTHOLOGY",
        artPath: "images/commander_anthology_deck_box_labels/src/regenerated_art_v2_7x5/meren_of_clan_nel_toth_regenerated_v2_7x5.png",
        colors: [.black, .green],
        series: 1
    ),
    DeckLabel(
        slug: "devour_for_power",
        deckName: "DEVOUR FOR POWER",
        deckNameLines: ["DEVOUR FOR", "POWER"],
        setName: "COMMANDER ANTHOLOGY VOLUME II",
        artPath: "images/commander_anthology_deck_box_labels/src/regenerated_art_v2_7x5/the_mimeoplasm_regenerated_v2_7x5.png",
        colors: [.black, .green, .blue],
        series: 2
    ),
    DeckLabel(
        slug: "built_from_scratch",
        deckName: "BUILT FROM SCRATCH",
        deckNameLines: ["BUILT FROM", "SCRATCH"],
        setName: "COMMANDER ANTHOLOGY VOLUME II",
        artPath: "images/commander_anthology_deck_box_labels/src/regenerated_art_v2_7x5/daretti_scrap_savant_regenerated_v2_7x5.png",
        colors: [.red],
        series: 2
    ),
    DeckLabel(
        slug: "wade_into_battle",
        deckName: "WADE INTO BATTLE",
        deckNameLines: ["WADE INTO", "BATTLE"],
        setName: "COMMANDER ANTHOLOGY VOLUME II",
        artPath: "images/commander_anthology_deck_box_labels/src/regenerated_art_v2_7x5/kalemne_disciple_of_iroas_regenerated_v2_7x5.png",
        colors: [.red, .white],
        series: 2
    ),
    DeckLabel(
        slug: "breed_lethality",
        deckName: "BREED LETHALITY",
        deckNameLines: ["BREED", "LETHALITY"],
        setName: "COMMANDER ANTHOLOGY VOLUME II",
        artPath: "images/commander_anthology_deck_box_labels/src/regenerated_art_v2_7x5/atraxa_praetors_voice_regenerated_v2_7x5.png",
        colors: [.green, .white, .blue, .black],
        series: 2
    )
]

let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)!
let nearBlack = CGColor(srgbRed: 0.015, green: 0.018, blue: 0.024, alpha: 1)
let ivory = CGColor(srgbRed: 0.985, green: 0.965, blue: 0.90, alpha: 1)
let trueWhite = CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1)
let shadow = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.88)
let anthologyGold = CGColor(srgbRed: 0.83, green: 0.57, blue: 0.20, alpha: 1)
let anthologyPaleGold = CGColor(srgbRed: 0.98, green: 0.82, blue: 0.43, alpha: 1)
let anthologyGreen = CGColor(srgbRed: 0.17, green: 0.68, blue: 0.47, alpha: 1)
let anthologySilver = CGColor(srgbRed: 0.70, green: 0.87, blue: 0.79, alpha: 1)

func loadImage(_ url: URL) -> CGImage {
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(url.path)")
    }
    return image
}

func makeContext(width: Int, height: Int) -> CGContext {
    guard let context = CGContext(
        data: nil,
        width: width,
        height: height,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
        fail("Could not create an sRGB canvas")
    }
    context.interpolationQuality = .high
    return context
}

func drawAspectFill(_ image: CGImage, in bounds: CGRect, context: CGContext) {
    let scale = max(bounds.width / CGFloat(image.width), bounds.height / CGFloat(image.height))
    let drawWidth = CGFloat(image.width) * scale
    let drawHeight = CGFloat(image.height) * scale
    let rect = CGRect(
        x: bounds.midX - drawWidth / 2,
        y: bounds.midY - drawHeight / 2,
        width: drawWidth,
        height: drawHeight
    )
    context.draw(image, in: rect)
}

func drawVerticalGradient(
    context: CGContext,
    rect: CGRect,
    colors: [CGColor],
    locations: [CGFloat],
    startY: CGFloat,
    endY: CGFloat
) {
    guard let gradient = CGGradient(
        colorsSpace: colorSpace,
        colors: colors as CFArray,
        locations: locations
    ) else { return }
    context.saveGState()
    context.clip(to: rect)
    context.drawLinearGradient(
        gradient,
        start: CGPoint(x: rect.midX, y: startY),
        end: CGPoint(x: rect.midX, y: endY),
        options: [.drawsBeforeStartLocation, .drawsAfterEndLocation]
    )
    context.restoreGState()
}

func fontName(_ preferred: String, fallback: String) -> String {
    let font = CTFontCreateWithName(preferred as CFString, 24, nil)
    let actual = CTFontCopyPostScriptName(font) as String
    return actual.isEmpty ? fallback : preferred
}

let titleFontName = fontName("HelveticaNeue-CondensedBlack", fallback: "Helvetica-Bold")
let smallFontName = fontName("AvenirNextCondensed-DemiBold", fallback: "Helvetica-Bold")

func makeLine(
    _ text: String,
    fontName: String,
    startingSize: CGFloat,
    minimumSize: CGFloat,
    kern: CGFloat,
    maxWidth: CGFloat,
    fill: CGColor,
    stroke: CGColor,
    strokeWidth: CGFloat
) -> CTLine {
    var size = startingSize
    while size >= minimumSize {
        let font = CTFontCreateWithName(fontName as CFString, size, nil)
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(kCTFontAttributeName as String): font,
            NSAttributedString.Key(kCTForegroundColorAttributeName as String): fill,
            NSAttributedString.Key(kCTStrokeColorAttributeName as String): stroke,
            NSAttributedString.Key(kCTStrokeWidthAttributeName as String): strokeWidth,
            NSAttributedString.Key(kCTKernAttributeName as String): kern,
            NSAttributedString.Key(kCTLigatureAttributeName as String): 0
        ]
        let line = CTLineCreateWithAttributedString(NSAttributedString(string: text, attributes: attributes))
        let bounds = CTLineGetBoundsWithOptions(line, [.useGlyphPathBounds])
        if bounds.width <= maxWidth { return line }
        size -= 2
    }
    fail("Could not fit text: \(text)")
}

func drawCenteredLine(_ line: CTLine, centerX: CGFloat, baselineY: CGFloat, context: CGContext) {
    let bounds = CTLineGetBoundsWithOptions(line, [.useGlyphPathBounds])
    context.saveGState()
    context.setShadow(offset: CGSize(width: 0, height: -4), blur: 8, color: shadow)
    context.textPosition = CGPoint(x: centerX - bounds.midX, y: baselineY)
    CTLineDraw(line, context)
    context.restoreGState()
}

func pipColors(_ manaColor: ManaColor) -> (background: CGColor, rim: CGColor, glyph: CGColor) {
    switch manaColor {
    case .white:
        return (
            CGColor(srgbRed: 0.94, green: 0.87, blue: 0.66, alpha: 1),
            CGColor(srgbRed: 0.55, green: 0.43, blue: 0.23, alpha: 1),
            CGColor(srgbRed: 0.48, green: 0.36, blue: 0.15, alpha: 1)
        )
    case .blue:
        return (
            CGColor(srgbRed: 0.12, green: 0.48, blue: 0.72, alpha: 1),
            CGColor(srgbRed: 0.45, green: 0.80, blue: 0.96, alpha: 1),
            CGColor(srgbRed: 0.70, green: 0.91, blue: 1.0, alpha: 1)
        )
    case .black:
        return (
            CGColor(srgbRed: 0.13, green: 0.12, blue: 0.14, alpha: 1),
            CGColor(srgbRed: 0.48, green: 0.43, blue: 0.49, alpha: 1),
            CGColor(srgbRed: 0.76, green: 0.70, blue: 0.76, alpha: 1)
        )
    case .red:
        return (
            CGColor(srgbRed: 0.72, green: 0.16, blue: 0.12, alpha: 1),
            CGColor(srgbRed: 0.98, green: 0.45, blue: 0.23, alpha: 1),
            CGColor(srgbRed: 1.0, green: 0.70, blue: 0.38, alpha: 1)
        )
    case .green:
        return (
            CGColor(srgbRed: 0.10, green: 0.42, blue: 0.24, alpha: 1),
            CGColor(srgbRed: 0.34, green: 0.74, blue: 0.44, alpha: 1),
            CGColor(srgbRed: 0.63, green: 0.89, blue: 0.60, alpha: 1)
        )
    }
}

func drawSun(center: CGPoint, radius: CGFloat, context: CGContext, color: CGColor) {
    context.setStrokeColor(color)
    context.setLineWidth(8)
    for index in 0..<8 {
        let angle = CGFloat(index) * .pi / 4
        context.move(to: CGPoint(x: center.x + cos(angle) * radius * 0.43, y: center.y + sin(angle) * radius * 0.43))
        context.addLine(to: CGPoint(x: center.x + cos(angle) * radius * 0.70, y: center.y + sin(angle) * radius * 0.70))
    }
    context.strokePath()
    context.setFillColor(color)
    context.fillEllipse(in: CGRect(x: center.x - radius * 0.31, y: center.y - radius * 0.31, width: radius * 0.62, height: radius * 0.62))
}

func drawDrop(center: CGPoint, radius: CGFloat, context: CGContext, color: CGColor) {
    let path = CGMutablePath()
    path.move(to: CGPoint(x: center.x, y: center.y + radius * 0.70))
    path.addCurve(
        to: CGPoint(x: center.x, y: center.y - radius * 0.62),
        control1: CGPoint(x: center.x - radius * 0.12, y: center.y + radius * 0.32),
        control2: CGPoint(x: center.x - radius * 0.52, y: center.y - radius * 0.16)
    )
    path.addCurve(
        to: CGPoint(x: center.x, y: center.y + radius * 0.70),
        control1: CGPoint(x: center.x + radius * 0.52, y: center.y - radius * 0.16),
        control2: CGPoint(x: center.x + radius * 0.12, y: center.y + radius * 0.32)
    )
    context.addPath(path)
    context.setFillColor(color)
    context.fillPath()
}

func drawSkull(center: CGPoint, radius: CGFloat, context: CGContext, color: CGColor) {
    context.setFillColor(color)
    context.fillEllipse(in: CGRect(x: center.x - radius * 0.46, y: center.y - radius * 0.20, width: radius * 0.92, height: radius * 0.84))
    context.fill(CGRect(x: center.x - radius * 0.29, y: center.y - radius * 0.48, width: radius * 0.58, height: radius * 0.38))
    context.setFillColor(CGColor(gray: 0.08, alpha: 0.92))
    context.fillEllipse(in: CGRect(x: center.x - radius * 0.29, y: center.y + radius * 0.02, width: radius * 0.20, height: radius * 0.22))
    context.fillEllipse(in: CGRect(x: center.x + radius * 0.09, y: center.y + radius * 0.02, width: radius * 0.20, height: radius * 0.22))
    let nose = CGMutablePath()
    nose.move(to: CGPoint(x: center.x, y: center.y - radius * 0.04))
    nose.addLine(to: CGPoint(x: center.x - radius * 0.09, y: center.y - radius * 0.19))
    nose.addLine(to: CGPoint(x: center.x + radius * 0.09, y: center.y - radius * 0.19))
    nose.closeSubpath()
    context.addPath(nose)
    context.fillPath()
    context.setStrokeColor(CGColor(gray: 0.10, alpha: 0.9))
    context.setLineWidth(5)
    for xOffset in [-0.18, 0.0, 0.18] as [CGFloat] {
        context.move(to: CGPoint(x: center.x + radius * xOffset, y: center.y - radius * 0.46))
        context.addLine(to: CGPoint(x: center.x + radius * xOffset, y: center.y - radius * 0.23))
    }
    context.strokePath()
}

func drawFlame(center: CGPoint, radius: CGFloat, context: CGContext, color: CGColor) {
    let path = CGMutablePath()
    path.move(to: CGPoint(x: center.x - radius * 0.34, y: center.y - radius * 0.55))
    path.addCurve(
        to: CGPoint(x: center.x + radius * 0.10, y: center.y + radius * 0.72),
        control1: CGPoint(x: center.x - radius * 0.57, y: center.y - radius * 0.04),
        control2: CGPoint(x: center.x - radius * 0.08, y: center.y + radius * 0.23)
    )
    path.addCurve(
        to: CGPoint(x: center.x + radius * 0.43, y: center.y - radius * 0.25),
        control1: CGPoint(x: center.x + radius * 0.50, y: center.y + radius * 0.38),
        control2: CGPoint(x: center.x + radius * 0.56, y: center.y + radius * 0.03)
    )
    path.addCurve(
        to: CGPoint(x: center.x - radius * 0.34, y: center.y - radius * 0.55),
        control1: CGPoint(x: center.x + radius * 0.26, y: center.y - radius * 0.62),
        control2: CGPoint(x: center.x - radius * 0.08, y: center.y - radius * 0.69)
    )
    context.addPath(path)
    context.setFillColor(color)
    context.fillPath()
}

func drawTree(center: CGPoint, radius: CGFloat, context: CGContext, color: CGColor) {
    context.setFillColor(color)
    context.fill(CGRect(x: center.x - radius * 0.10, y: center.y - radius * 0.60, width: radius * 0.20, height: radius * 0.70))
    context.fillEllipse(in: CGRect(x: center.x - radius * 0.48, y: center.y - radius * 0.04, width: radius * 0.96, height: radius * 0.73))
    context.fillEllipse(in: CGRect(x: center.x - radius * 0.34, y: center.y + radius * 0.21, width: radius * 0.68, height: radius * 0.51))
    let roots = CGMutablePath()
    roots.move(to: CGPoint(x: center.x, y: center.y - radius * 0.43))
    roots.addLine(to: CGPoint(x: center.x - radius * 0.31, y: center.y - radius * 0.66))
    roots.addLine(to: CGPoint(x: center.x + radius * 0.31, y: center.y - radius * 0.66))
    roots.closeSubpath()
    context.addPath(roots)
    context.fillPath()
}

func drawPip(_ manaColor: ManaColor, center: CGPoint, diameter: CGFloat, context: CGContext) {
    let symbolCode: String
    switch manaColor {
    case .white: symbolCode = "W"
    case .blue: symbolCode = "U"
    case .black: symbolCode = "B"
    case .red: symbolCode = "R"
    case .green: symbolCode = "G"
    }

    let symbolURL = repositoryRoot
        .appendingPathComponent("images/commander_anthology_deck_box_labels/src/mana_symbols")
        .appendingPathComponent("\(symbolCode).png")
    let symbol = loadImage(symbolURL)
    let rect = CGRect(
        x: center.x - diameter / 2,
        y: center.y - diameter / 2,
        width: diameter,
        height: diameter
    )

    context.saveGState()
    context.setShadow(offset: CGSize(width: 0, height: -5), blur: 12, color: shadow)
    context.draw(symbol, in: rect)
    context.restoreGState()
}

func blendedWash(for colors: [ManaColor], alpha: CGFloat) -> CGColor {
    let components: [ManaColor: (CGFloat, CGFloat, CGFloat)] = [
        .white: (0.80, 0.69, 0.39),
        .blue: (0.08, 0.42, 0.72),
        .black: (0.16, 0.10, 0.19),
        .red: (0.72, 0.12, 0.09),
        .green: (0.08, 0.43, 0.21)
    ]
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    for color in colors {
        let value = components[color]!
        red += value.0
        green += value.1
        blue += value.2
    }
    let count = CGFloat(colors.count)
    return CGColor(srgbRed: red / count, green: green / count, blue: blue / count, alpha: alpha)
}

func writePNG(_ image: CGImage, to url: URL, dpi: Int) {
    try? FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
    guard let destination = CGImageDestinationCreateWithURL(
        url as CFURL,
        UTType.png.identifier as CFString,
        1,
        nil
    ) else {
        fail("Could not create \(url.path)")
    }
    let properties: [CFString: Any] = [
        kCGImagePropertyDPIWidth: dpi,
        kCGImagePropertyDPIHeight: dpi,
        kCGImagePropertyPNGDictionary: [kCGImagePropertyPNGTitle: url.deletingPathExtension().lastPathComponent]
    ]
    CGImageDestinationAddImage(destination, image, properties as CFDictionary)
    guard CGImageDestinationFinalize(destination) else {
        fail("Could not finish writing \(url.path)")
    }
}

func renderLabel(_ label: DeckLabel) -> CGImage {
    let context = makeContext(width: canvasWidth, height: canvasHeight)
    let bounds = CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight)
    context.setFillColor(nearBlack)
    context.fill(bounds)

    let art = loadImage(repositoryRoot.appendingPathComponent(label.artPath))
    drawAspectFill(art, in: bounds, context: context)

    // Lift shadow detail before applying the color-family wash. The source art is
    // already crisp; this brightens it without introducing another generation or
    // enlarging a low-resolution intermediate.
    let isBreedLethality = label.slug == "breed_lethality"
    context.setBlendMode(.screen)
    context.setFillColor(CGColor(
        srgbRed: isBreedLethality ? 0.86 : 0.72,
        green: isBreedLethality ? 0.89 : 0.78,
        blue: isBreedLethality ? 0.94 : 0.86,
        alpha: isBreedLethality ? 0.30 : 0.12
    ))
    context.fill(bounds)
    context.setBlendMode(.normal)

    context.setBlendMode(.color)
    context.setFillColor(blendedWash(for: label.colors, alpha: 0.13))
    context.fill(bounds)
    context.setBlendMode(.normal)

    drawVerticalGradient(
        context: context,
        rect: bounds,
        colors: [
            CGColor(srgbRed: 0.005, green: 0.008, blue: 0.014, alpha: isBreedLethality ? 0.34 : 0.54),
            CGColor(srgbRed: 0.005, green: 0.008, blue: 0.014, alpha: isBreedLethality ? 0.09 : 0.16),
            CGColor(srgbRed: 0.005, green: 0.008, blue: 0.014, alpha: 0.00)
        ],
        locations: [0, 0.54, 1],
        startY: 1180,
        endY: 730
    )
    drawVerticalGradient(
        context: context,
        rect: bounds,
        colors: [
            CGColor(srgbRed: 0.004, green: 0.006, blue: 0.010, alpha: isBreedLethality ? 0.46 : 0.70),
            CGColor(srgbRed: 0.004, green: 0.006, blue: 0.010, alpha: isBreedLethality ? 0.22 : 0.40),
            CGColor(srgbRed: 0.004, green: 0.006, blue: 0.010, alpha: 0.02)
        ],
        locations: [0, 0.47, 1],
        startY: 0,
        endY: 760
    )

    let accent = label.series == 1 ? anthologyGold : anthologyGreen
    let accentHighlight = label.series == 1 ? anthologyPaleGold : anthologySilver
    context.setStrokeColor(nearBlack)
    context.setLineWidth(36)
    context.stroke(bounds.insetBy(dx: 18, dy: 18))
    context.setStrokeColor(accent)
    context.setLineWidth(14)
    context.stroke(bounds.insetBy(dx: 34, dy: 34))
    context.setStrokeColor(accentHighlight.copy(alpha: 0.82)!)
    context.setLineWidth(4)
    context.stroke(bounds.insetBy(dx: 47, dy: 47))

    let pipDiameter: CGFloat = 200
    let pipGap: CGFloat = 32
    let totalPipWidth = CGFloat(label.colors.count) * pipDiameter + CGFloat(max(0, label.colors.count - 1)) * pipGap
    var pipX = CGFloat(canvasWidth) / 2 - totalPipWidth / 2 + pipDiameter / 2
    for manaColor in label.colors {
        drawPip(manaColor, center: CGPoint(x: pipX, y: 1015), diameter: pipDiameter, context: context)
        pipX += pipDiameter + pipGap
    }

    let titleBaselines: [CGFloat] = [520, 330]
    for (index, titleText) in label.deckNameLines.enumerated() {
        let deckLine = makeLine(
            titleText,
            fontName: titleFontName,
            startingSize: 224,
            minimumSize: 168,
            kern: 1.4,
            maxWidth: 1460,
            fill: ivory,
            stroke: nearBlack,
            strokeWidth: -4.8
        )
        drawCenteredLine(deckLine, centerX: 825, baselineY: titleBaselines[index], context: context)
    }

    context.setStrokeColor(accent.copy(alpha: 0.90)!)
    context.setLineWidth(6)
    context.move(to: CGPoint(x: 120, y: 245))
    context.addLine(to: CGPoint(x: 1530, y: 245))
    context.strokePath()

    let setLines = label.series == 1 ? [label.setName] : ["COMMANDER ANTHOLOGY", "VOLUME II"]
    let setBaselines: [CGFloat] = label.series == 1 ? [122] : [151, 70]
    for (index, setText) in setLines.enumerated() {
        let setLine = makeLine(
            setText,
            fontName: titleFontName,
            startingSize: index == 0 ? 94 : 76,
            minimumSize: index == 0 ? 80 : 68,
            kern: 2.8,
            maxWidth: 1460,
            fill: trueWhite,
            stroke: nearBlack,
            strokeWidth: -1.8
        )
        drawCenteredLine(setLine, centerX: 825, baselineY: setBaselines[index], context: context)
    }

    guard let image = context.makeImage() else { fail("Could not render \(label.slug)") }
    return image
}

try? FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true)
var rendered: [(DeckLabel, CGImage)] = []
for label in labels {
    let image = renderLabel(label)
    let outputURL = outputDirectory.appendingPathComponent("\(label.slug)_boulder_top_label_bright_1650x1180_600dpi.png")
    writePNG(image, to: outputURL, dpi: outputDPI)
    rendered.append((label, image))
    print("Wrote \(outputURL.path)")
}

let previewWidth = 1580
let previewHeight = 2300
let previewContext = makeContext(width: previewWidth, height: previewHeight)
previewContext.setFillColor(CGColor(srgbRed: 0.035, green: 0.040, blue: 0.050, alpha: 1))
previewContext.fill(CGRect(x: 0, y: 0, width: previewWidth, height: previewHeight))
let previewCellWidth: CGFloat = 750
let previewCellHeight: CGFloat = 536
let margin: CGFloat = 20
let rowGap: CGFloat = 30

for (index, item) in rendered.enumerated() {
    let column = index % 2
    let row = index / 2
    let x = margin + CGFloat(column) * (previewCellWidth + 40)
    let y = CGFloat(previewHeight) - margin - previewCellHeight - CGFloat(row) * (previewCellHeight + rowGap)
    previewContext.saveGState()
    previewContext.setShadow(offset: CGSize(width: 0, height: -5), blur: 12, color: shadow)
    previewContext.draw(item.1, in: CGRect(x: x, y: y, width: previewCellWidth, height: previewCellHeight))
    previewContext.restoreGState()
}

guard let previewImage = previewContext.makeImage() else { fail("Could not render the contact sheet") }
let previewURL = outputDirectory.appendingPathComponent("commander_anthology_boulder_labels_bright_contact_sheet.png")
writePNG(previewImage, to: previewURL, dpi: 144)
print("Wrote \(previewURL.path)")
