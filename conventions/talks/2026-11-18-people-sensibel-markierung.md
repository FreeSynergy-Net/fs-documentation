# Gespräch 2026-11-18-people-sensibel-markierung

- **Id:** `2026-11-18-people-sensibel-markierung`
- **Datum:** 2026-11-18 (Entscheid des Nutzers)
- **Teilnehmer (Rollen):** Nutzer (entscheidet); Strategie (protokolliert)
- **Bezug:** Ausnahme `[[exception]]` in fs-people `scaffold.toml` (Karte `card/vendor.rs`; sensible Markierung; Vorschlag DPV-Kategorien (W3C Community Group DPVCG, keine W3C-Empfehlung)); ADR 0029 (gekennzeichnete Daten verlassen das Gerät nur mit Freigabe je Empfänger); ADR 0102 (Freigabe-Regeln vorab); ADR 0103 Punkt 14 (Nummer 58)
- **Frage (Nummer 58):** Wie werden sensible Angaben über Personen gekennzeichnet, und wer entscheidet, wer sie sieht?

**Entscheid des Nutzers (Nutzerwort 18.11.2026):**
- Ein **Schutz-Baustein** mit den **DPV-Kategorien** (Data Privacy Vocabulary, W3C Community Group DPVCG, keine W3C-Empfehlung) kennzeichnet sensible Angaben.
- **Die Freigabe je Empfänger bleibt unsere Regel** (ADR 0029, ADR 0102). Der Standard beschreibt die Kategorie, nicht die Freigabe.

**Folge:**
- Die Ausnahme in fs-people bleibt mit diesem Gespräch als `talk`, bis der Baustein existiert.
- Die DPV-Kategorien sind ein Standard-Kandidat; ihre Eignung (Logik und Qualität, ADR 0102 Entscheidung 9) ist beim Bau zu prüfen.

**Verweis:** ADR 0103 Punkt 14 (Nummer 58); ADR 0029; ADR 0102 Entscheidung 2 und 3.
