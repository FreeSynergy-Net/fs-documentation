# fs-data – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0076 (ODF .ods), ADR 0086, ADR 0066; Strang-D-Plan `PLAN.md` Abschnitt 2 (Entscheidungen E1–E20)
Programm: Tabellen und Formeln. Standards: ODF `.ods` mit OpenFormula; W3C CSV on the Web; xlsx nur an der Grenze.
Die Strang-D-Dateien liegen bisher nur in `/srv/FreeSynergy/.scratch/strang-d/` und sind noch nicht in fs-documentation eingecheckt.

## Dossier und Vorbereitung
- [x] Erstes Dossier und Recherche vorhanden (Beleg: `/srv/FreeSynergy/.scratch/strang-d/dossier-data.md`, `recherche-data-finance.md`; nicht eingecheckt)
- [ ] **GRUNDSACHE** Dossier-Nachzug (E6, Lauf `dossier`) vor dem ersten Vorbild-Frontend; das Admin-Frontend darf vorher entstehen. Lücken: LibreOffice Calc: Untermenüs aller 11 Menüs, Tastenkürzel-Seite; Excel: Menüs und Kürzel; Airtable: Klickfolgen, Fensterzustände; Apple-Vorbild (Numbers?) fehlt ganz
- [ ] SPÄTER Dossiers nach fs-documentation übernehmen (Pfad [offen])

## Spikes, Recherchen, Nachträge
- [ ] **GRUNDSACHE** Spike E12: `ironcalc_base` gegen `formualizer` mit derselben Testmappe, objektiv gemessen (Anteil der OpenFormula-Grundfunktionen, die richtig rechnen)
- [ ] SPÄTER Recherche: `.ods` schreiben (kein Crate recherchiert; sonst eigener Schreiber ZIP + XML)
- [ ] SPÄTER Rundlauf-Test Calc-Datumsseriennummern gegen typisierte Datumswerte beim Import

## Trait festlegen
- [ ] **GRUNDSACHE** Trait-Skizze (Ziel v1, PLAN.md Abschnitt 2) prüfen und festlegen: `Workbooks`, `Sheets`, `Columns`, `Cells`, `Views` (Thema `data`) plus `Evaluate` im eigenen Crate `fs-data-formula`; `Exchange` (Abschnitt 1.4). Stand: nur Skizze, nicht festgelegt
- [ ] **GRUNDSACHE** Wire-Vertrag `schema/<thema>.capnp` in fs-interfaces (ADR 0045)
- [ ] **GRUNDSACHE** Grenz-Trait `Exchange` mit Medientyp (E15, PLAN.md 1.4); Formate liefern Anbieter außerhalb der Traits
- [ ] Nicht Unterstütztes antwortet mit `Unsupported` (ADR 0045) und ist im Frontend sichtbar gesperrt (ADR 0066)

## Kern (typisiert nach ADR 0086, CLI)
- [ ] **GRUNDSACHE** Speicherung typisiert nach ADR 0086 gegen den v5-Entwurf von fs-objects im eigenen Zweig (E7): `workbook`, `sheet`, `column_def`, `column_choice`, `cell` (dünn besetzt), `cell_cache`, `named_range`, `view`, `view_sort`, `view_filter`, `view_column`
- [ ] **GRUNDSACHE** Keine JSON- und keine Blob-Spalten; Ausnahmen nur `original`, Medien als `FileRef` (E9), Chiffrat (E4)
- [ ] **GRUNDSACHE** Tabelle anlegen, Spalten mit Typ (`ColumnType`, auch `Free`), Zeilen erfassen
- [ ] **GRUNDSACHE** Grundrechnungen und Summen über `Evaluate` (Formel-Crate `fs-data-formula`, nach Spike E12)
- [ ] **GRUNDSACHE** Sortieren, Filtern, Verweis auf andere Tabelle
- [ ] **GRUNDSACHE** CSV ein/aus (Grenz-Adapter, Crate `csv`)
- [ ] **GRUNDSACHE** xlsx/ods ein/aus (Grenz-Adapter: `calamine`, `rust_xlsxwriter`; ods schreiben [offen])
- [ ] SPÄTER Pivot, Makros, Diagramme, Kollaboration (Loro nur Abgleich, E8)
- [ ] **GRUNDSACHE** CLI nach ADR 0063: `fs-data new|list|show|set|import|export|serve|admin`
- [ ] **GRUNDSACHE** Programm startet, kann einfache Dinge und lässt sich beenden (ADR 0087 Punkt 7)

## Frontend (Baustein-Zuordnung zuerst)
- [ ] **GRUNDSACHE** Schritt `baustein-zuordnung`: Baustein-Analyse vor dem Bauen; fehlende Bausteine entstehen in `fs-components`, nie im Programm (ADR 0066)
- [ ] **GRUNDSACHE** Tabellenfläche mit Virtualisierung (`tables`/`table`, vorhanden nur lesen)
- [ ] **GRUNDSACHE** Bausteine fehlen: `tables`-Module (Köpfe, Sortieren/Filtern, Bearbeiten, Bereichsauswahl), Formel-Modul und Formelzeile, Zelleditor je Typ, Dialog-Grundbaustein
- [ ] **GRUNDSACHE** Admin-Frontend aus der Typbeschreibung (ADR 0066)
- [ ] SPÄTER Frontend Einfach, Apple-Stil (Vorbild Numbers [Vorschlag]), Windows-Stil (Vorbild Excel [Vorschlag])
- [ ] SPÄTER Ansichten Board und Kalender (Bausteine `board`, `calendar-grid` vorhanden)
- [ ] SPÄTER Kein Blinc-Standardlook: cn-Bausteine nur über Wrapper, je Stil gestylt (ADR 0074)

## Doku
- [ ] **GRUNDSACHE** Programmseite in fs-documentation (Workflow `doku-mitziehen`) und diese Liste mitziehen
- [ ] SPÄTER Handbuch, Beispiele, Facetten-Seiten

## Bilder und Abnahme
- [ ] **GRUNDSACHE** Bilder des Frontends: erst Bilder, dann Strategie-OK, dann Release
- [ ] SPÄTER Abnahme der Vorbild-Frontends durch Durchgehen der Arbeitsabläufe aus dem Dossier

## Repo anlegen (erst nach Strategie-OK)
- [ ] **GRUNDSACHE** Repo anlegen über `programm-neu` (E13: Bündel 0.0.7 zuerst mergen). Stand: Platzhalter `FreeSynergy/fs-data` existiert (7 KB, laut PLAN.md Stand 2026-11-15); Kern-Crate fehlt
- [ ] **GRUNDSACHE** Kern-Crate `fs-data-core`, Bin `fs-data`, `fs-data-app` nach ADR 0063
