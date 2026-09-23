# Boulder deck-box label production record

## Split point

The owned collection needs **91 new unique label designs** after excluding the eight existing Commander Anthology designs. Breed Lethality is reused from Commander Anthology II and is not regenerated.

This yields **99 unique designs** but **100 physical deck-top files**. The Breed Lethality design appears in both the Commander Anthology and Commander 2016 folders.

- **First half complete:** 45 labels, ending with **The Brothers' War Commander**.
- **Second half complete:** 46 labels, beginning with **Phyrexia: All Will Be One Commander**.
- **Total complete:** 91 new unique labels, plus 8 retained Commander Anthology labels.

## Completed first-half release folders

| Release | New labels |
| --- | ---: |
| Commander 2013 | 2 |
| Commander 2016 | 1 |
| Commander 2017 | 4 |
| Commander 2018 | 4 |
| Commander 2019 | 4 |
| Throne of Eldraine Brawl | 4 |
| Commander 2020 | 5 |
| Zendikar Rising Commander | 2 |
| Commander Legends | 2 |
| Strixhaven Commander | 5 |
| Adventures in the Forgotten Realms Commander | 4 |
| Kamigawa: Neon Dynasty Commander | 2 |
| Warhammer 40,000 Commander | 4 |
| The Brothers' War Commander | 2 |
| **Total** | **45** |

Every release has its own `images/<release>_boulder_deck_box_labels/` folder. Each folder contains all of that release's print-ready labels, a contact sheet, its JSON content manifest, regenerated artwork, and commander reference art where applicable.

## Completed second-half order

1. Phyrexia: All Will Be One Commander — 2
2. March of the Machine Commander — 5
3. The Lord of the Rings: Tales of Middle-earth Commander — 4
4. Commander Masters — 4
5. Wilds of Eldraine Commander — 2
6. Doctor Who Commander — 4
7. The Lost Caverns of Ixalan Commander — 4
8. Fallout Commander — 4
9. Modern Horizons 3 Commander — 4
10. Bloomburrow Commander — 4
11. FINAL FANTASY Commander — 4
12. Teenage Mutant Ninja Turtles Commander — 1
13. Marvel Super Heroes Commander — 4

Total completed in this half: **46 labels**. Total remaining: **0**.

The four Marvel Super Heroes labels use the retained commander reference artwork directly because repeated illustration-generation attempts were rejected. Their typography, mana symbols, borders, sizing, and print metadata use the same deterministic Boulder-label compositor as every other label.

## Shared production files

- Template reference: `/Users/bishophall/.codex/skills/artifact-template-mtg-commander-boulder-deck-label/assets/reference.png`
- Deterministic label renderer: `images/build_boulder_labels.swift`
- Scryfall reference-art helper: `images/fetch_scryfall_art.sh`
- Specification: `images/BOULDER_DECK_BOX_LABEL_GENERATION_SPEC.md`

Build a release after its generated backgrounds and `label_manifest.json` are present:

```sh
swift images/build_boulder_labels.swift "$PWD" \
  images/<release>_boulder_deck_box_labels/label_manifest.json \
  images/<release>_boulder_deck_box_labels
```

The retained 1200-DPI label files are 3300 × 2800 px. The current higher-resolution deck-top editions are 3960 × 3360 px, sRGB PNG, tagged at 1440 DPI. Front and face artwork was not included in the 1440-DPI deck-top conversion.
