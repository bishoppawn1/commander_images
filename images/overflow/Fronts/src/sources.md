# Overflow — sources and production record

Produced 2026-08-31 as an open-ended storage-category face. Overflow has no fixed deck count and therefore intentionally has no number seal.

## Generation

- Mode: built-in ImageGen, `stylized-concept` workflow.
- Finalized prompt: `../prompts/overflow_abstract_magical_vault_brief.md`.
- Unmodified raw output: `imagegen_abstract_magical_overflow_raw.png`, 1163 × 1353 pixels at 72 DPI.
- Raw SHA-256: `bc336b74a2683b4ca4d1dc5eea1d484f47b20baf86c1a046306cb37e20692dff`.
- The exact built-in prompt is preserved verbatim in the finalized prompt brief.

## Deterministic construction

- Build script: `build_overflow_target.swift`.
- Cropped the raw generation minimally at `x=1, y=0, width=1160, height=1353` and resampled it to exact 1800 × 2100 sRGB with 600-DPI metadata.
- Added a restrained central contrast veil and deterministic exact `OVERFLOW` lettering. The pale-ivory face, cyan rim, magenta extrusion, and deep shadow remain legible at drawer scale without creating an empty title box.
- No count seal was applied.

## Finished targets

| File | SHA-256 |
| --- | --- |
| `../overflow_abstract_magical_vault_target_v1_1800x2100.png` | `30f03125d089b0aa26dc9ee67c65c9211ab05c6d812b941e78f26416aac8a5b1` |
| `../overflow_abstract_magical_vault_target_v1_1724x2024_black_margin_1_8in.png` | `dd661eabb8f3b54474e6e76c0419d873c3b5dfd1b6c768686009a6339ac8bd9c` |

QA confirmed exact dimensions and DPI, exact title spelling, immediate 300 × 350 drawer-scale legibility, dense useful detail at every edge, no characters or product-specific identity, and the standard black-margin geometry.
