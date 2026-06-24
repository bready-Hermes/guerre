#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
HTML="$ROOT/httpdocs/index.html"
test -s "$HTML"
grep -q '<!doctype html>' "$HTML"
grep -q 'Poutine et Trump' "$HTML"
grep -q 'thebulletin.org' "$HTML"
grep -q 'sipri.org' "$HTML"
grep -q 'fas.org' "$HTML"
grep -q 'armscontrol.org' "$HTML"
python3 - <<'PY' "$HTML"
import sys
from html.parser import HTMLParser
class P(HTMLParser):
    pass
P().feed(open(sys.argv[1], encoding='utf-8').read())
PY
echo "OK static site tests"
