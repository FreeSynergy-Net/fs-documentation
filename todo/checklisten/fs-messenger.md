# fs-messenger (bald fs-messages) – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0018, 0045, 0054, 0087; Plan `/srv/FreeSynergy/.scratch/plan-umbenennen-messages.md`; Vorab-Stände `/srv/FreeSynergy/.scratch/vorab-staende-strang-c.md`; Repo `/srv/FreeSynergy/fs-messenger`
Tags auf GitHub: `v0.0.1`, `v0.0.2` (2026-11-08). Die lokalen Tags `v0.1.0` bis `v0.5.0` sind alt.

## Erledigt (Beleg)
- [x] **GRUNDSACHE** Programmkern ohne Oberfläche: Modell, Ablage als AS2-`Note`, Konversationen, Lesemarke, Entwürfe, Suche, Änderungsstrom (Tag `v0.0.1`, `DESIGN.md` Abschnitt State)
- [x] **GRUNDSACHE** KI-Wächter `fs-messenger-guard` und Verschlüsselung im Ruhezustand (Tag `v0.0.2`, Commit 6c38e3f)
- [x] **GRUNDSACHE** Anbieter für Mail und Matrix als eigene Crates (af440af `crates/fs-messenger-mail/src/lib.rs`, 863bda0 `crates/fs-messenger-matrix/src/lib.rs`; beide auf `main`)
- [x] **GRUNDSACHE** Export einer Unterhaltung als JSON Lines (AS2 `Note`) (`DESIGN.md` „Accepted ideas“ Nr. 10)

## Grundsache: startet, einfache Dinge, beenden, Frontend
- [ ] **GRUNDSACHE** Typbeschreibung (`DescribesType`) für Conversation, Message, Account, Draft aus einer Befehlstabelle; Stand liegt in zwei Fassungen vor: `origin/r4-admin` (alt, fs-types v0.0.2, CI rot) und `origin/unreviewed/r5-describe-v18` (neuer, 58ada6a, fs-interfaces v0.0.18, ohne App). Entscheidung der Vorabstände: Basis ist r5-describe-v18, die describe-Fassung von r4-admin verwerfen
- [ ] **GRUNDSACHE** Admin-App und Binärdatei `fs-messenger` aus `r4-admin` (Crates `fs-messenger-app`, `fs-messenger`, `release.yml`) auf r5 übernehmen und an v0.0.19 anpassen; auf `main` gibt es noch keine App
- [ ] **GRUNDSACHE** Programm startet, zeigt Konversationen und Nachrichten, lässt sich beenden (Fenstertest mit Bild)
- [ ] **GRUNDSACHE** Frontend-Dossier mit Arbeitsabläufen (R2) und Frontend nach neuem System; Doku hat 9 Frontend-Ordner (`docs/de/programs/apps/messenger/frontends`), Bau steht aus
- [ ] **GRUNDSACHE** Speicherung typisiert (ADR 0086): Prüfung `storage-typed-check`; heute Indexfelder als Text (`DESIGN.md` „Store layout (provisional)“) [offen]
- [ ] **GRUNDSACHE** Manifest bei fs-registry (was das Programm kann)
- [ ] SPÄTER capnp-Server, echte Anbieter im Betrieb, Lesebestätigungen senden (kein Anbieter sendet sie, `DESIGN.md`)
- [ ] SPÄTER Anhänge im Export; Senden ist nicht genau einmal (`DESIGN.md` Open points 1)
- [ ] SPÄTER Mail v4 neben v6: offene Punkte 3, 4, 6 aus der Prüfung vom 2026-11-08 (`DESIGN.md`)
- [ ] SPÄTER Reaktionen und Bearbeitungen (Plan auf `r5-describe-v18`, Commit 8c4cb79)

## Umbenennung fs-messenger → fs-messages (ADR 0087)
- [x] Zwei rein lokale Stände gesichert: `origin/unreviewed/r5-describe-v18` (58ada6a, 7 Commits) und `origin/unreviewed/release-profile` (fe70b46) liegen auf origin
- [ ] **GRUNDSACHE** Vorab-Branch auf fs-types v0.0.19 heben (Branch nutzt v0.0.2, v0.0.8 oder v0.0.11) und pedantic clippy grün machen; CI der Vorab-Branches ist rot (Quelle `vorab-staende-strang-c.md`)
- [ ] **GRUNDSACHE** PR #1 `ci-concurrency` mergen oder schließen, bevor umbenannt wird (Stand 2026-11-15 offen; lokale Remote-Liste nicht aktuell) [offen]
- [ ] **GRUNDSACHE** Alt-Branches mit alten Crate-Namen: übernehmen oder archivieren (`archiv/<name>`-Tag), nicht offen lassen
- [ ] **GRUNDSACHE** 12 Remote-Branches (ai, guard, mail, matrix, backup/…) als Archiv-Tags festhalten und löschen
- [ ] **GRUNDSACHE** Worktree `/srv/FreeSynergy/.wt-messenger-par` entfernen, nachdem alles gesichert ist
- [ ] **GRUNDSACHE** Workflow `umbenennen` laufen lassen (Branch `rename-messages`: Crates `fs-messages-*`, Binärdatei, `release.yml`); GitHub-Umbenennung führt der Nutzer aus
- [ ] **GRUNDSACHE** `doku-mitziehen`: `docs/{de,en}/programs/apps/messenger/` (102 und 151 Dateien) nach `messages/`
- [ ] **GRUNDSACHE** fs-release `.fs/preapproved.toml`: `fs-messages` aufnehmen
- [ ] SPÄTER Krypto-Kontext `FreeSynergy.Messenger ... v1` und Registry-Schlüssel `messenger.*` bleiben (Wire-Namen, Strategie-Entscheid offen)
- [ ] SPÄTER fs-interfaces: nur Kommentar „Owner program“ ändern
- [ ] SPÄTER `release-profile` (`.fs/release.toml`) liegt in 13 Repos nicht auf `main`; gehört zur Release-Kette
- [ ] SPÄTER Erstes Release unter neuem Namen mit Katalogeintrag (nie veröffentlicht, kein `replaces`)
