# Turtle Power / Reality Fracture combined front

Created October 6, 2026, at the user's request. One temporary addendum front represents two owned Commander decks: Turtle Power! on the left and Reality Fracture / Multiverse Reforged on the right, with standard 1 / 1 seals. No deck counts changed.

## Inputs and provenance

- `turtle_power_existing_front_reference.png`: unchanged copy of `../../turtle_power_bottom_title_v1_deck_count_1_1800x2100.png`, 1800 x 2100. Based on official WPN key art credited to Ignatius Budi. [Official archive](https://media.wizards.com/2025/wpn/marketing_materials/tmt/tmt_sma_key_en.zip). The previous standalone source record is `../../src/sources.md`.
- `reality_fracture_existing_front_reference.png`: unchanged copy of `../../../../reality_fracture/Fronts/reality_fracture_official_key_art_adapted_v2_1800x2100.png`, 1800 x 2100. That front was adapted from official WPN artwork by Andrey Kuzinskiy and Caroline Gariba. [Official archive](https://media.wizards.com/2026/wpn/marketing_materials/fra/fra_key_art_sma_en.zip). The previous standalone source record is `../../../../reality_fracture/Fronts/src/sources.md`.
- Existing authoritative product/count verification is retained in the original source records and `INVENTORY.md`.

## Generation and production

- Mode: built-in ImageGen, compositing edit of the two retained existing fronts.
- Exact prompt: `../prompts/turtle_power_reality_fracture_vertical_split_v1.txt`.
- Untouched selected output: `turtle_power_reality_fracture_vertical_split_v1_raw.png`, 1161 x 1355 pixels. No CLI fallback was used.
- Recomposition preserves four distinct Turtle faces, Jace's white hood and crystalline blue setting, and separate large two-line titles. A single gold divider separates equal panels. The previous single-front count seal was removed during generation.
- `scripts/normalize_drawer_master.swift` normalized the complete generated composition to an exact 1800 x 2100 sRGB, 600-DPI master. Native generation resolution is lower than print export resolution.
- `scripts/apply_deck_count.swift` added deterministic standard seals with arguments `1:900 1:1800`; unnumbered and numbered masters are both preserved.
- The normal apply-white-margin, crop-white-margin (38), cut-border (3), and black-margin reframe scripts produced 1724 x 2024, 600-DPI masters. Both passed `validate_final_black_margin.swift`.
- `build_1440dpi_drawer_faces.swift` produced both 4138 x 4858, 1440-DPI print siblings; both passed `validate_1440dpi_drawer_faces.swift`. The white intermediates remain under `src/superseded_white_margin_3_16in/`.

## Print placement

The counted image occupies only the first front slot on separate temporary addendum sheet 13, at exactly 2.740278 x 3.208333 inches, on US Letter. Five slots remain blank. Rebuild with `scripts/build_fronts_temporary_addendum_13.py`. Its receipt is `Print Sheets/Fronts/.records/LATEST_fronts_temporary_addendum_13.json`.

The normal catalog and prior print sheets intentionally retain individual alternatives. This temporary sheet has its own index, independent of the regular all-front index. The combined physical drawer is recorded in `INVENTORY.md`.

## Raphael correction — October 6, 2026

The user noticed that Raphael's red head bandana seemed to wrap around his raised arm in v1. Reinspected the official Turtle Power source and the v1 combined front. The official source itself also has red material on the arm; the narrow combined crop made this read as a continuation of the mask. Built-in ImageGen edited the combined face using the official source as a character reference. The v2 version keeps the red bandana on Raphael's head with short rear tails and shows a continuous green raised arm with a separate brown wrist guard. The rest of the composition, titles, divider, and 1 / 1 markers were preserved.

- Exact edit prompt: `../prompts/turtle_power_reality_fracture_vertical_split_v2_raphael_fix.txt`.
- Untouched selected generated output: `turtle_power_reality_fracture_vertical_split_v2_raphael_fixed_raw.png`, 1161 x 1355 pixels. Mode: built-in ImageGen compositing edit, no CLI fallback.
- Full-bleed master: `../turtle_power_reality_fracture_vertical_split_v2_raphael_fixed_1800x2100.png`; counted sibling adds `1:900 1:1800`.
- Black-margin 600-DPI and 1440-DPI siblings were rebuilt using the same deterministic pipeline and passed the project validators. Earlier v1 artwork files remain intact as archived alternatives.
- The corrected v2 target is selected on the current normal Fronts sheet 12. The temporary sheet 13 PDF and its earlier edition were deleted on October 8 at the user's request; the artwork files remain.

## Current normal sheet — October 8, 2026

`Print Sheets/Fronts/12_Aetherdrift_Edge_of_Eternities_Starter_Commander_Turtle_Power_Reality_Fracture_1440dpi_2f86e8fcee.pdf` contains the corrected combined front in slot 3. Its full-size source is `../turtle_power_reality_fracture_vertical_split_v2_raphael_fixed_deck_counts_1_1_4138x4858_1440dpi_black_margin_1_8in.png`. The addendum PDFs were deleted, while earlier artwork variants remain for provenance.

## White Turtle Power title — October 11, 2026

At the user's request, the green interior fill of both TURTLE POWER! title lines was changed to white while keeping the orange outline and dark shadow. Raphael's corrected green arm and red head bandana remain clear; the Reality Fracture panel and standard 1 / 1 markers remain. Built-in ImageGen performed the local text-color edit using the v2 full-bleed front as the edit target.

- Exact edit prompt: `../prompts/turtle_power_reality_fracture_vertical_split_v3_white_title.txt`.
- Untouched generated output: `turtle_power_reality_fracture_vertical_split_v3_white_title_raw.png`, 1161 x 1355 pixels.
- New full-bleed master: `../turtle_power_reality_fracture_vertical_split_v3_white_title_1800x2100.png`; counted sibling uses markers `1:900 1:1800`.
- Both base and counted black-margin 600-DPI masters and 1440-DPI print siblings were built with the established scripts and passed both validators. V2 assets remain intact as alternatives.
- Active normal sheet: `Print Sheets/Fronts/12_Aetherdrift_Edge_of_Eternities_Starter_Commander_Turtle_Power_Reality_Fracture_1440dpi_02d35e160e.pdf`, slot 3. The previous normal sheet 12 edition is archived under `Print Sheets/Fronts/.archive/white_turtle_title_2026_10_11/`.

The user also requested an individual reprint of this exact white-title v3
front. It occupies the first slot on
`Print Sheets/Fronts/13_Special_Addendum_Turtle_Power_Reality_Fracture_1440dpi_5dfe52a62e.pdf`;
the other five slots are blank. This is a duplicate print of the normal
sheet-12 image, not an additional inventory entry.

## Consecutive front sheet numbers — October 11, 2026

The same finished white-title v3 print asset now appears on normal
`Print Sheets/Fronts/07_Aetherdrift_Edge_of_Eternities_Starter_Commander_Turtle_Power_Reality_Fracture_1440dpi_ac793bdb0e.pdf`
and one-image special
`Print Sheets/Fronts/08_Special_Addendum_Turtle_Power_Reality_Fracture_1440dpi_5dfe52a62e.pdf`.
These supersede the archived normal-12 and special-13 editions; the image pixels
and physical print boxes are unchanged.

## October 12, 2026 color-matched print selection

The user asked to make all three newly added normal-sheet fronts less vibrant so they match the older collection. Built-in ImageGen edited the existing full-bleed art non-destructively; exact prompts and untouched outputs are retained in this folder and `../prompts`. The selected `turtle_power_reality_fracture_vertical_split_v5_white_title_muted` image retains the original title/layout and was converted through the established count-seal, margin, cut-guide, and 1440-DPI pipeline. Mean HSV saturation of the counted print asset changed 0.613 → 0.468; older active fronts average 0.445. Current counted 1440-DPI print image: `../turtle_power_reality_fracture_vertical_split_v5_white_title_muted_deck_counts_1_1_4138x4858_1440dpi_black_margin_1_8in.png`. The current selection is on normal Fronts sheet 7; prior versions remain archived/available.

## Original Turtle Power palette match — October 12, 2026

The user compared the current split-panel Turtle Power image to the older full Turtle Power drawer face and found the split panel too full of rainbow/neon colors, even after its mean saturation was lowered. The full comparison source was `../../turtle_power_bottom_title_v1_deck_count_1_1800x2100.png`. Built-in ImageGen used that as a color and city-lighting reference for two non-destructive left-panel edits. The first untouched output is `turtle_power_reality_fracture_vertical_split_v6_original_palette_raw.png`; the selected follow-up output is `turtle_power_reality_fracture_vertical_split_v7_original_palette_raw.png`. Exact prompts are in `../prompts/turtle_power_reality_fracture_vertical_split_v6_original_palette.txt` and `../prompts/turtle_power_reality_fracture_vertical_split_v7_original_palette.txt`. The selected v7 front removes the artificial fluorescent splatter and calms the pavement reflections while preserving four turtles, Raphael's head bandana and green arm, white Turtle Power text, the right Reality Fracture panel, and 1 / 1 deterministic count seals. Current counted 1440-DPI source: `../turtle_power_reality_fracture_vertical_split_v7_original_palette_deck_counts_1_1_4138x4858_1440dpi_black_margin_1_8in.png`, on normal sheet 7.

## Big-puddle scene replacement — October 12, 2026

The user clarified that the earlier palette edit still retained the busy neon street scene. The new selected v8 art replaces the Turtle Power half with the original full front's composition: four turtles at the manhole and a broad, quiet dark puddle beneath them. The existing white TURTLE POWER! title remains over the puddle, Raphael's red bandana stays on his head with a green raised arm, and Reality Fracture remains on the right. Built-in ImageGen used the full Turtle Power front as the scene reference. Exact prompt: `../prompts/turtle_power_reality_fracture_vertical_split_v8_big_puddle.txt`. Untouched generated output: `turtle_power_reality_fracture_vertical_split_v8_big_puddle_raw.png`. Current counted 1440-DPI print asset: `../turtle_power_reality_fracture_vertical_split_v8_big_puddle_deck_counts_1_1_4138x4858_1440dpi_black_margin_1_8in.png`. It passed both 600- and 1440-DPI validators and is selected on normal Fronts sheet 7.

## Direct full-art fit — October 12, 2026

The user rejected the generated split-panel Turtle Power render and explicitly requested that the actual full Turtle Power image be cropped/squeezed into the left panel, with no new image generation. `scripts/build_turtle_split_from_full.swift` uses the retained `../../turtle_power_bottom_title_v1_deck_count_1_1800x2100.png` for all four turtles and the manhole, crops 80 px from each side and fits the remaining 1640 px into the 900 px half. The broad lower water comes from the retained original `../../turtle_power_commander_official_key_art_target_v1_1800x2100.png`; the two water regions are blended at their seam. The script deterministically draws the requested white/orange TURTLE POWER! title and copies the previous Reality Fracture right panel without image generation. The source art includes Raphael's original red forearm wrap. The selected full-bleed output is `../turtle_power_reality_fracture_vertical_split_v10_full_art_fit_1800x2100.png`; its counted 1440-DPI print sibling is `../turtle_power_reality_fracture_vertical_split_v10_full_art_fit_deck_counts_1_1_4138x4858_1440dpi_black_margin_1_8in.png`. Both 600- and 1440-DPI variants passed established validators. Current normal front sheet 7 uses this selection.

## Uniform Turtle Power crop — October 12, 2026

The user found the v10 horizontal squeeze visibly warped and asked for a side crop or uniform scaling. The revised `scripts/build_turtle_split_from_full.swift` crops outer city edges of the retained full front (x 250–1510) and scales the 1260-pixel-wide character scene uniformly to the 900-pixel left panel. The outer two turtles meet the panel edges, while all four faces remain recognizable. It extends the original official-art puddle below the scene with a subdued fade, draws the white/orange title deterministically, and copies the Reality Fracture right half from v10 pixel-for-pixel. No image generation was used. Current full-bleed master: `../turtle_power_reality_fracture_vertical_split_v11_uniform_art_fit_1800x2100.png`; current counted print source: `../turtle_power_reality_fracture_vertical_split_v11_uniform_art_fit_deck_counts_1_1_4138x4858_1440dpi_black_margin_1_8in.png`. The 600- and 1440-DPI print validators passed, and normal sheet 7 was rebuilt. V10 remains archived as an alternative.

## Tall-source skyline and centered turtles — October 12, 2026

The user found v11's vertically extended lower water distorted and asked for the turtles and Turtle Power title to sit more centrally, with the city skyline added above. The 1080 × 1920 official portrait `../../src/TMT_sma_key_1080x1920.jpg` supplies the exact turtle, manhole, and puddle pixels. A built-in ImageGen localized edit removed only the printed Magic logo from its upper skyline; the retained edit output is `turtle_power_skyline_logo_removed_v1.png`, and its exact prompt is `../prompts/turtle_power_skyline_cleanup_v1.txt`. The generation output's character area is not used. `scripts/build_turtle_split_from_tall.swift` scales both references uniformly to the left-panel height, uses the cleaned skyline only above the manhole, restores original character and puddle pixels below, covers the source's lower product lettering, draws white/orange TURTLE POWER! by code, and copies the previous Reality Fracture right side. Current full-bleed master: `../turtle_power_reality_fracture_vertical_split_v12_tall_skyline_centered_1800x2100.png`; current counted print asset: `../turtle_power_reality_fracture_vertical_split_v12_tall_skyline_centered_deck_counts_1_1_4138x4858_1440dpi_black_margin_1_8in.png`. Both print-image validators passed; normal sheet 7 was rebuilt. V11 remains available as an earlier alternative.

## Clear faces and source-matched tone — October 18, 2026

The Turtle Power artwork was raised 150 pixels at uniform scale, placing all four faces clearly above the title without stretching character or puddle pixels. A subtle dark overlay reduces its bright highlights. The Reality Fracture half was graded from the previous split using 0.84 contrast, 0.79 brightness, and 0.86 color; near-white title pixels were restored for legibility. This darker blue treatment was checked against the retained official `../../../../reality_fracture/Fronts/src/reality_FRA-1313-EN-1080x1350.png` source. The precise right-panel input is `turtle_power_reality_fracture_v13_right_source_tone_input.png`, reproducible with `scripts/grade_turtle_reality_right.py`. No new artwork was generated. Current full-bleed master: `../turtle_power_reality_fracture_vertical_split_v13_faces_clear_source_tone_1800x2100.png`; current counted print asset: `../turtle_power_reality_fracture_vertical_split_v13_faces_clear_source_tone_deck_counts_1_1_4138x4858_1440dpi_black_margin_1_8in.png`. Both print-image validators passed; normal sheet 7 was rebuilt. V12 remains archived as an alternative.

## Direct official Reality Fracture portrait — October 18, 2026

The prior v13 tone adjustment was too dark. V14 replaces the right half with the retained official `../../../../reality_fracture/Fronts/src/reality_FRA-1313-EN-Story.png` portrait. `scripts/build_turtle_reality_from_official.py` removes only 100 pixels from each side, scales the complete remaining portrait uniformly, and extends 68-pixel dark bands at the top and bottom. The source colors, Jace art, Magic logo, and Reality Fracture wordmark have no color or content edits. The v13 Turtle Power half is copied unchanged. Current full-bleed master: `../turtle_power_reality_fracture_vertical_split_v14_official_reality_1800x2100.png`; counted print asset: `../turtle_power_reality_fracture_vertical_split_v14_official_reality_deck_counts_1_1_4138x4858_1440dpi_black_margin_1_8in.png`. Both image validators passed and normal front sheet 7 was visually checked.

## One-image reprint sheet — October 18, 2026

The v14 counted print asset is duplicated unchanged in the first slot of Fronts addendum sheet 8. The other five slots are blank. Normal sheet 7 still holds the same image. Current addendum PDF: `../../../../../Print Sheets/Fronts/08_Special_Addendum_Turtle_Power_Reality_Fracture_1440dpi_635d866b8b.pdf`.
