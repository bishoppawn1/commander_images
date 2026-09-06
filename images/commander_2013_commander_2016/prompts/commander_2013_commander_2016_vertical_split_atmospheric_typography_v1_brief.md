# Commander 2013 | Commander 2016 — optional vertical split v1

Production mode: deterministic CoreGraphics/CoreText recomposition from the accepted standalone artwork sources. No new ImageGen call is needed for the combined candidate.

Use case: compositing

Asset type: optional combined 3 × 3.5-inch removable-drawer face

## Scope

Create an optional combined face without replacing either standalone release face or changing the project's standalone grouping policy. Commander 2013 owns the left 900-pixel panel; Commander 2016 owns the right 900-pixel panel. Use one straight, narrow, high-contrast vertical divider centered at x = 900. Do not use an empty gutter, second border, blended center seam, or shared atmosphere.

Owned-deck counts represented by the final seals:

- Commander 2013: `2` — Eternal Bargain and Mind Seize.
- Commander 2016: `2` — Invent Superiority and Breed Lethality.

## Input roles

- `../src/commander_2013_v3_title_free_raw.png`: accepted clean Commander 2013 v3 art source. Preserve Jeleva and Oloro, their faces and identities, cool Esper waterfall/throne atmosphere, red-violet Grixis night atmosphere, moon, veil, and Gothic architecture. This input has no readable title.
- `../src/commander_2016_breya_artwork_raw.png`: retained Commander 2016 Breya/Esper artifact artwork source. Preserve Breya's face, Etherium filigree, spell energy, thopters, artifact arches, and blue/magenta/silver palette.
- `../src/AlegreyaSC-Medium.ttf`: accepted Commander 2013 v3 title face. Rebuild the open, non-Gothic pale-silver identity at half-panel scale.
- `../src/cinzel_decorative_black.ttf`: accepted Commander 2016 typography v2 face. Rebuild the engraved Etherium identity at half-panel scale.

## Exact identification

Left text (verbatim): `COMMANDER 2013`

Right text (verbatim): `COMMANDER 2016`

Both identifications must be stacked as `COMMANDER` above the four-digit year, appear exactly once, remain horizontal, and read immediately at drawer scale.

## Panel treatment

### Commander 2013 — left

- Recompose rather than squeeze the full standalone face. Use two coordinated horizontal focal crops from the clean v3 art: Jeleva owns the upper atmosphere and Oloro owns the lower throne.
- Feather the focal transition deterministically through the mist/veil title zone so there is no additional hard line within the panel.
- Use the accepted v3 open Alegreya SC Medium wordmark: pale ivory/silver face, fine graphite edge, quiet shadow, and no plaque, frame, bevel slab, or blackletter.
- Place the lockup in the natural atmospheric interval between Jeleva and Oloro without obscuring either face or Jeleva's hands.
- Retain the accepted faint cyan and muted crimson hairlines flanking `2013`; they are atmospheric accents, not a border.

### Commander 2016 — right

- Recompose the clean Breya artwork as a narrow portrait crop centered on Breya, keeping her face clear and the artifact environment full-bleed.
- Use the approved v2 Cinzel Decorative Black/Etherium direction: angular ornamental serif contours, crisp dark silhouette, antique-gold rim, silver/ivory/gold/cyan engraved face, and restrained carmot edge light.
- Use open filigree rules around the stacked title; no filled plaque or generic black office-sign rectangle.
- Keep `2016` clear of Breya's face and subordinate to `COMMANDER` while remaining drawer-readable.

## Output constraints

- Exact 1800 × 2100 pixels, exact 6:7 portrait, sRGB, 600-DPI PNG.
- Exactly two equal 900-pixel art panels.
- Exactly one straight 6-pixel pale-gold divider centered on x = 900 and overlaid equally across the panel boundary.
- Full bleed with no extra gutters, outer borders, panel frames, or blank regions.
- No extra text, deck names, logos, cards, product boxes, watermarks, or repeated title layers.
- Preserve all standalone files and keep all combined work within `images/commander_2013_commander_2016/`.
- Counted sibling uses the standard 210-pixel seals with exact 70-pixel bottom clearance: `2:900` for the left panel and `2:1800` for the right panel.
- The counted filename must include `_vertical_split_` and `_deck_counts_2_2`.

## Deterministic build

```sh
/usr/bin/swift images/commander_2013_commander_2016/src/build_commander_2013_commander_2016_vertical_split.swift \
  images/commander_2013_commander_2016/src/commander_2013_v3_title_free_raw.png \
  images/commander_2013_commander_2016/src/commander_2016_breya_artwork_raw.png \
  images/commander_2013_commander_2016/src/AlegreyaSC-Medium.ttf \
  images/commander_2013_commander_2016/src/cinzel_decorative_black.ttf \
  images/commander_2013_commander_2016/commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_1800x2100.png \
  images/commander_2013_commander_2016/src/commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_drawer_preview.png

/usr/bin/swift scripts/apply_deck_count.swift \
  images/commander_2013_commander_2016/commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_1800x2100.png \
  images/commander_2013_commander_2016/commander_2013_commander_2016_vertical_split_atmospheric_typography_v1_deck_counts_2_2_1800x2100.png \
  2:900 2:1800
```

The unnumbered base must remain preserved beside the counted sibling.
