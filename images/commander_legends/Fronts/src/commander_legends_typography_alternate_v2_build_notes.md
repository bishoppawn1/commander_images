# Commander Legends typography alternate v2 — build and QA notes

## Diagnosis

- The retained v4 title is readable but uses a generic wide display treatment and thin rules that do not match the official product identity.
- Typography alternate v1 improves the contour by using the official wordmark, but the warm orange fill, heavy rim, conspicuous scratch texture, and near-full-width scale make the title read as a crude slab. At drawer scale, `LEGENDS` dominates Jeska rather than identifying the art, and the counted version lets the final `S` compete with the seal.

## Deterministic revision

- `build_commander_legends_typography_alternate_v2.swift` retains the same full-width Jeska art crop used by v1, ensuring the comparison isolates typography.
- The exact extracted official wordmark is scaled to 1360 pixels wide and centered at x=220. This is approximately 10.5% smaller than the first v2 draft and 18% smaller than v1.
- The face uses a smooth pale-ivory/silver-to-muted-teal gradient sampled conceptually from the official Wizards branded Jeska asset. Fine pale and antique-metal rims preserve the official silhouette. Deep indigo contour, restrained wine-red depth, and one subtle warm glint connect the cool official mark to Jeska's copper/red lighting.
- The title is supported only by a localized feathered indigo/wine radial atmosphere. No footer, banner, hard rule, rectangle, or featureless field is present.
- The final placement preserves Jeska's face, chest, weapon pose, and substantially more of her lower figure than v1, while clearing the 210 × 210-pixel lower-right seal zone.

## Counted sibling

- Created with `scripts/apply_deck_count.swift` using `2:1800`.
- The standard seal occupies x=1520–1730 and y=1820–2030 in top-left coordinates, retaining exactly 70 pixels of right and bottom inset.
- Visual inspection confirms the official wordmark and its shadow do not enter or compete with the seal.

## QA artifacts and result

Triptych order is always: retained v4 on the left, typography alternate v1 in the center, typography alternate v2 on the right.

- `qa_v4_vs_typography_alternates_v1_v2_full_size.png`: 5400 × 2100 full-height comparison.
- `qa_v4_vs_typography_alternates_v1_v2_drawer_scale_300x350.png`: three 300 × 350 panels, 900 × 350 total.
- `qa_v4_vs_typography_alternates_v1_v2_drawer_scale_360x420.png`: three 360 × 420 panels, 1080 × 420 total.

Full-size inspection confirms exact clean official contours, an unobstructed face, illustrated full bleed, smooth restrained materials, no hard footer, and clean seal clearance. Both drawer-scale comparisons confirm that v2 remains immediately readable and distinctive while feeling materially less obstructive and less heavy than v1.

## Technical verification

- Both finals: 1800 × 2100, non-interlaced 8-bit RGBA PNG, RGB/sRGB output, 600 × 600 DPI metadata.
- Base SHA-256: `2a0706b268fbbee6993ab993de5f919f66146d752e8417d261fca2c120f31a64`.
- Counted SHA-256: `04031cc736c816be1c72c0b1af6349063d9e89397d28ab729b64d1a37863944c`.
- ImageGen was not used; the revision is fully reproducible from retained official sources and deterministic Swift compositing.
