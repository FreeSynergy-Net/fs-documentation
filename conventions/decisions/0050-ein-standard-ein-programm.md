# 0050 – Ein Standard, ein Programm, eine Schnittstelle; `fs-contacts` heißt `fs-people`

Status: akzeptiert (2026-11-06) · ergänzt ADR 0014, 0045, 0049 · Abgrenzung der Standards: Vorschlag

## Entscheidung (Nutzer)
1. **Jedes Programm kümmert sich um die Standards, für die es geschaffen wurde. Ein Programm je Standard, damit es einen
   Point of Truth gibt. Jeder Standard hat eine eigene Schnittstelle, über die andere Programme zugreifen. IMMER.**
2. **`Task` steht für sich allein.** `fs-tasks` besitzt ihn. `fs-calendar` besitzt `Event` und bindet Aufgaben nur über die
   Schnittstelle von `fs-tasks` ein, ohne eigenes Task-Modell.
3. **`fs-contacts` heißt jetzt `fs-people`.** (Nutzer: „Ich mag es nicht, aber es umschreibt es wohl am besten.“)
   Repo, Verzeichnis und Crate `fs-people-core` sind umbenannt, die alte URL leitet weiter.

## Vorschlag zur Abgrenzung (offen)
Die Regel braucht eine Antwort auf zwei Fälle:
- **Ein Standard mit mehreren Objekten:** JSCalendar definiert `Event` und `Task`, und die Entscheidung oben teilt ihn auf
  zwei Programme. Also gilt die Regel je **Objektart** eines Standards, nicht je Dokument.
- **Querschnittsstandards:** AS2 ist die Hülle aller Objekte (ADR 0020) und das Aktivitätsprotokoll, kann also nicht
  einem Fachprogramm gehören. Vorschlag: Die Hülle gehört `fs-store`; `Group` gehört `fs-groups`, `Question` `fs-surveys`.
  JSContact kennt auch Gruppen-Karten: Sie gehören zu `fs-people` als Karte, die Mitgliedschaft und Rechte zu `fs-groups`.

## Entscheidung (Opus, 2026-11-06, auf Rückfrage von freesynergy-32; Nutzer kann ändern)
Gemeinsame **Typen** eines Standards dürfen in einer reinen Bibliothek liegen, zum Beispiel `fs-jscalendar` (Zeit, Zone,
Teilnehmer, Wiederholung, ICS). Sie hat keine Daten, keine Speicherung, keine Schnittstelle und ist kein Programm: Der Point
of Truth bleibt beim Besitzer. Sonst stünde Kopieren gegen ADR 0043. Importierte `Task`-Daten leitet `fs-calendar` immer an
`fs-tasks` weiter, in jedem Format.

## Personen und Rollen (vom Nutzer bestätigt, siehe ADR 0052)
Ein Programm `fs-people`, statt Contacts und People. Der Nutzer dachte an Vererbung: Person als Elternklasse, Kontakt, Kunde, User
als Ableitungen. Beschlossen: gleicher Gedanke, aber als **Person mit mehreren Rollen**, weil dieselbe Person zugleich Kontakt,
Kunde und User sein kann, was Vererbung nicht abbildet. Jede Rolle hat ihren Standard (JSContact, SCIM `User`, Kunde: Lücke).

## Folgen
- Der Schnittstellen-Katalog nennt je Thema den Besitzer.
- `fs-calendar` hat sein Task-Modell an `fs-tasks` abgegeben (erledigt: fs-tasks 0.1.0, fs-calendar 0.2.0). Die Verträge liegen in `fs-interfaces` (ADR 0045).
- Die gemeinsame Basis `fs-jscalendar` v0.1.0 ist umgesetzt, fs-tasks und fs-calendar nutzen sie (beide v0.3.0). Importe geben Aufgaben in jedem Format weiter, auch aus JSCalendar-JSON; ohne Aufgabenprogramm steht ein Hinweis im Bericht, nichts geht still verloren.
- Doku-Verzeichnisse sind umbenannt (2026-11-06): `programs/apps/people/`, `data/people/`.

## Nachtrag 23.11.2026 (Entwurf): Vertrag `events`, calcard, eine Form

Status: **Entwurf** (Strategie-Entscheid 23.11.2026 zu KAL-G2; Nutzer: Frage 12 = JA) · **präzisiert** Punkt 2 und „Folgen“ für `fs-calendars` · Fundstelle: `woche-11-23/kalender/ENTSCHEID-schnitt.md` (Verdict, a, d, e) und `LAUFLISTE-strategie-2026-11-22.md` (05:45, 05:46, 05:48/05:49)

- **Vertrag `events` (Crate `fs-events` in `fs-interfaces`), ohne `_v1`:** aus dem Entwurf `appointments_v1` (Eigentümer `PersonRef`, auch Gruppe; Teilnehmer `Attendee` ohne Namensfeld) und **ersetzt** `events.capnp`. Task-Verweis nur über JSCalendar `relatedTo`, keine Task-Felder und keine Crate-Kante.
- **Wiederholung und iCalendar über `calcard`** (0.3.14, JSCalendar 2.0, RRULE-Expansion) in `fs-jscalendar` (hinter Feature `ical`); eigene Engine und Crate `rrule` entfallen. Vertrag folgt JSCalendar 2.0 (ein `recurrenceRule`).
- **Eine Form `bars-in-time@1.0`** für Kalender, tasks-Gantt und Workflow-Gantt; Woche, Tag, Monat, Agenda und Gantt sind Sichten (Components). **`calendar-view` entfällt** (zweite Kalenderdarstellung neben `calendar-grid`, gegen ADR 0005); der Agenda-Teil wandert als Modus in `calendar-grid`.
- **Gruppe als Gast (Nutzer 23.11.): eine eingeladene Gruppe ist EIN Gast im Termin**; späterer Beitritt sieht den Termin, jedes Mitglied sagt selbst zu oder ab.
- **Ersetzen statt umbauen** (Nutzer): Der alte Kalender (rund 24 000 Zeilen) wird nicht umgebaut; bis zum ersten neuen Bild gibt es keinen lauffähigen Kalender.
- **Offen:** Zonenumrechnung im Block (wer macht sie) und ob `fs-components-workbenches/calendar` noch gebraucht wird: laut Entscheid `unbelegt`.
