# fs-kanidm – Abhak-Liste

Stand: 2026-11-16 · Quellen: README, mirror.toml, Release v1.12.1, handoff-strategy (Server-Kette), ADR 0068/0082
Hinweis: Belege sind Commit/Tag aus dem Repo (fs-kanidm, origin/main). Unklares steht als [offen].
Regel: Kein Agent und keine KI auf echten Servern; der Mensch führt aus (ADR 0079).

- [x] **GRUNDSACHE** Signierter Build-Mirror: `mirror.toml` pinnt Upstream-Release samt Commit, CI baut, fügt Quell-Tarball und SBOM hinzu, signiert (README; Commit ce6edc8)
- [x] **GRUNDSACHE** Release Kanidm v1.12.1 veröffentlicht (Pre-release, Tag v1.12.1, Objekt cc1b740; 2026-11-13)
- [x] **GRUNDSACHE** Öffentliche Konfiguration `config/server.toml` mit `${vault:…}`-Platzhaltern, keine Geheimnisse (fa0887c; `config/server.toml`)
- [x] **GRUNDSACHE** Fähigkeits-Tags `capabilities.toml`, Doku en/de, Export (fa0887c; `capabilities.toml`)
- [x] **GRUNDSACHE** `verify-mirror.sh` gehärtet: jede VALIDSIG muss der erwartete Primärschlüssel sein, Selbsttest mit echten Schlüsseln (Commits f5da323, 31389df, 6cbc935; PR #5, #6)
- [ ] **GRUNDSACHE** Kanidm als .deb (Fix lld/`kanidmd version`/Abhängigkeiten, Review) [offen: unreviewed WIP]
- [ ] **GRUNDSACHE** Installation per Skript durch den Menschen, protokolliert (Workflow `server-einrichtung`); Kanidm startet und lässt sich beenden [offen: kein Beleg eines Laufs]
- [ ] **GRUNDSACHE** Im Katalog (fs-catalog) als Paket geführt (ADR 0077) [offen: Prüfung packages.toml]
- [ ] SPÄTER Anmeldung kanidm-unixd/PAM (Pilot 3, ADR 0082)
- [ ] SPÄTER Wöchentlicher Upstream-Nachzug (Workflow `upstream-update`; „Sync Upstream"-Fehler in Forks, q2-ci-causes U4/U5)
- [ ] SPÄTER Podman-Tests vollständig (SELinux, AVC-Prüfung, kein privileged)
