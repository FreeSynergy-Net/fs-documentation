# 0086 – Gespeichert wird typisiert: kein JSON, kein Blob; nur Empfangenes behält sein Original

Status: akzeptiert (Nutzer, 2026-11-15) · präzisiert ADR 0020 (Speicherformat), 0030 (Original + Hülle), 0042 (Datenbank ist die Wahrheit) · baut auf ADR 0085 (Normalisierung an der Grenze), 0073 (wirklich löschen)

## Kontext
- ADR 0020 legt die AS2-Hülle in Spalten. Wie der **Inhalt**, also der Fachstandard, gespeichert wird, sagt es nicht.
- Ist-Stand in fs-objects (Schema v4, `crates/fs-objects/src/turso/schema.rs`, Stand 2026-11-15):
  - Die Hülle liegt in Spalten (`type`, `attributed_to`, `published`, `start_time` …).
  - Der Fachinhalt (JSContact, JSCalendar …) liegt aber als **JSON-Text** in `content`.
  - Ebenso als JSON-Text liegen `addressing`, `sensitive` und die Aktivitäts-`payload`.
  - Suchfelder stehen in `index_fields` als Paare aus Schlüssel und Wert. Alle Werte sind dort `TEXT`, deshalb lassen sich Datum und Zahl nicht richtig vergleichen oder sortieren.
- Nutzer (2026-11-15): Daten dürfen nicht als JSON oder Blob gespeichert werden. Sie müssen als durchsuchbare primitive Datentypen vorliegen.

## Entscheidung
1. **Jeder Fachstandard wird in typisierte Tabellen zerlegt.** Jedes Feld bekommt eine eigene Spalte mit primitivem Typ:
   - Ganzzahl, Kommazahl, Text, Ja/Nein;
   - Zeitpunkt in UTC als Ganzzahl, dazu eine Spalte mit der IANA-Zone, wo nötig (ADR 0085);
   - Datum ohne Uhrzeit;
   - Verweis (Id, z. B. `PersonRef`, ADR 0085).

   Listen und Unterobjekte bekommen eigene Untertabellen mit Fremdschlüssel. Beispiele: Teilnehmer, Telefonnummern, Erinnerungen, Wiederholungsregeln.
2. **Auch Adressierung (`to`/`cc` …), Schutzangaben und das Aktivitätsprotokoll werden typisiert.** Adressierung und Schutzangaben bekommen Tabellen. Eine Aktivität verweist auf die geänderten Felder, das heißt: Feld, alter Wert, neuer Wert, typisiert.
3. **Keine JSON- und keine Blob-Spalten für eigene Daten.** JSON gibt es nur an der Grenze, als Austauschformat (Import und Export, ADR 0046/0085), nie im Speicher.
4. **Einzige Ausnahme: das Original von Empfangenem** (ADR 0030). Gemeint ist, was von außen kommt: Mail (MIME), Rechnung (z. B. XRechnung/ZUGFeRD), iTIP-Einladung, vCard-Import, Matrix-Ereignis.
   - Es bleibt unverändert als Beleg „so kam es an“. Gründe: Aufbewahrungspflicht (GoBD), prüfbare Signaturen, späteres Neu-Einlesen mit einem besseren Umwandler.
   - **Gesucht und geändert wird nie im Original**, immer nur in den typisierten Tabellen. Eine Änderung durch Menschen betrifft nur die Tabellen. Das Original bleibt der Beleg des Empfangs.
   - **Jede Art hat eine Aufbewahrungsregel**, danach wird das Original gelöscht (ADR 0073). Rechnungen: gesetzliche Frist, 8 oder 10 Jahre je nach Beleg; die genaue Frist wird bei der Umsetzung belegt. Mail: zusammen mit der Mail. vCard-Import: nach erfolgreichem Import, sofern die Menschen nichts anderes wählen.
   - Das Original darf als Datei außerhalb der Datenbank liegen (fs-files) und wird dann nur per Verweis mit Prüfsumme geführt.
5. **Felder, die wir noch nicht kennen,** landen nicht in einem JSON-Rest. Sie bleiben im Original, falls es eines gibt. Sonst wird beim Import gemeldet, dass sie fehlen, und ein Schema-Update folgt.

## Folgen
- fs-objects bekommt ein neues Schema (v5) mit Migration. Bestehende `content`-JSON-Werte werden in die Tabellen zerlegt, und ein Rundlauftest zeigt, dass nichts verloren geht. `index_fields` entfällt oder wird typisiert.
- Jede Domäne beschreibt ihre Tabellen in `data/<domain>/technical.md`, abgeleitet aus dem Fachstandard.
- Der Workflow `programm-neu` erhält einen Prüfschritt: keine JSON- oder Blob-Spalte außer `original`.
- Reihenfolge: Umbau nach der Frontend-Runde (Woche ab 2026-11-16). Bis dahin wird das Schema nicht verändert.

