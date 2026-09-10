# Layout changes for the six current GIMP sheets

Based on the six screenshots supplied September 9, 2026, in attachment order.
The previously redundant sheet was deleted by the user and is not included.
This is a plan for these particular sheets, not a general image-generation prompt.
The sheets in the live GIMP session have not been changed.

## Sheet 1 — Forgotten Realms / Bloomburrow

Keep the existing 2-column × 3-row order:

| Row | Left | Right |
| --- | --- | --- |
| 1 | Adventures in the Forgotten Realms | Bloomburrow |
| 2 | Commander Legends / Phyrexia: All Will Be One | Commander 2013 / Commander 2016 |
| 3 | Commander 2017 | Commander 2018 |

Align each column's left edges, align the top edges across each row, and make
the two vertical gaps equal. The present row gaps are tight, and the right-hand
images sit slightly lower than the corresponding left-hand images. Center the
complete arrangement horizontally and balance its top/bottom margins.

## Sheet 2 — Commander 2020 / Strixhaven

Keep the existing 2-column × 3-row order:

| Row | Left | Right |
| --- | --- | --- |
| 1 | Commander 2020 / Ikoria | Strixhaven |
| 2 | Commander 2019 | Commander Anthology II |
| 3 | Commander Anthology I | Custom Commander Decks |

Straighten both columns and align each row. Make the tight vertical gaps equal,
including the space above the bottom row. Balance the outer margins. Do not
swap the Anthology I and II drawer faces or substitute individual deck labels.

## Sheet 3 — Final Fantasy / Lord of the Rings

Keep the existing 2-column × 3-row order:

| Row | Left | Right |
| --- | --- | --- |
| 1 | Final Fantasy | The Lord of the Rings: Tales of Middle-earth |
| 2 | Fallout | March of the Machine |
| 3 | The Lost Caverns of Ixalan | Marvel Super Heroes |

Align column edges and row tops. Equalize the row gaps: the gap above the bottom
row is visibly smaller than the one above the middle row. Balance top/bottom
margins and center the overall grid horizontally.

## Sheet 4 — Brothers' War / Throne of Eldraine Brawl

Keep the existing 2-column × 3-row order:

| Row | Left | Right |
| --- | --- | --- |
| 1 | The Brothers' War / Wilds of Eldraine | Throne of Eldraine Brawl |
| 2 | Secret Lair | Warhammer 40,000 |
| 3 | Turtle Power! | Zendikar Rising / Kamigawa: Neon Dynasty |

Align the top row, where the right image currently starts lower. Straighten the
left column and equalize both vertical gaps in both columns; the right-hand
images currently nearly touch. Center the overall grid horizontally and balance
top/bottom margins. Keep each split-set image intact as a single item.

## Sheet 5 — Modern Horizons 3 / Doctor Who

Use a partial 2-column × 2-row grid, retaining this order:

| Row | Left | Right |
| --- | --- | --- |
| 1 | Modern Horizons 3 | Doctor Who |
| 2 | Commander Masters | Empty |

Align the top two images. Move Commander Masters into exact left-column
alignment beneath Modern Horizons 3. Use the same column positions and row
spacing as sheets 1–4 if actual image dimensions match. Keep the unused lower
portion of the page empty; do not enlarge the three images to fill it or add
duplicate images. Apparent size differences must be checked against the actual
layer dimensions before any resizing is considered.

## Sheet 6 — Eight Commander Anthology Boulder tops

This sheet DOES fit a complete 2-column × 4-row grid. Retain the user's current
grouping, with Anthology I on the left and Anthology II on the right:

| Row | Left: Anthology I | Right: Anthology II |
| --- | --- | --- |
| 1 | Evasive Maneuvers | Breed Lethality |
| 2 | Guided by Nature | Built from Scratch |
| 3 | Heavenly Inferno | Devour for Power |
| 4 | Plunder the Graves | Wade into Battle |

Align all four row tops and both column edges. Equalize the three vertical gaps
and the horizontal gap. Balance outer margins. In particular, the bottom-right
label currently starts lower than the bottom-left. Move each complete label
including artwork, pips, text, and border as one unit; do not redesign it.

## Implementation constraints for these sheets

- Preserve the current images, reading order, page size, resolution, physical
  print size, color profiles, and image pixels. This task is positioning only.
- Confirm actual document resolution, layer dimensions, and grouping before
  assigning exact pixel coordinates. Screenshots show layout but not those data.
- Match sheets by their contents or verified document/layer names, not by an
  assumed tab enumeration. The screenshots do not show document or layer names.
- Do not impose 0.5-inch top/bottom margins on the six-image sheets without
  checking fit. For example, three 2024-pixel-tall images at 600 PPI already use
  10.12 inches of an 11-inch page; only 0.88 inch remains for both outer margins
  and both row gaps. Increasing margins cannot create additional space.
- Choose equal row gaps and balanced margins that fit the unchanged images;
  report an impossible fit rather than silently shrinking them. Verify chosen
  page-edge clearances against the printer's printable area before printing.
- Preserve original files with before/after copies and keep each sheet's moves
  in one undo group. Leave hidden/background layers unchanged.
- The generic script refactor is paused. This plan does not claim that the
  current script has been tailored to these six documents or executed on them.
