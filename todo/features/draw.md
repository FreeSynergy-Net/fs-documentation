# Feature-Liste: PROGRAMM draw (fs-draw)

Stand 2026-11-16, Workflow grundfassung (von Hand, Sonnet), Entwurf; Ablage später in fs-documentation `todo/features/draw.md` durch b7 bzw. den Workflow feature-liste (jetzt NICHT gepusht). Feature-Freeze: offen (Nutzer). Nur Deutsch: todo/ wird nicht übersetzt (ADR 0011).

Stand: 2026-11-16 · Regel [FEATURE-LISTE]: vollständige Liste aller Funktionen der Vorbilder, sortiert, mit Stufe heute / als Nächstes / später.
Vorbilder (Dossiers in fs-documentation `docs/de/programs/apps/draw/frontends/<x>/latest/features.md`, nichts kopiert, ADR 0013): Excalidraw, tldraw, draw.io (diagrams.net), Miro, Mural, OpenBoard; internes Strang-D-Dossier (nicht im Repo) (Inkscape, Figma, Affinity Designer, VectorCraft). Quellenangaben stehen in den Dossiers, hier keine neue Recherche.
Zustand bei uns: fs-draw v0.0.1 (Tag) = Kern `fs-draw-core` (104 Tests); Grundfassung 0.0.2 (Zweig unreviewed/grundfassung-draw): Server, Client, Frontend `simple` (Fenster ohne Zeichenfläche), Starter `fs-draw`. Vertrag `whiteboard.capnp` (Entwurf, vorläufig), Daten-Standard: SVG (Export), AS2-Hülle (`Collection`, Elemente als eigene Objekte).
Legende: `[x]` gebaut (Kern oder Grundfassung, auch wenn das Fenster es noch nicht zeigt) · `[ ]` offen · Stufe: heute = geht im Programm (auch nur Kern/Server) · als Nächstes = Plan der folgenden Versionen · später = benannt, noch nicht geplant · Priorität: hoch = Pflicht/Kern; mittel = verbreitet; niedrig = Nische (Vorschläge der Recherche, nicht beschlossen).
Format je Zeile: Feature — Vorbilder — Stand bei uns — Stufe — Priorität — Nutzen.

## Grundfassung (Programm selbst)

- [x] Fenster mit Name, Symbol-Platzhalter, „Was kommt“ — alle Programme der Suite — gebaut: `fs-draw-simple` — Stufe: heute — hoch — Man sieht, was das Programm ist und was noch fehlt.
- [x] Starter `fs-draw` (Server sichern, Frontend starten, Rückfall bei falschem Vertrag mit Meldung) — ADR 0063/0094 — gebaut — Stufe: heute — hoch — Ein Befehl; kein stilles Scheitern.
- [x] Server `fs-draw serve` (Unix-Socket, Version/Vertrag-Handshake, Boards listen/anlegen/umbenennen/löschen) — — gebaut — Stufe: heute — hoch — Engine und Frontend getrennt (ADR 0021).
- [x] `--version`, `--help`, unbekannte Option Exit 2 — — gebaut — Stufe: heute — hoch — Release-Rauchtest.

## Fläche, Seiten, Ansicht

- [x] Mehrere Tafeln (Boards) verwalten — Excalidraw (Szenen), tldraw, Miro (Boards), OpenBoard (Tableaux) — gebaut: Kern + Server (listen/anlegen/umbenennen/löschen) — Stufe: heute — hoch — Eine Tafel je Thema.
- [x] Mehrere Seiten je Tafel — tldraw, draw.io (Tabs), OpenBoard — gebaut im Kern (`page.add/remove`, Reihenfolge), Fenster fehlt — Stufe: heute — hoch — Tafel in Abschnitte teilen.
- [ ] Unendliche Fläche ansehen (Verschieben, Zoomen, Hand-Werkzeug) — alle — offen (Kern liefert Grenzen `bounds` und Sichtbereich-Abfrage) — Stufe: als Nächstes — hoch — Grundlage jeder Zeichenfläche.
- [ ] Zoom an Auswahl / alles zeigen — tldraw (`zoomToFit`), Excalidraw — offen — Stufe: als Nächstes — mittel — Orientierung.
- [ ] Raster, Einrasten, Hilfslinien, Ausrichtungslinien — draw.io, Excalidraw, Inkscape, Figma — offen — Stufe: später — mittel — Saubere Anordnung.
- [ ] Lineale und Seitenränder — Inkscape, draw.io — offen — Stufe: später — niedrig — Maßgenau arbeiten.
- [ ] Hell/Dunkel-Ansicht der Fläche — Excalidraw, draw.io — Fenster folgt dem Theme (fs-components) — Stufe: als Nächstes — mittel — Lesbarkeit.
- [ ] Nur-Lesen-Modus — tldraw (`readonly`), Miro — offen — Stufe: später — mittel — Ansehen ohne Ändern.

