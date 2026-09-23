#!/usr/bin/env swift
// Shared annual-release typography: one exact plaque geometry and text treatment.
import CoreGraphics
import CoreText
import Foundation
import ImageIO
import UniformTypeIdentifiers

func fail(_ text: String) -> Never { FileHandle.standardError.write(Data((text + "\n").utf8)); exit(1) }
let args = CommandLine.arguments
guard args.count == 4 || args.count == 5 else { fail("Usage: build_unified_annual_titles.swift INPUT OUTPUT YEAR|split|none [TITLE_CENTER_Y]") }
// Default preserves the prior lower placement for reproducibility. Current
// centered releases explicitly pass 1050 (half the 2100-pixel canvas height).
let titleCenterY: CGFloat
if args.count == 5 {
    guard let value = Double(args[4]), value >= 160, value <= 1850 else { fail("Invalid title center") }
    titleCenterY = CGFloat(value)
} else { titleCenterY = 1625 }
let titleOffsetY = 1625 - titleCenterY
let source = CGImageSourceCreateWithURL(URL(fileURLWithPath: args[1]) as CFURL, nil)!
let input = CGImageSourceCreateImageAtIndex(source, 0, nil)!
guard !FileManager.default.fileExists(atPath: args[2]) else { fail("Output already exists") }
let space = CGColorSpace(name: CGColorSpace.sRGB)!
let ctx = CGContext(data: nil, width: 1800, height: 2100, bitsPerComponent: 8, bytesPerRow: 0, space: space, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
ctx.interpolationQuality = .high
ctx.draw(input, in: CGRect(x: 0, y: 0, width: 1800, height: 2100))
func color(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) -> CGColor { CGColor(srgbRed: r, green: g, blue: b, alpha: a) }
let ink = color(0.025, 0.030, 0.034)
let darkGold = color(0.28, 0.17, 0.055)
let gold = color(0.72, 0.52, 0.24)
let paleGold = color(0.96, 0.85, 0.58)

func gradient(_ path: CGPath, _ colors: [CGColor], _ rect: CGRect) {
    ctx.saveGState(); ctx.addPath(path); ctx.clip()
    let grad = CGGradient(colorsSpace: space, colors: colors as CFArray, locations: nil)!
    ctx.drawLinearGradient(grad, start: CGPoint(x: rect.midX, y: rect.minY), end: CGPoint(x: rect.midX, y: rect.maxY), options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
    ctx.restoreGState()
}
func stroke(_ path: CGPath, _ color: CGColor, _ width: CGFloat) {
    ctx.addPath(path); ctx.setStrokeColor(color); ctx.setLineWidth(width); ctx.strokePath()
}
func plaqueShape(_ rect: CGRect, _ corner: CGFloat) -> CGPath {
    let p = CGMutablePath()
    p.move(to: CGPoint(x: rect.minX + corner, y: rect.minY))
    p.addLine(to: CGPoint(x: rect.maxX - corner, y: rect.minY))
    p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + corner))
    p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - corner))
    p.addLine(to: CGPoint(x: rect.maxX - corner, y: rect.maxY))
    p.addLine(to: CGPoint(x: rect.minX + corner, y: rect.maxY))
    p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - corner))
    p.addLine(to: CGPoint(x: rect.minX, y: rect.minY + corner))
    p.closeSubpath(); return p
}
func plaque(_ x: CGFloat, _ width: CGFloat) {
    // Centered releases: top-down y=935...1165, between portrait rows.
    let rect = CGRect(x: x, y: 360 + titleOffsetY, width: width, height: 230)
    let outer = plaqueShape(rect, 29)
    ctx.saveGState(); ctx.setShadow(offset: CGSize(width: 0, height: -9), blur: 17, color: color(0,0,0,0.9))
    ctx.addPath(outer); ctx.setFillColor(ink); ctx.fillPath(); ctx.restoreGState()
    gradient(outer, [color(0.025,0.029,0.035),color(0.085,0.09,0.095),color(0.032,0.037,0.042)], rect)
    stroke(outer, color(0.012,0.012,0.014), 15)
    stroke(outer, darkGold, 10)
    stroke(outer, gold, 6)
    stroke(plaqueShape(rect.insetBy(dx: 11, dy: 11), 22), paleGold.copy(alpha: 0.72)!, 1.7)
    // Small symmetric engraved corner accents, identical for every release.
    for edgeX in [rect.minX + 34, rect.maxX - 34] {
        let p = CGMutablePath()
        p.move(to: CGPoint(x: edgeX, y: rect.midY + 13)); p.addLine(to: CGPoint(x: edgeX + 7, y: rect.midY))
        p.addLine(to: CGPoint(x: edgeX, y: rect.midY - 13)); p.addLine(to: CGPoint(x: edgeX - 7, y: rect.midY)); p.closeSubpath()
        ctx.addPath(p); ctx.setFillColor(gold); ctx.fillPath()
    }
}
func glyphPath(_ text: String, _ size: CGFloat, _ cx: CGFloat, _ cy: CGFloat) -> CGPath {
    let font = CTFontCreateWithName("Baskerville-Bold" as CFString, size, nil)
    let attr: [NSAttributedString.Key: Any] = [.init(kCTFontAttributeName as String): font, .init(kCTKernAttributeName as String): 1.5, .init(kCTLigatureAttributeName as String): 0]
    let line = CTLineCreateWithAttributedString(NSAttributedString(string: text, attributes: attr))
    let bounds = CTLineGetBoundsWithOptions(line, [.useGlyphPathBounds])
    let p = CGMutablePath()
    for case let run as CTRun in CTLineGetGlyphRuns(line) as NSArray {
        let count = CTRunGetGlyphCount(run)
        var glyphs = [CGGlyph](repeating: 0, count: count)
        var positions = [CGPoint](repeating: .zero, count: count)
        CTRunGetGlyphs(run, CFRange(location: 0, length: 0), &glyphs)
        CTRunGetPositions(run, CFRange(location: 0, length: 0), &positions)
        for i in 0..<count {
            if let glyph = CTFontCreatePathForGlyph(font, glyphs[i], nil) {
                p.addPath(glyph, transform: CGAffineTransform(translationX: cx - bounds.midX + positions[i].x, y: cy - bounds.midY + positions[i].y))
            }
        }
    }
    return p
}
func lettering(_ text: String, _ size: CGFloat, _ cx: CGFloat, _ cy: CGFloat, _ maxWidth: CGFloat) {
    var fittedSize = size
    var path = glyphPath(text, fittedSize, cx, cy)
    while path.boundingBoxOfPath.width > maxWidth {
        fittedSize -= 1
        path = glyphPath(text, fittedSize, cx, cy)
    }
    ctx.saveGState(); ctx.setShadow(offset: CGSize(width: 0, height: -4), blur: 5, color: color(0,0,0))
    ctx.addPath(path); ctx.setFillColor(ink); ctx.fillPath(); ctx.restoreGState()
    stroke(path, color(0.015,0.012,0.007), 9)
    stroke(path, gold, 4)
    gradient(path, [color(0.74,0.56,0.28),color(0.96,0.85,0.62),color(1,0.96,0.82)], path.boundingBoxOfPath)
    stroke(path, color(1,0.93,0.71,0.65), 0.8)
    print("TITLE \(text) size \(fittedSize), glyph bounds \(path.boundingBoxOfPath)")
}
if args[3] == "split" {
    for (x, year) in [(CGFloat(450), "2013"), (CGFloat(1350), "2016")] {
        plaque(x - 404, 808)
        lettering("COMMANDER", 103, x, 520 + titleOffsetY, 710)
        lettering(year, 124, x, 425 + titleOffsetY, 710)
    }
    ctx.setFillColor(gold); ctx.fill(CGRect(x: 897, y: 0, width: 6, height: 2100))
} else if args[3] != "none" {
    guard ["2017","2018","2019"].contains(args[3]) else { fail("Invalid year") }
    plaque(62, 1676)
    lettering("COMMANDER " + args[3], 175, 900, 475 + titleOffsetY, 1510)
}
let out = ctx.makeImage()!
let dest = CGImageDestinationCreateWithURL(URL(fileURLWithPath: args[2]) as CFURL, UTType.png.identifier as CFString, 1, nil)!
CGImageDestinationAddImage(dest, out, [kCGImagePropertyDPIWidth:600,kCGImagePropertyDPIHeight:600] as CFDictionary)
guard CGImageDestinationFinalize(dest) else { fail("Write failed") }
print("WROTE \(args[2])")
