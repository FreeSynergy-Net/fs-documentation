# 0035 – Föderation zwischen Instanzen: OpenID Federation 1.0

Status: akzeptiert (2026-11-05) · ADR 0024, 0028, 0029

## Kontext
Der Nutzer will Listen, die wie ein Identity-Broker sagen, was Menschen und Gruppen dürfen; je mehr
Vertrauen, desto mehr Freigabe. **OpenID Federation 1.0** (final 2026-02-17,
`research/geodata-projects-profile-login.md`) beschreibt genau das.

## Entscheidung
- Föderation zwischen Instanzen über **OpenID Federation 1.0**:
  - **Trust Anchors** = unsere Vertrauenslisten,
  - **Trust Chains** = Vertrauen über mehrere Instanzen,
  - **Trust Marks** = Gütesiegel, u. a. Web-of-Trust-Stufen (RLTP),
  - Metadata Policy und automatische Registrierung zwischen Instanzen.
- Kanidm bleibt Identitäts-Provider (OAuth2/OIDC, Passkeys, SCIM); OpenID Federation kommt als
  Ergänzung daneben (Kanidm kann es nicht) — im Hub.
- Erfinden nur, was fehlt: ein **Trust-Mark-Profil** für Web-of-Trust-Stufen (eigene Spec).

## Nachtrag (Nutzer, 2026-11-16): Mandanten und Anmelde-Anbieter
- **Mandanten für alle:** Mandantenfähigkeit ist kein Enterprise-Merkmal, jede und jeder kann sie nutzen. Ein Mandant ist immer die **1. Ebene**, in Kanidm (oberste Gruppe) und in fs-groups. Wo er läuft (gemeinsames Programm, eigene Instanz, eigener Server), ist ein Workflow mit Umzugsweg; der Mandant selbst bleibt gleich.
- **Kanidm bleibt** Identitäts-Anbieter (ADR 0047). Die Mandantenschicht kommt in fs-identity. Broker und OpenID Federation folgen später als Rust-Crates. Unsere Lösung zeigen wir Kanidm offen; ob sie etwas übernehmen, entscheiden sie.
- **Anmelde-Anbieter:** Wir vertrauen nur Anbietern, die **offen, selbst betreibbar und föderiert** sind (OpenID Federation), z. B. andere FreeSynergy- oder Kanidm-Instanzen. Proprietäre Konzern-Anmeldungen (Google, GitHub/Microsoft, Meta, Apple …) unterstützen wir nicht. Die Regel betrifft die Anbieter, nicht die Menschen: Jede Person kann direkt ein Konto anlegen. Gründe: Datenschutz (kein Mitlesen der Anmeldungen durch Konzerne), keine fremde Sperrmacht über unsere Nutzer, DSGVO (Übermittlung in Drittländer), Föderation statt Zentralisierung.
- **Abgleich fs-identity (präzisiert ADR 0082):** Konten, die in Kanidm in einer unserer Gruppen stehen, in fs-groups aber nicht, werden **gemeldet, nicht entfernt**. Der Mandanten-Admin entscheidet: übernehmen oder entfernen.

## Nachtrag (Nutzer, 2026-11-18): keine Web-of-Trust-Stufen
Geprüft: **Trust Anchors** (Z. 12, Vertrauenslisten der Instanzen) und **Trust Chains** (Z. 13, Vertrauen über mehrere Instanzen) sind technische Instanz-Zuordnungen der OpenID Federation, keine Bewertung von Menschen; sie **bleiben**. Gestrichen werden: in Zeile 14 **„Trust Marks = Gütesiegel, u. a. Web-of-Trust-Stufen (RLTP)“** (keine Trust Marks für Stufen von Menschen; Trust Marks nur noch, falls sie technisch etwas anderes bestätigen, z. B. Instanz-Eigenschaften) und in Zeile 18 das **„Trust-Mark-Profil für Web-of-Trust-Stufen (eigene Spec)“**. Zeilen 6–7 („je mehr Vertrauen, desto mehr Freigabe“) lesen sich nach ADR 0102 Entscheidung 4: Vertrauen ist das Kennen, es zeigt sich nur in geöffneten Berechtigungen, nicht in einer Stufe. **Gestrichen:** Stufen, Prozente und Zahlen über Menschen sowie Web of Trust. **Bleibt (technisch, keine Bewertung):** (a) Bestätigung, dass eine Identität bzw. ein Schlüssel wirklich zu der Person gehört (z. B. Schlüsselvergleich beim Treffen, `fs-messages` vouch/Autocrypt); (b) Paket-Signaturstufen in `fs-packages` (TrustLevel = Vertrauen in **Software**, nicht in Menschen); (c) sachliche Vorgangsdaten (z. B. „Lieferung abgeschlossen“) dürfen sichtbar sein, werden aber **nie zu einer Personen-Zahl verdichtet**. Verweis: ADR 0102 Entscheidung 4 (Vertrauen bleibt menschlich) und Entscheid 46 (Nutzer, 18.11.2026).
