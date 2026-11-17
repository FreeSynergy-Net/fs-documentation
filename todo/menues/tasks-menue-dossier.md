# Menü-Dossier FS-TASKS (nur Recherche, Stand 2026-11-17)

Regel: Nachbauen = Struktur, Benennung, Reihenfolge, Kürzel, Verhalten. Kein Code, keine Grafiken (ADR 0013). `[nicht belegt]` = in der Quelle nicht gelesen; nichts erfunden.
Quellen: `fs-documentation` origin/main 980adcdc, `docs/en/programs/apps/tasks/frontends/<x>/latest/menus.md` + `shortcuts.md`; Plan/Stand in internen Aufgaben-Plan-Unterlagen (PLAN.md P1–P18, T1–T28, A1–A5; stand.md); Ist-Stand fs-tasks origin/main 0d47321 (v0.0.8-3), fs-components v0.0.25.
Netz: Commons-Suche für Endeavour, Microsoft To Do, Things, Todoist ohne brauchbare freie Aufnahme; **keine Vorbild-Bilder gespeichert** (interne Referenzbilder, nicht im Repo; bewusst keine gespeichert).
**Doku-Güte (wichtig):** Things 3 (vollständiges Inventar mit Kürzeln, aus Herstellerseiten) und Jira (Atlassian-Hilfe) belegt. **Todoist, Linear, OmniFocus, Taskwarrior: Menüs "Open/not read" = `[nicht belegt]`.** GNOME Endeavour, Microsoft To Do: gar kein Doku-Ordner (PLAN §9: Menü/Bilder durch Mensch an Windows 11). Thunderbird-Aufgaben: nur Entwurfsliste `[Hinweis]`.

## 1. Vorbilder und Quellen
| Vorbild | Menüform | Güte |
|---|---|---|
| Things 3 (Mac) | Menüleiste + Seitenleiste Inbox/Heute/Demnächst/Jederzeit/Irgendwann/Logbuch; Frontend "Day" von fs-tasks ahmt es nach | Inventar + 80 Kürzel belegt; Menüleiste nur teilweise benannt |
| Jira (Cloud) | Kopfleiste, Seitenleiste, Board/Backlog-Menüs, Kontextmenü Auswahl + Spalte | Inventar belegt |
| Microsoft To Do (Windows-Stil, ADR 0066) | Listen links (Mein Tag, Wichtig, Geplant, Zugewiesen an mich), Aufgabe + Detail rechts | nur Titel im PLAN, Menüs `[nicht belegt]` |
| GNOME Endeavour / Planner | - | `[nicht belegt]` (kein Dossier) |
| Todoist | Projekte, Heute/Demnächst, Filter, Priorität p1–p4 (Features laut PLAN) | Menüs `[nicht belegt]` |
| Linear | nur Triage-Kürzel: G dann T; 1 annehmen, 2 ablehnen, 3 Duplikat, H zurückstellen | Menüs `[nicht belegt]` |
| OmniFocus, Taskwarrior (Kommandozeile) | - | `[nicht belegt]` / nicht anwendbar |
fs-tasks-Frontends (`frontend.rs`): Classic (Liste + Status), Board (A, Jira-artig), Day (B, Things-artig). Das Menü-Vorbild folgt dem Frontend: Board = Jira, Day = Things 3, Classic = Todoist/To Do-artige Liste.

