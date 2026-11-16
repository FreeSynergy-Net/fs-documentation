# fs-components – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0074, 0084, 0087 Punkt 7; CHANGELOG und Tags in `fs-components`; Papier Arbeitsstand der Strategie, nicht veröffentlicht; Bildbefunde Arbeitsstand der Strategie, nicht veröffentlicht
fs-components ist die Baustein-Bibliothek (Blinc nur hier). Es gibt keine Programm-Oberfläche; „Grundsache“ heißt hier: die Bausteine tragen die Frontends aller Programme.
Hinweis zu Tags: Lokal liegen noch alte Tags `v0.1.0` bis `v0.3.0` (vor dem Reset, ADR 0064). Auf GitHub gelten `v0.0.1` bis `v0.0.19`.

## Erledigt (Beleg)
- [x] **GRUNDSACHE** Tag v0.0.17: Seitentitel-Regel, Namensdialog, Umbenennen, Löschen, Verwerfen (Tag `v0.0.17`, Commit 81b648a)
- [x] **GRUNDSACHE** Tag v0.0.18: Umbau-Werkzeug (Zählskript, Token-Liste, Bildvergleich-Test) (Tag `v0.0.18`, Commit 490c4b4)
- [x] **GRUNDSACHE** Bilder-Test mit Toleranz je Gruppe für Systemschrift (Commits 4457db9, 4552291, 84883db)
- [x] **GRUNDSACHE** Tag v0.0.19: Enter macht sofort einen Block, `/`-Blockmenü, Umbruch in echter Breite, Tabellen-Ausrichtung, Kästchen, Editor-Vertrag mit Tests (Tag `v0.0.19`, Commits 0b573ff, 55dc0f9, c915f70)
- [x] **GRUNDSACHE** Hülle, Menü und Sprache als MF2-Wörter, Deutsch und Englisch (seit Tag `v0.0.15`; Quelle `straenge-vollgas.md`)
- [x] **GRUNDSACHE** Gruppen `render` und `styles`: 0 feste Werte, nichts umzustellen (Kopf 89de2a9 laut `straenge-vollgas.md`)

## 0.0.20 (Branch `unreviewed/editor-0020`, Kopf ccdd1c1; zweiter Stand `origin/unreviewed/components-0.0.20`, 3d25106) – Nutzertest U1 bis U8
Code, Test mit Gegenprobe und Bild liegen vor. Auf `main` ist nichts davon. Kein Tag.
- [x] **GRUNDSACHE** U3 Block-Editor als eine durchgehende Schreibfläche (kein Feld je Block, Enter = nächster Block unsichtbar, Rücktaste fügt an) (Commits 6741c3e, 6c13308; Bild Arbeitsstand der Strategie, nicht veröffentlicht)
- [x] **GRUNDSACHE** U1/U2 Kästchen so hoch wie der Text und auf der Textzeile, in Liste und Tabellenzelle (Commit 4742fb9; Bild `abnahme/standard-notion-u1u2u7u8-seite.png`)
- [x] **GRUNDSACHE** U4/U5 Seiten-Icon und Gliederungsmarken ganz im Bild (Commit 4742fb9; Bild `abnahme/standard-notion-u4u5-rand.png`)
- [x] **GRUNDSACHE** U6 Brotkrume beginnt beim Text, Schalter „volle Breite“ (Commit 4742fb9; Bilder `abnahme/standard-notion-u6-spalte-1900.png`, `u6-spalte-1300`, `u6-volle-breite-1900`)
- [x] **GRUNDSACHE** U7 Tabellenschrift in Fließtextgröße (Commit 4742fb9; Bild `abnahme/standard-notion-u1u2u7u8-seite.png`)
- [x] **GRUNDSACHE** U8 Code-Block als Kasten mit Rahmen, eine Zeile etwa 44 px (Commit 4742fb9; Bild `abnahme/standard-notion-u1u2u7u8-seite.png`)
- [x] **GRUNDSACHE** `AppWidget::picture` zeichnet mit den Stilen eines Fensters (Commits 4742fb9, 3d25106)
- [x] **GRUNDSACHE** Schmales Fenster: Seitenleiste des Classic-Lesers weicht, Titel im Baum werden gekürzt (Commit 64b74a7; Bild `abnahme/standard-classic-480.png`: Inhalt bleibt lesbar)
- [ ] **GRUNDSACHE** Opus-Review des Kopfes ccdd1c1 (bisher kein Review-Befund in Arbeitsstand der Strategie, nicht veröffentlicht)
- [ ] **GRUNDSACHE** Bilder zum Strategie-OK, danach Merge nach `main` und Tag `v0.0.20` (Regel „Bilder vor Release“)
- [ ] **GRUNDSACHE** Bildbefund Craft-Stil: `abnahme/craft-notion-u1u2u7u8-seite.png` zeigt fast unsichtbaren Text (heller Text auf hellem Grund), offene Kästchen schwarz gefüllt, Suchfeld schwarz. Prüfen: Fehler der Bildmethode (`FS_ABNAHME_STYLE`, Commit ccdd1c1) oder des Stils [offen]
- [ ] **GRUNDSACHE** U1/U2 Ursache nicht gefunden: „Liste nicht klickbar“ und „Zellkästchen nicht aufhebbar“ ließen sich im Prozess nicht nachstellen (CHANGELOG 0.0.20). Prüfung durch den Nutzer-Test (Fable, etwa 2026-11-21)
- [ ] SPÄTER U4/U5 sind vorbeugend geändert, nicht im Bild nachgestellt (CHANGELOG 0.0.20)
- [ ] SPÄTER Bildabweichung am Tabellenrand unten (feiner Strich unter der letzten Zeile in `standard-notion-u1u2u7u8-seite.png`) ansehen [offen]

