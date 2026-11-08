# Wilds of Eldraine Commander drawer-face sources and provenance

## Product verification

- **Wizards of the Coast — A First Look at Wilds of Eldraine**  
  https://magic.wizards.com/en/news/announcements/a-first-look-at-wilds-of-eldraine  
  Published July 28, 2023. Wizards identifies the associated set and states that the release includes two Wilds of Eldraine-themed Commander decks, **Fae Dominion** and **Virtue and Valor**. This agrees with the project inventory's owned drawer count of 2.
- **Wizards Play Network — Wilds of Eldraine product page**  
  https://wpn.wizards.com/en/products/wilds-of-eldraine  
  Authoritative source for the official marketing downloads used below, including Art and Logos, Key Art Social Media Assets, and the 24 x 36 Key Art Poster.

## Retained official assets

### WPN Key Art Social Media Assets

- Download URL: https://media.wizards.com/2023/wpn/marketing_materials/woe/woe_key_art_sma_en.zip
- Untouched archive: `woe_key_art_social_media_assets_en.zip`
- Extracted files:
  - `woe_key_art_sma_en/woe_sma_fb_1000x1000_en.jpg` — 1000 x 1000 px; primary edit target/reference.
  - `woe_key_art_sma_en/woe_sma_fb_groups_1640x680_en.jpg` — 1640 x 680 px; official horizontal campaign crop retained for comparison.
  - `woe_key_art_sma_en/woe_sma_fb_pages_1600x841_en.jpg` — 1600 x 841 px; official horizontal campaign crop retained for comparison.
  - `woe_key_art_sma_en/woe_sma_insta_1080x1920_en.jpg` — 1080 x 1920 px; official vertical campaign crop and supporting composition reference.
- Artist credit visible in the supplied assets: **Pauline Voss**.
- Usage: the square art is the visual authority for the selected Talion/fae-ruler composition; the vertical crop informs the small 6:7 extension above and below it.

### WPN Wilds of Eldraine Art and Logos

- Download URL: https://media.wizards.com/2023/wpn/marketing_materials/woe/woe_alg_en.zip
- Untouched archive: `woe_art_and_logos_en.zip`
- Extracted files used:
  - `woe_alg_en/MTGWOE_EN_SetLogo.png` — 900 x 407 px, transparent; exact official English set logo used as the deterministic final title overlay.
  - `woe_alg_en/WOE_1080p_en.jpg` — 1920 x 1080 px; official branded landscape composition retained as a comparison reference.
- Other set-symbol files from the archive are retained but not used in the finished target.

### WPN Key Art Poster 24 x 36

- Download URL: https://media.wizards.com/2023/wpn/marketing_materials/woe/woe_lgp_key_24x36_en.pdf
- Untouched file: `woe_key_art_poster_24x36_en.pdf` — one-page PDF, 1806 x 2670 pt page.
- Artist credit visible in poster: **Magali Villeneuve**.
- `woe_key_art_poster_preview.jpg` — 2509 x 3709 px, 100-DPI inspection render made with Poppler; production intermediate only.
- Usage: inspected as the strongest official poster alternative. Its full composition is substantially narrower than 6:7, so the social key-art campaign was selected for the drawer face.

### Wizards First Look images

- Source article: https://magic.wizards.com/en/news/announcements/a-first-look-at-wilds-of-eldraine
- `first_look_wilds_of_eldraine_art.jpg` — 1920 x 1080 px; download URL https://media.wizards.com/2023/images/daily/nNjKmcrleh.jpg; official branded reveal graphic retained as a set-identity reference.
- `first_look_eldraine_prairie_art_alayna_danner.jpg` — 1920 x 1080 px; download URL https://media.wizards.com/2023/images/daily/NvOASKalmH.jpg; artist **Alayna Danner**; official landscape reference inspected, not used in final composition.
- `first_look_wilds_mystery_art_kasia_zielinska.jpg` — 1920 x 1080 px; download URL https://media.wizards.com/2023/images/daily/igZTPQcztj.jpg; artist **Kasia 'Kafis' Zielińska**; official landscape reference inspected, not used in final composition.

## Production record

- **Generation mode:** built-in ImageGen, reference-led `precise-object-edit`.
- **Unmodified ImageGen output:** `wilds_of_eldraine_commander_imagegen_unmodified_v1.png` — 1163 x 1353 px, 72-DPI metadata. SHA-256 `16e407ff9a6f3fc164369558dfcad56e1eb1b54c9f310f0682593bf894141177`.
- **Built-in output origin:** `/Users/bishophall/.codex/generated_images/01a03c60-6542-7ef2-b831-245d983a9179/exec-e5a437a3-cc9d-465f-a70a-e43788167926.png`; copied unchanged into this `src/` directory.

### Exact built-in ImageGen prompt

