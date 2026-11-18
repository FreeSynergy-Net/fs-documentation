# Gespräch 2026-11-18-people-gleiche-person

- **Id:** `2026-11-18-people-gleiche-person`
- **Datum:** 2026-11-18 (Entscheid des Nutzers)
- **Teilnehmer (Rollen):** Nutzer (entscheidet); Strategie (protokolliert)
- **Bezug:** Ausnahme `[[exception]]` in fs-people `scaffold.toml` (Abgleich „gleiche Person“, `matching/`; Vorschlag owl:sameAs); ADR 0058 (Kontakte sind Profile; Verknüpfen nur nach Rückfrage); ADR 0102 (Person zuerst); ADR 0103 Punkt 14 (Nummer 57)
- **Frage (Nummer 57):** Darf ein Programm von sich aus zwei Karten als dieselbe Person zusammenführen?

**Entscheid des Nutzers (Nutzerwort 18.11.2026):**
- Ein Hinweis „gleiche Person“ ist **immer nur ein Vorschlag**. Das Programm führt nie selbst zusammen.
- Dialog mit vier Antworten: **Ja**, **Nein**, **Für alle**, **Merken**.
  - **Für alle** gilt nur für diesen Lauf (die aktuelle Abfrage).
  - **Merken** legt eine sichtbare, widerrufbare Regel in den Einstellungen an.
- **Jede Verknüpfung ist lösbar.**

**Folge:**
- Die Ausnahme in fs-people bleibt mit diesem Gespräch als `talk`, bis der Dialog gebaut ist.
- Die technische Form (owl:sameAs oder ein eigener Verweis) ist offen; der Nutzer hat sie nicht entschieden. Das bleibt eine Ausnahme mit Verweis.

**Verweis:** ADR 0103 Punkt 14 (Nummer 57); ADR 0102 Punkt 4 (Kennen auf Gruppenebene) und ADR 0058.
