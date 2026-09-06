# Strixhaven Commander official-key-art portrait-extension brief

## Production mode

Built-in ImageGen edit/outpainting followed by a deterministic, non-destructive print adaptation. The generated stage extends official Strixhaven key art into a full portrait composition; the exact official set logo is applied afterward from the retained transparent Wizards asset so the drawer-identification text is verbatim and print-crisp.

## Input images and roles

- `../src/strixhaven_official_key_art.jpg` — primary edit target. Preserve Rowan Kenrith and Will Kenrith, their poses and recognizable faces, the red-and-blue spell effects, the owl, loose pages, library shelving, and the established polished Magic fantasy-painting look.
- `../src/stx_wpn_poster_preview.jpg` — official Wizards Play Network composition reference. Use only its vertically layered, dark-academia Strixhaven atmosphere and full-frame density as guidance; do not reproduce its surrounding white webpage margin and do not turn the image into a five-lead montage.
- `../src/strixhaven_official_campus_map.jpg` — supporting setting reference for the university's tall arches, libraries, towers, and five-college visual language. Do not imitate its flat infographic style or its pale empty background.
- `../src/strixhaven_official_set_logo.png` — deterministic title overlay, not a generative input. Preserve its exact integrated wording: `STRIXHAVEN` and `SCHOOL OF MAGES`.
- `../src/strixhaven_official_set_symbol.png` — provenance/reference asset only; do not add a redundant symbol when the official logo already provides complete identification.
- `../src/commander_2021_official_five_deck_product_lineup.png` — product-identity reference only. It verifies the five-college Commander packaging; do not composite boxes or photographed product into the artwork.

## Final ImageGen edit prompt

Use case: precise-object-edit

Asset type: print-ready 3 by 3.5 inch portrait MTG drawer-identification face-card artwork

Primary request: Extend Image 1, the official Strixhaven key art, into a seamless full-bleed 6:7 portrait fantasy illustration. Preserve Rowan Kenrith and Will Kenrith as the only two principal figures and keep their recognizable faces, poses, costumes, and red-versus-blue spellcasting interaction. Expand the university library vertically above and below them with tall dark bookcases, Gothic academy arches, hanging amber lamps, loose parchment, and subtle arcane filigree that naturally continues the source image. Image 2 is an official WPN poster used only for its dense vertical dark-academia composition. Image 3 is a campus-setting reference used only for Strixhaven architectural language.

Scene/backdrop: a grand, vertically soaring Strixhaven library interior at night, filled edge to edge with carved dark wood, books, warm lamps, scrolls, magical pages, and deep architectural detail.

Subject: Rowan on the lower-left/front casting vivid red-orange lightning; Will on the lower-right/back shaping a cool blue water spell; the owl flying above them. Preserve the original hierarchy and interaction rather than adding more students or commanders.

Style/medium: polished high-detail Magic fantasy key art; painterly realism; crisp faces, hands, fabric, book edges, owl feathers, sparks, and water; faithful to the official source's finish and palette.

Composition/framing: exact portrait intent, 6:7 crop-safe. Keep both figures comfortably within the central and lower-middle frame. Reserve a visually active but relatively calm dark-architectural band across the upper quarter for a later official title overlay. The upper band must still contain meaningful shelves, arches, lamps, particles, and texture—never blank space. Keep the lower-right corner noncritical enough for a later 210-pixel count seal.

Lighting/mood: warm amber library light crossed by intense red lightning and luminous blue water; scholarly, theatrical, prestigious, magical.

Color palette: near-black walnut, parchment ivory, antique gold, ruby red, electric orange, sapphire blue, and cool cyan.

Constraints: change only the framing and surrounding environment needed for the portrait extension; preserve the two principal figures and their spell effects; edge-to-edge image information; no white or featureless background; no border; no frame; no product packaging; no five-commander or five-student montage; no added people; no cropped faces or hands; no repeated subjects; no logos; no letters; no words; no watermark. Leave all typography for the deterministic production pass.

Avoid: blank sky, large empty walls, washed-out corners, flat infographic styling, tiny distant characters, unreadable pseudo-text, extra owls, extra hands, malformed faces, duplicated books, or a decorative card border.

## Deterministic print adaptation

Crop/reframe the selected unmodified ImageGen output to exact 1800 by 2100 pixels in sRGB, retaining full bleed. Add a restrained dark top vignette only as needed for contrast. Center the transparent official Wizards `STRIXHAVEN / SCHOOL OF MAGES` logo across nearly the full usable width with approximately 90–110 pixels of left/right print-safe clearance. The logo is the dominant information element and must remain unobstructed. Write 600-DPI PNG metadata.

Preserve the unnumbered base unchanged. The standalone Strixhaven drawer displays all five owned Commander decks. Create its separately named counted sibling with `scripts/apply_deck_count.swift` using `5:1800`, giving the standard 210-pixel seal equal 70-pixel right and bottom insets.
