# Feature-Liste fs-activities (Workflow feature-liste, Sonnet, 2026-11-17)

Entwurf, nicht gepusht. ADR 0013: nur Konzepte aus offiziellen Texten, nichts kopiert. Kein Vorbild-Dossier vorhanden (Lücke K3): Kurz-Dossier aus offiziellen Quellen; Menü-Pflichtabschnitte "[nicht belegt]" wo die Quelle sie nicht zeigt. Name: ADR 0087 history -> activity -> activities (Repo fs-history, Kopf 2c05fb2 "Rename fs-activity to fs-activities"; Doku-Seite "Früher History", Capability/Schnittstelle bleiben `history`). Wichtige Abgrenzung (Doku): fs-activities besitzt KEINE Inhalte, nur einen abgeleiteten lokalen Index über die Aktivitätsprotokolle der Programme (ADR 0020); Zusammenfassung statt Inhalt; Tagebuch = Facette (Filter auf "ich") mit Text als Wiki-Eintrag.

## 0. Stand heute (ehrlich)
- Kern `fs-activities-core` + Hub-Adapter `fs-activities-hub` (49 Tests, echter Hub, 3 Prüfrunden). Versionsangaben widersprüchlich: README Tag v0.0.1, Doku-Seite "v0.1.1". KEIN Fenster, KEIN Server; Schnittstelle `history.capnp` Entwurf/vorläufig.
- Im Kern: Zeitleiste der Aktivitäten anderer Programme, neueste zuerst, Filter, Seitenumbruch; `digest` (Serien von Ereignissen am selben Objekt zusammenfassen); `forget` nach Filter (nur Vergangenheit, nur dieser Index, gesalzene Hashes bleiben); liest nie Beziehungen, Rollenzuweisungen oder Umfrageantworten.
- Bekannte Grenzen: "Wer" ist leer (Hub liefert Programm als Akteur; Person = `attributedTo`), Zeit = Eingangszeit; Vergessen berührt das Protokoll des Hubs nicht; keine Freigabe, keine Gruppenansicht, kein Telemetrie-Import, keine Zeiterfassung; abgebrochene Hub-Verbindung wird nicht wiederhergestellt.
- "heute" im Fenster-Sinn: nichts bedienbar. "Kern" unten = im Programm, Fenster fehlt.

## 1. Vorbilder und Quellen (offiziell, abgerufen 2026-11-17)
| Kürzel | Vorbild | Quelle / Lesestand |
|---|---|---|
| NC | Nextcloud Activity (AGPL: nur Konzept) | https://docs.nextcloud.com/server/latest/user_manual/en/activity.html (gelesen; die Seite files/webgui/activity.html: 404) |
| GM | Google "Meine Aktivitäten" | https://support.google.com/accounts/answer/7028918 (gelesen) |
| GH | GitHub Profil: Beitragsdiagramm + Aktivitätsverlauf | https://docs.github.com/en/account-and-profile/concepts/contributions-on-your-profile (gelesen) |
| MA | Mastodon Benachrichtigungen (Stummschalten/Blockieren/Schlagwortfilter, nur Kurzbeleg) | https://docs.joinmastodon.org/user/moderating/ ; Seite user/notifications: 404 |
| AS | W3C Activity Streams 2.0 Core (Datenmodell) | https://www.w3.org/TR/activitystreams-core/ |
| JR | Jira Aktivitäts-Stream | Abruf 404: [nicht belegt] |
Eigene Dossiers: docs/de/programs/apps/activities/index.md, DESIGN.md im Repo, ADR 0020 (Aktivitätsprotokoll je Programm), ADR 0076 (Ereignis = AS2 Activity, "Was ist geschehen?" = fs-history), Memory "Selbstbestimmung über Daten", Memory "Fehlende Datenquelle melden".

## 2. Ansichten und Abläufe je Vorbild (nur Belegtes)
- NC: Zeitleiste nach Tagen gruppiert (Dateiänderungen, Freigaben, Kalender, Kontakte, Talk, je nach installierten Apps); Filter in der linken Leiste: Alle | Von dir | Von anderen | Dateiänderungen (+ Favoriten, Kalender, Kontakte je nach App); Reiter "Aktivität" in der Dateien-Seitenleiste zeigt nur Ereignisse dieser Datei/dieses Ordners; Einstellungen unten links: RSS-Schalter + Link (geheimer Token, ohne Anmeldung lesbar); Benachrichtigungen je Ereignisart: Mail/Push/beides; Mail-Takt sofort/stündlich/täglich/wöchentlich; optionale tägliche Zusammenfassung am Morgen.
- GM: Einträge einzeln, neueste zuerst, nach Tag und Uhrzeit blätterbar; Suchleiste + Filter (welche, nicht belegt); "Details" je Eintrag (wann und warum gespeichert, Ort/Gerät/App); Löschen einzeln/nach Zeitraum; automatisch löschen nach Alter; Speichern je Art ausschalten ("Ausschalten" / "Ausschalten und Aktivität löschen"); zusätzliche Bestätigung vor dem Ansehen des gesamten Verlaufs; "Weitere Aktivität" unter "Mehr"; Export: nicht erwähnt. Pfad: Konto > Daten und Datenschutz > Personalisierung und Aktivität > Meine Aktivitäten.
- GH: Aktivitätsübersicht (Beitragsarten, aktivste Repos nur lesbare); Kalender der letzten 12 Monate (UTC); Filter Organisation; Umschalter "private Beiträge einbeziehen" (anonymisiert; Standard: nur öffentlich); Verlauf mit Commits, PRs, Issues; Datumsfilter: nicht belegt.
- MA: Stummschalten kann Benachrichtigungen einschließen; Blockieren blendet sie aus; Schlagwortfilter blenden passende aus. Weitere Ansichten [nicht belegt].
- AS: Activity (actor, object, target, origin, result, instrument; Vergangenes, Laufendes, Künftiges), Verben Create, Add, Update, Delete, Like, Undo; Collection/OrderedCollection mit Seiten (first/next/prev/last); `published` RFC 3339; `summary` als Kurztext. Grundlage unseres Modells (ADR 0076).