## Rich-Text-Editor Stufe 1 (Branch `unreviewed/rich-stufe1`, Tag-Kandidat v0.0.22, Kopf bbd149b (Merge mit `origin/main`, Autoren umgeschrieben); Volllauf mit Exit-Code im CHANGELOG des Kopfes; Reviews Opus 2026-11-16 im internen Arbeitsstand der Strategie)
Stufe 1 (Absatz, Überschriften, Listen, Aufgaben, Code, Zitat, Linie, Kürzel, Cursor über Blöcke) ist gebaut; auf `main` ist nichts davon, kein Tag. Erledigt mit Beleg, aus dem Review:
- [x] **GRUNDSACHE** Blocker B1: Raw-Block hatte mehrere Startpunkte, Eingaben gingen still verloren (Beispiele `- a\n- b\nlazy`, Tabelle im Zitat). Behoben (Commit 25f819b), Konformitätsfälle „lazy list item“ und „table in a quote“, Test `a_raw_block_can_be_typed_in`; Gegenprobe: ohne `starts.clear()` rot (Mutation auf Kopie, Arbeitsstand der Strategie, nicht veröffentlicht)
- [x] **GRUNDSACHE** Speicherform mit Maskierung (`save_form`, Rundlauf lesen-schreiben-lesen für alle Knotenarten, in Listen und Zitaten); Gegenprobe: Maskierung aus = rot (Commit 25f819b, Test `write_then_read_gives_the_same_tree`)
- [x] **GRUNDSACHE** Kürzel-Rückgabe nur direkt nach der Umwandlung und `[] ` + Rücktaste ergibt `[] ` ohne nie getipptes `- ` (Commit 25f819b; Gegenproben rot)
- [x] **GRUNDSACHE** Konformität „Nummer zählt nicht als Inhalt“ enger (`#.` statt Streichen; Liste zu Absätzen fällt durch) und `tick`-Wächter geschärft (Commits 25f819b, 3223fa7; Gegenproben rot)
- [x] **GRUNDSACHE** Theme je Bildtest isoliert (Sperre) und Theme-Wächter an jedem Bild; Gegenprobe: Sperre entfernt bzw. Standard-Test mit Craft-Aufbau = rot; Bilder parallel und seriell byte-gleich (Commit 4d70920, Ordner Arbeitsstand der Strategie, nicht veröffentlicht)
- [x] **GRUNDSACHE** Craft-Cursor als eigenes Token `--cursor` (`Palette::cursor`), Kontrast 7,9:1 (Craft) und 3,6:1 (Standard), nicht Textfarbe; Code-Grund Craft 1,37:1 (`--code-ground`); Markierungsspalte 28 px; Luft um die Linie halbiert; Hoch/Runter laufen über die Linie; Häkchen aus dem Stil der Fläche; Fokuszähler bei `Drop`; Bild b3 zeigt den Cursor am Ende der Codezeile; Doku Version 2 (de/en), CHANGELOG
- [x] **GRUNDSACHE** Review Runde 2, A1: Zahl wird als `1\. x` gespeichert (gültiges CommonMark-Escape), Leser nimmt es zurück; feste Erwartung, Rundlauf, Gegenprobe (Schreiber zurück auf `\1. x`) rot (Commit d3ece68)
- [x] **GRUNDSACHE** Review Runde 2, A3: `save_form()` und `take_save_ops()` am Trait `TextEditor` (Standardmethoden, Vertrag 2) und an `RichSurface`; `document()`/`take_ops()` als Live-Form dokumentiert (an `Session`/`RichSurface` umbenannt in `live_document()`/`take_live_ops()`, Commit 004d51f); Test mit Gegenprobe (Live-Form = Überschrift) (Commit f94713d)
- [x] **GRUNDSACHE** Linie in Craft: Luft über und unter der Linie mindestens 9 px in jedem Stil (`Look::rule_gap`), im Bild gemessen; Gegenprobe `RULE_GAP` 0 = Craft rot; Bilder Arbeitsstand der Strategie, nicht veröffentlicht (Commit 45cf253)
- [x] **GRUNDSACHE** Review Runde 3, A4: Speicherform folgt CommonMark (`1) x`, `1.<Tab>x`, nacktes `1.`/`-`/`#`, Text in Listeneinträgen gegen alle Blockanfänge maskiert); Gegenprobe mit pulldown-cmark, 38 Texte in Absatz, Listeneintrag und Zitat, Gegenfall unmaskiert = kein Absatz (Commit 004d51f, Test `tests/rich_save_commonmark.rs`)
- [x] **GRUNDSACHE** Ein Token `--code-bg` für den Code-Grund (`--code-ground` entfernt), Craft 12 %, mindestens 1,3:1; Linien-Abstand als Look-Wert dokumentiert (Commit 004d51f)
- [ ] **GRUNDSACHE** Opus-Review der Korrekturen, danach Bilder zum Strategie-OK, Merge und Tag (Regel „Bilder vor Release“)
- [ ] **GRUNDSACHE** Dieselbe Theme-Wächter-Regel in den Workflow `testlauf` (macht ein anderer Agent)
- [ ] SPÄTER Zahl-Maske `1\. x`: der Text hinter den Ziffern liegt in der Quelle ein Byte weiter als im Text (Startpunkt ist der des ersten Bytes); nur `TextEditor::edit` mit Quell-Offsets hinter der Zahl in einem solchen unberührten Absatz trifft um 1 daneben (Tasten und Klicks im Widget laufen über Cursor-Pfade und treffen richtig); nach der ersten Bearbeitung stimmt es wieder (Lücke je Blatt im Startpunkt-Modell)
- [ ] SPÄTER `RichBlock::node` ist `pub` (`block.rs:13`): Änderung ohne `touch()` möglich; kapseln
- [ ] SPÄTER `Session::new` auf leerem Dokument erzeugt eine `InsertBlock`-Operation ohne Eingabe
- [ ] SPÄTER Code scrollt nicht seitlich (lange Zeile; steht in DESIGN.md, fehlte in der Liste)
- [ ] SPÄTER Enter in einem Raw-Block teilt die Quelle (steht in DESIGN.md, fehlte in der Liste)
- [ ] SPÄTER Schrift-Rückfall (steht in DESIGN.md, fehlte in der Liste)
- [ ] SPÄTER Pos1 auf einer Folgezeile (umbrochener Absatz) ist ungetestet
- [ ] SPÄTER Theme-Wächter für Standard positiv gegen den erwarteten Grund (250,250,250) prüfen (heute nur „nicht der Craft-Grund“; Stufe 2)
- [ ] SPÄTER Häkchen per Pixel prüfen: Pixel in `on_accent` im angehakten Kästchen > N, Gegenprobe offenes Kästchen = 0 (heute zählt der Test nur Akzentpixel; Stufe 2)
- [ ] SPÄTER `check_rust_rules`: Dateien über 200 Zeilen (Warnungen, u. a. `fs-components-rich/tests/scenes.rs`, `fs-components-editor/src/rich/*`)
- [ ] SPÄTER IME und echtes Fenster unter Wayland: ein echter Fensterlauf mit Komposition (`ü` per Tottaste, Emoji-Auswahl, chinesische Eingabe), Protokoll Tastenfolge, erwartetes Markdown, Bild mit Cursor (bisher nur Blincs Handler-Register, nie ein echtes Fenster)
- [ ] SPÄTER Graphem-Cursor statt `char` (`unicode-segmentation` oder Blincs Cluster), Gegenprobe Emoji-Familie und Kombinationszeichen
- [ ] SPÄTER Lange Seiten: 2000 Blöcke / 50000 Zeichen, Zeit je Taste unter 16 ms messen (Geometrie wird bei jeder Taste ganz neu gesetzt, `offset_in` misst je Klick jedes Präfix neu); danach nur geänderte Blöcke neu setzen bzw. sichtbaren Bereich zeichnen
- [ ] SPÄTER Rückgängig (vor Kopieren/Einfügen)
- [ ] SPÄTER Tab / Einrücken und Ausrücken in Listen (Lesen und Schreiben verschachtelter Listen geht, es gibt keine Tasten)
- [ ] SPÄTER Tabellen als eigener Knoten mit Zellen als Blättern (kein `Raw`), Spaltenausrichtung und Kästchen in Zellen, Tab/Umschalt+Tab zwischen Zellen, Rundlauf byte-gleich
- [ ] SPÄTER Kopieren und Einfügen (Markdown über `read.rs`, Klartext löst keine Kürzel aus; Gegenprobe `## x` in einen Absatz erzeugt keine Überschrift)
- [ ] SPÄTER Auswahl über Blöcke (Auswahl als Cursor-Paar in `Session`, Löschen/Ersetzen über Blockgrenzen); entscheiden, ob der Vertrag dafür Version 3 bekommt oder cursorfrei bleibt (ADR 0084, nicht stillschweigend)
- [ ] SPÄTER Maße `CARET`, `BAR`, `BULLET`, Zeilenhöhe 1,5, Kästchenseite als Tokens aus dem Theme (`Look`), Cursor-Blinken
- [ ] SPÄTER `Surface::toggle_task_at` (workbenches, `view/wiki/surface.rs`) ruft kein `on_changed()`: der Besitzer im Fenster hört den Haken nicht (Review-Kleinigkeit)

