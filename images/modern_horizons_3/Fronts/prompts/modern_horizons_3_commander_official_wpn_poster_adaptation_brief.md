# Modern Horizons 3 Commander — official WPN poster adaptation brief

## Production decision

- Use case: precise-object-edit.
- Asset type: print-ready 3 × 3.5-inch portrait drawer face for the complete four-deck Modern Horizons 3 Commander release.
- Production mode: direct, non-generative adaptation of Wizards Play Network's official Modern Horizons 3 24 × 36 key-art poster. Do not create a Commander-lead montage and do not regenerate Wisnu Tan's Ajani artwork.
- Exact dominant identification text: **`MODERN HORIZONS 3`**. The final character must be the Arabic numeral `3`, not the poster's Roman `III`.

## Retained source inputs and roles

- `src/mh3_lgp_key_24x36_en.pdf`: authoritative official WPN 24 × 36 poster and selected source artwork; Wisnu Tan's Ajani key art and integrated Modern Horizons branding are the visual authority.
- `src/mh3_lgp_key_24x36_en_render_200dpi.png`: lossless 200-DPI production raster of the selected official poster; direct edit target.
- `src/mh3_lgp_key_24x36_en_render.png`: lower-resolution full-poster review raster; visual comparison only.
- `src/mh3_key_art_sma_en.zip`: untouched official WPN key-art social-media archive.
- `src/mh3_key_art_sma_en/mh3_sma_key_1080x1920_en.jpg`: official vertical social asset; confirms the intended portrait Ajani composition and title palette, but its large sky area and lower resolution make it secondary to the poster.
- `src/mh3_key_art_sma_en/mh3_sma_key_1000x1000_en.jpg`, `mh3_sma_key_1600x841_en.jpg`, `mh3_sma_key_1640x680_en.jpg`, and `mh3_sma_key_1920x1080_en.jpg`: official square and landscape layout comparisons; not composited.
- `src/mh3_alg_en.zip`: untouched official WPN art-and-logos archive.
- `src/mh3_alg_en/MTGMH3_EN_SetLogo_4C.png`: official set-logo reference; not composited because it ends in Roman `III` rather than the required Arabic `3`.
- `src/mh3_alg_en/mh3_alg_1080p_en.jpg`: official art/logo presentation reference; not composited.
- `src/mh3_oversized_art_72x48.pdf` and `src/mh3_oversized_art_72x48_render.png`: official alternate Ajani oversized art credited in the asset to Alan Lathwell; inspected as a color-rich landscape alternative but not selected because it lacks the established branded vertical identity of the Wisnu Tan poster.

## Adaptation instructions

- Crop the official 4917 × 7317 poster raster to `x=18, y=1240, width=4881, height=5695`, then resample that portrait region to exact 1800 × 2100 pixels in sRGB. The slight horizontal inset removes both poster trim edges before full-bleed resampling.
- The crop must remove the printer marks, the small Magic wordmark, and most of the airy upper sky while preserving Ajani's face, hair, axe, chest, arm, detailed clothing, surrounding leaves, mountain and waterfall context, and the official `MODERN HORIZONS` lettering.
- Preserve every retained artwork pixel and the official words `MODERN HORIZONS` unchanged.
- Change only the bottom Roman-numeral field: cover `III` with the poster's sampled uniform title-field teal (`#369E85`) and render one centered Arabic `3` in pale pearl Copperplate Bold with a restrained magenta outline and dark teal shadow. Add no other words, logos, characters, watermarks, signatures, frames, mats, or borders.
- The complete stacked title must read exactly **`MODERN HORIZONS 3`** once, remain highly dominant, and have `HORIZONS` span most of the full usable width for immediate drawer-distance recognition.
- Keep the composition full bleed and visually dense. The selected crop must not leave a large blank sky region, white field, empty corner, smooth black band, or unbranded featureless panel.
- Write exact 600 × 600 DPI PNG metadata. Preserve the unnumbered base in the set root.
- Create a counted sibling non-destructively with `scripts/apply_deck_count.swift` and marker specification `4:1800`. The approved 210-pixel seal must occupy x=1520–1730 and y=1820–2030 in top-left coordinates, giving exactly 70 pixels of right and bottom outer-edge inset.

## Finished targets

- `modern_horizons_3_commander_official_wpn_poster_target_v2_1800x2100.png`
- `modern_horizons_3_commander_official_wpn_poster_target_v2_deck_count_4_1800x2100.png`
