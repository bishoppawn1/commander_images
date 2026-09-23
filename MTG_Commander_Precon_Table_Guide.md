# MTG Commander Precon Collection Table – Process and Structure Guide

## Purpose of this file

This file explains how the Commander precon collection table was built, what each column means, what formatting decisions were made, and what ownership information was supplied by the user.

It is intended to be copied into another ChatGPT/AI agent so that the agent can continue updating the table without having to reconstruct the process.

---

## 1. Goal of the table

The goal was to create a year-by-year list covering the past 15 calendar years, using **2012 through 2026 inclusive**.

The table tracks Commander preconstructed deck products, plus one Commander-adjacent product the user explicitly wanted included:

- **Throne of Eldraine Brawl** — included even though it is not technically a Commander product.

The table should show:

1. **Year**
2. **Precon / Set**
3. **Do We Have This?**
4. **Decks in Set**
5. **You Have**
6. **Have All?**
7. **Release Date**

---

## 2. Meaning of each column

### Year
The calendar year in which the preconstructed deck product was released.

If a year has multiple products, the year is shown only on the first row for that year and left blank on the following rows.

### Precon / Set
The product or Commander precon release name.

Examples:
- Commander 2017
- Commander Anthology I
- Warhammer 40,000 Commander
- Fallout Commander
- The Lord of the Rings: Tales of Middle-earth Commander

### Do We Have This?
This is the most important ownership column.

Rules:
- **✅ Yes** = the user owns at least one deck from this product.
- **❌ No** = the user owns zero decks from this product.
- **—** = not applicable.

This column comes before “Decks in Set” because the user said ownership status is the most important information.

### Decks in Set
The total number of preconstructed decks included in that release.

Examples:
- Commander 2013 = 5 decks
- Commander 2017 = 4 decks
- Zendikar Rising Commander = 2 decks

### You Have
Shows how many decks from that release the user owns.

Format:
- `4/4`
- `2/5`
- `0/2`

### Have All?
Shows whether the user owns the complete set.

Rules:
- **✅ Yes** = user owns every deck in that release.
- **❌ No** = user is missing at least one deck.
- If the user owns none of a release, this still says **❌ No**.
- **—** = not applicable.

Important distinction:
- Commander 2013 = Do We Have This? **Yes**, Have All? **No**
- Commander 2014 = Do We Have This? **No**, Have All? **No**

### Release Date
The release date for the physical preconstructed deck product.

---

## 3. Date range

The table uses:

**2012 through 2026 inclusive**

This is 15 calendar years.

Notes:
- Commander 2011 is outside this range.
- 2012 did not have a normal Commander preconstructed deck release, so the table includes:
  - “No Commander precon release”

---

## 4. Ownership information supplied by the user

The user explicitly said they own the following:

- Commander Anthology I — **4/4**
- Commander Anthology II — **4/4**
- Commander 2013 — **2/5**
- Commander 2016 — **2/5**
- Commander 2017 — **4/4**
- Commander 2018 — **4/4**
- Commander 2019 — **4/4**
- Throne of Eldraine Brawl — **4/4**
- Ikoria: Lair of Behemoths / Commander 2020 — **5/5**
- Zendikar Rising Commander — **2/2**
- Commander Legends — **2/2**
- Strixhaven: School of Mages — **5/5**
- Adventures in the Forgotten Realms Commander — **4/4**
- Kamigawa: Neon Dynasty Commander — **2/2**
- Warhammer 40,000 Commander — **4/4**
- The Brothers' War Commander — **2/2**
- Phyrexia: All Will Be One Commander — **2/2**
- March of the Machine Commander — **5/5**
- The Lord of the Rings: Tales of Middle-earth Commander — **4/4**
- Commander Masters — **4/4**
- Wilds of Eldraine Commander — **2/2**
- Doctor Who Commander — **4/4**
- The Lost Caverns of Ixalan Commander — **4/4**
- Fallout Commander — **4/4**
- Modern Horizons 3 Commander — **4/4**
- Bloomburrow Commander — **4/4**
- FINAL FANTASY Commander — **4/4**
- Teenage Mutant Ninja Turtles Commander — **1/1**
- Marvel Super Heroes Commander — **4/4**

