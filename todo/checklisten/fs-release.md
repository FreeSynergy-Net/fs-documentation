# fs-release – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0087 Punkt 3, 7; Review `/srv/FreeSynergy/.scratch/review-bundle-0.0.7-opus-r2.md`; Repo `/srv/FreeSynergy/fs-release`
Tags: `v0.0.1` bis `v0.0.6` (v0.0.6 auf `origin/main` 94b6551, 2026-11-13). Das Bündel 0.0.7 liegt auf `origin/unreviewed/bundle-0.0.7` (Kopf c915430) und ist nicht auf `main`.

## Erledigt (Beleg)
- [x] **GRUNDSACHE** Gemeinsame Bau-Workflows (CI und Release), Signaturschlüssel, Tags 0.0.1 bis 0.0.6 (Tags `v0.0.1` bis `v0.0.6`)
- [x] **GRUNDSACHE** Workflow-Dateien (`.yaml`) auf `origin/main` (Zahl nicht neu gezählt; Review prüft 36 Dateien auf dem Bündel-Kopf)
- [x] Bündel 0.0.7, Runde 1: B1 bis B6 behoben (Review Runde 2: „B1-B6 sind behoben“, Commits 45ddd4e, d3c1bc5)
- [x] Review Runde 2 (Kopf d3c1bc5): `doku-mitziehen`, `upstream-update`, `release-flow`, `review`, `programm-neu` (speicher-check) mit JA; Selbsttests grün (`test_doku_mitziehen.sh` 19 Fälle, `test_umbenennen.sh` 30 Fälle, `check_workflows.py` 36 Dateien) (`review-bundle-0.0.7-opus-r2.md`)
- [x] SHA-Pins für alle Action- und Workflow-Verweise (Commit 0d7dee4; Pin 94b6551 als plausibel bewertet, mit Auflage S1)
- [x] Befunde der Runde 2 sind laut Commits bearbeitet: B7 `umbenennen`: `retire` idempotent (910fb6b); R1 bis R6 koordinator-runde, G1 bis G5 programm-grundgeruest, T1/T2 testlauf, release-flow `output`, Zustandsdateien privat, S1 Changelog (c915430)

## Bündel 0.0.7: noch offen
- [ ] **GRUNDSACHE** Opus-Review der Runde 3 über Kopf c915430: nur die Runde 2 liegt vor (Urteil NEIN für `umbenennen`, `koordinator-runde`, `programm-grundgeruest`, `testlauf`); ob die Behebungen reichen, ist nicht geprüft
- [ ] **GRUNDSACHE** Strategie-Antwort zu R1: `koordinator-runde` schreibt Hintergrund-Agenten fest (Test `workflows_runde.rs:47, :77`), die Nutzerregel vom 2026-11-15 verlangt Vordergrund und Warten auf alle Agenten [offen; Prüfen, ob c915430 das geändert hat]
- [ ] **GRUNDSACHE** Nach dem Merge zweiter Schritt: SHA in `release.yml`, `ci.yml`, `check.yml` auf den Merge-Commit heben (`scripts/pin-refs.sh <merge-sha>`, eigener Commit); sonst nutzt der Signier-Job weiter `@main` (S1)
- [ ] **GRUNDSACHE** Merge nach `main`, Tag `v0.0.7`; „Bilder -> Strategie-OK -> Release“ gilt für sichtbare Änderungen
- [ ] **GRUNDSACHE** Workflow `umbenennen` (mit B7-Fix) ist die Voraussetzung für alle sieben Umbenennungen (ADR 0087 Punkt 3)
- [ ] **GRUNDSACHE** Alle Crates tragen die gemeinsame Version gleich dem Tag (Regel „Version = Tag“); bei jedem Lift prüfen
- [ ] SPÄTER Kleinpunkte der Runde 2: K1 (Vergleich beim Wiedereinstieg in `upstream-update` nur im Text), K4-Rest (`release-flow` ohne `output` in allen Elternabläufen), K5 (`doku` doppelt in `umbenennen`), P1/P2 (Rundlauf-Prüfung vor `release` in `programm-neu`, Standardzweig `green`)
- [ ] SPÄTER Das Muster „Standardzweig = green“ in den drei neuen Abläufen (R6, G2, T2) mit einem Lint finden
- [ ] SPÄTER Lint, der in `.github/workflows` nur 40-stellige SHAs zulässt
- [ ] SPÄTER Nicht belegt: echter Lauf nach Serverless Workflow 1.0 (`try`/`catch`, `fork`, `for`, `output`) und die `@fs`-Befehle (`resolve-head`, `merge-ff`, `storage-typed-check`, `trait-lock`, `await-approval`, `workspace-test-background`) existieren nur als Namen

## Weitere Branches auf origin
- [ ] SPÄTER Entscheiden, welche der übrigen `unreviewed/*`-Branches Teil von 0.0.7 sind: `anbieter-neuinstallation`, `api-gates-step`, `ereignis-profil`, `fs-release-apt` (apt-Signier-Action), `menue-vergleich`, `server-einrichtung`, `upstream-update` [offen]
- [ ] SPÄTER `workflow-pflege` für fehlende Abläufe: `repo-umbenennen` ist durch `umbenennen` ersetzt; `inhalt-aufbereiten`, `facette-anlegen` fehlen
