# fs-interfaces – Abhak-Liste

Stand: 2026-11-16 · Quellen: DESIGN.md, README, Tags v0.0.19 (lokal), handoff-strategy (v0.0.20)
Hinweis: Belege sind Commit/Tag aus dem Repo (/srv/FreeSynergy/fs-interfaces, origin/main). Unklares steht als [offen].

## Grundlagen
- [x] **GRUNDSACHE** Cap'n-Proto-Verträge: Gemeinsames, Aufgaben, Nachrichten, Hub, Personen, Gruppen, Dateien, Termine, Orte, Texte (README; Tag v0.0.19, 90e62c3)
- [x] **GRUNDSACHE** Erzeugter Rust-Code eingecheckt (kein Schema-Compiler im Normalbau) (3ef57ad)
- [x] **GRUNDSACHE** Gemeinsame Anbieter-Regel `Unsupported` + `Capabilities` (00b44e4)
- [x] **GRUNDSACHE** Ein Aufrufer-Zeitlimit für jede RPC-Verbindung (Commit 5fa4a8f); Fähigkeiten mit Anzeigename/Status (Commit 2e8bda1)
- [x] **GRUNDSACHE** v0.0.19: Store-Paketinfo, Fähigkeitsnamen, Kommentare-Entwurf, Aufgaben-Bereitschaft, Handshake (Commits edcaa00, 6f6392f)
- [ ] **GRUNDSACHE** Tag v0.0.20 (laut handoff-strategy veröffentlicht) lokal nicht gefunden [offen: Abgleich]
- [ ] **GRUNDSACHE** main liegt nach v0.0.19 weiter vorn (Commits 274bdd4, 2e8bda1, 90e62c3) -> neuer Tag, danach heben alle Programme gemeinsam (STOPP-Regel)
- [ ] **GRUNDSACHE** Flaky Test `rpc_handshake_race.rs:42` stabilisieren (q2-ci-causes U8)
- [ ] **GRUNDSACHE** PersonRef + DateTime UTC/Zone in `common.capnp` (ADR 0085)
- [ ] **GRUNDSACHE** Besitzer von `common.capnp` festlegen (ADR 0050 schlägt fs-objects vor)
- [ ] **GRUNDSACHE** Grenzen von `rpc` vor 1.0 schließen (DESIGN.md „Limits of rpc")

## Später
- [ ] SPÄTER Weitere Themen aus dem Katalog, bis zwei unabhängige Nutzer sie getestet haben, dann 1.0
- [ ] SPÄTER `fs-mcp`
- [ ] SPÄTER Kommentar-Thema (`comments.capnp`) fertig
