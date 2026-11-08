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

Keep the focal face near the center of the artwork, below the mana row and above the title. Show the complete head, including hair, ears, horns, crowns and hats, with comfortable clearance from the cut border and every overlay. Mana symbols normally form one horizontally centered row at the top. Correct portrait position or scale instead of moving the mana row aside to accommodate an overly high head. Inspect final composed labels at print size: an uncropped source can still be obscured by symbols or type.

When correcting an existing collection, visually audit every current label first. Preserve labels that already satisfy these rules. Prefer deterministic placement/scale changes using retained artwork; regenerate or outpaint only where the retained source lacks necessary head detail or background. Preserve previous finished versions and record exactly which labels changed.

Include this composition requirement in each new art brief: "Reserve the upper 18% for a top-centered mana row; place the complete focal head within the central artwork area, typically 22–52% down the canvas, with clearance for hair, ears, horns and headwear. Keep the lower title area clear. No text or symbols in art-only output."

The reserved mana area is scene artwork, not a solid black header. Artwork must reach every edge inside the normal decorative/cut frame. If moving a short image downward leaves a black band or other empty area, use ImageGen to outpaint additional background above it and at any other exposed edge. Preserve approved character placement and likeness; keep typography and mana crisp in the compositor. Do not stretch, mirror or duplicate background strips to fill the gap. Audit the final composition specifically for exposed canvas and seams, and provide a table/list pairing every affected label with its before/after recreation.

Preserve the reference image's composition, visual hierarchy, palette, typography, material treatment, lighting, and recurring brand elements.

User instructions control requested content and explicit deviations. The retained reference controls layout and formatting where the user has not requested a change.
