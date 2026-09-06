# Commander Anthology Boulder top labels

This folder contains eight tall labels for the top of an Ultimate Guard Boulder 100+ deck box. The current recommended print files end in `_tall_3300x2800_1200dpi.png`; earlier 600 DPI revisions remain available for comparison.

## Print specification

- Final label size: **2.75 × 2.333 inches** (**69.85 × 59.27 mm**)
- Raster dimensions: **3300 × 2800 pixels**
- Embedded print density: **1200 DPI**
- Print at **100% / Actual Size**. Disable “Fit to Page” and automatic scaling.
- The format was sized from the supplied Boulder photo to fill nearly all of the lid's usable flat plateau while staying clear of its rounded/chamfered lip. It leaves about **3.1 mm at each side** of the 76 mm lid.

The contact sheet is for preview only. Print the eight individual PNG files at their embedded 1200 DPI size.

The current revision follows the compact hierarchy demonstrated by the supplied physical-label references: authentic mana symbols at the top, a one-line deck title, one concise strategy line, and a one-line true-white product title. These elements are grouped closely in the upper half so far more commander artwork remains visible. Breed Lethality uses a brighter silver-blue Atraxa scene so it remains legible when printed. All text and graphic elements are rendered directly at the final 3300 × 2800 resolution.

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

Each label uses a newly generated tall commander painting rather than enlarging a finished lower-resolution label. The renderer combines that art with locally retained Scryfall mana symbols and freshly rasterized typography at the 3300 × 2800 target. The color row uses the same printed-mana-cost order as each face commander.

The eight original official crops remain unchanged under `images/commander_anthology_i/src/` and `images/commander_anthology_ii/src/`. The smaller 1500 × 900 label files have been removed. The current tall backgrounds are under `src/regenerated_art_v3_tall/`; their exact ImageGen prompts are in `prompts/regenerated_art_v3_tall_1200dpi_prompts.md`.

The set-agnostic production recipe is in [`../BOULDER_DECK_BOX_LABEL_GENERATION_SPEC.md`](../BOULDER_DECK_BOX_LABEL_GENERATION_SPEC.md). Commander Anthology-specific wording, sources, and rebuild details are in [`COMMANDER_ANTHOLOGY_LABEL_CONTENT.md`](COMMANDER_ANTHOLOGY_LABEL_CONTENT.md).

## Rebuild

From the repository root:

```sh
swift images/commander_anthology_deck_box_labels/src/build_labels.swift \
  "$PWD" \
  "$PWD/images/commander_anthology_deck_box_labels"
```