## Nachtrag (Nutzer, 2026-11-15, aus dem Plan der neuen Programme)
- **Ausnahme 2, Chiffrat:** Ein als verschlüsselt markiertes Feld (ADR 0067) liegt als Bytes. Die Struktur steht typisiert in Spalten (`alg`, `nonce`, `key_ref` …), nur der verschlüsselte Inhalt sind Bytes.
- **Loro (ADR 0073):** Die typisierten Tabellen sind die Wahrheit. Loro dient nur dem Abgleich und wird nicht als zweite Wahrheit gespeichert.
- **Medieninhalt** (Pixel, Samples, Videobilder, 3D-Puffer) liegt als Datei in fs-files, in offenen Formaten: Video AV1 (WebM), Bilder AVIF, Audio FLAC (verlustfrei) bzw. Opus (verlustbehaftet), 3D glTF. In den Tabellen steht nur ein `FileRef` mit Prüfsumme. Die Crate-Angaben werden noch belegt geprüft.
- **Geld** ist eine Ganzzahl in der kleinsten Einheit, dazu Währung (ISO 4217) und Skala. Nie eine Kommazahl.

## Nachtrag (Strategie, 2026-11-16, Schärfung der Aufbewahrungsfrist)
- Zur Zeile „8 oder 10 Jahre je nach Beleg“ (Abschnitt Original): **Buchungsbelege 8 Jahre** (Rechnung, Quittung), **Bücher und Abschlüsse 10 Jahre**, **Handels- und Geschäftsbriefe 6 Jahre**, jeweils **ab Schluss des Kalenderjahrs** (HGB § 257 Abs. 4 und 5, AO § 147 Abs. 3; gelesen am 2026-11-16 auf gesetze-im-internet.de). Das ist die Voreinstellung, der Mensch kann sie ändern; näheres in ADR 0085 Abschnitt 4. Keine Rechtsberatung.

## Nachtrag (Nutzer, 2026-11-16, Entscheidung 53: Ausnahme 3, eng)
Blob-Felder sind nur in drei benannten Fällen erlaubt (das **ändert Entscheidung Nr. 3 und Nr. 4**; Nr. 4 hieß bisher „Einzige Ausnahme“), jeweils mit `exception`-Kennzeichnung im Schema (Kommentar nennt den Grund):
1. **Erste Ausnahme, Original von Empfangenem** (Entscheidung Nr. 4 oben): im v5-Entwurf `object_original.bytes` (die Tabelle steht im Text dieses ADR noch nicht, nur im v5-Entwurf).
2. **Zweite Ausnahme, Chiffrat** (Nachtrag 2026-11-15): der verschlüsselte Inhalt eines als verschlüsselt markierten Feldes (ADR 0067), Struktur typisiert.
3. **Dritte Ausnahme, Abgleichs-Puffer** `collab_buffer.loro` (ADR 0073, Nachtrag 2026-11-16, Entscheidung 3): eine eigene, mit dem Dokument 1:1 verknüpfte Tabelle `collab_buffer` mit typisierten Kopf-Spalten (`doc_id`, `epoch`, `schema_version`, `table_rev`, `updated_at`; Peer-Liste und Versionsvektor in der Untertabelle `collab_buffer_peer`: Geräteschlüssel, Zähler) und **einem** Blob-Feld. Eng gefasst:
   - nur für **Fließtext**, nie für strukturierte Felder;
   - **nie durchsucht**, Suche und Abfragen laufen auf den Tabellen (`text`, `text_mark`);
   - **jederzeit aus `text`/`text_mark` neu baubar**; **nur bei Änderung geschrieben**;
   - **Versionsfeld** (`schema_version`, `epoch`): bei Fehler oder besserer typisierter Form wird die Version geändert und korrigiert, der Puffer neu gebaut;
   - **Kennzeichnung** im Schema (`exception`/Kommentar);
   - **Test:** Neubau aus den Tabellen ergibt den gleichen Text; **Verlust des Puffers ist kein Datenverlust** (nur das Offline-Mischen weicht auf „Text als Ganzes ersetzen + Konflikt anzeigen“ aus).
   Eine mögliche spätere typisierte Form (Op-Verlauf als Tabelle) ist in ADR 0073, Offen 3, beschrieben. Die Zeile „Loro … nicht als zweite Wahrheit gespeichert“ im Nachtrag 2026-11-15 bleibt richtig: der Puffer ist keine Wahrheit.
Der Workflow-Prüfschritt „keine JSON- oder Blob-Spalte außer `original`“ kennt damit zusätzlich Chiffrat und `collab_buffer.loro`.

**Folgen (kein Blocker):** Die Prüfungen, die wirklich laufen, kennen den Puffer noch nicht und schlagen bei `collab_buffer` an; sie sind anzupassen: `speicher-check` in `fs-release/workflows/programm-neu.yaml` (Z. 300) und `programm-grundgeruest.yaml` (Z. 281) sowie R14 und §2.4 (Z. 293) in `fs-objects/docs/v5-entwurf.md` (dort steht nur „object_original.bytes + CIPHER“).

