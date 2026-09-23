from pathlib import Path
import json
import subprocess

work = Path('tmp/annual_centered_2026_09_21')
items = json.loads((work/'inputs.json').read_text())
for row in items:
    split = 'vertical_split' in row['name']
    kind = 'split' if row['id'] == 'commander_2013_commander_2016' else 'none' if split else row['id'][-4:]
    if kind == 'none':
        row['raw'] = row['raw'].replace('_raw.png', '_refined_raw.png')
    prefix = Path('images') / row['id'] / row['name']
    row['base'] = str(prefix) + '_1800x2100.png'
    row['counted'] = str(prefix) + ('_deck_counts_2_2' if split else '_deck_count_4') + '_1800x2100.png'
    if not Path(row['base']).exists():
        subprocess.run(['swift', 'scripts/build_unified_annual_titles.swift', row['raw'], row['base'], kind, '1050'], check=True)
    if not Path(row['counted']).exists():
        subprocess.run(['swift', 'scripts/apply_deck_count.swift', row['base'], row['counted'], *(['2:900', '2:1800'] if split else ['4:1800'])], check=True)
    subprocess.run(['sips', '-Z', '700', row['counted'], '--out', str(work/(row['id']+'_preview.png'))], check=True, stdout=subprocess.DEVNULL)
(work/'outputs.json').write_text(json.dumps(items, indent=2)+'\n')
