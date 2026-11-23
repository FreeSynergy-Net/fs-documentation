# 0077 – Katalog-Arten (`kind`) und Store-Gruppen; Server nur mit rpm/deb

Status: **akzeptiert** (Strategie, 2026-11-14; Nutzerregel zu Punkt 3: alle Server kommen in den Katalog und sind überall installierbar) · baut auf ADR 0061 (Facetten), 0062 (ein Katalog-Repo), 0064 (Versionen), 0068 (gespiegelte Pakete), 0074 (Schichten, Gruppen im Store), 0075 (Store zeigt Server)

## Kontext
Kein ADR legt die `kind`-Werte des Katalogs fest. Ist-Zustand `fs-catalog` main: nur `kind = "program"`, AppStream-Typ fest `desktop-application`. Schema 2 (Branch `unreviewed/catalog-schema2`) kennt `server`, `icon-theme`, `component` (Entwurf). Der Store-Leser verwirft unbekannte Werte (`Skipped`); `PackageKind` in `store.capnp` hat 4 Werte. ADR 0074 verlangt je Schicht eine Store-Gruppe, „ebenso Programme und Server“, nennt aber keinen Wert für Programm und Server. Auslöser: `fs-kanidm` soll als Server in den Katalog.

## Entscheidung
### 1. `kind` ist die Store-Gruppe
Eine Eigenschaft, keine zweite Kategorie daneben. Werte: `program`, `server`, `frontend`, `theme`, `icon-theme`, `motion`, `sound-theme`, `haptics`, `shortcuts`, `language`. Abweichungen von der Tabelle in ADR 0074: `program` und `server` stehen dort nicht (nur im Satz zu den Gruppen); der Schema-2-Entwurf kennt zusätzlich `component`, das hier **nicht** übernommen wird (Bausteine gehören zum Stil, 0074). **Facette** (0061) bleibt ein eigener Begriff (Ausschnitt eines Programms) und ist **kein** `kind`; ein Katalogeintrag je Facette bleibt nach 0061 §7 möglich und trägt das `kind` seines Programms.

### 2. AppStream-Typ je `kind`
Belegt gegen die AppStream-Spezifikation (freedesktop.org/software/appstream/docs, gelesen 2026-11-14):

| kind | AppStream `type` | Beleg |
|---|---|---|
| `program` | `desktop-application` (Programm nur mit Kommandozeile: `console-application`) | „A console application is any application that has a command-line or text-based interface“; `desktop-application` im Bestand (`gen_catalog.py`) |
| `server` | `service` | „A service component is any software that is started and supervised by the Operating Systems ‚init‘ facility, such as systemd.“ |
| `icon-theme` | `icon-theme` | „`type` set to `icon-theme` … describing an icon theme following the Freedesktop specification“ |
| `language` | `localization` | „describes language packs for individual software components“ |
| `frontend`, `theme`, `motion`, `sound-theme`, `haptics`, `shortcuts` | `addon` | „Some components are not standalone, but rather extend existing software“; `<extends/>` nennt das erweiterte Programm. Dass diese sechs Arten darunter fallen, ist **unsere Zuordnung**, die Spezifikation nennt sie nicht |

Das Feld `fs:kind` bleibt zusätzlich im Katalog; der AppStream-Typ ersetzt es nicht.

### 3. Server: rpm, deb, Container
Für `kind = server` Pflicht: **rpm, deb und OCI-Container**, jeweils signiert (OpenPGP, 0062), mit systemd-Unit und Systembenutzer. Der Tarball bleibt zusätzlich (Quellcode-Tarball nach 0068 ohnehin). **Ein Server kommt erst in den Katalog, wenn mindestens rpm ODER deb vorliegt**; ein Tarball allein genügt nicht (Systemdienst, Root, PAM-Module lassen sich mit der Nutzer-Tarball-Installation des Stores nicht abbilden). Nutzerregel: **alle Server im Katalog, überall installierbar** (Store-Programm, Repo für deb/rpm, Container, Kommandozeile `fs-store`), so viele Schnittstellen wie möglich.

