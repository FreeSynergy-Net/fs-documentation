# Feature-Liste fs-forms: Formulare allgemein (Fragebogen, Anmeldung, Quiz, Meinungsbild) (Workflow feature-liste, Sonnet, 2026-11-17; ergänzt b7)

Entwurf, nicht gepusht. ADR 0013: nur Konzepte aus offiziellen Texten gelesen, nichts kopiert; Nextcloud Forms (AGPL): nur Konzept. Kein Vorbild-Dossier vorhanden (Lücke K3), daher Kurz-Dossier (Abschnitt 1-2) aus offiziellen Quellen; Menü-Pflichtabschnitte: wo die Quelle sie nicht zeigt, "[nicht belegt]". Abgrenzung ADR 0087 (Nachtrag 2026-11-16): fs-forms = Fragebogen, Anmeldung, Quiz, Meinungsbild; Abstimmung/Beschluss/Terminfindung gehören zu fs-decisions (Doodle-Terminumfrage = Facette von fs-decisions, Eingabefelder kommen EINGEBETTET aus fs-forms). Capability bleibt `surveys` (Anzeigename Forms).

## 0. Stand heute (ehrlich)
- Kern `fs-forms-core` + `fs-forms-methods` (Repo fs-surveys, Kopf bd4ee3f "Rename to fs-forms"; README: Tag v0.0.1, Doku-Seite sagt v0.3.0: Widerspruch, prüfen). 107 Tests. KEIN Fenster, KEIN Server, Schnittstelle `surveys.capnp` Entwurf/vorläufig.
- Im Kern: Umfragen mit Fragen und Bedingungen, Stufen Entwurf/offen/geschlossen; namentliche Antworten (Entwurf speichern, fortsetzen, abschicken, ersetzen solange offen); anonyme Antworten im getrennten Behälter (kein Protokoll, keine Zeit, durchmischt) mit Einmal-Tokens; Ergebnis nur ab Mindestgruppengröße; Auswertung plurality/approval/majority/supermajority; CSV-Export; Ausweiten über Gruppen; Entscheidung mit Aufgaben verknüpfbar (zieht laut ADR 0087 nach fs-decisions).
- Fehlt: Fenster, öffentlicher Link, Einbettung, echte Token-Zustellung (Messenger), DDI-/FHIR-Export, Vorlagen, Sprungregeln im Fenster. Für "heute (Fenster)" gilt daher: NICHTS bedienbar; "Kern" unten = vorhanden im Programm, nicht bedienbar (zählt nicht als heute).

