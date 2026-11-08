# Marvel Super Heroes Commander drawer-face provenance

## Product identity and scope verification

This package identifies the four-deck June 2026 **Magic: The Gathering | Marvel Super Heroes Commander** release. It is the Commander component of the main `Magic: The Gathering | Marvel Super Heroes` set and is not `Magic: The Gathering | Marvel's Spider-Man`, a Secret Lair drop, or another Marvel-branded product.

Authoritative official references:

- Wizards Play Network product and marketing-material page: <https://wpn.wizards.com/en/products/marvel-super-heroes>
  - Official product name: `Magic: The Gathering® | Marvel Super Heroes`.
  - Official WPN page supplies the product shots, key-art poster, key-art social-media assets, art-and-logo pack, oversized art, and banner art used in the source review.
  - WPN legal line: `© 2026 MARVEL | TM & © 2026 Wizards of the Coast LLC`.
- Official Wizards Commander decklists announcement, dated June 11, 2026: <https://magic.wizards.com/en/news/announcements/marvel-super-heroes-commander-decklists>
  - Confirms four ready-to-play decks: **Avengers Assemble**, **Wakanda Forever**, **The Fantastic Four**, and **Doom Prevails**.
  - Confirms the tabletop Commander release date of June 26, 2026.
- Official Wizards buyer's guide, dated June 2, 2026: <https://magic.wizards.com/en/news/feature/marvel-super-heroes-buyers-guide>
  - Shows the same four Commander products and identifies their lead characters as Captain America, T'Challa, Mister Fantastic / the Fantastic Four, and Doctor Doom.
- Official Wizards collecting guide: <https://magic.wizards.com/en/news/feature/collecting-marvel-super-heroes>
  - Confirms main-set code `MSH`, Commander set code `MSC`, and source-material set code `MAR`.
- Official Wizards preview prologue, dated December 9, 2025: <https://magic.wizards.com/en/news/feature/marvel-super-heroes-preview-prologue>
  - Confirms that the Commander decks are part of the broader Marvel Super Heroes set.
- Project collection authority: `INVENTORY.md` records **4 owned / 4 total** and mandates a standalone marker value of `4`. That owned count is treated as authoritative and is corroborated by the four official deck products above.

## Raw official WPN downloads

All downloads were retrieved from the official WPN product page on August 26, 2026. Untouched archives remain in this `src/` directory.

| Retained archive | Direct official URL | SHA-256 | Contents / role |
| --- | --- | --- | --- |
| `msh_key_poster_en.zip` | <https://media.wizards.com/2026/wpn/marketing_materials/msh/msh_key_poster_en.zip> | `2134b81d49468a5a55ff8718aa731f1a2406f111cc86ca4f6933ea3de48665d1` | Official 24×36 key-art poster. Reviewed but not selected because its large pale lower field and 600×889 raster were weaker for a dense drawer face. |
| `msh_sma_key_en.zip` | <https://media.wizards.com/2026/wpn/marketing_materials/msh/msh_sma_key_en.zip> | `41d0cb1633b73e77ac8c2da16290a01d3c1607a8d8e16c7fc5b65e22a7be58a3` | Official key-art social pack. Contains 1080×1350, 1600×841, 1080×1080, 1640×680, 1080×1920, and 1920×1080 variants. The 1080×1350 portrait was selected. |
| `msh_alg_en.zip` | <https://media.wizards.com/2026/wpn/marketing_materials/msh/msh_alg_en.zip> | `20a6981316062a8b840f1397d3b7542279c39eb45ab1d9cc53a946493986cdaf` | Official art, logos, and `MSH` / `MSC` set symbols. The four-color standalone set logo was selected. |
| `msh_pds_en.zip` | <https://media.wizards.com/2026/wpn/marketing_materials/msh/msh_pds_en.zip> | `844fbcb798c4f95cd97f552ec29ff1f848521fb97bc95ab1b1d1576a71d50423` | Official product-shot pack. Commander and Collector's Edition Commander product images were extracted as identity references only. |

Extracted archives are retained below `official_wpn/`. The original zip payloads were not overwritten.

## Selected visual inputs

| File | Original dimensions / format | Attribution and role | SHA-256 |
| --- | --- | --- | --- |
| `official_wpn/key_social/en/MSH_sma_key_1080x1350.jpg` | 1080 × 1350 JPEG | Primary official licensed WPN portrait key art. The asset's embedded legal credit identifies **Chris Rallis**. Selected because it has a dense full-frame action composition, strong centralized Black Panther silhouette, multiple recognizable set characters, no repeated subjects, and no large empty region. | `4eede7c4b494fece2855cb97f1dd287fb025bba41215665f8bb48653fcd9b393` |
| `official_wpn/art_and_logos/en/Set_Logo/Print/MTGMSH_EN_SetLogo.tif` | 2222 × 672, 300-DPI transparent CMYK TIFF | Official high-resolution print `MARVEL SUPER HEROES` set logo. Composited directly with color conversion onto the sRGB canvas so every letter and licensed proportion remains exact; no ImageGen or text recreation was used. | `095bf9486fb76401f8e6bf8ef8768f865b8305d70463d7b5bf218666fdc529f2` |
| `official_wpn/product_shots/MTGMSH_EN_OtrBx_Cmndr_05.png` | 900 × 900 8-bit RGBA PNG | Official four-deck family-shot reference. Used only to confirm the Commander product grouping; not composited into the drawer face. | `fb9a55fcb0c2390d9f03e6c24601affe5558c12ed96be57addb995dc5d279714` |

