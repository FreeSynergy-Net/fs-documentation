# 0099 – Bauplan (`scaffold.toml`) und zwei Rollen: Bau-Werkzeug für das Projekt, fs-scaffold für Instanzen

Status: **akzeptiert** (Nutzer, Gespräch 1 vom 2026-11-17: Antworten 123, 127, 128, 133, 134; Gespräch 2: Start jetzt; Grundidee „Wir programmieren keine Programme mehr, wir stecken sie nur noch zusammen“, 17.11.) · **ändert** ADR 0087 Nachtrag 17.11. [Entw.] Punkt 10: fs-scaffold „nutzt“ den Workflow `scaffold-ai` nicht mehr, das Gerüst entsteht deterministisch (Rolle 1); Punkt 10 bleibt als Rolle 2 · **ersetzt** im Workflow `grundfassung` den Schritt `geruest` (`call: scaffold-ai`, fs-release `workflows/grundfassung.yaml:79-80`), sobald das Bau-Werkzeug gleichwertig ist (Antwort 127) · baut auf ADR 0021, 0045, 0063, 0066, 0068, 0076, 0086, 0092, 0093, 0094 [Entw.], 0098 [Entw.] · Grundlage: Plan Baukasten (Fassung 5) §c

**Hinweis (2026-11-21, Entwurf ADR 0105):** ADR 0105 (Folge (a): ein gemeinsamer Host) lässt Nr. 15 (Zwischenschritt: erzeugte minimale `main`) aus; Nr. 11 (`release.yml` mit Windows-Zielen) und Nr. 12 (Admin-Layout `covers = "all"`) sind im Code von `fs-blueprint` nicht umgesetzt. Alle drei stehen in ADR 0105 unter „Abweichungen von bestehenden ADRs“. Solange ADR 0105 Entwurf ist, gelten die Regeln hier weiter.

**Kontext**
- Heute schreibt eine KI das Gerüst jedes Programms neu (`scaffold-ai`). Ergebnis: **fünf fast gleiche Kopien** der Programmhülle (activities, decisions, forms, messages, resources: `starter.rs` 183 Z., Diff nach Namensersatz 0; `main.rs` 54 Z., Diff 2; Inventur 17.11.).
- Handcode-Anteil der Programme heute: Untergrenze 34 % (76 782 von 228 465 Z.), Obergrenze 46 % (113 036 von 243 576 Z. mit Werkbänken); Rest ist Gerüst, Modul, Bausatz, Komponente oder Test (Plan §a3).
- ADR 0087 Nachtrag Punkt 10 [Entw.] beschreibt fs-scaffold als Programm, das Datenmodelle mit Standardbeleg besitzt und über `programm-neu`/`grundfassung` Programme erzeugt; Admins einer Instanz geben frei.

**Entscheidung**
1. **Ein Bauplan beschreibt ein Programm vollständig:** Datei `scaffold.toml`, TOML 1.0 mit festen Typen (`deny_unknown_fields`, `schema = 1`), keine personenbezogenen Daten. Tabellen:
   - `[program]`: `name` (Namensregel geprüft), `skeleton` (Gerüst-Version), `capability`.
   - `[[module]]`: `name`, `version` (gemeinsame Version = Tag des Modul-Repos).
   - `[[type]]` mit `standard` (URI + Abschnitt, Pflicht), `media_type`, `[[type.field]]` mit `kit` (Bausatz, ADR 0098) oder `basic` (Grundtyp), `multiple`, `words`.
   - `[[ruleset]]`: Fachregeln als **einstellbares Regelwerk** mit `presets` (Voreinstellungs-Sätze, z. B. `freesynergy`, `like-outlook`) und `default`; **keine festen Zustände** (Antwort 133); ein Zustandsplan ist nur Voreinstellung.
   - `[frontend]`: Standard-Frontend, `covers` (Abdeckung; `all` = Admin).
   - `[[exception]]`: eigener Code nur mit `what`, `why`, `checked`, `alternatives` und **`talk`** = Pfad zum Protokoll eines **Ausnahme-Gesprächs** Nutzer + Opus (Nutzer, Antwort 128: „Dann reden wir darüber, warum es nicht passt und vor allem, wozu es passt.“ … „Antwort also: Beide.“). Ohne `talk` lehnt die Prüfung ab. Ausgestaltung (kein Nutzerwort): nicht die Zeilenzahl entscheidet.
2. **Rolle 1: Bau-Werkzeug `fs-blueprint`** (Arbeitsname; Bibliothek + Befehl im Repo fs-release, Werkzeug, nicht zur Laufzeit). Es erzeugt aus dem Bauplan: Cargo-Workspace (`-core` mit Fachmodul-Traits, `-server` mit `ProgramRoot`, `-client`, `-bin` = Aufruf von `fs_starter::run`, Standard-Frontend), Cap'n-Proto-Vertrag (eigene Datei-ID, nur anhängen), Tabellen + Schritte + Wort-Tabellen, `TypeCatalog`, Medientypen, Paketdateien (AppStream, deb/rpm), CI mit gepinntem fs-release-Tag, MF2-Texte, Hilfe-Gerüst (fs-texts), Doku-Gerüst, Konformitätstests aus fs-conformance.
   - **Deterministisch:** gleiche Eingabe + gleiche Werkzeug-Version = byte-gleiche Ausgabe; die Werkzeug-Version umfasst die gepinnte Toolchain und `rustfmt`; `Cargo.lock` wird nicht erzeugt (Muster: Test `generated_matches_official`); CI-Schritt `fs-blueprint check`.
   - **Eingecheckt:** erzeugter Code liegt im Repo (lesbar, prüfbar, debugbar), mit Kopfzeile „erzeugt von fs-blueprint <Version> aus scaffold.toml sha256 …“; nie von Hand ändern. Eine Datei unter `crates/` ohne diese Kopfzeile und ohne `[[exception]]` macht die Prüfung rot. Das gilt für Crates aus dem Bauplan; `crates/fs-<prog>-<frontend>` (handgebaut nach ADR 0094/0066) und `tests/` sind ausgenommen; bestehende Programme erst ab ihrem Lift.
   - **Ablösung `scaffold-ai`** sobald gleichwertig (Antwort 127); Gegenprobe: erzeugte activities-Hülle byte-gleich mit der Hand-Extraktion (Plan M4).
