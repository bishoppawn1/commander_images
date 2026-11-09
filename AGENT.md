# MTG Commander Deck Box Face Cards

## Readability, restrained lighting and collection layout — 2026-11-08

- Use a dark opaque keyline plus a soft black halo behind every mana pip, keeping its original glyph crisp and its row top centered. Verify separation on both bright and dark scenery.
- Place a feathered translucent black shade behind the entire bottom text block, including title, strategy and set name. Preserve visible artwork; avoid hard rectangular panels and keep the shade below focal faces.
- Historical prompt files are provenance, not current defaults. Apply the latest composition brief when reusing them.
- Preserve source exposure, palette and medium. Do not request HDR, lifted shadows, punchy contrast, saturation boosts, bright print-oriented exposure, added rim light or bloom by default. Do not apply automatic screen lightening or mana-color washes in the builder. The approved Star Trek tops (formerly sheet 11) are the restrained lighting reference, not a requirement to repaint other sets in their style.
- Outpaint missing scenery when reframing leaves a gap; inspect the FINAL layered composite for duplicate heads, seams, missing edges and symbol/head overlap. A clean generated source alone does not prove the composite is correct. Keep old/new image links in the review.
- Keep set assets together as `images/<set>/Tops/` and `images/<set>/Fronts/`, each with its own sources/prompts. Store shared assets once and link from the other set with relative symlinks.
- For this collection refresh, rebuild the entire PDF collection, removing superseded PDF editions and old page reservations. Repack whole sets at existing physical sizes. Current target: 114 top placements on 10 sheets; 37 front placements on 7 sheets including six optional overflow labels. Earlier sheet-number/addendum preservation directions below are historical and superseded.

## Approved upper-third corrections — 2026-11-08

- Shift only Exquisite Invention, Animated Army, Wakanda Forever, Mutant Menace (slightly) and Devour for Power. Current outputs use `_upper_third_v5`; earlier images remain available. See `images/boulder_upper_third_audit_2026_11_08.json` and `reviews/boulder_upper_third_2026_11_08/index.html`.
- Preserve Evasive Maneuvers / Derevi (wings), Food and Fellowship (large scene), Grave Danger and Subjective Reality. Other reviewed subjective cases remain approved: Federation Fleet, Landing Party, We Are the Borg, Avengers Assemble, Counter Intelligence and Enhanced Evolution. Do not mechanically recenter these.

## Boulder-top portrait framing — 2026-11-08

- Artwork must fill the top label from top to bottom inside its normal decorative/cut frame. If lowering or shrinking a portrait exposes a black band or an empty area, generate/outpaint the missing background above or around it. A reserved mana area means continuous scene artwork behind the symbols, not a solid black header. Preserve the approved character, head placement, title and mana layout; do not stretch or mirror background pixels as a substitute for generation.
- Re-audit the final composite specifically for exposed canvas, seams and accidental dark bands. Preserve earlier versions and provide a before/after table identifying every affected label and its recreation.
- Historical gap-audit records remain at `images/boulder_background_audit_2026_11_08.json` and `reviews/boulder_backgrounds_2026_11_08/index.html`. They describe the earlier v3 pass, including two unsuccessful generation attempts. The readability v4 refresh resolves Fantastic Four with generated scenery and Avengers Assemble with retained-source framing. Readability audit: `images/boulder_readability_audit_2026_11_08.json`; readability old/new gallery: `reviews/boulder_readability_2026_11_08/index.html`. Use the current manifests and `scripts/build_boulder_collection.py` for rendering.

- Visually audit existing tops before changing them. Preserve satisfactory images; do not regenerate the collection by default. Prefer moving/scaling retained artwork, and regenerate/outpaint only when the source itself lacks necessary content.
- Keep complete heads (including hair, ears, horns, crowns and hats) clear of the cut border, mana symbols and titles. Place the focal head center near the upper third (about 33% down / two-thirds up), following normal portrait composition rather than vertical centering. Tall headwear, crests, wings and large scenes can justify lower faces; preserve user-approved exceptions.
- Mana symbols normally form a single TOP-CENTERED row. Fix high portrait placement instead of moving the symbols aside. The former Star Trek left-alignment exception is retired.
- New art prompts must reserve the upper 18% for the centered mana row, place focal head centers approximately 33% down the canvas, and keep the lower title area clear. Verify the final composed label, not just its source image.
- The shared builder supports per-label `portraitTopInset`, `portraitScale` and `artTopCrop` for deterministic placement and `outputStem` for non-destructive versioned results. Leave these unset on satisfactory labels. See `images/BOULDER_TOP_COMPOSITION.md` for the production brief and verification rules.

## Star Trek label additions — 2026-11-08

