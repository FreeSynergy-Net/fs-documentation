# Menü-Dossier FS-CALENDARS (nur Recherche, Stand 2026-11-17)

Regel: Nachbauen = Struktur, Benennung, Reihenfolge, Kürzel, Verhalten. Kein Code, keine Grafiken (ADR 0013). `[nicht belegt]` = in der Quelle nicht gelesen; nichts erfunden.
Quellen: `fs-documentation` origin/main 980adcdc, `docs/en/programs/apps/calendars/frontends/<x>/latest/menus.md` + `shortcuts.md`; Ist-Stand fs-calendar origin/main fbb3f17 (v0.0.4-42), fs-components origin/main v0.0.25. Bild: GNOME Calendar 47 (Commons, CC-Quelle in interne Referenzbilder, nicht im Repo), selbst angesehen.
Befund zur Doku-Güte: Merkuro (aus QML/C++-Quelltext 26.08.2) und Nextcloud Calendar (Quelltext v6.6.4) sind **vollständig und code-belegt**; Google Calendar nur aus deutschen Hilfeseiten (Namen DEUTSCH belegt); Outlook aus zwei Microsoft-Artikeln (Zugriffspfade); Thunderbird-Kalender nur Entwurfsliste (Hinweisgüte); GNOME Calendar nur Bild.

## 1. Vorbilder und Quellen
| Vorbild | Menüform | Güte |
|---|---|---|
| GNOME Calendar (47) | Kopfleiste, KEINE Leiste: Kalender ▾ + ☰ | Bild belegt (zugeklappt); Menü-Inhalt [nicht belegt] |
| Merkuro Calendar (KDE) | Menüleiste (abschaltbar, Strg+M), Aktionen, Seitenschublade | code-belegt, Kürzel belegt |
| Thunderbird (Lightning) | Menü "Kalender" + Kontextmenü | Entwurf, Hinweis |
| Outlook (neu/Web/klassisch) | Ribbon "Start", linke Leiste, Ansicht-Auswahl | Microsoft-Artikel; Ribbon-Inhalt nur teilweise |
| Google Calendar | Kopfleiste, linke Leiste, Einstellungen | deutsche Hilfe, Namen belegt |
| Nextcloud Calendar (AGPL: nur Konzept) | linke Leiste Kopf/Liste/Fuß, Termin-Editor | code-belegt |
Für fs-calendars (Windows-/Linux-Stil, ADR 0066): Hauptvorbild Outlook (Ansichtsleiste Tag/Woche/Monat) und GNOME Calendar (schlank), Gegenprobe Merkuro (volle Menüleiste).

