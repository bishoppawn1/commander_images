# Throne of Eldraine Brawl — sources and production record

## Product identity

This drawer face represents the complete 2019 **Throne of Eldraine Brawl** release, a standalone non-Commander product. The project inventory records four owned physical decks and assigns deck-count marker `4`.

Authoritative product verification:

- Wizards of the Coast, [Inside the Throne of Eldraine Brawl Decks](https://magic.wizards.com/en/news/card-preview/inside-throne-eldraine-brawl-decks-2019-09-04), September 4, 2019. Wizards describes the paper Brawl decks and explicitly refers to all four decks.
- Wizards of the Coast, [Project Booster Fun](https://magic.wizards.com/en/news/making-magic/project-booster-fun-2019-07-20), July 20, 2019. The official product breakdown lists Brawl Decks as 60-card decks with four versions.
- Wizards Play Network, [Throne of Eldraine product page](https://wpn.wizards.com/en/products/throne-of-eldraine). The official WPN page separately labels the product category `Brawl Decks` and supplies the packaging reference retained here.

The final title is deliberately `THRONE OF ELDRAINE BRAWL`, with `BRAWL` as the largest line and no use of the word `COMMANDER`.

## Chosen official visual

### `official_wpn_eld_large_banner_en.pdf`

- Direct source URL: https://media.wizards.com/2019/wpn/marketingmaterials/eld/eld_lrg_bnr_en.pdf
- Publisher/source: Wizards Play Network / Wizards of the Coast.
- Downloaded: August 26, 2026.
- Original file: 2-page PDF, 1890 × 5202 points per page, 13,709,147 bytes.
- SHA-256: `9453ce1de4d7c52e8922eb98473c0a9169d746b9b76b247653dea46d633ea710`.
- Chosen content: page 2, official vertical Throne of Eldraine key art showing Rowan in a red cloak charging her sword in an Eldraine forest.
- Artist attribution: Zack Stella. Verified directly from the page-2 footer: `Illus. Zack Stella.`
- Intended role: authoritative artwork source for the final face.

### Production renders of the official WPN PDF

- `official_wpn_eld_large_banner_en_page2_render_150dpi.png`: page 2 rendered losslessly with Poppler at 150 DPI; 3938 × 10838 pixels. This is the actual raster edit target used by `build_face.swift`.
- `official_wpn_eld_large_banner_en_page2_render.png`: 72-DPI page-2 research render; 1890 × 5202 pixels.
- `official_wpn_eld_large_banner_en_page2_preview.png`: reduced page-2 visual-inspection copy; 654 × 1800 pixels.
- `official_wpn_eld_large_banner_en_render.png`: 150-DPI page-1 research render; 3938 × 10838 pixels.
- `official_wpn_eld_large_banner_en_preview.png`: reduced page-1 visual-inspection copy; 654 × 1800 pixels.
- `qa_wpn_footer_crop.png`: enlarged footer crop used to verify the Zack Stella credit directly.

## Official product and article references

### `official_wpn_brawl_decks_product.jpg`

- Direct source URL: https://images.ctfassets.net/0piqveu8x9oj/7tGqQCilblqqvm6PzsO331/6cf0d4a8897c8ce1b1e564c0aed9304a/MTGELD_BrawlOtrBx_03_02_1569864834.jpg
- Linking page: https://wpn.wizards.com/en/products/throne-of-eldraine
- Publisher/source: Wizards Play Network / Wizards of the Coast.
- Original dimensions/metadata: 640 × 480 pixels, 300 DPI.
- Content: official `BRAWL DECK` packaging photograph for Knights' Charge.
- Intended role: product-language and non-Commander identity reference. It was not composited because its white-background product-photo treatment and low resolution are weaker than the official vertical key art for a full-bleed drawer face.

### `official_magic_inside_brawl_article_meta.jpeg`

- Direct source URL: https://images.ctfassets.net/s5n2t79q9icq/1HUznWmxseGGKxmQ5FjT9V/1e100242b943a70ad188dfc446152e2e/en_articles_archive_card-preview_inside-throne-eldraine-brawl-decks-2019-09-04-meta-image.jpeg
- Linking article: https://magic.wizards.com/en/news/card-preview/inside-throne-eldraine-brawl-decks-2019-09-04
- Publisher/source: Wizards of the Coast.
- Original dimensions/metadata: 768 × 432 pixels, 72 DPI.
- Content: official article meta art showing Syr Gwyn, the Brawl commander of Knights' Charge.
- Intended role: authoritative Brawl reveal/article reference. It was not used in the final because it is low-resolution landscape art and overweights one of the four decks.

### `official_wpn_eld_product_page.jpg`

- Direct source URL: https://images.ctfassets.net/0piqveu8x9oj/3cydJChXhUbI0i5pToIOIp/26718856836ba006231a5112c8ca5bbf/eld_product_page.jpg
- Linking page: https://wpn.wizards.com/en/products/throne-of-eldraine
- Publisher/source: Wizards Play Network / Wizards of the Coast.
- Original dimensions/metadata: 1920 × 1120 pixels, 72 DPI.
- Content: official Throne of Eldraine WPN product-page hero.
- Intended role: associated-set/product-page reference. It was not used because its large dark empty field and small booster-display subject fail the project's density requirement.

## Final production mode and exact brief

- Mode: direct official-art adaptation; no ImageGen generation or repainting was used.
- Rationale: the official WPN page-2 vertical key art already provides a strong, high-resolution, full-frame Throne of Eldraine visual. Project instructions prefer preserving a suitable official image instead of regenerating it.
- Exact final adaptation brief: the verbatim production brief is stored at `../prompts/throne_of_eldraine_brawl_official_art_adaptation_brief.md`.
- Production helper: `build_face.swift`.

## Transformations

1. Downloaded the official two-page WPN banner PDF without modifying it.
2. Rendered PDF page 2 to `official_wpn_eld_large_banner_en_page2_render_150dpi.png` at 150 DPI, producing a 3938 × 10838 lossless PNG.
3. `build_face.swift` removed the narrow white page edge and cropped the official render at source rectangle `x=20, y=105, width=3898, height=4548`.
4. Resampled that 6:7 crop to exactly 1800 × 2100 pixels with high-quality interpolation.
5. Added a translucent wine-black lower title gradient. The official cloak, sparks, armor, and forest remain visible beneath it, so the treatment does not create a featureless block.
6. Added thin antique-gold heraldic rules and crisp centered Copperplate Bold text on three lines: `THRONE OF`, `ELDRAINE`, `BRAWL`. All three lines use pure-white letter faces with dark outlines; `BRAWL` uses the largest type and no Commander wording appears.
7. Embedded 600-DPI width and height metadata in the unnumbered PNG.
8. Preserved the base and ran the project-standard `scripts/apply_deck_count.swift` with `4:1800` to create the counted sibling.

## Final targets and QA

### `../throne_of_eldraine_brawl_official_wpn_rowan_target_v3_1800x2100.png`

- Exact dimensions: 1800 × 2100 pixels.
- Embedded metadata: 600 × 600 DPI.
- SHA-256: `e1685d01bec1497bcc6c9fa729c7b88992a84b27e9930be38db9e7d65925cc77`.
- Status: finished unnumbered full-bleed base.

### `../throne_of_eldraine_brawl_official_wpn_rowan_target_v3_deck_count_4_1800x2100.png`

- Exact dimensions: 1800 × 2100 pixels.
- Embedded metadata: 600 × 600 DPI.
- SHA-256: `2f142e35ea64fa802cef8825ec84f6c619d4ec4d5e384fd23cfdbf426141e74b`.
- Status: finished counted target representing all four owned Brawl decks.
- Seal geometry: 210-pixel diameter; center `(1625, 175)` in the script's bottom-left coordinate system; outer bounds `x=1520…1730`, `y=70…280`; outer edge exactly 70 pixels from the right and bottom boundaries.

QA performed at full size and at drawer scale (`qa_drawer_scale_counted.png`, 300 × 350 pixels):

- Exact title reads `THRONE OF ELDRAINE BRAWL` once, across three lines.
- All three title lines use pure-white letter faces for consistent high contrast.
- `BRAWL` is the largest and most drawer-readable word.
- No `COMMANDER` text appears anywhere.
- Rowan's face, charged sword, the Planeswalker mark, forest, sparks, cloak, and armor remain recognizable.
- Composition is dense and full bleed, with no large empty or featureless regions.
- Title letters are not clipped and retain comfortable side clearance.
- Count `4` is clear, uses the approved dark/gold/ivory seal, and does not cover title text or a critical focal detail.
- Both final files pass exact pixel-dimension and 600-DPI metadata inspection.

---

## Secondary candidate — four-courts illuminated tableau

This non-destructive alternate was created after the original Rowan-only candidate was judged too generic in typography and too narrowly tied to one character. It preserves both original finished targets and adds a broader four-deck composition whose title remains exactly `THRONE OF ELDRAINE BRAWL`, with no `COMMANDER` wording.

### Four official ELD Brawl commander-art references

The following are crops of the official 2019 *Throne of Eldraine* card illustrations, served by Scryfall from the ELD printings. Each crop is 626 × 457 pixels and was downloaded August 26, 2026. They were used as identity and palette references for built-in ImageGen, not placed directly in the final raster.

#### `scryfall_eld_syr_gwyn_art_crop.jpg`

- Card/printing: Syr Gwyn, Hero of Ashvale, ELD 330.
- Artist: Lie Setiawan.
- Direct image URL: https://cards.scryfall.io/art_crop/front/a/3/a33add37-379d-4a90-9c04-529dff676986.jpg?1783932546
- Card page: https://scryfall.com/card/eld/330/syr-gwyn-hero-of-ashvale
- SHA-256: `d215db46e00c76a06b20887693a0bc02953f175bbc87611db882afcba3381fa2`.
- Intended role: Knights' Charge / mounted flame-sword knight reference.

#### `scryfall_eld_chulane_art_crop.jpg`

- Card/printing: Chulane, Teller of Tales, ELD 326.
- Artist: Victor Adame Minguez.
- Direct image URL: https://cards.scryfall.io/art_crop/front/8/3/83f43730-1c1f-4150-8771-d901c54bedc4.jpg?1783932548
- Card page: https://scryfall.com/card/eld/326/chulane-teller-of-tales
- SHA-256: `9b14e58151900327f0e6c53b6857cc72be07691e7e7f3817f4db9f9bd04dc979`.
- Intended role: Wild Bounty / storyteller and open-book reference.

#### `scryfall_eld_korvold_art_crop.jpg`

- Card/printing: Korvold, Fae-Cursed King, ELD 329.
- Artist: Wisnu Tan.
- Direct image URL: https://cards.scryfall.io/art_crop/front/9/2/92ea1575-eb64-43b5-b604-c6e23054f228.jpg?1783932546
- Card page: https://scryfall.com/card/eld/329/korvold-fae-cursed-king
- SHA-256: `87264565b0bf6cec15a380ecbccb4923dcccccadadfd7d1262cb76de4d646674`.
- Intended role: Savage Hunter / fae-cursed dragon-king reference.

#### `scryfall_eld_alela_art_crop.jpg`

- Card/printing: Alela, Artful Provocateur, ELD 324.
- Artist: Grzegorz Rutkowski.
- Direct image URL: https://cards.scryfall.io/art_crop/front/7/2/726e7dc5-2089-4758-93e1-79212aedf75f.jpg?1783932550
- Card page: https://scryfall.com/card/eld/324/alela-artful-provocateur
- SHA-256: `d22ad925b13d1177bed1eda0dcdfeff49162309f38584f33962b219e3e9c9b55`.
- Intended role: Faerie Schemes / flying faerie reference.

### `throne_of_eldraine_brawl_secondary_imagegen_raw_v1.png`

- Generation mode: built-in ImageGen compositing from the four reference images above.
- Original dimensions/metadata: 1162 × 1354 pixels, 72 DPI.
- SHA-256: `3a0e643d72fad4e95a595ad616d2f5dede1a869a008d3ae4d0e5890bf8734fc2`.
- Content: an unlettered, full-frame illuminated-manuscript tableau with four equal heraldic vignettes, gilded thorn tracery, and a textured central parchment area.
- Iteration: the initial output incorrectly turned the upper-left commander into a standing Rowan-like figure. A single targeted built-in edit replaced only that vignette with the requested mounted Syr Gwyn identity and preserved the other three vignettes and central parchment.
- Exact initial and correction prompts: recorded verbatim in `../prompts/throne_of_eldraine_brawl_secondary_four_courts_illuminated_brief.md`.
- Intended role: selected raw production raster for the secondary final.

### Secondary production mode and typography

- `build_secondary_face.swift` minimally crops the raw 1162 × 1354 source to exact 6:7, resamples it to 1800 × 2100, and embeds 600-DPI metadata.
- The central background remains textured parchment with visible gold tracery; no black or opaque rectangular title field was added.
- Exact deterministic text appears once on three lines: `THRONE OF`, `ELDRAINE`, `BRAWL`.
- Typography uses tracked `BigCaslon-Medium` for `THRONE OF` and `Luminari-Regular` for both larger identity lines. Pure-white letter faces with layered dark-ink and gold outlines create illuminated storybook/engraved medieval character rather than a generic sans treatment.
- Curved gold-and-ink flourishes and central diamonds integrate the title with the surrounding manuscript frame.
- `BRAWL` remains exceptionally large and high contrast, and no `COMMANDER` wording appears.
- The approved count seal was applied only by `scripts/apply_deck_count.swift` with `4:1800`.

## Secondary final targets and QA

### `../throne_of_eldraine_brawl_secondary_four_courts_illuminated_v1_1800x2100.png`

- Exact dimensions: 1800 × 2100 pixels.
- Embedded metadata: 600 × 600 DPI.
- SHA-256: `012c4a54b455f544b1eeb3cb5a4de85488e3d3ddda4fd937fe3b675b07976efd`.
- Status: finished, unnumbered, full-bleed secondary base.

### `../throne_of_eldraine_brawl_secondary_four_courts_illuminated_v1_deck_count_4_1800x2100.png`

- Exact dimensions: 1800 × 2100 pixels.
- Embedded metadata: 600 × 600 DPI.
- SHA-256: `2cc33c00e8c7e24ea770319020ea94ab08f8cc5c7e7cd3148fab32b04ba0619c`.
- Status: finished counted secondary target representing all four owned Brawl decks.
- Seal geometry: 210-pixel diameter; center `(1625, 175)` in the script's bottom-left coordinate system; outer bounds `x=1520…1730`, `y=70…280`; outer edge exactly 70 pixels from the right and bottom boundaries.

QA was performed on both the original counted target and the secondary counted target at full resolution, 300 × 350 pixels, and 360 × 420 pixels. The comparison previews are retained as `qa_original_counted_300x350.png`, `qa_original_counted_360x420.png`, `qa_secondary_four_courts_counted_300x350.png`, and `qa_secondary_four_courts_counted_360x420.png`.

- The complete title reads exactly `THRONE OF ELDRAINE BRAWL` once and is immediately legible at both drawer scales.
- `THRONE OF`, `ELDRAINE`, and `BRAWL` all use pure-white letter faces.
- `BRAWL` is unmistakable and nearly matches `ELDRAINE` in width and visual weight.
- No `COMMANDER` text or unintended lettering is visible.
- Syr Gwyn, Chulane, Korvold, and Alela each occupy a distinct, similarly sized vignette, so the composition reads as the four-deck Brawl product rather than a single unrelated set portrait.
- The title remains inside the print-safe area; no letters are clipped.
- Full bleed contains detailed art and filigree to every edge, with no large empty or opaque field.
- The count `4` remains clear in the approved lower-right seal and does not obscure title text or a critical face.
- Both secondary finals pass exact pixel-dimension and 600-DPI metadata inspection.