- Star Trek Commander front features exactly Sisko, Kirk, Picard, Janeway and Jonathan Archer. The user requested Archer after removing the original rightmost captain. Five portraits still represent four Commander decks, so use the standard `4` seal.
- Current front: `images/star_trek/Fronts/star_trek_five_captains_archer_v3_deck_count_4_4138x4858_1440dpi_black_margin_1_8in.png`, now on condensed Fronts sheet 7.
- Four tops: Federation Fleet, Landing Party, Klingon Fury and We Are the Borg, now on condensed Boulder Tops sheet 10. Picard and Spock keep the approved v1 art; Worf and the Queen use card-art-based v2 revisions. Use `images/star_trek/Tops/label_manifest.json` and `scripts/build_star_trek_sheets.py`. The earlier `_full_bleed_v3` outputs place complete heads below top-centered mana symbols and extend the scene to the top; earlier output versions remain available.

## Project purpose

Create deck-box-style face cards that make Magic: The Gathering Commander deck sets easy to identify.

## Output requirements

- Final physical size: **3 × 3.5 inches** (portrait orientation unless a later instruction says otherwise).
- Generate print-ready artwork at high resolution.
- Minimum target: **900 × 1050 pixels at 300 DPI**.
- Preferred editable/full-bleed master: **1800 × 2100 pixels at 600 DPI**, or higher when practical, while preserving the exact 6:7 aspect ratio.
- Required final print derivative for every large drawer-face/set-identification image: **4138 × 4858 pixels at 1440 DPI**. Preserve the 600-DPI master and create the 1440-DPI file non-destructively.
- Favor crisp typography, clean edges, and sufficient detail for physical printing.
- Favor full, edge-to-edge compositions with useful visual detail throughout the frame.
- Do not select or generate images containing large blank, white, featureless, or otherwise low-information areas.
- Crop, reframe, extend, or redesign source imagery as needed to fill the 6:7 canvas while keeping important subjects and text comfortably inside the print-safe area.

## Print-margin variants (black)

- Preserve every existing full-bleed finished target. Never replace or overwrite it when preparing a print-margin version.
- Build and retain the finalized project-wide print-margin master prototyped on Commander Masters at **1724 × 2024 pixels and 600 DPI**.
- Build a 1574 × 1874 artwork source from the complete finished target as one unit, including its title, count seal, dividers, and all other artwork. The archived 1800 × 2100 3/16-inch derivative provides this source region.
- Enlarge that complete artwork region to **1644 × 1944 pixels** without changing the 1724 × 2024 outer canvas. Center it horizontally at `x=40`; its top extends 16 pixels beyond the canvas and is clipped, while **96 total pixels** remain below it.
- Fill all exposed print-margin space with opaque black (`#000000`). Add a **3-pixel opaque-black cut-guide border on the outermost pixels of the active file**. The visible black margins are exactly **37 pixels on each side, none at the top, and 93 pixels at the bottom**.
- Do not redraw or reposition individual titles, markers, or panel dividers for this print derivative. The entire completed face is transformed together.
- From every 600-DPI print-margin master, create the required high-resolution print sibling at **4138 × 4858 pixels and 1440 DPI** with high-quality sRGB resampling. This rounded 2.4× scale preserves the established physical print size to within 0.0003 inch.
- Name 600-DPI masters by inserting `_1724x2024_black_margin_1_8in` before `.png`; name their 1440-DPI print siblings by inserting `_4138x4858_1440dpi_black_margin_1_8in` before `.png`.
- Store both variants alongside their corresponding finished targets in the applicable Tops or Fronts directory. Do not create separate reframe or cut-guide siblings.
- Retain every superseded 1800 × 2100 white 3/16-inch derivative under that set's `src/superseded_white_margin_3_16in/`; do not leave superseded variants in the set-directory root.
- Build the 600-DPI print-margin masters deterministically with `scripts/crop_white_margin.swift`, `scripts/add_cut_border.swift`, and `scripts/reframe_final_black_margin.swift`. Validate them with `scripts/validate_final_black_margin.swift`, then build and validate their 1440-DPI print siblings with `scripts/build_1440dpi_drawer_faces.swift` and `scripts/validate_1440dpi_drawer_faces.swift`. `scripts/apply_white_margin.swift` and `scripts/validate_white_margin.swift` remain available for constructing and checking the archived white 3/16-inch intermediate from a full-bleed target.

## Identification text and viewing context

- The finished face card will be mounted on the front of a removable storage drawer and must be readable at a glance from normal viewing distance.
- Make the set or preconstructed-deck name the dominant information element, not a minor caption.
- Set-identifying text should normally span nearly the entire usable width of the image.
- Use large, crisp, high-contrast lettering with a clean silhouette; keep it unobstructed by characters, effects, borders, or busy textures.
- Preserve a comfortable print-safe inset around the lettering while using as much horizontal width as practical.
- Decorative typography is acceptable only when it remains immediately legible. Identification takes priority over ornamentation.

