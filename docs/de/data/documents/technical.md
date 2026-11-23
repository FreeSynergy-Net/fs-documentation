# Documents – technical explanation

Workflow modul-neu, Schritt vorhanden-pruefen → technical. Modell Sonnet, 2026-11-23. Nur Text, kein Code, kein Push. Zielort später: `fs-documentation/data/documents/technical.md` (ersetzt dort nach Opus-Review die ältere Fassung, die noch den „block tree JSON“ aus ADR 0034 trägt).

Fassung v3 (Entscheide der Strategie nach Nachblick, 2026-11-23; Vorgänger `technical.md.bak-v2`, davor `technical.md.bak-v1`). Änderungen v3: kein eigener OOXML-Adapter (ferrodoc zuerst); ein Rückgängig (Scaffold, Loro liefert den Verlauf); Gruppen-Besitz über ADR 0095; Vorlagen-Kopie (eigene Kopie mit Herkunftsvermerk) und Gruppe als Eigentümer bei Mitbearbeitung **ENTSCHIEDEN** (Nutzer 23.11.), „Autor nimmt seinen Teil mit“ **OFFEN**; `art`/`wert` statt `kind`/`value_text`; `Template` als Typ entfernt.

Fassung v4 (Auftrag 0 laut REVIEW-DOC-baum.md, 2026-11-23; Vorgänger `technical.md.bak-v3-final`). Änderungen v4 = die sechs MUSS-Punkte des Review, nur am Modell: **M1** Block-Metadaten aus ADR 0072 (`rev`, `purpose`, …), Einsetzen eines Blocks, Punkt-Marken, interne Links als Ziel-Id (§2, §3, §3c); **M2** byte-gleiches Markdown über typisierte Schreibweise-Tabelle und Byte-Bereich im Original (§3b); **M3** Marken im Export als W3C Web Annotation (§4); **M4** Import-Sicherheit mit Erlaubt-Liste (§7c); **M5** Doppel-Orte aufgelöst: Listen-Nummernformat, Zellen-Lage, Sprache (§3, §5); **M6** ADR 0108: `retention_class`, Zustand „ausgestellt“, Herkunfts-Id der Ableitungen, vierter Konformitätstest (bedingt) (§3d, §7a). Die SOLL-Punkte des Review sind **nicht** Teil von v4 und stehen in §10 als offen, soweit sie M1–M6 berühren. Was der Review offen lässt, ist als **Offen** markiert, nichts ist dazu erfunden. **Status: Entwurf, nicht „vom Nutzer akzeptiert“.**

Status der Aussagen: **belegt** = in diesem Lauf gelesen (Datei genannt); **Entwurf** = Vorschlag dieses Dokuments; **noch nicht nachgeprüft** = aus Wissen, nicht gegen den Standardtext geprüft.

## 0. Rahmen (CLAUDE.md §8, Nutzer 23.11.)

- Das Modul `documents` ist für Dokumente die **einzige Quelle der Wahrheit** (Standard → Modul → point of truth). Kein Programm führt daneben eigene Dokument-Datensätze.
- Gespeichert wird in **AS2**: Eine Zeile ist ein AS2-Objekt (Typ, id, Eltern, Reihenfolge, Eigenschaften), jede Spalte genau eine Eigenschaft mit fester IRI im Kontext `fsd:`. **Kein Blob, kein JSON im Speicher** (ADR 0086 Entscheidung 3). JSON-LD entsteht erst beim Export, mechanisch.
- Das **Aussehen** liegt im selben Modell (ODF-Stilmodell als Gerüst, Eigenschaftsnamen XSL-FO/CSS), nicht als Datei daneben.
- Struktur-Import/Export über `ferrodoc` (Pin `=1.0.1`) hinter **eigenem Adapter** (nur die dünne Schicht Baum ↔ Spalten, kein eigener Format-Parser). **DOCX** liest und schreibt ferrodoc schon; fehlt etwas (Stilnamen), wird **upstream beigetragen** (UPSTREAM-ferrodoc-final.md Punkt 1, nur DOCX); `ooxmlsdk`/`docx-rs` kommen nur **hinter** dem Adapter in Frage, bei nachgewiesener Lücke (§8a). **ODT-Stilnamen** lesen: kein Upstream-Punkt (pandoc kennt dort kein `+styles`), das bleibt beim Stil-Adapter (§8, Zugriff auf die geparste Stiltabelle: Punkt 5, Frage). Kein Fork.
- Dienst: der Besitzer-Prozess des Moduls (ADR 0104); andere Programme sprechen nur über den Vertrag.

## 1. Gibt es das schon? (CLAUDE.md §8)

| Was | Wo | Befund | Folge |
|---|---|---|---|
| Dokumentmodell, Marken (stand-off), Ops/History, Markdown | lokaler Entwurfs-Klon des Repos `fs-document`, Crate `fs-document` (noch ohne Tag) | vorhanden, flach (`Container`-Stapel), null fs-Abhängigkeiten (`lib.rs`, README) | bleibt als Bibliothek, wird auf Baum umgebaut (§8) |
| HTML-Ausgabe | `crates/fs-document-html` | vorhanden, eigener Raw-Filter `raw.rs`+`rawtag.rs` | Filter → ammonia (§8) |
| Website-Erzeugung | `crates/fs-site` | vorhanden | bleibt, liest später per Port aus dem Modul (§8) |
| Programm texts / Vertrag | `fs-interfaces/schema/texts.capnp:86` (`document @2 :Text` = JSON) | JSON im Vertrag, widerspricht 0086 für Speicher | neuer Vertrag `documents.capnp` (§6); texts zieht nach |
| AS2-Hülle, Log, Original | ADR 0020, 0030, 0034, 0086, `fs-objects/.../v5/` (`tables.rs`, `envelope.rs`, `original.rs`, `log.rs`, `files.rs`) | vorhanden | **wiederverwenden**: Hülle, Aktivitätslog, Original, Datei-Verweis. Keine eigene Hülle |
| Stand-off-Marken, Kollaboration | ADR 0073 Z. 108 (`text_mark(block_id, start, end, art, wert)`), Loro nur Abgleich | vorhanden | `doc_mark` ist die Tabelle `text_mark` aus 0073 mit Spalten `block_id`, `start`, `end`, `art`, `wert` (Namen angeglichen, §3). Rich-Text-Marken **beim Tippen** liegen im Loro-Puffer (`collab_buffer`, ADR 0086 Ausnahme 3); `doc_block.text` und `doc_mark` sind der gespeicherte Stand nach dem Abgleich. **Marken-Standard (v4, M3):** W3C Web Annotation (ADR 0033, ADR 0014 Nr. 1), Abbildung in §4 |
| Web Annotation, URL, CSS, HTML säubern (für §3c, §4, §7c) | W3C Web Annotation Data Model (`oa:TextPositionSelector`); Crates `url` 2.5.9, `cssparser` 0.38.0 (MPL-2.0, steht in `deny.toml` auf der Erlaubt-Liste), `ammonia` 4.2.5 (hängt an html5ever ^0.40, cssparser ^0.38, url ^2) | Versionen laut REVIEW-DOC-baum (crates.io-API 23.11.) | nehmen, nichts davon selbst bauen; Einzelheiten und Zuständigkeit §7c |
| Bausätze (Länge, Farbe, Zeitangabe, Personen-Verweis) | ADR 0098, Repo fs-types | Zeitangabe/PersonRef vorhanden; **Länge und Farbe als Bausatz fehlen** (ENTSCHEID-baum (b)) | in fs-types ergänzen, nicht im Modul |
| Bilder/Dateien, Gerüst/CSS/JS | `fs-files` | vorhanden | `doc_ref` verweist darauf, nie Kopie |
| Personen-Erwähnung | `fs-people`, ADR 0085/0098 | vorhanden | Erwähnung = `PersonRef` (Spaltengruppe `_id/_art/_abzug`, §3), nie Name/E-Mail-Kopie |
| Programm-Styles (Oberfläche) | `fs-components` (Styles), Workflow `stil-neu` | vorhanden | getrennte Objekte, **gleiches Eigenschafts-Vokabular** (CSS-Namen) |
| Muster für Modul mit Fremdformat-Adapter | `fs-jscalendar` (iCalendar-Original bleibt byteweise) | vorhanden | gleiches Muster: Adapter + Original + Verlustmeldung |
| Pandoc-AST, ODT/DOCX/HTML/Markdown-Leser, ODT-Schreiber | Crate `ferrodoc` 1.0.1, MIT OR Apache-2.0 | geprüft (PROBE-ferrodoc.md, ENTSCHEID-baum §4) | Kern-Adapter; Lücken in §9 |
| HTML säubern | Crate `ammonia` 4.2.5 | ENTSCHEID-html §2 | statt Eigenbau |
| Markdown | `pulldown-cmark` 0.13.6 (bleibt), `comrak` BSD-2 (nicht im Einsatz: **ungeprüft**; die Lizenz ist kein Grund, ENTSCHEID-baum §4 erlaubt Lizenzen per `deny.toml`) | belegt (ENTSCHEID-baum §4, ältere technical.md) | Eigenbau-Export bleibt vorerst. Zwei Markdown-Wege (eigen/pulldown-cmark und ferrodoc-md) nur, weil ferrodoc-md Lücken hat: fenced divs nicht gelesen, YAML `[a, b]`, zerrissene Aufgabenliste (§9) |
| ODF-Stilmodell, Stilnamen | ODF 1.3 (OASIS/ISO 26300) | Standard | Gerüst (§5) |
| Word-Stile in Rust (`ooxmlsdk` 0.15.0, `docx-rs` 0.4.22) | crates.io, 23.11. | geprüft, Einordnung in §8a | **kein eigener OOXML-Adapter** (CLAUDE.md §8): DOCX über ferrodoc (liest/schreibt schon), Lücken upstream; `ooxmlsdk`/`docx-rs` nur hinter dem Adapter bei nachgewiesener Lücke (§8a) |
| Eigener Standard für Blockbäume | keiner (`research/documents-standards.md` §3 laut ENTSCHEID-baum) | – | wir definieren nur ein **Profil** `fsd:` auf AS2/JSON-LD |

Nicht vorhanden und nicht neu zu bauen: ODT-/DOCX-Parser, HTML-Parser, Sanitizer, Zip. Eine eigene ODT-Ausgabe wird **nicht** gebaut (ENTSCHEID-baum §4).

## 2. Typen (AS2-Objekte)

Jeder Typ hat Code (Spalte `type`, Tabelle `doc_word`, Code + volle IRI, ADR 0086 Nachtrag d3) und eine IRI im Kontext `fsd:`. AS2-Kernobjekte werden benutzt, wo AS2 sie kennt; alles andere ist `fsd:`-Erweiterung (AS2 darf Unbekanntes ignorieren, AS2 Core §5; **Widerspruch offen:** fremde Leser sehen nur das erzeugte `content`).

