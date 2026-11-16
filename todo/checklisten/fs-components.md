# fs-components – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0074, 0084, 0087 Punkt 7; CHANGELOG und Tags in `/srv/FreeSynergy/fs-components`; Papier `/srv/FreeSynergy/.scratch/straenge-vollgas.md`; Bildbefunde `/srv/FreeSynergy/.scratch/components-0020-bilder/`
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
- [x] **GRUNDSACHE** U3 Block-Editor als eine durchgehende Schreibfläche (kein Feld je Block, Enter = nächster Block unsichtbar, Rücktaste fügt an) (Commits 6741c3e, 6c13308; Bild `.scratch/components-0020-bilder/abnahme/standard-notion-u3-schreibflaeche.png`)
- [x] **GRUNDSACHE** U1/U2 Kästchen so hoch wie der Text und auf der Textzeile, in Liste und Tabellenzelle (Commit 4742fb9; Bild `abnahme/standard-notion-u1u2u7u8-seite.png`)
- [x] **GRUNDSACHE** U4/U5 Seiten-Icon und Gliederungsmarken ganz im Bild (Commit 4742fb9; Bild `abnahme/standard-notion-u4u5-rand.png`)
- [x] **GRUNDSACHE** U6 Brotkrume beginnt beim Text, Schalter „volle Breite“ (Commit 4742fb9; Bilder `abnahme/standard-notion-u6-spalte-1900.png`, `u6-spalte-1300`, `u6-volle-breite-1900`)
- [x] **GRUNDSACHE** U7 Tabellenschrift in Fließtextgröße (Commit 4742fb9; Bild `abnahme/standard-notion-u1u2u7u8-seite.png`)
- [x] **GRUNDSACHE** U8 Code-Block als Kasten mit Rahmen, eine Zeile etwa 44 px (Commit 4742fb9; Bild `abnahme/standard-notion-u1u2u7u8-seite.png`)
- [x] **GRUNDSACHE** `AppWidget::picture` zeichnet mit den Stilen eines Fensters (Commits 4742fb9, 3d25106)
- [x] **GRUNDSACHE** Schmales Fenster: Seitenleiste des Classic-Lesers weicht, Titel im Baum werden gekürzt (Commit 64b74a7; Bild `abnahme/standard-classic-480.png`: Inhalt bleibt lesbar)
- [ ] **GRUNDSACHE** Opus-Review des Kopfes ccdd1c1 (bisher kein Review-Befund in `.scratch/review-*`)
- [ ] **GRUNDSACHE** Bilder zum Strategie-OK, danach Merge nach `main` und Tag `v0.0.20` (Regel „Bilder vor Release“)
- [ ] **GRUNDSACHE** Bildbefund Craft-Stil: `abnahme/craft-notion-u1u2u7u8-seite.png` zeigt fast unsichtbaren Text (heller Text auf hellem Grund), offene Kästchen schwarz gefüllt, Suchfeld schwarz. Prüfen: Fehler der Bildmethode (`FS_ABNAHME_STYLE`, Commit ccdd1c1) oder des Stils [offen]
- [ ] **GRUNDSACHE** U1/U2 Ursache nicht gefunden: „Liste nicht klickbar“ und „Zellkästchen nicht aufhebbar“ ließen sich im Prozess nicht nachstellen (CHANGELOG 0.0.20). Prüfung durch den Nutzer-Test (Fable, etwa 2026-11-21)
- [ ] SPÄTER U4/U5 sind vorbeugend geändert, nicht im Bild nachgestellt (CHANGELOG 0.0.20)
- [ ] SPÄTER Bildabweichung am Tabellenrand unten (feiner Strich unter der letzten Zeile in `standard-notion-u1u2u7u8-seite.png`) ansehen [offen]

## Rich-Text-Editor Stufe 1 (Branch `unreviewed/rich-stufe1`, Kopf 61b7b05 + folgende; Review Opus 2026-11-16 `/srv/FreeSynergy/.scratch/review-u3-stufe1-opus.md`)
Stufe 1 (Absatz, Überschriften, Listen, Aufgaben, Code, Zitat, Linie, Kürzel, Cursor über Blöcke) ist gebaut; auf `main` ist nichts davon, kein Tag. Erledigt mit Beleg, aus dem Review:
- [x] **GRUNDSACHE** Blocker B1: Raw-Block hatte mehrere Startpunkte, Eingaben gingen still verloren (Beispiele `- a\n- b\nlazy`, Tabelle im Zitat). Behoben (Commit 7c1d5b2), Konformitätsfälle „lazy list item“ und „table in a quote“, Test `a_raw_block_can_be_typed_in`; Gegenprobe: ohne `starts.clear()` rot (Mutation auf Kopie, `.scratch/u3-mut.sh`)
- [x] **GRUNDSACHE** Speicherform mit Maskierung (`save_form`, Rundlauf lesen-schreiben-lesen für alle Knotenarten, in Listen und Zitaten); Gegenprobe: Maskierung aus = rot (Commit 7c1d5b2, Test `write_then_read_gives_the_same_tree`)
- [x] **GRUNDSACHE** Kürzel-Rückgabe nur direkt nach der Umwandlung und `[] ` + Rücktaste ergibt `[] ` ohne nie getipptes `- ` (Commit 7c1d5b2; Gegenproben rot)
- [x] **GRUNDSACHE** Konformität „Nummer zählt nicht als Inhalt“ enger (`#.` statt Streichen; Liste zu Absätzen fällt durch) und `tick`-Wächter geschärft (Commits 7c1d5b2, e1b3322; Gegenproben rot)
- [x] **GRUNDSACHE** Theme je Bildtest isoliert (Sperre) und Theme-Wächter an jedem Bild; Gegenprobe: Sperre entfernt bzw. Standard-Test mit Craft-Aufbau = rot; Bilder parallel und seriell byte-gleich (Commit 1828275, Ordner `.scratch/u3-stufe1-bilder/20261116-0207/`)
- [x] **GRUNDSACHE** Craft-Cursor als eigenes Token `--cursor` (`Palette::cursor`), Kontrast 7,9:1 (Craft) und 3,6:1 (Standard), nicht Textfarbe; Code-Grund Craft 1,37:1 (`--code-ground`); Markierungsspalte 28 px; Luft um die Linie halbiert; Hoch/Runter laufen über die Linie; Häkchen aus dem Stil der Fläche; Fokuszähler bei `Drop`; Bild b3 zeigt den Cursor am Ende der Codezeile; Doku Version 2 (de/en), CHANGELOG
- [ ] **GRUNDSACHE** Opus-Review der Korrekturen, danach Bilder zum Strategie-OK, Merge und Tag (Regel „Bilder vor Release“)
- [ ] **GRUNDSACHE** Dieselbe Theme-Wächter-Regel in den Workflow `testlauf` (macht ein anderer Agent)
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