## 2. Menübaum je Vorbild (Kürzel [ ])
### 2.1 GNOME Calendar (Bild)
```
Linke Kopfzeile: "Kalender ▾" (Auswahl/Sichtbarkeit je Kalender [Inhalt nicht belegt]) | ☰ Hauptmenü [Inhalt nicht belegt]
Darunter: Monatsnavigator mit Pfeilen vor/zurück, Wochen-Nummern, Heute rosa markiert, Punkt unter Tag mit Termin; Liste "Keine Termine"
Rechte Kopfzeile: Heute | Umschalter Woche | Monat (aktiv hervorgehoben) | Suche (Lupe) | + Neu | Schließen
Raster: Titel "Mai–Juni 2025", Wochentagskopf, Termin als Chip mit Farbbalken + Uhrzeit ("Blood Donation 14:20")
Kontextmenü Termin/Tag: [nicht belegt]
```
### 2.2 Merkuro Calendar (Code)
```
Menüleiste (Strg+M ein/aus): Datei [Merkuro beenden] | Bearbeiten [Text rückgängig, Text wiederholen, Ausschneiden, Kopieren, Einfügen, Löschen, Alles auswählen] | Fenster [Vollbild] | Einstellungen [Menüleiste zeigen (Schalter), Tags verwalten…] | Hilfe [Merkuro-Handbuch]
  + Aktionen: Ansicht (exklusiv): Monat [Strg+1] | Woche [Strg+2] | Arbeitswoche [Strg+2, Kollision im Code] | 3 Tage [Strg+3] | Tag [Strg+4] | Terminübersicht [Strg+5] | Aufgaben [Strg+6]
  Navigation: Zurück | Vor (gesperrt in Aufgabenansicht) | Zu heute | Zu Datum…
  Anlegen: Neuer Termin… | Neue Aufgabe… (ohne Kürzel) | Kalender importieren… | Rückgängig | Wiederholen
  Aufgabenansicht: Sortieren: alphabetisch, nach Fälligkeit, nach Priorität | Reihenfolge auf-/absteigend | Erledigte zeigen | Nur heute
  Sonstige: Alles aktualisieren [F5] | Tags verwalten… | Sprache wechseln
Seitenschublade: Kalender/Sammlungen (Sichtbarkeit, Farbe) | Tags | Einstellungen (Ansicht, Verfügbarkeit/Frei-Besetzt, Quellen, Konfiguration, Konten)
Termin-Info: Schublade oder Popup; Bearbeiten als Dialog (Desktop)/Seite (Mobil). Mobil: untere Leiste Monat | 3 Tage | Tag | Terminübersicht | Aufgaben + Neuer Termin.
Rechtsklick auf Termin/Raster: [nicht belegt]
```
### 2.3 Google Calendar (deutsche Namen belegt)
```
Kopfleiste: Heute [t] + Pfeile [J/N weiter] | Suche [/] | Ansichten: Tag [1,D] | Woche [2,W] | Monat [3,M] | 4 Tage/Benutzerdefiniert [4,X] | Jahr | Terminübersicht [5,A] | Einstellungen (Zahnrad) [s] | Konto
Linke Leiste: "Eintragen" (Neu-Menü: Termin, Aufgabe, "Terminplan" [Buchungsseite]) [c] | Minikalender | Meine Kalender (Klick = Sichtbarkeit) | Weitere Kalender (+: Kalender abonnieren | Per URL) | je Kalender ⋮: "Einstellungen und Freigabe" (Kalender exportieren, iCal-Adressen) | "Weitere Details" (Ihre Zeit im Blick)
Einstellungen: Ansichtsoptionen | Importieren & Exportieren (Exportieren = ZIP mit ICS; Importieren) | weitere Kategorien [nicht belegt]
Termin-Schnelleditor (Klick auf Zeit): umschaltbar auf "Fokuszeit"; Details [e]; Löschen [Entf]; Rückgängig [z]; Speichern [Strg+S]; Esc zurück
Terminplan-Editor: Zeitplan für Terminreservierung | Zeitfenster für Reservierungen | Angepasste Verfügbarkeit | Einstellungen für reservierte Termine (Puffer, Maximale Anzahl pro Tag, Berechtigungen für Gäste) | Kalender
Kürzel-Übersicht [?]
```
### 2.4 Outlook (neu/Web; klassisch)
```
Neu/Web: Navigationsleiste oben (Suche mittig; rechts Mein Tag, Benachrichtigungen, Hilfe, Einstellungen) | Ribbon-Reiter ("Start" voreingestellt; Neuer Termin, Besprechungsanfrage, Kalender freigeben; Reiter "Ansicht" > "Kalendereinstellungen") | linkes Fenster: "Neues Ereignis" (oben), Datumsauswahl, Kalenderliste, ganz links Umschalter Mail | Kalender | Kontakte | To Do
  Kalenderleiste: Monat/Jahr, zurück/vor, Monatsauswahl, Ansicht: Tag | Arbeitswoche | Woche | Monat | Heute | Freigeben
  Ereignis-Editor: Strg+N = eigenes Fenster ("Titel hinzufügen", Speichern; Verwerfen Alt+F4)
Klassisch: Ribbon | Ordnerbereich links (eigene, Feiertags-, geteilte Kalender) | Ansicht rechts | Statusleiste
  Zugriffspfade: Neuen/geteilten Kalender hinzufügen [Alt+H,O,C] | Kalender freigeben [Alt+H,S,C] | Online veröffentlichen [Alt+H,P,O] | Ordnerberechtigungen [Alt+H,F,P] | Per E-Mail senden [Alt+H,E] | Terminplanungs-Assistent [Alt+X] | Erinnerungsfenster [Alt+V,M] (Erneut erinnern Alt+S, Schließen Alt+D) | nebeneinander [Alt+H,S,V] | Optionen [Alt+H,C,O] | Datum wählen [Strg+G] | Heute [Alt+H,O,D]
  Ansichten: 1–10 Tage [Alt+1…Alt+0] | Monat [Alt+=] | ganze Woche [Alt+-] | Arbeitswoche [Strg+Alt+2] | Nächste 7 Tage [Alt+H,X]
Ribbon-Knöpfe und Rechtsklick: [nicht belegt]
```
### 2.5 Nextcloud Calendar (Code; nur Konzept)
```
Leistenkopf: Suchfeld "Ereignisse filtern…" | Datumswähler | Neues Ereignis | Heute | Ansichtsmenü: Tag | Woche | Monat | Jahr | Liste
Liste: Meine Kalender (+ Neu: Neuer Kalender | Neuer Kalender mit Aufgabenliste | Neues Abonnement aus Link (nur lesen) | Feiertagskalender hinzufügen | Eigenen öffentlichen Kalender hinzufügen) ; je Kalender: Aktivieren/Deaktivieren | Öffentlichen Link kopieren | Bearbeiten und teilen (Details, Teilen Benutzer/Gruppen/Kreise, Veröffentlichen, interner Link, Löschen) ; Öffentliche Kalender ; Terminvorschläge ; Terminbuchungen ; Papierkorb
Fuß: Kalendereinstellungen: Allgemein (Standardkalender, Verfügbarkeit, CalDAV-Adressen) | Darstellung (Geburtstage, Aufgaben im Kalender, Wochenenden, Wochennummern, Dichte) | Bearbeiten (Standarderinnerung, einfacher Editor) | Dateien | Delegation | ICS-Import | Tastaturkürzel-Übersicht
Haupt: Raster (Ziehen/Größe ändern) | Schalter "Nicht eingeplante Aufgaben" (rechte Leiste)
Detail-Editor "Detaillierter Terminbearbeiter": Aktionsmenü: Link kopieren | Exportieren (ICS) | Duplizieren | Löschen (Serie: Dieses Vorkommen / Dieses und folgende) ; Abschnitte: Eigenschaften | Wiederholung | Erinnerung | Teilnehmer (Frei/Besetzt, Zeitvorschläge) | Anhänge | Talk | Zusage-Knöpfe (Zusagen, Vielleicht, Absagen) ; Speichern ; "Änderungen verwerfen?"
```
### 2.6 Thunderbird (Entwurfsgüte)
Menü Kalender: Neuer Termin, Neuer Serientermin, Öffnen/Bearbeiten, Kopieren/Löschen, Verschieben, Kalender teilen, Importieren/Exportieren. Kontextmenü Termin: Bearbeiten/Löschen | Serientermin erstellen | Erinnerung hinzufügen | Status ändern | Farbe ändern | Kalender importieren/exportieren | Termin teilen. Aus Doku `messages/.../thunderbird/latest/menus.md`; nicht gegen die Oberfläche geprüft.

