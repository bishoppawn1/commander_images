#!/usr/bin/env python3
"""Make original-size 1440-PPI Boulder-top and drawer-front PDF batches."""
import argparse
from collections import Counter
import hashlib
from io import BytesIO
import json
from pathlib import Path
import re
import sys
import tempfile

from PIL import Image, ImageCms
from pypdf import PdfReader, PdfWriter
from pypdf.generic import ArrayObject, DecodedStreamObject, NameObject, NumberObject
from reportlab import rl_config
from reportlab.lib.utils import ImageReader
from reportlab.pdfgen import canvas

ROOT = Path(__file__).resolve().parent
TOP_SUFFIX = "_boulder_top_label_tall_3960x3360_1440dpi.png"
VERSION = 1
LAYOUTS = {
    "tops": dict(pixels=(3960, 3360), columns=3, rows=4, left=4.5, gap_x=4.5, gap_y=4.5),
    "fronts": dict(pixels=(4138, 4858), columns=2, rows=3, left=54, gap_y=13.65),
}


def digest_file(path):
    digest = hashlib.sha256()
    with Path(path).open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def layout(kind):
    spec = dict(LAYOUTS[kind])
    spec["width"], spec["height"] = (n / 1440 * 72 for n in spec["pixels"])
    spec.setdefault("gap_x", 612 - 2 * spec["left"] - 2 * spec["width"])
    spec["top"] = (792 - spec["rows"] * spec["height"] - (spec["rows"] - 1) * spec["gap_y"]) / 2
    if min(spec["left"], spec["top"], spec["gap_x"], spec["gap_y"]) < 0:
        raise ValueError("Layout cannot fit at the original physical size")
    return spec


def positions(kind, count):
    spec = layout(kind)
    if not 0 < count <= spec["columns"] * spec["rows"]:
        raise ValueError("Sheet exceeds capacity")
    result = []
    for index in range(count):
        row, col = divmod(index, spec["columns"])
        x = spec["left"] + col * (spec["width"] + spec["gap_x"])
        y = 792 - spec["top"] - spec["height"] - row * (spec["height"] + spec["gap_y"])
        result.append([x, y, spec["width"], spec["height"]])
    return result


def load_groups(kind, scope="all", ids=None, catalog=None, root=ROOT):
    data = catalog or json.loads((root / "print_catalog.json").read_text())
    rows = data[kind]
    if len({row["id"] for row in rows}) != len(rows):
        raise ValueError(f"Duplicate {kind} catalog IDs")
    if ids and set(ids) - {row["id"] for row in rows}:
        raise ValueError(f"Unknown {kind} set IDs: {sorted(set(ids) - {row['id'] for row in rows})}")
    groups = []
    for row in rows:
        if scope != "all" and row["scope"] != scope:
            continue
        if ids and row["id"] not in ids:
            continue
        group = dict(row)
        paths = list(row.get("files", []))
        if row.get("manifest"):
            manifest_path = root / row["manifest"]
            manifest = json.loads(manifest_path.read_text())
            paths = [str(manifest_path.parent.relative_to(root) / (item["slug"] + TOP_SUFFIX))
                     for item in manifest["labels"]] + paths
        if not paths or len(paths) != len(set(paths)):
            raise ValueError(f"Empty or duplicate source entries: {row['id']}")
        copies = row.get("copies", 1)
        if type(copies) is not int or copies < 1:
            raise ValueError(f"Copies must be a positive integer: {row['id']}")
        group["files"] = paths * copies
        groups.append(group)
    if not groups:
        raise ValueError(f"No {kind} groups match the selection")
    return groups


def pack_groups(groups, capacity):
    """First-fit in catalog order: never divide a release, fill earlier free slots."""
    sheets = []
    for group in groups:
        n = len(group["files"])
        if not 0 < n <= capacity:
            raise ValueError(f"{group['id']} has {n} images; cannot keep it on one {capacity}-slot page")
        if group.get("dedicated_sheet"):
            sheets.append([group])
            continue
        for sheet in sheets:
            if any(g.get("dedicated_sheet") for g in sheet):
                continue
            if sum(len(g["files"]) for g in sheet) + n <= capacity:
                sheet.append(group)
                break
        else:
            sheets.append([group])
    return sheets


