# Commander 2016 — Invent Superiority / Breya target v1 prompt

Generation mode: built-in OpenAI ImageGen, using two retained official Wizards references. Typography is added deterministically after generation so the required drawer-identification text is exact and print-crisp.

```text
Use case: stylized-concept
Asset type: premium print-ready removable-drawer face artwork, final physical size 3 × 3.5 inches
Primary request: Recompose and extend the official Commander 2016 Breya artwork into a visually full 6:7 portrait cover dedicated only to the owned Invent Superiority deck. Preserve Breya, Etherium Shaper as the sole heroic commander and the unmistakable visual identity of her four-color artifact deck.
Input images: Image 1: edit target and primary official art reference—Breya, Etherium Shaper by Clint Cearley; Image 2: official Commander 2016 Breya card reference—identity, costume, etherium filigree, color identity, thopters, and 2016 product-era reference.
Scene/backdrop: a full-bleed Esper artificer sanctum built from dark metallic arches, intricate silver etherium filigree, glowing conduits, and layered storm energy. Extend the official art naturally above and below; fill every edge and corner with coherent artifice, atmosphere, and controlled energy rather than blank space.
Subject: exactly one Breya, Etherium Shaper, recognizable from both official references: pale lavender-gray skin, long white hair, dark lips, luminous magenta eyes, ornate black-and-silver etherium body filigree, and a confident forward gaze. Surround her with several small white-and-gold thopters at different depths, but no other legendary characters.
Style/medium: premium painterly Magic: The Gathering fantasy illustration faithful to Clint Cearley's official Breya artwork; crisp intricate metalwork, cinematic depth, sophisticated rather than generic sci-fi.
Composition/framing: exact 6:7 portrait aspect ratio. Breya is large, centered, and shown from head through upper legs; her face sits below the top title zone, her etherium torso remains clear, and her spell hand projects magenta energy. A richly detailed but relatively low-contrast dark-metal arch and storm texture occupies the top 22% so deterministic title lettering can remain unobstructed. Keep the subject and thopters safely inset while artwork bleeds fully to all edges. Reserve the lower-right 350 × 350 pixel-equivalent area from critical facial or hand detail for the later standard count seal; keep that area visually full with noncritical machinery and energy.
Lighting/mood: magenta carmot lightning from Breya's raised hand opposed by cyan-blue aether conduits, cool silver highlights, deep blue-black shadows, commanding and inventive.
Color palette: blackened steel, silver, cool blue, cyan, magenta, pale ivory, restrained antique gold, and small red accents; no green-dominant treatment.
Text: no generated text. No letters, numerals, glyphs, symbols, signature, or watermark anywhere.
Constraints: preserve Breya's identity and distinctive etherium design; one Breya only; no other Commander 2016 face commanders; no Atraxa, Saskia, Yidris, Kynaios, or Tiro; no repeated subject; no product box; no card frame; no logos; no generated letters, numerals, glyphs, signature, or watermark; no large empty, white, flat, or low-information areas; no blank corners; no cropped face; no malformed hands; no incoherent filigree crossing the face.
Avoid: generic robot woman, modern technology, smooth plastic armor, cluttered character montage, anatomy errors, flat black voids, featureless smoke, washed-out energy, tiny central subject, or decorative elements that compete with Breya's face.
```

Post-production typography and target spec:

- Exact dominant text: `COMMANDER 2016`, presented on one centered line in antique-gold Copperplate Bold with a dark outline and shadow.
- `COMMANDER` spans approximately 88–92% of the 1800-pixel canvas width and remains within a 5% print-safe inset.
- Exact secondary deck label: `INVENT SUPERIORITY`, smaller and lower-left, used only to identify the owned deck.
- Final unnumbered target: 1800 × 2100 PNG, exact 6:7, sRGB, 600-DPI metadata.
- Counted sibling: run `scripts/apply_deck_count.swift` with marker spec `1:1800`; do not overwrite the base target.
