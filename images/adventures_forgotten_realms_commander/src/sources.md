# Adventures in the Forgotten Realms Commander sources and production record

## Identification and source-selection decision

The exact dominant drawer-identification text is **`ADVENTURES IN THE FORGOTTEN REALMS`**, stacked as `ADVENTURES IN THE` / `FORGOTTEN REALMS` for immediate drawer readability. This is the associated Magic set's established name and cleanly identifies the four-deck Adventures in the Forgotten Realms Commander release without requiring a four-face-commander montage.

Official Wizards sources establish the release grouping and deck count:

- The official Wizards Commander decklists state that Adventures in the Forgotten Realms includes four Commander decks and list **Aura of Courage**, **Draconic Rage**, **Dungeons of Death**, and **Planar Portal**: https://magic.wizards.com/en/news/announcements/adventures-forgotten-realms-commander-decklists-2021-07-09
- The official Wizards product overview states that all four ready-to-play Commander decks are part of Adventures in the Forgotten Realms: https://magic.wizards.com/en/news/feature/adventures-forgotten-realms-product-overview-2021-06-29
- The official WPN first-look/product article lists **Draconic Rage**, **Aura of Courage**, **Dungeons of Death**, and **Planar Portal** under Commander Decks: https://wpn.wizards.com/en/news/adventures-forgotten-realms-everything-you-need-know
- The official WPN product page identifies the set and provides the Commander product image plus its marketing-materials entry: https://wpn.wizards.com/en/products/adventures-in-the-forgotten-realms
- The official WPN marketing-kit article confirms a commissioned Adventures in the Forgotten Realms poster was distributed to stores: https://wpn.wizards.com/en/news/whats-new-your-adventures-forgotten-realms-kit

The collection inventory supplies the same complete 4/4 group in the requested order: **Draconic Rage**, **Dungeons of Death**, **Aura of Courage**, **Planar Portal**. The counted target therefore uses one `4` seal.

The selected visual is page 1 of Wizards Play Network's official English 11 × 17 key-art poster pack. Its vertical, edge-to-edge party-versus-dragon composition, recognizable Magic wordmark, full-frame detail, and established AFR palette provide stronger set-level identity than a small four-lead montage. No ImageGen was needed.

## Retained source and reference files

| File | Source | Artist / description | Original dimensions | Role / notes |
| --- | --- | --- | --- | --- |
| `afr_official_wpn_key_art_poster_11x17_en.pdf` | https://media.wizards.com/2021/wpn/marketing_materials/afr/afr_flp_11x17_en.pdf | Official English Wizards Play Network Adventures in the Forgotten Realms key-art poster pack; page 1 credit: Magali Villeneuve; page 2 credit: Jason Rainville | 3 pages, each 792 × 1224 pt (11 × 17 inches) | Untouched official provenance master and primary source. The source contains three vertical branded poster variants. |
| `afr_official_wpn_key_art_poster_page-1.png` | Rasterized directly from the retained official WPN PDF above | Magali Villeneuve; official party-versus-dragon poster with the Magic wordmark and integrated AFR branding | 2200 × 3400 px | Unmodified 200-PPI page rasterization and direct pixel source for the finished target. |
| `afr_official_wpn_key_art_poster_page-2.png` | Rasterized directly from the retained official WPN PDF above | Jason Rainville; official adventuring-party-versus-beholder poster | 2200 × 3400 px | Unmodified alternate official vertical-key-art reference. Retained for provenance and comparison; not composited. |
| `afr_official_wpn_key_art_poster_page-3.png` | Rasterized directly from the retained official WPN PDF above | Official five-headed Tiamat key-art poster; the small source footer rasterizes with overlapping credit text, so no uncertain artist attribution is asserted here | 2200 × 3400 px | Unmodified alternate official vertical-key-art reference. Retained for provenance and comparison; not composited. |
| `afr_official_wpn_product_hero.jpg` | https://images.ctfassets.net/0piqveu8x9oj/5jCgmKlAfRehtceTR00WtN/93872cbb0479269c42e7480b888ecc5a/afr_product_v2_1624990039.jpg | Official WPN Adventures in the Forgotten Realms product-line hero; product display uses the selected dragon key art and the dark blue/black/red AFR palette | 1570 × 916 px | Product identity and palette reference only. Its large low-information backdrop makes it unsuitable as a finished drawer face; it was not composited. |
| `afr_commander_product_reference.png` | https://images.ctfassets.net/0piqveu8x9oj/2OHfBxAZ83Ws8MDaaVG2L3/86b0a9f440b2506f05722addca5d7696/mtgafr_cmmdr.png | Official WPN product image for the Adventures in the Forgotten Realms Commander decks; pictured package is Draconic Rage | 416 × 597 px | Commander product-identity reference only. The small package photograph was not composited. |
| `afr_wpn_exclusive_poster_reference.jpg` | https://media.wizards.com/2021/wpn/w28/afr_poster.jpg | Official WPN article image showing the separate red commissioned store poster | 715 × 367 px | Design-context reference only. It contains substantial empty webpage background and was not used as final art. |