| Typ (JSON-LD) | AS2/fsd | Ablage | Bedeutung |
|---|---|---|---|
| Dokument | `Article` (oder `Document` für Dateitext) | Zeile in `objects` (Hülle, ADR 0020) | Titel, Sprache, Medientyp, Papierkorb/`rev` je Dokument; Zustand (u. a. „ausgestellt“, §3d) |
| Block | `fsd:Para`, `fsd:Header`, `fsd:CodeBlock`, `fsd:List`, `fsd:Item`, `fsd:Quote`, `fsd:Table`, `fsd:Row`, `fsd:Cell`, `fsd:Figure`, `fsd:Rule`, `fsd:Note`, `fsd:Callout`, `fsd:Toggle`, `fsd:Columns`, `fsd:Embed`, `fsd:Include` (Einsetzen eines Blocks, v4 M1), `fsd:RawBlock` | `doc_block` + Untertabelle je Art | Blockarten = offene Wortmenge; Pandoc-Vokabular als Hilfe, nicht Pflicht |
| Marke | `fsd:Strong`, `fsd:Emph`, `fsd:Under`, `fsd:Strike`, `fsd:Sup`, `fsd:Sub`, `fsd:CodeSpan`, `fsd:Link`, `fsd:StyleSpan`, `fsd:RawSpan`, `fsd:Lang` (Sprache eines Bereichs, v4 M5), `fsd:Variable` (Platzhalter, Punkt oder Bereich, v4 M1); `Mention` (AS2) | `doc_mark` | stand-off Bereich über `text` des Blocks; **Punkt-Marke** = `start = end` (§3) |
| Stil | `fsd:StyleDef` (Familie als Eigenschaft) | `doc_style` + Familientabellen | §4 |
| Verweis | `Image`/`Document` via `attachment`, Person via `Mention` | `doc_ref` | auf fs-files, fs-people, Einbettung (ADR 0068) |
| Original | AS2 `Document` | `object_original` (fs-objects) | Eingangsdatei, 30 Tage (ADR 0073 §11) |
| Verlustmeldung | `Note` | `doc_import_note` | Import: was nicht abbildbar war (ADR 0086 Punkt 5) |

Blöcke bekommen **keine** eigene `objects`-Hülle, aber eine IRI (urn:uuid, ADR 0085 §3, Entwurf nach ENTSCHEID-baum (a)).

**Vorlage ist kein Typ** (Entscheidung v3, behebt REVIEW S-N3): `fsd:Template`, die Spalte `template` und `scope` entfallen. Eine Vorlage ist ein gewöhnliches Dokument (`Article`) mit Stilen, ohne eigene Identität daneben; Besitz, Anwenden und Teilen: §3a.

**IRI-Eindeutigkeit (Entscheidung, behebt REVIEW MUSS 3).** Eine IRI hat genau eine Bedeutung. Vorher doppelt: `fsd:Code` (Block und Marke) und `fsd:Style` (Marke und Stiltyp). Neu: Block `fsd:CodeBlock`, Marke `fsd:CodeSpan`; Marke `fsd:StyleSpan` (Bereich mit Stil), Stiltyp `fsd:StyleDef` (Definition). Gleiche Regel für `fsd:Raw`: Marke `fsd:RawSpan`, Block `fsd:RawBlock`. Begründung: Block/Marke/Definition unterscheiden sich im Suffix (`…Block`, `…Span`, `…Def`), so bleibt der JSON-LD-Export eindeutig und ein fremder Leser kann Typ und Rolle am Namen erkennen. Prüfung: ein Test über die erzeugte Typ-Wortmenge `doc_word` (jede IRI genau einmal); Mutant „zweimal dieselbe IRI“ muss rot werden.

## 3. Tabellen und Spalten (Entwurf, v5-Domäne `doc`, ADR 0086/0104)

Ein Modul, ein Besitzer, eigene Domäne. Spalten nur anhängen (ADR 0086). Zeit = UTC-Ganzzahl, Verweis = `PersonRef`/Id (ADR 0085).

**Personen-Schlüssel (Entscheidung, behebt REVIEW MUSS 4).** ADR 0104 E7 verlangt auf dem Server „einen Personen-Schlüssel in jeder Zeile“. Jede `doc_*`-Tabelle (auch die Untertabellen) **außer `doc_word`** trägt deshalb die Spaltengruppe **`owner_id`, `owner_art`, `owner_abzug`** = Personen-Verweis nach ADR 0098 (Zeile „Personen-Verweis“: Spaltengruppe `_id/_art/_abzug`; Bestand der Schreibweise u. a. `fs-objects src/v5/tables.rs:53-54`). `owner_abzug` bleibt leer (nur bei ausgestelltem Dokument, ADR 0098; den Zustand und seinen Auslöser gibt es seit v4: §3d). **Nie** Name, E-Mail oder sonst eine Kopie von Personendaten; Anzeigename holt das Frontend über `fs-people`. Hinweis: die im Auftrag genannte Datei `v5::kit::person_ref` habe ich im Quellbaum nicht gefunden; Vorbild ist daher ADR 0098 Z. 8/24 und `v5/tables.rs`. `doc_word` (gemeinsame Wortliste Code ↔ IRI) ist ausgenommen: sie enthält keine Personendaten, ein Personen-Schlüssel hätte dort keinen Sinn. **Gruppen als Besitzer (v3, ADR 0095):** „Gruppe“ ist **kein eigener Schlüsseltyp**. Nach ADR 0095 besitzt eine Gruppe über ihre **Eigentümer** (Personen); der Personen-Schlüssel `owner_*` aus E7 wird über die Eigentümer der Gruppe aufgelöst. **Offene Stelle für den Test:** wie die drei Konformitätstests (§7a) bei Gruppeneigentum prüfen (Export/Löschen einer Person, die nur eine von mehreren Eigentümern ist; Wechsel der Eigentümer) – ungeprüft, im `testlauf` ergänzen. Auf dem Gerät (Treiber „Datei je Person“) ist die Spalte durch die Datei bestimmt, bleibt aber vorhanden, damit beide Treiber dasselbe Schema haben. Personen in Inhalt (Erwähnung, Autor) sind **eigene** Verweisspalten nach demselben Muster (§3, `doc_mark`), nicht der Besitzer-Schlüssel.

**doc_block** (jede Zeile = ein AS2-Objekt)
| Spalte | Typ | AS2/fsd-Eigenschaft |
|---|---|---|
| `id` | UUID | `id` (urn:uuid) |
| `doc` | Verweis | `context` (zum Dokument) |
| `parent` | Verweis (NULL = Wurzel) | `fsd:parent` (Kinder als `fsd:children`, `@list`) |
| `ord` | Text, Bruchindex | Reihenfolge in `@list` (kein Vergleich nach Zahl) |
| `type` | Wort → `doc_word` | `type` |
| `lang` | BCP-47 Text | `fsd:lang` (AS2 kennt keine Sprache außer `@language`/`contentMap`; `contentLanguage` ist kein AS2-Term). **Der einzige Ort für die Sprache des ganzen Blocks** (v4 M5); Sprache eines Teilbereichs = Marke `art = Lang` (§3). Das Stil-Modell trägt keine Sprache |
| `text` | Text (Unicode-Skalare) | `content`, `mediaType: text/plain` |
| `style` | Verweis → `doc_style` | `fsd:style` (benannter oder automatischer Stil) |
| `anchor` | Text, leer erlaubt | `fsd:anchor` (aus HTML/Pandoc-`id`); freie Zeichenkette: beim Import geprüft (gültige HTML-Id), beim Ausgeben maskiert (§7c) |
| `program` | Text (Paketname, ADR 0017), leer erlaubt | `fsd:program` (ADR 0072 §1) |
| `purpose` | Text, sprechender Schlüssel (ADR 0055), leer erlaubt | `fsd:purpose` (ADR 0072 §1: z. B. `store.summary`, `help.<thema>`, `manual.*`; offenes Vokabular, Programme legen eigene unter `<programm>.<zweck>` an) |
| `translation_of` | Verweis auf Block-Id, leer erlaubt | `fsd:translationOf` (ADR 0072 §1; eine Block-Id je Sprache, `translationOf` verbindet; ADR 0072 Risiko 1 ist dort nur „Vorschlag“) |
| `rev` | Ganzzahl, monoton **je Block** | `fsd:rev` (ADR 0072 §1: Fassung; Zeit und Urheber stehen im Aktivitätslog, nicht in einer Spalte). `rev` je Dokument (Hülle) bleibt daneben; ohne `rev` je Block kann die Hilfe-/Laden-/Übersetzungskette „veraltet“ nicht erkennen |
| `source_rev` | Ganzzahl, leer erlaubt (nur bei Übersetzung) | `fsd:sourceRev` (ADR 0072 §1: `rev` des Ursprungsblocks beim Übersetzen; höheres `rev` am Ursprung = Übersetzung **veraltet**, wird so angezeigt, ADR 0057) |
| `owner_id/_art/_abzug` | Personen-Verweis | (Schlüssel, nicht im Export) |

`program`, `purpose`, `translation_of`, `rev` und `source_rev` sind die Metadaten aus ADR 0072 §1 (dort „Vorschlag, anhängbar“); `lang` war schon da. Bei jeder Änderung von `text`, `style` oder einer Untertabelle erhöht der Moduldienst `rev` des Blocks (Entwurf; die Zählregel für reine Verschiebungen ohne Inhaltsänderung ist **Offen**, §10). `purpose`-Abfragen („gib mir `purpose = store.summary` für `program = fs-files` in `lang = de`“, ADR 0072 §2) laufen über `document.query` (§6) auf diesen Spalten; die Wiki-Schnittstelle selbst ist nicht Teil dieses Dokuments.

**Untertabellen je Art** (Schlüssel `block_id`): `doc_heading(level)`, `doc_list(ordered, start, tight, list_style)`, `doc_item(task, checked)`, `doc_code(info)`, `doc_cell(rowspan, colspan, header)`, `doc_table(caption_block)`, `doc_include(target_block, target_doc)` (Einsetzen, §3c), `doc_syntax_md(…)` und `doc_source(…)`, `doc_source_group(…)` (Markdown byte-gleich, §3b), `doc_state(doc, state, issued_at)` (Zustand, §3d), `doc_colspec(ord, align, width_*)`, `doc_raw(media_type, origin, reason)` (Rohblock: Quelltext wörtlich, nie ausgeführt), `doc_class(ord, name)` (Klassennamen wie `fs-callout`; offene Wortmenge, **kein** Schlüssel/Wert). **`doc_attr` entfällt** (REVIEW MUSS 6): ein Schlüssel/Wert-Rest neben dem Stilmodell ist die in ADR 0086 (Kontext, `index_fields`) verworfene Form. Abbildungsregel für Quell-`Attr`/HTML-Attribute, abschließend:

| Quelle | Ziel |
|---|---|
| `id` | Spalte `doc_block.anchor` |
| `class` | `doc_class` (Name); kennt das Modul den Namen als Blockart (`fs-*`), wird daraus die Art |
| `style="…"` (HTML) | Eigenschaften des Kernsatzes (§3, Familientabellen) → automatischer Stil (`name = NULL`); jede Eigenschaft **außerhalb** des Kernsatzes → **abgelehnt**: nicht gespeichert, `doc_import_note` nennt Eigenschaft und Wert, das Original behält sie (ADR 0086 Punkt 5) |
| `custom-style` (Pandoc/DOCX/ODT) | **benannter Stil** (`doc_style.name`); kennt das Modul den Namen nicht, wird er als leerer benannter Stil ohne Eigenschaften angelegt, damit der Name erhalten bleibt |
| `data-*` und alle übrigen Schlüssel | abgelehnt, `doc_import_note`; wer solche Daten braucht, bekommt eine **benannte Spalte** per Schema-Update (anhängen), nie einen Rest |

Damit gibt es neben dem Stilmodell keinen zweiten Ort für Aussehen.

**Doppel-Orte aufgelöst (v4 M5; jede Angabe hat genau einen Ort):**
| Angabe | Einziger Ort | Entfallen |
|---|---|---|
| Listen-Nummernformat, Trenner, Präfix/Suffix, Einzug | Listenstil: `doc_style_list_level(style, level, numfmt, prefix, suffix, indent, label_width)` (wie ODF `text:list-style`); der Block verweist über `doc_list.list_style` (Verweis → `doc_style`, `art = list`) darauf | `doc_list.numfmt`, `doc_list.delim` |
| Bedeutung der Liste | Block: `doc_list.ordered` (geordnet ja/nein), `doc_list.start` (Zählbeginn der **Bedeutung**, z. B. Liste beginnt bei 5), `tight` | – |
| Zellen-Lage (Zeile, Spalte) | Baum: Zeile = Knoten `fsd:Row` unter `fsd:Table`, Zelle = Knoten `fsd:Cell` unter `fsd:Row`, die Lage ergibt sich aus `parent` und `ord`. Die Untertabelle `doc_cell` trägt **nur** `rowspan`, `colspan`, `header` | `doc_cell.row`, `doc_cell.col` |
| Sprache | Block: `doc_block.lang`; Teilbereich: Marke `art = Lang`, `wert` = BCP-47. ODF `fo:language`/`fo:country` (20.202/20.188) und OOXML `w:lang` werden beim Import dorthin abgebildet, nicht in den Stil | `doc_style_text.lang` |

