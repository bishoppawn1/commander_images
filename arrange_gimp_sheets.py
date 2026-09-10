"""Convenience entry point; run from GIMP 3's Python Console."""
from pathlib import Path
import runpy

runpy.run_path(str(Path(__file__).resolve().parent / "images" /
                  "commander_anthology_deck_box_labels" / "src" /
                  "arrange_open_sheets.py"), run_name="__main__")
