#!/usr/bin/env python3
"""Rebuild audited background extensions without touching satisfactory artwork."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from make_print_pdfs import ROOT, build_page, load_groups, preflight, receipt_path, main as refresh_pdfs

AUDIT = ROOT / "images/boulder_background_audit_2026_11_08.json"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    rows = json.loads(AUDIT.read_text())
    fixes = [r for r in rows if r["status"] == "recreated"]
    selections = {}
    for row in fixes:
        selections.setdefault(row["manifest"], []).append(row["slug"])
    if "--pdfs-only" not in sys.argv:
        with tempfile.TemporaryDirectory(prefix="boulder-background-") as temporary:
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
        if sha(ROOT / row["before"]) != row["sha256_before"]:
            raise ValueError(f"Previous artwork was modified: {row['before']}")
    if "--labels-only" in sys.argv:
        return
    refresh_pdfs(["--kind", "both", "--replace-all"])


if __name__ == "__main__":
    main()
