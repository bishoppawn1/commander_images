# Duel Decks: Heroes vs. Monsters — battle face v1

## Mode and intended output

- Mode: built-in ImageGen reference-guided raster generation, followed by deterministic crop, title treatment, 600-DPI normalization, and project-standard deck-count seal.
- Use case: stylized-concept.
- Asset type: print-ready removable-drawer face for the complete 2013 non-Commander two-deck boxed product.
- Final size: exactly 1800 × 2100 pixels, portrait 6:7, embedded 600-DPI metadata, full bleed.

## Input images and roles

- `src/official_mtg_jp_ddl_main.jpg`: official Magic: The Gathering Japanese product-page hero reference. It establishes the English boxed-product presentation, bronze-armored heroic champion, many-headed green-black hydra, gold/ivory hero palette, green/crimson monster palette, and head-to-head confrontation. Reference only; do not reproduce its photographed box, cards, logos, or surrounding dark tabletop.
- `src/official_mtg_jp_ddl_packaging.jpg`: official Japanese packaging reference. It confirms both subjects must have equal narrative weight and that the product is a Duel Decks release, not Commander. Reference only; do not reproduce the Japanese packaging text, card frames, white background, or retail-box geometry.

## Built-in ImageGen production prompt

Use case: stylized-concept

Asset type: full-bleed portrait fantasy battle artwork for a 3 × 3.5-inch collectible-card drawer face

Primary request: Create a dense, premium painted fantasy confrontation that unmistakably presents two opposing decks with equal importance: HEROES against MONSTERS. Use Images 1 and 2, the supplied official Wizards product references, only to preserve the recognizable visual premise and palette. On the left, a monumental bronze-and-ivory armored heroic champion with a crested Greek-inspired helm raises a broad sword and braces behind a weathered round shield. On the right, a colossal dark green many-headed hydra lunges inward, each serpentine head distinct, with crimson throat and crest accents. Their gazes and actions meet across the center in a clear versus composition.

Scene/backdrop: A mythic Theros-inspired mountain battlefield at golden stormlight, with craggy stone, shattered temple fragments, windblown red cloth, dust, sparks, mist, and distant combat silhouettes. Carry useful painterly detail all the way to every edge.

Style/medium: richly rendered classic trading-card fantasy oil painting, dramatic and tactile, high-detail armor, scales, stone, smoke, and cloth; premium key-art finish; original adaptation rather than a photograph of product packaging.

Composition/framing: portrait. Hero owns the left half and hydra owns the right half, both large and equally readable. Keep both primary heads/faces safely inside the upper two-thirds. Let weapons, claws, coils, shield, terrain, smoke, and sparks fill the lower and outer frame. Preserve a darker but still richly textured horizontal zone across the lower-middle where a large three-line title can later be overlaid. Do not make this zone blank or featureless.

Lighting/mood: high-stakes mythic duel; warm ivory-gold rim light on the hero against cooler poisonous green and ember-crimson monster light; strong center contrast and cinematic depth.

Color palette: antique gold, sunlit ivory, bronze, oxblood red, forest green, charcoal, storm blue, and ember orange.

Text: no text at the generation stage. Do not render any words, letters, numbers, labels, logos, or signatures anywhere.

Constraints: Both HEROES and MONSTERS must be immediately obvious and visually balanced. One heroic champion only; one hydra creature with multiple naturally connected heads only. No modern objects. No packaging, card frames, Magic logos, set symbols, mana symbols, typography, letters, runes resembling words, watermarks, signatures, borders, blank background, large empty sky, duplicated champion, separate duplicate monsters, dragons, planeswalkers, or Commander branding.

Avoid: one-sided portrait; hydra cropped away; hero cropped away; retail product mockup; unreadable faux lettering; empty lower field; washed-out whites; muddy black voids; smooth featureless gradients; chibi/cartoon rendering; excessive gore.

## Deterministic title treatment

Apply the following text verbatim, exactly once, centered in three stacked lines:

`DUEL DECKS:`

`HEROES VS.`

`MONSTERS`

Together the three lines must read exactly **DUEL DECKS: HEROES VS. MONSTERS**. Use bold uppercase Copperplate, pale ivory fill, antique-gold inner stroke, and a broad near-black outer stroke/shadow. The block must span almost the full usable width with approximately 90 pixels of side clearance. Place it over a translucent black-burgundy textured banner in the lower-middle, with narrow antique-gold rules, while retaining visible battle detail beneath. `HEROES VS.` and `MONSTERS` are the largest lines; `DUEL DECKS:` remains large and unmistakable so the face cannot be confused with Commander.

Do not include the word `COMMANDER` anywhere. Keep the actual bottom-right corner composition rich but free of critical title content for the counted sibling.

## Counted sibling

Preserve the unnumbered base. Apply the project-standard count `2` only with `scripts/apply_deck_count.swift`, using `2:1800`. The seal is exactly 210 pixels in diameter, and its outer edge is exactly 70 pixels from the right and bottom edges.
