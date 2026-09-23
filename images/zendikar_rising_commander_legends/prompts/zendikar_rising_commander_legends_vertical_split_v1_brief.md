# Zendikar Rising | Commander Legends — chronological vertical split v1

Production mode: deterministic compositing from retained approved 900 × 2100 panels. No ImageGen call, prompt, or model is used for this repair.

- Left: exact approved `ZENDIKAR RISING` panel; marker `2`.
- Right: exact approved `COMMANDER LEGENDS` panel; marker `2`.
- Canvas: 1800 × 2100 sRGB PNG at 600 DPI.
- Layout: two equal 900-pixel panels and exactly one straight six-pixel antique-gold divider centered on x = 900.
- Preserve panel art and typography exactly; do not blend, regenerate, crop, stretch, or add a second divider.
- Create an unnumbered base and a counted sibling with `2:900 2:1800`.
- Create canonical 1724 × 2024 black-margin masters at 600 DPI and 4138 × 4858 derivatives at 1440 DPI for both.

Build the base with `scripts/build_chronological_pair_faces.swift`, then use the standard count and print-derivative scripts documented in `AGENT.md`.