Offen (der Review lässt es nicht entscheiden): ODF führt den Anfangswert (`text:start-value`, 19.874) in der Listenstufe des Stils. v4 folgt dem Vorschlag des Review („Am Block stehen nur Bedeutung und Wert (`ordered`, `start`)“) und legt `start` **nur** in den Block; beim ODF-Import wird `text:start-value` dorthin abgebildet, beim ODF-Export zurück in die Stufe. Ob das den Rundlauf trägt, ist nicht geprüft.

**doc_mark** (= `text_mark`, ADR 0073 Z. 108; Spaltennamen wie dort: `block_id`, `start`, `end`, `art`, `wert`, so bleibt Nachtrag zu 0073 nur für den Tabellennamen nötig). Die Spalte „Export“ gilt seit v4 (M3): wo W3C Web Annotation einen Term hat, wird **er** benutzt, `fsd:` nur für Art, Wert und Stilverweis (Abbildung im Einzelnen §4).
| Spalte | Typ | Export (§4) |
|---|---|---|
| `id` | UUID | `id` |
| `block_id` | Verweis auf `doc_block` | `oa:hasTarget` → `oa:SpecificResource`, `oa:hasSource` = Block-IRI |
| `start`, `end` | Ganzzahl, Unicode-Skalare; `start` inklusiv, `end` exklusiv; **`0 ≤ start ≤ end ≤` Länge von `text`**; **`start = end` ist ausdrücklich erlaubt** und heißt **Punkt-Marke** (Anker = Punkt, ADR 0033: Platzhalter/Variable, Serienbrief) | `oa:hasSelector` → `oa:TextPositionSelector` mit `oa:start`, `oa:end` |
| `art` (= ADR 0073 `text_mark.art`) | Wort aus `doc_word` | `type` (Wortliste, IRI aus `doc_word`) |
| `wert` (= ADR 0073 `text_mark.wert`) | Text | `fsd:value` |
| `name` | Text, leer erlaubt (Entwurf; **Offen**, s. u.) | `fsd:name` |
| `href` | Text (URL), nur `art = Link`, **nur externes Ziel**; Erlaubt-Liste der Schemata, `data:` nie (§7c) | `href` |
| `target_doc`, `target_block` | UUID, leer erlaubt; nur `art = Link`, **interner** Link: Ziel-Dokument und (optional) Ziel-Block als **Id** | `fsd:targetDoc`, `fsd:targetBlock` (Typ `@id`) |
| `path`, `title` | Text, nur `art = Link`: lesbarer Pfad und Titel des Ziels zum Anzeigen (kein Schlüssel) | `fsd:path`, `fsd:title` |
| `person_id/_art/_abzug` | Personen-Verweis (nur `art = Mention`), nie Name/E-Mail-Kopie (ADR 0098/0085 §3) | `Mention` → Person |
| `file_ref` | `FileRef` mit Prüfsumme (nur Bild/Datei), siehe `doc_ref` | `attachment` |
| `style` | Verweis → `doc_style` | `fsd:style` (nur `art = StyleSpan`) |
| `owner_id/_art/_abzug` | Personen-Verweis (Schlüssel) | (nicht im Export) |

**Punkt-Marken (v4 M1, ADR 0033).** Eine Marke darf als Anker einen Punkt haben (`start = end`). Welche `art` das darf, sagt die Wortliste, nicht der Code: Entwurf eine angehängte Spalte `anchor` in `doc_word` für Markenarten (`range`, `point`, `both`); `fsd:Variable` wäre `both`, `fsd:Strong` nur `range`. Eine Punkt-Marke mit einer Art, die nur `range` erlaubt, wird abgelehnt (Mutant: `Strong` mit `start = end` → rot). **Offen:** ob `art`/`wert` aus ADR 0073 Name, Typ und Wert aus ADR 0033 vollständig tragen. v4 hängt die Spalte `name` an (Entwurf), bis das entschieden ist. **Ungeprüft:** wie Punkt-Marken und Stilverweise im `LoroText` des Puffers laufen (ADR 0073 Nachtrag P6; Spike beim Bau von `CollabDoc`, Wert eines `StyleSpan` = Stil-IRI). Im W3C-Standardtext (Web Annotation Data Model, gelesen 23.11.) steht für `TextPositionSelector`: Zählung in Unicode-Codepunkten, Position 0 vor dem ersten Zeichen, Anfang eingeschlossen, Ende nicht; `start`/`end` nichtnegative Ganzzahlen. Ein Punkt (`start = end`) wird dort **nicht ausdrücklich** erwähnt, nur nicht verboten (ADR 0033 sagt „Punkt = Position ohne Länge“).

**Interne Links = Ziel-Id (v4 M1, ADR 0042 Punkt 8).** ADR 0042 verlangt eine Link-Tabelle (Quelle, Stelle, Ziel-UUID, Pfad, Titel) mit automatischem Umschreiben beim Verschieben. Sie ist **keine zweite Tabelle**, sondern `doc_mark` mit `art = Link`: Quelle = `block_id`, Stelle = `start`/`end`, Ziel = `target_doc`/`target_block`, Pfad = `path`, Titel = `title`. Der Schlüssel eines internen Links ist die **Id**; `path` und `title` sind Anzeigewerte, die der Moduldienst beim Verschieben oder Umbenennen des Ziels umschreibt (ADR 0042 Punkt 8), der Link bricht dabei nie. Genau eines gilt: `href` (extern) **oder** `target_doc`/`target_block` (intern). Rückwärtsabfrage („wer verlinkt hierher“) läuft über einen Index auf `target_*`, nicht über eine zweite Wahrheit. Vorbild im Bestand: die Bibliothek hat das schon (`links/row.rs`: `target: Option<Uuid>`, `internal`, laut Review gelesen). **Offen:** Verhalten bei gelöschtem Ziel (Anzeige, ist nicht festgelegt) und Links in andere Regale (Instanz-Grenze, ADR 0034).

**doc_ref**(`id`, `block_id|mark_id`, `file_ref` (Datei in fs-files, mit `sha256`), `media_type`, `width`, `height`, `owner_*`): Bild/Datei/Einbettung als Verweis mit Prüfsumme, nie Kopie.

**doc_style** (je Stil eine Zeile)
| Spalte | Bedeutung |
|---|---|
| `id` | UUID |
| `doc` | Verweis auf das Dokument, zu dem der Stil gehört (eine Vorlage ist selbst ein Dokument, §3a) |
| `family` | ODF-Namen (`style:family`, 19.480): `paragraph`, `text`, `table`, `table-column`, `table-row`, `table-cell`, `graphic`. **Keine** `style:family`-Werte in ODF sind Listen und Seiten: sie sind eigene Stilarten (`text:list-style`, `style:page-layout`/`style:master-page`, 16.5) und stehen hier als `art = list` bzw. `art = page` (Spalte `art`, Vorgabe `style`). OOXML kennt `paragraph`/`character`/`table`/`numbering`; Seitenmaße liegen dort in `w:sectPr`. Werteliste 19.480 selbst nicht vollständig gelesen |
| `art` | `style` (Vorgabe), `list`, `page` |
| `owner_id/_art/_abzug` | Personen-Verweis (Schlüssel, §3) |
| `name` | NULL = automatischer Stil (direkte Formatierung) |
| `display_name` | Anzeigename (ODF `style:display-name`) |
| `parent` | Vererbung (ODF `style:parent-style-name`) |
| `next` | Folgestil (nur Absatz) |

Familientabellen (Kernsatz, Spaltennamen = CSS/XSL-FO, Länge = Ganzzahl in Tausendstel + Einheit, Farbe = sRGB-Ganzzahl; beides Bausatz in fs-types, ADR 0098):
- `doc_style_text`: `font_family`, `font_size`, `font_weight`, `font_style`, `underline`, `line_through`, `color`, `background_color`, `highlight` (benannte Hervorhebungsfarbe, Wort; OOXML `w:highlight` ist eine Namensliste, keine sRGB-Farbe), `vertical_align`, `font_variant`. **Keine Sprache** (v4 M5: Sprache ist Inhalt, gehört an `doc_block.lang` bzw. Marke `art = Lang`).
- `doc_style_para`: `text_align`, `margin_*`, `text_indent`, `line_height`, `line_height_rule` (`exact`/`at-least`/`multiple`, mit Wert), `break_before`, `break_after`, `keep_with_next`, `keep_together`, `orphans`, `widows`, `border_*`, `padding_*`, `background_color`.
- `doc_style_table` / `doc_style_cell`: `width`, `align`, `border_*`, `padding_*`, `background_color`, `vertical_align`.
- `doc_style_list_level`(`style`, `level`, `numfmt`, `prefix`, `suffix`, `indent`, `label_width`).
- `doc_style_page`: `page_width`, `page_height`, `orientation`, `margin_*`, Kopf/Fuß-Abstände.

Keine Rest-Spalte: Eigenschaften außerhalb des Kernsatzes bleiben im **Original** und erzeugen eine `doc_import_note` (ADR 0086 Punkt 5). Das Original wird nach dem Papierkorb-Zeitraum gelöscht (Standard 30 Tage, ADR 0073 Z. 114, außer „Originale immer behalten“); **danach sind diese Eigenschaften endgültig weg**, nur die Meldung bleibt. Das ist bewusst verlustbehaftet an der Grenze (siehe §5, Verlustliste) und wird erweitert, indem Spalten angehängt werden.

**3a. Vorlagen und Mitbearbeitung – ENTSCHIEDEN (Nutzer 23.11.), ein Rest OFFEN.** Der frühere Entwurfstext (v2, „vorläufig“) ist durch die Entscheide ersetzt:
1. **Dokument aus Vorlage = eigene Kopie mit Herkunftsvermerk (entschieden).** Beim Anlegen aus einer Vorlage (und bei `style.apply` aus einem Vorlagen-Dokument) entsteht ein **eigenes Objekt**: Blöcke, Stile und Marken werden kopiert, die Kopie hat einen eigenen Eigentümer (ADR 0098 Regel 4.4, sharen ≠ schenken: die Kopie ist nicht die Vorlage, spätere Änderungen der Vorlage wirken nicht zurück). Die Herkunft steht in **einer** Spalte/Eigenschaft: `derived_from` (Verweis auf die IRI des Vorlage-Dokuments, ohne Abzug; wird die Vorlage gelöscht, bleibt die IRI als Vermerk und zeigt ins Leere). **Vorschlag AS2/Standard-Mittel:** im Export `prov:wasDerivedFrom` (W3C PROV-O); das ist der Standard für „abgeleitet aus“ und passt zur Kopie als eigenem Objekt. Nicht `as:inReplyTo` (Gesprächsbezug), nicht `as:context`, nicht `dcterms:source` (zu unscharf). Innen heißt die Spalte `derived_from`, im `fsd:`-Kontext (§4) wird sie auf `prov:wasDerivedFrom` abgebildet; vor dem Vertragsbau gegen ADR 0073/0086 und den AS2-Standardkatalog (Vorhandenes zuerst) prüfen.
2. **Mitbearbeitung: Eigentümer ist Person ODER Gruppe (entschieden).** Erarbeitet eine **Gruppe** ein Dokument, gehört es der **Gruppe**, nicht einer Einzelperson. Die Gruppe besitzt über ihre Eigentümer (ADR 0095), kein eigener Schlüsseltyp – wie im Personen-Schlüssel (§3) beschrieben; beides ist widerspruchsfrei: `owner_*` verweist auf Person oder Gruppe, die Auflösung läuft über die Gruppen-Eigentümer. Jeder **Beitrag trägt seinen Autor** als Personen-Verweis (`PersonRef`, `attributed_to_*`), auch im Gruppendokument. Grundsatz der Strategie: Personen funktionieren nicht ohne Groups; groups ist Grundlage wie der Scaffold (auch Kanidm).
3. **OFFEN (vom Nutzer nicht bestätigt):** „Autor nimmt seinen Teil mit“ (Export/Mitnahme der eigenen Beiträge beim Verlassen der Gruppe, Berührung §7a Test 1 und 3). Bleibt offen, bis der Nutzer entscheidet; bis dahin nichts bauen, was davon abhängt.
Vor dem Bau des Vertrags muss nur noch Punkt 3 entschieden sein.