## Zeichnen (Elemente)

- [x] Rechteck, Ellipse, Raute — alle — gebaut im Kern (`ShapeKind`), Fenster fehlt — Stufe: heute — hoch — Grundformen.
- [x] Linie und Pfeil, Verbinder mit Beschriftung und Pfeilspitze — Excalidraw, tldraw, draw.io — gebaut im Kern (Connector, Enden an Elementen oder frei) — Stufe: heute — hoch — Beziehungen zeigen.
- [x] Text, Notiz auf farbiger Form, Beschriftung an Form — alle — gebaut im Kern (`text`, `note`, `label`) — Stufe: heute — hoch — Gedanken festhalten.
- [x] Freihand-Stift mit Druckwerten — Excalidraw (`freedraw`), tldraw, OpenBoard, Inkscape — gebaut im Kern (`stroke`, ≤ 100 000 Punkte) — Stufe: heute — hoch — Skizzieren, Tablet/Stift.
- [x] Bild (Verweis auf Datei, `files.capnp`) — Excalidraw, tldraw, Miro, OpenBoard — gebaut im Kern (IRI), Einfügen fehlt — Stufe: heute — mittel — Fotos und Skizzen auf der Tafel.
- [x] Rahmen („frame“, benannte Fläche) — Excalidraw, tldraw, Miro — gebaut im Kern (`area`, Gruppe) — Stufe: heute — mittel — Bereiche abgrenzen, Export-Zuschnitt.
- [ ] Haftnotizen in mehreren Farben (Post-it) — tldraw, Miro, Mural — Kern hat `note`, Farbwahl im Fenster fehlt — Stufe: als Nächstes — hoch — Workshop-Karten.
- [ ] Werkzeug-Sperre (Werkzeug bleibt aktiv) — Excalidraw (`Q`) — offen — Stufe: später — niedrig — Mehrere Formen hintereinander.
- [ ] Radierer — Excalidraw, tldraw, OpenBoard — Kern hat `stroke.erase`/Löschen, Werkzeug fehlt — Stufe: als Nächstes — mittel — Striche wegnehmen.
- [ ] Einbettungen (Webseite/Video als Element) — Excalidraw (`embeddable`), tldraw (embed, bookmark), OpenBoard (Browser) — offen — Stufe: später — niedrig — Inhalt von außen auf der Tafel.
- [ ] Tabellen, Mindmap-/Organigramm-Automatik — Miro, draw.io — offen — Stufe: später — niedrig — Ordnungsarbeit abnehmen.
- [ ] Pfadbearbeitung (Knoten, Pathfinder, Shape Builder) — Inkscape, Figma, Affinity, VectorCraft — offen; Anbindung der craft-Crates später per Wrapper (kein Fork) — Stufe: später — niedrig — Vektorzeichnen im engeren Sinn.
- [ ] Handgezeichneter Stil (Rauheit, Schraffur) — Excalidraw — offen — Stufe: später — niedrig — Skizzenlook.

## Auswählen und Ändern

- [ ] Auswählen (Klick, Gummiband, Mehrfachauswahl) — alle — offen (Abfrage „was liegt im Bereich“ im Kern) — Stufe: als Nächstes — hoch — Grundlage jeder Bearbeitung.
- [x] Verschieben, Größe ändern, Drehen — alle — gebaut im Kern (`move`, `setFrame`, `rotate`) — Stufe: heute — hoch — Elemente anordnen.
- [x] Farben, Füllung, Linienstärke, gestrichelt, Deckkraft, Schrift — alle — gebaut im Kern (`Style`, `setStyle` je Eigenschaft) — Stufe: heute — hoch — Aussehen steuern.
- [x] Gruppieren / Gruppe lösen — alle — gebaut im Kern (Zyklen verweigert) — Stufe: heute — hoch — Zusammengehörendes bewegen.
- [x] Kopieren (Duplizieren mit Versatz) — alle — gebaut im Kern — Stufe: heute — mittel — Wiederholen.
- [ ] Ausschneiden, Einfügen aus Zwischenablage — alle — offen — Stufe: als Nächstes — mittel — Austausch mit anderen Programmen.
- [x] Ausrichten und Verteilen — tldraw, draw.io, Figma — gebaut im Kern (8 Arten) — Stufe: heute — mittel — Ordnung.
- [x] Sperren (Element gegen Bearbeitung) — tldraw, Excalidraw, Figma — gebaut im Kern — Stufe: heute — mittel — Hintergrund fixieren.
- [x] Ebenen: nach vorne/hinten — tldraw, Figma, Inkscape — gebaut im Kern (`order`-Schlüssel, `reorder`) — Stufe: heute — mittel — Überdeckung steuern.
- [x] Rückgängig/Wiederholen je Person (nur eigene Schritte) — alle (bei uns zusätzlich: überspringt fremd geänderte Eigenschaften) — gebaut im Kern, Grenze 64 MiB — Stufe: heute — hoch — Fehler zurücknehmen ohne fremde Arbeit zu zerstören.
- [ ] Pfeile folgen den Formen beim Verschieben — Excalidraw, tldraw (Bindings), draw.io — Kern: Enden an Elementen bleiben am letzten Rahmen; im Fenster offen — Stufe: später — mittel — Diagramme bleiben heil.
- [ ] Tastenkürzel (V, H, R, O, A, L, T, P, E, Strg+Z …) — Excalidraw, tldraw, Figma — offen; Kürzelliste nach Menüvergleich — Stufe: als Nächstes — hoch — Schnelles Arbeiten.
- [ ] Kontextmenü auf Elementen und Fläche — draw.io, tldraw, Figma — offen — Stufe: als Nächstes — mittel — Funktionen finden.

