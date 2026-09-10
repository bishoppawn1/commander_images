"""Arrange ONLY the six verified sheets in GIMP_SHEET_PLAN.md.

Moves visible top-level image layers/groups without resizing or recoloring them.
Keeps source files untouched, with before/after XCF copies and one Undo group.
Single-image/flattened documents and layouts that cannot fit are reported/skipped.
"""
from datetime import datetime
from pathlib import Path
import re
import math

ROOT = Path(__file__).resolve().parent

# Exact filenames in the user's console inventory, in screenshot row order.
FACE_SUFFIX = "_1724x2024_black_margin_1_8in.png"
FACE_ROWS = (
    ("01_forgotten_realms_bloomburrow", (
        "adventures_forgotten_realms_commander_official_key_art_wordmark_v2_deck_count_4",
        "bloomburrow_target_v3_official_key_art_deck_count_4",
        "commander_legends_phyrexia_all_will_be_one_vertical_split_v1_deck_counts_2_2",
        "commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_deck_counts_2_2",
        "commander_2017_four_tribes_ensemble_deck_count_4_v1",
        "commander_2018_four_leads_premium_cover_v1_deck_count_4")),
    ("02_ikoria_strixhaven", (
        "commander_2020_ikoria_official_key_art_target_v2_deck_count_5",
        "strixhaven_commander_official_key_art_target_v2_deck_count_5",
        "commander_2019_four_leads_ensemble_v1_deck_count_4",
        "commander_anthology_ii_target_v3_deck_count_4_trial",
        "commander_anthology_i_target_v3_deck_count_4_trial",
        "custom_commander_decks_unnumbered")),
    ("03_final_fantasy_lord_of_the_rings", (
        "final_fantasy_commander_official_key_art_crystal_target_v1_deck_count_4",
        "lord_of_the_rings_tales_of_middle_earth_commander_official_wordmark_typography_alternate_v2_deck_count_4",
        "fallout_commander_official_power_armor_key_art_target_v1_deck_count_4",
        "march_of_the_machine_commander_official_wpn_key_art_extended_battle_target_v1_deck_count_5",
        "lost_caverns_of_ixalan_commander_official_key_art_target_v1_deck_count_4",
        "marvel_super_heroes_commander_official_wpn_key_art_target_v1_deck_count_4")),
    ("04_brothers_war_eldraine", (
        "brothers_war_wilds_of_eldraine_vertical_split_deck_counts_2_2",
        "throne_of_eldraine_brawl_secondary_four_courts_illuminated_v1_deck_count_4",
        "secret_lair_category_alternate_art_vault_v1",
        "warhammer_40000_commander_four_faction_v2_deck_count_4",
        "turtle_power_commander_official_key_art_target_v1_deck_count_1",
        "zendikar_rising_kamigawa_neon_dynasty_target_vertical_split_v3_deck_counts_2_2_trial")),
    ("05_modern_horizons_doctor_who", (
        "modern_horizons_3_commander_cosmic_rift_alternate_v3_deck_count_4",
        "doctor_who_commander_official_wpn_tardis_key_art_target_v1_deck_count_4",
        "commander_masters_official_wpn_poster_target_v1_deck_count_4")),
)
SHEETS = [dict(key=key, names=tuple(s + FACE_SUFFIX for s in stems),
               page=(5100, 6600), ppi=600, size=(1724, 2024),
               positions=tuple((x, y) for y in (150, 2288, 4426)
                               for x in (600, 2776))[:len(stems)])
          for key, stems in FACE_ROWS]
SHEETS.append(dict(
    key="06_anthology_boulder_tops",
    names=tuple(s + "_boulder_top_label_tall_3300x2800_1200dpi.png" for s in (
        "evasive_maneuvers", "breed_lethality", "guided_by_nature",
        "built_from_scratch", "heavenly_inferno", "devour_for_power",
        "plunder_the_graves", "wade_into_battle")),
    page=(10200, 13200), ppi=1200, size=(3300, 2800),
    positions=tuple((x, y) for y in (600, 3667, 6733, 9800)
                    for x in (1200, 5700))))


def matching_spec(image):
    names = [layer.get_name() for layer in candidates(image)]
    return next((spec for spec in SHEETS
                 if len(names) == len(spec["names"])
                 and set(names) == set(spec["names"])), None)


def selected_layers(image, spec):
    if matching_spec(image) is not spec:
        raise ValueError("visible image layers no longer match the verified sheet")
    if (image.get_width(), image.get_height()) != spec["page"]:
        raise ValueError("page dimensions differ from the verified sheet")
    ok, xp, yp = image.get_resolution()
    if not ok or abs(xp - spec["ppi"]) > 0.01 or abs(yp - spec["ppi"]) > 0.01:
        raise ValueError("print resolution differs from the verified sheet")
    by_name = {layer.get_name(): layer for layer in candidates(image)}
    layers = [by_name[name] for name in spec["names"]]
    for layer in layers:
        if (layer.get_width(), layer.get_height()) != spec["size"]:
            raise ValueError(f"image dimensions changed: {layer.get_name()}")
        if layer.get_lock_position():
            raise ValueError(f"position locked: {layer.get_name()}")
    return layers