3. **Rolle 2: Programm `fs-scaffold`** (Name vom Nutzer, Frage 116): Datenmodell-Baukasten nach ADR 0087 Nachtrag Punkt 10 [Entw.]. Es erstellt Baupläne mit Standardbeleg je Feld. Ziel (Antwort 123: „JA, wenn es geht“): ein **Laufzeit-Host** führt einfache Baupläne **ohne Bauen (Kompilieren)** aus, wie `fs-forms-run` Oberflächen; sonst übergibt er an Rolle 1.
   - **Wer darf** (Antwort 134): **erst nur das Projekt**; ab einem Limit alle (OFFEN, siehe Offen 1); jeder kann **eigene Repos** mit Bauplänen anlegen und anbieten (dezentral, Katalog fremder Repos nach ADR 0036).
4. **Vor dem Schreiben eines Bauplans** prüft der Workflow `vorhandenes-zuerst` Katalog (Module, Bausätze, Components), Arbeitsstände und offene Zweige (Nutzerregel „Vorhandenes zuerst“).
5. **Änderungen nur über den Bauplan:** Workflow `schema-update` (nur anhängen: capnp `@N`, Spalten, Wörter; neuer Schritt statt Umbau); Gerüst-Version anheben = gebündelter Lauf aller Programme (`geruest-heben`).

**Pflichttests** (je ohne Umsetzung rot)
- Unbekannter Schlüssel im Bauplan → abgelehnt; Feld ohne Standardbeleg → abgelehnt.
- `[[exception]]` ohne `talk` → abgelehnt.
- Zweimal erzeugen → byte-gleich; Mutant „Zeitstempel in Ausgabe“ → rot.
- Datei ohne Erzeuger-Kopf und ohne Ausnahme (außer Frontend-Crates und `tests/`) → `fs-blueprint check` rot.
- Vertragsänderung, die `@N`, Typ oder Standardwert ändert → abgelehnt.
- `[[ruleset]]` ohne `default` oder mit unbekanntem Preset → abgelehnt.

**Folgen**
- fs-release: Workflows `programm-neu`/`programm-grundgeruest` zu einem Weg (`vorhandenes-zuerst` → `manifest-schreiben` → `manifest-pruefen` → `generieren` → Gates); `grundfassung`: `geruest` + `frontend-crate` + `manifest` + `lock-sources` = `generieren`; `trait-delta` = Bauplan-Diff; `lift` = `geruest-heben`; neu `ausnahme-gespraech` (über `workflow-pflege`).
- ADR 0087 Nachtrag Punkt 10 [Entw.]: Satz „fs-scaffold nutzt diesen Workflow nur“ und „Ausgabe (d)“ an Rolle 1/2 angleichen.
- Gesprächsprotokolle für Ausnahmen: Ablage `fs-documentation` (Ort OFFEN, Vorschlag `conventions/talks/`).

**Offen**
1. Limit, ab dem alle Baupläne anlegen dürfen (Empfehlung: sobald der Laufzeit-Host stabil ist und die Prüfung automatisch läuft). [offen]
2. Endgültiger Name des Bau-Werkzeugs (`fs-blueprint` ist Arbeitsname). [offen]
3. Format des Laufzeit-Hosts für Baupläne und sein Verhältnis zu `fs-forms-run` (siehe ADR 0096 „Format, Speicher und Host“). [offen]

## Nachtrag 2026-11-18: Bauplan-Schema 2 (`kind`, `[[bundle]]`, `paths`), Ort und Name des Bau-Werkzeugs

Status: **Entwurf** (Nutzer, Entscheid W1 vom 2026-11-18 über die Strategie 6e: Ort fs-release, Name `fs-blueprint`, Feld `paths` in `[[exception]]`, `schema = 2` mit `kind` = `standard`/`toolkit`/`component`, `[[bundle]]` eigene Tabelle; Nutzerregel 18.11. „bis zu den ersten echten Nutzern keine Datenmigrationen und keine Kompatibilitäts-Schichten für alte Daten und Formate“; Nutzerentscheid 45 vom 2026-11-18 (Ziel und Zwischenschritt der main); Ausgestaltung Opus) · **ändert** Entscheidung 1 (Z. 11–17: `schema = 1`, Tabellen `[program]`, `[[type]]`, `[[ruleset]]`, `[frontend]`, `[[exception]]`) und Entscheidung 2 (Z. 18: „Standard-Frontend“ wird nicht mehr als Crate erzeugt) · **schließt** Offen 2 (Name) · **setzt um** ADR 0101 Entscheidung 10 und Folgen (Z. 44) · **ändert** ADR 0101 Entscheidung 7 (Z. 23, „Keine weiteren Felder“) um genau das Feld `paths` · **präzisiert** ADR 0101 Folgen (Z. 45, `[[component]]`): es gibt keine Tabelle `[[component]]` · baut auf ADR 0020, 0045, 0057, 0066, 0068, 0086, 0087, 0092, 0094, 0096, 0097, 0098, 0100 · Grundlage: Plan scaffold-Kern (18.11., §3–§7), Plan V0 Vorrang forms/scaffold (18.11., Lücke V0-L13), Befund Hüllen-Slots (S0), Plan Planungs-Bausatz §6 (a)

**Kontext**
- ADR 0101 Entscheidung 10 legt fest, dass jedes `[[module]]` des Bauplans ein Pflichtfeld `kind` trägt und `[[bundle]]` eine eigene Tabelle ist; das verlangt `schema = 2` und einen Nachtrag hier (ADR 0101, Folgen).
- Der Erzeuger braucht für die Prüfung „Datei unter `crates/` ohne Erzeuger-Kopf und ohne `[[exception]]` → rot“ (Entscheidung 2, Pflichttests; ADR 0097 Pflichttests) eine Zuordnung von Dateien zu Ausnahmen. Heute nennt `[[exception]]` keine Dateien; der Erzeuger kann nicht wissen, welche Datei welche Ausnahme deckt (Plan scaffold-Kern §3.4, Frage SK4).
- Der Befund S0 zu den fünf Hüllen-Kopien (activities, decisions, forms, messages, resources) zeigt, welche Werte je Programm wirklich verschieden sind: Programmname, Vertragsname (nicht immer gleich dem Programmnamen: activities trägt `history`), Vertragsversion, Beschreibung, Desktop-Kategorie, Binärliste, Hilfetext, App-ID. Ein Teil davon fehlt im Schema 1 (Vertragsversion, Datei-ID, Beschreibung, Kategorie).
- Neue Frontends entstehen nur noch als forms-Beschreibung (ADR 0094 Nachtrag 17.11. (2) [Entw.] Z. 104; ADR 0096 Entscheidung 6–7). Entscheidung 2 nennt dagegen ein erzeugtes „Standard-Frontend“ (Z. 18) und `[frontend]` meint ein Crate (Beispiel `standard = "simple"`, Plan Baukasten §c1).
- Es gibt heute keinen Bauplan in Schema 1: kein `scaffold.toml` in den Programm-Repos (Suche in den Arbeitskopien des Projekts, 18.11.), kein Zweig `blueprint*` in fs-release (Plan V0 §2.B).

