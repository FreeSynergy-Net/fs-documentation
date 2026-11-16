#!/usr/bin/env bash
# Tests for gen_folder_indexes.py and the strict link gate (counter-test: the gate must go RED).
#   scripts/test_folder_indexes.sh      (needs mkdocs; MKDOCS=/path/to/mkdocs to override)
set -uo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
SRC="$PWD"; MKDOCS="${MKDOCS:-$(command -v mkdocs || echo /tmp/rv-venv/bin/mkdocs)}"
t="$(mktemp -d)"; trap 'rm -rf "$t"' EXIT
fail=0; ok() { echo "ok: $1"; }; bad() { echo "FAIL: $1" >&2; fail=1; }

# --- generator on a tiny tree
mkdir -p "$t/g/docs/en/a/b" "$t/g/docs/en/c"
printf '# Home\n\n[A](a/b/) [C](c/)\n' > "$t/g/docs/en/index.md"
printf '# Page B\n' > "$t/g/docs/en/a/b/page.md"
printf '# Hand made\n\nkeep me\n' > "$t/g/docs/en/c/index.md"
printf '# Other\n' > "$t/g/docs/en/c/other.md"
python3 scripts/gen_folder_indexes.py --root "$t/g" >/dev/null
[ -f "$t/g/docs/en/a/b/index.md" ] && ok "index generated for linked folder" || bad "no index generated"
grep -q 'Page B' "$t/g/docs/en/a/b/index.md" && ok "title taken from page" || bad "title missing"
grep -q keep "$t/g/docs/en/c/index.md" && ok "hand-written index.md untouched" || bad "index.md overwritten"
find "$t/g" -type f | sort | xargs md5sum > "$t/h1"
python3 scripts/gen_folder_indexes.py --root "$t/g" >/dev/null
find "$t/g" -type f | sort | xargs md5sum > "$t/h2"
cmp -s "$t/h1" "$t/h2" && ok "idempotent (second run changes nothing)" || bad "second run changed files"
python3 scripts/gen_folder_indexes.py --root "$t/g" --check >/dev/null && ok "--check green after run" || bad "--check red after run"
printf '# Home\n' > "$t/g/docs/en/index.md"
python3 scripts/gen_folder_indexes.py --root "$t/g" >/dev/null
[ ! -f "$t/g/docs/en/a/b/index.md" ] && ok "stale generated index removed" || bad "stale index kept"

# --- counter-test: strict build must go RED on a broken link and on a folder link without index
if [ -x "$MKDOCS" ] || command -v "$MKDOCS" >/dev/null; then
  for case in broken folder; do
    rm -rf "$t/w"; mkdir "$t/w"; cp -r mkdocs.yml docs "$t/w/"
    python3 scripts/gen_decisions.py >/dev/null; cp -r docs/en/decisions "$t/w/docs/en/"; cp -r docs/de/decisions "$t/w/docs/de/"
    if [ "$case" = broken ]; then printf '\n[kaputt](gibt-es-nicht.md)\n' >> "$t/w/docs/en/index.md"
    else mkdir -p "$t/w/docs/en/zz-leer"; printf '# Leer\n' > "$t/w/docs/en/zz-leer/seite.md"
         printf '\n[ordner](zz-leer/)\n' >> "$t/w/docs/en/index.md"; fi
    if [ "$case" = folder ]; then
      # folder link without generator run: gate is the generator --check
      python3 scripts/gen_folder_indexes.py --root "$t/w" --check >/dev/null && bad "folder case: --check stayed green" || ok "folder link without index: generator --check RED"
    else
      (cd "$t/w" && "$MKDOCS" build --strict -d "$t/site") >/dev/null 2>&1 && bad "broken link: strict build stayed green" || ok "broken link: strict build RED"
    fi
  done
else echo "SKIPPED: mkdocs missing" >&2; fi
[ "$fail" -eq 0 ] && echo "test ok" || { echo "test FAILED" >&2; exit 1; }
