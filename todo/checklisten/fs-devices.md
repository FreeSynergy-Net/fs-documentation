# fs-devices – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0087, ADR 0086, E5, E17; Strang-D-Plan `PLAN.md` Abschnitt 8 (Entscheidungen E1–E20)
Programm: Geräte und Sensoren. Standards: W3C WoT Thing Description 1.1; MQTT 5.0; Matter (Ziel-Adapter).
Die Strang-D-Dateien liegen bisher nur im internen Arbeitsstand der Strategie und sind noch nicht in fs-documentation eingecheckt.

## Dossier und Vorbereitung
- [x] Erstes Dossier und Recherche vorhanden (Beleg: Arbeitsstand der Strategie, nicht veröffentlicht, `recherche-audio-devices.md`; nicht eingecheckt)
- [ ] **GRUNDSACHE** Dossier-Nachzug (E6, Lauf `dossier`) vor dem ersten Vorbild-Frontend; das Admin-Frontend darf vorher entstehen. Lücken: openHAB: Menübeschriftungen Things/Items/Sitemaps; Home Assistant: Lade-/Fehlerzustand, offizielle Bestätigung Reiter „Entities“; Robotik-Vorbild fehlt; Apple-/Windows-Vorbild offen
- [ ] SPÄTER Dossiers nach fs-documentation übernehmen (Pfad [offen])

## Spikes, Recherchen, Nachträge
- [ ] **GRUNDSACHE** Schema `devices` in fs-interfaces anlegen (fehlt laut Dossier)
- [ ] SPÄTER Katalog-Einträge der Brücken `zigbee2mqtt` und `zwave-js-server` (Art `server`, E5) nach Strategie-OK
- [ ] SPÄTER Zugang zu Matter-/Zigbee-/Z-Wave-Spezifikationen [offen]
- [ ] SPÄTER Rechte für Schreibbefehle über `groups` [Vorschlag]

## Trait festlegen
- [ ] **GRUNDSACHE** Trait-Skizze (Ziel v1, PLAN.md Abschnitt 8) prüfen und festlegen: `Devices`, `Discovery`, `Channels`, `Sources`, `DeviceProtocol`; `Exchange`. Stand: nur Skizze, nicht festgelegt
- [ ] **GRUNDSACHE** Wire-Vertrag `schema/<thema>.capnp` in fs-interfaces (ADR 0045)
- [ ] **GRUNDSACHE** Grenz-Trait `Exchange` mit Medientyp (E15, PLAN.md 1.4); Formate liefern Anbieter außerhalb der Traits
- [ ] Nicht Unterstütztes antwortet mit `Unsupported` (ADR 0045) und ist im Frontend sichtbar gesperrt (ADR 0066)

## Kern (typisiert nach ADR 0086, CLI)
- [ ] **GRUNDSACHE** Speicherung typisiert nach ADR 0086 gegen den v5-Entwurf von fs-objects im eigenen Zweig (E7): `device`, `channel`, `sample`, `command`, `source`, `dashboard`/`card`
- [ ] **GRUNDSACHE** Keine JSON- und keine Blob-Spalten; Ausnahmen nur `original`, Medien als `FileRef` (E9), Chiffrat (E4)
- [ ] **GRUNDSACHE** Programm startet; Geräteliste (Name, Typ, Bereich, Zustand)
- [ ] **GRUNDSACHE** MQTT-Gerät über einen Broker hinzufügen (manuell und per Erkennung); nur MQTT 5 (E5)
- [ ] **GRUNDSACHE** Zustand lesen, einfach schalten
- [ ] **GRUNDSACHE** Bereich zuweisen (Verweis auf `places`, E17); Verlauf als Liste; Gerät entfernen; Beenden
- [ ] SPÄTER Automationen, Matter-Kopplung, Zigbee/Z-Wave über Brücken, Robotik-Steuerung
- [ ] SPÄTER Zugangsdaten über fs-vault (bis dahin nur Broker ohne Passwort)
- [ ] **GRUNDSACHE** CLI nach ADR 0063: `fs-devices list|sources|discover|read|set|history|serve|admin`; Facetten `fs-home`, `fs-robots` [Vorschlag Namen]
- [ ] **GRUNDSACHE** Programm startet, kann einfache Dinge und lässt sich beenden (ADR 0087 Punkt 7)

## Frontend (Baustein-Zuordnung zuerst)
- [ ] **GRUNDSACHE** Schritt `baustein-zuordnung`: Baustein-Analyse vor dem Bauen; fehlende Bausteine entstehen in `fs-components`, nie im Programm (ADR 0066)
- [ ] **GRUNDSACHE** Geräteliste und einfache Schalter (Baustein `table`, Formularfelder `switch`)
- [ ] **GRUNDSACHE** Admin-Frontend aus der Typbeschreibung
- [ ] SPÄTER Frontend Einfach, Dashboards (Vorbild Home Assistant, openHAB), Apple-/Windows-Stil (Vorbild [offen])
- [ ] SPÄTER Kein Blinc-Standardlook: cn-Bausteine nur über Wrapper, je Stil gestylt (ADR 0074)

## Doku
- [ ] **GRUNDSACHE** Programmseite in fs-documentation (Workflow `doku-mitziehen`) und diese Liste mitziehen
- [ ] SPÄTER Handbuch, Beispiele, Facetten-Seiten

## Bilder und Abnahme
- [ ] **GRUNDSACHE** Bilder des Frontends: erst Bilder, dann Strategie-OK, dann Release
- [ ] SPÄTER Abnahme der Vorbild-Frontends durch Durchgehen der Arbeitsabläufe aus dem Dossier

## Repo anlegen (erst nach Strategie-OK)
- [ ] **GRUNDSACHE** Repo anlegen über `programm-neu` (E13: Bündel 0.0.7 zuerst mergen). Stand: Repo `fs-devices` existiert nicht (404 laut PLAN.md); Anlegen durch den Nutzer (E14)
- [ ] **GRUNDSACHE** Kern-Crate `fs-devices-core`, Bin `fs-devices`, `fs-devices-app` nach ADR 0063
