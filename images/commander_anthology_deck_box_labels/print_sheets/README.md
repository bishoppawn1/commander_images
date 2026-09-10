# Commander Anthology Letter sheet

`commander_anthology_letter_grid_1200ppi.xcf` is an editable GIMP document with
eight separate label layers above a locked white paper background.
`commander_anthology_letter_grid_1200ppi.pdf` is the matching one-page print file.

- Page: 8.5 x 11 inches, portrait (10200 x 13200 pixels at 1200 PPI).
- Layout: two columns by four rows.
- Each label: unchanged 3300 x 2800 pixels, printed at 2.75 x 2.3333 inches.
- Top and bottom margins: 0.5 inch.
- Left and right margins: 0.75 inch.
- Gap between columns: 1.5 inches.
- Gap between rows: approximately 0.222 inch (5.64 mm).
- PDF: source RGB pixels preserved exactly; explicit sRGB ICC profile embedded.

Print the PDF from Preview at **100% / Actual Size**, with automatic fitting and
two-sided printing off. Select the paper type matching the actual laser-compatible
stock. The document's 1200 PPI does not require a 1200-DPI printer setting.

The separate [six-sheet GIMP arrangement script and instructions](../../../GIMP_GRIDS.md)
are at the project root. That script follows the user's current screenshot order
and uses 1-inch side margins; it does not rebuild these previously prepared files.

## Rebuild these prepared files

Run `src/build_letter_sheet.py` in an isolated GIMP 3 Python batch interpreter to
build and reopen-check the XCF. Run `src/build_letter_pdf.py` with Pillow,
ReportLab, and pypdf to rebuild the PDF and verify its embedded image pixels.
