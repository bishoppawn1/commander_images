"""Run inside an isolated GIMP 3 Python batch interpreter to create the XCF."""
from pathlib import Path
import sys

from gi.repository import Gimp, Gio

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "src"))
from sheet_layout import DECKS, SHEET_NAME, anthology_positions


def main():
    output = ROOT / "print_sheets"
    output.mkdir(exist_ok=True)
    image = Gimp.Image.new(10200, 13200, Gimp.ImageBaseType.RGB)
    image.undo_disable()
    image.set_resolution(1200, 1200)
    image.set_color_profile(Gimp.ColorProfile.new_rgb_srgb())
    background = Gimp.Layer.new(image, "White paper background", 10200, 13200,
                                Gimp.ImageType.RGB_IMAGE, 100, Gimp.LayerMode.NORMAL)
    image.insert_layer(background, None, 0)
    background.fill(Gimp.FillType.WHITE)
    background.set_lock_position(True)
    for slug, (x, y) in zip(DECKS, anthology_positions()):
        source = ROOT / f"{slug}_boulder_top_label_tall_3300x2800_1200dpi.png"
        layer = Gimp.file_load_layer(Gimp.RunMode.NONINTERACTIVE, image, Gio.File.new_for_path(str(source)))
        assert (layer.get_width(), layer.get_height()) == (3300, 2800)
        image.insert_layer(layer, None, len(image.get_layers()) - 1)
        layer.set_name(slug.replace("_", " ").title())
        layer.set_offsets(x, y)
    image.undo_enable()
    target = output / f"{SHEET_NAME}.xcf"
    if not Gimp.file_save(Gimp.RunMode.NONINTERACTIVE, image, Gio.File.new_for_path(str(target))):
        raise RuntimeError(f"Could not save {target}")
    image.delete()
    # Reopen the saved artifact, checking actual saved state instead of memory alone.
    check = Gimp.file_load(Gimp.RunMode.NONINTERACTIVE, Gio.File.new_for_path(str(target)))
    assert (check.get_width(), check.get_height()) == (10200, 13200)
    assert check.get_resolution()[1:] == (1200.0, 1200.0)
    layers = check.get_layers()
    assert len(layers) == 9
    for layer, slug, offset in zip(layers[:8], DECKS, anthology_positions()):
        assert layer.get_name() == slug.replace("_", " ").title()
        assert layer.get_offsets()[1:] == offset
        assert (layer.get_width(), layer.get_height()) == (3300, 2800)
    check.delete()
    print(f"VERIFIED: {target}")


if __name__ == "__main__":
    main()