**Entscheidung**
1. **Ort und Name (entschieden, W1):** Das Bau-Werkzeug heißt **`fs-blueprint`** (Bibliothek und Befehl) und liegt im Repo **fs-release** (Werkzeug, nicht zur Laufzeit; wie Entscheidung 2 und ADR 0097 Entscheidung 1). Der Name `fs-scaffold` bleibt dem Programm (Rolle 2). Offen 2 ist damit erledigt. Begründung: zwei verschiedene Dinge mit einem Namen verwechseln Menschen; fs-release ist von jedem Programm schon in CI gepinnt, `fs-blueprint check` braucht also keine neue Pin-Kette.
2. **`schema = 2` gilt allein.** Ein Bauplan mit `schema = 1` wird abgelehnt (`schema-unsupported{found, known}`), ein Bauplan mit `schema > 2` ebenso (`schema-newer{found, known}`). Es gibt **keine Migration** von 1 nach 2 und keinen Lesepfad für Schema 1 (Nutzerregel 18.11.; es gibt auch keinen Bauplan in Schema 1, siehe Kontext). Diese Regel gilt bis zu den ersten echten Nutzern; danach wird über Migration und Lesbarkeit alter Fassungen neu entschieden (Offen 4). Die Regel betrifft Daten und Formate, nicht Repos, Zweige oder Tags.
3. **Form:** TOML 1.0, feste Typen, `deny_unknown_fields` auf jeder Tabelle, keine personenbezogenen Daten (wie Entscheidung 1). Die Datei ist bis auf Weiteres die Quelle (Nutzer, Frage 19, zitiert in ADR 0096 Kontext Z. 11: „scaffold.toml … bleiben JETZT Dateien … später in die DB (Datei = Export)“); dieses Schema ist zugleich die Vorlage für die typisierten Tabellen von Rolle 2. Wörter und Bezeichner sind englisch (ADR 0002/0011), menschenlesbare Texte zweisprachig (Punkt 9).
4. **Schema 2, vollständig.** Es gibt genau diese Schlüssel; jeder andere Schlüssel ist `unknown-key{path}`. „Text2“ heißt: Tabelle `{ en = "…", de = "…" }`, beide Pflicht, jeweils eine MF2-Nachricht (ADR 0057), gleiche Variablen in beiden Sprachen.

   | Schlüssel | Typ | Pflicht | Voreinstellung | Bedeutung und Prüfung | Beispiel |
   |---|---|---|---|---|---|
   | `schema` | Ganzzahl | ja | – | Muss `2` sein (Punkt 2) | `2` |
   | `[program] name` | Text, `^[a-z][a-z0-9-]*$` | ja | – | Programmname ohne `fs-`; Namensregel ADR 0087 (Programme Mehrzahl, klein) → sonst `name-rule{name}`; daraus Crates `fs-<name>-*`, App-ID `net.freesynergy.<Name>` | `"tasks"` |
   | `[program] skeleton` | Text, SemVer | ja | – | Gerüst-Version; eine Tabelle in `fs-blueprint` ordnet ihr die Tags von fs-types, fs-rpc (mit fs-starter), fs-components (mit fs-settings), fs-interfaces und fs-release zu; unbekannt → `skeleton-unknown{found}` | `"0.1.0"` |
   | `[program] capability` | Text | ja | – | Hauptthema; nach ADR 0068 zugleich Name der Vertragsdatei `<capability>.capnp` in fs-interfaces; muss in `capabilities.txt` am gepinnten Stand stehen → sonst `capability-unknown{key}` | `"tasks"` |
   | `[program] summary` | Text2 | ja | – | Ein Satz: AppStream `summary`, Desktop-`Comment` | siehe Beispiel |
   | `[program] description` | Text2 | ja | – | Ein Absatz: AppStream `description`, Kopf der Hilfe-Seite | siehe Beispiel |
   | `[program] categories` | Liste Text, ≥ 1 | ja | – | Desktop-Kategorien (freedesktop Desktop Menu), mindestens eine Hauptkategorie → sonst `category-main-missing` | `["Office", "ProjectManagement"]` |
   | `[program] icon` | Text | nein | App-ID | Symbolname (freedesktop Icon Naming) aus fs-icons; fehlt das Symbol, nimmt der Erzeuger das nächste vorhandene, nie eine Platzhalter-Grafik | `"net.freesynergy.Tasks"` |
   | `[contract] version` | Text `major.minor` | ja | – | Vertragsversion: der Client erwartet sie, der Server meldet sie | `"0.1"` |
   | `[contract] id` | Text `0x` + 16 Hex | ja | – | Cap'n-Proto-Datei-ID, einmal vergeben, nie geändert (Erzeugung byte-gleich) → Änderung `contract-change{item="id"}` | `"0xc04d258971543476"` |
   | `[contract] provides` | Liste Text | nein | `[]` | weitere Fähigkeits-Schlüssel aus `capabilities.txt`, die das Programm meldet | `["dependency.evaluate"]` |
   | `[[module]] name` | Text | ja | – | Name im Katalog am gepinnten Stand → sonst `module-unknown{name}` | `"fs-todo"` |
   | `[[module]] kind` | Wort | ja | – | `standard` (Art 1), `toolkit` (Art 2), `component` (Art 3) nach ADR 0101; fehlt → `field-missing{table, field}`, anderer Wert → `kind-unknown{module, found}`, anders als im Katalog des Moduls → `kind-mismatch{module, declared, catalog}` | `"standard"` |
   | `[[module]] version` | Text, SemVer | ja | – | gemeinsame Version = vorhandener Tag des Modul-Repos (Entscheidung 1) → sonst `version-unknown{module, version}` | `"0.0.1"` |
   | `[[bundle]] name` | Text | ja | – | Modul-Bausatz (Art 2 als Ganzes, Bündel mit Fassade, ADR 0101 E2) im Katalog | `"fs-planning"` |
   | `[[bundle]] version` | Text, SemVer | ja | – | Tag des Bausatz-Repos | `"0.0.1"` |
   | `[[bundle]] parts` | Liste Text, ≥ 1 | ja | – | genutzte Teile (die Module des Bausatzes), Teilmenge seiner Teile → sonst `bundle-part-unknown{bundle, part}`; ein Teil darf nicht zusätzlich als `[[module]]` stehen → `module-in-bundle{module, bundle}` | `["readiness", "progress"]` |
   | `[[bundle]] item` | Text | ja | – | der `[[type]]`, über den das Programm den Port des Bausatzes bedient → sonst `type-unknown{name}` | `"Task"` |
   | `[[type]] name` | Text, PascalCase | ja | – | Name des Datentyps im `TypeCatalog` | `"Task"` |
   | `[[type]] module` | Text | nein | – | Art-1-Modul (`kind = "standard"`), das den Typ liefert; anderes `kind` → `kind-wrong-role{module, expected}`. Fehlt es, ist der Typ programmeigen (Fachmodul mit einem Nutzer, ADR 0097 E3; Seed im `-core`) | `"fs-todo"` |
   | `[[type]] standard` | Text, URI mit Abschnitt | ohne `module`: ja; mit `module`: verboten | – | Inhaltsstandard (ADR 0014/0020); mit `module` gehört er dem Modul → `owned-by-module{type, key}` | `"https://www.rfc-editor.org/rfc/rfc8984#section-2.2"` |
   | `[[type]] envelope` | Text | wie `standard` | – | AS2-Typ der Hülle (ADR 0020 E1) oder volle IRI eines Erweiterungstyps | `"Note"` |
   | `[[type]] media_type` | Text (RFC 6838) | wie `standard` | – | Medientyp (ADR 0098 E5) | `"application/jscalendar+json"` |
   | `[[type]] label` | Text2 | wie `standard` | – | Anzeigename des Typs | siehe Beispiel |
   | `[[type.field]] name` | Text, camelCase | ja | – | Feldname; nur bei Typen ohne `module` erlaubt → sonst `owned-by-module{type, key="field"}` | `"span"` |
   | `[[type.field]] kit` | Text | genau eins von `kit`/`basic` | – | Datenbausatz aus fs-types (ADR 0098) → sonst `kit-unknown{name}`; beide → `field-kind-both{field}`, keins → `field-kind-missing{field}` | `"timeSpan"` |
   | `[[type.field]] basic` | Text | s. o. | – | Grundtyp aus fs-types `BasicType` am gepinnten Stand → sonst `basic-unknown{name}` | `"text"` |
   | `[[type.field]] standard` | Text, URI mit Abschnitt | ja | – | Fundstelle des Feldes im Standard; erweitert das Feld den Standard, steht hier der Eintrag der Einreichung in fs-texts (ADR 0101 E5) → fehlt → `standard-missing{type, field}` | `"https://www.rfc-editor.org/rfc/rfc8984#section-4.4.6"` |
   | `[[type.field]] multiple` | Wahrheitswert | nein | `false` | Liste statt Einzelwert (Speicherform ADR 0086/0098) | `true` |
   | `[[type.field]] words` | Text `<modul>:<liste>` | nein | – | Wortliste eines genannten Moduls; nur bei `basic` `choice`/`keywords` → sonst `words-unknown{ref}` | `"fs-progress:state"` |
   | `[[type.field]] label` | Text2 | ja | – | Anzeigename des Feldes | siehe Beispiel |
   | `[[ruleset]] name` | Text | ja | – | Name des Regelwerks; daraus die Einstellung `fs.<program>.rules.<name>` (Art Auswahl, ADR 0100 E3) | `"progress"` |
   | `[[ruleset]] type` | Text | ja | – | betroffener `[[type]]` | `"Task"` |
   | `[[ruleset]] from` | Text | ja | – | `[[module]]` (`standard`/`toolkit`) oder `[[bundle]]`, das die Voreinstellungs-Sätze liefert; Texte kommen von dort → sonst `ruleset-source-unknown{name}` | `"fs-planning"` |
   | `[[ruleset]] presets` | Liste Text, ≥ 1 | ja | – | Voreinstellungs-Sätze (Antwort 133) → unbekannt `preset-unknown{ruleset, preset}` | `["rfc8984", "freesynergy"]` |
   | `[[ruleset]] default` | Text | ja | – | muss in `presets` stehen → sonst `ruleset-default-missing{ruleset}` | `"freesynergy"` |
   | `[frontend] standard` | Text | ja | – | `fs:frontend-id` des Standard-Frontends (ADR 0094 E1) | `"board"` |
   | `[frontend] layout` | Text, Pfad | ja | – | Austauschdatei der forms-Beschreibung (Format 2, ADR 0096 E6) im Repo → fehlt `layout-not-found{path}` | `"layout/board.toml"` |
   | `[frontend] covers` | `"all"` oder Liste Text | ja | – | Abdeckung `fs:covers` (ADR 0097 E6) als `<Schnittstelle>.<Methode>` bzw. `<Typ>.<Feld>` des `TypeCatalog` | `["Items.list"]` |
   | `[[exception]] what` | Text | ja | – | was der eigene Code tut (Prosa, wird nicht übersetzt, erscheint nicht im Programm) | – |
   | `[[exception]] why` | Text | ja | – | warum kein Modul, Bausatz oder Component passt | – |
   | `[[exception]] checked` | Liste Text, ≥ 1 | ja | – | geprüfte Kandidaten (Vorhandenes zuerst) | – |
   | `[[exception]] alternatives` | Liste Text | ja | – | erwogene Wege | – |
   | `[[exception]] talk` | Text, Pfad | ja | – | Protokoll des Ausnahme-Gesprächs Nutzer + Opus (Entscheidung 1; ADR 0097 E5) → fehlt `field-missing`, Datei nicht da `talk-not-found{path}` | – |
   | `[[exception]] paths` | Liste Text, ≥ 1 | ja | – | Dateien oder Ordner (Punkt 7) | `["crates/fs-tasks-core/src/secret_guard.rs"]` |

