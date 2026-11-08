# Turtle Power! Commander — official key-art adaptation brief

- Asset type: print-ready 3 × 3.5-inch portrait drawer face for the single **Turtle Power!** Commander deck.
- Exact dominant identification text: `TURTLE POWER!`.
- Supporting identification text: `COMMANDER DECK` plus the integrated official `TEENAGE MUTANT NINJA TURTLES` logo already present in the art.
- Primary input: `../src/TMT_sma_key_1080x1920.jpg`, the official Wizards Play Network portrait key-art social image.
- Reference-only input: `../src/official_turtle_power_commander_product.webp`, the official Wizards product render confirming the deck-specific title and four-Turtle product identity. Do not use its large white photographic surround in the final.
- Mode: deterministic crop, title treatment, 600-DPI normalization, and count-seal pass. No ImageGen call is needed because official portrait art already provides a strong, full composition.

Use the dense official portrait art with all four Turtles emerging from the manhole and retain the exact integrated TMNT wordmark. Crop away the upper Magic logo and excess city sky so the characters and product identity remain large at drawer scale. Add a large, exact, atmosphere-matched `TURTLE POWER!` title across nearly the full width near the top, with a smaller `COMMANDER DECK` line directly below. Use a lime-green, orange-rimmed, purple-shadowed arcade/comic treatment that complements the set without sacrificing immediate legibility.

Preserve the unnumbered 1800 × 2100, 600-DPI base. Create a separate counted sibling with the standard `1` seal using `scripts/apply_deck_count.swift` and `1:1800`, because Wizards confirms that Turtle Power! is one ready-to-play Commander deck. Create active 1724 × 2024 black-margin siblings for both finished targets and archive their white 3/16-inch intermediates under `src/superseded_white_margin_3_16in/`.

Constraints: exact 6:7 portrait; no malformed or extra title text; no invented Turtles; no product-photo white field; no empty region; no frame; no watermark; title and count seal must remain clear of the characters and official TMNT wordmark.