## Typography quality and secondary candidates

- Typography must feel native to the illustrated world or product identity. Avoid generic modern sans-serif or default-looking display treatments when they clash with the set's atmosphere.
- Prefer an accurate official set wordmark when a clean, sufficiently large asset is available. Otherwise build a deterministic, exact-text treatment using an atmosphere-matched display face, materials, outline, shadow, spacing, and framing that echo the set without sacrificing drawer-scale legibility.
- Treat typography as part of the composition rather than a label pasted on top. Its color, texture, border, and placement should harmonize with the surrounding art while preserving a crisp silhouette and strong contrast.
- When the user requests a secondary attempt, preserve every existing finished target and add clearly versioned alternate base and counted files. Do not silently replace or delete the earlier candidate.
- A secondary counted candidate must use the same approved deck-count seal geometry and marker value as the release's existing counted target.

## Ongoing instructions

- Organize the project-root `Print Sheets/` folder into two subfolders: `Boulder Tops/` for the complete Boulder deck-box top collection and `Fronts/` for large drawer fronts, including the optional Overflow sheet. Keep `Boulder_Tops` in top-sheet filenames; archived sheets are not a substitute for the current printable set. Future PDF generation must use these same subfolders.
- For the first-half Boulder-top PDF sheets, preserve the approved 3300 x 2800 images at 2.75 x 2 1/3 inches. Use the Epson ET-8550 (the user replaced the HP), Letter borderless-compatible printing, and a 3 x 4 grid with 1/16-inch side margins/gaps and approximately 0.739583-inch top/bottom margins. Keep each release in one PDF and name the PDF for every release it contains. Never silently shrink labels to fit; warn about driver borderless expansion changing physical size.
- Treat later user directions as additions or refinements to these project requirements.
- Record durable follow-on project requirements in this file so future work remains consistent.
- If a later instruction conflicts with an earlier one, follow the most recent explicit user instruction and update this file accordingly.

## Collection inventory and grouping authority

- Treat `INVENTORY.md` as the authoritative list of owned physical deck-release groups, owned/total counts, deck-count marker values, and drawer-face groupings.
- Commander 2013 and Commander 2016 use one approved equal vertical-split drawer face with markers `2 / 2`: Commander 2013 on the left and Commander 2016 on the right.
- Zendikar Rising Commander and Commander Legends use one approved equal vertical-split drawer face with markers `2 / 2`: Zendikar Rising on the left and Commander Legends on the right.
- Kamigawa: Neon Dynasty Commander and The Brothers' War Commander use one approved equal vertical-split drawer face with markers `2 / 2`: Kamigawa on the left and The Brothers' War on the right.
- Phyrexia: All Will Be One Commander and Wilds of Eldraine Commander use one approved equal vertical-split drawer face with markers `2 / 2`: Phyrexia on the left and Wilds of Eldraine on the right.
- The four pairings above are the active chronological two-deck groupings. Their standalone full-release targets remain available as alternatives, not as additional active drawer allocations. The user requested deletion of the superseded pairing archive on 2026-09-17; do not restore those old pairings.
- Chronological pairing uses each owned two-deck Commander release group once and minimizes the total release-date gap: sort eligible groups by tabletop release date and pair consecutive entries. This includes the two partial annual releases. It does not mean every group can have its independent nearest neighbor; see the dated audit in `INVENTORY.md` for that distinction.
- Commander 2020 / Ikoria, Strixhaven Commander, and March of the Machine Commander each remain standalone and use a `5` marker.
- Doctor Who Commander uses a standalone `4` marker for the four unique preconstructed decks owned.
- Turtle Power! Commander uses a standalone `1` marker because the release contains one ready-to-play Commander deck and the collection owns it.
- Overflow is an open-ended storage-category face. It must read exactly `OVERFLOW` and intentionally receives no count marker.
- Preserve Anthology decks under the Anthology product actually owned rather than regrouping them under their original Commander releases.
- Update `INVENTORY.md` whenever the user adds, removes, corrects, or regroups collection entries.

## Image asset organization

- Store each set under `images/<set>/`, with `Tops/` and `Fronts/` subdirectories. Finished files, `src/`, `prompts/` and manifests belong inside the applicable format directory. Cross-set builders and composition rules stay at the project root or `images/` root.
- Preserve raw references and original ImageGen outputs in the format's `src/`; preserve finalized briefs in its `prompts/`. Version finished files without overwriting older images. Record sources, artists, transforms and generation provenance in `src/sources.md`.
- Shared paired fronts live in the earlier set's `Fronts/<pair>/`; the other set has a relative directory symlink to that owner. Shared Anthology tops live in `commander_anthology_i/Tops`, linked from volume II. Reuse one physical asset rather than copying it.
- Existing path migration is recorded in `images/asset_path_migration_2026_11_08.json`. Resolve paths from current manifests/catalogs rather than historical folder names.
- Keep cross-set GIMP tools at project root. Respect `GIMP_SHEET_PLAN.md` and preserve unrelated or ambiguous GIMP documents.

