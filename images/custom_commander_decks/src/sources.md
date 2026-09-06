# Custom Commander Decks — production, provenance, and QA

## Final asset

- Finished face: `../custom_commander_decks_unnumbered.png`
- Category identity: **CUSTOM COMMANDER DECKS**
- Treatment: one standalone, unnumbered category face
- Inventory authority: `INVENTORY.md` lists the owned count as “Not supplied,” the fixed total as “None,” and the marker as “Pending owned-deck count.” No count was inferred and no numeric seal was added.
- Final raster: 1800 × 2100 pixels, exact 6:7 portrait ratio, full bleed, RGB PNG
- Print metadata: 600 × 600 DPI (`sips` reports 600.000; Pillow reads the PNG pixels-per-meter conversion as 599.9988)
- Final SHA-256: `0b4047d81dd6960bc607986777bf61aecebf0177a9556c98b5c0ad3ae80918b4`
- Final file size at production: 5,247,776 bytes

## Generation provenance

- Mode: OpenAI built-in ImageGen, new-image generation, `stylized-concept`
- Generation date: 2026-08-26
- External/reference images: none
- Official art used: none; this is an open-ended original category and no authoritative set art exists
- Human artist attribution: not applicable; AI-generated original illustration base
- Exact ImageGen prompt: `../prompts/imagegen_base_generation_prompt.txt`
- Complete final generation/finishing brief: `../prompts/custom_commander_decks_final_brief.txt`
- Unmodified generated output preserved as: `imagegen_original.png`
- Original generated dimensions: 1163 × 1353 pixels, RGB PNG, 72-DPI metadata
- Original generated SHA-256: `b93a0e780f1c8f1be8c6fc3a20c2c2d6138a8bb2882e3d266307d17792a82260`
- Original file size at production: 2,939,262 bytes
- Built-in save location before project copy: `/Users/bishophall/.codex/generated_images/01a03c80-d321-7eb0-8531-379a1c01cc94/exec-51a479a7-b3b2-437d-9764-46c88af3a488.png`
- Source role: untouched illustration base; all normalization and deterministic typography were applied only to the finished sibling in the package root

The generated scene is an original, dense fantasy card-collection still life: a central open wooden deck case, generic card backs, varied handmade deck boxes, brass dividers, blank tags, ribbons, tools, and restrained arcane light. Visual inspection found no copied character, card illustration, branded trading-card frame/back, mana-symbol system, set logo, watermark, signature, or readable generated wording.

## Deterministic production

Build helper: `build_face.py`

Rebuild command from the repository root:

```sh
uv run --with pillow python images/custom_commander_decks/src/build_face.py
```

The recorded build used Pillow 12.3.0 and the macOS system font `/System/Library/Fonts/Supplemental/Copperplate.ttc`, collection index 2 (`Copperplate Bold`). The helper performs these non-destructive steps:

1. Reads only `imagegen_original.png` from this `src/` directory.
2. Center-crops the near-6:7 source from `(1, 0)` through `(1161, 1353)`, removing three pixels total from the sides.
3. Resamples to exactly 1800 × 2100 with Lanczos and applies a restrained unsharp mask.
4. Adds a feathered translucent dark veil from roughly y=285–1040. The detailed cabinet, case, cards, and filigree remain visible beneath it; it is not an empty title plaque.
5. Typesets the exact three-line title `CUSTOM` / `COMMANDER` / `DECKS` in locally rendered Copperplate Bold. Each line is independently fitted inside a 1640-pixel safe width, centered, and drawn with pale-ivory fill, antique-gold inner rim, near-black keyline, and offset shadow.
6. Writes the final RGB PNG at 600 DPI and writes inspection artifacts and metrics to `src/`.

The title is generated from the three literal constants in `build_face.py`, so its displayed wording is deterministic rather than ImageGen-rendered. The title block occupies y=337–993. Line widths are 1634.80 px (`CUSTOM`), 1636.12 px (`COMMANDER`), and 1473.00 px (`DECKS`). Full build measurements are preserved in `title_metrics.json`.

Supporting inspection artifacts:

- `drawer_scale_preview.png` — 300 × 350 downsample used for normal drawer-distance legibility inspection
- `title_mask_preview.png` — alpha-only thumbnail proving the deterministic three-line title treatment and absence of any count badge
- `title_metrics.json` — source crop, output geometry, DPI, font, safe width, per-line metrics, and explicit `count_marker: null`

## QA record

QA completed on 2026-08-26 after inspecting both the full 1800 × 2100 final and the 300 × 350 drawer-scale preview.

| Requirement | Result | Evidence |
| --- | --- | --- |
| Exact category wording | Pass | Deterministic literal lines read `CUSTOM` / `COMMANDER` / `DECKS`; combined identity is exactly **CUSTOM COMMANDER DECKS**. No other text is present. |
| Drawer readability | Pass | At 300 × 350, all three lines remain immediate, unobstructed, centered, and high contrast. The first two lines use more than 90% of the full canvas width; the third uses about 82%. |
| Dominant identification | Pass | Three stacked title lines occupy the visually dominant upper-middle band while the deck collection remains visible around and below them. |
| Print-safe typography | Pass | Maximum title width is 1636.12 px, leaving at least about 81.94 px on each side before outer stroke/shadow; no letter touches or clips at an edge. |
| Dimensions/aspect | Pass | `sips`: 1800 × 2100 pixels; exact 6:7. |
| DPI metadata | Pass | `sips`: 600.000 × 600.000 DPI. |
| Full bleed and density | Pass | Art and useful texture extend to every edge. No large white, blank, fog-only, flat, or featureless region is present. RGB entropy is 7.736 bits; near-white pixels are only 0.0511%. |
| Personalized deck theme | Pass | Multiple materially distinct deck boxes, an open divided card case, blank tags, ribbons, tools, and individual embellishments clearly convey bespoke deck building and collection. |
| Original/non-branded imagery | Pass | No specific MTG character, card illustration, mana symbol, set logo, official card frame/back, trademark, watermark, or signature observed at full scale. Decorative motifs are generic and non-symbolic. |
| Count treatment | Pass | Unnumbered only. No numeric text, deck-count seal, or badge was created; `title_metrics.json` records `count_marker: null`. |
| Package hygiene | Pass | Package root contains only one finished PNG plus `prompts/` and `src/`; prompts, original output, helper, previews, metrics, and this record are stored in their required subdirectories. |

No revision was required after the first built composition: the base generation satisfied theme/originality/fullness constraints, and the deterministic title passed both full-size and drawer-scale review.
