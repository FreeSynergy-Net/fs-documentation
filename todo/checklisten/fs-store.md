# fs-store – Abhak-Liste

Stand: 2026-11-16 · Quellen: DESIGN.md, Tags v0.0.13–v0.0.16, handoff-strategy (Dossier Welle 1/Nachbesserung Store/Discover)
Hinweis: Belege sind Commit/Tag aus dem Repo (/srv/FreeSynergy/fs-store, origin/main). Unklares steht als [offen].

## Grundlagen
- [x] **GRUNDSACHE** Programm startet, Fenster mit Start-Übersicht, Neu-Laden übersteht kaputte Lesung (Tag v0.0.16, Commit ddbb9ad)
- [x] **GRUNDSACHE** Pakete aus Git-Quellen, Katalog + Signaturprüfung (OpenPGP) vor der Installation (DESIGN.md „Rules fixed in code"; Tag v0.0.16, ba25fe9)
- [x] **GRUNDSACHE** Ein Programm `fs-store` (Fenster + `serve`, ADR 0063) und Update-Prüfung (`check`, `background`, `updates.toml`) (DESIGN.md; Tag v0.0.16)
- [x] **GRUNDSACHE** Meldungsleiste mit Verlauf, eine Bestätigung (Commit ddbb9ad)
- [ ] **GRUNDSACHE** README stimmt mit dem Stand überein (README sagt noch „Design only so far") [offen: Fix im Programm-Repo]
- [ ] **GRUNDSACHE** v0.0.16 ist Pre-release; Abnahme per Bilder -> Strategie-OK -> Release (Memory: Bilder vor Release) [offen: kein Bildbeleg in dieser Quelle]
- [ ] **GRUNDSACHE** Frontend nach Dossier Store/Discover (Plasma 6): Arbeitsabläufe durchgegangen (Dossier Welle 1 auf Doku-main; Nachbesserungen offen, handoff-strategy Punkt 8)
- [ ] **GRUNDSACHE** Beenden/Neustart nach Update ohne Hänger (Befund `.scratch/befund-update-neustart.md`) [offen: Status prüfen]
- [ ] **GRUNDSACHE** Texte MF2 de+en (ADR 0057) [offen: Stand unbekannt]

## Sicherheit und Vertrauen
- [ ] **GRUNDSACHE** Signaturprüfung: Ablauf/Widerruf von Schlüsseln und Subkeys beachten (DESIGN.md „OpenPGP check does not look at key or signature expiry, subkey flags or subkey revocation")
- [x] TUF-Client (erste Scheibe, `tough`) und TUF-Publisher (Commit 542cb99 „TUF publisher", c5c4eff)
- [ ] SPÄTER TUF eigener Root (Nutzer erzeugt Root-Schlüssel), TUF-Layout in fs-catalog, Timestamp wöchentlich neu signiert
- [ ] SPÄTER `store.capnp`-Schreibzugriffe (install/update/uninstall/addSource) erst, wenn der Aufrufer bekannt ist (ADR 0054); `job`, `subscribe`
- [ ] SPÄTER rpm über dnf auf CI-Runner erprobt (DESIGN.md „Not yet tried")

## Kataloge und Ausbau
- [ ] SPÄTER Katalog-Arten server/workflow/module (ADR 0077), Paketquellen apt/dnf (ADR 0078, fs-packages)
- [ ] SPÄTER `replaces`-Katalogfeld (Umzug fs-wiki -> fs-text, ADR 0080)
- [ ] SPÄTER Schema 2 Katalog (neutrales Server-Icon, 7 Icon-Fehler)
- [ ] SPÄTER Jira-Kürzel/Nachbesserungen Store-Dossier
