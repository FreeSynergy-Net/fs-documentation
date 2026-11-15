# fs-audio – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0048, ADR 0086, E1, E2, E9; Strang-D-Plan `PLAN.md` Abschnitt 5 (Entscheidungen E1–E20)
Programm: Aufnahme, Schnitt, Wiedergabe. Standards: verlustfrei FLAC; Ogg Opus (RFC 6716, 7845) erst nach E1; PCM intern; MIDI 1.0 später.
Die Strang-D-Dateien liegen bisher nur in `/srv/FreeSynergy/.scratch/strang-d/` und sind noch nicht in fs-documentation eingecheckt.

## Dossier und Vorbereitung
- [x] Erstes Dossier und Recherche vorhanden (Beleg: `/srv/FreeSynergy/.scratch/strang-d/dossier-fs-audio.md`, `recherche-audio-devices.md, recherche-opus-rust.md`; nicht eingecheckt)
- [ ] **GRUNDSACHE** Dossier-Nachzug (E6, Lauf `dossier`) vor dem ersten Vorbild-Frontend; das Admin-Frontend darf vorher entstehen. Lücken: Audacity: Datei, Bearbeiten, Transport, Erzeugen, Effekt, Analysieren (Einzelpunkte), Startfenster, Export-Ablauf; Ardour: Transport/Edit/Region/Track/View; Speicher-Abfrage beim Beenden; Apple- und Windows-Vorbild fehlen
- [ ] SPÄTER Dossiers nach fs-documentation übernehmen (Pfad [offen])

## Spikes, Recherchen, Nachträge
- [ ] **GRUNDSACHE** Spike Aufnahme-Latenz mit `cpal` [offen]
- [ ] **GRUNDSACHE** E2 umsetzen: `symphonia` (MPL-2.0) nur als unveränderte Abhängigkeit, `cargo deny` mit Lizenzliste; ADR-0016-Nachtrag (Strategie)
- [ ] SPÄTER E1: Rust-Opus-Encoder aus `recherche-opus-rust.md` auswählen; Prüfung objektiv (mit `opus-decoder` dekodieren, gegen RFC-6716/8251-Testvektoren); Patentlage/Rechtsgutachten vor crates.io-Veröffentlichung
- [ ] SPÄTER MIDI 1.0: Lizenz der Spezifikation [offen]

## Trait festlegen
- [ ] **GRUNDSACHE** Trait-Skizze (Ziel v1, PLAN.md Abschnitt 5) prüfen und festlegen: `Projects`, `Tracks`, `Regions`, `Sources`, `Transport`; Anbieter `AudioPorts`, `AudioDecoder`, `AudioEncoder`; `Exchange`. Stand: nur Skizze, nicht festgelegt
- [ ] **GRUNDSACHE** Wire-Vertrag `schema/<thema>.capnp` in fs-interfaces (ADR 0045)
- [ ] **GRUNDSACHE** Grenz-Trait `Exchange` mit Medientyp (E15, PLAN.md 1.4); Formate liefern Anbieter außerhalb der Traits
- [ ] Nicht Unterstütztes antwortet mit `Unsupported` (ADR 0045) und ist im Frontend sichtbar gesperrt (ADR 0066)

## Kern (typisiert nach ADR 0086, CLI)
- [ ] **GRUNDSACHE** Speicherung typisiert nach ADR 0086 gegen den v5-Entwurf von fs-objects im eigenen Zweig (E7): `audio_project`, `track`, `source` (Datei FLAC/WAV als `FileRef`), `region`, `marker`, `automation_point` (später), `audio_credit` (PersonRef)
- [ ] **GRUNDSACHE** Keine JSON- und keine Blob-Spalten; Ausnahmen nur `original`, Medien als `FileRef` (E9), Chiffrat (E4)
- [ ] **GRUNDSACHE** Gerät öffnen, Mono-/Stereospur aufnehmen, abspielen
- [ ] **GRUNDSACHE** Ausschnitt setzen, Anfang/Ende löschen
- [ ] **GRUNDSACHE** Export FLAC (`flacenc`)
- [ ] **GRUNDSACHE** Projekt speichern/laden, Beenden
- [ ] SPÄTER Export Opus (nach E1)
- [ ] SPÄTER Mehrspur-Mischen, Effekte, Automation, MIDI
- [ ] **GRUNDSACHE** CLI nach ADR 0063: `fs-audio new|record|play|trim|export|devices|serve|admin`
- [ ] **GRUNDSACHE** Programm startet, kann einfache Dinge und lässt sich beenden (ADR 0087 Punkt 7)

## Frontend (Baustein-Zuordnung zuerst)
- [ ] **GRUNDSACHE** Schritt `baustein-zuordnung`: Baustein-Analyse vor dem Bauen; fehlende Bausteine entstehen in `fs-components`, nie im Programm (ADR 0066)
- [ ] **GRUNDSACHE** Bausteine fehlen: Spur-Zeitleiste mit Regionen (`timeline`-Familie erweitern), Wellenform, Pegelanzeige, Teiler, Dialog
- [ ] **GRUNDSACHE** Admin-Frontend aus der Typbeschreibung
- [ ] SPÄTER Frontend Einfach (Vorbild Audacity), Mehrspur (Vorbild Ardour), Apple-/Windows-Stil (Vorbild [offen])
- [ ] SPÄTER Kein Blinc-Standardlook: cn-Bausteine nur über Wrapper, je Stil gestylt (ADR 0074)

## Doku
- [ ] **GRUNDSACHE** Programmseite in fs-documentation (Workflow `doku-mitziehen`) und diese Liste mitziehen
- [ ] SPÄTER Handbuch, Beispiele, Facetten-Seiten

## Bilder und Abnahme
- [ ] **GRUNDSACHE** Bilder des Frontends: erst Bilder, dann Strategie-OK, dann Release
- [ ] SPÄTER Abnahme der Vorbild-Frontends durch Durchgehen der Arbeitsabläufe aus dem Dossier

## Repo anlegen (erst nach Strategie-OK)
- [ ] **GRUNDSACHE** Repo anlegen über `programm-neu` (E13: Bündel 0.0.7 zuerst mergen). Stand: Repo `fs-audio` existiert nicht (404 laut PLAN.md); Anlegen durch den Nutzer (E14)
- [ ] **GRUNDSACHE** Kern-Crate `fs-audio-core`, Bin `fs-audio`, `fs-audio-app` nach ADR 0063
