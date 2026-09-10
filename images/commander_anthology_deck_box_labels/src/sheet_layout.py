"""Physical-size-preserving grid geometry shared by the GIMP tools."""
import math

DECKS = [
    "heavenly_inferno", "evasive_maneuvers",
    "guided_by_nature", "plunder_the_graves",
    "devour_for_power", "built_from_scratch",
    "wade_into_battle", "breed_lethality",
]
SHEET_NAME = "commander_anthology_letter_grid_1200ppi"


def grid_positions(page_width, page_height, sizes, xppi, yppi,
                   columns=None, side_margin=0.5, top_margin=0.5):
    """Center unchanged rectangles in equal grid cells with >=0.2-inch gaps."""
    if not sizes or min(xppi, yppi) <= 0:
        raise ValueError("No images or invalid print resolution")
    mx, my = round(side_margin * xppi), round(top_margin * yppi)
    aw, ah = page_width - 2 * mx, page_height - 2 * my
    candidates = []
    for cols in ([columns] if columns else range(1, len(sizes) + 1)):
        rows = math.ceil(len(sizes) / cols)
        max_w, max_h = max(s[0] for s in sizes), max(s[1] for s in sizes)
        gx = (aw - cols * max_w) / (cols - 1) if cols > 1 else 0
        gy = (ah - rows * max_h) / (rows - 1) if rows > 1 else 0
        if max_w * cols > aw or max_h * rows > ah:
            continue
        if (cols > 1 and gx < 0.2 * xppi) or (rows > 1 and gy < 0.2 * yppi):
            continue
        positions = []
        for idx, (width, height) in enumerate(sizes):
            row, col = divmod(idx, cols)
            x = mx + col * (max_w + gx) + (max_w - width) / 2
            y = my + row * (max_h + gy) + (max_h - height) / 2
            if cols == 1:
                x = (page_width - width) / 2
            if rows == 1:
                y = (page_height - height) / 2
            positions.append((round(x), round(y)))
        # Prefer full rows, then balanced physical whitespace.
        score = (cols * rows - len(sizes), abs(gx / xppi - gy / yppi))
        candidates.append((score, positions, cols, rows))
    if not candidates:
        raise ValueError("These layers cannot fit at their current sizes with 0.5-inch margins and 0.2-inch gaps; no layers were resized")
    _, positions, cols, rows = min(candidates, key=lambda c: c[0])
    return positions, cols, rows


def anthology_positions():
    return grid_positions(10200, 13200, [(3300, 2800)] * 8, 1200, 1200,
                          columns=2, side_margin=0.75)[0]
