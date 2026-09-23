#!/usr/bin/env python3
"""Build current correction reprints, filling existing addenda before new pages."""
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from make_print_pdfs import build_page, load_groups, preflight

SHEETS = {
    7: [
        'adventures_forgotten_realms_commander',
        'warhammer_40000_commander',
        'commander_2020_ikoria',
        'throne_of_eldraine_brawl',
        'zendikar_rising_commander_legends',
        'kamigawa_neon_dynasty_brothers_war',
    ],
    8: [
        'commander_2013_commander_2016',
        'commander_2017',
        'commander_2018',
        'commander_2019',
        'march_of_the_machine_commander',
        'lord_of_the_rings_tales_of_middle_earth_commander',
    ],
    9: [
        'commander_2020_ikoria',
    ],
}


def main(numbers=None):
    numbers = list(SHEETS) if numbers is None else list(numbers)
    ids = [key for number in numbers for key in SHEETS[number]]
    selected = {g['id']: g for g in load_groups('fronts', ids=ids)}
    pages = []
    for number in numbers:
        groups = [dict(selected[key]) for key in SHEETS[number]]
        groups[0]['name'] = 'Addendum_' + groups[0]['name']
        preflight(groups, 'fronts')
        pages.append((number, groups))
    output = ROOT / 'Print Sheets/Fronts'
    results = []
    for number, groups in pages:
        result = build_page('fronts', groups, number, output)
        (output / f'.records/LATEST_fronts_addendum_{number:02d}.json').write_text(
            json.dumps([result], indent=2) + '\n')
        results.append(result)
    indices = [output / f'.records/LATEST_fronts_addendum_{n:02d}.json' for n in SHEETS]
    if all(path.exists() for path in indices):
        # A sheet-7-only rebuild must refresh the combined index as well.
        results = [json.loads(path.read_text())[0] for path in indices]
        (output / '.records/LATEST_fronts_addenda.json').write_text(
            json.dumps(results, indent=2) + '\n')


if __name__ == '__main__':
    main()
