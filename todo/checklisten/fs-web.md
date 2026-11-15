# fs-web – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0087, ADR 0086, ADR 0009, E2, E10, E17; Strang-D-Plan `PLAN.md` Abschnitt 9 (Entscheidungen E1–E20)
Programm: Lesezeichen und Web-Archiv; Browser als Frontend. Standards: WHATWG Living Standards (Engine); W3C WebAuthn L3; Lesezeichen-Austausch und Archiv-Format nicht recherchiert (Kandidaten Netscape-Lesezeichendatei, WARC).
Die Strang-D-Dateien liegen bisher nur in `/srv/FreeSynergy/.scratch/strang-d/` und sind noch nicht in fs-documentation eingecheckt.

## Dossier und Vorbereitung
- [x] Erstes Dossier und Recherche vorhanden (Beleg: `/srv/FreeSynergy/.scratch/strang-d/dossier-fs-web.md`, `recherche-web-learning-vault.md, recherche-browser-engine.md`; nicht eingecheckt)
- [ ] **GRUNDSACHE** Dossier-Nachzug (E6, Lauf `dossier`) vor dem ersten Vorbild-Frontend; das Admin-Frontend darf vorher entstehen. Lücken: Firefox: Tabs, Adressleiste, Verlauf, Kürzel (alle Seiten nicht ladbar); Chrome Desktop: Verlauf-Menü (nur Android belegt), Download-Speicherort; Leer-/Fehlerzustand
- [ ] SPÄTER Dossiers nach fs-documentation übernehmen (Pfad [offen])

## Spikes, Recherchen, Nachträge
- [ ] **GRUNDSACHE** Spike E10: Blitz in Blinc einbetten plus reine Rust-JS-Engine (Boa, quickjs-oxide, Kataan?, `rquickjs` nur als C-Rückfall) hinter `WebEngine`; Ergebnis in `recherche-browser-engine-spike.md`
- [ ] **GRUNDSACHE** E2/MPL-2.0: Stylo (MPL-2.0) nur als unveränderte Abhängigkeit; Fundstelle der Entscheidung E2 [offen] (Recherche fand sie nicht in fs-documentation)
- [ ] SPÄTER Recherche Web-Archiv (WARC) und Lesezeichen-Austausch
- [ ] SPÄTER Sicherheitsmodell: Prozess-Trennung der Engine [offen]

## Trait festlegen
- [ ] **GRUNDSACHE** Trait-Skizze (Ziel v1, PLAN.md Abschnitt 9) prüfen und festlegen: `Bookmarks`, `Folders`, `Archive`; Anbieter `WebEngine`, `WebView`; `Exchange`. Stand: nur Skizze, nicht festgelegt
- [ ] **GRUNDSACHE** Wire-Vertrag `schema/<thema>.capnp` in fs-interfaces (ADR 0045)
- [ ] **GRUNDSACHE** Grenz-Trait `Exchange` mit Medientyp (E15, PLAN.md 1.4); Formate liefern Anbieter außerhalb der Traits
- [ ] Nicht Unterstütztes antwortet mit `Unsupported` (ADR 0045) und ist im Frontend sichtbar gesperrt (ADR 0066)

## Kern (typisiert nach ADR 0086, CLI)
- [ ] **GRUNDSACHE** Speicherung typisiert nach ADR 0086 gegen den v5-Entwurf von fs-objects im eigenen Zweig (E7): `bookmark`, `bookmark_tag`, `bookmark_folder`, `archive_item`, `web_setting`; Verlauf gehört fs-activity, Downloads fs-files (E17)
- [ ] **GRUNDSACHE** Keine JSON- und keine Blob-Spalten; Ausnahmen nur `original`, Medien als `FileRef` (E9), Chiffrat (E4)
- [ ] **GRUNDSACHE** Seite öffnen; Tabs öffnen/wechseln/schließen; Adresse oder Suche eingeben
- [ ] **GRUNDSACHE** Lesezeichen setzen und finden (Ordner, Schlagworte)
- [ ] **GRUNDSACHE** Verlauf ansehen (über fs-activity); Download starten, in der Liste öffnen/entfernen (fs-files)
- [ ] **GRUNDSACHE** Starten, Beenden
- [ ] SPÄTER Archiv ganzer Seiten (`Archive`), Lesezeichen-Import/-Export
- [ ] SPÄTER Erweiterungen, Sync, Profile, Entwicklerwerkzeuge
- [ ] **GRUNDSACHE** CLI nach ADR 0063: `fs-web open|bookmarks|bookmark|archive|import|export|serve|admin`
- [ ] **GRUNDSACHE** Programm startet, kann einfache Dinge und lässt sich beenden (ADR 0087 Punkt 7)

## Frontend (Baustein-Zuordnung zuerst)
- [ ] **GRUNDSACHE** Schritt `baustein-zuordnung`: Baustein-Analyse vor dem Bauen; fehlende Bausteine entstehen in `fs-components`, nie im Programm (ADR 0066)
- [ ] **GRUNDSACHE** Web-Ansicht (Engine-Fläche) als neuer Baustein, nach Spike E10
- [ ] **GRUNDSACHE** Bausteine fehlen: Dialog, Toast, Teiler
- [ ] **GRUNDSACHE** Admin-Frontend aus der Typbeschreibung
- [ ] SPÄTER Frontend im Stil von Chrome/Chromium (Kürzel und Downloads belegt), Firefox-Vorbild nach Dossier-Nachzug; Apple-/Windows-Stil
- [ ] SPÄTER Kein Blinc-Standardlook: cn-Bausteine nur über Wrapper, je Stil gestylt (ADR 0074)

## Doku
- [ ] **GRUNDSACHE** Programmseite in fs-documentation (Workflow `doku-mitziehen`) und diese Liste mitziehen
- [ ] SPÄTER Handbuch, Beispiele, Facetten-Seiten

## Bilder und Abnahme
- [ ] **GRUNDSACHE** Bilder des Frontends: erst Bilder, dann Strategie-OK, dann Release
- [ ] SPÄTER Abnahme der Vorbild-Frontends durch Durchgehen der Arbeitsabläufe aus dem Dossier

## Repo anlegen (erst nach Strategie-OK)
- [ ] **GRUNDSACHE** Repo anlegen über `programm-neu` (E13: Bündel 0.0.7 zuerst mergen). Stand: Repo `fs-web` existiert nicht (404 laut PLAN.md); Anlegen durch den Nutzer (E14)
- [ ] **GRUNDSACHE** Kern-Crate `fs-web-core`, Bin `fs-web`, `fs-web-app` nach ADR 0063
