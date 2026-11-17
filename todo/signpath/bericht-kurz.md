> Herkunft: Branch `research-signpath-bericht` (Repo fs-icons), Stand 16.11. Kurzfassung des Berichts; die Vollversion steht in bericht.md.

# SignPath Foundation – Windows-Code-Signing für FreeSynergy (Recherche-Bericht)

Stand: 2026-11-13. Nur Recherche, kein Code. Unbelegtes ist mit **[nicht belegt]** markiert.
Vollversion identisch mit der Arbeitskopie `SIGNPATH-BERICHT.md` (außerhalb des Repos).

**Vorab-Warnung:** Die Seite `signpath.org/terms` ist laut eigenem Text ein **Entwurf** („The code of conduct is still in a draft version“). Die Bedingungen können sich ändern; vor der Bewerbung die aktuelle Fassung prüfen.

## 1. Bedingungen der SignPath Foundation (OSS)

**Quellen:** https://signpath.org (Startseite), https://signpath.org/apply, https://signpath.org/terms

**Angebot (belegt):**
- Zertifikat wird von der SignPath Foundation ausgestellt, nicht auf eine Person. Zitat Startseite: „No need for personal identification, we verify that the binary was built from your open source repository and vouch for that with our name.“
- Private Schlüssel liegen auf einem HSM (SignPath.io).
- „For OSS projects, our services are free of charge.“ (Startseite)

**Bewerbung:** `/apply` ist als „Apply for a free SignPath.io subscription“ betitelt, im Abruf aber nur Navigation. Formular, Ablauf, benötigte Angaben, Dauer, Ansprechpartner: **[nicht belegt]**. Direkt im Browser prüfen.

**Eligibility (Zitate aus signpath.org/terms, Entwurf):**
- Malware/PUA: „The project must not contain malware or potentially unwanted programs.“
- Lizenz: „must use an OSI-approved Open Source license without commercial dual-licensing for all components“. Konkrete Liste zulässiger Lizenzen: **[nicht belegt]**. MIT und Apache-2.0 sind OSI-approved (allgemein bekannt, nicht von dieser Seite belegt).
- Keine proprietären Komponenten: „may not contain any proprietary, non open-source component“.
- Pflege und Release: „must be actively maintained“ und „must already be released in the form that should be signed.“
- Dokumentation: „must be described on its download page or in the app store entry“.
- Reputation: „we require a certain verifiable reputation“ für Executables. Mindest-Nutzerzahl / Projektalter: **[nicht belegt]**.
- Öffentliche Quelle und Builds: Terms sprechen von „source code repository“ und „build scripts and CI configurations“, nennen GitHub Actions nicht ausdrücklich. Die GitHub-Doku verlangt für OSS GitHub-gehostete Runner.

**Einschränkungen (Zitate, Entwurf):**
- „The team must only sign software artifacts built from their own source code.“ Upstream-Fremdcode nur unter engen Fork-Bedingungen.
- „Binary artifacts must be built from source code in a verifiable way.“
- „Every release needs manual approval for signing.“
- Laut Seite „not automatically enforced yet“ (welche Punkte: **[nicht belegt]**).

**Code-Signing-Policy-Seite (Zitate, Entwurf):**
- Muss „on the project's home page“ stehen.
- Rollen: **Authors** (dürfen ohne weitere Review ins VCS committen), **Reviewer** (prüfen Änderungen von Nicht-Commitern), **Approver** (genehmigen jede Signaturanfrage; „a team member the whole team trusts“).
- Privacy Policy: eigene oder Musterformulierung „This program will not transfer any information to other networked systems unless specifically requested by the user.“

**MFA:** „All team members must use multi-factor authentication for both SignPath and source code repository access.“

**Nicht belegt:**
- Kosten über „free of charge“ hinaus, Limits/Quoten: **[nicht belegt]**
- Anzeigename des Herausgebers im Windows-Signaturdialog: **[nicht belegt]** (Startseite nennt „SignPath Foundation“).
- Rollen im SignPath-Portal (Submitter/Approver-Rechte): nur Hinweis „API token for a user with submitter permissions“ aus der GitHub-Doku.

## 2. GitHub Action zum Einreichen

