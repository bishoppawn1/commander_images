# Zendikar Rising | Commander Legends — sources and production record

Produced 2026-09-17 as an active chronological replacement. Zendikar Rising was released before Commander Legends, so it appears on the left. Each release represents two owned decks, so the counted face reads `2 | 2`.

Production mode: deterministic Core Graphics compositing. No new ImageGen generation or edit was used.

| Approved panel | Provenance | SHA-256 |
| --- | --- | --- |
| `approved_panels/zendikar_rising_approved_panel_900x2100.png` | Exact retained left half of the previously approved Zendikar Rising / Kamigawa face | `bcac1a102fcf51880fa68db12176dee6db72618785a682226bd97bd4860d4f27` |
| `approved_panels/commander_legends_approved_panel_900x2100.png` | Exact retained left half of the previously approved Commander Legends / Phyrexia face | `476b43696bd84cfc4a3c1359ba438ccad810e7d3f375bd6023f7343c81c5451f` |

`scripts/build_chronological_pair_faces.swift` places the panels on an exact 1800 × 2100 sRGB canvas and redraws one six-pixel antique-gold center divider. The counted sibling is built with `scripts/apply_deck_count.swift ... 2:900 2:1800`. Both bases have canonical 600-DPI black-margin masters and required 1440-DPI print derivatives.

The former combined directories and their archive were deleted at the user's request on 2026-09-17. The approved panel inputs above remain available for rebuilding this current pairing; additional source history is retained where available in the standalone release directories.
