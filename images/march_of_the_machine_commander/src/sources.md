# March of the Machine Commander — production provenance

## Product verification

- Canonical release group: **March of the Machine Commander**.
- Drawer title: **MARCH OF THE MACHINE**.
- Total ownership: **5** decks, matching Wizards' official First Look statement that the release has five Commander decks. All five are represented by this standalone drawer face; the retired Phyrexia | March split is no longer part of the drawer allocation.
- Official Wizards First Look: <https://magic.wizards.com/en/news/announcements/a-first-look-at-march-of-the-machine>
  - Wizards of the Coast, February 19, 2023.
  - Confirms five Commander decks and identifies the main March of the Machine key-art image as art by Billy Christian.
- Official Wizards collecting guide: <https://magic.wizards.com/en/news/feature/collecting-march-of-the-machine>
  - Confirms set code `MOC`, five Commander decks, and the contents of each deck.
- Official Wizards Play Network product/download page: <https://wpn.wizards.com/en/products/march-of-the-machine>
  - Authoritative source for the WPN Art and Logos package, Key Art Poster, and Key Art Social Media Assets used below.
- Official WPN dates and details: <https://wpn.wizards.com/en/news/dates-and-details-for-march-of-the-machine>

## Official source downloads and references

### Primary WPN social-key-art package

- Download URL: <https://media.wizards.com/2023/wpn/marketing_materials/mom/mom_sma_key_en.zip>
- Preserved archive: `mom_sma_key_en.zip`
- SHA-256: `eba2c7d315d09e64374190e5002ec9d5dc166284a310b26d2951bdb654e35cd5`
- Selected extraction: `mom_sma_fb_1000x1000_en.jpg`, 1000 × 1000 pixels.
- Selected extraction: `mom_sma_insta_1080x1920_en.jpg`, 1080 × 1920 pixels.
- Role: primary official composition and vertical-layout comparison. The square source preserves all three foreground heroes, Elesh Norn, the Magic logo, and a large two-line official `MARCH OF THE MACHINE` title. Its visible footer carries the packaged illustration credit to Magali Villeneuve.
- Primary extraction SHA-256: `e3bbfde0a4ff1e5c59461305c127aa187421df15e320b0ecc4fe3285c7dd7dec`.

### Official WPN print poster

- Download URL: <https://media.wizards.com/2023/wpn/marketing_materials/mom/mom_lgp_key_24x36_en.pdf>
- Preserved file: `mom_lgp_key_24x36_en.pdf`
- Original format: one-page 24 × 36-inch PDF; 1728 × 2592 PostScript points.
- Visible poster credit: Billy Christian.
- SHA-256: `de5a395035c34190ae43492e56e6016202db30c1a149de0b5491fc49e0f7487e`.
- Intermediate visual-QA render: `mom_lgp_key_24x36_en_preview.png`, 3600 × 5400 pixels at 150 DPI.
- Role: authoritative high-resolution vertical hierarchy, title scale, safe-area, and source-identity reference. It was not used as the final raster because its 2:3 poster framing would require a destructive vertical crop to reach 6:7.

### Official WPN art-and-logos package

- Download URL: <https://media.wizards.com/2023/wpn/marketing_materials/mom/mom_alg_en.zip>
- Preserved archive: `mom_alg_en.zip`
- SHA-256: `199d92de345a2041a0cfdac315a994063fd0130479fecf52b4a6818b80154488`.
- Selected extraction: `MOM_1080p_en.jpg`, 1920 × 1080 pixels; supporting official reference for title treatment, rock foreground, palette, and lighting. Visible file credit: Billy Christian.
- Selected extraction SHA-256: `fd7924b9d4c8f5bb0d704e937a212c6c4976b91c94f5352ae041e15312a7767c`.
- Selected extraction: `MTGMOM_EN_SetLogo_4C.png`, 2196 × 900 pixels; authoritative transparent set-logo reference.

### Additional official candidates retained from research

- `first_look_key_art_billy_christian.jpg`, 1920 × 1080 pixels.
  - URL: <https://media.wizards.com/2023/images/daily/xpQZfUOp00jw.jpg>
  - Role: unbranded First Look key-art candidate and identity check; the article attributes it to Billy Christian.
- `product_debut_header_1600x1080.jpg`, 1600 × 1080 pixels.
  - URL: <https://images.ctfassets.net/s5n2t79q9icq/1BIOyV6yL4BnKrSyW3oo7p/c7109bfe5e3a256c578ae2df0ffe8c6c/cndogSD3p_1600x1080-100.jpg>
  - Parent page: <https://magic.wizards.com/en/products/march-of-the-machine>
  - Role: alternate official product-page hero candidate; rejected for the final because it lacks the stronger integrated set title and portrait hierarchy of the WPN key art.

The packaged social assets and later poster expose different visible illustration credits. Both credits are recorded exactly as displayed rather than reconciling them by inference.

## ImageGen adaptation

