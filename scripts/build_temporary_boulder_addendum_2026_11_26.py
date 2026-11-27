#!/usr/bin/env python3
"""Build the requested eight-top temporary addendum without changing normal sheets."""
import json
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from make_print_pdfs import build_page, layout, load_groups, pack_groups, preflight, receipt_path

OUT = ROOT / 'Print Sheets/Boulder Tops/Temporary Addenda/2026-11-26'
SELECTION = [
    ('commander_2013', 'Commander 2013', 2),
    ('aetherdrift', 'Aetherdrift', 2),
    ('edge_of_eternities', 'Edge of Eternities', 2),
    ('reality_fracture', 'Reality Fracture', 1),
    ('teenage_mutant_ninja_turtles', 'Teenage Mutant Ninja Turtles: Turtle Power', 1),
]


def main():
    catalog = {g['id']: g for g in load_groups('tops')}
    groups = [dict(catalog[key]) for key, _, _ in SELECTION]
    counts = [len(g['files']) for g in groups]
    expected = [count for _, _, count in SELECTION]
    if counts != expected or sum(counts) != 8:
        raise ValueError(f'Expected 8 tops with set counts {expected}; found {counts} ({sum(counts)} total).')
    assert 'commander_2016' not in {g['id'] for g in groups}
    assert len({f for g in groups for f in g['files']}) == 8
    preflight(groups, 'tops')
    spec = layout('tops')
    pages = pack_groups(groups, spec['columns'] * spec['rows'])
    if len(pages) != 1:
        raise ValueError('The eight selected tops must fit on one sheet.')
    receipts = []
    previews = []
    lines = ['# Temporary Boulder-top addendum — November 26, 2026',
             '', 'All eight requested tops on one US Letter sheet. Print at **Actual Size / 100%**.',
             '', '| Page | Tops | Sets | PDF | Preview |', '| --- | ---: | --- | --- | --- |']
    for number, page in enumerate(pages, 1):
        named_page = [dict(g) for g in page]
        named_page[0]['name'] = 'Temporary_Addendum_2026_11_26_' + page[0]['name']
        receipt = build_page('tops', named_page, number, OUT)
        receipts.append(receipt)
        preview = OUT / f'Temporary_Addendum_2026-11-26_Boulder_Tops_{number:02d}_preview.png'
        subprocess.run(['pdftoppm', '-scale-to', '1400', '-singlefile', '-png',
                        str(OUT / receipt['pdf']), str(preview.with_suffix(''))], check=True)
        previews.append(preview)
        sets = ', '.join(name for key, name, _ in SELECTION if any(g['id'] == key for g in page))
        lines.append(f'| {number} | {receipt["count"]} | {sets} | [Print](<{receipt["pdf"]}>) | [PNG]({preview.name}) |')
    (OUT / '.records/LATEST_temporary_addendum.json').write_text(json.dumps(receipts, indent=2)+'\n')
    (OUT / 'README.md').write_text('\n'.join(lines)+'\n')
    for pdf in OUT.glob('*.pdf'):
        if pdf.name not in {r['pdf'] for r in receipts}:
            pdf.unlink()
            receipt_path(pdf).unlink(missing_ok=True)
    for preview in OUT.glob('Temporary_Addendum_2026-11-26_Boulder_Tops_*.png'):
        if preview not in previews:
            preview.unlink()


if __name__ == '__main__':
    main()
