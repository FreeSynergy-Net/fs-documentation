#!/usr/bin/env python3
"""Generate index pages for folders that are linked but have no index.md.

MkDocs does not treat a link to a folder ("./primitives/basics/kbd/") as a page unless the
folder contains an index.md. For every such linked folder this script writes an index.md that
ONLY lists what lies inside (sub-pages, sub-folders; titles taken from the pages' own first
heading). No invented text. Works on docs/en and docs/de separately.

- Generated files start with the marker line MARKER. Only files with the marker are ever
  rewritten or removed; a hand-written index.md is never touched (and is never overwritten
  even if the marker is missing).
- Idempotent: a second run changes nothing. Stale generated pages (folder no longer linked,
  or a real index.md appeared next to it) are removed.
- Committed (like gen_frontend_indexes.py / gen_component_indexes.py), checked in CI with --check.
  (gen_decisions.py is different: it copies files from another place, so its output is ignored.)

Options: --check  exit 1 if anything would change     --dry-run  report only
"""
import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
LANGS = ("en", "de")
MARKER = "<!-- gen:folder-index (scripts/gen_folder_indexes.py) — generated, do not edit -->"
TEXT = {
    "en": {"note": "Automatically generated overview", "pages": "Pages", "folders": "Folders",
           "lead": "This page only lists what lies in this folder."},
    "de": {"note": "Automatisch erzeugte Übersicht", "pages": "Seiten", "folders": "Ordner",
           "lead": "Diese Seite listet nur auf, was in diesem Ordner liegt."},
}
LINK = re.compile(r"(?<!!)\[[^\]]*\]\(\s*<?([^)\s>]+)>?(?:\s+\"[^\"]*\")?\s*\)")
FENCE = re.compile(r"^\s*(```|~~~)")


def strip_code(text):
    out, fence = [], False
    for line in text.splitlines():
        if FENCE.match(line):
            fence = not fence
            continue
        if not fence:
            out.append(re.sub(r"`[^`]*`", "", line))
    return "\n".join(out)


def title_of(md, fallback):
    for line in md.read_text(encoding="utf-8").splitlines():
        m = re.match(r"^#\s+(.+?)\s*#*\s*$", line)
        if m:
            return m.group(1)
    return fallback


def is_generated(p):
    return p.is_file() and p.read_text(encoding="utf-8").startswith(MARKER)


def has_md(d):
    return any(d.rglob("*.md"))


def wanted_dirs(base):
    """Folders linked from a page that exist, contain pages and have no (hand-written) index.md."""
    want = set()
    for md in base.rglob("*.md"):
        text = strip_code(md.read_text(encoding="utf-8"))
        for m in LINK.finditer(text):
            t = m.group(1).split("#")[0].split("?")[0]
            if not t or re.match(r"^([a-z][a-z0-9+.-]*:|/)", t, re.I):
                continue
            if not (t.endswith("/") or "." not in t.rsplit("/", 1)[-1]):
                continue
            d = (md.parent / t).resolve()
            try:
                d.relative_to(base.resolve())
            except ValueError:
                continue
            if d.is_dir() and has_md(d):
                want.add(d)
    return {d for d in want if not (d / "index.md").exists() or is_generated(d / "index.md")}


def render(d, lang, wanted):
    t = TEXT[lang]
    name = d.name
    # sub-folders that get (or have) their own index are linked as folders; the pages of all
    # other sub-folders are listed directly, so nothing in the tree is unreachable
    folders = sorted(s for s in d.iterdir() if s.is_dir() and not s.name.startswith(".")
                     and (s in wanted or (s / "index.md").exists()))
    pages = sorted(p for p in d.rglob("*.md") if p.name != "index.md"
                   and not any(f in p.parents for f in folders)
                   and not any(x.startswith(".") for x in p.relative_to(d).parts))
    lines = [MARKER, "", f"# {name}", "", f"> {t['note']}. {t['lead']}", ""]
    if pages:
        lines += [f"## {t['pages']}", ""]
        lines += [f"- [{title_of(p, p.stem)}]({p.relative_to(d).as_posix()})" for p in pages]
        lines.append("")
    if folders:
        lines += [f"## {t['folders']}", ""]
        for s in folders:
            ti = title_of(s / "index.md", s.name) if (s / "index.md").exists() and not is_generated(s / "index.md") else s.name
            lines.append(f"- [{ti}]({s.name}/index.md)")
        lines.append("")
    return "\n".join(lines).rstrip() + "\n"


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--check", action="store_true")
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--root", default=str(ROOT), help="repository root (tests)")
    args = ap.parse_args()
    root = Path(args.root).resolve()
    changed = []
    for lang in LANGS:
        base = root / "docs" / lang
        if not base.is_dir():
            continue
        wanted = wanted_dirs(base)
        for d in sorted(wanted):
            idx = d / "index.md"
            text = render(d, lang, wanted)
            if idx.exists() and idx.read_text(encoding="utf-8") == text:
                continue
            changed.append(f"write {idx.relative_to(root).as_posix()}")
            if not (args.check or args.dry_run):
                idx.write_text(text, encoding="utf-8")
        for idx in sorted(base.rglob("index.md")):
            if is_generated(idx) and idx.parent not in wanted:
                changed.append(f"remove {idx.relative_to(root).as_posix()}")
                if not (args.check or args.dry_run):
                    idx.unlink()
    print(f"folder index pages {'to change' if (args.check or args.dry_run) else 'changed'}: {len(changed)}")
    for c in changed[:15]:
        print("  " + c)
    if len(changed) > 15:
        print(f"  … {len(changed) - 15} more")
    return 1 if (args.check and changed) else 0


if __name__ == "__main__":
    sys.exit(main())
