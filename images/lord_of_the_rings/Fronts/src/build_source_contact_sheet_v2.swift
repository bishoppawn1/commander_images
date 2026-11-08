#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count >= 6,
      let columns = Int(CommandLine.arguments[2]), columns > 0,
      let cellWidth = Int(CommandLine.arguments[3]), cellWidth > 0,
      let cellHeight = Int(CommandLine.arguments[4]), cellHeight > 0 else {
    fail("Usage: build_source_contact_sheet_v2.swift OUTPUT.png COLUMNS CELL_WIDTH CELL_HEIGHT INPUT...")
}

let outputURL = URL(fileURLWithPath: CommandLine.arguments[1])
let inputPaths = Array(CommandLine.arguments.dropFirst(5))
let rows = Int(ceil(Double(inputPaths.count) / Double(columns)))
let canvasWidth = columns * cellWidth
let canvasHeight = rows * cellHeight

guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let context = CGContext(
        data: nil,
        width: canvasWidth,
        height: canvasHeight,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue
      ) else {
    fail("Could not create contact-sheet canvas.")
}

context.setFillColor(CGColor(srgbRed: 0.035, green: 0.025, blue: 0.022, alpha: 1.0))
context.fill(CGRect(x: 0, y: 0, width: canvasWidth, height: canvasHeight))
context.interpolationQuality = .high

for (index, path) in inputPaths.enumerated() {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fail("Could not read \(path).")
    }

    let column = index % columns
    let rowFromTop = index / columns
    let padding: CGFloat = 10
    let availableWidth = CGFloat(cellWidth) - 2 * padding
    let availableHeight = CGFloat(cellHeight) - 2 * padding
    let scale = min(availableWidth / CGFloat(image.width), availableHeight / CGFloat(image.height))
    let drawWidth = CGFloat(image.width) * scale
    let drawHeight = CGFloat(image.height) * scale
    let x = CGFloat(column * cellWidth) + (CGFloat(cellWidth) - drawWidth) / 2
    let y = CGFloat(canvasHeight - (rowFromTop + 1) * cellHeight) + (CGFloat(cellHeight) - drawHeight) / 2

    context.draw(image, in: CGRect(x: x, y: y, width: drawWidth, height: drawHeight))
}

guard let outputImage = context.makeImage(),
      let destination = CGImageDestinationCreateWithURL(
        outputURL as CFURL,
        UTType.png.identifier as CFString,
        1,
        nil
      ) else {
    fail("Could not create contact sheet.")
}

CGImageDestinationAddImage(destination, outputImage, nil)
guard CGImageDestinationFinalize(destination) else {
    fail("Could not finish writing \(outputURL.path).")
}

print("Wrote \(outputURL.path) with \(inputPaths.count) sources")
