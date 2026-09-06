# The Lord of the Rings: Tales of Middle-earth Commander — official-wordmark typography alternate v2 brief

## Mode and intended use

- Use case: precise deterministic raster compositing over retained licensed key art.
- Asset type: 3 × 3.5-inch portrait drawer-face card for the complete four-deck The Lord of the Rings: Tales of Middle-earth Commander release.
- Production mode: preserve the official Wizards Play Network Justyna Dura poster crop and its existing Magic: The Gathering / Universes Beyond branding; replace only the v1 geometric sans title-plate solution with the official engraved The Lord of the Rings set wordmark plus minimal ember/smoke support.
- Built-in ImageGen decision: not used. The task is typography-focused, the strong official focal art must remain unchanged, and a clean official raster wordmark is already retained locally. Deterministic extraction and compositing provide exact text control and preserve the licensed art.
- Exact dominant identification, read as one official stacked lockup: `THE LORD OF THE RINGS: TALES OF MIDDLE-EARTH`.

## Retained inputs and roles

- `src/ltr_lgp_key_24x36_en_preview.png`: **official source/edit anchor and direct art input**. Unmodified 1800 × 2700 rasterization of the Wizards Play Network 24 × 36-inch key-art poster, credited in its footer to Justyna Dura.
- `src/ltr_alg_en.zip`: **official provenance master**. Retained untouched Wizards Play Network English art/logo archive.
- `src/ltr_alg_en/MTGLTR_EN_SetLogo_LockUp.png`: **official logo source**. Retained unchanged 900 × 407 transparent PNG containing Magic, Universes Beyond, and the official engraved English set-title wordmark.
- `src/MTGLTR_EN_SetTitle_Wordmark_extracted_v2.png`: **direct typography input**. Exact transparent crop `x=149, y=198, width=601, height=209` from the retained official logo source; no redrawing, recoloring, generative reconstruction, or text substitution. The crop includes the official fine rule/central diamond and the canonical hyphen in `MIDDLE-EARTH`.
- All other retained official social crops, oversized art, set-symbol files, Commander packaging, PDFs, ZIP archives, and the official Commander details DOCX remain comparison/provenance inputs only. They are not composited.

## Composition and typography lock

- Begin with the same exact upper `x=0, y=0, width=1800, height=2100` crop used by the preserved v1 target. Do not alter, regenerate, repaint, extend, or replace any of Justyna Dura's focal art.
- Keep the official Magic: The Gathering and Universes Beyond branding in its original position and pixels.
- Remove the v1 hard oxblood plaque and generic geometric/Copperplate title lettering from this alternate.
- Add only a soft edge-fading black/oxblood ember-smoke veil centered behind the title area. It must have no hard rectangle, rounded-box silhouette, or opaque footer and must allow the underlying mountains, travelers, and lava to remain visible.
- Composite the official title-only wordmark at displayed `x=30, y=1320`, scaled proportionally to `1500` pixels wide (about 83% of the full canvas) with high-quality interpolation and a restrained dark shadow. Keep its engraved ivory/gold/oxide materials and official internal spacing unchanged.
- Preserve the official wordmark's existing hyphen in `MIDDLE-EARTH`.
- Because the official stylized lockup omits only the canonical colon, append a deterministic colon immediately after `RINGS` using two compact ivory/gold/oxide circular stops centered at displayed `(1552,1555)` and `(1552,1640)`. These stops complete the exact identity without replacing or restyling any official letterform.
- The complete dominant identity must read `THE LORD OF THE RINGS: TALES OF MIDDLE-EARTH`, including the colon and hyphen, at full print size and at a 360 × 420 drawer-view preview.
- Do not add face commanders, a Commander subtitle, invented Middle-earth lettering, pseudo-text, a modern sans-serif label, or a second set title.

## Output and seal constraints

- Finished alternate base: exact 1800 × 2100 pixels (6:7), PNG, 8-bit RGB/RGBA, non-interlaced, with 600 × 600 DPI metadata.
- Full bleed and useful official artwork to every edge; no border, blank field, opaque modern text box, watermark, or generative material.
- Preserve all existing v1 targets. Save the alternate with clearly versioned v2 filenames.
- Create a counted sibling non-destructively with `/usr/bin/swift scripts/apply_deck_count.swift ... 4:1800`.
- Marker geometry is fixed: one approved 210-pixel `4` seal at `x=1520–1730, y=1820–2030`, leaving exactly 70 pixels at the right and bottom edges. The title's compact lower line and appended colon must remain clear of this footprint.

## Target filenames

- `lord_of_the_rings_tales_of_middle_earth_commander_official_wordmark_typography_alternate_v2_1800x2100.png`
- `lord_of_the_rings_tales_of_middle_earth_commander_official_wordmark_typography_alternate_v2_deck_count_4_1800x2100.png`

## QA previews retained in `src/`

- `lord_of_the_rings_typography_comparison_v1_v2_full_3600x2100.png`: preserved v1 base on the left; typography alternate v2 base on the right, each at native 1800 × 2100 pixels.
- `lord_of_the_rings_typography_comparison_v1_v2_drawer_720x420.png`: preserved counted v1 on the left; counted v2 on the right, each reduced to 360 × 420 with Lanczos interpolation.
- `lord_of_the_rings_tales_of_middle_earth_commander_official_wordmark_typography_alternate_v2_counted_qa_360x420.png`: counted v2 drawer-view check.