def preflight(groups, kind, root=ROOT):
    expected = LAYOUTS[kind]["pixels"]
    for source in dict.fromkeys(p for group in groups for p in group["files"]):
        path = root / source
        if not path.is_file():
            raise ValueError(f"Missing 1440-DPI image: {path}")
        with Image.open(path) as im:
            dpi = im.info.get("dpi", (0, 0))
            if im.size != expected or any(abs(n - 1440) > .1 for n in dpi):
                raise ValueError(f"Wrong size or DPI: {path}: {im.size}, {dpi}")
            if im.mode not in ("RGB", "RGBA"):
                raise ValueError(f"Unexpected color mode: {path}: {im.mode}")
            if not im.info.get("icc_profile") and "srgb" not in im.info:
                raise ValueError(f"Unknown color profile: {path}")


def page_name(number, groups, signature):
    names = "_".join(g["name"] for g in groups)
    names = re.sub(r"[^A-Za-z0-9_-]+", "_", names).strip("_")
    # Full names remain in the PDF title/manifest if a future catalog exceeds this limit.
    return f"{number:02d}_{names[:190]}_1440dpi_{signature[:10]}.pdf"


def build_page(kind, groups, number, output, root=ROOT):
    entries = [(g["id"], path) for g in groups for path in g["files"]]
    boxes = positions(kind, len(entries))
    source_hashes = {p: digest_file(root / p) for _, p in entries}
    payload = dict(version=VERSION, kind=kind, groups=groups, boxes=boxes, sources=source_hashes)
    signature = hashlib.sha256(json.dumps(payload, sort_keys=True).encode()).hexdigest()
    output.mkdir(parents=True, exist_ok=True)
    target = output / page_name(number, groups, signature)
    receipt = target.with_suffix(".json")
    if target.exists() and receipt.exists():
        saved = json.loads(receipt.read_text())
        if saved.get("signature") == signature and saved.get("pdf_sha256") == digest_file(target):
            print(f"UNCHANGED: {target.name}", flush=True)
            return saved
    if target.exists() or receipt.exists():
        raise ValueError(f"Existing incomplete/modified output; move it aside before rebuilding: {target}")
    memory = BytesIO()
    rl_config.useA85 = 0
    pdf = canvas.Canvas(memory, pagesize=(612, 792), pageCompression=1)
    pdf.setTitle(" / ".join(g["name"].replace("_", " ") for g in groups) + " - 1440 DPI")
    pdf.setAuthor("MTGCommanderFaces")
    profiles, expected, records = {}, Counter(), []
    for (group_id, source), box in zip(entries, boxes):
        with Image.open(root / source) as im:
            if im.mode == "RGBA" and im.getchannel("A").getextrema() != (255, 255):
                raise ValueError(f"Transparent source needs explicit handling: {source}")
            profile = im.info.get("icc_profile") or ImageCms.ImageCmsProfile(ImageCms.createProfile("sRGB")).tobytes()
            rgb = im.convert("RGB")
            pixel_hash = hashlib.sha256(rgb.tobytes()).hexdigest()
            profiles[pixel_hash] = profile
            expected[pixel_hash] += 1
            pdf.drawImage(ImageReader(rgb), *box)
            records.append(dict(group=group_id, source=source, box_points=box, rgb_sha256=pixel_hash))
    pdf.showPage()
    pdf.save()
    memory.seek(0)
    writer = PdfWriter()
    writer.clone_document_from_reader(PdfReader(memory))
    for ref in writer.pages[0]["/Resources"]["/XObject"].values():
        obj = ref.get_object()
        h = hashlib.sha256(obj.get_data()).hexdigest()
        icc = DecodedStreamObject()
        icc.set_data(profiles[h])
        icc[NameObject("/N")] = NumberObject(3)
        icc[NameObject("/Alternate")] = NameObject("/DeviceRGB")
        obj[NameObject("/ColorSpace")] = ArrayObject([NameObject("/ICCBased"), writer._add_object(icc)])
    with tempfile.TemporaryDirectory(prefix=".building-", dir=output) as scratch:
        temporary = Path(scratch) / "sheet.pdf"
        with temporary.open("wb") as stream:
            writer.write(stream)
        verify_pdf(temporary, kind, boxes, expected, profiles)
        if any(digest_file(root / p) != h for p, h in source_hashes.items()):
            raise ValueError("A source changed during rendering; rerun after image generation finishes")
        temporary.replace(target)
    result = dict(signature=signature, pdf=target.name, pdf_sha256=digest_file(target),
                  kind=kind, count=len(entries), labels=records)
    receipt.write_text(json.dumps(result, indent=2) + "\n")
    print(f"VERIFIED: {target.name} ({len(entries)} images)", flush=True)
    return result


