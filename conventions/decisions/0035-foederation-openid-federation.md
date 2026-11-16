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
