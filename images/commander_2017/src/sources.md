# Commander 2017 sources and production notes

## Authoritative product identity and deck count

- Wizards of the Coast, [Commander (2017 Edition) Decklists](https://magic.wizards.com/en/news/feature/commander-2017-edition-decklists-2017-08-11), published August 11, 2017. This official decklist article identifies the four release decks: Feline Ferocity, Vampiric Bloodlust, Draconic Domination, and Arcane Wizardry. It is the product/deck-count authority used for the four-lead treatment and the `4` count seal.
- Wizards of the Coast, [Commander (2017 Edition) Card Image Gallery](https://magic.wizards.com/en/news/card-image-gallery/commander-2017), published August 11, 2017. This official gallery supplies the Commander 2017 printings used as character-identity references.
- Wizards of the Coast, [Tales from Designing Commander (2017 Edition)](https://magic.wizards.com/en/news/feature/tales-designing-commander-2017-edition-2017-08-17), published August 17, 2017. This official design article confirms the release's tribal premise and the Cat, Vampire, Wizard, and Dragon deck identities.

## Retained official references

| Local file | Official URL | Original pixels | Attribution / role |
| --- | --- | ---: | --- |
| `official_commander_2017_decklists_meta.jpeg` | `https://images.ctfassets.net/s5n2t79q9icq/lZ8FevAfgKNfj8aLDHwxI/8088561bd7fc5435d5dc44daea11cdcb/en_articles_archive_feature_commander-2017-edition-decklists-2017-08-11-meta-image.jpeg` | 768 × 432 | Official Wizards decklist social/meta art; Jesper Ejsing's Arahbo art crop; palette and painterly-finish reference. |
| `official_card_arahbo_roar_of_the_world.png` | `https://media.wizards.com/2017/c17/en_kqVPwMnL5C.png` | 265 × 370 | Official Commander 2017 card image. Arahbo identity reference; art by Jesper Ejsing. |
| `official_card_edgar_markov.png` | `https://media.wizards.com/2017/c17/en_41iZZBXhco.png` | 265 × 370 | Official Commander 2017 card image. Edgar Markov identity reference; art by Volkan Baǵa. |
| `official_card_inalla_archmage_ritualist.png` | `https://media.wizards.com/2017/c17/en_mVgLLkMEZJ.png` | 265 × 370 | Official Commander 2017 card image. Inalla identity reference; art by Yongjae Choi. |
| `official_card_the_ur_dragon.png` | `https://media.wizards.com/2017/c17/en_NchsNISzki.png` | 265 × 370 | Official Commander 2017 card image. The Ur-Dragon identity reference; art by Jaime Jones. |

The five files above are unmodified downloads retained in `src/`. They are reference inputs, not finished targets.

## Generation and transformations

- Mode: built-in ImageGen, reference-guided generation.
- Finalized prompt: `../prompts/commander_2017_four_leads_v1.md`.
- ImageGen inputs: the five retained official references listed above, in that order.
- Intended generation role: create one premium coherent ensemble composition with exactly one visual lead for each of the four decks. The official card frames and rules text are reference-only and must not appear in the result.
- Post-generation plan: preserve every unmodified selected ImageGen output in `src/`; normalize the selected artwork non-destructively to exact 1800 × 2100 pixels; apply or replace the title plaque deterministically if necessary for exact `COMMANDER 2017` typography; write 600-DPI metadata; retain the unnumbered finished base in the set root; create a counted sibling with the repository's approved deterministic count-seal script using marker specification `4:1800`.

## Selected output and final transformations

- `imagegen_commander_2017_four_leads_raw_v1.png` — unmodified built-in ImageGen output, 1163 × 1353 pixels at 72 DPI. Selected on the first generation pass because it contains exactly one Arahbo, one Edgar Markov, one Inalla, and one Ur-Dragon; the four identities are coherent and immediately distinct; the artwork is edge-to-edge; and the generated title reads exactly `COMMANDER 2017` once, at dominant drawer-readable scale.
- `../commander_2017_four_tribes_ensemble_v1.png` — finished unnumbered base. The raw generation was center-cropped by three total horizontal pixels, from 1163 × 1353 to 1160 × 1353, to normalize the near-6:7 generation without removing any subject or title content. That crop was high-quality resampled to exact 1800 × 2100 pixels and tagged at 600 × 600 DPI. No repainting or title replacement was needed.
- `../commander_2017_four_tribes_ensemble_deck_count_4_v1.png` — finished counted sibling. Created from the unnumbered base by running `scripts/apply_deck_count.swift` with marker specification `4:1800`. The deterministic seal is 210 pixels (0.35 inch) in diameter, with its outer edge 70 pixels from both the right and bottom boundaries. Output remains exact 1800 × 2100 pixels at 600 × 600 DPI.

## Visual QA

- Dominant text is exactly `COMMANDER 2017`, horizontal, high contrast, unobstructed, and spans nearly the full usable width.
- Exactly four lead identities appear: Edgar upper-left, The Ur-Dragon upper-right, Arahbo lower-left, and Inalla lower-right. No lead is duplicated or omitted.
- The scene is one coherent painterly composition with no hard quadrant borders and no large empty or low-information areas.
- Faces, dragon head, and title remain within print-safe framing after the normalization crop.
- The count seal sits in the true lower-right corner and covers only secondary spell-energy texture, not a face, title, or critical silhouette.
- Both finished PNGs were visually inspected after output and independently verified as 1800 × 2100 with 600-DPI metadata.
