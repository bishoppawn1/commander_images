# Throne of Eldraine Brawl — official-art adaptation brief

## Mode and intended output

- Mode: deterministic adaptation of official Wizards/WPN artwork; no generative repainting.
- Use case: stylized-concept.
- Asset type: print-ready removable-drawer face for the complete 2019 non-Commander Brawl release.
- Final size: exactly 1800 × 2100 pixels, portrait 6:7, embedded 600-DPI metadata, full bleed.

## Input images and roles

- `src/official_wpn_eld_large_banner_en.pdf`: authoritative official Wizards Play Network source; page 2 is the chosen Throne of Eldraine vertical key art by Zack Stella.
- `src/official_wpn_eld_large_banner_en_page2_render_150dpi.png`: lossless production render of the chosen page; edit target for crop, resize, and title treatment.
- `src/official_wpn_brawl_decks_product.jpg`: official WPN Brawl packaging reference proving product language and distinct non-Commander identity; do not composite the low-resolution product photograph into the final.
- `src/official_magic_inside_brawl_article_meta.jpeg`: official Wizards Brawl article art reference; retained for product research, not used in the final composition.
- `src/official_wpn_eld_product_page.jpg`: official WPN product-page reference; retained for set/product research, not used in the final composition.

## Production brief

Scene/backdrop: Preserve the official Rowan vertical key art and its dense Eldraine forest, armor, red cloak, charged sword, sparks, and painterly texture.

Subject: Rowan remains the clear focal figure. Keep her face, anatomy, armor, sword, pose, palette, and official painted identity unchanged.

Composition/framing: Crop the vertical source to a full-bleed 6:7 portrait that includes forest texture above Rowan, her face and charged sword in the upper half, and red cloak/armor detail beneath. No white source-page border. Place a translucent wine-black title field across the lower-middle without creating a blank or featureless block; retain visible cloak texture beneath it.

Text (verbatim, exactly once):

"THRONE OF"

"ELDRAINE"

"BRAWL"

Typography: Centered, uppercase, crisp high-contrast heraldic serif. `THRONE OF` is the smallest line, `ELDRAINE` is substantially larger, and `BRAWL` is the largest and most prominent line so the face cannot be mistaken for any Commander product. Together the three lines read exactly `THRONE OF ELDRAINE BRAWL`. Use pure white letter faces for all three lines, retaining antique-gold and dark outline/shadow accents. Span nearly the full safe width while maintaining approximately 100 pixels of side clearance.

Constraints: This must be clearly identifiable as the 2019 Throne of Eldraine Brawl product, not Commander and not Wilds of Eldraine Commander. Do not include the word `COMMANDER` anywhere. Do not add deck-specific names, logos, characters, symbols, or invented wording. Preserve useful visual detail edge to edge. Keep the lower-right corner sufficiently composed for the standardized 210-pixel deck-count seal in the counted sibling.

Avoid: generative restyling; inaccurate text; extra words; low-contrast typography; tiny `BRAWL`; large empty/black/white regions; heavy opaque panels; subject duplication; clipped title letters; an ornamental border that consumes the bleed.

## Counted sibling

Preserve the unnumbered base. Apply the project-standard count `4` only with `scripts/apply_deck_count.swift`, using `4:1800`. The 210-pixel seal's outer edge must be exactly 70 pixels from the right and bottom edges.
