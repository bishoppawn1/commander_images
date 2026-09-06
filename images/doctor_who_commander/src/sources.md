# Doctor Who Commander drawer-face sources and production record

Research and production completed **2026-08-27** and updated **2026-09-03**. Visual inputs are official Wizards of the Coast / Wizards Play Network materials using the licensed BBC `DOCTOR WHO` identity. The release and drawer contain four unique 2023 Commander decks, so the active count marker is `4`.

## Authoritative product, First Look, debut, and count research

1. **Wizards First Look — A First Look at Magic: The Gathering—Doctor Who** (Jubilee Finnegan, 2023-07-28)  
   https://magic.wizards.com/en/news/announcements/a-first-look-at-magic-the-gathering-doctor-who  
   Official First Look and source page for the launch key art, set logo, four Commander deck identities, and product details. It states that the release contains four Commander decks.

2. **Wizards debut/collecting feature — Collecting Magic: The Gathering—Doctor Who** (Max McCall, 2023-10-03)  
   https://magic.wizards.com/en/news/feature/collecting-magic-the-gathering-doctor-who  
   Official debut-era set overview, licensed set logo reference, and Commander product summary.

3. **Wizards Commander decklists — Magic: The Gathering—Doctor Who Commander Decklists** (2023-10-07)  
   https://magic.wizards.com/en/news/announcements/magic-the-gathering-doctor-who-commander-decklists  
   Authoritative unique-deck naming corroboration: **Blast from the Past**, **Timey-Wimey**, **Paradox Power**, and **Masters of Evil**. The user-confirmed drawer count is `4`, matching these four unique products.

4. **WPN product and marketing-download hub — Magic: The Gathering—Doctor Who**  
   https://wpn.wizards.com/en/products/universes-beyond-doctor-who  
   Official source hub for art and logos, product shots, key-art social-media assets, and the 24 × 36 key-art poster.

5. **WPN early reveal — Dates & Details for Universes Beyond: Doctor Who** (2023-07-28)  
   https://wpn.wizards.com/en/news/dates-and-details-universes-beyond-doctor-who  
   Official retailer First Look companion, Commander face-card reveal, and pointer to the updated product/marketing assets.

6. **WPN poster and launch reference — Doctor Who Promo Kit & Launch Party Overview** (2023-10-03)  
   https://wpn.wizards.com/en/news/magic-the-gathering-r-doctor-who-tm-promo-kit-and-launch-party-overview  
   Confirms the official set poster as a physical promotional component of the release.

## Retained official visual sources

All downloaded archives and media below are preserved untouched in `src/`; extracted files are retained alongside their original archives for inspection and deterministic reproduction.

### Selected WPN poster

- `official_wpn_doctor_who_key_art_poster_24x36_en.pdf` — official single-page 24 × 36 poster, 1728 × 2592 pt, about 10 MB. **Selected primary art source.**  
  Direct URL: https://media.wizards.com/2023/wpn/marketing_materials/who/who_lgp_key_24x36_en.pdf
- `official_wpn_doctor_who_key_art_poster_24x36_en_preview.png` — 3600 × 5400 px, 150-PPI inspection render derived with Poppler; not a final target.
- The poster itself credits the key art to **Shahab Alizadeh** and carries the Wizards/BBC licensing line. It was selected because its TARDIS-in-the-time-vortex art is a strong whole-product identifier, is already portrait-oriented, contains dense edge-to-edge detail, and provides much higher print detail than the 1080 × 1920 social file.

### WPN art and exact logos

- `official_wpn_doctor_who_art_and_logos_en.zip` — untouched official WPN archive.  
  Direct URL: https://media.wizards.com/2023/wpn/marketing_materials/who/who_alg_en.zip
- Extracted official files:
  - `MTGWHO_EN_SetLogo_1line.png` — 900 × 407 px transparent licensed set lockup.
  - `MTGWHO_EN_SetLogo_2line.png` — 900 × 407 px transparent licensed stacked set lockup; **exact identity source selected for the final title**.
  - `WHO_1080p_en.jpg` — 1920 × 1080 px official branded landscape key art.
- `official_wpn_doctor_who_title_derived.png` — 640 × 155 px transparent, lossless region crop from `MTGWHO_EN_SetLogo_2line.png`. It contains the untouched BBC + exact `DOCTOR WHO` product wordmark. The reproducible extraction command is:

```sh
ffmpeg -y -v error \
  -i src/MTGWHO_EN_SetLogo_2line.png \
  -vf 'crop=640:155:130:252' \
  src/official_wpn_doctor_who_title_derived.png
```

### WPN social and vertical/portrait key art

- `official_wpn_doctor_who_key_art_social_assets_en.zip` — untouched official WPN archive.  
  Direct URL: https://media.wizards.com/2023/wpn/marketing_materials/who/who_key_art_sma_en.zip
- Extracted official files:
  - `who_sma_insta_1080x1920_en.jpg` — 1080 × 1920 px official vertical/portrait social key art; strongest raster-only alternate and a key composition reference.
  - `who_sma_fb_1000x1000_en.jpg` — 1000 × 1000 px square social key art.
  - `who_sma_fb_groups_1640x680_en.jpg` — 1640 × 680 px wide social key art.
  - `who_sma_fb_pages_1600x841_en.jpg` — 1600 × 841 px landscape social key art.

