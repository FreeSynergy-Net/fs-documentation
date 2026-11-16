# fs-surveys (bald fs-forms) – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0087 (Punkt 2 und Nachtrag 4: Umfrage, Abstimmung, Anmeldung werden Facetten); Repo `fs-surveys`
Tags auf GitHub: `v0.0.1` (2026-11-08). Lokal alte Tags `v0.1.0` bis `v0.3.0`. Es gibt **keinen** Umbenennungsplan in Arbeitsstand der Strategie, nicht veröffentlicht und der Vorab-Stand steht nicht in `vorab-staende-strang-c.md`.

## Erledigt (Beleg)
- [x] **GRUNDSACHE** Programmkern: Umfragen anlegen und bearbeiten, Fragen, Bedingungen, Zustände, benannte Antworten, anonyme Urnen mit Stapeln, Ergebnisse, CSV-Export, Ausweiten über Gruppen (Tag `v0.0.1`, `DESIGN.md` State)
- [x] **GRUNDSACHE** KI-Teilnehmer: Erlaubnis je Umfrage, Kennzeichnung, Zweifel zählt als KI (`DESIGN.md`, vorläufig)
- [x] **GRUNDSACHE** Pedantic-clippy-Gate auf `main` grün (Commit f5b21fd)
- [x] **GRUNDSACHE** Branch `origin/r3-frontend` (adb9e91): Typbeschreibungen Survey, Question, SurveyResponse, Decision, `fs-surveys-server`, erzeugtes Admin-Fenster (Commits fbe3ff5, 7c349bf, adb9e91; nicht auf `main`)

## Grundsache: startet, einfache Dinge, beenden, Frontend
- [ ] **GRUNDSACHE** `r3-frontend` prüfen, auf fs-types v0.0.19 heben, Clippy, mergen (Stand der CI und der Pins nicht geprüft) [offen]
- [ ] **GRUNDSACHE** Programm startet, zeigt Umfragen, lässt sich beenden (Fenstertest mit Bild)
- [ ] **GRUNDSACHE** Frontend nach neuem System mit Dossier (R2); in der Doku keine Frontend-Ordner (de: 3 Dateien)
- [ ] **GRUNDSACHE** Speicherung typisiert (ADR 0086) prüfen [offen]
- [ ] **GRUNDSACHE** Manifest bei fs-registry
- [ ] SPÄTER Echte Zustellung der Tokens (wartet auf fs-messages/fs-messenger), DDI-Export, `survey.publicLink` und `poll.embed` (`Unsupported`)
- [ ] SPÄTER Facetten Umfrage, Abstimmung, Anmeldung als eigene Menüeinträge (ADR 0061)

## Umbenennung fs-surveys → fs-forms (ADR 0087)
- [ ] **GRUNDSACHE** Umbenennungsplan schreiben (wie `plan-umbenennen-*.md`): Fundstellen, Branches, Namensfreiheit (`fs-forms` war am 2026-11-16 auf GitHub frei)
- [ ] **GRUNDSACHE** Vorab-Branches `r3-frontend` und `ai-participants` übernehmen oder archivieren
- [ ] **GRUNDSACHE** Workflow `umbenennen`; GitHub-Umbenennung führt der Nutzer aus
- [ ] **GRUNDSACHE** `doku-mitziehen`: `docs/{de,en}/programs/apps/surveys/` (3 und 39 Dateien) nach `forms/`
- [ ] **GRUNDSACHE** fs-release `.fs/preapproved.toml` ergänzen
- [ ] SPÄTER Erstes Release unter neuem Namen
