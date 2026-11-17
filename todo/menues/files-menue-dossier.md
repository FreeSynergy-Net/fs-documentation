# Menue-Dossier FS-FILES (nur Recherche, Stand 2026-11-17)

Regel: Nachbauen = Struktur, Benennung, Reihenfolge, Kuerzel, Verhalten. Kein Code, keine Grafiken (ADR 0013). `[nicht belegt]` = in der offiziellen Quelle nicht gelesen; nichts erfunden.
Arbeitsweise: Dossiers aus `fs-documentation` origin/main (Branch-Stand 2026-11-14, Menue-Inventar), Ist-Stand aus blobless Klonen fs-files v0.0.11 und fs-components v0.0.25 (beide danach einzeln geloescht, s. Ende).
**Netz-Befund:** alle Abrufe offizieller Linux-Seiten (docs.kde.org Dolphin, help.gnome.org Nautilus, files.community/docs/features/context-menu) lieferten in diesem Lauf HTTP 404 bzw. wurden nicht erreicht. Dolphin/Nautilus/Thunar/Nemo sind deshalb komplett `[nicht belegt]`; sie sind ohnehin nach ADR 0066 (Windows-Stil: "bewusst keine Linux-Programme als Vorlage") keine Vorbilder des Frontends.

## 1. Vorbilder und Quellen

Welches Vorbild baut fs-files nach? ADR 0066 (Nachtrag 2026-11-09): Windows-Stil = 1:1, je Kategorie ein Windows-Programm, bevorzugt eines, das es unter Linux nicht gibt. Die Datei-Dossiers mit vollem Satz (menus, states, dialogs, workflows, acceptance) liegen fuer genau drei Programme vor:

| Vorbild | Rolle | Dossier (origin/main, `docs/en/programs/apps/files/frontends/...`) |
|---|---|---|
| Windows Explorer 11 | Windows-Stil, Hauptvorbild | `windows-explorer/latest/menus.md` (Quelle: support.microsoft.com: file-explorer-in-windows, keyboard-shortcuts-in-windows, zip-and-unzip-files, backup-and-restore-with-file-history, set-file-explorer-to-open-to-this-pc) |
| Files (files.community) | Windows-Programm, das es nur unter Windows gibt (passt zur ADR-Regel); Layout (Tabs, Befehlsleiste, Seitenleiste mit Home, Kommandopalette) steht dem heutigen fs-files-Fenster am naechsten | `files-community/latest/menus.md` (Quelle: files.community/docs/features/{toolbar,command-palette,sidebar,tabs,dual-pane}, /docs/customize-settings/*) |
| Total Commander 11.58 | Gegenprobe: klassische Menueleiste mit 8 Menues; Vorlage fuer "vollstaendiger Menuebaum" | `total-commander/latest/menus.md` (Quelle: offizielle Hilfe 11.58, KEYBOARD.TXT, lokal) |
| Nautilus, Dolphin, Finder | nur `index.md`; kein Menue-Dossier; Nautilus/Dolphin nach ADR 0066 keine Vorlage, Finder = Apple-Stil (spaeter) | `[nicht belegt]` |

Wichtigster Befund: **Weder Explorer 11 noch Files haben eine Menueleiste.** Ihre "Menues" sind (a) die Befehlsleiste mit Aufklapp-Knoepfen (Neu, Ansicht, Sortieren, "Mehr"), (b) Kontextmenues, (c) Files: Aktionen-Knopf und Kommandopalette. Nur Total Commander hat eine Menueleiste.

## 2. Menuebaum je Vorbild (kompakt; Quelle = Dossier-Inventar)

### 2.1 Windows Explorer 11 (Kuerzel in [ ])
```
Tab-Leiste: Tabs, Neuer Tab [Strg+T]
Befehlsleiste (Reihenfolge links->rechts, nur belegte Namen):
  Neu | Ausschneiden [Strg+X] | Kopieren [Strg+C] | Einfuegen [Strg+V] | Umbenennen [F2] | Freigeben | Loeschen [Entf, Strg+D]
  Ansicht > Layouts | Kompaktansicht | Anzeigen > Navigationsbereich | Elementkontrollkaestchen | Dateinamenerweiterungen | Ausgeblendete Elemente
  Weitere anzeigen ("...") > Optionen
Adressleiste: Zurueck [Alt+Links] Vor [Alt+Rechts] Hoch [Alt+Hoch] Aktualisieren [F5]; Pfad [Alt+D, Strg+L, F4]; Suchfeld [Strg+E]
Navigationsbereich: Start; Angeheftet (Schnellzugriff); Dieser PC; Laufwerke; Netzwerk; Cloud
Kontextmenue Datei/Ordner [Umschalt+F10]:
  Symbolzeile: Ausschneiden, Kopieren, Einfuegen, Umbenennen, Freigeben, Loeschen
  Oeffnen | Oeffnen mit > Andere App waehlen | An Schnellzugriff anheften / Von Schnellzugriff loesen
  Vertraulichkeitsbezeichnung anwenden | Alle extrahieren (ZIP)
  Weitere Optionen anzeigen [Umschalt+Rechtsklick] > Senden an > ZIP-Ordner | Fruehere Versionen (Ordner) | Eigenschaften [Alt+Enter]
  Menue anpassen
Kontextmenue Laufwerk: Fruehere Versionen wiederherstellen (Rest [nicht belegt])
Leerflaeche: Neu, Ansicht, Sortieren, Einfuegen, Eigenschaften (Reihenfolge/Trenner [nicht belegt])
Tab, Navigationsbereich-Eintrag, Papierkorb, Cloud-Eintrag: [nicht belegt] (Papierkorb: Wiederherstellen, Leeren; Cloud: Speicherplatz freigeben, Immer behalten; nur Namen)
Ansichten: Strg+Umschalt+Zahl; Strg+Mausrad = Symbolgroesse; Vorschaufenster [Alt+P], Detailfenster [Alt+Umschalt+P]; F6 = Fokus rotiert
```
Ueber Explorer ist die Hauptluecke: Reihenfolge, Trenner, Leerflaechen-/Tab-/Seitenleistenmenue und Statuszeile sind `[nicht belegt]` (Dossier gaps.md).

### 2.2 Files (files.community)
```
Titelleiste: Tabs, Plus; Aktionen-Knopf (links oben, Fensteranordnung/Panes)
Werkzeugleiste [Strg+Umschalt+B]: anpassbar; Modi: immer sichtbar + Kontextmodi (z. B. Papierkorb); Rechtsklick > Loesen | Werkzeugleiste anpassen
Omnibar: Pfad / Brotkrumen / Alias / Befehl / Suche
Kommandopalette [Strg+Umschalt+P] (150+ Aktionen mit Kuerzel), u. a.:
  Hilfe [F1] | Vollbild [F11] | Suche [Strg+F, F3] | Rueckgaengig [Strg+Z] | Wiederholen [Strg+Y] | Pfad bearbeiten [Strg+L, Alt+D]
  Ausgeblendete [Strg+H] | Infobereich [Strg+Alt+I] | Seitenleiste [Strg+B] | Werkzeugleiste [Strg+Umschalt+B]
  Kopieren [Strg+C] | Pfad kopieren [Strg+Umschalt+C] | Ausschneiden [Strg+X] | Einfuegen [Strg+V] | In gewaehlten Ordner einfuegen [Strg+Umschalt+V]
  Loeschen [Entf, Strg+D] | Endgueltig loeschen [Umschalt+Entf] | Ordner erstellen [Strg+Umschalt+N] | Element erstellen [Strg+Umschalt+I]
  Oeffnen [Enter] | Aktualisieren [Strg+R, F5] | Umbenennen [F2] | Alles auswaehlen [Strg+A] | Auswahl umschalten [Strg+Leertaste] | Vorschau [Leertaste]
  Archiv extrahieren [Strg+E] | Intelligent extrahieren [Strg+Umschalt+E] | Eigenschaften [Alt+Enter] | Einstellungen [Strg+,] | Terminal [Strg+`]
  Ansicht: Details [Strg+Umschalt+1] Liste 2, Karten 3, Raster 4, Spalten 5, Adaptiv 6 | Symbolgroesse [Strg++ / Strg+-]
  Tabs: Neu [Strg+T] | Neues Fenster [Strg+N] | Zurueck [Alt+Links, Rueck] | Vor [Alt+Rechts] | Hoch [Alt+Hoch] | Tab duplizieren [Strg+Umschalt+K]
        Geschlossenen Tab oeffnen [Strg+Umschalt+T] | Naechster [Strg+Tab] | Vorheriger [Strg+Umschalt+Tab] | Schliessen [Strg+W, Strg+F4]
  Teilen: waagrecht [Alt+Umschalt+H] | senkrecht [Alt+Umschalt+V] | Aktives Pane schliessen [Strg+Alt+W] | Anderes Pane fokussieren [Strg+Umschalt+Rechts]
  Papierkorb leeren | Papierkorbelement wiederherstellen
Kontextmenue Ordner: In neuem Tab oeffnen | In neuem Pane oeffnen | An Seitenleiste anheften / loesen | (Flatten-Optionen)
Kontextmenue Seitenleisteneintrag: Von Seitenleiste loesen | Abschnitt ausblenden (Kopfzeile)
Kontextmenue Datei, mehrere, Leerflaeche, Tab, Laufwerk, Papierkorb: [nicht belegt] (Doku-Seite context-menu existiert laut Dossier nicht)
Einstellungen: Allgemein, Darstellung, Dateien und Ordner, Aktionen, Erweitert
```
Dossier-Hinweis: "Alle Tabs schliessen [Strg+Umschalt+W]" widerspricht der Tabs-Seite (Konflikt, nicht aufgeloest).

### 2.3 Total Commander 11.58 (nur Struktur; Kuerzel siehe Dossier)
```
Menueleiste: Dateien | Markieren | Befehle | Netz | Ansicht(Show) | Konfiguration | Start | Hilfe   (F9 = Menue aktives Panel, F10 = linkes)
Dateien: Attribute aendern | Packen [Alt+F5] | Bestimmte Dateien entpacken [Alt+F6, Alt+F9] | Archive testen [Alt+Umschalt+F9] | Inhalt vergleichen | Zuordnen mit... | Interne Zuordnungen | Eigenschaften [Alt+Enter] | Belegten Platz berechnen [Strg+L] | Mehrfach-Umbenennen [Strg+M] | Kommentar bearbeiten [Strg+Z] | Drucken > | --- | Datei teilen | Dateien zusammenfuegen | Datei kodieren | dekodieren | Pruefsummen erzeugen | pruefen | --- | Beenden [Alt+F4]
Markieren: Gruppe waehlen | abwaehlen | Alles waehlen [Strg+A] | Alles abwaehlen [Strg+Num-] | Auswahl umkehren [Num*] | gleiche Endung [Alt+Num+] | Auswahl speichern | wiederherstellen [Num/] | In Datei speichern/laden | Namen in Zwischenablage (4 Varianten) | --- | Verzeichnisse vergleichen | Neuere markieren
Befehle: Verzeichnisbaum [Alt+F10] | Suchen [Alt+F7] | Suchen separat | Laufwerksname | Systeminfo | Verzeichnisse abgleichen | Hotlist [Strg+D] | Zurueck [Alt+Links] | --- | Eingabeaufforderung | --- | Verzweigte Ansicht [Strg+B] | Desktop | Hintergrundtransfer | --- | Quelle<->Ziel [Strg+U] | Ziel=Quelle
Netz: Verbindungen | Trennen | Freigeben | Freigabe aufheben | Admin-Freigaben | --- | FTP-Befehle > Verbinden [Strg+F], Neue [Strg+N], Trennen [Strg+Umschalt+F] | PORT
Ansicht: Kurz [Strg+F1] | Voll [Strg+F2] | Kommentare | Eigene Spalten [Umschalt+F1] | Eigene Ansichten | Baum [Strg+F8] | Getrennter Baum | Vorschaubilder [Strg+Umschalt+F1] | Schnellansicht [Strg+Q] | Vertikal | Neuer Ordner-Tab [Strg+T] | --- | Alle Dateien [Strg+F10] | Programme [Strg+F11] | *.* | Eigene [Strg+F12] | Nur Markierte | --- | Name [Strg+F3] | Erweiterung [Strg+F4] | Zeit [Strg+F5] | Groesse [Strg+F6] | Unsortiert [Strg+F7] | --- | Umgekehrt | --- | Neu einlesen [F2, Strg+R]
Konfiguration: Einstellungen | Knopfleiste aendern | Knopfleiste 2 | Einstellungsdateien | Dunkel<->Normal | Position speichern | Einstellungen speichern
Start: frei definierbare Programmliste | Hilfe: Index | Tastatur | Registrierung | Webseite | Update | Info
Kontextmenue Datei/Ordner [Umschalt+F10]: System-Shell-Menue + X64/X32-Untermenue + Kopieren + Ausschneiden
Kontextmenue Panel-Hintergrund/Pfad: Neu > | Einfuegen ; Ordner-Tab: Duplizieren, Sperren, Speichern/Laden, Schliessen (diese/alle/Duplikate), Zuletzt geschlossen, ...
```
Ob die Eintraege deutsch so heissen: `[nicht belegt]` (Dossier ist englisch; deutsche Namen oben sind Uebersetzung, vor Bau gegen deutsche Hilfe pruefen).

## 3. Gemeinsamer Nenner, Unterschiede, VORSCHLAG

Gemeinsamer Nenner (alle drei): Ausschneiden/Kopieren/Einfuegen/Umbenennen/Loeschen mit Strg+X/C/V, F2, Entf; Eigenschaften Alt+Enter; Aktualisieren F5; Zurueck/Vor Alt+Links/Rechts, Hoch Alt+Hoch; Papierkorb mit Wiederherstellen/Leeren; Neuer Tab Strg+T; Kontextmenue per Umschalt+F10; Ansichtswechsel und Sortierung als Aufklapper.
Unterschiede: Explorer/Files = Befehlsleiste statt Menueleiste, Kontextmenue zweistufig ("Weitere Optionen"); Files = Kommandopalette ersetzt die Leiste; TC = Menueleiste, Funktionstasten.

**Vorschlag fuer fs-files (Windows-Stil, Hauptvorbild Explorer 11, Zusatz Files):**
1. Keine eigene Menueleiste im Inhaltsbereich. Das Fenster-Rahmenmenue (Titelleiste) bleibt das einheitliche Shell-Menue (ADR 0065: Programm | Ansicht | Hilfe); es wird fuer fs-files **nicht** zur Explorer-Nachbildung, sondern nur Programm (Einstellungen, Beenden [Strg+Q]), Ansicht (Ansichten, Frontends >), Hilfe. Frage 1 klaert, ob das genuegt.
2. **Befehlsleiste** (Reihenfolge): Neu v (Ordner, Datei, Dokument... [nicht belegt: Eintraege]) | Ausschneiden | Kopieren | Einfuegen | Umbenennen | Freigeben | Loeschen | Sortieren v | Ansicht v | "..." (Weitere: Optionen). Beschriftungen: Windows 11 = nur Symbole mit Tooltip + Kuerzel im Tooltip ([nicht belegt], ob Text; Bild entscheidet).
3. **Ansicht v** (Explorer): Layouts (Symbole, Liste, Details, Kompakt) > ; Kompaktansicht ; Anzeigen > Navigationsbereich, Vorschaufenster, Detailfenster, Elementkontrollkaestchen, Dateinamenerweiterungen, Ausgeblendete Elemente (alle mit Haekchen).
4. **Sortieren v**: Name, Aenderungsdatum, Typ, Groesse, --- Aufsteigend/Absteigend (Radio) [Eintraege: Explorer-Dossier nur "Sort"; konkrete Liste `[nicht belegt]`, aus fs-components-SortKey {Name, Modified, Size, Type} uebernommen].
5. **Kontextmenue Datei/Ordner**: Symbolzeile (Ausschneiden, Kopieren, Einfuegen, Umbenennen, Freigeben, Loeschen) | Oeffnen | Oeffnen mit > | An Schnellzugriff anheften | Alle extrahieren (Archiv) | Weitere Optionen anzeigen (Umschalt+Rechtsklick) > Senden an > | Eigenschaften [Alt+Enter]. Untermenue "Weitere Optionen" = fs-files-spezifische Rest-Befehle (Papierkorb, Tags, Teilen).
6. **Kontextmenue Leerflaeche**: Neu > | Ansicht > | Sortieren > | Einfuegen | Eigenschaften (Reihenfolge als [nicht belegt]; hier an Explorer-Alltag angelehnt, per Bild pruefen).
7. **Seitenleisteneintrag**: Von Schnellzugriff loesen (Explorer) / Von Seitenleiste loesen, Abschnitt ausblenden (Files). **Tab**: Schliessen, Duplizieren [Strg+Umschalt+K], Geschlossenen Tab oeffnen [Strg+Umschalt+T]. **Papierkorb**: Wiederherstellen, Leeren.
8. **Kommandopalette [Strg+Umschalt+P]** als Zusatz aus Files (ersetzt fehlende Menueleiste; zeigt jede Aktion mit Kuerzel).
9. Verhalten: Eintraege ohne Faehigkeit sind deaktiviert (nicht verschwunden), mit Tooltip (ADR 0066/"Fehlende Datenquelle melden"); Kuerzel rechts in der Zeile; Haekchen fuer Zustaende; Radio fuer Sortierrichtung; Pfeil fuer Untermenues; Trenner zwischen Gruppen.

## 4. Ist-Stand und Luecken

**fs-files v0.0.11** (`crates/fs-files-app/src/faces.rs:29-56`): genau zwei Menues, Programm (Beenden) und Ansicht (`Face: List`, `Face: Grid`, das aktive deaktiviert, `(current)`); flaches Menue, `words.rs:19-27` (Program, View, Help, Quit, Face, About). DESIGN.md:371: "flat menu, because `Menu` has no sub-menu" - **veraltet**, fs-components v0.0.25 hat Untermenues. Kein Kontextmenue, keine Kuerzel in fs-files.
Befehlsleiste im Fenster: Knoepfe (Symbol-Tooltips) `fs-components-workbenches/src/file_manager/view/command_items.rs` (Neu mit Pfeil, Symbole filter, sort, details, trash, view-list, view-grid; nicht Gebautes gedimmt mit Tooltip, Z. 3-5, 11-22). Tabs: nur ein Tab, "more tabs are not built" (`view/tabs.rs:3`). Seitenleiste: `view/sidebar.rs`, Home, Angeheftet, Speicher, Netz, einklappbare Gruppen.

**fs-components v0.0.25**, Menueleiste (`fs-components-app`):
| Faehigkeit | Stand | Beleg |
|---|---|---|
| Untermenues | JA (`children`, `MenuEntry::submenu`, Pfeil, Auffalten links bei Platzmangel) | `src/menu.rs:24,41`; `menu_view.rs:64,80-95` |
| Haekchen (checked) | JA | `menu.rs:22`; `menu_view.rs:59,220` |
| Radio (Gruppe, Punkt) | NEIN (nur Haekchen; "chosen one of a group" per Haken) | `menu.rs:21-22` |
| Deaktivierte Eintraege | JA | `menu.rs:20` |
| Trenner im Menue | NEIN in MenuEntry (nur `dropdown().separator()` in Widgets und `context_menu` aus blinc_cn) | DESIGN.md:171; `widgets/dropdown/builder.rs:66`; `list_view/head.rs:62` |
| Kuerzel-Anzeige in der Zeile | NEIN, kein Feld | DESIGN.md:171; `menu.rs` (Felder id,label,disabled,checked,children) |
| Kuerzel-Ausfuehrung (Strg+Q, F1...) | NEIN ("shell menus have no shortcuts") | `fs-admin-frontend/DESIGN.md:63`, `window.rs:6` |
| Tastaturbedienung der Leiste | JA (Tab, Pfeile, Enter, Esc) | DESIGN.md:167 |
| Mnemonics (Alt+Buchstabe) | NEIN [nicht belegt] | - |
| Kontextmenue (Rechtsklick) auf Datei/Ordner/Leerflaeche/Seitenleiste/Tab | NEIN; einzig Spaltenkopf-Menue (blinc_cn `context_menu`) | `list_view/head.rs:12,34-62` |
| Menue unter Knopf (Neu, Ansicht, Sortieren) mit Eintraegen | `dropdown` vorhanden (item, item_disabled, separator, Platzierung), Untermenue/Haken/Kuerzel `[nicht belegt]` | `widgets/dropdown/builder.rs:42-66` |
| Zu schmale Leiste: Menues abgeschnitten, Scroll fehlt | Luecke | DESIGN.md:171 |
| Menue als Datenvertrag fuer Frontends ("Programm veroeffentlicht Funktionen fuer Menues") | nur `Menu/MenuEntry`, kein Kommandoverzeichnis | `app/menu.rs`; Memo "Style layers" |
| Kommandopalette | NEIN | - |
| Stil der Menues je Frontend (Explorer-Befehlsleiste, nicht Leiste) | Menueleiste ist immer die Shell-Leiste (title bar), einheitlich | DESIGN.md:165 |

**Hauptluecken:** (1) Kontextmenue-Component (Position am Zeiger, Rechtsklick/Umschalt+F10/Menue-Taste, Untermenue, Haken, Trenner, Kuerzel, deaktiviert) als eigene fs-components-Baustein; (2) Kuerzelfeld + Anzeige + globale Kuerzelbehandlung im Shell; (3) Trenner und Radio in `MenuEntry`; (4) gemeinsames Menue-Modell, das Leiste, Dropdown (Befehlsleiste) und Kontextmenue speist (heute zwei getrennte Wege: Shell-Menue und `dropdown`/blinc `context_menu`); (5) Befehlsleiste im Windows-Stil als eigenes Frontend-Layout (nicht Titelleiste); (6) Palette. **Komponenten-Lauf: JA**, vor jedem Menue-Nachbau in fs-files; sonst bleibt die Abnahme "Menue weicht ab".
Aufwand (Schaetzung, nicht gemessen): Komponenten-Lauf (1)-(4) ~2 Sonnet-Laeufe + Opus-Review; fs-files-Anschluss (Menuebaum, Kontextmenues, Kuerzel) ~1-2 Laeufe; Palette +1; Bildpaket (Abschnitt 5) ~1 Haiku/Sonnet-Lauf. Zusammen ~5-7 Laeufe.

## 5. Bildpaket-Plan (Vorbild | unser; Bilder lokal, nie ins Repo; ADR 0066)

Vorbild-Bilder (lokal): Explorer 11 Win11 hell, 100 %, Datei-/Ordnerauswahl; Files-App gleiche Ordner. Unser: Offscreen-Bild `AppWidget::picture`-Weg / Fenster-Foto, gleicher Ordner, gleiche Groesse. Namen `files-menue-<teil>-<vorbild|unser>.png`:
1. `befehlsleiste-ruhend` (nichts gewaehlt) | `befehlsleiste-datei-gewaehlt` | `befehlsleiste-mehrere-gewaehlt`
2. `neu-aufgeklappt` | `ansicht-aufgeklappt` | `ansicht-anzeigen-untermenue` | `sortieren-aufgeklappt` | `weitere-aufgeklappt`
3. `kontext-datei-kurz` | `kontext-datei-weitere-optionen` | `kontext-ordner` | `kontext-mehrere` | `kontext-leerflaeche` | `kontext-seitenleiste` | `kontext-tab` | `kontext-papierkorb` | `kontext-laufwerk`
4. `adressleiste-pfad-bearbeiten` | `tab-leiste-mehrere-tabs` | `suchfeld-aktiv`
5. `kommandopalette` (Files) | `werkzeugleiste-anpassen` (Files)
6. Shell: `titelleiste-menue-programm` | `-ansicht` | `-hilfe` (nur unser; Vorbild existiert nicht, Abgleich gegen ADR 0065)
Paarweise nebeneinander (Pflicht vor Zeigen), jeweils inklusive Menue-Hover/Fokus/deaktivierter Eintrag, hell und dunkel.

## 6. Offene Fragen
1. Soll fs-files im Windows-Stil KEINE Menueleiste zeigen (nur Befehlsleiste, Kontextmenue, Shell-Titelleiste mit Programm/Ansicht/Hilfe), oder zusaetzlich eine klassische Leiste (Datei/Bearbeiten/Ansicht/Hilfe) fuer Menschen, die "Menues" erwarten? (Der Nutzer sagt "Menues fehlen"; Explorer 11 hat keine.)
2. Hauptvorbild Explorer 11 oder Files (Befehlsleiste + Kommandopalette)? Files ist unter Linux nicht verfuegbar (ADR-Regel), hat aber nach Doku keine belegte Kontextmenue-Liste.
3. Dolphin/Nautilus doch als Vorbilder? Dann muss ein Lauf mit funktionierendem Netz die Handbuecher auswerten (hier 404).
4. Fehlende Reihenfolge/Trenner (Explorer-Leerflaeche, Sortieren-Liste): echtes Programm als Quelle (Windows-VM, lokal) oder Bild-Auswertung des Haiku-Fotos?
5. Deutsche Namen/Kuerzel der Eintraege: Microsoft-Terminologie (nicht kopieren, nur Benennung) oder eigene Uebersetzung? ADR 0057/MF2 beachten.

Bereinigung: Probe-Klone wurden einzeln gelöscht.
