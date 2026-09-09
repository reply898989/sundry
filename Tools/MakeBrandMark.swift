// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project
//
// Draws the Sundry mark and writes the three brand masters that
// Tools/MakeIcon.swift and the adaptive icon catalog consume:
//
// - Resources/Brand/logo.png            template master (black on transparent)
// - Resources/Brand/AppIcon-Default.png the Default rendition of the app icon
// - Resources/Brand/AppIcon.icon/Assets/sundry-brandmark.svg  vector mark
//
// Run from the repository root: `swift Tools/MakeBrandMark.swift`
//
// The mark is a drawer unit with the middle drawer pulled out: a place where
// many small useful things live. It has to survive as a menu bar template
// image, where only alpha is kept, so it is built from solid shapes with
// punched-out handles rather than anything relying on colour to separate parts.
//
// Two earlier designs were discarded for looking like something else: a divided
// tray (a rounded horizontal box with one end filled is the battery icon) and
// plain stacked bars (a text-align or list glyph). The handles are what make
// these read as drawer fronts.

import AppKit

// MARK: - Geometry, expressed once in a 200x204 design box

let box = CGSize(width: 200, height: 204)
let drawerSize = CGSize(width: 140, height: 46)
let drawerRadius: CGFloat = 12
let drawerInset: CGFloat = 20              // left edge of a closed drawer
let drawerPull: CGFloat = 30               // how far the open one slides out
let drawerRows: [CGFloat] = [20, 79, 138]  // bottom edges, bottom-up
let openRow = 1

let handleSize = CGSize(width: 36, height: 9)
let handleRadius: CGFloat = 4.5

let drawers: [CGRect] = drawerRows.enumerated().map { index, y in
    CGRect(x: drawerInset + (index == openRow ? drawerPull : 0), y: y,
           width: drawerSize.width, height: drawerSize.height)
}

func handle(in drawer: CGRect) -> CGRect {
    CGRect(x: drawer.midX - handleSize.width / 2,
           y: drawer.midY - handleSize.height / 2,
           width: handleSize.width, height: handleSize.height)
}

// MARK: - Raster

/// Draws the mark filling `target` (at the design box's aspect) in one colour.
/// Each drawer and its handle share one even-odd path, so the handle is a hole
/// in the alpha channel and survives template rendering in the menu bar.
func drawMark(in target: CGRect, color: NSColor) {
    let s = target.width / box.width
    func scaled(_ r: CGRect) -> CGRect {
        CGRect(x: target.minX + r.minX * s, y: target.minY + r.minY * s,
               width: r.width * s, height: r.height * s)
    }
    color.setFill()
    for drawer in drawers {
        let path = NSBezierPath()
        path.append(NSBezierPath(roundedRect: scaled(drawer),
                                 xRadius: drawerRadius * s, yRadius: drawerRadius * s))
        path.append(NSBezierPath(roundedRect: scaled(handle(in: drawer)),
                                 xRadius: handleRadius * s, yRadius: handleRadius * s))
        path.windingRule = .evenOdd
        path.fill()
    }
}

func render(_ px: Int, _ body: (CGRect) -> Void) -> Data? {
    guard let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: px, pixelsHigh: px,
                                     bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true,
                                     isPlanar: false, colorSpaceName: .deviceRGB,
                                     bytesPerRow: 0, bitsPerPixel: 0),
          let ctx = NSGraphicsContext(bitmapImageRep: rep) else { return nil }
    rep.size = NSSize(width: px, height: px)
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = ctx
    body(CGRect(x: 0, y: 0, width: CGFloat(px), height: CGFloat(px)))
    NSGraphicsContext.restoreGraphicsState()
    return rep.representation(using: .png, properties: [:])
}

/// Centres a mark of the given width, at the design box's aspect, in a canvas.
func markRect(in bounds: CGRect, width: CGFloat) -> CGRect {
    let height = width * box.height / box.width
    return CGRect(x: bounds.midX - width / 2, y: bounds.midY - height / 2,
                  width: width, height: height)
}

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
func write(_ data: Data?, _ path: String) throws {
    guard let data else {
        FileHandle.standardError.write(Data("render failed: \(path)\n".utf8)); exit(1)
    }
    try data.write(to: root.appendingPathComponent(path))
    print("wrote \(path)")
}

// 1. Template master. Black on transparent; MakeIcon.swift crops to ink bounds,
//    so the surrounding canvas only has to be big enough not to clip the mark.
try write(render(1024) { bounds in
    drawMark(in: markRect(in: bounds, width: 760), color: .black)
}, "Resources/Brand/logo.png")

// 2. App icon. The macOS squircle corner radius is ~22.37% of the side.
try write(render(1024) { bounds in
    NSBezierPath(roundedRect: bounds, xRadius: 229, yRadius: 229).addClip()
    NSGradient(starting: NSColor(srgbRed: 1.00, green: 0.73, blue: 0.38, alpha: 1),
               ending:   NSColor(srgbRed: 0.86, green: 0.44, blue: 0.15, alpha: 1))?
        .draw(in: bounds, angle: -60)
    drawMark(in: markRect(in: bounds, width: 560), color: .white)
}, "Resources/Brand/AppIcon-Default.png")

// MARK: - Vector, emitted from the same numbers

/// SVG path data for a rounded rectangle, in SVG's top-down coordinate space.
func roundedRectPath(_ r: CGRect, _ radius: CGFloat) -> String {
    let top = box.height - r.maxY          // flip: SVG's origin is top-left
    let (x, w, h) = (r.minX, r.width, r.height)
    let straightW = w - 2 * radius, straightH = h - 2 * radius
    return "M\(x + radius),\(top)"
         + "h\(straightW)a\(radius),\(radius) 0 0 1 \(radius),\(radius)"
         + "v\(straightH)a\(radius),\(radius) 0 0 1 -\(radius),\(radius)"
         + "h-\(straightW)a\(radius),\(radius) 0 0 1 -\(radius),-\(radius)"
         + "v-\(straightH)a\(radius),\(radius) 0 0 1 \(radius),-\(radius)Z"
}

let paths = drawers.map { drawer in
    "    <path d=\"" + roundedRectPath(drawer, drawerRadius)
        + roundedRectPath(handle(in: drawer), handleRadius) + "\"/>"
}.joined(separator: "\n")

let svg = """
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 \(Int(box.width)) \(Int(box.height))" \
width="\(Int(box.width))" height="\(Int(box.height))">
  <!-- Sundry mark: a drawer unit with the middle drawer pulled out. -->
  <g fill="#000000" fill-rule="evenodd">
\(paths)
  </g>
</svg>
"""
try write(Data(svg.utf8), "Resources/Brand/AppIcon.icon/Assets/sundry-brandmark.svg")
