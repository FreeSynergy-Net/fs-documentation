# fs-groups – Abhak-Liste

Stand: 2026-11-16 · Quellen: DESIGN.md, README, Tags v0.0.1/v0.4.0, Commit eb06008
Hinweis: Belege sind Commit/Tag aus dem Repo (fs-groups, origin/main). Unklares steht als [offen].

## Grundlagen
- [x] **GRUNDSACHE** Gruppen, Verschachtelung ohne Zyklen (Pfad benannt), Mitgliedschaft, Einladungen, Delegation (README; Tag v0.0.1, 7dbed81)
- [x] **GRUNDSACHE** Ein Programm `fs-groups` mit Fenster und `serve` über `groups.capnp` (Commit eb06008)
- [x] **GRUNDSACHE** Pedantic-Clippy grün in Tests; remote.rs in Module gesplittet (Commits 23e10c3, 8b4a458)
- [ ] **GRUNDSACHE** Neuer Tag ab main (2 Commits nach v0.0.1) und GitHub-Release [offen: keine Releases]
- [ ] **GRUNDSACHE** Aufrufer-Anmeldung: `add`/`remove`/`delete`/`grant`/`remove_parent` sind ungeschützt (DESIGN.md „Authenticated caller"); mindestens als bekannte Grenze im Fenster sichtbar [offen: Umfang]
- [ ] **GRUNDSACHE** Frontend nach Dossier (M365 Groups, Welle 2) abgenommen
- [ ] **GRUNDSACHE** Mitglieder als Personen-Verweis (ADR 0085)
- [ ] **GRUNDSACHE** Texte MF2 de+en [offen: Stand unbekannt]

## Offene Fragen an den Nutzer (DESIGN.md)
- [ ] [offen] Darf eine Gruppe ein Recht auf sich selbst halten?
- [ ] [offen] Einladung per Mail: Geheimnis/Token statt Zusicherung des Clients (`acceptProved`)
- [ ] [offen] Zwei Einstellungen und Zustimmung beidseitig (ADR 0056 „Einseitig folgen")

## Später
- [ ] SPÄTER `group.subscribe` und capnp-rpc-Server vollständig
- [ ] SPÄTER Antwort-Aktivitäten der Einladung (`put_and_log` Accept/Reject)
- [ ] SPÄTER Kanidm-Spiegel über fs-identity (ADR 0082)
