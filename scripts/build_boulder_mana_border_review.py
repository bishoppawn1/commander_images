#!/usr/bin/env python3
"""Verify that only the colored frames changed and write old/new inspection links."""
import base64
import hashlib
import html
import io
import json
from pathlib import Path
import sys

from PIL import Image, ImageChops

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from make_print_pdfs import load_groups

AUDIT = ROOT / 'images/boulder_mana_border_audit_2026_11_08.json'
OUT = ROOT / 'reviews/boulder_mana_borders_2026_11_08'


def sha(path):
    return hashlib.sha256((ROOT / path).read_bytes()).hexdigest()


def picture(path):
    with Image.open(ROOT / path) as source:
        im = source.convert('RGB')
        im.thumbnail((480, 408))
        buffer = io.BytesIO()
        im.save(buffer, format='JPEG', quality=88)
    return (f'<a href="../../{html.escape(path, quote=True)}">'
            '<img loading="lazy" alt="Open full-resolution PNG" src="data:image/jpeg;base64,'
            + base64.b64encode(buffer.getvalue()).decode() + '"></a>')


def verify_frame_only(row):
    assert sha(row['before']) == row['sha256_before'], row['before']
    with Image.open(ROOT / row['before']) as old, Image.open(ROOT / row['after']) as new:
        assert old.size == new.size == (3960, 3360)
        assert all(abs(d - 1440) < 0.1 for d in new.info['dpi'])
        assert new.mode != 'RGBA' or new.getchannel('A').getextrema() == (255, 255)
        diff = ImageChops.difference(old.convert('RGB'), new.convert('RGB'))
        assert diff.getbbox() is not None, f'Frame did not change: {row["after"]}'
        # At 1440 DPI the two colored strokes lie within this narrow frame.
        # Everything inside it and outside it must remain pixel-identical.
        width, height = new.size
        unchanged_regions = [(120, 120, width-120, height-120),
                             (0, 0, width, 63), (0, height-63, width, height),
                             (0, 0, 63, height), (width-63, 0, width, height)]
        for region in unchanged_regions:
            assert diff.crop(region).getbbox() is None, f'Change outside frame: {row["after"]}: {region}'
    row['sha256_after'] = sha(row['after'])
    row['qa'] = 'Original preserved; artwork, text, mana and black outer edge pixel-identical; only colored frame region differs. Dimensions, DPI and opacity checked.'


def main():
    rows = json.loads(AUDIT.read_text())
    selected = [p for group in load_groups('tops') for p in group['files']]
    assert len(rows) == len(selected) == 114
    assert {r['after'] for r in rows} == set(selected)
    OUT.mkdir(parents=True, exist_ok=True)
    parts = ['''<!doctype html><html lang="en"><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Mana-color borders: before and after</title>
<style>body{font:16px/1.5 system-ui;background:#f3f2ee;color:#252a26;margin:0}main{max-width:1400px;margin:auto;padding:28px}table{border-collapse:collapse;width:100%;background:white}td,th{padding:14px;border-bottom:1px solid #ddd;text-align:left;vertical-align:top}td:first-child{width:22%}td:not(:first-child){width:39%}img{width:100%;display:block}th{background:#263c32;color:white}a{color:#165a42}p{max-width:1050px}input{font:inherit;padding:10px;width:min(480px,90%);margin:10px 0 20px}small{display:block}</style>
<main><h1>Mana-color borders: before and after</h1>
<p>The two colored frame lines now blend gradually through each deck's mana colors. Single-color decks use tonal variations; colorless decks use silver-gray. The black outer cut edge, artwork, head positions, mana symbols, text and printed size are unchanged. No artwork was regenerated.</p>
<p>All 114 placements are included below, with earlier versions retained. Click either image for the full-resolution PNG. The current PDF collection has 10 top sheets and 7 front sheets, with the approved 0.75-point white column separators.</p>
<p><a href="../../Print%20Sheets/INDEX.md">Print sheets and PNG previews</a></p>
<label>Find a deck or set<br><input id="filter" type="search" placeholder="e.g. Exquisite Invention or Star Trek"></label>
<table><thead><tr><th>Deck / mana identity</th><th>Before</th><th>After</th></tr></thead><tbody>''']
    md = ['# Mana-color borders: old and new\n',
          'Only the colored frames changed. Artwork, text, mana, black cut borders and label sizes remain unchanged.\n',
          '| Set / deck | Mana colors | Old image | New image |', '| --- | --- | --- | --- |']
    featured = ['exquisite_invention', 'devour_for_power', 'invent_superiority', 'sliver_swarm', 'guided_by_nature', 'eldrazi_unbound']
    rows.sort(key=lambda r: (featured.index(r['slug']) if r['slug'] in featured else 99, r['set'], r['name']))
    for row in rows:
        verify_frame_only(row)
        name = row['name'].title()
        colors = ', '.join(c.title() for c in row['colors'])
        search = html.escape((name+' '+row['set']+' '+colors).lower(), quote=True)
        parts.append(f'<tr data-search="{search}"><td><strong>{html.escape(name)}</strong><small>{html.escape(row["set"])}</small><p>{colors}</p>'
                     f'<a href="../../{row["before"]}">Old image</a> · <a href="../../{row["after"]}">New image</a></td>'
                     f'<td>{picture(row["before"])}</td><td>{picture(row["after"])}</td></tr>')
        md.append(f'| {row["set"]} / {name} | {colors} | [Old](../../{row["before"]}) | [New](../../{row["after"]}) |')
    parts.append('''</tbody></table></main><script>document.getElementById('filter').addEventListener('input',function(){for(const row of document.querySelectorAll('tbody tr'))row.hidden=!row.dataset.search.includes(this.value.toLowerCase())})</script></html>''')
    (OUT / 'index.html').write_text(''.join(parts))
    (OUT / 'IMAGE_LINKS.md').write_text('\n'.join(md)+'\n')
    AUDIT.write_text(json.dumps(rows, indent=2)+'\n')
    print('Verified 114 new frames and preserved originals; all pixels outside the colored frame regions are unchanged.')


if __name__ == '__main__':
    main()
