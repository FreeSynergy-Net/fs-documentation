# fs-documentation – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0086, 0087; Repo `/srv/FreeSynergy/fs-documentation` (nur `origin/main`, 5891b1eb; lokale `main` ist abgewichen und wird nicht angefasst)
fs-documentation hat keine Tags und keinen Release. Die Seite wird per `mkdocs` gebaut. Jede Programmänderung zieht ihre Doku mit (Workflow `doku-mitziehen`, Gate ROT sonst).

## Erledigt (Beleg)
- [x] **GRUNDSACHE** ADR 0086 „Gespeichert wird typisiert“ (Commit 89d0322a, 2026-11-15)
- [x] **GRUNDSACHE** ADR 0087 „Programmnamen sind generisch“ mit Umbenennungstabelle, Monatsziel Punkt 7, geplanten Programmen (Commits c85146b9, f27b06d7, 3c72a963, 6e6bab51, 3d218dca)
- [x] **GRUNDSACHE** Nutzertest fs-wiki 0.0.12 (U1 bis U8) festgehalten (Commit 971ad9e2)
- [x] **GRUNDSACHE** Ordner `todo/checklisten/` mit Regeln und fs-workflows (Commit 5891b1eb)
- [x] **GRUNDSACHE** Doku je Programm in `docs/{de,en}/programs/apps/<programm>/` (Stand: wiki 95/126, whiteboard 46/53, messenger 102/151, history 1/24, streaming 74/109, resources 1/31, surveys 3/39 Dateien; Zählung aus `git ls-tree origin/main`)

## Grundsache: Doku zieht mit
- [ ] **GRUNDSACHE** Ordner nach der Umbenennung verschieben (`git mv`, de und en): wiki → text, whiteboard → draw, messenger → messages, history → activity, streaming → broadcast, resources → inventory, surveys → forms; Navigation ist ordnerbasiert (awesome-pages)
- [ ] **GRUNDSACHE** `mkdocs build --strict` grün nach jedem Umbenennen (Linkprüfung); Weiterleitungs-Plugin ist nicht belegt [offen]
- [ ] **GRUNDSACHE** Doku-Seiten für Programme ohne Seite oder mit 1 Datei in `de`: history, resources, surveys (Programmseite mit Steckbrief und Frontend-Ordnern)
- [ ] **GRUNDSACHE** Programmseiten für fs-text (Doku nennt bisher nur `programs/apps/wiki/…`), fs-forms, fs-software und fs-registry anlegen
- [ ] **GRUNDSACHE** Doku der Frontend-Dossiers mit Arbeitsabläufen je Programm (R2); vorhanden: wiki 7, whiteboard 6, messenger 9, streaming 10 Ordner; history, resources, surveys keine
- [ ] **GRUNDSACHE** Hilfe, Roadmap (`docs/de/programs/roadmap.md`) und Karte (`map.md`) auf die neuen Namen setzen
- [ ] **GRUNDSACHE** Jede neue Checkliste (A, B, weitere Gruppen) auf `origin/main` bringen und bei Änderungen pflegen
- [ ] **GRUNDSACHE** Sammel-ADR „Umbenennungen“ (Folge von 0055/0080) und Folge-ADR zu ADR 0080 für „0.0.13 statt 0.0.11“ (laut `plan-umbenennen-uebersicht.md` Stufe S0) [offen; prüfen, ob ADR 0087 den Sammel-ADR ersetzt]
- [ ] SPÄTER Hilfe-Dateien auf Englisch vollständig gleichziehen (en hat mehr Dateien als de bei messenger, streaming, whiteboard)
- [ ] SPÄTER Redirect-Plugin für alte Doku-Adressen
- [ ] SPÄTER Checklisten wandern nach fs-tasks
