# SignPath Foundation – Windows-Code-Signing für FreeSynergy (Recherche-Bericht)

Stand: 2026-11-13. Nur Recherche, kein Code. Unbelegtes ist mit **[nicht belegt]** markiert.

**Vorab-Warnung:** Die Seite `signpath.org/terms` ist laut eigenem Text ein **Entwurf** („The code of conduct is still in a draft version“). Die Bedingungen können sich ändern; vor der Bewerbung die aktuelle Fassung prüfen.

## 1. Bedingungen der SignPath Foundation (OSS)

**Quellen:** https://signpath.org (Startseite), https://signpath.org/apply, https://signpath.org/terms

**Angebot (belegt):**
- Zertifikat wird von der SignPath Foundation ausgestellt, nicht auf eine Person. Zitat Startseite: „No need for personal identification, we verify that the binary was built from your open source repository and vouch for that with our name.“
- Private Schlüssel liegen auf einem HSM (SignPath.io).
- „For OSS projects, our services are free of charge.“ (Startseite)

**Bewerbung:**
- Die Seite `/apply` ist als „Apply for a free SignPath.io subscription“ betitelt, enthält aber im Abruf nur Navigation. Formular, Ablauf, benötigte Angaben, Dauer, Ansprechpartner: **[nicht belegt]**. Direkt im Browser prüfen.

**Eligibility (Zitate aus signpath.org/terms, Entwurf):**
- Malware/PUA: „The project must not contain malware or potentially unwanted programs.“
- Lizenz: „must use an OSI-approved Open Source license without commercial dual-licensing for all components“. Konkrete Liste zulässiger OSI-Lizenzen: **[nicht belegt]**. MIT und Apache-2.0 sind OSI-approved (allgemein bekannt, nicht von dieser Seite belegt).
- Keine proprietären Komponenten: „may not contain any proprietary, non open-source component“.
- Pflege und Release: „must be actively maintained“ und „must already be released in the form that should be signed.“ → Ein Release in der Form, die signiert werden soll (also .exe/.msi), muss bereits existieren.
- Dokumentation: „must be described on its download page or in the app store entry“.
- Reputation: „we require a certain verifiable reputation“ für Executables. Mindest-Nutzerzahl / Projektalter: **[nicht belegt]** (keine Zahlen genannt).
- Öffentliche Quelle und öffentliche Builds: Die Terms sprechen von „source code repository“ und „build scripts and CI configurations“, nennen GitHub Actions nicht ausdrücklich. Die GitHub-Doku (unten) verlangt GitHub-gehostete Runner für OSS.

**Einschränkungen (Zitate, Entwurf):**
- Nur eigene Projekte: „The team must only sign software artifacts built from their own source code.“ Upstream-Fremdcode nur unter engen Fork-Bedingungen.
- Verifizierbarer Build: „Binary artifacts must be built from source code in a verifiable way.“
- Manuelle Freigabe: „Every release needs manual approval for signing.“
- Einige Einschränkungen seien laut Seite „not automatically enforced yet“ (welche: **[nicht belegt]**).

**Code-Signing-Policy-Seite (Zitate, Entwurf):**
- Muss „on the project's home page“ stehen.
- Rollen: **Authors** (dürfen ohne weitere Review ins VCS committen), **Reviewer** (prüfen Änderungen von Nicht-Commitern), **Approver** (genehmigen jede Signaturanfrage; „a team member the whole team trusts“).
- Privacy Policy: eigene oder Musterformulierung „This program will not transfer any information to other networked systems unless specifically requested by the user.“

**MFA:** „All team members must use multi-factor authentication for both SignPath and source code repository access.“

**Nicht belegt / nicht gefunden:**
- Kosten über „free of charge“ hinaus, Limits/Quoten: **[nicht belegt]**
- Zertifikats-Herausgebername im Signaturdialog: Die Seite nennt „SignPath Foundation“ als Herausgeber des Zertifikats (Startseite); der genaue Anzeigename im Windows-Dialog ist **[nicht belegt]**.
- Rollen im SignPath-Portal (Submitter/Approver-Rechte): Nur Hinweis „API token for a user with submitter permissions“ aus der GitHub-Doku. Details **[nicht belegt]**.

## 2. GitHub Action zum Einreichen

