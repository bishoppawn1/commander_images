"""Anthology-only sheet manifest, using the project-wide grid geometry."""
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
from arrange_gimp_sheets import grid_positions

DECKS = [
    "heavenly_inferno", "evasive_maneuvers",
    "guided_by_nature", "plunder_the_graves",
    "devour_for_power", "built_from_scratch",
    "wade_into_battle", "breed_lethality",
]
SHEET_NAME = "commander_anthology_letter_grid_1200ppi"


def anthology_positions():
    return grid_positions(10200, 13200, [(3300, 2800)] * 8, 1200, 1200,
                          columns=2, side_margin=0.75)[0]
