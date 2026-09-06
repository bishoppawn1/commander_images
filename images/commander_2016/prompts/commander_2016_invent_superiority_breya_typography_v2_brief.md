# Commander 2016 — Invent Superiority / Breya typography v2 brief

Production mode: deterministic CoreGraphics/CoreText typography and compositing. No new ImageGen generation or edit is needed because the existing v1 raw portrait artwork is the strongest part of the candidate and must remain substantially unchanged.

## Input roles

- `../src/commander_2016_invent_superiority_breya_v1_imagegen_raw.png`: retained unmodified artwork source and composition anchor. Preserve Breya, her face, pose, Etherium armor, thopters, palette, lighting, arcane architecture, and full-frame density.
- `../src/commander_2016_invent_superiority_official_packaging_reference.jpg`: authentic Commander 2016 / Invent Superiority retail-package reference. Use only to establish that the 2016 product identity used a bold serif `COMMANDER` wordmark and a fantasy-serif deck name, not a wide-tracked modern sans label.
- `../src/cinzel_decorative_black.ttf`: deterministic display-face source for the alternate. Use its angular classical capitals, ornamental terminals, and strong serif silhouette as the basis for a set-native artifact treatment. The clean official package lockup is not extracted because the surviving package reference is a photographed/rasterized product view rather than a clean, sufficiently large wordmark asset.

## Exact visual brief

Use case: text-localization

Asset type: print-ready removable-drawer face, 3 × 3.5 inches

Primary request: replace the v1 typography system while preserving the v1 Breya/Esper artwork and overall composition. Remove both generic black office-sign rectangles and all wide-tracked sans lettering. Build a deterministic title treatment that reads as forged Etherium filigree integrated into the existing arcane-metal setting.

Text (verbatim): `COMMANDER 2016`

Secondary text (verbatim): `INVENT SUPERIORITY`

Primary typography: stack `COMMANDER` over `2016` as one dominant lockup. Use Cinzel Decorative Black glyph outlines with a crisp black outer silhouette, antique-gold rim, dark-blue engraved keyline, and silver/ivory/gold/cyan metallic face. Add restrained magenta carmot edge light. Let `COMMANDER` span nearly the full print-safe width. Keep `2016` centered, large, and immediately associated with the wordmark.

Secondary typography: retain `INVENT SUPERIORITY` as a clearly subordinate but drawer-readable line near the lower-left/center, ending before the standard lower-right count-seal zone. Use the same engraved Etherium material system at smaller scale.

Integration: use open, symmetrical filigree rules, curves, and small diamond/carmot nodes rather than a filled plaque or rectangle. Add only soft atmospheric top/bottom vignettes to support contrast; preserve visible artwork behind and around the lettering.

Composition/framing: exact 1800 × 2100 pixels, exact 6:7 portrait aspect ratio, sRGB, 600-DPI metadata. Preserve the existing two-pixel center crop from 1162 × 1353 to 1160 × 1353 before resizing. Keep Breya's face completely clear and the title inside a comfortable approximately 5% safe inset. Reserve the exact standard 210-pixel count seal at 70-pixel right/bottom insets.

Constraints: exact spelling; no generated text; no modern sans; no wide tracking; no generic gold office lettering; no filled black label rectangle; no pasted-on sign; no new character or art generation; no modification to Breya's face, anatomy, costume, spell hand, or surrounding thopters; no large blank areas; no reduction in drawer-scale legibility.

## Deterministic production

Run:

```sh
/usr/bin/swift images/commander_2016/src/build_commander_2016_typography_v2.swift \
  images/commander_2016/src/commander_2016_invent_superiority_breya_v1_imagegen_raw.png \
  images/commander_2016/src/cinzel_decorative_black.ttf \
  images/commander_2016/commander_2016_invent_superiority_breya_typography_v2_1800x2100.png \
  images/commander_2016/src/commander_2016_invent_superiority_breya_typography_v2_drawer_preview.png

/usr/bin/swift scripts/apply_deck_count.swift \
  images/commander_2016/commander_2016_invent_superiority_breya_typography_v2_1800x2100.png \
  images/commander_2016/commander_2016_invent_superiority_breya_typography_v2_deck_count_1_1800x2100.png \
  1:1800
```

The counted sibling must retain the standard 210-pixel seal with exact 70-pixel right and bottom insets. Preserve both v1 finished targets and the new unnumbered v2 base.
