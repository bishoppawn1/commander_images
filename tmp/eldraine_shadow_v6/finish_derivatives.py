from pathlib import Path
import json, subprocess
work=Path('tmp/eldraine_shadow_v6')
items=json.loads((work/'outputs.json').read_text())
masters=[]
for row in items:
    for key in ('base','counted'):
        target=Path(row[key]); stem=target.name.removesuffix('_1800x2100.png')
        white=target.parent/'src/superseded_white_margin_3_16in'/(stem+'_1800x2100_white_margin_3_16in.png')
        cropped=work/(stem+'_cropped.png')
        bordered=work/(stem+'_bordered.png')
        master=target.parent/(stem+'_1724x2024_black_margin_1_8in.png')
        if not master.exists():
            for script,args in [
                ('apply_white_margin.swift',[target,white]),
                ('crop_white_margin.swift',[white,cropped,'38']),
                ('add_cut_border.swift',[cropped,bordered,'3']),
                ('reframe_final_black_margin.swift',[bordered,master])]:
                if not Path(args[1]).exists():
                    subprocess.run(['swift','scripts/'+script,*map(str,args)],check=True,stdout=subprocess.DEVNULL)
        masters.append(str(master))
        row[key+'_600dpi']=str(master)
        row[key+'_1440dpi']=str(master).replace('_1724x2024_black_margin_1_8in.png','_4138x4858_1440dpi_black_margin_1_8in.png')
        print('READY',master.name,flush=True)
subprocess.run(['swift','scripts/validate_final_black_margin.swift',*masters],check=True)
pending=[m for m in masters if not Path(m.replace('_1724x2024_black_margin_1_8in.png','_4138x4858_1440dpi_black_margin_1_8in.png')).exists()]
if pending:subprocess.run(['swift','scripts/build_1440dpi_drawer_faces.swift',*pending],check=True)
subprocess.run(['swift','scripts/validate_1440dpi_drawer_faces.swift',*[row[key+'_1440dpi'] for row in items for key in ('base','counted')]],check=True)
(work/'outputs.json').write_text(json.dumps(items,indent=2)+'\n')
print('All derivatives built and validated.',flush=True)
