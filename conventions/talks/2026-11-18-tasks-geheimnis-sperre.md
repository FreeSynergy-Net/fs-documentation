# Gespräch 2026-11-18-tasks-geheimnis-sperre

- **Id:** `2026-11-18-tasks-geheimnis-sperre`
- **Datum:** 2026-11-18 (Entscheid des Nutzers)
- **Teilnehmer (Rollen):** Nutzer (entscheidet); Strategie (protokolliert)
- **Bezug:** Ausnahme `[[exception]]` in fs-tasks `scaffold.toml` (Geheimnis-Sperre, C11; `crates/fs-tasks-cli/src/secrets.rs:6-30` (Pfad laut scaffold.toml Z. 76)); ADR 0067 (Tresor); ADR 0100 (Einstellungen); ADR 0103 Punkt 11 (Nummer 53)
- **Frage (Nummer 53):** Wie wird verhindert, dass Geheimnisse (Tokens, Schlüssel) in Texteingaben landen, und wer besitzt die Regel?

**Entscheid des Nutzers (Nutzerwort 18.11.2026):**
- Die Geheimnis-Sperre ist ein **allgemeiner Baustein für alle Programme mit Texteingabe**, nicht nur für fs-tasks.
- Einstellbar: **aus**, **warnen**, **sperren**. Voreinstellung: **sperren**.
- Mustersatz: gitleaks-Regeln. **Lizenz vor Übernahme prüfen.**
- Angebot an die Person: „in den Tresor verschieben“ (ADR 0067).
- Die Karte kommt aufs Board.
- **Nicht vor V1.**

**Folge:**
- Die Prüfregel wird ein Art-2-Modul (Modul-Bausatz nach ADR 0101, weil mehrere Programme sie brauchen: tasks, texts, messages).
- Die Anzeige ist eine Component mit Hinweis und dem Tresor-Angebot.
- Bis der Baustein existiert, bleibt die Ausnahme in fs-tasks mit diesem Gespräch als `talk`.

**Verweis:** ADR 0103 Punkt 11 (Nummer 53); ADR 0067; ADR 0100 (Einstellung aus / warnen / sperren).
