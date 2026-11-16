# Feature-Abgleich: PROGRAMM tasks (fs-tasks)

Stand 2026-11-16, Auftrag 27, Feature-Abgleich vor dem Feature-Freeze. Feature-Freeze: offen (Nutzer). Nur Deutsch: todo/ wird nicht übersetzt (ADR 0011).

Stand: 2026-11-16. Auftrag 27. Feature-Freeze: offen (Nutzer).

Zustand bei uns: fs-tasks main (9a2767f), DESIGN.md; Plan: Planordner pilot-tasks/PLAN.md (tasks_v1, §4 Funktionsliste T1–T28, §2.3 Vertrag). Verweise „Plan §4 T9“ meinen diese Tabelle.

Legende: `- [x]` = gebaut oder fest geplant (Verweis); `- [ ]` = fehlt. Stand: gebaut | geplant (Plan §) | fehlt. Priorität hoch/mittel/niedrig. Wir kopieren nichts; nur Feature-Namen und Nutzen in eigenen Worten.

Ergebnis Vorbilder: wer = Things 3 (T), Todoist (Td), Microsoft To Do (MS), Jira (J), Vikunja (V), Nextcloud Deck (ND), Taskwarrior (TW). Planka: nur Startseite abgerufen, kaum belegbar; deshalb nur Board-Ansicht als Vorbild genannt.

## Listen, Projekte, Bereiche

- [x] Mehrere Listen, eine Liste wählen — T, Td, MS, V, ND — geplant (Plan §4 T22) — hoch — Aufgaben nach Lebensbereich trennen.
- [ ] Projekte mit Unterprojekten — Td, V — fehlt — mittel — Große Vorhaben in Teile gliedern.
- [ ] Bereiche über Projekten — T — fehlt — niedrig — Mehrere Projekte gemeinsam sehen.
- [ ] Überschriften innerhalb einer Liste — T — fehlt — niedrig — Aufgaben in einer Liste gruppieren.
- [x] Farbe pro Liste — V, ND — geplant (Plan §2.3 create_list(name, color)) — niedrig — Listen am Bildschirm unterscheiden.
- [ ] Liste favorisieren, archivieren (nur lesbar) — V, Td — fehlt — niedrig — Abgeschlossene Listen aus dem Weg räumen, ohne zu löschen.
- [x] Standardliste „Persönlich“ beim ersten Start — T, MS — geplant (Plan §4 T22) — mittel — Sofort nutzbar ohne Einrichtung.

## Aufgaben

- [x] Teilaufgaben (Unteraufgaben) — J, MS (Schritte), V (Relationen) — geplant (Plan §4 T14) — hoch — Große Aufgabe in überprüfbare Schritte zerlegen.
- [ ] Checklisten innerhalb einer Aufgabe — T, MS, V — fehlt — mittel — Kleine Punkte ohne eigene Aufgabe abhaken.
- [x] Fälligkeit und Beginn (Datum oder Uhrzeit mit Zone) — T, Td, MS, V, J — geplant (Plan §4 T4) — hoch — Wann etwas fertig sein muss und wann man anfängt.
- [ ] Enddatum (Planungszeitraum, kein Termin) — V — fehlt — niedrig — Zeitraum einer Aufgabe ohne Frist zeigen.
- [x] Wiederholung (täglich, wöchentlich, Vorkommen erledigen → nächstes) — T, Td, MS, V, TW — geplant (Plan §4 T16; Regeln außerhalb der Teilmenge → Unsupported) — hoch — Wiederkehrende Pflichten ohne Neuanlage.
- [ ] Wiederholung nach Erledigung ab dem Erledigungsdatum — V, TW — fehlt — mittel — Gewohnheiten, die sich am letzten Mal orientieren.
- [x] Erinnerung zu einer Uhrzeit — T, MS, V — geplant (Plan §4 T17) — mittel — Rechtzeitig an Fälliges erinnert werden.
- [x] Priorität (vier Stufen) — Td, V, J — geplant (Plan §4 T18) — mittel — Die wichtigsten Aufgaben oben halten.
- [ ] Dringlichkeit, aus Fälligkeit und Priorität berechnet — TW — fehlt — niedrig — Sortierung ohne manuelle Pflege.
- [x] Labels/Tags — T, Td, V, J — geplant (Plan §4 T13) — hoch — Aufgaben quer über Listen finden.
- [x] Zuweisung an eine Person (Picker, „Mir zuweisen“) — J, MS, V, ND — geplant (Plan §4 T5, T6) — hoch — Klar wer etwas macht.
- [x] Zuweisung annehmen oder abweisen — (eigen; RFC 5545 PARTSTAT) — geplant (Plan §4 T7) — niedrig — Die zugewiesene Person bestätigt selbst.
- [ ] Kommentare zu einer Aufgabe — J, ND — fehlt (Plan §4: nicht in den Grundsachen, O7) — mittel — Rückfragen und Verlauf am Gegenstand.
- [ ] Datei-Anhänge — V, T (Link), J — fehlt (Plan §4 T28: nur URL; Datei erst mit fs-files, O15) — mittel — Unterlagen direkt an der Aufgabe.
- [x] Anhang als Link (URL) — T — geplant (Plan §4 T28) — niedrig — Verweis auf Dokument ohne Upload.
- [x] Geschätzte Dauer — (Plan §2.3 estimated: Span) — geplant (Plan §2.3) — niedrig — Planung der Zeit pro Aufgabe.
- [ ] Zeiterfassung (gebuchte Zeit je Aufgabe) — J (Worklog) — fehlt — niedrig — Tatsächliche Zeit neben Schätzung.
- [x] Abhängigkeiten („blockiert durch“) — J, V — geplant (Plan §4 T15) — mittel — Reihenfolge erzwingen, Engpässe sehen.
- [x] Erledigen, wieder öffnen, in Arbeit, abbrechen — T, Td, V, J — gebaut (fs-tasks Frontend, Status; progress) — hoch — Kernfunktion.
- [x] Erledigen mit offenen Teilaufgaben: Rückfrage — J — geplant (Plan §4 T14 OpenSubtasks) — mittel — Keine stillen Fehler bei offenen Schritten.
- [x] Löschen mit Rückgängig und Papierkorb (Frist) — V (30 Tage), J — geplant (Plan §4 T19, T20) — hoch — Versehentliches Löschen ist umkehrbar.
- [x] Verlauf einer Aufgabe — J, ND — geplant (Plan §4 T21 history) — mittel — Nachvollziehen, wer was wann geändert hat.