## 3. VOLLSTÄNDIGE Feature-Liste
Stufen: heute (Fenster nutzbar) | als Nächstes | später. "Kern" = im Programm vorhanden. Vorbilder: NC GM GH MA AS.
| # | Funktion | Stufe | Vorbilder |
|---|---|---|---|
| 1 | Fenster: Zeitleiste, neueste zuerst, nach Tag gruppiert, Seitenumbruch/Nachladen | als Nächstes (Kern) | NC GM GH |
| 2 | Eintrag: Kurztext (summary), Programm, Objekt-Verweis (Klick öffnet Objekt im Programm), Zeit | als Nächstes (Kern) | NC GM AS |
| 3 | Filter links: Alle / Von mir / Von anderen (leer: "Wer" fehlt noch, ehrlich zeigen) | als Nächstes (Kern: Filter; Wer fehlt) | NC |
| 4 | Filter nach Programm, Objektart, Zeitraum, Suche im Text | als Nächstes (Kern: Filter) | NC GM |
| 5 | Zusammenfassung ("12 Änderungen an Seite X, 10-11 Uhr") aufklappbar | als Nächstes (Kern: digest) | (eigen; GH ähnlich) |
| 6 | Details je Eintrag: wann/woher/welcher Weg gespeichert | als Nächstes | GM |
| 7 | Quelle fehlt/Hub getrennt: sichtbare Meldung, "Neu verbinden" | als Nächstes (Kern: keine Wiederverbindung) | (Regel "nie still ausgegraut") |
| 8 | Vergessen: einzelne Einträge/nach Filter/nach Zeitraum, mit Frage und Hinweis "Protokoll des Hubs bleibt" | als Nächstes (Kern: forget nach Filter) | GM |
| 9 | Aktivität je Objekt in der Seitenleiste des Programms (Reiter "Aktivität" in Dateien, Texte, Aufgaben) | später (eingebettet, ADR 0037) | NC |
| 10 | Kalenderübersicht/Heatmap der letzten 12 Monate (UTC beachten, ADR Normalisierung) | später | GH |
| 11 | Übersicht: aktivste Programme/Objekte, Beitragsarten | später | GH |
| 12 | Aufzeichnung je Art ausschalten (Pause), "ausschalten und löschen" | später | GM |
| 13 | Automatisch löschen nach Alter (Aufbewahrungsdauer) | später | GM |
| 14 | Zusätzliche Bestätigung vor Ansicht des gesamten Verlaufs (Gerät/Passkey) | später | GM |
| 15 | Benachrichtigungen je Ereignisart (Messenger/Mail/Push), Takt, tägliche Zusammenfassung | später (Messenger/Server) | NC |
| 16 | Stummschalten/Blockieren/Schlagwort-Filter für Einträge anderer | später | MA |
| 17 | RSS/Atom-Feed der eigenen Zeitleiste mit geheimem Token (nur Opt-in; Datenschutz) | später, offen ob gewollt | NC |
| 18 | Projektansicht: wer hat wann was getan (nur mit Freigabe der Beteiligten) | später (keine Freigabe im Kern) | (eigen) |
| 19 | Tagebuch als Facette (Filter "ich"; Text bleibt Wiki-Seite) | später | (Doku) |
| 20 | Private Einträge einbeziehen/ausblenden (anonymisiert) | später | GH |
| 21 | "Wer" und echte Ereigniszeit (Hub liefert Originale) | später (Hub-Abhängigkeit) | AS |
| 22 | Telemetrie-Import (OpenTelemetry), lokal bleibend | später | (Doku) |
| 23 | Zeiterfassung aus Aktivitäten | später, offen ob gewollt | (Doku: nicht gebaut) |
| 24 | Export der eigenen Zeitleiste (AS2 OrderedCollection, JSON/CSV) | später | AS (GM: nicht erwähnt) |
| 25 | Zusammenfassung nach Zeitraum für Berichte ("Wochenbericht") | später | (eigen) |
| 26 | Kürzel: Pfeile in Liste, Entf (vergessen), Strg+F Suche, F5 aktualisieren | als Nächstes | (Standard) |
Hinweis: Nr. 5 und 8 (echtes Vergessen mit Hashes) sind Alleinstellung; keines der Vorbilder löscht außer in eigenen Daten.

