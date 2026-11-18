# Gespräch 2026-11-18-tasks-kosten

- **Id:** `2026-11-18-tasks-kosten`
- **Datum:** 2026-11-18 (Entscheid des Nutzers)
- **Teilnehmer (Rollen):** Nutzer (entscheidet); Strategie (protokolliert)
- **Bezug:** Ausnahme `[[exception]]` in fs-tasks `scaffold.toml` (Kosten, C17; `crates/fs-tasks-cli/src/args_work.rs:181-185`: `--cost` als USD-Zahl); ADR 0098 E3 (Bausatz Geld); ADR 0103 Punkt 8 und Punkt 11 (Nummer 55)
- **Frage (Nummer 55):** Wie werden Kosten und Aufwand eines Laufs erfasst, wenn es kein USD-Feld mehr geben soll?

**Entscheid des Nutzers (Nutzerwort 18.11.2026): Kein USD-Feld. Stattdessen das Maß.**
- **Zeit** misst der Lauf automatisch (Beginn und Ende je Aufenthalt, UTC).
- **AUFWAND** trägt ein Mensch beim Abschließen eines Aufenthalts selbst ein, wenn es für Workflow, Liste oder Station eingeschaltet ist. Die **Einheit ist frei** (UCUM nur, wenn die Einheit dort vorkommt).
- **Geld** ist optional und **abgeleitet**: Satz mal Zeit oder Festbetrag je Aufenthalt, Währung nach ISO 4217 (Bausatz Geld, ADR 0098 E3). Niemand trägt Geld von Hand ein.
- Ein neuer Satz gilt ab der Änderung, nicht rückwirkend.
- **Faktor je Station (Gewichtung):** Gewichtete Summe = Σ (Zeit bzw. AUFWAND × Faktor der Station). Beispiel des Nutzers (nur Beispiel): Haiku ×1, Sonnet ×2,5, Opus ×5, Fable ×20. Der Faktor gehört der Station, nie einer Person (Entscheid 46). Geld kommt danach obendrauf.
- **Nur anhängen; Korrektur wie beim Kassenzettel:** Jeder Eintrag ist unveränderlich. Korrektur durch Gegeneintrag (negativer Wert) mit Pflicht-Begründung und Verweis auf den korrigierten Eintrag (ValueFlows `corrects`). Der Gegeneintrag übernimmt den Faktor des Originals. Was ValueFlows nicht regelt (negativer oder ersetzender Wert, Begründung, Faktor, Storno-Recht) ist unsere Regel (ADR 0103 Punkt 8).
- **Energie wird nicht gemessen und nicht geschätzt.** Es gibt keine Meldung „keine Messquelle“.

**Folge:**
- `--cost` (USD) entfällt in fs-tasks.
- API-Kosten eines Agenten: Geld mit Festbetrag je Aufenthalt in USD, oder Aufwand mit der Einheit „USD laut Konsole“, wenn jemand die Zahl abliest.
- Die Ausnahme 55 bleibt im Bauplan, bis Lauf und Maß existieren (ADR 0103 P4).

**Verweis:** ADR 0103 Punkt 8 (Maß, Faktor, Korrektur) und Punkt 9 (keine Summe je Person, Entscheid 46); ADR 0103 Punkt 11 (Nummer 55).
