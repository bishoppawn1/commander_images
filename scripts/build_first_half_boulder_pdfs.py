"""Lossless 1440-PPI, 12-slot US Letter sheets at the unchanged physical size."""
import hashlib
import json
from io import BytesIO
from pathlib import Path

from PIL import Image, ImageCms
from pypdf import PdfReader, PdfWriter
from pypdf.generic import ArrayObject, DecodedStreamObject, NameObject, NumberObject
from reportlab import rl_config
from reportlab.lib.utils import ImageReader
from reportlab.pdfgen import canvas

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "output/pdf/first_half_boulder_tops_1440dpi"
SOURCE_PPI = 1440
SOURCE_PIXELS = (3960, 3360)
SUFFIX = "_boulder_top_label_tall_3960x3360_1440dpi.png"
GROUPS = [
    ("01_Commander_2013_2016_2017_2018", [
        "commander_2013", "commander_2016", "commander_2017", "commander_2018"]),
    ("02_Commander_2019_Throne_of_Eldraine_Brawl_Zendikar_Rising_Commander_Legends", [
        "commander_2019", "throne_of_eldraine_brawl", "zendikar_rising", "commander_legends"]),
    ("03_Commander_2020_Strixhaven_Kamigawa_Neon_Dynasty", [
        "commander_2020", "strixhaven", "kamigawa_neon_dynasty"]),
    ("04_Adventures_in_the_Forgotten_Realms_Warhammer_40000_The_Brothers_War", [
        "adventures_in_the_forgotten_realms", "warhammer_40000", "brothers_war"]),
]
WIDTH, HEIGHT, GAP = 198, 168, 4.5  # PDF points: 2.75 x 2 1/3 inches, 1/16-inch gaps.
LEFT = (612 - 3 * WIDTH - 2 * GAP) / 2
TOP = (792 - 4 * HEIGHT - 3 * GAP) / 2


def source_labels(release):
    folder = ROOT / "images" / (release + "_boulder_deck_box_labels")
    manifest = json.loads((folder / "label_manifest.json").read_text())
    labels = [(item["deckName"], folder / (item["slug"] + SUFFIX))
              for item in manifest["labels"]]
    if release == "commander_2016":
        labels.append(("BREED LETHALITY (retained Anthology II artwork)",
                       ROOT / "images/commander_anthology_deck_box_labels" /
                       ("breed_lethality" + SUFFIX)))
    assert all(path.is_file() for _, path in labels)
    return labels


def rgb_and_profile(path):
    with Image.open(path) as source:
        assert source.size == SOURCE_PIXELS, path
        assert all(abs(dpi - SOURCE_PPI) < 0.1 for dpi in source.info["dpi"])
        if source.mode == "RGBA":
            assert source.getchannel("A").getextrema() == (255, 255), path
        else:
            assert source.mode == "RGB", (path, source.mode)
        profile = source.info.get("icc_profile")
        if not profile:
            assert "srgb" in source.info, f"Unknown color space: {path}"
            profile = ImageCms.ImageCmsProfile(ImageCms.createProfile("sRGB")).tobytes()
        return source.convert("RGB"), profile


