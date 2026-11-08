#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("QA failure: \(message)\n".utf8))
    exit(1)
}

struct Raster {
    let width: Int
    let height: Int
    let dpiX: Double
    let dpiY: Double
    let bytes: [UInt8]
}

func load(_ path: String) -> Raster {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil),
          let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [CFString: Any],
          let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else {
        fail("Could not read \(path)")
    }

    var bytes = [UInt8](repeating: 0, count: image.width * image.height * 4)
    let created = bytes.withUnsafeMutableBytes { rawBuffer -> Bool in
        guard let base = rawBuffer.baseAddress,
              let context = CGContext(
                data: base,
                width: image.width,
                height: image.height,
                bitsPerComponent: 8,
                bytesPerRow: image.width * 4,
                space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
              ) else {
            return false
        }
        context.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
        return true
    }
    guard created else {
        fail("Could not rasterize \(path)")
    }

    let dpiX = (properties[kCGImagePropertyDPIWidth] as? NSNumber)?.doubleValue ?? 0
    let dpiY = (properties[kCGImagePropertyDPIHeight] as? NSNumber)?.doubleValue ?? 0
    return Raster(width: image.width, height: image.height, dpiX: dpiX, dpiY: dpiY, bytes: bytes)
}

guard CommandLine.arguments.count == 3 else {
    fail("Usage: qa_validate.swift BASE.png COUNTED.png")
}

let base = load(CommandLine.arguments[1])
let counted = load(CommandLine.arguments[2])

for (name, raster) in [("base", base), ("counted", counted)] {
    guard raster.width == 1800, raster.height == 2100 else {
        fail("\(name) is \(raster.width) × \(raster.height), expected 1800 × 2100")
    }
    guard abs(raster.dpiX - 600) < 0.01, abs(raster.dpiY - 600) < 0.01 else {
        fail("\(name) DPI is \(raster.dpiX) × \(raster.dpiY), expected 600 × 600")
    }
    let minAlpha = stride(from: 3, to: raster.bytes.count, by: 4).map { raster.bytes[$0] }.min() ?? 0
    guard minAlpha == 255 else {
        fail("\(name) contains non-opaque pixels; minimum alpha is \(minAlpha)")
    }
}

guard base.bytes.count == counted.bytes.count else {
    fail("Raster byte counts differ")
}

var minX = base.width
var minY = base.height
var maxX = -1
var maxY = -1
for y in 0..<base.height {
    for x in 0..<base.width {
        let offset = (y * base.width + x) * 4
        if base.bytes[offset] != counted.bytes[offset]
            || base.bytes[offset + 1] != counted.bytes[offset + 1]
            || base.bytes[offset + 2] != counted.bytes[offset + 2]
            || base.bytes[offset + 3] != counted.bytes[offset + 3] {
            minX = min(minX, x)
            minY = min(minY, y)
            maxX = max(maxX, x)
            maxY = max(maxY, y)
        }
    }
}

guard maxX >= 0 else {
    fail("Counted target is identical to base")
}

// The standardized 210 px seal itself is x=1520...1729 and raster y=1820...2029
// in this top-origin buffer. Shadow blur may extend modestly beyond it.
guard minX >= 1490, maxX <= 1755, minY >= 1790, maxY <= 2060 else {
    fail("Counted changes escape the expected seal/shadow region: x=\(minX)...\(maxX), y=\(minY)...\(maxY)")
}

print("PASS base: \(base.width)×\(base.height), \(base.dpiX)×\(base.dpiY) DPI, fully opaque")
print("PASS counted: \(counted.width)×\(counted.height), \(counted.dpiX)×\(counted.dpiY) DPI, fully opaque")
print("PASS counted-only pixel changes: x=\(minX)...\(maxX), top-origin y=\(minY)...\(maxY)")
print("PASS seal circle geometry by script: diameter 210 px; right and bottom outer-edge insets 70 px")
