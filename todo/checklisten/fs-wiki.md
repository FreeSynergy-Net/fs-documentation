# fs-wiki (bald fs-text) – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0080, 0084, 0087; Plan `/srv/FreeSynergy/.scratch/plan-umbenennen-text.md` und `plan-umzug-wiki-nach-text.md`; CHANGELOG in `/srv/FreeSynergy/fs-wiki`; Nutzertest `/srv/FreeSynergy/.scratch/api-runner/followups-wiki-0013.md`
Nur dieses Programm ist veröffentlicht (Katalog). Auf GitHub gelten Tags `v0.0.1` bis `v0.0.12`; alte lokale Tags `v0.1.0` bis `v0.5.0` stammen aus der Zeit vor dem Reset.

## Erledigt (Beleg)
- [x] **GRUNDSACHE** Kern, Server, Client, Fenster, eine Binärdatei `fs-wiki` (`DESIGN.md`, Crates unter `crates/`; Tag `v0.0.10`)
- [x] **GRUNDSACHE** Tag v0.0.11: Dialoge Anlegen/Umbenennen/Löschen/Verwerfen, ein Titel, eine Leiste in Confluence, MF2-Wörter (Tag `v0.0.11`, Commit aeebecf)
- [x] **GRUNDSACHE** Tag v0.0.12: Kästchen anklickbar (`tick_ops`), Mehrzahl „1 Seite/2 Seiten“, Text des Nutzers byte-genau (Tag `v0.0.12`, Commits 9763110, 408175d, 62366fb)
- [x] **GRUNDSACHE** Frontends Notion und Confluence mit Abnahmebildern (`.scratch/wiki-0013-bilder/*-de-*.png` und `*-en-*.png`)
- [x] **GRUNDSACHE** Baum nach Speichern und Anlegen neu gebaut, geöffnete Seite markiert (Commit 40d7f51 auf `unreviewed/wiki-0013`)

## 0.0.13 (Branch `unreviewed/wiki-0013`, Kopf fdc2ab6; älterer Stand `unreviewed/wiki-0.0.13`, 1209814)
Baut auf fs-components 0.0.20. Dort gibt es noch kein Tag (siehe `fs-components.md`).
- [x] **GRUNDSACHE** Abnahmetests U1 bis U8 im Wiki-Fenster, Bilder `.scratch/wiki-0013-bilder/` (Commit 1209814; Bilder `u1-u2-kaestchen.png`, `u3-schreibflaeche.png`, `u3-nach-enter.png`, `u3-wechsel.png`, `u4-u6-breite-1900.png`, `u6-breite-1300.png`, `u6-volle-breite-1900.png`, `u7-u8-tabelle-code.png`)
- [x] **GRUNDSACHE** Wörter des Fensters einmal je Sprache (Commit 68fc16b)
- [ ] **GRUNDSACHE** fs-components Tag `v0.0.20` zuerst; dann Pin von lokalem Pfad-Patch auf das Tag setzen (CHANGELOG 0.0.13 sagt „Tag gibt es noch nicht“)
- [ ] **GRUNDSACHE** Opus-Review von Kopf fdc2ab6 (kein `review-wiki-0013*` vorhanden)
- [ ] **GRUNDSACHE** Bilder zum Strategie-OK, dann Merge, Tag `v0.0.13`, Release
- [ ] **GRUNDSACHE** Nutzertest durch Fable (etwa 2026-11-21): U1/U2 klicken, U3 Schreibfläche in einem echten Fenster mit echter Maus und Tastatur (Fenstertests klicken nur im Prozess)
- [ ] SPÄTER Doppelte Wörterdateien gegen die Wörter aus fs-components abbauen (Folgepunkt 0.0.12)
- [ ] SPÄTER Strg+V und Menü im echten Fenster testen (Szenario für KWin-Rig)

## Umbenennung fs-wiki → fs-text (ADR 0080, 0087; Pilot)
- [ ] **GRUNDSACHE** Workflow `umbenennen` bereit (Review-Stand siehe `fs-release.md`)
- [ ] **GRUNDSACHE** Gate A: 0.0.13 veröffentlicht (Tag, Release, Katalog)
- [ ] **GRUNDSACHE** Platzhalter-Repo `fs-text` (nur README/DESIGN, keine Tags) sichern oder löschen; Nutzer führt aus
- [ ] **GRUNDSACHE** Repo auf GitHub umbenennen (Nutzer); Crates `fs-text-model`, `fs-text-core|server|client|testserver|app`; Binärdatei `fs-text` mit Link `fs-wiki`
- [ ] **GRUNDSACHE** Datenkopie-Test mit Fixture 0.0.10/0.0.12, byte-genau
- [ ] **GRUNDSACHE** `replaces` bauen (Katalog Schema 2, Store-Update-Erkennung, rpm Obsoletes, deb Replaces); Pflicht vor dem ersten Release als fs-text
- [ ] **GRUNDSACHE** Erstes Release als fs-text (nach `v0.0.13`), Katalogeintrag mit `replaces = ["fs-wiki"]`; Bilder vor Release
- [ ] **GRUNDSACHE** Doku-Ordner `docs/{de,en}/programs/apps/wiki/` nach `text/` verschieben (95 und 126 Dateien am 2026-11-15), `doku-mitziehen` grün
- [ ] **GRUNDSACHE** 18 Worktrees von fs-wiki klären (Inventar `.scratch/inventar-fs-wiki-worktrees.md`)
- [ ] SPÄTER Facette „Wiki“ als Pilot (ADR 0061 Punkt 7), danach Draw-Facette Whiteboard
- [ ] SPÄTER HTML-Export und Web-Frontend (Websites aus Texten), eigener ADR
- [ ] SPÄTER Schnittstelle `texts.capnp`: Eigner-Name in fs-interfaces wechseln (nur Kommentar); Wire-Namen bleiben (ADR 0080)
- [ ] SPÄTER Schnittstelle `texts` Entwurf, Verbraucher 0 von 2 (DESIGN: Stand „draft“)