### Wizards First Look assets

- `official_first_look_doctor_who_key_art.jpg` — 1920 × 1080 px official launch key art.  
  Direct URL: https://media.wizards.com/2023/images/daily/y01jw4VZjkDo.jpg
- `official_first_look_doctor_who_set_logo.png` — 900 × 407 px exact official transparent set logo.  
  Direct URL: https://media.wizards.com/2023/images/daily/en_Armh8oHF0Sxh.png

These confirm the same licensed TARDIS composition and title treatment used by the WPN package. Product photographs were researched on the WPN product page but were deliberately excluded from the face: the finished target is key art, not a box photo on an empty field.

## Generation mode and exact prompt

- **Generation mode:** deterministic adaptation of official licensed Wizards/WPN sources using CoreGraphics and ffmpeg.
- **ImageGen used:** **No.** The official high-resolution poster and exact transparent product lockup fully satisfy the art and typography requirements.
- **Exact ImageGen prompt:** none; no generative model call was made.
- Finalized production brief: `../prompts/doctor_who_commander_official_wpn_tardis_key_art_adaptation_brief.md`.

## Deterministic target construction

Script: `build_doctor_who_commander_target.swift`

1. Open the official 1728 × 2592 pt WPN poster PDF directly.
2. Crop the PDF to `(x: 144, y: 528, width: 1440, height: 1680)` in bottom-left PDF coordinates. This exact 6:7 crop preserves the complete TARDIS and vortex while excluding the poster's top marketing lockup and lower title/legal region.
3. Scale the crop exactly 1.25× to 1800 × 2100; no outpainting, generated extension, or aspect distortion is used.
4. Apply a feathered translucent indigo veil across the lower vortex/TARDIS-base region; the underlying art remains visible.
5. Composite the untouched official BBC + `DOCTOR WHO` crop at 1660 px wide with 70 px left/right placement insets. The title is exact licensed art, not rebuilt typography, and remains above the count-seal zone.
6. Write an sRGB RGBA PNG with 600 × 600 DPI metadata.

Base build command:

```sh
swift src/build_doctor_who_commander_target.swift \
  src/official_wpn_doctor_who_key_art_poster_24x36_en.pdf \
  src/official_wpn_doctor_who_title_derived.png \
  doctor_who_commander_official_wpn_tardis_key_art_target_v1_1800x2100.png
```

Counted sibling command:

```sh
swift ../../scripts/apply_deck_count.swift \
  doctor_who_commander_official_wpn_tardis_key_art_target_v1_1800x2100.png \
  doctor_who_commander_official_wpn_tardis_key_art_target_v1_deck_count_4_1800x2100.png \
  4:1800
```

The standard script draws a 210 px dark circular seal with antique-gold rim and pale-ivory Copperplate Bold `4`. Its center is `(1625, 175)` in bottom-left output coordinates; the circle spans `x = 1520…1730` and `y = 70…280`, leaving exactly 70 px between its circular outer edge and both the right and bottom image edges.

## Final targets and QA

- `../doctor_who_commander_official_wpn_tardis_key_art_target_v1_1800x2100.png` — unnumbered base.
- `../doctor_who_commander_official_wpn_tardis_key_art_target_v1_deck_count_4_1800x2100.png` — active count-4 full-bleed sibling; base preserved. SHA-256: `d17d06301e08e1ea14318a8d3b7be877f78dcd8c1bce5363c0dc118a6de33f4a`.
- `../doctor_who_commander_official_wpn_tardis_key_art_target_v1_deck_count_4_1724x2024_black_margin_1_8in.png` — active count-4 black-margin print sibling. SHA-256: `b4c4056f3fd4fb1d4b92bddfc112c1911e55efc4b56a9271b4e68a9d367f2517`.
- `superseded_counted_targets/doctor_who_commander_official_wpn_tardis_key_art_target_v1_deck_count_5_1800x2100.png` and its black-margin sibling — superseded count-5 outputs retained as historical production evidence.

Supporting visual QA artifacts:

- `doctor_who_commander_drawer_preview_v1_300x350.png`
- `doctor_who_commander_drawer_preview_v1_deck_count_4_300x350.png`
- `doctor_who_commander_count_seal_inspection_v1_400x400.png`

Checks passed:

- Both deliverables are exactly 1800 × 2100 px (6:7), RGBA/sRGB, full bleed, and carry 600 × 600 DPI metadata.
- The exact licensed `DOCTOR WHO` wordmark spans a 1660 px overlay (92.2% of the face width), is the dominant first read, and remains crisp and legible in the 300 × 350 drawer previews.
- No AI-rendered, malformed, or invented title text is present. Incidental `POLICE PUBLIC CALL BOX` lettering is inherited unchanged from the licensed TARDIS artwork.
- The TARDIS remains complete from lamp to base, with luminous time-vortex detail at every edge and no blank, white, featureless, or packaging-photo field.
- The count `4` is clear at drawer scale and does not cover the title or the TARDIS focal detail.
- Seal diameter and circular-edge insets follow the project-standard 210 px / exact 70 px geometry.
- A clean rebuild from the documented sources and script was byte-for-byte identical to the delivered base target; rebuilding the counted sibling was also byte-for-byte identical.
- The main directory contains only the finished base, finished counted sibling, `prompts/`, and `src/`.
