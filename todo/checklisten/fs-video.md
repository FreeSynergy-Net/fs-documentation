# fs-video – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0048, ADR 0086, E1, E9, E15; Strang-D-Plan `PLAN.md` Abschnitt 7 (Entscheidungen E1–E20)
Programm: Videoschnitt. Standards: OpenTimelineIO (nicht recherchiert); Ausgabe AV1 + Opus (nach E1) in WebM; H.264 höchstens lesen.
Die Strang-D-Dateien liegen bisher nur in `/srv/FreeSynergy/.scratch/strang-d/` und sind noch nicht in fs-documentation eingecheckt.

## Dossier und Vorbereitung
- [x] Erstes Dossier und Recherche vorhanden (Beleg: `/srv/FreeSynergy/.scratch/strang-d/dossier-fs-video.md`, `recherche-kreativ.md, recherche-medien-av1-avif.md, recherche-opus-rust.md`; nicht eingecheckt)
- [ ] **GRUNDSACHE** Dossier-Nachzug (E6, Lauf `dossier`) vor dem ersten Vorbild-Frontend; das Admin-Frontend darf vorher entstehen. Lücken: Kdenlive: Einzelpunkte aller Menüs, Import, Render-Dialog; DaVinci Resolve: offizielles Handbuch fehlt, alle Abläufe; Leer-/Lade-/Fehlerzustände; Apple- und Windows-Vorbild offen (Resolve als Windows-Vorbild fraglich)
- [ ] SPÄTER Dossiers nach fs-documentation übernehmen (Pfad [offen])

## Spikes, Recherchen, Nachträge
- [ ] **GRUNDSACHE** Recherche WebM/Matroska-Muxer in Rust (fehlt laut PLAN.md)
- [ ] **GRUNDSACHE** AV1-Crates belegt prüfen (`rav1e`, `rav1d`; E9, `recherche-medien-av1-avif.md`), PATENTS-Datei (AOM Patent License 1.0) in Release-Pakete
- [ ] SPÄTER Recherche OpenTimelineIO: Spezifikation, Lizenz, Rust-Leser
- [ ] SPÄTER Tonspur erst nach E1-Ergebnis
- [ ] SPÄTER Rechenlast des Renders ohne Hardware; Vulkan Video als späteres Backend (ADR 0048)

## Trait festlegen
- [ ] **GRUNDSACHE** Trait-Skizze (Ziel v1, PLAN.md Abschnitt 7) prüfen und festlegen: `Projects`, `Media`, `Timeline`, `Preview`, `Render`; Anbieter `VideoDecoder`, `VideoEncoder`, `Muxer`; `Exchange`. Stand: nur Skizze, nicht festgelegt
- [ ] **GRUNDSACHE** Wire-Vertrag `schema/<thema>.capnp` in fs-interfaces (ADR 0045)
- [ ] **GRUNDSACHE** Grenz-Trait `Exchange` mit Medientyp (E15, PLAN.md 1.4); Formate liefern Anbieter außerhalb der Traits
- [ ] Nicht Unterstütztes antwortet mit `Unsupported` (ADR 0045) und ist im Frontend sichtbar gesperrt (ADR 0066)

## Kern (typisiert nach ADR 0086, CLI)
- [ ] **GRUNDSACHE** Speicherung typisiert nach ADR 0086 gegen den v5-Entwurf von fs-objects im eigenen Zweig (E7): `video_project`, `media_item`, `video_track`, `clip`, `effect`/`effect_param`, `transition`, `video_marker`, `render_job`
- [ ] **GRUNDSACHE** Keine JSON- und keine Blob-Spalten; Ausnahmen nur `original`, Medien als `FileRef` (E9), Chiffrat (E4)
- [ ] **GRUNDSACHE** Projekt anlegen, Clip ins Bin holen
- [ ] **GRUNDSACHE** Clip auf die Zeitleiste setzen, kürzen/teilen/löschen
- [ ] **GRUNDSACHE** Render nach WebM (AV1; Ton erst nach E1)
- [ ] **GRUNDSACHE** Speichern, Beenden
- [ ] SPÄTER Effekte, Übergänge, Knoten-Editor, OTIO-Austausch
- [ ] **GRUNDSACHE** CLI nach ADR 0063: `fs-video new|add|place|render|jobs|serve|admin`
- [ ] **GRUNDSACHE** Programm startet, kann einfache Dinge und lässt sich beenden (ADR 0087 Punkt 7)

## Frontend (Baustein-Zuordnung zuerst)
- [ ] **GRUNDSACHE** Schritt `baustein-zuordnung`: Baustein-Analyse vor dem Bauen; fehlende Bausteine entstehen in `fs-components`, nie im Programm (ADR 0066)
- [ ] **GRUNDSACHE** Vorschau im Projekt-Monitor (Blinc `media/`, Reife [offen])
- [ ] **GRUNDSACHE** Bausteine fehlen: Spur-Zeitleiste mit Clips (gemeinsam mit fs-audio), Wellenform, Teiler, Dialog
- [ ] **GRUNDSACHE** Admin-Frontend aus der Typbeschreibung
- [ ] SPÄTER Frontend Einfach (Vorbild Kdenlive), Apple-/Windows-Stil (Vorbild [offen])
- [ ] SPÄTER Kein Blinc-Standardlook: cn-Bausteine nur über Wrapper, je Stil gestylt (ADR 0074)

## Doku
- [ ] **GRUNDSACHE** Programmseite in fs-documentation (Workflow `doku-mitziehen`) und diese Liste mitziehen
- [ ] SPÄTER Handbuch, Beispiele, Facetten-Seiten

## Bilder und Abnahme
- [ ] **GRUNDSACHE** Bilder des Frontends: erst Bilder, dann Strategie-OK, dann Release
- [ ] SPÄTER Abnahme der Vorbild-Frontends durch Durchgehen der Arbeitsabläufe aus dem Dossier

## Repo anlegen (erst nach Strategie-OK)
- [ ] **GRUNDSACHE** Repo anlegen über `programm-neu` (E13: Bündel 0.0.7 zuerst mergen). Stand: Repo `fs-video` existiert nicht (404 laut PLAN.md); Anlegen durch den Nutzer (E14)
- [ ] **GRUNDSACHE** Kern-Crate `fs-video-core`, Bin `fs-video`, `fs-video-app` nach ADR 0063
