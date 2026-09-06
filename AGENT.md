# MTG Commander Deck Box Face Cards

## Project purpose

Create deck-box-style face cards that make Magic: The Gathering Commander deck sets easy to identify.

## Output requirements

- Final physical size: **3 × 3.5 inches** (portrait orientation unless a later instruction says otherwise).
- Generate print-ready artwork at high resolution.
- Minimum target: **900 × 1050 pixels at 300 DPI**.
- Preferred target: **1800 × 2100 pixels at 600 DPI**, or higher when practical, while preserving the exact 6:7 aspect ratio.
- Favor crisp typography, clean edges, and sufficient detail for physical printing.
- Favor full, edge-to-edge compositions with useful visual detail throughout the frame.
- Do not select or generate images containing large blank, white, featureless, or otherwise low-information areas.
- Crop, reframe, extend, or redesign source imagery as needed to fill the 6:7 canvas while keeping important subjects and text comfortably inside the print-safe area.

## Print-margin variants (black)

- Preserve every existing full-bleed finished target. Never replace or overwrite it when preparing a print-margin version.
- Every active print-margin variant uses the finalized project-wide treatment prototyped on Commander Masters. Keep the outer canvas at **1724 × 2024 pixels and 600 DPI**.
- Build a 1574 × 1874 artwork source from the complete finished target as one unit, including its title, count seal, dividers, and all other artwork. The archived 1800 × 2100 3/16-inch derivative provides this source region.
- Enlarge that complete artwork region to **1644 × 1944 pixels** without changing the 1724 × 2024 outer canvas. Center it horizontally at `x=40`; its top extends 16 pixels beyond the canvas and is clipped, while **96 total pixels** remain below it.
- Fill all exposed print-margin space with opaque black (`#000000`). Add a **3-pixel opaque-black cut-guide border on the outermost pixels of the active file**. The visible black margins are exactly **37 pixels on each side, none at the top, and 93 pixels at the bottom**.
- Do not redraw or reposition individual titles, markers, or panel dividers for this print derivative. The entire completed face is transformed together.
- Name active derivatives by inserting `_1724x2024_black_margin_1_8in` before `.png`.
- Store active variants alongside their corresponding finished targets in the main set directory. Do not create separate reframe or cut-guide siblings.
- Retain every superseded 1800 × 2100 white 3/16-inch derivative under that set's `src/superseded_white_margin_3_16in/`; do not leave superseded variants in the set-directory root.
- Build active variants deterministically with `scripts/crop_white_margin.swift`, `scripts/add_cut_border.swift`, and `scripts/reframe_final_black_margin.swift`. Validate them with `scripts/validate_final_black_margin.swift`. `scripts/apply_white_margin.swift` and `scripts/validate_white_margin.swift` remain available for constructing and checking the archived white 3/16-inch intermediate from a full-bleed target.

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

- Treat later user directions as additions or refinements to these project requirements.
- Record durable follow-on project requirements in this file so future work remains consistent.
- If a later instruction conflicts with an earlier one, follow the most recent explicit user instruction and update this file accordingly.

## Collection inventory and grouping authority

- Treat `INVENTORY.md` as the authoritative list of owned physical deck-release groups, owned/total counts, deck-count marker values, and drawer-face groupings.
- Zendikar Rising Commander and Kamigawa: Neon Dynasty Commander use the approved equal vertical-split combined drawer face.
- Commander 2013 and Commander 2016 remain standalone inventory groups, but an optional chronological Commander 2013 | Commander 2016 vertical-split candidate is authorized for comparison. Creating that candidate does not change the inventory grouping; update `INVENTORY.md` only if the user later confirms the combination.
- Commander Legends and Phyrexia: All Will Be One Commander use one approved equal vertical-split drawer face with markers `2 / 2`: Commander Legends on the left and Phyrexia on the right. Both owned decks from each release are represented by this combined face. Their standalone full-release targets remain available as alternatives, not as additional active drawer allocations.
- Commander 2020 / Ikoria, Strixhaven Commander, and March of the Machine Commander each remain standalone and use a `5` marker.
- The Brothers' War Commander and Wilds of Eldraine Commander use one approved equal vertical-split drawer face with markers `2 / 2`. All owned decks from both releases are represented by that combined face; their prior standalone targets remain preserved as historical assets rather than active drawer allocations.
- Doctor Who Commander uses a standalone `4` marker for the four unique preconstructed decks owned.
- Turtle Power! Commander uses a standalone `1` marker because the release contains one ready-to-play Commander deck and the collection owns it.
- Overflow is an open-ended storage-category face. It must read exactly `OVERFLOW` and intentionally receives no count marker.
- Preserve Anthology decks under the Anthology product actually owned rather than regrouping them under their original Commander releases.
- Update `INVENTORY.md` whenever the user adds, removes, corrects, or regroups collection entries.

