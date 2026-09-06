# The Brothers' War | Wilds of Eldraine split-face QA

Validated 2026-08-26.

## Automated validation

`qa_validate.swift` passed both finished targets:

- Exact 1800 x 2100 pixel dimensions and 6:7 aspect ratio.
- 600 x 600 DPI metadata.
- sRGB color space and RGB color model; files are 8-bit RGBA, non-interlaced PNGs.
- Exact 900-pixel left and right source panels.
- One constant 6-pixel full-height divider at x=897...902, centered over the exact x=900 boundary; adjacent columns are not divider pixels.
- Standard 210-pixel seal centers at bottom-origin `(725,175)` and `(1625,175)`.
- Standard core seal rectangles at x=620...829 and x=1520...1729, bottom-origin y=70...279, giving exact 70-pixel right and bottom insets.
- Counted/base pixel changes are confined to the two seal/shadow envelopes. Observed top-left-coordinate diff bounds are left x=610...839, y=1816...2046 and right x=1509...1740, y=1816...2046.

## Visual inspection

- Inspected the unnumbered and counted files at full resolution.
- Inspected both `300 x 350` drawer previews in `src/`.
- `THE BROTHERS' WAR` is exact, large, crisp, unobstructed, and readable as a three-line official lockup in the left half.
- `WILDS OF ELDRAINE` is exact, large, crisp, unobstructed, and readable as a two-line official lockup in the right half.
- The count seals do not touch either title or obscure either focal subject.
- The red/black mechanical-art left half and teal/indigo fairy-tale right half remain visually independent and atmosphere-matched.
- The artifact creature and fae ruler each remain clear at drawer scale.
- Artwork and textured vignettes fill every edge; there is no blank, white, flat, or low-information region.
- The divider is a single deliberate line with no gutter, second border, inner frame, or blended seam.

## Deterministic reproduction

The base was rebuilt in a fresh `/tmp/bro_woe_split_qa.*` directory with the documented command and the counted sibling was regenerated with exact arguments `2:900 2:1800`. Byte-for-byte `cmp` checks returned:

```text
base_cmp=0 counted_cmp=0
```

The reproduced outputs therefore match both delivered PNGs exactly.

## Legacy integrity

The four approved standalone targets retain their pre-build SHA-256 values:

- Brothers' War base: `dcd0cd8b61bae6fb815871179fbd6b51c88302b096602a51872e832490f73f21`
- Brothers' War counted: `f2b15e3bc18b5b438f805b5af24136668518bf325025f8964b190024039ffdec`
- Wilds of Eldraine base: `746baf6bb8a0925b0d4d6a1a621bb0383ff948b965756b3a68b76b9eca4d1046`
- Wilds of Eldraine counted: `3a2f4c831df19fa39a34623a5436cb0a4346c195fd499bfaa091569818c1c2fe`

The four selected retained inputs also match the SHA-256 values recorded in `sources.md`. No legacy source or standalone target was edited.

## Folder hygiene

The combined directory root contains exactly the two finished target PNGs plus `prompts/` and `src/`. The finalized brief is in `prompts/`; build helper, validator, previews, provenance, and this QA record are in `src/`. `AGENT.md` and `INVENTORY.md` were not modified.
