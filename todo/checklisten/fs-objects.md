# fs-objects – Abhak-Liste

Stand: 2026-11-16 · Quellen: DESIGN.md, README, Tags v0.0.1/v0.6.0, handoff-strategy Punkt 7, plan-storage (Memory: Speicherung typisiert)
Hinweis: Belege sind Commit/Tag aus dem Repo (fs-objects, origin/main). Unklares steht als [offen].

## Grundlagen
- [x] **GRUNDSACHE** Objekte speichern, lesen, abfragen, löschen; Änderung + Protokolleintrag atomar; Undo/Redo je Akteur dauerhaft (README „What it can do today"; Tag v0.0.1, 7cf0f05)
- [x] **GRUNDSACHE** Version auf 0.0.N zurückgesetzt (ADR 0064) (Commit 7cf0f05)
- [x] **GRUNDSACHE** Pedantic-Clippy-Gate grün (Commit d7df4a9, nach v0.0.1)
- [ ] **GRUNDSACHE** Neuer Tag ab main (main liegt 2 Commits nach v0.0.1: 84768fb, d7df4a9) und GitHub-Release [offen: keine Release-Einträge]
- [ ] **GRUNDSACHE** Speicherung typisiert (ADR 0086, Nutzer: kein JSON/Blob, primitive Typen); heute `content` = JSON-Text [offen: Entscheidung/Umsetzungsweg]
- [ ] **GRUNDSACHE** ADR 0085 Grenze: Zeiten UTC + Zone in `fs-types::DateTime` (Welle-1-Bugfix, Basis für Kalender/Tasks)
- [ ] **GRUNDSACHE** PersonRef `{ id, art, abzug }` (ADR 0085) als Typ bereitstellen [offen: Typ der `id` ungeklärt]

## Später
- [ ] SPÄTER Volltextsuche/Ranking, Sortierung nach CLDR (DESIGN.md „Open points")
- [ ] SPÄTER `location` (AS2) als Hüllenfeld; `describes` nicht nur exakt
- [ ] SPÄTER Fernzugriff über JSON/HTTPS; Tombstones für synchronisierte Löschungen
- [ ] SPÄTER `max_steps` je Akteur statt global
