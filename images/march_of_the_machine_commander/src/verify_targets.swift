#!/usr/bin/env swift

import CoreGraphics
import Foundation
import ImageIO

struct Raster {
    let width: Int
    let height: Int
    let pixels: [UInt8]
    let dpiWidth: Double
    let dpiHeight: Double
}

func load(_ path: String) -> Raster {
    let url = URL(fileURLWithPath: path)
    guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil),
          let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [CFString: Any] else {
        fatalError("Could not load \(path)")
    }

    let width = image.width
    let height = image.height
    let bytesPerRow = width * 4
    var pixels = [UInt8](repeating: 0, count: bytesPerRow * height)
    guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB),
          let context = CGContext(
            data: &pixels,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
          ) else {
        fatalError("Could not create analysis canvas")
    }
    context.translateBy(x: 0, y: CGFloat(height))
    context.scaleBy(x: 1, y: -1)
    context.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))

    return Raster(
        width: width,
        height: height,
        pixels: pixels,
        dpiWidth: properties[kCGImagePropertyDPIWidth] as? Double ?? 0,
        dpiHeight: properties[kCGImagePropertyDPIHeight] as? Double ?? 0
    )
}

func tileLuminanceStandardDeviations(_ raster: Raster) -> [Double] {
    let tileWidth = raster.width / 6
    let tileHeight = raster.height / 7
    var deviations: [Double] = []
    for tileY in 0..<7 {
        for tileX in 0..<6 {
            var sum = 0.0
            var sumSquares = 0.0
            var count = 0.0
            let x0 = tileX * tileWidth
            let y0 = tileY * tileHeight
            for y in y0..<(y0 + tileHeight) {
                for x in x0..<(x0 + tileWidth) {
                    let offset = (y * raster.width + x) * 4
                    let red = Double(raster.pixels[offset])
                    let green = Double(raster.pixels[offset + 1])
                    let blue = Double(raster.pixels[offset + 2])
                    let luminance = 0.2126 * red + 0.7152 * green + 0.0722 * blue
                    sum += luminance
                    sumSquares += luminance * luminance
                    count += 1
                }
            }
            let mean = sum / count
            deviations.append(sqrt(max(0, sumSquares / count - mean * mean)))
        }
    }
    return deviations
}

func goldSealBounds(_ raster: Raster) -> CGRect? {
    var minX = raster.width
    var minY = raster.height
    var maxX = -1
    var maxY = -1
    for y in 0..<400 {
        for x in 1400..<raster.width {
            let offset = (y * raster.width + x) * 4
            let red = Int(raster.pixels[offset])
            let green = Int(raster.pixels[offset + 1])
            let blue = Int(raster.pixels[offset + 2])
            if red >= 175, green >= 105, green <= 190, blue <= 125, red > green + 30, green > blue + 25 {
                minX = min(minX, x)
                minY = min(minY, y)
                maxX = max(maxX, x)
                maxY = max(maxY, y)
            }
        }
    }
    guard maxX >= minX, maxY >= minY else { return nil }
    return CGRect(x: minX, y: minY, width: maxX - minX + 1, height: maxY - minY + 1)
}

guard CommandLine.arguments.count == 3 else {
    fatalError("Usage: verify_targets.swift BASE.png COUNTED.png")
}

let base = load(CommandLine.arguments[1])
let counted = load(CommandLine.arguments[2])
let deviations = tileLuminanceStandardDeviations(base)
print("base=\(base.width)x\(base.height) dpi=\(base.dpiWidth)x\(base.dpiHeight)")
print("counted=\(counted.width)x\(counted.height) dpi=\(counted.dpiWidth)x\(counted.dpiHeight)")
print(String(format: "tile_luminance_sd_min=%.2f median=%.2f max=%.2f", deviations.min() ?? 0, deviations.sorted()[deviations.count / 2], deviations.max() ?? 0))
if let bounds = goldSealBounds(counted) {
    print("gold_seal_antialias_extent_core_graphics=x\(Int(bounds.minX))...\(Int(bounds.maxX)) y\(Int(bounds.minY))...\(Int(bounds.maxY))")
    print("gold_seal_geometry=diameter_\(Int(bounds.maxX - bounds.minX)) right_edge_x\(Int(bounds.maxX)) bottom_edge_y\(Int(bounds.minY)); right_inset=\(counted.width - Int(bounds.maxX)); bottom_inset=\(Int(bounds.minY))")
} else {
    print("gold_seal_pixel_bbox_core_graphics=NOT_FOUND")
}