**Direkte Formatierung = automatischer Stil:** Block → `doc_block.style` zeigt auf einen Stil mit `name = NULL`; Bereich → `doc_mark` mit `art = StyleSpan`. Ein Mechanismus, keine Sonderfelder (wie ODF `office:automatic-styles`).

### 3b. Markdown byte-gleich (v4 M2, ADR 0084 E5)

ADR 0084 Entscheidung 5 verlangt **Rundlauf byte-gleich** (laden, unverändert speichern = gleiche Bytes). Die Bibliothek erreicht das heute über `BlockAttrs.extra: BTreeMap<String,String>` (Hinweise `glue`, `dashes`, `fence` …), `heading_attrs` als Text und `source: Source` (wörtlicher Quelltext je Block samt Siegel) (`doc/attrs.rs`, `doc/source.rs`, gelesen). In v3 fehlten alle drei. Ein Schlüssel/Wert-Rest wie `extra` ist die in ADR 0086 verworfene Form (wie das gestrichene `doc_attr`), eine Textkopie je Block wäre eine zweite Wahrheit neben `doc_block.text`. Darum:

**(a) Schreibweise-Hinweise: typisierte Untertabelle je Quellformat.** Für Markdown `doc_syntax_md(block_id, fence_char, fence_len, bullet, emph_char, heading_style, …)` (Schlüssel `block_id`, `owner_*` wie alle). Jede Spalte ist ein Wort oder eine kleine Ganzzahl, keine freie Zeichenkette. Die **Spaltenliste ist ein Beispiel**: `glue`, `dashes`, `fence`, `heading_attrs` der Bibliothek werden darauf abgebildet; abschließend wird sie am Markdown-Korpus festgelegt (**Offen**). Die Menge ist offen und wird **angehängt** (ADR 0086). Eigenschaften, die das Modell ohnehin trägt, kommen **nicht** doppelt hinein: `{#id}` → `doc_block.anchor`, `.klasse` → `doc_class`; in `doc_syntax_md` steht nur die **Schreibweise** (z. B. Reihenfolge und Abstände der Attribut-Klammer). Für weitere Quellformate gilt dasselbe Muster mit eigener Untertabelle (`doc_syntax_<format>`); ob HTML/ODT sie brauchen, ist **Offen**.

**(b) Quelle je Block = ein Byte-Bereich im Original, keine Kopie.** `doc_source(block_id, original, byte_start, byte_end, own, tail, prev, seal)`:
- `original` = Verweis auf die Zeile in `object_original` (fs-objects, ADR 0073 Nachtrag d3); `byte_start`/`byte_end` zählen **Bytes** der Originaldatei (das Original ist eine Bytefolge, anders als `text`/`start`/`end` in Skalaren).
- `own`, `tail`, `prev` übernehmen die Semantik von `Source` der Bibliothek: Länge des Vorspanns (Leerzeilen, nicht in Blöcke umgesetzter Text), „Bereich reicht bis Dateiende“, der Block davor beim Lesen. Blöcke, die Quellzeilen teilen, stehen in `doc_source_group(block_id, member_block, seal)` (entspricht `Source.rest`).
- `seal` = Fingerabdruck über den Inhalt des Blocks zum Lesezeitpunkt (Bibliothek heute: 128-Bit-FNV-1a, **nicht kryptografisch**, er erkennt Veraltetes, schützt nicht gegen Manipulation; Spaltentyp und Verfahren **Offen**). Der Exporter schreibt den Bereich nur dann wörtlich, wenn das Siegel noch passt, der Nachbar noch passt und das Original noch da ist, und **beweist das Ergebnis durch Zurücklesen** (wie die Bibliothek heute; ein veralteter Bereich wird nie geschrieben).
- Konsistenz mit ADR 0085: `Origin` (Kanal, Prüfsumme, `rev_at_import`) für `document.import` nutzen, nicht neu bauen. „Seit dem Import unverändert“ = `rev` des Blocks gleich `rev_at_import`.

**(c) Nach dem Löschen des Originals** (Papierkorb-Zeitraum, Standard 30 Tage, ADR 0073 Nachtrag d3) gelten nur noch die Schreibweise-Hinweise aus (a); `doc_source` wird mit dem Original gelöscht. Der Rundlauf ist dann **„gleich nach Regel“, nicht mehr byte-gleich**. Das wird so gesagt (auch in der Oberfläche, wo es einen Export betrifft) und der Konformitätstest von ADR 0084 E5 wird **geteilt**: **(i) byte-gleich** mit vorhandenem Original (Nutzer-Fixture vom 14.11., GFM-Kern), **(ii) regel-gleich** ohne Original (Entwurf: Export, Import und Export des Ergebnisses ergeben dieselben Bytes). Beides gehört in den Vertrag als Abnahmebedingung. **Offen:** ob ADR 0084 E5 diese Teilung als Nachtrag bekommt (empfohlen, siehe ADR-Nachtrag 0084).

### 3c. Einsetzen eines Blocks (Transklusion, v4 M1, ADR 0072 §1, ADR 0033)

ADR 0072 §1 und ADR 0033: Ein Block gehört zu einer Seite, kann aber über seine Id an anderer Stelle **eingesetzt** werden (Wiederverwendung, Notion: synced block). v3 hatte dafür nur `fsd:Embed` (ADR 0068, Einbettung von Dingen anderer Programme).
- **Entwurf:** Blockart `fsd:Include` mit Untertabelle `doc_include(block_id, target_block, target_doc)`. Der eingesetzte Block wird **nie kopiert**; angezeigt wird der Inhalt des Ziels in seiner aktuellen Fassung. Ziele sind Block-Ids (stabil, ADR 0072), nicht Orte.
- **Rechte:** ohne Recht am Ziel zeigt der Moduldienst nur einen Platzhalter, nie den Inhalt (Konformitätstest 2, §7a). Ob das Recht am Quell- oder am Zieldokument gilt, richtet sich nach dem Besitz des Ziels (ADR 0104); die Frage, wem ein eingesetzter Block „gehört“, ist **Offen**.
- **Zyklen** (A setzt B ein, B setzt A ein): werden beim Anlegen und nach jedem Merge erkannt und angezeigt, nicht still abgelehnt (Muster wie bei Eltern-Zyklen, ADR 0073 Nachtrag Punkt 6; Entwurf).
- **Ausgaben:** HTML, Markdown und ODT geben den **aufgelösten** Inhalt aus; JSON-LD gibt `fsd:Include` mit `fsd:targetBlock` (`@id`) aus.
- **Offen:** (1) Blockart `fsd:Include` oder eine `doc_ref`-Art „Verweis auf Block oder Dokument“ (der Review nennt beides; v4 wählt die Blockart als Entwurf, weil ein Block im Baum an einer Stelle steht und Rechte/Ausgabe dort ansetzen); (2) festgehaltene Fassung (`rev` des Ziels) neben „immer aktuell“; (3) Einsetzen eines **Bereichs** statt eines ganzen Blocks (das leistet bis dahin nur die Punkt-Marke `fsd:Variable`, §3).

### 3d. Vergessen und „ausgestellt“ (v4 M6, ADR 0108 Entwurf, ADR 0085, ADR 0098)

ADR 0108 ist ein **Entwurf** (main 031a78ad). Ändert er sich, ändern sich `retention_class` und Test 4 (klein, anhängbar). Was hier steht, ist der Anschluss, keine Entscheidung.
- **`retention_class` je Datentyp (E1/E5):** das Modul erklärt sie in der Typbeschreibung, es führt keine Fristen. Fehlt die Angabe, gilt `content` (ADR 0108 E1).

| Datentyp | `retention_class` (Entwurf) | Bemerkung |
|---|---|---|
| Dokument und alle `doc_*` (Blöcke, Untertabellen, Marken, Stile, `doc_ref`) | `content` (Voreinstellung: aus) | Verlauf des Objekts folgt der Datenart (ADR 0108 E5, ADR 0073 Nachtrag 23.11.); voller Verlauf bleibt Voreinstellung |
| **ausgestelltes** Dokument (Protokoll, Beschluss; ADR 0085 „ausgestellt = eingefroren“) | `record` (nie automatisch, fest) | Wechsel von `content` auf `record` mit dem Zustand „ausgestellt“, s. u. |
| `object_original` | folgt Papierkorb/Import (ADR 0073 Nachtrag d3: Papierkorb-Zeitraum, Standard 30 Tage, „Originale immer behalten“ wählbar) | die Datenart in 0108-Wörtern (`trash`?) ist **Offen** |
| `doc_import_note` | folgt dem Import des Dokuments (ADR 0073 d3) | wie oben **Offen**; Meldungen enthalten Eigenschaft und Wert (§3) |
| `doc_word` | keine Personendaten, keine Frist | Wortliste/Schema, nicht Inhalt |

- **Zustand „ausgestellt“ (neu).** Das Dokument (Hülle) bekommt einen Zustand `state` (offene Wortliste, Entwurf: `draft`, `issued`) und `issued_at` (UTC-Ganzzahl). In v3 stand `owner_abzug` „nur bei ausgestelltem Dokument“, aber nichts löste das aus. Befehl `document.issue` (§6): setzt den Zustand, **friert ein** (danach lehnen `block.*`, `mark.*`, `style.*` Änderungen an diesem Dokument ab; eine Änderung ist eine neue Fassung als neues Dokument mit `derived_from`, Entwurf) und **füllt die `*_abzug`** der Personen-Verweise im Dokument (Erwähnungen, Autoren) nach der Feldliste je Dokumentart (ADR 0085 Datensparsamkeit). Aufbewahrung und Löschung des Abzugs: ADR 0085. **Offen:** (1) die Feldliste je Dokumentart für Protokoll und Beschluss gibt es noch nicht; (2) ob ADR 0108 einen Wechsel der Datenart **je Zeile** (content → record) zulässt oder ein eigener Datentyp nötig ist; (3) was `owner_abzug` bedeutet (der Besitzer-Schlüssel ist kein Inhalts-Verweis); (4) welche Rolle den Zustand setzen darf (Rechte, ADR 0104).
- **Ableitungen tragen die Herkunfts-Id (E9).** Jede Ableitung eines Dokuments trägt die Objekt-Id ihrer Herkunft (Spalte oder Eigenschaft `origin_object`; Name Vorschlag) und darf ohne sie nicht entstehen: Suchindex-Einträge, Vorschaubilder, zwischengespeichertes HTML (`content` des `Article`, `document.render`), der Loro-Puffer (`collab_buffer.doc_id`, ADR 0073), ausgegebene Exporte, die von `fs-site` gebauten Seiten. Beim Vergessen gehen sie mit. **Offen:** wie `fs-site` die Herkunfts-Id in der byte-reproduzierbaren Ausgabe trägt (Seitenverzeichnis, nicht im Seitentext).

## 4. JSON-LD-Kontext `fsd:` (Export, Entwurf)

