# Complete top-label framing audit

Reviewed all 114 active label placements from the print catalog, including the four Star Trek tops. Contact-sheet inspection was followed by source-art review for every flagged case, corrected-layout previews, and final PDF review.

- 80 placements retain their original files unchanged.
- 34 receive versioned `_portrait_v2` layouts: 33 retain their existing artwork and one uses published alternate artwork of the same commander.
- No generated artwork was used in the final corrections.
- Centered mana rows, complete focal heads, room for hair/headwear/ears/horns, title clearance, and cut-border clearance govern the review.

Changed placements by release: Commander 2016 (1), Commander 2017 (4), Commander 2018 (4), Commander 2019 (4), Wilds of Eldraine (1), Lost Caverns of Ixalan (1), Fallout (1), Marvel Super Heroes (4), Commander Anthology I (1), Commander Anthology II (3), Aetherdrift (1), Edge of Eternities (1), Starter Commander (3), Reality Fracture (1), Star Trek (4).

All original finished images are retained. The new shared-builder options move artwork as a complete unit below the centered mana row; they are opt-in and do not reframe already-correct labels. The alternate Avengers image is Gal Or's published Captain America, Team Leader artwork (LMAR 6); the prior group artwork already cropped Hulk at its source boundary. The attempted ImageGen extension failed and no generated output entered the project.

The machine-readable [audit](boulder_top_audit_2026_11_08.json) records every pass/fix decision, original path and SHA-256, changed source and layout settings, and final output path. All 114 previous assets were hash-checked for preservation. A render comparison of the previous and new shared builders confirmed identical pixels for an unchanged control label; historical rendered assets need not match a fresh build from the current pre-existing compositor, so their preservation is checked directly by file hash.

Updated Boulder Tops sheets: 1, 2, 5, 6, 7, 8, 9, 10 and 11. Sheets 3 and 4 remain unchanged. The established physical label size is 2.75 x 2 1/3 inches with 3960 x 3360 source pixels at 1440 DPI. PDF validation checks the embedded images, placement transforms, sRGB profiles and Letter page size. Superseded editions are retained under `Print Sheets/Boulder Tops/.archive/portrait_clearance_2026_11_08/`.

Rebuild only the audited corrections with `scripts/build_boulder_portrait_corrections.py`. The reusable production instructions are in [BOULDER_TOP_COMPOSITION.md](BOULDER_TOP_COMPOSITION.md), the builder comments, and the personal MTG Commander Boulder Deck Label skill (review copy: [BOULDER_LABEL_SKILL.md](BOULDER_LABEL_SKILL.md)). The personal skill passed its validator.
