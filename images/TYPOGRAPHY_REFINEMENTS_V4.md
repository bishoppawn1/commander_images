# Typography refinements v4 — 2026-09-19

These three files supersede the earlier active Eldraine, Forgotten Realms and Warhammer faces. The other corrected fronts remain unchanged.

| Front | Refinement | Final 1440-DPI PNG |
| --- | --- | --- |
| throne_of_eldraine_brawl | Restored Big Caslon and Luminari, reduced BRAWL from the original 300-point cap to 160, separated all lines, and shortened the lower flourish to keep faces visible. The vivid background is retained. | [Print file](throne_of_eldraine_brawl/throne_of_eldraine_brawl_luminari_clear_v4_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png) |
| adventures_forgotten_realms_commander | Tightened spacing between the existing official glyphs and added a dark local gradient beneath the title. The upper illustration stays bright. | [Print file](adventures_forgotten_realms_commander/adventures_forgotten_realms_contrast_tight_v4_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png) |
| warhammer_40000_commander | Built-in ImageGen extended the steel crest to enclose a compact COMMANDER tier in matching metallic block lettering. The original bright battlefield below y=840 is pixel-identical. | [Print file](warhammer_40000_commander/warhammer_40000_unified_crest_v4_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png) |

## Production records

- [Warhammer built-in ImageGen prompt](warhammer_40000_commander/prompts/unified_crest_v4.md).
- [Forgotten Realms native title brief](adventures_forgotten_realms_commander/prompts/typography_refinement_v4.md).
- [Eldraine native title brief](throne_of_eldraine_brawl/prompts/typography_refinement_v4.md).
- [Complete base, counted, 600-DPI and 1440-DPI asset paths](TYPOGRAPHY_REFINEMENTS_V4.json).

## Verification

All six base/count print-margin variants passed exact dimensions, 600-DPI metadata, black-margin and cut-guide checks. All six high-resolution derivatives passed 4138x4858, 1440-DPI and sRGB validation. The PDF builder verified embedded pixels and ICC profiles against the PNG sources and retained the existing physical print size. PDF previews remained closed; verification uses small rendered PNGs only.

## Updated print sheets

Small PNG renders of sheets 1 and 2 were visually reviewed: the Forgotten Realms title is clear against its darker background, the Warhammer crest encloses matching compact COMMANDER lettering, and the original Eldraine lettering has separated lines and a smaller BRAWL without covering commander faces.

- `01_Commander_2013_Commander_2016_Commander_2017_Commander_2018_Commander_2019_Eldraine_Brawl_Commander_2020_Ikoria_1440dpi_77c410e6d2.pdf`
- `02_Zendikar_Rising_Commander_Legends_Strixhaven_Forgotten_Realms_Kamigawa_Neon_Dynasty_Brothers_War_Warhammer_40000_Phyrexia_All_Will_Be_One_Wilds_of_Eldraine_1440dpi_d45854637f.pdf`

The six current PDFs in `Print Sheets/Fronts/` exactly match the current index and their recorded SHA-256 hashes. Sheets 3–6 are unchanged. The two superseded PDFs and their receipts are preserved in `Print Sheets/Fronts/.archive/typography_refinements_v4_2026_09_19/`.
