# fs-icons – Abhak-Liste

Stand: 2026-11-16 · Grundlage: Repo `/srv/FreeSynergy/fs-icons`; Urteile in `/srv/FreeSynergy/.scratch/icons-1` bis `icons-6`; Papier `/srv/FreeSynergy/.scratch/icon-namen-abgleich.md`
fs-icons ist ein Daten-Repo (SVG-Sätze), kein Programm. „Grundsache“: Programme und Katalog können Icons beziehen. Es gibt kein Tag und keinen Release; `origin` kennt nur `main` (91a34d3, 2026-03-30) und `ci-concurrency`.

## Erledigt (Beleg)
- [x] **GRUNDSACHE** Repo mit `manifest.toml`, Satz `homarrlabs` (MIT), Tests, `package.toml`, Containerfile (Commit 91a34d3 auf `origin/main`)
- [x] **GRUNDSACHE** Bau-Gate-Dateien, deny.toml (Commits 8a32967 bis 10e6ebe auf `origin/main`)
- [x] Entwurf der Programm-Icons (7 Programme in Farbe und symbolisch): (Commit 0ee1f9d) auf `unreviewed/program-icons-serious`, Urteile mit Bildern `/srv/FreeSynergy/.scratch/icons-6/uebersicht.png` und `alt-neu.png` (nur lokal, nicht auf origin)

## Offen
- [ ] **GRUNDSACHE** Lokale Branches sichern (nur auf diesem Rechner, nicht auf origin): `revive-icons`/`research-iconsets`/`research-signpath` (c5c4c4d: Sätze `freesynergy-theme`, `freesynergy-legacy`, We10X und Rust-Sync-Werkzeug entfernt), `unreviewed/program-icons-serious` (0ee1f9d), `unreviewed/program-icons` (22baad0, WIP), `unreviewed/program-icons-final` (6821533, WIP „nicht reviewt“)
- [ ] **GRUNDSACHE** Welcher der drei Programm-Icon-Stände gilt (serious, final, theme)? Entscheidung nach Bildern durch die Strategie [offen]
- [ ] **GRUNDSACHE** Review und Merge nach `main`; `scripts/gates.sh` lief laut Urteil Runde 5 in der Umgebung nicht (nur `check_svg.py`) [offen]
- [ ] **GRUNDSACHE** Jedes Katalogpaket braucht ein Icon (Katalog Schema 2 meldete 7 Fehler „every package needs an icon“, `straenge-vollgas.md`); Icons für die umbenannten Programme (text, draw, messages, activity, broadcast, inventory, forms) ergänzen
- [ ] **GRUNDSACHE** Programm-Icons am Ende der Umbenennung unter den neuen Programmnamen führen
- [ ] SPÄTER Erstes Tag und Release (ohne Tag, README nennt Sätze und Gates)
- [ ] SPÄTER People-Icon bei 16 und 24 px unterscheidbar machen (Urteil `icons-6/URTEIL.md`: bei 16 px nur Ahnung)
- [ ] SPÄTER Abgleich der Namen mit fs-components (47 Glyphen, nur 5 gleichnamig: search, close, check, warning, copy)
- [ ] SPÄTER Ursprung der Cursor-Sätze (`cursor-sets/`) bestätigen, weitere freie Sätze suchen (`research-iconsets`)