### 4. Versionen, Namen, Icons gespiegelter Server
- **Version:** Upstream-Version (ADR 0064 gilt nur für eigene Programme). Eigene Paketänderungen als **Paket-Revision** (`1.12.1-1`, `-2` …, wie Debian-Revision und RPM-Release). Tag im Paket-Repo `v1.12.1`.
- **Name:** der Upstream-Name („Kanidm“, nicht `FreeSynergy.*`); Beschreibung z. B. „Identitätsserver, gespiegelt und signiert von FreeSynergy“.
- **AppStream-ID:** Upstream-rDNS, wenn Upstream eine führt. Gelesen: `kanidm/kanidm` (Zweig `master`) enthält **keine** `.metainfo.xml`/`.appdata.xml`/`.desktop`-Datei; eine Upstream-ID ist daher **[nicht belegt]**. Vorschlag: aus der Upstream-Domain `kanidm.com` abgeleitet, `com.kanidm.Kanidm`, bis Upstream eine nennt (dann Wechsel mit `<provides><id>` für die alte ID).
- **Icon:** `kanidm/kanidm` `artwork/README.md`: „All artworks are licensed as CC-BY-NC-ND.“ (das Repo selbst: MPL-2.0). „NC“ und „ND“ erlauben weder freie Weitergabe in unserem Sinn noch Anpassung (Größen, Symbolic-Fassung); das Upstream-Logo wird **nicht** verwendet. Stattdessen ein **neutrales Server-Icon aus unserem Icon-Satz**. Fragt Upstream später ausdrücklich um Erlaubnis, kann das geändert werden [nicht belegt].

## Folgen
Reihenfolge der Umsetzung (aus dem Bericht):
1. fs-interfaces: `PackageKind` um `server`, `iconTheme` (und die übrigen Werte) erweitern, Tag.
2. fs-store: Leser (`catalog.rs`), `words.rs`, `wire.rs`, Gruppen in der Oberfläche; `min_store` prüfen.
3. fs-catalog: Schema 2 reviewen und nach main (`kind`, `min_store`, AppStream-Typ aus der Tabelle, Prüfung „Server braucht rpm oder deb“).
4. fs-kanidm: rpm, deb, Container bauen und signieren; Icon aus unserem Satz; Revision-Zählung.
5. Katalog-Eintrag `fs-kanidm`, erst nach 2 und 3 (`gen_catalog.py --check`).
6. Installation von Servern im Store (Systempaket statt Nutzer-Tarball): eigenes Konzept, größtes Risiko.

## Alternativen (verworfen)
- **A: `kind = server` im alten Schema 1:** setzt den Typ fest auf `desktop-application` (falsch), kein `min_store`, alte Stores werfen den Eintrag still weg; jeder Umstieg auf Schema 2 fasst ihn erneut an.
- **C: zweiter Katalog für Server:** widerspricht ADR 0062 (ein Katalog-Repo, ein Vertrauenskreis, eine TUF-Kette) und dem Nutzerwunsch „alle Server im Katalog“.
- Eigene Kategorie neben `kind`: zwei Wahrheiten für dieselbe Gruppe.

## Offen
- Upstream-AppStream-ID von Kanidm [nicht belegt]; Vorschlag oben.
- Ob Upstream das Logo freigibt [nicht belegt].
- Zuordnung der sechs Stil-Arten zu `addon` ist keine Vorgabe der Spezifikation.
- Container-Registry und Signatur der Container (z. B. Sigstore/OpenPGP) noch nicht entschieden.
- Installationskonzept für Systemdienste (Folge 6).
- ~~Module/Handler für eingebettete Inhalte: eigene Art `module` oder `addon`?~~ **Entschieden** im Nachtrag 2026-11-14 (Katalogart `module`).

