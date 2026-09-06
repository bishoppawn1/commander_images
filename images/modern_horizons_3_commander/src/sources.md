# Modern Horizons 3 Commander drawer-face sources and provenance

## Product and grouping authority

- [A First Look at Modern Horizons 3](https://magic.wizards.com/en/news/announcements/a-first-look-at-modern-horizons-3) — official Wizards announcement published February 23, 2024. It identifies **Modern Horizons 3** as the associated set, gives the main set code `MH3`, gives the Commander set code `M3C`, presents the Ajani key art, and credits that key art to **Wisnu Tan**.
- [Modern Horizons 3 Commander Decklists](https://magic.wizards.com/en/news/announcements/modern-horizons-3-commander-decklists) — official Wizards deck-list article published May 31, 2024. Wizards states that **four new Commander decks** debuted with the release and names them **Graveyard Overdrive**, **Tricky Terrain**, **Creative Energy**, and **Eldrazi Incursion**. This independently verifies the drawer marker value `4` used by `INVENTORY.md`.
- [Modern Horizons 3 — WPN product page](https://wpn.wizards.com/en/products/modern-horizons-3) — official Wizards Play Network source for the art-and-logo archive, branded social-media assets, 24 × 36 key-art poster, oversized art, product images, and product guide. The associated set's official branded key art was deliberately preferred to a montage of the four face commanders.

## Official WPN downloads and retained inputs

| Retained file | Direct official URL | Attribution / role | Original dimensions or format | Usage |
| --- | --- | --- | --- | --- |
| `mh3_lgp_key_24x36_en.pdf` | https://media.wizards.com/2024/wpn/marketing_materials/mh3/mh3_lgp_key_24x36_en.pdf | Selected official WPN 24 × 36 key-art poster; Ajani key art by Wisnu Tan | One-page PDF, 1770 × 2634 pt, 22,556,193 bytes | Authoritative direct source for the finished drawer face. Its portrait composition, complete Ajani figure, and integrated Modern Horizons branding were stronger than the landscape and product-photo alternatives. |
| `mh3_lgp_key_24x36_en_render_200dpi.png` | Derived losslessly from the retained poster with Poppler `pdftoppm -png -r 200 -singlefile` | Production edit target | 4917 × 7317 px, RGB PNG | Cropped and resampled by the retained Swift build script. |
| `mh3_lgp_key_24x36_en_render.png` | Derived from the retained poster with Poppler at 100 DPI | Full-poster visual-review raster | 2459 × 3659 px, RGB PNG | Used only to compare the full poster and determine the tight drawer crop. |
| `mh3_key_art_sma_en.zip` | https://media.wizards.com/2024/wpn/marketing_materials/mh3/mh3_key_art_sma_en.zip | Untouched official WPN key-art social-media archive | ZIP, 1,816,463 bytes | Retained raw archive and source of the five official social layouts below. |
| `mh3_key_art_sma_en/mh3_sma_key_1080x1920_en.jpg` | Extracted unchanged from `mh3_key_art_sma_en.zip` | Official branded vertical social asset; Wisnu Tan Ajani key art | 1080 × 1920 px | Important portrait and branding comparison. It contains too much airy sky and less source resolution than the poster, so it was not directly adapted. |
| `mh3_key_art_sma_en/mh3_sma_key_1000x1000_en.jpg` | Extracted unchanged from `mh3_key_art_sma_en.zip` | Official square key-art social layout | 1000 × 1000 px | Composition comparison only; not composited. |
| `mh3_key_art_sma_en/mh3_sma_key_1600x841_en.jpg` | Extracted unchanged from `mh3_key_art_sma_en.zip` | Official landscape key-art social layout | 1600 × 841 px | Composition comparison only; not composited. |
| `mh3_key_art_sma_en/mh3_sma_key_1640x680_en.jpg` | Extracted unchanged from `mh3_key_art_sma_en.zip` | Official wide key-art social layout | 1640 × 680 px | Composition comparison only; not composited. |
| `mh3_key_art_sma_en/mh3_sma_key_1920x1080_en.jpg` | Extracted unchanged from `mh3_key_art_sma_en.zip` | Official 16:9 key-art social layout | 1920 × 1080 px | Composition comparison only; not composited. |
| `mh3_alg_en.zip` | https://media.wizards.com/2024/wpn/marketing_materials/mh3/mh3_alg_en.zip | Untouched official WPN art-and-logos archive | ZIP, 5,046,888 bytes | Retained raw archive. |
| `mh3_alg_en/MTGMH3_EN_SetLogo_4C.png` | Extracted unchanged from `mh3_alg_en.zip` | Official English set-logo reference | 900 × 407 px, transparent RGBA PNG | Branding reference only. It was not composited because its final number is the Roman `III`, while this package requires the exact Arabic numeral `3`. |
| `mh3_alg_en/mh3_alg_1080p_en.jpg` | Extracted unchanged from `mh3_alg_en.zip` | Official art/logo overview | 1920 × 1080 px | Branding comparison only; not composited. The remaining extracted expansion-symbol files are preserved inside the raw archive and extracted directory as official set-code references, but none were composited. |
| `mh3_oversized_art_72x48.pdf` | https://media.wizards.com/2024/wpn/marketing_materials/mh3/mh3_oversized_art_72x48.pdf | Official WPN alternate oversized Ajani artwork, credited in the image to Alan Lathwell | One-page landscape PDF, 5226 × 3498 pt, 9,377,239 bytes | Inspected as a dense color-rich alternative; rejected for the face because it lacks the branded vertical identity of the selected poster. |
| `mh3_oversized_art_72x48_render.png` | Derived from the retained oversized-art PDF with Poppler at 50 DPI | Visual-review raster | 3630 × 2430 px, RGB PNG | Comparison only; not composited. |

## Production decision and exact transformation

The associated set identity is the strongest and clearest drawer identity for this Commander release, so the finished face uses the official WPN Ajani key-art poster rather than reducing four face commanders to a montage. Built-in ImageGen was **not used**: the official poster already supplied the correct visual identity and enough detail for a direct adaptation.

The retained `build_modern_horizons_3_commander_target.swift` script performs the complete non-generative print finish:

1. Load the official poster's 4917 × 7317 production raster.
2. Crop `x=18, y=1240, width=4881, height=5695`. The 18-pixel horizontal insets remove the poster's white trim edges; the vertical crop removes the airy upper margin and printer marks while retaining Ajani's complete face, axe, chest, arms, robes, waterfall, mountains, leaves, and official `MODERN HORIZONS` word treatment.
3. Resample that crop once with high-quality interpolation to exact 1800 × 2100 pixels in an sRGB RGBA canvas.
4. Replace only the bottom Roman-numeral field. The original `III` is completely covered with the poster's own sampled uniform title-field teal, RGB `(54, 158, 133)` / `#369E85`, and one Arabic `3` is rendered deterministically in pale pearl Copperplate Bold with a restrained magenta outline and dark-teal shadow. The completed dominant title therefore reads exactly **`MODERN HORIZONS 3`** once.
5. Write exact 600 × 600 DPI PNG metadata.
6. Run the repository-standard `scripts/apply_deck_count.swift` with marker specification `4:1800` to create the non-destructive counted sibling. The approved 210-pixel seal occupies x=1520–1730 and y=1820–2030 in top-left image coordinates, giving exactly 70 pixels of right and bottom outer-edge inset.

The first v1 finish passes are retained in `src/` as production intermediates because inspection caught a white poster trim line and remnants of the source's Roman numerals. Both defects were removed in v2. Drawer-review thumbnails are also retained only in `src/`.

## Finished print targets

| Final file | Role and derivation | Technical result | SHA-256 |
| --- | --- | --- | --- |
| `../modern_horizons_3_commander_official_wpn_poster_target_v2_1800x2100.png` | Unnumbered official-poster adaptation built by `build_modern_horizons_3_commander_target.swift` | 1800 × 2100 px, non-interlaced 8-bit RGBA PNG, 600 × 600 DPI | `7d64528279c21cf6a7139cd5044e2aeac1c91dc70d0274324a77e768c4923519` |
| `../modern_horizons_3_commander_official_wpn_poster_target_v2_deck_count_4_1800x2100.png` | Counted sibling derived non-destructively from the unnumbered base with `scripts/apply_deck_count.swift ... 4:1800` | 1800 × 2100 px, non-interlaced 8-bit RGBA PNG, 600 × 600 DPI; approved `4` seal geometry | `fece5be19c6ac82cd54e3bf5f2d132fbb184ae4314eccdd715378fe6cf5b09a4` |

## Visual and technical QA

- Both final PNGs were inspected separately at full resolution and at 360 × 420 drawer-view scale.
- Exact title: `MODERN HORIZONS 3` is present once; the Arabic `3` is crisp and the source Roman `III` is completely absent.
- Drawer legibility: `HORIZONS` remains the largest element and spans most of the full width; `MODERN`, `HORIZONS`, `3`, and the counted sibling's `4` remain immediately readable at 360 × 420.
- Fullness: the crop is full bleed, Ajani dominates the frame, and useful mountain, waterfall, clothing, foliage, weapon, and mist detail fills the composition. There is no white trim, border, blank corner, smooth black band, or large empty sky area.
- Safety and overlap: Ajani's face, hair, axe, arms, and official word treatment remain intact. The count seal covers only the noncritical lower-right teal title field and does not touch the title or focal art.
- Geometry and metadata: both finals were independently reported as exactly 1800 × 2100 with 600.000 × 600.000 DPI. The count marker's scripted footprint and equal 70-pixel right/bottom insets match the approved project standard.

---

## Secondary candidate — cosmic-rift alternate v3

### Broader redesign decision

The earlier official-poster adaptation remains preserved unchanged, but its teal lower field and repaired standalone numeral did not provide the dimensional, high-energy Modern Horizons 3 identity requested for the secondary attempt. The alternate instead promotes the already-retained official WPN oversized art credited in the PDF to **Alan Lathwell**. Its red volcanic rift, violet/cyan spectral energy, ghostly blade-wielder, roaring armored leonin, debris, and blue-white planar impact create a dense full-frame composition without a Commander-lead montage or a large solid-color field.

Built-in ImageGen was **not used**. The retained official art contains enough source detail for a strong exact-ratio crop, so reframing it deterministically preserves the official composition more faithfully than regeneration or outpainting would.

### New derived production source

| Retained file | Derivation / attribution | Dimensions | Usage |
| --- | --- | ---: | --- |
| `mh3_oversized_art_72x48_render_100dpi.png` | Lossless Poppler render of retained official `mh3_oversized_art_72x48.pdf` at 100 DPI; official PDF credit: Alan Lathwell | 7259 × 4859 px, RGB PNG, 100 × 100 DPI | Direct source for the v3 portrait crop. The higher-resolution render replaces the earlier 50-DPI review raster for production. |
| `MTGMH3_EN_SetLogo_4C_tif_review.png` | RGB review conversion of retained official CMYK TIFF logo | 2409 × 864 px | Visual comparison only; confirms official spacing and pearl/pink/cyan material. Not composited because the TIFF has an opaque white background. |
| `mh3_oversized_portrait_crop_x760_preview_600x700.png`, `mh3_oversized_portrait_crop_x900_preview_600x700.png`, `mh3_oversized_portrait_crop_x1040_preview_600x700.png` | Drawer-ratio crop studies from the retained 50-DPI oversized-art review raster | 600 × 700 px each | Review only. The centered x=900 study was selected and translated to x=1800 in the doubled-resolution production raster. |

### Exact deterministic transformation

The retained `build_modern_horizons_3_commander_cosmic_rift_alternate_v3.swift` script performs the complete v3 finish:

1. Load the official oversized-art production raster at 7259 × 4859 pixels.
2. Crop `x=1800, y=0, width=4164, height=4858`, an exact 6:7 portrait region, and resample once to 1800 × 2100. The crop preserves both central figures, the blade, volcanic rift, spectral impact, debris, and edge-to-edge color while excluding the source Magic wordmark and both corner credit blocks.
3. Add a translucent plum-to-clear lower vignette and a soft elliptical cyan/violet/magenta bloom. These preserve visible artwork through the title area and do not form a flat footer or solid panel.
4. Crop the retained official transparent `mh3_alg_en/MTGMH3_EN_SetLogo_4C.png` to its first 240 rows, preserving the exact official `MODERN HORIZONS` pixels while excluding every row of the source Roman `III`. Place the official wordmark at x=55, y=392, width=1690, height=451 in bottom-left Core Graphics coordinates with restrained depth and chromatic glow.
5. Build one Arabic `3` deterministically in Bodoni Seventy-Two ITC Bold, 330 points, using the logo's pale pearl/blush/cyan material, magenta edge, dark extrusion, and pale highlight. The numeral slightly overlaps the official wordmark and is connected by translucent prismatic shoulders, creating one stacked title lockup that reads exactly **`MODERN HORIZONS 3`**.
6. Write exact 600 × 600 DPI PNG metadata.
7. Create the counted sibling non-destructively with `scripts/apply_deck_count.swift ... 4:1800`. The approved 210-pixel seal occupies x=1520–1730 and y=1820–2030 in top-left coordinates, exactly 70 pixels from the right and bottom outer edges.

### Finished secondary print targets

| Final file | Role and derivation | Technical result | SHA-256 |
| --- | --- | --- | --- |
| `../modern_horizons_3_commander_cosmic_rift_alternate_v3_1800x2100.png` | Unnumbered official oversized-art adaptation built by `build_modern_horizons_3_commander_cosmic_rift_alternate_v3.swift` | 1800 × 2100 px, 8-bit RGBA PNG, 600 × 600 DPI | `297edf1dc5ef45166d38f47020e4a72eb0efa58d536eb2d548ad04fb70528ed5` |
| `../modern_horizons_3_commander_cosmic_rift_alternate_v3_deck_count_4_1800x2100.png` | Counted sibling derived non-destructively from the v3 base with `scripts/apply_deck_count.swift ... 4:1800` | 1800 × 2100 px, 8-bit RGBA PNG, 600 × 600 DPI; approved `4` seal geometry | `4e7bde8782e9e70dd86529c704ad3933dda2ad14ee030ee408bf73d247f1c67c` |

### Comparative visual and technical QA

- Existing v2 and alternate v3 were inspected separately at full resolution and side by side at 360 × 420 drawer scale. Every existing v2 root final remains untouched.
- Exact title: the alternate contains the official `MODERN HORIZONS` letter art once and one deterministic Arabic `3`; no Roman `III` or extra text is present.
- Drawer legibility: `HORIZONS` spans almost the entire width and all three title components remain immediately readable at 360 × 420. The new numeral shares the wordmark's prismatic material, overlap, glow, and connecting shoulders instead of reading as a detached generic glyph.
- Brand energy: compared with v2's calm Ajani poster and broad flat teal title field, v3 uses the official red-violet-blue planar-rift art, edge-to-edge debris and light, a deep translucent title landing zone, and an official luminous set wordmark.
- Fullness and focal safety: the crop remains full bleed and visually dense. Both faces, the weapon, armor, rift, spectral trail, debris, and impact remain clear. The title occupies noncritical lower action texture; the count seal occupies a dark lower-right corner without touching the title or either figure's face.
- Geometry and metadata: both v3 finals independently report exactly 1800 × 2100 pixels and 600.000 × 600.000 DPI. The scripted marker retains its standard 210-pixel diameter and exact 70-pixel right/bottom outer-edge insets.