5. **`kind`: was je Art erzeugt und gefordert wird** (die Art ist eine Eigenschaft des Moduls, nicht der Wahl des Programms; der Bauplan wiederholt sie, damit ein Mensch sie liest und die Prüfung sie gegen den Katalog vergleicht):
   - **`standard` (Art 1):** darf Typen liefern (`[[type]] module`), Wortlisten (`words`), Regelwerke (`[[ruleset]] from`) und die Ein- und Ausgabeformate seiner Daten (ADR 0097 E3, Pflichten jedes Moduls). Der Erzeuger schreibt die Abhängigkeit (gepinnter Tag) in `-core`/`-server`, die Einträge in `TypeCatalog` und Medientyp und die Bindung der Standard-Component (ADR 0098 E5). Er erzeugt **keinen** Code, der Inhalt des Moduls nachbaut.
   - **`toolkit` (Art 2):** darf Verfahren und Regelwerke liefern, aber **keine Typen und keinen Speicher** (ADR 0101 E2: kennt keinen Programmvertrag, keine Anzeige, fremde Daten nur über einen Port). Der Erzeuger schreibt die Abhängigkeit und die Port-Bindung an den genannten Typ. `[[type]] module` auf ein `toolkit` → `kind-wrong-role`. Ob mindestens zwei Programme den Bausatz nutzen (ADR 0101 E2), prüft der Katalog über alle Baupläne, nicht der einzelne Bauplan.
   - **`component` (Art 3):** steht **nie** als Abhängigkeit in `-core`, `-server`, `-client` oder `-bin` (ein Programm hat keine Anzeige; ADR 0094 E1). Der Erzeuger schreibt die Components nur ins Frontend-Manifest (`fs:requires`) und prüft, dass die Austauschdatei des Frontends nur genannte Components oder Standard-Components verwendet (`component-undeclared{block}`). Components liefern keine Typen und keine Regelwerke.
   - **`[[bundle]]`** ist Art 2 als Ganzes: es nennt die genutzten Teile (`parts`) und den bedienten Typ (`item`). Ein Teil eines Bündels steht nicht zusätzlich als `[[module]]` (eine Quelle je Baustein, ADR 0092 Regel 2). Eine Tabelle `[[component]]` gibt es nicht; Components stehen als `[[module]]` mit `kind = "component"` (ADR 0101 E10).
