# Commander 2013 — atmospheric official-era wordmark v3

Use case: precise-object-edit

Asset type: from-scratch typography and integration redesign for a premium 3 x 3.5-inch portrait drawer-face cover

Primary request: Preserve the successful owned-deck story—Eternal Bargain / Oloro and Mind Seize / Jeleva—but rebuild the title treatment from a clean art field. Remove the v1 title from the artwork, reconstruct the fantasy environment behind it, then add the exact title deterministically in a cleaner official-era identity. Do not reuse v2's Pirata One blackletter, shaped black-iron cartouche, framed plaque, or oversized slab styling.

Input images and assets:

- Image 1 / edit target: `../commander_2013_eternal_bargain_mind_seize_premium_cover_v1.png`; preserve Oloro, Jeleva, their poses and identities, the 6:7 framing, and the existing Esper-to-Grixis environment.
- Image 2 / official branding reference: `../src/official_eternal_bargain_packaging_wizards.jpg`; reference the 2013 packaging's restrained silver high-contrast `COMMANDER` wordmark and cool metallic surface.
- Image 3 / official branding reference: `../src/official_mind_seize_packaging_wizards.jpg`; reference the same period retail identity and the blue-black-red palette.
- Image 4 / official release-branding reference: `../src/official_commander_2013_footer_key_art_wizards.jpg`; reference only the period's unframed white/silver wordmark behavior, not Marath or the green/orange palette.
- Font asset: `../src/AlegreyaSC-Medium.ttf`; designed in 2011 by Juan Pablo del Peral / Huerta Tipográfica. Use as a period-contemporary, high-contrast calligraphic small-cap serif whose lighter, tapered strokes echo the official packaging's restrained silver wordmark without copying the rejected generic Trajan or v2 blackletter.
- Deterministic build: `../src/build_commander_2013_atmospheric_wordmark.swift`.

Background cleanup edit:

- Remove only the existing readable `COMMANDER 2013` lettering from Image 1.
- Reconstruct the area naturally from adjacent storm mist, sweeping black-violet veil, distant gothic atmosphere, Oloro's cool waterfall haze, and the red-violet Grixis energy at right.
- Leave a naturally dark, varied, painterly title field across the upper-middle; it must remain part of the environment, with no rectangle, plaque, frame, banner, slab, empty flat band, or replacement text.
- Preserve Jeleva's face and hands, Oloro's face, armor, torso, hands, and throne, all character silhouettes, the moon and architecture, the lower-right count-seal zone, and the exact 6:7 composition.
- Add no readable text, symbols, logos, cards, boxes, borders, or watermarks during the cleanup edit.

Text (verbatim): "COMMANDER 2013"

Deterministic typography:

- Set `COMMANDER` as the primary line in uppercase Alegreya SC Medium, spanning the central print-safe width with visible breathing room; keep its lighter, tapered silhouette and do not let it become an oversized slab.
- Set `2013` centered below in the same face at a clearly smaller size with deliberate tracking. Together the two lines read exactly `COMMANDER 2013`; add no other text.
- Use a restrained pale-silver/ivory face, thin graphite engraved edge, subtle cool-gray inner highlight, and a soft painted shadow. Keep the letterforms crisp and comparatively flat, not chrome, beveled slab, embossed block, blackletter, or glowing neon.
- Integrate the open title directly over the rebuilt mist. Add only two fine, fading energy hairlines flanking `2013`: cool cyan on the Oloro/Esper left and muted crimson on the Jeleva/Grixis right. They are atmospheric accents, not a frame.

Composition/framing: exact 1800 x 2100, 6:7 portrait. Place the open two-line title in the upper-middle gap between Jeleva and Oloro, comfortably inside print-safe margins. Do not cover either lead's face or hands. Retain the lower-right non-critical detail for the standard count seal.

Constraints: exact title; exactly two lead characters; high legibility at 300 x 350 or 360 x 420 drawer scale; no plaque or banner; no v2 blackletter; no generic Trajan-like treatment; no thick slab bevel; no extra text; no Magic logo; no deck names; no package mockup; no card frame; no watermark; no seal in the unnumbered base.

Avoid: pasted labels, hard-edged title backgrounds, decorative frames, pirate or blackletter aesthetics, oversized block lettering, glossy chrome, all-five-deck montage, duplicated subjects, title misspelling, unreadable tracking, thin hairline glyphs, modern sans-serif, flat empty sky, or changes to either character.

Output intent: Preserve the unmodified cleanup edit in `src`, then create one non-destructive v3 unnumbered base at exact 1800 x 2100 pixels with 600-DPI metadata and one `_deck_count_2` sibling using the standard 210-pixel seal at exact 70-pixel right and bottom insets.
