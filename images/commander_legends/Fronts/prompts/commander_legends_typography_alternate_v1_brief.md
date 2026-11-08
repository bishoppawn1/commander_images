# Commander Legends — typography alternate v1 brief

## Mode and intended use

- Use case: `text-localization` / deterministic official-wordmark compositing.
- Asset type: 3 × 3.5-inch portrait drawer-face card.
- Production mode: deterministic raster extraction and compositing; built-in ImageGen is not needed because the retained official poster contains clean source art and an exact official title lockup.
- Exact dominant identification text, rendered verbatim: `COMMANDER LEGENDS`.

## Input images and roles

- `src/official_poster_page1_600dpi.png`: **edit target and art source**. This is a 600-DPI page-1 raster of the retained official Wizards/WPN Jeska poster.
- `src/official_commander_legends_wordmark_extracted.png`: **official title asset**. This transparent lockup is deterministically isolated from the page-1 poster; it preserves the exact official `COMMANDER`-above-`LEGENDS` silhouettes and spacing.
- `src/official_wizards_commander_legends_vertical_key_art_poster_en.pdf`: retained untouched official source for both of the above derivatives.
- `src/official_wizards_branded_jeska_key_art.jpg`, `src/official_wpn_commander_legends_key_art.jpg`, and `src/official_wizards_commander_legends_texture_background.jpg`: official color, hierarchy, and set-native identity references.

## Primary request

Preserve the strong official Magali Villeneuve Jeska illustration substantially, especially Jeska's face, horns, weapons, clothing, the storm-lit red/navy atmosphere, and the complete upper-left Magic mark. Redesign only the title treatment so it no longer resembles a generic wide sans overlay.

Use the exact official `COMMANDER LEGENDS` lockup as one cohesive title unit. Keep `COMMANDER` tightly above the much larger `LEGENDS`; give the official letterforms a strong engraved-metal silhouette with a deep wine-black outer edge, ember-orange rim, pale warm-metal face, copper/red low tones, restrained highlight engraving, and a controlled shadow. Make the result native to the Jeska art and immediately readable at drawer distance.

## Composition and invariants

- Reframe the official poster illustration edge to edge at exactly 6:7; exclude the poster's original navy title panel and copyright line.
- Place the title across nearly the full usable width in the lower artwork, below Jeska's face and above the count-seal zone.
- Use only soft feathered atmosphere behind the title. Keep clothing, blades, fabric, and color visible through the lower composition.
- Do not add a black rectangle, opaque footer, large blank field, stray thin rules, extra text, deck names, generated pseudo-text, or additional characters.
- Do not obscure Jeska's face. Do not alter or redraw the official title silhouettes.
- Preserve a visually noncritical 210 × 210-pixel lower-right marker zone.

## Output constraints

- Final base: exactly 1800 × 2100 pixels, PNG, sRGB, 600-DPI metadata.
- Full bleed with useful visual information to every edge.
- Identification must read exactly `COMMANDER LEGENDS` once.
- Preserve the unnumbered base and create a separate counted sibling.
- Apply the counted sibling with `scripts/apply_deck_count.swift` and specification `2:1800`, producing a 210-pixel seal with exactly 70 pixels of right and bottom outer-edge inset.

## Target filenames

- `commander_legends_official_vertical_key_art_typography_alternate_v1_1800x2100.png`
- `commander_legends_official_vertical_key_art_typography_alternate_v1_deck_count_2_1800x2100.png`
