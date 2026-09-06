# The Lord of the Rings: Tales of Middle-earth Commander — official WPN poster adaptation brief

## Mode and intended use

- Use case: precise deterministic raster adaptation of existing licensed key art.
- Asset type: 3 × 3.5-inch portrait drawer-face card for the complete four-deck The Lord of the Rings: Tales of Middle-earth Commander release.
- Production mode: preserve Wizards Play Network's official Justyna Dura poster art; crop the strongest full-art upper 6:7 region; add an exact, drawer-readable title treatment without regenerating the licensed artwork.
- Built-in ImageGen decision: not used. The official WPN poster already supplies a strong vertical composition, useful detail to every edge, and unmistakable set identity. A deterministic crop and typography pass is sufficient and preserves the licensed art more faithfully than regeneration.
- Exact dominant identification text, rendered verbatim once: `THE LORD OF THE RINGS: TALES OF MIDDLE-EARTH`.

## Retained inputs and roles

- `src/ltr_lgp_key_24x36_en.pdf`: **official source/edit anchor**. Wizards Play Network English 24 × 36-inch vertical key-art poster, credited in its footer to Justyna Dura.
- `src/ltr_lgp_key_24x36_en_preview.png`: **direct production source**. Unmodified 75-PPI page rasterization at 1800 × 2700 pixels.
- `src/ltr_alg_en.zip` and `src/ltr_alg_en/*`: official WPN key-art/logo package and extracted comparison references. The supplied logo omits the canonical colon as a stylized stacked lockup, so it is retained for brand reference rather than composited as the primary title.
- `src/ltr_key_art_sma_en.zip` and `src/ltr_key_art_sma_en/*`: official WPN social crops inspected as alternate candidates. The 1080 × 1920 portrait has large featureless black regions; the square and wide versions require more reconstruction than the poster.
- `src/ltr_oversized_art.zip` and `src/ltr_oversized_art/*`: official alternate set-art comparisons. These are landscape environmental pieces and are less immediately drawer-readable than the branded Justyna Dura key art.
- `src/ltr_pds_en.zip` and `src/commander_product_shots/*`: untouched official product-shot archive plus extracted Commander deck packaging references. They verify the four-deck licensed product identity but are not composited because the requested face should favor set-level identity over a forced four-commander montage.

## Final composition

- Use the upper `x=0, y=0, width=1800, height=2100` region of the 1800 × 2700 poster raster. This preserves the official Magic and Universes Beyond branding, the Frodo/Gollum split portrait, the One Ring, Mount Doom, and detailed foreground lava while excluding the poster's low title/footer area that would collide with the standardized count seal.
- Preserve the official focal artwork without generative edits, subject replacement, invented characters, or scene extension.
- Place a translucent oxblood-black title plate at displayed coordinates `x=45, y=1490, width=1710, height=320`. Keep the underlying mountains and lava faintly visible so the plate remains integrated rather than becoming an empty footer.
- Render the exact title on two centered lines in pale antique gold Copperplate Bold with a dark brown outline and subtle black shadow:
  - `THE LORD OF THE RINGS:`
  - `TALES OF MIDDLE-EARTH`
- Fit each line independently to a maximum width of 1640 pixels so both lines span almost the entire usable width while retaining 80-pixel left/right print-safe margins.
- Keep the complete title above the count-seal footprint. The counted sibling receives one `4` marker occupying `x=1520–1730, y=1820–2030`, leaving exactly 70 pixels at the right and bottom outer edges.

## Output constraints

- Finished base: exactly 1800 × 2100 pixels (6:7), PNG, 8-bit RGB/RGBA, non-interlaced, with 600 × 600 DPI metadata.
- Full bleed with useful licensed artwork to every edge; no white border, blank field, featureless block, commander montage, watermark, invented logo, or pseudo-text.
- Dominant identification must read exactly `THE LORD OF THE RINGS: TALES OF MIDDLE-EARTH`, once, at immediate drawer-viewing scale. The colon is part of the canonical title; a terminal sentence period is not part of the product name and is not rendered.
- Preserve the unnumbered base unchanged. Create a separately named counted sibling with `scripts/apply_deck_count.swift` using `4:1800`; never overwrite the base.

## Target filenames

- `lord_of_the_rings_tales_of_middle_earth_commander_official_wpn_poster_target_v1_1800x2100.png`
- `lord_of_the_rings_tales_of_middle_earth_commander_official_wpn_poster_target_v1_deck_count_4_1800x2100.png`
