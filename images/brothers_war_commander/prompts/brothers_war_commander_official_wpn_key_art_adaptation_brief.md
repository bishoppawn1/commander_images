# The Brothers' War Commander — official WPN key-art extended-battle brief

## Mode and intended use

- Use case: precise-object-edit followed by deterministic official-art compositing.
- Asset type: 3 × 3.5-inch portrait drawer-face card for the complete two-deck The Brothers' War Commander release.
- Production mode: preserve the official Wizards Play Network focal composition; use built-in ImageGen only to replace the low-information lower quarter with a continuous battlefield extension; blend that extension into the direct poster adaptation; reapply Wizards' supplied transparent logo exactly.
- Exact dominant identification text, rendered verbatim once: `THE BROTHERS' WAR`. The angular typographic apostrophe in Wizards' official supplied logo is acceptable because the complete phrase remains immediately clear.

## Retained inputs and roles

- `src/bro_lgp_key_24x36_en.pdf`: **official source/edit anchor**. WPN English 24 × 36-inch vertical key-art poster, credited in the footer to Dominik Mayer.
- `src/bro_lgp_key_24x36_en_preview.png`: unmodified 75-PPI poster rasterization and direct source for the preserved upper composition.
- `src/bro_alg_en/MTGBRO_EN_SetLogo_1line.png`: **official supporting compositing input**. Reapplied after the generated lower extension to guarantee exact title shapes, spelling, sharpness, size, and placement.
- `src/bro_alg_en/MTGBRO_EN_SetLogo_1line.tif`, `MTGBRO_EN_SetLogo_1line_ALT.*`, and `MTGBRO_EN_SetLogo_2line*`: official print/web logo alternatives inspected for typography and contrast; not composited.
- `src/bro_alg_en/BRO_1080p_en.jpg`: official horizontal key-art reference confirming the Dominik Mayer composition, palette, Magic wordmark, and title hierarchy.
- `src/bro_alg_en/bro_expsym_*`: official expansion-symbol references from the same WPN package; retained for provenance, not composited.
- `src/bro_key_sma_en/bro_sma_insta_1080x1920_en.jpg`, `bro_sma_fb_1000x1000_en.jpg`, and the other `bro_sma_*` social crops: official branded comparison references. Their integrated title sits too low for the standardized seal after a 6:7 crop.
- `src/bro_oversized_art/*.pdf` and `*_preview.png`: official WPN alternate set-level art inspected as potential backgrounds. The established Dominik Mayer composition remains the stronger branded identity.
- `src/brothers_war_commander_lower_battle_extension_imagegen_raw_v2.png`: **unmodified built-in ImageGen edit output**. Source for the detailed lower-edge extension; preserve unchanged in `src/`.
- `src/bro_alg_en.zip`, `src/bro_key_sma_en.zip`, and `src/bro_oversized_art.zip`: untouched official download archives retained as provenance masters.

## ImageGen edit prompt (verbatim)

```text
Use case: precise-object-edit
Asset type: 3 x 3.5-inch portrait Magic: The Gathering drawer-face artwork
Input images: Image 1 is the edit target and official The Brothers' War key-art composition.
Primary request: Change only the low-information near-black lower quarter below the dominant title. Extend the established Brothers' War battlefield continuously through the lower edge with meaningful painterly detail: ember-lit shattered automata, broken brass and iron gears, fragments of war machines, scorched metal plates, cables, sparks, furnace glow, smoky rubble, and diagonal battle texture. Match the existing official painterly rendering, perspective, red-orange forge lighting, antique bronze, blackened steel, and pale green powerstone highlights. The new lower detail should feel like the same battlefield already visible above, not a separate footer or pasted band.
Composition/framing: preserve the exact 6:7 portrait framing and every important element above the lower quarter. Keep the Magic wordmark, yellow diamond, central war machine, central face, hands, glowing red crystal, and the dominant title in exactly their existing positions. Keep the title fully unobstructed and make the new lower-right area detailed but noncritical so a circular count seal can later sit there.
Text (verbatim): "THE BROTHERS' WAR"
Constraints: render the title exactly once and unchanged; preserve its supplied official lettering, apostrophe, scale, sharp edges, spelling, and placement. Preserve the official focal composition. No commander montage, no added characters, no added logos, no new words, no pseudo-text, no border, no frame, no flat footer, no dark empty field, no watermark. Fill the bottom edge with continuous useful artwork. Change only the bottom low-information region; keep everything else unchanged.
```

## Final composition

- Recreate the direct official base by cropping `x=0, y=0, width=1800, height=2100` from the 1800 × 2700 poster raster and using the official logo at `x=80, y=1120`, scaled proportionally to 1640 × 742 pixels.
- Normalize the raw 1162 × 1353 ImageGen output by cropping `x=1, y=0, width=1160, height=1353` and scaling to 1800 × 2100.
- Preserve the direct official base unchanged above `y=1450`. Feather from the official base into the generated edit across `y=1450–1780`; use the generated lower battlefield fully below `y=1780`. This keeps the Magic wordmark, yellow diamond, war machines, central face, hands, and crystal anchored to the official source while carrying new machinery and forge detail to the bottom edge.
- Reapply the official transparent set logo at `x=80, y=1120` after blending. This guarantees the exact dominant `THE BROTHERS' WAR` title and clean official glyph edges.
- Fill the lower region with ember-lit shattered automata, gears, metal plates, cables, furnace glow, sparks, and debris. It must read as continuous battlefield art, never a footer, band, blank field, or near-black cloak block.
- Keep the lower-right 210 × 210-pixel seal footprint detailed but noncritical. The counted sibling receives one `2` marker occupying `x=1520–1730, y=1820–2030`, with 70 pixels of right and bottom inset.

## Output constraints

- Finished base: exactly 1800 × 2100 pixels (6:7), PNG, 8-bit RGB, non-interlaced, with 600 × 600 DPI metadata.
- Full bleed with useful painted detail to every edge; no white border, blank field, featureless block, watermark, commander montage, or added text.
- Dominant identification must read exactly `THE BROTHERS' WAR`, once, at immediate drawer-viewing scale. Keep the Magic wordmark and title comfortably print-safe.
- Preserve the unnumbered base unchanged. Create a separately named counted sibling with `scripts/apply_deck_count.swift` using `2:1800`; never overwrite the base.

## Target filenames

- `brothers_war_commander_official_wpn_key_art_extended_battle_target_v2_1800x2100.png`
- `brothers_war_commander_official_wpn_key_art_extended_battle_target_v2_deck_count_2_1800x2100.png`