## Nachtrag 2026-11-14: Katalogart `workflow`
Der `kind`-Wert `workflow` (anbietbare Abläufe, z. B. `server-einrichtung`, ADR 0079) kommt zur Tabelle in §1 hinzu. AppStream-Typ: `addon` mit `<extends>` `fs-workflows`. Diese Zuordnung ist **unsere**, die Spezifikation gibt sie nicht vor (wie bei den Stil-Arten in §2). Das Angebot läuft über den Katalog, `fs-marketplace` später.

| kind | AppStream `type` | Beleg |
|---|---|---|
| `workflow` | `addon` (`<extends>` `fs-workflows`) | Unsere Zuordnung; „Some components are not standalone, but rather extend existing software“ (Spezifikation, nur zur Art `addon`) |

## Nachtrag 2026-11-14: Katalogart `module` (akzeptiert, Strategie, 2026-11-14; Nutzerentscheidung)
Entscheidet den Offen-Punkt „`module` oder `addon`“. Der `kind`-Wert `module` kommt zur Tabelle in §1 hinzu: eine Erweiterung eines Bausteins oder Programms (z. B. Sprachmodul für den `SourceEditor`, Blocktyp für den `BlockEditor`, Handler für eingebettete Inhalte; siehe ADR 0084). Der Eintrag **nennt, welchen Baustein oder welches Programm er erweitert**. AppStream-Typ: `addon` mit `<extends>` auf den erweiterten Baustein. Diese Zuordnung ist **unsere**, die Spezifikation gibt sie nicht vor (wie bei den Stil-Arten und `workflow`). Module laufen als Hot-Plugins (ADR 0045).

| kind | AppStream `type` | Beleg |
|---|---|---|
| `module` | `addon` (`<extends>` erweiterter Baustein/Programm) | Unsere Zuordnung; „Some components are not standalone, but rather extend existing software“ (Spezifikation, nur zur Art `addon`) |

Nutzer-JA 2026-11-14 zur Katalogart `module`. Darstellung im Store: **offen** (später mit dem Nutzer).

## Nachtrag 2026-11-16: Ist-Stand korrigiert, Katalogart `font` (akzeptiert, Nutzer, 2026-11-16, mit ADR 0089)
Der Ist-Stand in „Kontext“ ist überholt und wird hier korrigiert; der Text oben bleibt als Verlauf stehen. Geprüft am `origin/main` von `fs-catalog` (2026-11-16):
- `scripts/schema_base.py` kennt `KINDS = program, frontend, component, theme, server, icon-theme` (AppStream: `desktop-application`, `desktop-application`, `addon`, `addon`, `service`, `icon-theme`). `NEW_KINDS` = `server`, `icon-theme`.
- `packages.toml` auf `main` enthält sieben Programme (`kind = "program"`) und den Eintrag `zentinel` mit `kind = "server"`. Der CHANGELOG nennt `zentinel` unter „Unreleased (unreviewed/catalog-zentinel)“.
- Abweichung zu §1: Das Schema auf `main` kennt `component`, das §1 nicht übernimmt; `motion`, `sound-theme`, `haptics`, `shortcuts`, `language`, `module` und `workflow` kennt das Schema auf `main` noch nicht. Die Angleichung ist offen (Folge für fs-catalog, nicht in diesem ADR entschieden).

**Katalogart `font` (Vorschlag):** Eine Schriftfamilie mit allen ihren Schnitten ist ein Katalogeintrag mit `kind = "font"`. AppStream-Typ: `font` (Spezifikation, Abschnitt „Fonts“, laut Recherche 2026-11-16 gelesen; `<provides><font>` nennt die vollen Schnittnamen). Die Zuordnung ist damit nicht unsere eigene, sondern folgt der Spezifikation.

Die Entscheidung über die Art ist akzeptiert. Die Felder bleiben ausdrücklich Vorschlag und werden erst mit dem Schema-Schritt S1 verbindlich.