6. **Programmeigene Typen und Modul-Typen:** Ein Typ mit `module` gehört dem Modul; Standard, Hülle, Medientyp, Bezeichnung und Felder kommen von dort, der Bauplan nennt nur den Namen. Ein Programm erweitert einen Modul-Typ nicht im eigenen Bauplan; fehlt ein Feld, wird es im Modul ergänzt (mit Beleg nach ADR 0101 E5). Nur ein Typ ohne `module` hat eigene Felder; daraus entsteht das Fachmodul-Gerüst im `-core` (Entscheidung 2).
7. **`[[exception]] paths` (entschieden, W1):**
   - *Form:* Pfade relativ zur Repo-Wurzel, mit `/` auch unter Windows, ohne `..`, ohne führendes `/`, ohne Platzhalter (`*`, `?`); ein Eintrag mit End-`/` meint den ganzen Ordner. Sonst `path-invalid{path}`. Begründung: Platzhalter machen die Zuordnung abhängig von der Dateiliste; ohne sie ist sie aus dem Bauplan allein ablesbar und byte-gleich prüfbar.
   - *Wirkung:* `fs-blueprint generate` schreibt eine genannte Datei nie und verlangt keinen Erzeuger-Kopf; `fs-blueprint check` zählt sie als Ausnahme (Klasse `Exception` neben `Generated` und `Seed`).
   - *Prüfung:* jeder Pfad existiert (`path-not-found{path}`); keiner deckt eine erzeugte Datei (`path-generated{path}`); zwei Ausnahmen decken keine gemeinsame Datei (`path-overlap{path, first, second}`); jede Datei unter `crates/` ohne Erzeuger-Kopf, die kein Seed ist, liegt in genau einem `paths` (`file-unowned{path}`; Ausnahmen aus Entscheidung 2: handgebaute Frontend-Crates im Bestand und `tests/`).
   - *Gesprächspflicht:* unverändert; ohne `talk` keine Ausnahme. `talk` ist ein Pfad im Repo fs-documentation (Ort der Protokolle weiter offen, ADR 0097 Offen 8, Vorschlag `conventions/talks/`); `check` liest ihn in CI aus einem flachen Klon von fs-documentation main.
   - *Ablauf:* **kein** Datumsfeld (ADR 0101 E7: keine weiteren Felder außer `paths`). Eine Ausnahme gilt für die Gerüst-Version, unter der sie geprüft wurde. Hebt `geruest-heben` die Gerüst-Version, führt der Workflow für jede Ausnahme `vorhanden-pruefen` neu aus; gibt es jetzt einen passenden Baustein, wird die Ausnahme im nächsten Gespräch aufgelöst oder bestätigt (Vorschlag; Offen 3).
   - *Einstieg ausgenommen:* Kein `paths`-Eintrag darf eine `main.rs` des Repos decken, weder als Datei noch über einen Ordner; sonst `main-reserved{path}`. Der Einstieg ist erzeugt und austauschbar (Punkt 15); eigener Code gehört nie dorthin.
