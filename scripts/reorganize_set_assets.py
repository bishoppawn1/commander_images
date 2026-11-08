#!/usr/bin/env python3
"""One-time, lossless migration to set/{Tops,Fronts}; records old/new paths."""
import hashlib
import json
import os
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
FRONTS = {
    'adventures_forgotten_realms_commander': 'adventures_in_the_forgotten_realms',
    'commander_2020_ikoria': 'commander_2020',
    'lord_of_the_rings_tales_of_middle_earth_commander': 'lord_of_the_rings',
    'turtle_power_commander': 'teenage_mutant_ninja_turtles',
}
PAIRS = {
    'aetherdrift_edge_of_eternities': ('aetherdrift', 'edge_of_eternities'),
    'commander_2013_commander_2016': ('commander_2013', 'commander_2016'),
    'kamigawa_neon_dynasty_brothers_war': ('kamigawa_neon_dynasty', 'brothers_war'),
    'phyrexia_all_will_be_one_wilds_of_eldraine': ('phyrexia_all_will_be_one', 'wilds_of_eldraine'),
    'turtle_power_reality_fracture': ('teenage_mutant_ninja_turtles', 'reality_fracture'),
    'zendikar_rising_commander_legends': ('zendikar_rising', 'commander_legends'),
}

def migrate():
    record = ROOT / 'images/asset_path_migration_2026_11_08.json'
    if record.exists():
        raise SystemExit('Migration already recorded; refusing to move assets twice.')
    mapping = {}
    for p in sorted((ROOT / 'images').iterdir()):
        if not p.is_dir() or p.name.startswith('.'):
            continue
        name = p.name
        if name == 'commander_anthology_deck_box_labels':
            target = 'commander_anthology_i/Tops'
        elif name.endswith('_boulder_deck_box_labels'):
            target = name.removesuffix('_boulder_deck_box_labels') + '/Tops'
        elif name in PAIRS:
            target = PAIRS[name][0] + '/Fronts/' + name
        else:
            target = FRONTS.get(name, name.removesuffix('_commander')) + '/Fronts'
            if name == 'starter_commander':
                target = 'starter_commander'
        mapping['images/' + name] = 'images/' + target
    before = {}
    for old in mapping:
        for p in (ROOT / old).rglob('*'):
            if p.is_file():
                before[str(p.relative_to(ROOT))] = hashlib.sha256(p.read_bytes()).hexdigest()
    staging = ROOT / 'tmp/reorganization_2026_11_08/assets'
    staging.mkdir(parents=True)
    for old in mapping:
        (ROOT / old).rename(staging / Path(old).name)
    for old, new in sorted(mapping.items(), key=lambda x: len(x[1])):
        (ROOT / new).parent.mkdir(parents=True, exist_ok=True)
        (staging / Path(old).name).rename(ROOT / new)
    def mapped(path):
        for old, new in mapping.items():
            if path == old or path.startswith(old + '/'):
                return new + path[len(old):]
        return path
    for old, digest in before.items():
        assert hashlib.sha256((ROOT / mapped(old)).read_bytes()).hexdigest() == digest, old
    # Rewrite path references in production code, metadata, reviews and documents.
    # Binary artwork is never modified. Exclude scratch and version-control data.
    changed = []
    for base, dirs, files in os.walk(ROOT):
        dirs[:] = [d for d in dirs if d not in {'.git', 'tmp', '__pycache__'}]
        for name in files:
            p = Path(base) / name
            if p.resolve() == Path(__file__).resolve():
                continue
            if p.suffix.lower() not in {'.md','.txt','.json','.html','.py','.swift','.sh','.csv','.tsv','.yaml','.yml'}:
                continue
            try:
                text = p.read_text()
            except UnicodeDecodeError:
                continue
            original = text
            # Single simultaneous replacement prevents canonical names matching twice.
            pattern = '|'.join(re.escape(x) for x in sorted(mapping, key=len, reverse=True))
            text = re.sub(r'(?<![A-Za-z0-9_])(?:' + pattern + r')(?=[/"\x27`\s)])',
                          lambda m: mapping[m.group()], text)
            if text != original:
                p.write_text(text)
                changed.append(str(p.relative_to(ROOT)))
    links = {}
    for pair, (owner, other) in PAIRS.items():
        link = ROOT / 'images' / other / 'Fronts' / pair
        link.parent.mkdir(parents=True, exist_ok=True)
        target = ROOT / 'images' / owner / 'Fronts' / pair
        link.symlink_to(os.path.relpath(target, link.parent), target_is_directory=True)
        links[str(link.relative_to(ROOT))] = os.readlink(link)
    link = ROOT / 'images/commander_anthology_ii/Tops'
    link.symlink_to('../commander_anthology_i/Tops', target_is_directory=True)
    links[str(link.relative_to(ROOT))] = os.readlink(link)
    record.write_text(json.dumps({'directories': mapping, 'symlinks': links,
        'verified_files': len(before), 'rewritten_files': changed}, indent=2) + '\n')
    (ROOT / 'tmp/reorganization_2026_11_08/asset_hashes.before.json').write_text(json.dumps(before))
    print(f'Moved {len(mapping)} directories; verified {len(before)} files; rewrote {len(changed)} references; created {len(links)} shared links.')

if __name__ == '__main__':
    migrate()
