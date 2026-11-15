# fs-history (bald fs-activity) – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0020, 0073, 0076 Regel 6, 0087; Plan `/srv/FreeSynergy/.scratch/plan-umbenennen-activity.md`; Vorab-Stände `/srv/FreeSynergy/.scratch/vorab-staende-strang-c.md`; Repo `/srv/FreeSynergy/fs-history`
Tags auf GitHub: `v0.0.1` (2026-11-08). Lokal alte Tags `v0.1.0`, `v0.1.1`, `v0.2.0`. Lokal ist alles sauber (`main` = `origin/main` d865c44).

## Erledigt (Beleg)
- [x] **GRUNDSACHE** Programmkern: Einträge (abgeleiteter Index, keine Nutzlast), Zeitleiste, Filter, Seitenblättern, Digest, Vergessen mit Grabsteinen (Tag `v0.0.1`, `DESIGN.md` State, 49 Tests)
- [x] **GRUNDSACHE** Beobachter über Port `ActivitySource` und Hub-Adapter `fs-history-hub` gegen einen echten Hub (`crates/fs-history-hub` auf `main`)
- [x] **GRUNDSACHE** Pedantic-clippy-Gate auf `main` grün (Commit d865c44)

## Grundsache: startet, einfache Dinge, beenden, Frontend
- [ ] **GRUNDSACHE** Typbeschreibung für Entry und Digest, Server `fs-history-server` (Cap'n Proto über Socket, mit Test), App mit Diagrammen, `release.yml` – nur auf `origin/r3-admin` (+9, 2026-11-10, lokal nie geholt); fs-types v0.0.11, CI rot
- [ ] **GRUNDSACHE** Empfehlung der Vorabstände: übernehmen (fs-types v0.0.19, Clippy, Merge); `forget` als Löschbefehl passt zu ADR 0076 Regel 6
- [ ] **GRUNDSACHE** Programm startet, zeigt die Zeitleiste, lässt sich beenden (Fenstertest mit Bild)
- [ ] **GRUNDSACHE** Frontend nach neuem System mit Dossier (R2); in der Doku gibt es noch keine Frontend-Ordner (de: 1 Datei)
- [ ] **GRUNDSACHE** Speicherung typisiert (ADR 0086) prüfen [offen]
- [ ] **GRUNDSACHE** Manifest bei fs-registry
- [ ] SPÄTER Echte Zeit des Ereignisses (`originalAt`) und Akteur (`originalActor`) kommen mit dem nächsten fs-hub-Tag
- [ ] SPÄTER Hub-Sitzung nach Abbruch neu verbinden; mehr als 16 Aktivitäten je Abruf
- [ ] SPÄTER Telemetrie-Import (OpenTelemetry), Zeiterfassung aus dem Verlauf, Teilen und Gruppenansichten

## Umbenennung fs-history → fs-activity (ADR 0087; kleiner Fall, kommt zuerst)
- [ ] **GRUNDSACHE** Vorab-Branch auf fs-types v0.0.19 heben (Branch nutzt v0.0.2, v0.0.8 oder v0.0.11) und pedantic clippy grün machen; CI der Vorab-Branches ist rot (Quelle `vorab-staende-strang-c.md`)
- [ ] **GRUNDSACHE** PR #1 `ci-concurrency` mergen oder schließen, bevor umbenannt wird (Stand 2026-11-15 offen; lokale Remote-Liste nicht aktuell) [offen]
- [ ] **GRUNDSACHE** Alt-Branches mit alten Crate-Namen: übernehmen oder archivieren (`archiv/<name>`-Tag), nicht offen lassen
- [ ] **GRUNDSACHE** `git fetch origin r3-admin` als erster Schritt (bisher nicht lokal)
- [ ] **GRUNDSACHE** Workflow `umbenennen` (Branch `rename-activity`, Crates `fs-activity-*`); im Merge den Namen noch nicht anfassen; GitHub-Umbenennung führt der Nutzer aus
- [ ] **GRUNDSACHE** `doku-mitziehen`: `docs/{de,en}/programs/apps/history/` (1 und 24 Dateien) nach `activity/`
- [ ] **GRUNDSACHE** fs-release `.fs/preapproved.toml` ergänzen
- [ ] SPÄTER Hub-Fähigkeiten `history.*` bleiben (Wire-Namen, Strategie-Entscheid offen)
- [ ] SPÄTER Passung des Namens „Activity“ (Nähe zu „activity log“) klären [offen, Nutzer]
- [ ] SPÄTER Erstes Release unter neuem Namen
