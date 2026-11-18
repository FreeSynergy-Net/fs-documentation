# 0024 – Programm ohne Hub: lokale Daten, Verschlüsselung, Schlüsseltresor, SCIM

Status: akzeptiert (2026-11-05) · Protokoll §3, §21.3 · ADR 0015, 0019

## Entscheidung
- Ein Programm **ohne Hub** speichert lokal, **wahlweise verschlüsselt** (Einstellung).
- **Schlüsseltresor** (eigene Workbench und/oder eigenes Programm, noch zu bauen): nimmt die
  Schlüssel auf; kann sie mit Kanidm abgleichen oder nicht — dann nur auf diesem Rechner.
- **Jedes Programm kann OAuth2, SSO und SCIM** von Haus aus, ohne Umweg.
- Wer Daten hinter einer Wand (Firewall, Mehrbenutzer) betreiben will, installiert den Server
  (Hub + Kanidm). **Mehrere Mandanten in einer Instanz** über OAuth2/SSO — mehrere Instanzen sind
  möglich, aber nicht nötig (Korrektur 2026-11-05). Kanidm läuft im Server und wird über seine
  REST-API gesteuert; was Kanidm (noch) nicht kann, programmieren wir dazu.
- **Niemals Paywall** (ADR 0016).
- Zwischen Instanzen: **DID** als Identität, **Web of Trust** als Vertrauensstufen; Föderation
  über Listen, die wie ein Identity-Broker sagen, was Menschen/Gruppen dürfen — je mehr
  Vertrauen, desto mehr Freigaberegeln.

## Folgen
- Neue Kategorie für den Schlüsseltresor (Programm und/oder Workbench) planen.
- **Korrektur 2026-11-05 (Nutzer):** Kanidm hat seit **1.7.0 eine volle SCIM-API** (GET, PUT, POST,
  Pagination, Sorting, Batch; PRs #3151, #3359, #3535, #3700, #3725, #3741, #3748, #4271). Die Kanidm-Doku
  („nur Synchronisation“) ist veraltet — Issue kanidm#4638 (vom Nutzer); Maintainer 2026-10-28: noch
  nicht dokumentiert, **weil sich die Form der API noch ändert**. → Kein eigener SCIM-Server; Kanidm-SCIM
  hinter unserer Abstraktion nutzen, bis die API stabil ist. Kanidm kann kein OpenID Federation →
  Ergänzung neben Kanidm (ADR 0035).

## Nachtrag (Nutzer, 2026-11-18): Web of Trust als Vertrauensstufen entfällt
Zeile 15 („**Web of Trust** als Vertrauensstufen“) und Zeile 17 („je mehr Vertrauen, desto mehr Freigaberegeln“, soweit als Stufenrechnung gelesen) gelten nicht mehr als Stufen. Vertrauen bleibt rein menschlich und zeigt sich nur darin, dass sich Berechtigungen öffnen (Freigabe-Regeln). **DID als Identität** bleibt. **Gestrichen:** Stufen, Prozente und Zahlen über Menschen sowie Web of Trust. **Bleibt (technisch, keine Bewertung):** (a) Bestätigung, dass eine Identität bzw. ein Schlüssel wirklich zu der Person gehört (z. B. Schlüsselvergleich beim Treffen, `fs-messages` vouch/Autocrypt); (b) Paket-Signaturstufen in `fs-packages` (TrustLevel = Vertrauen in **Software**, nicht in Menschen); (c) sachliche Vorgangsdaten (z. B. „Lieferung abgeschlossen“) dürfen sichtbar sein, werden aber **nie zu einer Personen-Zahl verdichtet**. Verweis: ADR 0102 Entscheidung 4 (Vertrauen bleibt menschlich) und Entscheid 46 (Nutzer, 18.11.2026). Satz 9 („kann OAuth2, SSO und SCIM“) wird durch ADR 0102 Entscheidung 2 zur Pflicht je Programm.