**Offen / Hinweis:** `_nonce` ist im v5-Entwurf vom Typ BLOB; laut diesem ADR ist nur das verschlüsselte Inhalts-Bytefeld eine Ausnahme. Nonce typisieren oder als Teil des Chiffrats ausdrücklich benennen. [offen]

## Nachtrag (Strategie, 2026-11-16, Vorgabe d3: Wortlisten als Wort-Tabellen)
**Kontext**
- Der v5-Entwurf (`fs-objects/docs/v5-entwurf.md`, Abschnitt 2.1) beschreibt Wortmengen als `ENUM(a,b,..)`, also `TEXT` mit `CHECK (x IN ('a','b',..))`. Beispiele aus den Programmen: `purpose`, `origin`, `doc_kind`.
- Jede Änderung der Wortliste ändert den `CHECK`. SQLite ändert ihn nicht per `ALTER TABLE`; der Migrator baut die Tabelle neu. Die Fingerabdruck-Prüfung der v5-Schicht meldet dann `StepMismatch` gegen den eingefrorenen Schritt (Opus-Review fs-people Etappe 2a, Befund Umbaurisiko). Jedes neue Wort würde so einen Tabellen-Neuaufbau auslösen.
- Der Nutzer will die Zweck-Liste editierbar haben: eigene Zwecke neben den eingebauten.

**Entscheidung**
1. **Jede offene Wortmenge bekommt eine eigene Wort-Tabelle**, mit Domain-Präfix des Programms, z. B. `people_word`. Spalten: `kind TEXT` (welche Wortmenge, z. B. `purpose`), `code TEXT` (das Wort), `builtin INTEGER` (0 oder 1, mit `CHECK (builtin IN (0,1))`), `label TEXT NULL` (Anzeigetext), `sort INTEGER NULL` (Reihenfolge), `active INTEGER` (0 oder 1). Schlüssel `(kind, code)`.
2. **Nutzspalten verweisen per Fremdschlüssel** auf die Wort-Tabelle, statt eine Wortliste im `CHECK` zu tragen. Der Schlüssel ist zusammengesetzt aus `kind` und `code`, siehe Offen 1.
3. **Eingebaute Wörter** (`builtin = 1`) setzt das Programm per INSERT-Schritt. Sie sind nicht löschbar.
4. **Eigene Wörter** (`builtin = 0`) sind vom Nutzer editierbar: anlegen, Anzeigetext ändern, `active` setzen.
5. **Ein neues eingebautes Wort ist ein neuer Schritt (INSERT)**, kein Tabellen-Neuaufbau.
6. **`CHECK` bleibt nur für echte Bereichs- und Konsistenzregeln** (Zahlenbereiche, Paarbildungen wie bei `WHEN`). Er gilt **nie für offene Wortmengen**.
7. **Ausnahme:** geschlossene, rein technische Zustände, die der Code erschöpfend kennt, dürfen `CHECK IN` behalten, z. B. Status-Maschinen oder `object_origin.channel` (Trait `OriginChannel`, sieben Glieder). Ändert sich so ein Wert, ändert sich der Code; dann gilt der Schritt mit Fingerabdruck.

**Folgen**
- fs-people: STEP_1 nach der Trait-Runde einmal neu fassen (`people_word` statt `CHECK IN` auf die Zweck-Liste). Das geschieht vor dem ersten Lauf des Schritts.
- Prüfer: die Regel „kein `CHECK IN` auf offene Wortmengen“ kommt als Folgelauf in check-rust-rules bzw. in den Registry-Test. Dieser Nachtrag führt sie noch nicht ein.
- v5-Entwurf: Abschnitt 2.1 (`ENUM`) und 2.4 an diese Regel anpassen. Das ist ein Folgelauf in fs-objects, nicht Teil dieses Commits.

### Offen
1. **Fremdschlüssel:** Der v5-Entwurf belegt Fremdschlüssel in SQLite (Abschnitt 8: `PRAGMA foreign_keys = ON` je Verbindung, R4). Nicht geprüft ist, ob die Registry Fremdschlüssel zwischen eigenen Domain-Tabellen zulässt; dort ist `REF` nur als Fremdschlüssel auf `objects(id)` beschrieben. Der zusammengesetzte Schlüssel `(kind, code)` ist ungeprüft. Alternative: je Wortmenge eine eigene Tabelle mit einfachem Schlüssel `code`.
2. **Lösch- und Umbenennregeln eigener Wörter** (`builtin = 0`): ob ein Wort mit Nutzzeilen nur auf `active = 0` gesetzt werden darf, und wie eine Umbenennung die Nutzzeilen mitnimmt.
3. **Lokalisierung** der Anzeigetexte (`label`): nach ADR 0057 mit MF2, nicht mit Fluent.
4. **Gemeinsame Wort-Tabelle** für mehrere Programme (z. B. `purpose` in people und calendar): dann entfällt der Domain-Präfix, oder es gibt eine Ausnahme.
