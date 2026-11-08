# Aetherdrift — Boulder top production

Created October 5, 2026. Product names, deck contents, and colors verified against the [official decklist](https://magic.wizards.com/en/news/announcements/aetherdrift-commander-decklists).

## Reference art

- **LIVING ENERGY — Saheeli, Radiant Creator**. Original artist: Ernanda Souza. [Official card artwork via Scryfall](https://cards.scryfall.io/art_crop/front/5/f/5fea0781-e933-47ef-9414-92c8652a7778.jpg?1783907753); [card record](https://scryfall.com/card/drc/3/saheeli-radiant-creator?utm_source=api). Untouched reference: `living_energy_official_art.jpg`, 626 × 457 pixels.
- **ETERNAL MIGHT — Temmet, Naktamun's Will**. Original artist: Douglas Shuler. [Official card artwork via Scryfall](https://cards.scryfall.io/art_crop/front/c/0/c0629894-0b72-4abe-9771-03becfdb241c.jpg?1783907753); [card record](https://scryfall.com/card/drc/4/temmet-naktamuns-will?utm_source=api). Untouched reference: `eternal_might_official_art.jpg`, 626 × 457 pixels.

## Production

Used the built-in ImageGen tool to adapt each reference into a detailed 33:28 illustration with clear space for the established mana and text overlays. Generated artwork is an adaptation, not an unmodified official illustration. Unmodified tool outputs are retained in this folder. The corresponding exact briefs are in `../prompts/`; use the highest version for the selected artwork.

`images/build_boulder_labels.swift` draws the same project-native mana symbols, exact deck name, concise strategy text, green frame, and product name used by the existing collection. The manifest is the source of truth for text, color order, and art selection. Final labels are rendered directly at **3960 × 3360 pixels, 1440 DPI, sRGB**, with native text at the target resolution. Artwork is resampled; DPI metadata does not imply native 1440-DPI illustration detail. Printed size remains **2.75 × 2 1/3 inches**.

The ten labels from this batch share Boulder Tops sheet 10. No existing label or sheet is replaced.
