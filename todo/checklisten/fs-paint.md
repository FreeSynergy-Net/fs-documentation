# fs-paint – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0076 (Raster und Foto), ADR 0086, E3, E9; Strang-D-Plan `PLAN.md` Abschnitt 3 (Entscheidungen E1–E20)
Programm: Rasterbilder. Standards: OpenRaster `.ora`, PNG, ICC-Profile, OpenEXR; PSD nur Import; AVIF/JPEG/WebP als Export.
Die Strang-D-Dateien liegen bisher nur im internen Arbeitsstand der Strategie und sind noch nicht in fs-documentation eingecheckt.

## Dossier und Vorbereitung
- [x] Erstes Dossier und Recherche vorhanden (Beleg: Arbeitsstand der Strategie, nicht veröffentlicht, `recherche-kreativ.md (Formate: recherche-medien-av1-avif.md)`; nicht eingecheckt)
- [ ] **GRUNDSACHE** Dossier-Nachzug (E6, Lauf `dossier`) vor dem ersten Vorbild-Frontend; das Admin-Frontend darf vorher entstehen. Lücken: Krita: Datei-Menü-Einträge, Werkzeuge; Photoshop: alles (403); PhotoCraft: Zustände, Menüs; Lade-/Fehlerzustände; Windows-Vorbild fehlt (Krita und GIMP sind Linux-Programme)
- [ ] SPÄTER Dossiers nach fs-documentation übernehmen (Pfad [offen])

## Spikes, Recherchen, Nachträge
- [ ] **GRUNDSACHE** Lizenzprüfung `craft-libs/vendor/` vor jedem Git-Pin (E3); Grundsachen nur mit crates.io-Crates (`image`, `png`, `exr`, `moxcms`)
- [ ] SPÄTER Stifteingabe (Druck, Neigung) in Blinc [offen] (ADR 0015: Gesten mit Autor abstimmen)
- [ ] SPÄTER Leistung großer Bilder über Kacheln
- [ ] SPÄTER AVIF-Crates belegt prüfen (E9, `recherche-medien-av1-avif.md`) und PATENTS-Datei in Release-Pakete
- [ ] SPÄTER `canvas_kit` liegt auf altem Blinc-Pin, nur per `[patch]`: Umstellung klären

## Trait festlegen
- [ ] **GRUNDSACHE** Trait-Skizze (Ziel v1, PLAN.md Abschnitt 3) prüfen und festlegen: `Images`, `Layers`, `Pixels`, `Operations` (Filter, später); `Exchange`. Stand: nur Skizze, nicht festgelegt
- [ ] **GRUNDSACHE** Wire-Vertrag `schema/<thema>.capnp` in fs-interfaces (ADR 0045)
- [ ] **GRUNDSACHE** Grenz-Trait `Exchange` mit Medientyp (E15, PLAN.md 1.4); Formate liefern Anbieter außerhalb der Traits
- [ ] Nicht Unterstütztes antwortet mit `Unsupported` (ADR 0045) und ist im Frontend sichtbar gesperrt (ADR 0066)

## Kern (typisiert nach ADR 0086, CLI)
- [ ] **GRUNDSACHE** Speicherung typisiert nach ADR 0086 gegen den v5-Entwurf von fs-objects im eigenen Zweig (E7): `image`, `layer`, `layer_mask`, `fill_layer`/`adjust_layer`; Pixel als Datei in fs-files, in den Tabellen nur `FileRef` (E9)
- [ ] **GRUNDSACHE** Keine JSON- und keine Blob-Spalten; Ausnahmen nur `original`, Medien als `FileRef` (E9), Chiffrat (E4)
- [ ] **GRUNDSACHE** Bild neu/öffnen; Speichern als ORA, Export PNG/JPEG
- [ ] **GRUNDSACHE** Ebenen anlegen, sichtbar schalten, Deckkraft
- [ ] **GRUNDSACHE** Pinsel, Radierer, Farbwahl; Auswahl Rechteck/Lasso; Ausschneiden/Kopieren/Einfügen
- [ ] **GRUNDSACHE** Zuschneiden, Skalieren, Rückgängig, Zoom
- [ ] **GRUNDSACHE** Beenden mit Rückfrage
- [ ] SPÄTER Filter (`Operations`), PSD-Import, EXR/HDR, JPEG XL
- [ ] SPÄTER Nicht im Umfang: Smart Objects, KI, Skripte
- [ ] **GRUNDSACHE** CLI nach ADR 0063: `fs-paint new|import|export|layers|scale|serve|admin`; Facette `fs-photo` [Vorschlag Name]
- [ ] **GRUNDSACHE** Programm startet, kann einfache Dinge und lässt sich beenden (ADR 0087 Punkt 7)

## Frontend (Baustein-Zuordnung zuerst)
- [ ] **GRUNDSACHE** Schritt `baustein-zuordnung`: Baustein-Analyse vor dem Bauen; fehlende Bausteine entstehen in `fs-components`, nie im Programm (ADR 0066)
- [ ] **GRUNDSACHE** Leinwand (Viewport, Auswahl, Raster) per `blinc_canvas_kit`-Wrapper in `fs-components`
- [ ] **GRUNDSACHE** Bausteine fehlen: Dialog, Formularfelder (`slider`, `color_picker`), Teiler, Toast
- [ ] **GRUNDSACHE** Admin-Frontend aus der Typbeschreibung
- [ ] SPÄTER Frontend Einfach, Apple-Stil (Vorbild Pixelmator Pro [Vorschlag]), Windows-Stil (Vorbild Paint.NET [Vorschlag])
- [ ] SPÄTER Kein Blinc-Standardlook: cn-Bausteine nur über Wrapper, je Stil gestylt (ADR 0074)

## Doku
- [ ] **GRUNDSACHE** Programmseite in fs-documentation (Workflow `doku-mitziehen`) und diese Liste mitziehen
- [ ] SPÄTER Handbuch, Beispiele, Facetten-Seiten

## Bilder und Abnahme
- [ ] **GRUNDSACHE** Bilder des Frontends: erst Bilder, dann Strategie-OK, dann Release
- [ ] SPÄTER Abnahme der Vorbild-Frontends durch Durchgehen der Arbeitsabläufe aus dem Dossier

## Repo anlegen (erst nach Strategie-OK)
- [ ] **GRUNDSACHE** Repo anlegen über `programm-neu` (E13: Bündel 0.0.7 zuerst mergen). Stand: Platzhalter `FreeSynergy/fs-paint` existiert (7 KB, laut PLAN.md); Kern-Crate fehlt
- [ ] **GRUNDSACHE** Kern-Crate `fs-paint-core`, Bin `fs-paint`, `fs-paint-app` nach ADR 0063
