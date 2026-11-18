# Gespräch 2026-11-18-tasks-pruefbefehl-policy

- **Id:** `2026-11-18-tasks-pruefbefehl-policy`
- **Datum:** 2026-11-18 (Entscheid des Nutzers)
- **Teilnehmer (Rollen):** Nutzer (entscheidet); Strategie (protokolliert)
- **Bezug:** Ausnahme `[[exception]]` in fs-tasks `scaffold.toml` (Prüfbefehl-Policy, C07/C08; `crates/fs-tasks-cli/src/check.rs`, `policy.rs`); ADR 0099 Entscheidung 1 (Pflicht `talk`); ADR 0103 Punkt 10 und Punkt 11 (Nummer 52)
- **Frage (Nummer 52):** Soll der Prüfbefehl in fs-tasks bleiben, und wie werden Sicherheitsregeln für Befehle geprüft?

**Entscheid des Nutzers (Nutzerwort 18.11.2026):** Der Prüfbefehl wird zu einem **Status-Befehl**. Er gibt nicht nur ja oder nein, sondern einen Status nach dem Muster der Monitoring Plugins (OK, WARNING, CRITICAL, UNKNOWN), Text und Messwerte. Kandidat für die Monitoring-Plugins-API, kein Eigenbau.

**Sicherheitsregeln gehören dem Workflow-Schritt**, nicht fs-tasks:
- nur Läufe mit lokalem Ursprung;
- nur Programme aus einer Liste, ohne Shell;
- Skripte nur unter `scripts/`;
- Zeitlimit (1 bis 3600 Sekunden).

**Folge:**
- Die Prüfung wandert aus fs-tasks heraus. Der Status-Befehl ist ein Schritt im Workflow (SW 1.0 `timeout`; FS-Profil `freesynergy.net:allow` und `freesynergy.net:origin`).
- Der Lauf (fs-flow) prüft die Regeln vor jeder Ausführung.
- Bis dahin bleibt die Ausnahme in fs-tasks mit diesem Gespräch als `talk`.

**Verweis:** ADR 0103 Punkt 10 (Status-Befehl) und Punkt 11 (Ausnahmen-Tabelle), Nummer 52. Ort des Codes nach ADR 0103 Folgen: fs-flow, sobald gebaut.
