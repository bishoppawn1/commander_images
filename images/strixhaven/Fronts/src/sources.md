# Strixhaven: School of Mages Commander / Commander 2021 sources and production record

## Identification and grouping decision

The dominant drawer-identification text is the official integrated **`STRIXHAVEN` / `SCHOOL OF MAGES`** logo. Wizards' product overview states that the major Commander release of 2021 is tied to Strixhaven and consists of five distinct decks, one for each college. The face therefore uses the associated set's official key-art identity instead of forcing a five-face-commander montage.

The inventory and official Commander (2021 Edition) decklists agree that the collection owns all five decks:

- Prismari Performance
- Silverquill Statement
- Quantum Quandrix
- Lorehold Legacies
- Witherbloom Witchcraft

The standalone Strixhaven drawer holds and displays all five owned decks and therefore uses a `5` marker. The retired Commander Legends / Ikoria / Strixhaven composite is no longer part of the drawer allocation.

Authoritative product and deck sources:

- Wizards product overview tying Commander 2021 to Strixhaven and confirming five decks: https://magic.wizards.com/en/news/feature/strixhaven-school-mages-product-overview-2021-03-25
- Wizards Commander (2021 Edition) decklists naming the five decks and confirming the April 23 release alongside Strixhaven: https://magic.wizards.com/en/news/announcements/commander-2021-edition-decklists-2021-04-05
- Wizards reveal article for the official STX key art, logo, set symbol, and campus map: https://magic.wizards.com/en/news/announcements/strixhaven-school-of-mages-previews-and-more-2021-magic-release-dates-2021-03-18
- Wizards Play Network product page: https://wpn.wizards.com/en/products/strixhaven-school-of-mages
- Wizards Play Network marketing article showing the exclusive branded Strixhaven poster and linking the official online-store archive: https://wpn.wizards.com/en/news/new-strixhaven-school-mages-marketing-materials-available-now

## Retained official source files

The cited Wizards pages label the primary image as `STX Key Art` and identify Rowan and Will visually, but they do not print an artist credit. No unsupported artist attribution is inferred here. The other retained official assets likewise carry no visible artist attribution on their source pages.

| File | Direct source | Original dimensions | Role / notes |
| --- | --- | ---: | --- |
| `strixhaven_official_key_art.jpg` | https://media.wizards.com/2021/images/daily/UysdehDi8d.jpg | 850 × 500 px | Primary ImageGen edit target. Official Rowan-and-Will Strixhaven key art used on the reveal page and product packaging. Preserved untouched. SHA-256: `eef39caa0912d1d72064ca96b399ae98cd7366d97d458a96eed2fced1cf99413`. |
| `strixhaven_official_set_logo.png` | https://media.wizards.com/2021/images/daily/en_7shDsuudeD.png | 586 × 160 px, RGBA | Official transparent integrated `STRIXHAVEN / SCHOOL OF MAGES` logo. Applied deterministically after generation so the identity wording remains exact. Preserved untouched. SHA-256: `100cb214f9429a1607a59a135de55f456c48f1994634a1da0f787edb2ed911c1`. |
| `strixhaven_official_set_symbol.png` | https://media.wizards.com/2021/images/daily/en_hhDh737DsS.png | 128 × 135 px, RGBA | Official expansion-symbol reference. Retained for provenance; not composited because the integrated logo already supplies complete identity. SHA-256: `f6d6ff2ecb8127b7b0ec652db383f9564a8f1b6be06c8f3e9401218940f9dc8d`. |
| `strixhaven_official_campus_map.jpg` | https://media.wizards.com/2021/images/daily/GnrHtHofZ7.jpg | 850 × 1020 px | Supporting university-architecture and five-college setting reference for ImageGen. Its pale infographic field was not used directly in the target. Preserved untouched. SHA-256: `0fe4aa6a3feb11aad6391c6c7b82ca87d8ad62d63c86e4532808b47e5a0f819d`. |
| `stx_wpn_poster_preview.jpg` | https://media.wizards.com/2021/wpn/w14/stx_wpn_poster.jpg | 715 × 367 px | Official WPN article image containing the exclusive branded vertical poster inside a webpage-style white surround. Used only as a dense vertical-composition reference; the low-resolution white surround made it unsuitable as a direct target. Preserved untouched. SHA-256: `578e2fa81515b6c1b300a532e670dbbda6285c6ee5861d6d03019ba8cc1b1c69`. |
| `commander_2021_official_five_deck_product_lineup.png` | https://media.wizards.com/2021/images/daily/en_AJahyDseeD.png | 548 × 432 px, RGBA | Official Wizards five-deck lineup from the product overview. Product-identity/count reference only; no boxes or product photography were composited. Preserved untouched. SHA-256: `368f3677fcaf6ca455842b6da5c77a69c4d7dc4b23a535234f8c46ab1a18224f`. |
| `stx_onlinestore_assets_en.zip` | https://media.wizards.com/2021/wpn/marketing_materials/stx/stx_onlinestore_assets_en.zip | 41,061,610 bytes | Untouched official WPN online-store archive linked by the marketing article. Contains the English retail imagery and 2000 × 2000 carousel shots for the five college Commander products. Retained as a provenance master; not used as a generative input or final target. SHA-256: `2b9c33634b98bce41d1b7d6fa6e4adcc59d094dd0b7985e979138ab03f7fe39c`. |

