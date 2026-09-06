# Commander 2013 | Commander 2016 optional split — source and production record

## Scope and count decision

This directory is an optional combined candidate only. It does not replace the standalone Commander 2013 or Commander 2016 faces and does not change their standalone drawer grouping.

- Left panel: Commander 2013, two owned decks — Eternal Bargain and Mind Seize — count seal `2`.
- Right panel: Commander 2016, two owned decks — Invent Superiority and Breed Lethality — count seal `2`.
- Chronological order: Commander 2013 left, Commander 2016 right.
- Final count invocation: `2:900 2:1800`.

The right panel retains the approved Breya-centered Commander 2016 artwork direction as the established release identity. Its `2` seal represents both owned physical decks; the panel title identifies the annual release rather than listing individual deck names.

## Copied production inputs

The standalone directories remain untouched. Project-local copies are retained here so the combined build is reproducible from its own `src/` directory.

| Combined source file | Original project source | Origin / role | Dimensions or format | SHA-256 |
| --- | --- | --- | ---: | --- |
| `commander_2013_v3_title_free_raw.png` | `../../commander_2013/src/imagegen_commander_2013_owned_decks_cover_v3_title_free_raw.png` | Accepted unmodified built-in ImageGen cleanup output from Commander 2013 v3. Title-free Jeleva/Oloro artwork; see the standalone `src/sources.md` and v3 prompt for the complete official Wizards reference and generation record. | 1162 × 1353 PNG | `a84decd3043e2aa3a28908fd927a1214355e3ea27429ccfdb17db470712336bd` |
| `commander_2016_breya_artwork_raw.png` | `../../commander_2016/src/commander_2016_invent_superiority_breya_v1_imagegen_raw.png` | Unmodified built-in ImageGen portrait source from the approved Commander 2016 typography v2 candidate. Breya/Esper artifact artwork; see the standalone `src/sources.md` and prompts for the official Clint Cearley/Wizards reference record. | 1162 × 1353 PNG | `aa7ab8ff74f4d526022915f86a292144cad08d985466817490b96156264c325b` |
| `AlegreyaSC-Medium.ttf` | `../../commander_2013/src/AlegreyaSC-Medium.ttf` | Accepted Commander 2013 v3 title face by Juan Pablo del Peral / Huerta Tipográfica; SIL Open Font License. | TrueType, Medium 500 | `fa896222115cc9a41c0695a3ee6feafbaba97932e9bb6240520b3feeb560ea2c` |
| `OFL_AlegreyaSC.txt` | `../../commander_2013/src/OFL_AlegreyaSC.txt` | Retained Alegreya SC license. | UTF-8 text | `f6f60d5d4cf4f4b1fc4e41353c897a2f5a16e6396c0cd8fa8bdfd2f4586a9a68` |
| `cinzel_decorative_black.ttf` | `../../commander_2016/src/cinzel_decorative_black.ttf` | Approved Commander 2016 v2 ornamental title face by Natanael Gama; SIL Open Font License. | TrueType, Black 900 | `a6c1eb3e228f639a98aafd8a8e8a035582dd50ad5f8a84e9dcbc8664e7457114` |
| `cinzel_decorative_OFL.txt` | `../../commander_2016/src/cinzel_decorative_OFL.txt` | Retained Cinzel Decorative license. | UTF-8 text | `1e5d6660366ddcfca4f2fc10e2acfba9fa4d97d40aec80d7dbfd41d730a420ae` |

## Deterministic transformations

`build_commander_2013_commander_2016_vertical_split.swift` creates the combined base with CoreGraphics/CoreText only; no new ImageGen generation or edit is performed for this candidate.

1. Creates an exact 1800 × 2100 sRGB canvas and two equal 900-pixel panels.
2. Scales each 1162 × 1353 raw source to the full 2100-pixel target height, producing an approximately 1804-pixel-wide draw before panel clipping.
3. Rebuilds the Commander 2013 half from the clean v3 source rather than squeezing a standalone face:
   - Oloro/lower-throne focus uses source x = 520.
   - Jeleva/upper-night focus uses source x = 820.
   - A deterministic 24-step transition from CoreGraphics y = 1180 through y = 1600 merges the focal crops through the existing veil/mist field.
   - A feathered atmospheric ellipse supports the open title without forming a plaque or band.
