#!/usr/bin/env swift

import AppKit
import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

private let sourceWidth = 1724
private let sourceHeight = 2024
private let sourceDPI = 600.0
private let outputWidth = 4138
private let outputHeight = 4858
private let outputDPI = 1440.0
private let sourceSuffix = "_1724x2024_black_margin_1_8in.png"
private let outputSuffix = "_4138x4858_1440dpi_black_margin_1_8in.png"

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("ERROR: \(message)\n".utf8))
    exit(1)
}

func number(_ properties: CFDictionary, _ key: CFString) -> Double? {
    let dictionary = properties as NSDictionary
    return (dictionary[key] as? NSNumber)?.doubleValue
}

func render1440DPI(_ inputURL: URL) {
    guard inputURL.lastPathComponent.hasSuffix(sourceSuffix) else {
        fail("Unexpected source filename: \(inputURL.path)")
    }
    guard let source = CGImageSourceCreateWithURL(inputURL as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil),
          let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) else {
        fail("Could not read \(inputURL.path)")
    }
    guard image.width == sourceWidth, image.height == sourceHeight else {
        fail("\(inputURL.path): expected \(sourceWidth)x\(sourceHeight); found \(image.width)x\(image.height)")
    }
    let dpiX = number(properties, kCGImagePropertyDPIWidth) ?? -1
    let dpiY = number(properties, kCGImagePropertyDPIHeight) ?? -1
    guard abs(dpiX - sourceDPI) < 0.01, abs(dpiY - sourceDPI) < 0.01 else {
        fail("\(inputURL.path): expected 600x600 DPI; found \(dpiX)x\(dpiY)")
    }

    let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)!
    guard let context = CGContext(
        data: nil,
        width: outputWidth,
        height: outputHeight,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
        fail("Could not create the output context for \(inputURL.path)")
    }
    context.interpolationQuality = .high
    context.draw(image, in: CGRect(x: 0, y: 0, width: outputWidth, height: outputHeight))
    guard let rendered = context.makeImage() else {
        fail("Could not render \(inputURL.path)")
    }

    let outputName = inputURL.lastPathComponent.replacingOccurrences(
        of: sourceSuffix,
        with: outputSuffix
    )
    let outputURL = inputURL.deletingLastPathComponent().appendingPathComponent(outputName)
    guard !FileManager.default.fileExists(atPath: outputURL.path) else {
        fail("Refusing to overwrite existing output: \(outputURL.path)")
    }
    let temporaryURL = outputURL.deletingLastPathComponent().appendingPathComponent(
        ".\(outputName).partial-\(ProcessInfo.processInfo.processIdentifier)"
    )
    defer { try? FileManager.default.removeItem(at: temporaryURL) }

    guard let destination = CGImageDestinationCreateWithURL(
        temporaryURL as CFURL,
        UTType.png.identifier as CFString,
        1,
        nil
    ) else {
        fail("Could not create \(temporaryURL.path)")
    }
    let pngProperties: CFDictionary = [
        kCGImagePropertyDPIWidth: outputDPI,
        kCGImagePropertyDPIHeight: outputDPI,
        kCGImagePropertyPNGDictionary: [
            kCGImagePropertyPNGInterlaceType: 0
        ]
    ] as CFDictionary
    CGImageDestinationAddImage(destination, rendered, pngProperties)
    guard CGImageDestinationFinalize(destination) else {
        fail("Could not finish \(temporaryURL.path)")
    }
    do {
        try FileManager.default.moveItem(at: temporaryURL, to: outputURL)
    } catch {
        fail("Could not move completed output into place: \(error)")
    }
    print("WROTE \(outputURL.path)")
}

let paths = Array(CommandLine.arguments.dropFirst())
guard !paths.isEmpty else {
    fail("Usage: build_1440dpi_drawer_faces.swift INPUT.png [INPUT.png ...]")
}
for path in paths {
    render1440DPI(URL(fileURLWithPath: path))
}
print("DONE: \(paths.count) drawer-face image(s) converted to \(outputWidth)x\(outputHeight) at 1440 DPI.")