## Frontend-Umbau (Schichten, ADR 0074)
- [ ] **GRUNDSACHE** Umbau-Werkzeug (Tag 0.0.18) und Token-Liste auf `main` halten; Entscheidungen der Token-Liste bestätigen (Gleichstand = kleinere Stufe, Craft als Referenzstil, Deckkraft-Toleranz 0,05) [offen, Strategie]
- [ ] **GRUNDSACHE** Texte nach MF2 in allen Crates: `texts-check` meldete am 2026-11-14 noch 449 Funde (Stufe R2), CI nur als Warnung; Ziel 0, dann CI hart [offen, Stand neu zählen]
- [ ] **GRUNDSACHE** Tokens statt fester Werte: Gruppen 2 bis 10 (charts, kanban, primitives, map, fields, calendar-grid, timeline, admin-frontend, app) – laut Papier 2026-11-14 nicht begonnen [offen, Stand neu prüfen]
- [ ] SPÄTER Tokens in `widgets` (Welle A und B) und `workbenches` (Gruppen 11 bis 16, der Großteil der Arbeit)
- [ ] **GRUNDSACHE** Wiki-Frontends (Notion, Confluence) in `workbenches` laufen mit den Programmen fs-text und fs-draw als Vorbild für alle weiteren Frontends (ADR 0087 Punkt 7)
- [ ] **GRUNDSACHE** Dossier-Pflicht (R2): kein neues Frontend ohne Vorbild-Dossier mit Arbeitsabläufen