## Dateien, Import, Export

- [x] Eigenes Format (JSON) lesen/schreiben, fremdes Original wird erhalten — — gebaut im Kern (Import ≤ 32 MiB) — Stufe: heute — hoch — Tafel sichern und weitergeben.
- [x] Export als SVG (Standard: W3C SVG) — Excalidraw, tldraw, draw.io — gebaut im Kern (`board.export`), Menüpunkt im Fenster gesperrt „kommt noch“ — Stufe: heute — hoch — Offenes Format, weiterverwendbar.
- [ ] Tafel öffnen/speichern im Fenster (Datei wählen mit Dateiwähler) — alle — offen — Stufe: als Nächstes — hoch — Ohne das ist das Programm kein Werkzeug.
- [ ] Automatisch speichern — tldraw, draw.io — Server speichert im Objektspeicher; Fenster-Anbindung offen — Stufe: als Nächstes — mittel — Nichts geht verloren.
- [ ] Zuletzt geöffnet — Inkscape, draw.io — offen — Stufe: später — niedrig — Schnell zurück.
- [ ] Export nur der Auswahl / eines Rahmens — tldraw, Affinity (Slices) — Kern kann Auswahl (`ids`) und Seite — Stufe: als Nächstes — mittel — Teile weitergeben.
- [ ] Export als PNG — Excalidraw, tldraw, draw.io — Kern: ausdrücklich „nicht möglich“ (ADR 0045) — Stufe: später — mittel — Bild für Dokumente.
- [ ] Export als PDF, Drucken — draw.io, OpenBoard — Kern: „nicht möglich“ — Stufe: später — mittel — Papier.
- [ ] Import `.excalidraw` — Excalidraw — offen (Plan: Import geschlossener/fremder Formate nur lesend) — Stufe: später — mittel — Vorhandene Tafeln übernehmen.
- [ ] Import `.drawio` / Visio (VSDX) — draw.io — offen — Stufe: später — mittel — Diagramme übernehmen.
- [ ] Import `.xopp` (Xournal++) und `.obz` (OpenBoard) — Xournal++, OpenBoard — offen — Stufe: später — niedrig — Handschrift-Notizen übernehmen.
- [ ] ODF Draw (`.odg`) lesen/schreiben — Strang-D-Dossier (LibreOffice-Standard) — offen — Stufe: später — niedrig — Büro-Welt.

## Zusammenarbeit