The user owns **partial sets only** for:
- Commander 2013 — 2/5
- Commander 2016 — 2/5

Everything else listed above is complete.

---

## 5. Naming decisions

A few naming clarifications were made:

- “Strixhaven: School of Magic” was corrected to **Strixhaven: School of Mages**.
- “Commander Anthology 1” is displayed as **Commander Anthology I**.
- “Commander Anthology 2” is displayed as **Commander Anthology II**.
- Throne of Eldraine is labeled **Throne of Eldraine Brawl (not Commander)**.
- Ikoria’s decks are shown as **Ikoria: Lair of Behemoths / Commander 2020**.

---

## 6. Formatting process and what was learned

Several formatting approaches were tried.

### Original standard table
The original table was a normal Markdown table.

This was the version the user ultimately preferred visually.

### Attempted year separators
The user wanted the years to be easier to distinguish.

Attempts included:
- Thick white lines
- Blank spacer rows
- HTML tables with custom borders
- Text-based divider rows using characters like `━━━━`

These were rejected because:
- Some versions created two dark lines instead of one.
- Some HTML rendered as raw code and became hard to read.
- Text divider rows looked artificial and cluttered.
- The user preferred the original table rendering.

### Final formatting rule
Use a **normal Markdown table** with no custom HTML and no fake divider rows.

The user specifically preferred the original table appearance.

If a future agent tries to improve year separation, it should avoid:
- raw HTML
- text-made white lines
- doubled separators
- blank divider rows that visibly break the table

The safest default is to preserve the plain Markdown table.

---

## 7. Important update rules for another agent

When the user gives a new ownership update:

1. Find the correct product row.
2. Change **Do We Have This?** to:
   - ✅ Yes if they own at least one deck
   - ❌ No if they own none
3. Update **You Have** to the correct fraction.
4. Change **Have All?** to:
   - ✅ Yes only if numerator = denominator
   - ❌ No otherwise
5. Keep the row bold if the user owns that product, matching the current visual style.
6. Do not remove products the user does not own unless explicitly asked.
7. Keep products grouped chronologically by release date within each year.
8. Keep Throne of Eldraine Brawl included because the user explicitly wants it tracked with the Commander collection.

---

## 8. Current table

