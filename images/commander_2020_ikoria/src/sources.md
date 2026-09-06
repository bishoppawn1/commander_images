# Commander 2020 / Ikoria sources and production record

## Identification decision

The exact dominant drawer-identification text is **`COMMANDER 2020`**. This wording unmistakably identifies the owned Commander release rather than the Ikoria booster set. The official integrated **`IKORIA: LAIR OF BEHEMOTHS`** logo remains visible near the bottom so the face also communicates the release's associated-set identity at a glance.

The face uses official Ikoria key art rather than a five-commander montage. Wizards' own product and preview material identifies Commander (2020 Edition), product code C20, as a five-deck release aligned with Ikoria; the official key art therefore provides the intended plane and product-era identity without forcing five small character portraits into a drawer-viewing composition.

The standalone drawer represents all five owned Commander 2020 / Ikoria decks and therefore displays a `5` seal. The retired Commander Legends / Ikoria / Strixhaven composite is no longer part of the drawer allocation.

## Retained source files

| File | Source | Artist / description | Original dimensions | Role / notes |
| --- | --- | --- | --- | --- |
| `ikoria_official_key_art_poster_en.pdf` | https://media.wizards.com/2020/wpn/marketing_materials/iko/iko_lgp_key_en.pdf | Taylor Ingvarsson; official English Wizards Play Network Ikoria key-art poster. Artist credit is printed in the source's lower-left copyright line. | One page; 2610 × 1746 pt page box | Untouched official provenance master. Landscape artwork includes the central behemoth and hunter, crystalline terrain, the Magic logo at upper left, and the integrated Ikoria logo at bottom center. |
| `ikoria_official_key_art_poster_en_page1.png` | Rasterized directly from the retained official PDF above with macOS `sips`; source URL is the same official WPN PDF | Taylor Ingvarsson; unmodified page-one rasterization of the official key-art poster | 2610 × 1746 px | Primary edit target. No generative alteration was applied. Retained in `src/`; only the cropped, titled print target is stored in the set root. |
| `commander_2020_ruthless_regiment_product_reference.jpg` | https://images.ctfassets.net/0piqveu8x9oj/6C7MXegmrCdMwL5ijAwgog/1a388ccea93c993ca35e2366840a20cb/MTGIKO_EN_CmndrOtrBx_01_02_1586881391.jpg | Official Wizards Play Network Commander 2020 product image; Ruthless Regiment packaging | 640 × 480 px | Product-identity and palette reference only. Its large white photographic background made it unsuitable as a final target. It was not composited into the face. |

Official WPN product page containing the Commander 2020 product entry and stating that the five decks align with Ikoria: https://wpn.wizards.com/en/products/ikoria-lair-of-behemoths

Official Wizards overview confirming Commander (2020 Edition) is aligned with Ikoria and contains five decks: https://magic.wizards.com/en/news/announcements/big-things-are-coming-commander-2020-2019-10-30

Official Wizards design preview confirming five Ikoria Commander decks and the IKO/C20 connection: https://magic.wizards.com/en/news/card-preview/ikoria-commander-2020-04-03

Official Wizards deck-list sources for the five owned decks:

- Enhanced Evolution: https://magic.wizards.com/en/news/announcements/enhanced-evolution-2020-04-06
- Timeless Wisdom: https://magic.wizards.com/en/news/announcements/timeless-wisdom-2020-04-06
- Ruthless Regiment: https://magic.wizards.com/en/news/announcements/ruthless-regiment-2020-04-06
- Arcane Maelstrom: https://magic.wizards.com/en/news/announcements/arcane-maelstrom-2020-04-06
- Symbiotic Swarm: https://magic.wizards.com/en/news/announcements/symbiotic-swarm-2020-04-06

## Finished assets and transformations

| File | Source / mode | Transformations and usage notes |
| --- | --- | --- |
| `../commander_2020_ikoria_official_key_art_target_v2_1800x2100.png` | Direct, non-generative official-art adaptation from `ikoria_official_key_art_poster_en_page1.png` | Cropped the 2610 × 1746 source at `x=650, y=0, width=1496, height=1746` to exclude the source's upper-left Magic wordmark cleanly while retaining the behemoth, hunter, crystals, and complete Ikoria logo. Resampled to exact 1800 × 2100 px (6:7) in sRGB. Added a translucent dark top gradient, a thin antique-gold rule, and exact `COMMANDER 2020` Copperplate Bold title centered across approximately 1582 px of glyph width with roughly 109 px left/right clearance. Written with 600-DPI PNG metadata. No ImageGen was used. SHA-256: `bd00e76a636a8df4f19b5d11c17a193c4c2f46500222436681910fec641bcf10`. |
| `../commander_2020_ikoria_official_key_art_target_v2_deck_count_5_1800x2100.png` | Non-destructive counted sibling derived from the unnumbered v2 base | Added one approved `5` seal with `scripts/apply_deck_count.swift` using argument `5:1800`: 210-pixel diameter, equal 70-pixel right/bottom outer-edge insets, dark circular field, antique-gold rim, and pale-ivory Copperplate Bold numeral. The marker overlaps only noncritical lower-right crystal/ground detail and does not obscure either title. SHA-256: `c224c5f877aab0dffb94aa8ddac124a5f695ebe672186c034733c182597da0e1`. |
| `superseded_counted_targets/commander_2020_ikoria_official_key_art_target_v2_deck_count_4_1800x2100.png` | Superseded counted target retained as production evidence | Former residual `4`-seal target from the retired mixed-drawer allocation. Preserved byte-for-byte under `src/superseded_counted_targets/`; SHA-256: `ae01858e5c7a75649de699f4109f8a0e88cf0f4b1216f5332580341e8771435a`. |
| `commander_2020_ikoria_official_key_art_target_v2_deck_count_4_drawer_preview_300x350.png` | Drawer-scale QA evidence derived from the counted final | Exact 300 × 350 downscale used for visual inspection of title and numeral legibility at drawer scale. SHA-256: `384461c68f3f77e6fab0abad791a2dafc447ad6d36865aa88b7635e83195fbd3`. |

The finalized adaptation brief is retained at `../prompts/commander_2020_ikoria_official_key_art_adaptation_brief.md`.

## Verification record

- Collection ownership is five decks out of five. The standalone drawer contains all five and its counted sibling uses `5`.
- Both finished files visually inspected at full resolution after rendering.
- Exact dominant title reads `COMMANDER 2020`; no stray, malformed, or additional title lettering remains.
- Official `IKORIA: LAIR OF BEHEMOTHS` logo is complete and unobstructed.
- Central behemoth and hunter remain recognizable; no subjects were generated or duplicated.
- Full edge-to-edge artwork and texture occupy the entire 6:7 canvas; no blank or white areas.
- Both finished PNGs verified at exactly 1800 × 2100 pixels and 600 × 600 DPI.
- Count seal visually inspected at full resolution and drawer scale in the actual lower-right corner with equal 70-pixel insets; the `5` remains immediately legible and does not cover critical focal detail or identification text.
- A second independent run of `scripts/apply_deck_count.swift` with marker specification `5:1800` reproduced the counted final byte-for-byte with the same SHA-256.