```
@context: [ "https://www.w3.org/ns/activitystreams",
  { "fsd": "https://freesynergy.net/ns/document#",
    "oa":  "http://www.w3.org/ns/oa#",
    "xsd": "http://www.w3.org/2001/XMLSchema#",
    "fsd:children": { "@container": "@list" },
    "fsd:parent": {"@type":"@id"}, "fsd:style": {"@type":"@id"},
    "fsd:targetDoc": {"@type":"@id"}, "fsd:targetBlock": {"@type":"@id"},
    "oa:hasTarget": {"@type":"@id"}, "oa:hasSource": {"@type":"@id"}, "oa:hasSelector": {"@type":"@id"},
    "oa:start": {"@type":"xsd:nonNegativeInteger"}, "oa:end": {"@type":"xsd:nonNegativeInteger"},
    "fsd:level": {"@type":"xsd:integer"}, "fsd:marks": {"@container":"@set"} } ]
```
- Spalte → Term (feste Abbildung, 1:1), `ord` → Position in `@list`. Der Kontext soll aus den Tabellenbeschreibungen **erzeugt** werden (Ziel/Vorschlag, Muster ADR 0098 Punkt 2), nicht von Hand gepflegt.
- **Marken = W3C Web Annotation (v4 M3, ADR 0033, ADR 0014 Nr. 1).** v3 erfand `fsd:target`, `fsd:start`, `fsd:end`; das entfällt. Die Spalten von `doc_mark` bleiben, nur die Abbildung Spalte → Term ändert sich:

| `doc_mark` | Term |
|---|---|
| `id` | `id` der Annotation |
| `block_id` | `oa:hasTarget` → `oa:SpecificResource` mit `oa:hasSource` = IRI des Blocks (urn:uuid) |
| `start`, `end` | `oa:hasSelector` → `oa:TextPositionSelector` mit `oa:start`, `oa:end` |
| `art` | `type` der Marke (IRI aus `doc_word`, z. B. `fsd:Strong`); die Marke ist zugleich `oa:Annotation` (Mehrfachtyp, für fremde Leser **nicht geprüft**, siehe unten) |
| `wert`, `name`, `style`, `target_doc`, `target_block`, `path`, `title` | `fsd:`-Terme: Web Annotation hat dafür nichts, was ADR 0033 (Name, Typ, Wert im „Body“) 1:1 träfe |
| `href` | `href` |

  Beispiel einer Punkt-Marke (Platzhalter an Position 12 des Blocks): `{"type":["fsd:Variable","oa:Annotation"], "fsd:name":"Anrede", "oa:hasTarget":{"type":"oa:SpecificResource","oa:hasSource":"urn:uuid:…","oa:hasSelector":{"type":"oa:TextPositionSelector","oa:start":12,"oa:end":12}}}`. **Belegt** (Web Annotation Data Model, gelesen 23.11.): Zählung in Unicode-Codepunkten (passt zu den Skalaren aus ADR 0073), Anfang eingeschlossen, Ende ausgeschlossen. **Offen:** (1) ADR 0033 legt Name/Typ/Wert in den „Body“ (`oa:hasBody`, `TextualBody`); v4 folgt der Vorgabe des Review (`fsd:` nur für Art, Wert, Stilverweis) und hält den Body-Weg als Alternative offen; (2) der Standard erwähnt den Punkt (`start = end`) nicht ausdrücklich; (3) Standard-Selektoren für den Byte-Bereich im Original (`oa:DataPositionSelector`, im Standardtext vorhanden) werden **nicht** exportiert, `doc_source` bleibt innen (§3b).
- Das erzeugte `content` am `Article` (HTML, ammonia-gesäubert) ist der Rückfall für fremde Leser.
- Die Domain `freesynergy.net/ns/document#` ist hier Entwurf; Veröffentlichung des Kontexts (Dereferenzierbarkeit) **nicht geprüft**.
- Offen aus ENTSCHEID-baum §8: AS2-Mehrfachtypen für fremde Leser nicht geprüft.
- Änderungen im Log: AS2 `Add`/`Remove`/`Move`/`Update` mit Feld alt/neu (ADR 0086 Punkt 2); Anlegen `Create`; Sperren `Update`. **Der Akteur jedes Log-Eintrags kommt ausschließlich aus der Verbindung** (§7a), nie aus einem Feld der Anfrage.

## 5. Abbildung ODF ↔ OOXML ↔ CSS (Kernsatz)

**Belegt (23.11., gelesen):** OASIS ODF 1.3 Teil 3 (Schema), `https://docs.oasis-open.org/office/OpenDocument/v1.3/os/part3-schema/OpenDocument-v1.3-os-part3-schema.html`. Kapitel: **§16 Styles**, **§17 Formatting Properties Elements**, **§18 Datatypes**, **§19 General Attributes**, **§20 Formatting Attributes** (die frühere Angabe „§16 Datentypen“ war falsch; Datentypen = §18). Jede ODF-Nummer in der Tabelle wurde im Inhaltsverzeichnis dieser Seite nachgeschlagen (maschinell gesucht, Treffer je Attributname). Wo ein Attribut zugleich in §19 und §20 vorkommt (`style:num-format` 19.504/20.322, `style:width` 19.522/20.399, `fo:margin-left` 19.237/20.207, `fo:text-indent` 19.246/20.225, `fo:language` 19.236/20.202, `fo:country` 19.234/20.188), gilt für Formatierung die Nummer aus §20 (§19 ist die Attributdeklaration allgemein). Elemente: `style:style` 16.2, `style:page-layout` 16.5, `text:list-level-style-number` 16.34, `office:automatic-styles` 3.15.3, `style:paragraph-properties` 17.6, `style:table-properties` 17.15, `style:text-properties` 16.29.29 (laut Inhaltsverzeichnis; nicht in §17 einsortiert).

**Nicht belegt (Marke):** OOXML-Abschnitte (ISO/IEC 29500-1, Spalte „OOXML“) sind **aus Wissen, nicht gegen den Standardtext gelesen**; die Namen sind Stichprobe plausibel. Einheiten: ODF Länge mit Einheit (pt, mm, in, cm); OOXML twips (1/20 pt), `w:sz` in halben Punkten, Rahmen `w:sz` in Achteln eines Punkts, `w:tcW` auch `pct` (Fünfzigstel-Prozent), Bilder in EMU; in Strict `w:ind` `start/end` statt `left/right` (aus Wissen); CSS Länge. Wir speichern „wie gelesen“ + Einheit (ENTSCHEID-baum (b)).

Spalte „Rundlauf“ ist **Ziel, unbelegt** (Probe auf dem Korpus steht aus, §10 Punkt 6).

| Spalte (CSS-Name) | ODF (Eigenschaft, §) | OOXML (nicht nachgeprüft, ISO/IEC 29500-1) | CSS | Rundlauf (Ziel, unbelegt) |
|---|---|---|---|---|
| `font_family` | `style:font-name` 20.277 / `fo:font-family` 20.189 | `w:rFonts@w:ascii` (17.3.2.26) | `font-family` | Ziel ja; Design-Schriften (Theme) werden aufgelöst |
| `font_size` | `fo:font-size` 20.190 | `w:sz` (17.3.2.38, halbe Punkte) | `font-size` | Ziel ja |
| `font_weight` | `fo:font-weight` 20.193 | `w:b` (17.3.2.1) | `font-weight` | Ziel: nur normal/bold sicher |
| `font_style` | `fo:font-style` 20.191 | `w:i` (17.3.2.16) | `font-style` | Ziel ja |
| `underline` | `style:text-underline-style` 20.390 / `-type` 20.391 | `w:u` (17.3.2.40) | `text-decoration-line` | Ziel: nur einfach/doppelt |
| `line_through` | `style:text-line-through-style` 20.373 / `-type` 20.376 | `w:strike` (17.3.2.37) | `text-decoration-line` | Ziel ja |
| `color` | `fo:color` 20.187 | `w:color` (17.3.2.6) | `color` | Ziel ja (sRGB) |
| `background_color` | `fo:background-color` 20.182 | `w:shd@w:fill` (17.3.2.32 / 17.3.1.31) | `background-color` | Ziel ja |
| `highlight` | (kein eigenes ODF-Attribut; ODF-Import von Word-Hervorhebung wird als `fo:background-color` geschrieben, **Verlust** der Unterscheidung beim Rückweg nach OOXML, ungeprüft) | `w:highlight` (17.3.2.15, benannte Farbliste) | `background-color` | Ziel: Wort bleibt in Spalte `highlight`; nach ODF/CSS Verlust gemeldet |
| `vertical_align` | `style:text-position` 20.384 | `w:vertAlign` (17.3.2.42); LibreOffice schreibt auch `w:position` (17.3.2.24, laut PROBE §5) | `vertical-align` (+ kleinere Größe) | Ziel ja; ferrodoc-DOCX liest Sub/Sup aus ODT-Quelle richtig (PROBE §5); `w:position` von ferrodoc/pandoc vermutlich nicht gelesen (ungeprüft) |
| `font_variant` | `fo:font-variant` 20.192 | `w:smallCaps` (17.3.2.33) | `font-variant-caps` | Ziel ja |
| `text_align` | `fo:text-align` 20.223 (`start`/`end`) | `w:jc` (17.3.1.13) | `text-align` | Ziel ja; `left/right` ↔ `start/end` nach Schreibrichtung |
| `margin_*` | `fo:margin` 20.205, `fo:margin-left` 20.207, `fo:margin-top` 20.209 | `w:spacing@before/after` (17.3.1.33), `w:ind@left/right` (17.3.1.12) | `margin-*` | Ziel ja |
| `text_indent` | `fo:text-indent` 20.225 | `w:ind@firstLine/hanging` | `text-indent` | Ziel ja |
| `line_height` + `line_height_rule` | `fo:line-height` 20.204 (Vielfaches/fest), `style:line-height-at-least` 20.317 (mindestens), `style:line-spacing` 20.318 (Zusatzabstand) | `w:spacing@line` + `@lineRule` (`auto`/`exact`/`atLeast`) | `line-height` | Ziel ja: Regel als Wert + Art |
| `break_before/after` | `fo:break-before` 20.185 / `fo:break-after` 20.184 | `w:pageBreakBefore` (17.3.1.23) | `break-before` | Ziel: nur Seitenumbruch sicher |
| `keep_with_next` | `fo:keep-with-next` 20.201 | `w:keepNext` (17.3.1.15) | `break-after: avoid` | Ziel ja |
| `keep_together` | `fo:keep-together` 20.200 | `w:keepLines` (17.3.1.14) | `break-inside: avoid` | Ziel ja |
| `orphans`, `widows` | `fo:orphans` 20.214, `fo:widows` 20.228 | `w:widowControl` (17.3.1.44, nur an/aus) | `orphans`, `widows` | Ziel teilweise |
| `border_*`, `padding_*` | `fo:border` 20.183.2 (Familie `fo:border*`), `fo:padding` 20.217 | `w:pBdr` (17.3.1.24), `w:tcBorders` (17.4.66) | `border-*`, `padding-*` | Ziel: Linienarten nur Teilmenge |
| `width` (Tabelle, Spalte) | `style:column-width` 20.254, `style:width` 20.399 | `w:gridCol` (17.4.16), `w:tcW` (17.4.72) | `width` | Ziel ja |
| Spannen | `table:number-columns-spanned` 19.680, `table:number-rows-spanned` 19.682 | `w:gridSpan` (17.4.17), `w:vMerge` (17.4.85) | `colspan`, `rowspan` | Ziel ja |
| `numfmt` (Stil, `doc_style_list_level`), `start` (Block, `doc_list.start`) | `style:num-format` 20.322, `text:start-value` 19.874 (in `text:list-level-style-number` 16.34) | `w:numFmt` (17.9.17), `w:start` (17.9.25) | `list-style-type`, `<ol start>` | Ziel: Kernformate (1, a, A, i, I, •) |
| `page_width/height`, `orientation` | `fo:page-width` 20.216, `fo:page-height` 20.215, `style:print-orientation` 20.333 (in `style:page-layout` 16.5) | `w:pgSz` (17.6.13), `w:pgMar` (17.6.11) | `@page size/margin` | Ziel: Word↔ODT ja; HTML nur `@page` |
| `lang` (Block) bzw. Marke `Lang` | `fo:language` 20.202 + `fo:country` 20.188 | `w:lang` (17.3.2.20) | `lang` | Ziel ja; Ort nur am Block/an der Marke, nie im Stil (v4 M5) |
| Stilname | `style:name` 19.502, `style:display-name` 19.476 | `w:style@w:styleId` (17.7.4.17) | Klasse | Ziel ja |
| Vererbung, Folgestil, Familie | `style:parent-style-name` 19.510, `style:next-style-name` 19.503, `style:family` 19.480 (Element `style:style` 16.2) | `w:basedOn` (17.7.4.3), `w:next` (17.7.4.11), `w:type` | Kaskade | Ziel: Namen/Vererbung ja; CSS nur Klasse |
| direkte Formatierung | `office:automatic-styles` 3.15.3 | `w:rPr`/`w:pPr` am Lauf/Absatz | `style="…"` | über automatische Stile (§3) |

