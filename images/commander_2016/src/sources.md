# Commander 2016 — Invent Superiority / Breya image sources

This directory contains retained raw official references, the unmodified built-in ImageGen output, and production provenance. Finished print targets are stored one level above.

## Product and owned-deck verification

- Official Wizards decklists: https://magic.wizards.com/en/news/announcements/commander-2016-edition-decklists-2016-10-28
  - Verifies that Commander (2016 Edition) contains five decks.
  - Verifies the deck name `Invent Superiority` and its commander `Breya, Etherium Shaper`.
- Official Wizards character article: https://magic.wizards.com/en/news/magic-story/its-time-talk-commander-2016-edition-2016-10-26
  - Identifies Breya as commander of the Invent Superiority deck.
  - Credits the original Breya artwork to Clint Cearley.
- Official Wizards Commander 2016 card gallery: https://magic.wizards.com/en/news/card-image-gallery/commander-2016
  - Verifies the Commander 2016 printing and provides the official English card image.
- Repository inventory authority: `../../../INVENTORY.md`
  - Records this physical group as incomplete, with two of five decks owned: Invent Superiority and Breed Lethality.
  - Therefore the current deterministic drawer count seal is `2`. Earlier count-`1` siblings are retained as historical outputs from before the collection correction.

## Retained inputs and outputs

| File | Source / generation | Artist / description | Original dimensions | Role / transformations |
| --- | --- | --- | --- | --- |
| `breya_etherium_shaper_clint_cearley_official_art.jpg` | http://media.wizards.com/2016/images/daily/c4rd4r7_3rXj1wUSCj.jpg | Clint Cearley; official Breya, Etherium Shaper art published by Wizards | 850 × 473 px, JPEG | Primary official identity, painterly style, composition, palette, spell-energy, and thopter reference. Untouched download. |
| `breya_etherium_shaper_c16_card_reference.png` | http://media.wizards.com/2016/bn8f9t2zc_C16/b2qw7Ice5A_EN.png | Official English Commander 2016 Breya card image; art by Clint Cearley | 265 × 370 px, PNG | Product-era, exact character, name, frame, set-symbol, and four-color/artifact identity reference. Untouched download. |
| `commander_2016_invent_superiority_official_packaging_reference.jpg` | https://i5.walmartimages.com/seo/MtG-Commander-2016-Invent-Superiority-Deck_863306e7-fb61-4914-b73f-773dcb5a3a18.47490e66c357a4fb80f925b57beb2c62.jpeg | Authentic Wizards Commander 2016 / Invent Superiority retail packaging, retained from a retailer product listing | 1178 × 1600 px, JPEG | Untouched package photograph used only as typography/product-branding evidence. It confirms a bold serif `COMMANDER` wordmark and fantasy-serif `INVENT SUPERIORITY`; it is not used as final art. SHA-256: `26e630748baaa61ea7bf9834f232b477ab2ccd90b625f1cea7f92d7256739ba2`. |
| `cinzel_decorative_black.ttf` | https://raw.githubusercontent.com/google/fonts/main/ofl/cinzeldecorative/CinzelDecorative-Black.ttf | Cinzel Decorative Black by Natanael Gama, distributed by Google Fonts under the SIL Open Font License | 61 KB, TrueType | Deterministic ornamental serif source for the v2 exact-text paths. Its strong classical silhouette and angular flourishes were composited as engraved Etherium metal. SHA-256: `a6c1eb3e228f639a98aafd8a8e8a035582dd50ad5f8a84e9dcbc8664e7457114`. License retained as `cinzel_decorative_OFL.txt`. |
| `commander_2016_invent_superiority_breya_v1_imagegen_raw.png` | Built-in OpenAI ImageGen using the two official references above | Unmodified generated portrait artwork | 1162 × 1353 px, PNG | Raw ImageGen output retained unchanged. The exact structured prompt is recorded in `../prompts/commander_2016_invent_superiority_breya_target_v1_prompt.md`. SHA-256: `aa7ab8ff74f4d526022915f86a292144cad08d985466817490b96156264c325b`. |
| `../commander_2016_invent_superiority_breya_target_v1_1800x2100.png` | Derived non-destructively from the raw ImageGen output | Finished unnumbered Commander 2016 / Invent Superiority drawer face | 1800 × 2100 px at 600 DPI, PNG | Center-cropped by two source pixels from 1162 × 1353 to 1160 × 1353, resized to exact 6:7 print dimensions, converted onto an sRGB canvas, and given deterministic Copperplate Bold title treatments. Exact dominant text is `COMMANDER 2016`; secondary owned-deck label is `INVENT SUPERIORITY`. The title spans nearly the full safe width and remains separate from Breya's face. |
| `../commander_2016_invent_superiority_breya_target_v1_deck_count_1_1800x2100.png` | Derived non-destructively from the unnumbered target | Finished counted sibling | 1800 × 2100 px at 600 DPI, PNG | Added the approved `1` marker with `/usr/bin/swift scripts/apply_deck_count.swift ... 1:1800`: 210-pixel (0.35-inch) dark circular seal, antique-gold rim, pale-ivory Copperplate Bold numeral, and equal 70-pixel right/bottom insets. The unnumbered target remains unchanged. |
| `../commander_2016_invent_superiority_breya_target_v1_deck_count_2_1800x2100.png` | Derived non-destructively from the unnumbered v1 target after the owned-count correction | Current finished counted sibling | 1800 × 2100 px at 600 DPI, PNG | Added the approved `2` marker with `/usr/bin/swift scripts/apply_deck_count.swift ... 2:1800`; exact standard seal geometry and equal 70-pixel right/bottom insets. SHA-256: `c48054d72c11eeaa232fafe4985b9a7a15e733498e61e820654705cdd51d1f4a`. |
| `../commander_2016_invent_superiority_breya_typography_v2_1800x2100.png` | Deterministic CoreGraphics/CoreText build from the retained v1 raw artwork | Finished unnumbered typography-focused alternate | 1800 × 2100 px at 600 DPI, PNG | Preserves the v1 crop, artwork, Breya, and composition. Replaces both black rectangular labels and generic spaced sans text with exact Cinzel Decorative Black paths rendered as beveled Etherium silver/gold, dark engraved keylines, open filigree rules, and carmot/cyan accents. Built with `build_commander_2016_typography_v2.swift`; no new ImageGen call. Exact text: `COMMANDER 2016` and subordinate `INVENT SUPERIORITY`. SHA-256: `406831ef2b5e8f32318aafca3bf4f22a596839f667e25dd2bee4f0022ef00423`. |
| `../commander_2016_invent_superiority_breya_typography_v2_deck_count_1_1800x2100.png` | Derived non-destructively from the v2 unnumbered target | Finished counted typography-focused alternate | 1800 × 2100 px at 600 DPI, PNG | Added the approved `1` with `/usr/bin/swift scripts/apply_deck_count.swift ... 1:1800`: exact 210-pixel seal and exact 70-pixel right/bottom insets. The seal remains clear of the subordinate title and critical artwork. SHA-256: `167da270092d63072c38f7c1ac421f196c836af7ffc72793a317f50078bcc161`. |
| `../commander_2016_invent_superiority_breya_typography_v2_deck_count_2_1800x2100.png` | Derived non-destructively from the approved v2 unnumbered target after the owned-count correction | Current finished counted typography-focused alternate | 1800 × 2100 px at 600 DPI, PNG | Added the approved `2` with `/usr/bin/swift scripts/apply_deck_count.swift ... 2:1800`; exact standard seal geometry and equal 70-pixel right/bottom insets. SHA-256: `34607c6fa95a92986fecac5d323ac64b6915e7cee3063838063c2fb7d2676f13`. |

