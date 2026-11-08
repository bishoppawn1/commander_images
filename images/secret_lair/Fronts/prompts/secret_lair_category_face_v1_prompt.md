# Secret Lair category face — generation and adaptation brief

## Intent

Create one premium, portrait drawer face for the open-ended **Secret Lair** category. The image must communicate the whole eclectic collectible product line—not one drop, artist, plane, or licensed collaboration. The central idea is a dark theatrical "vault of alternate-art possibilities": many distinct visual languages coexist inside one polished composition.

## Source inputs and roles

- `src/official_2019_secret_lair_packaging.jpg` — official Wizards launch-era brand reference. Preserve the black/antique-gold luxury presentation and recognize the original Secret Lair wordmark structure.
- `src/official_2025_winter_superdrop_hero.webp` — official Wizards category-marketing reference. Use the large cream-on-black Secret Lair logo, thin antique-gold linework, scattered collectible presentation, and dense premium finish as brand anchors. Do not reproduce the particular cards or imply that Winter Superdrop is the category.
- `src/official_2024_inside_elevator_superdrop.png` — official Wizards category-marketing reference showing how radically different alternate-art treatments coexist around a centered Secret Lair logo. Do not reproduce the particular cards or imply that this superdrop is the category.

## Built-in ImageGen prompt

Use case: stylized-concept
Asset type: premium 3 x 3.5-inch portrait drawer-face artwork for a Magic: The Gathering collection
Primary request: Create a cohesive, category-level Secret Lair composition: a dark fantastical collector's vault or cabinet of curiosities filled edge-to-edge with original alternate-art windows and foil-like fragments. It must represent the broad ongoing Secret Lair line rather than any single drop. The various windows should deliberately span very different art languages—luminous high-fantasy painting, bold retro screenprint, cute storybook creature art, intricate black-ink occult linework, neon surrealism, prismatic geometric abstraction, and metallic biomechanical fantasy—but be unified by deep black, antique gold, restrained ivory, jewel-tone light, and a premium theatrical presentation. No recognizable existing character, named drop, crossover franchise, or copied card illustration.
Input images: Image 1 (`official_2019_secret_lair_packaging.jpg`) is the launch-era brand and luxury packaging reference; Image 2 (`official_2025_winter_superdrop_hero.webp`) is the primary official logo, black/cream/gold composition, and collectible-gallery reference; Image 3 (`official_2024_inside_elevator_superdrop.png`) is a secondary reference for eclectic alternate-art breadth around the centered logo. Treat all as references, not edit targets.
Scene/backdrop: a richly layered black collector's vault with antique-gold structural lines, shallow arches, foil glints, colored portals, torn-paper and etched-metal edges, miniature stars, brush texture, and subtle Magic-like five-color light—detail continues to every edge.
Subject: the Secret Lair category itself, expressed as an eclectic gallery of original art treatments; no single hero character dominates.
Style/medium: highly polished fantasy key art mixed with premium graphic design, printmaking, ink, collage, and subtle holographic foil; cohesive and sophisticated rather than random.
Composition/framing: vertical 6:7, full bleed, symmetrical-but-restless dense collage. Reserve the middle band for the exact two-line official-style wordmark, with many art windows and textures continuing behind and around it. Keep important details and title within a generous print-safe inset. No large blank, flat, white, or featureless region.
Lighting/mood: mysterious, exclusive, celebratory, jewel-box glow; crisp highlights, deep dimensional blacks, saturated jewel tones.
Color palette: black and warm antique gold foundation with controlled emerald, cyan, magenta, violet, amber, and crimson accents.
Materials/textures: black lacquer, engraved gold, handmade paper, screenprint ink, brushed metal, stained glass, holographic foil, fine painterly detail.
Text (verbatim): "SECRET LAIR". Render exactly once, in two stacked lines using the distinctive tall cream/antique-gold official Secret Lair display-lettering proportions from Images 1–3, spanning nearly the full usable width. Spell S-E-C-R-E-T L-A-I-R exactly. Make it the dominant, immediately drawer-readable element with a clean dark silhouette behind it.
Constraints: portrait; visually dense full bleed; broad category identity; exact title only; title clean and unobstructed; no deck-count circle, seal, numeral, badge, corner marker, product price, card rules text, drop name, artist name, or watermark; no trademark text other than SECRET LAIR; no recognizable licensed characters; no one panel or style may imply a specific release.
Avoid: a single-character poster; a literal product photo; a spread of readable real Magic cards; one-drop branding; sparse negative space; pale empty backgrounds; illegible or misspelled title; duplicate title; extra words; numbers; circular seals.

## Deterministic finishing

If generated lettering is not perfectly exact and drawer-readable, replace only the title area with the exact official cream-on-black Secret Lair logo extracted from `src/official_2025_winter_superdrop_hero.webp`, preserving its recognizable letterforms. Reframe/crop the selected unmodified generation to exact 6:7, resize to **1800 x 2100**, set **600 x 600 DPI** metadata, and retain the unmodified generation in `src/`.