8. **Fehler sind Code + Parameter:** Jede Ablehnung von `fs-blueprint` ist ein Wert der `coded`-Form aus fs-types (Code kebab-case englisch, benannte Parameter), nie ein englischer Satz. Die Sätze stehen als MF2-Nachrichten `blueprint-error-<code>` in de und en im Werkzeug (ADR 0057). Die Codes in diesem Nachtrag sind die Startliste; neue Codes nur anhängen.
9. **Texte:** Nur `summary`, `description` und `label` sind menschenlesbare Texte im Bauplan; sie sind Text2 (de + en, MF2, gleiche Variablen; fehlt eine Sprache → `text-pair{key, missing}`, verschiedene Variablen → `text-vars{key}`). Weitere Sprachen kommen als Sprachpaket (ADR 0057 Punkt 3), nicht in den Bauplan. Wortlisten und Texte der Regelwerke liefert das Modul, nicht der Bauplan. `what`/`why` sind Projektprosa, keine Programmtexte.
10. **Gerüst-Einbindung ist Pflicht und nicht abwählbar:** Das Gerüst aus ADR 0097 Entscheidung 2 (Starter, Sitzung, Selbst-Update, Darstellung, Hilfe, Außen-Schnittstelle mit SCIM/OAuth nach ADR 0024, MCP abschaltbar und nach der Installation aus, Git, Sicherung, Workflows, Konformität) hängt allein an `skeleton`. Es gibt **kein Feld**, das einen Pflichtteil abschaltet oder MCP einschaltet (`deny_unknown_fields`). Teile, die es zur Gerüst-Version noch nicht gibt, meldet `check` sichtbar als `skeleton-part-pending{part}` und listet sie in der erzeugten Doku; der zugehörige Konformitätstest ist mit genau diesem Code als ausstehend markiert, nie still weggelassen (Vorschlag; Offen 2). Heute vorhanden: fs-starter, fs-rpc, fs-conformance, fs-settings (Plan scaffold-Kern §1); nicht vorhanden u. a. fs-session, fs-update, fs-connect/fs-access, MCP-Schalter, fs-git, fs-backup, fs-flow.
11. **Windows-CI ist erzeugter Teil:** Der Erzeuger schreibt neben `check.yml` und `release.yml` immer `windows.yml` (Aufruf des gepinnten fs-release-Workflows) und setzt in `release.yml` die Windows-Ziele; es gibt kein Feld zum Abschalten. Der Transport unter Windows kommt aus fs-rpc/fs-starter (Named Pipe), nicht aus eigenem Code.
12. **Frontend:** `[frontend]` erzeugt **kein** Frontend-Crate (ändert Entscheidung 2, Z. 18 „Standard-Frontend“). Es erzeugt das Frontend-Manifest (AppStream `addon`, `fs:exec = fs-forms-run`, `fs:frontend-id`, `fs:covers`; ADR 0094 und Nachtrag 17.11. (2)) und das Paket `layout`, das die Austauschdatei trägt (ADR 0096 E7). Zusätzlich erzeugt es immer ein Admin-Layout mit `covers = "all"` aus dem `TypeCatalog` (ADR 0097 E6). Die Ausnahme in Entscheidung 2 für handgebaute Frontend-Crates gilt nur für den Bestand.
13. **Vertragstext:** Der Bauplan hält vom Vertrag nur `id`, `version` und `provides`. Der Vertragstext liegt nach ADR 0045 in fs-interfaces und wird nur angehängt (Entscheidung 5, Workflow `schema-update`); Rust-Code daraus erzeugen capnpc-rust und capnpc-cli, nicht `fs-blueprint`.
14. **Lesbarkeit:** `fs-blueprint fmt` schreibt einen Bauplan kanonisch (Tabellen in der Reihenfolge der Tabelle in Punkt 4, Schlüssel ebenso, Reihenfolge der Einträge in Listen bleibt, UTF-8, LF, ein End-LF), damit Diffs zwischen Fassungen nur echte Änderungen zeigen (Vorschlag, wie Export in ADR 0096 E6).
15. **Ziel und Zwischenschritt für den Einstieg (Nutzerentscheid 45, 18.11.2026):** Das Ziel ist, dass ein Programm nur aus **Bauplan + forms-Beschreibung** besteht und alle Programme **einen gemeinsamen Starter** haben (fs-starter mit `fs-forms-run`); ein Programm hat dann keinen eigenen Einstieg mehr. Bis dahin (Release-Stufe 1) **erzeugt** `fs-blueprint` für jedes Programm eine **minimale `main`** („Bauplan laden, starten“): niemand schreibt sie von Hand, sie enthält **nichts Programmspezifisches** außer dem Verweis auf den Bauplan des Programms, und sie ist austauschbar. Alles, was ein Programm unterscheidet (Name, Vertrag, Version, Gerüst-Teile), kommt aus dem Bauplan bzw. aus Dateien, die der Erzeuger daraus schreibt, nie aus Code in der `main`. Fällt der Zwischenschritt weg, wird **nur diese `main` gestrichen**; Bauplan, forms-Beschreibung und Module bleiben unverändert. Der Einstieg selbst ist der Gerüst-Teil Starter (ADR 0097 Entscheidung 2; Punkt 10 oben). Die Form des Verweises (eingebetteter Bauplan oder aus ihm erzeugte Werte) entscheidet S1 (Offen 8). Es gibt **keinen Schlüssel**, der Code oder programmspezifischen Text in die erzeugte `main` bringt (weder `main`, `entry`, `start` noch eine Tabelle `[main]`, in keiner Tabelle): jeder solche Schlüssel ist `unknown-key{path}` (Punkt 4).

**Beispiel-Bauplan fs-tasks (Zielstand nach der Umstellung, Plan V0 Teil 4)**

Werte sind belegt, wo angegeben; Modul-Namen und -Versionen sind Zielwerte (fs-modules-planning hat noch keinen Tag, das Crate heißt dort noch `fs-tasks-local`, README Z. 9). Die Ausnahme ist ein **Beispiel**: das Gespräch hat nicht stattgefunden, der Eintrag würde heute mit `talk-not-found` abgelehnt (Regel C11 der Liste „fs-tasks-Regeln ohne Standard“, Vorschlag dort: `[[exception]]` + `talk`).

```toml
schema = 2

[program]
name = "tasks"
skeleton = "0.1.0"
capability = "tasks"
summary = { en = "Tasks, dependencies and boards", de = "Aufgaben, Abhängigkeiten und Boards" }
description = { en = "Plan and track tasks as JSCalendar tasks, with dependencies and boards.", de = "Aufgaben als JSCalendar-Aufgaben planen und verfolgen, mit Abhängigkeiten und Boards." }
categories = ["Office", "ProjectManagement"]

[contract]
version = "0.1"
id = "0xc04d258971543476"
provides = ["dependency.evaluate", "dependency.cycle-check"]

[[module]]
name = "fs-todo"
kind = "standard"
version = "0.0.1"

[[module]]
name = "board"
kind = "component"
version = "0.0.29"

[[module]]
name = "task-card"
kind = "component"
version = "0.0.29"

[[bundle]]
name = "fs-planning"
version = "0.0.1"
parts = ["readiness", "schedule", "progress", "rank", "checklist", "claim"]
item = "Task"

[[type]]
name = "Task"
module = "fs-todo"

[[ruleset]]
name = "progress"
type = "Task"
from = "fs-planning"
presets = ["rfc8984", "freesynergy"]
default = "freesynergy"

[frontend]
standard = "board"
layout = "layout/board.toml"
covers = ["Items.list", "Items.query", "Items.create", "Items.editIf", "Items.readiness"]

[[exception]]
what = "Sperrt Titel, Notiz und Befehl mit erkennbaren Schlüsselmustern"
why = "kein Modul und kein Standard beschreibt eine Geheimnis-Sperre für Aufgabentexte"
checked = ["fs-todo", "fs-planning"]
alternatives = ["Prüfregel als Regelwerk in fs-todo"]
talk = "conventions/talks/2026-11-xx-tasks-secret-guard.md"
paths = ["crates/fs-tasks-core/src/secret_guard.rs"]
```

