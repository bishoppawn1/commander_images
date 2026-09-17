"""Compatibility entry point; use the shared batch tool for first-half tops."""
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
from make_print_pdfs import main

if __name__ == "__main__":
    main(["--kind", "tops", "--scope", "first", *sys.argv[1:]])