## 1. Vorbilder und Quellen (offiziell, abgerufen 2026-11-17)
| Kürzel | Vorbild | Quelle / Lesestand |
|---|---|---|
| LS | LimeSurvey (GPL) | https://www.limesurvey.org/manual/Question_types ; https://www.limesurvey.org/manual/LimeSurvey_Manual (gelesen) |
| GF | Google Forms | https://support.google.com/docs/answer/6281888 ; .../2839737 (Fragetyp-Liste steht in verlinktem Artikel, nicht gelesen) |
| MF | Microsoft Forms | https://support.microsoft.com/en-us/office/create-a-form-with-microsoft-forms-4ffb64cc-7d5d-402f-b82e-b1d49418fd9d |
| NF | Nextcloud Forms (AGPL, nur Konzept) | https://github.com/nextcloud/forms (README, docs/DataStructure.md); Benutzerhandbuch-Seite nicht erreichbar (404) |
| KT | KoboToolbox (XLSForm) | https://support.kobotoolbox.org/getting_started_xlsform.html (nur Einstieg gelesen; Offline/Export nur als Titel) |
| MD | Moodle Quiz (GPL; Quiz) | https://docs.moodle.org/en/Quiz_settings (gelesen: Timing Open/Close/Time limit; Grade Attempts allowed/Grading method/Grade to pass; Layout; Question behaviour; Review options Marks, Right answer, Specific/General/Overall feedback; Fragetypen-Liste dort nicht gelesen) |
| PT | pretix (AGPL: nur Konzept; Anmeldung/Plätze) | docs.pretix.eu: Seiten Settings/Waitinglist 404 bzw. Seite entfallen, Guides-Index ohne Warteliste-Titel: **[nicht belegt]**; Plätze/Warteliste/Stornierung nur aus bekanntem Produktkonzept, nicht aus dem Abruf |
| JF | Jotform | https://www.jotform.com/help/ (Index): Formulararten Registration, Feedback, Evaluation, Application, Order, Contact, Request, Reservation/Booking, Quiz/Signup-Karten, Survey; Conditional Logic, Workflows (Freigaben), Widgets; Feldtypen-Namen **[nicht belegt]** |
| CG | Cognito Forms | https://www.cognitoforms.com/support (Index): Feldtypen allgemein, Conditional Logic, Entries (Ansicht, Import/Export, Teilen), Benachrichtigungen; Unterschrift, Warteliste **nicht erwähnt** |
| FS | Formstack | **[nicht abgerufen]** (nicht versucht; ADR 0013: nur offizielle Doku) |
| EB | Eventbrite | **[nicht abgerufen]** |
| KH | Kahoot | support.kahoot.com: Abruf 403, **[nicht belegt]** |
| TF | Typeform | help.typeform.com Fragetypen: Abruf 403, [nicht belegt]; nicht in der Liste gezählt |
Eigene Dossiers: fs-documentation docs/de/programs/apps/forms/{index,design,requirements}.md (Anonymitätsstufen, Entscheidungsarten, Muster); ADR 0087 Nachträge; ADR 0037 (kompakte Workbench in anderen Programmen). Kandidaten laut Doku-Seite: LimeSurvey, Nextcloud Forms, Formbricks, Framadate, Google Forms, Microsoft Forms (Framadate/Formbricks hier nicht gelesen; Framadate = Terminfindung, gehört zu fs-decisions).

## 2. Ansichten und Abläufe je Vorbild (nur Belegtes)
- LS: Fragengruppen zuerst anlegen, dann Fragen; Frage öffnen > Reiter "General options" rechts (Typ ändern); Antwortoptionen/Unterfragen je Frage; Fragetypen: Arrays (9 Varianten), Maskenfragen (Datum, Datei-Upload, Geschlecht, Sprachwechsel, Zahl, mehrere Zahlen, Rangfolge, erweiterte Rangfolge, Textanzeige, Ja/Nein, Gleichung), Mehrfachauswahl (mit Kommentar, Bildauswahl), Einzelauswahl (5 Punkte, Liste Dropdown/Radio, mit Kommentar, Bildauswahl), Text (kurz/lang/riesig/mehrere kurze). Umfrage-Menü: Fragen/Gruppen, Teilnehmer (früher Tokens), Quoten, Bewertungen (Assessments), Berechtigungen, E-Mail-Vorlagen, Ressourcen. Einstellungen: Allgemein, Textelemente, Datenschutz, Themen, Darstellung, Teilnehmer, Benachrichtigungen, Veröffentlichung/Zugang. Test, aktivieren, schließen; Antworten durchsehen, Statistik (einfach/Experte), Zeitstatistik, Export (auch Struktur .lss, QueXML PDF), Import, Mehrfachlöschen; Bedingungen und ExpressionScript; mehrsprachig; Datenverschlüsselung; Vorlagen-Editor (CSS).
- GF: Leeres Formular (Plus), Namensfeld; Abschnitte (bis 75; benennen/umsortieren/duplizieren/löschen); Schalter "Pflicht"; "Fragen nach Antworten zeigen" (Bedingungen); Quiz mit Bewertung; Thema/Schrift; Einstellungen > Darstellung: Reihenfolge mischen, Autospeichern der Antwortenden abschalten; Option-Reihenfolge mischen je Frage über "Mehr"; Antworten in neues Sheet; Diagramme live; Mitarbeitende (gemeinsam bearbeiten); Standard-Einstellungen für neue Formulare. Fragetypen im Einzelnen [nicht belegt].
- MF: Fragetypen Auswahl, Text, Bewertung, Datum; "Weitere": Rangfolge, Likert, Datei-Upload, Net Promoter Score; Abschnitte; Textformat im Titel (fett/kursiv/Farbe/Nummerierung); Titel ≤ 90, Beschreibung ≤ 1000 Zeichen; Bild an Frage; Verzweigung (verlinkt, Inhalt nicht gelesen); Thema; Vorschau Rechner/Handy mit Testantwort; Autospeichern; Knöpfe "Neues Formular", "Neu hinzufügen", "Vorschau", Menü "Weitere Formulareinstellungen"; Warnung: Frage löschen löscht deren Antworten dauerhaft; als Excel-/OneNote-Form.
- NF: Reduziert ("nur das Wesentliche"), handytauglich, Antworten visualisiert + CSV-Export im Google-Forms-Format, Webhooks. Formulareigenschaften: Zugriff (alle angemeldeten / in Navigation zeigen), Beginn, Ablauf, anonym, mehrfach abschicken, eigene Antworten ändern/löschen, Ablaufdatum zeigen, Zustand aktiv/geschlossen/archiviert, Bestätigungs-Mail, eigene Abschlussmeldung (Markdown). Typen: Mehrfachauswahl, Einzelauswahl, Dropdown, Kurztext, Langtext, Datum, Zeit, Datei (Typ-/Größengrenze), lineare Skala, Farbe, Rangfolge (Raster erwähnt).
- KT: Formular als XLSForm (Tabellenblatt `survey`: Spalten `type`, `relevant` = Überspringregel); Projekt aus Upload, "Vorschau" zum Testen, Fehler zeigen Zeile/Ausdruck; Erhebung per Webformular und App KoboCollect (offline: im Abruf nicht belegt).

