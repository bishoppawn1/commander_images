# Commander Legends | Phyrexia: All Will Be One — sources and production record

Produced 2026-08-30 as the replacement equal vertical-split drawer face. Commander Legends appears on the left because it was released first; Phyrexia: All Will Be One appears on the right. Both complete release groups contain two owned decks, so the markers are `2 | 2`. The retired Commander Legends / Ikoria / Strixhaven and Phyrexia / March of the Machine combinations were removed from the active project.

Generation mode: deterministic compositing from retained official and approved project sources. No new ImageGen call was used.

## Retained inputs

| Input | Provenance and role | SHA-256 |
| --- | --- | --- |
| `../../commander_legends/src/official_poster_page1_600dpi.png` | Retained 5100 × 6600 raster of the official WPN Commander Legends poster; Jeska panel art. Full provenance and Magali Villeneuve attribution remain in the standalone release's `src/sources.md`. | `4d58b61aeeb80077413918cb7c671f6d5ba54163d4335cda23e83afd9bcfaffa` |
| `../../commander_legends/src/official_commander_legends_wordmark_extracted.png` | Exact-contour official Commander Legends wordmark extracted from the same retained poster. | `5a15f1d7064dbdc9fe26badcaead22115497dc67ef247d8de87ea5669f6fadce` |
| `../../phyrexia_all_will_be_one_commander/src/official_wpn_one_key_art_poster_24x36_en_page1_150ppi.png` | Retained 3600 × 5400 raster of the official WPN Phyrexia poster; Elesh Norn panel art. Full WPN provenance and Magali Villeneuve attribution remain in the standalone release's `src/sources.md`. | `77cd6e6993ef681cf088cd33e39c00a300515b8721dfd30401b0edd8426ee846` |
| `../../phyrexia_all_will_be_one_commander/src/MTGONE_EN_SetLogo.png` | Untouched official English Phyrexia wordmark. | `bd32a1d232d01730b4acc22a82b82895ea383994597ccf286b68317e9df4ca06` |

## Deterministic construction

- Finalized brief: `../prompts/commander_legends_phyrexia_vertical_split_brief.md`.
- Build script: `build_vertical_split.swift`.
- Commander Legends crop: `x=1700, y=350, width=1993, height=4650`, resampled into the exact 900 × 2100 left panel. The approved metallic official-wordmark treatment is retained at 812 pixels wide.
- Phyrexia crop: `x=964, y=100, width=1671, height=3899`, resampled into the exact 900 × 2100 right panel. The exact official wordmark is 750 pixels wide with the approved deterministic porcelain colon treatment.
- One six-pixel antique-gold divider occupies x=897–902 over the exact x=900 panel boundary. There are no gutters, extra frames, or blended seams.
- The counted sibling is derived from the unnumbered base with `scripts/apply_deck_count.swift` and marker arguments `2:900 2:1800`.
- Both full-bleed targets have active 1724 × 2024, 600-DPI opaque-black print-margin siblings. Their archived 1800 × 2100 white 3/16-inch intermediates remain under `superseded_white_margin_3_16in/`.

Reproduction from the repository root:

```sh
swift images/commander_legends_phyrexia_all_will_be_one/src/build_vertical_split.swift \
  images/commander_legends/src/official_poster_page1_600dpi.png \
  images/commander_legends/src/official_commander_legends_wordmark_extracted.png \
  images/phyrexia_all_will_be_one_commander/src/official_wpn_one_key_art_poster_24x36_en_page1_150ppi.png \
  images/phyrexia_all_will_be_one_commander/src/MTGONE_EN_SetLogo.png \
  images/commander_legends_phyrexia_all_will_be_one/commander_legends_phyrexia_all_will_be_one_vertical_split_v1_1800x2100.png \
  images/commander_legends_phyrexia_all_will_be_one/src/commander_legends_phyrexia_all_will_be_one_vertical_split_v1_drawer_preview_300x350.png

swift scripts/apply_deck_count.swift \
  images/commander_legends_phyrexia_all_will_be_one/commander_legends_phyrexia_all_will_be_one_vertical_split_v1_1800x2100.png \
  images/commander_legends_phyrexia_all_will_be_one/commander_legends_phyrexia_all_will_be_one_vertical_split_v1_deck_counts_2_2_1800x2100.png \
  2:900 2:1800
```

## Finished targets

| File | SHA-256 |
| --- | --- |
| `../commander_legends_phyrexia_all_will_be_one_vertical_split_v1_1800x2100.png` | `3562271349897668a614b2563b900f57ab1c377823a3c8e588db1a19ea144318` |
| `../commander_legends_phyrexia_all_will_be_one_vertical_split_v1_deck_counts_2_2_1800x2100.png` | `e0fad5aed38cd0b50f78b93c3ab798b82c2a812445090cb4a068f885a4c03189` |
| `../commander_legends_phyrexia_all_will_be_one_vertical_split_v1_1724x2024_black_margin_1_8in.png` | `c3e8d4461cbefb89b449ca1ed5ced3a621745e91b4a14bbfb5a47a41693ef4c1` |
| `../commander_legends_phyrexia_all_will_be_one_vertical_split_v1_deck_counts_2_2_1724x2024_black_margin_1_8in.png` | `ea475c6227c166664f6cd6a0adf23dcf8f8bc3ec2e31b49d21220567b959eef6` |

## QA

- Both full-bleed files are exact 1800 × 2100, 600-DPI sRGB PNGs; both black-margin files are exact 1724 × 2024, 600-DPI PNGs.
- The counted target has 210-pixel markers with exact 70-pixel insets from each panel's right boundary and the full-image bottom.
- Full-resolution and 300 × 350 drawer-scale inspection confirmed immediately legible identifiers, clean divider geometry, intact focal faces, and no large empty area.
- A clean rebuild reproduced the full-bleed base and counted files byte-for-byte.
