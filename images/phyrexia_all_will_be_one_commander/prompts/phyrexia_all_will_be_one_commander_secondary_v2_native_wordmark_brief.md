# Phyrexia: All Will Be One Commander — secondary v2 native-wordmark brief

## Mode and intended use

- **Use case:** `ads-marketing`
- **Asset type:** preserved 3 × 3.5-inch portrait alternate full-release drawer face for the two owned Phyrexia: All Will Be One Commander decks. The current physical allocation represents both decks on the Commander Legends | Phyrexia: All Will Be One split face; this standalone target remains an alternate full-release candidate rather than an additional allocation.
- **Production mode:** deterministic, non-generative reframing of official Wizards Play Network art plus exact restoration of the official transparent English set wordmark. This is a preserved secondary candidate, not a replacement for v1.

## Input images and roles

1. `../src/official_wpn_one_key_art_poster_24x36_en_page1_150ppi.png` — primary edit target; untouched 3600 × 5400 rasterization of Magali Villeneuve's official WPN vertical Elesh Norn poster.
2. `../src/official_wpn_one_key_art_poster_24x36_en.pdf` — untouched official provenance master for Image 1.
3. `../src/MTGONE_EN_SetLogo.png` — exact official 900 × 407 transparent English set wordmark, composited without redrawing or substituting its letterforms.
4. `../src/official_wpn_one_art_and_logos_en.zip` — untouched official WPN archive that supplied Image 3.
5. `../src/one_sma_insta_1080x1920_en.jpg` — official WPN vertical social reference for the established title-over-art hierarchy.
6. `../src/official_wizards_one_first_look_key_art_anato_finnstark.png` — official oppressive, symmetrical Elesh Norn composition reference used during source comparison, not composited.
7. `../src/official_wpn_one_oversized_art_72x48_page1_75ppi.png` and `../src/official_wizards_new_phyrexia_landscape_sergey_glushakov.png` — official New Phyrexia architectural composition references used during source comparison, not composited.

## Exact identification text and typography

The sole dominant title must read exactly **`PHYREXIA: ALL WILL BE ONE`**.

- Preserve `PHYREXIA` and `ALL WILL BE ONE` from the exact official transparent WPN set wordmark.
- Because the official distribution wordmark omits the user-required punctuation, append one unmistakable deterministic colon immediately after `PHYREXIA`.
- Construct the colon as two crisp engraved porcelain dots with the official logo's pale bone, warm gray inner rim, oil-black shadow, and restrained blood-red hairline. Do not alter, approximate, or regenerate any official letter.
- The dominant line plus colon should span approximately x=95–1714 on the 1800-pixel canvas, with a clean silhouette and immediate drawer-scale readability.
- Render the title exactly once; no deck names, Commander subtitle, pseudo-text, or duplicate lockup.

## Composition and transformations

- Use the exact source crop `x=300, y=350, width=3000, height=3500`. It is natively 6:7 and reframes Elesh Norn 20% tighter than v1, removing the detached poster footer and small Magic mark while preserving her face, porcelain halo, blade hand, torso, exposed red anatomy, robe, throne architecture, and edge-to-edge illustration.
- Integrate the official title over the lower red-and-black art rather than placing it in a footer. Use only a transparent elliptical black-oil/crimson bloom and a shallow transparent lower veil; meaningful robe, porcelain, flesh, and architecture must remain visible beneath and around it.
- Position the official logo at `x=95, y=248` in bottom-left Core Graphics coordinates, scaled proportionally to 1510 pixels wide. Keep the complete title above the standard count-seal zone.
- Append the porcelain colon with dot centers at `(1682, 724)` and `(1682, 588)` in the same coordinate system.
- Preserve the oppressive symmetrical hierarchy: halo and face at the top, exposed biomechanical body through the center, native wordmark across the lower third, and dense robes/throne detail at the bottom.

## Output constraints

- Exact portrait aspect ratio: 6:7.
- Exact print target: 1800 × 2100 pixels with 600 × 600 DPI metadata in sRGB.
- Full bleed and visually dense edge to edge; no blank, white, framed, or low-information title panel.
- Preserve the unnumbered secondary v2 base and create a separately named counted sibling.
- Apply the count seal only with `scripts/apply_deck_count.swift` and argument `2:1800`, producing the approved 210-pixel seal with exactly 70 pixels of right and bottom outer-edge inset. The incorrect allocation pass's `1` sibling is archived under `../src/superseded_correction_history/` and is not an active root target.

## Avoid

- No generic sans-serif, Copperplate replacement title, redrawn approximation of the official letters, generated pseudo-wordmark, malformed punctuation, or missing colon.
- No ImageGen character replacement, two-lead montage, deck-name labels, empty footer, large opaque rectangle, border, frame, watermark, or extra logo.
- Do not obscure Elesh Norn's face, halo, blade hand, exposed central anatomy, or the count seal.
