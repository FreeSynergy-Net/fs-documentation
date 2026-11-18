# Suche

**Status: Entwurf (2026-11-18).** Zurück zu den [Schnittstellen](index.md). Pflichtkapitel: Jedes Programm, das Suche anbietet, folgt ihm.

Legende: **[B]** = belegt (Quelle genannt), **[V]** = Vorschlag von uns, vom Nutzer noch nicht bestätigt, **[nicht belegt]** = Quelle nicht geprüft. Das Kapitel sagt nur zu, was mit [B] steht; alles andere ist als solches gekennzeichnet.

## Ausgangslage

- Der Wortlaut der „7 Ebenen der Suche“ steht nicht im Repository, nicht in der Historie und nicht in den Notizen [B]. Die sieben Sucharten unten folgen der Erinnerung des Nutzers (2026-11-18); Art 5 und 6 waren vergessen und sind ein **Vorschlag**.
- Grundsätze (Nutzer): **Jedes Programm entscheidet, welche Sucharten es anbietet.** Der Server kann alle Programme fragen (Daten nur nach Rechten), auch externe Programme.

## Die sieben Sucharten

| # | Suchart | Beispiel |
|---|---------|----------|
| 1 | Genaue Suche (sofort, vollständig) | eine Rechnung finden |
| 2 | Langsame offene Suche (bleibt offen, Treffer kommen, wann sie sich melden) | ein Punkt auf der Karte nach drei Wochen |
| 3 | Langsame Suche mit Zeitlimit | Abbruch nach 1 Stunde |
| 4 | Langsame Suche mit Benutzerabbruch | die Person beendet sie |
| 5 [V] | Abbruch nach Anzahl / erstem Treffer | „die ersten 50“, „ein Treffer genügt“ |
| 6 [V] | Unscharfe / Ähnlichkeitssuche | Tippfehler, „klingt wie“ |
| 7 | Ungenaue Suche wie im Web | Abschnitte, „1–20 von ca. 20 000“ |

Art 5 und 6 bleiben Vorschlag, bis der Nutzer sie bestätigt.

## Suchart und Standard

