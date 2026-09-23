# Centered Commander labels — 2026-09-21

Current annual fronts use matching labels exactly halfway down the canvas, between the upper and lower commander portraits. This supersedes the lower label placement from the earlier alignment pass.

## Changes

- Commander 2017: lowered Arahbo at bottom left and provided clearance above Inalla at bottom right.
- Commander 2018 and 2019: shifted the lower portraits slightly down to keep their full heads clear of the middle labels.
- Commander 2013 / 2016: raised both labels to the same middle band and positioned Oloro and Atraxa below them. Jeleva and Breya remain above. Counts remain 2 / 2.
- Preserved the established font, label width, dark backing, gold outlines and count seals.

## Production

Artwork was edited with built-in ImageGen using the exact briefs linked below. The unmodified outputs remain in each set’s src directory. The shared native typography builder `scripts/build_unified_annual_titles.swift` now accepts an optional top-down title-center argument; these fronts pass `1050`. The 1800 × 2100 canvas therefore has plaque bounds y=935...1165, centered at half height. Its earlier default is retained for reproducing historical files.

Each new version has an unnumbered and counted 600-DPI full-bleed target, a 1724 × 2024 black-margin master, and a 4138 × 4858 1440-DPI sibling. Earlier artwork remains intact. The catalog selects the new counted print files.

## Finished artwork and exact prompts

| Release | Print artwork | Edit prompt |
| --- | --- | --- |
| commander_2017 | [1440-DPI PNG](commander_2017/commander_2017_centered_title_v3_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png) | [Built-in ImageGen prompt](commander_2017/prompts/commander_2017_centered_title_v3.md) |
| commander_2013_commander_2016 | [1440-DPI PNG](commander_2013_commander_2016/commander_2013_commander_2016_vertical_split_centered_v4_deck_counts_2_2_4138x4858_1440dpi_black_margin_1_8in.png) | [Built-in ImageGen prompt](commander_2013_commander_2016/prompts/commander_2013_commander_2016_vertical_split_centered_v4.md) |
| commander_2018 | [1440-DPI PNG](commander_2018/commander_2018_centered_title_v3_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png) | [Built-in ImageGen prompt](commander_2018/prompts/commander_2018_centered_title_v3.md) |
| commander_2019 | [1440-DPI PNG](commander_2019/commander_2019_centered_title_v3_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png) | [Built-in ImageGen prompt](commander_2019/prompts/commander_2019_centered_title_v3.md) |

## Validation

- Inspected all four counted compositions at drawer scale: consistent central placement, all commander heads clear, readable lettering and count seals.
- Eight black-margin masters passed the established geometry checks; eight high-resolution files passed size, DPI and sRGB checks.
- Rebuilt sheet 1 through the shared PDF engine; all six embedded images verified against their selected PNGs. Sheets 2–7 remain unchanged.
- Current PDF filenames are indexed in `Print Sheets/Fronts/.records/LATEST_fronts_all.json`. The previous sheet 1 and receipt are archived under `Print Sheets/Fronts/.archive/annual_centered_2026_09_21/` after visual review.

Final sheet-1 PNG review passed: centered labels, readable text, clear commander heads, unchanged page grid and physical dimensions. Seven current front PDFs confirmed.
