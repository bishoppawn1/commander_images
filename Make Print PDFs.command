#!/bin/zsh
cd -- "${0:A:h}" || exit 1
runtime_python="/Users/bishophall/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/bin/python3"
if [[ ! -x "$runtime_python" ]]; then
  runtime_python="$(command -v python3)"
fi
if [[ -z "$runtime_python" ]] || ! "$runtime_python" -c 'import PIL, reportlab, pypdf' 2>/dev/null; then
  print 'Python with Pillow, reportlab and pypdf is required. See PRINT_PDFS.md.'
  read '?Press Return to close.'
  exit 1
fi
if (( $# )); then
  "$runtime_python" make_print_pdfs.py "$@"
  exit $?
fi
"$runtime_python" make_print_pdfs.py --interactive
result=$?
read '?Press Return to close.'
exit $result
