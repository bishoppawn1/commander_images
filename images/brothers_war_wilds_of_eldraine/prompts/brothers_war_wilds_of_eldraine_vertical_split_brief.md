# The Brothers' War | Wilds of Eldraine vertical-split production brief

## Purpose

Create one finished 3 x 3.5-inch drawer face for two chronologically ordered Commander releases: **THE BROTHERS' WAR** on the left and **WILDS OF ELDRAINE** on the right. The release counts are `2 | 2`.

## Selected retained inputs

- `../../brothers_war_commander/src/bro_oversized_art/bro_oversized_art_72x48_v1.pdf` — official WPN red-and-black artifact-war artwork by Antonio Bravo; full-bleed left-panel art.
- `../../brothers_war_commander/src/bro_alg_en/MTGBRO_EN_SetLogo_2line.png` — untouched official transparent stacked English set logo; exact deterministic left title.
- `../../wilds_of_eldraine_commander/src/wilds_of_eldraine_commander_imagegen_unmodified_v1.png` — accepted clean enchanted-forest artwork underlying the approved standalone Wilds target; full-bleed right-panel art.
- `../../wilds_of_eldraine_commander/src/woe_alg_en/MTGWOE_EN_SetLogo.png` — untouched official transparent stacked English set logo; exact deterministic right title.

## Locked composition

- Canvas: exactly 1800 x 2100 pixels, 600 x 600 DPI, sRGB RGB(A), edge-to-edge 6:7.
- Panels: exactly 900 pixels each. Earlier release on the left, later release on the right.
- Divider: one straight 6-pixel antique-gold line centered over the x=900 boundary, full height. No gutters, frames, extra borders, blended seam, or empty gap.
- Left crop: scale the full official PDF page height to 2100 pixels and focus at 61% of source width so the furnace-bright artifact creature owns the panel.
- Right crop: scale the accepted clean Wilds art to the full 2100-pixel height and center its fae ruler, crystal, wings, canopy, and forest texture.
- Titles: use only the retained official transparent logos. Remove fully transparent horizontal storage-canvas columns, then render each visible wordmark at 820 pixels wide, centered in its own half, with its bottom 310 pixels above the canvas bottom. Preserve the exact readable text `THE BROTHERS' WAR` and `WILDS OF ELDRAINE`.
- Contrast: place a transparent atmosphere-matched lower vignette behind each title, red-black on the left and indigo-black on the right. Retain visible art detail; do not introduce a blank title plate.
- Count-safe layout: title lockups remain above the standardized lower-right seal zones. Apply the standard 210-pixel seals only to a separate sibling with exact invocation arguments `2:900 2:1800`.

## Quality constraints

- Both set identities must be immediately legible at a 300 x 350 drawer preview.
- Preserve one clear focal subject in each half and useful detail through every edge.
- No large blank, white, flat, or featureless regions; no text generation; no commander montage; no extra logos; no extra panel boundaries.
- Preserve the unnumbered base and create the counted sibling non-destructively.

## Production mode

Deterministic CoreGraphics recomposition and official-logo compositing. **No new ImageGen call.** The Wilds background is the retained clean source that was previously created for the approved standalone target; it is reused unchanged as an input.
