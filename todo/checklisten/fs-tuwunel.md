# fs-tuwunel – Abhak-Liste

Stand: 2026-11-16 · Quellen: README, mirror.toml, Git-Log, fs-tuwunel#1, Podman-Tests
Hinweis: Belege sind Commit/Tag aus dem Repo (fs-tuwunel, origin/main). Unklares steht als [offen].
Regel: Kein Agent und keine KI auf echten Servern; der Mensch führt aus (ADR 0079).

- [x] **GRUNDSACHE** Gerüst: Mirror-Beschreibung (Upstream-Tag v2.0.0 gepinnt), Fähigkeits-Tags, öffentliche Konfiguration, Doku en/de, Export (Commit 97534b3)
- [x] **GRUNDSACHE** Startfehler behoben: Datenbank-Worker begrenzt (`max_workers = 256`, Task-Limit 2048), direct_io aus für ZFS (Commit 1610cf7, PR #1, Merge 01887e5)
- [x] **GRUNDSACHE** Texte zu Worker-Grenzen, Loopback vs. Container, io_uring (Commit ea178ab)
- [ ] **GRUNDSACHE** Erstes signiertes Release (CI baut aus gepinntem Commit, signiert) [offen: keine Tags/Releases auf GitHub]
- [ ] **GRUNDSACHE** Aufnahme in den Katalog (fs-catalog) [offen]
- [ ] **GRUNDSACHE** Start und Beenden im Podman-Test grün (SELinux, `:Z`, pids-limit) [offen: kein Beleg in den Quellen]
- [ ] SPÄTER Verbindung zu fs-messenger (Matrix, KI-Teilnehmer, ADR 0054)
- [ ] SPÄTER Upstream-Nachzug (Workflow `upstream-update`; Sync-Fehler in Forks, q2-ci-causes U4)
