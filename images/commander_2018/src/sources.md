# Commander 2018 source and production record

## Product identity and authoritative deck verification

- Wizards of the Coast, [Commander (2018 Edition) Release Notes](https://magic.wizards.com/en/news/feature/commander-2018-edition-release-notes-2018-07-27), published 2018-07-27. This official release record states that the product consists of four game packs and names them **Adaptive Enchantment**, **Exquisite Invention**, **Nature's Vengeance**, and **Subjective Reality**. Release date: 2018-08-10. This is the authoritative source for the four-deck count.
- Wizards of the Coast, [Commander (2018 Edition) Decklists and Tokens](https://magic.wizards.com/en/news/feature/commander-2018-edition-decklists-and-tokens-2018-07-27), published 2018-07-27. This official decklist article identifies the display/face commanders used in this composition: **Estrid, the Masked** for Adaptive Enchantment; **Saheeli, the Gifted** for Exquisite Invention; **Lord Windgrace** for Nature's Vengeance; and **Aminatou, the Fateshifter** for Subjective Reality.
- Wizards of the Coast, [Commander (2018 Edition) Card Image Gallery](https://magic.wizards.com/en/news/card-image-gallery/commander-2018-edition-2018-07-27), published 2018-07-27. This official gallery supplied the four retained card-image references below and confirms all four characters as Commander 2018 cards.

Commander 2018 is an annual standalone Commander product rather than a deck release tied to a premier expansion. No official single portrait key art found during research combined all four deck identities with a dominant, drawer-readable annual-release title. The chosen production mode was therefore a new premium four-lead ImageGen composition, grounded in official card references, with exactly one face commander per deck.

## Retained official Wizards card references

All four files below are untouched downloads from the official Wizards Commander 2018 card-image gallery. Each is 265 × 370 pixels and is retained as an authoritative identity/release-treatment reference, not as a final target.

| Local file | Official source URL | Card / deck role | Artist attribution |
| --- | --- | --- | --- |
| `official_card_estrid_the_masked.png` | https://media.wizards.com/2018/c18/en_k76yfU4A3b.png | Estrid, the Masked — Adaptive Enchantment | Johannes Voss |
| `official_card_saheeli_the_gifted.png` | https://media.wizards.com/2018/c18/en_6FqeR1wjYE.png | Saheeli, the Gifted — Exquisite Invention | Ryan Pancoast |
| `official_card_lord_windgrace.png` | https://media.wizards.com/2018/c18/en_ImEyn6ilbM.png | Lord Windgrace — Nature's Vengeance | Bram Sels |
| `official_card_aminatou_the_fateshifter.png` | https://media.wizards.com/2018/c18/en_NBIlC94jco.png | Aminatou, the Fateshifter — Subjective Reality | Seb McKinnon |

## Retained art-crop generation references

The source artworks are official Commander 2018 card art, served as lossless-to-source JPEG art crops by Scryfall. The crops remove card-frame and rules-text distraction so ImageGen can use the character silhouettes, costumes, and signature magical motifs more effectively. Each retained file is an untouched 633 × 397 download.

| Local file | Download URL | Card record | Artist | Intended role |
| --- | --- | --- | --- | --- |
| `reference_art_estrid_the_masked_johannes_voss.jpg` | https://cards.scryfall.io/art_crop/front/3/3/3340b83e-72dc-42e2-9f93-92f732c047df.jpg?1783934330 | https://scryfall.com/card/c18/40/estrid-the-masked | Johannes Voss | Identity, floating blue aura masks, white/dark garment and enchanted-foliage cues |
| `reference_art_saheeli_the_gifted_ryan_pancoast.jpg` | https://cards.scryfall.io/art_crop/front/c/a/ca095559-ac77-4186-8d9b-b75ce0607582.jpg?1783934329 | https://scryfall.com/card/c18/44/saheeli-the-gifted | Ryan Pancoast | Identity, magenta/cyan/gold inventor clothing, filigree and artifact-magic cues |
| `reference_art_lord_windgrace_bram_sels.jpg` | https://cards.scryfall.io/art_crop/front/2/1/213d6fb8-5624-4804-b263-51f339482754.jpg?1783934329 | https://scryfall.com/card/c18/43/lord-windgrace | Bram Sels | Identity, panther anatomy, staff, red-gold regalia and land-magic cues |
| `reference_art_aminatou_the_fateshifter_seb_mckinnon.jpg` | https://cards.scryfall.io/art_crop/front/1/6/16b9f43a-9c3f-4bfa-9eb1-734189a4bb1f.jpg?1783934331 | https://scryfall.com/card/c18/37/aminatou-the-fateshifter | Seb McKinnon | Identity, age, ceremonial markings, veil, moths and fate-thread cues |

## ImageGen generation

- Mode: built-in ImageGen, reference-guided generation.
- Finalized brief: `../prompts/commander_2018_four_leads_premium_cover_v1.md`.
- Referenced inputs passed to ImageGen: the four `reference_art_*.jpg` files above, in the same order used below.
- Raw unmodified output: `imagegen_raw_commander_2018_four_leads_v1.png`, 1162 × 1353 pixels, 72-DPI source metadata.
- Raw-output SHA-256: `bff10a6a2c3b42ae7aa571af408e4aac67d64ad7f2752efc9a4118a9bb60d0ac`.

### Exact generation prompt

```text
Use case: stylized-concept
Asset type: premium print-ready portrait drawer-face cover for the complete Commander 2018 four-deck annual release
Input images: Image 1 is Estrid, the Masked identity reference; Image 2 is Saheeli, the Gifted identity reference; Image 3 is Lord Windgrace identity reference; Image 4 is Aminatou, the Fateshifter identity reference. Use them as identity, clothing, palette, and signature-magic references only; do not reproduce card frames.
Primary request: Create one seamless, prestigious painterly fantasy ensemble showing exactly these four face commanders, each exactly once: Estrid upper left with a floating blue-green aura mask and enchanted foliage; Saheeli upper right shaping a compact gold-and-cyan filigree construct amid magenta/cyan artifact glow; Lord Windgrace lower left as a dignified muscular black panther warrior with staff and ember-gold land magic, roots, stone and jungle haze; Aminatou lower right as a calm young girl with white ceremonial face markings, dark veil, pale dress, luminous fate thread and moths. Preserve their recognizable faces, species, ages, costumes, and signature motifs from Images 1-4. Unite them as one richly layered annual-release key-art composition, not four boxed panels.
Style/medium: highly finished painterly fantasy key art; premium trading-card annual-release poster; cinematic, richly textured, sophisticated, cohesive lighting, natural brushwork, realistic materials.
Composition/framing: exact 6:7 portrait design intent; edge-to-edge/full bleed with useful visual detail everywhere; balanced four-lead diamond ensemble; substantial head-and-shoulder presence for all four; clear, separate silhouettes; all faces comfortably inside print-safe edges. Weave their magic effects together without adding characters. Keep the lower-right corner visually detailed but noncritical for a later small count seal.
Scene/backdrop: a seamless magical arena where Estrid's blue-green crystalline aura masks and enchanted foliage, Saheeli's cyan-magenta filigree and small thopters, Windgrace's ember-gold land magic/roots/stone, and Aminatou's ivory-violet moths/fate threads meet around a warm antique-gold center glow. Deep near-black, emerald, cyan, violet, magenta, and ember shadows; no empty sky, no blank fog, no voids.
Text (verbatim): "COMMANDER 2018"
Typography: render exactly once, spelling C-O-M-M-A-N-D-E-R followed by one space and 2-0-1-8. Very large horizontal uppercase antique-gold engraved serif capitals, near-black outline, subtle bevel, centered across the lower-middle/central band, nearly full usable width, immediately readable from a storage drawer, unobstructed, no line break.
Constraints: exactly four named figures, one of each, no fifth hero, no duplicate. No other words, letters, numbers, logos, signatures, copyright marks, or watermarks. No card frames, mana symbols, deck boxes, split-panel grid, quadrant dividers, ornamental outer border, inset poster, mockup, faux paper edge. No cropped faces, merged faces, tiny figures, muddy silhouettes, text over faces, or effects crossing the title. Fullness and exact title legibility are mandatory.
```

## Final production assets and transformations

| Local file | Role | Transformations | SHA-256 |
| --- | --- | --- | --- |
| `../commander_2018_four_leads_premium_cover_v1_1800x2100.png` | Preserved unnumbered print base | The 1162 × 1353 raw ImageGen output was resampled non-destructively to exactly 1800 × 2100 pixels with `sips`; the ratio normalization is about 0.16% and does not materially crop or alter the composition. PNG metadata was set to 600 × 600 DPI. | `def0130b07f5d65572e1e74f19110af84a334a6c9ac65007e4565b46439de637` |
| `../commander_2018_four_leads_premium_cover_v1_deck_count_4_1800x2100.png` | Counted print target | Created from the unnumbered base with `scripts/apply_deck_count.swift` using `4:1800`. The script added the approved 210-pixel (0.35-inch) dark circular seal, antique-gold rim, pale-ivory Copperplate Bold numeral, and equal 70-pixel right/bottom inset. The base was not overwritten. Output metadata is 600 × 600 DPI. | `8eb2f4784a9471f2cee8a6352fd4f1789b3fd951cd6ef1a64484943bb80a34c8` |

No generative content was introduced during final normalization or count-seal application. Only the two finished targets are stored in the set root; raw references and the untouched ImageGen result remain in `src/`.
