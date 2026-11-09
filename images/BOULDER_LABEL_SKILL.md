---
name: artifact-template-mtg-commander-boulder-deck-label
description: "Create an image using the MTG Commander Boulder Deck Label template and its retained reference file. Use when the user selects this template, names MTG Commander Boulder Deck Label, or explicitly invokes $artifact-template-mtg-commander-boulder-deck-label. Create tall, print-ready MTG Commander deck-box labels with mana symbols, a large deck title, two concise strategy lines, and the product or set name."
---

# MTG Commander Boulder Deck Label

Create an image from this template. Keep the reference file unchanged.

## Workflow

1. Read `artifact-template.json` and resolve its paths relative to this skill directory.
2. Invoke $imagegen with the retained PNG as a reference image and the user's requested content as the edit or generation brief.
3. Treat the user's prompt and available sources as the content input. Do not invent factual claims merely to fill the composition.
4. Preserve the reference's visual language unless the user explicitly requests a deviation.
5. Visually inspect the generated image for fidelity and defects, then return the final image.

## Fidelity

Position the focal head center near the upper third of the canvas (about one-third down or two-thirds up), below the mana row and above the title; do not center the face vertically. Show the complete head, including hair, ears, horns, crowns and hats, with comfortable clearance from the cut border and every overlay. Mana symbols normally form one horizontally centered row at the top. Correct portrait position or scale instead of moving the mana row aside to accommodate an overly high head. Inspect final composed labels at print size: an uncropped source can still be obscured by symbols or type.

When correcting an existing collection, visually audit every current label first. Preserve labels that already satisfy these rules. Prefer deterministic placement/scale changes using retained artwork; regenerate or outpaint only where the retained source lacks necessary head detail or background. Preserve previous finished versions and record exactly which labels changed.

Include this composition requirement in each new art brief: "Reserve the upper 18% for a top-centered mana row; place the focal head center approximately 33% down the canvas, with clearance for hair, ears, horns and headwear. Keep the lower title area clear. No text or symbols in art-only output."

The reserved mana area is scene artwork, not a solid black header. Artwork must reach every edge inside the normal decorative/cut frame. If moving a short image downward leaves a black band or other empty area, use ImageGen to outpaint additional background above it and at any other exposed edge. Preserve approved character placement and likeness; keep typography and mana crisp in the compositor. Do not stretch, mirror or duplicate background strips to fill the gap. Audit the final composition specifically for exposed canvas and seams, and provide a table/list pairing every affected label with its before/after recreation.

Preserve the reference image's composition, visual hierarchy, palette, typography, material treatment, lighting, and recurring brand elements.

User instructions control requested content and explicit deviations. The retained reference controls layout and formatting where the user has not requested a change.

## Readability and lighting

Give every mana symbol a dark keyline and soft black halo so it separates from busy artwork while its glyph stays crisp. Shade the bottom typography with a feathered translucent black overlay behind all title, strategy and set-name lines; keep the underlying scene visible and focal faces clear.

Preserve the source art’s exposure, palette and medium. Default to restrained natural lighting and moderate saturation; do not add HDR, lifted shadows, contrast/saturation boosts, bright print-oriented exposure, bloom or extra rim light. Avoid automatic screen-lightening and color washes in compositors. Inspect final layered output for duplicate heads, joins and image gaps as well as source quality.

For this repository, use `images/<set>/Tops/` and `images/<set>/Fronts/`, with `src/` and `prompts/` inside each format. Shared assets live once, with relative symlinks from other sets. When the user requests a full refresh, rebuild/repack the whole PDF collection at existing physical sizes instead of accumulating addenda.

Treat the upper-third position as a photographic guideline, not a mandatory coordinate. Tall headwear, crests, expansive wings and large group or environmental scenes may justify lower faces. Preserve explicit user-approved exceptions and inspect full head clearance under the mana row. Move or uniformly scale the retained artwork first; leave compliant labels unchanged.

## Mana-identity borders

Use slow, continuous gradients through the deck’s mana identity for both colored border lines instead of fixed green or gold. Use only the colors represented by its mana row: warm ivory, blue, visible charcoal, red and green. Single-color decks use tonal shades of that color; colorless decks use silver-gray. Preserve the black outer cut edge, border widths, typography and artwork. This is a native compositor change, not a request to regenerate the art.
