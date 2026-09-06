# Commander Legends — official key-art adaptation brief

## Mode and intended use

- Use case: stylized-concept / direct official-art adaptation.
- Asset type: 3 × 3.5-inch portrait drawer-face card.
- Production mode: deterministic raster adaptation of official Wizards art; do not use ImageGen unless the official poster proves unusable during visual QA.
- Exact dominant identification text, rendered verbatim: `COMMANDER LEGENDS`.

## Input images and roles

- `src/official_wizards_commander_legends_vertical_key_art_poster_en.pdf`: **selected edit target**. Use page 1, the official vertical Jeska key-art poster credited in the artwork to Magali Villeneuve.
- `src/official_wpn_commander_legends_key_art.jpg`: official WPN branded key-art reference confirming the Jeska composition and Commander Legends treatment.
- `src/official_wizards_branded_jeska_key_art.jpg`: official Wizards product-page branded horizontal reference for logo color, hierarchy, and Jeska crop.
- `src/official_wizards_jeska_key_art_cutout.png`: official Wizards transparent Jeska reference/possible compositing fallback.
- `src/official_wizards_commander_legends_texture_background.jpg`: official Wizards purple/teal Commander Legends background reference/possible extension fallback.
- `src/official_wizards_commander_decks_product_reference.png`: official Wizards reference confirming the two associated Commander decks.
- `src/official_reap_the_tides_packaging.png`: official Wizards decklist-page packaging reference for Aesi/Reap the Tides; fallback only.
- `src/official_arm_for_battle_packaging.png`: official Wizards decklist-page packaging reference for Wyleth/Arm for Battle; fallback only.

## Final composition

- Preserve the official page-1 Jeska key art, its storm-lit red/navy palette, and the Magic logo at the upper left.
- Crop the poster's original lower title panel completely out of frame, then enlarge and reframe the remaining official illustration to the exact 6:7 portrait canvas. Keep Jeska's face, horns, torso, weapons, clothing, and flowing fabric readable, with meaningful illustration extending through every part of the bottom edge.
- Integrate the replacement title directly over the lower artwork. Use only a shallow, feathered translucent navy readability veil behind the lettering; do not introduce an opaque footer, large dark field, empty title panel, or abrupt horizontal block.
- Set `COMMANDER` above `LEGENDS`; `LEGENDS` must be the largest line and span approximately 90% of the image width. Use pale ivory lettering with a subtle cool-teal highlight, a dark outline, and a restrained shadow for immediate drawer-distance legibility.
- Keep the lower-right 210 × 210-pixel marker zone visually noncritical. The counted sibling will receive a `2` marker with exactly 70 pixels of right and bottom inset using `scripts/apply_deck_count.swift` and specification `2:1800`.
- Do not add deck names or force Aesi/Wyleth into the selected set-level art.

## Output constraints

- Final base: exactly 1800 × 2100 pixels, PNG, sRGB, 600-DPI metadata.
- Full bleed with useful visual information to every edge; no white border, blank field, or featureless area.
- Identification must read exactly `COMMANDER LEGENDS`; no spelling changes, duplicate title, extra title words, watermark, or generated pseudo-text.
- Keep important art and the large title comfortably inside the print-safe area.
- Preserve the unnumbered base. Create a separately named counted sibling; never overwrite the base.

## Target filenames

- `commander_legends_official_vertical_key_art_v4_1800x2100.png`
- `commander_legends_official_vertical_key_art_v4_deck_count_2_1800x2100.png`
