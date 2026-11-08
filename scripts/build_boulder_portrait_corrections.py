#!/usr/bin/env python3
"""Rebuild audited top-label corrections without touching satisfactory artwork."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from make_print_pdfs import ROOT, build_page, load_groups, preflight, receipt_path

AUDIT = ROOT / "images/boulder_top_audit_2026_11_08.json"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    rows = json.loads(AUDIT.read_text())
    fixes = [r for r in rows if r["decision"] == "fix"]
    selections = {}
    for row in fixes:
        selections.setdefault(row["manifest"], []).append(row["slug"])
    with tempfile.TemporaryDirectory(prefix="boulder-portrait-") as temporary:
        for index, (relative, slugs) in enumerate(selections.items()):
            manifest = ROOT / relative
            data = json.loads(manifest.read_text())
            data["labels"] = [label for label in data["labels"] if label["slug"] in slugs]
            subset = Path(temporary) / f"subset_{index}.json"
            subset.write_text(json.dumps(data))
            subprocess.run(["swift", str(ROOT / "images/build_boulder_labels.swift"),
                            str(ROOT), str(subset), str(manifest.parent)], check=True,
                           env={**os.environ, "BOULDER_DPI": "1440", "BOULDER_SKIP_CONTACT_SHEET": "1"})
    for row in rows:
        if sha(ROOT / row["file"]) != row["sha256_before"]:
            raise ValueError(f"Previous artwork was modified: {row['file']}")
    groups = {g["id"]: g for g in load_groups("tops")}
    preflight(list(groups.values()), "tops")
    output = ROOT / "Print Sheets/Boulder Tops"
    records = output / ".records"
    index = records / "LATEST_tops_all.json"
    existing = json.loads(index.read_text())
    old_sources = {r["file"] for r in fixes}
    new_sources = {r["output"] for r in fixes}
    updated, changed = [], []
    archive = output / ".archive/portrait_clearance_2026_11_08"
    for previous in existing:
        if not any(label["source"] in old_sources | new_sources for label in previous["labels"]):
            updated.append(previous)
            continue
        ids = list(dict.fromkeys(label["group"] for label in previous["labels"]))
        page = [groups[group_id] for group_id in ids]
        result = build_page("tops", page, int(previous["pdf"].split("_", 1)[0]), output)
        updated.append(result)
        changed.append(result)
        if previous["pdf"] != result["pdf"]:
            archive.mkdir(parents=True, exist_ok=True)
            old = output / previous["pdf"]
            for source in [old, receipt_path(old)]:
                if source.exists():
                    target = archive / source.name
                    if target.exists():
                        raise FileExistsError(target)
                    source.rename(target)
    index.write_text(json.dumps(updated, indent=2) + "\n")
    (records / "LATEST_tops_portrait_corrections.json").write_text(json.dumps(changed, indent=2) + "\n")
    # Keep batch shortcuts pointing to the current editions too.
    by_number = {r["pdf"].split("_", 1)[0]: r for r in updated}
    for name in ["LATEST_tops_star_trek.json", "LATEST_tops_additions_2026_10_05.json"]:
        p = records / name
        if p.exists():
            old = json.loads(p.read_text())
            p.write_text(json.dumps([by_number[r["pdf"].split("_", 1)[0]] for r in old], indent=2) + "\n")
    print(f"Verified {len(rows)} placements; corrected {len(fixes)}; preserved {len(rows)-len(fixes)}.")


if __name__ == "__main__":
    main()
