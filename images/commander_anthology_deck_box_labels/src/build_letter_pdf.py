"""Create a Letter PDF with unchanged label pixels and explicit sRGB tagging."""
from io import BytesIO
from pathlib import Path

from PIL import Image, ImageCms
from pypdf import PdfReader, PdfWriter
from pypdf.generic import ArrayObject, DecodedStreamObject, NameObject, NumberObject
from reportlab.pdfgen import canvas
from reportlab.lib.utils import ImageReader

from sheet_layout import DECKS, SHEET_NAME, anthology_positions

ROOT = Path(__file__).resolve().parent.parent


def main():
    output = ROOT / "print_sheets"
    output.mkdir(exist_ok=True)
    memory = BytesIO()
    pdf = canvas.Canvas(memory, pagesize=(612, 792), pageCompression=1)
    pdf.setTitle("Commander Anthology - eight Boulder labels - US Letter")
    pdf.setAuthor("MTGCommanderFaces")
    profile = None
    srgb = ImageCms.ImageCmsProfile(ImageCms.createProfile("sRGB")).tobytes()
    for slug, (x, y) in zip(DECKS, anthology_positions()):
        source = ROOT / f"{slug}_boulder_top_label_tall_3300x2800_1200dpi.png"
        with Image.open(source) as original:
            assert original.size == (3300, 2800)
            assert original.getchannel("A").getextrema() == (255, 255)
            embedded = original.info.get("icc_profile")
            if embedded is None:
                assert "srgb" in original.info, "Source has no known color profile"
                embedded = srgb
            if profile is None:
                profile = embedded
            else:
                assert profile == embedded
            rgb = original.convert("RGB")
            pdf.drawImage(ImageReader(rgb), x * 72 / 1200,
                          792 - (y + 2800) * 72 / 1200, 198, 168)
    pdf.showPage()
    pdf.save()
    memory.seek(0)
    writer = PdfWriter()
    writer.clone_document_from_reader(PdfReader(memory))
    icc = DecodedStreamObject()
    icc.set_data(profile)
    icc[NameObject("/N")] = NumberObject(3)
    icc[NameObject("/Alternate")] = NameObject("/DeviceRGB")
    icc_ref = writer._add_object(icc)
    images = writer.pages[0]["/Resources"]["/XObject"]
    assert len(images) == 8
    for reference in images.values():
        item = reference.get_object()
        assert item["/Subtype"] == "/Image"
        item[NameObject("/ColorSpace")] = ArrayObject([NameObject("/ICCBased"), icc_ref])
    target = output / f"{SHEET_NAME}.pdf"
    with target.open("wb") as stream:
        writer.write(stream)
    check = PdfReader(target)
    assert len(check.pages) == 1
    assert tuple(check.pages[0].mediabox) == (0, 0, 612, 792)
    # Verify each embedded image's decoded RGB pixels against an original source.
    expected = set()
    import hashlib
    for slug in DECKS:
        with Image.open(ROOT / f"{slug}_boulder_top_label_tall_3300x2800_1200dpi.png") as original:
            expected.add(hashlib.sha256(original.convert("RGB").tobytes()).hexdigest())
    actual = set()
    for reference in check.pages[0]["/Resources"]["/XObject"].values():
        item = reference.get_object()
        assert (item["/Width"], item["/Height"]) == (3300, 2800)
        assert item["/ColorSpace"][0] == "/ICCBased"
        actual.add(hashlib.sha256(item.get_data()).hexdigest())
    assert actual == expected
    print(f"VERIFIED: {target} (Letter; 8 unchanged sRGB images)")


if __name__ == "__main__":
    main()
