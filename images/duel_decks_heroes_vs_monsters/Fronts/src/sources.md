# Duel Decks: Heroes vs. Monsters — sources and production provenance

## Authoritative product sources

1. Wizards of the Coast, “Heroes vs. Monsters,” Making Magic, August 19, 2013  
   URL: https://magic.wizards.com/en/news/making-magic/heroes-vs-monsters-2013-08-19  
   Role: primary English product/deck-list authority. The article identifies the release as Duel Decks, describes Heroes fighting Monsters, names Polukranos and Sun Titan as the marquee confrontation, supplies both deck lists, credits the Polukranos and Sun Titan art shown in the article to Karl Kopinski, and records the September 6, 2013 release date. It also explicitly says the Monsters deck contains no Dragons.

2. Wizards of the Coast / Magic: The Gathering Japan, official product page, “Duel Decks: Heroes vs. Monsters”  
   URL: https://mtg-jp.com/products/0000082/  
   Role: official product and packaging authority. The page records two 60-card decks (120 cards total), the September 6, 2013 release date, official code HVM, and English/Japanese availability. It hosts the key product imagery downloaded below.

3. Wizards of the Coast / Magic: The Gathering Japan, official announcement route listed by the product page  
   URL: https://mtg-jp.com/publicity/014266/  
   Role: announcement research only. The live product page still labels this route as the related “Duel Decks: Heroes vs. Monsters announcement,” but the migrated route currently resolves to the site's not-found presentation. No image or factual claim in the finished asset depends on it.

Artist-attribution note: the English Wizards article explicitly labels the displayed Polukranos, World Eater and Sun Titan art as Karl Kopinski's work. The downloaded product-page/packaging files do not expose a separate packaging-illustration credit, so this package does not assert one.

## Retained official image inputs

### `official_mtg_jp_ddl_main.jpg`

- Direct URL: https://mtg-jp.com/img_sys/cardSet/ddl_main.jpg
- Original downloaded dimensions: 1300 × 760 pixels.
- Embedded source resolution: 96 DPI.
- Content: official product-page hero graphic showing the boxed release against a dark tabletop/background.
- Role: visual premise, palette, packaging, title hierarchy, hero/hydra opposition, and Duel Decks identity reference for ImageGen. The photographed box and surrounding negative space are not used directly in the finished face.

### `official_mtg_jp_ddl_packaging.jpg`

- Direct URL: https://mtg-jp.com/img_sys/cardSetSellStyle/ddl_p1.jpg
- Original downloaded dimensions: 620 × 500 pixels.
- Content: official Japanese retail-box reference with the bronze-armored hero and multi-headed hydra given equal packaging prominence.
- Role: secondary visual/product reference only. The white background, Japanese copy, card frames, and retail-box geometry are excluded from the finished face.

### `official_mtg_jp_ddl_logo.png`

- Direct URL: https://mtg-jp.com/img_sys/cardSet/ddl_logo2_2.png
- Original downloaded dimensions: 170 × 38 pixels with transparency.
- Content: official Japanese localized title graphic.
- Role: retained as product-page provenance only; not composited because the required final title is English and must be substantially larger and drawer-readable.

## Production provenance

- Generation mode: built-in ImageGen, reference-guided generation using `official_mtg_jp_ddl_main.jpg` and `official_mtg_jp_ddl_packaging.jpg`.
- Final prompt: preserved verbatim in `../prompts/duel_decks_heroes_vs_monsters_battle_face_v1.md` under “Built-in ImageGen production prompt.”
- Unmodified ImageGen output: `imagegen_battle_plate_v1_unmodified.png`, 1162 × 1353 pixels, RGB PNG, source metadata 72 DPI. This is a byte-for-byte copy of built-in ImageGen output `exec-ef54a975-5d15-4aa0-bead-bc0db4c46658.png` from generation run `01a03c7c-dfa4-7023-afa7-aa365da775ff`. It is retained unchanged in `src/`.
- Deterministic finishing: `build_face.swift` takes a centered 1158 × 1351 crop (exactly 6:7; two source pixels removed from each left/right edge and one from each top/bottom edge), scales it to 1800 × 2100, adds the translucent black-burgundy lower-middle title banner with antique-gold rules, and renders the exact three-line Copperplate Bold title in pale ivory, antique gold, and near-black. It exports an sRGB PNG with 600 × 600 DPI metadata.
- Unnumbered target: `../duel_decks_heroes_vs_monsters_battle_face_v1_1800x2100.png`.
- Counted sibling: created only from the finished unnumbered base with `scripts/apply_deck_count.swift`, count `2`, right boundary `1800`.
- Counted target: `../duel_decks_heroes_vs_monsters_battle_face_v1_deck_count_2_1800x2100.png`.

## QA artifacts

- `qa_drawer_scale_base_v1.png`: 360 × 420 (20%) inspection copy of the unnumbered target.
- `qa_drawer_scale_counted_v1.png`: 360 × 420 (20%) inspection copy of the counted target.
- Full-size and drawer-scale inspection confirm the exact title is immediately legible, the left hero and right multi-headed monster have comparable visual weight, no Commander language or visual branding appears, useful detail fills the frame, and the standardized count seal does not cover title text or either primary subject.
- The `apply_deck_count.swift` geometry places the 210-pixel circle at x = 1520…1730 and y = 1820…2030 in top-origin image coordinates, leaving exactly 70 pixels from the circle's right and bottom outer edges to the 1800 × 2100 boundaries.
- `qa_validate.swift` independently confirms both finished targets are exactly 1800 × 2100, carry 600 × 600 DPI metadata, and are fully opaque. Its base/count comparison finds changes only at x = 1507…1741 and top-origin y = 1815…2049; that narrow expansion around the exact circle is the intentional standardized drop shadow.

## SHA-256 checksums

- `official_mtg_jp_ddl_main.jpg`: `5937f7130d611b626cdbdea41ca11aaf55fba3c759e675a702e67e96078782ce`
- `official_mtg_jp_ddl_packaging.jpg`: `72ba7fe87273b1d68b3d792c374c8dd64f83fc84efc126c577cccff61268a297`
- `official_mtg_jp_ddl_logo.png`: `5977bb26ecd28d39ce41445c6987cebe5a9bb547f65282245f67f2b5f9df01c0`
- `imagegen_battle_plate_v1_unmodified.png`: `7a0e85cf3e7c2638b7f63d5452c670521ad57adb3c515bbf889daa464ab3d5fe`
- `../duel_decks_heroes_vs_monsters_battle_face_v1_1800x2100.png`: `b7dc15ed97aaffffca66caf71867f565001dc6dc38190badadf42c0a0e76c73a`
- `../duel_decks_heroes_vs_monsters_battle_face_v1_deck_count_2_1800x2100.png`: `d26ecf3f7a3b10f539b651d38f78a0e2f45c669251a7fd5902ccda9ba7bc30da`