## 3. Gemeinsamer Nenner und VORSCHLAG
Nenner (alle): Heute, zurück/vor, Ansicht Tag/Woche/Monat (+Liste/Terminübersicht), Suche, Neuer Termin, Kalenderliste mit Sichtbarkeit/Farbe, Einstellungen, Import/Export ICS, Termin: Bearbeiten/Duplizieren/Löschen, Terminserie: "Nur dieses / dieses und folgende / alle". Unterschied: nur Merkuro (und Thunderbird/Outlook-klassisch) mit Leiste.
VORSCHLAG fs-calendars (Outlook/GNOME-Stil, keine Menüleiste; Shell-Titelleiste ADR 0065):
1. Shell-Titelleiste: Programm [Kalender importieren… , Kalender exportieren…, Beenden Strg+Q] | Ansicht [Tag Strg+4*, Woche, Monat, Terminübersicht (Radio); Seitenleiste (Häkchen)] | Hilfe. (*Merkuro-Belegung als Vorlage, nicht Zwang; Google nutzt 1/2/3).
2. Ansichtsleiste über dem Raster (Reihenfolge Outlook/GNOME): Titel "Mai–Juni 2025" | ◀ ▶ | Heute [t] | Tag | Woche | Monat | Terminübersicht | Suche [/] | Neu [Strg+N, c].
3. Linke Seitenleiste (Nextcloud/Google): Minikalender | Kalenderliste (Häkchen = sichtbar, Farbe) | + Kalender hinzufügen > (Neu, Abonnement aus Link) | Papierkorb.
4. Kontextmenü Termin: Öffnen [Enter] | Bearbeiten | Duplizieren | Link kopieren | Teilnehmerstatus > (Zusagen, Vielleicht, Absagen) | Löschen [Entf] (Serie: Dieses Vorkommen / Dieses und folgende / Alle). Kontextmenü Leerer Tag/Zeitfeld: Neuer Termin hier | Heute | Einfügen. Kontextmenü Kalender (Seitenleiste): Ein-/ausblenden | Farbe | Eigenschaften | Exportieren | Teilen (später).
5. Termin-Dialog/-Seite (Nextcloud-Gliederung): Titel, Kalender, Ganztägig | Zeit + Zeitzone | Wiederholung | Erinnerung | Teilnehmer | Ort | Beschreibung | Speichern/Verwerfen (mit "Änderungen verwerfen?").
6. Verhalten: Aufgaben erscheinen im Kalender als Tagesposten (Kalender fragt fs-tasks), Schalter "Aufgaben anzeigen" (Häkchen); nicht gebaute Einträge gesperrt mit Grund; Zeiten UTC+Zone (Normalisierungsregel).

