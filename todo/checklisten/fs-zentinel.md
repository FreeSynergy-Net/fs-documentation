# fs-zentinel – Abhak-Liste

Stand: 2026-11-16 · Quellen: README, docs/ROADMAP.md, known-limits.md, Tag v26.11_2, Branch unreviewed/upstream-26.11_3, .scratch/zentinel-*.md
Hinweis: Belege sind Commit/Tag aus dem Repo (/srv/FreeSynergy/fs-zentinel, origin/main). Unklares steht als [offen].
Regel: Kein Agent und keine KI auf echten Servern; der Mensch führt aus (ADR 0079).

- [x] **GRUNDSACHE** Signierter Mirror des Maker-Releases (Sigstore cosign + SHA-256), Quell-Tarball, Lizenzen (README; Commit 9d9b30d)
- [x] **GRUNDSACHE** Release v26.11_2 veröffentlicht (Pre-release, Tag v26.11_2, Objekt fec8e44; 2026-11-14)
- [x] **GRUNDSACHE** KDL-Vorlage `config/zentinel.kdl` ohne Geheimnisse; Hinweis zu `ca-cert` bei privater CA (Commit 2f7cccd)
- [x] **GRUNDSACHE** Doku en/de, Export, Roadmap, bekannte Grenzen (Commit 9d9b30d)
- [x] **GRUNDSACHE** .deb amd64 und arm64 im Release v26.11_2 veröffentlicht, Signatur 2026-11-16 neu gegen release-signing-key.asc geprüft (GOODSIG/VALIDSIG 16A4…4342), Prüfsummen stimmen; CI auf fec8e44 grün
- [ ] **GRUNDSACHE** Review-Vermerk zu fec8e44 (Delta-Review „nach dem Fix JA ohne neues Review“) [offen]
- [ ] **GRUNDSACHE** Katalogeintrag `kind=server`: Branch `unreviewed/catalog-zentinel` (fs-catalog, Köpfe siehe Bericht) reviewen und nach main; erst grün, wenn fs-interfaces `gateway.reverse-proxy` (planned, Branch unreviewed/planned-capabilities) getaggt ist und `capabilities_ref` darauf zeigt
- [ ] **GRUNDSACHE** rpm bauen und signieren (Ziel rpm+deb+OCI, ADR 0077 §3; zur Aufnahme genügt rpm ODER deb)
- [ ] **GRUNDSACHE** OCI-Archiv bauen, signieren (.asc), ADR 0078 Punkt 5
- [ ] **GRUNDSACHE** Server-Icon: neutrales `icons/server.png` im Katalog vorhanden; Entscheidung, ob ein eigenes Zentinel-Icon folgt [offen]
- [ ] SPÄTER Begründung, warum das Upstream-Image `ghcr.io/zentinelproxy/zentinel` nicht gespiegelt wird [offen]
- [ ] **GRUNDSACHE** Statische „im Umbau"-Seite für freesynergy.net / helfa.org / freeplanetearth.org (zentinel-static.md); Nutzer führt aus, Do 19.11. [offen]
- [x] **GRUNDSACHE** Hetzner-DNS-01 im Upstream auf neue Cloud-API umgestellt (Beleg: Upstream-Fix 42be3102 / PR #675, im Tag 26.11_3 = Commit 2bf39089, Release 2026-11-14; .scratch/beleg-zentinel-hetzner-neue-api.md)
- [ ] **GRUNDSACHE** Pin auf 26.11_3 im Mirror: Branch `unreviewed/upstream-26.11_3` (fs-zentinel, Kopf cc8d94b), Gates lokal grün (repo_tool check, shellcheck, verify-mirror-Selbsttest 35 PASS, test_render, test_serve mit 26.11_3-Binary); offen: Opus-Review des Kopfs, Tag v26.11_3 (Strategie), CI-Lauf mirror.yml (cosign, .deb), Pre-release
- [ ] **GRUNDSACHE** Hetzner-DNS-01 echt geprüft: Staging-Lauf mit neuem Hetzner-Cloud-Token (Read & Write im Projekt der Zone; alte DNS-Console-Tokens gehen nicht); Nutzer legt Token an, nur Syntax lokal geprüft [offen]
- [x] SPÄTER Webhook-Adapter für Hetzner-DNS entfällt (Zentinel 26.11_3 kann Hetzner selbst; kein git-bug-Eintrag dazu vorhanden)
- [ ] SPÄTER Login-Agent gegen Kanidm (Forward-Auth)
- [ ] SPÄTER HTTP-zu-HTTPS-Weiterleitung (kein dokumentierter Handler in 26.11_1)
- [ ] SPÄTER Eigene Control-Plane in Rust (nach Runde 3b); Upstream-Agent nicht gespiegelt
- [ ] SPÄTER [offen] Warum `ca-cert` bei privater CA nicht wirkt (unbestätigt)
