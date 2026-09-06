# The Lost Caverns of Ixalan Commander — official key-art adaptation v1

## Direction

Use Wizards Play Network's official The Lost Caverns of Ixalan key-art campaign as the visual authority. This drawer face represents the associated four-deck Commander release, but the main-set identity takes priority: Huatli riding a luminous cavern bat toward Chimil, dense subterranean city detail, saturated magenta/orange cosmium light, and the official English set logo. Do not introduce a Commander montage or the four face commanders.

## Inputs and roles

- `src/key_art_social/lci_key_art_sma_en/lci_sma_key_1000x1000_en.jpg` — **primary edit target and composition authority**. Preserve Huatli, the central bat, the outstretched wings, distant flying bats, cavern-city structures, Chimil glyph, painterly finish, and established palette. Remove its typography so the exact official logo can be restored after generation.
- `src/key_art_social/lci_key_art_sma_en/lci_sma_key_1080x1920_en.jpg` — **supporting vertical composition reference**. Use only to understand how the official campaign art continues above and below the square crop and how the central figures remain readable in portrait framing.
- `src/lci_key_art_poster_preview.jpg` — **supporting poster reference**. Confirms the official vertical key-art hierarchy and the desired full-frame cavern density; do not reproduce its crop marks, legal line, or typography.
- `src/lci_first_look_key_art.jpg` — **official First Look set-identity reference**. Confirms the associated main-set visual and Néstor Ossandón Leal artwork; not a compositing input.
- `src/lci_official_set_logo.png` — **deterministic final overlay**, not a generation input. Crop only its transparent canvas padding, then composite this untouched official high-resolution English set logo so the visible title is exact and crisp.
- `src/art_and_logos/woe_alg_en/MTGLCI_EN_SetLogo_4C.png` — **official WPN logo reference**. Retained for provenance comparison; the higher-resolution official article PNG above is the finishing source.
- `src/lci_oversized_art_preview.jpg` — **alternate official WPN visual inspected but not selected**. Its landscape dinosaur encounter is strong, but the Néstor campaign is the more cohesive branded vertical source.
- `src/banner_stand/lci_bnr_stnd_v1_preview.jpg` and `src/banner_stand/lci_bnr_stnd_v2_preview.jpg` — **alternate official vertical references inspected but not selected**. They establish the release's vertical marketing vocabulary but are not compositing inputs.

## Built-in ImageGen edit prompt

Use case: precise-object-edit
Asset type: premium 3 x 3.5 inch Magic deck-drawer face background
Input images: Image 1: official The Lost Caverns of Ixalan square key-art edit target; Image 2: official vertical key-art composition reference
Primary request: Reframe Image 1 into a full-bleed exact 6:7 portrait composition by reconstructing only the small amount of missing official cavern artwork above and below the square crop. Remove all typography, logos, trademarks, legal text, and watermarks so the untouched official set logo can be composited later.
Scene/backdrop: an immense detailed subterranean Ixalan cavern-city filled with cliffs, stepped stone structures, orange sun disks, luminous magenta cosmium veins, mist, distant flying bats, and painterly rock texture reaching every edge
Subject: preserve the same central Huatli riding the same large luminous purple cavern bat, with Huatli raising the same cosmium staff toward the radiant Chimil glyph
Style/medium: premium painterly fantasy key art matching the official inputs exactly; highly detailed; crisp focal rendering; no photorealism
Composition/framing: exact 6:7 portrait; one Huatli and one large central bat; Huatli's face in the upper-middle and the bat's face just above center; retain both wing silhouettes and useful detailed cavern art across the whole frame; reserve the lower 38 percent as dark but richly textured cavern depth for a large title, keeping critical faces and the lower-right seal zone clear
Lighting/mood: radiant pink-orange Chimil light, magenta cosmium glow, heroic descent into an ancient hidden world, strong depth and contrast
Color palette: violet, magenta, rose, warm orange, antique gold, dusty mauve, deep aubergine, and near-black
Constraints: change only framing extension and removal of existing typography; preserve subject identity, pose, anatomy, staff, mount, wing geometry, lighting, palette, painterly style, and official set identity; full bleed; visually dense; no large blank, white, flat, or featureless regions; no borders; no frames; no cards; no packaging; no Commander montage; no added characters; no text; no logos; no trademarks; no legal line; no watermark
Avoid: duplicated faces, extra riders, extra limbs, extra staffs, malformed hands, broken wing geometry, altered character identity, flat gradients, blank black areas, blurry focal details, modern graphic-design elements

## Deterministic finishing specification

- Preserve the unmodified built-in ImageGen output in `src/`.
- Normalize once to exactly **1800 x 2100 pixels** and embed **600 DPI** metadata.
- Add a subtle transparent lower vignette over existing detailed artwork only; do not replace the lower field with flat color.
- Crop only the transparent padding from the official `lci_official_set_logo.png`, then composite it at x=70, bottom y=170, width=1450 px. It must remain entirely left of the count-seal area while spanning 80.6% of the full canvas.
- The exact dominant visible title must be **THE LOST CAVERNS OF IXALAN**, with no extra, missing, or altered letters.
- Preserve an unnumbered base target, then create a counted sibling with `scripts/apply_deck_count.swift` using `4:1800`.
- The seal must be exactly 210 px in diameter, with its outer edge exactly 70 px from the right and bottom edges.
