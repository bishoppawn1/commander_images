#!/usr/bin/env python3
"""Verify the five approved framing corrections and build old/new links."""
import base64
import hashlib
import html
import io
import json
from pathlib import Path
import sys

from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from make_print_pdfs import load_groups

AUDIT = ROOT / 'images/boulder_upper_third_audit_2026_11_08.json'
OUT = ROOT / 'reviews/boulder_upper_third_2026_11_08'


def sha(path):
    return hashlib.sha256((ROOT / path).read_bytes()).hexdigest()


def picture(path):
    with Image.open(ROOT / path) as source:
        im = source.convert('RGB')
        im.thumbnail((660, 560))
        buffer = io.BytesIO()
        im.save(buffer, format='JPEG', quality=90)
    return (f'<a href="../../{html.escape(path, quote=True)}">'
            '<img alt="Open full-resolution PNG" src="data:image/jpeg;base64,'
            + base64.b64encode(buffer.getvalue()).decode() + '"></a>')


def main():
    rows = json.loads(AUDIT.read_text())
    previous = json.loads((ROOT / 'images/boulder_readability_audit_2026_11_08.json').read_text())
    old_hashes = {r['after']: r['sha256_after'] for r in previous}
    for path, expected in old_hashes.items():
        assert sha(path) == expected, f'Previously approved image changed: {path}'
    selected = [p for group in load_groups('tops') for p in group['files']]
    changed = {r['after'] for r in rows}
    assert len(selected) == 114
    assert changed.issubset(selected)
    unchanged = [p for p in selected if p not in changed]
    assert len(unchanged) == 109
    for path in unchanged:
        assert path in old_hashes and sha(path) == old_hashes[path], path
    OUT.mkdir(parents=True, exist_ok=True)
    parts = ['''<!doctype html><html lang="en"><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Approved upward framing corrections</title>
<style>body{font:16px/1.5 system-ui;background:#f3f2ee;color:#252a26;margin:0}main{max-width:1500px;margin:auto;padding:28px}table{border-collapse:collapse;width:100%;background:white}td,th{padding:14px;border-bottom:1px solid #ddd;text-align:left;vertical-align:top}td:first-child{width:20%}td:not(:first-child){width:40%}img{width:100%;display:block}th{background:#263c32;color:white}a{color:#165a42}p{max-width:1050px}</style>
<main><h1>Five approved upward framing corrections</h1>
<p>Retained artwork, uniformly scaled and cropped to raise the focal subjects. Mutant Menace receives only a slight lift. No new artwork was generated; text, mana and borders retain their positions. Click an image for its full-resolution PNG.</p>
<p>All earlier images are preserved. The other 109 top placements are byte-for-byte unchanged, including the approved wings, large-scene and subjective exceptions. All 10 top and 7 front PDFs are rebuilt from the current catalog.</p>
<p><a href="../../Print%20Sheets/INDEX.md">Current print sheets and PNG previews</a></p>
<table><thead><tr><th>Label / adjustment</th><th>Before</th><th>After</th></tr></thead><tbody>''']
    md = ['# Five approved upward framing corrections\n',
          'Retained artwork, uniformly scaled and cropped upward. No new art generated. All earlier images and the other 109 placements remain unchanged.\n',
          '| Label | Old image | New image |', '| --- | --- | --- |']
    order = ['exquisite_invention', 'animated_army', 'wakanda_forever', 'mutant_menace', 'devour_for_power']
    rows.sort(key=lambda r: order.index(r['slug']))
    for r in rows:
        assert sha(r['before']) == r['sha256_before']
        with Image.open(ROOT / r['after']) as im:
            assert im.size == (3960, 3360)
            assert all(abs(d - 1440) < 1 for d in im.info['dpi'])
            assert im.mode != 'RGBA' or im.getchannel('A').getextrema() == (255, 255)
        r['sha256_after'] = sha(r['after'])
        r['change'] = ('Slight upward reframe.' if r['slug'] == 'mutant_menace'
                       else 'Upward reframe with full-bleed retained artwork.')
        r['method'] = 'Uniform art-only scale 1/(1-artTopCrop), bottom anchored; overlays unchanged.'
        r['qa'] = 'Final composite inspected; full-size dimensions, DPI and opacity validated; previous file hash unchanged.'
        name = r['name'].title()
        parts.append(f'<tr><td><strong>{html.escape(name)}</strong><p>{r["change"]}</p>'
                     f'<a href="../../{r["before"]}">Old image</a> · <a href="../../{r["after"]}">New image</a></td>'
                     f'<td>{picture(r["before"])}</td><td>{picture(r["after"])}</td></tr>')
        md.append(f'| {name} | [Old](../../{r["before"]}) | [New](../../{r["after"]}) |')
    parts.append('</tbody></table></main></html>')
    (OUT / 'index.html').write_text(''.join(parts))
    (OUT / 'IMAGE_LINKS.md').write_text('\n'.join(md) + '\n')
    AUDIT.write_text(json.dumps(rows, indent=2) + '\n')
    print('Verified five corrections, all prior images preserved, 109 other placements unchanged.')


if __name__ == '__main__':
    main()