Felder (Vorschlag, Schema `kind = "font"`):
- `license` als SPDX-Kennung. Jede freie Schriftlizenz ist erlaubt. Unfreie oder unklare Lizenzen werden gemeldet, nicht gespiegelt.
- `family` (Familienname) und `faces` (Liste der Schnitte mit Dateiname und Prüfsumme).
- `preview` (Vorschau-Text oder Bild; Form offen).
- `install` mit den Zielen `~/.local/share/fonts` und fontconfig für Linux.

| kind | AppStream `type` | Beleg |
|---|---|---|
| `font` | `font` (`<provides><font>` nennt die vollen Schnittnamen) | Spezifikation, Abschnitt „Fonts“ (laut Recherche 2026-11-16, nicht im Volltext nachgelesen) **[nicht belegt]** |

**Offen:** Windows- und macOS-Pendants der Installationsziele sind nicht recherchiert **[nicht belegt]**. Die Vorschau-Form ist nicht entschieden. Die Darstellung im Store ist offen (wie bei `module`). Die Dokumentationsseite zum Store ist `docs/en/programs/platform/packages.md` und `docs/de/programs/platform/packages.md`; sie wird hier nur verlinkt, nicht umgebaut.

## Nachtrag 2026-11-23: Paketarten (Arten-Abgleich, `avatar`, Selbsterklärung, Schrift-Ziel)
Status: **Entwurf** · **ändert** §3 oben (nur noch OCI und Systembenutzer, Vorschlag) und das Feld `install` des Nachtrags 2026-11-16 (Vorschlag). Grundlage: Strategie-Entscheid Paketarten (23.11.2026, angenommen). Die Abschnitte oben bleiben unverändert stehen. Wo dieser Nachtrag einen Punkt oben anders ordnet, steht das bei dem Punkt (§5 Nr. 1–11).

### 1. Arten-Abgleich
Je Art: der AppStream-Typ, der trägt; der Punkt, an dem der Standard endet und ein `fs:`-Feld ergänzt; wo die Art geregelt ist.

| Art | AppStream-Typ (trägt) | Endet bei → `fs:`-Ergänzung | Geregelt in |
|---|---|---|---|
| `program` | `desktop-application` (`console-application` ohne GUI) | Bedarf an Modulen/Formen → `fs:needs` | §2 oben |
| `frontend` | `addon` + `extends` (0094) | Abdeckung, Admin, Vorbild → `fs:covers`, `fs:admin`, `fs:reference` | §2 oben; Schema siehe §5 Nr. 2 |
| `module` | `addon` + `extends` | Befehlssatz `modul@H.N`, Formen → `fs:provides` | Nachtrag 2026-11-14 |
| `theme` | DTCG 2025.10 (Tokens) + `addon` | keine Component-Regeln; Plätze `theme@1.0` | §5 Nr. 9 |
| `icon-theme` | freedesktop Icon Theme 0.13 (`index.theme`) + `icon-theme` | Pflichtnamen → Plätze `icons@1.0` | §2 oben; §4 dieses Nachtrags |
| `font` | `font` + OpenType + fontconfig | Rollen und Lizenz-Gate → Plätze `font@1.0`, SPDX-Pflicht | Nachtrag 2026-11-16; §4 dieses Nachtrags |
| `avatar` | glTF 2.0 + VRM 1.0; AppStream `addon` + `extends` `people` | Personenbezug und Katalog → Plätze `avatar@1.0` | §2 dieses Nachtrags |
| `server` | `service` + rpm/deb/OCI | Registry und Signatur offen | §3 oben |

Die Arten `motion`, `sound-theme`, `haptics`, `shortcuts`, `language` und `workflow` bleiben nach derselben Regel offen (später). `component` ist verworfen (§5 Nr. 1).
Die Paketart-Schnittstelle `fs-interfaces/schema/packagekinds.txt` (Schritt PA-1) legt sechs Arten an. Welche sechs, entscheidet PA-1; die Beispiele im Entscheid sind `theme@1.0`, `icons@1.0`, `font@1.0`, `avatar@1.0`, `frontend@1.0`, `program@1.0` [nicht entschieden: Auswahl PA-1].

