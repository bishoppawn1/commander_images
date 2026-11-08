# Marvel Super Heroes Commander — official WPN key-art adaptation brief

## Mode and intent

- Use case: `ads-marketing`
- Asset type: print-ready 3 × 3.5-inch Commander drawer face
- Production mode: deterministic adaptation of official licensed Wizards Play Network art and logos; no ImageGen generation is needed because a suitable official portrait visual exists.

## Inputs and roles

1. `src/official_wpn/key_social/en/MSH_sma_key_1080x1350.jpg` — primary official WPN portrait key-art source and composition anchor. Preserve the single licensed group scene and its established character identities, proportions, lighting, city setting, painterly finish, and action.
2. `src/official_wpn/art_and_logos/en/Set_Logo/Print/MTGMSH_EN_SetLogo.tif` — official high-resolution transparent CMYK print set logo. Composite this asset directly with color conversion onto the sRGB target canvas; do not redraw, restyle, regenerate, distort, or alter its letterforms.
3. `src/official_wpn/product_shots/MTGMSH_EN_OtrBx_Cmndr_05.png` — official four-deck family-shot reference used only to verify that this is the June 2026 Commander product containing Avengers Assemble, Wakanda Forever, The Fantastic Four, and Doom Prevails. Do not composite the product boxes.

## Required composition

- Reframe the primary portrait source to exact 6:7 without changing or duplicating any character. Use the dense upper key-art scene as the visual anchor and preserve Black Panther as the central forward-moving subject.
- Completely cover the source portrait's smaller lower split lockup before applying the replacement title, so the final has exactly one visible `MARVEL SUPER HEROES` title and no ghosted or duplicate branding.
- Use a compact dark comic-action title field with a restrained red lower band, subtle speed-line texture, and an antique-gold separator. It may veil only the lower rubble/leg region needed for title contrast; the frame must remain visually dense and full bleed.
- Composite the official standalone set logo near full safe width. Its visible title must read exactly **MARVEL SUPER HEROES**, with the licensed red Marvel box and the gold `SUPER HEROES` wordmark unchanged. This is the dominant identification element and must remain immediately legible at drawer scale.
- Add exact subordinate text `COMMANDER` once in crisp pale-ivory Copperplate Bold on the lower red band. It must remain secondary to `MARVEL SUPER HEROES` and stop before the standard lower-right count-seal zone.
- Do not add deck names, a face-commander montage, new characters, extra logos, card frames, borders, white mats, watermarks, or generated pseudo-branding.

## Output and marker requirements

- Create an unnumbered full-bleed PNG at exactly 1800 × 2100 pixels with 600 × 600 DPI metadata and an sRGB canvas.
- Preserve the unnumbered base unchanged.
- Create a separately named counted sibling with `scripts/apply_deck_count.swift` using marker specification `4:1800`.
- The approved count seal must be exactly 210 pixels in diameter with a dark field, antique-gold rim, pale-ivory Copperplate Bold numeral `4`, and exactly 70-pixel right and bottom outer-edge insets. The seal must sit in the lower-right red-band area without obscuring the dominant title or a critical character feature.

## Final filenames

- `marvel_super_heroes_commander_official_wpn_key_art_target_v1_1800x2100.png`
- `marvel_super_heroes_commander_official_wpn_key_art_target_v1_deck_count_4_1800x2100.png`
