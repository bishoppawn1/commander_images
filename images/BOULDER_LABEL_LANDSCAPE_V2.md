# Boulder label landscape v2 correction

## Outcome

The first generated source-art pass contained 72 portrait images. Filling the 3300 × 2800 horizontal label canvas from those sources cropped substantial parts of the subjects and magnified the sources enough to expose grain.

Those 72 paintings were recomposed with built-in OpenAI ImageGen as horizontal 33:28 landscape artwork. Each replacement is stored in the matching release folder under `src/regenerated_art_v2/`. The deterministic renderer automatically prefers a matching v2 file when a manifest still names a `regenerated_art_v1` source. The 23 v1 sources that were already landscape remain unchanged.

Set `BOULDER_ART_SOURCE=v1` when invoking the renderer to bypass that preference and reproduce a retained v1 source deliberately.

The corresponding current labels and contact sheets were rebuilt. Their earlier versions are preserved in each affected release's `archive_v1/` directory.

## Shared ImageGen settings

- Mode: identity-preserve
- Template reference: `/Users/bishophall/.codex/skills/artifact-template-mtg-commander-boulder-deck-label/assets/reference.png`
- Subject reference: the matching v1 painting, used as an identity and scene reference
- Output use: source painting only; mana symbols, rules, title, strategy line, and set name are added deterministically by `build_boulder_labels.swift`

Exact shared prompt:

```text
Use case: identity-preserve
Asset type: newly regenerated source painting for a premium 3300 x 2800 pixel Commander deck-box label
Input images: Image 1 is the exact landscape label composition reference; Image 2 is the existing subject-and-scene painting to recompose.
Primary request: regenerate—not resize, stretch, or merely crop—the same subject, identity, costume, and scene from Image 2 as an exceptionally crisp horizontal 33:28 landscape fantasy painting.
Composition/framing: WIDE HORIZONTAL LANDSCAPE, approximately 6:5, never portrait; reserve the entire top 20% as unobstructed scenery for a centered mana-symbol row; place the subject's head below that clear zone; keep the entire face, head, body, hands, equipment, and defining silhouette inside the central 72%; scenery extends naturally to every edge; reserve a calm darker bottom 24% for later typography.
Lighting/mood: bright print exposure, lifted midtones and shadows, precise edges, smooth tonal gradients.
Style/medium: polished collectible-card realism with clean brushwork and restrained texture.
Constraints: preserve Image 2's subject identity and defining details; no anatomy or head cropped; no text, letters, numbers, logos, symbols, card frame, watermark, or signature.
Avoid: portrait orientation, vertical canvas, halftone, stippling, paper grain, film grain, canvas texture, noisy brush texture, pixels, compression, blur, muddy detail, crushed blacks, plastic 3D rendering, anime styling.
```

## Affected releases

- Adventures in the Forgotten Realms
- Bloomburrow
- The Brothers' War
- Commander 2020
- Commander Legends
- Commander Masters
- Doctor Who
- Fallout
- FINAL FANTASY
- Kamigawa: Neon Dynasty
- The Lord of the Rings
- The Lost Caverns of Ixalan
- March of the Machine
- Modern Horizons 3
- Phyrexia: All Will Be One
- Strixhaven
- Teenage Mutant Ninja Turtles
- Throne of Eldraine Brawl
- Warhammer 40,000
- Wilds of Eldraine
- Zendikar Rising

## Verification

- Current unique label designs: 99
- Current physical folder-level label files: 100, including the reused Breed Lethality copy in Commander 2016
- Final labels with incorrect dimensions or density: 0
- Final format: 3300 × 2800 pixels, 1200 DPI on both axes
- Portrait v1 sources: 72
- Matching v2 replacements: 72
- Missing replacements: 0
- Non-landscape v2 sources: 0
- Preserved prior labels: 72 across 21 `archive_v1/` directories
- Visual QA: all affected release contact sheets plus full-resolution spot checks
