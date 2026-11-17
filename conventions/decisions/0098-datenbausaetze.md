# 0098 – Datenbausätze: einmal beschrieben, überall gleich, überall vollständig

Status: **akzeptiert** (Grundsatz Nutzer, ADR 0087 Nachtrag (2) Punkt 3; Freigabe je Gruppe Nutzer, Gespräch 1 Antwort 130; technische Ausgestaltung Strategie, 2026-11-17) · **ändert** für Adresse ADR 0087 Nachtrag (2) Punkt 3 „Spalte je Feld“: Komponentenliste nach RFC 9553 §2.5.1.2 als Untertabelle (ADR 0086 Entscheidung 1, Listen); abgeleitete Spalten schreibt nur `v5::kit` · **erfüllt** ADR 0087 Nachtrag (2) Punkt 3 („Bibliothek und Ort der Bausätze … in einem eigenen ADR“) · **ergänzt** ADR 0066 §1 (Grundtypen) und §4 (Components je Grundtyp) um zusammengesetzte Grundtypen · **präzisiert** ADR 0086 Entscheidung 1 (Speicherform zusammengesetzter Werte) · baut auf ADR 0014, 0029, 0050, 0057, 0066, 0068, 0077, 0085, 0086, 0093 · Grundlage: Plan Baukasten (Fassung 5) §b3

**Kontext**
- **Nutzer (2026-11-17, ADR 0087 Nachtrag (2) Punkt 3):** Zusammengesetzte Standard-Bausätze (Adresse, Person …) sehen **überall gleich aus** und werden **überall vollständig verwendet** („ein Shop nimmt nicht nur ‚Ort‘, sondern immer ‚Adresse‘“); Felder dürfen leer bleiben, außer Pflichtfeldern; nicht alle Felder müssen sichtbar sein; die Speicherung bleibt typisiert.
- **Bestand:** Die Werte gibt es schon in `fs-types` (Repo fs-types 6323518): `Address` (`src/address.rs`, JSContact-Komponentenliste, 18 `AddressKind` in `schema/types.capnp`), `Location` (`src/location.rs`, RFC 8984 §4.2.5), `GeoPoint`/`Place` (RFC 5870), `Name`, `PersonRef` (ADR 0085), `EmailAddress`, `PhoneNumber`. Die **Speicherform** schreibt jedes Programm von Hand (Inventur 17.11., Beleg Datei:Zeile):
  - Personen-Verweis `<p>_id/_art/_abzug` **10×**: calendars `fs-calendars-local/src/calendar_tables.rs:36-38`, `:113-116`; tasks `fs-tasks-local/src/tables.rs:37-39`, `:128-130`, `:150-152`; fs-objects `src/v5/tables.rs:53-54`, `:79-82`, Makro `side!` `:103`, `:107`, `src/v5/tables_kind.rs:50`.
  - Zeitangabe mit Zone 3× (calendars `calendar_tables.rs:66-71`; tasks `tables.rs:64-68`, `:69-73`), Reihenfolge und Pflicht weichen ab.
  - Erinnerung 2× mit **auseinandergelaufenen Spalten** (calendars `calendar_tables.rs:140-154`: `at`, `action`; tasks `tables_more.rs:59-76`: `trigger_at`, `alert_action`, `pos`).
  - Sensibel-Markierung 4× mit gleichem Algorithmus (calendars `model/marks.rs:20-50`, people-core `card/vendor.rs:42-105`, people-app und tasks-app `source/marks.rs`).
- Freigabe je Feld gibt es heute nur für vier Personen-Felder (`ShareField`: Geburtstag, Anschrift, E-Mail, Telefon; Entwurf person_directory_v2).