## Source selection for set-based Commander products

- Many later Commander products are tied directly to a main Magic: The Gathering set. For these products, the associated set's identity and artwork take priority over Commander-specific characters or a montage of the included face commanders.
- Always inspect the set's official First Look, reveal, debut, announcement, and product pages for branded hero graphics whose artwork already includes the set name. Also inspect official Wizards Play Network key-art social-media assets. These square, portrait, or landscape branded composites are first-class candidates because their integrated set title and established composition may already satisfy most drawer-face requirements.
- Search for official vertical or portrait set images as well, including key art, phone wallpapers, social artwork, packaging faces, promotional art, and posters. A strong vertical set image will often be the best drawer face with little or no redesign.
- Keep branded reveal/debut graphics in contention alongside strong vertical images and poster-based adaptations; do not assume a poster is preferable merely because it is already portrait-oriented.
- Prefer an existing set image when it already provides strong product identity, a visually full composition, sufficient resolution, and prominent legible set identification.
- Do not add Commander-specific characters merely to distinguish the product. Use face-commander art only when making an individual precon face, when the product has no suitable associated-set art, or when later user direction explicitly calls for it.
- Do not regenerate a suitable existing visual merely for novelty. When the best existing image is close but not an exact 6:7 fit, preserve it and adapt it through cropping, outpainting/extension, repositioning, resolution enhancement, and a dominant set-name treatment.
- When adaptation is needed, preserve the recognizable visual identity and main composition of the associated MTG set while reframing it for the 3 × 3.5-inch drawer face.

## Dual-set drawer-face edge case

- Some storage drawers contain two sets and require one 3 × 3.5-inch face card to identify both. Apply all normal resolution, fullness, print-safety, source-selection, provenance, and drawer-legibility requirements to these combined faces.
- Store the combined face in `images/<first_set>/Fronts/<first_set>_<second_set>/`, with `prompts/` and `src/`; link it from the second set’s `Fronts/` using a relative symlink.
- Unless later direction says otherwise, order the two sets chronologically: the earlier set appears on the left and the later set appears on the right.
- Use two equal left/right panels separated by one straight top-to-bottom divider line.
- Use one deliberate, narrow, high-contrast divider. Do not add extra panel borders, gutters, frames, decorative separators, blended seams, or empty gaps.
- Each set must clearly own its half of the composition and retain its recognizable art direction, palette, and visual identity. Do not blend the two worlds across the divider.
- Each set name is a separate dominant identification element. It should span nearly the full usable width of its own panel, remain horizontal when practical, use stacked lines when needed, and be immediately legible from drawer-viewing distance.
- Design each title for the narrower half-panel rather than shrinking a long single-line title to illegibility. Prefer two or three short stacked lines over rotated or tiny lettering.
- Research and retain suitable official branded art for both sets independently. A directly reusable official source may be promoted to a finished panel treatment; otherwise reframe or regenerate each half while preserving its set identity.
- Name finished dual-set variants descriptively, including `_vertical_split_`.

## Deck-count marker standard

- Apply this treatment to every finished drawer-face candidate. Preserve every existing unnumbered target and create a separately named counted sibling; never overwrite the base target.
- A single-set face receives one marker showing the number of decks represented by that drawer face.
- A multi-set face receives one marker per panel, with each marker showing the deck count for its own set.
- Use one consistent marker across the project: a dark circular seal with an antique-gold rim and a pale-ivory Copperplate Bold numeral. Keep the marker at 0.35 inches in diameter (210 pixels at 600 DPI) and use the same numeral scale in every target.
- Place the marker in the actual lower-right corner of its image or panel. Inset its outer edge approximately 0.12 inches (70 pixels at 600 DPI) from both the applicable right boundary and the bottom boundary. The equal inset keeps it clearly corner-positioned while retaining a modest clearance for drawer-frame overhang.
- For multi-panel faces, measure each marker's right inset from that panel's right boundary and its bottom inset from that panel's bottom boundary. Give every panel identical marker styling and clearance.
- If a marker materially obscures a set title or critical focal detail, recompose the artwork rather than pushing the marker toward an unsafe outer edge.
- Verify deck counts from an authoritative product or deck-list source unless the user supplies the count directly.
- Include `_deck_count_<n>` in a single-set filename and `_deck_counts_<left>_<right>` in a dual-set filename. Existing approved files may retain `_trial` in their historical filename, but new targets do not need it. When marker placement changes, create a newly versioned target filename so image previews cannot reuse a cached prior placement.

