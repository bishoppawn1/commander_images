# FINAL FANTASY Commander drawer-face sources and production record

Research and production completed **2026-08-26**. Only official Wizards of the Coast / Wizards Play Network and licensed Square Enix materials were used as visual sources. The drawer represents all four original 2025 Commander decks, not the later standalone FINAL FANTASY VII Game Edition.

## Authoritative product and reveal research

1. **Wizards Play Network product page — Magic: The Gathering—FINAL FANTASY**  
   https://wpn.wizards.com/en/products/final-fantasy?product=5c8WindcxLGBan34WFm8q1  
   Authoritative download hub for the product shots, art-and-logo archive, key-art social assets, 24 × 36 key-art poster, oversized art, banner stand, and other retailer materials. The page also identifies the regular and Collector's Edition Commander product line.

2. **Official Wizards product page — Magic: The Gathering—FINAL FANTASY**  
   https://magic.wizards.com/en/products/final-fantasy  
   Confirms the full licensed set identity and the Commander Decks / Collector's Edition Commander Decks product categories.

3. **Official Wizards Commander decklists announcement** (Jubilee Finnegan, 2025-05-12)  
   https://magic.wizards.com/en/news/announcements/final-fantasy-commander-decklists  
   Authoritative deck-count and naming source. It states that the release contains four new Commander decks: **Revival Trance** (FINAL FANTASY VI), **Limit Break** (FINAL FANTASY VII), **Counter Blitz** (FINAL FANTASY X), and **Scions & Spellcraft** (FINAL FANTASY XIV). This supports the required count marker `4`.

4. **Official Wizards preview/debut index** (Jubilee Finnegan, 2025-05-09)  
   https://magic.wizards.com/en/news/announcements/where-to-find-final-fantasy-previews  
   Records the May 10 set debut and credits the promoted ensemble image to **Magali Villeneuve**. It also distinguishes FIN previews from FIC Commander previews.

5. **WPN Dates & Details** (2025-02-18)  
   https://wpn.wizards.com/en/news/dates-and-details-for-magic-the-gathering-final-fantasy  
   Official early reveal / retailer announcement and pointer to the newly released key-art marketing materials.

6. **WPN Events & Promos Overview**  
   https://wpn.wizards.com/en/news/magic-the-gathering-r-final-fantasy-tm-events-and-promos-overview  
   Confirms that the seasonal kit included a main set poster plus five character posters.

7. **WPN Prerelease Planning Guide**  
   https://wpn.wizards.com/en/news/magic-the-gathering-final-fantasy-prerelease-planning-guide  
   Official visual reference for the printed main poster and five character-poster takeover assets.

## Retained official WPN source packages

All originals below are preserved unmodified in `src/`.

### Art and logos

- `official_wpn_fin_art_and_logos.zip` — 1.7 MB original archive.  
  Direct URL: https://media.wizards.com/2025/wpn/marketing_materials/fin/fin_alg.zip
- Extracted into `official_wpn_assets/`:
  - `FIN_sma_key_1920x1080.jpg` — 1920 × 1080 px official key art.
  - `MTGFIN_EN_LockUp_Black.png` — 1000 × 218 px transparent official horizontal lockup.
  - `MTGFIN_EN_LockUp_White.png` — 1000 × 218 px transparent official horizontal lockup.
  - `MTGFIN_EN_LockUp_Stacked_Black.png` — 1000 × 702 px transparent official stacked lockup.
  - `MTGFIN_EN_LockUp_Stacked_White.png` — 1000 × 702 px transparent official stacked lockup; selected as the exact final identity overlay.
  - `FIN_cmmdr_expsym_{c,u,r,m}_3in.png` — 900 × 900 px official FIC Commander expansion symbols. The mythic version is used as the small lower-left licensed accent.
  - `FIN_main_expsym_{c,u,r,m}.png` — 900 × 900 px official FIN main-set symbols, retained but not used.

`MTGFIN_EN_Magic_Wordmark_White_Derived.png` (970 × 340 px) and `MTGFIN_EN_Final_Fantasy_Wordmark_White_Derived.png` (970 × 230 px) are transparent, lossless region crops from `MTGFIN_EN_LockUp_Stacked_White.png`. They separate the two unchanged rows so FINAL FANTASY can span nearly the full face width without redrawing or AI-generating any letter. The exact commands were:

```sh
ffmpeg -i MTGFIN_EN_LockUp_Stacked_White.png -vf 'crop=970:340:15:0' MTGFIN_EN_Magic_Wordmark_White_Derived.png
ffmpeg -i MTGFIN_EN_LockUp_Stacked_White.png -vf 'crop=970:230:15:472' MTGFIN_EN_Final_Fantasy_Wordmark_White_Derived.png
```

`stacked_white_logo_preview.png` is a neutral-gray inspection composite only; it confirms that the source lockup includes the exact MAGIC: THE GATHERING and FINAL FANTASY trademarks.

### Key-art social media assets

