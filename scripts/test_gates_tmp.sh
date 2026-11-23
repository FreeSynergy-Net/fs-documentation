#!/usr/bin/env bash
# Self test of the temp folder of a gates run (scripts/gates.sh): the tests get a TMPDIR folder of their own inside TMPDIR_GATES; it is gone
# after the run (ok, red, SIGTERM); a folder of a dead PID is swept, one of a live PID stays. cargo, python3 and limited.sh are stubs.
# Mutant: the trap taken out must leave the folder.
#   bash scripts/test_gates_tmp.sh
set -uo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
fails=0
ok() { echo "ok   $1"; }
bad() { echo "FAIL $1"; fails=$((fails + 1)); }
R="$tmp/repo"; mkdir -p "$R" && git -C "$R" init -q
echo a > "$R/a.txt"; git -C "$R" add -A && git -C "$R" -c user.name=t -c user.email=t@t commit -qm base
base="$tmp/base"; mkdir -p "$base" "$tmp/bin"
# stub cargo: `cargo test` leaves a folder and a file in TMPDIR (what a killed or failing test does); STUB_TEST decides the result
cat > "$tmp/bin/cargo" <<'S'
#!/usr/bin/env bash
if [ "$1" = test ]; then
  mkdir "$TMPDIR/.tmpLEAK"; echo x > "$TMPDIR/fs-leak.png"; echo "$TMPDIR" > "$STUB_SEEN"
  [ -n "${STUB_RO:-}" ] && { mkdir -p "$TMPDIR/ro/sub"; chmod 500 "$TMPDIR/ro"; }
  [ -n "${STUB_SLEEP:-}" ] && sleep "$STUB_SLEEP"
  exit "${STUB_TEST:-0}"
fi
exit 0
S
printf '#!/usr/bin/env bash\nexit 0\n' > "$tmp/bin/python3"
chmod +x "$tmp/bin/cargo" "$tmp/bin/python3"
mkscripts() { mkdir -p "$1/scripts"; cp "$here/gates.sh" "$1/scripts/"; printf '#!/usr/bin/env bash\nexec "$@"\n' > "$1/scripts/limited.sh"; chmod +x "$1/scripts/limited.sh"; touch "$1/scripts/check_rust_rules.py"; }
run() { PATH="$tmp/bin:$PATH" TMPDIR_GATES="$base" STUB_SEEN="$tmp/seen" bash "$1/scripts/gates.sh" "$R" > "$tmp/out" 2>&1; }
mkscripts "$tmp/real"
run "$tmp/real"; rc=$?
{ [ "$rc" -eq 0 ] && [ -z "$(ls -A "$base")" ]; } && ok "ok run: base is empty afterwards" || bad "ok run: rc $rc, left: $(ls -A "$base")"
case "$(cat "$tmp/seen" 2>/dev/null)" in "$base"/gates-run.*) ok "the tests wrote below $base/gates-run.*" ;; *) bad "TMPDIR of the tests: $(cat "$tmp/seen" 2>/dev/null)" ;; esac
STUB_TEST=1 run "$tmp/real"; rc=$?
{ [ "$rc" -ne 0 ] && [ -z "$(ls -A "$base")" ]; } && ok "red run: rc $rc, base is empty afterwards" || bad "red run: rc $rc, left: $(ls -A "$base")"
STUB_SLEEP=4 run "$tmp/real" &
pid=$!
for _ in $(seq 1 50); do ls "$base"/gates-run.*/.tmpLEAK > /dev/null 2>&1 && break; sleep 0.1; done
pkill -TERM -P "$pid" -f "gates.sh" 2>/dev/null; kill -TERM "$pid" 2>/dev/null; wait "$pid" 2>/dev/null
sleep 0.5
[ -z "$(ls -A "$base")" ] && ok "SIGTERM: base is empty afterwards" || bad "SIGTERM: left: $(ls -A "$base")"
sleep 0.1 & dead=$!; wait "$dead"
sleep 5 & live=$!
mkdir -p "$base/gates-run.$dead.AAAAAA" "$base/gates-run.$live.BBBBBB" "$base/gates-run.abc.CCC" "$base/other"
run "$tmp/real"; rc=$?
kill "$live" 2>/dev/null; wait "$live" 2>/dev/null
{ [ "$rc" -eq 0 ] && [ ! -e "$base/gates-run.$dead.AAAAAA" ] && [ -d "$base/gates-run.$live.BBBBBB" ] && [ -d "$base/gates-run.abc.CCC" ] && [ -d "$base/other" ]; } \
  && ok "sweep: dead PID folder removed, live and foreign kept" || bad "sweep (rc $rc): $(ls -A "$base")"
