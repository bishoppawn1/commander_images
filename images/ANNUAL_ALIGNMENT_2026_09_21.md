# Annual titles and split-front corrections — 2026-09-21

The annual fronts below were subsequently superseded by the user's middle-placement refinement in [ANNUAL_CENTERED_2026_09_21.md](ANNUAL_CENTERED_2026_09_21.md). The Kamigawa / The Brothers' War correction remains active. This document preserves the earlier production record.

Five active drawer fronts were corrected with built-in ImageGen edits and the shared deterministic typography finisher. Previous finished artwork is preserved. The catalog selects the new counted 1440-DPI derivatives.

## Changes

- **commander_2013_commander_2016**: Added Atraxa, Praetors' Voice alongside Breya, so the right half visibly represents Breed Lethality and Invent Superiority. Preserved Jeleva and Oloro on the left. Matching two-line annual titles now share the same gold-outlined dark plaque and vertical coordinates; counts remain 2 / 2.
- **commander_2017**: Replaced the old title with the shared annual template; preserved Edgar Markov, the dragon, Arahbo and Inalla artwork.
- **commander_2018**: Removed the middle title and applied the shared lower-middle annual template, leaving all four commander faces clear.
- **commander_2019**: Removed the middle title and plaque and applied the shared lower-middle annual template, leaving all four commander faces clear.
- **kamigawa_neon_dynasty_brothers_war**: Raised the Kamigawa wordmark into the same lower title area as The Brothers' War, with matching lower alignment. Preserved each set's distinct type treatment and the 2 / 2 seals.

## Typography and finishing

`../scripts/build_unified_annual_titles.swift` applies one native CoreGraphics/CoreText title template after ImageGen removes the old lettering. Commander 2017–2019 use Baskerville Bold, 156-pixel type, a common center at (900, 1625) in top-down coordinates, and identical clipped-corner near-black plaques with antique-gold double outlines. Full-width plaque bounds are x=62...1738 and y=1510...1740. The 2013/2016 half-plaques share those y coordinates, identical 808-pixel widths, COMMANDER at 97 pixels and the year at 124 pixels. All faces stay clear of the title area.

Each revised asset retains its unmodified ImageGen raw input, 1800 × 2100 600-DPI full-bleed base and counted sibling, 1724 × 2024 600-DPI black-margin masters and 4138 × 4858 1440-DPI print siblings. Count seals are applied using `scripts/apply_deck_count.swift`, then the established white-intermediate → crop → cut-border → black-margin → high-resolution workflow transforms each completed face as one unit. Source aspect ratios were normalized by less than 0.2%.

## Active artwork and exact prompt records

| Release | Counted print file | Prompt |
| --- | --- | --- |
| commander_2013_commander_2016 | [1440-DPI PNG](commander_2013_commander_2016/commander_2013_commander_2016_vertical_split_unified_v3_deck_counts_2_2_4138x4858_1440dpi_black_margin_1_8in.png) | [Built-in edit brief](commander_2013_commander_2016/prompts/commander_2013_commander_2016_vertical_split_unified_v3.md) |
| commander_2017 | [1440-DPI PNG](commander_2017/commander_2017_unified_title_v2_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png) | [Built-in edit brief](commander_2017/prompts/commander_2017_unified_title_v2.md) |
| commander_2018 | [1440-DPI PNG](commander_2018/commander_2018_unified_title_v2_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png) | [Built-in edit brief](commander_2018/prompts/commander_2018_unified_title_v2.md) |
| commander_2019 | [1440-DPI PNG](commander_2019/commander_2019_unified_title_v2_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png) | [Built-in edit brief](commander_2019/prompts/commander_2019_unified_title_v2.md) |
| kamigawa_neon_dynasty_brothers_war | [1440-DPI PNG](kamigawa_neon_dynasty_brothers_war/kamigawa_neon_dynasty_brothers_war_vertical_split_aligned_v2_deck_counts_2_2_4138x4858_1440dpi_black_margin_1_8in.png) | [Built-in edit brief](kamigawa_neon_dynasty_brothers_war/prompts/kamigawa_neon_dynasty_brothers_war_vertical_split_aligned_v2.md) |

## Commander 2020 / Ikoria naming

Wizards explicitly aligned its annual Commander (2020 Edition), set code C20, with Ikoria. The five Ikoria Commander decks therefore legitimately carry both names. Zendikar Rising and Commander Legends also received Commander precons in 2020; Commander 2020 does not denote every Commander release that year. Earlier annual releases did not have this same expansion tie-in. The alias is accurate but optional on a drawer label, so the current Ikoria artwork and its sheet-7 addendum selection were retained.

Official source: [Big Things Are Coming for Commander in 2020](https://magic.wizards.com/en/news/announcements/big-things-are-coming-commander-2020-2019-10-30). Breed Lethality / Atraxa verification: [Commander 2016 character introductions](https://magic.wizards.com/en/news/magic-story/its-time-talk-commander-2016-edition-2016-10-26).

## Verification

- All five full-bleed counted fronts inspected at small drawer scale; text is readable, count seals clear, and no commander faces obscured.
- Ten black-margin masters passed `validate_final_black_margin.swift`.
- Ten high-resolution siblings passed `validate_1440dpi_drawer_faces.swift`.
- Sheets 1 and 2 rebuilt through `make_print_pdfs.py`; embedded raster pixels verified against selected PNG files. Current full-batch receipt: `Print Sheets/Fronts/.records/LATEST_fronts_all.json`.
- Small PNG renders of both new PDFs inspected. Earlier editions are archived under `Print Sheets/Fronts/.archive/annual_alignment_2026_09_21/`. Sheets 3–7 retain their prior files. No PDF opened in a Codex Files preview.
