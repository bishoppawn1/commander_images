# Throne of Eldraine Brawl — secondary four-courts illuminated brief

## Mode and intended output

- Mode: built-in ImageGen compositing followed by deterministic exact-text production.
- Use case: `compositing`.
- Asset type: print-ready removable-drawer face for all four 2019 non-Commander Brawl decks.
- Final size: exactly 1800 × 2100 pixels, portrait 6:7, embedded 600-DPI metadata, full bleed.
- Revision status: clearly versioned secondary candidate; all earlier targets remain preserved.

## Input images and roles

- `src/scryfall_eld_syr_gwyn_art_crop.jpg`: reference for Syr Gwyn, Hero of Ashvale and the Knights' Charge deck.
- `src/scryfall_eld_chulane_art_crop.jpg`: reference for Chulane, Teller of Tales and the Wild Bounty deck.
- `src/scryfall_eld_korvold_art_crop.jpg`: reference for Korvold, Fae-Cursed King and the Savage Hunter deck.
- `src/scryfall_eld_alela_art_crop.jpg`: reference for Alela, Artful Provocateur and the Faerie Schemes deck.
- `src/throne_of_eldraine_brawl_secondary_imagegen_raw_v1.png`: selected unlettered built-in ImageGen output after one targeted identity correction; production raster edit target.

## Built-in ImageGen prompt

Use case: compositing

Asset type: full-bleed portrait background for a 3 × 3.5-inch collectible drawer face

Input images: Image 1: official 2019 Syr Gwyn Brawl commander art reference; Image 2: official 2019 Chulane Brawl commander art reference; Image 3: official 2019 Korvold Brawl commander art reference; Image 4: official 2019 Alela Brawl commander art reference

Primary request: Reframe these four distinct official Throne of Eldraine Brawl commander artworks into one coherent 6:7 portrait fairy-tale tableau. Present all four commanders with equal visual importance in four interlocking illuminated-storybook or heraldic vignettes: the mounted flame-sword knight, the blue-green storyteller casting beside an open book, the red-black-green fae-cursed dragon king, and the blue-white-black flying faerie provocateur. Make the result unmistakably a four-deck ensemble rather than a portrait of one character.

Scene/backdrop: Enchanted Eldraine court and forest, woven together as an illuminated medieval manuscript page with carved gilded tracery and subtle thorn-vine transitions between the four vignettes.

Style/medium: Richly painterly high-fantasy key art preserving the recognizable 2019 Eldraine palette and characters; refined illuminated-manuscript composition, not a flat collage and not a UI screen.

Composition/framing: Exact 6:7 portrait intent, full bleed, dense detail edge to edge, balanced four-way composition. Reserve the central horizontal third for later deterministic title typography by lowering local contrast there with translucent parchment, mist, and gilded scrollwork, but keep visible illustrative texture so it is not an empty or opaque rectangle. Keep recognizable faces and silhouettes away from the central title-safe region and comfortably inside the canvas.

Lighting/mood: Luminous storybook gold against royal purple, moonlit teal, ember red, and forest green; dramatic but legible.

Materials/textures: Hand-tooled gold leaf, aged vellum translucency, carved heraldic filigree, painterly canvas grain.

Constraints: Preserve the four distinct commander identities and core poses from the references; exactly four featured commanders, one from each image; no fifth character; no repeated character; no dominant single character; no words; no letters; no Magic logo; no set logo; no UI; no cards; no frames resembling trading cards; no watermark.

Avoid: Generic fantasy strangers; photorealism; pasted-on black bands; large empty areas; modern typography; title text; product packaging; Commander terminology.

## Targeted identity-correction prompt

Change only the upper-left vignette of the first generated portrait. Replace its red-hooded standing warrior with Syr Gwyn from the supplied reference: the same brown-haired human woman knight in red, white, and dark-steel armor, visibly riding her black armored horse and raising the same flaming sword. Preserve the horse and knight as a compact but clearly readable mounted silhouette within the upper-left oval. Keep the entire 6:7 composition, gilded thorn tracery, central parchment region, upper-right storyteller and open book, lower-left dragon king, lower-right flying faerie, palettes, lighting, framing, and all other pixels/concepts unchanged. Do not alter the other three vignettes. Exactly four featured commanders. No repeated character. No words, letters, logos, UI, cards, product packaging, or watermark. Avoid Rowan, a red hood, a standing lone warrior, changing the central parchment, changing another vignette, or adding a fifth figure.

## Deterministic finishing brief

Use `src/build_secondary_face.swift` to crop the selected raw source minimally to 6:7 and resample it to 1800 × 2100. Preserve all four illuminated vignettes and their existing central parchment texture.

Render the exact product identity once, with no extra wording:

"THRONE OF"

"ELDRAINE"

"BRAWL"

Typography: atmosphere-native illuminated storybook and engraved-medieval display character, not generic sans. Use tracked Big Caslon for `THRONE OF` and decorative Luminari for both `ELDRAINE` and `BRAWL`. Use pure white letter faces for all three lines, with dark ink and layered gold outlines/shadows. Make `BRAWL` unmistakable and nearly as wide as the set line. Integrate the title into the central parchment with refined gilded flourishes; do not add an opaque panel.

Constraints: The complete identity must read exactly `THRONE OF ELDRAINE BRAWL`. Never include `COMMANDER`. Keep all lettering crisp, centered, high contrast, and comfortably within the print-safe area. Preserve useful detail throughout the full bleed. Keep the lower-right corner compatible with the standardized 210-pixel deck-count seal.

## Counted sibling

Preserve the unnumbered secondary base. Apply project-standard count `4` only with `scripts/apply_deck_count.swift`, using `4:1800`. The seal must remain 210 pixels in diameter with its outer edge exactly 70 pixels from the right and bottom edges.