## 4. Ist-Stand und fs-components-Lücken
fs-calendars v0.0.4+ (`window.rs`): Menüs Programm [Beenden] | Ansicht [Kalender, Ereignis = zwei Bildschirme] | Hilfe [Hilfe, Info]; Wörter englisch (`words.rs`). Raster-Bildschirm = `fs-components-calendar-grid` (Monat, Woche, Tag; Tagesposten Aufgaben); Ereignis-Bildschirm = generiertes Admin-Frontend. Der alte Workbench-Kalender (Heute, Zurück, Vor, Ansichtsknöpfe, Neu in `calendar/view/toolbar.rs`, v0.0.25) hatte eine Leiste, ist im Programm aber **aus dem Build entfernt**. Kein Kontextmenü, keine Kürzel, keine Kalenderliste, keine Suche, Import/Export nur per Kommandozeile (`fs-calendars import|export`).
| Bedarf | Stand v0.0.25 | Baustein |
|---|---|---|
| Menü-Modell: Trenner, Radio (Ansicht), Kürzel | fehlt | M1 |
| Kürzel t, c, 1–3, Strg+N, Entf, Pfeile | fehlt | M2/M4 |
| Kontextmenü Termin/Raster/Kalender mit Position am Zeiger | fehlt | M3 |
| Ansichtsleiste mit Überlauf ("Mehr") | nur alter Workbench | M7 |
| Personenauswahl (Teilnehmer) | Dialog-Rahmen da, Baustein fehlt | M6 |
| Datum-Springen (Strg+G / "Zu Datum…") | `[nicht belegt]` | prüfen |
| Datei-Wähler Import/Export | `[nicht belegt]` | prüfen |
Komponenten-Lauf M1–M4 + M7 vor Menü-Nachbau: JA.

## 5. Bildpaket-Plan (nur lokal; interne Referenzbilder, nicht im Repo; unser: Offscreen-Bild)
Namen `calendars-menue-<teil>-<vorbild|unser>.png`:
1. `fenster-monat` (GNOME vorhanden) | `fenster-woche` | `fenster-tag` | `fenster-terminuebersicht` [Vorbild fehlt] | `fenster-leer`
2. `ansichtsleiste` | `seitenleiste` | `kalender-hinzufuegen-menue` (Nextcloud/Google) | `hauptmenue-auf` (GNOME ☰, Vorbild fehlt) | `shell-titelleiste-programm/-ansicht/-hilfe` (nur unser)
3. `kontext-termin` | `kontext-zeitfeld` | `kontext-kalender` | `kontext-serie-loeschen` (Dieses/Folgende/Alle) [Vorbild fehlt, Outlook/Google am laufenden Programm]
4. `termin-dialog` | `termin-dialog-wiederholung` | `teilnehmer-auswahl` | `erinnerung`
Vorbild-Aufnahmen Outlook/Google/Merkuro/Thunderbird: Nutzer oder Test-Agent; Google-Webseite liefert Netz keine freie Aufnahme.

## 6. Deutsche Namen (nur belegte)
Google (deutsche Hilfe, belegt): Heute, Eintragen, Terminplan, Meine Kalender, Weitere Kalender, Weitere Kalender hinzufügen, Kalender abonnieren, Per URL, Einstellungen und Freigabe, Kalender exportieren, Weitere Details, Ansichtsoptionen, Importieren & Exportieren, Exportieren, Fokuszeit, Tag, Woche, 4 Tage, Monat, Jahr, Terminübersicht. fs-calendars: Programm/Ansicht/Hilfe deutsch `[nicht belegt]` im Kalenderprogramm (nur englisch gelesen). Outlook/Thunderbird/GNOME deutsch: `[nicht belegt]`.

## 7. Offene Fragen
1. Ansichten-Namen und Kürzel: Google-Belegung (1/2/3, t, c) oder Merkuro (Strg+1..) oder Outlook (Alt+…)? Empfehlung: Buchstaben ohne Modifikator (t, c, d/w/m) nur bei Fokus im Raster, dazu Strg+N; Konflikt-Regel M2.
2. "Terminübersicht" (Agenda) als eigene Ansicht jetzt oder später? Empfehlung: Grundfassung Tag/Woche/Monat + Terminübersicht (im Kern da).
3. Terminserie-Löschen als Rückfrage-Dialog oder Untermenü (Dieses/Folgende/Alle)? Empfehlung: Dialog mit drei Wahlen, wie Nextcloud/Google belegt.
4. Alten Workbench-Leiste (Heute/Zurück/Vor/Ansichtsknöpfe) wieder einbauen oder neue Leiste in fs-components-calendar-grid? Empfehlung: Ansichtsleiste in fs-calendars-app über M7.
5. Terminfragen (Doodle-artig) gehören nach b7 eingebettet in fs-decisions, nicht in diese Menüs: bestätigt?

## Entscheidung (b7, 17.11.)
Kürzel-Familie Google (Buchstaben, deutsch belegt). Serien-Löschen als Dialog „Nur dieser Termin / Dieser und alle folgenden / Alle“.