```text
Use case: precise-object-edit
Asset type: premium 3 x 3.5 inch Magic deck-drawer face background
Input images: Image 1: official Wilds of Eldraine square key-art edit target; Image 2: official vertical key-art composition reference; Image 3: official First Look set-identity reference
Primary request: Reframe Image 1 into a full-bleed exact 6:7 portrait composition by reconstructing only the small amount of missing enchanted-forest artwork above and below the square crop. Remove all typography, logos, trademarks, legal text, and watermarks from the artwork so a clean official logo can be composited later.
Scene/backdrop: dense enchanted Eldraine wilds with thorny silhouettes, jewel-like foliage, mist, magical particles, and painterly teal, emerald, indigo, cyan, and magenta texture reaching every edge
Subject: preserve the same central pale-haired fae ruler, luminous crystalline wings, angular black-and-magenta armor, hands, and glowing faceted pink crystal orb from Image 1
Style/medium: premium painterly fantasy key art matching Image 1 exactly; highly detailed; crisp focal rendering; no photorealism
Composition/framing: exact 6:7 portrait; subject centered and large; face in the upper-middle; orb in the middle; retain both wing silhouettes and useful detailed artwork across the whole frame; leave the lower quarter dark and richly textured enough for a large high-contrast two-line set logo without making it blank or featureless
Lighting/mood: luminous fae magic, alluring and ominous fairy-tale atmosphere, bright cyan rim light, pink crystal glow, deep forest contrast
Color palette: saturated emerald, teal, cyan, indigo, magenta, pale pink, and near-black
Constraints: change only the framing extension and removal of existing typography; preserve the subject's identity, pose, anatomy, hands, orb, wings, armor, lighting, palette, and painterly style; no large empty or featureless regions; no borders; no frames; no cards; no packaging; no Commander montage; no added characters; no text; no logos; no trademarks; no watermark
Avoid: duplicated faces, extra fingers or arms, broken wing geometry, flat gradients, blank black areas, blurry focal details, altered character identity, modern graphic-design elements
```

The finalized brief with deterministic finishing instructions is also preserved at `../prompts/wilds_of_eldraine_commander_official_key_art_adaptation_v1.md`.

### Final transformations and targets

- Production helper: `build_target.swift`.
- Center-cropped only the generated output's tiny excess width, preserving its full vertical composition, then upscaled once with high-quality interpolation to exact 1800 x 2100.
- Added a transparent lower vignette over detailed artwork for drawer-scale title contrast; no region was replaced with a flat or empty field.
- Composited the untouched official transparent set logo `woe_alg_en/MTGWOE_EN_SetLogo.png` (SHA-256 `439499144b5b3cee8f2877a13ab45ab8b8c8edc48bfee19d8423249717f39796`) at x=70, bottom y=150, width=1450 px. It therefore spans 80.6% of the full canvas while ending exactly where the count-seal zone begins.
- Embedded 600-DPI metadata in the finished PNG.
- **Unnumbered base:** `../wilds_of_eldraine_commander_official_key_art_target_v1_1800x2100.png` — 1800 x 2100 px, 600 DPI; SHA-256 `746baf6bb8a0925b0d4d6a1a621bb0383ff948b965756b3a68b76b9eca4d1046`.
- **Counted sibling:** `../wilds_of_eldraine_commander_official_key_art_target_v1_deck_count_2_1800x2100.png` — created non-destructively with `scripts/apply_deck_count.swift ... 2:1800`; 1800 x 2100 px, 600 DPI; SHA-256 `3a2f4c831df19fa39a34623a5436cb0a4346c195fd499bfaa091569818c1c2fe`.
- Drawer previews retained as production intermediates: `wilds_of_eldraine_commander_drawer_preview_v1_300x350.png` and `wilds_of_eldraine_commander_drawer_preview_v1_deck_count_2_300x350.png`.

## Final QA

- **Dimensions / print density:** both targets independently inspected with macOS ImageIO via `sips`; each reports exactly 1800 x 2100 and 600 x 600 DPI.
- **Title accuracy:** the title comes from the untouched official English set-logo PNG, visually verified as exactly **WILDS OF ELDRAINE**. It is a crisp two-line dominant element spanning most of the drawer face with high silver/gold contrast.
- **Drawer readability:** inspected at native resolution and at a 300 x 350 drawer preview. Both title lines remain immediately legible; subject and set identity remain recognizable.
- **Composition / density:** full bleed on all four sides; thorn canopy, foliage, magic ribbons, crystalline wings, armor, and textured shadow fill the entire frame. No large blank, white, flat, or featureless regions.
- **Subject integrity:** one central fae subject, one face, two wings, two visible hands holding one crystal orb; no duplicate character or stray text artifacts.
- **Count seal:** approved script constant is 210 px diameter. For boundary `1800`, the seal occupies x=1520..1730 and y=70..280 in bottom-origin coordinates, leaving its outer edges exactly 70 px from the right and bottom. The official logo ends at x=1520, so the seal does not obscure the title.
- **Folder hygiene:** the set root contains only the two finished PNG targets plus `prompts/` and `src/`; prompts, official/raw downloads, unmodified ImageGen output, helpers, previews, and provenance remain in their prescribed subdirectories.
