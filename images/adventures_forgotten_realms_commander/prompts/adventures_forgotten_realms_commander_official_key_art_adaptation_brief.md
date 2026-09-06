# Adventures in the Forgotten Realms Commander official-key-art adaptation brief

## Mode and intended use

- **Use case:** `ads-marketing`
- **Asset type:** 3 × 3.5-inch portrait drawer-face card for the complete Adventures in the Forgotten Realms Commander release.
- **Production mode:** Direct, non-generative adaptation of official Wizards Play Network artwork. Do not invent, regenerate, duplicate, or montage characters.

## Input images and roles

1. `../src/afr_official_wpn_key_art_poster_11x17_en.pdf` — untouched official WPN provenance master and primary edit target. Use page 1, the Magali Villeneuve party-versus-dragon key art, because it is vertical, edge-to-edge, visually dense, and strongly identifies the associated set.
2. `../src/afr_official_wpn_key_art_poster_page-1.png` — unmodified high-resolution rasterization of page 1; direct pixel source for the finished adaptation.
3. `../src/afr_official_wpn_key_art_poster_page-2.png` — unmodified alternate Jason Rainville beholder poster; retained alternate-art reference only.
4. `../src/afr_official_wpn_key_art_poster_page-3.png` — unmodified alternate Magali Villeneuve Tiamat poster; retained alternate-art reference only.
5. `../src/afr_official_wpn_product_hero.jpg` — official WPN product-line reference confirming the page-1 dragon art and dark blue/black/red product palette; do not composite.
6. `../src/afr_commander_product_reference.png` — official WPN Commander product reference confirming Commander packaging identity; do not composite.
7. `../src/afr_wpn_exclusive_poster_reference.jpg` — official WPN article reference for the separate red WPN-exclusive poster; design-context reference only because the source image contains a large empty webpage background.

## Exact identification text

Render the following set-identifying title verbatim, in two clean horizontal lines, exactly once:

`ADVENTURES IN THE`

`FORGOTTEN REALMS`

The full phrase identifies **ADVENTURES IN THE FORGOTTEN REALMS**. It must be the dominant information element, use crisp high-contrast pale-ivory Copperplate Bold lettering with a subtle dark outline, and span nearly the full usable width while respecting an approximately 70-pixel print-safe inset. Do not abbreviate, misspell, hyphenate, or add words to the title.

## Composition and transformations

- Preserve the official page-1 vertical key art directly: the attacking dragon on the right, the white-haired swordswoman and black panther on the left, the fiery center, the dark wing canopy, and the official Magic wordmark at upper left.
- Crop away the poster's original lower branding panel so the required 6:7 canvas can be filled by the key art without squashing it and without duplicating the set name.
- Recreate the exact set title as a drawer-readable lower title treatment over a subtle dark gradient derived from the existing palette. Keep the title completely above and clear of the required lower-right count marker.
- Use a restrained antique-gold separator rule above the title to reinforce the existing fantasy-product treatment.
- Fill the entire canvas with artwork or textured title treatment; no blank, white, featureless, framed, or low-information areas.
- Keep focal faces, the dragon's mouth, and title comfortably inside the print-safe area.

## Output constraints

- Exact portrait aspect ratio: 6:7.
- Exact print target: 1800 × 2100 pixels with 600 × 600 DPI metadata in sRGB.
- Preserve an unnumbered base target and create a separately named counted sibling.
- Apply the standard single-set count seal only with `scripts/apply_deck_count.swift` and argument `4:1800`, producing the approved 210-pixel seal with equal 70-pixel right and bottom outer-edge insets.
- The `4` seal may cover only noncritical lower-right background texture. It must not obscure the title, Magic wordmark, dragon, party members, or other critical focal detail.

## Avoid

- No four-commander montage.
- No generated or substituted characters.
- No repeated subjects, malformed anatomy, incorrect title text, extra slogans, watermarks, empty margins, border frames, or white background.
- Do not stretch or distort the official key art.
