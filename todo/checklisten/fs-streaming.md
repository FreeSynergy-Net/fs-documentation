# fs-streaming (bald fs-broadcast) – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0087; Plan `/srv/FreeSynergy/.scratch/plan-umbenennen-broadcast.md`; Vorab-Stände `/srv/FreeSynergy/.scratch/vorab-staende-strang-c.md`; Repo `/srv/FreeSynergy/fs-streaming`
Tags auf GitHub: `v0.0.1` (2026-11-08). Lokal alte Tags `v0.1.0`, `v0.2.0`.

## Erledigt (Beleg)
- [x] **GRUNDSACHE** Stufe 1: weiterleiten und aufnehmen ohne Decodierung: RTMP-Eingang, Weiterleitung an RTMP- und RTMPS-Ziele, FLV-Aufnahme, Zustandsautomaten, Schlüssel als Geheimnis (Tag `v0.0.1`, `DESIGN.md` State, 94 Tests mit echten Sockets und `ffmpeg`)
- [x] **GRUNDSACHE** `ffmpeg`-Test auf dem Runner abschaltbar (Commit 287dff9 auf `main`)

## Grundsache: startet, einfache Dinge, beenden, Frontend
- [ ] **GRUNDSACHE** Typbeschreibung für Stream und Target, App mit Fenster, Backend mit Ändern/Suchen/Ausführen auf fs-types v0.0.11, `release.yml` – nur auf `origin/r4-admin-v11` (+6, Kopf fe3eda3; enthält `r4-admin` vollständig); CI rot (2 Clippy-Fehler in `tests/describe.rs`)
- [ ] **GRUNDSACHE** Empfehlung der Vorabstände: übernehmen (der reifste der drei Stände): fs-types v0.0.19, Clippy grün, mergen, `r4-admin` auf origin löschen
- [ ] **GRUNDSACHE** Programm startet, zeigt Streams und Ziele, lässt sich beenden (Fenstertest mit Bild)
- [ ] **GRUNDSACHE** Frontend nach neuem System mit Dossier (R2); Doku hat 10 Frontend-Ordner, Bau steht aus
- [ ] **GRUNDSACHE** Stream-Schlüssel (Entscheidung 10) ist blockiert; was fehlt, steht im DESIGN auf `r4-admin-v11` [offen]
- [ ] **GRUNDSACHE** Speicherung typisiert (ADR 0086) prüfen [offen]
- [ ] **GRUNDSACHE** Manifest bei fs-registry
- [ ] SPÄTER Echte Plattform testen (bisher nur Loopback mit `ffmpeg`)
- [ ] SPÄTER Begrenzung der Versuche je Quelladresse, Übergabe der Aufnahme an fs-files, capnp-Server, Rest der Wurzelkommentar-Liste im Vertrag
- [ ] SPÄTER Rust-Encoder für Audio (Opus) statt C-Bibliothek, ADR 0087 Nachtrag

## Umbenennung fs-streaming → fs-broadcast (ADR 0087)
- [ ] **GRUNDSACHE** Vorab-Branch auf fs-types v0.0.19 heben (Branch nutzt v0.0.2, v0.0.8 oder v0.0.11) und pedantic clippy grün machen; CI der Vorab-Branches ist rot (Quelle `vorab-staende-strang-c.md`)
- [ ] **GRUNDSACHE** PR #1 `ci-concurrency` mergen oder schließen, bevor umbenannt wird (Stand 2026-11-15 offen; lokale Remote-Liste nicht aktuell) [offen]
- [ ] **GRUNDSACHE** Alt-Branches mit alten Crate-Namen: übernehmen oder archivieren (`archiv/<name>`-Tag), nicht offen lassen
- [ ] **GRUNDSACHE** Workflow `umbenennen` (Branch `rename-broadcast`, Crates `fs-broadcast-*`); GitHub-Umbenennung führt der Nutzer aus
- [ ] **GRUNDSACHE** `doku-mitziehen`: `docs/{de,en}/programs/apps/streaming/` (74 und 109 Dateien) nach `broadcast/`
- [ ] **GRUNDSACHE** fs-release `.fs/preapproved.toml` ergänzen
- [ ] SPÄTER Wort „streaming“ als KI-Text-Strom nicht blind ersetzen (Homonym im Plan)
- [ ] SPÄTER Erstes Release unter neuem Namen
