# fs-finance – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0087, ADR 0085 (Entwurf), ADR 0086, E16; Strang-D-Plan `PLAN.md` Abschnitt 10 (Entscheidungen E1–E20)
Programm: Buchungen und Rechnungen. Standards: doppelte Buchführung; ISO 20022 (camt.053 Import zuerst); XRechnung (nicht recherchiert); IBAN/BIC.
Die Strang-D-Dateien liegen bisher nur in Arbeitsstand der Strategie, nicht veröffentlicht und sind noch nicht in fs-documentation eingecheckt.

## Dossier und Vorbereitung
- [x] Erstes Dossier und Recherche vorhanden (Beleg: Arbeitsstand der Strategie, nicht veröffentlicht, `recherche-data-finance.md`; nicht eingecheckt)
- [ ] **GRUNDSACHE** Dossier-Nachzug (E6, Lauf `dossier`) vor dem ersten Vorbild-Frontend; das Admin-Frontend darf vorher entstehen. Lücken: GnuCash, Actual, Firefly III: Menüs, Untermenüs, Kürzel, alle Fensterzustände, alle Klickfolgen (keine einzige belegt); dünnstes Dossier
- [ ] SPÄTER Dossiers nach fs-documentation übernehmen (Pfad [offen])

## Spikes, Recherchen, Nachträge
- [ ] **GRUNDSACHE** ADR-0086-Nachtrag „Dezimal = Ganzzahl + Skala“ (E16): Geld als Ganzzahl in kleinster Einheit + ISO-4217-Währung + Skala
- [ ] **GRUNDSACHE** Personen-Verweis-Baustein (ADR 0085, noch Entwurf) in `fields`
- [ ] SPÄTER Recherche XRechnung/ZUGFeRD (EN 16931): Format, Rust-Crates; Rechtsfragen (Unveränderbarkeit, Fristen) [nicht belegt]
- [ ] SPÄTER Bankformat-Versionen je Bank prüfen

## Trait festlegen
- [ ] **GRUNDSACHE** Trait-Skizze (Ziel v1, PLAN.md Abschnitt 10) prüfen und festlegen: `Accounts`, `Transactions`, `Reports`, `Budgets` (Facette Haushaltsbuch), `Invoices` (später); `Exchange`. Stand: nur Skizze, nicht festgelegt
- [ ] **GRUNDSACHE** Wire-Vertrag `schema/<thema>.capnp` in fs-interfaces (ADR 0045)
- [ ] **GRUNDSACHE** Grenz-Trait `Exchange` mit Medientyp (E15, PLAN.md 1.4); Formate liefern Anbieter außerhalb der Traits
- [ ] Nicht Unterstütztes antwortet mit `Unsupported` (ADR 0045) und ist im Frontend sichtbar gesperrt (ADR 0066)

## Kern (typisiert nach ADR 0086, CLI)
- [ ] **GRUNDSACHE** Speicherung typisiert nach ADR 0086 gegen den v5-Entwurf von fs-objects im eigenen Zweig (E7): `account`, `transaction`, `posting`, `abzug` (ADR 0085), `budget_line`, `import_batch`, `statement_line`, `invoice`/`invoice_line` (später)
- [ ] **GRUNDSACHE** Keine JSON- und keine Blob-Spalten; Ausnahmen nur `original`, Medien als `FileRef` (E9), Chiffrat (E4)
- [ ] **GRUNDSACHE** Konten anlegen
- [ ] **GRUNDSACHE** Buchung mit Soll und Haben, Summenprüfung (Summe der Posten = 0), Kontostand
- [ ] **GRUNDSACHE** CSV-Export, camt.053-Import, Monatsbericht
- [ ] **GRUNDSACHE** IBAN-Prüfung; Beenden
- [ ] SPÄTER Rechnungen (`Invoices`), XRechnung, pain.001, Steuer, Abschluss, XBRL, Kurse, automatischer Abgleich
- [ ] **GRUNDSACHE** CLI nach ADR 0063: `fs-finance accounts|account|post|balance|import|report|export|serve|admin`
- [ ] **GRUNDSACHE** Programm startet, kann einfache Dinge und lässt sich beenden (ADR 0087 Punkt 7)

## Frontend (Baustein-Zuordnung zuerst)
- [ ] **GRUNDSACHE** Schritt `baustein-zuordnung`: Baustein-Analyse vor dem Bauen; fehlende Bausteine entstehen in `fs-components`, nie im Programm (ADR 0066)
- [ ] **GRUNDSACHE** Bausteine fehlen: `table`-Module, Personen-Verweis-Feld, Formularfelder (`number_input`, `date_picker`), Dialog
- [ ] **GRUNDSACHE** Admin-Frontend aus der Typbeschreibung
- [ ] SPÄTER Frontend Einfach (Vorbild GnuCash), Haushaltsbuch (Vorbild Actual), Apple-/Windows-Stil (Vorbild [offen])
- [ ] SPÄTER Kein Blinc-Standardlook: cn-Bausteine nur über Wrapper, je Stil gestylt (ADR 0074)

## Doku
- [ ] **GRUNDSACHE** Programmseite in fs-documentation (Workflow `doku-mitziehen`) und diese Liste mitziehen
- [ ] SPÄTER Handbuch, Beispiele, Facetten-Seiten

## Bilder und Abnahme
- [ ] **GRUNDSACHE** Bilder des Frontends: erst Bilder, dann Strategie-OK, dann Release
- [ ] SPÄTER Abnahme der Vorbild-Frontends durch Durchgehen der Arbeitsabläufe aus dem Dossier

## Repo anlegen (erst nach Strategie-OK)
- [ ] **GRUNDSACHE** Repo anlegen über `programm-neu` (E13: Bündel 0.0.7 zuerst mergen). Stand: Repo `fs-finance` existiert nicht (404 laut PLAN.md); Anlegen durch den Nutzer (E14)
- [ ] **GRUNDSACHE** Kern-Crate `fs-finance-core`, Bin `fs-finance`, `fs-finance-app` nach ADR 0063
