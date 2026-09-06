# Commander Legends source and production record

Downloaded 2026-08-26. All URLs below are official Wizards of the Coast or Wizards Play Network sources.

## Product and deck verification

- [Commander Legends product page](https://magic.wizards.com/en/products/commander-legends) — official set page and source for the product-page art assets below.
- [Commander Legends Commander Decklists](https://magic.wizards.com/en/news/feature/commander-legends-commander-decklists-2020-11-05) — Wizards states that the release includes two entry-level Commander decks and identifies them as **Reap the Tides** (Aesi, Tyrant of Gyre Strait) and **Arm for Battle** (Wyleth, Soul of Steel). This verifies the drawer marker value `2`.
- [The Best Ways to Use CMR Marketing Materials](https://wpn.wizards.com/en/news/best-ways-use-cmr-marketing-materials) — WPN describes Commander Legends key art as available in social, banner, poster, and wallpaper formats.

## Retained official sources

| Local file | Direct official URL | Original dimensions / format | Attribution and role |
| --- | --- | --- | --- |
| `official_wizards_commander_legends_vertical_key_art_poster_en.pdf` | [WPN marketing-material PDF](https://media.wizards.com/2020/wpn/marketing_materials/cmr/cmr_flp_8_5x11_en.pdf) | 3-page US Letter PDF, 612 × 792 points per page | Selected edit target. Page 1 is the vertical Jeska poster and prints the credit “Ill. Magali Villeneuve.” Pages 2–3 are alternate official vertical Commander Legends art. |
| `official_wpn_commander_legends_key_art.jpg` | [WPN article image](https://media.wizards.com/2020/wpn/w42/k4dva3w7jk.jpg) | 715 × 354 JPEG | Official branded horizontal Jeska key-art reference; the source article explicitly labels this section “Key Art.” |
| `official_wizards_branded_jeska_key_art.jpg` | [Wizards product-page asset](https://images.ctfassets.net/s5n2t79q9icq/63HJ6OzGWTxtVBb8EjAca3/5f1e07278c8ba3133c5dd6d41ea0cfff/en_7KvM7g82LN.jpg) | 1200 × 630 JPEG | Official branded horizontal Jeska reference. Same key-art family as the Magali Villeneuve poster. |
| `official_wizards_jeska_key_art_cutout.png` | [Wizards product-page asset](https://images.ctfassets.net/s5n2t79q9icq/1LxUQNKLr2LqvykUvK0cpc/0d9ae7372145e34daaf314a28716e1e9/f3RoJBqSz6MmHO9__1_.png) | 844 × 818 PNG | Official transparent Jeska cutout; retained as a compositing fallback. The poster identifies the Jeska key art as Magali Villeneuve's illustration. |
| `official_wizards_commander_legends_texture_background.jpg` | [Wizards product-page asset](https://images.ctfassets.net/s5n2t79q9icq/1BWKmt9adRPswiDsL0DVlv/8b1bc8837256ecd8c91da70dfeb5090a/cNIKL0AQBL_v1.jpg) | 1920 × 1080 JPEG | Official purple/teal Commander Legends texture; retained as an extension fallback. Artist not stated on the source page. |
| `official_wizards_commander_decks_product_reference.png` | [Wizards product-page asset](https://images.ctfassets.net/s5n2t79q9icq/ylZON0Y5Jz5XBn2azI7rn/78516729e207568af299b878b4318059/oVUN7gQmlP_en.png) | 548 × 432 PNG | Official composite showing the Reap the Tides and Arm for Battle products. Packaging/card-art attribution is not stated on the source page. |
| `official_reap_the_tides_packaging.png` | [Wizards decklist-page image](https://media.wizards.com/2020/images/daily/WIa4HeSNQb.png) | 650 × 692 PNG | Official Reap the Tides packaging reference featuring Aesi. Fallback only; artist not stated on the decklist page. |
| `official_arm_for_battle_packaging.png` | [Wizards decklist-page image](https://media.wizards.com/2020/images/daily/d2DutfdMAc.png) | 650 × 692 PNG | Official Arm for Battle packaging reference featuring Wyleth. Fallback only; artist not stated on the decklist page. |

## Selection decision

The official vertical page-1 poster is the strongest drawer-face source: it is full bleed, portrait-oriented, visibly branded, and unmistakably Commander Legends. It also provides much stronger set-level identity than forcing the two deck leads into a montage. The final adaptation therefore uses Jeska set key art and does not use Aesi or Wyleth in the finished face.

## Typography-alternate supporting assets

- `official_poster_page1_600dpi.png` — deterministic 5100 × 6600 page-1 raster of the retained WPN PDF, rendered at 600 DPI with Poppler. This is the high-resolution Jeska art and wordmark extraction source; it is a derivative of the untouched retained PDF, not an additional download.
- `official_commander_legends_wordmark_extracted.png` — 2735 × 839 transparent PNG isolated from the official poster by `extract_official_commander_legends_wordmark.swift`. It preserves the exact official `COMMANDER`-above-`LEGENDS` contours and spacing while removing only the uniform navy poster panel. SHA-256: `5a15f1d7064dbdc9fe26badcaead22115497dc67ef247d8de87ea5669f6fadce`.
- `extract_official_commander_legends_wordmark.swift` — deterministic extractor for the official poster title lockup. The broad title crop is thresholded only against the white-on-navy source and then trimmed to the detected alpha bounds.
- `build_commander_legends_typography_alternate_v1.swift` — deterministic 1800 × 2100 compositor. It reframes the official full-width Jeska illustration, excludes the original footer, and applies the extracted official lockup with engraved warm-metal, ember-red, deep-wine edge, subtle scratch, and feathered-shadow treatments.
- `official_poster_preview-1.png` through `official_poster_preview-3.png`, `official_wordmark_crop_preview.png`, and `official_wordmark_tight_crop_preview.png` — supporting inspection previews used to confirm all three poster pages and identify the clean title extraction area. They are not finished targets.
- `qa_original_vs_typography_alternate_v1_full_size.png` — 3600 × 2100 side-by-side QA comparison of the retained v4 base and the typography alternate at full pixel height.
- `qa_original_vs_typography_alternate_v1_drawer_scale.png` — 360 × 210 side-by-side Lanczos downsample used to confirm immediate title readability at drawer scale.

## Production record

- Generation mode: direct official-art adaptation; ImageGen not used.
- Selected source: page 1 of `official_wizards_commander_legends_vertical_key_art_poster_en.pdf`.
- Rejected iteration: the removed v2 targets used a large navy/texture footer. Root QA correctly identified that treatment as too low-information for the project's edge-to-edge artwork requirement; those files are no longer retained as finished candidates.
- Corrected transformations: rendered page 1 at 600 DPI; cropped the poster's original title panel completely out; enlarged the remaining official Jeska illustration to fill the full 6:7 canvas; biased the crop slightly right to retain the complete upper-left Magic mark and right-hand weapon; integrated the exact enlarged `COMMANDER LEGENDS` typography directly over Jeska's lower clothing, weapons, and fabric; used only a shallow feathered translucent veil plus restrained teal/gold rules for readability. No opaque footer or replacement background is present, and meaningful official art continues through the bottom edge.
- `commander_legends_official_vertical_key_art_v4_1800x2100.png` — retained corrected unnumbered base. SHA-256: `2b7201e371f9ee048c4e959bbeebecf78d4ab2f3086e1acd806fe135526ef0ce`.
- `commander_legends_official_vertical_key_art_v4_deck_count_2_1800x2100.png` — corrected counted sibling created with `scripts/apply_deck_count.swift` and specification `2:1800`. The 210-pixel seal occupies x=1520–1730 and y=1820–2030 in top-left image coordinates, giving exactly 70 pixels of right and bottom inset. SHA-256: `62f4873ef12dbfb5b1fc06c45edf3c39b50b37633e8525e244355a279a106061`.
- Technical verification: both corrected final files are non-interlaced 8-bit RGBA PNGs at exactly 1800 × 2100 pixels with 600 × 600 DPI metadata. Separate visual inspection of base and counted versions confirmed full bleed, exact text, intact focal art, continuous detailed artwork through the lower edge, a clean title silhouette, and an unobstructed lower-right marker.

## Typography alternate v1 production record

- Generation mode: deterministic official-art and official-wordmark adaptation; ImageGen not used.
- Typography decision: the generic wide sans treatment and thin horizontal rules from v4 were removed. The replacement uses the exact official poster wordmark silhouette as one lockup, with `COMMANDER` tightly above the larger `LEGENDS`. A pale warm-metal face, copper/orange-red low tones, ember rim, deep wine-black outer silhouette, restrained engraved scratches, and controlled shadow echo Jeska's copper weapons and storm-red light while remaining immediately legible.
- Artwork preservation: the official page-1 Jeska illustration remains the sole finished artwork. Its complete Magic mark, Jeska's unobscured face and horns, weapons, clothing, cape, and red/navy sky are retained. The original poster footer is excluded; the lower image instead remains illustrated through the bottom edge with only feathered, translucent atmosphere behind the title.
- `commander_legends_official_vertical_key_art_typography_alternate_v1_1800x2100.png` — new unnumbered typography-focused alternate base. SHA-256: `be4ddedb4fc668f3d3695448a15c9fde9352938da7f43f9935fe211d88255b97`.
- `commander_legends_official_vertical_key_art_typography_alternate_v1_deck_count_2_1800x2100.png` — counted sibling created with `scripts/apply_deck_count.swift` and specification `2:1800`. The 210-pixel seal uses exactly 70 pixels of right and bottom outer-edge inset. SHA-256: `d95d215c3311d9003f483a5005fc0bafcec4bb32b0f9e475337dff081d50018a`.
- Technical verification: both alternate targets are non-interlaced 8-bit RGBA PNGs at exactly 1800 × 2100 pixels with 600 × 600 DPI metadata. Full-size inspection confirmed exact title text, intact official letter contours, crisp edges, unobscured face, no stray rules or hard footer, and no overlap with the lower-right seal. The 180 × 210 drawer-scale comparison confirmed that the exact official lockup remains materially more distinctive and readable than the retained generic v4 treatment.

## Typography alternate v2 production record

- Generation mode: deterministic official-art and exact official-contour adaptation; ImageGen not used.
- Source review: the retained three-page WPN poster, both official Jeska branded/key-art graphics, the extracted wordmark and its crop previews, Jeska cutout, Commander Legends texture, two-deck product composite, and individual Reap the Tides / Arm for Battle packaging were all inspected. Page-1 Jeska remains the strongest set-level art; the clean poster wordmark remains the strongest exact typography source; the official Wizards branded Jeska graphic provides the authoritative pale-silver-to-teal material direction.
- Typography decision: preserve the exact official `COMMANDER`-above-`LEGENDS` silhouettes but remove v1's oversized orange slab, heavy warm rim, and visible scratch pattern. The v2 face transitions from pale ivory/silver to muted teal-steel with a fine pale/antique-metal edge, deep indigo contour, restrained wine-red depth, and subtle warm glint. A localized feathered atmosphere supplies contrast without creating a footer, banner, or large blank field.
- Composition decision: the 1360-pixel-wide centered lockup is approximately 10.5% smaller than the first v2 draft and 18% smaller than v1. It remains dominant at drawer scale while preserving Jeska's unobstructed face, chest and weapon pose, revealing substantially more of the lower figure, and leaving the count seal a separate non-overlapping corner.
- `build_commander_legends_typography_alternate_v2.swift` — deterministic 1800 × 2100 compositor for the final art and exact official title treatment.
- `build_commander_legends_typography_qa_triptych.swift` — deterministic three-panel comparison builder used at full size and both requested drawer sizes.
- `commander_legends_typography_alternate_v2_build_notes.md` — detailed diagnosis, transformation, count-zone, QA, and technical record.
- `qa_v4_vs_typography_alternates_v1_v2_full_size.png` — 5400 × 2100 comparison; v4 left, v1 center, v2 right.
- `qa_v4_vs_typography_alternates_v1_v2_drawer_scale_300x350.png` — 900 × 350 comparison containing three 300 × 350 panels in the same order.
- `qa_v4_vs_typography_alternates_v1_v2_drawer_scale_360x420.png` — 1080 × 420 comparison containing three 360 × 420 panels in the same order.
- `commander_legends_official_vertical_key_art_typography_alternate_v2_1800x2100.png` — unnumbered v2 base. SHA-256: `2a0706b268fbbee6993ab993de5f919f66146d752e8417d261fca2c120f31a64`.
- `commander_legends_official_vertical_key_art_typography_alternate_v2_deck_count_2_1800x2100.png` — counted sibling created with `scripts/apply_deck_count.swift` and `2:1800`. The approved 210-pixel seal occupies x=1520–1730 and y=1820–2030 in top-left coordinates, with exactly 70 pixels of right and bottom inset. SHA-256: `04031cc736c816be1c72c0b1af6349063d9e89397d28ab729b64d1a37863944c`.
- Technical verification: both v2 finals are non-interlaced 8-bit RGBA PNGs at exactly 1800 × 2100 pixels with 600 × 600 DPI metadata. Full-size and 300 × 350 / 360 × 420 drawer-scale triptychs confirm exact readable text, a clean silhouette, full-bleed detailed art, no empty footer, unobstructed focal art, and clear separation between the title and count seal.
