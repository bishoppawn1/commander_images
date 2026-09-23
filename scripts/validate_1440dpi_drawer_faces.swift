#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO

private let expectedWidth = 4138
private let expectedHeight = 4858
private let expectedDPI = 1440.0
private let expectedSuffix = "_4138x4858_1440dpi_black_margin_1_8in.png"

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("FAIL: \(message)\n".utf8))
    exit(1)
}

func number(_ properties: CFDictionary, _ key: CFString) -> Double? {
    let dictionary = properties as NSDictionary
    return (dictionary[key] as? NSNumber)?.doubleValue
}

let paths = Array(CommandLine.arguments.dropFirst())
guard !paths.isEmpty else {
    fail("Usage: validate_1440dpi_drawer_faces.swift OUTPUT.png [OUTPUT.png ...]")
}

for path in paths {
    let url = URL(fileURLWithPath: path)
    guard url.lastPathComponent.hasSuffix(expectedSuffix) else {
        fail("Unexpected output filename: \(path)")
    }
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          CGImageSourceGetCount(source) == 1,
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil),
          let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) else {
        fail("Could not read a single PNG image from \(path)")
    }
    guard image.width == expectedWidth, image.height == expectedHeight else {
        fail("\(path): expected \(expectedWidth)x\(expectedHeight); found \(image.width)x\(image.height)")
    }
    let dpiX = number(properties, kCGImagePropertyDPIWidth) ?? -1
    let dpiY = number(properties, kCGImagePropertyDPIHeight) ?? -1
    guard abs(dpiX - expectedDPI) < 0.01, abs(dpiY - expectedDPI) < 0.01 else {
        fail("\(path): expected 1440x1440 DPI; found \(dpiX)x\(dpiY)")
    }
    guard image.bitsPerComponent == 8 else {
        fail("\(path): expected 8 bits per component; found \(image.bitsPerComponent)")
    }
    guard image.colorSpace?.model == .rgb else {
        fail("\(path): expected an RGB color space")
    }
    guard image.colorSpace?.name == CGColorSpace.sRGB else {
        fail("\(path): expected the embedded sRGB color profile")
    }
}

print("PASS: \(paths.count) drawer-face images are 4138x4858, 1440x1440 DPI, 8-bit sRGB RGB(A) PNGs.")
