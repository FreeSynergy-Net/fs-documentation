# fs-maps – Abhak-Liste

Stand: 2026-11-16 · Quellen: DESIGN.md, README, Tags v0.0.1–v0.0.4, RESEARCH.md
Hinweis: Belege sind Commit/Tag aus dem Repo (fs-maps, origin/main). Unklares steht als [offen].

## Grundlagen
- [x] **GRUNDSACHE** PMTiles lokal/remote lesen, Cache mit Größenlimit und 7 Tagen Ablauf, Region für Offline mit Schätzung/Limit/Abbruch (README; Tag v0.0.4)
- [x] **GRUNDSACHE** Richtlinien eingebaut: keine OSM-Tile-Server, klarer User-Agent, wenige Anfragen (README, DESIGN.md „Policy rules")
- [x] **GRUNDSACHE** `fs-maps --version` (Smoke-Test) (Commit aa15f01)
- [x] **GRUNDSACHE** Stopp-Signale vor Bind registriert, Lease-Tests grün (Commit 404d14f)
- [x] **GRUNDSACHE** Review-Funde behoben (Kästen, Name, Stichwörter, Unsicherheit, Zeitlimits) (Commit 6bd9f35)
- [ ] **GRUNDSACHE** Release: v0.0.3 und v0.0.4 sind Draft [offen: Veröffentlichung nach Bildern + Strategie-OK]
- [ ] **GRUNDSACHE** Frontend nach Dossier Welle B (OSM) abgenommen
- [ ] **GRUNDSACHE** Orte (`Places`) im Fenster; Personen-Verweis [offen: Stand]
- [ ] **GRUNDSACHE** Texte MF2 de+en [offen]
- [ ] **GRUNDSACHE** Entscheidung: welche PMTiles-Quelle FreeSynergy standardmäßig bietet (kein Hotlinking Protomaps) [offen: Nutzerentscheidung]

## Später (DESIGN.md „Unsupported" und „Open points")
- [ ] SPÄTER Ebenen (`MapLayer`: find/create/change/delete, refresh, invite)
- [ ] SPÄTER Höhenprofil (`Place.elevationProfile`)
- [ ] SPÄTER Regionen: Byte-Bereiche zusammenfassen, parallel laden; bessere Schätzung
- [ ] SPÄTER Cache gzip auf Platte