## ImageGen generation record

| File | Mode | Dimensions | Role / notes |
| --- | --- | ---: | --- |
| `strixhaven_commander_imagegen_portrait_raw.png` | Built-in ImageGen edit/outpainting with three local reference paths | 1163 × 1353 px, RGB | Unmodified generated output. Image 1 was the official key art edit target; Image 2 was the WPN poster composition reference; Image 3 was the campus-setting reference. The generation extended the official scene vertically while retaining Rowan, Will, their red/blue magic, the owl, and the library identity. SHA-256: `7b4896ae4dfa75d3f256f01da5695d5e533809142380632ed780b0c73715a599`. |

Exact built-in prompt, verbatim:

```text
Use case: precise-object-edit
Asset type: print-ready 3 by 3.5 inch portrait MTG drawer-identification face-card artwork
Primary request: Extend Image 1, the official Strixhaven key art, into a seamless full-bleed 6:7 portrait fantasy illustration. Preserve Rowan Kenrith and Will Kenrith as the only two principal figures and keep their recognizable faces, poses, costumes, and red-versus-blue spellcasting interaction. Expand the university library vertically above and below them with tall dark bookcases, Gothic academy arches, hanging amber lamps, loose parchment, and subtle arcane filigree that naturally continues the source image. Image 2 is an official WPN poster used only for its dense vertical dark-academia composition. Image 3 is a campus-setting reference used only for Strixhaven architectural language.
Scene/backdrop: a grand, vertically soaring Strixhaven library interior at night, filled edge to edge with carved dark wood, books, warm lamps, scrolls, magical pages, and deep architectural detail.
Subject: Rowan on the lower-left/front casting vivid red-orange lightning; Will on the lower-right/back shaping a cool blue water spell; the owl flying above them. Preserve the original hierarchy and interaction rather than adding more students or commanders.
Style/medium: polished high-detail Magic fantasy key art; painterly realism; crisp faces, hands, fabric, book edges, owl feathers, sparks, and water; faithful to the official source's finish and palette.
Composition/framing: exact portrait intent, 6:7 crop-safe. Keep both figures comfortably within the central and lower-middle frame. Reserve a visually active but relatively calm dark-architectural band across the upper quarter for a later official title overlay. The upper band must still contain meaningful shelves, arches, lamps, particles, and texture—never blank space. Keep the lower-right corner noncritical enough for a later 210-pixel count seal.
Lighting/mood: warm amber library light crossed by intense red lightning and luminous blue water; scholarly, theatrical, prestigious, magical.
Color palette: near-black walnut, parchment ivory, antique gold, ruby red, electric orange, sapphire blue, and cool cyan.
Constraints: change only the framing and surrounding environment needed for the portrait extension; preserve the two principal figures and their spell effects; edge-to-edge image information; no white or featureless background; no border; no frame; no product packaging; no five-commander or five-student montage; no added people; no cropped faces or hands; no repeated subjects; no logos; no letters; no words; no watermark. Leave all typography for the deterministic production pass.
Avoid: blank sky, large empty walls, washed-out corners, flat infographic styling, tiny distant characters, unreadable pseudo-text, extra owls, extra hands, malformed faces, duplicated books, or a decorative card border.
```

