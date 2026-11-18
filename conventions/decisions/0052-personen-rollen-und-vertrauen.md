# 0052 – Eine Person mit Rollen; Rollen sind standardisiert oder selbst definiert; Vertrauen sichtbar machen

Status: akzeptiert (2026-11-06) · ergänzt ADR 0050 · öffentlich: `docs/en/interfaces/roles.md`

## Entscheidung (Nutzer)
1. **`fs-people` verwaltet alle Menschen, einmal je Person, mit mehreren Rollen** (Kontakt, Kunde, User …) statt Vererbung.
2. **Rollen dürfen und müssen Standards entsprechen, wo es sie gibt.** Sie werden vorher überlegt und öffentlich gemacht.
3. **Eigene Rollen sind möglich und genauso definiert** wie unsere.
4. **Wir brauchen etwas, das zeigt, wann ein Mensch sicher ist.** Das geht über Web of Trust. Es könnte auch gegen Betrug durch
   Bots helfen, etwa bei Telegram, sobald wir groß werden und zusammenarbeiten. Das Risiko von Sperren durch Telegram bei
   Userbots sagen wir ausdrücklich.

## Vorschlag (Opus)
- Trennung: **Beziehung** zu mir (vCard `RELATED`, JSContact `relatedTo`) und **Rolle** in einer Gruppe (W3C `org:Role`,
  `org:Membership`). „Freund“ ist damit genormt, „Kunde“ bleibt eine Lücke.
- `fs-people` hält die Person, der Besitzer der Rolle hält deren Felder.
- Vertrauen als eigene Schnittstelle im Katalog, Grundlage Web of Trust.

## Nachtrag (Nutzer, 2026-11-18): Vertrauen sichtbar machen ohne Web of Trust
Zeile 9 („Das geht über Web of Trust“) und Zeile 17 („Vertrauen als eigene Schnittstelle im Katalog, Grundlage Web of Trust“) entfallen. „Vertrauen sichtbar machen“ heißt ab jetzt **nur**: Vertrauen zeigt sich darin, dass sich Berechtigungen öffnen (Freigabe-Regeln), plus die Bestätigung, dass ein Schlüssel zu der Person gehört; **keine Zahl, keine Stufe, keine Anzeige über Menschen**. Gegen Betrug durch Bots helfen KI-Kennzeichnung und Bot-Platz nach ADR 0054/0091. Die Rollen (Entscheidung 1–3, Beziehung/Rolle im Vorschlag) bleiben unverändert. **Gestrichen:** Stufen, Prozente und Zahlen über Menschen sowie Web of Trust. **Bleibt (technisch, keine Bewertung):** (a) Bestätigung, dass eine Identität bzw. ein Schlüssel wirklich zu der Person gehört (z. B. Schlüsselvergleich beim Treffen, `fs-messages` vouch/Autocrypt); (b) Paket-Signaturstufen in `fs-packages` (TrustLevel = Vertrauen in **Software**, nicht in Menschen); (c) sachliche Vorgangsdaten (z. B. „Lieferung abgeschlossen“) dürfen sichtbar sein, werden aber **nie zu einer Personen-Zahl verdichtet**. Verweis: ADR 0102 Entscheidung 4.1 und Entscheid 46 (Nutzer, 18.11.2026; Begründung: quantifiziertes Vertrauen nimmt die Möglichkeit, jemanden neu kennenzulernen, macht die Vergangenheit zur Zukunft und hilft Masken).
