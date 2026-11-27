# Label names and print filenames

## What goes on a Boulder top

Read the three lines from top to bottom as the **deck name**, **what the deck does**, and **the set it belongs to**. For example, World Shaper uses **WORLD SHAPER**, **SACRIFICE LANDS • SHAPE WORLDS**, then the **Edge of Eternities** wordmark. Take the exact spelling and punctuation from the set’s top manifest. Its fields are `deckName`, `goalDescription`, and `setName`. [World Shaper manifest](images/edge_of_eternities/Tops/label_manifest.json)

Use the distinctive English set logo in the footer when one exists. Match the release and volume, including Commander Anthology I versus Volume II. A set such as Commander 2013 keeps its plain year label. Omit surrounding Magic, Universes Beyond, and generic Commander branding when the set wordmark already identifies the product.

| Example | Approved treatment |
| --- | --- |
| Aetherdrift | Use the Aetherdrift logo. Fit the visible letters to the available space. Excess padding and faint glow can make the name print too small. |
| Edge of Eternities | Place “Edge Of” beside “Eternities” in reading order. Use the spare width to make both parts legible. |
| Turtle Power! | Keep the exclamation point in the deck title. Set “Teenage Mutant Ninja” beside “Turtles” in the footer, using the green wordmark from the official deck packaging. |

Keep each word group’s proportions and leave clearance around the inner frame and separator. Inspect the final label at its printed size. Put a feathered black shade behind the lower text. Apply an extra half pass of that shade behind the strategy line and two extra passes behind the set line. Keep the lettering crisp above the shade. The builder uses `images/set_wordmarks/logos.json` for exact set-name matches and `sources.json` in the same folder for provenance. [Boulder composition instructions](images/BOULDER_TOP_COMPOSITION.md)

## What goes on a drawer front

- Move a top-mounted set title, such as Strixhaven’s, to the bottom and move the art up into the freed space. Keep approved titles already in the middle or elsewhere. Remove redundant top branding, including the Universes Beyond banner.
- Center the Commander 2017, 2018, and 2019 titles between portrait rows using the same position, backing, and outline. The Commander 2013 / 2016 split uses matching centered plaques with COMMANDER above each year. Keep both titles clear of faces. The Atraxa deck on the 2016 side is **Breed Lethality**.
- Align the Kamigawa: Neon Dynasty and The Brothers’ War titles at the same level on their split front. On Ikoria, group **Commander 2020** with **Ikoria: Lair of Behemoths** at the bottom. Commander 2020 identifies the annual five-deck product.
- On the Turtle Power! / Reality Fracture split front, the **TURTLE POWER!** deck title uses white lettering with its orange outline. The green packaging wordmark belongs in the Boulder top’s set footer.

## How to find the right file

| File | Location and naming |
| --- | --- |
| Set assets | Use `images/<set>/Tops/` and `images/<set>/Fronts/`. Store shared artwork or labels once and use a relative symlink from the other set. Keep source art, logos, prompts, and build files. |
| Boulder top PNG | The set’s `Tops/label_manifest.json` supplies `outputStem`, falling back to `slug`. The print suffix is `_boulder_top_label_tall_3960x3360_1440dpi.png`. For example, the logo edition of World Shaper uses `world_shaper_set_logo_v7_boulder_top_label_tall_3960x3360_1440dpi.png`. |
| Drawer front PNG | Take the exact file from the front entry in the print catalog. The print filename ends in `_4138x4858_1440dpi_black_margin_1_8in.png`. Keep the corresponding build master. |
| Print PDF | Use `Print Sheets/Boulder Tops/` or `Print Sheets/Fronts/`. The builder names each PDF with its sheet number, release groups, `1440dpi`, and a ten-character build signature. Top-sheet filenames also include `Boulder_Tops`. |
| Temporary addendum | Keep the requested eight-top addendum under `Print Sheets/Boulder Tops/Temporary Addenda/2026-11-26/`, with its dated selection and receipt. It contains Commander 2013, Aetherdrift, Edge of Eternities, Reality Fracture, and Turtle Power. |

Use the catalog, active manifests, and latest sheet receipts to resolve the current filenames. After a replacement passes verification, retire superseded generated PNGs and PDFs. [Print catalog](print_catalog.json) · [Current print sheet index](Print%20Sheets/INDEX.md)
