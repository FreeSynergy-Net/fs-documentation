# Gespräch 2026-11-18-tasks-ausfuehrungsfelder

- **Id:** `2026-11-18-tasks-ausfuehrungsfelder`
- **Datum:** 2026-11-18 (Entscheid des Nutzers)
- **Teilnehmer (Rollen):** Nutzer (entscheidet); Strategie (protokolliert)
- **Bezug:** Ausnahme `[[exception]]` in fs-tasks `scaffold.toml` (Ausführungsfelder, C09; `crates/fs-tasks-core/src/model/exec.rs:13-28`: `run`, `result`, `attempts`, `error`, `loop`, dazu `template`, `claim`); ADR 0076 (Ablauf und Ziel); ADR 0086 (typisierte Speicherung); ADR 0103 Punkt 13 (Nummer 56)
- **Frage (Nummer 56):** Gehören die Ausführungsfelder an die Aufgabe oder an den Lauf?

**Entscheid des Nutzers (Nutzerwort 18.11.2026): Die Ausführungsfelder gehören dem Lauf.**
- Der **Lauf** ist ein eigenes Objekt (Modul `fs-flow`, Arbeitsname). Er trägt Ergebnis je Versuch, Versuche je Station, letzten Fehler (Problem-Typ-URI), Durchlaufnummer.
- Die Abbildung: W3C PROV-O (Lauf als Activity mit Plan), dazu der AS2-Verlauf (`Move` mit `origin` und `target`).
- `template` wird `hadPlan` (Verweis auf den Workflow in einer Version).
- `claim` geht nach fs-planning (`claim`), nicht in den Lauf.

**Folge:**
- In fs-tasks entfallen die Felder aus `exec.rs`.
- Die Ausnahme bleibt im Bauplan, mit Verweis auf dieses Gespräch, bis fs-flow existiert.

**Verweis:** ADR 0103 Punkt 13 (Nummer 56); ADR 0103 Abschnitt „Standards“ (PROV-O als Abbildung beim Export, nicht als Speicherform).
