# Identität und Schlüsselbestätigung – Technische Erklärung

## Grundsatz (Regel 1, vorläufig)

Bestätigungen sind **eigene Objekte**, keine Felder am Profil:

`Attestation = { attestierender Akteur, bezogener Akteur, Aussage (z. B. „hat Key K“, „ist Person P“), Schlüssel, Zeit, Treffens-Methode/-Ort (optional) }`

Das Objekt entspricht dem Attestation-Objekt in Antons Modell (✅ gesichtet 2026-11-02); dessen Ziel „reputation“ (Ruf) übernehmen wir **nicht** (ADR 0102, Entscheid 46). Eine Attestation sagt nur: dieser Schlüssel gehört zu dieser Person.

## Speicherperspektive

- **Tabelle `attestation`**: `id` (ULID), `subject` (wer bestätigt, IRI), `object` (wen/was, IRI), `claim_type` (Enum, eigene Festlegung: `person_key`/`identity_encounter`/`vouching`), `key_ref` (`publicKey`-ID des Objects oder `did:key`), `method` (`qr-in-person`/`remote`/…), `attested_at`, `place` (optional, Referenz auf [geodata/](../geodata/index.md)), `signature_ref`.
- **Keine Vertrauenswerte, keine Scores:** weder gespeichert noch berechnet (ADR 0102, Entscheid 46). Die Tabelle hält nur Bestätigungen („Schlüssel gehört zu Person“); `vouching` heißt: eine dritte Person bestätigt einen Schlüssel, keine Bewertung, ohne Anzahl und ohne Schwelle.

## Fluss im Envelope (Beschluss 2)

1. Zwei Personen treffen sich, scannen QR (Muster aus Antons Projekt).
2. Client erzeugt Attestation → `Create` auf einem **AS2-`Relationship`**-Objekt (✅ Vokabular gelesen): `subject` = Bestätigender, `relationship` = Aussage-Typ, `object` = Bestätigter.
3. Empfänger-Instanzen speichern die Attestation unverändert; Signaturprüfung nach Schlüsselrecherche (⚠️/❌ — Signatur-Mechanismen für ActivityPub sind bei uns noch **nicht belegt**, alte Referenz war 404; Antons Stack nutzt Ed25519/JWS als Indiz).

## Mapping-Skizze auf Antons WoT Spec (✅-Fakten aus standards.md; `mapping.md` noch offen)

| Stuck bei Anton | Bei uns |
|-----------------|---------|
| Attestation (Kernobjekt der WoT Spec) | AS2-`Relationship` + eigene Felder (`claim_type`, `method`) |
| `did:key` (Ed25519) | `publicKey` am Actor ↔ `cryptoKeys` in der Contact-Card |
| `wot-profiles` (JWS-signierte Profilveröffentlichung) | [profile/](../profile/index.md)-Projektion + Signatur (⚠️ Mechanismus offen) |
| UCAN-inspirierte Fähigkeiten | Autorisierungs-Schicht (Envelope/Instanz), nicht Datenmodell |
| RLTP (Gen 3) | beobachten; Migration folgt Gen 3 |

## Offene technische Punkte

- `identity/mapping.md` als eigene Datei erstellen (Auftrag aus [requirements.md §7](../requirements.md))
- Signatur-Mechanismus-Recherche (welcher ist real belegt?) — vor jeder Implementierung
- Verfallsfristen für Schlüsselbestätigungen (Schlüssel gewechselt, abgelaufen) als API, nicht als Schema; **keine Vertrauensketten als Wert**
