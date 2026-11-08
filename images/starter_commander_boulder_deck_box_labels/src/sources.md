# Starter Commander — Boulder top production

Created October 5, 2026. Product names, deck contents, and colors verified against the [official decklist](https://magic.wizards.com/en/news/announcements/starter-commander-decks-decklists-2022-10-20).

## Reference art

- **FIRST FLIGHT — Isperia, Supreme Judge**. Original artist: Scott M. Fischer. [Official card artwork via Scryfall](https://cards.scryfall.io/art_crop/front/1/e/1e3b82a7-ebef-4190-9f50-40b992ba89c9.jpg?1783931147); [card record](https://scryfall.com/card/c20/217/isperia-supreme-judge?utm_source=api). Untouched reference: `first_flight_official_art.jpg`, 626 × 457 pixels.
- **GRAVE DANGER — Gisa and Geralf**. Original artist: Karla Ortiz. [Official card artwork via Scryfall](https://cards.scryfall.io/art_crop/front/b/c/bce9bf8d-4d22-4967-bd9e-27fe444ef3f6.jpg?1783908077); [card record](https://scryfall.com/card/inr/237/gisa-and-geralf?utm_source=api). Untouched reference: `grave_danger_official_art.jpg`, 626 × 457 pixels.
- **CHAOS INCARNATE — Kardur, Doomscourge**. Original artist: Chris Rahn. [Official card artwork via Scryfall](https://cards.scryfall.io/art_crop/front/7/c/7c0f7712-7bbf-471b-8107-3a49cf922ad9.jpg?1783909592); [card record](https://scryfall.com/card/dsc/223/kardur-doomscourge?utm_source=api). Untouched reference: `chaos_incarnate_official_art.jpg`, 626 × 457 pixels.
- **DRACONIC DESTRUCTION — Atarka, World Render**. Original artist: Karl Kopinski. [Official card artwork via Scryfall](https://cards.scryfall.io/art_crop/front/c/5/c569fab1-6901-40ab-b958-001698819585.jpg?1783907034); [card record](https://scryfall.com/card/tdc/281/atarka-world-render?utm_source=api). Untouched reference: `draconic_destruction_official_art.jpg`, 626 × 457 pixels.
- **TOKEN TRIUMPH — Emmara, Soul of the Accord**. Original artist: Mark Winters. [Official card artwork via Scryfall](https://cards.scryfall.io/art_crop/front/4/1/41b930ee-e16b-4612-87de-c03ecc6ff6db.jpg?1783934136); [card record](https://scryfall.com/card/grn/168/emmara-soul-of-the-accord?utm_source=api). Untouched reference: `token_triumph_official_art.jpg`, 626 × 457 pixels.

## Production

Used the built-in ImageGen tool to adapt each reference into a detailed 33:28 illustration with clear space for the established mana and text overlays. Generated artwork is an adaptation, not an unmodified official illustration. Unmodified tool outputs are retained in this folder. The corresponding exact briefs are in `../prompts/`; use the highest version for the selected artwork.

`images/build_boulder_labels.swift` draws the same project-native mana symbols, exact deck name, concise strategy text, green frame, and product name used by the existing collection. The manifest is the source of truth for text, color order, and art selection. Final labels are rendered directly at **3960 × 3360 pixels, 1440 DPI, sRGB**, with native text at the target resolution. Artwork is resampled; DPI metadata does not imply native 1440-DPI illustration detail. Printed size remains **2.75 × 2 1/3 inches**.

The ten labels from this batch share Boulder Tops sheet 10. No existing label or sheet is replaced.
