# fs-calendar – Abhak-Liste

Stand: 2026-11-16 · Quellen: DESIGN.md, README, Tags v0.0.1–v0.0.4, plan-dossiers-welle1 (ADR 0085)
Hinweis: Belege sind Commit/Tag aus dem Repo (/srv/FreeSynergy/fs-calendar, origin/main). Unklares steht als [offen].

## Grundlagen
- [x] **GRUNDSACHE** Termine (JSCalendar RFC 8984), Wiederholungen mit Einzeländerungen, Zeitzonen, ICS/JSCalendar-Import/-Export (README; Tag v0.0.4, 95e70aa)
- [x] **GRUNDSACHE** `fs-calendar --version` / `-V` (Smoke-Test des Release-Workflows) (Commit bee266b)
- [x] **GRUNDSACHE** Verschieben eines Einzeltermins gegen den eigenen Start der Instanz (Commit 95e70aa)
- [x] **GRUNDSACHE** Bereichslesung merkt nur Revisionen der gezeigten Termine (Commits a06514f, 3dff42c)
- [x] **GRUNDSACHE** Messende Tests laufen nacheinander (zufälliges Rot behoben) (Commit 416964b)
- [ ] **GRUNDSACHE** Release v0.0.4 ist Draft, nicht veröffentlicht [offen: Veröffentlichung nach Bildern + Strategie-OK]
- [ ] **GRUNDSACHE** Frontend nach Dossier Welle B (Google/Outlook Kalender) abgenommen
- [ ] **GRUNDSACHE** ADR 0085: Einladungen mit Personen als `PersonRef`
- [ ] **GRUNDSACHE** ADR 0085: ganztägig = Datum, schwebende Zeit mit `zone_assumed`
- [ ] **GRUNDSACHE** Texte MF2 de+en [offen]

## Offene Fragen
- [ ] [offen] Form von `exportText` für mehrere Termine: JSON-Array oder JSCalendar `Group`
- [ ] [offen] Unbekannte `TZID` wird abgelehnt (vorläufig)

## Später
- [ ] SPÄTER Viele Overrides schreiben ist langsam (2 MiB/20 000 Overrides ca. 3 s); Speicherbedarf beim Schreiben großer Texte
- [ ] SPÄTER `privacy` allein erreicht die Hülle nicht (nur `freesynergy.net:sensitive`)
- [ ] SPÄTER Gemeinsamer Kalender-Raster-Baustein (plan-crate-familien)
