# Commander Anthology Boulder top labels

This folder contains eight enlarged landscape labels for the top of an Ultimate Guard Boulder 100+ deck box. The current recommended print files contain `_bright_` in their filenames; the previous darker revision remains available for comparison.

## Print specification

- Final label size: **2.75 × 1.967 inches** (**69.85 × 49.95 mm**)
- Raster dimensions: **1650 × 1180 pixels**
- Embedded print density: **600 DPI**
- Print at **100% / Actual Size**. Disable “Fit to Page” and automatic scaling.
- The new format was sized from the supplied photo to fill nearly all of the Boulder lid's usable flat plateau while staying clear of its rounded/chamfered lip. It leaves about **3.1 mm at each side** of the 76 mm lid.

The contact sheet is for preview only. Print the eight individual PNG files at their embedded 600 DPI size.

The bright revision lifts shadow detail throughout the commander artwork and substantially reduces the dark top and bottom veils. Breed Lethality receives an additional print-oriented exposure lift because its Atraxa scene is naturally much darker than the other seven. Each deck title is reflowed onto two balanced lines at a much larger type size. The set identification now uses larger, heavy true-white lettering; Commander Anthology Volume II is split over two lines so it remains clearly readable at the physical print size.

## Label contents

| Product | Deck | Colors |
| --- | --- | --- |
| Commander Anthology | Heavenly Inferno | White, Black, Red |
| Commander Anthology | Evasive Maneuvers | White, Blue, Green |
| Commander Anthology | Guided by Nature | Green |
| Commander Anthology | Plunder the Graves | Black, Green |
| Commander Anthology Volume II | Devour for Power | Blue, Black, Green |
| Commander Anthology Volume II | Built from Scratch | Red |
| Commander Anthology Volume II | Wade into Battle | White, Red |
| Commander Anthology Volume II | Breed Lethality | White, Blue, Black, Green |

Each enlarged label uses a newly regenerated 7:5 commander painting rather than stretching the previous background. ImageGen produced each clean v2 scene at 1484 × 1060 pixels in the final aspect ratio, and the print renderer performs only a modest approximately 11% resample to 1650 × 1180. This avoids the halftone dots, compression, and softness caused by enlarging small card-art crops. The symbols, title, set line, borders, and spacing were all enlarged with the physical label—not only the background image. The color row uses authentic MTG mana-symbol artwork in the same printed-mana-cost order used by each face commander.

The eight original official crops remain unchanged under `images/commander_anthology_i/src/` and `images/commander_anthology_ii/src/`. The smaller 1500 × 900 label files have been removed. The v1 paintings remain available as source history; the new v2 backgrounds are under `src/regenerated_art_v2_7x5/`, and the exact ImageGen prompt set is recorded under `prompts/regenerated_art_v2_7x5_prompts.md`.

## Rebuild

From the repository root:

```sh
swift images/commander_anthology_deck_box_labels/src/build_labels.swift \
  "$PWD" \
  "$PWD/images/commander_anthology_deck_box_labels"
```
