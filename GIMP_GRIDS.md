# Arrange the six verified GIMP sheets

The script and this guide are in the project's main folder, outside any set folder.
The exact image order is recorded in [GIMP_SHEET_PLAN.md](GIMP_SHEET_PLAN.md).

## Run in your existing GIMP window

1. Choose **Filters → Development → Python-Fu → Console** from the menu bar at the top of your Mac's screen.
2. Paste this entire line beside `>>>` and press **Return once**:

```python
import runpy; runpy.run_path('/Users/bishophall/_code/MTGCommanderFaces/arrange_gimp_sheets.py', run_name='__main__')
```

3. Wait for **DONE**, then close the console. Large XCF backups can take time.
   Do not rerun the command while it is saving.

## Exactly what changes

- Only the six screenshot-matched sheets with the verified image filenames.
  Document names such as Untitled and tab order are not used to identify them.
- Sheets 1–4: two columns, three rows, in the specified order.
- Sheet 5: two images in the first row, Commander Masters below the left image.
- Sheet 6: two columns, four rows, with Anthology I left and Anthology II right.
- No resizing, cropping, recoloring, resolution changes, or background moves.
- Any other documents, including the two 300-PPI entries in the console inventory,
  are left unchanged. Their age and visibility in the GUI are not known.

The 600-PPI sheets use 1-inch left/right margins, 0.25-inch top/bottom margins
(for full sheets), an approximately 0.753-inch column gap, and 0.19-inch row gaps. Sheet 5 uses
the same first three positions and leaves the rest blank. The 1200-PPI Anthology
sheet uses 1-inch left/right margins, 0.5-inch top/bottom margins, a 1-inch column
gap, and approximately 0.222-inch row gaps. Confirm printable-area compatibility
in the print preview; do not use Fit to Page to change the label sizes.

Before/after XCF copies and a report go in **gimp_grid_sheets**, beside the script,
in a dated folder. Original files on disk are not overwritten, and their tab
associations are preserved. Undo once immediately in a changed tab to restore its
positions, or reopen its saved `_before.xcf` later. Saving a changed original tab
yourself will save its new arrangement to its original file.

Read any **SKIPPED**, **NOT FOUND**, or **ERROR** lines. Unexpected layer names,
sizes, resolution, position locks, extra visible layers, or duplicate matching
documents prevent the affected sheet from being moved. An already-correct sheet
is reported as **UNCHANGED**. This command does not open or create extra sheets.

Verification uses `scripts/test_gimp_sheet_arrangement.py` in an isolated GIMP
instance with synthetic documents, not the user's live sheets.