**Entscheidung**
1. **Ein Bausatz ist ein zusammengesetzter Grundtyp** (ADR 0066 §1) und wird **genau einmal beschrieben, in `fs-types`**: Felder, Grundtyp je Feld, Standard-URI mit Abschnitt je Feld, Form-Pflicht des Bausatzes, Medientyp. Keine eigene Bibliothek (kein `fs-datasets`): Werte und Draht-Schema liegen nach ADR 0093 Regel 2 in fs-types; der Name wäre zudem gegen die Namensregel (Bibliothek Einzahl).
2. **Alles Weitere wird aus der Beschreibung erzeugt, nie von Hand gepflegt:**
   - Speicherform in `fs-objects` (`v5::kit`): **1:1-Bausatz = Spaltengruppe** `<prefix>_<feld>` in der Tabelle des Besitzers; **1:n und Listen im Bausatz = Untertabelle** mit Fremdschlüssel (ADR 0086 Entscheidung 1). Neue Bausatzfelder nur **anhängen**; jeder Anhang ist ein neuer Schritt je nutzender Tabelle, nie ein Umbau (ADR 0086 Nachtrag 16.11.: kein `RENAME`).
   - Component-Bindung in `fs-components` (`accepts`, ADR 0087 Nachtrag 17.11. [Entw.] Punkt 3) und `TypeCatalog`-Eintrag (ADR 0066 §3): der Bausatz erscheint als **ein** Feld mit seinem Grundtyp; `BasicType` in `types.capnp` nur anhängen.
3. **Erste Bausätze und Standards:**
   | Bausatz | Standard | Speicherform |
   |---|---|---|
   | Adresse | RFC 9553 §2.5.1.1 (JSContact `Address`), ISO 3166-1; Abbildung schema.org `PostalAddress` | Untertabelle `(kind, value, pos)` nach JSContact + abgeleitete Spalten `postcode`, `locality`, `country_code` zum Sortieren (feste Spalten Straße/PLZ/Ort passen nicht zu allen Ländern) |
   | Ort / Punkt | RFC 8984 §4.2.5; RFC 5870, RFC 7946 | Spaltengruppe |
   | Personen-Verweis | AS2 `id`, ADR 0085 | Spaltengruppe `_id/_art/_abzug` |
   | Zeitangabe | RFC 3339; RFC 8984 `LocalDateTime`, `Duration`; IANA tz | Spaltengruppe `_kind/_local/_date/_zone/_zone_assumed` (eine Reihenfolge) |
   | Erinnerung | RFC 8984 §4.5.2 `Alert` | Untertabelle |
   | Schutzangabe | ADR 0029; W3C DPV | Spaltengruppe + Untertabelle Kategorien |
   | Person | RFC 9553 `Card`; vCard RFC 6350 an der Grenze | gehört fs-people; andere speichern nur den Verweis |
   | Geld | ISO 4217; Ganzzahl in kleinster Einheit + Skala (ADR 0086 Nachtrag) | Spaltengruppe |
4. **Regeln für jede Verwendung:**
   1. **Immer vollständig:** wer einen Bausatz nimmt, bekommt alle Felder; das Erzeugen lässt kein Feld weg.
   2. **Leer erlaubt:** jedes Feld nullable, außer der Form-Pflicht des Bausatzes selbst.
   3. **Pflicht nur bei Verträgen** (ADR 0087 Nachtrag (2) Punkt 1): vorher sichtbar, widerrufbar; sonst „von anderen nie verlangen“.
   4. **Fremde Daten nie kopieren:** **Verweis immer**; **Abzug nur** bei ausgestellten Dokumenten und Verträgen (ADR 0085 „ausgestellt = eingefroren“; ADR 0087 Nachtrag (2) Pflichttest „Abzug nur bei ausgestellter Anmeldung“).
   5. **Sichtbarkeit zweifach:** *Anzeige-Auswahl* (welche Felder ein Layout zeigt; Programm bzw. Mensch im Frontend) gegen *Freigabe* (wer ein Feld sehen darf; **nur der Besitzer der Daten**). Freigabe gilt für jeden Bausatz mit Personendaten. Stufen (aus der Nutzerregel „Selbstbestimmung über Daten“, nicht aus Antwort 130): nur ich / bestimmte Personen / Gruppen / Freunde / alle. Fehlt eine Freigabe, fehlt das Feld **mit Grund**, nie still.
   6. **Freigabe je Gruppe zuerst** (Nutzer, Antwort 130: „Ich würde Gruppen daraus machen. Also: Adresse, anstatt Straße, ort usw.“): in der Grundauswahl je **ganzem Bausatz**; feiner je Feld später („Irgendwann mal sollte es jeder können.“).
