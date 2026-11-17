# Vorbild-Recherche: Frontend-Baukasten (fs-forms), Datenmodell-Baukasten, Veranstaltungen (Opus, Bahn 5, 2026-11-17)

Grundlage für ADR 0087, Nachtrag 2026-11-17 (forms = Frontend-Baukasten). ADR 0013: nur Konzepte aus offiziellen Texten, nichts kopiert, kein Code angesehen. Lesestand je Quelle: **gelesen** = Seite abgerufen und ausgewertet; **dünn** = abgerufen, beantwortet die Frage kaum; **404/Umleitung** = nicht erreichbar; `[nicht gelesen; Konzept]` = nur aus allgemeinem Produktwissen, nicht belegt. Abruf 2026-11-17 per WebFetch.

## 1. Quellen und Lesestand
| Kürzel | Vorbild | Lizenz (belegt) | Quelle | Lesestand |
|---|---|---|---|---|
| PA | Microsoft Power Apps (Canvas) | proprietär `[nicht gelesen; Konzept]` | https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/working-with-data-sources | gelesen |
| PF | Power Fx (Formelsprache von PA) | „will make Power Fx available as open-source“ | https://learn.microsoft.com/en-us/power-platform/power-fx/overview | gelesen |
| PY | Power Apps Quelltext `.pa.yaml` | – | https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/power-apps-yaml | gelesen |
| BB | Budibase | „GPL v3“, „client and component libraries … MPL“, Bezahlteile BSL | https://github.com/Budibase/budibase ; https://docs.budibase.com/docs/data-sources ; https://docs.budibase.com/docs/bindings | gelesen (Datenquellen dünn) |
| AS | Appsmith | Apache-2.0 | https://github.com/appsmithorg/appsmith ; https://docs.appsmith.com/core-concepts/building-ui/dynamic-ui | gelesen; Git-Ordnerstruktur 404 |
| RT | Retool | proprietär `[nicht gelesen; Konzept]` | https://docs.retool.com/apps/concepts/components ; https://docs.retool.com/permissions/quickstart | gelesen; Ressourcen-Seite 404 |
| NB | NocoBase | Apache-2.0 (Repo-Angabe) | https://github.com/nocobase/nocobase ; https://docs.nocobase.com/ | dünn (Seiten nur noch KI-Werbung) |
| DI | Directus | Monospace Sustainable Core License (MSCL) | https://directus.com/docs/getting-started/overview ; https://directus.com/docs/guides/data-model/collections | gelesen |
| TJ | ToolJet | auf der Seite nicht genannt | https://docs.tooljet.com/docs/ | dünn |
| TA | Tally (Formulare) | proprietär `[nicht gelesen; Konzept]` | https://tally.so/help/conditional-form-logic ; https://tally.so/help | gelesen |
| BR | Baserow | Kern MIT, Premium/Enterprise getrennt | https://github.com/baserow/baserow ; https://baserow.io/docs/index | gelesen (Feldtypen dünn) |
| ND | NocoDB | Sustainable Use License | https://github.com/nocodb/nocodb | gelesen |
| PX | pretix | „GNU AGPL license v3 with additional terms“ | https://github.com/pretix/pretix ; https://docs.pretix.eu/guides/products/ ; https://docs.pretix.eu/guides/seating/ | gelesen |
| EB/PT | Eventbrite, Pretalx, Typeform, Superblocks | – | – | `[nicht gelesen; Konzept]`, nicht verwendet |

