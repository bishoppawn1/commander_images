# Kamigawa: Neon Dynasty | The Brothers' War — sources and production record

Produced 2026-09-17 as an active chronological replacement. Kamigawa: Neon Dynasty was released before The Brothers' War, so it appears on the left. Each release represents two owned decks, so the counted face reads `2 | 2`.

Production mode: deterministic Core Graphics compositing. No new ImageGen generation or edit was used.

| Approved panel | Provenance | SHA-256 |
| --- | --- | --- |
| `approved_panels/kamigawa_neon_dynasty_approved_panel_900x2100.png` | Exact retained right half of the previously approved Zendikar Rising / Kamigawa face | `8e2b56135ef57e93fb0c8967303afed25dcffe1bd691d62b474ae3765c5d946c` |
| `approved_panels/brothers_war_approved_panel_900x2100.png` | Exact retained left half of the previously approved Brothers' War / Wilds face | `2d4e0d1e4695ab85d00120dc746c0fd5815747c442da94d0763c20e3a6246564` |

`scripts/build_chronological_pair_faces.swift` places the panels on an exact 1800 × 2100 sRGB canvas and redraws one six-pixel antique-gold center divider. The counted sibling is built with `scripts/apply_deck_count.swift ... 2:900 2:1800`. Both bases have canonical 600-DPI black-margin masters and required 1440-DPI print derivatives.

The former combined directories and their archive were deleted at the user's request on 2026-09-17. The approved panel inputs above remain available for rebuilding this current pairing; additional source history is retained where available in the standalone release directories.


## Current correction — 2026-09-21

Raised the Kamigawa wordmark into the same lower title area as The Brothers' War, with matching lower alignment. Preserved each set's distinct type treatment and the 2 / 2 seals.

Mode: built-in ImageGen edit, followed by exact CoreGraphics/CoreText finishing in `scripts/build_unified_annual_titles.swift` and the established count/margin scripts. All earlier completed files remain preserved.

- Unmodified accepted raw output: `imagegen_kamigawa_neon_dynasty_brothers_war_vertical_split_aligned_v2_refined_raw.png`.
- Exact edit prompt: `../prompts/kamigawa_neon_dynasty_brothers_war_vertical_split_aligned_v2.md`.
- Current unnumbered full-bleed target: `../kamigawa_neon_dynasty_brothers_war_vertical_split_aligned_v2_1800x2100.png`.
- Current counted print target: `../kamigawa_neon_dynasty_brothers_war_vertical_split_aligned_v2_deck_counts_2_2_4138x4858_1440dpi_black_margin_1_8in.png`.
- Raw SHA-256: `d8845a24dc88492b1c390a7c3167d1dce58ccd478a114aa40173dd5ce6764ace`.
- Counted print SHA-256: `f5c8df91739d7ca539e7512b167e89b63310dabeee7e8d0b689c3048dfc6d54d`.

See `images/ANNUAL_ALIGNMENT_2026_09_21.md` for the shared layout, finishing, and PDF verification record.