def verify_pdf(path, kind, boxes, expected, profiles):
    reader = PdfReader(path)
    assert len(reader.pages) == 1 and tuple(reader.pages[0].mediabox) == (0, 0, 612, 792)
    page = reader.pages[0]
    resources = page["/Resources"]["/XObject"]
    hashes = {}
    for name, ref in resources.items():
        obj = ref.get_object()
        assert (obj["/Width"], obj["/Height"]) == LAYOUTS[kind]["pixels"]
        h = hashlib.sha256(obj.get_data()).hexdigest()
        assert h in expected and obj["/ColorSpace"][0] == "/ICCBased"
        assert obj["/ColorSpace"][1].get_object().get_data() == profiles[h]
        hashes[name] = h
    ops = page.get_contents().operations
    drawn = Counter(hashes[args[0]] for args, op in ops if op == b"Do")
    assert drawn == expected
    transforms = [list(map(float, args)) for args, op in ops
                  if op == b"cm" and abs(float(args[0]) - layout(kind)["width"]) < .001]
    assert len(transforms) == len(boxes)
    for actual, (x, y, w, h) in zip(transforms, boxes):
        assert all(abs(a - b) < .001 for a, b in zip(actual, [w, 0, 0, h, x, y]))


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--kind", choices=["tops", "fronts", "both"], default="both")
    parser.add_argument("--scope", choices=["all", "first", "second", "anthology", "other"], default="all")
    parser.add_argument("--sets", help="Comma-separated catalog IDs; use --list to see IDs")
    parser.add_argument("--list", action="store_true", help="List catalog IDs without generating PDFs")
    parser.add_argument("--plan", action="store_true", help="Validate sources and show pages without writing PDFs")
    parser.add_argument("--output", type=Path, default=ROOT / "output/pdf/generated")
    parser.add_argument("--interactive", action="store_true")
    args = parser.parse_args(argv)
    if args.interactive:
        args.kind = {"1": "tops", "2": "fronts", "3": "both"}[input("1 Boulder tops | 2 Large fronts | 3 Both: ").strip()]
        args.scope = {"1": "all", "2": "first", "3": "second"}[input("1 All | 2 First half | 3 Second half: ").strip()]
    if args.sets and args.kind == "both":
        parser.error("Use --sets with --kind tops or --kind fronts")
    jobs = []
    for kind in (["tops", "fronts"] if args.kind == "both" else [args.kind]):
        groups = load_groups(kind, args.scope, [s.strip() for s in args.sets.split(",")] if args.sets else None)
        if args.list:
            for g in groups:
                print(f"{kind}: {g['id']} | {len(g['files'])} images | {g['name']}")
            continue
        preflight(groups, kind)
        spec = layout(kind)
        pages = pack_groups(groups, spec["columns"] * spec["rows"])
        print(f"\n{kind.upper()}: {sum(len(g['files']) for g in groups)} images, {len(pages)} PDFs; "
              f"size {spec['width']/72:.6f} x {spec['height']/72:.6f} inches")
        for i, page in enumerate(pages, 1):
            print(f"  {i}: {sum(len(g['files']) for g in page)} images - " + ", ".join(g["name"] for g in page))
        jobs.append((kind, pages))
    if args.plan or args.list:
        return
    if args.interactive and input("Create these PDFs? Type y to continue: ").strip().lower() != "y":
        print("Cancelled. No PDFs changed.")
        return
    for kind, pages in jobs:
        output = args.output / f"{kind}_{args.scope}"
        results = [build_page(kind, page, i, output) for i, page in enumerate(pages, 1)]
        # Content-addressed PDFs retain older editions. This index identifies the current batch.
        (output / "LATEST.json").write_text(json.dumps(results, indent=2) + "\n")
        print(f"DONE: {output}")
    print("Print at Actual Size / 100%. Tops need Letter Borderless; check expansion with a measured proof.")


if __name__ == "__main__":
    try:
        main()
    except (ValueError, KeyError, OSError) as error:
        sys.exit(f"ERROR: {error}")