| # | Standard | Quelle | Was fehlt / Erweiterung |
|---|----------|--------|-------------------------|
| 1 | JMAP `Foo/query` mit `filter`, `sort`, `position`, `limit` [B] | RFC 8620 Abschnitt 5.5 | Kein Zeitlimit, kein Abbruch; das Ergebnis kommt komplett oder als Fehler. Lokal: SQLite FTS5 für Volltext (BM25, Präfix, Trigram) [B: Funktionen], Engine-Funktion, kein Protokollstandard; Zeitlimit nur über einen Engine-Hook [nicht belegt]. |
| 2 | JMAP `Foo/queryChanges` (`sinceQueryState`, `maxChanges`) und Push (StateChange) [B] | RFC 8620 Abschnitte 5.6 und 7 | Der Standard kennt **keine** Meldung „Suche läuft noch“; Push meldet Zustandswechsel, keinen Fortschritt. |
| 2 | WebFinger [B]; W3C Linked Data Notifications [B: Status]; ActivityPub [nicht belegt] | RFC 7033; W3C-Empfehlung LDN | WebFinger löst Konten auf, durchsucht aber keine Daten. LDN liefert Benachrichtigungen, ist aber keine Suchabfrage. |
| 3 | Kein Standard gefunden. HTTP `Retry-After` gilt nur für 503/3xx-Antworten, nicht für Laufzeitgrenzen [B] | RFC 9110 Abschnitt 10.2.3 | **Lücke, durch Erweiterung geschlossen** (Entscheid 1 unten). |
| 4 | Kein Such-Standard; JMAP-Anfragen kennen keinen Abbruch [B: RFC 8620 Abschnitt 5.5 enthält keinen]. IMAP: nur durch Verbindungsabbruch [nicht belegt] | RFC 8620 Abschnitt 5.5 | **Lücke, durch Erweiterung geschlossen** (Entscheid 1 unten). |
| 5 [V] | JMAP `limit` (Server darf kürzen und meldet `limit`) [B]; IMAP ESEARCH `RETURN (MIN MAX COUNT)` [B] | RFC 8620 Abschnitt 5.5; RFC 4731; RFC 9051 Abschnitt 7.3.4 | Stoppt nur die Ausgabe, nicht die Suche im Anbieter (Serverseite nicht spezifiziert); ESEARCH hat kein Stopp-Signal. |
| 6 [V] | Unicode Collation (UCA, UTS #10 Rev. 55) für Sortier-/Vergleichsschlüssel [B] | UTS #10 | UCA ordnet, misst aber keine Ähnlichkeit. Soundex, Metaphone, Levenshtein: keine ISO/IETF/W3C-Norm bekannt [nicht belegt]. |
| 7 | OpenSearch 1.1: `totalResults`, `startIndex`, `itemsPerPage` [B: Entwürfe 5 und 6, kein offizieller Stand] | GitHub dewitt/opensearch | Beschreibt Felder, nicht die Zählart; „ca.“ fehlt. JMAP `calculateTotal` ist exakt oder gar nicht [B]. Ungefähre Zählung (Elasticsearch `track_total_hits`) [nicht belegt: Quelle nicht abrufbar]. |
| - | CalDAV `calendar-query` REPORT [B]; CardDAV `addressbook-query` [B] | RFC 4791 Abschnitt 7.8; RFC 6352 Abschnitt 8.6 | Zeitraum- und Feldfilter, keine Volltextsuche; Kürzung über `DAV:number-of-matches-within-limits` (RFC 6352 Abschnitt 8.6.2) [B]. |
| - | IMAP SEARCH [B] | RFC 9051 Abschnitt 6.4.4 (ersetzt RFC 3501) | Nur Mail-Kriterien, kein Zeitlimit. |
| - | SPARQL 1.1 Query [B] | W3C-Empfehlung, 2013-03-21 | Kein Protokoll für Zeitlimit, Abbruch oder Teilergebnisse. |

## Entscheide (Nutzer, 2026-11-18)

1. **Zeitlimit und Abbruch (Art 3 und 4) sind eine Erweiterung von JMAP**, keine freie Eigenlösung. Regel: erst an den Standard halten, mit Beleg erweitern. Der Beleg „kein Standard“ steht oben. Die Erweiterung: ein **Parameter Zeitlimit** und ein **Befehl `cancel`** an `/query` bzw. an die offene Suche. Sie kommt in die Liste des Standards-Moduls (`fs-texts`) und wird später eingereicht. Der Erweiterungsmechanismus von RFC 8620 (Abschnitt 11) ist noch nicht geprüft [nicht belegt].
2. **Die offene Suche (Art 2) hat Pflicht-Regeln:**
   - nur **mit Einwilligung der Gefundenen** (Selbstbestimmung über Daten);
   - die **Laufzeit ist immer sichtbar**;
   - sie ist **jederzeit beendbar**.
3. **Art 5 und 6 bleiben als [V] gekennzeichnet**, bis der Nutzer sie bestätigt (5 = Abbruch nach Anzahl / erster Treffer, 6 = unscharfe / Ähnlichkeitssuche).
4. **„Sucharten im Vertrag erklären“** und **„Server-Fan-out mit Rechten“** sind Vorschläge ([V], unten). Ein ADR folgt erst, nachdem der Nutzer sie gelesen hat.

## Vorschlag: Der Vertrag erklärt die Sucharten [V]

Der Vertrag jedes Programms bekommt ein Feld `search` (Liste der Arten), zum Beispiel:

```
search = [
  { kind = "exact" },
  { kind = "open-slow", push = true },
  { kind = "timed", limit_seconds = 3600 },
  { kind = "cancelable" },
  { kind = "limited", max_results = 50 },
  { kind = "fuzzy", algorithm = "uca-collation" },
  { kind = "approximate-count", count = "exact|approx" },
  { kind = "paged", page_size = 50 }
]
```

- Parameter je Art: Zeitlimit (Sekunden), Seitengröße (JMAP `limit`), Zählart (`exact` = JMAP `calculateTotal`; `approx`: [nicht belegt]).
- Fehlt eine Art, sagt das Programm es ausdrücklich (`supported = false`), nie still ausgegraut (Regel fehlende Datenquelle).

## Vorschlag: Der Server fragt alle Programme (Fan-out) [V]

1. Der Server nimmt einen Suchauftrag `{query, kinds, limit, timeout}` entgegen und prüft die Rechte der Person (ADR 0050, 0029 laut Bezug in ADR 0067).
2. Je Programm eine Anfrage nach dem Vertrag oben, nur für Arten, die das Programm angibt.
3. Antwort je Programm als `query`-Ergebnis (position/limit); Änderungen kommen über `queryChanges`/Push (offene Suche).
4. Zusammenführen: Rangfolge nach Treffer-Score je Programm, dann Herkunft; eine Summe nur mit `approx` oder mit dem Vermerk „unvollständig“.
5. Externe Programme: über dieselbe Standard-Schnittstelle (JMAP-Adapter oder OpenSearch-Beschreibung), mit eigenem Rechte-Schlüssel.
6. **Tresor: nur blinder Index** (HMAC, ADR 0067), kein Klartext-Index beim Server; Suche über verschlüsselte Felder bleibt Aufgabe des Geräts.
7. Zeitlimit und Abbruch: Der Server setzt eine Frist und sendet `cancel` an die Programme; Teilergebnisse werden als `partial` markiert.

## Unsere Stellen

| Stelle | Aussage [B] |
|--------|-------------|
| `conventions/decisions/0070-thema-storage.md`, Zeile 145 („Riesige Bäume“) | `list` nur eine Ebene mit Cursor; Suche im Anbieter (Flag `search`) |
| `conventions/decisions/0067-tresor-und-verschluesselung.md`, Zeilen 23–43 | Suche über verschlüsselte Daten ist Aufgabe des Geräts; blinder Index (HMAC) für exakte Suche |
| `conventions/decisions/0086-gespeichert-wird-typisiert.md`, Zeile 52 | Suche und Abfragen laufen auf den Tabellen (`text`, `text_mark`); der Index wird nie durchsucht |

Die PLAN-Dateien, die JMAP und Suche nennen (`PLAN-angleichung-teil2/3`, `PLAN-insel-module`, `katalog-plan/ANFORDERUNGEN-baukasten`), treffen per Text; ihr Inhalt ist nicht ausgewertet [B: nur Treffer].

## Offene Punkte

1. Wortlaut der „7 Ebenen“ (aus dem Gedächtnis des Nutzers, nicht im Repository); Art 5 und 6 warten auf Bestätigung.
2. Unschärfe-Algorithmus: Soundex/Metaphone/Levenshtein sind kein Standard. Eigene Spezifikation oder Verzicht?
3. Prüfen, ob `cancel` und Zeitlimit zum Erweiterungsmechanismus von RFC 8620 Abschnitt 11 passen [nicht geprüft].
4. Ungefähre Zählung: Quelle für `track_total_hits` bei Bedarf nachreichen.
5. Der ADR zu Vertragsfeld und Fan-out: erst nachdem der Nutzer dieses Kapitel gelesen hat.

Im Lauf nicht belegt: Elasticsearch `track_total_hits`, Status von Soundex/Metaphone, ActivityPub-Details, offizielle OpenSearch-Seite (nur Entwürfe auf GitHub).