| Year | Precon / Set | **Do We Have This?** | Decks in Set | You Have | Have All? | Release Date |
|---|---|:---:|---:|---:|:---:|---|
| **2012** | No Commander precon release | — | — | — | — | — |
| **2013** | **Commander 2013** | **✅ Yes** | **5** | **2/5** | ❌ No | Nov. 1, 2013 |
| **2014** | Commander 2014 | ❌ No | 5 | 0/5 | ❌ No | Nov. 7, 2014 |
| **2015** | Commander 2015 | ❌ No | 5 | 0/5 | ❌ No | Nov. 13, 2015 |
| **2016** | **Commander 2016** | **✅ Yes** | **5** | **2/5** | ❌ No | Nov. 11, 2016 |
| **2017** | **Commander Anthology I** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | June 9, 2017 |
|  | **Commander 2017** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | Aug. 25, 2017 |
| **2018** | **Commander Anthology II** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | June 8, 2018 |
|  | **Commander 2018** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | Aug. 10, 2018 |
| **2019** | **Commander 2019** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | Aug. 23, 2019 |
|  | **Throne of Eldraine Brawl** *(not Commander)* | **✅ Yes** | **4** | **4/4** | **✅ Yes** | Oct. 4, 2019 |
| **2020** | **Ikoria: Lair of Behemoths / Commander 2020** | **✅ Yes** | **5** | **5/5** | **✅ Yes** | May 15, 2020 |
|  | **Zendikar Rising Commander** | **✅ Yes** | **2** | **2/2** | **✅ Yes** | Sept. 25, 2020 |
|  | **Commander Legends** | **✅ Yes** | **2** | **2/2** | **✅ Yes** | Nov. 20, 2020 |
| **2021** | Kaldheim Commander | ❌ No | 2 | 0/2 | ❌ No | Feb. 5, 2021 |
|  | **Strixhaven: School of Mages** | **✅ Yes** | **5** | **5/5** | **✅ Yes** | Apr. 23, 2021 |
|  | **Adventures in the Forgotten Realms Commander** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | July 23, 2021 |
|  | Innistrad: Midnight Hunt Commander | ❌ No | 2 | 0/2 | ❌ No | Sept. 24, 2021 |
|  | Innistrad: Crimson Vow Commander | ❌ No | 2 | 0/2 | ❌ No | Nov. 19, 2021 |
| **2022** | **Kamigawa: Neon Dynasty Commander** | **✅ Yes** | **2** | **2/2** | **✅ Yes** | Feb. 18, 2022 |
|  | Streets of New Capenna Commander | ❌ No | 5 | 0/5 | ❌ No | Apr. 29, 2022 |
|  | Commander Legends: Battle for Baldur's Gate | ❌ No | 4 | 0/4 | ❌ No | June 10, 2022 |
|  | Dominaria United Commander | ❌ No | 2 | 0/2 | ❌ No | Sept. 9, 2022 |
|  | **Warhammer 40,000 Commander** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | Oct. 7, 2022 |
|  | **The Brothers' War Commander** | **✅ Yes** | **2** | **2/2** | **✅ Yes** | Nov. 18, 2022 |
|  | Starter Commander Decks | ❌ No | 5 | 0/5 | ❌ No | Dec. 2, 2022 |
| **2023** | **Phyrexia: All Will Be One Commander** | **✅ Yes** | **2** | **2/2** | **✅ Yes** | Feb. 10, 2023 |
|  | **March of the Machine Commander** | **✅ Yes** | **5** | **5/5** | **✅ Yes** | Apr. 21, 2023 |
|  | **The Lord of the Rings: Tales of Middle-earth Commander** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | June 23, 2023 |
|  | **Commander Masters** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | Aug. 4, 2023 |
|  | **Wilds of Eldraine Commander** | **✅ Yes** | **2** | **2/2** | **✅ Yes** | Sept. 8, 2023 |
|  | **Doctor Who Commander** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | Oct. 13, 2023 |
|  | **The Lost Caverns of Ixalan Commander** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | Nov. 17, 2023 |
| **2024** | Murders at Karlov Manor Commander | ❌ No | 4 | 0/4 | ❌ No | Feb. 9, 2024 |
|  | **Fallout Commander** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | Mar. 8, 2024 |
|  | Outlaws of Thunder Junction Commander | ❌ No | 4 | 0/4 | ❌ No | Apr. 19, 2024 |
|  | **Modern Horizons 3 Commander** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | June 14, 2024 |
|  | **Bloomburrow Commander** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | Aug. 2, 2024 |
|  | Duskmourn: House of Horror Commander | ❌ No | 4 | 0/4 | ❌ No | Sept. 27, 2024 |
| **2025** | Aetherdrift Commander | ❌ No | 2 | 0/2 | ❌ No | Feb. 14, 2025 |
|  | Tarkir: Dragonstorm Commander | ❌ No | 5 | 0/5 | ❌ No | Apr. 11, 2025 |
|  | **FINAL FANTASY Commander** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | June 13, 2025 |
|  | Edge of Eternities Commander | ❌ No | 2 | 0/2 | ❌ No | Aug. 1, 2025 |
| **2026** | Lorwyn Eclipsed Commander | ❌ No | 2 | 0/2 | ❌ No | Jan. 23, 2026 |
|  | **Teenage Mutant Ninja Turtles Commander** | **✅ Yes** | **1** | **1/1** | **✅ Yes** | Mar. 6, 2026 |
|  | Secrets of Strixhaven Commander | ❌ No | 5 | 0/5 | ❌ No | Apr. 24, 2026 |
|  | **Marvel Super Heroes Commander** | **✅ Yes** | **4** | **4/4** | **✅ Yes** | June 26, 2026 |

---

## 9. Short instruction for another agent

If this file is pasted into another AI conversation, the agent should:

> Continue using the table above as the source of truth for the user's Commander precon collection. Preserve the column order, ownership logic, chronological grouping, and plain Markdown table style. When the user adds or removes decks, update the relevant row without redesigning the table unless the user specifically asks for a formatting change.