**Programmeigener Typ (Ausschnitt, Beispiel fs-schedules aus Plan Baukasten §c1 in Schema 2):**

```toml
[[type]]
name = "Shift"
standard = "https://www.rfc-editor.org/rfc/rfc8984#section-2.1"
envelope = "Event"
media_type = "application/vnd.freesynergy.shift"
label = { en = "Shift", de = "Schicht" }

[[type.field]]
name = "span"
kit = "timeSpan"
standard = "https://www.rfc-editor.org/rfc/rfc8984#section-5.1"
label = { en = "Time", de = "Zeit" }

[[type.field]]
name = "assignee"
kit = "personRef"
multiple = true
standard = "https://www.rfc-editor.org/rfc/rfc8984#section-4.4.6"
label = { en = "Assigned to", de = "Eingeteilt" }
```

**Prüfung des Beispiels Feld für Feld gegen Punkt 4**

| Zeile | Ergebnis |
|---|---|
| `schema = 2` | gültig |
| `[program] name = "tasks"` | Form gültig; Mehrzahl nach ADR 0087 |
| `skeleton = "0.1.0"` | Form gültig; Eintrag in der Gerüst-Tabelle entsteht mit `fs-blueprint` (noch keiner) |
| `capability = "tasks"` | steht in `capabilities.txt` Z. 15 (fs-interfaces main 5c43e16); Vertragsdatei `tasks.capnp` vorhanden |
| `summary`, `description` | Text2, de + en, keine Variablen |
| `categories` | `Office` ist Hauptkategorie, `ProjectManagement` Zusatzkategorie (freedesktop) |
| `icon` | fehlt → Voreinstellung `net.freesynergy.Tasks` (App-ID wie `release.yml:17` von fs-tasks) |
| `[contract] version = "0.1"` | wie `CONTRACT_VERSION = "tasks 0.1 (draft)"` (fs-tasks `fs-tasks-core/src/contract/mod.rs:15`) |
| `id` | Datei-ID aus `tasks.capnp:1` |
| `provides` | beide Schlüssel in `capabilities.txt` Z. 16–17; ob fs-tasks sie heute im Paket meldet: nicht geprüft |
| `[[module]] fs-todo` | `kind = "standard"` passt zu ADR 0101 E9 (Art 1); Version Zielwert, kein Tag vorhanden → heute `version-unknown` |
| `[[module]] board`, `task-card` | Blöcke in fs-components main 6bd98008 (`contract/blocks/widgets.toml:250`, `task-card` vorhanden); `component` steht in keiner Rust-Abhängigkeit; ob Tag v0.0.29 sie enthält: nicht geprüft |
| `[[bundle]] fs-planning` | Teile wie Plan Planungs-Bausatz §6 (a); `item = "Task"` verweist auf den `[[type]]` unten; kein Teil steht als `[[module]]`; zweiter Nutzer (fs-workflows) hat noch keinen Bauplan → die Katalog-Prüfung „≥ 2 Programme“ wäre heute rot |
| `[[type]] Task` | nur `name` + `module`, keine eigenen Schlüssel (Punkt 6) |
| `[[ruleset]] progress` | `from` ist ein `[[bundle]]`; `default` in `presets`; Namen der Sätze sind Zielwerte (Regelwerk `fs-progress`, README fs-modules-planning Z. 17) |
| `[frontend]` | `layout` Pfad gültig, Datei entsteht mit der Umstellung; `covers` nennt Methoden aus `tasks.capnp` (`interface Items`) |
| `[[exception]]` | alle sechs Pflichtfelder da, `paths` gültige Form; `talk-not-found` (gewollt, siehe oben) |
| Ausschnitt `Shift` | ohne `module`: `standard`, `envelope`, `media_type`, `label` da; je Feld genau eins von `kit`/`basic`, `standard`, `label` |

Nicht geprüft: die Abschnittsnummern der RFC-8984-Verweise (§2.1, §2.2, §4.4.6, §5.1) gegen den RFC-Text; dass `timeSpan` und `personRef` so in fs-types heißen (ADR 0098 Folgen nennt `timeSpan` als anzuhängenden `BasicType`, den Personen-Verweis als Bausatz). `Task` ist kein AS2-Typ; die Hülle des Typs liefert fs-todo, die heutige Angabe „AS2 `Task` envelope“ (`tasks.capnp:56`) ist darum dort mit Beleg nach ADR 0101 E5 zu klären.

