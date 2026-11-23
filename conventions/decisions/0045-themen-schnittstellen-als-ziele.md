# 0045 – Jedes Thema eine Schnittstelle; Schnittstellen sind Ziele; Hot-Plugins

Status: akzeptiert (2026-11-06) · Form der Plugins: Vorschlag · ergänzt ADR 0014, 0021, 0043

## Entscheidung (Nutzer)
1. **Jedes Thema bekommt eine eigene Schnittstelle**, ab sofort und für alles, was schon gebaut ist: Mail-Client,
   Mail-Server, Matrix, Telegram (auch wenn nicht selbst gehostet), Datenbank, Nachrichten, Dateien, Personen,
   Gruppen … Die Schnittstellen müssen gleich sein, damit man austauschen oder hinzufügen kann. Deshalb sind
   Standards absolut notwendig.
2. **Eine Schnittstelle ist ein Ziel und wächst nicht.** Wachsen hat keinen Endpunkt, ein Ziel schon. Muss sie sich
   ändern, ist das ein **Sprung**, kein Wachsen. Lose zusammenarbeitende Projekte wissen sonst nicht, wann sich was ändert.
3. **Plugins sind immer Hot-Plugins.**
4. Das Backend darf mehr können, als ein Frontend nutzt. Frontends mit eingebauten Filtern sind Mini-Server oder
   Engines (ADR 0021 weitergedacht).

## Vorschlag zur Umsetzung
- Katalog: `docs/en/interfaces/index.md`. Zwei Ebenen: Thema (Nachrichten) und Anbieter (Mail, Matrix, Telegram).
- **Korrektur des Nutzers (2026-11-06), ersetzt „Kern plus optionale Fähigkeiten“:** Wie eine Elternklasse: Jeder Anbieter bietet **alle** Methoden und Attribute. Fehlt einem Anbieter etwas, suchen wir einen Weg, es trotzdem umzusetzen. Geht das wirklich nicht, antwortet er ausdrücklich „nicht möglich“. Erst nachdenken, wie es geht, statt zu sagen, dass es nicht geht. Rust: Trait mit Standardmethode, die `Unsupported` liefert.
- Ablauf: Entwurf → mindestens zwei unabhängige Nutzer der Schnittstelle (bei Anbieter-Schnittstellen: zwei Anbieter) → 1.0 fest → danach nur Sprünge. Korrigiert 2026-11-06: Ein Thema hat nach ADR 0050 nur einen Besitzer, also kann nicht „zwei Umsetzungen“ die Bedingung sein.
- **Hot-Plugins nach dem Vorbild Zentinel** (Hinweis des Nutzers): Viele Schnittstellen sind nur Konfiguration, die geprüft und atomar getauscht wird. Größere sind Agenten: eigene, absturzsichere Prozesse über eine lokale Verbindung, die ihre Fähigkeiten melden. Bei uns mit Cap'n Proto. Zeichnet ein Agent, liefert er eine Szenenbeschreibung. Nicht gemessen, Textmessung ungelöst.
- **Öffentliches Repo `fs-interfaces`: vom Nutzer bestätigt.**
- Das Ziel darf schrittweise genauer werden, solange wir es nicht ganz kennen (Nutzer): erst Ziel festlegen, dann weitersehen.
- **Der Umbau gilt für alles, auch für Fertiges (Nutzer).**

## Folgen
- **ADR 0021** erlaubt Erweiterung ohne Bruch. Das bleibt technisch möglich, aber nach 1.0 ist es nicht mehr der Weg:
  Änderungen kommen als neue Version, mit Übergang, in dem beide angeboten werden.
- Die bestehenden Kerne werden gegen den Katalog geprüft und umgebaut.

## Nachtrag 2026-11-17 (Baukasten, Gespräch 2): Form der Plugins entschieden

Status: **akzeptiert** (Nutzer, Gespräch 1 und 2 vom 2026-11-17; Strategie) · **ändert** den Status „Form der Plugins: Vorschlag“ (Z. 3, Abschnitt „Vorschlag zur Umsetzung“ Z. 20) zu **entschieden** · baut auf ADR 0097

**Entscheidung**
1. **Zwei Stufen:** Konfigurations-Modul (Beschreibung, geprüft und atomar getauscht; Vorbild Zentinel, Z. 20) und Agenten-Modul (Code).
2. **Kommunikation nach Nähe** (Vorschlag des Nutzers mit Rückfrage, von der Strategie bestätigt): „die Sachen, die "Nah" an dem Modul sind, sind alle WebAssably, die, die ohne das Programm auskommen, sind capnproto - die, die ganz weit weg sind, sind capnproto, json, grpc - das klingt doch nach einem Plan, oder?“ Also: nah = **WebAssembly** (Host und Plugin-ABI nach Messung); ohne Programm lauffähig = eigener Prozess über **Cap'n Proto**; ganz weit weg = **Cap'n Proto, JSON, gRPC**.
3. **Prozess-Modell** (Entscheidung der Strategie, Gegenwort des Nutzers steht aus): einmal je Person und Vertragsversion, Start bei Bedarf, Ende nach Frist, eigene Rechte je Aufrufer (ADR 0097).
4. „Plugins sind immer Hot-Plugins“ (Z. 12) bleibt.

## Nachtrag 23.11.2026 (Entwurf): bis zu echten Nutzern kein `_vN` nebeneinander

Status: **Entwurf** (Nutzer-Entscheid A vom 23.11.2026, Lauflisten-Eintrag 05:31) · Fundstelle: `LAUFLISTE-strategie-2026-11-22.md` (05:31) und `woche-11-23/kalender/ENTSCHEID-schnitt.md` (Abschnitt „Widersprüche“)

- **Regel:** Bis es echte Nutzer gibt, liegt von einem Vertrag nur **eine** Fassung vor, **ohne `_vN` im Namen und ohne `_v1` und `_v2` nebeneinander**. Eine Änderung ersetzt den Vertrag, statt einen zweiten daneben zu legen; Sperren wie die Hash-Sperre von `groups_v1` gelten dafür nicht und sind durch Nutzerwort aufgehoben. Erst mit echten Nutzern wird neu entschieden, wie Versionen koexistieren.
- **Begründung des Ortes:** ADR 0045 legt fest, dass jedes Thema eine Schnittstelle ist und die Verträge in `fs-interfaces` liegen; die Regel betrifft genau diese Verträge. Sie gilt gleichlautend wie bei ADR 0064 (frühe Phase: Versionen springen), betrifft aber Vertragsnamen, nicht Paketversionen.
- **Folgen:** `groups` wird ein Vertrag (ADR 0095, Nachtrag), `events` entsteht ohne `_v1` (ADR 0050, Nachtrag). `person_directory_v1` wird **jetzt nicht** angefasst; eine Angleichung der Namen in einer Welle steht als Checklistenzeile für später.
- **Offen (Frage):** Gilt die Regel auch für Datenbankschemata und das Bauplan-Schema (ADR 0099 hat bereits `schema = 2` ohne Lesepfad für 1)? Die Quellen nennen nur Verträge. Ob dieser ADR oder ein eigener der richtige Ort ist, entscheidet der Nutzer.
