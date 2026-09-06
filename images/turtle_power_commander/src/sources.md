# Turtle Power! Commander — sources and production record

Produced 2026-08-31. This drawer represents the complete **Turtle Power!** Commander product: **one owned deck out of one released deck**, so its count marker is `1`.

## Product and count verification

- Wizards Commander decklist: <https://magic.wizards.com/en/news/announcements/teenage-mutant-ninja-turtles-commander-decklist>
  - Published February 18, 2026.
  - States that Wizards is releasing a single brand-new Commander deck named **Turtle Power!** and that each product contains one ready-to-play 100-card Commander deck.
- Official product page: <https://magic.wizards.com/en/products/teenage-mutant-ninja-turtles>
  - Describes the release as “One Commander Deck” and identifies the Commander product as Turtle Power!.
- Wizards collecting guide: <https://magic.wizards.com/en/news/feature/collecting-teenage-mutant-ninja-turtles>
  - Confirms the deck name, product contents, set code `TMC`, and the March 6, 2026 release.
- Wizards Play Network product and marketing-material hub: <https://wpn.wizards.com/en/products/teenage-mutant-ninja-turtles>

## Retained official inputs

| File | Official source and role | Dimensions | SHA-256 |
| --- | --- | ---: | --- |
| `official_wpn_tmt_key_art_social_en.zip` | Untouched WPN key-art social archive: <https://media.wizards.com/2025/wpn/marketing_materials/tmt/tmt_sma_key_en.zip> | Archive | `0ef0fbca7630f91bef01c634c43e7924dae3f25b92bbc3023d6ed27297b2da32` |
| `TMT_sma_key_1080x1920.jpg` | Selected official portrait social art extracted unchanged from the archive. It contains all four Turtles, the integrated official TMNT wordmark, and dense full-frame city/manhole art. The visible source credit names Ignatius Budi. | 1080 × 1920 | `2c77cc67fd44cb7e34ace2e67a55888ee207db1caa35383d215c0f85018164b4` |
| `TMT_sma_key_1000x1000.jpg` | Official square composition retained for comparison. | 1000 × 1000 | `1a81e9e08095bbfbda0801244a01b97f112ac3dee66c9398c1b5ee86f4114c01` |
| `official_wpn_tmt_art_and_logos_en.zip` | Untouched WPN art-and-logos archive: <https://media.wizards.com/2025/wpn/marketing_materials/tmt/alg_tmt_en.zip> | Archive | `4015ed322d010d592a9ce67e8f1a255b33244a3d1bd897dac16799eb212dbdde` |
| `MTGTMT_EN_MSL_4C.png` | Official transparent MTG/TMNT set lockup retained as an identity reference; not needed in the final because the selected portrait already includes the TMNT wordmark. | 900 × 197 | `a0e9716905ab93d8afcabaca381e4941a36fe929917878c99e3b273be767d0a5` |
| `official_turtle_power_commander_product.webp` | Official Wizards Commander product render from the collecting guide. It verifies the deck-specific title and the four-Turtle product treatment; rejected as a direct face because of its large white product-photo surround. | 1349 × 2000 | `5b89700062c6d5268cff2345eca9988eaa27d652a4c6ff2aa0f226c833271fd6` |

## Deterministic construction

- Finalized brief: `../prompts/turtle_power_commander_official_key_art_adaptation_brief.md`.
- Build script: `build_turtle_power_target.swift`.
- Generation mode: official-art adaptation; no ImageGen call.
- Cropped the official portrait at `x=0, y=640, width=1080, height=1260`, then resampled to exact 1800 × 2100 sRGB at 600 DPI.
- Added restrained upper and lower veils without removing the official artwork.
- Added exact `TURTLE POWER!` title and `COMMANDER DECK` subtitle deterministically with an arcade/comic treatment matched to the product's video-game theme.
- Added the standard `1` seal non-destructively with `scripts/apply_deck_count.swift` and `1:1800`.

## Finished targets

| File | SHA-256 |
| --- | --- |
| `../turtle_power_commander_official_key_art_target_v1_1800x2100.png` | `fe007a3483a299593b470baf329414269764ee63f542c1efcd6df3b03b4abbbe` |
| `../turtle_power_commander_official_key_art_target_v1_deck_count_1_1800x2100.png` | `d0d7d537717d0e2372aaa048c8b976d0cc0ffd159c76fadced2d51825950aa86` |
| `../turtle_power_commander_official_key_art_target_v1_1724x2024_black_margin_1_8in.png` | `915cea81fbeeb4d8936f6a60ccd5ca451e6ddfcbcc29069d10353fd9dfd7eafc` |
| `../turtle_power_commander_official_key_art_target_v1_deck_count_1_1724x2024_black_margin_1_8in.png` | `1c6e2de59c614588eecd2ea8b517b5c8eacfa1d1b4fcfe4db0ee78ac440062ab` |

QA confirmed exact dimensions and DPI, exact title spelling, immediate 300 × 350 drawer-scale legibility, intact official TMNT identity, four distinct Turtles, no large empty region, and the standard count-seal and black-margin geometry.
