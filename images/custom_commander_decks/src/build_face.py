#!/usr/bin/env python3
"""Build the deterministic Custom Commander Decks drawer face.

Run from the repository root with:
    uv run --with pillow python images/custom_commander_decks/src/build_face.py

Only files inside images/custom_commander_decks/ are read or written.
"""

from __future__ import annotations

import json
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont


HERE = Path(__file__).resolve().parent
PACKAGE = HERE.parent
SOURCE = HERE / "imagegen_original.png"
FINAL = PACKAGE / "custom_commander_decks_unnumbered.png"
PREVIEW = HERE / "drawer_scale_preview.png"
MASK_PREVIEW = HERE / "title_mask_preview.png"
METRICS = HERE / "title_metrics.json"
FONT_PATH = Path("/System/Library/Fonts/Supplemental/Copperplate.ttc")
FONT_INDEX = 2  # Copperplate Bold

CANVAS = (1800, 2100)
MAX_TITLE_WIDTH = 1640
TITLE_LINES = ("CUSTOM", "COMMANDER", "DECKS")


def tracked_width(font: ImageFont.FreeTypeFont, text: str, tracking: float) -> float:
    return sum(font.getlength(ch) for ch in text) + tracking * max(0, len(text) - 1)


def fit_font(text: str, max_width: int) -> tuple[ImageFont.FreeTypeFont, float]:
    """Fit each title line independently so every line is drawer-dominant."""
    for size in range(400, 99, -1):
        font = ImageFont.truetype(str(FONT_PATH), size=size, index=FONT_INDEX)
        tracking = round(size * 0.045, 2)
        if tracked_width(font, text, tracking) <= max_width:
            return font, tracking
    raise RuntimeError(f"Could not fit title line: {text}")


def draw_tracked(
    draw: ImageDraw.ImageDraw,
    text: str,
    font: ImageFont.FreeTypeFont,
    tracking: float,
    center_x: float,
    y: float,
    *,
    fill: tuple[int, int, int, int],
    stroke_width: int,
    stroke_fill: tuple[int, int, int, int],
) -> None:
    width = tracked_width(font, text, tracking)
    x = center_x - width / 2
    for ch in text:
        draw.text(
            (round(x), round(y)),
            ch,
            font=font,
            fill=fill,
            stroke_width=stroke_width,
            stroke_fill=stroke_fill,
        )
        x += font.getlength(ch) + tracking


def main() -> None:
    if not SOURCE.exists():
        raise FileNotFoundError(SOURCE)
    if not FONT_PATH.exists():
        raise FileNotFoundError(FONT_PATH)

    with Image.open(SOURCE) as opened:
        original = opened.convert("RGB")

    # Source is very close to 6:7. Center-crop four side pixels before a
    # high-quality upscale so the final canvas is exactly 6:7 without padding.
    target_crop_width = round(original.height * 6 / 7)
    left = (original.width - target_crop_width) // 2
    crop_box = (left, 0, left + target_crop_width, original.height)
    base = original.crop(crop_box).resize(CANVAS, Image.Resampling.LANCZOS)
    base = base.filter(ImageFilter.UnsharpMask(radius=1.15, percent=80, threshold=3))

    # A feathered translucent tonal veil improves letter separation while
    # retaining the detailed wood, brass, cards, and filigree beneath it.
    veil = Image.new("RGBA", CANVAS, (0, 0, 0, 0))
    veil_px = veil.load()
    veil_top, veil_bottom = 285, 1040
    veil_center, veil_peak_alpha = 675, 126
    for y in range(veil_top, veil_bottom + 1):
        distance = abs(y - veil_center)
        half_span = max(veil_center - veil_top, veil_bottom - veil_center)
        strength = max(0.0, 1.0 - distance / half_span)
        alpha = round(18 + veil_peak_alpha * (strength ** 0.68))
        for x in range(CANVAS[0]):
            veil_px[x, y] = (7, 3, 10, alpha)
    veil = veil.filter(ImageFilter.GaussianBlur(radius=34))

    composed = Image.alpha_composite(base.convert("RGBA"), veil)
    title_layer = Image.new("RGBA", CANVAS, (0, 0, 0, 0))
    title_draw = ImageDraw.Draw(title_layer)

    fitted = []
    for line in TITLE_LINES:
        font, tracking = fit_font(line, MAX_TITLE_WIDTH)
        bbox = font.getbbox(line, stroke_width=13)
        visible_height = bbox[3] - bbox[1]
        fitted.append((line, font, tracking, visible_height, bbox[1]))

    gap = 8
    total_height = sum(row[3] for row in fitted) + gap * (len(fitted) - 1)
    block_top = round(665 - total_height / 2)
    cursor = block_top
    line_metrics = []

    for line, font, tracking, visible_height, bbox_top in fitted:
        draw_y = cursor - bbox_top

        # Soft offset shadow, hard near-black keyline, then antique-gold rim.
        draw_tracked(
            title_draw,
            line,
            font,
            tracking,
            CANVAS[0] / 2 + 7,
            draw_y + 11,
            fill=(15, 8, 12, 235),
            stroke_width=18,
            stroke_fill=(5, 2, 5, 225),
        )
        draw_tracked(
            title_draw,
            line,
            font,
            tracking,
            CANVAS[0] / 2,
            draw_y,
            fill=(247, 232, 184, 255),
            stroke_width=14,
            stroke_fill=(25, 12, 8, 255),
        )
        draw_tracked(
            title_draw,
            line,
            font,
            tracking,
            CANVAS[0] / 2,
            draw_y,
            fill=(247, 232, 184, 255),
            stroke_width=7,
            stroke_fill=(184, 127, 48, 255),
        )

        line_metrics.append(
            {
                "text": line,
                "font_size_px": font.size,
                "tracking_px": tracking,
                "render_width_px": round(tracked_width(font, line, tracking), 2),
                "visible_top_px": cursor,
                "visible_bottom_px": cursor + visible_height,
            }
        )
        cursor += visible_height + gap

    composed = Image.alpha_composite(composed, title_layer).convert("RGB")
    composed.save(FINAL, format="PNG", dpi=(600, 600), optimize=True)

    preview = composed.resize((300, 350), Image.Resampling.LANCZOS)
    preview.save(PREVIEW, format="PNG", dpi=(100, 100), optimize=True)

    mask = title_layer.getchannel("A").resize((300, 350), Image.Resampling.LANCZOS)
    mask.save(MASK_PREVIEW, format="PNG", optimize=True)

    metrics = {
        "source": SOURCE.name,
        "source_size_px": list(original.size),
        "source_crop_box_px": list(crop_box),
        "final": FINAL.name,
        "final_size_px": list(CANVAS),
        "dpi": [600, 600],
        "font": "Copperplate Bold",
        "font_path": str(FONT_PATH),
        "font_collection_index": FONT_INDEX,
        "safe_title_width_px": MAX_TITLE_WIDTH,
        "title_block_top_px": block_top,
        "title_block_bottom_px": cursor - gap,
        "lines": line_metrics,
        "count_marker": None,
    }
    METRICS.write_text(json.dumps(metrics, indent=2) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