4. Rebuilds the Commander 2016 half from the clean Breya raw source with source x = 580 centered in its panel.
5. Draws exact stacked `COMMANDER` / `2013` in Alegreya SC Medium using the accepted v3 pale-silver, fine-graphite, open treatment with cyan/crimson year hairlines.
6. Draws exact stacked `COMMANDER` / `2016` in Cinzel Decorative Black using the approved v2 engraved Etherium silver/gold/cyan treatment with restrained open filigree.
7. Adds exactly one straight 6-pixel pale-gold divider centered on x = 900. There are no gutters, outer borders, or additional panel dividers.
8. Writes 600-DPI metadata to the exact 6:7 PNG.

The complete build brief is retained at `../prompts/commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_brief.md`.

## Finished assets

| File | Role | Dimensions | Transformations / QA | SHA-256 |
| --- | --- | ---: | --- | --- |
| `../commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_1800x2100.png` | Finished unnumbered optional split base | 1800 × 2100 PNG, 600 DPI | Deterministic two-panel recomposition and exact typography described above. Both standalone directories remain untouched. | `eafd096c8ad2497c6df511a10571c84ce6b306e67d8a27cd5cbeca6bd9277453` |
| `../commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_deck_counts_2_2_1800x2100.png` | Finished counted sibling | 1800 × 2100 PNG, 600 DPI | Created from the unnumbered base with `/usr/bin/swift scripts/apply_deck_count.swift ... 2:900 2:1800`. Two standard 210-pixel seals use exact 70-pixel bottom clearance; the left seal is inset 70 pixels from the divider and the right seal 70 pixels from the canvas edge. | `c5e6998c25e0814cc194baeddc38caa3c0d470ca6b2f42379dbfbf21687db5e6` |

## Build support and QA previews

- `build_commander_2013_commander_2016_vertical_split.swift`: rerunnable deterministic compositor.
- `commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_drawer_preview.png`: 450 × 525 unnumbered drawer-scale preview.
- `commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_deck_counts_2_2_drawer_preview.png`: 450 × 525 counted drawer-scale preview.
- `commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_deck_counts_2_1_superseded_draft.png` and its preview are retained in `src` only as superseded production artifacts from before the user's Commander 2016 count correction. They are not finished targets and are not present in the combined root.

## Visual QA

The base and corrected `2 | 2` counted target were inspected at full resolution and at 450 × 525 drawer scale on 2026-08-26.

- Exact `COMMANDER 2013` appears once on the left and exact `COMMANDER 2016` appears once on the right; no earlier title layer remains.
- Both titles remain immediately readable at drawer scale while retaining distinct release-native typography.
- Jeleva, Oloro, and Breya remain coherent and recognizable; no title or seal covers a face or essential hand detail.
- The central divider is the only hard seam and remains straight, narrow, continuous, and high contrast.
- Both panels are full-bleed and atmospherically distinct with no blank areas or blended center gutter.
- The corrected left and right seals both read `2`. They cover only expendable floor/artifact detail and use the approved geometry.
- `sips` reports exact 1800 × 2100 dimensions, RGB PNG output, and 600 × 600 DPI metadata for both finished targets.

## SHA-256 checksums

```text
eafd096c8ad2497c6df511a10571c84ce6b306e67d8a27cd5cbeca6bd9277453  commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_1800x2100.png
c5e6998c25e0814cc194baeddc38caa3c0d470ca6b2f42379dbfbf21687db5e6  commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_deck_counts_2_2_1800x2100.png
a84decd3043e2aa3a28908fd927a1214355e3ea27429ccfdb17db470712336bd  commander_2013_v3_title_free_raw.png
aa7ab8ff74f4d526022915f86a292144cad08d985466817490b96156264c325b  commander_2016_breya_artwork_raw.png
fa896222115cc9a41c0695a3ee6feafbaba97932e9bb6240520b3feeb560ea2c  AlegreyaSC-Medium.ttf
a6c1eb3e228f639a98aafd8a8e8a035582dd50ad5f8a84e9dcbc8664e7457114  cinzel_decorative_black.ttf
f6f60d5d4cf4f4b1fc4e41353c897a2f5a16e6396c0cd8fa8bdfd2f4586a9a68  OFL_AlegreyaSC.txt
1e5d6660366ddcfca4f2fc10e2acfba9fa4d97d40aec80d7dbfd41d730a420ae  cinzel_decorative_OFL.txt
7700ef44137825f2ee3204d3647ac73240d367a11102890a1cce10ee91b6affd  build_commander_2013_commander_2016_vertical_split.swift
9d472750e76859b62bbb51d6b01e59dd310d800f81c7b367a0909c1a90203785  commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_drawer_preview.png
40ff4acda110c69fa512a61f9635379ceb0e4411284b7b85d1dc6c6e55b05972  commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_deck_counts_2_2_drawer_preview.png
```
