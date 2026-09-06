# Wilds of Eldraine Commander — official key-art adaptation v1

## Direction

Use the official Wizards Play Network Wilds of Eldraine key art as the visual authority. This drawer face represents the associated Commander release, but the main-set identity takes priority: a luminous fae ruler, crystalline wings and orb, thorny enchanted wilds, saturated teal/emerald/magenta magic, and the official set logo. Do not introduce a Commander montage or the preconstructed-deck face commanders.

## Inputs and roles

- `src/woe_key_art_sma_en/woe_sma_fb_1000x1000_en.jpg` — **edit target and primary composition reference**. Preserve the central fae ruler, crystalline wings, crystal orb, palette, painterly finish, and dense enchanted-forest atmosphere.
- `src/woe_key_art_sma_en/woe_sma_insta_1080x1920_en.jpg` — **supporting vertical composition reference** for how the official campaign art continues above and below the square crop.
- `src/first_look_wilds_of_eldraine_art.jpg` — **supporting set-identity reference** for Wilds of Eldraine's official fairy-tale styling and purple magical ribbons.
- `src/woe_alg_en/MTGWOE_EN_SetLogo.png` — **deterministic final overlay**, not a generation reference. Composite this official transparent logo after generation so the required title is exact and crisp.

## Built-in ImageGen edit prompt

Use case: precise-object-edit
Asset type: premium 3 x 3.5 inch Magic deck-drawer face background
Input images: Image 1: official Wilds of Eldraine square key-art edit target; Image 2: official vertical key-art composition reference; Image 3: official First Look set-identity reference
Primary request: Reframe Image 1 into a full-bleed 6:7 portrait composition by reconstructing the small amount of missing enchanted-forest artwork above and below the square crop. Remove all typography, logos, trademarks, legal text, and watermarks from the artwork so a clean official logo can be composited later.
Scene/backdrop: dense enchanted Eldraine wilds with thorny silhouettes, jewel-like foliage, mist, magical particles, and painterly teal, emerald, indigo, cyan, and magenta texture reaching every edge
Subject: preserve the same central pale-haired fae ruler, luminous crystalline wings, angular black-and-magenta armor, hands, and glowing faceted pink crystal orb from Image 1
Style/medium: premium painterly fantasy key art matching Image 1 exactly; highly detailed; crisp focal rendering; no photorealism
Composition/framing: exact 6:7 portrait; subject centered and large; face in the upper-middle; orb in the middle; retain both wing silhouettes and useful detailed artwork across the whole frame; leave the lower quarter dark and textured enough for a large high-contrast two-line set logo without making it blank or featureless
Lighting/mood: luminous fae magic, alluring and ominous fairy-tale atmosphere, bright cyan rim light, pink crystal glow, deep forest contrast
Color palette: saturated emerald, teal, cyan, indigo, magenta, pale pink, and near-black
Constraints: change only the framing extension and removal of existing typography; preserve the subject's identity, pose, anatomy, hands, orb, wings, armor, lighting, palette, and painterly style; no large empty or featureless regions; no borders; no frames; no cards; no packaging; no Commander montage; no added characters; no text; no logos; no trademarks; no watermark
Avoid: duplicated faces, extra fingers or arms, broken wing geometry, flat gradients, blank black areas, blurry focal details, altered character identity, modern graphic-design elements

## Deterministic finishing specification

- Normalize to exactly **1800 x 2100 pixels** and embed **600 DPI** metadata.
- Composite the untouched official `MTGWOE_EN_SetLogo.png` as the dominant identification element in the lower portion, centered, spanning about 92% of the canvas width with a comfortable print-safe inset.
- The exact visible title must be **WILDS OF ELDRAINE**, with no extra or altered letters.
- Preserve an unnumbered base target, then create a counted sibling with `scripts/apply_deck_count.swift` using `2:1800`.
- The seal must be exactly 210 px in diameter, with its outer edge 70 px from the right and bottom edges.

