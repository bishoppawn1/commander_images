# Boulder deck-top labels: 1440-DPI edition

## Scope

The collection contains 100 physical Commander Boulder deck-top placements representing 99 unique designs. Every placement has a 1440-DPI file. Breed Lethality accounts for the difference: its Commander Anthology Volume II design is reused as a second file in the Commander 2016 folder.

- Output size: 3960 × 3360 pixels
- Embedded density: 1440 DPI on both axes
- Printed size at Actual Size: 2.75 × 2.333 inches
- Filename suffix: `_boulder_top_label_tall_3960x3360_1440dpi.png`
- Existing 3300 × 2800, 1200-DPI tops: retained
- Front, face, and battle-face artwork: unchanged
- Contact sheets: unchanged
- Source artwork: unchanged
- `archive_v1` files: unchanged

## Rebuild

For a manifest-based release:

```sh
BOULDER_DPI=1440 BOULDER_SKIP_CONTACT_SHEET=1 \
  swift images/build_boulder_labels.swift "$PWD" \
  images/<release>_boulder_deck_box_labels/label_manifest.json \
  images/<release>_boulder_deck_box_labels
```

For Commander Anthology:

```sh
BOULDER_DPI=1440 BOULDER_SKIP_CONTACT_SHEET=1 \
  swift images/commander_anthology_i/Tops/src/build_labels.swift \
  "$PWD" images/commander_anthology_i/Tops
```

The renderers use the original 3300 × 2800 logical layout and a 1.2× rendering transform. This produces genuine 3960 × 3360 output while retaining the exact physical size and established composition.

## Verification

- Expected physical deck-top files: 100
- Unique label designs: 99
- 1440-DPI deck-top files produced: 100
- Missing 1440-DPI counterparts: 0
- Incorrect dimensions or DPI metadata: 0
- 1440-DPI files added under `archive_v1`: 0
- 1440-DPI contact sheets generated: 0
- Swift renderer type-checks: passed
- Visual inspection: Fae Dominion, Breed Lethality, and Avengers Assemble passed
