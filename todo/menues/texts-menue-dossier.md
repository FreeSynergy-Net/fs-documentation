# Menü-Dossier FS-TEXTS (nur Recherche, Stand 2026-11-17)

Regel: Nachbauen = Struktur, Benennung, Reihenfolge, Kürzel, Verhalten. Kein Code, keine Grafiken (ADR 0013). `[nicht belegt]` = in der Quelle nicht gelesen; nichts erfunden.
Arbeitsweise: Menü-Inventare aus `fs-documentation` origin/main 980adcdc (`docs/en/programs/apps/texts/frontends/<x>/latest/menus.md`, `shortcuts.md`), Editor-Plan aus internen Plan-Unterlagen (DOSSIER.md, PLAN-0.0.14.md, B1–B3 entschieden: nicht widersprochen), Ist-Stand aus fs-wiki origin/main 5a4265c (v0.0.12-27; lokaler Ordner heißt noch `fs-wiki`, Programm fs-texts, ADR 0087) und fs-components origin/main v0.0.25 (nur gelesen, kein Klon verändert).
Netz: Wikimedia Commons erreichbar (3 Writer-Bilder geholt und selbst angesehen); Notion/Confluence/Obsidian/Typora-Bilder: keine freie Quelle, nicht gespeichert.

## 1. Vorbilder und Quellen
| Vorbild | Was dessen Menüs hergeben | Belegt wodurch | Güte |
|---|---|---|---|
| LibreOffice Writer (24.2 / 7.5, de) | klassische Menüleiste + Format-Symbolleiste + Textkontextmenü = Muster "Texteditor" | Bilder Commons (Lizenz in QUELLEN.md), DOSSIER Q6–Q8 (Kürzel) | Leiste, Hilfe-Menü, Kontextmenü BELEGT (Bild); übrige Menüs `[nicht belegt]` |
| Notion | Seitenleiste, Seitenmenü •••, Blockmenü ⋮⋮, Auswahl-Leiste, Schrägstrich-Menü, Teilen | Doku-Inventar (Notion-Hilfeseiten, gelesen 2026-11-14) | vollständig, mit Kürzeln und deutschen Namen (eigene Übersetzung) |
| Confluence Cloud | Kopfleiste, Seitenleiste, Seiten-•••-Menü, Raum-Menü, Verlauf, Anhang | Doku-Inventar (Atlassian-Hilfe) | gut; Rechtsklick `[nicht belegt]` (Atlassian beschreibt keinen) |
| MediaWiki / Wikipedia | Reiter Lesen/Bearbeiten/Versionsgeschichte/Diskussion, Werkzeuge, Bearbeiten-Leiste | Doku `mediawiki/latest/menus.md` | schwach (Entwurfston, nicht an Seiten geprüft): als Hinweis, nicht als Beleg |
| Wiki.js 3 | Format-Leiste über Quelltext, Einfüge-Spalte, Befehlspalette, Discard/Save | Bild `wikijs-bearbeiten-geteilt.png` (DOSSIER Q9) | Leistenknöpfe belegt (Bild); Menüs `[nicht belegt]` |
| Typora | nur Kürzel (Q3) und Moduswechsel Strg+/ | DOSSIER Q2/Q3 | Menüleiste "Absatz/Format" `[nicht belegt]` |
| Obsidian | Befehlspalette Strg+P, Ansichtsschalter, Strg+E | Doku `obsidian/latest/menus.md` ("Open: not read") | Menüs `[nicht belegt]` |
| VSCodium | Menüleiste Datei/Bearbeiten/Ansicht/Gehe zu/Terminal/Hilfe (ohne "Auswahl"?) | Doku `vscodium/latest/menus.md` | schwach, unvollständig; nur als Hinweis |
Nicht Vorbild: AppFlowy (AGPL, nur Ideen in appflowy-ideen.md), Tana/Logseq/XWiki/Tango (Dossiers haben keine Menü-Inventare, die hier nötig wären).
fs-texts hat heute drei Frontends: Classic, Confluence, Notion (`frontend.rs`). Die Menü-Vorbilder folgen daraus: Notion-Frontend = Notion-Menüs, Confluence-Frontend = Confluence-Menüs, Editor-Facette = Writer-Muster (DOSSIER 10: Datei-Menü Öffnen=Import, Speichern=Store, Exportieren=Datei).

