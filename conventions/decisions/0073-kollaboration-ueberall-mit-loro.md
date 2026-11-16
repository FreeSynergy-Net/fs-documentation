# 0073 – Kollaboration überall mit Loro

Status: Entwurf (Strategie, 2026-11-12; Nutzerwunsch „Kollaboration überall“); Code erst nach 3b und Wiki · baut auf ADR 0014 (Standards zuerst, AS2), 0020 (Speicherformat), 0021 (Cap'n Proto), 0042 (Datenbank ist die Wahrheit), 0046 (Speichern ≠ Export), 0050 (Besitzer), 0054 (KI-Teilnehmer), 0059 (iroh), 0067 (Tresor), 0071 (Versionen, Backup), 0072 (Blöcke)

Befund und Quellen: `research/kollaboration.md` (Opus-Empfehlung) und `research/kollaboration-befund.md` (Stand 2026-11-11, Primärquellen: crates.io, npm, GitHub inkl. LICENSE-Dateien).

## Kontext
Mehrere Menschen (und markierte KIs, ADR 0054) sollen **gleichzeitig** am selben Dokument, Board oder Plan arbeiten, auch **offline und ohne Server** (ADR 0059). Dafür braucht es ein CRDT, ein Bild davon, **wer gerade da ist** (Awareness), einen Änderungsstrom und Regeln für Rechte und Löschen.

## Entscheidung (Entwurf)

### 1. Bibliothek: Loro
**Loro** (`loro` in Rust, `loro-crdt` als Wasm aus demselben Kern; Lizenz MIT laut LICENSE-Datei; 1.x, aktiv gepflegt). Gründe:
- **Ein Kern**: Engine (nativ) und Frontends (Wasm) verhalten sich gleich.
- **Blockmodell eingebaut**: `LoroTree` (verschiebbarer Baum) mit Metadaten je Knoten passt zu ADR 0072 (Block mit Id und Metadaten; → ersetzt durch Nachtrag 16.11.: die Blockstruktur läuft feldweise, nur der Fließtext über Loro); Rich Text mit Marken in `LoroText`.
- **Anwesenheit eingebaut** (`EphemeralStore`), **Verlaufskürzung** (`shallow_snapshot`), `checkout`/`fork_at` für Versionen.
- **Transportneutral**: Updates sind Bytes mit Versionsvektoren; sie sind Nutzlast in Cap'n Proto (ADR 0021) und laufen über iroh (ADR 0059).

**Ehrliche Gegenargumente:** Loro ist kein De-facto-Standard (Yjs hat das größere Ökosystem; auch Yjs ist keine formale Norm); kleines Team dahinter. Darum wird das CRDT **hinter einer eigenen Schnittstelle `CollabDoc`** gekapselt (Version gepinnt, ein Ort; wie bei `BackupEngine`, ADR 0071), und der Export in offene Formate geht jederzeit (ADR 0046).
**Dokumentierte Alternative: `yrs`** (MIT, 0.x, Yjs-kompatibel, Wiki.js-Ökosystem); sie wird gewählt, falls Yjs-Kompatibilität schwerer wiegt. **Nicht verwenden:** `y-sync` (Repo archiviert, in `yrs::sync` aufgegangen), `diamond-types` (nur Text, ISC, kein Release seit 2022). Automerge ist nicht gewählt (Blöcke nur als Textmarker, Verlauf ohne Kürzung). → ergänzt durch Nachtrag 16.11.: Loro trägt nur noch den Fließtext; die Blockstruktur wird feldweise abgeglichen, die LoroTree-Begründung gilt dafür nicht mehr.

### 2. Awareness: immer sichtbar, wer da ist
- In jedem gemeinsam bearbeiteten Dokument und Board ist **jederzeit sichtbar, wer gerade darin ist** (Name, Farbe, Gerät, Status aktiv/untätig/abwesend, Ort im Dokument).
- **Cursor und Auswahl anderer sind standardmäßig sichtbar; jeder kann seine eigenen abschalten** (dann zeigt nur noch die Anwesenheit „ist im Dokument“). Es gibt keinen Zwang, den eigenen Cursor zu zeigen.
- Anwesenheit ist **flüchtig** (`EphemeralStore`, Zeitlimit etwa 30 s), wird **nie gespeichert** und läuft **nie im Änderungsstrom**. Jeder Eintrag ist signiert (ADR 0059). Schema siehe `research/kollaboration.md` §4 (Vorschlag, anhängbar).
- KIs erscheinen als **markierte Teilnehmer** (ADR 0054), nie als Mensch.

### 3. Wahrheit
Bei gemeinsam bearbeiteten Objekten ist das **Loro-Dokument (Schnappschuss plus Änderungen) die Wahrheit**. Es liegt im **Store des Besitzers** (ADR 0050); damit gilt **ADR 0042 weiter: die Datenbank hält die Wahrheit**. Task-Objekte und Abfrage-Indizes sind **daraus abgeleitete Projektionen**, nach jedem Merge neu berechnet. JSCalendar und iCal sind **Exporte** (ADR 0046). **Ohne Kollaboration** (rein lokal) ändert sich für den Menschen nichts: es ist ein Loro-Dokument mit einem einzigen Teilnehmer. → ersetzt durch Nachtrag 16.11.

### 3a. Datenmodell
Ein `LoroDoc` je Seite (Wiki, ADR 0072) bzw. je Board/Projekt. Wiki-Seite: `LoroTree` der Blöcke. **Die Block-Id (UUIDv7, ADR 0072) steht als Metadatum am Knoten des Blockbaums; die internen CRDT-Knoten-Ids sind nicht die Block-Id** und werden nie als Verweis nach außen benutzt (sie überleben Export und Import nicht). Speicherformat: Loro-Snapshot als Nutzlast in einer AS2-Hülle (ADR 0020); **Export** (Markdown/HTML/AS2-JSON) ist eine getrennte, verlustbehaftete Projektion. Benannte Stände sind `Frontiers` plus AS2-`Update` (Zusammenspiel mit ADR 0071 Versionen). → ersetzt durch Nachtrag 16.11.

### 4. Änderungsstrom: AS2
Lokale Änderungen werden gebündelt (`set_change_merge_interval`) und als AS2-Aktivität (`Update`, `Create`, `Add`, `Remove`, `Move`) mit `object` = Block-/Task-Id und `attributedTo` = Actor verschickt (ADR 0014/0020). Die CRDT-Bytes sind **Nutzlast**, nicht die Aktivität selbst. → ersetzt durch Nachtrag 16.11.: das gilt nur noch für Fließtext; strukturierte Felder schicken Feld, Wert, Lamport-Zähler, Peer-Id und Basiswert.

### 5. Transport
Cap'n Proto (ADR 0021) als Vertrag, **iroh** (ADR 0059) als Weg zwischen Geräten, über den Hub (`fs-hub`) als Rückfall; kein fremdes Websocket-Protokoll. Der Transport hinter einer Schnittstelle, wie in ADR 0059 vorgesehen.

### 6. Rechte: vor dem Import prüfen
Ein CRDT kennt keine Rechte. Darum: **jede Änderung ist signiert** (ADR 0059), Peer-Id und Identität (Kanidm hinter eigenem Wrapper, ADR 0047) sind fest gebunden. Der Empfänger **prüft „darf dieser Autor das?“ VOR dem Import** (ADR 0050, Gruppen ADR 0055). Eine bereits gemergte unerlaubte Änderung lässt sich nicht sauber zurücknehmen; deshalb wird sie gar nicht erst importiert, abgelehnte Änderungen werden **sichtbar gemeldet**, nicht stillschweigend verworfen. Gruppendaten sind mit dem Gruppenschlüssel verschlüsselt (ADR 0067).

### 7. Löschen: Verlauf standardmäßig voll, „wirklich löschen“ als Pflicht
- **Standard:** der volle Verlauf bleibt (Tombstones), damit Rückgängig und Verlauf funktionieren. **Es gibt keine automatische Kürzung** und keinen Standardwert dafür. Gekürzt wird nur auf **ausdrücklichen Wunsch des Menschen**: über „wirklich löschen“ oder über eine von ihm gesetzte, einstellbare Obergrenze (Dauer oder Größe); danach liegt Älteres nur noch in Sicherungen (ADR 0071).
- **Pflicht „wirklich löschen“** (DSGVO-Recht auf Löschung): auf Wunsch wird der Inhalt **aus dem Verlauf entfernt bzw. der Verlauf neu geschrieben** (`shallow_snapshot` ab dem Zeitpunkt nach dem Inhalt, anschließend alte Verläufe verwerfen).
- **Ehrlicher Hinweis, immer vorher gezeigt:** **Peers, die einen alten Stand haben, können die Daten noch besitzen**; Files kann das auf fremden Geräten nicht erzwingen. Der Dialog nennt, welche bekannten Geräte/Menschen betroffen sind und welche Sicherungen den Inhalt noch halten (ADR 0071, „bleibt in Sicherungen bis …“). Ältere Peers brauchen danach einen vollständigen Snapshot statt inkrementellem Abgleich.

### 8. Aufgaben (Kanban, Plan, Gantt) ohne Schiedsrichter
Ein `LoroDoc` je Board mit Maps und beweglichen Listen (Aufgaben, Spalten, Reihenfolge, Abhängigkeiten), **nicht serverautoritativ** (ADR 0059: kein Moderator). Das CRDT erzwingt keine Invarianten (Zyklen in Abhängigkeiten, WIP-Limits, Karte in zwei Spalten). **Die Engine prüft nach jedem Merge deterministisch, zeigt Konflikte an und bietet eine Auflösung an; sie lehnt nichts still ab.** **Planungsdaten** (frühester Start, Puffer, kritischer Pfad, Gantt-Termine) werden **berechnet statt gespeichert**. Zyklen, die erst **nach einem Merge** entstehen, bekommen `Readiness::Conflict`: sie werden **angezeigt, nicht abgelehnt**. Das Gantt rechnet **nominal** und sagt das **sichtbar** („nominal“); ein Arbeitszeit-Kalender kommt später aus `fs-calendar` **über dessen Schnittstelle**, Tasks hat keinen eigenen Kalender. Lange Beschreibungen sind eigene Wiki-Blöcke. → ersetzt durch Nachtrag 16.11.

### 9. Spike vor dem Festschreiben
Wasm-Größe von `loro-crdt` und Leistung bei großen Seiten/vielen Peers sind **nicht gemessen**. Sobald das Wiki dran ist, läuft ein **kleiner Spike** mit echten Wiki-Seiten (Größe des Wasm-Pakets, Zeit für Öffnen/Merge, Speicher). Fällt er schlecht aus, greift die dokumentierte Alternative `yrs` hinter `CollabDoc`.

## Entwurfsmuster (ADR 0043)
**Adapter/Facade** (`CollabDoc` kapselt Loro), **Observer** (Änderungs- und Anwesenheitsströme), **Strategy** (austauschbarer Transport und CRDT), **Memento** (benannte Stände), **Specification** (Rechteprüfung vor Import als reine Funktion, für sich getestet).

## Risiken
1. **Speicherwachstum** durch vollen Verlauf: Kürzen (`shallow_snapshot`) nur auf Wunsch des Menschen, vorher Sicherung; Anzeige des Platzes (Platz schonen, ADR 0071); Grenze: ältere Peers brauchen einen vollen Snapshot.
2. **Abhängigkeit von einem kleinen Team:** `CollabDoc`, gepinnte Version, offener Export.
3. **Springende Blöcke bei gleichzeitigem Verschieben:** in der Oberfläche kennzeichnen.
4. **Falsche Sicherheit beim Löschen:** darum der ehrliche Hinweis in Punkt 7.
5. **Datenschutz der Anwesenheit:** Cursor abschaltbar, Anwesenheit nie gespeichert.

## Folgen
- `fs-interfaces`: Thema `collab` (Dokument öffnen, Änderungen senden/empfangen, Anwesenheit; Rechteprüfung als Eingang), nach Annahme und 3b. `fs-wiki` und Aufgaben-Programm: Loro hinter `CollabDoc`. Code erst nach Runde 3b grün und nach dem Wiki.
- Entschieden (Strategie): Standard ist der volle Verlauf, ohne automatische Kürzung.

## English summary
**Decision (draft):** Loro (MIT, Rust core plus Wasm) behind our own `CollabDoc` interface; yrs documented as the alternative; `y-sync` and `diamond-types` not used. Awareness is always visible (who is in the document); cursors and selections are visible by default and everyone can turn their own off; presence is ephemeral and never stored. Change stream as AS2 with the CRDT bytes as payload; transport Cap'n Proto plus iroh. Every change is signed and rights are checked before import. History is kept in full by default, with no automatic trimming (only on explicit request or a limit the human sets); "really delete" is mandatory (remove from history / rewrite) with an honest warning that peers holding an old state may still have the data. The Loro document (snapshot plus changes) is the truth for shared objects, held in the owner's store (so ADR 0042 still holds; see the addendum of 2026-11-16: now the typed tables are the truth); task objects and query indexes are projections recomputed after each merge, JSCalendar/iCal are exports; purely local use is a document with one participant. Tasks have no referee: the engine checks cycles and WIP limits after a merge, shows conflicts (`Readiness::Conflict` for cycles created by a merge) and never silently rejects; planning data (earliest start, slack, critical path) is computed, not stored; the Gantt is nominal and says so, a working-time calendar comes later from `fs-calendar` through its interface. The block id (UUIDv7) is metadata on the block-tree node, not the internal CRDT node id. **Superseded in part by the addendum of 2026-11-16:** the typed tables (ADR 0086) are the truth, Loro is only a sync buffer for running text, stored in its own linked table `collab_buffer` (typed header columns plus one blob field, a narrow third exception to ADR 0086; always rebuildable from the tables, never searched, written only on change, versioned), structured fields merge field by field with a Lamport counter (ordered by the pair Lamport, peer id), and the statement "the Loro document is the truth" no longer holds. A small spike measures Wasm size and speed once the wiki is under way. **Status: draft; code only after round 3b and the wiki.**

## Nachtrag 2026-11-16: Papierkorb-Frist

Anlass: Nutzerentscheidung 2026-11-16: „Papierkorb: JA. Nach Ablauf der Frist endgültig löschen. Die Frist wird in den Einstellungen des Programms eingestellt (dort Pflicht). Im Papierkorb steht ‚noch N Tage‘.“ Die Entscheidungen 1 bis 9 bleiben unverändert.

**(1) Was §7 sagte und was jetzt gilt.** §7 hält den Verlauf voll und kennt keine automatische Kürzung. Der Papierkorb ist davon getrennt: Gelöschtes bleibt im Papierkorb und ist bis zum Ablauf wiederherstellbar. Nach Ablauf der Frist wird der Papierkorb endgültig geleert, d. h. das Objekt wird endgültig gelöscht. Die Kaskade nimmt es samt seinem Verlauf (`activity`, `activity_change`) mit; das ist der Purge-Pfad von v4 (`turso/purge.rs:45`) und die Kaskade des v5-Entwurfs (`review-v5-2-opus.md`, Anforderung 4). Der Verlauf-Purge allein (ADR 0029) bleibt davon getrennt.

**(2) Frist einstellbar.** Jedes Programm stellt die Frist in seinen Einstellungen ein; das Feld ist Pflicht. Standardwert: **30 Tage** (Empfehlung der Schicht fs-objects; Vorbild Google, Papierkorb 30 Tage, `pilot-calendar/dossier-google-outlook.md`). Dieser Standardwert gilt nur für den Papierkorb, nicht für die Kürzung des Verlaufs; §7 bleibt dafür unverändert.

**(3) Anzeige und Zeitpunkt.** Im Papierkorb steht bei jedem Eintrag „noch N Tage“ (berechnet aus `purge_after`, v5-Entwurf). Die angezeigte Frist ist eine Zusage: nichts geht früher weg.

### Entschieden

- **Standard 30 Tage, Mindestfrist 1 Tag, keine Höchstfrist.**
- **„Nie automatisch löschen“ ist als Einstellung erlaubt.** Der Nutzer leert dann selbst.
- **Aufbewahrung geht vor der Frist.** Ist eine gesetzliche oder gewollte Aufbewahrung gesetzt (`keep_until`), wird das Objekt nicht automatisch gelöscht; die Anzeige lautet „aufbewahrt bis …“.
- **Beim endgültigen Löschen nach Fristablauf geht der Verlauf des Objekts mit** (Kaskade, Punkt 1).

## Nachtrag 2026-11-16: Wahrheit in typisierten Tabellen, Loro als Abgleichs-Puffer

**(1) Kontext: Widerspruch.** §3 sagt „Das Loro-Dokument (Schnappschuss plus Änderungen) ist die Wahrheit“. ADR 0086 (akzeptiert, Nutzer 2026-11-15) sagt: gespeichert wird typisiert, kein JSON und kein Blob; Loro dient nur dem Abgleich und wird nicht als zweite Wahrheit gespeichert. Beides zugleich gilt nicht. Entscheidung der Strategie (16.11.): **ADR 0086 gewinnt.** §3, §3a und §8 bleiben im Wortlaut stehen und tragen je einen Verweis auf diesen Nachtrag. Die Entscheidungen 1 bis 9 gelten sonst unverändert.

### Entschieden

1. **Die Wahrheit sind die typisierten Tabellen** (ADR 0086). Jedes Feld hat eine Spalte mit primitivem Typ; Listen und Unterobjekte sind Untertabellen mit Fremdschlüssel. Ein Loro-Dokument ist keine Wahrheit mehr.
2. **`CollabDoc` ist die einzige Schnittstelle.** Programme sprechen nur mit `CollabDoc`; Loro liegt dahinter. Ein Wechsel auf `yrs` (Entscheidung 1) bleibt auf diese Schnittstelle begrenzt.
3. **Loro ist Abgleichs-Puffer, gespeichert als dritte Ausnahme zu ADR 0086 Nr. 3 (Nutzerentscheidung 53, Form des Nutzers: Variante (a)).** Offline zusammenführen braucht den gespeicherten Op-Verlauf des Loro-Dokuments. Er liegt in einer **eigenen, verknüpften Tabelle `collab_buffer`** (1:1 zum Dokument):
   - **typisierte Kopf-Spalten:** `doc_id` (Fremdschlüssel, 1:1), `epoch` (Ganzzahl), `schema_version` (Ganzzahl, Format des Puffers), Peer-Liste (Untertabelle `collab_buffer_peer`: Geräteschlüssel, zuletzt gesehener Zähler), `version_vector_at` (Stand, passend zu den Tabellen), `updated_at` (Zeitpunkt UTC, Ganzzahl);
   - **genau ein Blob-Feld `loro`** mit dem Loro-Puffer. Das ist die **Ausnahme**: im Schema mit `exception`-Kennzeichnung und Kommentar versehen (ADR 0086, Nachtrag „Ausnahme 3, eng“).
   - **Eigenschaften:** nur für **Fließtext**; wird **nur bei Änderung geschrieben**; **jederzeit aus `text`/`text_mark` neu baubar** (dann beginnt eine neue Epoche); **nie durchsucht** (Suche und Abfragen laufen auf den Tabellen); gekürzt per `shallow_snapshot` (§7). Er ist keine zweite Wahrheit.
   - **Verlust des Puffers ist kein Datenverlust:** die Tabellen halten alles. Nur das Offline-Mischen weicht aus: der Text wird **als Ganzes ersetzt und der Konflikt angezeigt** (Test (f)).
   - **Versionswechsel-Regel:** Ziel ist, bei einem Fehler oder einer besseren typisierten Form die **Version zu ändern und zu korrigieren**. `schema_version` und `epoch` tragen das; ein Puffer mit unbekannter oder älterer Version wird **nicht migriert, sondern aus den Tabellen neu gebaut** (neue Epoche); Peers auf einer älteren Epoche bekommen das Verhalten „Ersetzen + Konflikt“. Das Schema von `collab_buffer` darf per Migration (ADR 0086, Schema-Version) jederzeit geändert werden.
   - **Spätere Möglichkeit:** typisierter Op-Verlauf als Tabelle, siehe Offen 3.
4. **Rückschreibung nach geprüftem Merge.** Nach jedem Merge, und erst nachdem die Rechteprüfung (§6) bestanden ist, werden die geänderten Felder in einer Transaktion in die typisierten Tabellen geschrieben: ganz oder gar nicht. Ein Merge ohne Rückschreibung gilt nicht als übernommen.
5. **Strukturierte Daten feldweise, mit Lamport-Zähler.** Termine, Aufgaben, Zeichenelemente und andere strukturierte Daten werden feldweise abgeglichen; jede Änderung trägt Feld, Wert, Lamport-Zähler, Peer-Id und **Basiswert** (der alte Wert, aus `activity_change`, ADR 0086 Nr. 2). Gleichzeitige Änderungen desselben Feldes werden angezeigt, nicht still verworfen (wie §8).
   - **Tiebreak:** Ordnung nach dem Paar (Lamport, Peer-Id). Die Peer-Id ist der **Geräteschlüssel** (iroh NodeId, ADR 0059), **byteweise verglichen**, nicht die Person: eine Person mit zwei Geräten offline kann mit sich selbst kollidieren.
   - **Gleichzeitigkeit:** Lamport allein erkennt sie nicht. Passt der Basiswert einer Änderung nicht zum aktuellen Wert (`Basis ≠ aktuell`), wird ein **Konflikt angezeigt** (`Readiness::Conflict`, wie §8). Der Tiebreak bestimmt nur den **vorläufigen Gewinner**; nichts wird still verworfen.
6. **Loro nur für Fließtext.** Der Textinhalt von Blöcken läuft über Loro. Was kein Fließtext ist, auch die Blockstruktur (Id, Eltern, Reihenfolge als Bruchindex (TEXT), Typ, Attribute), wird feldweise abgeglichen.
   - **Grenze Fließtext:** Rich-Text-Marken (fett, Link …) **bleiben im Puffer** (`LoroText`); getrennt in einer Tabelle verlören sie bei gleichzeitigem Tippen ihren Anker. Typisiert zurückgeschrieben werden die Spalte `text` (TEXT, Klartext) und die Untertabelle `text_mark(block_id, start, end, art, wert)`; Offsets zählen in **Unicode-Skalaren**.
   - **Zyklen:** gleichzeitiges Verschieben (Eltern feldweise) kann Zyklen erzeugen (A unter B, B unter A). Sie werden **nach dem Merge erkannt** und mit `Readiness::Conflict` angezeigt (wie §8), nicht abgelehnt; LoroTree nahm das früher ab.
7. **„Wirklich löschen“ läuft über `activity_change` und den Puffer.** Der Inhalt wird aus den Feldänderungen des Verlaufs **und aus dem Loro-Puffer** (`shallow_snapshot` ab dem Zeitpunkt nach dem Inhalt, wie §7) entfernt und der Verlauf neu geschrieben. Der ehrliche Hinweis auf Peers mit altem Stand bleibt. Der Papierkorb-Nachtrag oben bleibt unverändert.
8. **Atomarität.** Puffer-Stand (Versionsvektor) und Tabellen werden in **einer** Transaktion geschrieben. Empfangene Updates bleiben liegen, bis die Transaktion bestätigt ist; nach einem Absturz werden sie neu eingespielt (Loro-Import ist idempotent). Der Sender bekommt die Quittung erst danach.
9. **Puffer gegen Tabelle.** Schreibt jemand an `CollabDoc` vorbei (Import, anderes Programm), **gilt die Tabelle**; der Puffer wird per Versionsvergleich als veraltet erkannt und neu gebaut.
10. **Reihenfolge, kein Widerspruch:** beide Bedingungen gelten. Zuerst das v5-Schema (ADR 0086) nach der Frontend-Runde, danach `CollabDoc`/Loro (nach Runde 3b, Wiki und v5), weil v5 das Ziel der Rückschreibung ist.
11. **Importe, einheitliche Regel (d3, 2026-11-16; gilt für fs-draw, fs-maps, fs-data und künftig alle Programme):** das Original bleibt nach erfolgreichem Import **im Papierkorb-Zeitraum des Programms** (Standard 30 Tage, Einstellung in den Settings, „Originale immer behalten“ wählbar) und wird danach gelöscht; es gibt **kein sofortiges Löschen**. Verweis: `object_original` (v5-Entwurf zu ADR 0086, dort noch nicht im Text) und Papierkorb-Nachtrag oben (§7-Frist).

### Folgen

- **fs-objects Schema v5** mit Migration (ADR 0086). Für **fs-text** und **fs-draw** heißt das Migration v4→v5: Inhalte (fs-texts) und Elemente (fs-draw) liegen heute als JSON-`content` und werden feldweise in Tabellen überführt. Blöcke werden zur Tabelle mit Id, Elternknoten und Reihenfolge; ihr Textinhalt bleibt Fließtext.
- **Tests:** (a) Rundlauf je Programm, v4 JSON nach Tabellen und zurück ohne Verlust, mit eigenen Testdaten für fs-texts und fs-draw; (b) Konflikttests: gleichzeitige Änderung desselben Feldes wird angezeigt, Änderungen an verschiedenen Feldern mischen sich; (c) abgebrochene Rückschreibung hinterlässt keinen Teilstand; (d) unerlaubte Änderung wird vor dem Import abgelehnt und nicht geschrieben; (e) „wirklich löschen“ entfernt den Inhalt aus `activity_change` und dem Puffer; (f) Neustart **mit und ohne** Puffer (ohne: Text als Ganzes ersetzt, Konflikt angezeigt); (g) Tiebreak deterministisch (gleicher Lamport-Wert, Peer-Ids byteweise, gleiches Ergebnis auf allen Peers); (h) Zyklus beim gleichzeitigen Verschieben wird nach dem Merge als `Readiness::Conflict` angezeigt; (i) Absturz vor der Quittung: Update wird neu eingespielt, kein Doppeleffekt; (j) Schreiben an `CollabDoc` vorbei: Puffer wird neu gebaut.
- Umsetzung: Code erst nach Runde 3b und Wiki, und nach dem v5-Schema (Entscheidung 10).

### Offen

1. **Erledigt:** die dritte Ausnahme steht als Nachtrag „Ausnahme 3, eng“ in ADR 0086 (Nutzerentscheidung 53).
2. Ein Peer ändert ein Feld, während ein anderer das Objekt löscht: Vorschlag: anzeigen, das Löschen bleibt im Papierkorb wiederherstellbar. [offen]
3. **Spätere Möglichkeit V3: typisierter Op-Verlauf als Tabelle** statt Blob (Opus-Probe 16.11., `loro =1.17.1`). **Machbar:** `export_json_updates_without_peer_compression` / `import_json_updates` liefern und nehmen Rust-Strukturen (Change, Op); Roundtrip Tabelle, Doc, Tabelle war gleich. Aufwand etwa 5 Agenten-Tage. **Schwächen:** Kürzen nur per Epochenwechsel (neues Doc aus `text`/`text_mark`, alte Op-Zeilen löschen; Loro kennt kein typisiertes Kürzen); Op-Zeilen sind einzeln typisiert, aber nicht für sich lesbar (`pos` gilt relativ zum Stand bei `deps`); mehr Platz (10 000 bis 100 000 Zeilen je 50 Seiten geschätzt); das JSON-Format ist nur rückwärtskompatibel, bei Format 2 braucht es eine eigene Zeilen-Migration, das Binärformat hat dagegen eine Stabilitätszusage seit Loro 1.0. Würde `collab_buffer.loro` ablösen; über die Versionsregel (Entscheidung 3) ohne Bruch möglich. [offen, spätere Wahl des Nutzers]
