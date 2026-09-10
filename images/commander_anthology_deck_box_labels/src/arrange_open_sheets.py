"""Run once inside the existing GIMP 3 Python Console; see print_sheets/README.md.

Moves visible top-level image layers/groups without resizing or recoloring them.
Keeps source files untouched, with before/after XCF copies and one Undo group.
Single-image/flattened documents and layouts that cannot fit are reported/skipped.
"""
from datetime import datetime
from pathlib import Path
import re
import sys

from gi.repository import Gimp, Gio

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "src"))
from sheet_layout import SHEET_NAME, grid_positions


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
    layers = candidates(image)
    if len(layers) < 2:
        return f"SKIPPED: {title}: fewer than two separate visible image layers. A flattened sheet cannot be rearranged this way."
    ok, xp, yp = image.get_resolution()
    if not ok:
        return f"SKIPPED: {title}: could not read print resolution."
    sizes = [(l.get_width(), l.get_height()) for l in layers]
    try:
        positions, cols, rows = grid_positions(image.get_width(), image.get_height(), sizes, xp, yp)
    except ValueError as error:
        return f"SKIPPED: {title}: {error}"
    if any(layer.get_lock_position() for layer in layers):
        return f"SKIPPED: {title}: an image layer has its position locked; unlock it before rerunning."
    old = [l.get_offsets()[1:] for l in layers]
    stem = re.sub(r"[^A-Za-z0-9._-]+", "_", Path(title).stem).strip("._") or "sheet"
    stem = f"{stem[:90]}_{image.get_id()}"
    before = destination / f"{stem}_before.xcf"
    after = destination / f"{stem}_grid.xcf"
    save_snapshot(image, before)
    image.undo_group_start()
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
    return f"ARRANGED: {title}: {cols} columns x {rows} rows; saved {after.name}"


def main():
    # Capture the existing tabs first, before opening the newly created anthology sheet.
    opened = list(Gimp.get_images())
    destination = ROOT / "print_sheets" / "rearranged_open_sheets" / datetime.now().strftime("%Y%m%d_%H%M%S_%f")
    destination.mkdir(parents=True)
    report = []
    for image in opened:
        if SHEET_NAME in image.get_name():
            report.append(f"UNCHANGED: {image.get_name()}: already the prepared anthology grid.")
            continue
        try:
            message = rearrange(image, destination)
        except Exception as error:
            message = f"ERROR: {image.get_name()}: {error}"
        report.append(message)
        print(message, flush=True)
    new_sheet = ROOT / "print_sheets" / f"{SHEET_NAME}.xcf"
    if not any(SHEET_NAME in i.get_name() for i in opened):
        new_image = Gimp.file_load(Gimp.RunMode.NONINTERACTIVE, Gio.File.new_for_path(str(new_sheet)))
        Gimp.Display.new(new_image)
        report.append("OPENED: the new eight-label Letter grid.")
    Gimp.displays_flush()
    report.append(f"Before/after copies and this report: {destination}")
    (destination / "arrangement_report.txt").write_text("\n".join(report) + "\n")
    print("\n".join(report[-2:]))
    print("DONE. Close this console to see your sheets. Undo once in a changed tab to restore its arrangement.")


if __name__ == "__main__":
    main()