## Ansichten

- [x] Liste (flach, sortierbar) — T, Td, MS, V — gebaut (fs-tasks-app, provisorisch; DESIGN.md Frontend) — hoch — Überblick über eine Menge.
- [x] Board/Kanban mit Spalten nach Stand, Karte ziehen — V, J, ND — geplant (Plan §4 T9; Frontend-Entscheidung: Status-Ansicht ist kein Board, DESIGN.md) — hoch — Arbeitsfluss sichtbar machen.
- [x] Hand-Reihenfolge in Liste und Board — T, V — geplant (Plan §4 T10 place) — mittel — Eigene Priorisierung ohne Feld.
- [x] Heute, Demnächst, Jederzeit, Wartet — T, Td, MS (Mein Tag) — geplant (Plan §4 T11) — hoch — Tagesplan ohne Filtern.
- [ ] Kalenderansicht der Fälligkeiten — T, V — teilweise gebaut (fs-calendars zeigt fällige Aufgaben schon: `TasksInWindow`, repo/agenda.rs) (korrigiert 16.11. nach Opus-Bewertung) — mittel — Aufgaben neben Terminen sehen.
- [ ] Zeitleiste/Gantt — V, J (Pläne) — fehlt (ADR 0073 Punkt 8: später) — niedrig — Abhängigkeiten über Zeit zeigen.
- [ ] Gespeicherte Filter — Td, J (Filter) — fehlt — mittel — Häufige Suchen mit einem Klick.
- [ ] Boolesche Filter (und/oder/nicht) — Td, J (JQL) — fehlt (TaskQuery ist eine Struktur, Plan §2.3) — niedrig — Komplexe Abfragen ohne Programmierung.
- [ ] Ansicht-Einstellungen je Gerät merken — V — fehlt — niedrig — Nicht jedes Mal neu einstellen.

## Zusammenarbeit

- [ ] Liste mit anderen teilen — MS (Listen), V, ND — fehlt (Konten/Sync später, Plan §2.3) — hoch — Gemeinsame Aufgaben ohne Export.
- [ ] Rechte (Lesen, Schreiben, Verwalten) je Teilen — V — fehlt — hoch — Wer darf was ändern.
- [ ] Teilen per Link mit Kennwort — V — fehlt — niedrig — Schneller Zugang für Gäste.
- [ ] @Erwähnung in Kommentar, Benachrichtigung — J — fehlt (abhängig von Kommentaren) — mittel — Aufmerksamkeit gezielt lenken.
- [x] Aktivitätsverlauf gemeinsam — J, ND — geplant (Plan §4 T21) — mittel — Änderungen anderer nachvollziehen.
- [x] Live-Änderungen anderer sehen — (eigen; ADR 0049 Punkt 7) — geplant (Plan §4 T25 changes) — mittel — Keine veralteten Bildschirme.