## 3. VOLLSTÄNDIGE Feature-Liste
Stufen: heute (Fenster nutzbar) | als Nächstes | später. "Kern" = im Programm vorhanden, Fenster fehlt. Vorbilder: LS GF MF NF KT.
| # | Funktion | Stufe | Vorbilder |
|---|---|---|---|
| 1 | Fenster: Liste meiner Umfragen (Name, Zustand, Antwortzahl), Suche | als Nächstes | GF MF NF LS |
| 2 | Umfrage anlegen/umbenennen/duplizieren/löschen (Löschwarnung: Antworten gehen mit) | als Nächstes (Kern: anlegen/bearbeiten) | alle |
| 3 | Fragen hinzufügen, ändern, verschieben, löschen (Editor mit Vorschau) | als Nächstes (Kern) | alle |
| 4 | Fragetypen Einzel-/Mehrfachauswahl, Dropdown, Kurz-/Langtext, Zahl, Datum, Zeit | als Nächstes (Kern teils) | alle |
| 5 | Pflichtfrage, Validierung (Länge, Zahlbereich, Muster) | als Nächstes (Kern: Bedingungen) | GF LS |
| 6 | Zustände Entwurf/offen/geschlossen/archiviert, Beginn und Ablauf | als Nächstes (Kern: 3 Stufen) | NF LS |
| 7 | Antwort ausfüllen (Fenster Antwortende), Entwurf speichern, fortsetzen, abschicken | als Nächstes (Kern) | GF MF |
| 8 | Anonymitätsstufe wählen UND dem Antwortenden zeigen samt Grenzen | als Nächstes (Kern; Alleinstellung) | NF(anonym) LS(Teiln.) |
| 9 | Ergebnis-Zusammenfassung mit Diagrammen, Zahl der Antworten | als Nächstes (Kern: Zusammenfassung) | GF MF NF LS |
| 10 | CSV-Export | als Nächstes (Kern) | NF GF LS KT |
| 11 | Vorschau/Testantwort ohne zu speichern | als Nächstes | MF KT LS |
| 12 | Einladen: Personen/Gruppen auswählen (Personen-Verweis-Baustein) | als Nächstes | NF LS |
| 13 | Abschnitte/Seiten, Reihenfolge umsortieren | später | GF MF LS |
| 14 | Sprungregeln/Anzeige-Bedingungen im Editor | später (Kern: Bedingungen) | GF MF LS KT |
| 15 | Rangfolge, Skala/Likert, Bewertung (Sterne), NPS | später | MF NF LS |
| 16 | Matrix/Raster-Fragen (Arrays) | später | LS NF |
| 17 | Datei-Upload (Typ/Größe begrenzt; Ziel fs-files) | später | MF NF LS |
| 18 | Bild an Frage/Antwort; Textformat in Titel | später | MF GF LS |
| 19 | Fragen/Antworten mischen (Zufallsreihenfolge) | später | GF LS |
| 20 | Quiz/Test mit Punkten und Auswertung (Ausbau siehe Nr. 44-48) | als Nächstes (b7: sichtbar) | GF LS(Assessments) MD |
| 21 | Einmal-Tokens zustellen ("eine Antwort je Person"), Zustellung Messenger | später (Kern; Messenger fehlt) | LS(Teilnehmer) |
| 22 | Eigene Antworten ändern/löschen nach Abschicken | später (Kern: ersetzen solange offen) | NF |
| 23 | Mehrfach-Abgabe erlauben/verbieten | später | NF |
| 24 | Abschlussmeldung, Bestätigungs-Mail | später | NF |
| 25 | Quoten (Obergrenze je Antwort/Gruppe), Anmeldung mit Plätzen (Ausbau siehe Nr. 39-43) | als Nächstes (b7: sichtbar) | LS PT |
| 26 | Mehrsprachige Umfrage | später | LS (+AS2 nameMap) |
| 27 | Antworten durchsehen/filtern/kreuzen, einzeln löschen | später | LS GF |
| 28 | Mindestgruppengröße und "Noch kein Ergebnis" sichtbar erklären | später (Kern) | (eigen) |
| 29 | Auswertungsmethoden (Mehrheit, Zustimmung, ...) im Fenster nur lesend; Verfahren selbst gehört nach fs-decisions/fs-tally | später | (eigen) |
| 30 | Ausweiten auf übergeordnete Gruppe (Anonymität nie schwächer) | später (Kern) | (eigen, kein Vorbild) |
| 31 | Vorlagen und Fragensammlung (Wiki-Vorlagen, ADR 0031) | später | GF MF LS |
| 32 | Öffentlicher Link ohne Konto + Missbrauchsschutz; Einbettung (ADR 0037) | später (Server) | GF MF NF LS |
| 33 | Zusammenarbeit: Mitbearbeiter am Formular | später | GF MF LS(Berechtigungen) |
| 34 | Webhooks/Benachrichtigung bei neuer Antwort (`subscribe`) | später | NF GF(Add-ons) |
| 35 | Import/Export Struktur (XLSForm, FHIR Questionnaire, DDI); QueXML | später | KT LS |
| 36 | Offline-Erhebung (App) | später, offen ob gewollt | KT |
| 37 | Sensible Umfrage markieren (ADR 0029) | später | (eigen) |
| 38 | Terminfrage-Eingabefelder eingebettet (fs-decisions/Kalender; Abgrenzung ADR 0087) | später | (Framadate/Doodle) |
### 3a. Ergänzung b7 (2026-11-17): fs-forms = FORMULARE allgemein (Fragebogen, Anmeldung, Quiz, Meinungsbild)
Prüfbefund der ersten Fassung: Editor, Fragetypen (Text, Zahl, Datum/Zeit, Auswahl, Dropdown, Skala, Matrix, Ranking, Datei), Bedingungen, Abschnitte, Pflicht/Validierung, Anonymität, Einladen, CSV, Vorlagen, Benachrichtigung waren da; **es fehlten**: Anmeldung (Plätze, Warteliste, Bestätigung, Stornierung), Quiz im Einzelnen (Lösungen, Zeitlimit, Rückmeldung), Meinungsbild mit Live-Ergebnis, Feldarten Unterschrift/Einwilligung und Adresse/Person, Antworten-Verwaltung als Tabelle/Einzelansicht, Terminfrage nur als Randnotiz. Neue Zeilen (Vorbilder: MD Moodle Quiz, PT pretix, JF Jotform, CG Cognito, FS Formstack, EB Eventbrite, KH Kahoot, TF Typeform; Lesestand Abschnitt 1):
| # | Funktion | Stufe | Vorbilder |
|---|---|---|---|
| 39 | Anmeldung: Formular mit Platzgrenze je Termin/Option (Quote), Zähler "noch n Plätze" | als Nächstes | PT LS EB JF |
| 40 | Warteliste bei voller Quote, automatisches Nachrücken mit Bestätigung | später | PT EB |
| 41 | Bestätigung an die Person (Anmeldung angekommen / Platz bestätigt) | später (Zustellung braucht Messenger) | NF PT EB |
| 42 | Stornierung/Abmeldung durch die Person, Platz wird frei | später | PT EB |
| 43 | Anmeldeliste für Veranstalter (Tabelle, Anwesenheit abhaken, Export) | später | PT EB CG |
| 44 | Quiz: richtige Antwort je Frage, Punkte je Frage, Gesamtpunkte, Bestehensgrenze | als Nächstes | MD GF KH |
| 45 | Quiz: Zeitlimit je Test/Frage, Beginn/Ende ("Open/Close the quiz", "Time limit") | später | MD KH |
| 46 | Quiz: Rückmeldung je Antwort und gesamt, Lösungen nach Abgabe zeigen (steuerbar) | später | MD GF |
| 47 | Quiz: mehrere Versuche, Wertung (beste/letzte) | später | MD |
| 48 | Quiz: Auswertung je Person und je Frage (Trefferquote) | später | MD GF KH |
| 49 | Meinungsbild: eine Frage, Einzel- oder Mehrfachwahl, Live-Ergebnis (Balken), sichtbar vor/nach Antwort einstellbar; ohne bindendes Ergebnis | als Nächstes | GF MF (Antworten live), NF |
| 50 | Feldart Unterschrift (gezeichnet/getippt) und Einwilligung (Häkchen mit Text, Zeitpunkt festgehalten) | später | JF [Namen im Abruf nicht belegt] |
| 51 | Feldart Adresse (Straße, PLZ, Ort, Land) und Person (Auswahl aus fs-people über Personen-Verweis, M6) | später | JF [nicht belegt]; Verweis eigen |
| 52 | Feldarten E-Mail, Telefon, Link, Zahl mit Einheit, Währung, Farbe | später | NF GF |
| 53 | Antworten-Verwaltung: Tabelle (Spalten wählbar, sortieren, filtern), Einzelantwort ansehen, einzeln löschen, Export CSV | als Nächstes (Tabelle+CSV), Rest später | CG LS GF |
| 54 | Diagramme je Frage (Balken, Torte, Skala-Mittel), Zeitverlauf | als Nächstes | GF MF LS NF |
| 55 | Benachrichtigung an Ersteller bei neuer Antwort und bei Platzgrenze erreicht | später | NF CG |
| 56 | Anonymitätsstufen: Namentlich | Anonym mit Token | Anonym ohne Token (jeweils mit Hinweis, was sichtbar bleibt) | als Nächstes (Kern) | eigen |
| 57 | Terminfrage (Doodle-artig) liegt in fs-decisions; fs-forms liefert nur die eingebetteten Eingabefelder (Zeitfenster-Wahl, Verfügbarkeit Ja/Vielleicht/Nein); keine eigene Terminfragen-Facette in fs-forms (b7, ADR 0087) | später | (Framadate/Doodle) |
| 58 | Seiten/Abschnitte mit Fortschrittsanzeige, Zurück/Weiter, Antwort zwischenspeichern | später | GF MF |
| 59 | Formular-Vorlagen je Zweck (Anmeldung, Feedback, Quiz, Meinungsbild, Kontakt) | später | JF GF MF |
Hinweis: Nr. 8, 21, 28-30 sind Alleinstellungen laut Design (kein Vorbild hat das); Typeform-Funktionen [nicht belegt].

