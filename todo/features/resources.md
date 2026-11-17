# Feature-Liste fs-resources (Workflow feature-liste, Sonnet, 2026-11-17)

Entwurf, nicht gepusht. ADR 0013: nur Konzepte aus offiziellen Texten; Snipe-IT (AGPL) und Odoo: nur Konzept. Kein Vorbild-Dossier vorhanden (Lücke K3): Kurz-Dossier aus offiziellen Quellen, Menü-Pflichtabschnitte "[nicht belegt]" wo die Quelle sie nicht zeigt. Grundlage: ADR 0076 (Ressource = REA/ValueFlows `EconomicResource`), ADR 0087 Nachtrag 2026-11-16 (fs-resources BLEIBT, nach ValueFlows: ResourceSpecification, EconomicResource, Intent = Angebot und Gesuch, Proposal/Katalog, Commitment, EconomicEvent; Recipe/Process bleiben bei fs-workflows; Katalog = Filter; Laden = Suite), Checkliste todo/checklisten/fs-resources.md.

## 0. Stand heute (ehrlich)
- Kern `fs-resources-core` (115 Tests, 4 Prüfrunden; Versionsangaben widersprüchlich: README Tag v0.0.1, DESIGN "0.1.0", Doku-Seite "v0.2.0", Checkliste: GitHub-Tag v0.0.1 und lokale Alt-Tags). KEIN Fenster, KEIN Server (Server müsste Kapazitätsaufrufe ablehnen, solange der Aufrufer unbekannt ist).
- Im Kern: Dinge, Räume (Art "room"), Material mit abgeleitetem Bestand; Reservierungen (Zustände requested/confirmed, reiner Sweep, Überbuchung unmöglich unter einer Sperre; `finish` gibt frei bzw. verbraucht Material); freie Zeit einer Sache über einen Zeitraum; eigene Kapazität (Minuten/Woche), Zuteilungen, Freigabe an Gruppen in eigenem ungeloggtem Speicher; Gruppenlast (`groupLoad` über Groups-Port, mit benannten Grenzen); Bedarf und Angebot (Annehmen erzeugt Reservierung). Löschen wird bei bestätigter Reservierung verweigert.
- Fehlt: Fenster, Server, Kosten, MSPDI, Fähigkeiten (Skills), Lager/Chargen/Bewertung (bewusst nicht ERP), ValueFlows-Neuschnitt (Checkliste "Neuschnitt": ResourceSpecification, Intent in einer Form, EconomicEvent-Übergabe, Katalog-Filter; alle offen, Strategie-OK nötig), typisierte Speicherung (ADR 0086) offen.
- "heute" im Fenster-Sinn: nichts bedienbar. "Kern" unten = im Programm, Fenster fehlt (zählt nicht als heute).

## 1. Vorbilder und Quellen (offiziell, abgerufen 2026-11-17)
| Kürzel | Vorbild | Quelle / Lesestand |
|---|---|---|
| VF | ValueFlows 1.0 (Vokabular, CC BY-SA: nur Konzept/Link) | https://www.valueflo.ws/specification/all_vf/ (Klassenliste gelesen; Aktionen nur teils: consume/produce/work/transfer) ; valueflows.org nicht erreichbar |
| SI | Snipe-IT (Inventar, AGPL: nur Konzept) | https://snipe-it.readme.io/docs/overview (gelesen; Reservierungen/Menüs dort nicht behandelt) |
| NC | Nextcloud Kalender: Räume und Ressourcen | https://docs.nextcloud.com/server/latest/user_manual/en/groupware/calendar.html (Abschnitt Räume/Ressourcen) |
| OD | Odoo Inventory (Konzept) | https://www.odoo.com/documentation/latest/applications/inventory_and_mrp/inventory.html (Gliederung gelesen) |
| MB | Microsoft Bookings (persönliche/geteilte Buchungen, Personal als Ressource) | https://learn.microsoft.com/en-us/microsoft-365/bookings/bookings-overview |
Nicht belegt: Open Food Network, Cyclos, hOurworld (Abruf nicht versucht, Zeitrahmen); Snipe-IT-Wartung (404). Eigene Dossiers: docs/de/programs/apps/resources/index.md, fs-resources DESIGN.md, research/projectmanagement-landscape.md (Kapazitätsplanung fehlt in OSS-Werkzeugen), ADR 0075 (fs-marketplace als Facette), ADR 0076.