## Typography v2 production support

- `build_commander_2016_typography_v2.swift` is the deterministic, rerunnable v2 compositor. It registers the retained font locally, recreates the exact v1 crop/resize, draws open artifact filigree and soft atmospheric vignettes, converts the exact title strings to glyph paths, applies the engraved-metal treatment, and writes 600-DPI PNG metadata.
- `build_v1_v2_comparison.swift` creates side-by-side inspection assets without modifying either finished target.
- `commander_2016_invent_superiority_breya_typography_v2_drawer_preview.png` is the 450 × 525 single-candidate drawer-scale preview.
- `commander_2016_typography_v1_v2_comparison_large.png` is the 1800 × 1050 large side-by-side comparison: v1 left, v2 right.
- `commander_2016_typography_v1_v2_comparison_drawer.png` is the 450 × 263 counted drawer-scale comparison: v1 left, v2 right.

The 2016 Wizards editorial/product pages still verify the product and deck, but a clean, sufficiently large official `COMMANDER` wordmark asset was not available from the surviving official pages inspected for this alternate. The authentic retail packaging reference therefore supplies the authoritative shape direction, while the final exact title is rebuilt rather than extracted from a noisy photographed/raster package.

## Composition decision

Commander 2016 is an annual Commander product rather than a release tied to a main expansion set. The cover was approved while the collection contained only Invent Superiority and therefore focuses on Breya's established Esper artifact identity: etherium filigree, thopters, dark metallic architecture, magenta carmot energy, and cyan aether conduits. The collection now also contains Breed Lethality; the release-level `COMMANDER 2016` identification remains accurate and the approved artwork is retained, while the current count seal is updated to `2`. The official landscape art was not tall enough or sufficiently high-resolution to use directly, so built-in ImageGen extended and recomposed it into a coherent portrait. Exact title and deck text were added deterministically after generation to guarantee spelling, immediate drawer readability, and crisp physical printing.

Visual inspection confirmed that both final targets are full-bleed and visually dense with no blank corners or large empty areas; Breya appears once with coherent face, body, filigree, and spell hand; the exact dominant title is unobstructed; and the count seal does not cover the title, label, face, or hand.

For typography v2, full-size and drawer-scale side-by-side inspection confirmed that the primary wordmark remains instantly legible while gaining a much stronger set-native silhouette. The stacked `COMMANDER 2016` lockup uses the upper arch without covering Breya's face; the open filigree preserves the art instead of creating a pasted-on rectangle; the subordinate deck name remains readable at drawer scale; and the standard count seal remains isolated in the true lower-right corner.
