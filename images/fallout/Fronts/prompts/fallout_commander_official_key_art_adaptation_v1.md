# Fallout Commander — official key-art adaptation v1

## Direction

Create one 3 × 3.5-inch drawer-face background from Wizards Play Network's official Magic: The Gathering—Fallout Power Armor key art. This is a restrained format adaptation, not a redesign and not a four-commander montage. The finished face will use Wizards' untouched official combined Magic: The Gathering / Universes Beyond / Fallout logo as a deterministic post-production overlay.

## ImageGen input and role

- `src/pip_alg_en/pip_1080p_en.jpg` — edit target and identity/composition reference. Preserve its central Power Armor subject, weapon, distressed metal surfaces, sparks, radioactive yellow-green light, and ruined-wasteland atmosphere.

## Built-in ImageGen prompt used for the retained output (verbatim)

Use case: precise-object-edit
Asset type: portrait print background
Primary request: Convert the supplied image to a portrait 6:7 composition by extending its painted environment above and below. Keep the same single armored figure, helmet, weapon, pose, lighting, palette, and gritty painted texture unchanged. Remove all existing text, logos, and tiny legal copy. Fill every edge with continuous ruined industrial scenery, smoke, sparks, machinery, and rubble.
Composition/framing: one central armored figure fills the portrait; helmet and torso unobstructed; darker textured upper area reserved for a later separate title overlay
Text (verbatim): none
Constraints: change only framing, natural scene extension, and typography removal; no new characters; no redesigned armor; no extra limbs; no duplicate weapons; no cards; no symbols; no text; no logos; no watermark; no borders; no blank bands; no empty sky

## Deterministic finishing

- Normalize the chosen unmodified ImageGen output to exactly 1800 × 2100 pixels.
- Preserve full bleed and use a high-quality cover crop only if necessary.
- Overlay crops from `src/pip_alg_en/MTGPIP_SetLogo_2C_white_en.png` without modifying their shapes or text.
- Scale the official `Fallout` tier to 1600 pixels wide and position it at x=100, y=55 in top-origin coordinates. It spans 88.9% of the complete face width.
- Scale the official Magic / Universes Beyond tier to 720 pixels wide and position it 70 pixels from the left and bottom edges, keeping it secondary.
- Do not add a plaque or featureless backing; the supplied textured dark regions already provide contrast.
- Embed 600-DPI metadata.
- Create the counted sibling with `scripts/apply_deck_count.swift` using `4:1800`.

## Acceptance checks

- Exact 1800 × 2100 pixels, exact 6:7, 600 × 600 DPI.
- The official word `Fallout` is exact, dominant, unobstructed, and drawer-readable.
- Magic and Universes Beyond remain clearly secondary.
- Dense visual information reaches all edges; no blank or featureless region.
- One recognizable Power Armor hero; no invented characters or montage.
- Unnumbered base preserved; counted sibling has one 210-pixel seal with equal 70-pixel right and bottom outer-edge insets and numeral `4`.