## 4. Menübäume je Vorbild (nur Belegtes)
Alle Vorbilder sind Web-Oberflächen ohne Menüleiste. Vollständige Menüs sind aus den abrufbaren offiziellen Texten nicht belegt.
- LS (Umfrage-Menü belegt): Fragen/Fragengruppen | Teilnehmer | Quoten | Bewertungen | Berechtigungen | E-Mail-Vorlagen | Ressourcen; Einstellungen siehe Abschnitt 2. Reihenfolge, Untermenüs: [nicht belegt].
- GF: Kopf: Einstellungen, Vorschau, Senden (Namen aus allgemeinem Wissen, im Abruf nur "Settings" belegt); Frage: Pflicht-Schalter, "Mehr" (Option-Reihenfolge mischen). Vollständiger Baum [nicht belegt].
- MF: Knöpfe "Neu hinzufügen", "Weitere Fragetypen", "Vorschau", "Weitere Formulareinstellungen" (Feedback u. a.). Rest [nicht belegt].
- NF, KT: [nicht belegt].
- Kontextmenüs (Rechtsklick): bei keinem belegt. Werkzeugleiste: Fragetyp-Auswahl + "Neu hinzufügen" (MF belegt). Tastenkürzel: bei keinem belegt: [nicht belegt].
Muster: Editor in der Mitte (Fragenkarten, Plus unten), Eigenschaften der gewählten Frage, Reiter Fragen | Antworten (Ergebnis) | Einstellungen | Teilen (Muster, nicht wörtlich belegt).

