# Warhammer 40,000 Commander — four-faction drawer face v1

Use case: stylized-concept

Asset type: print-ready Magic: The Gathering Commander drawer-face artwork

Primary request: Create a premium, cinematic, portrait grimdark science-fantasy battle composition representing all four Magic x Warhammer 40,000 Commander decks in one coherent image. This generation supplies the artwork layer; the exact official title treatment is composited afterward from the official Wizards logo reference so the trademark is never redrawn or distorted.

Input images:

- `src/official_wizards_imperium_highlight.png`: official Wizards identity reference for Inquisitor Greyfax / Forces of the Imperium.
- `src/official_wizards_necron_highlight.png`: official Wizards identity reference for Szarekh, the Silent King / Necron Dynasties.
- `src/official_wizards_tyranid_highlight.png`: official Wizards identity reference for The Swarmlord / Tyranid Swarm.
- `src/official_wizards_ruinous_highlight.png`: official Wizards identity reference for Abaddon the Despoiler / The Ruinous Powers.
- `src/official_wizards_mobile_header_575x700.jpg`: official Wizards set-level art-direction reference for the fiery, high-detail, full-bleed Warhammer 40,000 atmosphere.
- `src/official_wizards_warhammer_40000_logo.png`: official exact title reference; use only in deterministic post-production, not as an ImageGen redraw target.

Scene/backdrop: An immense war-torn gothic industrial battlefield under a fractured smoky sky, with ruined cathedral machinery, distant troops, embers, energy arcs, ash, green necrodermis glow, violet-red Warp haze, and organic Tyranid silhouettes. Useful detail must continue all the way to every edge.

Subject: A balanced four-faction ensemble. Inquisitor Greyfax in blue-black Imperial armor, the skeletal gold-and-green Szarekh, the purple multi-limbed Swarmlord, and black-and-gold Abaddon appear as four distinct, recognizable commanders. Each subject appears exactly once. Preserve their official silhouettes, armor language, weapons, and faction color cues from the references. Arrange them in a dynamic triangular/diamond ensemble in the lower three-quarters, with shoulders and weapons overlapping atmospheric depth but not one another's faces.

Style/medium: museum-quality painted trading-card key art; detailed grimdark science-fantasy realism; coherent single illustration rather than four panels or a collage; tactile armor, bone, chitin, scorched metal, banners, smoke, sparks, and energy.

Composition/framing: portrait 6:7 intent. Full bleed. Strong central depth and edge-to-edge action. Keep a busy but lower-contrast dark steel-and-smoke title zone across the upper 24 percent so an exact official `WARHAMMER 40,000` logo can later span nearly the full safe width. The zone must remain richly textured, not blank or featureless. Keep all faces and signature weapons out of that title zone and keep important details away from the lower-right 280 x 280 pixel area reserved for the deck-count seal.

Lighting/mood: apocalyptic, operatic, and serious; orange fire and blue-white lightning balanced by toxic emerald and magenta-violet energy; crisp rim light on every lead; deep blacks without crushed detail.

Color palette: oxidized black steel, antique brass, deep cobalt, bone ivory, ember orange, electric cyan, toxic emerald, and controlled Warp magenta.

Text (verbatim, final composite): `WARHAMMER 40,000` with `COMMANDER` directly below. The official Wizards logo asset supplies the exact `WARHAMMER 40,000` typography; `COMMANDER` is added as a separate clean uppercase line. No other text.

Constraints: exactly four distinct lead characters, one per official deck; immediate Warhammer 40,000 identity; no card frames; no packaging; no brand redraw; no watermark; no signatures; no tiny legal copy; no empty fields; no featureless border; no hard quadrant seams. All title typography must be crisp, horizontal, unobstructed, and inside an approximately 70-pixel print-safe inset in the 1800 x 2100 final.

Avoid: duplicated figures or limbs, merged subjects, generic medieval fantasy, modern military photography, cute or comic styling, distorted heraldry, invented faction marks, invented words, illegible pseudo-lettering, logos in the generated art layer, white backgrounds, large flat fog fields, or any extra text.

