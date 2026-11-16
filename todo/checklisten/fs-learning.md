# fs-learning – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0087, ADR 0086, ADR 0050, ADR 0013, E18; Strang-D-Plan `PLAN.md` Abschnitt 11 (Entscheidungen E1–E20)
Programm: Kurse und Karteikarten. Standards: xAPI 2.0 (IEEE 9274.1.1-2023); FSRS (Planungsverfahren); Open Badges 3.0 und LTI 1.3 später.
Die Strang-D-Dateien liegen bisher nur in Arbeitsstand der Strategie, nicht veröffentlicht und sind noch nicht in fs-documentation eingecheckt.

## Dossier und Vorbereitung
- [x] Erstes Dossier und Recherche vorhanden (Beleg: Arbeitsstand der Strategie, nicht veröffentlicht, `recherche-web-learning-vault.md`; nicht eingecheckt)
- [ ] **GRUNDSACHE** Dossier-Nachzug (E6, Lauf `dossier`) vor dem ersten Vorbild-Frontend; das Admin-Frontend darf vorher entstehen. Lücken: Anki: vollständige Menüs, Kürzel, Bewertungsknöpfe, Sync; Moodle: neue offizielle Quelle (Doku 404); Apple-/Windows-Vorbild offen
- [ ] SPÄTER Dossiers nach fs-documentation übernehmen (Pfad [offen])

## Spikes, Recherchen, Nachträge
- [ ] **GRUNDSACHE** Abhängigkeitsbaum `fsrs` 7.0.0 prüfen (zieht es ein schweres ML-Framework mit? sonst Feature nur für Planung) [offen]
- [ ] SPÄTER Anki-`.apkg`-Import: Lesen eines AGPL-Formats vor Bau rechtlich prüfen [offen]
- [ ] SPÄTER xAPI-/LTI-/Open-Badges-Typen eigens nach Spezifikation (Crates veraltet oder fehlen)

## Trait festlegen
- [ ] **GRUNDSACHE** Trait-Skizze (Ziel v1, PLAN.md Abschnitt 11) prüfen und festlegen: `Decks`, `NoteTypes`, `Notes`, `Study`, `Courses` (Facette Kurse), `Statements` (xAPI); `Exchange`. Stand: nur Skizze, nicht festgelegt
- [ ] **GRUNDSACHE** Wire-Vertrag `schema/<thema>.capnp` in fs-interfaces (ADR 0045)
- [ ] **GRUNDSACHE** Grenz-Trait `Exchange` mit Medientyp (E15, PLAN.md 1.4); Formate liefern Anbieter außerhalb der Traits
- [ ] Nicht Unterstütztes antwortet mit `Unsupported` (ADR 0045) und ist im Frontend sichtbar gesperrt (ADR 0066)

## Kern (typisiert nach ADR 0086, CLI)
- [ ] **GRUNDSACHE** Speicherung typisiert nach ADR 0086 gegen den v5-Entwurf von fs-objects im eigenen Zweig (E7): `deck`, `note_type`/`note_field`/`card_template`, `note`, `note_value`, `note_tag`, `card`, `review_log`, `course`/`lesson`, `enrollment`, `statement`; kein `rusqlite` (E18)
- [ ] **GRUNDSACHE** Keine JSON- und keine Blob-Spalten; Ausnahmen nur `original`, Medien als `FileRef` (E9), Chiffrat (E4)
- [ ] **GRUNDSACHE** Deck anlegen (verschachtelt); Notiztyp Vorder-/Rückseite; Karte hinzufügen
- [ ] **GRUNDSACHE** Lernen mit vier Stufen, FSRS-Planung, Fälligkeitsliste
- [ ] **GRUNDSACHE** CSV-Import/-Export
- [ ] **GRUNDSACHE** Kurs als geordnete Liste (Text-Verweis auf fs-text); Beenden
- [ ] SPÄTER Statistik-Ansichten, Add-ons, Bildverdeckung, Sync, Moodle-Abgabe, Badges, xAPI-Nachweise
- [ ] **GRUNDSACHE** CLI nach ADR 0063: `fs-learning decks|deck|add|study|due|import|serve|admin`; Facetten `fs-flashcards`, `fs-courses` [Vorschlag Namen]
- [ ] **GRUNDSACHE** Programm startet, kann einfache Dinge und lässt sich beenden (ADR 0087 Punkt 7)

## Frontend (Baustein-Zuordnung zuerst)
- [ ] **GRUNDSACHE** Schritt `baustein-zuordnung`: Baustein-Analyse vor dem Bauen; fehlende Bausteine entstehen in `fs-components`, nie im Programm (ADR 0066)
- [ ] **GRUNDSACHE** Lern-Ansicht (Karte, vier Bewertungsknöpfe) und Fälligkeitsliste; Knopfnamen bei Anki [offen]
- [ ] **GRUNDSACHE** Bausteine fehlen: Dialog, Formularfelder, Personen-Verweis-Feld
- [ ] **GRUNDSACHE** Admin-Frontend aus der Typbeschreibung
- [ ] SPÄTER Frontend Einfach (Vorbild Anki), Kurse (Vorbild Moodle), Apple-/Windows-Stil
- [ ] SPÄTER Kein Blinc-Standardlook: cn-Bausteine nur über Wrapper, je Stil gestylt (ADR 0074)

## Doku
- [ ] **GRUNDSACHE** Programmseite in fs-documentation (Workflow `doku-mitziehen`) und diese Liste mitziehen
- [ ] SPÄTER Handbuch, Beispiele, Facetten-Seiten

## Bilder und Abnahme
- [ ] **GRUNDSACHE** Bilder des Frontends: erst Bilder, dann Strategie-OK, dann Release
- [ ] SPÄTER Abnahme der Vorbild-Frontends durch Durchgehen der Arbeitsabläufe aus dem Dossier

## Repo anlegen (erst nach Strategie-OK)
- [ ] **GRUNDSACHE** Repo anlegen über `programm-neu` (E13: Bündel 0.0.7 zuerst mergen). Stand: Repo `fs-learning` existiert nicht (404 laut PLAN.md); Anlegen durch den Nutzer (E14)
- [ ] **GRUNDSACHE** Kern-Crate `fs-learning-core`, Bin `fs-learning`, `fs-learning-app` nach ADR 0063
