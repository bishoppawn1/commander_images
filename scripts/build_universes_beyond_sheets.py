#!/usr/bin/env python3
"""Build dedicated Universes Beyond proof sheets from the current catalog artwork."""
import json
from pathlib import Path
import sys
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from make_print_pdfs import build_page, preflight

ROOT = Path(__file__).resolve().parents[1]
IDS = [
    'warhammer_40000_commander',
    'lord_of_the_rings_tales_of_middle_earth_commander',
    'doctor_who_commander',
    'fallout_commander',
    'final_fantasy_commander',
    'turtle_power_commander',
    'marvel_super_heroes_commander',
]

def main():
    catalog = json.loads((ROOT / 'print_catalog.json').read_text())['fronts']
    by_id = {row['id']: row for row in catalog}
    groups = []
    for ident in IDS:
        row = dict(by_id[ident])
        row['files'] = list(row['files'])
        groups.append(row)
    output = ROOT / 'Print Sheets/Fronts'
    pages = [groups[:6], groups[6:]]
    results = []
    for number, page in zip((10, 11), pages):
        preflight(page, 'fronts')
        results.append(build_page('fronts', page, number, output))
    (output / '.records/LATEST_fronts_universes_beyond.json').write_text(json.dumps(results, indent=2) + '\n')

if __name__ == '__main__':
    main()
