# Secret Lair category face provenance

## Category authority

- Wizards of the Coast, **Secret Lair Recap**, 2019-11-26: https://magic.wizards.com/en/news/announcements/secret-lair-recap-2019-11-25
  - Wizards describes Secret Lair as a Magic brand built around collectible drops, "eye-popping designs," and many new art styles. This is the basis for a broad multi-style category face instead of a one-drop illustration.
- Official Secret Lair storefront: https://secretlair.wizards.com/us/en
  - Confirms the continuing product-line identity and current official Secret Lair branding.
- Wizards of the Coast, **Secret Lair Winter Superdrop 2025**, 2025-02-07: https://magic.wizards.com/en/news/announcements/secret-lair-winter-superdrop-2025
  - Official hero demonstrates the contemporary centered Secret Lair logo, black field, cream/antique-gold framing, and eclectic collectible-card presentation.
- Wizards of the Coast, **Secret Lair In an Elevator Superdrop**, 2024-07-26: https://magic.wizards.com/en/news/announcements/secret-lair-in-an-elevator-superdrop
  - Official hero demonstrates the brand's use of radically different art treatments around one centered category logo.

## Raw official source files

### `official_2019_secret_lair_packaging.jpg`

- Direct URL: https://media.wizards.com/2019/images/daily/BgNr6kxq7b.jpg
- Linked by: https://magic.wizards.com/en/news/announcements/secret-lair-recap-2019-11-25
- Publisher: Wizards of the Coast
- Original dimensions: 850 x 478 px
- Embedded metadata on download: 72 x 72 DPI
- Content: official black Secret Lair Drop Series launch package with cream/gold wordmark, subtle planeswalker emblems, and theatrical warm backlight.
- Role: brand-history, wordmark, and luxury black/gold presentation reference.
- Transformation: none; untouched download retained in `src/`.

### `official_2025_winter_superdrop_hero.webp`

- Direct URL: https://media.wizards.com/2025/images/daily/uOIL4WSqCk.webp
- Linked by: https://magic.wizards.com/en/news/announcements/secret-lair-winter-superdrop-2025
- Publisher: Wizards of the Coast
- Original dimensions: 1920 x 550 px
- Embedded metadata on download: 72 x 72 DPI
- Content: official Winter Superdrop hero with a large centered cream Secret Lair logo, deep black field, thin antique-gold frame, and assorted differently styled cards.
- Role: primary contemporary logo and category-marketing composition reference; also the source for an exact deterministic logo overlay if generated lettering needs correction.
- Transformation: none; untouched download retained in `src/`.

### `official_2024_inside_elevator_superdrop.png`

- Direct URL: https://media.wizards.com/2024/images/daily/SLD9fT9BFyYYN.png
- Linked by: https://magic.wizards.com/en/news/announcements/secret-lair-in-an-elevator-superdrop
- Publisher: Wizards of the Coast
- Original dimensions: 1920 x 500 px
- Embedded metadata on download: 72 x 72 DPI
- Content: official superdrop hero with centered cream Secret Lair logo, black/gold frame, and a deliberate mixture of painterly, graphic, retro, humorous, and surreal card treatments.
- Role: supporting reference for eclectic alternate-art breadth.
- Transformation: none; untouched download retained in `src/`.

## Generated and finished assets

### `secret_lair_category_imagegen_v1_unmodified.png`

- Generation mode: built-in ImageGen, one new-image generation using all three official files above as labeled visual references.
- Exact generation prompt: recorded verbatim under **Built-in ImageGen prompt** in `../prompts/secret_lair_category_face_v1_prompt.md`.
- Original generated dimensions: 1163 x 1353 px.
- Original generated metadata: 72 x 72 DPI.
- Content: an original, densely filled black-and-antique-gold gallery/vault of varied alternate-art windows, with an exact two-line Secret Lair title in the center. The panes span crystalline fantasy, monochrome ink, jewel-toned geometric collage, painted fire, cute storybook animal art, retro-futurist screenprint, stained glass, and metallic fantasy.
- Preservation: unmodified ImageGen output copied into `src/`; not treated as the print target.

### `secret_lair_category_alternate_art_vault_v1_1800x2100.png`

- Location: finished target in the `images/secret_lair/` directory root.
- Dimensions: 1800 x 2100 px, exact 6:7 portrait.
- Resolution metadata: 600 x 600 DPI.
- Count treatment: intentionally **unnumbered**. No deck-count marker, seal, corner badge, or numeral was added because the authoritative inventory supplies no owned count for this open-ended category.
- Transformations:
  1. Center-cropped the 1163 x 1353 generated source by three horizontal pixels to exact 6:7.
  2. Resampled to 1800 x 2100 using Lanczos scaling, with a slight print-oriented contrast and saturation refinement.
  3. Covered the generated title region with an opaque, finely gold-framed black-lacquer plaque so only one title remains.
  4. Extracted the exact centered official cream Secret Lair logo from untouched `official_2025_winter_superdrop_hero.webp`, keyed away its black field, resized it to 1450 px wide, and centered it on the plaque. This makes the title occupy 91% of the 1600-px print-safe title band.
  5. Wrote 600-DPI PNG metadata.
- Reproducible finishing script: `finalize_secret_lair_face.sh` in `src/`.
- Drawer-scale QA preview: `secret_lair_category_alternate_art_vault_v1_drawer_preview_300x350.png` in `src/`.

## Final QA

- Exact identification text: visual inspection confirms `SECRET LAIR`, spelled correctly and shown exactly once.
- Category identity: the many clearly different art languages communicate the continuing eclectic line, while no named drop, specific crossover logo, or single dominant character claims the face.
- Drawer readability: the official cream wordmark has a clean black silhouette and remains immediately legible at the retained 300 x 350 preview scale.
- Title scale: 1450 px wide on the 1800-px target; nearly all of the usable print-safe width.
- Fullness/density: detailed art, foil-like objects, frames, and ornament reach every edge; the central dark plaque is occupied by the oversized title and etched grid, with no large empty white or featureless area.
- Marker check: no circular count seal, numeral, badge, or invented marker is present.
- Print specification: verified 1800 x 2100 px and 600 x 600 DPI with macOS image metadata inspection.
- Directory hygiene: the category root contains only the finished PNG plus `prompts/` and `src/`.
