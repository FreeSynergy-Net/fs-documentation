# fs-files – Abhak-Liste

Stand: 2026-11-16 · Quellen: DESIGN.md, README, Tags v0.0.1–v0.0.10, Commits
Hinweis: Belege sind Commit/Tag aus dem Repo (/srv/FreeSynergy/fs-files, origin/main). Unklares steht als [offen].

## Grundlagen
- [x] **GRUNDSACHE** Ordner, Umbenennen, Verschieben, Kopieren, Papierkorb/Wiederherstellen/Löschen; fortsetzbare Uploads mit Prüfsumme (README; Tag v0.0.10, c04a44c)
- [x] **GRUNDSACHE** Lokaler Ordner mit echten Namen; S3-Backend (einmal gegen RustFS getestet) (4c9245d lokal unter echten Namen, 32ac9a8 S3 gegen RustFS)
- [x] **GRUNDSACHE** Datei-Fenster: Ansicht Liste/Raster im Menü Ansicht, gemerkt in `files-window.conf` (Commit 6194d6a)
- [x] **GRUNDSACHE** Upload ist beim Server angekommen, bevor das Fenster benutzt wird (Test, Commit 4c5e6c4); Windows-Pfad als `file:`-Link (Commit 25d6e26)
- [x] **GRUNDSACHE** Sortierung Ordner zuerst (Vertrag `Sort.foldersFirst`, fs-interfaces Commit 90e62c3)
- [ ] **GRUNDSACHE** Release v0.0.10 ist Pre-release; Abnahme per Bilder -> Strategie-OK
- [ ] **GRUNDSACHE** Frontend nach Dossier Welle 1 (Dateien) Arbeitsabläufe durchgegangen; Dateiwähler überall, wo ein Pfad gebraucht wird (Memory)
- [ ] **GRUNDSACHE** Datei-Tabelle = Tabellen-Baustein der fs-components-Familie `tables` (Baustein-Analyse)
- [ ] **GRUNDSACHE** Texte MF2 de+en [offen]
- [ ] **GRUNDSACHE** Umfang-Befund (`.scratch/befund-files-umfang.md`) auswerten [offen: Entscheidung]

## Nicht unterstützt (benannt, nicht vorgetäuscht; DESIGN.md „Unsupported")
- [ ] SPÄTER Vorschau, Freigaben/Rollen, Versionen, Tags, Duplikate, Inhaltssuche, Sperren
- [ ] SPÄTER Alben, Bilder-Bibliothek (Import, Metadaten, Orte)
- [ ] SPÄTER `Folder.archive`, `File.uploadResume` als Stream/`subscribe`