## Per-set production workflow

Apply this workflow independently to each set or precon:

1. Create or identify `images/<set_or_precon>/Fronts/` and its `prompts/` and `src/` subdirectories using a descriptive lowercase snake-case set or precon name.
2. Verify the product name and associated MTG set from authoritative sources. Verify individual decks and face commanders only when they are relevant to the requested face.
3. Research the official First Look/reveal/debut article and Wizards Play Network assets for branded key-art graphics with the set name already integrated. Keep those in contention with official vertical set art, then inspect other key art, phone wallpapers, packaging, logos, promotional imagery, posters, and—only when relevant—face-card art.
4. Retain only useful raw source/reference images in `src/` and document their URLs, attribution, pixel dimensions, and intended role in `src/sources.md`. Promote every completed face-card candidate—including official-art candidates—to a finished target in the applicable Tops or Fronts directory.
5. Decide whether to reuse, adapt, or generate. Prefer reuse/adaptation when existing art already satisfies the format and visual requirements. Directly reused official art is a finished target and must be stored in the applicable Tops or Fronts directory.
6. Before generation, create a finalized set-specific prompt brief in `prompts/` that names every `src/` input image and its role, defines the exact identification text, preserves the set's established visual identity, and repeats the print, fullness, and drawer-legibility constraints.
7. Generate without pausing for approval when the user's requested direction and available references are sufficient.
8. Inspect the result for exact text, immediate drawer readability, full-frame composition, recognizable set identity, unwanted empty space, repeated or incorrect subjects, and print-safe placement. Iterate when a material requirement fails.
9. Preserve the unmodified generated output in `src/`, then create a non-destructive exact 6:7 print target at 1800 × 2100 pixels with 600-DPI metadata in the applicable Tops or Fronts directory.
10. Build the 600-DPI black-margin master, then create its 4138 × 4858, 1440-DPI print sibling without overwriting either earlier file.
11. Record the final asset, generation mode, exact prompt, transformations, and provenance in `src/sources.md`; keep the finished prompt brief in `prompts/` and the target image in the applicable Tops or Fronts directory.


## Drawer-front readability and PDF handling — 2026-09-19

- Keep large titles centered independently of the lower-right count seal; arrange a separate clear area for the seal rather than offsetting titles left.
- Favor substantial letter weight and readable shadow detail at small physical print size.
- After correcting active drawer fronts, update `print_catalog.json` and regenerate affected print PDFs. Move superseded PDF editions into `Print Sheets/Fronts/.archive/` so the main folder remains the current printable set.
- Do not open PDFs in Codex Files previews or through `open_in_codex`: the user reported a crash from the saved PDF preview. Inspect PDFs through metadata, extracted contents, and small rendered page PNGs only.


## User typography refinements — 2026-09-19

- Forgotten Realms: tight letter spacing and a darkened local background behind the light title; preserve the brighter upper artwork.
- Warhammer 40,000: COMMANDER belongs directly beneath 40,000 inside the same extended crest, in matching metallic angular block lettering with compact spacing.
- Eldraine Brawl: prefer the original Big Caslon / Luminari lettering, with a smaller BRAWL and clear space between ELDRAINE and BRAWL. Keep all commander faces unobscured. This supersedes the previous temporary bold-serif title treatment.

## Heading readability — 2026-09-20

- Eldraine needs matching soft dark backing behind all three title rows (THRONE OF, ELDRAINE, BRAWL), not only THRONE OF. Keep consistent color, opacity and feathering, fit the backing to each line, and retain the original type, smaller BRAWL, and clear faces. Updated 2026-09-21.
- Ikoria COMMANDER 2020 should match the main IKORIA crystalline cyan/white angular serif lettering, with a dark edge/shadow for immediate small-print readability.

## Addendum sheets — 2026-09-21