## Automatisierung und Vorlagen

- [ ] Regeln „wenn … dann …“ — J (Automation), TW (Hooks) — fehlt — niedrig — Routinen ohne Hand.
- [ ] Webhooks bei Änderungen — V — fehlt — niedrig — Anbindung an andere Programme.
- [ ] Aufgabenvorlagen (wiederholbare Listen) — J, Planka (Pro laut Startseite) — fehlt — niedrig — Gleiche Schritte für neue Vorgänge.
- [ ] Eigene Felder (UDAs) — TW — fehlt — niedrig — Zusatzangaben ohne Programmänderung.

## Suche

- [x] Volltext in Titel und Beschreibung — T (Quick Find), Td — gebaut (Filter term, fs-tasks DESIGN.md) — hoch — Eine Aufgabe in Sekunden finden.
- [x] Suche mit Filtern (Liste, Label, Person, Stand) — Td, T — geplant (Plan §4 T12) — hoch — Enges Finden ohne Umwege.
- [ ] Schnellsprung zu Liste oder Aufgabe per Tastatur — T (Quick Find) — fehlt — mittel — Schnell überall hin.
- [ ] Berichte (Auswertung nach Stand, Dauer) — TW (Reports), J — fehlt — niedrig — Überblick über Erledigtes.

## Import und Export

- [x] VTODO (iCalendar) Import und Export — V (CalDAV-Austausch), eigen — gebaut (fs-tasks DESIGN.md: ICS VTODO, Original je UID) — hoch — Aufgaben in andere Programme mitnehmen.
- [x] JSCalendar-Task (RFC 8984) — eigen (fs-tasks ist Eigentümer) — gebaut (fs-tasks DESIGN.md) — mittel — Ein Standard innen, keine Eigenform.
- [ ] CalDAV-Konto (Sync mit Kalender-Apps) — V — fehlt (CalDAV als eigener Anbieter, später, Plan §2.3) — hoch — Aufgaben auf dem Handy in der gewohnten App.
- [ ] CSV Import und Export — Td, V — fehlt — mittel — Tabellen-Austausch mit Excel und Co.
- [ ] Todoist-Import (Einordnung: geschlossen → nur Import, Regel Import/Export) — Td — fehlt — niedrig — Umzug aus Todoist.
- [ ] Trello-Import (Einordnung: geschlossen → nur Import, Regel) — (Trello nicht in den Dossiers, nicht geprüft) — fehlt — niedrig — Umzug aus Trello.

## Offline und Sync

- [ ] Sync über mehrere Geräte — T (Things Cloud), V — fehlt (Konten/Sync später, Plan §2.3) — hoch — Gleicher Stand auf allen Geräten.
- [ ] Offline arbeiten, später abgleichen — T, Td, MS — fehlt — hoch — Arbeiten ohne Netz (unterwegs).
- [x] Konflikterkennung beim Speichern (Revision) — J (Versionen) — gebaut (fs-tasks core edit_checked; „Wurde inzwischen geändert“, Plan §4 T3) — hoch — Keine stillen Überschreibungen.

## Tastatur und Barrierefreiheit

- [x] Karte per Tastatur verschieben — J — gebaut (fs-tasks-app, DESIGN.md Frontend, provisorisch) — hoch — Ohne Maus arbeiten.
- [x] Schnellerfassung mit Tastatur (Titel, Enter, Esc) — T (Quick Entry), J (Kürzel C) — geplant (Plan §4 T2) — hoch — Gedanken sofort festhalten.
- [ ] Vollständige Tastatursteuerung aller Ansichten — V (Barrierefreiheit: Kanban nicht per Tastatur), J — fehlt — hoch — Zugänglichkeit nach Standard.
- [ ] Bildschirmleser-taugliche Listen und Dialoge — MS (Bildschirmleser-Seite) — fehlt — hoch — Blinde und sehbehinderte Nutzende.

## Mobil

- [ ] Eigene Mobil-App (iOS, Android) — T, Td, MS, J — fehlt — mittel — Aufgaben unterwegs erfassen.
- [ ] Mobil-Web (Darstellung auf schmalen Bildschirmen) — Td, V — fehlt — mittel — Ohne App nutzbar.

## Benachrichtigungen

