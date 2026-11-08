# FINAL FANTASY Commander — official key-art adaptation brief

## Purpose

Create a single drawer-readable face for the four owned **Magic: The Gathering—FINAL FANTASY Commander** decks. The associated set identity takes priority over a montage of the four face commanders.

## Inputs and roles

- `src/official_wpn_assets/FIN_sma_key_1080x1920.jpg` — **Image 1; edit target and primary official key-art reference.** Preserve its recognizable licensed four-character ensemble and polished painted rendering while replacing its white fade/empty regions with a full-bleed environment.
- `src/official_wpn_assets/MTGFIN_EN_LockUp_Stacked_White.png` — **deterministic finishing overlay, not an ImageGen input.** Composite this untouched official transparent lockup after generation so `MAGIC: THE GATHERING` and, especially, `FINAL FANTASY` remain exact and never AI-redrawn.
- `src/official_wpn_assets/FIN_cmmdr_expsym_m_3in.png` — **deterministic finishing overlay.** Use the official FIC Commander expansion symbol as a small licensed-identity accent.
- `src/official_wpn_assets/FIN_sma_key_1000x1000.jpg`, `FIN_sma_key_1600x841.jpg`, `FIN_sma_key_1640x680.jpg`, and `FIN_sma_key_1920x1080.jpg` — supporting official WPN key-art references inspected during source selection; retain for provenance but do not collage them into the target.
- `src/official_wpn_main_set_poster.png` and `src/official_wpn_character_poster_*.png` — supporting official WPN printed-poster references inspected during source selection; do not reproduce their large white/flat fields in the target.
- `src/official_wpn_product_refs/MTGFIN_EN_OtrBx_Cmndr_All.png` — product-line reference used only to confirm the four-deck Commander grouping; do not turn the target into a packaging montage.

## Built-in ImageGen edit prompt

```text
Use case: identity-preserve
Asset type: print-ready 3 x 3.5 inch Magic: The Gathering drawer-face artwork, portrait 6:7
Input images: Image 1 is the official Wizards Play Network vertical FINAL FANTASY key art and the edit target
Primary request: Adapt Image 1 into a visually dense, full-bleed 6:7 portrait key-art canvas. Preserve the recognizable licensed four-character ensemble from Image 1: Terra Branford at left, Cloud Strife centered in front, the Warrior of Light above center, and Y'shtola Rhul at right. Preserve their faces, hair, costumes, weapons, relative scale, poses, and Magali Villeneuve's polished painterly rendering as closely as possible. Recompose the ensemble slightly lower so the upper portion can support an exact official logo overlay added later.
Scene/backdrop: Replace every white fade, empty margin, and featureless area with a richly painted FINAL FANTASY atmosphere: deep midnight-blue and charcoal space, faceted crystal architecture and translucent crystal shards, faint prismatic rainbow refractions, luminous blue-violet mist, star sparks, and fine magical particles. Keep the upper logo zone calmer than the character area but still textured and visually informative, never blank.
Composition/framing: exact 6:7 portrait intent; characters large and immediately recognizable; Cloud remains the central focal subject; swords and silhouettes stay inside the frame; balanced edge-to-edge detail; no borders and no empty white field. Leave the lower-right corner non-critical for a later 210 px deck-count seal.
Lighting/mood: luminous crystalline rim light, restrained cool highlights, heroic and premium, strong value separation behind every silhouette.
Color palette: obsidian, midnight blue, steel, cool silver, violet, subtle teal and restrained prismatic crystal accents.
Text: none
Constraints: Remove the existing Magic logo, FINAL FANTASY logo, legal line, copyright, and every other text element from Image 1 cleanly. Do not invent, imitate, redraw, or leave fragments of any logo or typography. Do not add characters. Preserve the four named characters and their identities. Keep anatomy, faces, hands, costumes, and weapons coherent. Full bleed with useful detail across the entire canvas.
Avoid: text, letters, numbers, logos, trademarks, signature, watermark, packaging, card frames, poster borders, flat-color fields, large blank regions, large white regions, repeated characters, duplicate limbs, malformed hands, cropped heads, muddy faces, generic anime restyling.
```

## Deterministic finishing specification

- Normalize the selected unmodified ImageGen output to exactly **1800 × 2100 px**.
- Composite the untouched official white stacked lockup at the top, spanning about **1690 px** (nearly the full usable width) with a controlled obsidian readability plate behind it. `FINAL FANTASY` must be the largest and most drawer-readable text.
- Composite the untouched mythic FIC Commander expansion symbol as a restrained accent below the lockup, away from faces and weapons.
- Add subtle edge-darkening only where it improves print-safe contrast; do not create empty bands.
- Write **600 DPI** metadata.
- Preserve this unnumbered target and create a separate counted sibling with `scripts/apply_deck_count.swift`, marker `4:1800`.
- The marker must remain 210 px in diameter, with its outer edge exactly 70 px from the right and bottom edges.