rm -rf "$base"; mkdir -p "$base"
# a leftover that cannot be removed is a warning, not a red gate: in the EXIT trap and in the sweep
sleep 0.1 & dead=$!; wait "$dead"
mkdir -p "$base/gates-run.$dead.RO/ro/sub"; chmod 500 "$base/gates-run.$dead.RO/ro"
run "$tmp/real"; rc=$?
{ [ "$rc" -eq 0 ] && grep -q 'warning: could not remove' "$tmp/out"; } && ok "unremovable rest of a dead run in the sweep: rc 0 and a warning" || bad "unremovable (sweep): rc $rc: $(tail -3 "$tmp/out")"
chmod -R u+rwX "$base"; rm -rf "$base"; mkdir -p "$base"
# unremovable rest in the run folder of this run (the stub test makes a read-only folder)
STUB_RO=1 run "$tmp/real"; rc=$?
{ [ "$rc" -eq 0 ] && grep -q 'warning: could not remove' "$tmp/out"; } && ok "unremovable rest in the run folder: rc 0 and a warning" || bad "unremovable (trap): rc $rc: $(tail -3 "$tmp/out")"
chmod -R u+rwX "$base"; rm -rf "$base"; mkdir -p "$base"
# a relative TMPDIR_GATES is refused, rc 2
PATH="$tmp/bin:$PATH" TMPDIR_GATES="rel" bash "$tmp/real/scripts/gates.sh" "$R" > "$tmp/out" 2>&1; rc=$?
{ [ "$rc" -eq 2 ] && [ ! -e "$R/rel" ] && grep -q 'must be an absolute path' "$tmp/out"; } && ok "relative TMPDIR_GATES: rc 2" || bad "relative base: rc $rc"
mkscripts "$tmp/m"
sed -i '/^trap /d' "$tmp/m/scripts/gates.sh"
if cmp -s "$tmp/m/scripts/gates.sh" "$here/gates.sh"; then bad "mutant: the sed expression changed nothing"; else
  run "$tmp/m"
  [ -n "$(ls -A "$base")" ] && ok "mutant (no trap): a leftover stays (test would be red)" || bad "mutant not caught"
fi
rm -rf "$base"; mkdir -p "$base"
# mutant: a failing removal is fatal
mkscripts "$tmp/m3"
sed -i 's#rm -rf "\$1" 2>/dev/null || echo "gates: warning: could not remove \$1" >&2; return 0;#rm -rf "$1";#' "$tmp/m3/scripts/gates.sh"
if cmp -s "$tmp/m3/scripts/gates.sh" "$here/gates.sh"; then bad "mutant c: the sed expression changed nothing"; else
  STUB_RO=1 run "$tmp/m3"; rc=$?
  [ "$rc" -ne 0 ] && ok "mutant (failing removal is fatal): rc $rc (test would be red)" || bad "mutant c not caught"
fi
chmod -R u+rwX "$base"; rm -rf "$base"
[ "$fails" -eq 0 ] && echo "test_gates_tmp: all ok" || { echo "test_gates_tmp: $fails failed"; exit 1; }