## 2. Ansichten und Abläufe je Vorbild (nur Belegtes)
- VF: Klassen Agent (Person, Organisation), EconomicResource (Menge, Ort, verantwortlicher Agent), ResourceSpecification (Art; Güter, Dienste, Währung, Fähigkeiten, Arbeit), Intent (gewünscht/geplant, einseitig), Commitment (Zusage zwischen Agenten), EconomicEvent (beobachteter Fluss ändert Menge/Ort/Verantwortung), Proposal (veröffentlichtes Angebot/Gesuch, ggf. Gegenleistung; Proposal-Listen), Agreement (Bündel wechselseitiger Zusagen), Plan/Process (gehört zu fs-workflows), Unit/Measure, Spatial Thing als Ort. Bedienoberfläche: keine (Vokabular).
- SI: Anlagen mit eindeutigem Asset-Tag, an Person/Ort/andere Anlage ausgegeben; Ein-/Ausgabe (Check-out/Check-in) verhindert Doppelbelegung, beim Rücknehmen Zustand setzen; Zubehör (mehrfach, ohne Tag), Komponenten (in Anlage), Verbrauchsmaterial (nur an Personen, nie zurück), Lizenzen; Statusmarken Nicht einsetzbar/Einsetzbar/Archiviert/Ausstehend; Farbmarken; Spaltenauswahl; Admin-Einstellungen (Marke, Warnungen, LDAP, 2FA).
- NC: Räume/Ressourcen wie Teilnehmende zum Termin hinzufügen; Konfliktprüfung; erster Termin = angenommen, überlappender = abgelehnt; Ressourcen werden NICHT im Kalender verwaltet (Admin richtet Backend ein); mit App "Calendar Rooms and Resources" (NC 30+): "Raumverfügbarkeit" (Frei/Belegt wie bei Teilnehmern).
- OD: Produktverwaltung (Typen, Einheiten, Verpackung, Seriennummern/Chargen, Ablauf), Lager/Orte/Vorgangsarten, Inventurkorrektur, Zählung, Ausschuss, Nachschub (Regeln, Mindestbestand), Ein-/Ausgänge in 1-3 Schritten, Reservierungsmethoden (bei Bestätigung/manuell/vor Termin), Entnahmestrategien (FIFO/LIFO/FEFO), Bewertung, Berichte (Bestand, Bewegungen), Barcode. Bewusst größer als unser Umfang.
- MB: persönliche Buchungsseite (eigene Verfügbarkeit, Termintypen, Link teilen); geteilte Buchung: Team, Dienste, Mitarbeitende, Öffnungszeiten, Planungsregeln; E-Mail/SMS-Erinnerungen; Online-Meeting-Link; Zugang web, Outlook, Teams.