- Fill vacant slots on existing addenda before starting another addendum. Preserve existing image order and use current catalog-selected artwork at the established physical size.
- Sheet 7 contains, in reading order: Adventures in the Forgotten Realms; Warhammer 40,000; Commander 2020 / Ikoria; Throne of Eldraine Brawl; Zendikar Rising / Commander Legends split; Kamigawa / The Brothers' War split. The latest user instruction supersedes the earlier empty-slot requirement: sheet 7 is now full.
- Sheet 8 contains, in reading order: Commander 2013 / 2016 split; Commander 2017; Commander 2018; Commander 2019; March of the Machine; The Lord of the Rings. The last two slots include earlier corrected fronts found during the full correction-history audit.
- Sheet 9 contains the updated Commander 2020 / Ikoria front in slot 1. The previous Ixalan placement was removed at the user's request on 2026-09-22.
- The addenda are convenient reprints and do not replace sheets 1–6. Build all three with `scripts/build_fronts_addenda.py`; `scripts/build_fronts_addendum_07.py` remains a compatibility entry point for sheet 7 alone. Per-sheet indices are `LATEST_fronts_addendum_07.json`, `LATEST_fronts_addendum_08.json` and `LATEST_fronts_addendum_09.json` under `Print Sheets/Fronts/.records/`; the combined index is `LATEST_fronts_addenda.json`.
- Audit addendum coverage against the full correction history, not only the latest edit batch. See `images/ADDENDUM_CORRECTION_COVERAGE_2026_09_21.md`: twelve corrected fronts plus the separately requested Zendikar / Commander Legends front are included once each.
- When future corrections affect an addendum front, refresh its addendum as well as its normal catalog sheet, and archive superseded editions. The current main Fronts folder now has nine PDFs.

## Annual-title consistency and split correction — 2026-09-21

- Commander 2017, 2018 and 2019 use the same MIDDLE title position, font, size, dark backing and antique-gold outline. The user's follow-up supersedes the lower-middle placement: the label belongs between upper and lower portraits and must not obscure commanders. The deterministic shared template is `scripts/build_unified_annual_titles.swift`, invoked with title-center argument `1050`: 1800 × 2100 full-bleed canvas, plaque x=62...1738 and top-down y=935...1165, Baskerville Bold at 156 pixels. Do not vary placement or plaque styling between annual releases.
- The Commander 2013 / 2016 split uses the same plaque style in two equal-width panels at the identical y bounds. Both panels use the same two-line COMMANDER / year typography. Keep Jeleva and Oloro on the left; show both Breya and Atraxa, Praetors' Voice on the right. Atraxa represents the already-owned Breed Lethality deck, so markers remain 2 / 2.
- Lower the bottom-left Arahbo portrait on Commander 2017 enough that the middle plaque clears his complete head, ears and mane. Keep Inalla's head clear too. Reserve corresponding middle space in every annual composition and the 2013/2016 split; all lower portraits begin below the plaque with comfortable clearance.
- Kamigawa / The Brothers' War must place both set-title groups in the same lower horizontal area with aligned lower boundaries. Preserve their distinct neon and metallic wordmarks and the equal vertical split.
- Commander 2020 is the official annual-product name for the five Ikoria Commander decks; it does not mean Ikoria was the only Commander product in 2020. The current Ikoria label is accurate and retained. Its annual alias is optional display information, not an inventory grouping change.
- Current annual asset paths, prompt briefs and validation are recorded in `images/ANNUAL_CENTERED_2026_09_21.md`. Kamigawa's correction remains in `images/ANNUAL_ALIGNMENT_2026_09_21.md`. They supersede the prior catalog selections; preserve all earlier artwork files.

## Trimmed front sheets — 2026-09-22

- The latest user instruction applies to all nine front sheets: keep the established black outer area, but place the complete image smaller on the printed sheet. The catalog continues to use the `_4138x4858_1440dpi_black_margin_1_8in.png` sources; the front PDF boxes are 3946 × 4620 equivalent pixels (2.740278 × 3.208333 inches), so the artwork and black margins shrink together.
- Sheet 9 replaces The Lost Caverns of Ixalan with the updated Ikoria / Commander 2020 front. The updated Ikoria artwork keeps all three title rows together at the bottom and leaves the lower-right area clear for the count seal.

## Universes Beyond title cleanup — 2026-09-22

- The collection's Universes Beyond fronts are Warhammer 40,000, The Lord of the Rings, Doctor Who, Fallout, Final Fantasy, Teenage Mutant Ninja Turtles, and Marvel Super Heroes.
- Warhammer 40,000, The Lord of the Rings, Fallout, and Turtle Power received new versioned fronts with their top title treatments moved to the bottom. The Lord of the Rings and Fallout Universes Beyond labels were removed. Doctor Who, Final Fantasy, and Marvel Super Heroes already had acceptable placement and no visible Universes Beyond label, so their current fronts remain selected.
- Dedicated proof sheets 10 and 11 contain all seven Universes Beyond fronts in chronological catalog order. Normal and addendum sheets were rebuilt to use the revised four fronts.


## New releases and appended sheets — 2026-10-05