## 2. Menübaum je Vorbild
### 2.1 LibreOffice Writer (aus Bildern, deutsche Oberfläche; Kürzel rechts)
```
Menüleiste: Datei | Bearbeiten | Ansicht | Einfügen | Format | Formatvorlagen | Tabelle | Formular | Extras | Fenster | Hilfe
  (Menütitel mit unterstrichenem Zugriffsbuchstaben, bei Alt sichtbar; Titelleiste "Unbenannt 1 - LibreOffice Writer")
Hilfe [Bild belegt, 11 Einträge, 4 Trenner]:
  LibreOffice-Hilfe [F1] | Direkthilfe | Benutzerhandbücher | Tipp des Tages anzeigen | Befehle suchen [Umschalt+Esc]
  --- Hilfe online erhalten | Rückmeldung geben
  --- Im abgesicherten Modus neu starten...
  --- Mitmachen | Spenden
  --- Lizenzinformation | Über LibreOffice
Datei, Bearbeiten, Ansicht, Einfügen, Format, Formatvorlagen, Tabelle, Formular, Extras, Fenster: Inhalt [nicht belegt] (Bilder zeigen sie nur zugeklappt)
Standardleiste (Symbole, Reihenfolge Bild): Neu v | Öffnen v | Speichern v | Export | Drucken | Druckvorschau | Ausschneiden | Kopieren | Einfügen v | Format übertragen | Rückgängig v | Wiederholen v | Suchen | Rechtschreibung | Formatierungszeichen | Tabelle | Bild | Diagramm | Textfeld | ... (Rest abgeschnitten)
Formatierungsleiste: Absatzvorlage [Standard v] | Schriftname [Liberation Serif v] | Größe [12 pt v] | F K U S (fett, kursiv, unterstrichen, durchgestrichen) | Hoch/Tiefgestellt | Direktformatierung löschen ...
Textkontextmenü (englisch, 24.2; deutsche Namen `[nicht belegt]`):
  Cut [Ctrl+X] | Copy [Ctrl+C] | Paste [Ctrl+V] | Paste Special >
  --- Clone Formatting | Clear Direct Formatting [Ctrl+M] | Character > | Paragraph > | List >
  --- Insert Comment [Ctrl+Alt+C] | Page Style... [Alt+Shift+P]
Kürzel (DOSSIER Q6): Strg+1..3 Überschrift 1–3, Strg+0 Textkörper, F12/Umschalt+F12 Listen, Strg+Y Wiederholen, Umschalt+Enter Zeilenumbruch, Alt+Enter Absatz ohne Aufzählung
```
### 2.2 Notion (Doku-Inventar; macOS-Kürzel weggelassen, Strg-Fassung)
```
Seitenleiste: Suche [Strg+K] | Start | Chats mit Notion AI | Meetings | Eingang (Alle gelesen, Alle archivieren, Gelesene archivieren) | Library | Vorlagen | Papierkorb | Einstellungen | Marketplace | Meine Aufgaben | Neu-Menü | Workspace-Wechsler (Einstellungen, Abmelden)
  Ein-/Ausklappen [Strg+\]; Bereiche Privat/Geteilt/Teamspace mit Bereichsmenü •••: Sortieren > (Manuell, Zuletzt bearbeitet) | Anzeigen | Bereich verschieben > (hoch, runter) | Teamspace verlassen
Seite in der Seitenleiste, ••• beim Überfahren (Kontextmenü; Rechtsklick selbst [nicht belegt]):
  Löschen | Duplizieren | Link kopieren [Strg+L] | Umbenennen | Verschieben nach | Aus Favoriten entfernen ; "+" = Unterseite hinzufügen
Seitenkopf: Teilen | Favorit (Stern) | ••• Seitenmenü:
  Darstellung & Layout > (Standard, Serif, Mono | Kleiner Text | Volle Breite | Seitendiskussionen | Inhaltsverzeichnis)
  Mit KI verwenden | Mehr > (Präsentieren, Übersetzen, Importieren, Exportieren > PDF/HTML/Markdown & CSV, Zu Wiki machen)
  Versionsverlauf | Verschieben nach | Duplizieren | Archivieren | Löschen          (Reihenfolge laut Inventar; Trenner [nicht belegt])
Blockmenü (⋮⋮ am Rand oder Rechtsklick Desktop; Strg+/):
  Umwandeln in [Strg+/] | Farbe | Link zum Block kopieren | Duplizieren [Strg+D] | Verschieben nach | Löschen [Rücktaste]
  Kommentar [Strg+Umschalt+M] | Änderungen vorschlagen | Mit KI bearbeiten | KI fragen | Wort- und Zeichenzahl
Auswahl-Leiste (schwebend über markiertem Text; Knöpfe laut Inventar): Fett [Strg+B] | Kursiv [Strg+I] | Unterstrichen [Strg+U] | Durchgestrichen [Strg+Umschalt+S] | Inline-Code [Strg+E] | Link [Strg+K] | Kommentar | Farbe [Strg+Umschalt+H] | Erwähnung [@]  (Leistenaufbau/Trenner [nicht belegt])
Schrägstrich-Menü "/" (Filter /h1, /todo, /code): Text, Seite, To-do-Liste, Überschrift 1–3, Aufzählung, Nummerierung, Aufklappliste, Trenner, Zitat, Seitenlink, Erwähnung, Datum/Erinnerung, Formel, Emoji, Bild, PDF, Lesezeichen, Video, Audio, Code, Datei, Einbettung, Duplizieren, Verschieben, Löschen, Inhaltsverzeichnis, Vorlagenknopf, Brotkrumen, Umwandeln, Farbe
Papierkorb-Eintrag: Wiederherstellen | Endgültig löschen   Suchfenster: Sortieren (5 Arten) | Filter (Titel, Ersteller, Teamspace, In, Datum) | Link kopieren [Strg+L]
Teilen-Menü: Reiter Teilen/Veröffentlichen; Einladen; Zugriffsstufe (Voller Zugriff, Kann bearbeiten, Kann Inhalt bearbeiten, Kann erstellen, Kann kommentieren, Kann ansehen); Allgemeiner Zugriff (nur Eingeladene, alle im Workspace, jeder mit Link)
Kürzel Blocktyp (Strg+Umschalt+0..8: Text, Überschr. 1–3, To-do, Liste, Nummer, Aufklapp, Code), Enter/Umschalt+Enter, Tab/Umschalt+Tab, Esc = Block wählen, Strg+Umschalt+Pfeil = Block verschieben
```
### 2.3 Confluence Cloud (Doku-Inventar)
```
Kopfleiste: Suche [Alt+Umschalt+Z] | Erstellen > (Seite [Win+Alt+C], Live-Dokument, Datenbank, Loom-Video, Whiteboard, Folien, Mit Rovo erstellen, Blogbeitrag) | Chat | Benachrichtigungen | Hilfe > Tastenkürzel [Umschalt+?] | Profil und Einstellungen
Seitenleiste: Für dich | Zuletzt (Heute, Bearbeitet, Von mir) | Markiert | Bereiche | Apps | Mehr | Teams | Entwürfe | Company Hub | Seitenleiste anpassen ; Baumeintrag: + (Unterseite) und ••• (Entwurf: Löschen; sonstige Einträge [nicht belegt])
Seiten-•••-Menü (Ansichtsmodus): Markieren | Beobachtungseinstellungen | Vorschau | Suchen und Ersetzen | Änderungen anzeigen* | Frühere Fassung wiederherstellen* | Versionsverlauf | Verschieben | Duplizieren | In Live-Dokument umwandeln | Vorlagen und Import | Exportieren > Word, PDF | Archivieren | Archivieren und Löschen > Löschen   (* nur bei unveröffentlichten Änderungen)
Entwurf im Editor: Vorschau | Suchen und Ersetzen | Verschieben | Vorlagen und Import | In Live-Dokument umwandeln | Entwurf löschen ; "Weitere Optionen > Veröffentlichen als" Seite/Blog
Raum-•••: Raumeinstellungen (Inhalt: Papierkorb, Archiv, Ausgeblendet, Neuordnen; Allgemein: Funktionen, Raum exportieren PDF/CSV/HTML/XML) | Zugriff | Anhänge
Papierkorb-Eintrag: Wiederherstellen | Endgültig löschen (Kopf: Alle endgültig löschen) ; Version: Diese Fassung wiederherstellen | Löschen | Vergleichen (Kästchen) ; Anhang: Herunterladen | Alle herunterladen | Eigenschaften | Löschen
Schwebende Aktionsleiste: Kommentare | Details | Emoji-Reaktionen | Loom | KI ; Editor-Symbolleiste fest oben ODER schwebend bei Auswahl, umschaltbar ("Symbolleistenmenü") ; Knöpfe [nicht belegt]
Editor-Kürzel (Strg): Fett B, Kursiv I, Unterstrichen U, Durchgestrichen Umschalt+S, Inline-Code Umschalt+M, Link K, Dateien/Bilder M, Tabelle Umschalt+I, Überschrift Strg+Alt+1–6, Liste Umschalt+7/8, Zitat Umschalt+9; Autoformat "# ", "* ", "> ", "```", "---", "[] "; "/" Einfügen, ":" Emoji, "@" Erwähnung
```
### 2.4 Weitere (nur Hinweis-Güte)
MediaWiki: Reiter Seite/Diskussion + Lesen/Bearbeiten/Quelltext/Versionsgeschichte/Beobachten; Werkzeuge: Links auf diese Seite, Änderungen an verlinkten Seiten, Spezialseiten, Druckversion; Benutzermenü: Diskussion, Beiträge, Beobachtungsliste, Einstellungen, Abmelden (Entwurf der Doku, nicht gegen Wikipedia geprüft). Wiki.js 3: Format-Leiste (Fett, Kursiv, Durchgestrichen, Überschrift, tief/hoch, Zeilenblock, Listen, Aufgabenliste, Code, Tastatur) + linke Einfüge-Spalte (Link, Bild, Code, Tabelle) + Befehlspalette + "Discard"/"Save Changes" (Bild). Wiki.js-Doku listet Home/Seiten/Editor/Papierkorb/Medien/Benutzer ... (Entwurfston, nicht verwertet).

## 3. Gemeinsamer Nenner und VORSCHLAG
Nenner (Notion + Confluence + Writer): (a) Seitenbaum links mit Kontextmenü Umbenennen/Duplizieren/Verschieben/Löschen; (b) Seitenmenü mit Export/Versionsverlauf/Verschieben/Duplizieren/Löschen; (c) Auswahl-Leiste mit Fett/Kursiv/Unterstrichen/Durchgestrichen/Code/Link; (d) "/"-Einfügemenü; (e) Strg+B/I/U/K/F/Z/Y; (f) Papierkorb mit Wiederherstellen/Endgültig löschen. Unterschied: nur Writer/Typora haben eine Menüleiste; Notion/Confluence kennen keine Rechtsklick-Liste für Seiten (nur •••).
VORSCHLAG (je Frontend folgt seinem Vorbild; gemeinsam sind Befehle und Kürzel, ADR 0074 §5/§6, PLAN-components M1–M8):
1. Shell-Titelleiste (ADR 0065): Programm [Beenden Strg+Q] | Seite | Ansicht [Frontends >] | Hilfe [Hilfe F1, Über]. Heute fehlt Hilfe.
2. Notion-Frontend: keine Leiste; Seitenleiste (Reihenfolge wie 2.2), Seitenmenü •••, Blockmenü ⋮⋮ (auch Rechtsklick und Umschalt+F10), Auswahl-Leiste, "/"-Menü (PLAN-0.0.14 §4), Teilen-Menü später. KI-Einträge entfallen (Nutzerentscheid: keine KI im Editor).
3. Confluence-Frontend: Kopfleiste Suche | Erstellen > (Seite, Unterseite ...) | Hilfe; Seiten-•••-Menü wie 2.3 ohne Loom/Rovo/Live-Dokument; Baumeintrag + und •••.
4. Editor-Facette (Writer-Muster, Frage 1): Menüleiste Datei [Neu, Öffnen = Import, Speichern, Exportieren >, Drucken] | Bearbeiten [Rückgängig Strg+Z, Wiederholen Strg+Y, ---, Ausschneiden/Kopieren/Einfügen, Alles auswählen, ---, Suchen Strg+F] | Ansicht [Modus: Live / Geteilt / Quelltext / Lesen (Radio), Seitenleiste Strg+\ (Häkchen)] | Einfügen [Link Strg+K, Bild, Tabelle, Codeblock, Trenner] | Format [Fett ... Code (Häkchen), Überschrift 1–3, Liste, Zitat] | Hilfe. Inhalte sind Vorschlag aus Nenner, Reihenfolge nach Writer-Titelleiste (Datei | Bearbeiten | Ansicht | Einfügen | Format ...) belegt, die Einträge darunter `[nicht belegt]` bis Bildvergleich.
5. Textkontextmenü (Writer-belegt): Ausschneiden | Kopieren | Einfügen | --- | Format löschen [Strg+M, Writer] | Zeichen > | Absatz > | Liste > | --- | Kommentar [Strg+Alt+C].
6. Format-Symbolleiste: Absatzvorlage | F K U S | Code | Link | Liste | Zitat (Reihenfolge Writer-Leiste; schwebend in Notion/Confluence).
7. Verhalten: nicht gebaute Einträge gesperrt mit Grund "(kommt noch)" (ADR 0066, heute schon so im Seite-Menü); Kürzel rechts; Moduswechsel als Radio. Kürzel-Konflikt: PLAN-0.0.14 nennt Strg+/ für Moduswechsel (Typora), Notion belegt Strg+/ mit "Umwandeln in" (Frage 2). (überholt durch Entscheidung 2, b7 17.11.)

## 4. Ist-Stand und fs-components-Lücken
fs-texts (origin/main 5a4265c): Menüs Programm [Beenden] | Seite [Neue Seite, Neue Unterseite, Umbenennen, Löschen, Entwurf verwerfen; Grund in Klammern bei gesperrt, Zustandsmuster `window_menu.rs`] | Ansicht [je Frontend ein Eintrag mit "✓ "-Zeichen im Text statt Häkchen: Classic, Confluence, Notion]. Kein Hilfe-Menü, kein Kontextmenü, keine Kürzel, keine Auswahl-Leiste, kein "/"-Menü (nur Wort-Widget `slash_menu`), keine Trenner. Deutsch belegt: Programm, Beenden, Ansicht, Seite, Neue Seite, Neue Unterseite, Umbenennen, Löschen, Entwurf verwerfen (`locales/de.mf2`). Editor heute = ein `textarea` (workbenches `view/editor.rs`), Notion-Frontend je Block ein `textarea`.
| Bedarf | Stand v0.0.25 | Baustein |
|---|---|---|
| Trenner, Radio, Kürzelanzeige in `MenuEntry` | fehlt (nur Häkchen/gesperrt/Untermenü) | M1 |
| Kürzel-Ausführung, Vorrang Fokus-Element (Strg+B im Editor) | fehlt; `bind_keys` nur am Element | M2 |
| Kontextmenü Rechtsklick/Menü-Taste (Block, Baumeintrag, Text) | fehlt (blinc_cn `context_menu` vorhanden) | M3 |
| Tastatur/Mnemonics in Menüs | Leiste ja, Mnemonics nein | M4 |
| Seitenbaum mit Zeilenmenü, Laden bei Bedarf | `tree_view` ohne Zeilenmenü | M5 |
| Befehlsleiste + Palette (Seitenkopf, Strg+Umschalt+P / "Befehle suchen") | fehlt | M7 |
| Schwebende Auswahl-Leiste, "/"-Menü mit Inhalten | Blinc `rich_text_editor` vorhanden, Menü fehlt; Marken/Tabelle/Code fehlen (plan-rich-editing 4.5) | zusätzlich, an M3 hängen |
| Menü als Datenvertrag (Programm veröffentlicht Befehle) | nur `Menu`/`MenuEntry` | M1/M7 |
Komponenten-Lauf M1–M4 vor jedem Menü-Nachbau in fs-texts: JA. Rest (M5, M7, Auswahl-Leiste) danach.

## 5. Bildpaket-Plan (nur lokal; Vorbild-Ordner interne Referenzbilder, nicht im Repo, QUELLEN.md; unser: Offscreen-Bild, gleiche Größe)
Namen `texts-menue-<teil>-<vorbild|unser>.png`:
1. `writer-leiste-ruhend` (Vorbild: Writer de, vorhanden zum Teil) | `shell-titelleiste-programm/-seite/-ansicht/-hilfe` (unser)
2. `writer-datei-auf` | `-bearbeiten-auf` | `-ansicht-auf` | `-einfuegen-auf` | `-format-auf` (Vorbild FEHLT, eigene Aufnahme nötig) | `editor-datei-auf` ... (unser)
3. `kontext-text` (Writer vorhanden, englisch) | `kontext-block` (Notion ⋮⋮) | `kontext-baumeintrag` (Notion •••, Confluence •••) | `kontext-leerflaeche` [nicht belegt] | `kontext-papierkorb`
4. `auswahl-leiste` (Notion, Confluence) | `slash-menue` (Notion, Wiki.js-Befehlspalette vorhanden) | `format-leiste` (Writer, Wiki.js vorhanden)
5. `seitenmenue-auf` (Notion •••, Confluence •••) | `teilen-menue` | `blockmenue-umwandeln-untermenue`
Vorhandene Vorbild-Bilder: 3 Writer (Commons), Wiki.js zwei (Lizenz [nicht belegt]), Writer Bearbeiten (Commons, GPL laut Metadaten). Notion/Confluence/Typora/Obsidian-Aufnahmen: Nutzer oder Test-Agent am laufenden Programm.

## 6. Deutsche Namen (nur belegte)
Belegt (Writer-Bild de): Datei, Bearbeiten, Ansicht, Einfügen, Format, Formatvorlagen, Tabelle, Formular, Extras, Fenster, Hilfe, LibreOffice-Hilfe, Direkthilfe, Benutzerhandbücher, Befehle suchen, Über LibreOffice, Lizenzinformation. Belegt (fs-texts de.mf2): siehe Abschnitt 4. Notion/Confluence: deutsche Namen im Inventar sind eigene Übersetzung, Microsoft-/Atlassian-Wortlaut `[nicht belegt]`. Kontextmenü Writer deutsch: `[nicht belegt]`.

## 7. Offene Fragen
1. Soll die Editor-Facette eine klassische Menüleiste (Writer: Datei|Bearbeiten|Ansicht|Einfügen|Format|Hilfe) haben, obwohl Notion/Confluence keine haben? Empfehlung: ja nur in der Editor-Facette, Notion/Confluence-Frontends vorbildtreu ohne.
2. Moduswechsel-Kürzel: Strg+/ (PLAN-0.0.14, Typora) kollidiert mit Notion (Strg+/ = Umwandeln in). Empfehlung: Strg+/ nur im Frontend ohne Block-Menü, sonst Strg+Umschalt+E (Vorschlag, nicht belegt). (überholt durch Entscheidung 2, b7 17.11.)
3. Dürfen KI-Einträge (Notion: Mit KI bearbeiten, KI fragen) ganz entfallen? Empfehlung: ja, Nutzerentscheid keine KI im Editor.
4. Vorbild-Aufnahmen Writer-Menüs/Notion/Confluence: Nutzer, Test-Agent oder VM? Ohne sie bleiben Einträge unter Datei/Bearbeiten/Format `[nicht belegt]`.
5. Rechtsklick auf Seitenbaum-Eintrag: Vorbilder haben nur •••. Beides anbieten (Rechtsklick öffnet dasselbe Menü)? Empfehlung: ja.

## Entscheidung (b7, 17.11.)
1. Jedes Frontend folgt SEINEM Vorbild: Die Editor-Facette (Writer-artig) bekommt eine klassische Menüleiste. Die Notion- und Confluence-artigen Frontends bekommen keine Leiste, sondern „/“-Menü, Auswahl-Leiste und Kontextmenüs.
2. Strg+/ gehört im Notion-artigen Frontend zu „Umwandeln in“ (vorbildtreu). Der Moduswechsel aus PLAN-0.0.14 bekommt ein anderes Kürzel (M2 zeigt Konflikte ohnehin an). Das ersetzt die Empfehlung in den offenen Fragen.