The finalized prompt and production brief is also retained at `../prompts/strixhaven_commander_official_key_art_portrait_extension_brief.md`.

## Finished assets and transformations

| File | Source / mode | Transformations and usage notes |
| --- | --- | --- |
| `../strixhaven_commander_official_key_art_target_v2_1800x2100.png` | Deterministic print adaptation from `strixhaven_commander_imagegen_portrait_raw.png`, built with `build_strixhaven_commander_target.swift` | Center-cropped approximately two total source pixels from the nearly exact 6:7 raw generation, then resampled to exact 1800 × 2100 px in sRGB. Added a restrained transparent dark gradient only over the upper architectural zone. Applied the untouched official transparent `STRIXHAVEN / SCHOOL OF MAGES` logo at 1600 px wide, centered with exactly 100 px left/right clearance and approximately 112 px top clearance; its integrated text is the dominant identification element. Wrote 600-DPI PNG metadata. SHA-256: `f754bdf4126516116585c696d1ba766fad1b02ea69e8be6599cbc530987cb530`. |
| `../strixhaven_commander_official_key_art_target_v2_deck_count_5_1800x2100.png` | Non-destructive counted sibling derived from the unnumbered v2 base | Added one approved `5` seal with `scripts/apply_deck_count.swift` using `5:1800`: 210-pixel diameter, equal 70-pixel right/bottom outer-edge insets, dark circular field, antique-gold rim, and pale-ivory Copperplate Bold numeral. The marker overlaps only noncritical lower-right books/architecture and does not obscure the title, faces, hands, or central magic. This is the canonical standalone-drawer counted final for all five owned decks. SHA-256: `9286b05412c6fd41b7f100b54ae59b8f5eea55b3836868288616d4946180945c`. |

The supporting deterministic build script is retained as `build_strixhaven_commander_target.swift`. The unnumbered base remains preserved and is never overwritten by the counted pass.

The prior four-count sibling is retained only as superseded production evidence at `superseded_counted_targets/strixhaven_commander_official_key_art_target_v2_deck_count_4_1800x2100.png`; its bytes and SHA-256 (`57c9113b5b37e57d3f5896ea37551329ea155279dbdabf27ff64c4ab1a1000f4`) are unchanged. The older 300 × 350 count-4 drawer-scale QA render remains historical evidence only.

## Verification record

- Collection ownership and official-decklist count: five owned decks out of five. All five are represented by the standalone counted sibling, which uses `5`.
- Both finished files were visually inspected at full source resolution after rendering.
- Exact dominant title reads `STRIXHAVEN` with the integrated subtitle `SCHOOL OF MAGES`; no duplicate, malformed, pseudo-, or additional title text remains.
- Rowan, Will, the owl, the red spell, and the blue spell remain distinct and recognizable; there are no added people or duplicated subjects.
- Useful library architecture, books, lamps, parchment, and magic fill all four edges; there are no blank, white, featureless, or empty areas.
- Both finished PNGs verify at exactly 1800 × 2100 pixels and 600 × 600 DPI.
- The `5` count seal was visually inspected at full resolution. It remains immediately legible in the actual lower-right corner with exact 70-pixel right and bottom insets and covers no critical focal detail or identification text.
- The set root contains only finished full-bleed targets, their active black-margin print siblings, `prompts/`, and `src/`.
