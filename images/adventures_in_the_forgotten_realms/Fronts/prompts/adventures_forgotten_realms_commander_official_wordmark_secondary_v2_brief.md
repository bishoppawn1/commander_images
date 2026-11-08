# Adventures in the Forgotten Realms Commander official-wordmark secondary v2 brief

## Mode and intended use

- **Use case:** `compositing`
- **Asset type:** typography-focused secondary 3 × 3.5-inch portrait drawer-face card for the complete Adventures in the Forgotten Realms Commander release.
- **Production mode:** deterministic, non-generative extraction and compositing from retained official Wizards Play Network artwork. Built-in ImageGen is not needed.

## Input images and roles

1. `../src/afr_official_wpn_key_art_poster_page-1.png` — primary edit target and direct pixel source. Preserve its Magali Villeneuve party-versus-dragon artwork and the existing 6:7 crop used by the v1 target.
2. `../src/afr_official_wpn_key_art_poster_11x17_en.pdf` — untouched official provenance master containing the exact Adventures in the Forgotten Realms title lockup.
3. `../src/afr_official_wpn_product_hero.jpg` — official product reference confirming that the party-versus-dragon composition is the release's principal key art; do not composite.
4. `../src/afr_commander_product_reference.png` — official Commander packaging reference; do not composite.

## Exact identification text

Preserve the exact official two-line set wordmark from the poster, reading verbatim and exactly once:

`ADVENTURES IN THE`

`FORGOTTEN REALMS`

The full dominant title is **ADVENTURES IN THE FORGOTTEN REALMS**. Extract the real poster lettering rather than typesetting a substitute. Preserve its pointed chiseled fantasy serifs, flared terminals, curved `R` legs, and established two-line hierarchy. The title must span most of the usable width and remain immediately readable at 360 × 420-pixel drawer-preview scale.

## Composition and transformations

- Preserve the v1 art crop substantially: source crop `x=0, y=0, width=2200, height=2567`, resampled without distortion to 1800 × 2100.
- Preserve the Magic wordmark at upper left, the dragon on the right, the swordswoman and panther on the left, and the fiery center without retouching or regeneration.
- Extract only the official white AFR set title from the retained poster's lower branding area into a transparent supporting asset. Exclude the red Dungeons & Dragons logo, copyright line, and scale-panel background.
- Place the exact extracted lockup in the lower third, centered and approximately 1660 pixels wide. Keep it above the count-seal zone and do not cover the central duel.
- Give the official glyph shapes a restrained weathered ivory/antique-stone face, subtle gold warmth, crisp near-black silhouette, and small natural surface flecks. Preserve the glyph contours exactly; material treatment must not alter spelling or legibility.
- Use only a soft, localized translucent shadow behind the title. Do not add a large black footer, opaque banner, border frame, or blank panel; the official artwork must remain visible through and around the typography.

## Output constraints

- Exact portrait aspect ratio: 6:7.
- Exact print target: 1800 × 2100 pixels with 600 × 600 DPI metadata in sRGB.
- Preserve both v1 finals and add a clearly versioned unnumbered v2 base plus a separately named counted sibling.
- Apply the standard single-set count seal only with `scripts/apply_deck_count.swift` and argument `4:1800`, producing the approved 210-pixel seal with exactly 70-pixel right and bottom outer-edge insets.
- The seal may cover only noncritical lower-right background texture and must remain clear of the title and focal subjects.

## Avoid

- No generic sans serif, Copperplate substitute, default font, retyped approximation, AI-generated lettering, or misspelled title.
- No four-commander montage, regenerated art, changed crop, repeated subjects, extra slogan, large footer, opaque title plate, white margin, or watermark.
- Do not stretch, redraw, or otherwise alter the official wordmark contours.
