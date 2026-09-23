# Completed drawer-front corrections — 2026-09-19

Seven active fronts replace their earlier print-catalog selections. Original assets and source art remain preserved.

Latest follow-on changes are recorded in [Readability refinements v5](READABILITY_REFINEMENTS_V5.md); earlier changes are in [Typography refinements v4](TYPOGRAPHY_REFINEMENTS_V4.md).

## Final 1440-DPI assets

| Front | Change | Print-ready PNG |
| --- | --- | --- |
| The Lord of the Rings | Centered the official title above the 4 seal. | [Counted print file](lord_of_the_rings_tales_of_middle_earth_commander/lord_of_the_rings_centered_wordmark_v3_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png) |
| The Lost Caverns of Ixalan | Centered and raised the official title above the 4 seal. | [Counted print file](lost_caverns_of_ixalan_commander/lost_caverns_of_ixalan_centered_wordmark_v2_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png) |
| March of the Machine | Enlarged the official title to 1580 px wide and moved it lower over the rock. | [Counted print file](march_of_the_machine_commander/march_of_the_machine_large_lower_title_v2_deck_count_5_4138x4858_1440dpi_black_margin_1_8in.png) |
| Throne of Eldraine Brawl | Richer colors, original Big Caslon/Luminari lettering, smaller BRAWL and matching dark backing behind all three title rows. | [Counted print file](throne_of_eldraine_brawl/throne_of_eldraine_brawl_unified_shadow_v6_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png) |
| Ikoria / Commander 2020 | Vivid colors, a large centered IKORIA title and matching crystalline COMMANDER 2020 lettering. | [Counted print file](commander_2020_ikoria/commander_2020_ikoria_crystal_commander_v5_deck_count_5_4138x4858_1440dpi_black_margin_1_8in.png) |
| Adventures in the Forgotten Realms | Brighter subjects and terrain; enlarged official lettering reflowed into three lines. | [Counted print file](adventures_forgotten_realms_commander/adventures_forgotten_realms_contrast_tight_v4_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png) |
| Warhammer 40,000 | Brighter battlefield and characters; bright ivory COMMANDER lettering. | [Counted print file](warhammer_40000_commander/warhammer_40000_unified_crest_v4_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png) |

## Production and prompts

Built-in ImageGen was used for color/lighting edits, title removal on March/Forgotten Realms, and Ikoria title enlargement. Existing official logo layers and native CoreGraphics/CoreText compositors were used for precise LOTR, Ixalan, March, Eldraine and Forgotten Realms lettering. No API/CLI image-generation fallback was used.

Exact ImageGen prompt sets:
- [march_of_the_machine_commander / correction_2026_09_18](march_of_the_machine_commander/prompts/correction_2026_09_18.md)
- [throne_of_eldraine_brawl / correction_2026_09_18](throne_of_eldraine_brawl/prompts/correction_2026_09_18.md)
- [commander_2020_ikoria / correction_2026_09_18](commander_2020_ikoria/prompts/correction_2026_09_18.md)
- [commander_2020_ikoria / correction_2026_09_19](commander_2020_ikoria/prompts/correction_2026_09_19.md)
- [adventures_forgotten_realms_commander / correction_2026_09_19](adventures_forgotten_realms_commander/prompts/correction_2026_09_19.md)
- [warhammer_40000_commander / correction_2026_09_19](warhammer_40000_commander/prompts/correction_2026_09_19.md)

Full filenames for all base, counted, 600-DPI and 1440-DPI files are recorded in [the asset manifest](DRAWER_CORRECTIONS_2026_09_19.json). Each set's `src/sources.md` records inputs, transformations and build scripts.

## Verification

- All 18 revised base/count variants (seven final candidates plus the two superseded first-pass color candidates) passed exact 600-DPI black-margin/cut-guide checks.
- All 18 high-resolution derivatives passed size, 1440-DPI metadata, sRGB and bit-depth validation.
- The PDF builder verifies every embedded image against its PNG pixel hash, preserves ICC profiles, and checks the original physical size and page layout.
- PDF pages are inspected only as small rendered PNGs. No PDF is opened in Codex Files or through `open_in_codex`.

## Current PDFs

Sheets 1, 2 and 3 are regenerated from the new catalog. Sheets 4, 5 and optional Overflow sheet 6 remain unchanged. The current six-sheet batch is indexed by `Print Sheets/Fronts/.records/LATEST_fronts_all.json`. Superseded editions of sheets 1–3 are archived under `Print Sheets/Fronts/.archive/superseded_2026_09_19/`. The main Fronts folder contains exactly six current PDFs. All three replacement pages passed visual inspection at a maximum edge of 1200 pixels, with no clipping or obscured title text. Sheets 4–6 retain their original file hashes.

Rebuilt PDF files:

- `01_Commander_2013_Commander_2016_Commander_2017_Commander_2018_Commander_2019_Eldraine_Brawl_Commander_2020_Ikoria_1440dpi_805ec0f58f.pdf`
- `02_Zendikar_Rising_Commander_Legends_Strixhaven_Forgotten_Realms_Kamigawa_Neon_Dynasty_Brothers_War_Warhammer_40000_Phyrexia_All_Will_Be_One_Wilds_of_Eldraine_1440dpi_a3d8dde5d6.pdf`
- `03_March_of_the_Machine_Lord_of_the_Rings_Commander_Masters_Doctor_Who_Lost_Caverns_of_Ixalan_Fallout_1440dpi_9a6bd6e66d.pdf`

Eldraine follow-on: [Unified title shadow v6](ELDRAINE_UNIFIED_SHADOW_V6.md).