Post-production: Preserve the unmodified ImageGen output in `src/`. Crop/reframe non-destructively to exact 1800 x 2100 pixels, composite the official cropped `WARHAMMER 40,000` logo near full safe width, add `COMMANDER`, set 600-DPI metadata, and save the unnumbered target in the set root. Then run `scripts/apply_deck_count.swift` with `4:1800` to create the counted sibling using equal 70-pixel lower-right insets.

## Exact built-in ImageGen execution prompt

```text
Use case: stylized-concept
Asset type: print-ready drawer-face artwork layer, portrait 6:7 intent
Primary request: Create a premium, cinematic, unified grimdark science-fantasy battle illustration representing the four Magic x Warhammer 40,000 Commander decks. This is an artwork-only layer: include NO TEXT, NO LOGOS, NO LETTERS, NO WATERMARKS.
Input images: Images 1–4 are official Wizards character identity references for Inquisitor Greyfax, Szarekh the Silent King, The Swarmlord, and Abaddon the Despoiler. Image 5 is the official Wizards set-level atmosphere and finish reference.
Scene/backdrop: immense war-torn gothic industrial battlefield under a fractured smoky sky; ruined cathedral machinery, distant armies, embers, energy arcs, ash, green necrodermis glow, violet-red Warp haze, and organic Tyranid silhouettes; useful visual detail continues to every edge.
Subject: Exactly four distinct lead characters, each appearing exactly once: Inquisitor Greyfax in blue-black Imperial armor; skeletal gold-and-green Szarekh; purple multi-limbed Swarmlord; black-and-gold Abaddon. Preserve their official silhouettes, armor language, weapons, and faction colors from Images 1–4. Balanced dynamic diamond ensemble in the lower three-quarters; faces and weapons do not merge or repeat.
Style/medium: museum-quality painted trading-card key art; highly detailed grimdark science-fantasy realism; coherent single illustration, never four panels or a collage; tactile armor, bone, chitin, scorched metal, banners, smoke, sparks, and energy.
Composition/framing: vertical portrait, full bleed. Strong central depth and edge-to-edge action. Across the upper 24 percent, maintain a richly textured but lower-contrast dark steel-and-smoke zone for later title compositing; this zone must not be blank or featureless. Keep all faces and signature weapons out of that upper title zone. Keep critical focal details out of the extreme lower-right corner reserved for a small count seal.
Lighting/mood: apocalyptic, operatic, serious; orange fire and blue-white lightning balanced by toxic emerald and controlled magenta; crisp rim light on every lead; deep blacks retain detail.
Color palette: oxidized black steel, antique brass, deep cobalt, bone ivory, ember orange, electric cyan, toxic emerald, controlled Warp magenta.
Constraints: exactly four lead characters, one per reference; immediate Warhammer 40,000 identity; no card frames; no packaging; no hard quadrant seams; no blank border; no large flat fog fields; no extra figures dominating the leads; NO TEXT OR LOGOS OF ANY KIND.
Avoid: duplicated figures, duplicated limbs, merged subjects, generic medieval fantasy, modern military photo styling, cute/comic styling, distorted heraldry, invented marks, pseudo-lettering, white backgrounds, signatures, and tiny legal copy.
```

## Exact targeted correction prompt

```text
Precise composition edit of the just-generated four-faction Warhammer 40,000 artwork. Preserve the four commanders' identities, costumes, faces, weapons, lighting, colors, battlefield, painting finish, and coherent single-scene style. Change only the vertical staging: extend the dark, detailed gothic fleet-and-storm sky so the entire upper 27 percent of the portrait contains richly textured but lower-contrast environment only; move/scale the complete four-character ensemble downward so every head, face, weapon, banner, silhouette, and energy effect begins below that upper 27-percent title-safe zone. Keep exactly four featured commanders, each appearing once. Keep edge-to-edge visual detail and preserve a less critical extreme lower-right corner for a small count seal. NO TEXT, NO LOGOS, NO LETTERS, NO PSEUDO-TEXT, NO WATERMARK, no card frames, no panel seams, no empty or featureless area.
```
