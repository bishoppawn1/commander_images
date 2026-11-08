#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let cropRect = CGRect(x: 950, y: 5250, width: 3200, height: 1000)
private let padding = 24

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count == 3 else {
    fail("Usage: extract_official_commander_legends_wordmark.swift POSTER_PAGE1_600DPI.png OUTPUT.png")
}

let inputURL = URL(fileURLWithPath: CommandLine.arguments[1])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[2])

guard let source = CGImageSourceCreateWithURL(inputURL as CFURL, nil),
      let sourceImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
    fail("Could not read \(inputURL.path).")
}

guard sourceImage.width == 5100, sourceImage.height == 6600 else {
    fail("Expected a 5100 x 6600 page-1 raster; found \(sourceImage.width) x \(sourceImage.height).")
}

guard let crop = sourceImage.cropping(to: cropRect),
      let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
    fail("Could not crop the official wordmark area.")
}

let cropWidth = crop.width
let cropHeight = crop.height
let bytesPerRow = cropWidth * 4
var rgba = [UInt8](repeating: 0, count: cropHeight * bytesPerRow)

guard let cropContext = CGContext(
    data: &rgba,
    width: cropWidth,
    height: cropHeight,
    bitsPerComponent: 8,
    bytesPerRow: bytesPerRow,
    space: colorSpace,
    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
) else {
    fail("Could not create the extraction canvas.")
}
cropContext.draw(crop, in: CGRect(x: 0, y: 0, width: cropWidth, height: cropHeight))

var alpha = [UInt8](repeating: 0, count: cropWidth * cropHeight)
var minX = cropWidth
var minY = cropHeight
var maxX = -1
var maxY = -1

for y in 0..<cropHeight {
    for x in 0..<cropWidth {
        let offset = y * bytesPerRow + x * 4
        let minimumChannel = Int(min(rgba[offset], min(rgba[offset + 1], rgba[offset + 2])))
        // The official lockup is white on a uniform navy panel. Preserve its
        // anti-aliased edge while eliminating the panel and faint art above it.
        let value = UInt8(max(0, min(255, (minimumChannel - 48) * 255 / 150)))
        alpha[y * cropWidth + x] = value
        if value > 8 {
            minX = min(minX, x)
            minY = min(minY, y)
            maxX = max(maxX, x)
            maxY = max(maxY, y)
        }
    }
}

guard maxX >= minX, maxY >= minY else {
    fail("No wordmark pixels were detected.")
}

minX = max(0, minX - padding)
minY = max(0, minY - padding)
maxX = min(cropWidth - 1, maxX + padding)
maxY = min(cropHeight - 1, maxY + padding)

let outputWidth = maxX - minX + 1
let outputHeight = maxY - minY + 1
var outputPixels = [UInt8](repeating: 0, count: outputWidth * outputHeight * 4)

for y in 0..<outputHeight {
    for x in 0..<outputWidth {
        let extractedAlpha = alpha[(minY + y) * cropWidth + (minX + x)]
        let outputOffset = (y * outputWidth + x) * 4
        outputPixels[outputOffset] = extractedAlpha
        outputPixels[outputOffset + 1] = extractedAlpha
        outputPixels[outputOffset + 2] = extractedAlpha
        outputPixels[outputOffset + 3] = extractedAlpha
    }
}

guard let outputContext = CGContext(
    data: &outputPixels,
    width: outputWidth,
    height: outputHeight,
    bitsPerComponent: 8,
    bytesPerRow: outputWidth * 4,
    space: colorSpace,
    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
), let outputImage = outputContext.makeImage() else {
    fail("Could not create the transparent wordmark image.")
}

try? FileManager.default.createDirectory(
    at: outputURL.deletingLastPathComponent(),
    withIntermediateDirectories: true
)

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

print("Wrote \(outputURL.path) (\(outputWidth) x \(outputHeight))")