**Pflichttests** (Vorschlag, je ohne Umsetzung rot)
- `schema = 1` → `schema-unsupported{found=1, known=2}`; `schema = 3` → `schema-newer{found=3, known=2}`; kein Lesepfad für 1 (Mutant „Schema 1 wird gelesen“ → rot).
- `[[module]]` ohne `kind` → `field-missing{table=module, field=kind}`; `kind = "library"` → `kind-unknown`; `kind` anders als im Katalog → `kind-mismatch`.
- Tabelle `[[component]]` oder ein Feld `expires` in `[[exception]]` → `unknown-key`.
- Teil eines `[[bundle]]` zusätzlich als `[[module]]` → `module-in-bundle`; unbekannter Teil → `bundle-part-unknown`; `item` ohne passenden `[[type]]` → `type-unknown`.
- `[[type]] module` auf ein `toolkit` oder eine `component` → `kind-wrong-role`; Modul-Typ mit eigenem `standard` oder `[[type.field]]` → `owned-by-module`.
- Feld mit `kit` und `basic` → `field-kind-both`; ohne beides → `field-kind-missing`; ohne `standard` → `standard-missing`.
- Text2 nur mit `en` → `text-pair{key, missing=de}`; verschiedene Variablen → `text-vars`.
- `[[exception]]` ohne `paths` → `field-missing`; `paths = []` → abgelehnt; Pfad mit `..`, `*` oder `\` → `path-invalid`; Pfad nicht vorhanden → `path-not-found`; Pfad auf erzeugte Datei → `path-generated`; zwei Ausnahmen mit derselben Datei → `path-overlap`; Datei ohne Kopf außerhalb aller `paths` → `file-unowned` (Mutant „Ordner-Präfix wird nicht ausgewertet“ → rot).
- `[[exception]]` mit nicht vorhandenem `talk` → `talk-not-found`.
- Jede Ablehnung ist ein `coded`-Wert; für jeden Code gibt es `blueprint-error-<code>` in de und en (Paarprüfung wie ADR 0057); Mutant „Fehler trägt englischen Satz statt Code“ → rot.
- Erzeugter Baum enthält `windows.yml` und Windows-Ziele in `release.yml`; Mutant „Windows weglassen“ → rot.
- Erzeugter Baum enthält kein Frontend-Crate und ein Manifest mit `fs:exec = fs-forms-run` und ein Admin-Layout mit `covers = "all"`; fehlt die Austauschdatei → `layout-not-found`.
- `component` erscheint in keiner Abhängigkeit von `-core`/`-server`/`-client`/`-bin`; Austauschdatei mit nicht genanntem Block → `component-undeclared`.
- Ein Schlüssel wie `mcp = true` oder ein Abschalter für einen Gerüst-Teil → `unknown-key`; fehlende Gerüst-Teile → `skeleton-part-pending{part}` sichtbar, nie stilles Fehlen.
- Der Beispiel-Bauplan fs-tasks ist Prüfdatei: Ergebnis genau `talk-not-found` plus die erwarteten `version-unknown` für Zielwerte, sonst nichts.
- `[[exception]] paths` mit einer `main.rs` oder einem Ordner, der eine enthält → `main-reserved{path}`; der Beispiel-Bauplan fs-tasks ergibt kein `main-reserved`; ein Schlüssel `main`, `entry` oder `start` (oben oder in `[program]`, `[contract]`, `[frontend]`) → `unknown-key`.
- Die erzeugte `main` zweier Programme ist byte-gleich bis auf die Bauplan-Verweise (Programmname bzw. Pfad des Bauplans); Mutant „programmspezifische Zeile in der `main`“ → rot; eine von Hand geänderte `main` → `generated-changed{path}`.

**Folgen**
- fs-release: `fs-blueprint` S1 (Modell + Prüfung) baut gegen dieses Schema (Plan V0, Lücke V0-L14); die Codes aus Punkt 4–11 sind der Startumfang; MF2-Texte de/en im Werkzeug.
- ADR 0101: Entscheidung 7 gilt mit dem Feld `paths`; Folgen Z. 45 („`[[component]]` (Art 3)“) ist durch Punkt 5 ersetzt.
- ADR 0099 Entscheidung 2: „Standard-Frontend“ heißt Manifest + Paket `layout` + Admin-Layout (Punkt 12).
- ADR 0096: Der Begriff „Bauplan“ für die Ausgabe von `fs-forms-bind` (Entscheidung 14, Z. 44) kollidiert mit diesem Bauplan; dort umbenennen (Vorschlag „Platzierungsplan“), Nachtrag zu 0096.
- fs-documentation: Ort der Gesprächsprotokolle festlegen (ADR 0097 Offen 8); Fundort-Doku je Modul nennt die Art (ADR 0101 Pflichttests).
- Workflows (über `workflow-pflege`): `manifest-pruefen` ruft `fs-blueprint check`; `geruest-heben` prüft Ausnahmen neu (Punkt 7).

**Offen**
1. Limit, ab dem alle Baupläne anlegen dürfen (Offen 1 oben). [offen, unverändert]
2. Ausstehende Gerüst-Teile: Test mit Code als ausstehend markieren (Vorschlag Punkt 10) oder als rot zählen. [offen]
3. Ablauf einer Ausnahme: an die Gerüst-Version gebunden (Vorschlag Punkt 7) oder eigenes Datum (wäre ein weiteres Feld gegen ADR 0101 E7). [offen, Nutzer]
4. Migration und Lesbarkeit älterer Bauplan-Fassungen: nach den ersten echten Nutzern neu entscheiden (Punkt 2). [offen]
5. Ob `[contract] provides` aus den genutzten Bausätzen abgeleitet statt geschrieben wird. [offen]
6. Ob ein Typ mit Personendaten den Bausatz Schutzangabe (ADR 0029, ADR 0098 Tabelle) tragen muss. [offen]
7. Endgültige Namen der Voreinstellungs-Sätze für Fortschritt (`rfc8984`, `freesynergy`): legt das Modul fest. [offen]
8. Form des Bauplan-Verweises in der erzeugten `main` (Bauplan eingebettet und beim Start gelesen, oder daraus erzeugte Werte) und ihr Verhältnis zum Laufzeit-Host ohne Bauen (Offen 3 oben). [offen, Entscheid in S1]

### English summary (Nachtrag 2026-11-18)
Draft addendum to ADR 0099. The build tool is named `fs-blueprint` and lives in the repo fs-release; the name `fs-scaffold` stays with the program (role 2). The blueprint `scaffold.toml` now has `schema = 2` only: schema 1 is rejected with a code, there is no migration and no read path for older versions until the first real users (then decided again). The addendum lists every key of schema 2 with type, mandatory flag, default, meaning and check. Every `[[module]]` has a mandatory `kind` (`standard`, `toolkit`, `component` after ADR 0101); `[[bundle]]` is its own table with `parts` and `item`, and there is no `[[component]]` table. `[[exception]]` gains `paths` (exact repo paths or folders, no wildcards) so the check can map every hand-written file to exactly one exception; there is no expiry field. Human texts are de + en MF2 pairs; errors are codes with parameters. Skeleton parts (starter, settings, conformance and the rest of ADR 0097) and Windows CI are always generated and cannot be switched off; the frontend is a manifest plus a `layout` package for fs-forms, never a crate. A full example blueprint for fs-tasks is checked key by key.

Until every program is only a blueprint plus a forms description started by one shared starter (user decision 45), `fs-blueprint` generates a minimal `main` ("load the blueprint, start") that holds nothing program-specific except the reference to the blueprint; later only this `main` is removed. No key can put code into that `main`, and no exception may cover a `main.rs` (`main-reserved`).