## Frontend und Theme getrennt (Nutzerkorrektur 2026-11-16; Theme = bisher Stil, Begriff offen; Papier Arbeitsstand der Strategie, nicht veröffentlicht Abschnitt 11 und 12)
- [ ] **GRUNDSACHE** Theme meldet Vertragsversion und abgedeckte Bausteine (`contract_version`, `covers`), erzeugt/geprüft durch `stil-vollstaendigkeit` [offen, nichts davon belegt gebaut]
- [ ] **GRUNDSACHE** Theme-Auswahl filtert: nur Themes, die alle Bausteine des aktuellen Programms/Frontends vollständig gestalten; ungestalteter Baustein = Theme nicht anwendbar [offen]
- [ ] **GRUNDSACHE** Laufzeitwechsel des Themes außerhalb des Frontends, jedes Theme auf jedes Frontend (nicht „Frontend in Stil“); Blinc-Neuzeichnen zur Laufzeit [nicht belegt, Spike S0]
- [ ] SPÄTER Probe „Theme auf Frontend“ (Bild ändert sich, Struktur nicht) neben `zwei-stile`/Tokenprobe
- [ ] **GRUNDSACHE** Kompatibilität je Programm: Theme nutzbar, wenn es ALLE Bausteine dieses Programms gestaltet (Theme-Vertrag); dasselbe Theme kann für Programm A nutzbar, für B nicht nutzbar sein [Nutzerentscheidung 2026-11-16, offen, nichts belegt gebaut]
- [ ] **GRUNDSACHE** Unvollständige Themes in der Auswahl AUSGEGRAUT (nicht ausgeblendet), nicht wählbar, nicht anwendbar; Tooltip „nicht kompatibel“ plus Liste der fehlenden Bausteine bzw. Teile und Zustände; optional öffnet der Tooltip die Theme-Bearbeitung bzw. den Workflow `alle-themes-erweitern` für genau diese Lücken [offen]
- [ ] **GRUNDSACHE** Test mit Gegenprobe: Theme mit einer Lücke erscheint grau, mit korrektem Tooltip-Text, und lässt sich nicht anwenden; dasselbe Theme bleibt für ein Programm ohne diese Lücke wählbar; vollständiges Theme normal [offen, nichts belegt]
- [ ] **GRUNDSACHE** Begriff „Theme“ statt „Stil“ in Verträgen, Doku und UI-Texten (MF2 de/en: `theme-picker-title`, `theme-incompatible`, `theme-missing-blocks`, `theme-missing-parts`, `theme-disabled-hint`); Plan Arbeitsstand der Strategie, nicht veröffentlicht (fs-components: 5 Dateien, 14 Zeilen) [offen, nach Tag fs-release v0.0.7 über `umbenennen` + `doku-mitziehen`]
- [ ] SPÄTER Offene Fragen: Format und Ort der Theme-Meldung; Verhalten bei aktivem Theme, wenn ein Programm einen neuen Baustein bekommt [offen, Strategie]
- [ ] SPÄTER Nachtrag 2 zu ADR 0074 (Strategie schreibt; Entwurf im Papier Abschnitt 12)

## Bausteine, Folgepunkte
- [ ] SPÄTER Signal statt Abfrage alle 200 ms für Menü „Seite“ (Folgepunkt 0.0.11)
- [ ] SPÄTER Namensdialog und Frage als eigene Bausteine mit Zeile für den Grund, Fokusring (Folgepunkt 0.0.12; die Kopie in fs-wiki fällt dann weg)
- [ ] SPÄTER Brotkrume nennt Ordner mit Titel statt Pfadwort
- [ ] SPÄTER `RichTextEditor` (Ansicht mit fertiger Formatierung statt Markdown wie getippt), schwebendes Blockmenü mit Overlay-Schicht, Rücktaste fügt in Liste oder Tabelle darüber an
- [ ] SPÄTER Titel fett (Blinc `text_input` ohne Gewicht, Anfrage an Blinc per git-bug)
- [ ] SPÄTER Icon-Namen: Abgleich der 47 Glyphen mit fs-icons (Arbeitsstand der Strategie, nicht veröffentlicht, Entscheidung offen)