def grid_positions(page_width, page_height, sizes, xppi, yppi,
                   columns=None, side_margin=0.5, top_margin=0.5):
    """Center unchanged rectangles in grid cells; incomplete final rows are OK."""
    if not sizes or min(xppi, yppi) <= 0:
        raise ValueError("No images or invalid print resolution")
    mx, my = round(side_margin * xppi), round(top_margin * yppi)
    aw, ah = page_width - 2 * mx, page_height - 2 * my
    layouts = []
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
        score = (cols * rows - len(sizes), abs(gx / xppi - gy / yppi))
        layouts.append((score, positions, cols, rows))
    if not layouts:
        raise ValueError(
            f"These layers cannot fit at their current sizes with {side_margin:g}-inch "
            f"side margins, {top_margin:g}-inch top/bottom margins and 0.2-inch gaps; "
            "no layers were resized")
    _, positions, cols, rows = min(layouts, key=lambda c: c[0])
    return positions, cols, rows


def is_background(layer, image):
    name = layer.get_name().lower().strip()
    named = bool(re.match(r"^(white paper background|background|white background|paper background)(\b|$)", name))
    return named and layer.get_width() >= image.get_width() and layer.get_height() >= image.get_height()


def candidates(image):
    layers = [layer for layer in image.get_layers()
              if layer.get_visible() and not is_background(layer, image)]
    # Use current reading order; position ties preserve the Layers-panel order.
    return sorted(layers, key=lambda layer: (layer.get_offsets()[2], layer.get_offsets()[1]))


def save_snapshot(image, target):
    from gi.repository import Gimp, Gio

    # Save a duplicate to avoid changing the existing tab's original file association.
    duplicate = image.duplicate()
    try:
        if not Gimp.file_save(Gimp.RunMode.NONINTERACTIVE, duplicate,
                              Gio.File.new_for_path(str(target))):
            raise RuntimeError(f"Could not save {target}")
    finally:
        duplicate.delete()


def rearrange(image, destination):
    title = image.get_name()
    spec = matching_spec(image)
    if spec is None:
        return f"SKIPPED: {title}: not one of the six verified sheets."
    try:
        layers = selected_layers(image, spec)
    except ValueError as error:
        return f"SKIPPED: {title}: {error}"
    positions = spec["positions"]
    old = [l.get_offsets()[1:] for l in layers]
    if old == list(positions):
        return f"UNCHANGED: {spec['key']}: already arranged."
    stem = f"{spec['key']}_{image.get_id()}"
    before = destination / f"{stem}_before.xcf"
    after = destination / f"{stem}_grid.xcf"
    save_snapshot(image, before)
    if not image.undo_group_start():
        raise RuntimeError("Could not start Undo group; no images moved")
    try:
        for layer, (x, y) in zip(layers, positions):
            if not layer.set_offsets(x, y):
                raise RuntimeError(f"Could not move {layer.get_name()}")
        save_snapshot(image, after)
    except Exception:
        for layer, (x, y) in zip(layers, old):
            layer.set_offsets(x, y)
        raise
    finally:
        image.undo_group_end()
    partial = "; incomplete final row" if len(layers) % 2 else ""
    return f"ARRANGED: {spec['key']}: 2 columns x {math.ceil(len(layers) / 2)} rows{partial}; saved {after.name}"


def main():
    from gi.repository import Gimp

    opened = list(Gimp.get_images())
    if not opened:
        print("No open sheets. Open your layered sheets in GIMP, then run again.")
        return
    destination = ROOT / "gimp_grid_sheets" / datetime.now().strftime("%Y%m%d_%H%M%S_%f")
    destination.mkdir(parents=True)
    report = []
    matches = [(image, matching_spec(image)) for image in opened]
    counts = {spec["key"]: sum(match is spec for _, match in matches)
              for spec in SHEETS}
    for spec in SHEETS:
        if counts[spec["key"]] == 0:
            message = f"NOT FOUND: {spec['key']}; no document changed for this target."
            report.append(message)
            print(message, flush=True)
    for image in opened:
        try:
            spec = matching_spec(image)
            if spec is not None and counts[spec["key"]] > 1:
                message = f"SKIPPED: {spec['key']}: multiple matching documents; close duplicates and rerun."
            else:
                print(f"Checking/saving: {spec['key'] if spec else image.get_name()} ...", flush=True)
                message = rearrange(image, destination)
        except Exception as error:
            message = f"ERROR: {image.get_name()}: {error}"
        report.append(message)
        print(message, flush=True)
    Gimp.displays_flush()
    report.append(f"Before/after copies and this report: {destination}")
    (destination / "arrangement_report.txt").write_text("\n".join(report) + "\n")
    print(report[-1])
    print("DONE. Close this console to see your sheets. Undo once in a changed tab to restore its arrangement.")


if __name__ == "__main__":
    main()
