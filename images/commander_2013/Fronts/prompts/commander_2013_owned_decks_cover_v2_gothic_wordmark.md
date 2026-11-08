# Commander 2013 — Gothic wordmark typography alternate

Use case: precise-object-edit

Asset type: typography-focused alternate for a premium 3 x 3.5-inch portrait drawer-face cover

Primary request: Preserve the successful two-owned-deck Oloro/Jeleva composition from the finished v1 base and replace only its generic pale metallic serif title with an exact, deterministic, era-authentic Gothic title treatment.

Input images and assets:

- Image 1 / edit target: `../commander_2013_eternal_bargain_mind_seize_premium_cover_v1.png`; preserve the full composition, character identities, lighting, palette, framing, and lower-right seal-safe area.
- Image 2 / official branding reference: `../src/official_eternal_bargain_packaging_wizards.jpg`; use only to confirm the 2013 retail product's silver Commander branding and Esper-aligned packaging atmosphere.
- Image 3 / official branding reference: `../src/official_mind_seize_packaging_wizards.jpg`; use only to confirm the same official retail treatment and Grixis-aligned color atmosphere.
- Font asset: `../src/PirataOne-Regular.ttf`; deterministic Gothic display face used because the official product photographs contain only a very small raster `MAGIC / COMMANDER` mark and no clean, standalone, exact `COMMANDER 2013` lockup suitable for 600-DPI printing.
- Build file: `../src/build_commander_2013_gothic_wordmark.swift`; exact deterministic title, cartouche, metal, texture, and 600-DPI output implementation.

Text (verbatim): "COMMANDER 2013"

Typography: Set the title exactly once, horizontally in one line, all uppercase, with Pirata One's narrow blackletter forms. Spell exactly C-O-M-M-A-N-D-E-R, space, 2-0-1-3. Use large carved dark-silver lettering with black-iron depth, an antique-silver bevel, crisp light edge, and restrained wear. Apply a subtle cool-blue energy cast across the left/Esper side and a subtle crimson cast across the right/Grixis side while keeping every glyph high-contrast and immediately legible.

Integration: Fully conceal the previous title with an opaque blackened-metal Gothic cartouche shaped with pointed ends and bowed medieval edges rather than a modern rectangular text box. Add restrained engraved wear, a layered antique-metal rim, and one blue and one red end rivet so the title feels forged into the illustrated world. Retain a clean silhouette and comfortable print-safe inset.

Composition/framing: Keep the exact 1800 x 2100, 6:7 composition. The replacement title remains in the existing upper-middle title zone between the two leads. Do not cover Jeleva's face or hands, Oloro's face, torso, or hands, or the lower-right count-seal zone.

Constraints: change only the title region; preserve the two-lead composition substantially; no ImageGen repaint; no extra text; no subtitle; no deck names; no Magic logo; no card frames; no package mockup; no watermark; no modern rectangle; no duplicated subjects; no title misspelling; no seal in the unnumbered base.

Avoid: generic Trajan-like serif lettering, default serif styling, thin type, smooth modern gradients, flat contemporary labels, illegible blackletter, oversized ornament that competes with the words, bright saturated neon, or any change to the characters and full-frame artwork outside the title zone.

Output intent: One new non-destructive unnumbered base at exact 1800 x 2100 pixels with 600-DPI metadata, followed by a separately named counted sibling produced with the standard 210-pixel deck-count seal at exact 70-pixel right and bottom insets and marker value `2`.
