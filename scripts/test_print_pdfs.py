"""Fast layout/catalog checks; optional real-image integration tests via --integration."""
import json
from pathlib import Path
import sys
import tempfile
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import make_print_pdfs as tool


class LayoutTests(unittest.TestCase):
    def test_original_sizes_and_bounds(self):
        for kind, count in (("tops", 12), ("fronts", 6)):
            spec = tool.layout(kind)
            boxes = tool.positions(kind, count)
            for i, (x, y, w, h) in enumerate(boxes):
                self.assertAlmostEqual(w / 72, spec["pixels"][0] / 1440)
                self.assertAlmostEqual(h / 72, spec["pixels"][1] / 1440)
                self.assertTrue(0 <= x < x+w <= 612 and 0 <= y < y+h <= 792)
                for bx, by, bw, bh in boxes[i+1:]:
                    self.assertTrue(x+w <= bx or bx+bw <= x or y+h <= by or by+bh <= y)
            self.assertGreaterEqual(spec["top"], 18 if kind == "fronts" else 0)

    def test_whole_sets(self):
        groups = [dict(id=str(i), files=list(range(n))) for i, n in enumerate([5, 5, 4, 4, 2, 2])]
        pages = tool.pack_groups(groups, 12)
        self.assertEqual(sorted(g["id"] for page in pages for g in page), [str(i) for i in range(6)])
        self.assertTrue(all(sum(len(g["files"]) for g in page) <= 12 for page in pages))
        with self.assertRaises(ValueError):
            tool.pack_groups([dict(id="oversize", files=list(range(13)))], 12)

    def test_catalog_current_counts(self):
        for scope, expected in (("first", 46), ("second", 46), ("anthology", 8), ("all", 100)):
            groups = tool.load_groups("tops", scope)
            self.assertEqual(sum(len(g["files"]) for g in groups), expected)
        self.assertEqual(len(tool.load_groups("fronts")), 29)
        with self.assertRaises(ValueError):
            tool.load_groups("tops", ids=["not_a_real_set"])

    def test_guarded_inputs(self):
        with self.assertRaises(ValueError):
            tool.preflight([dict(files=["not_a_file.png"])], "tops")
        with self.assertRaises(ValueError):
            tool.positions("fronts", 7)
        self.assertLessEqual(len(tool.page_name(1, [dict(name="a"*400)], "abcdef123456")), 255)

    def test_six_overflows_on_separate_sheet(self):
        pages = tool.pack_groups(tool.load_groups("fronts"), 6)
        self.assertEqual([sum(len(g["files"]) for g in p) for p in pages], [6, 6, 6, 6, 4, 6])
        self.assertTrue(all(g["id"] != "overflow" for p in pages[:5] for g in p))
        self.assertEqual([g["id"] for g in pages[5]], ["overflow"])
        self.assertEqual(len(set(pages[5][0]["files"])), 1)
        self.assertIn("06_6_Overflows_Optional_", tool.page_name(6, pages[5], "test"))
        groups = [dict(id="spares", files=["a"], dedicated_sheet=True),
                  dict(id="normal", files=["b"])]
        self.assertEqual(len(tool.pack_groups(groups, 6)), 2)

    def test_explicit_copies(self):
        base = dict(id="test", name="Test", scope="other", files=["source.png"])
        for invalid in (0, -1, 1.5, True, "6"):
            with self.assertRaises(ValueError):
                tool.load_groups("fronts", catalog={"fronts": [dict(base, copies=invalid)]})
        result = tool.load_groups("fronts", catalog={"fronts": [dict(base, copies=6)]})
        self.assertEqual(result[0]["files"], ["source.png"] * 6)

    def test_preflight_all_sources(self):
        for kind in ("tops", "fronts"):
            tool.preflight(tool.load_groups(kind), kind)


def integration(output):
    for kind, capacity in (("tops", 12), ("fronts", 6)):
        groups = tool.load_groups(kind)
        page = tool.pack_groups(groups, capacity)[0]
        target = output / kind
        first = tool.build_page(kind, page, 1, target)
        before = (target / first["pdf"]).stat().st_mtime_ns
        self_same = tool.build_page(kind, page, 1, target)
        assert self_same == first
        assert (target / first["pdf"]).stat().st_mtime_ns == before
        receipt = target / Path(first["pdf"]).with_suffix(".json")
        data = json.loads(receipt.read_text())
        data["pdf_sha256"] = "invalid"
        receipt.write_text(json.dumps(data))
        try:
            tool.build_page(kind, page, 1, target)
        except ValueError:
            pass
        else:
            raise AssertionError("Modified cached output should not be silently overwritten")
        receipt.write_text(json.dumps(first))
    print("PASS: real 12-top and six-front pages, pixel/ICC/size verification, unchanged reruns and overwrite guard")


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "--integration":
        integration(Path(sys.argv[2]))
    else:
        unittest.main()