## 2. Je Vorbild: Komponenten, Datenquellen, Rechte, Logik, Speicherung
**PA Power Apps.** Komponenten: Steuerelemente (Gallery, Display/Edit form, Karten). Datenquelle: Tabellen über „Connections“; „The data source has the same column names and data types as the underlying table“; Bindung über Eigenschaften: „Gallery.Items = DataSource“; Schreiben über `SubmitForm`/`Patch`, je Karte `Update` = Feld (PA). Wichtig: „Power Apps can't be used to create a connected data source, or modify its structure; the data source must already exist“ (PA) – genau unsere Trennung Baukasten ↔ Datenmodell. Rechte: „The connection takes care of authentication of the user“; Fehler „the user doesn't have the right permissions“ (PA) → Daten mit Rechten der Person. Große Mengen: „delegated … run inside the cloud service“, sonst nur 500 Datensätze (PA). Logik: Power Fx, „strongly typed, declarative, and functional“, Excel-artige Formeln, auch imperativ (PF); No-Code-Schalter schreiben Formeln (PF). Speicherung: `.msapp` (Binärsammlung), Quelltext `*.pa.yaml` je App/Bildschirm/Komponente, „read-only“, Steuerelement mit `Control@Version` und `Variant` (PY); jedes Dokument mit „language version stamp“ und automatischem Umschreiben alter Formeln (PF).
**BB Budibase.** Datenquellen: eigene Datenbank CouchDB oder externe SQL/APIs; Lesen über „Data provider“, Schreiben „Execute Query“ (BB data-sources). Logik: Bindungen in Handlebars `{{ }}` oder JavaScript `$("Query 1.Customer.name")`, Helfer für Bedingungen/Schleifen (BB bindings). Rechte: Nutzer/Gruppen, Gruppenverwalter (BB README). Speicherort der App-Definition: nicht belegt.
**AS Appsmith.** Widgets binden über `{{QUERY_NAME.data}}`, `{{Table1.selectedRow.email}}`, JS-Objekte, `storeValue()` im Browser-Speicher (AS dynamic-ui). Logik = JavaScript überall. Speicherung in Git: Seite 404, nicht belegt.
**RT Retool.** „Each component is represented by a JavaScript object“; „write JavaScript almost anywhere using `{{ }}`“; Ereignisse lösen Abfragen aus; eigene Komponenten in React/TypeScript (RT components). Rechte: Gruppen mit Use/Edit/Own auf Apps und Ressourcen, „Permissions are always additive“ (RT permissions). Ob Abfragen mit Ressourcen- oder Personen-Zugangsdaten laufen: auf der Seite nicht gesagt, Ressourcen-Seite 404 → nicht belegt.
**DI Directus.** „Collections are database tables with additional metadata“; vorhandene Datenbank wird „introspect[ed]“; zum Anzeigen braucht eine Tabelle „interfaces, displays, and icons“ (DI collections) – entspricht unseren Components Eingabe/Anzeige je Grundtyp (ADR 0066 §4). Rechte: „users can only see, interact with, and create the data their role allows“ (DI overview). Automatisierung „Flows“ nur genannt.
**NB / TJ.** NocoBase: Rechte, Workflows, Dateien als „building blocks“, Rest auf den Seiten nicht belegt (NB). ToolJet: Drag-and-drop, eigene PostgreSQL-Datenbank, Datenquellen-Bibliothek, Workflows mit Knoten/Auslösern, JavaScript-Bibliotheken importierbar (TJ).
**TA Tally.** Logik ohne Code: Blöcke „IF … THEN“, Bedingungen „all“/„any“, sechs feste Aktionen (Seite springen, Blöcke zeigen/verbergen, Wert berechnen, Pflicht machen, Knopf verbergen, Umleiten) (TA logic). Geschlossene Aktionsliste ist das Muster für Nachtrag-Punkt 12 (v1 keine Bedingungen, später geschlossene Liste).
**BR / ND (Datenmodelle).** Baserow: Tabellen-Datenbank „looks a lot like a spreadsheet“, eigene Feldtypen als Plugin, App-Builder für Portale (BR). NocoDB: Tabellenoberfläche über PostgreSQL/SQLite, Feldtypen u. a. Links, Lookup, Rollup, Formula, User (ND). Beide: Felder frei erfindbar, ohne Standardbezug.
**PX pretix.** „A quota determines how many instances of your product can be sold“, jedes Produkt braucht ein Kontingent; Kategorien normal/Zusatz/Querverkauf; Check-in-Listen mit Regeln nach Produkt, Zeit, früheren Einlässen (PX products). Sitzplätze: Plan als JSON aus eigenem Editor, Zonen/Reihen/Nummern, „pretix maps products to seats depending on the seat category“, eine Kategorie = ein Produkt; ohne Sitzwahl weist der Veranstalter zu; Sitzplätze nicht in der Community-Fassung (PX seating).

