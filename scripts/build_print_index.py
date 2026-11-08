#!/usr/bin/env python3
"""Render current PDF batches to small PNGs and write a printable-sheet index."""
from concurrent.futures import ThreadPoolExecutor
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT/'reviews/boulder_readability_2026_11_08/sheets'

def main():
    OUT.mkdir(parents=True,exist_ok=True)
    jobs=[]
    parts=['# Current print sheets\n',
           'Rebuilt November 8, 2026: 10 top sheets and 7 front sheets. Print at 100% / Actual Size. Top sheets require Letter Borderless; fronts fit ordinary Letter. All earlier PDF editions have been removed.\n',
           'Use the PNG previews to inspect pages without opening a PDF preview in Codex.\n',
           '| Format / sheet | Labels | Sets | Preview | Print PDF |',
           '| --- | ---: | --- | --- | --- |']
    for kind,folder in [('tops','Boulder Tops'),('fronts','Fronts')]:
        rows=json.loads((ROOT/'Print Sheets'/folder/'.records'/f'LATEST_{kind}_all.json').read_text())
        for r in rows:
            number=int(r['pdf'].split('_',1)[0]);pdf=ROOT/'Print Sheets'/folder/r['pdf']
            prefix=OUT/f'{kind}_{number:02d}'
            jobs.append((pdf,prefix))
            groups=', '.join(dict.fromkeys(x['group'].replace('_',' ').title() for x in r['labels']))
            preview='../'+str(prefix.with_suffix('.png').relative_to(ROOT))
            parts.append(f'| {kind.title()} {number} | {r["count"]} | {groups} | [PNG]({preview}) | [PDF](<{folder}/{r["pdf"]}>) |')
    def render(job):
        pdf,prefix=job
        subprocess.run(['pdftoppm','-scale-to','1400','-singlefile','-png',str(pdf),str(prefix)],check=True,
                       stdout=subprocess.DEVNULL,stderr=subprocess.PIPE)
    with ThreadPoolExecutor(max_workers=3) as pool:
        list(pool.map(render,jobs))
    (ROOT/'Print Sheets/INDEX.md').write_text('\n'.join(parts)+'\n')
    print(f'Rendered {len(jobs)} current sheets and wrote Print Sheets/INDEX.md.')

if __name__=='__main__': main()
