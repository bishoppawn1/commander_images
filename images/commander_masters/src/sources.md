# Commander Masters drawer-face sources and provenance

Produced 2026-08-27. All external sources below are official Wizards of the Coast or Wizards Play Network properties.

## Product identity, First Look, debut, and count authority

- [Commander Masters product page](https://magic.wizards.com/en/products/commander-masters) — official Wizards product page. It describes Commander Masters as the first Masters set for Commander and states that the release includes four preconstructed Commander decks. This independently supports the supplied drawer count `4`.
- [Commander Masters Arrives August 4, 2023](https://magic.wizards.com/en/news/announcements/commander-masters-arrives-august-4-2023) — official February 21 announcement with the key art, exact set logo, all four deck names, and the May 5 First Look date.
- [A First Look at Commander Masters](https://magic.wizards.com/en/news/announcements/a-first-look-at-commander-masters) — official May 5 First Look. It presents the Commander Masters key art, four ready-to-play decks, and exact set logo. Direct official article assets inspected: [key art](https://media.wizards.com/2023/images/daily/8KAda22cWpB5.jpg) and [English set logo](https://media.wizards.com/2023/images/daily/en_fSrgNuDuWWxN.png).
- [Collecting Commander Masters](https://magic.wizards.com/en/news/feature/collecting-commander-masters) — official July 11 debut-day product overview with key art, exact logo, product lineup, and release details.
- [Where to Find Commander Masters Previews](https://magic.wizards.com/en/news/feature/where-to-find-commander-masters-previews) — official preview guide confirming the July 11 Commander Masters debut and using the same key art.
- [Commander Masters — WPN product page](https://wpn.wizards.com/en/products/commander-masters) — official Wizards Play Network source for the selected 24 x 36 poster, art-and-logo package, social/vertical key-art package, product shots, and product guide.

## Retained official source assets

| Retained file | Direct official URL | Original dimensions / format | Attribution and role |
| --- | --- | --- | --- |
| `cmm_lgp_key_24x36_en.pdf` | [WPN 24 x 36 key-art poster](https://media.wizards.com/2023/wpn/marketing_materials/cmm/cmm_lgp_key_24x36_en.pdf) | One-page PDF; 1728 x 2592 pt (24 x 36 in); 11,988,095 bytes | **Selected authoritative art source.** The poster's printed credit reads `ILL. PINDURSKI`; that credit is recorded exactly without inferring a first name. SHA-256 `3bebbf57eb384508ec75185df316220331047ec82daabef4c66a19079e0c5244`. |
| `cmm_lgp_key_24x36_en_render_150dpi.png` | Derived losslessly from the retained poster PDF with Poppler | 3600 x 5400, 8-bit RGB PNG, 150 DPI | Direct production raster. Its upper 3600 x 4200 region supplies the complete final 6:7 artwork. |
| `cmm_alg_en.zip` | [WPN Commander Masters art and logos](https://media.wizards.com/2023/wpn/marketing_materials/cmm/cmm_alg_en.zip) | Untouched ZIP; 894,197 bytes | Official archive containing the exact English wordmark, landscape key art, expansion symbols, and storage labels. SHA-256 `9d0eeb550268d72395787b177f16b03c4fd35d9519c377997e057b74975e1be0`. |
| `cmm_alg_en/MTGCMM_MSL_EN_4C.png` | Extracted unchanged from `cmm_alg_en.zip` | 900 x 407 transparent RGBA PNG | **Selected typography source.** Wizards' exact `COMMANDER MASTERS` wordmark; only transparent outer padding is cropped during production. |
| `cmm_alg_en/CMM_1080p_en.jpg` | Extracted unchanged from `cmm_alg_en.zip` | 1920 x 1080 RGB JPEG | Official branded landscape key-art candidate; comparison only. Its 16:9 layout requires a severe portrait crop, so it was not selected directly. |
| `cmm_key_art_sma_en.zip` | [WPN Commander Masters key-art social assets](https://media.wizards.com/2023/wpn/marketing_materials/cmm/cmm_key_art_sma_en.zip) | Untouched ZIP; 1,500,288 bytes | Official social-media package. SHA-256 `4f02e9d37f813ad8437a8063b69470eee3523f792e4d1f56c4d11f562b21b56f`. |
| `cmm_key_art_sma_en/cmm_sma_insta_1080x1920_en.jpg` | Extracted unchanged from `cmm_key_art_sma_en.zip` | 1080 x 1920 RGB JPEG | Official branded vertical/portrait candidate. Kept in contention, but the poster provides more source detail and more flexible title-safe framing. |
| `cmm_key_art_sma_en/cmm_sma_fb_1000x1000_en.jpg` | Extracted unchanged from `cmm_key_art_sma_en.zip` | 1000 x 1000 RGB JPEG | Official square social candidate; composition comparison only. |
| `cmm_key_art_sma_en/cmm_sma_fb_groups_1640x680_en.jpg` | Extracted unchanged from `cmm_key_art_sma_en.zip` | 1640 x 680 RGB JPEG | Official wide social candidate; composition comparison only. |
| `cmm_key_art_sma_en/cmm_sma_fb_pages_1600x841_en.jpg` | Extracted unchanged from `cmm_key_art_sma_en.zip` | 1600 x 841 RGB JPEG | Official page-width social candidate; composition comparison only. |

## Source selection and generation mode

The 24 x 36 WPN poster was selected because it is the strongest official portrait source: the roaring primary dragon, surrounding flight of dragons, green-gold-violet cosmic field, and Magic mark remain visually dense across the full frame. The in-image `ILL. PINDURSKI` credit provides the available artist attribution. The exact official transparent wordmark from the matching WPN art-and-logo archive provides error-free native typography.

The official vertical social image was explicitly inspected and retained, along with the square and wide social layouts and the landscape art-and-logo image. The vertical file is already branded but has less source resolution and keeps the title very low, where the standardized count seal would compete with it. Product photography was rejected as a final-art direction because it would introduce packaging on a product-photo background. The poster plus separate official wordmark allows a stronger focal crop, nearly full-width title, and clean seal zone without inventing imagery.

Built-in ImageGen was **not used**. No generated image, outpainting, synthetic extension, or generative edit was required, and no generation prompt was submitted. The finalized non-generative production brief is `../prompts/commander_masters_official_wpn_poster_adaptation_brief.md`.

## Exact deterministic transformation

The retained `build_commander_masters_target.swift` script performs the complete base finish:

1. Load the retained 3600 x 5400 poster raster and crop upper-poster `x=0, y=0, width=3600, height=4200`, an exact 6:7 region. This keeps the complete dragon focal image, surrounding smaller dragons, cosmic detail, and Magic mark, while ending just before the poster's low integrated title.
2. Resample the crop once with high-quality interpolation to exact 1800 x 2100 on an sRGB RGBA canvas.
3. Add a soft black-green-to-transparent lower vignette across the detailed art. It has no hard edge, opaque footer, border, or featureless band.
4. Crop only transparent padding from `MTGCMM_MSL_EN_4C.png` at `x=90, y=92, width=721, height=220`. Place the untouched official wordmark content at displayed `x=45, y=1200, width=1710, height=522`, plus a restrained dark shadow. The wordmark's official letters, spelling, spacing, white/orange/pink material, purple outline, and extrusion are not redrawn or altered.
5. Write exact 600 x 600 DPI PNG metadata.
6. Run `scripts/apply_deck_count.swift` with marker argument `4:1800` to make the non-destructive counted sibling. The standard 210-pixel circle occupies `x=1520–1730, y=1820–2030` in top-left final coordinates, which gives exactly 70 pixels of right and bottom outer-edge inset.

Reproduction from the repository root:

```sh
pdftoppm -f 1 -singlefile -png -r 150 \
  images/commander_masters/src/cmm_lgp_key_24x36_en.pdf \
  images/commander_masters/src/cmm_lgp_key_24x36_en_render_150dpi

/usr/bin/swift images/commander_masters/src/build_commander_masters_target.swift \
  images/commander_masters/src/cmm_lgp_key_24x36_en_render_150dpi.png \
  images/commander_masters/src/cmm_alg_en/MTGCMM_MSL_EN_4C.png \
  images/commander_masters/commander_masters_official_wpn_poster_target_v1_1800x2100.png

/usr/bin/swift scripts/apply_deck_count.swift \
  images/commander_masters/commander_masters_official_wpn_poster_target_v1_1800x2100.png \
  images/commander_masters/commander_masters_official_wpn_poster_target_v1_deck_count_4_1800x2100.png \
  4:1800
```

## Finished print targets

| Final file | Role | Technical result | SHA-256 |
| --- | --- | --- | --- |
| `../commander_masters_official_wpn_poster_target_v1_1800x2100.png` | Unnumbered base from the deterministic official-poster adaptation | 1800 x 2100, exact 6:7, non-interlaced 8-bit RGBA PNG, sRGB/RGB, 600 x 600 DPI | `7939e43c4b52ea0fc2c15f880217b12551e7e3a86abc285c7a5dd6cde6dc6536` |
| `../commander_masters_official_wpn_poster_target_v1_deck_count_4_1800x2100.png` | Counted sibling created non-destructively from the base with `4:1800` | 1800 x 2100, exact 6:7, non-interlaced 8-bit RGBA PNG, sRGB/RGB, 600 x 600 DPI; standard `4` seal geometry | `b84a8da7edf3940b056727dee87abc1101f87dc2e48b33c8eeac71394c4d8682` |

## Visual and technical QA

- Inspected the selected poster, official logo, landscape art-and-logo asset, all four official social layouts, unnumbered final, counted final, and the retained 300 x 350 drawer-scale counted preview.
- Exact identity: `COMMANDER MASTERS` appears once in Wizards' exact official English wordmark. There is no malformed text, pseudo-text, duplicate title, deck name, or added slogan.
- Drawer legibility: the visible official title spans about 95% of the canvas width; `COMMANDER`, `MASTERS`, and the numeral `4` remain immediately readable in `commander_masters_official_wpn_poster_target_v1_deck_count_4_drawer_qa_300x350.png`.
- Composition: art and atmospheric detail fill every edge. The primary dragon face and open mouth remain unobstructed; the title sits across noncritical lower torso/wing texture. There is no product-photo background, white border, blank footer, large empty area, or flat title panel.
- Title/seal safety: the official wordmark ends at displayed y=1722. The 210-pixel count seal begins at y=1820, leaving a 98-pixel clear gap. The seal covers only noncritical lower-right dragon/cosmic texture.
- Geometry and metadata: both finals independently report exact 1800 x 2100 pixels, 600.000 x 600.000 DPI, RGB/sRGB, 8-bit RGBA, and non-interlaced PNG encoding. The seal's outer circle has exact 70-pixel right and bottom insets.
- Determinism: a clean base rebuild and counted rebuild were each byte-identical to the checked final. The hashes reproduced exactly as listed above.
- Folder hygiene: the set root contains only finished full-bleed and active black-margin targets plus `prompts/` and `src/`. Raw sources, production scripts, provenance, QA previews, and superseded print derivatives remain under `src/`; the finalized brief remains under `prompts/`.

## Commander Masters finalized print-margin prototype — 2026-08-30

The active Commander Masters black-margin targets replace this set's standard 3/16-inch variants. Per the user's explicit correction, 38 pixels—the nearest symmetric whole-pixel representation of 1/16 inch at 600 DPI—were first cropped from every outer edge of each archived 1800 × 2100 white-margin derivative. This produces the retained 1724 × 2024 outer canvas and an initial 1574 × 1874 artwork region. This approved treatment subsequently became the project-wide standard for every active black-margin target.

The complete artwork region is first enlarged by 38 pixels in both dimensions, then expanded by another 16 pixels on every edge. The final artwork is therefore 1644 × 1944. It is centered horizontally at `x=40`; in Core Graphics bottom-left coordinates it is drawn at `y=96`, causing its topmost 16 pixels to extend beyond the canvas and be clipped. This consumes 16 pixels of margin space on the left, right, and bottom compared with the previous iteration while keeping the 1724 × 2024 canvas unchanged. The 3-pixel opaque-black cut guide remains on all outer edges. Per the later project-wide correction, all exposed margin pixels are opaque black: 37 pixels per side, none at the top, and 93 pixels at the bottom. Active filenames use the accurate `black_margin` label.

| Active reduced-margin file | SHA-256 |
| --- | --- |
| `../commander_masters_official_wpn_poster_target_v1_1724x2024_black_margin_1_8in.png` | `7e4f823cc1e919d97c30d254f6f990215ae1a4f504309f475aad2f2e9260cd02` |
| `../commander_masters_official_wpn_poster_target_v1_deck_count_4_1724x2024_black_margin_1_8in.png` | `c0ff0d8e18fa40f1964edefffd6ed3ecfbe1d693bde7b3e2fa3821ce22acb78f` |

Reproduction and pixel-identity validation:

```sh
qa_dir=$(mktemp -d)

swift scripts/crop_white_margin.swift \
  images/commander_masters/src/superseded_white_margin_3_16in/commander_masters_official_wpn_poster_target_v1_1800x2100_white_margin_3_16in.png \
  "$qa_dir/cropped.png" \
  38

swift scripts/validate_white_margin_crop.swift \
  images/commander_masters/src/superseded_white_margin_3_16in/commander_masters_official_wpn_poster_target_v1_1800x2100_white_margin_3_16in.png \
  "$qa_dir/cropped.png" \
  38 75

swift scripts/add_cut_border.swift \
  "$qa_dir/cropped.png" \
  "$qa_dir/bordered.png" \
  3

swift scripts/validate_cut_border.swift \
  "$qa_dir/cropped.png" \
  "$qa_dir/bordered.png" \
  3

swift scripts/reframe_final_black_margin.swift \
  "$qa_dir/bordered.png" \
  "$qa_dir/final.png"

swift scripts/validate_final_black_margin.swift \
  "$qa_dir/final.png"
```

The same commands apply to the `_deck_count_4_` pair. QA passed exact 1724 × 2024 output dimensions, 600-DPI metadata, opaque-black exposed margins, a 3-pixel pure-black cut guide, correct 1644 × 1944 artwork geometry, and the specified asymmetric allocation. Pixel comparison against the preceding white-margin files confirmed that every artwork pixel remained identical and only the exposed margin pixels changed to black. The active files were updated in place; no extra root-level sibling was created. The superseded 3/16-inch versions remain archived under `src/superseded_white_margin_3_16in/`. No ImageGen call was used.
