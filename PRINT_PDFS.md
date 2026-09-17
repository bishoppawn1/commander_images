# Make PDFs for Boulder tops and large fronts

## Easiest way

In this project's main folder, double-click **Make Print PDFs.command**.
It opens Terminal, not GIMP. Choose:

1. **Boulder tops**, **Large fronts**, or **Both**.
2. **All**, **First half**, or **Second half**.
3. Review the listed pages, then type **y** to generate them.

For everything, choose **3**, then **1**, then **y**.

The output is under `output/pdf/generated/`, in folders such as `tops_all` and
`fronts_all`. `LATEST.json` lists the current PDFs for each batch. Filenames name
the sets and end with a short revision code. Unchanged PDFs are skipped on rerun;
changed images produce a new edition instead of overwriting an earlier PDF.
Do not print every old revision in a folder: use the current run's filenames.

## What it preserves

| Format | Source | Printed image size | Letter grid |
| --- | --- | --- | --- |
| Boulder tops | 3960 x 3360, 1440 PPI | 2.75 x 2.333333 in | Up to 12, 3 x 4 |
| Large fronts | 4138 x 4858, 1440 PPI | 2.873611 x 3.373611 in | Up to 6, 2 x 3 |

These are the current black-margin front print files, not the older 3 x 3.5-inch
full-bleed masters. Neither format is resized or cropped. Embedded image pixels
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

The front catalog contains 30 inventory-approved faces/categories. It uses the
three combined fronts from INVENTORY.md and does not also print their standalone
alternatives. Commander 2013 and 2016 stay separate per the inventory. For fronts,
a cross-half combined face belongs to the first-half selection and remains whole.
Anthologies and the miscellaneous categories are included by **All**, not by
the first/second-half filters.

The script does not print all 93 front variants: doing so would duplicate sets.
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
`--list` lists set IDs. For a custom subset, use one format plus `--sets`:

```sh
./"Make Print PDFs.command" --kind tops --sets commander_2013,commander_2016
```

The old `scripts/build_first_half_boulder_pdfs.py` entry point delegates to the
same shared engine. Previously created PDFs are not removed or replaced.

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