**Verlustfrei Ziel (zu belegen):** Gliederung, Stilnamen + Vererbung, Zeichen-/Absatzformat des Kernsatzes, Listen-Nummernformat, Tabellen mit Spannen, Fußnoten, Bilder mit Größe. **Verlustbehaftet:** Word-Designschriften/-farben, bedingte Tabellenformate, Textrahmen/Verankerung, Abschnitte/Spalten, Felder, Änderungsverfolgung; HTML→Office: Selektoren-Kaskade, Flex/Grid. **Nie:** gleicher Seitenumbruch/Zeilenfall, Makros, OLE, Skripte. (Alles aus ENTSCHEID-baum (b), hier nicht neu belegt.)

**Lesen alles, Schreiben nur offen (CLAUDE.md §8):** DOCX nur lesen; ODT, HTML, Markdown schreiben. DOCX-Schreiben wird nicht angeboten, auch wenn ferrodoc es kann.

## 6. Befehle und Schnittstellen (Vertrag aus Programmbefehlen, kein neuer Code)

Ein Vertrag `documents.capnp` (Entwurf; ersetzt `document @2 :Text` in `texts.capnp:86`, ADR 0104 E3: capnp-Datei-ID + Version). CLI, MCP (nur lokal/„nur Mensch“ wo Sicherheit) und Workflow-Bausteine sollen **aus dem Vertrag erzeugt** werden (Ziel/Vorschlag; ADR 0104 Offen 9 ist noch nicht entschieden), nicht von Hand geschrieben. **Kein Befehl hat einen Parameter „Akteur“, „Benutzer“ oder „updatedBy“** (§7a). Befehlsnamen im Stil `text.edit`/`text.history` des alten Vertrags:

| Befehl | Wirkung | Log |
|---|---|---|
| `document.create`, `document.get`, `document.list`, `document.delete` | Dokument-Objekt | `Create`/`Delete` |
| `document.tree` | Baum ab Block, mit Tiefe | – |
| `block.insert`, `block.update`, `block.move`, `block.delete` | Knoten (Eltern + `ord`) | `Add`/`Update`/`Move`/`Remove` |
| `mark.add`, `mark.remove` | stand-off Marke | `Create`/`Delete` |
| `style.define`, `style.apply` (auch aus einem Vorlagen-Dokument; Kopie vs. Verweis offen, §3a), `style.list` | Stile/Vorlagen | `Create`/`Update` |
| `document.import` (Quelle: Datei + Medientyp) | Adapter → Baum + Stile + Verlustmeldung; Original ablegen; Sicherheitsregeln §7c (Erlaubt-Liste, kein `data:`, kein Netz, Meldung für Verworfenes); Markdown: Schreibweise + Byte-Bereich nach §3b | `Create` |
| `document.export` (Ziel: `text/markdown`, `text/html`, `application/vnd.oasis.opendocument.text`, `application/ld+json`) | Baum → Ziel; Rohblock wörtlich nur ins gleiche Format, sonst Verlustwarnung (ADR 0084); Markdown byte-gleich nur mit vorhandenem Original, sonst regel-gleich (§3b); Marken als Web Annotation (§4) | – |
| `document.render` | gesäuberte HTML-Vorschau (ammonia) | – |
| `document.history`, `document.restore` | Verlauf/Wiederherstellen; **Rückgängig/Wiederholen für den Nutzer: genau ein Einstieg**, der Scaffold-Befehl „rückgängig“ (CLAUDE.md §8: Scaffold liefert es EINMAL); er delegiert an das Modul, im Modul `documents` liefert **Loro** den Verlauf (ADR 0073). Gespeicherte Historie bleibt das fs-objects-Aktivitätslog; **kein zweiter Stapel** daneben (alt: `text.history`) | `Update` |
| `document.lock` | Sperre | `Update` |
| `document.issue` | Zustand „ausgestellt“: friert ein, füllt `*_abzug` (§3d); nicht umkehrbar | `Update` |
| `document.query` | Suche/Filter über typisierte Spalten | – |

Zusammenhänge: Konflikt-/CAS-Verhalten (`editIf`, `editWith` im alten Vertrag) soll **übernommen**, nicht neu erfunden werden. Befehlsketten über Module (z. B. Website erzeugen) sind Workflows (ADR 0103).

## 7. Rechte und Sicherheit

### 7a. Akteur und Konformitätstests (Pflicht, behebt REVIEW MUSS 4/5)

**Akteur nur aus der Verbindung.** Wer eine Zeile anlegt/ändert/löscht und wer im Aktivitätslog (`Create`/`Add`/`Update`/…) steht, bestimmt der Moduldienst **ausschließlich** aus der Identität der Verbindung/Capability (ADR 0104 E4: „Der Zugriff läuft **immer** über den Vertrag mit der Identität der Person“; E7: „Der Treiber kennt die Person bei jedem Zugriff; der Vertrag prüft die Rechte“). Es gibt **kein Eingabefeld** für Akteur, Autor oder `updatedBy`; der alte Vertrag hatte `updatedBy @6 :Text` in `texts.capnp`, das im neuen Vertrag nicht vorkommt. Ebenso wenig wird der Akteur aus einem Startparameter oder einer Umgebungsvariable des Prozesses gelesen. KI-Zugriffe laufen über den Bot-Platz als eigener, gekennzeichneter Akteur (ADR 0104 E4, ADR 0091). Mutant für die Tests: ein Aufruf mit mitgegebenem fremdem Akteur muss ignoriert/abgelehnt werden und darf im Log nicht erscheinen → rot.

**Die drei Konformitätstests nach ADR 0104 E6 (Pflicht, je Treiber, Gerät und Server) und ein vierter, bedingt (ADR 0108 E9).** Wörtlich aus ADR 0104 E6 („Entschieden sind drei Konformitätstests, die **jeder Treiber** besteht, auf dem Gerät wie auf dem Server“; Wiederholung unter „Pflichttests“) und mit dem Personen-Schlüssel nach E7 („einem Personen-Schlüssel in jeder Zeile“):
1. **Export einer Person vollständig:** alle Zeilen dieser Person, keine fremden. Für `documents`: alle `doc_*`-Tabellen inkl. Untertabellen, `doc_style`, `doc_mark`, `doc_ref`, `doc_import_note`; Rückprüfung über `owner_*`.
2. **Keine fremde Zeile ohne Recht:** eine Person sieht ohne Recht keine Zeile einer anderen Person (Dokument, Marke, Verlustmeldung).
3. **Löschen einer Person vollständig:** nach dem Löschen bleibt keine Zeile dieser Person, auch nicht im Cache (auch kein Original, keine `doc_import_note`; ob Dokumente anderer, in die Stile kopiert wurden, unversehrt bleiben, hängt an §3a: die Kopie ist ein eigenes Objekt, Stile fremder Vorlagen bleiben unversehrt; bei Gruppeneigentum siehe §3 „offene Stelle“).
4. **Vergessen vollständig (bedingt, v4 M6):** nach dem Vergessenslauf ist eine eingesetzte Nadel weder in der Datei noch im WAL noch in einer Ableitung (Suchindex, Vorschau, zwischengespeichertes HTML, Loro-Puffer, Original, `doc_import_note`) zu finden, und die alte Datei ist mit dem neuen Schlüssel nicht lesbar (ADR 0108 E9, „vierter Test neben ADR 0104 E6“). Für `documents` zusätzlich: jede Ableitung trägt die Herkunfts-Id (§3d), sonst gilt der Test als nicht bestanden. **Bedingt:** gilt erst, wenn ADR 0108 angenommen ist (heute Entwurf); bis dahin ist er als Abnahmebedingung eingetragen, aber nicht Voraussetzung für „fertig“.
Diese drei sind Voraussetzung, um `documents` als fertig zu führen (Workflow `testlauf`, Stufe `ende`; CLAUDE.md §4); der vierte (bedingt, nach Annahme von ADR 0108) kommt dazu. Sie gelten zusätzlich zu den Sicherheitstests unten (XSS-Korpus). Der Vertrag trägt sie als Abnahmebedingung.

### 7b. Weitere Regeln

- **Rechte vorab per Vertrag** (SCIM/OAuth je Modul, ADR 0024/0104 E4): Rechte der Person, nicht des Programms; kein Programm liest die Domänen-Datei, nur der Besitzer-Dienst.
- **Rohblock:** wird im Programm **nie ausgeführt**, nur als Quelltext gezeigt. Wörtlich nach außen nur mit Schalter des Eigentümers **und** nur wenn der Block vom Site-Eigentümer stammt (ENTSCHEID-baum §5).
- **HTML:** jede Anzeige/jedes Teilen läuft durch `ammonia` (Allow-List; `script`, `on*`, `javascript:`/`data:`-URL fallen weg). Beleg warum nötig: ferrodoc reicht `RawInline`/`RawBlock` mit `<script>` im HTML-Ausgang unverändert durch (PROBE §5: pandoc-gleich, kein Upstream-Fehler; im ODT bleibt nur der Text); die Bereinigung ist **unser Adapter** (ammonia). Offen: ob ammonia **meldet**, was es entfernt (ENTSCHEID-html §7 „nicht gelesen“); sonst muss die Meldung der Adapter erzeugen. Test: XSS-Vektorenkorpus OWASP. Linkziele: nur Erlaubt-Liste, für alle Ausgaben (§7c (a)); die Regeln zu `data:`, Netzabruf, Meldungen und freien Zeichenketten stehen in §7c.
- **Skripte:** JavaScript wird nie als Dokumentinhalt gespeichert/ausgeführt; JS/CSS der Website sind unveränderte Dateien in fs-files (ENTSCHEID-html Richtung). ODF/DOCX-Makros und OLE werden beim Import verworfen und gemeldet.
- **Zip/XML-Eingang (ODT/DOCX):** Größe-/Anzahl-/Tiefen-Grenzen, Pfad-Traversal-Prüfung, keine externen Entitäten. Ob ferrodoc (zip 8, html5ever) das selbst begrenzt: **nicht geprüft**; der Adapter setzt Grenzen davor.
- **Sensibel-Markierung** (ADR 0029) am Dokument; **Verschlüsselte Felder** als Chiffrat-Spalten (ADR 0086 Nachtrag). **KI** als eigener Akteur, gekennzeichnet; keine KI-Schreibrechte ohne Einladung.
- **Windows:** ferrodoc ist reines Rust; Upstream-CI baut MSVC, lokal unbelegt (PROBE §1) → Branch-CI-Prüfung (Windows-Pflicht).

### 7c. Import-Sicherheit und Ausgabe-Säuberung (v4 M4; Befund: REVIEW-DOC-baum §4)

Grundsatz bleibt: Fremder Code wird **nie ausgeführt**, weder im Programm noch in der Vorschau. Der Import ist eine **Sicherheitsgrenze** (Sicherheitsmodul nach CLAUDE.md §4 Grenze 2: vor dem Release voller Test und Opus-Review HOCH). Die Regeln gehören ins Modell, sie sind keine Beigabe des Adapters. Aussagen zum Quelltext von ferrodoc sind dem Review entnommen (ferrodoc 1.0.1, Stellen unten), hier **nicht neu gelesen**.

