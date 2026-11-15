# fs-zentinel – Abhak-Liste

Stand: 2026-11-16 · Quellen: README, docs/ROADMAP.md, known-limits.md, Tag v26.11_2, .scratch/zentinel-*.md
Hinweis: Belege sind Commit/Tag aus dem Repo (/srv/FreeSynergy/fs-zentinel, origin/main). Unklares steht als [offen].
Regel: Kein Agent und keine KI auf echten Servern; der Mensch führt aus (ADR 0079).

- [x] **GRUNDSACHE** Signierter Mirror des Maker-Releases (Sigstore cosign + SHA-256), Quell-Tarball, Lizenzen (README; Commit 9d9b30d)
- [x] **GRUNDSACHE** Release v26.11_2 veröffentlicht (Pre-release, Tag v26.11_2, Objekt fec8e44; 2026-11-14)
- [x] **GRUNDSACHE** KDL-Vorlage `config/zentinel.kdl` ohne Geheimnisse; Hinweis zu `ca-cert` bei privater CA (Commit 2f7cccd)
- [x] **GRUNDSACHE** Doku en/de, Export, Roadmap, bekannte Grenzen (Commit 9d9b30d)
- [ ] **GRUNDSACHE** Zentinel als .deb [offen: unreviewed WIP]
- [ ] **GRUNDSACHE** Statische „im Umbau"-Seite für freesynergy.net / helfa.org / freeplanetearth.org (zentinel-static.md); Nutzer führt aus, Do 19.11. [offen]
- [ ] **GRUNDSACHE** Hetzner-DNS-Problem gelöst (zentinel-hetzner-dns.md) [offen]
- [ ] SPÄTER Login-Agent gegen Kanidm (Forward-Auth)
- [ ] SPÄTER HTTP-zu-HTTPS-Weiterleitung (kein dokumentierter Handler in 26.11_1)
- [ ] SPÄTER Eigene Control-Plane in Rust (nach Runde 3b); Upstream-Agent nicht gespiegelt
- [ ] SPÄTER [offen] Warum `ca-cert` bei privater CA nicht wirkt (unbestätigt)
