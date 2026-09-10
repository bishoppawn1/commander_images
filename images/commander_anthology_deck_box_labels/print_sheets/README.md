# Letter-size GIMP grid and printing sheet

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

## Rearrange the sheets already open in GIMP

The script below runs inside your existing GIMP session. It rearranges each open
sheet's visible top-level image layers or groups into a grid, preserving their
dimensions, resolution, color, opacity, and the page size. Each top-level group is
treated as one item. Page-sized layers named Background, White Background,
Paper Background, or White Paper Background are left in place. Hidden layers are
not moved.

1. Click your existing GIMP window to make GIMP active.
2. In the menu bar at the **very top of the Mac screen**, click **Filters**.
3. Choose **Development > Python-Fu > Console** (it may say **Python Console**).
4. Click beside the `>>>` prompt at the bottom of the console.
5. Paste the following entire line and press **Return once**:

```python
import runpy; runpy.run_path('/Users/bishophall/_code/MTGCommanderFaces/arrange_gimp_sheets.py', run_name='__main__')
```

6. Wait until the console says **DONE**. Large 1200-PPI documents can take a while
   to save, so do not run the command again while it is still working.
7. Close the Python Console to inspect your sheets. The new eight-label anthology
   sheet opens in a new tab if it was not already open.

For each changed existing tab, the script saves a **before** and **grid** XCF copy
under `rearranged_open_sheets/<date-and-time>/` in this folder. The original file
on disk and the existing tab's association with that file are preserved. The tab
remains modified: use **Undo once** immediately after running to restore the old
positions, or reopen the saved before copy later. Saving the original tab yourself
will, as usual, save its new arrangement to its original file.

The script reports and skips flattened/single-image sheets, locked image layers,
or sheets whose layers cannot fit with at least 0.5-inch margins and 0.2-inch gaps.
It does not cut apart flattened images or shrink labels to force a fit. Read any
**SKIPPED** or **ERROR** lines; the same details are saved in
`arrangement_report.txt` beside the before/after copies.

## Rebuild and verification

Run `src/build_letter_sheet.py` in an isolated GIMP 3 Python batch interpreter to
build and reopen-check the XCF. Run `src/build_letter_pdf.py` with Pillow,
ReportLab, and pypdf to rebuild the PDF and verify its embedded image pixels.
`src/test_open_sheet_arrangement.py` exercises the live arranger on temporary
synthetic GIMP documents; it does not access the user's existing GIMP instance.

Console menu reference:
https://docs.gimp.org/3.0/en_GB/gimp-filters-python-fu.html