| # | Regel | Umsetzung (nicht selbst bauen) | Test |
|---|---|---|---|
| (a) | **Links nur per Erlaubt-Liste, nie per Sperrliste.** Erlaubt: `http`, `https`, `mailto`, `tel`, `urn:uuid`, relativ und `#frag`. Alles andere (auch `javascript:`, `vbscript:`, `data:`, `file:`, verschleierte Schreibweisen) wird **abgelehnt und gemeldet**. Gilt für `doc_mark.href`, Bild-/Datei-Ziele und **alle** Ausgaben (HTML, ODT, Markdown), nicht nur den HTML-Weg | Crate `url` 2.5.9 (WHATWG-Parser, hängt schon an ammonia) | OWASP-XSS-Korpus (Link-Vektoren); Mutant „Sperrliste statt Erlaubt-Liste“ muss rot werden |
| (b) | **`data:`-URL wird nie in einer Spalte gespeichert** (`href`, `file_ref`, `doc_ref`). ferrodoc macht aus Inline-`<svg>` ein Bild mit `data:image/svg+xml`-URL (`ferrodoc-html/src/read.rs:588-594`, `:1396ff`); SVG kann Skript tragen. Die Bytes werden **Anhang-Kandidat in fs-files**; SVG nur gesäubert oder gerastert (fs-site lässt SVG schon nicht zu, ENTSCHEID-schnitt §5) | Adapter an der Grenze (ADR 0085) | SVG mit `<script>`/`onload` → kein Skript in Ausgabe und Ablage |
| (c) | **Kein Netzabruf beim Import.** Externe Bilder und Ressourcen bleiben Verweis mit Kennzeichen „extern“; Holen nur auf ausdrücklichen Befehl mit Größen- und Typgrenze, Ziel fs-files. Die Vorschau lädt nichts (ENTSCHEID-html §3.2). CSS `url()` fällt mit (e) weg | Adapter | Netz-Attrappe: 0 Abrufe bei Import und Vorschau |
| (d) | **Meldung für alles, was ferrodoc still verwirft oder umformt:** `script`, `style`, `head` (`ferrodoc-html/src/read.rs:255`, `:618`); unbekannte Elemente (`iframe`, `form`, `object` …, fallen in `_ => {}`); `meta`, `base`; Kommentare im Seiten-Modus (`read.rs:101-105`); verworfene CSS-Eigenschaften (§3 Abbildungsregel). Vor-Prüfung mit html5ever (über ferrodoc da): Liste der verworfenen Elementarten → `doc_import_note` (ADR 0086 P5, ADR 0084 Nachtrag 2 P5). Ob ammonia meldet, was es entfernt, ist **ungeprüft**; die Meldung erzeugt der Import, nicht ammonia | html5ever (Bestand), `doc_import_note` | Seite mit allen Elementarten: jede verworfene Art steht in der Meldung |
| (e) | **Freie Zeichenketten** (`font_family`, `doc_class.name`, `anchor`, `display_name`, `doc_style.name`) werden **beim Import geprüft** (Klasse = CSS-Bezeichner, Anker = gültige HTML-Id, Schrift = Schriftname ohne Steuerzeichen) und **bei der Ausgabe für das Ziel maskiert** (CSS: `cssparser::serialize_identifier`/`serialize_string`; HTML: ammonia; ODT/XML: quick-xml). `style="…"` wird mit `cssparser` 0.38 in die typisierten Spalten gelesen (nicht per Eigenbau); `url()`, `expression()`, `var()` fallen dabei weg, alles außerhalb des Kernsatzes → Meldung (d), nicht gespeichert (§3) | cssparser 0.38 (MPL-2.0, `deny.toml` erlaubt), ammonia 4.2.5, quick-xml | `font-family: "x;}body{…"` und `class="a b{…}"` → kein zweiter Regelblock in der Ausgabe |

Weiter gilt aus §7b: ammonia bei jeder Anzeige und beim Teilen; Rohblock nur als Quelltext; kein Rohblock `text/html` wörtlich in die Markdown-Ausgabe (Verlustwarnung statt wörtlich). Ausgabe nur aus typisierten Spalten (keine Zeichenkette in CSS ohne Maskierung); externe Links `rel="noopener noreferrer"` (ammonia-Voreinstellung); Ausgabe mit `Csp::Strict` (ENTSCHEID-html §3.3). **Offen:** Größen-, Knoten- und Markenzahl-Grenze beim Umsetzen in Zeilen (ferrodoc hat sie nicht; Eingabegröße 10 MiB wie `pass/fsx.rs:25` als Vorschlag, Tests: 100 000 verschachtelte `div`, 1 Mio. Marken, Zip-Bombe); Zeichensatz beim HTML-Import (`read_html(&str)` erwartet dekodierten Text); zwei html5ever-Versionen im Baum (ferrodoc-html 0.39, ammonia 0.40). Diese und die weiteren SOLL-Punkte des Review gehören in die Bauaufträge, nicht in dieses Modell.

## 8. Einordnung der lokalen Crates (lokaler Klon `fs-document`)

| Crate | Bleibt | Ersetzt ferrodoc / ammonia | Entfällt / wandert |
|---|---|---|---|
| **fs-document** (Bibliothek, Schicht 1, 7 621 Z. laut ENTSCHEID-schnitt) | Dokumentmodell, Marken-Stand-off (`mark`, `anchor`), Ops (`ops`); `history` (eigener Undo/Redo-Stapel) **entfällt** – ein Rückgängig für den Nutzer: der Scaffold-Befehl „rückgängig“ delegiert an das Modul, Loro liefert den Verlauf, die gespeicherte Historie ist das fs-objects-Aktivitätslog (§6), `links`, `component`, Markdown-Import/Export (pulldown-cmark, eigener Export vorerst) | Format-Leser/-Schreiber für ODT/DOCX/HTML kommen aus ferrodoc **hinter** einem Adapter (`Importer`/`Exporter`-Traits existieren schon, `format/`) | `doc/container.rs` (flache Stapel) wird **echter Baum** (Umbau, Daten werden nicht gerettet); `BlockAttrs.extra`, `heading_attrs` und `source` werden zu `doc_syntax_md` und `doc_source` (§3b, v4 M2); `FrontMatter` als Block → Dokument-Metadaten; `template` entfällt als Typ; eine Vorlage ist ein gewöhnliches Dokument mit Stilen (§3a); `BlockKind::Html` → `Raw{format,text,origin}` |
| **fs-document-html** | Seitenrahmen, Navigation, Theme (`frame.rs`, `nav.rs`, `theme.rs`), Passthrough für Nutzerdateien (`pass/`); laut ENTSCHEID-baum §4 gehören Rahmen/CSP/`pass/` konzeptionell zu fs-site (Ist-Ort ist das html-Crate: **Zuordnung beim Bau klären**) | `raw.rs` + `rawtag.rs` (ca. 299 Z.) → **ammonia**; HTML-Ausgabe des Inhalts (`render.rs`, `inline.rs`, `leaf.rs`, `table.rs`) → ferrodoc-html, **erst wenn der Rundlauf es belegt** (ENTSCHEID-baum §4) | wird zum **HTML-Adapter** (Einlesen, Säubern, Raw-Regeln) |
| **fs-site** | Erzeugung statisches Verzeichnis, byte-reproduzierbar, Menüs, Sprachen, Host/CSP; setzt Gestaltung (Dateien aus fs-files) + Inhalt zusammen | – | `site.toml` später in die DB; Lesen aus dem Modul über Port `SiteSource` → Adapter `StoreSource` im Moduldienst (ENTSCHEID-schnitt §1); eigener `raw.rs` (217 Z.) prüfen, ob ammonia reicht |
| (Eigenbau, der gar nicht mehr gebaut wird) | – | eigene ODF-Ausgabe, eigener Sanitizer, eigener DOCX-Leser | – |

Im neuen Zuschnitt: Bibliothek `fs-document` hängt an keinem fs-Crate (Länge/Farbe kommen als Bausatz aus fs-types erst im **Moduldienst**, der die Abbildung Bibliothek ↔ Spalten trägt, nicht in der Bibliothek); der **Dienst** (einziger Besitzer, ADR 0104) ist der Moduldienst `documents` in einem Gruppen-Repo (Name aus ENTSCHEID-schnitt: `fs-modules-documents`; im Original-Entscheid `fs-modules-publishing` verworfen). **Stil-Adapter nur für ODF** (`styles.xml`/automatische Stile): für **ODF** gibt es kein Crate (ferrodoc-odt reduziert Stile auf 6 AST-Merkmale; ENTSCHEID-baum (c)); zuerst UPSTREAM-ferrodoc-final.md Punkt 5 (Zugriff auf die geparste Stiltabelle) klären, erst bei Ablehnung eigener Code (kleines Projekt ist kein Gegenargument, CLAUDE.md §8). **Für OOXML gibt es keinen eigenen Adapter:** DOCX über ferrodoc, Lücken upstream (Punkt 1), Crates nur hinter dem Adapter (§8a). Nichts ist an ferrodoc gesendet (nur Entwurf).

## 8a. Word-Crates `ooxmlsdk` und `docx-rs` (geprüft 23.11., CLAUDE.md §8)

Quellen: crates.io-API, GitHub-READMEs (`KaiserY/ooxmlsdk`, `bokuweb/docx-rs`); **kein** Quelltext gelesen, kein Test gebaut. Cargo.toml von ferrodoc (`probe6/quelle/ferrodoc-1.0.1`, `ferrodoc-docx-1.0.1`): ferrodoc-docx hängt nur an `ferrodoc-ast`, `quick-xml` und `zip`; **ferrodoc nutzt weder `ooxmlsdk` noch `docx-rs`**.

| | `ooxmlsdk` 0.15.0 (03.11.2026) | `docx-rs` 0.4.22 (21.07.2026) |
|---|---|---|
| Lizenz | MIT OR Apache-2.0 | MIT |
| Lesen/Schreiben | beides: `WordprocessingDocument::new_from_file`/`save_as_file`, Rundlauf ganzer Pakete; typisierte Teile aus der Open-XML-SDK-Metadatei erzeugt | beides: `read_docx` liest in das Modell, `Docx::pack` schreibt; Fokus Erzeugen |
| Stile | ob `styles.xml`/`w:style`/`rPr`/`pPr` typisiert sind, **sagt die README nicht** (ungeprüft; wegen Erzeugung aus der SDK-Metadatei wahrscheinlich) | „styles“ als Fähigkeit genannt; Tiefe nicht beschrieben; README: „support is not exhaustive“ |
| Reife | vor 1.0, APIs ändern sich; 5 477 Korpusdateien ohne Fehler laut README; kein serde; unbekannte Elemente nicht editierbar | 0.4, 852 Commits, sehr verbreitet (3,99 Mio. Downloads), aber nur 0.4 |
| Erweiterbarkeit | Erweiterungs-/Wildcard-Inhalt bleibt erhalten | nicht beschrieben |