- `official_wpn_fin_key_art_social_media_assets.zip` — 2.7 MB original archive.  
  Direct URL: https://media.wizards.com/2025/wpn/marketing_materials/fin/fin_sma_key.zip
- Extracted into `official_wpn_assets/`:
  - `FIN_sma_key_1000x1000.jpg` — 1000 × 1000 px, Cloud and Sephiroth branded square.
  - `FIN_sma_key_1080x1920.jpg` — 1080 × 1920 px, Magali Villeneuve four-character branded vertical; **selected primary edit target**.
  - `FIN_sma_key_1600x841.jpg` — 1600 × 841 px official landscape.
  - `FIN_sma_key_1640x680.jpg` — 1640 × 680 px official wide landscape.
  - `FIN_sma_key_1920x1080.jpg` — 1920 × 1080 px official landscape.

The vertical asset was selected because it is licensed whole-set key art rather than a Commander-package montage, places recognizable characters from multiple FINAL FANTASY installments in one established set composition, and already includes the official product identity. Its major defect for this project is its extensive white/faded poster field, so it was adapted rather than directly promoted to a target.

### Key-art poster and banner

- `official_wpn_fin_key_art_poster_24x36.pdf` — 1737 × 2601 pt, single-page official print PDF, 4.6 MB.  
  Direct URL: https://media.wizards.com/2025/wpn/marketing_materials/fin/fin_lgp_key_24x36.pdf  
  PDF credit line: **© SQUARE ENIX; © 2025 Wizards of the Coast LLC.; Magali Villeneuve**.  
  `official_wpn_fin_key_art_poster_preview.png` is a 75-PPI 1810 × 2710 inspection render. It confirms the same ensemble art, exact FINAL FANTASY wordmark, and large white/faded regions that made direct use unsuitable.
- `official_wpn_fin_banner_stand_34x80.pdf` — 2448 × 5760 pt, single-page official print PDF, 28 MB.  
  Direct URL: https://media.wizards.com/2025/wpn/marketing_materials/fin/fin_bnr_stnd_34x80_en.pdf  
  `official_wpn_fin_banner_stand_preview.png` is a 36-PPI 1224 × 2880 inspection render. It is a dense branded vertical featuring Kefka and credited on-art to **Ramza Psyru**, but it was not selected because a single-installment character would narrow the whole-set identity.

### Product shots

- `official_wpn_fin_product_shots_en.zip` — 66 MB original product archive.  
  Direct URL: https://media.wizards.com/2025/wpn/marketing_materials/fin/fin_pds_en.zip
- Selected references extracted into `official_wpn_product_refs/`:
  - `MTGFIN_EN_OtrBx_Cmndr_All.png` — 900 × 900 px regular four-deck lineup.
  - `MTGFIN_EN_OtrBx_Cmndr_01_01.png` through `_04_01.png` — each 900 × 928 px regular Commander package front.
  - `MTGFIN_EN_OtrBx_ClctrCmndr_All.png` — 900 × 851 px Collector's Edition lineup.

These were used only to confirm product identity and grouping. They were deliberately excluded from the face composition to avoid a Commander packaging montage.

### Physical WPN poster references

Downloaded directly from the official WPN Prerelease Planning Guide:

- `official_wpn_main_set_poster.png` — 600 × 789 px.  
  https://images.ctfassets.net/0piqveu8x9oj/7jl2K88QVdBFfdHDE4zr4D/8af3012ce2d9e54daf164deac66d9075/MTGFIN_EN_Pstr.png
- `official_wpn_character_poster_1.png` — 700 × 921 px, Cloud.  
  https://images.ctfassets.net/0piqveu8x9oj/5JmHoXzZkeSA0FSakYPXsV/5e1033c0ead4592c08ca248e1229f678/FIN_Character_Poster_1.png
- `official_wpn_character_poster_2.png` — 700 × 921 px, Firion.  
  https://images.ctfassets.net/0piqveu8x9oj/3fFwDcOaSBD88OLHv3Dbha/e8c18c69caedf7e41a9d820a71d2e692/FIN_Character_Poster_2.png
- `official_wpn_character_poster_3.png` — 700 × 921 px, Terra.  
  https://images.ctfassets.net/0piqveu8x9oj/3TB89bNQxMzx6PSUOZSubp/d2d6e0549d6057ee1d73ba0653ae19e4/FIN_Character_Poster_3.png
- `official_wpn_character_poster_4.png` — 700 × 921 px, Emet-Selch.  
  https://images.ctfassets.net/0piqveu8x9oj/43B011UiePZs5hLswfcv0H/88099bd1b4ac31d9a67bf16fc9aceda6/FIN_Character_Poster_4.png
- `official_wpn_character_poster_5.png` — 700 × 921 px, Sephiroth.  
  https://images.ctfassets.net/0piqveu8x9oj/2RKpXBh7okgIfORmmqGB6H/d63cd3ef0549348c6023883dbfb81532/FIN_Character_Poster_5.png