- Mode: built-in ImageGen, `precise-object-edit` workflow.
- Image 1 / edit target: `mom_sma_fb_1000x1000_en.jpg`.
- Image 2 / supporting reference: `MOM_1080p_en.jpg`.
- Raw output: `imagegen_official_key_art_lower_extension_raw.png`, 1162 × 1354 pixels at 72 DPI.
- Raw-output SHA-256: `fb482ea5506b0437f2f4939be1ea3ebf68cbddddf34d6befaeb507514b137204`.
- Purpose: preserve the official WPN composition and exact title while extending the dark rocky foreground downward into a native-feeling 6:7 portrait, keeping a noncritical detailed lower-right seal zone.
- Final prompt brief: `../prompts/march_of_the_machine_commander_official_key_art_adaptation_brief.md`.

Exact built-in prompt:

> Use case: precise-object-edit. Asset type: premium 3 x 3.5-inch Commander storage-drawer face, portrait, full bleed. Image 1 is the edit target and authoritative official composition; Image 2 is a supporting official reference for battlefield-rock texture and dark lower-edge treatment. Create a 6:7 portrait version by preserving Image 1 exactly in the upper portion and extending only the canvas downward. Continue the foreground as richly detailed dark battlefield stone, dust, and subtle oily Phyrexian atmosphere matching the source lighting and palette. Preserve Teferi centered, Quintorius left, Elspeth right, Elesh Norn above, the small Magic logo, and the existing official title exactly. Text (verbatim): "MARCH OF THE MACHINE". Do not alter, duplicate, respell, regenerate, cover, or crop any existing text; do not add any new text. Keep the title fully above a clear lower-right count-seal zone. The lower extension must be detailed edge-to-edge and visually continuous, with noncritical dark rock in the lower-right corner. Constraints: change only the newly extended lower canvas; no border, frame, mat, blank band, featureless gradient, watermark, signature, extra logo, extra title, extra character, repeated subject, or smooth empty black. Avoid mutation of faces, hands, weapons, typography, set-symbol letterform, Magic logo, and the central composition.

## Final transformations

1. Copied the untouched built-in output from the Codex generated-images directory into `src/imagegen_official_key_art_lower_extension_raw.png`.
2. Resampled the raw 1162 × 1354 PNG to exactly 1800 × 2100 pixels with macOS `sips`; the ratio correction is below 0.1%.
3. Embedded 600 × 600 DPI metadata and retained the sRGB IEC61966-2.1 profile.
4. Preserved the unnumbered base as `../march_of_the_machine_commander_official_wpn_key_art_extended_battle_target_v1_1800x2100.png`.
5. Ran the repository-standard `scripts/apply_deck_count.swift` with `5:1800`, producing the active non-destructive standalone sibling. The script uses a 210-pixel antique-gold/dark seal with a Copperplate Bold ivory numeral and places the geometric outer edge exactly 70 pixels from the right and bottom. The former residual `4:1800` result is archived under `superseded_counted_targets/`.

## Final files and QA

### Unnumbered base

- `../march_of_the_machine_commander_official_wpn_key_art_extended_battle_target_v1_1800x2100.png`
- SHA-256: `9b6a59564ccc7961c901f20d48e37b1d851b23ea1c7197945e5316e2f12431c4`

### Counted sibling

- `../march_of_the_machine_commander_official_wpn_key_art_extended_battle_target_v1_deck_count_5_1800x2100.png`
- SHA-256: `5e82e6ea3a4372f12c00846c860d99de0e11b8dce33a1f6a701a3312519327cc`

### Superseded historical counted sibling

- `superseded_counted_targets/march_of_the_machine_commander_official_wpn_key_art_extended_battle_target_v1_deck_count_4_1800x2100.png`
- SHA-256: `c78bf9647e764261f25f0b0e47b90dd4b538162cbcf0d77fcb681f40eb824543`
- Preserved unchanged for allocation history; it is not an active finished target in the set root.

Verified with `src/verify_targets.swift` and visual inspection:

- Both targets are exactly 1800 × 2100 pixels, 6:7 portrait, 600 × 600 DPI, sRGB.
- The primary title reads exactly **MARCH OF THE MACHINE**, appears once, is unobstructed, and spans most of the usable width across two large lines. The official set-logo `O` in `OF` retains its intentional Phyrexian-symbol styling.
- All four key figures are distinct and unrepeated; no malformed text, extra subjects, watermarks, frames, or blank/featureless bands were found.
- The frame is full bleed and visually dense. A 6 × 7 tile analysis measured luminance standard deviations from 9.19 to 99.05 (median 50.66); the darkest lower tiles still contain visible rock, fissure, and rubble detail.
- The active counted face shows one `5` seal in the true lower-right corner. Detected gold-rim geometry: 210-pixel diameter, right edge at x=1730 and bottom edge at y=70 in Core Graphics coordinates, yielding exact 70-pixel right and bottom insets.
- The seal sits entirely below the title and covers only noncritical rocky foreground.