5. **Standard-Component je Datenart (Rückfall):** Jeder Typ im `TypeCatalog` nennt seinen **Medientyp** (registriert, wo vorhanden: `application/jscontact+json` RFC 9553, `application/jscalendar+json` RFC 8984; sonst `application/vnd.freesynergy.<typ>` nach RFC 6838, Registrierung offen) und seine **Standard-Component** (Anzeige, kompakt, Zelle, Eingabe; ADR 0066 §4). Fehlt eine eigene, zeigt die **Rückfall-Component** die Felder aus der Typbeschreibung. Eingebettet wird über die Katalogart `module` (ADR 0077 Nachtrag [akz.] Z. 64).
6. **Person** sieht überall gleich aus: eine Component `person-card` in fs-components (vier Formen nach ADR 0066 §4); sie zeigt nur, was der Besitzer fs-people liefert, und markiert Zurückgehaltenes.
7. **Ab dem zweiten Nutzer:** ein neuer Bausatz entsteht, wenn zwei Programme ihn brauchen; vorher bleibt das Feld ein Feld des einen Programms (Workflow `bausatz-neu`, Standard-Beleg Pflicht).

**Pflichttests** (je ohne Umsetzung rot)
- Erzeugte Spaltengruppe enthält alle Bausatzfelder; Mutant „ein Feld weglassen“ → rot. Für Adresse (Untertabelle): Mutant „eine `kind` aus der JSContact-Liste fehlt in der Wortliste“ → rot.
- Ein angehängtes Bausatzfeld ergibt einen neuen Schritt, keinen Tabellen-Neuaufbau; Fingerabdruck alter Schritte unverändert.
- Freigabe fehlt → Feld fehlt mit Grund (`withheld`), nie leer ohne Grund.
- Verweis statt Kopie: ein Programm speichert für Person nur `PersonRef`; Abzug nur bei ausgestelltem Dokument.
- Jeder Typ im `TypeCatalog` hat Medientyp und Standard-Component; fehlt eine eigene, erscheint die Rückfall-Component.

**Folgen**
- fs-types: Bausatz-Beschreibung (Arbeitsname `Kit`), Medientyp je Typ; `BasicType` anhängen (`timeSpan`, `alert`, `money` …).
- fs-objects: `v5::kit` (erzeugte Spaltengruppen/Untertabellen); bestehende Handfassungen in calendars, tasks, fs-objects im jeweils nächsten Lauf heben (Plan §e M3); Erinnerungs-Spalten angleichen = neuer Schritt.
- fs-components: `accepts` je Bausatz, `person-card`, Rückfall-Component.
- fs-people: Freigabe je Bausatz-Gruppe als person_directory v3 (nur anhängen), nach v2.
- Doku: `data/<domain>/technical.md` nennt Bausätze statt Einzelfelder.

**Offen**
1. Registrierung eigener Medientypen (`vnd.freesynergy.*`) bei der IANA: ob und wann. [offen]
2. Freigabe je Einzelfeld für jeden: später, „wenn die Workflows fertig sind“ (Nutzer, Antwort 130). [offen]
3. Gemeinsame Wörter eines Bausatzes (z. B. `AddressKind`) als Code-Liste in fs-types, jede Domain legt sie in ihre Wort-Tabelle (ADR 0086 Offen 4); für Bausätze bestätigen. [offen]
