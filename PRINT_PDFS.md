# Make PDFs for Boulder tops and large fronts

## Easiest way

In this project's main folder, double-click **Make Print PDFs.command**.
It opens Terminal, not GIMP. Choose:

1. **Boulder tops**, **Large fronts**, or **Both**.
2. **All**, **First half**, or **Second half**.
3. Review the listed pages, then type **y** to generate them.

For everything, choose **3**, then **1**, then **y**.

PDFs go into two subfolders of **Print Sheets** in the project's main folder:

- **Boulder Tops** contains the complete Boulder-top collection.
- **Fronts** contains the large drawer fronts and the optional Overflow sheet.

Open the existing PDFs to print; the command is only needed to generate or update
sheets. Boulder-top filenames include `Boulder_Tops`.

Each subfolder has a hidden `.records` folder; its `LATEST_*.json` indexes list
the current PDFs for each batch. The two older first-half top-sheet collections
are preserved in `Boulder Tops/.archive`. Finder normally hides these support folders.
Filenames name the sets and end with a short revision code. Unchanged PDFs are skipped on rerun;
changed images produce a new edition instead of overwriting an earlier PDF.
Do not print every old revision in a folder: use the current run's filenames.

## What it preserves

| Format | Source | Printed image size | Letter grid |
| --- | --- | --- | --- |
| Boulder tops | 3960 x 3360, 1440 PPI | 2.75 x 2.333333 in | Up to 12, 3 x 4 |
| Large fronts | 4138 x 4858 source, scaled to 3946 x 4620 equivalent, 1440 PPI | 2.740278 x 3.208333 in | Up to 6, 2 x 3 |

These are the current black-margin front print files, not the older 3 x 3.5-inch
full-bleed masters. The latest front sheets scale the complete image, including
the black outer area, as one unit. Embedded image pixels
are verified against the PNGs; ICC profiles are retained. No JPEG compression.

- Tops retain 1/16-inch side margins and cutting gaps; top/bottom margins are
  approximately 0.739583 inch. Print on compatible Letter Borderless media.
- Fronts have 0.75-inch side margins, 0.25-inch top/bottom margins, about
  1.253-inch column gap, and approximately 0.189583-inch row gaps. These fit without borderless.
- Sets are indivisible groups; a group larger than page capacity raises an error.
- Pages are filled automatically in catalog order, using earlier vacant slots
  when a whole later set fits. Some sets may therefore appear out of date order.
- Both layouts retain blank cells on their final sheet instead of enlarging images.
- Print at 100% / Actual Size. Tops need a check of borderless expansion: measure
  one printed label before a batch, since driver expansion can change physical size.

## Coverage and selection

The first half ends at The Brothers' War; the second begins with Phyrexia: All
Will Be One. The top selections are 46 first-half labels, 46 second-half labels,
and 8 Anthology labels. **All** includes all 100 physical labels, using 99 unique
designs because the collection has Breed Lethality under two owned products.
The current Commander 2016 manifest includes its reused Breed Lethality entry;
the tool does not append another copy to that set.

The front catalog contains 29 inventory-approved faces/categories. It uses the
four chronological combined fronts from INVENTORY.md and does not also print their
standalone alternatives. For fronts, every combined face remains whole; the
Phyrexia: All Will Be One / Wilds of Eldraine face belongs to the second-half
selection and the other three combined faces belong to the first-half selection.
Anthologies and the miscellaneous categories are included by **All**, not by
the first/second-half filters.

The full front batch has six PDFs: sheets 1-4 have six images each; sheet 5 has
four images and no Overflow. Sheet 6 is a separate optional sheet of **six
Overflow labels**, clearly named `06_6_Overflows_Optional_1440dpi_<revision>.pdf`.
Skip printing sheet 6 unless you need spare Overflow labels. The catalog's
`copies` and `dedicated_sheet` settings make this repeatable without duplicating
the source artwork. To regenerate only the Overflow sheet, use
`--kind fronts --sets overflow` (a standalone subset is numbered from 01).

The script does not print all 123 front variants: doing so would duplicate sets.
The exact selected filenames are visible/editable in `print_catalog.json`.
Changing a front variant or adding a new release only requires updating that
catalog entry; no manual page positioning or new Python script is needed.
Top entries read all deck slugs from each release's `label_manifest.json`, so
adding a deck to an existing manifest is picked up automatically.

## Commands (optional)

From the project folder:

```sh
./"Make Print PDFs.command" --kind both --scope all --plan
./"Make Print PDFs.command" --kind tops --scope second
./"Make Print PDFs.command" --kind fronts --scope all
./"Make Print PDFs.command" --kind tops --scope anthology
./"Make Print PDFs.command" --kind both --scope all
```

`--plan` validates images and shows the proposed pages without creating PDFs.
`--output` changes the parent destination; PDFs still go into its `Boulder Tops`
and `Fronts` subfolders.
`--list` lists set IDs. For a custom subset, use one format plus `--sets`:

```sh
./"Make Print PDFs.command" --kind tops --sets commander_2013,commander_2016
```

The old `scripts/build_first_half_boulder_pdfs.py` entry point delegates to the
same shared engine and also saves to `Print Sheets/Boulder Tops`. Previously created
PDFs are not removed or replaced.

## Requirements and safety

The launcher uses the available bundled Python on this Mac, with system Python
as a fallback. The Python libraries required are Pillow, reportlab, and pypdf.
On another machine, use a Python environment containing those libraries and run
`python3 make_print_pdfs.py --interactive`. Source PNGs and manifests must also
be present locally; the script does not download missing images.

Sources are checked before a batch starts. Missing files, incorrect pixel sizes,
wrong DPI metadata, or unknown color spaces cause an error instead of falling
back to old/lower-resolution images. Individual PDFs are saved only after checks
pass. If a later page fails, earlier verified PDFs remain safe; rerun after fixing
the input. A modified/incomplete cached PDF is not silently overwritten.

Full-resolution batches can take several minutes and several GB. No printer job
is submitted automatically. Automated tests are in `scripts/test_print_pdfs.py`.


## Corrected front batch — 2026-09-19

Sheets 1–3 now select the corrected Eldraine, Ikoria, Forgotten Realms, Warhammer 40,000, March of the Machine, Lord of the Rings and Ixalan fronts. All remain 1440 DPI at the original physical print size. Superseded sheets 1–3 are moved into `Fronts/.archive/superseded_2026_09_19/`; use the six PDFs in the main `Fronts/` folder. See `images/DRAWER_CORRECTIONS_2026_09_19.md`.

Keep PDF previews closed in Codex because the saved Files preview caused a crash. For inspection, render small page PNGs or inspect PDF metadata and embedded images.

## Typography refinements v4 — 2026-09-19

Sheets 1 and 2 now use the restored original Eldraine lettering with smaller BRAWL, the darker and tighter Forgotten Realms title, and the unified Warhammer crest. Both rebuilt sheets passed embedded-image verification and visual review of small PNG renders. The two superseded sheets and receipts are in `Fronts/.archive/typography_refinements_v4_2026_09_19/`. Exactly six current PDFs remain in the main `Fronts/` folder; sheets 3–6 are unchanged. See `images/TYPOGRAPHY_REFINEMENTS_V4.md` for artwork and production records.

## Heading readability v5 — 2026-09-20

Sheet 1 now includes Eldraine with a dark backing behind THRONE OF and Ikoria with matching crystalline COMMANDER 2020 lettering. Embedded-image validation and a small rendered PNG review passed. The prior sheet 1 and receipt are archived under `Fronts/.archive/readability_v5_2026_09_20/`. Exactly six current PDFs remain; sheets 2–6 are unchanged. See `images/READABILITY_REFINEMENTS_V5.md`.

## Eldraine unified title shadow v6 — 2026-09-21

Sheet 1 now uses matching dark backing behind all three Eldraine title rows. Verified embedded images and small PNG render. Prior sheet 1 and receipt are archived under `Fronts/.archive/eldraine_shadow_v6_2026_09_21/`. Six current sheets remain. See `images/ELDRAINE_UNIFIED_SHADOW_V6.md`.

## Addendum sheets 7–9 — updated 2026-09-21

The separate seventh addendum uses the latest catalog artwork in the user's requested order:

| Row | Left | Right |
| --- | --- | --- |
| 1 | Adventures in the Forgotten Realms | Warhammer 40,000 |
| 2 | Ikoria / Commander 2020 | Throne of Eldraine Brawl |
| 3 | Zendikar Rising / Commander Legends split | Kamigawa / The Brothers' War split |

Sheet 7's old empty slot is now filled with the corrected Kamigawa / The Brothers' War front. Sheet 8 holds the four centered annual fronts together:

| Row | Left | Right |
| --- | --- | --- |
| 1 | Commander 2013 / 2016 split | Commander 2017 |
| 2 | Commander 2018 | Commander 2019 |
| 3 | March of the Machine | The Lord of the Rings |

Sheet 9 contains **The Lost Caverns of Ixalan** in its top-left slot, with five slots available for future corrections. March of the Machine, The Lord of the Rings and Ixalan were corrected earlier and were initially missed when assembling the addenda; this coverage audit adds them.

All three retain the normal Letter 2-by-3 front grid, 1440-DPI embedded images and original physical print size. Current filenames are in `Fronts/.records/LATEST_fronts_addenda.json`, with separate `LATEST_fronts_addendum_07.json`, `LATEST_fronts_addendum_08.json` and `LATEST_fronts_addendum_09.json` indices. Sheets 1–6 remain the normal full catalog batch, indexed separately in `LATEST_fronts_all.json`; addenda intentionally repeat fronts for convenient reprinting.

To rebuild all three from the latest catalog selections, run `scripts/build_fronts_addenda.py` with the project's Python runtime. The older `scripts/build_fronts_addendum_07.py` command rebuilds only sheet 7. Both use the shared PDF builder and embedded-image validation. Fill empty slots in existing addenda before adding more pages. The prior five-front sheet 7 is archived under `Fronts/.archive/addenda_filled_2026_09_21/`; the four-front sheet 8 is archived under `Fronts/.archive/addenda_coverage_2026_09_21/`. See `images/ADDENDUM_CORRECTION_COVERAGE_2026_09_21.md` for the complete coverage checklist.


## Annual titles and split corrections — 2026-09-21

Sheets 1 and 2 now use the corrected Commander 2013/2016 split (including Atraxa for Breed Lethality), the matching Commander 2017–2019 title panels, and the vertically aligned Kamigawa / The Brothers' War wordmarks. Both replacement PDFs passed embedded-image verification and visual review of small PNG renders. Superseded sheets and receipts are retained in `Fronts/.archive/annual_alignment_2026_09_21/`. Exactly seven current PDFs remain; sheets 3–7 keep their existing files. Ikoria's accurate Commander 2020 alias is retained. See `images/ANNUAL_ALIGNMENT_2026_09_21.md` for the current artwork and prompt records.


## Centered annual labels — 2026-09-21

Sheet 1 now places the Commander 2017–2019 labels and both Commander 2013/2016 split labels in the middle, between upper and lower portraits. Arahbo was lowered on the 2017 front; all lower commander heads have clear space beneath the labels. The revised sheet passed embedded-image verification and visual review of a small rendered PNG. Its predecessor and receipt are in `Fronts/.archive/annual_centered_2026_09_21/`. Exactly seven current sheets remain; sheets 2–7 keep their prior files. See `images/ANNUAL_CENTERED_2026_09_21.md` for artwork and exact built-in ImageGen edit prompts.


## Addenda filled and verified — 2026-09-22

Sheet 7 and sheet 8 remain full. Sheet 9 now contains the updated Ikoria / Commander 2020 front in place of Ixalan. All current addenda use the black-margin sources scaled as complete images and passed embedded-pixel validation and visual review. Superseded PDFs and receipts are archived under `Fronts/.archive/trimmed_margins_2026_09_22/`.

## Universes Beyond proof sheets — 2026-09-22

Sheets 10 and 11 are dedicated Universes Beyond proof sheets. They contain Warhammer 40,000, The Lord of the Rings, Doctor Who, Fallout, Final Fantasy, Teenage Mutant Ninja Turtles, and Marvel Super Heroes. Four revised fronts move top titles to the bottom; The Lord of the Rings and Fallout no longer show the Universes Beyond label.


## Full correction-history coverage audit — 2026-09-21

The earlier addenda missed March of the Machine, The Lord of the Rings and The Lost Caverns of Ixalan from the earlier correction batch. Sheet 8 now fills its two remaining slots with March and LOTR; sheet 9 contains Ixalan. The audit of six correction manifests confirms that all 12 distinct corrected fronts are included exactly once, plus the separately requested Zendikar / Commander Legends split, with current catalog artwork throughout. The new PDFs passed embedded-image and visual checks. The prior sheet 8 is archived; nine current front PDFs remain. Sheet 7 and normal sheets 1–6 are unchanged. See `images/ADDENDUM_CORRECTION_COVERAGE_2026_09_21.md`.
