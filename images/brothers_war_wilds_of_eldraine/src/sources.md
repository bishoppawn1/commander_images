# The Brothers' War | Wilds of Eldraine split-face sources and production record

Produced 2026-08-26. The combined face reuses retained project sources; no source file was overwritten or modified.

## Selected inputs

| Local input | Provenance | Dimensions / format | SHA-256 | Role |
| --- | --- | --- | --- | --- |
| `../../brothers_war_commander/src/bro_oversized_art/bro_oversized_art_72x48_v1.pdf` | [Official WPN The Brothers' War oversized-art archive](https://media.wizards.com/2022/wpn/marketing_materials/bro/bro_oversized_art.zip); art credited in-image to **Antonio Bravo** | One-page 5184 x 3456 pt PDF (72 x 48 inches) | `ad9ac3a7748952ecf8bc7176b449285c621f281c451992197bc7fea6bbc3f31b` | Full-height left artwork. The red-and-black artifact creature gives the narrow panel a crisp, unmistakably mechanical war focal point and dense detail at every edge. |
| `../../brothers_war_commander/src/bro_alg_en/MTGBRO_EN_SetLogo_2line.png` | [Official WPN The Brothers' War art-and-logo archive](https://media.wizards.com/2022/wpn/marketing_materials/bro/bro_alg_en.zip) | 900 x 407 transparent PNG | `75ea49241602a9bcc7170abbdf6d6215e026ca6564eb58bbeb05182a7d568e71` | Exact official stacked title `THE BROTHERS' WAR`. Fully transparent horizontal storage-canvas columns are cropped at render time; the visible official pixels are otherwise untouched. |
| `../../wilds_of_eldraine_commander/src/wilds_of_eldraine_commander_imagegen_unmodified_v1.png` | Retained accepted clean artwork underlying the approved standalone Wilds target; originally a reference-led precise-object edit from official Pauline Voss key art, documented in the standalone `sources.md` | 1163 x 1353, 8-bit RGB PNG | `16e407ff9a6f3fc164369558dfcad56e1eb1b54c9f310f0682593bf894141177` | Full-height right artwork, preserving the fae ruler, crystalline wings and orb, thorn canopy, and dense enchanted forest. |
| `../../wilds_of_eldraine_commander/src/woe_alg_en/MTGWOE_EN_SetLogo.png` | [Official WPN Wilds of Eldraine art-and-logo archive](https://media.wizards.com/2023/wpn/marketing_materials/woe/woe_alg_en.zip) | 900 x 407 transparent PNG | `439499144b5b3cee8f2877a13ab45ab8b8c8edc48bfee19d8423249717f39796` | Exact official stacked title `WILDS OF ELDRAINE`. |

The release order and supplied counts are locked as The Brothers' War (2022) on the left, Wilds of Eldraine (2023) on the right, with markers `2 | 2`. The standalone provenance records retain the official product/deck-count verification links and full source history.

## Visual and layout decisions

- The 1800 x 2100 canvas is divided into two exact 900-pixel source panels.
- The Brothers' War PDF is scaled to the full 2100-pixel height and focused at 61% of its source width, retaining the artifact creature's bright core, angular silhouette, and mechanical debris rather than squeezing a complete portrait card into the half.
- The accepted clean Wilds artwork is likewise scaled by height and centered, keeping the fae ruler's face, wings, crystal, canopy, and lower forest texture intact.
- Each visible official wordmark is 820 pixels wide—91.1% of its panel—and centered 40 pixels from each side. A transparent, atmosphere-matched lower vignette provides contrast while allowing the underlying art to remain visible.
- The Brothers' War logo uses three compact official lines and the Wilds logo uses two official lines, so neither long title is reduced to a tiny single-line caption.
- One 6-pixel antique-gold divider overlays x=897...902 across the full canvas height. The sources still occupy exact x=0...899 and x=900...1799 panels; there are no gutters, frames, extra borders, or blended seams.
- Both titles end above the seal zone. The two 210-pixel seals cover only noncritical lower-edge texture.

## Production mode and commands

This combined asset was built deterministically with CoreGraphics and the approved seal script. **No new ImageGen generation or edit was used.** The retained Wilds input is ImageGen-derived from the earlier standalone workflow and is reused unchanged here.

```sh
/usr/bin/swift images/brothers_war_wilds_of_eldraine/src/build_vertical_split.swift \
  images/brothers_war_commander/src/bro_oversized_art/bro_oversized_art_72x48_v1.pdf \
  images/wilds_of_eldraine_commander/src/wilds_of_eldraine_commander_imagegen_unmodified_v1.png \
  images/brothers_war_commander/src/bro_alg_en/MTGBRO_EN_SetLogo_2line.png \
  images/wilds_of_eldraine_commander/src/woe_alg_en/MTGWOE_EN_SetLogo.png \
  images/brothers_war_wilds_of_eldraine/brothers_war_wilds_of_eldraine_vertical_split_1800x2100.png \
  images/brothers_war_wilds_of_eldraine/src/brothers_war_wilds_of_eldraine_vertical_split_preview_300x350.png

/usr/bin/swift scripts/apply_deck_count.swift \
  images/brothers_war_wilds_of_eldraine/brothers_war_wilds_of_eldraine_vertical_split_1800x2100.png \
  images/brothers_war_wilds_of_eldraine/brothers_war_wilds_of_eldraine_vertical_split_deck_counts_2_2_1800x2100.png \
  2:900 2:1800
```

The first command also writes the unnumbered 300 x 350 visual-QA preview. The counted preview was downsampled non-destructively with `sips -z 350 300` and is retained only in `src/`.

## Finished targets

| File | Role | Technical result | SHA-256 |
| --- | --- | --- | --- |
| `../brothers_war_wilds_of_eldraine_vertical_split_1800x2100.png` | Preserved unnumbered base | 1800 x 2100, 8-bit RGBA non-interlaced PNG, 600 x 600 DPI, sRGB | `ed6621e3e771abc627526c73e016adad1f21703db330e48287df54efdc88724a` |
| `../brothers_war_wilds_of_eldraine_vertical_split_deck_counts_2_2_1800x2100.png` | Counted drawer face | 1800 x 2100, 8-bit RGBA non-interlaced PNG, 600 x 600 DPI, sRGB | `2b16966c5c1f3160c0fd2c93ea4945e9e0c351bff92da2f4dd56a0cb542c62b8` |

## Count-seal geometry

The counted sibling was created with the exact required invocation arguments `2:900 2:1800`. Each standard seal is 210 pixels in diameter with 70 pixels between its outer edge and its panel's right boundary and the canvas bottom:

- Left core seal rect: x=620...829, bottom-origin y=70...279; center=(725, 175).
- Right core seal rect: x=1520...1729, bottom-origin y=70...279; center=(1625, 175).
- The script's approved soft shadow extends only inside the validated corner envelopes and introduces no changes elsewhere.

See `qa_report.md` for visual, metadata, geometry, deterministic-rebuild, legacy-integrity, and folder-hygiene results.