- The collection now includes Aetherdrift Commander (2), Edge of Eternities Commander (2), the two-color Starter Commander Decks (5), and Reality Fracture / Multiverse Reforged (1). The user explicitly confirmed Starter Commander, not the mono-color Foundations products.
- Add the fifth paired front: Aetherdrift on the left and Edge of Eternities on the right, equal vertical split with one central divider and `2 / 2` markers. Starter Commander remains standalone with `5`; Reality Fracture remains standalone with `1`. Preserve the earlier four pairings.
- The user requested the next numbered sheets for these additions. Use **Fronts 12** for the three fronts and **Boulder Tops 10** for all ten individual labels. This supersedes filling older vacant addendum slots for this batch.
- New catalog groups have `sheet_number` fields. The shared PDF builder keeps them on those pages, including subset exports, and never backfills them into earlier sheets. Existing pages and their source selections remain unchanged.
- Rebuild this batch with `scripts/build_new_sets_2026_10_05.py`. Maintain `LATEST_fronts_additions_2026_10_05.json` and `LATEST_tops_additions_2026_10_05.json`, and include the new pages in each `LATEST_*_all.json` index.

## Turtle Power / Reality Fracture temporary addendum — 2026-10-06

- The user combined Turtle Power! Commander and Reality Fracture Commander into one front. Use an equal vertical split, Turtle Power on the left and Reality Fracture on the right, with standard `1 / 1` seals. This supersedes their standalone drawer allocation above; preserve those individual artworks as alternatives.
- Put this single combined front on its own **temporary addendum sheet 13**, in the standard first slot at 2.740278 × 3.208333 inches on Letter. Leave the remaining slots blank. This explicit request overrides filling older addendum vacancies.
- Keep this temporary sheet separate from normal catalog packing and preserve the previous print PDFs and regular catalog selections. The inventory records the combined physical drawer; the existing regular sheets retain individual alternatives. Do not silently rebuild other sheets for this temporary export.
- Rebuild with `scripts/build_fronts_temporary_addendum_13.py`; its index is `Print Sheets/Fronts/.records/LATEST_fronts_temporary_addendum_13.json`. Finished images, prompt, retained references, and provenance are under `images/teenage_mutant_ninja_turtles/Fronts/turtle_power_reality_fracture/`.
- The user's October 6 correction requires Raphael's red bandana to stay on his head and not visually wrap onto his raised arm. Use `turtle_power_reality_fracture_vertical_split_v2_raphael_fixed_deck_counts_1_1_4138x4858_1440dpi_black_margin_1_8in.png` for current temporary sheet 13. The prior v1 image assets remain, and its PDF edition is archived.

## Current print selection — 2026-10-08

- The user retired **all addendum sheets**. Delete addendum PDFs and their receipts and indexes, including archived editions of sheets 7–9 and temporary sheet 13. Do not regenerate addenda unless the user explicitly requests them again. Preserve finished artwork and prompts.
- Select the corrected Turtle Power / Reality Fracture `1 / 1` combined front on **normal Fronts sheet 12** with the Aetherdrift / Edge and Starter Commander fronts. Remove the individual Turtle Power and Reality Fracture fronts from the active normal catalog; keep the underlying artwork files as alternatives.
- Rebuild normal sheets 4, 5, and 12 with the shared catalog generator. Commander Anthology II moves from sheet 5 to the open sheet-4 slot; sheet 5 then holds three category fronts. Update the current full front index and archive superseded normal PDF editions. Normal sheets 1–3 and 6 and all Boulder-top sheets remain selected as before.

## White Turtle Power title — 2026-10-11

- On the active Turtle Power / Reality Fracture combined front, `TURTLE POWER!` uses a white letter fill with its orange outline and dark shadow. Preserve Raphael's corrected green raised arm and red head bandana, the right Reality Fracture panel, and `1 / 1` count seals.
- The active sheet-12 source is `images/teenage_mutant_ninja_turtles/Fronts/turtle_power_reality_fracture/turtle_power_reality_fracture_vertical_split_v3_white_title_deck_counts_1_1_4138x4858_1440dpi_black_margin_1_8in.png`. Earlier v1/v2 artwork is retained; the previous normal sheet-12 PDF is archived under `.archive/white_turtle_title_2026_10_11/`.
- The user also requested this exact white-title front on its **own special addendum sheet 13**. It is a one-image reprint in the first standard front slot; keep the same image on normal sheet 12. This is an explicit exception to the October 8 addendum retirement. Build it with `scripts/build_fronts_special_addendum_13.py`; index it as `Print Sheets/Fronts/.records/LATEST_fronts_special_addendum_13.json`. Do not restore other retired addenda.

## Consecutive front numbering — 2026-10-11

- The user observed the gap after the former addenda were deleted and requested consecutive numbering. Current normal fronts are sheets **1–7**; the separate one-image Turtle Power / Reality Fracture special addendum is sheet **8**. The old 12/13 editions are archived. This supersedes all earlier current-number statements for these two sheets.
- The three new front groups in `print_catalog.json` have `sheet_number: 7`. The white-title combined source remains the same. Build the special reprint with `scripts/build_fronts_special_addendum_08.py`; its current index is `Print Sheets/Fronts/.records/LATEST_fronts_special_addendum_08.json`. Top-sheet numbering remains unchanged.