**Quelle (offizielle Doku):** https://docs.signpath.io/trusted-build-systems/github
**Action-Repo:** https://github.com/SignPath/github-action-submit-signing-request (laut Doku-Abruf; Repo-Seite selbst nicht geprüft)
**Version laut Doku-Beispiel:** `signpath/github-action-submit-signing-request@v3` (zusammen mit `actions/upload-artifact@v7` im Beispiel). Ein Drittprojekt (GitHub Issue Chelydra-Labs/Silt #983) empfiehlt Pinning auf Commit-SHA statt Tag – Sekundärquelle, nicht offiziell.

**Pflicht-Inputs:** `api-token` (Secret, Nutzer mit Submitter-Rechten), `organization-id`, `project-slug`, `signing-policy-slug`, `github-artifact-id`.
**Optionale Inputs:** `connector-url` (nur self-hosted), `artifact-configuration-slug` (Default: Standardkonfiguration), `wait-for-completion` (Default `true`), `output-artifact-directory` (ohne Angabe wird das signierte Artefakt nicht geladen), `github-token` (Default `secrets.GITHUB_TOKEN`), `wait-for-completion-timeout-in-seconds` (600), `service-unavailable-timeout-in-seconds` (600), `download-signed-artifact-timeout-in-seconds` (300), `parameters`, `skip-decompress` (false).
**Outputs:** `signing-request-id`, `signing-request-web-url`, `signed-artifact-download-url`.

**Voraussetzungen (Doku):**
- Artefakt muss als GitHub-Workflow-Artefakt vorliegen; `github-artifact-id` nur mit `actions/upload-artifact` v4 oder neuer.
- Ohne `archive: false` muss das Wurzelelement der Artifact Configuration `zip-file` sein; bei `archive: false` `skip-decompress: true` setzen.
- OSS: alle Jobs vor dem Signing-Request auf GitHub-gehosteten Runnern.
- Bei privatem Repo mit eingeschränkten Standard-Rechten und ohne installierte SignPath-GitHub-App: `actions: read` und `contents: read`.
- Origin-Verifikation: Herkunftsdaten kommen von GitHub, nicht vom Build-Skript (Doku-Aussage).

**Beispiel (Struktur aus der offiziellen Doku, sinngemäß; Platzhalter sind meine Kürzung, Originalbeispiel vor Übernahme prüfen):**

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

Hinweis: `github-artifact-id` darf nicht leer sein (Fehlerfall laut PR eines Drittprojekts, Sekundärquelle).

## 3. Plan für unsere release.yml (grob, nur Plan – nichts geändert)

**Vorbemerkung:** Im Worktree liegt **keine** `release.yml`; in diesem Repo gibt es nur `.github/workflows/check.yml` und `ci.yml`. Die Release-Workflow-Datei lebt laut Auftrag in `FreeSynergy/fs-release` und wurde **nicht** eingesehen [nicht belegt für Inhalt]. *Der Satz bezieht sich auf das damalige Arbeitsverzeichnis (fs-icons); fs-documentation hat nur .github/workflows/deploy.yml.*

Vorgeschlagene Reihenfolge innerhalb des Release-Laufs:
1. Windows-Build (GitHub-gehosteter Runner) erzeugt .exe/.msi.
2. `actions/upload-artifact` (mit `id`) lädt das **unsignierte** Windows-Artefakt hoch.
3. Submit-Schritt `submit-signing-request` mit `wait-for-completion: true` (oder `false` + separater Schritt).
4. **Haltepunkt:** Ein Mensch (Approver) gibt die Signatur im SignPath-Portal frei („Every release needs manual approval“). Der Lauf wartet bis dahin; Timeouts beachten (Default 600 s für Wartezeit – bei manueller Freigabe ggf. zu kurz; **[nicht belegt]**, ob Wartezeit über Timeout hinaus unterstützt wird; ggf. `wait-for-completion: false` + Folgejob).
5. Signiertes Artefakt per `output-artifact-directory` herunterladen.
6. Danach Prüfsummen (SHA256) und unsere GPG-Signaturen (.asc) **neu** erzeugen, da sich die Binaries geändert haben.
7. Pre-release-Upload.

Einordnung in die Kette (Opus-Freigabe → Tag → Release-Lauf → Draft → Signatur → Pre-release): Signatur zwischen Draft und Pre-release ist konzeptionell passend; Achtung: Die Signatur-Freigabe bindet einen Menschen zusätzlich ein, daher Lauf ggf. in zwei Jobs teilen.

**Secrets:** `SIGNPATH_API_TOKEN` (Secret), `organization-id` und Slugs (als Variablen oder im Workflow – Sicherheitsabwägung: Die Doku nennt sie als Eingaben; ob sie geheim sein müssen: **[nicht belegt]**). Kein Secret-Wert in Dokumenten ablegen.

**Offene technische Punkte:** Artifact-Configuration in SignPath (Root-Element `zip-file` vs. `archive: false`), Behandlung von .msi vs. .exe in der Konfiguration, Pinning der Action (SHA statt Tag), Berechtigungen (`actions: read`, `contents: read`) falls Repo privat.

## 4. Gliederung Code-Signing-Policy-Seite (Entwurf, nur Struktur)

Ablageort vorschlagsweise `docs/code-signing-policy.md`, verlinkt von README und Download-Seite (Pflicht: „on the project's home page“).

1. Zweck und Geltungsbereich (welche Artefakte: Windows .exe/.msi, welche Programme/Repos)
2. Zertifikats-Herausgeber: SignPath Foundation, Verweis auf signpath.org
3. Rollen (Pflichtangaben – **offen, bitte Nutzer entscheiden**):
   - Author(s): Wer darf ohne weitere Review committen? → **[offen]**
   - Reviewer: Wer prüft Beiträge von Nicht-Commitern? → **[offen]**
   - Approver: Wer genehmigt jede Signaturanfrage? → **[offen]**
4. Build-Prozess: Nur GitHub Actions, öffentliches Repo, Build aus Quellcode nachvollziehbar, nur eigene Builds
5. Freigabe-Prozess: Manuelle Freigabe pro Release im SignPath-Portal
6. Team-Sicherheit: MFA für alle Teammitglieder (SignPath und Repo)
7. Datenschutz/Privacy: eigene Policy oder Musterformulierung (s. oben)
8. Fremdkomponenten: Liste der Drittanteile, Lizenzen (MIT/Apache-2.0)
9. Melden von Problemen / Sicherheitskontakt (SECURITY.md verlinken)
10. Änderungshistorie der Policy

**Offene Fragen an den Nutzer:**
- Wer sind Author, Reviewer, Approver (Namen oder GitHub-Logins)?
- Gibt es weitere Teammitglieder mit MFA-Nachweis?
- Ist das Repo fs-release öffentlich? Build-Skripte und CI-Konfiguration öffentlich?
- Welche Programme sollen signiert werden (nur fs-Rust-Programme oder auch Drittprodukte, die wir paketieren)?
- Gibt es bereits eine SECURITY.md und Download-Seite, auf der die Policy verlinkt werden kann?

## 5. Alternativen (nicht recherchiert; nur Namen aus allgemeinem Wissen, **nicht belegt**)

- **Azure Trusted Signing:** kostenpflichtiger Cloud-Signaturdienst von Microsoft.
- **Eigenes OV/EV-Zertifikat:** kostenpflichtig, Identitätsprüfung der Organisation nötig.
- **Sigstore:** Signatur für Artefakte ohne Windows-Authenticode-Anerkennung; hilft nicht bei SmartScreen/Herausgeber-Anzeige.

## Quellen

- https://signpath.org
- https://signpath.org/apply (ohne Details abrufbar)
- https://signpath.org/terms (Entwurf)
- https://docs.signpath.io/trusted-build-systems/github
- https://github.com/SignPath/github-action-submit-signing-request (Verweis aus Doku, nicht selbst abgerufen)
- Sekundär: https://github.com/Chelydra-Labs/Silt/issues/983 (Pinning-Empfehlung)

## Nicht geprüft / Grenzen

- `/about`, `/projects`, `/privacy-policy` nicht abgerufen.
- Action-Repo und Changelog der Action nicht direkt geprüft (Version v3 stammt aus der Doku-Zusammenfassung).
- Keine Preise, keine Limits, keine Bearbeitungsdauer belegt.
- Release-Workflow `release.yml` (fs-release) nicht eingesehen.
