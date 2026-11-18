# Gespräch 2026-11-18-tasks-kosten

- **Id:** `2026-11-18-tasks-kosten`
- **Datum:** 2026-11-18 (Entscheid)
- **Teilnehmer (Rollen):** Nutzer (Nutzerwort); Strategie (Entscheid, protokolliert)
- **Bezug:** Ausnahme `[[exception]]` in fs-tasks `scaffold.toml` (Kosten, C17; `crates/fs-tasks-cli/src/args_work.rs:181-185`: `--cost` als USD-Zahl); ADR 0098 E3 (Bausatz Geld); ADR 0103 Punkt 8 und Punkt 11 (Nummer 55)
- **Frage (Nummer 55):** Wie werden Kosten und Aufwand eines Laufs erfasst, wenn es kein USD-Feld mehr geben soll?

**Entscheid (Nutzerwort 18.11.2026, Strategie 6e): Kein USD-Feld. Stattdessen Buchungen und Auswertung.**
- **Buchungen** (unveränderlich, nur anhängen) tragen die Rohwerte: **Zeit** (vom Lauf gemessen) und **Menge** (Aufwand, von Hand, Einheit frei; UCUM nur, wenn die Einheit dort vorkommt), dazu Stations- und Einsatzartfaktor, mitgespeichert.
- **Auswertung** ist eine eigene Sicht über die Buchungen, ändert keine Buchung und zeigt immer ihre Formel und daneben die Rohsummen Zeit und Menge. Gruppierung nach Person gibt es nicht.
- **Geld** ist optional und **abgeleitet**: Satz mal Zeit oder Festbetrag je Aufenthalt, Währung nach ISO 4217 (ADR 0098 E3). Niemand trägt Geld von Hand ein.
- **Faktoren** gehören der Station und der Einsatzart. Die Einsatzart hängt an der Beziehung (z. B. `org:Membership`), nie an der Person; Beispiel des Nutzers: ein Kassierer kann ehrenamtlich oder bezahlt sein; bei KI aus dem `BotRef`. Kein Faktor-Feld an Personen; ein Faktor mit `PersonRef`-Schlüssel wird abgelehnt. `org:Role` (ADR 0052) trägt keinen Faktor.
- **Korrektur** von Zeit und Menge nur per Gegeneintrag mit Begründung (`note`) und Verweis (`corrects`); der Gegeneintrag übernimmt die Faktoren des Originals. Wer korrigieren darf, legt die Workflow-Regel fest.
- Ein neuer Satz gilt ab der Änderung, nicht rückwirkend.
- **Energie wird nicht gemessen und nicht geschätzt.** Es gibt keine Meldung „keine Messquelle“.

**Folge:**
- `--cost` (USD) entfällt in fs-tasks.
- API-Kosten eines Agenten: Geld mit Festbetrag je Aufenthalt in USD, oder Menge mit der Einheit „USD laut Konsole“, wenn jemand die Zahl abliest.
- Die Ausnahme 55 bleibt im Bauplan, bis Lauf und Maß existieren (ADR 0103, Folgen, fs-flow).
- Offen: Einsatzart mit einem Mitglied in der Beziehung (ADR 0103 Offen 6).

**Verweis:** ADR 0103 Punkt 8 (Maß, Buchungen, Auswertung) und Punkt 9 (keine Summe je Person, Entscheid 46); ADR 0103 Punkt 11 (Nummer 55).
