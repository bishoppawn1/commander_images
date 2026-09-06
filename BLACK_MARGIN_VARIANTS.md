# Print-margin variants — black

Every finished face target retains its full-bleed original and has a non-destructive active print sibling whose filename ends in `_1724x2024_black_margin_1_8in.png`.

All active variants use the finalized treatment prototyped on Commander Masters:

- 1724 × 2024 outer canvas at 600 DPI.
- 1644 × 1944 complete-face artwork rectangle centered at `x=40`.
- Artwork drawn at Core Graphics `y=96`, so its uppermost 16 pixels extend beyond the canvas and are clipped.
- Opaque-black (`#000000`) fill throughout all exposed print-margin space.
- Three-pixel opaque-black cut guide on every outer edge.
- Visible black margin of 37 pixels on each side, none at the top, and 93 pixels at the bottom.
- The title, count marker, dividers, and artwork are transformed together; individual elements are not moved or redrawn.

The `black_margin_1_8in` filename label directly describes the active files. The black color and exact asymmetric geometry above are authoritative.

The replaced 1800 × 2100 3/16-inch files are preserved under each set's `src/superseded_white_margin_3_16in/`. No active `_white_margin_3_16in.png` files remain in set-directory roots.

## Reproduction

```sh
swift scripts/crop_white_margin.swift input_white_margin_3_16in.png output_white_margin_1_8in.png 38
swift scripts/validate_white_margin_crop.swift input_white_margin_3_16in.png output_white_margin_1_8in.png 38 75
swift scripts/add_cut_border.swift output_white_margin_1_8in.png bordered.png 3
swift scripts/reframe_final_black_margin.swift bordered.png reframed.png
swift scripts/validate_final_black_margin.swift reframed.png
```

To reconstruct the archived 3/16-inch intermediate from a full-bleed target:

```sh
swift scripts/apply_white_margin.swift input.png output_white_margin_3_16in.png
```

Validate one or more archived intermediates:

```sh
swift scripts/validate_white_margin.swift output_white_margin_3_16in.png
```

## Batch status — 2026-08-31

All 93 active print variants across 35 set/group directories use this geometry and opaque-black margin treatment. Every file passed exact checks for dimensions, 600-DPI metadata, black-margin allocation, the three-pixel black cut guide, and artwork bounds. A full before/after pixel comparison also confirmed that only the formerly white exposed margin pixels changed; all artwork pixels remained identical. Representative single-set, dual-set, alternate-typography, numbered, and unnumbered faces passed visual inspection. SHA-256 values are recorded in `BLACK_MARGIN_SHA256.txt`.