## Current Starter Commander front and addendum status — 2026-10-12

- The user deleted the one-image special addendum sheet 8. Its archived sheet-13 predecessor was also removed. Keep the Turtle Power / Reality Fracture combined front on normal sheet 7; do not regenerate special addenda without a new explicit request. This supersedes the October 11 special-addendum instruction.
- Starter Commander is the 2022 five two-color-deck product. Its current front title reads `STARTER COMMANDER 2022`, with the `5` count seal. Use `images/starter_commander/Fronts/starter_commander_five_legends_v3_2022_deck_count_5_4138x4858_1440dpi_black_margin_1_8in.png` on normal sheet 7. Preserve prior versions and the existing top labels.

## Color-matched new fronts — 2026-10-12

- The user asked to make all three newly added normal-sheet fronts less vibrant after comparing them to the older collection. Current counted 1440-DPI assets are `aetherdrift_edge_of_eternities_vertical_split_v2_muted_deck_counts_2_2`, `starter_commander_five_legends_v4_2022_muted_deck_count_5`, and `turtle_power_reality_fracture_vertical_split_v5_white_title_muted_deck_counts_1_1` in their respective `images/` directories. Keep these on normal Fronts sheet 7. The original high-vibrancy versions are preserved as alternatives.
- The revised counted print images measure mean HSV saturation 0.435, 0.425, and 0.468, versus 0.510, 0.518, and 0.613 previously; 27 older non-overflow active fronts averaged 0.445. Preserve exact titles, seals, split sides, and Raphael's red head bandana/green arm. Boulder tops were not color-edited in this pass.

## Turtle Power original-palette correction — 2026-10-12

- The user clarified that the split Turtle Power half had distracting rainbow/neon colors compared with the original full Turtle Power drawer front. The current normal-sheet source is `images/teenage_mutant_ninja_turtles/Fronts/turtle_power_reality_fracture/turtle_power_reality_fracture_vertical_split_v7_original_palette_deck_counts_1_1_4138x4858_1440dpi_black_margin_1_8in.png`. It was edited using the original full front as a palette and city-lighting reference; preserve the white title, corrected Raphael head bandana/green arm, right Reality Fracture panel, and `1 / 1` seals. Earlier v5 and v6 variants are retained.

## Current Turtle Power puddle scene — 2026-10-12

- The user clarified that the split left panel must replace its busy neon street scene with the original full Turtle Power front's large subdued puddle. Use `images/teenage_mutant_ninja_turtles/Fronts/turtle_power_reality_fracture/turtle_power_reality_fracture_vertical_split_v8_big_puddle_deck_counts_1_1_4138x4858_1440dpi_black_margin_1_8in.png` on normal Fronts sheet 7. This supersedes v7 original-palette guidance. Preserve four turtles, white title, Raphael's red head bandana and green raised arm, right Reality Fracture panel, and `1 / 1` seals.

## Current Turtle Power direct full-art fit — 2026-10-12

- The user explicitly requested using retained Turtle Power character art, without generating another turtle scene. The current normal-sheet source is `images/teenage_mutant_ninja_turtles/Fronts/turtle_power_reality_fracture/turtle_power_reality_fracture_vertical_split_v14_official_reality_deck_counts_1_1_4138x4858_1440dpi_black_margin_1_8in.png`. Rebuild the Turtle Power half with `scripts/build_turtle_split_from_tall.swift`; its center turtles and puddle come from the official tall source at uniform scale, and only the skyline above them uses a localized logo-removal edit. It draws the white title by code. Then run `scripts/build_turtle_reality_from_official.py` to place the retained official Reality Fracture Story portrait on the right in its original colors. Never stretch the puddle or turtle characters to fill the panel. This supersedes v13's dark color grade, v11's warped lower-water extension, v10's horizontal squeeze, and v8's generated turtle scene. The retained source contains the original red forearm wrap on Raphael.

## Current one-image addendum — 2026-10-18

- At the user’s explicit request, the current Turtle Power / Reality Fracture combined front is duplicated on its own **Fronts addendum sheet 8**. Normal sheet 7 still includes it. The addendum has one image in the first standard front slot and five blank slots. Build with `scripts/build_fronts_special_addendum_08.py`, which reads the current catalog-selected image. Its active PDF is `Print Sheets/Fronts/08_Special_Addendum_Turtle_Power_Reality_Fracture_1440dpi_635d866b8b.pdf`. This supersedes the October 12 addendum retirement only for this one sheet.