### VORSCHLAG Menübaum fs-forms (eigenes Konzept; Entscheidung b7: Seitenleiste + Symbolleiste + Kontextmenüs, KEINE Menüleiste; Shell-Titelleiste ADR 0065 Programm | Ansicht | Hilfe)
Seitenleiste (Reihenfolge): Meine Formulare | Mit mir geteilt | Entwürfe | Anmeldungen | Quiz | Meinungsbilder | Geschlossen/Archiv | Vorlagen. (Die Arten sind Filter auf EIN Programm = Facetten; nach Regel Facette ≠ Suite.)
Reiter eines Formulars: Fragen | Antworten (Tabelle, Einzelantwort, Diagramme) | Einstellungen (Zugang, Anonymität, Platzgrenze/Warteliste, Quiz: Punkte/Zeitlimit/Lösungen) | Teilen (Einladen über Personenauswahl).
Symbolleiste (Editor): Neues Feld ▾ (Text kurz/lang, Zahl, Datum/Uhrzeit, Einzelwahl, Mehrfachwahl, Dropdown, Skala/Bewertung, Matrix, Rangfolge, Datei, Unterschrift/Einwilligung, Adresse/Person, Abschnitt) | Vorschau | Veröffentlichen/Schließen | Teilen | Suchfeld | Weitere ▾ (Duplizieren, Export CSV, Als Vorlage speichern, Archivieren, Löschen…).
Kontextmenü Feld: Bearbeiten | Duplizieren | Nach oben/unten | Pflicht (Häkchen) | Bedingung… | Richtige Antwort/Punkte… (nur Quiz) | Löschen…. Kontextmenü Formular (Liste): Öffnen | Duplizieren | Schließen | Archivieren | Als Vorlage | Löschen…. Kontextmenü Antwort (Tabelle): Ansehen | Löschen…. Kontextmenü Anmeldung (Teilnehmerzeile): Bestätigen | Von Warteliste nachrücken | Stornieren.
Kürzel (Vorschlag, nicht belegt, CUA/ADR 0074): Strg+N neues Formular, Strg+Enter Feld hinzufügen, Entf löschen, F2 umbenennen, Strg+P Vorschau, Strg+Umschalt+E Export. Ausgegraut immer mit Grund. Nicht gebaute Einträge gesperrt "kommt noch".

