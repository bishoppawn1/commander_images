# Fallout Commander source provenance

## Authoritative product and release references

- **Wizards of the Coast product page:** https://magic.wizards.com/en/products/fallout
  - Confirms the canonical `Fallout` product name and the four-deck Commander product line.
- **Wizards Play Network product and marketing-material page:** https://wpn.wizards.com/en/products/magic-the-gathering-fallout?product=3Na3zaVrhuK4Qi5Ie9mDId
  - Official source page for the art/logo pack, key-art social assets, and 24 × 36-inch key-art poster used in this package.
- **Wizards First Look:** https://magic.wizards.com/en/news/announcements/a-first-look-at-magic-the-gathering-fallout-available-march-2024
  - Confirms the release as four Commander decks and identifies the launch key visual as Magic: The Gathering—Fallout Power Armor Art.
- **Wizards decklists:** https://magic.wizards.com/en/news/announcements/magic-the-gathering-fallout-commander-decklists
  - Confirms the four decks represented by this drawer face: Scrappy Survivors, Hail, Caesar, Mutant Menace, and Science!.

## Downloaded official assets

### `pip_key_art_sma_en.zip`

- URL: https://media.wizards.com/2023/wpn/marketing_materials/pip/pip_key_art_sma_en.zip
- Publisher: Wizards Play Network / Wizards of the Coast.
- Contents retained unmodified under `src/pip_key_art_sma_en/`:
  - `pip_sma_key_1000x1000_en.jpg` — 1000 × 1000 px, 72 DPI.
  - `pip_sma_key_1080x1920_en.jpg` — 1080 × 1920 px, 72 DPI.
  - `pip_sma_key_1600x841_en.jpg` — 1600 × 841 px, 72 DPI.
  - `pip_sma_key_1640x680_en.jpg` — 1640 × 680 px, 72 DPI.
  - `pip_sma_key_1920x1080_en.jpg` — 1920 × 1080 px, 72 DPI.
- Role: official branded-composition references; the square and vertical versions were inspected as direct-target candidates.
- Visible credit line: Lilix Yin.

### `pip_alg_en.zip`

- URL: https://media.wizards.com/2023/wpn/marketing_materials/pip/pip_alg_en.zip
- Publisher: Wizards Play Network / Wizards of the Coast.
- Relevant contents retained unmodified under `src/pip_alg_en/`:
  - `pip_1080p_en.jpg` — 1920 × 1080 px, 72 DPI; official landscape Power Armor key art with branding; selected edit target.
  - `MTGPIP_SetLogo_2C_white_en.png` — 900 × 407 px, transparent; official combined Magic: The Gathering / Universes Beyond / Fallout logo selected for the exact title overlay.
  - `MTGPIP_SetLogo_2C_black_en.png` — 900 × 407 px, transparent; alternate official mark retained as reference.
  - Four official PIP set-symbol PNGs retained in their source subdirectory.
- Visible key-art credit line: Lilix Yin.

### `pip_lgp_key_24x36.pdf`

- URL: https://media.wizards.com/2023/wpn/marketing_materials/pip/pip_lgp_key_24x36.pdf
- Publisher: Wizards Play Network / Wizards of the Coast.
- Original: one-page official 24 × 36-inch poster PDF; page geometry 1776 × 2640 points.
- Visible credit line: Raymond Swanland.
- Role: official portrait/poster candidate and high-resolution visual reference.
- `pip_lgp_key_24x36_render_150dpi.png` is a 3700 × 5500 px, 150-DPI production inspection render made with Poppler; it is an intermediate, not a target.

### `pip_set_logo_white_preview.png`

- 900 × 407 px local preview composite of the untouched transparent white official logo on a flat green inspection background.
- Role: alpha/legibility inspection only; not a final target.

## Selection rationale

The official WPN Power Armor hero is more immediately identifiable as the Fallout release than a forced montage of the four deck commanders. Its dense machinery, armor, sparks, and irradiated wasteland support the drawer-face fullness requirement. Wizards' supplied combined logo is used unchanged for exact licensed typography, with `Fallout` scaled across nearly the full face width and Magic / Universes Beyond kept secondary.

## Generation and transformations

- **Generation mode:** built-in ImageGen image edit. No API/CLI fallback was used.
- **Edit target:** `pip_alg_en/pip_1080p_en.jpg`.
- **Exact successful prompt:** preserved in `../prompts/fallout_commander_official_key_art_adaptation_v1.md`.
- **Unmodified retained output:** `fallout_commander_imagegen_key_art_adaptation_v1_unmodified.png`, 1163 × 1353 px, 72 DPI as returned by the built-in service.
- **ImageGen scope:** portrait reframing/environmental extension and removal of the source's integrated text. The generated background contains no typography; all final text comes from Wizards' untouched official logo asset.
- **Deterministic build:** `build_fallout_face_v1.sh` uses FFmpeg Lanczos scaling to bring the background to 2100 pixels high, center-crops the roughly five surplus horizontal pixels to 1800 pixels, and overlays the official white-logo tiers from `MTGPIP_SetLogo_2C_white_en.png`.
- **Primary title placement:** the official `Fallout` tier is 1600 pixels wide at x=100, y=55 (top-origin), spanning 88.9% of the face width.
- **Secondary-brand placement:** the official Magic / Universes Beyond tier is 720 pixels wide, 70 pixels from the left and bottom edges.
- **Print normalization:** the base is exactly 1800 × 2100 pixels with 600 × 600 DPI metadata, full bleed.
- **Counted sibling:** created non-destructively with project script `scripts/apply_deck_count.swift` and argument `4:1800`. Pixel-difference inspection localizes all count changes to the exact 210 × 210 px box x=1520…1729, y=1820…2029 (top-origin), proving 70-pixel right and bottom outer-edge insets.
- **Drawer-scale QA:** 270 × 315 inspection renders are retained as `fallout_commander_target_v1_drawer_scale_270x315.png` and `fallout_commander_target_v1_deck_count_4_drawer_scale_270x315.png`.

## Finished targets

- `../fallout_commander_official_power_armor_key_art_target_v1_1800x2100.png`
  - Unnumbered base; 1800 × 2100 px; 600 DPI.
  - MD5: `564604c482ab0c2dd0cd93d3026058e0`.
- `../fallout_commander_official_power_armor_key_art_target_v1_deck_count_4_1800x2100.png`
  - Counted sibling; 1800 × 2100 px; 600 DPI; one approved `4` seal.
  - MD5: `aef07f43d6f8a04db3d14516141081da`.

## QA result

- Exact required dimensions, 6:7 aspect ratio, and 600-DPI metadata: pass.
- Full bleed and edge-to-edge environmental detail: pass.
- Exact official `Fallout` title, dominant across nearly the full width: pass.
- Magic / Universes Beyond branding readable but secondary: pass.
- One recognizable Power Armor hero with no montage, duplicate subject, generated text, or malformed logo: pass.
- Count seal size, numeral, styling, and equal 70-pixel edge insets: pass.
- Full-size and drawer-scale visual inspection: pass.
