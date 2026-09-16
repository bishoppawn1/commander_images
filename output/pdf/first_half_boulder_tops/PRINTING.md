# First-half Boulder top labels - Epson ET-8550

Four one-page US Letter PDFs: 12, 12, 12, and 10 labels. No release is split
between files. The first-half production boundary is The Brothers' War.
These contain the 45 newly generated first-half labels plus the retained Breed
Lethality label alongside Invent Superiority for Commander 2016 (46 total).
Breed Lethality retains its existing Commander Anthology Volume II text.
The rest of the already-prepared Anthology labels are not repeated here.

## Exact size and margins

- Paper: 8.5 x 11 inches, portrait.
- Every label: 2.75 x 2 1/3 inches, unchanged 3300 x 2800 source pixels.
- Effective image resolution: 1200 PPI; lossless image streams with source ICC
  profiles retained (sRGB tagging supplied for PNGs carrying an sRGB chunk).
- Grid: three columns by four rows. Last sheet has two unused slots.
- Left and right margins: 1/16 inch (1.5875 mm).
- Horizontal and vertical cutting gaps: 1/16 inch (1.5875 mm).
- Top and bottom grid margins: 0.739583 inch (18.7854 mm).
- No source image was resized, cropped, regenerated, or overwritten.

## Print without changing label sizes

Open a PDF in Preview, select the **Epson ET-8550**, and use **US Letter
Borderless** with compatible paper. Print one PDF page per paper sheet at
**100% / Actual Size**, not Fit to Page. The PDF already contains the 12-slot
layout: do not select 12 pages per sheet in the print dialog. Disable duplex.

The ET-8550 supports borderless Letter printing only with compatible media/settings.
Standard bordered mode can clip these narrow side margins. Match the actual
paper type; do not misidentify incompatible paper simply to enable borderless.

Borderless enlargement is separate from the application's 100% scaling. Disable
automatic expansion if your driver exposes that option; otherwise use the
smallest expansion setting and measure a test label before printing the batch.
Minimum expansion is not a guarantee of exact physical size. If it changes the
2.75-inch width, do not proceed with the full batch until the driver settings
are corrected. Expect some white paper around the grid: it is intentional.

Epson references:

- [Compatible borderless media and sizes](https://files.support.epson.com/docid/cpd5/cpd59879/source/printers/source/paper_loading/reference/et8500_8550_l8160_l8180/paper_borderless_types_us_can_et8500.html)
- [ET-8500/ET-8550 user guide](https://files.support.epson.com/docid/cpd5/cpd59879.pdf), borderless expansion and incorrect image size troubleshooting.

The filenames identify all releases on each page. `sheet_manifest.json` records
every source label, its RGB checksum, and exact placement. The reproducible
builder is `scripts/build_first_half_boulder_pdfs.py` at the project root.
