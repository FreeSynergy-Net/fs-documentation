# 0029 – Schutzbedürftige Daten müssen gekennzeichnet werden

Status: akzeptiert (2026-11-05) · Form der Kennzeichnung = Vorschlag · ADR 0019, 0020

## Kontext
Verknüpfen (gleiche Person in mehreren Programmen, `owl:sameAs`) soll es geben. Aber manche Daten
können Leben gefährden: sexuelle Orientierung aus einem Dating-Portal kann in Uganda die
Todesstrafe bedeuten. Verknüpfung + solche Daten = Gefahr.

## Entscheidung (Nutzer)
- Schutzbedürftige Daten **dürfen** gespeichert werden, **müssen** aber **gekennzeichnet** sein.
- Gleichheit zweier Kontakte heißt technisch `owl:sameAs` (AS2 `Relationship`).
- Absicherung ist mehrfach: OAuth/SSO (Login) + DID (Identität) + Web of Trust (Vertrauen) —
  die Kombination macht es; paarweise DIDs (RLTP) sind gewollt.

## Auch Geschäftsgeheimnisse (Nutzer, 2026-11-07)
Schützen muss man nicht nur Daten nach DSGVO Art. 9: „Stell dir vor, da werden Geschäftsgeheimnisse erzählt. Das kann das Unternehmen kaputt machen.“ Die Kennzeichnung braucht dafür eine eigene Kategorie; welche Bezeichnung, ist noch zu klären. Für KIs: ADR 0054.

## Vorschlag zur Umsetzung
- Kennzeichnung je **Feld oder Objekt** mit Kategorien der besonders geschützten Daten
  (DSGVO Art. 9: sexuelle Orientierung, Gesundheit, Religion, politische Meinung, Herkunft, …);
  Vokabular: W3C **Data Privacy Vocabulary DPV 2.3** (2026-02-25, Final CG Report ✅) —
  `dpv:SpecialCategoryPersonalData`, `pd:SexualPreference`, GDPR-Erweiterung mit Art. 9(2)(a)–(j).
- Gekennzeichnete Daten:
  1. werden **nie automatisch** verknüpft — der Hub schlägt keine `owl:sameAs`-Verbindung vor, die
     sie mit anderen Kontexten zusammenführt;
  2. verlassen das Gerät nur mit **ausdrücklicher** Freigabe je Empfänger;
  3. sind standardmäßig **verschlüsselt** gespeichert (ADR 0024);
  4. werden in Frontends sichtbar markiert.

## Nachtrag (Nutzer, 2026-11-18): Web of Trust entfällt als Absicherung
In Zeile 13 („OAuth/SSO (Login) + DID (Identität) + Web of Trust (Vertrauen)“) entfällt **Web of Trust (Vertrauen)**. Es bleiben OAuth/SSO und DID; paarweise DIDs sind weiter gewollt. **Gestrichen:** Stufen, Prozente und Zahlen über Menschen sowie Web of Trust. **Bleibt (technisch, keine Bewertung):** (a) Bestätigung, dass eine Identität bzw. ein Schlüssel wirklich zu der Person gehört (z. B. Schlüsselvergleich beim Treffen, `fs-messages` vouch/Autocrypt); (b) Paket-Signaturstufen in `fs-packages` (TrustLevel = Vertrauen in **Software**, nicht in Menschen); (c) sachliche Vorgangsdaten (z. B. „Lieferung abgeschlossen“) dürfen sichtbar sein, werden aber **nie zu einer Personen-Zahl verdichtet**. Verweis: ADR 0102 Entscheidung 4 (Vertrauen bleibt menschlich) und Entscheid 46 (Nutzer, 18.11.2026).
