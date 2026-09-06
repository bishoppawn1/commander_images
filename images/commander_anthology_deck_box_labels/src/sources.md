# Sources and provenance

The official commander art crops used by these labels are the source files already retained under:

- `images/commander_anthology_i/src/`
- `images/commander_anthology_ii/src/`

Their exact Scryfall image URLs, artist credits, and printing notes are recorded in those directories' `sources.md` files.

Mana-symbol artwork:

- `mana_symbols/W.svg` and `W.png`: https://svgs.scryfall.io/card-symbols/W.svg
- `mana_symbols/U.svg` and `U.png`: https://svgs.scryfall.io/card-symbols/U.svg
- `mana_symbols/B.svg` and `B.png`: https://svgs.scryfall.io/card-symbols/B.svg
- `mana_symbols/R.svg` and `R.png`: https://svgs.scryfall.io/card-symbols/R.svg
- `mana_symbols/G.svg` and `G.png`: https://svgs.scryfall.io/card-symbols/G.svg

The SVGs are the retained source artwork. The 600 × 600 transparent PNGs are deterministic local conversions used by the Swift renderer.

Product/deck identity sources:

- Commander 2011 / Heavenly Inferno: https://magic.wizards.com/en/news/feature/magic-gathering-commander-decklists-2011-06-14
- Commander 2013 / Evasive Maneuvers: https://magic.wizards.com/en/news/making-magic/all-five-commander-decklists-2013-10-18
- Commander 2014 and 2015 / Guided by Nature, Built from Scratch, Plunder the Graves, and Wade into Battle: https://magic.wizards.com/en/news/feature/commander-2015-edition-decklists-2015-11-06
- Commander Anthology Volume II / Devour for Power and Breed Lethality: https://magic.wizards.com/en/news/announcements/commander-anthology-vol-ii-legends-and-decklists-2018-05-08
- Boulder 100+ top footprint: Ultimate Guard's current Boulder 100+ product specification, 76 mm wide × 75 mm deep.

The three HEIC files supplied by the user were used only as layout and placement references. They were not copied into the labels.

## Regenerated background art

Eight high-detail background paintings were generated with built-in OpenAI ImageGen, one per face commander, using the exact official Commander Anthology art crop as the sole image reference. The originals remain unchanged. Generated files are retained under `regenerated_art_v1/`; the exact prompt set is recorded in `../prompts/regenerated_art_v1_prompts.md`.

The current 1200 DPI tall-label revision uses the regenerated backgrounds in `regenerated_art_v3_tall/`. They were created from the clean v2 paintings as identity references, with a brighter print-oriented exposure and a taller 33:28 composition. Exact prompts are retained in `../prompts/regenerated_art_v3_tall_1200dpi_prompts.md`.

| Generated file | Reference crop |
| --- | --- |
| `regenerated_art_v1/kaalia_of_the_vast_regenerated_v1.png` | `images/commander_anthology_i/src/kaalia_of_the_vast.jpg` |
| `regenerated_art_v1/derevi_empyrial_tactician_regenerated_v1.png` | `images/commander_anthology_i/src/derevi_empyrial_tactician.jpg` |
| `regenerated_art_v1/freyalise_llanowars_fury_regenerated_v1.png` | `images/commander_anthology_i/src/freyalise_llanowars_fury.jpg` |
| `regenerated_art_v1/meren_of_clan_nel_toth_regenerated_v1.png` | `images/commander_anthology_i/src/meren_of_clan_nel_toth.jpg` |
| `regenerated_art_v1/the_mimeoplasm_regenerated_v1.png` | `images/commander_anthology_ii/src/the_mimeoplasm.jpg` |
| `regenerated_art_v1/daretti_scrap_savant_regenerated_v1.png` | `images/commander_anthology_ii/src/daretti_scrap_savant.jpg` |
| `regenerated_art_v1/kalemne_disciple_of_iroas_regenerated_v1.png` | `images/commander_anthology_ii/src/kalemne_disciple_of_iroas.jpg` |
| `regenerated_art_v1/atraxa_praetors_voice_regenerated_v1.png` | `images/commander_anthology_ii/src/atraxa_praetors_voice.jpg` |
