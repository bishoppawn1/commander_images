"""Integration checks run inside an isolated GIMP, never on the user's tabs."""
import importlib.util
from pathlib import Path
import tempfile
from gi.repository import Gimp, Gio

spec = importlib.util.spec_from_file_location("arranger", Path(__file__).with_name("arrange_open_sheets.py"))
arranger = importlib.util.module_from_spec(spec)
spec.loader.exec_module(arranger)


def layer(image, name, width, height, x=0, y=0, visible=True):
    result = Gimp.Layer.new(image, name, width, height, Gimp.ImageType.RGBA_IMAGE,
                            100, Gimp.LayerMode.NORMAL)
    image.insert_layer(result, None, 0)
    result.fill(Gimp.FillType.WHITE)
    result.set_offsets(x, y)
    result.set_visible(visible)
    return result


def main():
    with tempfile.TemporaryDirectory(prefix="mtg-grid-qa-") as scratch:
        destination = Path(scratch)
        sheet = Gimp.Image.new(1020, 1320, Gimp.ImageBaseType.RGB)
        sheet.set_resolution(120, 120)
        background = layer(sheet, "Background", 1020, 1320)
        background.set_lock_position(True)
        labels = [layer(sheet, f"Label {i}", 330, 280, i * 4, i * 5) for i in range(8)]
        hidden = layer(sheet, "Hidden spare", 300, 200, 123, 456, False)
        original_file = destination / "original.xcf"
        assert Gimp.file_save(Gimp.RunMode.NONINTERACTIVE, sheet, Gio.File.new_for_path(str(original_file)))
        import hashlib
        original_hash = hashlib.sha256(original_file.read_bytes()).hexdigest()
        message = arranger.rearrange(sheet, destination)
        assert message.startswith("ARRANGED"), message
        assert sheet.get_file().get_path() == str(original_file)
        assert hashlib.sha256(original_file.read_bytes()).hexdigest() == original_hash
        expected, _, _ = arranger.grid_positions(1020, 1320, [(330, 280)] * 8, 120, 120)
        assert [l.get_offsets()[1:] for l in labels] == expected
        assert hidden.get_offsets()[1:] == (123, 456) and not hidden.get_visible()
        assert background.get_offsets()[1:] == (0, 0) and background.get_lock_position()
        assert len(list(destination.glob("*_before.xcf"))) == 1
        assert len(list(destination.glob("*_grid.xcf"))) == 1
        before = Gimp.file_load(Gimp.RunMode.NONINTERACTIVE, Gio.File.new_for_path(str(next(destination.glob("*_before.xcf")))))
        before_labels = arranger.candidates(before)
        assert [l.get_offsets()[1:] for l in before_labels] == [(i * 4, i * 5) for i in range(8)]
        before.delete()
        labels[0].set_lock_position(True)
        assert "position locked" in arranger.rearrange(sheet, destination)
        sheet.delete()
        flat = Gimp.Image.new(1020, 1320, Gimp.ImageBaseType.RGB)
        flat.set_resolution(120, 120)
        layer(flat, "Flattened", 1020, 1320)
        assert arranger.rearrange(flat, destination).startswith("SKIPPED")
        layer(flat, "Oversized image", 1020, 1320)
        assert "cannot fit" in arranger.rearrange(flat, destination)
        flat.delete()
    print("PASS: positioned 8 layers; retained background, hidden layer, sizes, and file association; verified before/after copies; skipped locked, flattened, and oversized sheets.")


if __name__ == "__main__":
    main()
