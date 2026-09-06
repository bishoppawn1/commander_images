# Phyrexia: All Will Be One Commander — official key-art adaptation brief

## Mode and intended use

- **Use case:** `ads-marketing`
- **Asset type:** preserved 3 × 3.5-inch portrait alternate full-release drawer face for the two owned Phyrexia: All Will Be One Commander decks. The current physical allocation represents both decks on the Commander Legends | Phyrexia: All Will Be One split face; this standalone target remains an alternate full-release candidate rather than an additional allocation.
- **Production mode:** direct, non-generative adaptation of official Wizards Play Network key art. Preserve the established set-level identity instead of forcing the two Commander leads into a montage.

## Input images and roles

1. `../src/official_wpn_one_key_art_poster_24x36_en.pdf` — untouched official WPN 24 × 36 key-art poster and primary provenance master. Its vertical Elesh Norn composition, credited in the poster to Magali Villeneuve, is the selected edit target.
2. `../src/official_wpn_one_key_art_poster_24x36_en_page1_150ppi.png` — unmodified 3600 × 5400 rasterization of the selected official poster; direct pixel source for the finished adaptation.
3. `../src/one_sma_insta_1080x1920_en.jpg` — unmodified official WPN vertical social asset showing the same Elesh Norn key-art family; portrait composition and palette reference only.
4. `../src/one_sma_fb_1000x1000_en.jpg` — unmodified official WPN square branded social asset; branding-placement reference only.
5. `../src/one_1080p_en.jpg` — unmodified official WPN horizontal key art; artwork and logo-placement reference only.
6. `../src/MTGONE_EN_SetLogo.png` — unmodified official transparent set logo; typography and color reference only. Do not composite it because the required drawer title includes an explicit colon.
7. `../src/official_wizards_one_first_look_key_art_anato_finnstark.png` — unmodified official Wizards First Look branded key art by Anato Finnstark; alternate set-level art reference only.
8. `../src/official_wizards_new_phyrexia_landscape_sergey_glushakov.png` — unmodified official Wizards First Look New Phyrexia landscape by Sergey Glushakov; environment reference only.
9. `../src/official_wpn_one_oversized_art_72x48.pdf` — untouched official WPN oversized-art PDF credited in the file to Matteo Bassini; alternate art reference only.
   `../src/official_wpn_one_oversized_art_72x48_page1_75ppi.png` — unmodified 5400 × 3600 rasterization of that PDF; alternate-art inspection reference only.
10. `../src/official_wpn_one_key_art_social_media_assets_en.zip` — untouched WPN distribution archive for the retained social assets.
11. `../src/official_wpn_one_art_and_logos_en.zip` — untouched WPN distribution archive for the retained horizontal key art and transparent logo.
12. `../src/official_wizards_corrupting_influence_product_reference.png` — unmodified official Wizards decklist-page product image for Corrupting Influence; product-group verification only, not composited.
13. `../src/official_wizards_rebellion_rising_product_reference.png` — unmodified official Wizards decklist-page product image for Rebellion Rising; product-group verification only, not composited.
14. `../src/official_wpn_one_key_art_poster_preview.png` — reduced inspection copy of the poster raster; visual source-selection QA only, never composited.
15. `../src/official_wpn_one_key_art_instagram_preview.jpg` — reduced inspection copy of the official Instagram asset; visual source-selection QA only, never composited.

## Exact identification text

Render this set-identifying title verbatim, exactly once, as two centered horizontal lines:

`PHYREXIA:`

`ALL WILL BE ONE`

Together the lines must read exactly **`PHYREXIA: ALL WILL BE ONE`**. Preserve the colon. Use large, crisp, high-contrast pale-ivory Copperplate Bold lettering with a dark outline and restrained red-black shadow. `PHYREXIA:` should span nearly the full usable width; `ALL WILL BE ONE` should also be large and immediately legible at drawer distance. No abbreviation, misspelling, replacement symbol, duplicate title, or extra title words.

## Composition and transformations

- Preserve the official Magali Villeneuve vertical Elesh Norn key art, the halo-like white headpiece, red exposed biomechanical tissue, porcelain armor, oil-dark architecture, cardinal cloth, and small Magic wordmark.
- Crop the 2:3 poster to the exact 6:7 canvas by removing its separate lower branding panel and a limited amount of noncritical top/bottom margin. Do not stretch or distort the artwork.
- Integrate the replacement exact title directly over detailed lower artwork. Use only a feathered dark oil-and-crimson readability veil; do not add an opaque footer, blank panel, frame, or large featureless field.
- Keep Elesh Norn's head, hand, torso, and porcelain silhouette unobstructed. Meaningful artwork or texture must continue through every edge.
- Reserve the actual lower-right count-marker zone for the separately applied full-release `2` seal; title lettering must remain clear of that zone.

## Output constraints

- Exact portrait aspect ratio: 6:7.
- Exact print target: 1800 × 2100 pixels with 600 × 600 DPI metadata in sRGB.
- Full bleed with useful visual detail across the entire frame; no white, blank, framed, or featureless areas.
- Preserve an unnumbered base target and create a separately named counted sibling.
- Apply the standard single-set seal only with `scripts/apply_deck_count.swift` and argument `2:1800`, producing the approved 210-pixel-diameter marker with equal 70-pixel right and bottom outer-edge insets. The incorrect allocation pass's `1` sibling is archived under `../src/superseded_correction_history/` and is not an active root target.

## Avoid

- No two-lead montage, deck names, or face-commander additions.
- No generated or substituted characters.
- No malformed or pseudo-text, missing colon, repeated subjects, extra logos, watermarks beyond the official source's retained Wizards marks, empty margins, border frames, or low-information title footer.
