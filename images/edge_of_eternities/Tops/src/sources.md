# Edge Of Eternities — Boulder top production

Created October 5, 2026. Product names, deck contents, and colors verified against the [official decklist](https://magic.wizards.com/en/news/announcements/edge-of-eternities-commander-decklists).

## Reference art

- **WORLD SHAPER — Hearthhull, the Worldseed**. Original artist: Daniel Ljunggren. [Official card artwork via Scryfall](https://cards.scryfall.io/art_crop/front/6/b/6b913e79-a9f6-44d4-bb37-c4f6f66b8151.jpg?1783906067); [card record](https://scryfall.com/card/eoc/1/hearthhull-the-worldseed?utm_source=api). Untouched reference: `world_shaper_official_art.jpg`, 626 × 457 pixels.
- **COUNTER INTELLIGENCE — Kilo, Apogee Mind**. Original artist: Tuan Duong Chu. [Official card artwork via Scryfall](https://cards.scryfall.io/art_crop/front/3/0/307a859e-eb80-4af6-b731-92e4767b5100.jpg?1783906067); [card record](https://scryfall.com/card/eoc/3/kilo-apogee-mind?utm_source=api). Untouched reference: `counter_intelligence_official_art.jpg`, 626 × 457 pixels.

## Production

Used the built-in ImageGen tool to adapt each reference into a detailed 33:28 illustration with clear space for the established mana and text overlays. Generated artwork is an adaptation, not an unmodified official illustration. Unmodified tool outputs are retained in this folder. The corresponding exact briefs are in `../prompts`; use the highest version for the selected artwork.

`images/build_boulder_labels.swift` draws the same project-native mana symbols, exact deck name, concise strategy text, green frame, and product name used by the existing collection. The manifest is the source of truth for text, color order, and art selection. Final labels are rendered directly at **3960 × 3360 pixels, 1440 DPI, sRGB**, with native text at the target resolution. Artwork is resampled; DPI metadata does not imply native 1440-DPI illustration detail. Printed size remains **2.75 × 2 1/3 inches**.

The ten labels from this batch share Boulder Tops sheet 10. No existing label or sheet is replaced.
