# Readability refinements v5 — 2026-09-20

Eldraine now has a soft dark plum backing behind THRONE OF, preserving the original Big Caslon/Luminari letterforms, separated rows, small BRAWL and bright artwork. Ikoria COMMANDER 2020 now matches the main wordmark with icy cyan/white faceted serif letters and a strong dark outline/shadow.

## Final artwork

- [throne_of_eldraine_brawl](throne_of_eldraine_brawl/throne_of_eldraine_brawl_luminari_shadow_v5_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png)
- [commander_2020_ikoria](commander_2020_ikoria/commander_2020_ikoria_crystal_commander_v5_deck_count_5_4138x4858_1440dpi_black_margin_1_8in.png)

## Production and verification

- [All asset paths](READABILITY_REFINEMENTS_V5.json).
- [Ikoria built-in ImageGen prompt](commander_2020_ikoria/prompts/crystal_commander_v5.md).
- [Eldraine native title brief](throne_of_eldraine_brawl/prompts/luminari_shadow_v5.md).
- Four base/count masters passed exact 1724x2024 dimensions, 600-DPI metadata, black margins and cut guides. Four print derivatives passed 4138x4858, 1440-DPI, sRGB validation.
- Individual artwork previews reviewed for exact text, clear contrast, unchanged faces and title spacing. PDF verification uses a small rendered PNG; never open the PDF preview in Codex.

## Final PDF verification

Sheet 1 passed embedded-image checks and visual review of its small PNG render. Both headings are clear at sheet scale. Ikoria pixels below the edited heading (y=540 onward) match the prior vivid master exactly.

Current sheet: `01_Commander_2013_Commander_2016_Commander_2017_Commander_2018_Commander_2019_Eldraine_Brawl_Commander_2020_Ikoria_1440dpi_012493482f.pdf`. The superseded sheet and receipt are archived under `Print Sheets/Fronts/.archive/readability_v5_2026_09_20/`. All six current PDF hashes match their receipts; sheets 2–6 are unchanged.
