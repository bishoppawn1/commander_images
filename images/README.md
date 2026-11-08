# Set assets

Each set has one directory containing `Tops/` and `Fronts/` where applicable. Finished PNGs live inside the relevant format directory; `src/` holds original sources and generated art, and `prompts/` holds generation briefs.

For example:

```text
star_trek/
  Tops/label_manifest.json
  Tops/*_readability_v4_boulder_top_label_tall_3960x3360_1440dpi.png
  Tops/src/
  Tops/prompts/
  Fronts/*_4138x4858_1440dpi_black_margin_1_8in.png
  Fronts/src/
  Fronts/prompts/
```

Paired fronts belong to the earlier set's `Fronts/<pair>/`, with a relative symlink from the other set. Both Anthology volumes use the shared `commander_anthology_i/Tops/` collection. Commander 2016 links to the shared current Breed Lethality top.

`../print_catalog.json` selects current printable assets. Older PNG versions remain available for comparison. Cross-set builders and audits stay at this level or in `../scripts/`; multi-set PDFs remain in `../Print Sheets/`.

- [Current old/new gallery](../reviews/boulder_readability_2026_11_08/index.html)
- [Old/new image links](../reviews/boulder_readability_2026_11_08/IMAGE_LINKS.md)
- [Composition and lighting directions](BOULDER_TOP_COMPOSITION.md)
- [Old-to-new directory mapping](asset_path_migration_2026_11_08.json)

Rebuild tops with `python scripts/build_boulder_collection.py` from the project root. Rebuild and replace the compact PDF collection with `python make_print_pdfs.py --kind both --replace-all`.
