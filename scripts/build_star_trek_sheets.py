#!/usr/bin/env python3
"""Build only Star Trek fronts 9 and Boulder tops 11; preserve earlier sheets."""
import json
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from make_print_pdfs import ROOT, OUTPUT_SUBDIRS, build_page, load_groups, preflight


def main():
    for kind, group_id in (("fronts", "star_trek_commander"), ("tops", "star_trek")):
        groups = load_groups(kind, ids=[group_id])
        preflight(groups, kind)
        output = ROOT / "Print Sheets" / OUTPUT_SUBDIRS[kind]
        # This isolated export has one release on one explicitly numbered page.
        number = groups[0]["sheet_number"]
        results = [build_page(kind, groups, number, output)]
        records = output / ".records"
        records.mkdir(parents=True, exist_ok=True)
        (records / f"LATEST_{kind}_star_trek.json").write_text(json.dumps(results, indent=2) + "\n")
        index = records / f"LATEST_{kind}_all.json"
        existing = json.loads(index.read_text()) if index.exists() else []
        existing = [r for r in existing if not any(label["group"] == group_id for label in r["labels"])]
        index.write_text(json.dumps(existing + results, indent=2) + "\n")


if __name__ == "__main__":
    main()