## 3. Standards (belegt)
- **schema.org `EventReservation`**: „A reservation for an event like a concert, sporting event, or lecture“; `reservationFor`, `reservedTicket` (Ticket), `underName`, `reservationStatus`; Beispiel Ticket mit `ticketedSeat` → Seat `seatSection/seatRow/seatNumber` (https://schema.org/EventReservation, gelesen).
- **schema.org `Event`**: `maximumAttendeeCapacity` „total number of individuals that may attend“, `remainingAttendeeCapacity`, `attendee`, `organizer`, `offers`, `eventAttendanceMode`, `isAccessibleForFree` (https://schema.org/Event, gelesen).
- **JSCalendar RFC 8984 §4.4.6 Participant**: `participationStatus` needs-action/accepted/declined/tentative/delegated, `expectReply`, `roles` (owner, attendee, optional, informational, chair, contact), `kind`; eine Kapazitäts-Eigenschaft wurde im gelesenen Teil nicht gefunden (https://www.rfc-editor.org/rfc/rfc8984.html, erste 100 000 Zeichen gelesen).
- **AS2**: `Question` mit `oneOf`/`anyOf` (nie beides), `closed`; `Invite` („Offer … invitation“), `Accept`, `TentativeAccept`, `Reject` (https://www.w3.org/TR/activitystreams-vocabulary/, gelesen bis 100 000 Zeichen).
- **Cap'n Proto**: `@N` fortlaufend ab 0, neue Mitglieder nur mit höherer Nummer, „You cannot change a field, method, or enumerant's number“, Typ/Standardwert ändern unsicher, „A Cap'n Proto file must have a unique 64-bit ID“ (https://capnproto.org/language.html, gelesen) → Regel für fs-scaffold.
- **JSON Schema 2020-12**: „declarative language for describing the structure and constraints of JSON data“, für Prüfung und Doku (https://json-schema.org/overview/what-is-jsonschema, gelesen). Nur an der Grenze (Export der Beschreibungen), nie Speicher (ADR 0086). OpenAPI/AsyncAPI: `[nicht gelesen; Konzept]`, für Web-Grenze später.
- **RFC 9553 (JSContact)**: im Bestand (ADR 0014), hier nicht neu gelesen.

## 4. Was wir übernehmen (Konzepte) / NICHT übernehmen
| Konzept | Vorbild | Wir |
|---|---|---|
| Baukasten ändert keine Datenstruktur; Datenquelle muss existieren | PA | **übernehmen**: fs-forms bindet nur Vorhandenes, neue Felder nur über fs-scaffold |
| Datenquelle bringt Spaltennamen + Typen mit; Prüfinfo aus der Quelle (`DataSourceInfo`) | PA, DI | **übernehmen** als Typbeschreibung (ADR 0066 §3) |
| Eingabe/Anzeige je Feldtyp („interfaces, displays“) | DI | **übernehmen**, gibt es schon als ADR 0066 §4; neu `accepts` im Block-Vertrag |
| Zugriff mit der Anmeldung der Person | PA | **übernehmen**, strenger: nie Dienstkonto, nie Zugangsdaten in der Beschreibung |
| Rechte additiv über Gruppen | RT | nicht nötig: Rechte kommen allein vom Datenbesitzer (fs-access/fs-groups) |
| Formelsprache (Power Fx), `{{ }}`-JavaScript, Handlebars, JS-Objekte, eigene React-Komponenten | PF, AS, RT, BB | **NICHT** (kein freier Code); Logik = fs-workflows |
| Geschlossene Liste von Bedingungs-Aktionen ohne Code | TA | **später** (Nachtrag-Punkt 12: v1 nichts, dann geschlossene Liste), nie Ausdrücke |
| Steuerelement mit Version und Variante in der Quelldatei; Versionsstempel je Dokument | PY, PF | **übernehmen**: Baustein-Name + Vertragsversion + Variante; `schema` je Beschreibung |
| Quelltext nur lesbar, echte App in Binärpaket | PY | **NICHT**: unsere Beschreibung ist die Wahrheit, typisiertes TOML, menschenlesbar |
| Eigene App-Datenbank (CouchDB, PostgreSQL) im Baukasten | BB, TJ | **NICHT**: keine Kopie, Daten bleiben beim Besitzer |
| Browser-Speicher für App-Zustand (`storeValue`) | AS | **NICHT**; Sitzung nach ADR 0069 |
| Frei erfundene Felder ohne Standard (Formula, Rollup) | BR, ND | **NICHT**: Feld nur mit Standard-Beleg; Berechnungen = Workflow |
| Kontingent je Angebot, Check-in-Listen mit Regeln, Sitzkategorie ↔ Angebot | PX | **übernehmen (Konzept)** im Veranstaltungsprogramm |
| Sitzplan als JSON-Datei | PX | **NICHT** als Speicher; Plan typisiert (Zone/Reihe/Nummer als Spalten), schema.org `Seat` an der Grenze |
| Sitzplätze nur in Bezahlfassung | PX | **NICHT**: alles frei |

## 5. Lücken der Recherche
- Retool: Zugangsdaten je Abfrage (Ressource vs. Person) nicht belegt (404). Appsmith-Git-Format nicht belegt (404). NocoBase/ToolJet-Konzepte (Blöcke, Plugins, Rechte) auf den heutigen Seiten nicht beschrieben.
- pretix: Fragen/Teilnehmerdaten, Warteliste nicht gelesen (keine Guide-Seite gefunden). Eventbrite, Pretalx, Typeform, Superblocks nicht abgerufen.
- Vorbild-Dossier mit Arbeitsabläufen und Menübäumen (Regel R2) fehlt noch: vor dem Editor-Frontend (Etappe E5) eigener Lauf `dossier` mit Bildern (Power Apps Studio, Budibase-Designer, Appsmith-Editor, Tally-Editor).