The three page PNGs were rasterized with Poppler `pdftoppm -png -r 200`; no retouching, generation, or recompression was applied to those retained rasters.

## Finished assets and transformations

| File | Source / mode | Transformations and usage notes |
| --- | --- | --- |
| `../adventures_forgotten_realms_commander_official_key_art_target_v1_1800x2100.png` | Direct, non-generative official-art adaptation from `afr_official_wpn_key_art_poster_page-1.png` | Cropped the source to `x=0, y=0, width=2200, height=2567`, retaining the official Magic wordmark, dark wing canopy, dragon, swordswoman, panther, fire, and lower scale texture while removing the poster's original lower branding panel. Resampled that exact 6:7-oriented crop to 1800 × 2100 in sRGB without stretching. Added a palette-matched dark lower gradient, an antique-gold rule, and exact two-line pale-ivory Copperplate Bold title `ADVENTURES IN THE` / `FORGOTTEN REALMS`. The second line spans approximately 1609 px, leaving about 95 px on each side; all title glyphs remain above the count-marker zone. Written with 600 × 600 DPI PNG metadata. Built-in ImageGen was not used. SHA-256: `0dfd013431e7629fdc18a59140ee8713a8d700a48c2fac7922d38c7eb2f9de5c`. |
| `../adventures_forgotten_realms_commander_official_key_art_target_v1_deck_count_4_1800x2100.png` | Non-destructive counted sibling derived from the unnumbered v1 base | Added one approved `4` seal with `scripts/apply_deck_count.swift` using argument `4:1800`: 210-pixel diameter, equal 70-pixel right/bottom outer-edge insets, dark circular field, antique-gold rim, and pale-ivory Copperplate Bold numeral. The seal covers only noncritical lower-right dark scale/background texture and remains clear of the title and focal subjects. SHA-256: `caa54c382f5dea1b26449b2cc517c175787e598b42642c15cf8d7165b17b43d7`. |

The finalized set-specific adaptation brief is retained at `../prompts/adventures_forgotten_realms_commander_official_key_art_adaptation_brief.md`. It names every retained `src/` input and its role, specifies the exact title, and records all print, fullness, and drawer-legibility constraints.

## Typography-focused official-wordmark secondary v2

The v2 secondary preserves both v1 finished targets and addresses the typography specifically. Instead of retypesetting the set name in Copperplate Bold, it deterministically extracts the real **Adventures in the Forgotten Realms** title glyphs printed in the retained official WPN poster. The source lettering has the set's characteristic pointed, chiseled fantasy serifs, flared terminals, curved `R` legs, and official two-line hierarchy. Built-in ImageGen was not used.

### New supporting files

| File | Source / mode | Transformations and role |
| --- | --- | --- |
| `afr_official_title_region_preview.png` | Audit crop from `afr_official_wpn_key_art_poster_page-1.png` | 2050 × 520 preview of the retained poster's lower official branding region. It confirms the source title contours before extraction and is not a finished target. |
| `afr_official_set_wordmark_extracted_v2.png` | Deterministic raster extraction from `afr_official_wpn_key_art_poster_page-1.png` | Transparent 1960 × 380 supporting wordmark cropped from source coordinates `x=120, y=2840, width=1960, height=380`. A smooth neutral-channel threshold isolates the official white AFR title while excluding the dark dragon-scale field; the crop excludes the red Dungeons & Dragons logo and copyright line. Exact source spelling and glyph contours are preserved. SHA-256: `35403bf251ca16da2df73b6d14ad5a8afe6311619d645a12089ac9b87c896d85`. |
| `build_official_wordmark_secondary_v2.swift` | Deterministic Core Graphics production build | Recreates the established source-art crop, derives and exports the transparent official wordmark, applies its material/outline treatment, and writes the unnumbered print target with 600-DPI metadata. The script makes no network or generative-model calls. |
| `afr_v1_vs_official_wordmark_v2_full_comparison.png` | Derived comparison preview | 1800 × 1050 side-by-side comparison with the v1 counted target on the left and v2 counted target on the right, each shown at 900 × 1050. Not a finished target. |
| `afr_v1_vs_official_wordmark_v2_drawer_comparison.png` | Derived drawer-scale comparison preview | 720 × 420 side-by-side comparison with v1 on the left and v2 on the right, each at the required 360 × 420 drawer-review scale. Not a finished target. |