`official_wpn_character_posters_contact_sheet.png` is an inspection-only comparison. The character posters were not selected because their long flat-color fields and single-character focus are weaker whole-set identifiers at the required 6:7 drawer scale.

## Built-in ImageGen adaptation

- Mode: **built-in ImageGen edit**, taxonomy `identity-preserve`.
- Edit target: `official_wpn_assets/FIN_sma_key_1080x1920.jpg`.
- Finalized prompt: `../prompts/final_fantasy_commander_official_key_art_adaptation_brief.md`.
- Unmodified generated output: `final_fantasy_commander_imagegen_official_key_art_adaptation_raw_v1.png` — 1163 × 1353 px, 72-DPI source metadata.
- Built-in default output provenance: copied without modification from `/Users/bishophall/.codex/generated_images/01a03c72-982a-7ca2-a1e7-671a6081b911/exec-e93d409a-9f35-42cc-8f15-12ef19a4ee72.png`.

The edit preserved the official four-character ensemble (Terra, Cloud, Warrior of Light, and Y'shtola) while replacing the white/faded poster field with dense midnight-blue crystalline atmosphere. The prompt explicitly forbade generated text and logos. All title/logo work was performed deterministically from the untouched official WPN lockup after generation.

## Deterministic target construction

Script: `build_final_fantasy_commander_target.swift`

1. Center-crop the unmodified 1163 × 1353 generated art to 1160 × 1353 (three total side pixels removed), then scale with high-quality interpolation to 1800 × 2100.
2. Apply a translucent obsidian readability veil across the lower torso/leg region while keeping the crystalline image visible beneath it.
3. Composite the official cropped Magic row at 760 px wide.
4. Composite the official cropped FINAL FANTASY row at **1660 px wide**, with 70 px left/right insets. It is the exact dominant title and largest information element.
5. Add the official mythic FIC Commander expansion symbol at 220 × 220 px in the lower-left corner.
6. Write sRGB PNG output with 600-DPI metadata.

Build command:

```sh
swift src/build_final_fantasy_commander_target.swift \
  src/final_fantasy_commander_imagegen_official_key_art_adaptation_raw_v1.png \
  src/official_wpn_assets/MTGFIN_EN_Magic_Wordmark_White_Derived.png \
  src/official_wpn_assets/MTGFIN_EN_Final_Fantasy_Wordmark_White_Derived.png \
  src/official_wpn_assets/FIN_cmmdr_expsym_m_3in.png \
  final_fantasy_commander_official_key_art_crystal_target_v1_1800x2100.png
```

Counted sibling command:

```sh
swift ../../scripts/apply_deck_count.swift \
  final_fantasy_commander_official_key_art_crystal_target_v1_1800x2100.png \
  final_fantasy_commander_official_key_art_crystal_target_v1_deck_count_4_1800x2100.png \
  4:1800
```

The project-standard script renders a 210 px dark circular seal with antique-gold rim and pale-ivory Copperplate Bold numeral. For boundary `1800`, its center is `(1625, 175)` in the script's bottom-left coordinate system; therefore the circular outer edge is exactly 70 px from the right edge (`x = 1730`) and bottom edge (`y = 70`).

## Final targets and QA

- `../final_fantasy_commander_official_key_art_crystal_target_v1_1800x2100.png`
  - 1800 × 2100 px, exact 6:7, sRGB, 600 × 600 DPI.
  - Unnumbered non-destructive base.
- `../final_fantasy_commander_official_key_art_crystal_target_v1_deck_count_4_1800x2100.png`
  - 1800 × 2100 px, exact 6:7, sRGB, 600 × 600 DPI.
  - Separate count-4 sibling; base preserved.

Visual QA was performed at full resolution and at drawer scale using:

- `final_fantasy_commander_drawer_preview_v1_300x350.png`
- `final_fantasy_commander_drawer_preview_v1_deck_count_4_300x350.png`
- `final_fantasy_commander_count_seal_inspection_v1.png` — 400 × 400 lower-right inspection crop; visibly confirms the 70 px right/bottom clearances around the 210 px seal.

Checks passed:

- `FINAL FANTASY` is exact, unmodified official typography, unobstructed, high contrast, and spans 1660/1800 px (92.2% of the face width).
- The Magic and FINAL FANTASY marks are official WPN assets, not AI-rendered text; no malformed or extra text is present.
- Whole-set licensed key art, not a four-package or four-face-commander montage, is the visual center.
- All four ensemble faces remain clear and immediately recognizable at full size; Cloud remains the center focal subject.
- Crystalline detail fills every edge; there are no blank, white, flat, or low-information regions.
- The title remains the dominant first read in the 300 × 350 drawer preview.
- The `4` seal remains legible at drawer scale, does not touch the title, and uses the approved 210 px / 70 px standard placement.
- Both deliverables report exact 1800 × 2100 dimensions and 600 × 600 DPI metadata.