- [x] Änderungen zweier Seiten je Eigenschaft zusammenführen (Reihenfolge egal, ohne Schiedsrichter) — tldraw (Records), Excalidraw (je Element, letzte Version gewinnt) — gebaut im Kern (Eigenschaftstests); nichts sendet noch zwischen Geräten — Stufe: heute — hoch — Alleinstellungsmerkmal, Grundlage der Live-Zusammenarbeit.
- [ ] Live-Zusammenarbeit (Änderungen zwischen Geräten übertragen) — Excalidraw, tldraw, Miro, draw.io — offen („sync“ nicht im Vertrag, Hub liefert nur Aktivitäten anderer Programme) — Stufe: später — hoch — Gemeinsam an einer Tafel.
- [ ] Anwesenheit: farbige Zeiger, Namen, „Folgen“ — Excalidraw, tldraw, Miro — offen (Presence-Schnittstelle fehlt; nie gespeichert) — Stufe: später — mittel — Wer ist wo.
- [ ] Laserpointer — Excalidraw, tldraw — offen — Stufe: später — niedrig — Zeigen ohne Spuren.
- [ ] Teilen mit Menschen und Gruppen, Rechte (Ansehen/Ändern) — Excalidraw (Link), Miro, tldraw — offen (`board.share` nicht im Vertrag; Freigabe über Gruppen von fs-groups) — Stufe: später — hoch — Wer darf was.
- [ ] Kommentare an Elementen — Miro, Figma — offen (`comment.add` nicht im Vertrag; Kommentar-Schnittstelle `comments.capnp` existiert) — Stufe: später — mittel — Rückmeldung ohne die Tafel zu verändern.
- [ ] Versionen/Verlauf einer Tafel, Wiederherstellen — draw.io (Versionen), Miro — Objektspeicher hat Revisionen, Anzeige offen — Stufe: später — mittel — Zurück zum Stand von gestern.
- [ ] Ende-zu-Ende-Verschlüsselung der Live-Verbindung — Excalidraw — offen, Entscheidung später — Stufe: später — niedrig — Privatsphäre.

## Bibliotheken, Vorlagen, Moderation

- [ ] Formbibliotheken (Flussdiagramm, UML, BPMN, Netzwerk, Mockup) — draw.io — offen (`library.*` nicht im Vertrag) — Stufe: später — mittel — Fertige Bausteine.
- [ ] Eigene Formen speichern und wiederverwenden — Excalidraw (Bibliothek), draw.io — offen — Stufe: später — mittel — Eigene Vorlagen.
- [ ] Vorlagen für Tafeln (Retro, Workshop, Customer Journey) — Miro, Mural — offen (`template.*` nicht im Vertrag) — Stufe: später — mittel — Schneller Start.
- [ ] Abstimmen, Timer, Abschnitte (Moderationsablauf) — Miro, Mural (Facilitation) — offen; Abstimmen gehört zu fs-decisions — Stufe: später — niedrig — Workshops leiten.
- [ ] Präsentieren (Seite für Seite, Vollbild) — OpenBoard, Miro — offen — Stufe: später — niedrig — Vor Gruppen zeigen.
- [ ] Unterrichtshilfen (Lineal, Geodreieck, Wecker) — OpenBoard — offen — Stufe: später — niedrig — Schule.
- [ ] Diagramme aus Text (Ablauf-, Sequenzdiagramm) — draw.io (Mermaid), Excalidraw — offen — Stufe: später — niedrig — Schnell skizzieren.
- [ ] Datenanhänge an Elementen (eigene Attribute) — draw.io — offen — Stufe: später — niedrig — Auswertung.

## Schnittstellen und Standards

- [x] Vertrag `whiteboard.capnp` (Entwurf, Eigentümer fs-draw): Wurzel mit Fähigkeiten und Support-Bericht, `Boards`, `BoardEditor` — Excalidraw/tldraw nur als Datenmodell-Vergleich — gebaut; Server trägt `board.create/delete/list`, der Rest meldet „nicht möglich“ (ADR 0045) — Stufe: heute — hoch — Brücke beider Seiten ([BRUECKE-BEIDE-SEITEN]).
- [ ] Server trägt den vollen Vertrag (`board.open`, Elemente hinzufügen, Export …) — — offen; Kern kann es, Verdrahtung fehlt — Stufe: als Nächstes — hoch — Voraussetzung jedes Zeichen-Frontends.
- [ ] Typbeschreibung (`types`, ADR 0066) für ein erzeugtes Frontend — — offen — Stufe: als Nächstes — mittel — Frontends aus der Beschreibung.
- [ ] Vertrags-Sperre (Trait-Fixpunkt) und Vertrag `draw_v1` statt `whiteboard.capnp`-Entwurf — pilot-draw DR1 — offen (Entscheidung Strategie; Release erst nach gesperrtem Trait) — Stufe: als Nächstes — hoch — Release-Bedingung.
- [ ] Geometrie in kurbo-Typen (BezPath/Point/Affine) für spätere Pfadoperationen — VectorCraft (Plan-Hinweis T1) — offen — Stufe: später — niedrig — Anbindung der craft-Crates.
- [ ] Weitere Frontends (Papier-/Whiteboard-Stil, Diagramm-Stil, Admin) — ADR 0094, 0066 — offen; `simple` ist das erste — Stufe: später — mittel — Vier Frontends je Programm.
- [ ] MCP-/Agenten-Steuerung (Menüs, Werkzeuge, Export) — VectorCraft (MCP-Server) — offen, nur über Bot-Platz (ADR 0091) — Stufe: später — niedrig — Agent zeichnet nie ohne Einladung.
