# Aetherdrift Edge Of Eternities — drawer front

Created October 5, 2026.

Official reference art retained from Wizards Play Network: [Aetherdrift key-art social assets](https://media.wizards.com/2024/wpn/marketing_materials/dft/dft_sma_key_en.zip), art by Svetlin Velinov; [Edge of Eternities key-art social assets](https://media.wizards.com/2025/wpn/marketing_materials/eoe/eoe_sma_key_en.zip), art by Chris Rallis. Each selected portrait is 1080 × 1920 pixels. Product-page graphics and alternate social formats are also retained as research references. The branded portrait references were selected for their recognizable Chandra racing and Tezzeret cosmic compositions.

The user explicitly requested these two releases share a four-deck drawer. Aetherdrift is the left panel and Edge of Eternities the right. Each has a `2` marker.

## Prior selected output (superseded)

- Full-bleed base: `aetherdrift_edge_of_eternities_vertical_split_v1_1800x2100.png`, 1800 × 2100 at 600 DPI.
- Counted full-bleed sibling: `aetherdrift_edge_of_eternities_vertical_split_v1_deck_counts_2_2_1800x2100.png`.
- Black-margin master: `aetherdrift_edge_of_eternities_vertical_split_v1_deck_counts_2_2_1724x2024_black_margin_1_8in.png`, 1724 × 2024 at 600 DPI.
- Print file: `aetherdrift_edge_of_eternities_vertical_split_v1_deck_counts_2_2_4138x4858_1440dpi_black_margin_1_8in.png`, 4138 × 4858 at 1440 DPI.

Built-in ImageGen adapted the retained official references; exact prompts are in `../prompts`. Earlier raw attempts are preserved. The selected image was normalized as a complete composition to 6:7 with `scripts/normalize_drawer_master.swift`. The shared `apply_deck_count.swift` added deterministic seals. The established white-intermediate, crop, cut-border, black-margin, and 1440-DPI scripts built and validated both unnumbered and numbered variants without overwriting the full-bleed masters.

The complete black-margin print image is placed at the project's established **2.740278 × 3.208333 inches** on Fronts sheet 12. Artwork is resampled from the retained generated source; export DPI is not native illustration resolution.

## October 12, 2026 color-matched print selection

The user asked to make all three newly added normal-sheet fronts less vibrant so they match the older collection. Built-in ImageGen edited the existing full-bleed art non-destructively; exact prompts and untouched outputs are retained in this folder and `../prompts`. The selected `aetherdrift_edge_of_eternities_vertical_split_v2_muted` image retains the original title/layout and was converted through the established count-seal, margin, cut-guide, and 1440-DPI pipeline. Mean HSV saturation of the counted print asset changed 0.510 → 0.435; older active fronts average 0.445. Current counted 1440-DPI print image: `../aetherdrift_edge_of_eternities_vertical_split_v2_muted_deck_counts_2_2_4138x4858_1440dpi_black_margin_1_8in.png`. The current selection is on normal Fronts sheet 7; prior versions remain archived/available.