**Quelle (offizielle Doku):** https://docs.signpath.io/trusted-build-systems/github
**Action-Repo (laut Doku-Abruf):** https://github.com/SignPath/github-action-submit-signing-request (nicht selbst abgerufen)
**Version laut Doku-Beispiel:** `signpath/github-action-submit-signing-request@v3`, zusammen mit `actions/upload-artifact@v7`. Ein Drittprojekt (Chelydra-Labs/Silt #983) empfiehlt Pinning auf Commit-SHA – Sekundärquelle.

**Pflicht-Inputs:** `api-token` (Secret, Nutzer mit Submitter-Rechten), `organization-id`, `project-slug`, `signing-policy-slug`, `github-artifact-id`.
**Optionale Inputs:** `connector-url` (nur self-hosted), `artifact-configuration-slug`, `wait-for-completion` (Default `true`), `output-artifact-directory` (ohne Angabe kein Download), `github-token` (Default `secrets.GITHUB_TOKEN`), `wait-for-completion-timeout-in-seconds` (600), `service-unavailable-timeout-in-seconds` (600), `download-signed-artifact-timeout-in-seconds` (300), `parameters`, `skip-decompress` (false).
**Outputs:** `signing-request-id`, `signing-request-web-url`, `signed-artifact-download-url`.

**Voraussetzungen (Doku):**
- Artefakt muss als GitHub-Workflow-Artefakt vorliegen; `actions/upload-artifact` v4 oder neuer.
- Ohne `archive: false` muss das Wurzelelement der Artifact Configuration `zip-file` sein; bei `archive: false` `skip-decompress: true`.
- OSS: alle Jobs vor dem Signing-Request auf GitHub-gehosteten Runnern.
- Privates Repo mit Standard-Read-only-Rechten und ohne SignPath-GitHub-App: `actions: read` und `contents: read`.

**Beispiel (Struktur, sinngemäß nach offizieller Doku; vor Übernahme Originalbeispiel prüfen):**

```yaml
- uses: actions/upload-artifact@v7
  id: upload-unsigned-artifact
  with:
    name: unsigned-windows
    path: <pfad-zum-artefakt>
- uses: signpath/github-action-submit-signing-request@v3
  with:
    api-token: '${{ secrets.SIGNPATH_API_TOKEN }}'
    organization-id: <organization-id>
    project-slug: <project-slug>
    signing-policy-slug: <signing-policy-slug>
    github-artifact-id: '${{ steps.upload-unsigned-artifact.outputs.artifact-id }}'
    wait-for-completion: true
    output-artifact-directory: <ausgabeverzeichnis>
```

Hinweis: `github-artifact-id` darf nicht leer sein (Fehlerfall laut Drittprojekt-PR, Sekundärquelle).

## 3. Plan für unsere release.yml (nur Plan, nichts geändert)

Im Worktree liegt keine `release.yml`; hier gibt es nur `.github/workflows/check.yml` und `ci.yml`. Die Release-Datei lebt laut Auftrag in `FreeSynergy/fs-release` und wurde **nicht** eingesehen.

1. Windows-Build (GitHub-gehosteter Runner) erzeugt .exe/.msi.
2. `actions/upload-artifact` (mit `id`) lädt das **unsignierte** Artefakt hoch.
3. Submit-Schritt mit `wait-for-completion: true` (oder `false` + separater Folgejob).
4. **Haltepunkt:** Approver gibt im SignPath-Portal frei („Every release needs manual approval“). Timeouts beachten: Default 600 s; ob bei manueller Freigabe längere Wartezeit ohne Timeout-Fehler möglich ist, **[nicht belegt]** – ggf. Aufteilung in zwei Jobs.
5. Signiertes Artefakt per `output-artifact-directory` laden.
6. SHA256-Prüfsummen und unsere GPG-.asc-Signaturen **neu** erzeugen, da sich die Binaries geändert haben.
7. Pre-release-Upload.

Einordnung: Signatur zwischen Draft und Pre-release passt zur Kette (Opus-Freigabe → Tag → Release-Lauf → Draft → Signatur → Pre-release). Die menschliche Freigabe macht den Lauf ggf. zweiteilig.

**Secrets:** `SIGNPATH_API_TOKEN` (Secret); `organization-id` und Slugs als Eingaben (ob geheim nötig: **[nicht belegt]**).

**Offene technische Punkte:** Artifact-Configuration (`zip-file` vs. `archive: false`), .msi vs. .exe in der Konfiguration, Pinning der Action (SHA statt Tag), Berechtigungen bei privatem Repo.

## 4. Gliederung Code-Signing-Policy-Seite (Entwurf, nur Struktur)

Vorschlag `docs/code-signing-policy.md`, verlinkt von README und Download-Seite (Pflicht: „on the project's home page“).

1. Zweck und Geltungsbereich (welche Artefakte und Programme)
2. Herausgeber: SignPath Foundation, Verweis auf signpath.org
3. Rollen – **offen, Nutzer entscheidet:** Author(s), Reviewer, Approver
4. Build-Prozess: GitHub Actions, öffentliches Repo, nachvollziehbarer Build, nur eigene Builds
5. Freigabe: manuelle Freigabe pro Release im SignPath-Portal
6. MFA für alle Teammitglieder (SignPath und Repo)
7. Privacy: eigene Policy oder Musterformulierung
8. Fremdkomponenten und Lizenzen (MIT/Apache-2.0)
9. Problemmeldung (SECURITY.md verlinken)
10. Änderungshistorie

**Offene Fragen an den Nutzer:**
- Wer ist Author, Reviewer, Approver (Namen/GitHub-Logins)?
- Gibt es weitere Teammitglieder mit MFA?
- Ist fs-release und die Build-/CI-Konfiguration öffentlich?
- Welche Programme werden signiert (nur FreeSynergy-Rust-Programme oder auch paketierte Drittprodukte)?
- Gibt es bereits SECURITY.md und Download-Seite als Verlinkungsziel?

## 5. Alternativen (nicht recherchiert; nur Namen, **nicht belegt**)

- **Azure Trusted Signing:** kostenpflichtiger Microsoft-Cloud-Signaturdienst.
- **Eigenes OV/EV-Zertifikat:** kostenpflichtig, Identitätsprüfung der Organisation.
- **Sigstore:** Artefakt-Signatur ohne Windows-Authenticode-Anerkennung; hilft nicht bei SmartScreen.

## Quellen

- https://signpath.org
- https://signpath.org/apply (ohne Details abrufbar)
- https://signpath.org/terms (Entwurf)
- https://docs.signpath.io/trusted-build-systems/github
- https://github.com/SignPath/github-action-submit-signing-request (Verweis aus Doku)
- Sekundär: https://github.com/Chelydra-Labs/Silt/issues/983

## Nicht geprüft / Grenzen

- `/about`, `/projects`, `/privacy-policy` nicht abgerufen.
- Action-Repo und Releases der Action nicht direkt geprüft.
- Keine Preise, Limits, Bearbeitungsdauer belegt.
- `release.yml` in fs-release nicht eingesehen.
- Nichts committet; Änderung besteht nur aus dieser Datei (untracked).
