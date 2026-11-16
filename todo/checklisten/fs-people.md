# fs-people – Abhak-Liste

Stand: 2026-11-16 · Quellen: DESIGN.md, README, Tags v0.0.1–v0.0.12, GitHub-Releases
Hinweis: Belege sind Commit/Tag aus dem Repo (fs-people, origin/main). Unklares steht als [offen].

## Grundlagen
- [x] **GRUNDSACHE** Karten als JSContact (RFC 9553), Anlegen/Ändern/Löschen/Suchen, vCard-Import/-Export (README „What it can do today"; Tag v0.0.12, f376143)
- [x] **GRUNDSACHE** Fenster `fs-people-app`: Art eines neuen Eintrags als Auswahl, Medienfeld ohne Ton im Bildformular (Commits 2a49663, f6d9dda, f376143)
- [x] **GRUNDSACHE** Änderung erkennt „leeren" gespeicherte Leerwerte als Änderung (Commits 1209864, d21eee9)
- [x] **GRUNDSACHE** Stopp-Signal vor Bind, Lease-Wächter startet nach Signalregistrierung (Commit 69204d8, fs-interfaces v0.0.14)
- [ ] **GRUNDSACHE** Release veröffentlichen: v0.0.4 ist Draft, v0.0.12 hat laut `gh release list` keinen Eintrag [offen: lokale Tags v0.0.5–v0.0.12 ohne Release prüfen]
- [ ] **GRUNDSACHE** Abnahme Frontend per Dossier (Apple Kontakte, handoff-strategy Punkt 8) mit Bildern -> Strategie-OK
- [ ] **GRUNDSACHE** Namen = Personen-Verweis (ADR 0085): Personen-Verweis-Baustein bereitstellen, andere Programme verweisen statt zu kopieren
- [ ] **GRUNDSACHE** Texte MF2 de+en [offen: Stand unbekannt]

## Später
- [ ] SPÄTER JSContact `PatchObject`-Updates (heute ersetzt `update` die ganze Karte)
- [ ] SPÄTER CardDAV / Sync-Token (RFC 6352)
- [ ] SPÄTER Felder-weise `sensitive`-Filterung beim Export/Teilen (ADR 0029, Hub/Frontend)
- [ ] SPÄTER „Abgelehnte" Vorschläge werden gemerkt (Gleiche-Person-Vorschläge)
- [ ] SPÄTER vCard `PHOTO`/`KEY` getestet