## 2. Menübaum je Vorbild (Kürzel [ ], Mac-Taste Cmd = Strg beim Nachbau, nur Vorschlag)
### 2.1 Things 3 (Mac; Inventar der Doku)
```
Menüleiste (nur benannte Pfade): Things > Einstellungen > Allgemein | Schnelleingabe | Kalenderereignisse | Things Cloud
  Ablage: Neue wiederkehrende Aufgabe | Neuer Bereich | Neue Überschrift
  Objekte: Bewegen | In Projekt umwandeln | Aus Projekt/Bereich entfernen | Wiederholen
  Darstellung: Gehe zu | Symbolleiste zeigen    Bearbeiten: Schnellsuche    Fenster: Tags    Hilfe: Tastaturkürzel
  (Namen englisch, deutsche Namen [nicht belegt]; Reihenfolge/Trenner nur soweit oben; weitere Menüs To-Do/Projekt/Bereich/Liste/Tag [nicht belegt])
Kürzel (Gruppen, Cmd): Neu: Aufgabe [N], unter Auswahl [Leertaste], aus Zwischenablage [V], Checkliste [Umschalt+C], Projekt [Opt+N], Überschrift [Umschalt+N], Schnelleingabe [Ctrl+Leertaste]
  Bearbeiten: Öffnen [Return], Speichern+schließen [Cmd+Return], Duplizieren [D], Kopieren/Einfügen [C/V], Erledigen [K], Abbrechen [Opt+K], ins Logbuch [Umschalt+Y]
  Auswahl: erste/letzte [Opt+Pfeil], erweitern [Umschalt+Pfeil], alle [A]
  Bewegen: in andere Liste [Umschalt+M], hoch/runter [Pfeil], nach oben/unten [Opt+Pfeil]
  Datum: When zeigen [S], Heute starten [T], Heute Abend [E], Jederzeit [R], Irgendwann [O], +/-1 Tag [Ctrl+]/[ ], +/-1 Woche [Ctrl+Umschalt+]/[ ], Deadline [Umschalt+D], Wiederholung [Umschalt+R]
  Navigieren: Seitenleiste [Cmd+/], Gehe zu Eingang..Logbuch [1..6], Navigation [Umschalt+O], Zurück [Cmd+Pfeil links], Tags-Fenster [Ctrl+T], Tags der Auswahl [Umschalt+T], Später ein-/ausblenden [Umschalt+E]
  Markdown in Notizen: Überschrift 1/2, Kursiv/Fett [I/B], Listen, Aufgabenliste, Zitat, Markieren, Link [Umschalt+K], Durchgestrichen, Code, Codeblock, Einrücken [ ]
Kontextmenü Aufgabe (Ctrl-Klick): Aus Projekt/Bereich entfernen | Im Projekt zeigen (Opt gehalten)   [weitere Einträge nicht belegt]
Kontextmenü Projekt (Seitenleiste): Verschieben… > Kein Bereich   Kontextmenü Überschrift: Überschrift duplizieren [Cmd+D] | In Projekt umwandeln
Kontextmenü Bereich, Checkliste, Tag, Seitenleistenliste: [nicht belegt]
```
### 2.2 Jira Cloud (Inventar der Doku)
```
Navigation: Atlassian-Apps wechseln | Suche | Erstellen | KI-Chat, Benachrichtigungen, Einstellungen, Konto (nur als Gruppe)
Seitenleiste: Für dich | Zuletzt | Markiert | Bereiche | Dashboards | Assets | Ziele | Apps | Mehr > Seitenleiste anpassen
Bereichs-Reiter: Liste | Apps | + Reiter ; Reiter-Mehr: Als Standard | Umbenennen | Nach links | Nach rechts | Entfernen ; Bereichsname-Mehr: Bereichseinstellungen
Board-Mehr: Board konfigurieren (Spalten, Swimlanes) | Board-Einstellungen (Details, Layout) | Arbeitsobjekte in Seitenleiste öffnen | Löschen
Backlog-Mehr: Sprint bearbeiten | Sprint löschen | Sammeländerung
Kontextmenü Auswahl im Backlog (Rechtsklick oder Sammeländerung): Verschieben | Löschen | Archivieren | Markierungen setzen/entfernen | Labels | Bearbeiter | Priorität | Schätzung | Übergeordnetes | Ausgewählte anzeigen
Kontextmenü Spalte (Rechtsklick auf Namen): Spaltenlimit setzen | Löschen   Swimlane-Abfrage-Mehr: Bearbeiten
Einzelnes Arbeitsobjekt-Mehr (Verschieben, Klonen, Löschen, Verknüpfen, Beobachten, Markieren), Start/Abschluss Sprint: [nicht belegt]
Kürzel (Doku shortcuts.md): C anlegen, A zuweisen, I mir zuweisen, M kommentieren (Rest in jira-shortcuts.md)
```
### 2.3 Weitere
Microsoft To Do (nur Namen aus PLAN): Listen Mein Tag, Wichtig, Geplant, Zugewiesen an mich; Aufgabe: Schritte, Fälligkeit, Erinnerung, Wiederholung, Liste teilen/zuweisen. Menüs, Kontextmenü, Kürzel: `[nicht belegt]`. Todoist: Today, Upcoming, Filter "assigned to/by", Priorität p1–p4 (Features, keine Menüs). Linear: nur Triage-Kürzel oben.