- [ ] Erinnerung als Benachrichtigung auf dem Gerät — T, MS, V — geplant (Plan §4 T17); gebaut ist nur das Speichern von `alerts`, nichts löst aus (korrigiert 16.11. nach Opus-Bewertung) — mittel — Fälliges kommt von selbst.
- [ ] Benachrichtigung bei Zuweisung oder Kommentar — J — fehlt — mittel — Wer gebraucht wird, erfährt es.
- [ ] E-Mail-Benachrichtigung bei Fälligkeit — V — fehlt — niedrig — Für Menschen ohne App.

## KI (nur benennen, nicht entscheiden)

- [ ] KI-Vorschläge zu Aufgaben (Zerlegung, Fälligkeit) — J (Atlassian Intelligence, Cloud) — fehlt (nur benannt; KI-Gruppen-Regel) — niedrig — Vorschläge, die der Mensch bestätigt.
- [ ] Übernehmen durch Akteur (claim/release/next) — eigen (fs-tasks CLI) — auf Branch `unreviewed/lift-tasks` und `unreviewed/release-profile`, nicht auf `main`; Trait ja (korrigiert 16.11. nach Opus-Bewertung) (Plan §4 T24) — mittel — Mensch und Agent teilen sich eine Liste ohne Doppelarbeit.

## Selbstverwaltung

- [x] Eigener Server, Daten bleiben beim Betreiber — V, ND, Planka, TW (lokal) — gebaut (fs-tasks-server, DESIGN.md) — hoch — Kein Anbieter liest mit.
- [ ] Rollen und Verwaltung der Konten am Server — V (Admin) — fehlt (Konten später) — mittel — Betreiber trennt Zugänge.
- [ ] Vollständiger Export aller Aufgaben — V, TW (JSON) — teilweise geplant (VTODO/JSCalendar gebaut; Export je Id, Plan §2.3 export) — mittel — Keine Abhängigkeit vom Anbieter.

## Ideen des Nutzers

- (Platzhalter: noch keine Ideen vom Nutzer eingetragen.)

## Feature-Freeze: offen (Nutzer)

Kein Freeze gesetzt. Nur der Nutzer setzt ihn, nach Handtest, Ideensammlung und diesem Abgleich (Regel FIXPUNKT, rules.md). Bauen gegen die Fixpunkte ist erlaubt.

## Quellen (Abruf 2026-11-16)

- Things 3: Dossier fs-documentation origin/main, docs/en/programs/apps/tasks/frontends/things-3/latest/features.md; Herkunft laut Dossier https://culturedcode.com/things/features/ (selbst nicht abgerufen).
- Todoist: Dossier origin/main, .../todoist/latest/features.md; https://www.todoist.com/help/articles/introduction-to-filters-V98wIH (Dossier-Quelle, nicht selbst abgerufen).
- Microsoft To Do: Suche 2026-11-16 nach support.microsoft.com, u. a. https://support.microsoft.com/en-us/outlook/create-and-manage-task-lists-with-my-day-in-outlook , https://support.microsoft.com/en-us/office/assign-tasks-in-shared-lists-1b12ff41-f204-4a2c-975d-edbf631a4b34 , https://support.microsoft.com/en-us/office/add-due-dates-and-reminders-in-microsoft-to-do-064d9696-08d1-4433-bfdd-f661dc97491f (Suchergebnisse, Seiten teils alt). Seite todo.microsoft.com leitet auf Anmeldung um, nicht genutzt.
- Jira: Dossier origin/main, .../jira/latest/features.md; https://support.atlassian.com/jira-software-cloud/ (Dossier-Quelle).
- Vikunja: Dossier af2e2ca7 (Branch tasks-dossier, nicht in main), .../vikunja/latest/features.md; https://vikunja.io/help/ , https://vikunja.io/docs/api-documentation/ (Dossier-Quellen).
- Nextcloud Deck: Suche 2026-11-16, https://github.com/nextcloud/deck/blob/main/docs/User_documentation_en.md (Nutzerhandbuch, Ausschnitt); https://apps.nextcloud.com/apps/deck (abgerufen, nur Metadaten, dünn).
- Taskwarrior: https://taskwarrior.org/docs/ (abgerufen 2026-11-16, Kapitelliste).
- Planka: https://planka.app/ (abgerufen 2026-11-16, Startseite; nur Board belegt, Rest nicht).
- Nicht belegt: Kommentar- und Anhangdetails bei Nextcloud Deck; Trello, OpenProject, Focalboard nicht geprüft.

Offenheitsvermerk: Nur Feature-Namen, keine Texte übernommen. Die Formate VTODO (RFC 5545) und JSCalendar (RFC 8984) sind offen. Todoist-, Trello- und Things-Exporte sind nach der Import/Export-Regel als geschlossen einzuordnen (nur Import), bisher nicht im Detail geprüft.
