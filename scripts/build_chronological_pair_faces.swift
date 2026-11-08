#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let canvasWidth = 1800
private let canvasHeight = 2100
private let panelWidth = 900
private let outputDPI = 600
private let dividerWidth = 6

struct PairSpec {
    let leftPanel: String
    let rightPanel: String
    let output: String
}

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("ERROR: \(message)\n".utf8))
    exit(1)
}

func load(_ path: String, width: Int, height: Int) -> CGImage {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(path)")
    }
    guard image.width == width, image.height == height else {
        fail("\(path): expected \(width)x\(height); found \(image.width)x\(image.height)")
    }
    return image
}

func writePNG(_ image: CGImage, to path: String) {
    let url = URL(fileURLWithPath: path)
    guard !FileManager.default.fileExists(atPath: path) else {
        fail("Refusing to overwrite existing output: \(path)")
    }
    do {
        try FileManager.default.createDirectory(
            at: url.deletingLastPathComponent(),
            withIntermediateDirectories: true
        )
    } catch {
        fail("Could not create the output directory for \(path): \(error)")
    }
    guard let destination = CGImageDestinationCreateWithURL(
        url as CFURL,
        UTType.png.identifier as CFString,
        1,
        nil
    ) else {
        fail("Could not create \(path)")
    }
    let properties: CFDictionary = [
        kCGImagePropertyDPIWidth: outputDPI,
        kCGImagePropertyDPIHeight: outputDPI,
        kCGImagePropertyPNGDictionary: [kCGImagePropertyPNGInterlaceType: 0]
    ] as CFDictionary
    CGImageDestinationAddImage(destination, image, properties)
    guard CGImageDestinationFinalize(destination) else {
        fail("Could not finish \(path)")
    }
    print("WROTE \(path)")
}

func compose(_ spec: PairSpec) {
    let left = load(spec.leftPanel, width: panelWidth, height: canvasHeight)
    let right = load(spec.rightPanel, width: panelWidth, height: canvasHeight)
    let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)!
    guard let context = CGContext(
        data: nil,
        width: canvasWidth,
        height: canvasHeight,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
        fail("Could not create the output canvas for \(spec.output)")
    }
    context.interpolationQuality = .none
    context.draw(left, in: CGRect(x: 0, y: 0, width: panelWidth, height: canvasHeight))
    context.draw(right, in: CGRect(x: panelWidth, y: 0, width: panelWidth, height: canvasHeight))

    let antiqueGold = CGColor(srgbRed: 0.83, green: 0.63, blue: 0.27, alpha: 1)
    context.setFillColor(antiqueGold)
    context.fill(
        CGRect(
            x: panelWidth - dividerWidth / 2,
            y: 0,
            width: dividerWidth,
            height: canvasHeight
        )
    )
    guard let output = context.makeImage() else {
        fail("Could not render \(spec.output)")
    }
    writePNG(output, to: spec.output)
}

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).standardizedFileURL.path
func path(_ relative: String) -> String { root + "/" + relative }

let panels = [
    path("images/commander_2013/Fronts/commander_2013_commander_2016/src/approved_panels/commander_2013_approved_left_panel_900x2100.png"),
    path("images/commander_2013/Fronts/commander_2013_commander_2016/src/approved_panels/commander_2016_approved_right_panel_900x2100.png"),
    path("images/zendikar_rising/Fronts/zendikar_rising_commander_legends/src/approved_panels/zendikar_rising_approved_panel_900x2100.png"),
    path("images/zendikar_rising/Fronts/zendikar_rising_commander_legends/src/approved_panels/commander_legends_approved_panel_900x2100.png"),
    path("images/kamigawa_neon_dynasty/Fronts/kamigawa_neon_dynasty_brothers_war/src/approved_panels/kamigawa_neon_dynasty_approved_panel_900x2100.png"),
    path("images/kamigawa_neon_dynasty/Fronts/kamigawa_neon_dynasty_brothers_war/src/approved_panels/brothers_war_approved_panel_900x2100.png"),
    path("images/phyrexia_all_will_be_one/Fronts/phyrexia_all_will_be_one_wilds_of_eldraine/src/approved_panels/phyrexia_all_will_be_one_approved_panel_900x2100.png"),
    path("images/phyrexia_all_will_be_one/Fronts/phyrexia_all_will_be_one_wilds_of_eldraine/src/approved_panels/wilds_of_eldraine_approved_panel_900x2100.png")
]

for panel in panels { _ = load(panel, width: panelWidth, height: canvasHeight) }

let pairs = [
    PairSpec(
        leftPanel: panels[0],
        rightPanel: panels[1],
        output: path("images/commander_2013/Fronts/commander_2013_commander_2016/commander_2013_commander_2016_vertical_split_chronological_v2_1800x2100.png")
    ),
    PairSpec(
        leftPanel: panels[2],
        rightPanel: panels[3],
        output: path("images/zendikar_rising/Fronts/zendikar_rising_commander_legends/zendikar_rising_commander_legends_vertical_split_v1_1800x2100.png")
    ),
    PairSpec(
        leftPanel: panels[4],
        rightPanel: panels[5],
        output: path("images/kamigawa_neon_dynasty/Fronts/kamigawa_neon_dynasty_brothers_war/kamigawa_neon_dynasty_brothers_war_vertical_split_v1_1800x2100.png")
    ),
    PairSpec(
        leftPanel: panels[6],
        rightPanel: panels[7],
        output: path("images/phyrexia_all_will_be_one/Fronts/phyrexia_all_will_be_one_wilds_of_eldraine/phyrexia_all_will_be_one_wilds_of_eldraine_vertical_split_v1_1800x2100.png")
    )
]

for pair in pairs { compose(pair) }
print("DONE: built four chronological pair bases from eight retained approved panels.")
