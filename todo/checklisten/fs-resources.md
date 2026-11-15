# fs-resources (bald fs-inventory) – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0075, 0076, 0087; Plan `/srv/FreeSynergy/.scratch/plan-umbenennen-inventory.md`; Vorab-Stände `/srv/FreeSynergy/.scratch/vorab-staende-strang-c.md`; Repo `/srv/FreeSynergy/fs-resources`
Tags auf GitHub: `v0.0.1` (2026-11-08). Lokal alte Tags `v0.1.0`, `v0.2.0`. Lokal ist alles sauber (`main` = `origin/main` 8cf27c5).

## Erledigt (Beleg)
- [x] **GRUNDSACHE** Programmkern: Ressourcen, Bestand, Reservierungen, Kapazität, Zuteilungen, Gruppenlast, Bedarf und Angebot mit Reservierung beim Annehmen (Tag `v0.0.1`, `DESIGN.md` State, 115 Tests mit echten Stores)
- [x] **GRUNDSACHE** Pedantic-clippy-Gate auf `main` grün (Commit 8cf27c5)

## Grundsache: startet, einfache Dinge, beenden, Frontend
- [ ] **GRUNDSACHE** Typbeschreibung für 6 Typen (Resource, Reservation, Need, Offer, Capacity, Allocation), `fs-resources-server`, App mit 6 Backends und Fenster – nur auf `origin/r3-types` (+7, Kopf 2ad8eff, 2026-11-10; lokal nie geholt); fs-types v0.0.11, CI rot
- [ ] **GRUNDSACHE** Empfehlung der Vorabstände: übernehmen (v0.0.19, Clippy, Merge)
- [ ] **GRUNDSACHE** Programm startet, zeigt Ressourcen, lässt sich beenden (Fenstertest mit Bild)
- [ ] **GRUNDSACHE** Frontend nach neuem System mit Dossier (R2); in der Doku keine Frontend-Ordner (de: 1 Datei)
- [ ] **GRUNDSACHE** Offer/Need gegen fs-marketplace (ADR 0075, Angebot/Gesuch) abgrenzen [offen, Strategie]
- [ ] **GRUNDSACHE** Speicherung typisiert (ADR 0086) prüfen [offen]
- [ ] **GRUNDSACHE** Manifest bei fs-registry
- [ ] SPÄTER capnp-Server (muss Kapazität und Zuteilung ablehnen, solange der Transport den Aufrufer nicht kennt), Kosten, MSPDI, Fähigkeiten

## Umbenennung fs-resources → fs-inventory (ADR 0087)
- [ ] **GRUNDSACHE** Name `fs-inventory` klären: Am 2026-11-15 leitete der Name auf das archivierte Repo `fs-inventory-archive` (2026-04-05) weiter; die gh-Abfrage am 2026-11-16 liefert 404. Nutzer entscheidet: Name freigeben oder anderer Name [offen]
- [ ] **GRUNDSACHE** Vorab-Branch auf fs-types v0.0.19 heben (Branch nutzt v0.0.2, v0.0.8 oder v0.0.11) und pedantic clippy grün machen; CI der Vorab-Branches ist rot (Quelle `vorab-staende-strang-c.md`)
- [ ] **GRUNDSACHE** PR #1 `ci-concurrency` mergen oder schließen, bevor umbenannt wird (Stand 2026-11-15 offen; lokale Remote-Liste nicht aktuell) [offen]
- [ ] **GRUNDSACHE** Alt-Branches mit alten Crate-Namen: übernehmen oder archivieren (`archiv/<name>`-Tag), nicht offen lassen
- [ ] **GRUNDSACHE** Workflow `umbenennen` (Branch `rename-inventory`, Crates `fs-inventory-*`); GitHub-Umbenennung führt der Nutzer aus
- [ ] **GRUNDSACHE** `doku-mitziehen`: `docs/{de,en}/programs/apps/resources/` (1 und 31 Dateien) nach `inventory/`
- [ ] **GRUNDSACHE** fs-release `.fs/preapproved.toml` ergänzen
- [ ] SPÄTER Wort „resource“ nicht blind ersetzen (MCP-Resource, REA)
- [ ] SPÄTER Passung „Inventory“ (Zeit und Fähigkeiten von Menschen sind laut ADR 0076 auch Ressourcen) klären
- [ ] SPÄTER Erstes Release unter neuem Namen
