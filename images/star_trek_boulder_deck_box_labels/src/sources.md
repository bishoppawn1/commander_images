# Star Trek Commander top labels

Product and deck authority: https://magic.wizards.com/en/news/feature/star-trek-buyers-guide and https://www.magic.wizards.com/en/news/announcements/star-trek-commander-decklists

Original v1 illustrations were built-in ImageGen adaptations of Wizards' product-box character illustrations, not direct crops. Retained boxes are in ../../star_trek_commander/src/references/:

- Federation Fleet: https://media.wizards.com/2026/images/daily/6IF46UlXn3/en_D7b004Wo4s.webp
- Landing Party: https://media.wizards.com/2026/images/daily/6IF46UlXn3/en_EcnQlCM9Qy.webp
- Klingon Fury: https://media.wizards.com/2026/images/daily/6IF46UlXn3/en_le0bxzT2PI.webp
- We Are the Borg: https://media.wizards.com/2026/images/daily/6IF46UlXn3/en_3XOZ7wCrfN.webp

Picard and Spock retain the v1 artwork approved by the user. Worf and the Borg Queen were revised from actual commander-card art to improve fidelity:

- Worf, Defiant Commander (TRC 4), Flavio Greco Paglia: https://api.scryfall.com/cards/trc/4 ; retained references/worf_card_art.jpg, 626 x 457.
- The Borg Queen (TRC 1), Jodie Muir: https://api.scryfall.com/cards/trc/1 ; retained references/queen_card_art.jpg, 626 x 457.

Full source metadata and original image URLs are retained in references/*_scryfall.json. V2 illustrations are AI adaptations/expansions of those card illustrations, not original official card art. Exact prompts are in ../prompts/. Raw generations are preserved here.

Final labels use images/build_boulder_labels.swift with BOULDER_DPI=1440 and ../label_manifest.json: 3960 x 3360 pixels, 2.75 x 2 1/3 inches. The current `_portrait_v2` outputs reposition the retained artwork lower, keep complete heads clear, and use a top-centered mana row. This replaces the initial left-aligned mana workaround. No new Star Trek artwork was generated for this layout correction. Final labels are in the parent directory; prior outputs are retained. Boulder Tops sheet 11 contains all four.