## 3. VOLLSTÄNDIGE Feature-Liste
Stufen: heute (Fenster nutzbar) | als Nächstes | später. "Kern" = im Programm vorhanden. Vorbilder: VF SI NC OD MB.
| # | Funktion | Stufe | Vorbilder |
|---|---|---|---|
| 1 | Fenster: Liste Dinge/Räume/Material (Name, Art, Bestand/Zustand), Suche, Filter | als Nächstes | SI OD |
| 2 | Ding/Raum/Material anlegen, ändern, archivieren; Löschen verweigert bei bestätigter Reservierung (Grund zeigen) | als Nächstes (Kern) | SI OD |
| 3 | Art der Sache (ResourceSpecification) mit typisierter Einheit | später (ValueFlows-Neuschnitt) | VF OD |
| 4 | Reservieren: Sache, Zeitraum, Menge; Überbuchung wird mit Grund abgelehnt | als Nächstes (Kern) | NC MB SI |
| 5 | Verfügbarkeit/Freizeit-Ansicht einer Sache über Zeitraum (Streifen frei/belegt) | als Nächstes (Kern: `free`) | NC MB |
| 6 | Reservierung bestätigen, ändern, abbrechen, abschließen (Rückgabe/Verbrauch) | als Nächstes (Kern) | SI(Check-in/out) OD |
| 7 | Material: Bestand abgeleitet, verbrauchen, Bestand korrigieren (erwarteter Wert) | als Nächstes (Kern) | SI(Verbrauch) OD |
| 8 | Bedarf einstellen (Menge, Zeit, Projekt) | als Nächstes (Kern) | VF(Intent) |
| 9 | Angebot einstellen/annehmen -> Reservierung (selbe Form wie Bedarf, Intent) | als Nächstes (Kern) | VF |
| 10 | Eigene Kapazität (Minuten/Woche), Zuteilungen sehen; nur ich | später (Kern; Server muss Aufrufer kennen) | MB(Verfügbarkeit) |
| 11 | Freigabe an eine Gruppe + Gruppenlast als Summe, MIT benannten Grenzen im Fenster | später (Kern) | (eigen; kein Vorbild) |
| 12 | Kalender-Bezug: Reservierung als Termin, Raumverfügbarkeit beim Termin wählen (fs-calendars) | später | NC MB |
| 13 | Ausgabe an Person/Ort (Check-out) mit Rückgabefrist und Erinnerung | später | SI |
| 14 | Zubehör/Komponenten (Sache in Sache), Verbrauchsmaterial nur an Personen | später | SI |
| 15 | Statusmarken (nicht einsetzbar, archiviert, ausstehend) | später | SI |
| 16 | Wartung/Instandhaltung als Aufgabe (Verweis fs-tasks) | später, offen ob gewollt | SI [nicht belegt] |
| 17 | Mehrere Orte/Lager, Ort einer Sache (Spatial Thing, fs-maps) | später | VF OD |
| 18 | Seriennummern/Chargen, Ablaufdatum | später (Kern: nein, bewusst kein ERP) | OD |
| 19 | Mindestbestand/Nachschubregel -> Bedarf automatisch | später | OD |
| 20 | Inventur/Zählung, Ausschuss | später | OD |
| 21 | Übergabe (EconomicEvent): wer hat wann an wen gegeben, protokolliert | später (ValueFlows) | VF |
| 22 | Zusage (Commitment) und Absprache (Agreement), Gegenleistung (Proposal reciprocal) | später | VF |
| 23 | Katalog als Filter (erlaubte Art, typisierte Bedingungen), Marktplatz = Katalog von Katalogen (ADR 0087) | später | VF |
| 24 | Öffentliche Buchungsseite zum Teilen (Link, Termintypen) | später (Server) | MB |
| 25 | Erinnerungen per E-Mail/Messenger vor Beginn | später | MB |
| 26 | Berichte: Auslastung, Verlauf je Sache (Bewegungen) | später | OD SI |
| 27 | Kosten (geplant/zugesagt/tatsächlich) | später (Design: getrennte Entscheidung) | OD(Bewertung) |
| 28 | Import/Export: ValueFlows (Turtle/GraphQL), MSPDI, CSV | später | VF |
| 29 | Fähigkeiten (Skills) von Personen, Suche nach Fähigkeit | später | VF(Spec: Skills) |
| 30 | Barcode/QR-Etikett scannen | später | SI OD [SI nicht belegt] |
| 31 | Tastatur: Pfeile in Liste, Entf, F2, Strg+N; Spaltenwahl/Sortierung | als Nächstes | (Standard) SI |
| 32 | Frage/Antwort Bedarf-Angebot im Messenger (Verweis in Nachricht) | später | (eigen) |
Hinweis: Nr. 11 und die Selbstbestimmung über eigene Zeit (Nr. 10) sind Alleinstellungen laut Design.

## 4. Menübäume je Vorbild (nur Belegtes)
Alle Vorbilder sind Web-Oberflächen; ein vollständiger Menübaum ist aus den abrufbaren offiziellen Texten für KEIN Vorbild belegt.
- VF: keine Oberfläche. SI: Navigationseinträge nur sinngemäß aus Funktionsnamen (Anlagen, Zubehör, Komponenten, Verbrauchsmaterial, Lizenzen, Admin-Einstellungen); Reihenfolge/Untermenüs [nicht belegt]. NC: im Termin-Dialog "Räume/Ressourcen hinzufügen", "Raumverfügbarkeit". OD: Gliederung der Doku (Produkte, Lager, Versand/Empfang, Bewertung, Barcode), keine Menüleiste belegt. MB: Zugang über linke Leiste (Outlook/Teams), Seiten: Persönlich, Geteilt; Einzelmenüs [nicht belegt].
- Kontextmenüs: bei keinem belegt. Werkzeugleiste: bei keinem belegt. Tastenkürzel: bei keinem belegt: [nicht belegt].
Muster (aus den Funktionen, nicht wörtlich belegt): Liste links, Detailseite mit Reitern (Eigenschaften | Reservierungen/Verlauf | Verfügbarkeit), Aktionsknöpfe "Ausgeben/Zurücknehmen/Reservieren".

