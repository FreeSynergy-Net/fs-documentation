# 0094 – Frontend-Paket: Manifest, Fundort, `requires`/`extends`, Laden durch das Programm, Installation/Update über fs-packages

Status: **Entwurf** (Strategie, 2026-11-16; Entscheidungen b7: O1 XML, O2 Englisch, O3 Lease je Frontend; O4 offen, O5 später) · Grundlage: Nutzerrichtung „Programm und Frontends als Schnittstelle“, F3 (b7: JA) · erweitert 0021, ergänzt 0012, 0045, 0063 um eine Ausnahme (eigenes Binary je Frontend-Paket), 0068, 0074, 0077

## Kontext
- ADR 0021: Programm ↔ Frontend lokal über Unix-Socket, Vertrag Cap'n Proto; „Ein **Frontend ist ein Paket** mit Manifest (benötigte Fähigkeiten, Vertragsversion); installieren → es ist da“. Ein Manifest-Format, ein Fundort und ein Ladeweg sind nirgends festgelegt.
- ADR 0012: Frontend = Oberfläche, austauschbar, „das Programm kennt kein Frontend“. ADR 0045: Plugins sind Hot-Plugins; größere sind „eigene, absturzsichere Prozesse über eine lokale Verbindung“ (Cap'n Proto).
- ADR 0074 §8: „Ein Standard-Frontend kommt immer mit dem Programm.“ §6: Ziel ist das Frontend als Anordnungsdatei; „Heute sind die Frontends Rust-Code im Programm.“
- ADR 0077 §2: `kind = frontend` → AppStream `addon` mit `<extends>`. Ist im Katalog: `frontend` → `desktop-application` (`Catalog/scripts/schema_base.py` Z. 8–17), Format 2 verlangt für `frontend` nur `requires` (`Catalog/docs/format.md` Z. 40); ein Feld `extends` gibt es nicht (ebd., Z. 22–36).
- Code heute: Frontends sind einkompiliert. fs-packages wählt `Face::{Storefront, Compact}` im Fenster (fs-packages v0.0.18 `DESIGN.md` „Frontends (0.0.14)“); `Kind::Frontend` ist installierbar wie ein Programm (`crates/fs-packages-core/src/package.rs` Z. 26–32), ohne Prüfung „Programm da / Vertrag passt“ und ohne Meldung an das Programm [nicht belegt: kein Prüfcode gefunden, Stand v0.0.18].
- Vorhandene Teile: fs-texts trennt `fs-texts-core`, `-server`, `-client`, `-app`, `-bin` (Repo fs-texts `crates/`); der Socket ist `$XDG_RUNTIME_DIR/freesynergy/texts.sock` (`fs-texts-client/src/peer.rs` Z. 25); `serve --lease FILE` beendet den Server, wenn kein Fenster mehr die Sperre hält (`fs-texts-server/src/program.rs` Z. 19). `Control.version` liefert Programm, Version, Protokollstufe; `SupportReport.contractVersion` die Vertragsversion (fs-interfaces `schema/common.capnp` Z. 38–46, 118–119). Die Hülle kann eine veränderliche Frontend-Liste zeigen: `set_frontends(items, active, on_choose)`, `FrontendItem{id,label,names,disabled}` (fs-components `fs-components-app/src/standard.rs` Z. 32, `standard_widget.rs` Z. 47).
- Client-Crates gibt es laut `crates/` der Repos nur in fs-texts, fs-packages (Repo fs-packages `crates/fs-packages-client`) und fs-registry (Repo fs-registry `crates/fs-registry-client`); Server-Crates in mehreren weiteren Programmen (z. B. calendars, files, groups, maps, people, tasks) [nicht belegt: Zählung nicht gegen Tags geprüft].

## Entscheidung
1. **Was ein Frontend-Paket ist.** Ein eigener **Prozess** (ausführbare Datei) mit **Manifest**. Es spricht ausschließlich über den Cap'n-Proto-Vertrag des Programms (Client-Crate `fs-<prog>-client`), nie über `-core` oder `-server`. Es hat eine eigene **Version** (= Tag, wie jedes Paket) und nennt: für welches Programm (`extends`), welchen Vertrag mit Mindestversion (`requires`, Fähigkeitsnamen aus `fs-interfaces/schema/capabilities.txt`, ADR 0068), welche Fähigkeiten es nutzt. Das Programm (Engine, `fs-<prog> serve`) kennt kein bestimmtes Frontend (0012 bleibt); es kennt nur Manifeste.
2. **Manifest-Format: AppStream-Metainfo, minimal.** Kein eigenes Format (ADR 0068). Dieselbe Datei ist Quelle für den Katalogeintrag (`kind = frontend`). Schema-Vorschlag (Text, kein Code):
   - `<component type="addon">`, `<id>` = `net.freesynergy.<prog>.<frontend>` [Präfix nicht belegt; an bestehende IDs angleichen], `<name>` und `<summary>` (übersetzbar), `<extends>` (Pflicht für `addon`, genau eins; siehe unten).
   - `<requires>`: `<id version="X.Y.Z" compare="ge">` Programm-ID (Mindestversion der Engine). Fähigkeiten stehen nicht in `<requires>`, sondern als `<custom><value key="fs:requires">` wie im Katalog (`schema_xml.py`, `custom_values`), z. B. `texts 1.0`: Hauptstufe gleich, Nebenstufe ≥ (übertragen von der Nutzerentscheidung zum Theme-Vertrag; für Frontends neu zu bestätigen).
   - `<extends>` = Katalog-ID des Programms (z. B. `fs-texts`, `catalog.xml`; Ziel nach ADR 0087, `catalog.xml` führt heute noch `fs-wiki`); das Präfix der Frontend-`<id>` wird daran angeglichen.
   - `<custom>`: alle `fs:`-Felder als `<value key="fs:…">` (zulässig: Schlüssel frei, eindeutig, Vendor-Präfix empfohlen): `fs:kind=frontend`, `fs:frontend-id` (englisch, ASCII klein, stabil, = Teil des Binärnamens; O2), `fs:exec` (Programmname ohne Pfad, Argumente als Liste, keine Shell), `fs:contract` (Vertragsname + Version, gegen die gebaut wurde), `fs:style`, `fs:icons` u. a. nach ADR 0074 §8 (optional), `fs:admin=true` nur beim Admin-Frontend; `fs:covers` = Vertrag + Version + abgedeckte Felder/Befehle oder `all` (**Admin-Frontend = `all`**, geprüft von fs-conformance gegen den `TypeCatalog`; normale Frontends zeigen beim Start, was fehlt).
   - `<releases>` mit der Version. Mehr nicht; alles andere (Bilder, Beschreibung) steht im Katalog.
3. **Fundort.** Das Programm liest Manifeste aus genau zwei Ebenen, Nutzer vor System:
   - Nutzer: `$XDG_DATA_HOME/freesynergy/frontends/<prog>/<frontend-id>.metainfo.xml` (tar.gz-Installationen durch fs-packages; von Hand abgelegte Manifeste ebenfalls).
   - System: `<XDG_DATA_DIRS>/freesynergy/frontends/<prog>/…` (rpm/deb; Standard `/usr/share/…`).
   - `fs:exec` wird nur aufgelöst in `current/<frontend-paket>/` des Stores bzw. `/usr/bin`; nie über `PATH`, nie relativ zum Manifest-Ordner außerhalb dieser Orte. „Ladbar“ = Manifest am Fundort, „installiert“ = fs-packages hat es abgelegt: ein Weg, zwei Quellen [nicht belegt: kein Code für die zwei Quellen].
   - **Hot-Plugin:** Das Programm beobachtet beide Ordner (inotify bzw. Abfrage beim Öffnen des Menüs) und baut das Menü „Ansicht › Frontend“ neu (`set_frontends`). Das Ablegen des Manifests **ist** die Benachrichtigung; ein eigener Meldeweg ist nicht nötig.
4. **Laden durch das Programm.** `fs-<prog>` ohne Argumente ist der **Starter** (ADR 0063 bleibt: ein Befehl je Programm).
   - (a) Server sicherstellen: läuft er nicht, `fs-<prog> serve --lease …` starten (Muster fs-texts; Lease je Frontend, kein Wächterprozess, O3). (b) Frontend wählen: `--frontend <id>` > Wahl des Menschen (Einstellungen des Programms) > `fs:default` > eingebautes Standard-Frontend. (c) Vorprüfung aus dem Manifest (`extends`, `requires` gegen die eigene Version und `SupportReport`). (d) Prozess starten mit `--socket <pfad>` und `--lease <datei>`; der Starter wartet, bis das Frontend den Handshake bestanden hat (Rückgabecode oder Bereitschaftszeichen), und endet erst dann (kein Zwischenprozess danach).
   - **Handshake:** Das Frontend ruft zuerst `Control.version` und `supportReport` (bestehende Methoden, kein neuer Vertrag). Passt die Vertragsversion nicht (Hauptstufe ungleich oder Nebenstufe des Servers zu alt), endet es mit eigenem Rückgabecode (Vorschlag 3) und einer Meldung; scheitert der Handshake, zeigt der Starter die Meldung **sichtbar** (ADR 0065 §5) und startet das Standard-Frontend (**Fallback**). Nie still.
   - **Mehrere Frontends parallel:** erlaubt; jedes ist ein Client am selben Socket und hält eine eigene Lease (O3: kein Wächterprozess; der Server endet, wenn die letzte Lease fällt). Wechsel im Menü = neues Frontend starten, das alte sichert seinen Zustand (`suspend_and_exit`, ADR 0069) und endet.
   - **Standard- und Admin-Frontend** kommen immer mit dem Programmpaket (ADR 0074 §8, ADR 0066 §5); sie benutzen dennoch denselben Weg (eigener Prozess, eigenes Manifest), damit es nur einen Ladeweg gibt.
5. **Installation und Update über fs-packages.**
   - Je Frontend ein Katalogeintrag `kind = frontend`, AppStream `addon` (ADR 0077 §2), neues Feld `extends` (Pflicht für `frontend`), `requires` (heute schon Pflicht).
   - **Installieren:** `extends`-Programm installiert? Sonst mit anbieten (Auflösung nach ADR 0068). `requires` gegen die `provides` des installierten Programms prüfen; passt es nicht: gesperrt mit Grund (wie `lock_reason`). Dann wie jedes Paket (Signatur, sha256, `current/<name>`), danach Manifest atomar an den Nutzer-Fundort (temp, `rename`).
   - **Update eines Frontends:** wie ein Fenster nach ADR 0069 Weg B (Frontend beenden, tauschen, neu starten); der Server bleibt unberührt.
   - **Update des Programms:** vorher die installierten Frontends mit `extends` = dieses Programm prüfen; bricht ein `requires`, wird das vor dem Update genannt und das passende Frontend-Update angeboten. Nie ein Frontend still unbrauchbar machen.
   - **Rollback:** der bestehende Ablauf (`Failed` → `RolledBack`) stellt auch das alte Manifest wieder her. **Entfernen:** Manifest weg; ein laufendes Frontend darf zu Ende laufen, beim nächsten Start gilt das Standard-Frontend.
6. **Übergang einkompiliert → eigenes Paket (drei Stufen).**
   - **Stufe 1 (W1-Grundfassungen):** selbes Repo, eigenes Crate und Binary `fs-<prog>-<frontend>` (Abhängigkeit nur `fs-<prog>-client` + fs-components), Manifest unter `packaging/frontends/`, **im selben Release** wie das Programm (tar.gz und AppImage bündeln alle Binaries; deb/rpm entstehen je Cargo-Paket, siehe O4). Das Frontend-Crate ergibt dabei schon heute ein eigenes deb/rpm `fs-<prog>-<frontend>`; deb/rpm des Programms nennen das Frontend-Paket deshalb als Abhängigkeit (`Depends`/`Requires`). Braucht: Server + `serve`, Client-Crate, Starter, Handshake-Test. Kein eigener Katalogeintrag [nicht belegt: ob ein Eintrag je Frontend aus einem Release entsteht]. Die Abhängigkeit steht im Cargo.toml des Programm-Crates (`[package.metadata.deb] depends`, `[package.metadata.generate-rpm] requires`); fs-release übernimmt beides schon heute (cargo-deb liest die Tabelle, eine eigene generate-rpm-Tabelle bleibt unangetastet und muss dann auch `assets` nennen, `scripts/linux-pkg.sh` Z. 19–21), und der Rauchtest installiert alle deb eines Release gemeinsam per apt (`actions/smoke/smoke.sh` Z. 37). Notlösung, nur falls das scheitert: im Katalog „Frontend separat installieren“ sichtbar vermerken; beide Binaries in einem deb nicht, weil das Frontend-Crate sein eigenes deb erzeugt (Dateikonflikt).
   - **Stufe 2:** selbes Repo, **eigene tar.gz** je Frontend und eigener Katalogeintrag (deb/rpm je Frontend gibt es schon ab Stufe 1). Braucht: fs-release kann mehrere Pakete je Repo-Release, Catalog-Feld `extends`, Store-Prüfung nach Punkt 5.
   - **Stufe 3:** eigenes Repo `fs-<prog>-<frontend>` mit eigenen Tags; Vertrag nur über `fs-interfaces`-Pin und das Client-Crate (gerichteter Graph, ADR 0092). Braucht: Client-Crate als eigenständig gepinnte Bibliothek. Auch Dritte bauen so.
   - **Namensregel:** `<frontend>` darf nicht `core`, `server`, `client`, `app`, `bin`, `cli`, `engine`, `testserver` heißen (Kollision mit Crate-Rollen); Anzeigename über `FrontendItem.names` (übersetzbar, ADR 0057). Menschen starten nie `fs-<prog>-<frontend>` direkt, sondern `fs-<prog>` bzw. den Facetten-Link.
7. **Sicherheit.** Das Frontend läuft als die Person, mit den Rechten des Sockets in `$XDG_RUNTIME_DIR` (nur derselbe Nutzer verbindet sich, `common.capnp` Z. 40–41). Es bekommt **keine Rechte über den Vertrag hinaus**: Risikomarken setzt die Engine (ADR 0021), Geheimnisse gehen nie über das Manifest. Signatur und Prüfsumme wie alle Pakete; ein von Hand abgelegtes Manifest wird im Menü als „lokal, nicht geprüft“ gezeigt (Vertrauensanzeigen nicht gestaltbar, ADR 0074 §9.1). `fs:exec` ohne Shell, ohne Pfad. **Keine KI-Rolle:** ein Frontend bekommt nie einen Bot-Schlüssel; KI nur über den Bot-Platz (ADR 0091).
8. **Abnahme.** Bilder zuerst (Workflow `picture-acceptance`), Vorbild-Dossier je Frontend (Workflow `dossier`). Probe: **ein Programm, zwei Frontends als Prozesse** (Vorschlag fs-texts, Client vorhanden), beide gleichzeitig am selben Server. Tests, jeder ohne die Umsetzung rot: falsche Vertrags-Hauptstufe → Abbruch, sichtbare Meldung, Fallback; zu alte Nebenstufe → dasselbe; Manifest entfernt → Menü ohne Eintrag, Standard-Frontend; Manifest neu abgelegt → Eintrag erscheint ohne Neustart; Frontend-Crate hängt nicht an `-core`/`-server` (`cargo tree`-Prüfung). Alle gebauten Frontends werden veröffentlicht; der 1:1-Nachbau bleibt lokal (ADR 0074 §2).
9. **Erster Anwendungsfall: Programm-Fenster der Grundfassung (W1).** Workflow `grundfassung` (fs-release Zweig `unreviewed/workflow-grundfassung`, f5bfc27, v0.0.10; heute Eingabe `frontend_art`, Schritt `fenster`). Der Zweigkopf e11fe69 (aktuell fd9309d5) von `unreviewed/workflow-grundfassung` setzt Eingabe `frontend` und Schritt `frontend-crate` bereits um (ungeprüft):
   - Eingabe **`frontend`** (Frontend-ID nach Punkt 6, englisch, z. B. `simple`) ersetzt `frontend_art`; die Art (Einfach …) bleibt Anzeigename.
   - Neuer Schritt **`frontend-crate`** nach `geruest`, vor `fenster`: legt `crates/fs-<prog>-<frontend>` mit `[[bin]] fs-<prog>-<frontend>` an, Abhängigkeit nur Client + fs-components; Manifest `packaging/frontends/<frontend>.metainfo.xml`; Starter in `fs-<prog>` (Server sicherstellen, Frontend starten, Fallback); Handshake-Test mit falscher Vertragsversion; Abhängigkeitsprüfung. `geruest` liefert dafür Server und `fs-<prog>-client`. `fenster` füllt danach dieses Crate (statt eines einkompilierten Fensters). `binary-test` prüft zusätzlich `fs-<prog>-<frontend> --version`.

## Verhältnis zu bestehenden ADRs
- **0021:** erweitert; Manifest, Fundort, Ladeweg und Handshake werden festgelegt. Ersetzt nichts.
- **0012:** ergänzt; Begriff bleibt, „das Programm kennt kein Frontend“ bleibt (nur Manifeste). Der Dossier-Dateisatz (`frontends/<program>/<version>/`) betrifft Vorbilder, nicht Pakete.
- **0045:** ein Frontend-Paket ist ein Hot-Plugin der Prozess-Art; es zeichnet selbst (keine Szenenbeschreibung nötig).
- **0063:** ergänzt; ein Befehl je Programm bleibt (Starter). Neu: ein Frontend ist ein eigenes Paket und darf ein eigenes Binary `fs-<prog>-<frontend>` haben; es ist keine „Datei je Rolle“ des Programms.
- **0068:** `requires`/`provides` werden für Frontends angewandt (Store beim Installieren, Handshake beim Benutzen).
- **0069:** Frontend-Update = Fenster-Update (Weg B); Wechsel des Frontends nutzt `suspend_and_exit`.
- **0074:** §8 erfüllt (Standard-Frontend mit dem Programm). §6 (Anordnungsdatei) bleibt Ziel, siehe O5.
- **0077:** §2 wird umgesetzt (`frontend` → `addon` + `<extends>`); Folge für Catalog: AppStream-Typ und Feld `extends`.
- **0087:** Namen nach der Namensregel; Frontend-IDs englisch (O2, entschieden). **0066/0038:** vier Frontends je Programm bleiben; ab jetzt sind sie Pakete.
- **0092:** Frontend-Crate hängt nur am Client (gerichteter Graph).
- **0097:** Agenten-Module werden auf demselben Weg gefunden, geprüft, gestartet und aktualisiert wie Frontend-Pakete.

## Folgen
- fs-rpc: Bibliothek `fs-starter` (ohne Blinc; fs-components liegt nach ADR 0093 unter fs-rpc, der Starter braucht `fs_rpc::ServerStarter`): Starter-Baustein (Fundort lesen, beobachten, `set_frontends` füllen, Prozess starten, Fallback) einmal für alle Programme.
- Catalog: `frontend` → AppStream `addon`, Feld `extends` (Pflicht für `frontend`), Prüfung im Generator.
- fs-packages: Prüfung `extends`/`requires` vor dem Installieren und vor Programm-Updates; Manifest ablegen/zurückrollen; Store-Gruppe „Frontends“ zeigt den Bezug.
- Programme: Client-Crate für alle Programme mit Server (fehlt nach den Funden unter Kontext in den meisten [nicht belegt: genaue Zahl]); fs-packages selbst stellt `Face` auf Frontend-Pakete um (Stufe 1).
- fs-release: Workflow `grundfassung` nach Punkt 9 (über `workflow-pflege`); für Stufe 2 mehrere Pakete je Release.
- fs-documentation: Seite „Frontend-Pakete“ (de/en), Verweis aus `docs/*/programs/platform/packages.md`.

## Offen
Entschieden (b7, 2026-11-16) und oben eingearbeitet: **O1** AppStream-XML als Manifest (der Starter liest nur die wenigen Felder aus Punkt 2). **O2** englische Frontend-IDs, ASCII klein wie Crate-Namen (`simple`, `classic`, …); Anzeige übersetzt. **O3** Lease je Frontend (Muster fs-texts `--lease`), kein Wächterprozess.

- **O4 Stufe 2 in fs-release: offen.** Vor Stufe 2 prüfen, ob fs-release mehrere Pakete je Release bauen kann. Befund der Recherche (fs-release v0.0.10, Stand `main` 489e0be4):
  - **Belegt:** `binaries` ist eine kommagetrennte Liste (`actions/plan/plan.py:75`, `.github/workflows/release.yml:11`); mehrere Binaries aus verschiedenen Cargo-Paketen eines Workspace sind möglich (`plan.py:105-112`). Jedes Binary unter `crates/` muss in `binaries` stehen (`plan.py:118-126`).
  - **Belegt:** tar.gz und AppImage enthalten alle Binaries gemeinsam (`actions/package-linux/package.sh:33`, `:55`); deb und rpm entstehen dagegen **je Cargo-Paket** (`package.sh:21-23`, `scripts/linux-pkg.sh`, `DESIGN.md` Z. 10), ein Frontend-Crate ergibt also schon heute ein eigenes deb/rpm `fs-<prog>-<frontend>`. Ein Release hat **einen** Namen (`plan.py:144`, `name`).
  - **[nicht belegt]:** eigene tar.gz je Frontend und eigener Katalogeintrag je Frontend aus einem Release. Signaturen und Prüfsummen entstehen je Datei über den Ausgabeordner (`actions/sign-files/action.yml:2`). Folge: Stufe 2 braucht voraussichtlich eine Erweiterung von fs-release (mehrere Pläne je Release oder Paketliste) über `workflow-pflege`; Stufe 1 braucht nur die Abhängigkeitsangabe.
- **O5 Anordnungsdatei (0074 §6): später.** Vorschlag: ein gemeinsamer Frontend-Prozess (`fs:exec` = Host) liest die Anordnungsdatei; Manifest und Ladeweg bleiben gleich; eigener ADR.

## Verworfen
- **Frontends als dynamische Bibliotheken** (`.so`/`dlopen`): Rust hat keine stabile ABI, ein Absturz nimmt das Programm mit, Austausch zur Laufzeit unsicher; widerspricht 0021/0045 (Prozess über Vertrag).
- **Frontends nur einkompiliert:** widerspricht 0021 („ein Frontend ist ein Paket“); Dritte könnten keine Frontends liefern, der Store keine installieren.
- **Freischalten statt Laden:** Katalog verspricht ein Paket, das keines ist; durch F3 ersetzt.
- **WASM jetzt:** kein Host, Textmessung ungelöst (ADR 0045); später über den Weg aus O5.
- **Binary je Frontend ohne Starter:** Menschen müssten Binärnamen kennen; widerspricht 0063.
- **Eigener Meldekanal Store → Programm:** doppelt; das Ablegen des Manifests am beobachteten Fundort genügt.

## Nachtrag 2026-11-17: Starter wartet aufs Ende des Frontends

Status: **akzeptiert** (Strategie-Entscheid O2 vom 2026-11-17, Prüfung der fs-starter-Probe; kein Nutzerwort) · **ändert** Entscheidung 4(d) (Z. 28): Der Starter wartet nicht auf ein Bereitschaftszeichen, sondern auf das Ende des Frontends; `--lease` entfällt in v1 · baut auf ADR 0069 Nachtrag (Probezeit nach einem Update)

**Entscheidung**
In v1 startet der Starter das Frontend mit `--socket <pfad>` (dazu `--fresh` oder `--resumed TOKEN`, wenn gegeben), wartet auf dessen Ende und gibt dessen Rückgabecode unverändert weiter (0–255; Signal oder außerhalb = 1).

**Grund**
Kein Frontend gibt ein Bereitschaftszeichen; die Probezeit nach einem Update (ADR 0069 Nachtrag) braucht Ende und Dauer (`StartHook::after_end`). Der wartende Starter ist kein Wächter: Er hält keinen Socket und keine Lease und startet nichts neu. Endet er mit dem Frontend durch ein Signal (Strg+C trifft beide), läuft `after_end` nicht; fs-updates wertet ein fehlendes Ende als „nicht bestätigt“, nicht als Absturz.

**Offen**
- `--lease` (Entscheidung 4 a und d) kommt mit fs-rpc 0.0.4.
- Ein Bereitschaftszeichen, nach dem der Starter früher endet, ist ein eigener Nachtrag.
