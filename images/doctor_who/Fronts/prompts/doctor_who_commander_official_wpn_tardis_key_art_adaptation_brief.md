# Doctor Who Commander — official WPN TARDIS key-art adaptation brief

## Purpose

Create one drawer-readable face for the four owned **Magic: The Gathering—Doctor Who Commander** decks. Use the licensed whole-product identity rather than a product-box photograph or a montage of the four packages.

## Inputs and roles

- `src/official_wpn_doctor_who_key_art_poster_24x36_en.pdf` — **primary official licensed art source and deterministic edit target.** Use its Shahab Alizadeh TARDIS/time-vortex key art because it is full, immediately recognizable, portrait-oriented, and designed by Wizards for this product.
- `src/MTGWHO_EN_SetLogo_2line.png` — **exact official transparent identity source.** Losslessly crop the BBC + `DOCTOR WHO` portion; do not redraw, typeset, approximate, or AI-generate any part of the wordmark.
- `src/official_wpn_doctor_who_art_and_logos_en.zip`, `src/WHO_1080p_en.jpg`, and `src/MTGWHO_EN_SetLogo_1line.png` — supporting official WPN art-and-logo references retained untouched.
- `src/official_wpn_doctor_who_key_art_social_assets_en.zip` and extracted `src/who_sma_*.jpg` files — supporting official social/key-art candidates. The 1080 × 1920 Instagram image confirms the portrait composition; the poster PDF is selected because it has substantially more print detail.
- `src/official_first_look_doctor_who_key_art.jpg` and `src/official_first_look_doctor_who_set_logo.png` — official Wizards First Look references, retained untouched.

## Deterministic composition specification

- Output an exact **1800 × 2100 px**, **6:7**, full-bleed, sRGB/RGBA PNG with **600 × 600 DPI** metadata.
- Crop the official 1728 × 2592 pt poster to the exact 1440 × 1680 pt rectangle `(x: 144, y: 528, width: 1440, height: 1680)` in bottom-left PDF coordinates. Scale exactly 1.25× to the final canvas. This preserves the TARDIS lamp, body, base, and vortex while removing the poster's separate top marketing lockup and low legal/title zone.
- Use a feathered translucent indigo readability veil across the lower portion while keeping the vortex and TARDIS visible.
- Derive `src/official_wpn_doctor_who_title_derived.png` as the lossless transparent crop `crop=640:155:130:252` from the official two-line WPN lockup. Composite it at `(x: 70, y: 335, width: 1660, height: 401.953125)` in bottom-left output coordinates. The exact `DOCTOR WHO` title must remain unobstructed, nearly full-width, and dominant at 300 × 350 drawer scale.
- Leave the standard lower-right seal zone clear of the title. Preserve the unnumbered base and create a counted sibling using `scripts/apply_deck_count.swift` with `4:1800` for the four physical decks owned.
- Do not use ImageGen. Do not add or generate characters, letters, logos, frames, borders, packaging, or empty fields.

## Acceptance checks

- Exact official text reads `DOCTOR WHO`; no malformed text or fragments.
- TARDIS and luminous time-vortex art fill all edges with useful visual information.
- The title is the first read at drawer scale and does not collide with the count seal.
- Count seal is 210 px in diameter with its circular outer edge exactly 70 px from the right and bottom edges.
- Main directory contains only finished full-bleed targets, their active black-margin print siblings, `prompts/`, and `src/`.