## 3. Gemeinsamer Nenner und VORSCHLAG
Nenner (Things + Jira + To Do): Seitenleiste mit festen Listen/Filtern; Schnellanlegen (Titel, Enter; Things Ctrl+Leertaste, Jira C); Aufgabe erledigen (Things Cmd+K), zuweisen (Jira A, I), Datum (Things S/T/E), verschieben, duplizieren, löschen; Mehrfachauswahl mit Sammelmenü (Jira Kontext: Verschieben, Löschen, Labels, Bearbeiter, Priorität); Tags/Labels. Unterschied: nur Things hat Menüleiste (teilweise belegt); Jira/To Do Kopfleiste.
VORSCHLAG fs-tasks (Frontend-treu, keine eigene Menüleiste, Shell-Titelleiste ADR 0065):
1. Shell-Titelleiste: Programm [Beenden Strg+Q] | Aufgabe [Neu Strg+N, Importieren…, Exportieren…] | Ansicht [Frontend (Radio mit Haken: Classic, Board, Tagesliste; P5), Listenansicht/Statusansicht (Radio), Erledigte zeigen (Häkchen)] | Hilfe. Heute: Aufgabe [Neu] nur wenn schreibbar, Ansicht [Liste, Status], Frontend (gewählter ausgegraut statt Haken).
2. Leiste über der Liste (Reihenfolge nach Things/Jira): Suchfeld | Filter ▾ (Liste, Label, Person, Stand) | Ansicht ▾ | Neu [Strg+N / C].
3. Seitenleiste Day-Frontend (Things): Heute | Demnächst | Jederzeit | Logbuch | Wartet (laut T11; Eingang als Vorbild-Liste Things, bei uns nicht geplant) | Mir zugewiesen (A4) | Listen | Labels | Papierkorb.
4. Kontextmenü Aufgabe: Öffnen [Enter] | Erledigen [Strg+K, Leertaste?] | Zuweisen… [A] | Mir zuweisen [I] | Datum > (Heute, Morgen, Wählen…) | Labels > | Verschieben nach > | Duplizieren [Strg+D] | --- | Löschen [Entf] (Reihenfolge: Jira-Sammelmenü, Namen Things). Mehrfachauswahl: dasselbe mit Sammelwirkung (Jira). Kontextmenü Karte (Board): zusätzlich "Stand setzen >". Kontextmenü Spalte: Spaltenlimit/Löschen = Board v2 (gesperrt "kommt noch").
5. Kontextmenü Leerfläche der Liste: Neue Aufgabe | Einfügen | Alles auswählen [Strg+A] [nicht belegt als Vorbild: eigener Vorschlag].
6. Verhalten: Zuweisung annehmen/abweisen (A5) nur sichtbar für Zugewiesene; Kürzel Buchstaben nur bei Fokus in Liste; nicht gebaute Einträge gesperrt mit Grund; Kommentare nicht in den Grundsachen (O7: kein Knopf).