The other WPN social, poster, logo, and Commander packaging variants remain in `official_wpn/` as raw comparison sources. No nonofficial fan art, retailer mockup, Secret Lair visual, Spider-Man set visual, or generated character art was used.

`official_set_logo_print_preview.png` is an sRGB PNG inspection conversion of the retained CMYK print TIFF (2222 × 672; SHA-256 `23c2f45603875354011b0a61b16d809c7dcb9b74fd7288d25c4bbb729b58b514`). It was used only to visually verify the licensed print logo; the build script composites the original TIFF directly.

## Production method

Generation mode: **direct non-generative official-art adaptation**. Built-in ImageGen was not used because the official WPN portrait already supplied a strong licensed set-wide scene, and deterministic reframing preserved it more faithfully.

The finished prompt brief is `../prompts/marvel_super_heroes_commander_official_wpn_key_art_adaptation_brief.md`. The reproducible adaptation script is `build_marvel_super_heroes_commander_target.swift`.

Transformations performed by that script:

1. Validate the selected 1080 × 1350 WPN portrait and 2222 × 672 official high-resolution print-logo dimensions.
2. Crop the portrait to its upper 1080 × 1260 pixels, an exact 6:7 crop. This removes only the final 90 pixels of footer/legal area while keeping the dense hero scene and all selected character identities unchanged.
3. Resample that crop to the exact 1800 × 2100 output canvas with high interpolation in sRGB.
4. Cover the source's smaller lower split lockup completely with an opaque near-black lower field plus a feathered dark veil. This prevents a duplicate or ghosted title while preserving visible rubble and lower-body texture above the title field.
5. Add a compact deep-red `COMMANDER` band with subtle diagonal comic-action speed lines and a 10-pixel antique-gold separator. Render exact subordinate text `COMMANDER` once in pale-ivory Copperplate Bold, sized to end before the standard count-seal zone.
6. Composite the official standalone `MARVEL SUPER HEROES` logo unchanged at 1660 pixels wide, centered with 70-pixel geometric side clearances. The licensed title is the single dominant drawer-readable identification element.
7. Write the unnumbered target as an 8-bit RGBA, non-interlaced PNG at exact 1800 × 2100 pixels with 600 × 600 DPI metadata.
8. Run the repository-standard `scripts/apply_deck_count.swift` non-destructively with `4:1800` to create the counted sibling.

## Finished targets and QA

| Finished file | Specifications | SHA-256 |
| --- | --- | --- |
| `../marvel_super_heroes_commander_official_wpn_key_art_target_v1_1800x2100.png` | Unnumbered base; 1800 × 2100; 6:7; 8-bit RGBA non-interlaced PNG; 600 × 600 DPI | `0623e42e0859d3791ee50230898fe0cd7b949b7be3c7949f2f1be59c112d6284` |
| `../marvel_super_heroes_commander_official_wpn_key_art_target_v1_deck_count_4_1800x2100.png` | Counted sibling; same print specifications; standard `4` seal | `390edaf078a30949b0b0d926ac3957be2907c21643f250cef4d5162e757f4955` |

Validation completed at full resolution and at the retained 360 × 420 drawer previews:

- Exact dominant licensed text is visibly `MARVEL SUPER HEROES` once. The direct official logo has no malformed, missing, substituted, or duplicated letters. `COMMANDER` appears once as subordinate format identification.
- The title spans almost the full safe width and remains immediately readable at 360 × 420 drawer scale.
- The frame is full bleed and visually dense: city action and characters occupy the upper field, the large title occupies the lower-middle field, and the patterned Commander band occupies the base. There is no white mat, large blank field, border, or featureless margin.
- Visual inspection found no duplicated character, malformed anatomy introduced by editing, generated pseudo-logo, unrelated release branding, or Secret Lair / Spider-Man identity.
- The standard seal geometry is exactly 210 pixels in diameter. Its geometric box is `x=1520…1729`, `y=1820…2029` in top-origin coordinates, so its outer edge is exactly 70 pixels from the right and bottom boundaries. The script's antialiased soft shadow extends four pixels below that geometric box, as expected, without changing seal diameter or inset.
- The count marker occupies only the reserved lower-right patterned band. It does not cover the primary title, `COMMANDER`, or any critical character feature.
- `ffprobe` reports both finals as 1800 × 2100 RGBA PNG with 6:7 display aspect and sRGB / IEC 61966-2-1 color characteristics. `sips` reports 600.000 × 600.000 DPI for both files.

Retained drawer-scale review files:

- `marvel_super_heroes_commander_drawer_preview_v1_360x420.png`
- `marvel_super_heroes_commander_drawer_preview_v1_deck_count_4_360x420.png`