## 5. Die wichtigsten nächsten Funktionen (neu gewichtet b7: Formular-Editor, Feldarten, Anmeldung, Quiz sichtbar)
1. Formular-Editor im Fenster: Liste + Felder anlegen/ändern/verschieben + Vorschau [L]: ohne Fenster ist der Kern unsichtbar (Nr. 1-3, 11).
2. Feldarten-Grundsatz: Text kurz/lang, Zahl, Datum/Uhrzeit, Einzel-/Mehrfachwahl, Dropdown, Skala, Pflicht/Validierung [M]; danach Matrix, Rangfolge, Datei, Unterschrift/Einwilligung, Adresse/Person (Nr. 4, 5, 15-17, 50-52).
3. Anmeldung: Platzgrenze mit Zähler, Bestätigung, später Warteliste/Stornierung [M] (Nr. 39-43): häufigster Alltagsfall in Gruppen und Vereinen.
4. Quiz: richtige Antwort, Punkte, Auswertung je Person [M] (Nr. 44-48); Zeitlimit, Lösungen zeigen später.
5. Antwort-Fenster (ausfüllen, Entwurf, abschicken) + Anonymitätsstufe sichtbar [M] (Nr. 7, 8, 56).
6. Antworten-Verwaltung: Tabelle, Einzelantwort, Diagramme, CSV [M] (Nr. 9, 10, 53, 54).
7. Meinungsbild mit Live-Ergebnis [S-M] (Nr. 49); Einladen über Personen-/Gruppenauswahl [M] (Nr. 12, braucht M6).
8. Bedingungen und Abschnitte im Editor [M] (Nr. 13, 14, 58).

