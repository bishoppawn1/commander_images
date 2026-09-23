# Print-margin variants — black

Every finished face target retains its full-bleed original and its canonical 600-DPI print-margin master, whose filename ends in `_1724x2024_black_margin_1_8in.png`. Every such master also has a non-destructive 1440-DPI print sibling ending in `_4138x4858_1440dpi_black_margin_1_8in.png`.

All 600-DPI masters use the finalized treatment prototyped on Commander Masters:

- 1724 × 2024 outer canvas at 600 DPI.
- 1644 × 1944 complete-face artwork rectangle centered at `x=40`.
- Artwork drawn at Core Graphics `y=96`, so its uppermost 16 pixels extend beyond the canvas and are clipped.
- Opaque-black (`#000000`) fill throughout all exposed print-margin space.
- Three-pixel opaque-black cut guide on every outer edge.
- Visible black margin of 37 pixels on each side, none at the top, and 93 pixels at the bottom.
- The title, count marker, dividers, and artwork are transformed together; individual elements are not moved or redrawn.

The `black_margin_1_8in` filename label directly describes the active files. The black color and exact asymmetric geometry above are authoritative.

The 1440-DPI sibling is a high-quality sRGB 2.4× resampling of the complete 600-DPI master, so the title, count seal, dividers, artwork, black margins, and cut guide remain one unchanged composition. Rounding the scaled dimensions to 4138 × 4858 preserves the established physical print size to within 0.0003 inch.

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

Create and validate the 1440-DPI print siblings without overwriting the 600-DPI masters:

```sh
swift scripts/build_1440dpi_drawer_faces.swift images/*/*_1724x2024_black_margin_1_8in.png
swift scripts/validate_1440dpi_drawer_faces.swift images/*/*_4138x4858_1440dpi_black_margin_1_8in.png
```

## Batch status — 2026-09-17

All 93 active print variants across 35 set/group directories use this geometry and opaque-black margin treatment, including the four chronological two-deck pair replacements. Every file passed exact checks for dimensions, 600-DPI metadata, black-margin allocation, the three-pixel black cut guide, and artwork bounds. Representative single-set, dual-set, alternate-typography, numbered, and unnumbered faces passed visual inspection. SHA-256 values are recorded in `BLACK_MARGIN_SHA256.txt`.

## 1440-DPI batch status — 2026-09-17

All 93 canonical print-margin masters have 4138 × 4858, 1440 × 1440 DPI, 8-bit sRGB RGB(A) print siblings. The batch passed `scripts/validate_1440dpi_drawer_faces.swift`; representative single-set numbered, dual-set numbered, and unnumbered category faces also passed visual inspection. The 600-DPI masters remain preserved unchanged.


## Completed corrections — 2026-09-19

Added 18 validated 600-DPI masters and 18 matching 1440-DPI derivatives: seven final corrected candidates in both base and counted forms, plus two preserved first-pass color candidates in both forms. The interrupted conversion was completed. The print catalog selects the seven final counted candidates. See `images/DRAWER_CORRECTIONS_2026_09_19.md` and its JSON manifest.


## Typography refinement v4 — 2026-09-19

Six further base/count variants and their six 1440-DPI derivatives passed the standard validation. The project now retains 117 600-DPI print-margin variants. Current selections are in `print_catalog.json`; see `images/TYPOGRAPHY_REFINEMENTS_V4.md`.

## Readability refinements v5 — 2026-09-20

Added four base/count 600-DPI masters and their matching 1440-DPI siblings for Eldraine shadow backing and Ikoria crystalline COMMANDER 2020 lettering. Previous variants remain preserved (121 total 600-DPI variants). See `images/READABILITY_REFINEMENTS_V5.json`.

## Eldraine unified title shadow v6 — 2026-09-21

Added two base/count 600-DPI masters and matching 1440-DPI siblings; 123 total preserved 600-DPI variants. See `images/ELDRAINE_UNIFIED_SHADOW_V6.json`.


## Annual-title and split corrections — 2026-09-21

Added ten new base/counted black-margin masters and their ten 1440-DPI siblings for the five corrected fronts. All passed the existing black-margin and high-resolution validators. Exact paths and prompt records are in `images/ANNUAL_ALIGNMENT_2026_09_21.md`; their hashes are appended to `BLACK_MARGIN_SHA256.txt`. Earlier files remain preserved.
