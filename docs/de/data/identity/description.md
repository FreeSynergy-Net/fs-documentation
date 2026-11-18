# Identität und Schlüsselbestätigung – Beschreibung

**Was diese Domäne ist:** die Frage, **ob ein Schlüssel wirklich zu der Person gehört** — Bestätigungen (Attestations) zwischen Akteuren, Schlüssel und die Gewissheit, dass ein Konto/die Person wirklich die ist, für die man sie hält. Ansatz: **Schlüsselbestätigung beim Treffen in der realen Welt** — Vorbild ist Antons Real-Life-Projekt (`real-life-org/web-of-trust`), Repo **gesichtet am 2026-11-02**; alle Fakten im zentralen Register ([standards.md → Nachrecherche](../standards.md)).

**Kernprinzip (aus Antons Projekt, ✅ gesichtet):** **Verification ≠ Trust.** Verifikation bestätigt nur: „Das ist wirklich diese Person“ (persönliches Treffen + QR-Scan). **Vertrauen** bewerten wir nicht: keine Stufe, keine Zahl, kein Vertrauensnetz; es zeigt sich nur darin, dass sich Berechtigungen öffnen (ADR 0102, Entscheid 46). Bestätigungen sind Ja/Nein, nicht Stärke.

**Was sie abdeckt:**

- Bestätigungs-Objekte: Subjekt – Relation – Objekt, plus Schlüssel, Zeit, Ort/Methode des Treffens
- Schlüssel-Andockung: `publicKey` am Actor, `cryptoKeys` in der Contact-Card, `did:key` (aus Antons Stack)
- Schlüsselfragen beantworten: „Hat X einen bestätigten Schlüssel?“ (Ja/Nein; keine Stärke, keine Kette als Wert)

**Abgrenzung:**

| Schicht | Domäne | Merksatz |
|---------|--------|----------|
| Zugang | [login/](../login/index.md) | Ein Login beweist **keine** Identität |
| Mensch-Daten | [people/](../people/index.md) | Was über die Person bekannt ist |
| Selbstbild | [profile/](../profile/index.md) | Was sie von sich zeigt |
| **Schlüsselbestätigung** | **identity/** | **Gehört dieser Schlüssel zu dieser Person?** |

**Standard-Status:** ❌ keine etablierte Spec für Schlüsselbestätigung **im Standardisierungsgremium** gefunden. Aber: Antons **WoT Spec v0.1.0-draft** (✅ Repo gesichtet) kombiniert W3C **Verifiable Credentials**, **DIDComm v2.1**, **Ed25519**, **ECIES**; Nachfolger **RLTP** (Gen 3) in `real-life-org/trust-protocol`. Das ist unser Andockpunkt — eigene/mitgestaltete Spec, Spec-Kandidat Nr. 2.
