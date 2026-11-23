# 0034 – Textstruktur technisch denken: Absatz, Seite, Kollektion, Regal

Status: akzeptiert (2026-11-05) · präzisiert ADR 0031

## Kontext
„Seite, Buch, Bibliothek“ war ein Bild. Technisch spielt es keine Rolle, ob etwas ein Buch, eine
Webseite, eine Buchführung oder ein Log ist. EPUB, Markdown, HTML sind **nur Exportformate**.

## Entscheidung
Vier technische Bausteine:

| Baustein | Was | Beispiel |
|----------|-----|----------|
| **Absatz** | extrahierbarer, benannter Teil (wie ein Block); markieren → als Absatz definieren → Namen geben → anderswo wieder einsetzen (ADR 0033) | Warnhinweis, der in zehn Hilfetexten steht |
| **Seite** | ein Dokument (jede Wiki-Seite) | Hilfe-Eintrag, Protokoll, Rechnungstext |
| **Kollektion** | Gruppe von Seiten/Kollektionen; Kollektionen **können aufeinander verweisen** (Graph, kein starrer Baum); kann **gesperrt** werden | Handbuch, Buchführungsjahr, Log eines Dienstes |
| **Regal** | **unabhängige Instanz** (eigener Speicher, eigene Rechte) | Bibliothek des Vereins, Hilfe-Bibliothek der Programme |

- Bücher, Kapitel, Webseiten sind **Sichten/Exporte** darauf, keine eigenen Datentypen.
- AS2: Seite = `Article`; Kollektion = `Collection`/`OrderedCollection`; Absatz = benannte Marke
  (ADR 0033) bzw. eigener Typ in der Block-Spezifikation; Regal = Instanz-Grenze (ADR 0019/0028).
- schema.org `Book`/`Chapter`, EPUB 3.3, Markdown nur bei Export/Import.

## Folgen
- Eigene Spezifikation für den Blockinhalt (Arbeitstitel siehe `data/documents/standards.md`) mit
  neutralem Namen, damit sie bei IETF/W3C eingereicht werden kann.

## Nachtrag (2026-11-14)
- **Wortwahl Regal:** im Code `shelf`; in der Oberfläche de „Projekt“, en „Project“ (Nutzerwort).
- **Struktur:** Absatz → Seite → Kollektion (Buch) → Regal (Shelf; eigene Instanz, eigene Rechte).

## Nachtrag 2026-11-23 (Entwurf, Workflow `adr-write`; nicht vom Nutzer akzeptiert): Absatz = eigenes Objekt, Profil statt Spezifikation
Anlass: Opus-Review des Dokument-Baums (`documents`, technical.md v4) und Nutzer-Entscheid vom 23.11.2026 (HTML wird nicht Speicherform; Baum aus Blöcken als AS2, daraus alle Ausgaben). Die Entscheidungen oben bleiben im Wortlaut stehen.
- **Absatz/Block = eigenes AS2-Objekt** im Baum (Eltern + Reihenfolge, typisierte Spalten nach ADR 0086), **nicht** „benannte Marke im `Article`“. Die Zeile „Absatz = benannte Marke (ADR 0033) bzw. eigener Typ in der Block-Spezifikation“ gilt damit im Sinn des zweiten Teils. Die **benannte Marke** (ADR 0033) bleibt für Platzhalter, Variablen und benannte Bereiche (Punkt oder Bereich).
- **Profil statt eigener Spezifikation:** Für Blockbäume gibt es keinen Standard (`research/documents-standards.md` §3 laut ENTSCHEID-baum). Wir definieren nur ein **Profil** `fsd:` auf AS2/JSON-LD; Marken folgen W3C Web Annotation (ADR 0033), „abgeleitet aus“ folgt W3C PROV-O. Die „Folgen“-Zeile „eigene Spezifikation für den Blockinhalt“ ist damit durch das Profil erfüllt (Fundstelle: `data/documents/technical.md` v4, §2, §4).
- Markdown und HTML bleiben Import/Export, nie Speicherformat (unverändert; HTML ausdrücklich bestätigt).
- **Offen:** ob der Name `fsd:` und der Kontext `https://freesynergy.net/ns/document#` so bleiben (Entwurf, Dereferenzierbarkeit nicht geprüft).
**English summary.** Draft addendum: a paragraph/block is its own AS2 object in a tree with typed columns, not a named mark inside the `Article`; the named mark of ADR 0033 stays for placeholders and named ranges. We define only a profile (`fsd:`) on AS2/JSON-LD instead of a new specification; marks follow W3C Web Annotation. Not accepted by the user yet.
