#!/usr/bin/env python3
"""Render all current top manifests with the shared, source-faithful compositor."""
import argparse
import json
import os
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dpi', type=int, default=1440)
    parser.add_argument('--output', type=Path, help='Preview destination, separate from final assets')
    args = parser.parse_args()
    manifests = [p for p in (ROOT/'images').glob('*/Tops/label_manifest.json') if not p.parent.is_symlink()]
    # Shared Anthology output must exist before Commander 2016 reuses it.
    manifests.sort(key=lambda p: (p.parent.parent.name != 'commander_anthology_i', str(p)))
    with tempfile.TemporaryDirectory(prefix='boulder-builder-') as scratch:
        executable = Path(scratch)/'builder'
        subprocess.run(['swiftc', str(ROOT/'images/build_boulder_labels.swift'), '-o', str(executable)], check=True)
        for i, manifest in enumerate(manifests):
            target = manifest.parent
            source = manifest
            if args.output:
                target = args.output/manifest.parent.parent.name
                data = json.loads(manifest.read_text())
                for label in data['labels']:
                    label.pop('reuseRenderedPath', None)
                source = Path(scratch)/f'{i}.json'
                source.write_text(json.dumps(data))
            subprocess.run([str(executable), str(ROOT), str(source), str(target)], check=True,
                           env={**os.environ, 'BOULDER_DPI':str(args.dpi), 'BOULDER_SKIP_CONTACT_SHEET':'1'})
    print(f'Rendered {len(manifests)} manifests at {args.dpi} DPI.')

if __name__ == '__main__':
    main()