## 4. Menübäume je Vorbild (nur Belegtes)
Alle Vorbilder sind Web-Oberflächen; vollständige Menübäume sind aus den abrufbaren Texten nicht belegt.
- NC: linke Leiste: Filter-Einträge (Alle, Von dir, Von anderen, Dateiänderungen, + App-Filter), unten Einstellungen (RSS). Dateien-Seitenleiste: Reiter Aktivität. Benachrichtigungen: Einstellungen > Persönlich > Benachrichtigungen.
- GM: Suchleiste oben mit Filtern und "Mehr" (Weitere Aktivität), je Eintrag "Details" und Löschen; Einstellungen: Ausschalten, Automatisch löschen, Verifizierung. Rest [nicht belegt].
- GH: Profil: Beitragsdiagramm, Verlauf, Filter Organisation, Schalter private Beiträge. Rest [nicht belegt].
- MA, JR: [nicht belegt]. Kontextmenüs, Werkzeugleiste, Tastenkürzel: bei keinem belegt: [nicht belegt].

### VORSCHLAG Menübaum fs-activities (eigenes Konzept; Entscheidung b7: Seitenleiste + Symbolleiste + Kontextmenüs, keine Menüleiste)
Seitenleiste (Filter): Alles | Von mir | Von anderen | Je Programm > (Liste der Programme) | Zusammengefasst (Häkchen) | Einstellungen (Aufzeichnen, Aufbewahren).
Symbolleiste: Suchfeld | Zeitraum ▾ (Heute/7 Tage/Monat/Von-bis) | Zusammenfassen (Umschalter) | Vergessen… | Aktualisieren | Weitere ▾ (Export, Aufzeichnung pausieren).
Kontextmenü Eintrag: Objekt öffnen | Details | Vergessen… | Zu diesem Objekt filtern | Zu diesem Programm filtern. Kontextmenü Zusammenfassung: Aufklappen | Vergessen… (alle). Leerfläche: Aktualisieren.
Kürzel (Vorschlag, nicht belegt): Strg+F Suche, F5 aktualisieren, Entf vergessen (mit Frage), Enter Objekt öffnen, Pfeile Liste. Ausgegraut immer mit Grund (z. B. Quelle getrennt).

## 5. Die wichtigsten nächsten Funktionen
1. Fenster Zeitleiste (Tage, Seitenumbruch, Kurztext, Klick öffnet Objekt) [M]: ohne Fenster ist der geprüfte Kern unsichtbar; nutzt Kern 1:1.
2. Filter (Programm, Objektart, Zeitraum, Suche) in der Seitenleiste [S-M]: Standard aller Vorbilder; Kern hat Filter.
3. Zusammenfassung aufklappbar [S]: Alleinstellung, macht lange Serien lesbar; `digest` vorhanden.
4. Vergessen mit klarer Frage und ehrlichem Hinweis auf Hub-Protokoll [S-M]: Selbstbestimmung; Kern vorhanden.
5. Quelle getrennt melden und neu verbinden [S-M]: Kern stellt nichts selbst wieder her; Regel "nie still".
6. Details je Eintrag (woher, wann, auf welchem Weg) [S]: Ehrlichkeit über "Wer leer, Zeit = Eingang"; Vorbild GM.
7. Aufzeichnen pausieren je Programm + Aufbewahrungsdauer [M]: Kontrolle über die eigene Zeitleiste (GM); braucht Schreibweg im Kern.
8. Reiter "Aktivität" je Objekt eingebettet (ADR 0037) [M-L]: Vorbild NC; erst wenn Dateien/Texte Fenster haben.

## 6. Lücken in fs-components (Verweis PLAN-components-menue.md M1-M8)
M1 Befehlsmodell (Symbolleiste, Grund bei ausgegraut), M2 Kürzel, M3 Kontextmenü (Eintrag/Zusammenfassung), M4 Tastatur in Listen, M5 Baum (Zusammenfassung aufklappbar; Lücke: Gruppenkopf "Tag" mit Aufklappen in Liste, kein Baum im Plan), M7 Befehlsleiste. Zusätzlich fehlend: Zeitleisten-Widget (Tagesgruppen, Nachladen/Virtualisierung), Zeitraum-Auswahl (date-range), Kalender-Heatmap (nur für später). Vorhanden laut Doku: table, chart, date-input.

## 7. Offene Fragen
1. Datenschutz: darf der Kern "Von anderen" anzeigen, solange der Hub "Wer" nicht liefert? Oder Filter ausblenden mit Grund?
2. RSS/Feed der eigenen Zeitleiste (NC): gewollt (Opt-in) oder passt es nicht zu "bleibt lokal"?
3. Version: README v0.0.1, Doku v0.1.1: welche gilt?
4. Name im Fenster: "Verlauf" oder "Aktivitäten" (Capability bleibt `history`, Doku-Seite "Früher History")?
