#!/usr/bin/env bash
# All gates before a tag, as one command with a real exit code.
#   scripts/gates.sh <repo root> && git push ... && git tag ...
# Run it on a fresh clone. Do not rely on `set -e` in a tool call: the shell wrapper runs commands inside an
# `&&` list, where bash ignores it. Inside this script it works.
set -euo pipefail
root="$(cd "$1" && pwd)"
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
rules="$here/check_rust_rules.py"
cd "$root"
export CARGO_BUILD_JOBS="${CARGO_BUILD_JOBS:-4}"
# The tests (tempfile) write to TMPDIR. A folder of its own per run, removed on exit (ok, red, SIGTERM), so what a test leaves behind goes
# with the run. The base is not /tmp (RAM) and is not changed. A run killed by SIGKILL leaves its folder; the next run sweeps folders of dead PIDs.
gates_tmp_base="${TMPDIR_GATES:-/srv/FreeSynergy/.scratch}"
for old in "$gates_tmp_base"/gates-run.*; do
  [ -d "$old" ] || continue
  old_pid="${old##*/gates-run.}"; old_pid="${old_pid%%.*}"
  case "$old_pid" in ''|*[!0-9]*) continue ;; esac
  kill -0 "$old_pid" 2>/dev/null || rm -rf "$old"
done
gates_run_tmp="$(mktemp -d "$gates_tmp_base/gates-run.$$.XXXXXX")"
trap 'rm -rf "$gates_run_tmp"' EXIT
export TMPDIR="$gates_run_tmp"
if [ -n "$(git status --porcelain --untracked-files=no)" ]; then
  echo "gates FAILED: uncommitted changes in $root" >&2
  exit 1
fi
fmt_args=()
for manifest in crates/*/Cargo.toml; do
  [ -f "$manifest" ] || continue
  fmt_args+=(-p "$(sed -n 's/^name = "\(.*\)"/\1/p' "$manifest" | head -1)")
done
cargo fmt --check "${fmt_args[@]}"
"$here/limited.sh" cargo clippy --workspace --all-targets --all-features -- -D warnings
"$here/limited.sh" cargo test --workspace --all-features
python3 -I "$rules" "$root"
echo "gates ok: $root at $(git rev-parse --short HEAD)"