### VORSCHLAG Menübaum fs-resources (eigenes Konzept; Entscheidung b7: Seitenleiste + Symbolleiste + Kontextmenüs, keine Menüleiste)
Seitenleiste: Dinge | Räume | Material | Reservierungen | Bedarf und Angebote | Meine Zeit | Gruppen-Auslastung.
Reiter einer Sache: Eigenschaften | Verfügbarkeit | Reservierungen | Verlauf.
Symbolleiste: Neu ▾ (Ding/Raum/Material/Bedarf/Angebot) | Reservieren… | Abschließen | Suchfeld | Ansicht-Umschalter (Liste/Zeitstreifen) | Weitere ▾ (Archivieren, Export, Löschen…).
Kontextmenü Sache: Öffnen | Reservieren… | Verfügbarkeit | Bestand korrigieren… (Material) | Archivieren | Löschen… (ausgegraut mit Grund bei bestätigter Reservierung). Kontextmenü Reservierung: Bestätigen | Ändern… | Abschließen | Abbrechen. Kontextmenü Bedarf/Angebot: Angebot machen… / Annehmen | Zurückziehen. Leerfläche: Neu | Aktualisieren.
Kürzel (Vorschlag, nicht belegt, ADR 0074/CUA): Strg+N neu, Strg+R reservieren, Entf löschen, F2 umbenennen, F5 aktualisieren. Ausgegraut immer mit Grund.

## 5. Die wichtigsten nächsten Funktionen
1. Fenster Liste + Detailseite für Dinge/Räume/Material (anlegen/ändern/archivieren) [M]: ohne Fenster ist der geprüfte Kern unsichtbar.
2. Reservieren mit Zeitraum und Überbuchungs-Meldung samt Grund [M]: Kernversprechen "zwei buchen nicht denselben Raum"; Kern fertig.
3. Verfügbarkeits-Streifen (frei/belegt) einer Sache [M]: macht Reservieren verständlich; `free` im Kern.
4. Reservierung abschließen: Rückgabe bzw. Verbrauch, Bestandsanzeige [S]: sonst bleibt alles "belegt"; Kern fertig.
5. Bedarf und Angebot in einer Form (Intent), Annehmen -> Reservierung [M]: Alleinstellung gegenüber Inventarprogrammen; nach ValueFlows-Neuschnitt-Entscheidung.
6. Kalender-Brücke: Reservierung als Termin, Raumwahl im Termin (fs-calendars) [M-L]: Vorbild NC/MB; braucht fs-calendars-Fenster.
7. Meine Zeit (Kapazität/Freigabe) mit angezeigten Grenzen [M-L]: Selbstbestimmung; erst nach Server mit Aufrufer-Prüfung.
8. Ausgabe/Rückgabe an Person mit Frist [S-M]: Alltag in Vereinen (Zelte, Geräte); Vorbild SI.

## 6. Lücken in fs-components (Verweis PLAN-components-menue.md M1-M8)
M1 Befehlsmodell (Symbolleiste, Grund bei ausgegraut), M2 Kürzel, M3 Kontextmenü (Sache/Reservierung), M4 Tastatur in Listen, M6 Personenauswahl (Ausgabe an Person, Gruppe wählen), M7 Befehlsleiste. Zusätzlich fehlend (nicht in M1-M8): Zeitstreifen/Belegungsplan-Widget (freie/belegte Stretches), Mengen-/Einheitenfeld, Zeitraum-Auswahl (date-range). Vorhanden laut Doku: table, date-input, chart.

## 7. Offene Fragen
1. ValueFlows-Neuschnitt (Checkliste, Strategie-OK offen): vor oder nach dem ersten Fenster? Ein Fenster auf heutigem Modell wird danach umgebaut.
2. Abgrenzung Angebot/Gesuch gegen fs-marketplace: ADR 0087 sagt Besitz bei fs-resources; Checkliste führt "offen". Bestätigen?
3. Version: README v0.0.1, DESIGN 0.1.0, Doku v0.2.0: welche gilt?
4. Wartung/Lizenzen/Kosten: im Umfang oder bewusst draußen (Design: nicht ERP)?
