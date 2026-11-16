# fs-tasks – Abhak-Liste

Stand: 2026-11-16 · Quellen: DESIGN.md, Tags v0.0.1–v0.0.8, Arbeitsstand der Strategie, nicht veröffentlicht (A1–A12), plan-dossiers-welle1
Hinweis: Belege sind Commit/Tag aus dem Repo (fs-tasks, origin/main). Unklares steht als [offen].

## Grundlagen
- [x] **GRUNDSACHE** Aufgaben anlegen/ändern/zuweisen/etikettieren/verknüpfen/löschen, VTODO-Import/-Export, Meldung bei Änderung (README; Tag v0.0.8, 9272796)
- [x] **GRUNDSACHE** Arbeitsboard für Arbeiter/Agenten (CLI next/claim/status/note/check) und Abhängigkeiten sichtbar (Lückenliste A7, A11; Tag v0.0.8)
- [x] **GRUNDSACHE** Speichern im Fenster ist Compare-and-Set; Aufrufe mit Zeitlimit (Commit d3226f1)
- [x] **GRUNDSACHE** Live-Verdrahtung des Fensters, ein Server für Fenster und Befehlszeile getestet (Commit d24076d)
- [ ] **GRUNDSACHE** A3 Zuweisen im Fenster (Feld „Assigned to") und CLI `assign`/`unassign` (Lückenliste: teilweise)
- [ ] **GRUNDSACHE** A8 „Wer hat was": Filter „Assigned to" in Board und Tagesliste mit Zählern
- [ ] **GRUNDSACHE** A4 Fälligkeit ganztägig als reines Datum, keine erfundene 17:00 (ADR 0085, Welle-1-Bugfix)
- [ ] **GRUNDSACHE** A12 Texte MF2 de+en (ADR 0057; Pin fs-components v0.0.13 -> mindestens v0.0.19)
- [ ] **GRUNDSACHE** Zuständige als `PersonRef` (ADR 0085; hängt an fs-interfaces)
- [ ] **GRUNDSACHE** Release v0.0.8 ist Pre-release; Bilder -> Strategie-OK
- [ ] **GRUNDSACHE** Aufgabe im Seitenfeld bearbeiten (Eingabefelder; braucht fs-components)
- [ ] **GRUNDSACHE** Frontend nach Dossier Things 3/Jira abgenommen (Arbeitsabläufe)

## Später
- [ ] SPÄTER A5 Kommentare (Verweis auf Kommentar-Thema, gehört nicht in fs-tasks)
- [ ] SPÄTER A6 eigene Spalten/Boards (Draht `Boards` in `tasks.capnp` unsupported)
- [ ] SPÄTER A9 Suchleiste in Board/Tagesliste
- [ ] SPÄTER A10 Wiederholung (mit fs-calendar)
- [ ] SPÄTER Karten per Maus ziehen (fs-components)
- [ ] SPÄTER Things T3/T6–T9/T12, Jira J3–J9
- [ ] SPÄTER Zonen im Fenster (Einstellung der Zone fehlt)
- [ ] SPÄTER Seitenzählung O(n² log n) im Store; `list`/`query` unbegrenzt
