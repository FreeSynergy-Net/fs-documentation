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
