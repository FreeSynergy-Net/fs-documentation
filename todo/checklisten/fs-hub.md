# fs-hub – Abhak-Liste

Stand: 2026-11-16 · Quellen: DESIGN.md (Not done yet), README, Tags v0.0.1/v0.0.2
Hinweis: Belege sind Commit/Tag aus dem Repo (fs-hub, origin/main). Unklares steht als [offen].

## Grundlagen
- [x] **GRUNDSACHE** Daemon auf lokalem Unix-Socket, verweigert zweiten Hub, räumt auf (README; Tag v0.0.2, 1260264)
- [x] **GRUNDSACHE** Programme melden an (schreibt/liest), Pull-Position überlebt Neustart, Push/Pull/Ack/Live-Meldung mit Größenlimits (9ffb1db Daemon und Client, 4d6eba3 Kern hinter Traits, dbef167 Größenlimits)
- [x] **GRUNDSACHE** Sensible Daten werden nie gesammelt, ältere Kopie gelöscht (5f62a20 Test `sensitive_marks`; Regel in `DESIGN.md`)
- [x] **GRUNDSACHE** Pedantic-Clippy in Tests grün (Commit 63b52e1)
- [ ] **GRUNDSACHE** GitHub-Release für v0.0.2 [offen: keine Releases]
- [ ] **GRUNDSACHE** Hub per Hand starten ist genug für das Monatsziel; Start/Beenden sauber [offen: Prüfung]
- [ ] **GRUNDSACHE** Erkennung für fs-server über fs-hub (ADR 0082)

## Später
- [ ] SPÄTER Socket-Aktivierung (systemd), Installation bei Bedarf
- [ ] SPÄTER mDNS/DNS-SD, Namen, Domains, ACME, WebFinger (ADR 0028)
- [ ] SPÄTER OpenID Federation, P2P, Instanz-zu-Instanz (ADR 0035/0036)
- [ ] SPÄTER Peer-Authentifizierung über „gleiche uid" hinaus, Token je Programm
- [ ] SPÄTER Verschlüsselter Hub-Speicher, Schlüsseltresor (ADR 0024), Freigabe je Empfänger (ADR 0029)
- [ ] SPÄTER Windows Named Pipes; JSON/HTTPS-, CLI-, MCP-Zugänge aus dem Schema
- [ ] SPÄTER Log-Verdichtung, Tombstones, Konfliktbehandlung (heute letzter Schreiber gewinnt), Adressierung to/cc
