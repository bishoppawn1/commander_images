"""Run in an isolated GIMP 3 batch session, never the user's live instance."""
import hashlib
import importlib.util
from pathlib import Path
import tempfile
from gi.repository import Gimp, Gio

spec = importlib.util.spec_from_file_location(
    "arranger", Path(__file__).resolve().parent.parent / "arrange_gimp_sheets.py")
arranger = importlib.util.module_from_spec(spec)
spec.loader.exec_module(arranger)


def layer(image, name, width, height, x=0, y=0, visible=True):
    item = Gimp.Layer.new(image, name, width, height, Gimp.ImageType.RGBA_IMAGE,
                          100, Gimp.LayerMode.NORMAL)
    image.insert_layer(item, None, 0)
    item.fill(Gimp.FillType.WHITE)
    item.set_offsets(x, y)
    item.set_visible(visible)
    return item


def main():
    with tempfile.TemporaryDirectory(prefix="verified-gimp-grid-test-") as scratch:
        destination = Path(scratch)
        for target in arranger.SHEETS:
            sheet = Gimp.Image.new(*target["page"], Gimp.ImageBaseType.RGB)
            sheet.set_resolution(target["ppi"], target["ppi"])
            background = layer(sheet, "Background", *target["page"], -8, 0)
            background.set_lock_position(True)
            labels = [layer(sheet, name, *target["size"], i * 4, i * 5)
                      for i, name in enumerate(target["names"])]
            hidden = layer(sheet, "Hidden spare", 30, 20, 123, 456, False)
            source = destination / (target["key"] + "_original.xcf")
            assert Gimp.file_save(Gimp.RunMode.NONINTERACTIVE, sheet,
                                 Gio.File.new_for_path(str(source)))
            original_hash = hashlib.sha256(source.read_bytes()).hexdigest()
            assert arranger.matching_spec(sheet) is target

            # Verify guarded failures before attempting a successful move.
            sheet.set_resolution(300, 300)
            assert "resolution differs" in arranger.rearrange(sheet, destination)
            sheet.set_resolution(target["ppi"], target["ppi"])
            labels[0].set_lock_position(True)
            assert "position locked" in arranger.rearrange(sheet, destination)
            labels[0].set_lock_position(False)
            extra = layer(sheet, "Unexpected visible item", 20, 20)
            assert arranger.rearrange(sheet, destination).startswith("SKIPPED")
            sheet.remove_layer(extra)
            assert [item.get_offsets()[1:] for item in labels] == [
                (i * 4, i * 5) for i in range(len(labels))]

            message = arranger.rearrange(sheet, destination)
            assert message.startswith("ARRANGED"), message
            assert [item.get_offsets()[1:] for item in labels] == list(target["positions"])
            assert all((item.get_width(), item.get_height()) == target["size"]
                       for item in labels)
            assert sheet.get_file().get_path() == str(source)
            assert hashlib.sha256(source.read_bytes()).hexdigest() == original_hash
            assert background.get_offsets()[1:] == (-8, 0)
            assert background.get_lock_position()
            assert hidden.get_offsets()[1:] == (123, 456) and not hidden.get_visible()
            for ending, expected in (
                ("before", [(i * 4, i * 5) for i in range(len(labels))]),
                ("grid", list(target["positions"])),
            ):
                saved = destination / f"{target['key']}_{sheet.get_id()}_{ending}.xcf"
                check = Gimp.file_load(Gimp.RunMode.NONINTERACTIVE,
                                      Gio.File.new_for_path(str(saved)))
                ordered = arranger.selected_layers(check, target)
                assert [item.get_offsets()[1:] for item in ordered] == expected
                check.delete()
            assert arranger.rearrange(sheet, destination).startswith("UNCHANGED")
            sheet.delete()
            print("PASS:", target["key"], flush=True)

        # Unrecognized 300-PPI documents remain untouched.
        other = Gimp.Image.new(2550, 3300, Gimp.ImageBaseType.RGB)
        other.set_resolution(300, 300)
        old = layer(other, "09_fallout.png", 900, 1050, 945, 21)
        assert arranger.matching_spec(other) is None
        assert arranger.rearrange(other, destination).startswith("SKIPPED")
        assert old.get_offsets()[1:] == (945, 21)
        other.delete()
    print("PASS: all six exact layouts, guards, unchanged pixels dimensions, backups, original-file preservation, background/hidden positions, safe reruns and unrelated-sheet exclusion.")


if __name__ == "__main__":
    main()
