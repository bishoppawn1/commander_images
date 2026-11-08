# Marvel top-label portrait corrections, 2026-11-08

The original Avengers group image already clips Hulk at its upper source boundary. A requested ImageGen extension failed moderation and produced no usable output. No generated artwork was used in these corrections.

The current Avengers label instead uses published alternate art of the same commander, Captain America, Team Leader, by Gal Or (Marvel Legends Series Inserts, LMAR 6). Retained image: references/captain_america_lmar6_art_crop.jpg, 626 x 457. Source: https://api.scryfall.com/cards/lmar/6 and https://scryfall.com/card/lmar/6/captain-america-team-leader . Full metadata and exact image URL are in references/captain_america_lmar6.json. The original Mark Spears MSC 5 image and metadata are preserved; the original finished label remains available.

The shared label builder removes a 2% top strip containing only the card-frame fragment, preserves the complete Captain America head, and lays out the art below top-centered mana symbols with the title below his chin. Black Panther, Mister Fantastic and Doctor Doom retain their previous source artwork with deterministic vertical placement changes. See ../label_manifest.json and ../../boulder_top_audit_2026_11_08.json.


## Readability/composition correction — 2026-11-08

the_fantastic_four: built-in ImageGen edit using `images/marvel_super_heroes/Tops/src/the_fantastic_four_outpaint_reference_v3.png`. Prompt retained in `../prompts/the_fantastic_four_composition_v4.txt`; unmodified generated output `the_fantastic_four_composition_v4.png`. Used as full art in the manifest, with native mana, typography, frame and shading. Older sources and outputs preserved.

Avengers Assemble: extension request 853456ad-9804-448f-9b6a-4dbc026cf717 was rejected at output stage (category other). No image was returned. Native aspect-fill of the retained LMAR 6 source, with the existing 2% frame-fragment crop and no added vertical inset, now fills the label with its full head clear of the mana row. Wakanda Forever and Doom Prevails remove 3% and 2.5% source-top frame fragments respectively; their prior art and extensions remain.
