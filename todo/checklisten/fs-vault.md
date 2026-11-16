# fs-vault – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0067, ADR 0054, ADR 0086, E2, E4, E18; Strang-D-Plan `PLAN.md` Abschnitt 12 (Entscheidungen E1–E20)
Programm: Tresor: Passwörter, Schlüssel, Passkeys. Standards: KDBX 4.1; age (Backup); Argon2id (RFC 9106); WebAuthn L3 PRF / CTAP2 `hmac-secret`; TOTP RFC 6238; FIDO CXF/CXP; freedesktop Secret Service.
Die Strang-D-Dateien liegen bisher nur in Arbeitsstand der Strategie, nicht veröffentlicht und sind noch nicht in fs-documentation eingecheckt.

## Dossier und Vorbereitung
- [x] Erstes Dossier und Recherche vorhanden (Beleg: Arbeitsstand der Strategie, nicht veröffentlicht, `recherche-web-learning-vault.md`; nicht eingecheckt)
- [ ] **GRUNDSACHE** Dossier-Nachzug (E6, Lauf `dossier`) vor dem ersten Vorbild-Frontend; das Admin-Frontend darf vorher entstehen. Lücken: KeePassXC: Abschnittstexte und Kürzel (Seite 980 KB, nur Anfang gelesen); Bitwarden: Kürzel gegen offizielle Seite; Leer-/Fehlerzustände; Dialoge Passwort ändern; Apple-Vorbild (Apple Passwörter, 1Password) nicht recherchiert
- [ ] SPÄTER Dossiers nach fs-documentation übernehmen (Pfad [offen])

## Spikes, Recherchen, Nachträge
- [ ] **GRUNDSACHE** Spike E18: Dateiverschlüsselung durch fs-objects (ADR 0019 Punkt 2, ADR 0067)
- [ ] **GRUNDSACHE** Chiffrat als Bytes mit typisierter Struktur (`alg`, `nonce`, `ciphertext`, `key_ref`): ADR-0086-Nachtrag Ausnahme 2 (E4) ist in Commit 6e6bab51 eingetragen, Umsetzung im Kern offen
- [ ] SPÄTER Recherche TOTP, Secret Service (D-Bus), CTAP2-Client, KDBX 4.1 im `keepass`-Crate
- [ ] SPÄTER `webauthn-rs` (MPL-2.0) nur als unveränderte Abhängigkeit (E2)
- [ ] SPÄTER Linux als Passkey-Anbieter für Browser [offen, ADR 0067]
- [ ] **GRUNDSACHE** Sicherheits-Review vor jedem Release (Workflow `review`, Fokus Schlüsselmaterial)

## Trait festlegen
- [ ] **GRUNDSACHE** Trait-Skizze (Ziel v1, PLAN.md Abschnitt 12) prüfen und festlegen: `Vaults`, `Entries`, `Secrets`, `Generator`, `SecretProvider` (für andere Programme); `Exchange`. Stand: nur Skizze, nicht festgelegt
- [ ] **GRUNDSACHE** Wire-Vertrag `schema/<thema>.capnp` in fs-interfaces (ADR 0045)
- [ ] **GRUNDSACHE** Grenz-Trait `Exchange` mit Medientyp (E15, PLAN.md 1.4); Formate liefern Anbieter außerhalb der Traits
- [ ] Nicht Unterstütztes antwortet mit `Unsupported` (ADR 0045) und ist im Frontend sichtbar gesperrt (ADR 0066)

## Kern (typisiert nach ADR 0086, CLI)
- [ ] **GRUNDSACHE** Speicherung typisiert nach ADR 0086 gegen den v5-Entwurf von fs-objects im eigenen Zweig (E7): `vault`, `unlock_method`, `vault_folder`, `entry`, `entry_url`, `entry_tag`, `entry_secret`, `entry_secret_history`, `access_log`, `passkey` (später)
- [ ] **GRUNDSACHE** Keine JSON- und keine Blob-Spalten; Ausnahmen nur `original`, Medien als `FileRef` (E9), Chiffrat (E4)
- [ ] **GRUNDSACHE** Tresor anlegen, mit Passphrase sperren/entsperren, Auto-Sperre (Passphrase nie als Argument)
- [ ] **GRUNDSACHE** Einträge Login/Notiz anlegen, suchen, ändern, löschen; Ordner
- [ ] **GRUNDSACHE** Passwort-Generator
- [ ] **GRUNDSACHE** KDBX-Import/-Export, age-Backup
- [ ] **GRUNDSACHE** Zwischenablage nach Zeit leeren (Frontend); Beenden
- [ ] SPÄTER Ausfüllen im Browser (braucht fs-web, E10)
- [ ] SPÄTER Passkeys, Teilen, SSH-Agent, Secret-Service-Anbieter (`SecretProvider`)
- [ ] **GRUNDSACHE** CLI nach ADR 0063: `fs-vault new|unlock|lock|list|add|copy|generate|import|export|serve|admin`
- [ ] **GRUNDSACHE** Programm startet, kann einfache Dinge und lässt sich beenden (ADR 0087 Punkt 7)

## Frontend (Baustein-Zuordnung zuerst)
- [ ] **GRUNDSACHE** Schritt `baustein-zuordnung`: Baustein-Analyse vor dem Bauen; fehlende Bausteine entstehen in `fs-components`, nie im Programm (ADR 0066)
- [ ] **GRUNDSACHE** Bausteine fehlen: Passwortfeld mit Anzeigen-Schalter (`fields`), Dialog, Toast
- [ ] **GRUNDSACHE** Admin-Frontend aus der Typbeschreibung
- [ ] SPÄTER Frontend Einfach (Vorbild KeePassXC, Bitwarden), Apple-Stil (Apple Passwörter, 1Password) und Windows-Stil
- [ ] SPÄTER Kein Blinc-Standardlook: cn-Bausteine nur über Wrapper, je Stil gestylt (ADR 0074)

## Doku
- [ ] **GRUNDSACHE** Programmseite in fs-documentation (Workflow `doku-mitziehen`) und diese Liste mitziehen
- [ ] SPÄTER Handbuch, Beispiele, Facetten-Seiten

## Bilder und Abnahme
- [ ] **GRUNDSACHE** Bilder des Frontends: erst Bilder, dann Strategie-OK, dann Release
- [ ] SPÄTER Abnahme der Vorbild-Frontends durch Durchgehen der Arbeitsabläufe aus dem Dossier

## Repo anlegen (erst nach Strategie-OK)
- [ ] **GRUNDSACHE** Repo anlegen über `programm-neu` (E13: Bündel 0.0.7 zuerst mergen). Stand: Repo `fs-vault` existiert nicht (404 laut PLAN.md); Anlegen durch den Nutzer (E14)
- [ ] **GRUNDSACHE** Kern-Crate `fs-vault-core`, Bin `fs-vault`, `fs-vault-app` nach ADR 0063
