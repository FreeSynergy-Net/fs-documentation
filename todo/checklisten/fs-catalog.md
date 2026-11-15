# fs-catalog – Abhak-Liste

Stand: 2026-11-16 · Quellen: README, Tag v0.0.1, Git-Log (signierter catalog.xml)
Hinweis: Belege sind Commit/Tag aus dem Repo (/srv/FreeSynergy/fs-catalog, origin/main). Unklares steht als [offen].

- [x] **GRUNDSACHE** Referenzkatalog `catalog.xml` (AppStream) mit abgetrennter Signatur `catalog.xml.asc` durch CI (README; Commit 4b745f2)
- [x] **GRUNDSACHE** `scripts/gen_catalog.py` erzeugt den Katalog aus öffentlichen Releases, mit Test (Verzeichnis `scripts/`)
- [x] **GRUNDSACHE** Verify-Job: nur ausdrückliche Drafts toleriert, GOODSIG, Tag-Prüfung je Komponente (Commit 4308046)
- [x] **GRUNDSACHE** Katalog hebt Paket-Tags automatisch auf die neueste vollständige Release (Commits 2bb98b4, 4ef9af1)
- [ ] **GRUNDSACHE** Nur Pre-release-Pakete enthalten (README „Status: pre-release packages only"); Aufnahme der Kern-Programme (store, people, tasks, files, calendar, maps, wiki) prüfen [offen: Inhalt von `packages.toml` nicht ausgewertet]
- [ ] **GRUNDSACHE** Tag v0.0.1 liegt 28 Commits hinter main [offen: neuer Tag nötig?]
- [ ] SPÄTER TUF-Metadaten (ADR 0062)
- [ ] SPÄTER Katalog-Arten server/workflow/module (ADR 0077), Facetten, Schema 2
- [ ] SPÄTER Server im Katalog, überall installierbar (Memory „Server im Katalog")
- [ ] SPÄTER Feld `replaces` (ADR 0080)