def make_sheet(stem, releases):
    entries = [(release, title, path) for release in releases
               for title, path in source_labels(release)]
    assert 0 < len(entries) <= 12
    memory = BytesIO()
    pdf = canvas.Canvas(memory, pagesize=(612, 792), pageCompression=1)
    pdf.setTitle(stem[3:].replace("_", " ") + " - 1440 DPI")
    pdf.setAuthor("MTGCommanderFaces")
    profiles, expected, placements = {}, {}, []
    for idx, (release, title, path) in enumerate(entries):
        rgb, profile = rgb_and_profile(path)
        raw_hash = hashlib.sha256(rgb.tobytes()).hexdigest()
        assert raw_hash not in expected, "Duplicate image on page"
        expected[raw_hash] = str(path.relative_to(ROOT))
        profiles[raw_hash] = profile
        row, col = divmod(idx, 3)
        x = LEFT + col * (WIDTH + GAP)
        y = 792 - TOP - HEIGHT - row * (HEIGHT + GAP)
        pdf.drawImage(ImageReader(rgb), x, y, WIDTH, HEIGHT)
        placements.append(dict(release=release, deck=title, source=expected[raw_hash],
                               rgb_sha256=raw_hash, box_points=[x, y, WIDTH, HEIGHT]))
    pdf.showPage()
    pdf.save()
    memory.seek(0)
    writer = PdfWriter()
    writer.clone_document_from_reader(PdfReader(memory))
    image_objects = writer.pages[0]["/Resources"]["/XObject"]
    assert len(image_objects) == len(entries)
    icc_refs = {}
    for reference in image_objects.values():
        obj = reference.get_object()
        digest = hashlib.sha256(obj.get_data()).hexdigest()
        assert digest in expected
        profile = profiles[digest]
        if profile not in icc_refs:
            icc = DecodedStreamObject()
            icc.set_data(profile)
            icc[NameObject("/N")] = NumberObject(3)
            icc[NameObject("/Alternate")] = NameObject("/DeviceRGB")
            icc_refs[profile] = writer._add_object(icc)
        obj[NameObject("/ColorSpace")] = ArrayObject([NameObject("/ICCBased"), icc_refs[profile]])
    target = OUT / (stem + "_1440dpi.pdf")
    with target.open("wb") as stream:
        writer.write(stream)
    check = PdfReader(target)
    assert len(check.pages) == 1 and tuple(check.pages[0].mediabox) == (0, 0, 612, 792)
    actual = set()
    for reference in check.pages[0]["/Resources"]["/XObject"].values():
        obj = reference.get_object()
        assert (obj["/Width"], obj["/Height"]) == SOURCE_PIXELS
        digest = hashlib.sha256(obj.get_data()).hexdigest()
        assert obj["/ColorSpace"][0] == "/ICCBased"
        assert obj["/ColorSpace"][1].get_object().get_data() == profiles[digest]
        actual.add(digest)
    assert actual == set(expected)
    # Check actual page transforms rather than only the intended placement list.
    transforms = [list(map(float, values)) for values, op in check.pages[0].get_contents().operations
                  if op == b"cm" and abs(float(values[0]) - WIDTH) < 1e-6]
    assert len(transforms) == len(entries)
    for transform, item in zip(transforms, placements):
        x, y, w, h = item["box_points"]
        assert transform == [w, 0, 0, h, x, y]
        assert 0 <= x and 0 <= y and x + w <= 612 and y + h <= 792
        assert (SOURCE_PIXELS[0] / (w / 72), SOURCE_PIXELS[1] / (h / 72)) == (SOURCE_PPI, SOURCE_PPI)
    print(f"VERIFIED {target.name}: {len(entries)} original-size, lossless labels", flush=True)
    return dict(pdf=target.name, count=len(entries), releases=releases, labels=placements)


def main():
    # Binary Flate streams avoid unnecessary ASCII85 overhead; never JPEG-compress.
    rl_config.useA85 = 0
    OUT.mkdir(parents=True, exist_ok=True)
    releases = [release for _, group in GROUPS for release in group]
    assert len(releases) == len(set(releases)) == 14
    sheets = [make_sheet(*group) for group in GROUPS]
    assert [sheet["count"] for sheet in sheets] == [12, 12, 12, 10]
    (OUT / "sheet_manifest.json").write_text(json.dumps(dict(
        source_ppi=SOURCE_PPI, source_pixels=SOURCE_PIXELS,
        label_inches=[WIDTH / 72, HEIGHT / 72],
        margin_inches=dict(left=LEFT / 72, right=LEFT / 72, top=TOP / 72, bottom=TOP / 72),
        gap_inches=GAP / 72, sheets=sheets), indent=2) + "\n")


if __name__ == "__main__":
    main()
