# Print the current collection

The November 8, 2026 refresh contains **10 Boulder-top PDFs** (114 placements, 113 unique designs) and **7 front PDFs** (37 placements, including six optional Overflow labels). All sets stay together. Superseded PDFs, including archived editions and duplicate addenda, have been removed.

Use [the current sheet index](Print%20Sheets/INDEX.md) for PDF links and PNG previews. Keep PDF previews closed in Codex because they previously caused a crash; inspect the PNG previews instead.

Star Trek tops now share **top sheet 10** with Starter Commander. The Star Trek front is on **front sheet 7**. Front sheets 1–5 each contain six images; sheet 6 holds six optional Overflow labels. The Aetherdrift / Edge of Eternities, Starter Commander and Turtle Power / Reality Fracture fronts fill the remaining slots on sheet 5.

## Artwork and folders

Each set lives in `images/<set>/`, with `Tops/` and `Fronts/` subdirectories. Sources and prompts are inside the relevant format. Shared paired fronts and Anthology tops use relative symlinks. `print_catalog.json` selects the current images; earlier PNG versions remain available.

Inspect the latest [five approved upward framing corrections](reviews/boulder_upper_third_2026_11_08/index.html), with [direct old/new image links](reviews/boulder_upper_third_2026_11_08/IMAGE_LINKS.md). Exquisite Invention, Animated Army, Wakanda Forever, Mutant Menace and Devour for Power use retained artwork reframed upward; the other 109 top placements are unchanged. The upper-third guideline allows headwear, wings and large-scene exceptions.

The earlier [whole-collection readability comparison](reviews/boulder_readability_2026_11_08/index.html) remains available as historical provenance.

## Physical sizes

Print at **100% / Actual Size**. Do not fit to page.

| Format | PNG source | Printed size | Letter layout |
| --- | --- | --- | --- |
| Boulder tops | 3960 × 3360, 1440 DPI | 2.75 × 2.333333 inches | 3 columns × 4 rows |
| Drawer fronts | 4138 × 4858, 1440 DPI | 2.740278 × 3.208333 inches | 2 columns × 3 rows |

Top columns retain a **0.25-point white separator (0.09 mm)** for cutter alignment. Narrowing the former 4.5-point gutters increases the left/right page margins from 1/16 inch (1.59 mm) to **0.1215 inch (3.09 mm)** while keeping every label at its original physical size. Vertical row spacing is unchanged. Front-sheet spacing is unchanged. The side clearance exceeds the ET-8550's [specified 3 mm minimum](https://files.support.epson.com/docid/cpd5/cpd59879/source/specifications/references/et8500_8550_l8160_l8180/spex_printable_area_et8500_8550.html).

Use a Letter mode that prints within those 3.09-mm side margins; if using Borderless, disable automatic enlargement where available and measure a proof. Fronts fit ordinary Letter. The complete front image, including its existing black margin, is scaled as one unit. Artwork pixels are embedded losslessly with ICC color profiles.

## Rebuilding

Double-click **Make Print PDFs.command** to select a format and scope interactively. From the project root, the launcher also accepts arguments:

```sh
./"Make Print PDFs.command" --kind both --plan
./"Make Print PDFs.command" --kind both --replace-all
./"Make Print PDFs.command" --kind tops --scope second
./"Make Print PDFs.command" --kind tops --sets commander_2013,commander_2016
```

`--replace-all` validates the complete new batch before removing earlier PDFs and receipts. It requires the `all` scope without a set subset. Use it for full collection refreshes; ordinary subset exports preserve existing editions. `--plan` validates sources and prints the layout without writing PDFs. `--list` lists catalog IDs. `--output` selects a different parent destination.

PDFs go into `Print Sheets/Boulder Tops/` and `Print Sheets/Fronts/`. Hidden `.records/LATEST_tops_all.json` and `.records/LATEST_fronts_all.json` list the current complete batches. `python scripts/build_print_index.py` refreshes PNG previews and the human-readable sheet index after a rebuild.

The top-art builder is `python scripts/build_boulder_collection.py`. It reads all current manifests, uses the shared Swift compositor, and renders 1440-DPI PNGs. Preview with `--dpi 360 --output tmp/top-previews`. See `images/BOULDER_TOP_COMPOSITION.md` for framing, shading and restrained lighting requirements.

The former isolated Star Trek and October-additions PDF helpers now delegate to a complete compact refresh. Historical page reservations are retired. No print request is sent automatically.

## Coverage and verification

Top scopes contain 46 first-half, 60 second-half and 8 Anthology placements. Breed Lethality is intentionally present under Commander 2016 and Anthology II using a shared current asset. Fronts select each physical grouping once, with the six requested Overflow copies on their own optional page.

Preflight rejects missing sources, wrong pixel sizes, DPI or color-space errors. Each generated PDF is reopened and checked for original image pixels, ICC profiles, page size, placement and exact label coverage. Automated packing and failure-preservation checks are in `scripts/test_print_pdfs.py`. PNG page previews receive visual inspection.

The launcher uses the bundled Python on this Mac. Other systems need Pillow, reportlab and pypdf, plus Swift/CoreGraphics for artwork and Poppler for PDF previews. Original source art and manifests must be available locally.
