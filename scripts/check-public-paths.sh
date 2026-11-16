#!/usr/bin/env bash
# Public-docs check: no local paths and no foreign e-mail addresses in docs/, conventions/, todo/, research/.
#   scripts/check-public-paths.sh [root]      (root defaults to the repo root; used by the counter-test)
# RED (exit 1) on: ".scratch", "/srv/FreeSynergy", "/home/<user>", or an address other than
# support@freesynergy.net / example domains (example.*, *.example, *.test, *.invalid, localhost).
# Files listed in scripts/public-paths-exceptions.txt (internal handoffs) may contain .scratch and /srv/FreeSynergy.
set -uo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
root="${1:-$here/..}"
cd "$root" || exit 2
exc="$here/public-paths-exceptions.txt"
excepted() { grep -vE '^\s*(#|$)' "$exc" 2>/dev/null | grep -qxF "$1"; }
dirs=(docs conventions todo research); fail=0
files() { find "${dirs[@]}" -type f \( -name '*.md' -o -name '*.yaml' -o -name '*.yml' -o -name '*.txt' \) 2>/dev/null | sort; }
while IFS= read -r f; do
  if ! excepted "$f"; then
    grep -nE '\.scratch|/srv/FreeSynergy' "$f" | sed "s#^#RED path: $f:#" | grep . && fail=1
  fi
  grep -nE '(^|[^A-Za-z0-9_])/home/[A-Za-z0-9_.-]+' "$f" | sed "s#^#RED path: $f:#" | grep . && fail=1
  grep -noE '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' "$f" \
    | grep -viE '@(support@)?freesynergy\.net$|@([a-z0-9-]+\.)*example(\.[a-z]+)?$|@[a-z0-9.-]+\.(example|test|invalid)$|@localhost$' \
    | sed "s#^#RED address: $f:#" | grep . && fail=1
done < <(files)
[ "$fail" -eq 0 ] && echo "check-public-paths ok" || echo "check-public-paths FAILED (RED)" >&2
exit "$fail"