### 2. `avatar` als eigene Paketart
- **Entscheid (Strategie, 23.11.2026):** Avatar-Sammlungen sind eine eigene Paketart `avatar`. AppStream `addon`, `<extends>` `people`. Eine Sammlung wird im Katalog angeboten.
- **Der eigene Avatar ist kein Paket.** Er gehört zu den Profildaten der einen Person (Grundsatz „Beispiel Person“, CLAUDE.md §8). AS2 `icon`/`image` mit `mediaType` `model/gltf-binary` und Profil `vrm@1.0` (RFC 6906, wie bei Formen). Die Datei liegt als FileRef in storage. Medientypen `model/gltf-binary` und `model/gltf+json` kommen in die Medientyp-Liste. Galerie „Avatare“ = Modul-Galerie.
- **Plätze `avatar@1.0`:** `model!`, `thumbnail!`, `license!` (Pflicht).
- **Regeln:** `avatar-not-gltf`, `avatar-vrm-meta-missing`, `avatar-too-large` (rot). `avatar-license-forbids` (rot für ein Katalog-Angebot): VRM-Meta verbietet Weitergabe oder Nutzung durch andere (`avatarPermission`, `allowRedistribution`). Ein solcher Avatar wird im Katalog nie angeboten.
- **Vorschau:** 2D aus `thumbnailImage` sofort. 3D-Drehbild erst nach dem Blinc-scene3d-Spike (fs-3d E11), Schritt PA-7.
- **Sicherheit:** Fremde Binärdateien von Personen. Grenzen für Bytes, Dreiecke, Texturgröße; voller Test und Opus-Review (PA-4d).

### 3. Selbsterklärung: `fs:provides` und `fs:needs`
1. **Träger bleibt AppStream-Metainfo**, eine Datei je Paket (ADR 0068, §2 oben, 0094 Entscheidung 2). Sie ist zugleich Katalogquelle, Starter-Manifest und Quelle der RPM-Abhängigkeiten. Daneben gibt es nichts.
2. **`fs:provides` und `fs:needs`** stehen in `<custom>` als Liste `<schnittstelle>@H.N`. Versionsregel wie bei Formen: Haupt gleich, Neben ≥.
3. **Eine Schnittstelle ist eins von drei**, alle im Zeilenformat `key | name | status | description`: ein **Vertrag** (`capabilities.txt`), eine **Form** (`forms.txt`), eine **Paketart-Schnittstelle** (neu: `fs-interfaces/schema/packagekinds.txt`, Liste benannter Plätze mit Art, Pflicht `!` und Anzahl).
4. **Ein Leser `fs-metainfo`** (Bibliothek, Repo fs-interfaces, Schicht 1). Er ersetzt die zwei eigenen Leser (fs-store `fs-packages-catalog` mit roxmltree; fs-starter `manifest_xml.rs`). Der Python-Erzeuger `fs-catalog/scripts/schema_base.py` wird nicht erweitert (§5 Nr. 6).
   - **Crate `appstream` 0.2.2 wird genutzt** (Strategie, 23.11.2026; MIT, crates.io 2022-01-16, letzter Commit 2023-06-17). Auf master liest er `requires`, `recommends`, `supports`, aber `<id>` nur ohne `version`/`compare`. Er liest kein `<custom>` und keine Komponentenart `service`.
   - Bis zum Release trägt ein Port `Metainfo` in `fs-metainfo` den **vorhandenen** roxmltree-Leser (verschoben, nicht neu geschrieben). Nach dem Release wird gegen `appstream` getauscht; die Schnittstelle bleibt.
   - Vier kleine PRs an `appstream` (`<custom>`, `<id version compare>`, Art `service`/`operating-system`, Bitte um Release): **offen** (PRs an upstream; mit offenem KI-Vermerk).
