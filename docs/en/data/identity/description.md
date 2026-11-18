# Identity and key confirmation – description

**What this domain is:** the question of **whether a key really belongs to the person** — attestations between actors, keys, and the certainty that an account/the person really is who one takes them to be. Approach: **key confirmation at meetings in the real world** — the model is Anton's real-life project (`real-life-org/web-of-trust`), repo **reviewed on 2026-11-02**; all facts in the central register ([standards.md → follow-up research](../standards.md)).

**Core principle (from Anton's project, ✅ reviewed):** **Verification ≠ Trust.** Verification only confirms: "this really is that person" (personal meeting + QR scan). **Trust** we do not rate: no level, no number, no web of trust; it shows only in permissions opening (ADR 0102, decision 46). Confirmations are yes/no, not strength.

**What it covers:**

- Attestation objects: subject – relation – object, plus key, time, place/method of the meeting
- Key docking: `publicKey` on the actor, `cryptoKeys` in the contact card, `did:key` (from Anton's stack)
- Answering key questions: "does X have a confirmed key?" (yes/no; no strength, no chain as a value)

**Differentiation:**

| Layer | Domain | Mnemonic |
|-------|--------|----------|
| Access | [login/](../login/index.md) | a login proves **no** identity |
| Person data | [people/](../people/index.md) | what is known about the person |
| Self-image | [profile/](../profile/index.md) | what they show about themselves |
| **Key confirmation** | **identity/** | **does this key belong to this person?** |

**Standard status:** ❌ no established spec for key confirmation **in a standards body** was found. But: Anton's **WoT Spec v0.1.0-draft** (✅ repo reviewed) combines W3C **Verifiable Credentials**, **DIDComm v2.1**, **Ed25519**, **ECIES**; the successor **RLTP** (gen 3) lives in `real-life-org/trust-protocol`. That is our docking point — own/co-authored spec, spec candidate no. 2.
