#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 7,
      let panelWidth = Int(CommandLine.arguments[4]),
      let panelHeight = Int(CommandLine.arguments[5]),
      panelWidth > 0,
      panelHeight > 0 else {
    fail("Usage: build_commander_legends_typography_qa_triptych.swift V4.png V1.png V2.png PANEL_WIDTH PANEL_HEIGHT OUTPUT.png")
}

func loadImage(_ path: String) -> CGImage {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(path).")
    }
    return image
}

let images = CommandLine.arguments[1...3].map { loadImage(String($0)) }
for image in images where image.width != 1800 || image.height != 2100 {
    fail("Every comparison input must be an 1800 x 2100 target.")
}

guard panelWidth * 7 == panelHeight * 6 else {
    fail("Each panel must preserve the exact 6:7 aspect ratio.")
}

guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(
        data: nil,
        width: panelWidth * 3,
        height: panelHeight,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
      ) else {
    fail("Could not create the comparison canvas.")
}

context.interpolationQuality = .high
for (index, image) in images.enumerated() {
    context.draw(
        image,
        in: CGRect(x: index * panelWidth, y: 0, width: panelWidth, height: panelHeight)
    )
}

guard let outputImage = context.makeImage() else {
    fail("Could not render the comparison image.")
}

let outputURL = URL(fileURLWithPath: CommandLine.arguments[6])
guard let destination = CGImageDestinationCreateWithURL(
    outputURL as CFURL,
    UTType.png.identifier as CFString,
    1,
    nil
) else {
    fail("Could not create \(outputURL.path).")
}

CGImageDestinationAddImage(destination, outputImage, nil)
guard CGImageDestinationFinalize(destination) else {
    fail("Could not finish writing \(outputURL.path).")
}

print("Wrote \(outputURL.path) (\(panelWidth * 3) x \(panelHeight))")