5. **Abhängigkeiten aus einer Wahrheit**, abgeleitet:

   | AppStream | RPM | winget |
   |---|---|---|
   | `requires` (`<id version compare="ge">`) | `Requires:` | `Dependencies.PackageDependencies` |
   | `recommends` | `Recommends:` | – |
   | `supports` | `Suggests:` | – |
   | `extends` (addon) | `Enhances:` | – |

   `fs-blueprint package rpm` (PKG-3) erzeugt die RPM-Zeilen aus der Metainfo, nie von Hand. Die Regel `rpm-requires-drift` (rot) prüft das.
6. **Konformitätsregeln** (fs-conformance, Repo fs-types, Gruppe `package-kind`, gemeinsamer Matcher mit den Form-Regeln G7). Jede Regel hat eine Mutante, die rot wird: `package-kind-unknown`, `package-need-unmet` (gelb im Katalog, rot bei der Installation), `package-version-mismatch`, `package-slot-missing`, `frontend.admin-present`, `frontend.admin-covers-all`, `frontend.normal-present`, `frontend.normal-has-reference`, `theme-overlay-undecorated`, `theme-contrast-low` (WCAG 2.x AA 4.5:1, berechnet), `icon-theme-index-missing`, `icon-name-missing` (gelb), `program-icon-unresolved`, `font-license-unfree`, `font-face-checksum`, `avatar-*` (§2), `sample-as-real`, `rpm-requires-drift`, `metainfo-reader-duplicate`.

### 4. Schrift- und Icon-Ziel (Standard-Orte gehen vor)
- **Schriften:** `/usr/share/fonts/<familie>/` mit fontconfig-conf und Metainfo, über RPM (noarch). Beleg: Fedora (geprüft 23.11.2026), Schrift-RPMs liefern Metainfo unter `/usr/share/metainfo/` und eine fontconfig-conf. Lesen über `fontdb`.
- **Icons:** `/usr/share/icons/<theme>/`.
- **Themes:** bleiben unter `/usr/share/freesynergy/themes/`. Das ist der einzige Teil unter `/usr/share/freesynergy/`.
- Wo ein Text `/usr/share/freesynergy` für Schriften oder Icons nennt, wird er angepasst. Die bisherige Planung „Schriften im fs-starter-RPM unter `/usr/share/freesynergy/fonts`“ entfällt.
- Das Ziel `~/.local/share/fonts` (Nachtrag 2026-11-16, Feld `install`) entfällt für das Release. Es widerspricht der Nutzervorgabe „systemweit, nicht lokal“ (ADR 0069, Nachtrag 23.11.2026 „rpm ist der Hauptweg“). Gleicher Widerspruch in ADR 0089, Punkt 5.

