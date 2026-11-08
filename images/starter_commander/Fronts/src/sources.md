# Starter Commander — drawer front

Created October 5, 2026.

The five reference illustrations show Isperia, Supreme Judge (Scott M. Fischer), Gisa and Geralf (Karla Ortiz), Kardur, Doomscourge (Chris Rahn), Atarka, World Render (Karl Kopinski), and Emmara, Soul of the Accord (Mark Winters). Each reference is 626 × 457 pixels. URLs and card records are recorded in `images/starter_commander/Tops/src/sources.md`. The two siblings form one deck. This is the 2022 five-deck two-color Starter Commander product, confirmed by the user, and receives `5`.

## Prior selected output (superseded)

- Full-bleed base: `starter_commander_five_legends_v3_2022_1800x2100.png`, 1800 × 2100 at 600 DPI.
- Counted full-bleed sibling: `starter_commander_five_legends_v3_2022_deck_count_5_1800x2100.png`.
- Black-margin master: `starter_commander_five_legends_v3_2022_deck_count_5_1724x2024_black_margin_1_8in.png`, 1724 × 2024 at 600 DPI.
- Print file: `starter_commander_five_legends_v3_2022_deck_count_5_4138x4858_1440dpi_black_margin_1_8in.png`, 4138 × 4858 at 1440 DPI.

Built-in ImageGen adapted the retained official references; exact prompts are in `../prompts`. Earlier raw attempts are preserved. The selected image was normalized as a complete composition to 6:7 with `scripts/normalize_drawer_master.swift`. The shared `apply_deck_count.swift` added deterministic seals. The established white-intermediate, crop, cut-border, black-margin, and 1440-DPI scripts built and validated both unnumbered and numbered variants without overwriting the full-bleed masters.

The complete black-margin print image is placed at the project's established **2.740278 × 3.208333 inches** on normal Fronts sheet 7. Artwork is resampled from the retained generated source; export DPI is not native illustration resolution.

## October 12, 2026 typography update

The user requested the release year on the Starter Commander front. Built-in ImageGen locally edited the previous full-bleed front to add `2022` to the title plaque. The exact prompt is `../prompts/starter_commander_five_legends_v3_2022.txt`, and its unmodified result is `starter_commander_five_legends_v3_2022_raw.png`. The same deterministic count-seal, margin, cut-guide, and 1440-DPI pipeline generated and validated the new versioned siblings; the earlier v2 assets remain available. The selected counted 1440-DPI image appears on normal Fronts sheet 7.

## October 12, 2026 color-matched print selection

The user asked to make all three newly added normal-sheet fronts less vibrant so they match the older collection. Built-in ImageGen edited the existing full-bleed art non-destructively; exact prompts and untouched outputs are retained in this folder and `../prompts`. The selected `starter_commander_five_legends_v4_2022_muted` image retains the original title/layout and was converted through the established count-seal, margin, cut-guide, and 1440-DPI pipeline. Mean HSV saturation of the counted print asset changed 0.518 → 0.425; older active fronts average 0.445. Current counted 1440-DPI print image: `../starter_commander_five_legends_v4_2022_muted_deck_count_5_4138x4858_1440dpi_black_margin_1_8in.png`. The current selection is on normal Fronts sheet 7; prior versions remain archived/available.
