# Commander Legends — typography alternate v2 brief

## Mode and intended use

- Use case: `text-localization` / deterministic official-contour restoration and compositing.
- Asset type: 3 × 3.5-inch portrait drawer-face card.
- Production mode: deterministic raster adaptation; built-in ImageGen is not required because the retained official poster provides the complete Jeska art and an exact clean title silhouette.
- Exact dominant identification text, rendered once and verbatim: `COMMANDER LEGENDS`.

## Input images and roles

- `src/official_poster_page1_600dpi.png`: **edit target and sole finished-art source**. Preserve the official Magali Villeneuve Jeska illustration, full upper-left Magic mark, storm-lit red/navy sky, weapons, clothing and cape.
- `src/official_commander_legends_wordmark_extracted.png`: **exact official title contour**. Preserve its `COMMANDER`-above-`LEGENDS` letterforms and spacing without font substitution or redraw.
- `src/official_wizards_commander_legends_vertical_key_art_poster_en.pdf` and `src/official_poster_preview-1.png` through `official_poster_preview-3.png`: official poster-family references. Page 1 remains the selected Jeska composition; pages 2–3 confirm the shared white serif lockup and purple/teal product language.
- `src/official_wpn_commander_legends_key_art.jpg`: official WPN Jeska key-art reference for the compact lockup silhouette and teal-metal lower tones.
- `src/official_wizards_branded_jeska_key_art.jpg`: primary material/color reference for the official pale-silver-to-teal wordmark face over purple/teal texture.
- `src/official_wordmark_crop_preview.png` and `src/official_wordmark_tight_crop_preview.png`: contour and crop verification references.
- `src/official_wizards_jeska_key_art_cutout.png` and `src/official_wizards_commander_legends_texture_background.jpg`: retained compositing references; inspect but do not substitute them for the higher-resolution poster art.
- `src/official_wizards_commander_decks_product_reference.png`, `src/official_reap_the_tides_packaging.png`, and `src/official_arm_for_battle_packaging.png`: official package references confirming the two-deck product family and its cool/warm Commander Legends palette; reference only, not finished art inputs.

## Primary request

Create a materially more polished secondary typography revision while preserving every earlier target. Keep the exact official `COMMANDER LEGENDS` contours, but remove v1's oversized orange slab effect. Restore the period-authentic official material language: pale ivory/silver upper faces transitioning to muted teal-steel lower faces, a fine antique-metal rim, a deep indigo silhouette, and restrained wine-red depth that connects the mark to Jeska's red storm light.

Scale and place the lockup so `LEGENDS` remains the dominant drawer identifier without masking Jeska's face, chest, weapon pose, or most of the lower figure. Keep the complete unit centered over the lower artwork and entirely clear of the standardized lower-right deck-count seal. Use only a localized feathered indigo/wine atmosphere behind the title—no opaque footer, banner, black rectangle, large blank field, thin decorative rules, or broad featureless veil.

## Composition and invariants

- Preserve the established v4/v1 full-bleed 6:7 Jeska reframing so the typography remains the only material design variable.
- Exclude the poster's original navy title/copyright panel.
- Preserve Jeska's face and horns without obstruction; retain meaningful official illustration through every edge.
- Render the exact official lockup at 1360 pixels wide, centered at x=220, with deterministic contour expansion rather than a replacement font.
- Retain a visually noncritical 210 × 210-pixel lower-right marker zone. The title and its shadow must not overlap or compete with that zone.
- Do not add characters, deck names, pseudo-text, a second title, watermark, or generated letterforms.

## Output constraints

- Base and counted sibling: exactly 1800 × 2100 pixels, PNG, sRGB, 600-DPI metadata.
- Full bleed with useful visual information to every edge.
- Exact identification text once: `COMMANDER LEGENDS`.
- Counted sibling created only with `scripts/apply_deck_count.swift` and specification `2:1800`, preserving the approved 210-pixel seal with exactly 70 pixels of right and bottom inset.
- Inspect full-size and side-by-side drawer-scale comparisons at 300 × 350 and 360 × 420 pixels before finalizing.

## Target filenames

- `commander_legends_official_vertical_key_art_typography_alternate_v2_1800x2100.png`
- `commander_legends_official_vertical_key_art_typography_alternate_v2_deck_count_2_1800x2100.png`
