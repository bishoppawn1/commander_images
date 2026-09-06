# Warhammer 40,000 Commander drawer-face sources

## Product verification

- [Official Wizards product page](https://magic.wizards.com/en/products/warhammer-40000-commander) — canonical product identity and the four deck groups: Forces of the Imperium, Necron Dynasties, Tyranid Swarm, and The Ruinous Powers.
- [Official Wizards decklists](https://magic.wizards.com/en/news/announcements/warhammer-40000-commander-decklists) — Wizards states that the release contains four Commander decks and identifies their decklists and display commanders. Published September 17, 2022.
- [Official Wizards card image gallery](https://magic.wizards.com/en/news/card-image-gallery/warhammer-40000-commander-decks) — official card-image source and release reference.
- [Official Warhammer Community crossover article](https://www.warhammer-community.com/en-gb/articles/CthwMvOq/prepare-for-a-momentous-warhammer-crossover-with-five-exclusive-magic-the-gathering-card-reveals/) — Games Workshop states that the product has four 100-card Commander decks and names the four represented factions/leads. Published September 12, 2022.

The collection inventory records 4 of 4 decks owned, so the standalone drawer face uses one `4` marker.

## Downloaded official references

All files below are untouched downloads retained in `src/`.

| Local file | Official source URL | Original pixels | Attribution / role |
| --- | --- | ---: | --- |
| `official_wizards_warhammer_40000_logo.png` | [Wizards transparent Magic x Universes Beyond x Warhammer 40,000 logo](https://images.ctfassets.net/s5n2t79q9icq/3FDVElIwCIFGelNsIolb23/0ca1141800c4b725aac112735c86870f/ub_40k_test_en3.png) | 660 x 300 | Official product-page logo. Artist/designer not credited on the page. Exact `WARHAMMER 40,000` plate is cropped only in the deterministic final compositor; it is never regenerated. |
| `official_wizards_mobile_header_575x700.jpg` | [Wizards mobile product hero](https://images.ctfassets.net/s5n2t79q9icq/399IUYeKP6NSorx62Eqtto/da935669a4aaea6c91a35adc902e6e38/Header_575x700.jpg) | 575 x 700 | Official full-bleed vertical product art and atmosphere reference. Artist not credited on the product page. Contains tiny legal copy in the raw download only; no legal copy is carried into the finished face. |
| `official_wizards_imperium_highlight.png` | [Wizards Inquisitor Greyfax highlight](https://images.ctfassets.net/s5n2t79q9icq/1lg3XKYDWjzquh9ki9gVqz/c7424b529f2c0bdac95341cd915d5528/7JkDavgG_EN_03.png) | 528 x 432 | Official commander-card identity reference for Forces of the Imperium. Card art credited in the asset to Lie Setiawan. |
| `official_wizards_necron_highlight.png` | [Wizards Szarekh highlight](https://images.ctfassets.net/s5n2t79q9icq/72CyYWfZaZtpLCHOX93qow/1f8eff0f050185883f5e67f6f769f940/mOcBVic8_EN_02.png) | 528 x 432 | Official commander-card identity reference for Necron Dynasties. Card art credited in the asset to Anton Solovianchyk. |
| `official_wizards_tyranid_highlight.png` | [Wizards Swarmlord highlight](https://images.ctfassets.net/s5n2t79q9icq/7CoYnnkAu9la16Ys9yJFPm/d332adbc6eeee55fd01efb4dcd2b70cb/VEBTEssL_EN_04.png) | 528 x 432 | Official commander-card identity reference for Tyranid Swarm. Card art credited in the asset to Mathias Kollros. |
| `official_wizards_ruinous_highlight.png` | [Wizards Abaddon highlight](https://images.ctfassets.net/s5n2t79q9icq/7yFaAwuMaenPUtK1yx2y0S/988d1c4c660b945be02ce35e335042db/aaB0Jazk_EN_01.png) | 528 x 432 | Official commander-card identity reference for The Ruinous Powers. Card art credited in the asset to Igor Kieryluk. |
| `official_warhammer_community_four_deck_share.jpg` | [Warhammer Community Magic crossover social image](https://assets.warhammer-community.com/articles/9d307c28-cbfb-44b2-b376-76c0767d6967/wfktm8yfzr2nixfc.jpg) | 1000 x 500 | Official branded social reference confirming the licensed visual identity. It was not used directly because its wide white field and translucent copy bar do not satisfy the full-bleed portrait requirement. Artist not credited on the article page. |

## Image generation

Generation mode: default built-in ImageGen tool with official reference images. The model produced the artwork layer only; all exact brand typography was applied afterward from the official Wizards logo asset.

### Raw v1

- File: `imagegen_four_faction_raw_v1.png`
- Original generated pixels: 1163 x 1352 at 72 DPI.
- Inputs: the four official Wizards commander highlight images plus the official Wizards mobile product hero.
- Disposition: retained as an unmodified generator output. The four-faction composition was strong, but Greyfax and Szarekh entered the intended title-safe area, so it was not promoted to a target.

Exact prompt:

```text
Use case: stylized-concept
Asset type: print-ready drawer-face artwork layer, portrait 6:7 intent
Primary request: Create a premium, cinematic, unified grimdark science-fantasy battle illustration representing the four Magic x Warhammer 40,000 Commander decks. This is an artwork-only layer: include NO TEXT, NO LOGOS, NO LETTERS, NO WATERMARKS.
Input images: Images 1–4 are official Wizards character identity references for Inquisitor Greyfax, Szarekh the Silent King, The Swarmlord, and Abaddon the Despoiler. Image 5 is the official Wizards set-level atmosphere and finish reference.
Scene/backdrop: immense war-torn gothic industrial battlefield under a fractured smoky sky; ruined cathedral machinery, distant armies, embers, energy arcs, ash, green necrodermis glow, violet-red Warp haze, and organic Tyranid silhouettes; useful visual detail continues to every edge.
Subject: Exactly four distinct lead characters, each appearing exactly once: Inquisitor Greyfax in blue-black Imperial armor; skeletal gold-and-green Szarekh; purple multi-limbed Swarmlord; black-and-gold Abaddon. Preserve their official silhouettes, armor language, weapons, and faction colors from Images 1–4. Balanced dynamic diamond ensemble in the lower three-quarters; faces and weapons do not merge or repeat.
Style/medium: museum-quality painted trading-card key art; highly detailed grimdark science-fantasy realism; coherent single illustration, never four panels or a collage; tactile armor, bone, chitin, scorched metal, banners, smoke, sparks, and energy.
Composition/framing: vertical portrait, full bleed. Strong central depth and edge-to-edge action. Across the upper 24 percent, maintain a richly textured but lower-contrast dark steel-and-smoke zone for later title compositing; this zone must not be blank or featureless. Keep all faces and signature weapons out of that upper title zone. Keep critical focal details out of the extreme lower-right corner reserved for a small count seal.
Lighting/mood: apocalyptic, operatic, serious; orange fire and blue-white lightning balanced by toxic emerald and controlled magenta; crisp rim light on every lead; deep blacks retain detail.
Color palette: oxidized black steel, antique brass, deep cobalt, bone ivory, ember orange, electric cyan, toxic emerald, controlled Warp magenta.
Constraints: exactly four lead characters, one per reference; immediate Warhammer 40,000 identity; no card frames; no packaging; no hard quadrant seams; no blank border; no large flat fog fields; no extra figures dominating the leads; NO TEXT OR LOGOS OF ANY KIND.
Avoid: duplicated figures, duplicated limbs, merged subjects, generic medieval fantasy, modern military photo styling, cute/comic styling, distorted heraldry, invented marks, pseudo-lettering, white backgrounds, signatures, and tiny legal copy.
```

### Raw v2 — selected artwork layer

- File: `imagegen_four_faction_raw_v2.png`
- Original generated pixels: 1164 x 1351 at 72 DPI.
- Input: Raw v1 from the immediately preceding built-in ImageGen result.
- Disposition: retained unmodified and selected for the final target after the targeted vertical-staging correction.

Exact correction prompt:

```text
Precise composition edit of the just-generated four-faction Warhammer 40,000 artwork. Preserve the four commanders' identities, costumes, faces, weapons, lighting, colors, battlefield, painting finish, and coherent single-scene style. Change only the vertical staging: extend the dark, detailed gothic fleet-and-storm sky so the entire upper 27 percent of the portrait contains richly textured but lower-contrast environment only; move/scale the complete four-character ensemble downward so every head, face, weapon, banner, silhouette, and energy effect begins below that upper 27-percent title-safe zone. Keep exactly four featured commanders, each appearing once. Keep edge-to-edge visual detail and preserve a less critical extreme lower-right corner for a small count seal. NO TEXT, NO LOGOS, NO LETTERS, NO PSEUDO-TEXT, NO WATERMARK, no card frames, no panel seams, no empty or featureless area.
```

## Final transformations and targets

`build_warhammer_40000_commander_target.swift` is the deterministic production compositor retained in `src/`.

- Raw v2 was center-cropped from 1164 x 1351 to approximately 1158 x 1351, removing under one percent of width, then resampled to exact 1800 x 2100 pixels.
- The busy upper environment was darkened with a transparent vertical gradient only; fleet, lightning, architecture, and surface detail remain visible.
- The exact official `WARHAMMER 40,000` metal plate was cropped from pixel rectangle x=78, y=170, width=504, height=130 of the untouched 660 x 300 Wizards logo asset and composited at 1650 pixels wide with a 55-pixel top inset.
- `COMMANDER` was added once in horizontal uppercase Copperplate Bold, stretched to a 1480-pixel visual width, with an ivory/steel fill, black outline, and shadow for drawer-distance contrast.
- No other text, legal copy, watermark, signature, card frame, or invented logo was added.
- PNG metadata was written at 600 DPI.

Finished targets:

- `../warhammer_40000_commander_four_faction_v2_1800x2100.png` — unnumbered base, exact 1800 x 2100, 600 DPI.
- `../warhammer_40000_commander_four_faction_v2_deck_count_4_1800x2100.png` — counted sibling created non-destructively by running `scripts/apply_deck_count.swift` with `4:1800`. The standard 210-pixel seal has equal 70-pixel right and bottom insets.

Visual inspection confirmed exact title spelling, immediate product readability, four distinct leads appearing once each, full-bleed detail, no accidental or invented text, no large empty field, unobstructed faces, and safe count-marker placement.
