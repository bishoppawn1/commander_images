# Commander Masters — official WPN poster adaptation brief

## Production decision

- Use case: precise-object-edit.
- Asset type: print-ready 3 x 3.5-inch portrait drawer face representing all four Commander Masters decks.
- Generation mode: deterministic, non-generative adaptation of official Wizards Play Network materials. Built-in ImageGen is not used.
- Exact dominant identification text: **`COMMANDER MASTERS`**.
- Source identity: preserve the official PINDURSKI dragon key art and reuse Wizards' exact English `COMMANDER MASTERS` wordmark pixels without redrawing any letters.

## Retained source inputs and roles

- `src/cmm_lgp_key_24x36_en.pdf`: authoritative official WPN 24 x 36 key-art poster and selected art source.
- `src/cmm_lgp_key_24x36_en_render_150dpi.png`: lossless 150-DPI production raster of the poster; direct crop input.
- `src/cmm_alg_en.zip`: untouched official WPN art-and-logos archive.
- `src/cmm_alg_en/MTGCMM_MSL_EN_4C.png`: exact official transparent English wordmark; direct typography input.
- `src/cmm_alg_en/CMM_1080p_en.jpg`: official branded landscape key-art comparison.
- `src/cmm_key_art_sma_en.zip`: untouched official WPN social-media archive.
- `src/cmm_key_art_sma_en/cmm_sma_insta_1080x1920_en.jpg`: official vertical social candidate; portrait comparison only.
- `src/cmm_key_art_sma_en/cmm_sma_fb_1000x1000_en.jpg`, `cmm_sma_fb_groups_1640x680_en.jpg`, and `cmm_sma_fb_pages_1600x841_en.jpg`: official square/wide composition comparisons only.

## Exact deterministic transformation

1. Rasterize page 1 of the retained 24 x 36 poster with Poppler at 150 DPI, producing exact 3600 x 5400 RGB pixels.
2. Crop `x=0, y=0, width=3600, height=4200`, an exact 6:7 upper-poster region. This retains the complete primary dragon, surrounding flight of dragons, cosmic color, and the Magic mark while ending before the source poster's low title treatment.
3. Resample the crop once with high-quality interpolation to exact 1800 x 2100 pixels on an sRGB RGBA canvas.
4. Add only a soft edge-fading lower black-green vignette so artwork remains visible behind the title; do not add a footer, panel, border, or featureless band.
5. Crop transparent padding only from the official 900 x 407 logo at `x=90, y=92, width=721, height=220`. Place it at displayed `x=45, y=1200, width=1710, height=522`, retaining all official letterforms, spacing, fills, outlines, and dimensional extrusion unchanged. Add only a restrained dark shadow for separation.
6. Write exact 600 x 600 DPI PNG metadata and preserve the unnumbered base.
7. Create the counted sibling non-destructively with `scripts/apply_deck_count.swift` and marker specification `4:1800`. The approved 210-pixel seal must occupy displayed `x=1520–1730, y=1820–2030`, leaving exactly 70 pixels at the right and bottom outer edges and not touching the title.

## Finished targets

- `commander_masters_official_wpn_poster_target_v1_1800x2100.png`
- `commander_masters_official_wpn_poster_target_v1_deck_count_4_1800x2100.png`

## Quality constraints

- Full bleed, visually dense, no product-photo background, blank footer, white border, or large low-information area.
- `COMMANDER MASTERS` appears exactly once, uses the official wordmark, spans nearly the full usable width, and remains immediately legible at 300 x 350 drawer scale.
- Preserve the dragon's face and mouth as the focal point. The title and count seal must not collide, and the seal may cover only noncritical lower-right cosmic/dragon texture.
- Final base and counted sibling must be exact 1800 x 2100, 6:7, 600 DPI, and sRGB RGB(A).
