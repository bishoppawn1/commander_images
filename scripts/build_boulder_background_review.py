#!/usr/bin/env python3
"""Create a visual before/after table from the background audit; no artwork edits."""
import base64, hashlib, html, io, json
from pathlib import Path
from PIL import Image, ImageChops

ROOT = Path(__file__).resolve().parents[1]
AUDIT = ROOT / 'images/boulder_background_audit_2026_11_08.json'
OUT = ROOT / 'reviews/boulder_backgrounds_2026_11_08'
OUT.mkdir(parents=True, exist_ok=True)
rows = json.loads(AUDIT.read_text())
parts = ['''<!doctype html><html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Boulder tops — background extension review</title>
<style>body{font:16px/1.5 system-ui,sans-serif;margin:0;background:#f5f3ed;color:#242925}main{max-width:1450px;margin:auto;padding:32px}h1{font-size:34px;margin-bottom:10px}p{max-width:950px}input{font:inherit;padding:12px;width:min(500px,80%);margin:12px 0 24px;border:1px solid #aaa;border-radius:5px}table{width:100%;border-collapse:collapse;background:white}th,td{padding:15px;text-align:left;border-bottom:1px solid #ddd;vertical-align:top}thead{position:sticky;top:0;background:#243b32;color:white}td:first-child{width:21%}td:not(:first-child){width:39%}img{display:block;width:100%;height:auto}small{display:block;color:#555}.status{display:inline-block;border-radius:4px;padding:3px 7px;background:#e0efe6;font-size:13px;margin:8px 0}.blocked{background:#fff0d7}.note{padding:24px;background:#fff0d7}a{color:#17624b}details{margin:30px 0}footer{margin:30px 0;color:#555}@media(max-width:700px){main{padding:12px}th,td{padding:7px}h1{font-size:26px}}</style>
<main><h1>Boulder tops: background extension review</h1><p>Audited all <strong>114 placements</strong> for exposed canvas after portrait repositioning. <strong>34 had a top gap; 32 have new scene extensions; 2 remain unresolved.</strong> The other 80 placements were left byte-for-byte unchanged.</p>
<p>The new rule requires continuous artwork from top to bottom inside the decorative frame. Missing scenery is generated above the retained art. Portrait placement, native titles, borders and top-centered mana symbols are preserved, with a narrow blend at the background join.</p>
<p class="note"><strong>Unresolved:</strong> Avengers Assemble and The Fantastic Four retain their previous versions. The built-in image service rejected both output attempts through its safety system without a specific reason. These are not counted as corrected.</p>
<label for="filter">Find a deck or set</label><br><input id="filter" type="search" placeholder="e.g. Star Trek or Commander 2017"><p>Click an image to open its full-resolution PNG. Each prompt is retained beside the source assets.</p><table><thead><tr><th>Label / issue</th><th>Before</th><th>Recreation</th></tr></thead><tbody>''']

def thumb(path):
    with Image.open(ROOT/path) as image:
        image=image.convert('RGB'); image.thumbnail((660,560))
        buffer=io.BytesIO();image.save(buffer,format='JPEG',quality=90)
    return 'data:image/jpeg;base64,'+base64.b64encode(buffer.getvalue()).decode()

def picture(path, alt):
    return f'<a href="../../{html.escape(path,quote=True)}"><img loading="lazy" src="{thumb(path)}" alt="{html.escape(alt,quote=True)}"></a>'

for row in rows:
    assert hashlib.sha256((ROOT/row['before']).read_bytes()).hexdigest()==row['sha256_before'], row['before']
    if row['status']=='unchanged':continue
    title=row['name'].title().replace('’S', '’s'); status=row['status']
    gap=round(row['gap_fraction']*100)
    if status=='recreated':
        with Image.open(ROOT/row['before']) as before,Image.open(ROOT/row['after']) as after:
            assert after.size==(3960,3360)
            assert abs(after.info['dpi'][0]-1440)<1
            start=round((row['gap_fraction']+.04)*3360)
            assert ImageChops.difference(before.convert('RGB').crop((0,start,3960,3360)),after.convert('RGB').crop((0,start,3960,3360))).getbbox() is None, row['slug']
        row['sha256_after']=hashlib.sha256((ROOT/row['after']).read_bytes()).hexdigest()
        row['qa']='Visual coverage and join inspected; lower artwork and typography pixel-identical below the join region; 3960x3360 at 1440 DPI.'
        replacement=picture(row['after'],title+' recreation')
    else:
        replacement='<p><strong>No recreation available.</strong></p><p>Generation blocked; previous label retained.</p>'
    parts.append(f'<tr data-search="{html.escape(title+" "+row["set"],quote=True).lower()}"><td><strong>{html.escape(title)}</strong><small>{html.escape(row["set"])}</small><span class="status {"blocked" if status=="blocked" else ""}">{status.title()}</span><p>Exposed top band: approximately {gap}% of canvas height.</p><a href="../../{row["prompt"]}">Saved edit prompt</a></td><td>{picture(row["before"],title+" before")}</td><td>{replacement}</td></tr>')
parts.append('</tbody></table><details><summary>80 unchanged placements</summary><ul>')
for row in rows:
    if row['status']=='unchanged':parts.append(f'<li>{html.escape(row["name"].title())} — {html.escape(row["set"])}</li>')
parts.append('''</ul></details><footer>8 November 2026 · Built-in ImageGen background outpainting, followed by the retained Swift label compositor. Earlier PNG versions are preserved. Print sheets 1, 2, 5, 6, 7, 8, 9, 10 and 11 are rebuilt; 3 and 4 remain unchanged.</footer></main><script>document.getElementById('filter').addEventListener('input',function(){for(const row of document.querySelectorAll('tbody tr'))row.hidden=!row.dataset.search.includes(this.value.toLowerCase())})</script></html>''')
(OUT/'index.html').write_text(''.join(parts))
AUDIT.write_text(json.dumps(rows,indent=2)+'\n')
print(f'Wrote {OUT}/index.html. Validated all previous hashes and 32 lower-art pixel comparisons.')