## Frontend und Theme getrennt (Nutzerkorrektur 2026-11-16; Theme = bisher Stil, Begriff offen; Papier `/srv/FreeSynergy/.scratch/plan-theme-bruecke.md` Abschnitt 11 und 12)
- [ ] **GRUNDSACHE** Theme meldet Vertragsversion und abgedeckte Bausteine (`contract_version`, `covers`), erzeugt/geprüft durch `stil-vollstaendigkeit` [offen, nichts davon belegt gebaut]
- [ ] **GRUNDSACHE** Theme-Auswahl filtert: nur Themes, die alle Bausteine des aktuellen Programms/Frontends vollständig gestalten; ungestalteter Baustein = Theme nicht anwendbar [offen]
- [ ] **GRUNDSACHE** Laufzeitwechsel des Themes außerhalb des Frontends, jedes Theme auf jedes Frontend (nicht „Frontend in Stil“); Blinc-Neuzeichnen zur Laufzeit [nicht belegt, Spike S0]
- [ ] SPÄTER Probe „Theme auf Frontend“ (Bild ändert sich, Struktur nicht) neben `zwei-stile`/Tokenprobe
- [ ] **GRUNDSACHE** Kompatibilität je Programm: Theme nutzbar, wenn es ALLE Bausteine dieses Programms gestaltet (Theme-Vertrag); dasselbe Theme kann für Programm A nutzbar, für B nicht nutzbar sein [Nutzerentscheidung 2026-11-16, offen, nichts belegt gebaut]
- [ ] **GRUNDSACHE** Unvollständige Themes in der Auswahl AUSGEGRAUT (nicht ausgeblendet), nicht wählbar, nicht anwendbar; Tooltip „nicht kompatibel“ plus Liste der fehlenden Bausteine bzw. Teile und Zustände; optional öffnet der Tooltip die Theme-Bearbeitung bzw. den Workflow `alle-themes-erweitern` für genau diese Lücken [offen]
- [ ] **GRUNDSACHE** Test mit Gegenprobe: Theme mit einer Lücke erscheint grau, mit korrektem Tooltip-Text, und lässt sich nicht anwenden; dasselbe Theme bleibt für ein Programm ohne diese Lücke wählbar; vollständiges Theme normal [offen, nichts belegt]
- [ ] **GRUNDSACHE** Begriff „Theme“ statt „Stil“ in Verträgen, Doku und UI-Texten (MF2 de/en: `theme-picker-title`, `theme-incompatible`, `theme-missing-blocks`, `theme-missing-parts`, `theme-disabled-hint`); Plan `/srv/FreeSynergy/.scratch/plan-begriff-theme.md` (fs-components: 5 Dateien, 14 Zeilen) [offen, nach Tag fs-release v0.0.7 über `umbenennen` + `doku-mitziehen`]
- [ ] SPÄTER Offene Fragen: Format und Ort der Theme-Meldung; Verhalten bei aktivem Theme, wenn ein Programm einen neuen Baustein bekommt [offen, Strategie]
- [ ] SPÄTER Nachtrag 2 zu ADR 0074 (Strategie schreibt; Entwurf im Papier Abschnitt 12)

## Bausteine, Folgepunkte
- [ ] SPÄTER Signal statt Abfrage alle 200 ms für Menü „Seite“ (Folgepunkt 0.0.11)
- [ ] SPÄTER Namensdialog und Frage als eigene Bausteine mit Zeile für den Grund, Fokusring (Folgepunkt 0.0.12; die Kopie in fs-wiki fällt dann weg)
- [ ] SPÄTER Brotkrume nennt Ordner mit Titel statt Pfadwort
- [ ] SPÄTER `RichTextEditor` (Ansicht mit fertiger Formatierung statt Markdown wie getippt), schwebendes Blockmenü mit Overlay-Schicht, Rücktaste fügt in Liste oder Tabelle darüber an
- [ ] SPÄTER Titel fett (Blinc `text_input` ohne Gewicht, Anfrage an Blinc per git-bug)
- [ ] SPÄTER Icon-Namen: Abgleich der 47 Glyphen mit fs-icons (`.scratch/icon-namen-abgleich.md`, Entscheidung offen)
