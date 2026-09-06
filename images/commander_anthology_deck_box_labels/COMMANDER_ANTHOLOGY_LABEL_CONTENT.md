# Commander Anthology Boulder-label content manifest

This file contains only Commander Anthology-specific content and implementation details. The reusable design and print rules live in [`../BOULDER_DECK_BOX_LABEL_GENERATION_SPEC.md`](../BOULDER_DECK_BOX_LABEL_GENERATION_SPEC.md).

## Label content

| Product | Deck title | One-line description | Mana-symbol order |
| --- | --- | --- | --- |
| Commander Anthology | Heavenly Inferno | ATTACK WITH KAALIA • DROP BIG THREATS | Red, White, Black |
| Commander Anthology | Evasive Maneuvers | EVADE BLOCKERS • TAP & UNTAP FOR VALUE | Green, White, Blue |
| Commander Anthology | Guided by Nature | MAKE ELVES & MANA • OVERWHELM THE TABLE | Green |
| Commander Anthology | Plunder the Graves | SACRIFICE CREATURES • REANIMATE THEM | Black, Green |
| Commander Anthology Volume II | Devour for Power | FILL GRAVEYARDS • BUILD A HUGE MIMEOPLASM | Black, Green, Blue |
| Commander Anthology Volume II | Built from Scratch | SACRIFICE ARTIFACTS • REANIMATE MACHINES | Red |
| Commander Anthology Volume II | Wade into Battle | RAMP INTO GIANTS • ATTACK WITH EXPERIENCE | Red, White |
| Commander Anthology Volume II | Breed Lethality | ADD COUNTERS • PROLIFERATE EVERY TURN | Green, White, Blue, Black |

The shortened descriptions preserve the central plan of each original deck while fitting as a single line.

## Authoritative deck sources

- Commander 2011 / Heavenly Inferno: https://magic.wizards.com/en/news/feature/magic-gathering-commander-decklists-2011-06-14
- Commander 2013 / Evasive Maneuvers: https://magic.wizards.com/en/news/making-magic/all-five-commander-decklists-2013-10-18
- Commander 2014 and 2015 / Guided by Nature, Built from Scratch, Plunder the Graves, and Wade into Battle: https://magic.wizards.com/en/news/feature/commander-2015-edition-decklists-2015-11-06
- Commander Anthology Volume II / Devour for Power and Breed Lethality: https://magic.wizards.com/en/news/announcements/commander-anthology-vol-ii-legends-and-decklists-2018-05-08

## Rebuild

From the repository root:

```sh
swift images/commander_anthology_deck_box_labels/src/build_labels.swift \
  "$PWD" \
  "$PWD/images/commander_anthology_deck_box_labels"
```