**Einordnung (Entscheidung, Entwurf):**
- **ferrodoc zuerst; `ooxmlsdk`/`docx-rs` nur hinter dem Adapter bei nachgewiesener Lücke** (Entscheid Strategie 23.11., CLAUDE.md §8; ersetzt das frühere „beide nicht nehmen"). Kein eigener OOXML-Adapter. Zur Abwägung: Wir brauchen vom Word-Format **nur Lesen** (DOCX schreiben bieten wir nicht an, §5) und davon nur Stilnamen, Vererbung und den Kernsatz der Eigenschaften (§3). ferrodoc-docx hat dafür schon `quick-xml` + `zip`, und der Stil-Zugriff kommt (wenn überhaupt) upstream (UPSTREAM-ferrodoc-final.md Punkte 1 und 5). Ein zweiter, großer Abhängigkeitsbaum (Abwägung, kein Verbot) (ooxmlsdk erzeugt den gesamten Standard) für ein Lesen von ein paar Stil-Elementen ist unverhältnismäßig; `docx-rs` ist auf Erzeugen ausgelegt.
- **Ausnahme/Wiedervorlage:** Sollen wir **DOCX schreiben** oder reicht ferrodoc nicht, ist `ooxmlsdk` der bessere Kandidat (Lizenz passt, schreibt typisiert, erhält Unbekanntes). Dann zuerst Probe: `styles.xml` einer LibreOffice- und einer Word-Datei lesen und `w:style`/`rPr`/`pPr` ausgeben (nicht getan).
- **Aufgabe vor jedem OOXML-Eigencode:** diese Probe (Stilnamen + Kernsatz lesen) gegen `ooxmlsdk` und ferrodoc-docx. Bis dahin steht in der Planung **kein** Eigencode für Word; ist die Lücke nachgewiesen, kommt zuerst ein Beitrag upstream, dann ein Crate hinter dem Adapter.

## 9. ferrodoc: was trägt, was nicht (Belege, Stand Nachprobe)

Quelle PROBE-ferrodoc.md, **§5 Nachprobe (N1, 23.11.)** eingearbeitet; bei Widerspruch zu §2/§4 der Probe gilt §5. Zusätzlich UPSTREAM-ferrodoc-final.md (gegen pandoc 3.7.0.2 geprüft: Punkte 1, 2, 4, 5 verhalten sich dort wie beschrieben, also ein **Wunsch**, kein ferrodoc-Fehler).
- **Trägt:** Lesen md/HTML/DOCX/ODT; Schreiben md/HTML/ODT; Pandoc-AST mit `RawBlock`, `Div`, `Span`, `Figure`, `Note`, `Attr`; ODT öffnet in LibreOffice; schnell; kein `unsafe` in den Bibliotheks-Crates.
- **Keine Lücken mehr (Bedienfehler der ersten Probe, PROBE §5):** (1) Bilder: `render_with_media` schreibt ODT-`Pictures/` + `draw:frame`, DOCX `word/media/`; `parse_with_media` liest DOCX-Bilder samt Bytes. (2) Stilvorlage: `render_with_reference` übernimmt `styles.xml` einer Vorlagen-`.odt` (ganze Vorlage, nicht je Block; DOCX-Vorlage nicht geprüft). (3) ODT-Tabellenkopf: `table:table-header-rows` wird geschrieben (Rahmen/Kopf-Stil kommt aus der Vorlage). (4) DOCX-Tabellenkopf/Tiefstellung: bei DOCX aus ODT-Quelle liest ferrodoc Kopf, Sub und Sup richtig; die erste Probe-Datei stammte aus LibreOffice-HTML-Import und hatte weder `w:tblHeader` noch `w:vertAlign` (nur `w:position`, §5-Tabelle). (5) DOCX-Code: wird wie bei pandoc nur über `Source Code`/`Verbatim Char` erkannt, nicht über LibreOffice „Preformatted Text“.
- **Echte Lücken (bestätigt, PROBE §5):**
  1. YAML-Kopf `tags: [a, b]` = **harter Fehler** („outside the YAML subset“); `tags:`+`- a` und `tags: a, b` gehen (UPSTREAM Punkt 4).
  2. **Fenced divs** `::: x` werden vom Markdown-Leser nicht gelesen (bleiben Absatztext), der Schreiber gibt sie aus: `Div → md → Div` geht nicht zurück (UPSTREAM Punkt 3). Das trifft unsere `fs-*`-Klassen (Aufgabe/Callout/Erwähnung) direkt: im Markdown-Weg über ferrodoc überleben sie nicht; Bracketed Span `[x]{.mark custom-style=".."}` wird gelesen.
  3. Der **ODT-Schreiber verwirft Div/Span-Attribute einschließlich `custom-style`**; der HTML-Leser behält `class`/`custom-style`, der HTML-Schreiber gibt `class` bzw. `data-custom-style` aus (UPSTREAM Punkt 2).
  4. **DOCX-Leser verwirft Stilnamen** (UPSTREAM Punkt 1 gilt **nur für DOCX**); der **ODT-Leser** verwirft sie ebenfalls, dafür gibt es **keinen** Upstream-Punkt (pandoc kennt dort kein `+styles`), das ODT-Stilnamen-Lesen bleibt beim ODF-Stil-Adapter (§8); Zugriff auf die geparste Stiltabelle fehlt (Punkt 5, Frage).
  5. **Rohes HTML:** `RawInline`/`RawBlock` mit `<script>` geht im HTML-Ausgang unverändert durch (auch `<div><script>`), im ODT bleibt nur der Text. Das ist **pandoc-gleich**, kein Upstream-Fehler; die Bereinigung ist **unser Adapter** (ammonia, §7).
  - Weiter offen aus der ersten Probe (nicht neu geprüft): gemischte Aufgabenliste wird in zwei Listen zerrissen; md-Schreiber Simple-Tables; `<details>` flach; Windows lokal unbelegt (Zweig-CI nicht gelaufen).
- **Folge für §3/§5:** Struktur über ferrodoc; Aufgaben/Callout/Erwähnung als `Div`/`Span`-Klassen `fs-*` **nur im HTML-Weg und in unserem eigenen Modell/Markdown-Eigenbau** (nicht über ferrodoc-md oder -odt, bis UPSTREAM Punkte 2/3 erledigt sind); Stile über eigenen Adapter. Das Aussehen-Modell hängt **nicht** von ferrodoc ab.
- **Rückfall** (ENTSCHEID-baum §6.6, `pandoc_ast`-Typen + eigener ODT-Writer mit quick-xml + zip) wird **erst erwogen, wenn upstream ablehnt** (CLAUDE.md §8).

## 10. Offen / unbelegt

1. ODF-Abschnittsnummern sind belegt (§5); **OOXML-Abschnitte/-Namen** (ISO/IEC 29500-1) und die Strict-Unterschiede bleiben **nicht nachgeprüft**; `style:family`-Werteliste 19.480 nicht vollständig gelesen.
2. (erledigt: ferrodoc-Nachprobe N1 ist in §9 eingearbeitet.)
3. Länge/Farbe als Bausatz in fs-types fehlen (ADR 0098 ergänzen).
4. Zuordnung `frame`/`nav`/`theme`/`pass` (html-Crate oder fs-site).
5. Ob ammonia Verluste meldet; Zip-/XML-Grenzen in ferrodoc.
6. Rundlauf Word ↔ ODT ↔ HTML auf dem Korpus: **nicht belegt** (Ziel, nicht Ergebnis). ODT→Baum→ODT verliert Layout (PROBE §3); die Aussage „verlustfrei“ in §5 gilt erst nach Probe mit eigenem Stil-Adapter.
7. Wort-/Tabellennamen (`doc_*`, `fsd:`-IRI) sind Vorschlag; Abnahme: Opus-Review (kein JSON/Blob, jede Spalte = AS2-Term).
8. ADR-Nachträge 0034/0072 (Block = eigenes Objekt, Profil statt Spezifikation), 0084 (Speicher = Baum, Rückgängig-Einstieg, geteilter Byte-gleich-Test) und 0073 (`doc_mark` = `text_mark`) liegen als Entwurf im Zweig `unreviewed/dok-baum-v4` von fs-documentation (v4); sie müssen **vor dem Speicher-Bau** landen. Status: nicht „vom Nutzer akzeptiert“.
9. Gruppen als Besitzer: entschieden als Auflösung über die Eigentümer (ADR 0095, kein eigener Schlüsseltyp, §3); **offen:** Verhalten der Konformitätstests dabei.
10. Probe `ooxmlsdk`/ferrodoc-docx auf `styles.xml` (§8a) steht aus; Quelle der im Auftrag genannten Datei `v5::kit::person_ref` nicht gefunden.
11. Spalten sind an ADR 0073 angeglichen (`art`, `wert`); der Tabellenname `doc_mark` ↔ `text_mark` und die Zusatzspalten (`name`, `href`, `target_*`, `path`, `title`) stehen im Nachtrag zu ADR 0073 (Entwurf, v4).
12. Vorlagen-Kopie und Gruppeneigentum sind entschieden (Nutzer 23.11., §3a). **OFFEN:** „Autor nimmt seinen Teil mit“ (§3a Punkt 3); vor dem Vertragsbau. Prüfen: Abbildung `derived_from` ↔ `prov:wasDerivedFrom`.
13. **v4, Offen aus M1:** Einsetzen als Blockart `fsd:Include` oder `doc_ref`-Art (§3c); Einsetzen eines Bereichs; festgehaltene Fassung; Rechte am eingesetzten Block; `rev`-Zählregel bei reiner Verschiebung (§3); Spalte `name` gegen ADR 0033 „Name/Typ/Wert im Body“ (§3, §4); Punkt-Marken im `LoroText` (ADR 0073 Nachtrag P6, Spike bei `CollabDoc`); Anzeige bei gelöschtem Linkziel und Links in andere Regale (§3).
14. **v4, Offen aus M2:** abschließende Spaltenliste von `doc_syntax_md` (am Markdown-Korpus); ob HTML/ODT eine `doc_syntax_<format>` brauchen; Verfahren und Spaltentyp des `seal`; ob ADR 0084 E5 die Teilung „byte-gleich / regel-gleich“ als Nachtrag bekommt (§3b).
15. **v4, Offen aus M3:** Body-Weg (`oa:hasBody`) als Alternative zu `fsd:value`/`fsd:name`; Punkt-Selektor im Standardtext nicht ausdrücklich; Mehrfachtyp `oa:Annotation` für fremde Leser nicht geprüft; Prüfung des Exports mit dem Crate `json-ld` 0.23 (nur Dev-Abhängigkeit, Gewicht und async-Zwang **ungeprüft**; Review SOLL 15).
16. **v4, Offen aus M4:** Knoten-/Marken-/Größengrenzen beim Umsetzen in Zeilen; Zeichensatz-Erkennung beim HTML-Import (Review SOLL 5: `encoding_rs`); zwei html5ever-Versionen (Review SOLL 3); ob ammonia meldet, was es entfernt (ungeprüft). Zuständigkeit: Bauaufträge 1 und 2 aus REVIEW-DOC-baum §5.
17. **v4, Offen aus M5:** Ort des Zählbeginns einer Liste (`doc_list.start` gegen ODF-Stufe, §3); Rundlauf der Abbildung ODF `text:start-value` ↔ `doc_list.start` ungeprüft.
18. **v4, Offen aus M6:** ADR 0108 ist Entwurf (alles in §3d und der vierte Test hängt daran); Datenart von `object_original` und `doc_import_note`; Wechsel `content` → `record` je Zeile oder eigener Datentyp; Feldliste je Dokumentart für Protokoll und Beschluss (ADR 0085); Bedeutung von `owner_abzug`; Rolle, die „ausgestellt“ setzen darf; Herkunfts-Id in der byte-reproduzierbaren `fs-site`-Ausgabe.
19. **Review-SOLL, nicht in v4 bearbeitet:** CSS ohne Eigenbau (nur als Verweis in §7c übernommen), Bruchindex-Crate für `ord`, Kante `fs-document` → `fs-types` (Strategie entscheidet; v3 lässt die Bibliothek ohne fs-Crates, §8), Längen-Einheiten `%`/`em`/`rem`/`auto`/`pct` und `doc_style_border`, Rohblock-`media_type` je Block aus `doc_raw`, „öffentlich“ über AS2-Adressierung (ADR 0020 Nr. 3), `urn:uuid` v7, Gestaltung aus HTML (zwei Ebenen: Dokument-Aussehen gegen Website-Gestaltung), Import über Module (ADR 0104 E9.1), weitere Leseformate (EPUB, RST, LaTeX, AsciiDoc, ipynb), ferrodoc-Grenzen (Review SOLL 14). Sie stehen im Review und werden mit den Bauaufträgen oder einem späteren Stand eingearbeitet.
