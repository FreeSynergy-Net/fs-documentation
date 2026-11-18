# Gespräch 2026-11-18-tasks-kosten

- **Id:** `2026-11-18-tasks-kosten`
- **Datum:** 2026-11-18 (Entscheid)
- **Teilnehmer (Rollen):** Nutzer (Nutzerwort); Strategie (Entscheid, protokolliert)
- **Bezug:** Ausnahme `[[exception]]` in fs-tasks `scaffold.toml` (Kosten, C17; `crates/fs-tasks-cli/src/args_work.rs:181-185`: `--cost` als USD-Zahl); ADR 0098 E3 (Bausatz Geld); ADR 0103 Punkt 8 und Punkt 11 (Nummer 55)
- **Frage (Nummer 55):** Wie werden Kosten und Aufwand eines Laufs erfasst, wenn es kein USD-Feld mehr geben soll?

**Entscheid (Nutzerwort 18.11.2026, Strategie 6e): Kein USD-Feld. Der Lauf sammelt, fs-invoices rechnet.**
- Der **Lauf** sammelt nur **Buchungszeilen** (unveränderlich, nur anhängen). Er rechnet nichts: keine Summen, keine Formeln, keine Auswertung.
- Eine Buchungszeile trägt: **Zeit** (vom Lauf gemessen), **Menge** (frei, freie Einheit; UCUM nur, wenn die Einheit dort vorkommt), **eigenen Faktor oder Satz**, Station, **Rolle** als Abzug (Mitgliedschaft mit Zeitraum plus Rollenname; Verweis auf `org:Role` nach ADR 0052, nur Kontext; kein Faktor an der Rolle), Akteur (Person oder Bot, gleich behandelt) und den Zeitpunkt.
- Der **Faktor hängt an der Zeile**, nicht an Person, Rolle oder Einsatzart. Beispiel des Nutzers: tagsüber 15 €, nachts 20 €, dieselbe Person in derselben Rolle. Voreinstellungen dürfen beim Anlegen einen Faktor vorschlagen; gespeichert wird der Wert der Zeile.
- **Korrektur** von Zeit und Menge nur per Gegeneintrag mit Begründung (`note`) und Verweis (`corrects`); der Gegeneintrag übernimmt den Faktor des Originals. Wer korrigieren darf, legt die Workflow-Regel fest.
- **Jede Rechnung oder Auswertung macht fs-invoices** (ADR 0087), mit oder ohne Geld. Die Rechnungsvorlage legt die erlaubten Formeln fest. Die Formel entscheidet, was zählt: Satz je Rolle (z. B. Gehalt), Faktor der Zeile (Vorrang) oder beides kombiniert; die Rangfolge steht in der Vorlage und wird neben Formel und Rohwerten angezeigt; jede Ausgabe zeigt Formel und Rohwerte Zeit und Menge.
- **Energie wird nicht gemessen und nicht geschätzt.** Es gibt keine Meldung „keine Messquelle“.

**Folge:**
- `--cost` (USD) entfällt in fs-tasks.
- API-Kosten eines Agenten: Geld als Festbetrag je Zeile in USD, oder Menge mit der Einheit „USD laut Konsole“, wenn jemand die Zahl abliest; Rechnung über fs-invoices.
- Die Ausnahme 55 bleibt im Bauplan, bis Lauf und fs-invoices existieren (ADR 0103, Folgen, fs-flow und fs-invoices).
- fs-invoices darf je Akteur summieren, nur auf ausdrücklichen Aufruf und mit Rechten vorab per Vertrag; Formel und Rohwerte bleiben sichtbar. Präzisierung von ADR 0102 E4 (c), bestätigt 19.11.2026; ADR 0102 wird beim nächsten Doku-Lauf nachgetragen.
- Offen: Offen-Notiz (ADR 0103 Offen 6).

**Verweis:** ADR 0103 Punkt 8 (Buchungszeilen, fs-invoices) und Punkt 9 (keine Summe je Person ohne Aufruf, Entscheid 46); ADR 0103 Punkt 11 (Nummer 55).
