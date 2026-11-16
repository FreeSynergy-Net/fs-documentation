# fs-3d – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0087, ADR 0086, E3, E11, E19; Strang-D-Plan `PLAN.md` Abschnitt 6 (Entscheidungen E1–E20)
Programm: 3D-Modelle. Standards: glTF 2.0; STL/OBJ/PLY/3MF nur an der Grenze; OpenEXR für Umgebungslicht.
Die Strang-D-Dateien liegen bisher nur im internen Arbeitsstand der Strategie und sind noch nicht in fs-documentation eingecheckt.

## Dossier und Vorbereitung
- [x] Erstes Dossier und Recherche vorhanden (Beleg: Arbeitsstand der Strategie, nicht veröffentlicht, `recherche-kreativ.md`; nicht eingecheckt)
- [ ] **GRUNDSACHE** Dossier-Nachzug (E6, Lauf `dossier`) vor dem ersten Vorbild-Frontend; das Admin-Frontend darf vorher entstehen. Lücken: Blender: alles aus Volltext (bisher nur Suchauszüge): Topbar-Menüs, Workspaces, Modi, Objekt hinzufügen, Rendern, Beenden; Apple- und Windows-Vorbild fehlen; dünnstes Dossier neben fs-finance (keine belegte Klickfolge)
- [ ] SPÄTER Dossiers nach fs-documentation übernehmen (Pfad [offen])

## Spikes, Recherchen, Nachträge
- [ ] **GRUNDSACHE** Spike E11: `blinc_canvas_kit` (scene3d) per Wrapper für die 3D-Ansicht; Gizmos [offen]
- [ ] SPÄTER Lizenzprüfung `craft-libs/vendor/` (E3); `gltf`-Crate-Pflege prüfen
- [ ] SPÄTER GPU-Pin wgpu `=26.0.1` gemeinsam mit Blinc abstimmen

## Trait festlegen
- [ ] **GRUNDSACHE** Trait-Skizze (Ziel v1, PLAN.md Abschnitt 6) prüfen und festlegen: `Scenes`, `Nodes`, `Meshes`, `Materials`, `Render` (später); Thema `scenes` (E19, Datei `scenes.capnp`); `Exchange`. Stand: nur Skizze, nicht festgelegt
- [ ] **GRUNDSACHE** Wire-Vertrag `schema/<thema>.capnp` in fs-interfaces (ADR 0045)
- [ ] **GRUNDSACHE** Grenz-Trait `Exchange` mit Medientyp (E15, PLAN.md 1.4); Formate liefern Anbieter außerhalb der Traits
- [ ] Nicht Unterstütztes antwortet mit `Unsupported` (ADR 0045) und ist im Frontend sichtbar gesperrt (ADR 0066)

## Kern (typisiert nach ADR 0086, CLI)
- [ ] **GRUNDSACHE** Speicherung typisiert nach ADR 0086 gegen den v5-Entwurf von fs-objects im eigenen Zweig (E7): `scene`, `node`, `mesh`, `mesh_primitive`, `material`, `texture`, `camera`/`light`; Puffer als Datei (`FileRef`, E9)
- [ ] **GRUNDSACHE** Keine JSON- und keine Blob-Spalten; Ausnahmen nur `original`, Medien als `FileRef` (E9), Chiffrat (E4)
- [ ] **GRUNDSACHE** glTF/GLB öffnen, Export GLB/glTF
- [ ] **GRUNDSACHE** Grundkörper einfügen; verschieben, drehen, skalieren
- [ ] **GRUNDSACHE** Materialfarbe setzen
- [ ] **GRUNDSACHE** Speichern, Beenden
- [ ] SPÄTER Render (`Render`), Knoten-Editor für Materialien, STL/OBJ/PLY/3MF
- [ ] **GRUNDSACHE** CLI nach ADR 0063: `fs-3d new|import|tree|add|export|serve|admin`
- [ ] **GRUNDSACHE** Programm startet, kann einfache Dinge und lässt sich beenden (ADR 0087 Punkt 7)

## Frontend (Baustein-Zuordnung zuerst)
- [ ] **GRUNDSACHE** Schritt `baustein-zuordnung`: Baustein-Analyse vor dem Bauen; fehlende Bausteine entstehen in `fs-components`, nie im Programm (ADR 0066)
- [ ] **GRUNDSACHE** 3D-Ansicht (Drehen/Zoomen) nach Spike E11
- [ ] **GRUNDSACHE** Bausteine fehlen: Teiler, Dialog, Formularfelder
- [ ] **GRUNDSACHE** Admin-Frontend aus der Typbeschreibung
- [ ] SPÄTER Frontend Einfach, Apple-Stil (Vorbild Reality Composer [Vorschlag]), Windows-Stil (Vorbild 3D Builder [Vorschlag])
- [ ] SPÄTER Kein Blinc-Standardlook: cn-Bausteine nur über Wrapper, je Stil gestylt (ADR 0074)

## Doku
- [ ] **GRUNDSACHE** Programmseite in fs-documentation (Workflow `doku-mitziehen`) und diese Liste mitziehen
- [ ] SPÄTER Handbuch, Beispiele, Facetten-Seiten

## Bilder und Abnahme
- [ ] **GRUNDSACHE** Bilder des Frontends: erst Bilder, dann Strategie-OK, dann Release
- [ ] SPÄTER Abnahme der Vorbild-Frontends durch Durchgehen der Arbeitsabläufe aus dem Dossier

## Repo anlegen (erst nach Strategie-OK)
- [ ] **GRUNDSACHE** Repo anlegen über `programm-neu` (E13: Bündel 0.0.7 zuerst mergen). Stand: Repo `fs-3d` existiert nicht (404 laut PLAN.md); Anlegen durch den Nutzer (E14)
- [ ] **GRUNDSACHE** Kern-Crate `fs-3d-core`, Bin `fs-3d`, `fs-3d-app` nach ADR 0063
