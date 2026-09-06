# Commander 2013 source and production record

## Scope and inventory decision

- Physical group: Commander 2013, incomplete at 2/5 decks owned.
- Owned decks represented: **Eternal Bargain** and **Mind Seize** only.
- Face commanders used: **Oloro, Ageless Ascetic** and **Jeleva, Nephalia's Scourge**.
- Count marker: **2**, the number of owned physical decks represented by this drawer face.
- The other three release decks and their commanders were intentionally excluded from the composition.

## Authoritative research

- Wizards of the Coast, [All Five Commander Decklists](https://magic.wizards.com/en/news/making-magic/all-five-commander-decklists-2013-10-18), October 18, 2013. This is the authoritative release deck-list source; its Eternal Bargain and Mind Seize sections establish the two deck names and their contents.
- Wizards of the Coast Magic Creative Team, [The Ten Commanders](https://magic.wizards.com/en/news/feature/ten-commanders-2013-10-29), October 30, 2013. This official character feature supplies the Oloro and Jeleva art files and their visual/story identities.
- Wizards of the Coast, [Your Wish Is My Commander](https://magic.wizards.com/en/news/making-magic/your-wish-my-commander-2013-10-28), October 28, 2013. Release-design context: Commander 2013 used five shard-color decks with face commanders designed around the command zone and commander recasting rules.

## Retained official image sources

| Local raw file | Direct source URL | Original dimensions | Attribution / role |
| --- | --- | ---: | --- |
| `official_jeleva_nephalias_scourge_wizards.jpg` | https://media.wizards.com/images/magic/daily/ur/ur271_jeleva.jpg | 620 x 453 px, 72 DPI | Official Wizards character art; Jeleva art by Cynthia Sheppard. Primary Mind Seize character and palette reference. |
| `official_oloro_ageless_ascetic_wizards.jpg` | https://media.wizards.com/images/magic/daily/ur/ur271_oloro.jpg | 620 x 453 px, 72 DPI | Official Wizards character art; Oloro art by Eric Deschamps. Primary Eternal Bargain character and palette reference. |
| `official_eternal_bargain_packaging_wizards.jpg` | https://media.wizards.com/images/magic/daily/arcana/arc1338_b.jpg | 620 x 439 px, 72 DPI | Official Wizards Eternal Bargain product image. Supporting product-name, face-card, and white-blue-black identity reference only. |
| `official_mind_seize_packaging_wizards.jpg` | https://media.wizards.com/images/magic/daily/arcana/arc1338_u.jpg | 620 x 439 px, 72 DPI | Official Wizards Mind Seize product image. Supporting product-name, face-card, and blue-black-red identity reference only. |
| `official_commander_2013_footer_key_art_wizards.jpg` | https://media.wizards.com/images/magic/daily/footers/CMD13/Commander_Footer_Background3.jpg | 620 x 508 px, 72 DPI | Official Commander 2013 footer/key-art treatment using Marath art by Tyler Jacobson. Retained as release-branding research, but deliberately not supplied to ImageGen because this physical group does not include Nature of the Beast. |

Artist metadata was cross-checked against the Commander 2013 card records returned by Scryfall's named-card API: [Jeleva](https://api.scryfall.com/cards/named?exact=Jeleva%2C%20Nephalia%27s%20Scourge&set=c13), [Oloro](https://api.scryfall.com/cards/named?exact=Oloro%2C%20Ageless%20Ascetic&set=c13), and [Marath](https://api.scryfall.com/cards/named?exact=Marath%2C%20Will%20of%20the%20Wild&set=c13).

## Generation record

- Mode: default built-in ImageGen tool, reference-guided new generation (`stylized-concept`).
- Input order:
  1. `official_jeleva_nephalias_scourge_wizards.jpg` — primary Jeleva character reference.
  2. `official_oloro_ageless_ascetic_wizards.jpg` — primary Oloro character reference.
  3. `official_eternal_bargain_packaging_wizards.jpg` — supporting Eternal Bargain product/color reference.
  4. `official_mind_seize_packaging_wizards.jpg` — supporting Mind Seize product/color reference.
- Unmodified selected ImageGen output: `imagegen_commander_2013_owned_decks_cover_v1_raw.png`, 1163 x 1353 px, 72 DPI.
- The built-in tool originally saved the same bytes at `/Users/bishophall/.codex/generated_images/01a03c35-59d7-7fc3-b502-7a5261844e04/exec-3b46e346-d19c-40b6-a26a-dda28a514d5e.png`; the project copy above is retained as the provenance source.

### Exact ImageGen prompt

```text
Use case: stylized-concept
Asset type: premium 3 x 3.5-inch portrait drawer-face cover for a physical Magic: The Gathering Commander collection
Primary request: Create a visually full, edge-to-edge fantasy cover for Commander 2013 that represents only the two owned decks, Eternal Bargain and Mind Seize. Recompose the supplied official face-commander artworks into one coherent premium key-art scene rather than showing card frames, boxes, or all five release decks.
Input images: Image 1 is official Wizards Jeleva, Nephalia's Scourge artwork, the primary character and visual-identity reference for Mind Seize; preserve her pale vampire face, black veils, jeweled headpiece, reaching hands, and blue-black-red night-magic atmosphere. Image 2 is official Wizards Oloro, Ageless Ascetic artwork, the primary character and visual-identity reference for Eternal Bargain; preserve his immense seated giant-soldier silhouette, stone throne, blue-white-black life-energy, and mist-shrouded ancient-island atmosphere. Image 3 is official Wizards Eternal Bargain packaging, supporting product/color reference only; do not reproduce the package, card frame, small copy, or logos. Image 4 is official Wizards Mind Seize packaging, supporting product/color reference only; do not reproduce the package, card frame, small copy, or logos.
Scene/backdrop: A continuous dark fantasy environment blending Oloro's ancient flooded stone throne and cool cascading light at lower left with Jeleva's stormy Nephalian night, moonlit gothic spires, and flowing black veils at upper right. Connect them through curling magical mist and sweeping fabric, without a hard split or empty gutter.
Subject: Exactly two principal figures: Oloro, monumental and calm on his ruined throne, and Jeleva, airborne and predatory with an outstretched hand. Keep both faces and silhouettes coherent and recognizable from the references. Do not add other Commander 2013 face commanders or extra focal characters.
Style/medium: richly painted high-fantasy trading-card key art; premium supplemental-product cover; crisp anatomy, controlled detail, dramatic depth, fine mist, stone, metal, fabric, moonlight, and magical energy textures.
Composition/framing: strict 6:7 portrait. Full-bleed art with useful visual information to every edge. Oloro anchors the lower-left and center; Jeleva sweeps through the upper-right. Keep faces and hands away from the outer print-safe area. Reserve a non-critical dark-texture zone at the lower-right for a later circular collection seal. Place the exact title horizontally across the upper-middle third where neither character nor effects obstruct it. The title must span nearly the full usable width, have a clean silhouette, and read instantly from drawer-viewing distance.
Lighting/mood: moonlit indigo, charcoal, and violet atmosphere; Oloro edged with restrained ivory and cyan life-light; Jeleva edged with restrained crimson and cold blue spell-light; grave, luxurious, ancient, and dangerous.
Color palette: blue-white-black for Eternal Bargain blended with blue-black-red for Mind Seize; antique silver and pale ivory title accents; avoid bright green or dominant orange.
Text (verbatim): "COMMANDER 2013"
Typography: Render the title exactly once, in one large horizontal line, all uppercase, with crisp high-contrast pale-ivory engraved serif lettering, subtle dark shadow, and a thin antique-metal edge. Spell exactly C-O-M-M-A-N-D-E-R, space, 2-0-1-3. No subtitle, deck names, card text, logo, extra letters, or other readable text.
Constraints: exact title text; exactly two principal subjects; visually full edge-to-edge 6:7 portrait composition; no blank, white, featureless, or low-information areas; no separate panels; no card borders; no package mockup; no Magic logo; no watermark; no collection-count seal in the generated base; print-safe title and faces; coherent anatomy and hands; lower-right seal zone contains only expendable atmosphere/stone/fabric detail.
Avoid: all-five-deck montage, other Commander 2013 commanders, duplicated subjects, cropped title, misspelled text, tiny text, extra text, large empty sky, empty floor, flat collage seams, modern graphic gradients, photorealistic cosplay, cards, boxes, logos, watermarks.
Output intent: One polished portrait source image suitable for normalization to exact 1800 x 2100 print artwork.
```

The finalized project brief is also retained at `../prompts/commander_2013_owned_decks_cover_v1.md`; it explicitly names each local input and its role.

## Final transformations and assets

1. `commander_2013_eternal_bargain_mind_seize_premium_cover_v1.png`
   - Created from the unmodified ImageGen source with macOS `sips --resampleHeightWidth 2100 1800`.
   - Set to 600 x 600 DPI metadata.
   - The source ratio was 0.85957 versus the exact 6:7 target ratio of 0.85714, so exact-dimension resampling applies only an approximately 0.28% horizontal aspect normalization. No crop, repaint, sharpening, color edit, or typography replacement was applied.
   - Finished unnumbered base; 1800 x 2100 px, 600 DPI PNG.
2. `commander_2013_eternal_bargain_mind_seize_premium_cover_v1_deck_count_2.png`
   - Created non-destructively from the base with `swift scripts/apply_deck_count.swift INPUT OUTPUT 2:1800`.
   - Standard 210 px / 0.35-inch dark seal, antique-gold rim, pale-ivory Copperplate Bold numeral, with equal 70 px right and bottom inset.
   - Finished counted sibling; 1800 x 2100 px, 600 DPI PNG.

## Visual QA

Both final targets were opened and visually inspected at full source resolution on 2026-08-26. The title is exactly **COMMANDER 2013**, appears once, spans nearly the full usable width, and is immediately legible. Jeleva and Oloro are coherent and recognizable; no additional face commanders appear. The frame is full-bleed with no large blank or featureless region. The count seal reads **2**, sits in the true lower-right corner with equal insets, and covers only expendable stone/mist detail rather than a title, face, hand, or essential silhouette.

## Typography-focused v2 alternate

### Official wordmark audit and deterministic decision

- The official 2013 Wizards packaging sources already retained above were re-inspected specifically for their typography. They show the era's silver `COMMANDER` retail mark below the Magic logo, but only as a very small part of 620 x 439-pixel product photographs. They do not contain `2013` in the lockup.
- The official Commander 2013 footer/key-art asset also uses `COMMANDER` without `2013` and includes unrelated sales copy. No clean, standalone, sufficiently large, exact `COMMANDER 2013` Wizards lockup was found in the authoritative material inspected for this release.
- Upscaling and extending the tiny packaging mark would have produced a mixed, low-resolution partial logo and would not have solved the requested generic Trajan-like character. The v2 alternate therefore uses exact deterministic lettering instead of a simulated or incomplete official lockup.
- The chosen display face is **Pirata One**, designed by Rodrigo Fuenzalida and Nicolas Massi and added to Google Fonts on October 31, 2012. Its narrow, angular blackletter construction is contemporaneous with the 2013 product and supplies clearly medieval/occult terminals without sacrificing the title's one-line drawer-scale silhouette.

### New retained production assets

| Local file | Source / derivation | Dimensions or format | Role |
| --- | --- | --- | --- |
| `PirataOne-Regular.ttf` | [Google Fonts repository, Pirata One](https://raw.githubusercontent.com/google/fonts/main/ofl/pirataone/PirataOne-Regular.ttf) | TrueType, regular 400 | Deterministic Gothic title face. Copyright 2012 Rodrigo Fuenzalida and Nicolas Massi; SIL Open Font License. |
| `OFL_PirataOne.txt` | [Google Fonts repository, OFL](https://raw.githubusercontent.com/google/fonts/main/ofl/pirataone/OFL.txt) | UTF-8 text | Retained license for the embedded production font. |
| `build_commander_2013_gothic_wordmark.swift` | Project-local deterministic build | Swift / Core Graphics / Core Text | Conceals the v1 title, draws the shaped black-iron cartouche and exact metal wordmark, preserves the rest of the pixels, and writes 600-DPI PNG metadata. |
| `preview_v1_drawer_300x350.png` | Downscaled from the preserved v1 base with macOS `sips` | 300 x 350 px | Drawer-scale comparison preview for the original typography. |
| `preview_v2_gothic_wordmark_drawer_300x350.png` | Downscaled from the v2 base with macOS `sips` | 300 x 350 px | Drawer-scale comparison preview for the new unnumbered typography. |
| `preview_v2_gothic_wordmark_deck_count_2_drawer_300x350.png` | Downscaled from the v2 counted sibling with macOS `sips` | 300 x 350 px | Drawer-scale QA preview for the standard seal and title together. |

The finalized typography brief is retained at `../prompts/commander_2013_owned_decks_cover_v2_gothic_wordmark.md`. No built-in ImageGen call or CLI generation was used for v2; the strong v1 Oloro/Jeleva artwork remains the edit target and is unchanged outside the title region.

### Exact deterministic build

```text
swift images/commander_2013/src/build_commander_2013_gothic_wordmark.swift \
  images/commander_2013/commander_2013_eternal_bargain_mind_seize_premium_cover_v1.png \
  images/commander_2013/src/PirataOne-Regular.ttf \
  images/commander_2013/commander_2013_eternal_bargain_mind_seize_premium_cover_v2_gothic_wordmark.png

swift scripts/apply_deck_count.swift \
  images/commander_2013/commander_2013_eternal_bargain_mind_seize_premium_cover_v2_gothic_wordmark.png \
  images/commander_2013/commander_2013_eternal_bargain_mind_seize_premium_cover_v2_gothic_wordmark_deck_count_2.png \
  2:1800
```

### V2 transformations and finished assets

1. `commander_2013_eternal_bargain_mind_seize_premium_cover_v2_gothic_wordmark.png`
   - New non-destructive sibling derived from the preserved v1 base; no v1 target was overwritten.
   - The former title is fully concealed by an opaque, pointed, bowed-edge blackened-metal cartouche rather than a modern rectangle.
   - The exact one-line title **COMMANDER 2013** is drawn at 251 points in Pirata One, spanning approximately 1,535 pixels. The build applies a black-iron depth stroke, antique-silver bevel, dark-silver carved-metal gradient, deterministic fine wear, and restrained left-cyan/right-crimson energy tint.
   - The title zone remains between Jeleva and Oloro. Both faces, Jeleva's hands, Oloro's torso and hands, the full-frame environment, and the lower-right seal-safe area are preserved.
   - Finished unnumbered alternate; exact 1800 x 2100 px, 600 x 600 DPI PNG.
2. `commander_2013_eternal_bargain_mind_seize_premium_cover_v2_gothic_wordmark_deck_count_2.png`
   - Created only from the new v2 base with the standard project script and marker specification `2:1800`.
   - Standard 210-pixel dark circular seal, antique-gold rim, pale-ivory Copperplate Bold numeral, with exact 70-pixel right and bottom inset.
   - Finished counted sibling; exact 1800 x 2100 px, 600 x 600 DPI PNG.

### V2 visual QA

- The original v1 and new v2 bases were inspected at full resolution and at a 300 x 350-pixel drawer-scale preview.
- At full resolution, the title is exact, appears once, has clean blackletter contours, restrained carved-metal wear, and fully masks the old generic serif title. No title glyph is cropped and neither lead's face is obscured.
- At drawer scale, the v2's narrow Gothic silhouette, heavy dark outline, and forged cartouche remain immediately distinguishable; `COMMANDER 2013` reads more quickly and with substantially more setting-specific character than the v1's generic pale serif treatment.
- The counted target was inspected at full and drawer scale. The `2` seal covers only expendable lower-right atmosphere and floor detail; it does not overlap a title, face, hand, or essential silhouette.
- `sips` verification reports exact 1800 x 2100 dimensions, RGB PNG output, and 600 x 600 DPI metadata for both v2 finished targets.

## Typography-focused v3 atmospheric alternate

### Official identity audit and design decision

- The two official 2013 Wizards packaging images and the official Commander 2013 footer/key-art image were re-inspected at source resolution. The retained `official_commander_wordmark_crop_eternal_bargain.jpg` and 5x inspection preview isolate the packaging treatment: a restrained, open, pale-silver serif `COMMANDER` mark with no plaque. The source is only 320 x 120 pixels after cropping, includes no `2013`, and is not a clean standalone logo.
- No authoritative asset inspected supplies a clean, exact, sufficiently large `COMMANDER 2013` lockup. Directly enlarging the tiny partial mark or grafting a separately typeset year onto it would produce a visibly mixed-resolution title. The crop is therefore research evidence only and is not composited into the final.
- V3 instead follows the packaging's useful period behavior—open silver lettering over art, high contrast, quiet taper, and no enclosure—using exact deterministic typography. It deliberately rejects v2's Pirata One blackletter, black-iron cartouche, and heavy slab construction.
- **Alegreya SC Medium** was chosen for the accepted v3. Designed in 2011 by Juan Pablo del Peral / Huerta Tipográfica, it is contemporary with the 2013 release. Its calligraphic modulation and tapered serifs give the title a more fantasy-specific silhouette than a default Roman display face, while its lighter weight stays closer to the official package mark than the rejected ExtraBold exploration.

### Title-field cleanup edit

- Mode: built-in ImageGen, `precise-object-edit`, used only because the v1 title was painted across translucent veil, storm mist, and energy detail that could not be cleanly recovered through deterministic masking alone.
- Edit target: preserved v1 base, with the official Eternal Bargain and Mind Seize packaging plus official Commander 2013 footer art used as visual identity references.
- Production direction: remove only the readable v1 `COMMANDER 2013` title; reconstruct the covered region from adjacent storm mist, sweeping black-violet veil, distant Gothic atmosphere, Oloro's cool waterfall haze, and Jeleva's red-violet energy; preserve both leads, their faces, hands, silhouettes, environment, 6:7 framing, and lower-right seal zone; add no new text, plaque, banner, logo, card, frame, symbol, or watermark.
- Unmodified selected cleanup output: `imagegen_commander_2013_owned_decks_cover_v3_title_free_raw.png`, 1162 x 1353 pixels, RGB, 72 DPI. The built-in tool originally saved the same output at `/Users/bishophall/.codex/generated_images/01a03db0-5ed7-7cb0-8452-17cbd98d67a2/exec-472ccca3-cc93-464a-94a7-3e7093e407e3.png`; the project copy is the retained provenance source.
- The complete production brief is retained at `../prompts/commander_2013_owned_decks_cover_v3_atmospheric_wordmark.md`.

### New retained production assets

| Local file | Source / derivation | Dimensions or format | Role |
| --- | --- | ---: | --- |
| `official_commander_wordmark_crop_eternal_bargain.jpg` | Inspection crop derived from the retained official Wizards Eternal Bargain packaging image | 320 x 120 px | Research-only evidence for the open, restrained 2013 retail wordmark; not present in the final pixels. |
| `preview_official_commander_wordmark_crop_5x.jpg` | 5x inspection enlargement of the crop above | 1600 x 600 px | Visual audit preview only. |
| `imagegen_commander_2013_owned_decks_cover_v3_title_free_raw.png` | Unmodified built-in ImageGen cleanup output | 1162 x 1353 px | Accepted title-free Oloro/Jeleva art source. |
| `AlegreyaSC-Medium.ttf` | [Google Fonts Alegreya SC repository](https://raw.githubusercontent.com/google/fonts/main/ofl/alegreyasc/AlegreyaSC-Medium.ttf) | TrueType, Medium 500 | Exact deterministic title face. Copyright 2011 The Alegreya Project Authors; SIL Open Font License. |
| `OFL_AlegreyaSC.txt` | [Google Fonts Alegreya SC OFL](https://raw.githubusercontent.com/google/fonts/main/ofl/alegreyasc/OFL.txt) | UTF-8 text | Retained license for the production font. |
| `build_commander_2013_atmospheric_wordmark.swift` | Project-local deterministic build | Swift / Core Graphics / Core Text | Resamples the clean art to 1800 x 2100, draws the exact open wordmark, and writes 600-DPI PNG metadata. |
| `preview_v3_atmospheric_wordmark_drawer_300x350.png` | Downscaled from the v3 unnumbered final with macOS `sips` | 300 x 350 px | Drawer-scale title QA. |
| `preview_v3_atmospheric_wordmark_deck_count_2_drawer_300x350.png` | Downscaled from the v3 counted final with macOS `sips` | 300 x 350 px | Drawer-scale title and seal QA. |

### Exact deterministic build

```text
swift images/commander_2013/src/build_commander_2013_atmospheric_wordmark.swift \
  images/commander_2013/src/imagegen_commander_2013_owned_decks_cover_v3_title_free_raw.png \
  images/commander_2013/src/AlegreyaSC-Medium.ttf \
  images/commander_2013/commander_2013_eternal_bargain_mind_seize_premium_cover_v3_atmospheric_wordmark.png

swift scripts/apply_deck_count.swift \
  images/commander_2013/commander_2013_eternal_bargain_mind_seize_premium_cover_v3_atmospheric_wordmark.png \
  images/commander_2013/commander_2013_eternal_bargain_mind_seize_premium_cover_v3_atmospheric_wordmark_deck_count_2.png \
  2:1800
```

### V3 transformations and finished assets

1. `commander_2013_eternal_bargain_mind_seize_premium_cover_v3_atmospheric_wordmark.png`
   - New non-destructive sibling; every v1 and v2 file remains preserved.
   - The accepted title-free cleanup source is resampled directly to exact 1800 x 2100 pixels. The source ratio is 0.85883 versus the target 6:7 ratio of 0.85714, an approximately 0.20% horizontal aspect normalization with no crop.
   - The exact text is an open two-line lockup: `COMMANDER` above `2013`, both centered in the upper-middle mist. `COMMANDER` is Alegreya SC Medium at a nominal 270 points with 7-point tracking and a maximum width of 1,450 pixels. `2013` is a nominal 130 points with 20-point tracking and a maximum width of 410 pixels.
   - Letter faces use a quiet pale-ivory-to-silver gradient, a fine graphite edge, and soft atmospheric shadow rather than a bevel or slab. Faint cyan and crimson hairlines flank only the year, connecting the Esper and Grixis halves without enclosing the title.
   - Finished unnumbered v3; exact 1800 x 2100 px, RGB PNG, 600 x 600 DPI.
2. `commander_2013_eternal_bargain_mind_seize_premium_cover_v3_atmospheric_wordmark_deck_count_2.png`
   - Created only from the v3 base with `scripts/apply_deck_count.swift` and marker specification `2:1800`.
   - Standard 210-pixel dark circular seal with exact 70-pixel right and bottom insets.
   - Finished counted v3 sibling; exact 1800 x 2100 px, RGB PNG, 600 x 600 DPI.

### V3 visual and deterministic QA

- Both v3 finals were inspected at full resolution and at 300 x 350 drawer scale on 2026-08-26. `COMMANDER 2013` is exact, appears once, and remains immediately readable at drawer size; the smaller year does not collapse into the two energy hairlines.
- The title stays within print-safe margins and occupies the natural veil/mist gap. It does not obscure Jeleva's face or hands, Oloro's face, torso, or hands, and it is integrated without a hard-edged background, cartouche, frame, or banner.
- The counted preview confirms that the standard `2` seal covers only expendable lower-right ground and does not intersect the title or either lead.
- `sips` reports exact 1800 x 2100 dimensions and 600 x 600 DPI for both finals. A second complete typography build and seal pass produced byte-identical SHA-256 values for both targets.

## SHA-256 checksums

```text
1d3f38d99e5b464bb669cbafd87be0b0357cc565f09a3848bc8941b958c1a7f6  official_commander_2013_footer_key_art_wizards.jpg
8ceede58f573af196e2be3c49f367c4c1d244dc3982545d2b10aa55f3c517ecb  official_eternal_bargain_packaging_wizards.jpg
8fedbbb8db6beddb3e7676d59c11d12e0bafaf991ce6372130df201f26d64e71  official_jeleva_nephalias_scourge_wizards.jpg
5f629df103383e3efa0c548fdb0b72172a415f3cea7cf11ef00e05d07ab147c3  official_mind_seize_packaging_wizards.jpg
48fcaeec08df9071c10cd8618f7cbe66507842372b8c89d8ab0a9779e85b3e9f  official_oloro_ageless_ascetic_wizards.jpg
803ca96a20aaef36e59218f9e23651e8bcf7d7e1b79a0369c635feeacce412f1  imagegen_commander_2013_owned_decks_cover_v1_raw.png
a39ade5af5137fe2b8c694b5f12f153b47c1d44ec667d2d19319f544bbbbae37  commander_2013_eternal_bargain_mind_seize_premium_cover_v1.png
8d7d5c6f87153adfcabd745ff13b55aaf963d121145e7ffa22a93509e313497b  commander_2013_eternal_bargain_mind_seize_premium_cover_v1_deck_count_2.png
5347a2e155589ecf667d4b766613c8ee003edde9f83717fd24c09599a4b1ecc0  PirataOne-Regular.ttf
e8ad3f3de5baeff6bac6e711d8c406e0a6b8a61d2944741532d8965d893a2681  OFL_PirataOne.txt
c52052a4b00cb2efb0d520b5d68e83e9d88a965796057075d04e2aa2fc7b1276  build_commander_2013_gothic_wordmark.swift
b3bf65c6e2f945f5020839bde4e96b08783f9b128bc676d76391cd81de957728  preview_v1_drawer_300x350.png
83c06ae7ff06a8c6e6b1a0ec67dd1697a43761614d98eab79890c17a652b242c  preview_v2_gothic_wordmark_drawer_300x350.png
d256c1774a712a749114f2045ae12aa1c899d7c094c2d32760dcf03a5f9c462c  preview_v2_gothic_wordmark_deck_count_2_drawer_300x350.png
7157f5e425533ca31788488554376cff90584ce187f66d8cc40c6cd01ad79452  commander_2013_eternal_bargain_mind_seize_premium_cover_v2_gothic_wordmark.png
09c29787bdc9d265468180b46dfdbf8967f8c9cecefe6a8d15c6388274d0a882  commander_2013_eternal_bargain_mind_seize_premium_cover_v2_gothic_wordmark_deck_count_2.png
a059de94607ba17876120557cd2e6cebe3fafbeba51b76261845d2b126d599b6  official_commander_wordmark_crop_eternal_bargain.jpg
882f5e6b8a312d2cd5cd9a344bfed152f8f7c8bc686d2cc6a33e45a1c82b6018  preview_official_commander_wordmark_crop_5x.jpg
a84decd3043e2aa3a28908fd927a1214355e3ea27429ccfdb17db470712336bd  imagegen_commander_2013_owned_decks_cover_v3_title_free_raw.png
fa896222115cc9a41c0695a3ee6feafbaba97932e9bb6240520b3feeb560ea2c  AlegreyaSC-Medium.ttf
f6f60d5d4cf4f4b1fc4e41353c897a2f5a16e6396c0cd8fa8bdfd2f4586a9a68  OFL_AlegreyaSC.txt
b517f00df844c390d8c0f95ea0d58bb9686a7cc9513c6dfd2ed208b5e6214475  build_commander_2013_atmospheric_wordmark.swift
f3b30f89d13bf1f9326e12f31d9866f25203bee55c7fac1e5b0db67ec2e08f85  preview_v3_atmospheric_wordmark_drawer_300x350.png
e024832cb5e348c6f495688cd572b4e239d3378e8111ca8c34e4891b1568ef36  preview_v3_atmospheric_wordmark_deck_count_2_drawer_300x350.png
1335fe3edbd5d33131e387aaa6e88f223d7c4e7615ca7eb96c25e38c302be9c3  commander_2013_owned_decks_cover_v3_atmospheric_wordmark.md
eaaba4d6822444b82a68578efd97253ee95ea4a457c299199dd7a0301b2619ef  commander_2013_eternal_bargain_mind_seize_premium_cover_v3_atmospheric_wordmark.png
5dc9863b56c40a7096e19f466ab102cd811c10b0a028558a6ec20f093da2f785  commander_2013_eternal_bargain_mind_seize_premium_cover_v3_atmospheric_wordmark_deck_count_2.png
```