## 6. Lücken in fs-components (Verweis PLAN-components-menue.md M1-M8)
M1 Befehlsmodell (Symbolleiste, Zustand mit Grund), M2 Kürzel, M3 Kontextmenü (Frage/Antwort), M4 Tastatur, M5 Baum (Frageliste, Abschnitte; Drag-Umsortieren steht dort NICHT: Lücke), M6 Personenauswahl (Einladen), M7 Befehlsleiste. Zusätzlich laut Design neu: Workbenches `survey-builder`, `survey-form`, Widgets `question`, `matrix-question`, `ranking-list` (docs components/planned); vorhanden: field, radio-group, checkbox, rating, slider, date-input, wizard, chart, table.

## 7. Offene Fragen (aktualisiert b7 2026-11-17)
1. Version = Tag: Grundfassung ist v0.0.2 (README v0.0.1, Doku-Seite v0.3.0 widersprechen sich; beim Lift auf den Tag setzen).
2. Antwortende: zuerst nur Eingeladene (Entscheid); öffentlicher Link erst mit dem Server-Teil. Bestätigt?
3. Terminfrage/Doodle: nach b7 in fs-decisions, nur Eingabefelder eingebettet aus fs-forms (Nr. 57). Bestätigt, keine Facette in fs-forms?
4. Quiz und Anmeldung als "als Nächstes" mit Grundumfang (Punkte; Platzgrenze), Warteliste/Zeitlimit später: ausreichend?
5. Vorbild-Lücken (pretix, Jotform, Cognito, Kahoot, Typeform, Formstack, Eventbrite: Abruf nicht möglich/zu dünn): Lauf mit Netz oder Aufnahmen vom Menschen?

## Änderungsvermerk
2026-11-17 (Zusatzauftrag b7): Titel/Abgrenzung auf Formulare allgemein erweitert; Vorbilder Moodle, pretix, Jotform, Cognito, Formstack, Eventbrite, Kahoot ergänzt (Lesestand ehrlich: meist nur Index/`[nicht belegt]`); Feature-Liste um Nr. 39-59 ergänzt (Anmeldung, Quiz, Meinungsbild, Feldarten, Antworten-Verwaltung, Diagramme, Benachrichtigung, Terminfrage-Abgrenzung), Nr. 20 und 25 auf "als Nächstes"; Menübaum-Vorschlag und Top-8 neu; Fragen aktualisiert.
