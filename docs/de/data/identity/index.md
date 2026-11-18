# Identität und Schlüsselbestätigung

Gehört dieser Schlüssel wirklich zu dieser Person? Ansatz: **Schlüsselbestätigung beim Treffen in der realen Welt** (Vorbild: das externe Projekt Web of Trust bzw. RLTP; wir übernehmen davon nur den Treffen-Ablauf für die Schlüsselbestätigung, Standard in Arbeit). **Wir bestätigen Schlüssel, nicht Menschen:** keine Vertrauensstufe, keine Zahl, kein Vertrauensnetz (ADR 0102, Entscheid 46). Was bleibt: (a) die Bestätigung, dass ein Schlüssel/eine Identität zur Person gehört, (b) Paket-Signaturstufen in `fs-packages` (Vertrauen in Software), (c) sachliche Vorgangsdaten ohne Verdichtung zu einer Personen-Zahl.

## Bestand

| Stück | Beleg | Rolle bei FreeSynergy |
|-------|-------|-----------------------|
| ❌ **keine etablierte Spec für Schlüsselbestätigung im Standardisierungsgremium** | ❌ | eigene/mitgestaltete Spec — unser Spec-Kandidat Nr. 2 nach Block/Dokument |
| **WoT Spec v0.1.0-draft (real-life-org/web-of-trust)** | ✅ Repo gesichtet 2026-11-02 | kombiniert W3C Verifiable Credentials + DIDComm v2.1 + Ed25519 + ECIES; `did:key`; Grundsatz „Verification ≠ Trust“ (wir nutzen nur die Verifikation, nicht den Vertrauensteil); Nachfolger RLTP (Gen 3). Alle Fakten in [standards.md → Nachrecherche](../standards.md) — **nicht erneut herunterladen** |
| **AS2-Typ `Relationship`** (Vocabulary) | ✅ Vokabular gelesen | formaler Andockpunkt für Aussagen wie „A bestätigt, dass PGP-Key K zu B gehört“ |
| **AS2-Akteursschlüssel** | ✅ | `Multikey` (FEP-521a), `publicKey` alt — die Schlüssel, an die Bestätigungen andocken |
| **W3C DID Core 1.0** | ✅ Recommendation 2022-07-19 (DID 1.1: Candidate Recommendation 2026-03-05) | Identität über Instanzen hinweg (ADR 0024); Methode `did:key` (wie RLTP) |
| **W3C VC Data Model 2.0, Data Integrity 1.0, EdDSA-Cryptosuites, Controlled Identifiers 1.0** | ✅ Recommendations 2025-05-15 | Bestätigungen sind VC-2.0-Credentials mit `eddsa-jcs-2022`-Proofs (wie RLTP) |
| **RLTP Gen 3** (`real-life-org/trust-protocol`) | ✅ geprüft 2026-11-05: Editor's Drafts, Bibliothek 0.12.0 | Ed25519 `did:key`, **eigene Kennungen je Beziehung**, VC 2.0; Transport offen (erster Adapter ToIP TSP) |
| **HTTP Message Signatures, RFC 9421** | ✅ Feb 2024 | Signieren von Anfragen zwischen Instanzen; Mastodon prüft seit 4.5.0 |
| **FEP-8b32 Object Integrity Proofs** | ✅ Entwurf | Signaturen auf AS2-Objekten (Data Integrity, `eddsa-jcs-2022`) |
| **FEP-521a** | ✅ final 2025-06-14 | Akteursschlüssel als `Multikey` (ersetzt das alte `publicKey`) |
| **MLS, RFC 9420** | ✅ Juli 2023 | Gruppenverschlüsselung (ADR 0018); Bindung von MLS-Credentials an DIDs: ❌ kein IETF-Entwurf gefunden |

## Vorläufige Regeln

1. Bestätigungen sind **eigene Objekte** (Subjekt – Relation – Objekt + Schlüssel + Zeit + Ort/Methode des Treffens), nicht Felder am Profil.
2. Bestätigungen reisen im AS2-Envelope (`Create` auf einem `Relationship`-Objekt), damit der Austausch der Bestätigungen wie alle Daten läuft (Beschluss 2).
3. Ein „Login“ beweist keine Identität — Login ([login/](../login/index.md)) und Schlüsselbestätigung sind getrennte Schichten.

## Offene Punkte

- ~~Antons Repo sichten~~ → **erledigt 2026-11-02**, Fakten in standards.md; als `mapping.md` auf `Relationship`/`publicKey` abbilden ist noch offen
- ~~Signatur-Recherche~~ → ✅ 2026-11-05: RFC 9421, FEP-8b32, FEP-521a; Status DID Core/VC 2.0 ✅ (`research/contacts-identity-standards.md`)
- Schichten (ADR 0024): **Login** = Kanidm (OAuth2/OIDC, SCIM) · **Identität** = DID · **Schlüsselbestätigung** = Bestätigungen (VC 2.0), kein Vertrauen
- Pairwise DIDs (RLTP) vs. Hub-Zuordnung — offen

## Siehe auch

- [standards.md → Korrekturliste](../standards.md) (Signatur-Referenz 404)
- [profile/](../profile/index.md), [login/](../login/index.md)
