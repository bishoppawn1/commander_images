#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 6 else {
    fail("Usage: build_v1_v2_comparison.swift V1.png V2.png OUTPUT.png PANEL_WIDTH PANEL_HEIGHT")
}

func load(_ path: String) -> CGImage {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(path)")
    }
    return image
}

let v1 = load(CommandLine.arguments[1])
let v2 = load(CommandLine.arguments[2])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[3])
guard let panelWidth = Int(CommandLine.arguments[4]),
      let panelHeight = Int(CommandLine.arguments[5]),
      panelWidth > 0, panelHeight > 0 else {
    fail("Panel dimensions must be positive integers")
}

guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(
        data: nil,
        width: panelWidth * 2,
        height: panelHeight,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
      ) else {
    fail("Could not create comparison canvas")
}

context.interpolationQuality = .high
context.draw(v1, in: CGRect(x: 0, y: 0, width: panelWidth, height: panelHeight))
context.draw(v2, in: CGRect(x: panelWidth, y: 0, width: panelWidth, height: panelHeight))

context.setFillColor(CGColor(srgbRed: 0.83, green: 0.63, blue: 0.27, alpha: 0.95))
context.fill(CGRect(x: CGFloat(panelWidth) - 2, y: 0, width: 4, height: CGFloat(panelHeight)))

guard let comparison = context.makeImage(),
      let destination = CGImageDestinationCreateWithURL(
        outputURL as CFURL,
        UTType.png.identifier as CFString,
        1,
        nil
      ) else {
    fail("Could not create comparison output")
}
CGImageDestinationAddImage(destination, comparison, nil)
guard CGImageDestinationFinalize(destination) else {
    fail("Could not finalize comparison output")
}

print("Wrote \(outputURL.path)")
