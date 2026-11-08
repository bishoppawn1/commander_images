#!/usr/bin/env python3
"""Refresh the compact collection; former isolated sheet numbers are retired."""
from pathlib import Path
import sys
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from make_print_pdfs import main
if __name__ == '__main__':
    main(['--kind', 'both', '--replace-all'])
