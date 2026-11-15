# fs-whiteboard (bald fs-draw) – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0076, 0087; Plan `/srv/FreeSynergy/.scratch/plan-umbenennen-draw.md`; Vorab-Stände `/srv/FreeSynergy/.scratch/vorab-staende-strang-c.md`; Repo `/srv/FreeSynergy/fs-whiteboard`
Tags auf GitHub: `v0.0.1` (2026-11-08). Lokal alte Tags `v0.1.0`, `v0.2.0`.

## Erledigt (Beleg)
- [x] **GRUNDSACHE** Programmkern ohne Oberfläche: Boards, Seiten, Elemente aller Arten, Merge je Eigenschaft, Zurück je Editor, Raumindex, Gruppen, eigenes Format, SVG-Export (Tag `v0.0.1`, `DESIGN.md` State, 104 Tests)
- [x] **GRUNDSACHE** Pedantic-clippy-Gate auf `main` grün (Commit c9c08b4, 2026-11-08)

## Grundsache: startet, einfache Dinge, beenden, Frontend
- [ ] **GRUNDSACHE** Typbeschreibung für Board, Page, Element (`aa0ec3a`), Befehle „supported“ aus der Tabelle und Standard-Suche (`e53ba52`) – nur auf `origin/r4-types-v11` (+4 gegen `main`), nicht auf `main`
- [ ] **GRUNDSACHE** App mit Fenster und Binärdatei `fs-whiteboard` (`0566c27`), `release.yml`, DESIGN (`7d025f1`) – nur auf Branch
- [ ] **GRUNDSACHE** Empfehlung der Vorabstände: Basis `r4-types-v11`, dazu `61fc8d2` (Test-Aufteilung aus `r4-admin`) per Cherry-pick; Branch `r4-admin` nach dem Merge löschen (die beiden Branches sind auseinandergelaufen)
- [ ] **GRUNDSACHE** Programm startet, zeigt ein Board, lässt sich beenden (Fenstertest mit Bild); laut DESIGN wartet die App auf das Frontend für fs-types v0.0.11
- [ ] **GRUNDSACHE** Frontend-Dossier mit Arbeitsabläufen (R2) und Frontend nach neuem System (Doku: 6 Frontend-Ordner)
- [ ] **GRUNDSACHE** Speicherung typisiert (ADR 0086) prüfen [offen]
- [ ] **GRUNDSACHE** Manifest bei fs-registry
- [ ] SPÄTER capnp-Server, Presence, Teilen, Bibliotheken, Vorlagen, Kommentare, PNG und PDF (`DESIGN.md`: nicht gebaut)
- [ ] SPÄTER Gleichzeitiges Arbeiten über Geräte (Merge-Funktion wird noch nirgends aufgerufen)

## Umbenennung fs-whiteboard → fs-draw (ADR 0087)
- [ ] **GRUNDSACHE** Vorab-Branch auf fs-types v0.0.19 heben (Branch nutzt v0.0.2, v0.0.8 oder v0.0.11) und pedantic clippy grün machen; CI der Vorab-Branches ist rot (Quelle `vorab-staende-strang-c.md`)
- [ ] **GRUNDSACHE** PR #1 `ci-concurrency` mergen oder schließen, bevor umbenannt wird (Stand 2026-11-15 offen; lokale Remote-Liste nicht aktuell) [offen]
- [ ] **GRUNDSACHE** Alt-Branches mit alten Crate-Namen: übernehmen oder archivieren (`archiv/<name>`-Tag), nicht offen lassen
- [ ] **GRUNDSACHE** Platzhalter-Repo `fs-draw` auf GitHub: Nutzer entscheidet löschen oder `fs-draw-archive` (am 2026-11-15 vorhanden, gleiche Dateien wie fs-text, keine Tags; gh-Abfrage am 2026-11-16 liefert 404, daher prüfen) [offen]
- [ ] **GRUNDSACHE** Workflow `umbenennen` (Branch `rename-draw`); GitHub-Umbenennung führt der Nutzer aus
- [ ] **GRUNDSACHE** `doku-mitziehen`: `docs/{de,en}/programs/apps/whiteboard/` (46 und 53 Dateien) nach `draw/`
- [ ] **GRUNDSACHE** fs-release `.fs/preapproved.toml` ergänzen
- [ ] SPÄTER Datenmarker `whiteboard-tombstone` und Themen-Dateien in fs-interfaces bleiben (Wire-Namen)
- [ ] SPÄTER Facette „Whiteboard“ von fs-draw nach dem Wiki-Pilot
- [ ] SPÄTER Erstes Release unter neuem Namen
