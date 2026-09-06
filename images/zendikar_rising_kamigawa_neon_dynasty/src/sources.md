# Zendikar Rising + Kamigawa Neon Dynasty sources

This directory contains raw source/reference material, unmodified generator outputs, production notes, and provenance only. Finished dual-set targets are stored one level above; finalized prompts are stored in `../prompts/`.

| File | Source | Artist / description | Original dimensions | Role / notes |
| --- | --- | --- | --- | --- |
| `zendikar_rising_official_key_social_1000x1000.jpg` | https://www.theswordandboardtoronto.com/cdn/shop/products/znr_sma_fb_1000x1000_en_1200x1200.jpg?v=1610559394 | Official Wizards Play Network Zendikar Rising branded key-art social asset; artist not identified in the retained file | 1000 × 1000 px | Raw identity anchor for Zendikar Rising: green stone adventure palette, climber subject, floating hedrons, and integrated official title. The asset is mirrored by a retailer; Wizards documents the corresponding key-art social resources on its WPN page below. |
| `kamigawa_neon_dynasty_official_key_social_1000x1000.jpg` | https://magicmarketcanada.com/cdn/shop/collections/neo_sma_v1_fb_1000x1000_en.jpg?v=1742609965 | Official Wizards Play Network Kamigawa: Neon Dynasty branded key-art social asset; illustration by Bryan Sola | 1000 × 1000 px | Raw identity anchor for Kamigawa Neon Dynasty: cyber-ninja, neon city, blue/pink palette, and integrated official title. The asset is mirrored by a retailer; Wizards documents the corresponding key-art social resources on its WPN pages below. |
| `zendikar_rising_kamigawa_neon_dynasty_vertical_split_v1_source.png` | Built-in OpenAI ImageGen using the two retained official branded-key-art references | Unmodified generated vertical-split source | 1163 × 1353 px | Exact prompt is recorded in `../prompts/zendikar_rising_kamigawa_neon_dynasty_vertical_split_v1_prompt.md`. |
| `../zendikar_rising_kamigawa_neon_dynasty_target_vertical_split_v1_1800x2100.png` | Derived from `zendikar_rising_kamigawa_neon_dynasty_vertical_split_v1_source.png` | Print-normalized vertical-split target | 1800 × 2100 px at 600 DPI | Center-cropped by 3 source pixels to exact 6:7, then resized. Zendikar is left; Kamigawa is right; one continuous vertical divider. |
| `../zendikar_rising_kamigawa_neon_dynasty_target_vertical_split_v3_deck_counts_2_2_trial_1800x2100.png` | Derived non-destructively from `../zendikar_rising_kamigawa_neon_dynasty_target_vertical_split_v1_1800x2100.png` | Trial dual deck-count target | 1800 × 2100 px at 600 DPI | Added a `2` to the actual lower-right corner of each panel with `scripts/apply_deck_count.swift`. Both use the same 0.35-inch seal, Copperplate Bold numeral, and equal 70-pixel panel-right/bottom insets. The unnumbered v1 target remains unchanged. |

Official Wizards source-family documentation:

- Zendikar Rising WPN digital resources: https://wpn.wizards.com/en/news/download-now-digital-resources-znr
- Kamigawa: Neon Dynasty WPN product page: https://wpn.wizards.com/en/products/kamigawa-neon-dynasty
- Kamigawa marketing-material guidance: https://wpn.wizards.com/en/news/4-ways-to-use-kamigawa-neon-dynasty-marketing-materials