### 5. Die 11 Widersprüche zu ADR 0077 (und Nachbarn)
1. **Schema ≠ ADR.** §1 nennt zehn Werte. fs-catalog `main` kennt `program, frontend, component, theme, server, icon-theme` (Nachtrag 2026-11-16, Z. 74–76). `component` ist dabei, obwohl §1 es verwirft. Es fehlen `motion`, `sound-theme`, `haptics`, `shortcuts`, `language`, `module`, `workflow`, `font`; **`avatar` fehlt überall.** *Auflösung:* Arten-Abgleich §1 und `avatar` §2. `component` bleibt verworfen. Schema-Änderungen für Arten erst nach Schritt P8.
2. **`frontend` → `desktop-application`** im Schema statt `addon` (0094, Kontext Z. 9). Das Feld `extends` fehlt. *Auflösung:* `addon` + `extends` (0094). Schema-Angleichung nach Schritt P8.
3. **`store.capnp` `PackageKind`** = `program, frontend, component, theme, server` (fs-interfaces 1ce2e44, Z. 33–39). 0077 Folge 1 ist nicht umgesetzt; `component` steht drin. *Auflösung:* Nur neue Werte anhängen; bestehende capnp-IDs bleiben.
4. **Kein Bedarf je Art.** 0077 regelt nur den Typ. `fs:provides`/`fs:needs` und Plätze je Art fehlen. *Auflösung:* §3 und `packagekinds.txt`.
5. **Schrift-Ziel.** Nachtrag 2026-11-16 (Z. 86) nennt `~/.local/share/fonts`; ADR 0069 (Nachtrag 23.11.2026) verlangt systemweite Installation über dnf. *Auflösung:* §4 (`/usr/share/fonts`). Gleicher Widerspruch in ADR 0089, Punkt 5 (Nachbar, nicht in diesem Nachtrag geändert).
6. **Katalog-Werkzeug Python.** Folge 3/5 (`gen_catalog.py`) widerspricht CLAUDE.md §7 für neue Regeln. *Auflösung:* Neue Regeln in Rust (fs-conformance). Der Python-Erzeuger wird nicht erweitert; bestehende Skripte bleiben bis zur Inventur und zur Entscheidung über den Umzug.
7. **Server-Sonderweg.** §3 „rpm/deb Pflicht“ gilt nach ADR 0069 (Nutzervorgabe systemweit) faktisch für jedes Programm. *Auflösung:* §3 bleibt nur für OCI und den Systembenutzer.
8. **fs-icons** führt ein eigenes `manifest.toml` und `package.toml type="artifact"` statt `index.theme` und Metainfo `icon-theme`. *Auflösung:* Umstellung in PA-4b.
9. **0074 ↔ 0077, „theme“.** Die sechs Stil-Arten sind noch nicht vereinheitlicht (INVENTUR, Offen). *Vorschlag:* `theme` = DTCG-Tokens; die übrigen Arten bleiben eigene Arten mit eigenen Plätzen.
10. **0094 ist Entwurf.** Ohne Annahme fehlt der Grund für „Frontend als Paket“. *Auflösung:* offen, wird im Bündel mit A0 (Nachtrag 0094 Mindestausstattung) geschlossen.
11. **0023 Darstellungs-Register** (Folge „Format und Ort“ offen). *Auflösung:* Für Pakete beantwortet durch `packagekinds.txt` und `forms.txt`: Ort fs-interfaces, Format Zeilenliste.

### 6. Offen
- **Vier PRs an `appstream`** (bilelmoussaoui/appstream): offen, nicht entschieden (§3 Nr. 4).
- **Avatar-Sammlungen** (Strategie, 23.11.2026): entschieden, ja (§2).
- Paketart-Auswahl für `packagekinds.txt` (PA-1) und die Schema-Angleichung (nach Schritt P8).
- 3D-Avatar (PA-7) nach Spike E11.

## Nachtrag 2026-11-23 (2): Versionsformat der Schnittstellen

Status: **entschieden** (Entscheid Strategie 23.11., Nutzer informiert) · ändert im Nachtrag 2026-11-23 „Paketarten“ nur das Zahlenformat (§1 Tabelle einschließlich der Zeilen `frontend@1.0`, `program@1.0` u. a., §2, §3 Nr. 2) · Regel: ADR 0045, Nachtrag 2026-11-23 „eine Versionsregel“
- `H.N` wird `x.y.z` (SemVer): Befehlssatz `modul@x.y.z`, Plätze `theme@1.0.0`, `icons@1.0.0`, `font@1.0.0`, `avatar@1.0.0`. Die Schreibweise mit `@` bleibt.
- **§3 Nr. 2:** `fs:provides` nennt Versionen (`<schnittstelle>@x.y.z`), `fs:needs` nennt Bereiche (`<schnittstelle>@^x.y.z`, für `0.0.x` nach der Voreinstellung `<schnittstelle>@~0.0.N`), je Listeneintrag genau ein Vergleich (ADR 0045, Nachtrag 2026-11-23, Nr. 5). Die Regel „Haupt gleich, Neben ≥“ wird durch Cargo-Caret ersetzt. Ab 1.0.0 ist das dasselbe; für 0.x gilt Neben gleich.
- Das Profil `vrm@1.0` (§2) bezeichnet den fremden Standard VRM 1.0 und behält dessen Nummer (ADR 0045, Nachtrag, Nr. 8).