## Image asset organization

- Use a descriptive lowercase snake-case directory name for `<set_or_precon>`, such as `images/commander_anthology_i/`.
- Keep the main `images/<set_or_precon>/` directory clean: apart from the `prompts/` and `src/` subdirectories, it may contain only finished face-card target images. A finished target belongs here whether it is generated, adapted, or directly reused from official Wizards artwork.
- Keep finalized generation/edit prompt briefs in `images/<set_or_precon>/prompts/`. Do not store prompt files in the main set directory or in `src/`.
- Keep only raw source/reference images, unmodified ImageGen outputs, and supporting production notes in `images/<set_or_precon>/src/`. Never place a finished or print-ready target candidate in `src/`.
- Treat a suitable official reveal, key-art, or social image as a target—not merely as a source—once it satisfies the face-card requirements. If it already has the exact output specifications, keep that target in the main directory without making an unnecessary duplicate in `src/`. If it needs cropping, extension, or normalization, preserve the untouched download in `src/` and place the finished adapted target in the main directory.
- Preserve source images without overwriting them. Give finished targets and revisions distinct descriptive filenames in the main set directory.
- Record source URLs, artist attribution when known, original pixel dimensions, transformations, and relevant usage notes in `images/<set_or_precon>/src/sources.md`.
- Product photographs or references with substantial empty backgrounds may be retained for design information, but must not be used directly as final face-card artwork without being cropped, reframed, or reconstructed.

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
- Create a combined directory named `images/<first_set>_<second_set>/`, with the normal `prompts/` and `src/` subdirectories. Store only finished 6:7 target images in the combined directory root.
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

1. Create or identify `images/<set_or_precon>/` and its `prompts/` and `src/` subdirectories using a descriptive lowercase snake-case set or precon name.
2. Verify the product name and associated MTG set from authoritative sources. Verify individual decks and face commanders only when they are relevant to the requested face.
3. Research the official First Look/reveal/debut article and Wizards Play Network assets for branded key-art graphics with the set name already integrated. Keep those in contention with official vertical set art, then inspect other key art, phone wallpapers, packaging, logos, promotional imagery, posters, and—only when relevant—face-card art.
4. Retain only useful raw source/reference images in `src/` and document their URLs, attribution, pixel dimensions, and intended role in `src/sources.md`. Promote every completed face-card candidate—including official-art candidates—to a finished target in the main set directory.
5. Decide whether to reuse, adapt, or generate. Prefer reuse/adaptation when existing art already satisfies the format and visual requirements. Directly reused official art is a finished target and must be stored in the main set directory.
6. Before generation, create a finalized set-specific prompt brief in `prompts/` that names every `src/` input image and its role, defines the exact identification text, preserves the set's established visual identity, and repeats the print, fullness, and drawer-legibility constraints.
7. Generate without pausing for approval when the user's requested direction and available references are sufficient.
8. Inspect the result for exact text, immediate drawer readability, full-frame composition, recognizable set identity, unwanted empty space, repeated or incorrect subjects, and print-safe placement. Iterate when a material requirement fails.
9. Preserve the unmodified generated output in `src/`, then create a non-destructive exact 6:7 print target at 1800 × 2100 pixels with 600-DPI metadata in the main set directory.
10. Record the final asset, generation mode, exact prompt, transformations, and provenance in `src/sources.md`; keep the finished prompt brief in `prompts/` and the target image in the main set directory.
