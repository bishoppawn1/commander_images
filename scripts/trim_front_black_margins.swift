#!/usr/bin/env swift
// Crop the established black frame; retain the artwork's physical scale.
import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("Error: \(message)\n".utf8)); exit(1)
}
let suffix = "_1724x2024_black_margin_1_8in.png"
func save(_ image: CGImage, _ path: String, _ dpi: Int) {
    guard !FileManager.default.fileExists(atPath: path) else { fail("Refusing overwrite: \(path)") }
    guard let dest = CGImageDestinationCreateWithURL(URL(fileURLWithPath: path) as CFURL, UTType.png.identifier as CFString, 1, nil) else { fail("Cannot write \(path)") }
    CGImageDestinationAddImage(dest, image, [kCGImagePropertyDPIWidth: dpi, kCGImagePropertyDPIHeight: dpi] as CFDictionary)
    guard CGImageDestinationFinalize(dest) else { fail("Cannot finish \(path)") }
}
guard CommandLine.arguments.count > 1 else { fail("Usage: trim_front_black_margins.swift MASTER.png [MASTER.png ...]") }
for path in CommandLine.arguments.dropFirst() {
    guard path.hasSuffix(suffix),
          let src = CGImageSourceCreateWithURL(URL(fileURLWithPath: path) as CFURL, nil),
          let im = CGImageSourceCreateImageAtIndex(src, 0, nil),
          im.width == 1724, im.height == 2024 else { fail("Expected established 1724x2024 master: \(path)") }
    // Top-down crop: remove 40px left/right, 3px top cut guide, 96px bottom.
    guard let cropped = im.cropping(to: CGRect(x: 40, y: 3, width: 1644, height: 1925)) else { fail("Cannot crop \(path)") }
    let stem = String(path.dropLast(suffix.count))
    save(cropped, stem + "_1644x1925_600dpi_trimmed.png", 600)
    guard let ctx = CGContext(data: nil, width: 3946, height: 4620, bitsPerComponent: 8, bytesPerRow: 0,
                              space: CGColorSpace(name: CGColorSpace.sRGB)!,
                              bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else { fail("Cannot create sRGB canvas") }
    ctx.interpolationQuality = .high
    ctx.draw(cropped, in: CGRect(x: 0, y: 0, width: 3946, height: 4620))
    guard let rendered = ctx.makeImage() else { fail("Cannot render \(path)") }
    save(rendered, stem + "_3946x4620_1440dpi_trimmed.png", 1440)
    print("TRIMMED \(stem)")
}
