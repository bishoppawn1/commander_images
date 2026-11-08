#!/usr/bin/env python3
"""Verify original PNGs and build an old/new inspection list for every top."""
import base64
import hashlib
import html
import io
import json
from pathlib import Path
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT/'reviews/boulder_readability_2026_11_08'
AUDIT = ROOT/'images/boulder_readability_audit_2026_11_08.json'
SPECIAL = {
    'exquisite_invention': 'Regenerated composition: one head, lowered portrait, continuous workshop background.',
    'mind_seize': 'Regenerated composition: portrait moved left to center and down, with continuous scenery.',
    'evasive_maneuvers': 'Regenerated composition: lowered head, softer sky and restrained blue/gold lighting.',
    'the_fantastic_four': 'Generated background extension; full generated composition used to eliminate the old card-frame seam and black header.',
    'avengers_assemble': 'Retained source reframed to fill the canvas, removing the black header with complete head clear of mana. Outpaint attempt was rejected; no generated output used.',
    'wakanda_forever': 'Removed a 3% source strip containing a card-frame fragment at the scenery join; portrait retained.',
    'doom_prevails': 'Removed a 2.5% source strip containing a card-frame fragment at the scenery join; portrait retained.',
    'breed_lethality': 'Removed the stronger deck-specific screen-lightening pass; same treatment as the rest of the collection. Shared between Commander 2016 and Anthology II.',
}

def picture(relative):
    with Image.open(ROOT/relative) as im:
        im = im.convert('RGB'); im.thumbnail((660,560))
        data = io.BytesIO(); im.save(data,format='JPEG',quality=88)
    return '<a href="../../'+html.escape(relative,quote=True)+'"><img loading="lazy" alt="Open full-resolution image" src="data:image/jpeg;base64,'+base64.b64encode(data.getvalue()).decode()+'"></a>'

def main():
    OUT.mkdir(parents=True,exist_ok=True)
    rows = json.loads(AUDIT.read_text())
    parts = ['''<!doctype html><html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Top label corrections — old and new</title>
<style>body{font:16px/1.5 system-ui;margin:0;background:#f2f1ed;color:#242925}main{max-width:1450px;margin:auto;padding:32px}table{width:100%;border-collapse:collapse;background:white}td,th{padding:15px;border-bottom:1px solid #ddd;text-align:left;vertical-align:top}td:first-child{width:22%}td:not(:first-child){width:39%}img{display:block;width:100%;height:auto}thead{position:sticky;top:0;background:#263c32;color:white}a{color:#165a42}input{font:inherit;padding:12px;width:min(500px,90%);margin:15px 0}small{display:block}h1{line-height:1.2}p{max-width:1000px}.tag{display:block;color:#516257;margin-top:8px}</style><main>
<h1>Top labels: old and new</h1><p>All 114 placements have stronger dark mana halos, a darker feathered shade behind bottom text, and no automatic screen lightening or mana-color wash. Earlier images are preserved. Four artworks were edited with built-in ImageGen; the remaining art is retained, with native framing corrections where noted. Historical art styles remain distinct; this refresh does not repaint the entire collection.</p>
<p>The older prompts explicitly asked for brighter print exposure and lifted shadows. The former compositor then added a 7% screen-lightening pass (17% on Breed Lethality) and a 9% mana-color wash. There is no evidence of a separate HDR mode. The shared rules now call for restrained, source-faithful lighting.</p>
<p>Folder layout: <code>images/&lt;set&gt;/Tops</code> and <code>Fronts</code>. Paired fronts and Anthology tops use relative symlinks. Current PDFs are repacked into 10 top sheets and 7 front sheets; former sheet 11 Star Trek tops are now on sheet 10.</p>
<p>Click any thumbnail or Old / New link for its full-resolution PNG. Targeted fixes appear first; search covers the whole collection.</p>
<label>Find a deck or set<br><input id="filter" type="search" placeholder="e.g. Mind Seize, Star Trek, or Anthology"></label><table><thead><tr><th>Label / changes</th><th>Old</th><th>New</th></tr></thead><tbody>''']
    rows.sort(key=lambda r:(r['slug'] not in SPECIAL,r['set'],r['name']))
    md = ['# Top-label old/new inspection list\n','All 114 placements use the updated mana halo, text shade and source-faithful exposure. Four artworks regenerated; the remaining artwork retained.\n','| Set / label | Change | Old image | New image |','| --- | --- | --- | --- |']
    for r in rows:
        assert hashlib.sha256((ROOT/r['before']).read_bytes()).hexdigest()==r['sha256_before'], r['before']
        after=ROOT/r['after']
        with Image.open(after) as im:
            assert im.size==(3960,3360) and abs(im.info['dpi'][0]-1440)<1, after
            assert im.mode!='RGBA' or im.getchannel('A').getextrema()==(255,255), after
        r['sha256_after']=hashlib.sha256(after.read_bytes()).hexdigest()
        r['change']=SPECIAL.get(r['slug'],'Retained artwork; updated mana halo, bottom shade, and removal of automatic brightening/color wash.')
        r['qa']='Inspected in whole-collection preview; full-size dimensions, DPI and opacity validated; original hash unchanged.'
        label=r['name'].title();setname=r['set'];change=r['change']
        old='../../'+r['before'];new='../../'+r['after']
        parts.append(f'<tr data-search="{html.escape((label+" "+setname).lower(),quote=True)}"><td><strong>{html.escape(label)}</strong><small>{html.escape(setname)}</small><p>{html.escape(change)}</p><a href="{old}">Old image</a> · <a href="{new}">New image</a></td><td>{picture(r["before"])}</td><td>{picture(r["after"])}</td></tr>')
        md.append(f'| {setname} / {label} | {change} | [Old]({old}) | [New]({new}) |')
    parts.append('''</tbody></table></main><script>document.getElementById('filter').addEventListener('input',function(){for(const r of document.querySelectorAll('tbody tr'))r.hidden=!r.dataset.search.includes(this.value.toLowerCase())})</script></html>''')
    (OUT/'index.html').write_text(''.join(parts))
    (OUT/'IMAGE_LINKS.md').write_text('\n'.join(md)+'\n')
    AUDIT.write_text(json.dumps(rows,indent=2)+'\n')
    print(f'Verified {len(rows)} originals and new PNGs; wrote {OUT}.')

if __name__=='__main__': main()