### New finished assets

| File | Source / mode | Transformations and usage notes |
| --- | --- | --- |
| `../adventures_forgotten_realms_commander_official_key_art_wordmark_v2_1800x2100.png` | Direct, non-generative official-art and official-wordmark composite from `afr_official_wpn_key_art_poster_page-1.png` | Preserves the v1 source crop exactly (`x=0, y=0, width=2200, height=2567`) and resamples without distortion to 1800 × 2100. Places the exact extracted official title at `x=70, y=1468, width=1660, height=322`, safely below the duel and above the count-seal zone. The untouched title contours receive a restrained weathered ivory/antique-stone gradient, fine deterministic pitting, a crisp near-black silhouette, and a localized translucent scrim. There is no footer plate: official art texture remains visible through and around the title. Written in sRGB at 600 × 600 DPI. SHA-256: `8ccab074058ff96c5fb26fac5cec61894d0d508d2bebb35f3444dcc3af50941a`. |
| `../adventures_forgotten_realms_commander_official_key_art_wordmark_v2_deck_count_4_1800x2100.png` | Non-destructive counted sibling derived from the v2 base | Added one approved `4` seal with `scripts/apply_deck_count.swift` and argument `4:1800`: exact 210-pixel diameter and exact 70-pixel right/bottom outer-edge insets. The seal covers only lower-right scale texture and remains clear of the title and duel. SHA-256: `0b8e375a7bcd6a55a3989189b721498fcf51e8a6e54ee0d64d5a0e93e2f689e7`. |

The finalized secondary brief is retained at `../prompts/adventures_forgotten_realms_commander_official_wordmark_secondary_v2_brief.md`.

## Verification record

- Inventory and authoritative-source check: complete four-deck release; the counted sibling uses `4`.
- Both finished files were visually inspected at full resolution.
- The counted target was also inspected at a 360 × 420 px drawer-viewing thumbnail; `ADVENTURES IN THE FORGOTTEN REALMS` and the `4` remain immediately readable.
- Exact dominant title appears once and reads `ADVENTURES IN THE FORGOTTEN REALMS`; no malformed, abbreviated, or additional title lettering appears.
- Official set identity remains recognizable through the Magic wordmark, Magali Villeneuve dragon encounter, fiery red/orange core, and dark scaled texture.
- Artwork and textured title treatment fill the full 6:7 canvas edge to edge; there are no blank, white, framed, or featureless areas.
- Dragon mouth, swordswoman, panther, Magic wordmark, title, and count marker are unobstructed and comfortably composed.
- Both final PNGs verify at exactly 1800 × 2100 pixels, 600 × 600 DPI, and RGB/sRGB-compatible color.
- The count seal was visually inspected in the actual lower-right corner with equal 70-pixel insets and does not overlap the title or critical artwork.

### Secondary v2 verification

- Both v2 finished files verify at exactly 1800 × 2100 pixels, 600 × 600 DPI, and sRGB.
- Both v1 finished targets remain preserved and unchanged.
- The title reads exactly `ADVENTURES IN THE FORGOTTEN REALMS`, once, using the official retained-poster glyphs rather than a substitute font.
- The extracted title spans 1660 pixels (92.2% of the finished width), leaving a 70-pixel print-safe inset on each side.
- Full comparison: the v2 preserves the same dragon-versus-party focal crop and removes the v1 antique rule plus heavily blackened lower footer treatment.
- Drawer-scale comparison at 360 × 420: the official fantasy-seriffed `FORGOTTEN REALMS` line remains immediately legible, the smaller official `ADVENTURES IN THE` line remains readable, and the `4` seal is clear.
- The v2 typography is more release-native because its contours are the actual WPN set wordmark and its warm stone/gold material echoes the dragon fire and armor instead of presenting the name as generic spaced display type.
- The standard counted sibling was produced only with `scripts/apply_deck_count.swift` using `4:1800`; the approved seal geometry is therefore exact.
