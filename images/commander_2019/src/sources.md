# Commander 2019 sources and production notes

## Authoritative product identity and deck count

- Wizards of the Coast, [Commander (2019 Edition) Release Notes](https://magic.wizards.com/en/news/feature/commander-2019-edition-release-notes-2019-08-09), published August 9, 2019. This official release document states that Commander 2019 contains four game packs and names them `Faceless Menace`, `Merciless Rage`, `Mystic Intellect`, and `Primal Genesis`. It is the authority for the four-deck composition and the `4` count seal.
- Wizards of the Coast, [The Decks of Commander (2019 Edition)](https://magic.wizards.com/en/news/feature/decks-commander-2019-edition-2019-08-08), published August 8, 2019. This official decklist article is the deck-content authority and supplies the retained Commander 2019 meta/key image.
- Wizards of the Coast, [Commander (2019 Edition) Card Image Gallery](https://magic.wizards.com/en/news/card-image-gallery/commander-2019-edition), published August 9, 2019. This official gallery supplies the Commander 2019 card images used as face-commander identity references.

## Retained official references

| Local file | Official URL | Original pixels | Attribution / role |
| --- | --- | ---: | --- |
| `official_commander_2019_decks_meta_wizards.jpeg` | `https://images.ctfassets.net/s5n2t79q9icq/3g27opHjOyEtKDOQRiWhKj/c9dd01f579c4f7ab2307cc2e5a3dcf7d/en_articles_archive_feature_decks-commander-2019-edition-2019-08-08-meta-image.jpeg` | 768 × 432 | Official Wizards decklist social/meta key art; Kadena illustration by Caio Monteiro; palette, atmosphere, finish, and secondary Kadena reference. |
| `official_card_anje_falkenrath.png` | `https://media.wizards.com/2019/c19/en_ajhZ1B3oqW.png` | 265 × 370 | Official Commander 2019 card image. Anje Falkenrath identity reference for Merciless Rage; art by Cynthia Sheppard. |
| `official_card_ghired_conclave_exile.png` | `https://media.wizards.com/2019/c19/en_ew7rUSfILV.png` | 265 × 370 | Official Commander 2019 card image. Ghired identity reference for Primal Genesis; art by Yongjae Choi. |
| `official_card_kadena_slinking_sorcerer.png` | `https://media.wizards.com/2019/c19/en_ez6m4n8ZVc.png` | 265 × 370 | Official Commander 2019 card image. Kadena identity reference for Faceless Menace; art by Caio Monteiro. |
| `official_card_sevinne_the_chronoclasm.png` | `https://media.wizards.com/2019/c19/en_9QLmr4ddP1.png` | 265 × 370 | Official Commander 2019 card image. Sevinne identity reference for Mystic Intellect; art by Zoltan Boros. |

The five files above are unmodified official downloads retained in `src/`. They are reference inputs, not finished targets.

## Generation and transformations

- Mode: built-in ImageGen, reference-guided generation.
- Finalized prompt: `../prompts/commander_2019_four_leads_ensemble_v1_prompt.md`.
- ImageGen inputs: the five retained official references listed above, in that order.
- Intended generation role: create one premium coherent ensemble with exactly one face commander for each of the four Commander 2019 decks. Official card frames, rules text, mana symbols, and packaging are reference-only and must not appear in the result.
- Post-generation plan: preserve the selected unmodified ImageGen output in `src/`; normalize the selected composition to exact 1800 × 2100 pixels; correct the title plaque deterministically only if necessary; write 600-DPI metadata; retain the unnumbered finished base in the set root; create a separately named counted sibling using `scripts/apply_deck_count.swift` with marker specification `4:1800`.

## Selected output and final transformations

- `imagegen_commander_2019_four_leads_ensemble_raw_v1.png` — unmodified built-in ImageGen output, 1163 × 1353 pixels at 72 DPI. Its SHA-256 matches the original built-in save byte-for-byte: `40072225d55ae4ad8b1b45dc62b9ac86f8fb29874bba5eea4aba5e2e534a1cfd`. Selected on the first generation pass because it contains exactly one Anje, one Ghired with one rhino, one Kadena, and one Sevinne; the four visual identities and their deck-specific color worlds are distinct; the generated title reads exactly `COMMANDER 2019`; the frame is visually full; and the lower-right corner contains only secondary time-magic texture suitable for the count seal.
- `../commander_2019_four_leads_ensemble_v1_1800x2100.png` — finished unnumbered base. The raw generation was center-cropped by three total horizontal pixels, from 1163 × 1353 to 1160 × 1353, without removing any subject or title content. That crop was high-quality resampled to exact 1800 × 2100 pixels and tagged at 600 × 600 DPI. No repainting or title replacement was required.
- `../commander_2019_four_leads_ensemble_v1_deck_count_4_1800x2100.png` — finished counted sibling. Created non-destructively from the unnumbered base by running `scripts/apply_deck_count.swift` with marker specification `4:1800`. The deterministic dark seal is 210 pixels (0.35 inch) in diameter with an antique-gold rim and pale-ivory Copperplate Bold numeral; its outer edge is exactly 70 pixels from both the right and bottom boundaries. Output remains exact 1800 × 2100 pixels at 600 × 600 DPI.

## Visual QA

- Dominant text is exactly `COMMANDER 2019`, horizontal, high contrast, unobstructed, and spans nearly the full usable image width.
- Exactly four deck leads appear once each: Anje upper-left, Kadena upper-right, Ghired and a single rhino lower-left, and Sevinne lower-right. No hero, species, or rhino is duplicated or omitted.
- The composition is full bleed and visually dense through all four edges and corners, with no blank, white, featureless, or low-information area and no pasted card frame or hard panel grid.
- Character faces, the rhino head, Kadena's head and staff, and the complete title treatment remain safely framed after the normalization crop.
- The count seal sits in the true lower-right corner, covers only secondary blue time-magic and the extreme edge of Sevinne's flowing coat, and does not obscure a face, hand, title, or critical silhouette.
- Both finished PNGs were visually inspected at final size and independently verified as RGB PNG files at exact 1800 × 2100 pixels with 600 × 600 DPI metadata.