## 4. Ist-Stand und fs-components-Lücken
fs-tasks (`surface.rs`, `frontends.rs`, `words.rs`): Menü "Task"(Aufgabe) [New] nur bei `can_create`; Menü "View" [List, Status] nur Variante Full und Classic; Menü "Frontend" [Classic, Board, Day list] mit gewähltem Eintrag `disabled` (PLAN P5: soll Radio+Haken werden). Wörter englisch (`words.rs`); deutsch `[nicht belegt]` in dieser Lesung (MF2-Texte der Branch tasks-usable). Fenster: Suchfeld, Ansicht-Knöpfe Liste/Status, Neu (workbench `tasks/view/toolbar.rs`). Kein Kontextmenü, keine Kürzel, kein Quick-Entry (P14), keine Suche im Board (P11), Ziehen von Karten (P10) geplant. Menü-Radio, Personenwähler (T5, F2: `PersonDirectory` ohne `search`) offen.
| Bedarf | Stand v0.0.25 | Baustein |
|---|---|---|
| Radio mit Haken (Frontend) | nur Haken/disabled | M1 (P5) |
| Trenner, Kürzel-Anzeige | fehlt | M1 |
| Kürzel Strg+N, C, A, I, Entf, Leertaste (nur bei Fokus Liste) | fehlt | M2/M4 |
| Kontextmenü Aufgabe/Karte/Mehrfach/Leerfläche | fehlt | M3 |
| Zuweisen-Picker | Dialog-Rahmen da, Baustein fehlt | M6 |
| Befehlsleiste/Palette | fehlt | M7 |
| Karten ziehen, Quick-Entry | Baustein `board` Variante `drop-target`, `quick-entry` nötig | PLAN P10/P14 |
Komponenten-Lauf M1–M4, M6 vor Menü-Nachbau: JA.

## 5. Bildpaket-Plan (nur lokal; interne Referenzbilder, nicht im Repo bisher leer; unser: Offscreen-Bild)
Namen `tasks-menue-<teil>-<vorbild|unser>.png`:
1. `fenster-liste-leer` | `fenster-liste-gefuellt` | `fenster-board` (Jira) | `fenster-tagesliste` (Things) | `fenster-mit-detail`
2. `shell-titelleiste-programm/-aufgabe/-ansicht/-hilfe` (nur unser) | `things-menue-ablage/-objekte/-darstellung` (Vorbild FEHLT) | `jira-board-mehr` | `jira-backlog-mehr`
3. `kontext-aufgabe` | `kontext-mehrfach` (Jira Sammelmenü) | `kontext-karte` | `kontext-spalte` (Jira) | `kontext-seitenleiste-liste` | `kontext-leerflaeche` [nicht belegt]
4. `schnellanlegen` (Things Schnelleingabe) | `zuweisen-picker` | `datum-menue` (When) | `erledigt-undo`
Alle Vorbild-Aufnahmen: Mensch/Test-Agent am laufenden Programm (Things nur Mac, Jira Cloud-Konto, To Do Windows 11).

## 6. Deutsche Namen (nur belegte)
Vorbild-Doku englisch; deutsche Namen der Vorbilder `[nicht belegt]`. fs-tasks deutsch in dieser Lesung `[nicht belegt]` (nur englische `words.rs`; MF2 de auf Branch tasks-usable, nicht gelesen).

## 7. Offene Fragen
1. Welches Frontend-Vorbild gilt als Hauptvorbild der Menüs: Things (Day), Jira (Board) oder Microsoft To Do (Windows-Stil, ADR 0066)? Empfehlung: je Frontend sein Vorbild; Hauptvorbild Windows-Stil = To Do, dafür fehlen Aufnahmen und Menüs (Mensch an Windows 11).
2. Aufgabe erledigen: Strg+K (Things), Leertaste oder Kästchen (To Do)? Empfehlung: Kästchen + Leertaste; Strg+K als Befehlsname im Palette-Eintrag.
3. Kürzel Buchstaben (C, A, I wie Jira) ohne Modifikator: nur wenn Fokus in Liste/Board und nicht im Textfeld (M2-Regel). Einverstanden?
4. Papierkorb/Verlauf/Zuweisung annehmen haben kein Vorbild (T7, T19–T21): eigener Entwurf nach Kontextmenü-Muster zulassen?
5. Brauchen wir Todoist/Linear-Menü-Inventare (Doku "Open")? Empfehlung: nur Todoist (verbreitet), Lauf mit Netz.

## Entscheidung (b7, 17.11.)
Führendes Vorbild für das Standard-Frontend ist Things 3 (Menüs und Kürzel belegt). Jira gilt für das Team- und Projekt-Frontend später. Microsoft To Do (Windows-Stil) folgt, wenn Aufnahmen da sind.
