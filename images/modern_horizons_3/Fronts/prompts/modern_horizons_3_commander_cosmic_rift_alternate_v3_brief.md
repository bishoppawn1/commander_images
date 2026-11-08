# Modern Horizons 3 Commander — cosmic-rift alternate v3 final brief

## Production decision

- Use case: precise-object-edit.
- Asset type: print-ready 3 × 3.5-inch portrait drawer face for the complete four-deck Modern Horizons 3 Commander release.
- Production mode: deterministic, non-generative adaptation of the retained official WPN oversized art and official WPN set logo. Built-in ImageGen is not used because the official landscape artwork already has enough detail for a strong portrait crop; no extension or regeneration is necessary.
- Exact dominant identification text: **`MODERN HORIZONS 3`**. The last character is one Arabic numeral `3`; the official source's Roman `III` is completely excluded.
- This is a non-destructive secondary candidate. Preserve both existing v2 poster targets unchanged.

## Retained source inputs and roles

- `src/mh3_oversized_art_72x48.pdf`: authoritative official WPN oversized artwork and source of the high-energy red, violet, cyan, and white planar-rift composition; the PDF credit identifies the artist as Alan Lathwell.
- `src/mh3_oversized_art_72x48_render_100dpi.png`: new 7259 × 4859, 100-DPI lossless production raster from the retained PDF; direct crop target.
- `src/mh3_alg_en/MTGMH3_EN_SetLogo_4C.png`: official transparent WPN Modern Horizons III set logo. Use its exact `MODERN HORIZONS` pixels and exclude its Roman numeral rows.
- `src/mh3_alg_en/MTGMH3_EN_SetLogo_4C.tif`: high-resolution official logo reference inspected for shape, spacing, and pearl-pink/cyan material; not composited because it has a white background.
- `src/mh3_lgp_key_24x36_en_render_200dpi.png`, all `src/mh3_key_art_sma_en/` layouts, and `src/mh3_alg_en/mh3_alg_1080p_en.jpg`: retained comparison references. They confirm the established logo treatment, but their teal Ajani composition is intentionally not reused for this broader redesign.
- `src/modern_horizons_3_commander_cosmic_rift_alternate_v3_draft*.png`, crop previews, and 360 × 420 QA files: production and review intermediates only; never final targets.

## Exact deterministic adaptation

1. Render the retained official oversized-art PDF at 100 DPI to `7259 × 4859` pixels.
2. Crop the production raster at `x=1800, y=0, width=4164, height=4858`, an exact 6:7 portrait region. This keeps the spectral blade-wielder, the roaring armored leonin, the blue-white impact, and the red volcanic rift while excluding the source Magic wordmark and both corner credit blocks.
3. Resample once with high-quality interpolation to exact `1800 × 2100` pixels in sRGB.
4. Preserve the artwork full bleed. Add only a translucent plum-to-clear lower vignette and a soft elliptical rift-colored bloom to establish contrast; do not add a solid footer, border, frame, blank field, or Commander-character montage.
5. Crop the official transparent logo to `x=0, y=0, width=900, height=240`, retaining the exact official `MODERN HORIZONS` wordmark and excluding all source Roman-numeral rows. Place it at `x=55, y=392, width=1690, height=451` in bottom-left Core Graphics coordinates, with dark depth shadow plus restrained cyan and magenta bloom.
6. Add one centered Arabic `3` in Bodoni Seventy-Two ITC Bold at 330 points. Match the official logo's material with a pale pearl/blush/cyan gradient, magenta edge, dark crystalline extrusion, and pale highlight. Slightly overlap the wordmark and connect it with two translucent prismatic shoulders so `MODERN HORIZONS 3` reads as one cohesive lockup, not a detached numeral.
7. Add no other words, logos, set symbols, numerals, watermarks, signatures, frames, or panels.
8. Write exact 600 × 600 DPI PNG metadata.
9. Preserve the unnumbered base, then create a counted sibling with `scripts/apply_deck_count.swift` and marker specification `4:1800`. The approved 210-pixel seal must occupy x=1520–1730 and y=1820–2030 in top-left coordinates, yielding exactly 70 pixels of right and bottom outer-edge inset.

## Acceptance criteria

- The dominant title reads exactly **`MODERN HORIZONS 3`** once at full size and 360 × 420 drawer scale.
- `HORIZONS` spans nearly the full usable width; the Arabic `3` shares the wordmark's luminous prismatic material and is visibly connected into the lockup.
- The official art fills the complete card with useful detail. There is no flat teal footer, detached pink numeral, generic sans-serif title, large solid-color field, unnecessary Commander montage, white trim, or empty border.
- The leonin face, spectral warrior, glowing blade, red rift, and blue-white impact remain clear and recognizable.
- The counted seal does not overlap the title or a critical face and retains the approved project geometry.

## Finished targets

- `modern_horizons_3_commander_cosmic_rift_alternate_v3_1800x2100.png`
- `modern_horizons_3_commander_cosmic_rift_alternate_v3_deck_count_4_1800x2100.png`
