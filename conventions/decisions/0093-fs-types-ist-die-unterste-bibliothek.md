# 0093 – fs-types ist die unterste Bibliothek: Wertobjekte samt Draht-Schema im eigenen Repo

Status: **akzeptiert** (Strategie, 2026-11-16; Entscheidung V1+ JA, Fragen 1, 2, 2.1 und 3; Opus-Review 9b1ba986) · baut auf ADR 0092 (Repo-DAG, `fs-rpc`), ADR 0085 (Typen in fs-types), ADR 0066 (Typbeschreibung), ADR 0087 Punkt 5 (Bibliotheken behalten ihren Namen) und `conventions/coding.md` Abschnitte 1 und 8 · ersetzt Regel 1 und den Punkt „Verworfen V1+“ in ADR 0092

## Kontext
- ADR 0092 bricht den Kreis zwischen `fs-interfaces`, `fs-objects` und `fs-types` mit `fs-rpc`. Es lässt `fs-types` aber im Repo `fs-interfaces` und hat V1+ nur wegen des Aufwands verworfen (4 bis 6 Tage). Das Kriterium dieses ADR ist dagegen Sinn und Objektorientierung, nicht Aufwand (Nutzerregel, Strategie 2026-11-16).
- Die Abstraktionsrichtung ist heute verkehrt (Belege: Opus-Architekturnotiz zu fs-types, Arbeitsstand 2026-11-16, an den Ständen `fs-interfaces` v0.0.26, `fs-objects` v0.0.5, `fs-jscalendar` v0.0.3, nicht veröffentlicht):
  - **Wertobjekte hängen an Verträgen:** `crates/fs-types/Cargo.toml:17` bindet `fs-interfaces` mit dem Feature `values`. 24 Quelldateien in `fs-types` nutzen `fs_interfaces::{types_capnp, values}`, darunter der Kern `value.rs:7` und `rule.rs:10` (`use fs_interfaces::types_capnp::BasicType`).
  - **Eigentum und Ort stimmen nicht überein:** `schema/types.capnp:3` nennt als Eigentümer „Rust crate `fs-types`“; das Schema liegt und wird aber in `fs-interfaces` generiert (`crates/fs-interfaces/src/lib.rs:90`).
  - **Wertobjekte liegen im Vertrags-Crate:** `EmailAddress`, `PhoneNumber` und `ValueProblem` stehen in `fs-interfaces` (Feature `values`, `lib.rs:35`) und werden von `fs-types` nur weitergereicht (`fs-types/src/lib.rs:55`), ebenso `AddressKind`, `BasicType`, `NameKind` (`lib.rs:54`).
  - **Speicher und Norm-Adapter hängen am Takt der Verträge:** `fs-objects` und `fs-jscalendar` pinnen `fs-types` über das Repo `fs-interfaces`, nutzen aber nur reine Wertobjekte (`fs-objects`: `ObjectId`, `PersonRef`, `PersonArt`, `Date`, `BasicValue`; `fs-jscalendar`: `Zone`, `LocalDateTime`, `Utc`, `BasicValue`). Jeder `fs-interfaces`-Tag zieht sie nach; ADR 0092 nennt das selbst als Rest-Risiko.
  - **Transport im Wertobjekt-Crate:** der `TypeCatalog`-Server liegt in `fs-types` (`describe/mod.rs:16-28`, Feature `rpc`).
- Die Typbeschreibung (`TypeCatalog`, Feldbeschreibung) ist das Metamodell der Wertobjekte (ADR 0066 Punkt 3). Der **Server** dazu ist dagegen Transport.
- Zwei Beifunde: `Capabilities` gibt es doppelt (`fs-types/src/paging.rs:23` und `fs-interfaces/src/provider/capabilities.rs:20`); ADR 0085 Zeile 63 nennt `PersonRef` „in `fs-interfaces`“, Zeile 97 und der Code „in `fs-types`“.

## Entscheidung
Entscheidung der Strategie (2026-11-16): V1+ JA.
1. **`fs-types` wird ein eigenes Repo `FreeSynergy/fs-types`, ganz unten im Graphen, auch für andere Projekte nutzbar** (eigener Tag, eigene README und CHANGELOG; die Mitarbeit von Claude wird im Crate genannt). Der Name bleibt `fs-types` (ADR 0087 Punkt 5; Namensregel: Bibliothek, Einzahl, klein).
2. **`fs-types` bringt `types.capnp` selbst mit** (Grundtypen und Typbeschreibung) und besitzt die Wertobjekte aus dem Feature `values` (`EmailAddress`, `PhoneNumber`, `ValueProblem`). Fremdnutzer laden dafür die Laufzeit `capnp` mit.
   - 2.1 **Die Typbeschreibung (`TypeCatalog`, Feldbeschreibung) gehört zu `fs-types`.** Der Server dazu (`CatalogServer`) wandert nach `fs-rpc`; `fs-types` hat kein Feature `rpc`.
3. **Regel 1 (ersetzt die Regel 1 aus ADR 0092), Repo-DAG:** Eine Kante zeigt nur von oben nach unten (Pfeil heißt „wird benutzt von“): `fs-types` → {`fs-interfaces`, `fs-objects`, `fs-jscalendar`, `fs-components`} → `fs-rpc` → Programme. `fs-types` hängt von keinem unserer Repos ab, nur von Fremd-Crates (`chrono`, `iri-string`, `capnp` und ähnlich).
4. **Regel 2:** `fs-types` besitzt `types.capnp` und die Wertobjekte. Alles, was nur Werte und ihr Draht-Schema betrifft, liegt dort, nichts davon in `fs-interfaces`.
5. **Regel 3, eine Quelle je Schema:** Ein Schema wird nur in dem Crate generiert, das es besitzt; andere Crates verweisen darauf (`::fs_types::types_capnp`), es gibt keine Kopie der `.capnp`-Datei und keinen zweiten generierten Code. `fs-interfaces` erzeugt nur Themenschemata und braucht `types.capnp` als Importpfad aus dem gepinnten `fs-types`. **Import-Pfad (Entscheidung der Strategie):** `import "types.capnp"` ohne Schrägstrich sucht `fs-capnpc` nur neben der importierenden Datei (`source/loader.rs:140-143`; `import_path` gilt nur für `/types.capnp`). Deshalb schreiben die 13 Schemata, die `types.capnp` importieren, `import "/types.capnp"`, und der Aufruf setzt `import_path` auf das gepinnte `fs-types`. **Keine Kopie und kein Symlink** von `types.capnp` in `fs-interfaces` (das wäre eine zweite Quelle: gegen R13 und gegen diese Regel 3). Die Datei-ID ändert das nicht.
6. Die Regel „je Bibliothek genau eine Quelle im Lock“ (ADR 0092, Regel 2) bleibt und gilt auch für `fs-types`.

## Folgen
Reihenfolge nach der Opus-Notiz. **V1+ kommt vor der Programmwelle**, damit jedes Programm nur einmal auf `fs-rpc` und `fs-types` neu hebt. Die Trait-Runde ist danach `fs-interfaces` v0.0.28.
1. Probe `crate_provides`: erledigt, grün (siehe Offen).
2. Repo `FreeSynergy/fs-types` (legt der Nutzer an; es existiert noch nicht) mit der Historie aus `crates/fs-types` (Herkunft bleibt sichtbar), dazu `schema/types.capnp`, `values`, eigene Codegen, ohne `rpc`-Feature; Tag **v0.0.1** (Version = Tag).
3. `fs-interfaces` **v0.0.27**: `crates/fs-types`, `types.capnp` und `values` entfallen, Pin auf `fs-types` v0.0.1, die 13 Schemata importieren `/types.capnp`, `crates_provide_map` verweist auf `fs_types`. Vor dem ersten Release ohne Alias und ohne Übergang (Nutzerregel: Schnittstellen werden vor dem ersten Release ohne Umstände ersetzt).
4. `fs-objects` und `fs-jscalendar` pinnen `fs-types` **direkt** (nicht mehr über `fs-interfaces`); `fs-rpc` pinnt beide neu und übernimmt den `CatalogServer`. Neue Tags: jeweils die nächste Patch-Version.
5. Die Programme heben **einmal** in der Reihenfolge von ADR 0092 (people → calendars → tasks → groups → texts → packages); danach `fs-components` (heute `fs_interfaces::values`). Pfade: `fs_interfaces::values` → `fs_types`, `fs_interfaces::types_capnp` → `fs_types::types_capnp`, `fs_types::CatalogServer` → `fs_rpc`.
6. In ADR 0092 steht eine Nachtragszeile („Verworfen V1+“ wird durch ADR 0093 ersetzt).
7. Test `generated_matches_official` schreibt künftig in ein Test-Target statt nach `/tmp` (Arbeitsspeicher); für `types_capnp.rs` entsteht ein eigener Test in `fs-types`. `compat_files.rs` ändert nur den Importpfad (`fs_interfaces::types_capnp` → `fs_types::types_capnp`).
8. **Abnahmetest:** ein echter `capnp-rpc`-Roundtrip (`TypeCatalog`) über die Crate-Grenze; die Probe belegt nur Typgleichheit zur Compile-Zeit.
9. Folge-Dokumentation (nicht Teil dieses Entwurfs): `conventions/coding.md` Abschnitt 8 bekommt den Repo-DAG und den Satz „eine Quelle je Bibliothek“ (offener Punkt aus ADR 0092).
10. Die Prüfung nach ADR 0092 Regel 2 (eine Quelle im Lock) in `fs-release` schlägt bei jeder Rest-Quelle fehl.
- Getaggte Stände (`fs-interfaces` bis v0.0.26, `fs-objects` bis v0.0.5, `fs-jscalendar` bis v0.0.3, `fs-rpc`) bleiben unveränderlich.
- Vorteile (Opus-Notiz): kreisfrei durch Konstruktion; ein Schema-Tag eines Themas zieht nur noch `fs-rpc` und Programme nach, nicht `fs-objects` und `fs-jscalendar`; Normen (RFC 9553, RFC 8984, RFC 5870, BCP 47, AS2) an einer Stelle mit Regeln und Wertobjekt.

## Offen
- **Erledigt, grün: Probe `crate_provides`** (Probe der Strategie, 2026-11-16, Arbeitsstand, nicht veröffentlicht; Stände `fs-interfaces` v0.0.26, `capnpc` 0.27.0, `fs-capnpc` v0.0.1). `CodeGenerationCommand::crates_provide_map({0x916fad50f1c14440 => "ftypes"})` setzt die Pfade (`codegen.rs:105`; `CompilerCommand::crate_provides`, `lib.rs:215`, ist nur der Durchreicher); `fs-capnpc` muss nicht geändert werden. 13 von 18 Schemata importieren `types.capnp` (events, files, streaming, surveys, texts, tasks, groups, history, people, messenger, whiteboard, places, resources). Datei-ID und Typ-IDs sind gleich: `types_capnp.rs` ist byte-gleich mit v0.0.26, die 17 übrigen Dateien unterscheiden sich nach Ersetzen des Pfads in 0 Zeilen; **(Einschränkung: gilt nur für den relativen Import der Probe, siehe Nachtrag „Draht-Befund v0.0.27“)** es gibt keine Doppel-Typen (Compile-Zeit-Prüfung von `get_catalog()` und `get_edit()`). Nicht belegt bleibt der echte `capnp-rpc`-Roundtrip (Abnahmetest, Folgen Punkt 8) und die `import`-Auflösung des offiziellen Compilers `capnpc-embedded`.
- **Zwei `fs-types` im Lock während des Übergangs** (alt im Repo `fs-interfaces`, neu im eigenen Repo; Fehler wie E0308): eine Welle in fester Reihenfolge ohne Brücke, dazu die Prüfung nach ADR 0092 Regel 2. Ein vergessener alter Pin (zum Beispiel per `rev` auf `fs-people-directory`) bleibt das Risiko.
- **Datei-ID** von `types.capnp` bleibt `@0x916fad50f1c14440` (`types.capnp:16`), der Draht bleibt unverändert; `tests/compat_0_0_19.rs` und `compat_0_0_20.rs` müssen grün bleiben.
- **Tag-Nummern** von `fs-objects`, `fs-jscalendar`, `fs-rpc`: nächste Patch-Version, Nummern bei der Umsetzung festzulegen.
- **`Capabilities` doppelt** (`fs-types/src/paging.rs:23`, `fs-interfaces/src/provider/capabilities.rs:20`): auflösen, wo die Fähigkeit hingehört **[offen]**.
- **ADR 0085 Zeile 63** nennt `PersonRef` „in `fs-interfaces`“, richtig ist `fs-types`: Das ADR trägt dafür keinen Nachtrag-Abschnitt in der Art von ADR 0087, die Korrekturzeile steht als Hinweis „korrigiert durch ADR 0093“ unter „Offen für Nachtrag“ in ADR 0085.
- Aufwand: nicht belegt (ADR 0092 schätzte V1+ mit 4 bis 6 Tagen); er ist hier kein Entscheidungskriterium.

## Verworfen
- **`fs-types` ganz ohne `capnp` (V1+b, Schema bleibt in `fs-interfaces`):** verlangt eine zweite Definition von `BasicType`, `NameKind` und `AddressKind` (Rust und Schema), also zwei Quellen eines Vokabulars; widerspricht ADR 0085 und R13 in `docs/v5-entwurf.md` von `fs-objects` („Types come from fs-types“).
- **V1 ohne Schema-Umzug (`fs-types` als eigenes Repo, Abhängigkeit auf `fs-interfaces` bleibt):** der Kreis bleibt (Probe in ADR 0092: `cyclic package dependency`), und die Wertobjekte hingen weiter an den Verträgen.
- **V3 (`fs-objects` v5 ohne `fs-types`):** bricht den Code und verlangt eine zweite Kopie der Typen; verstößt gegen R13 und ADR 0085 (siehe ADR 0092).
- **Status quo** (`fs-types` im Repo `fs-interfaces`): Wertobjekte hängen an Verträgen, die Abstraktionsrichtung bleibt verkehrt.

## Nachtrag 2026-11-16: Draht-Befund v0.0.27

- „0 Zeilen Unterschied“ (Abschnitt „Offen“, Probe `crate_provides`) galt nur für den **relativen** Import der Probe. Mit `import "/types.capnp"` (so ausgeliefert in `fs-interfaces` v0.0.27) verschieben sich **189 Quell-Byte-Bereiche in 13 generierten Dateien** um je +1: Es sind die in die Schemaknoten eingebetteten Start- und End-Bytes der Deklaration im Schema-Quelltext, und `"/types.capnp"` ist ein Zeichen länger als `"types.capnp"`.
- Der **Draht ist gleich**: Typ-IDs, Felder, Ordinale, Datenlayout und Zugriffs-Offsets sind unverändert; ein Client auf v0.0.26 und ein Server auf v0.0.27 tauschen dieselben Bytes. Belegt durch den Opus-Review von `fs-interfaces` v0.0.27 (e2c554e2): 1173 Schemaknoten alt gegen neu dekodiert, alle 189 Abweichungen sind genau +1/+1 und zeigen auf dieselbe Deklaration.
- Außerhalb dieser Byte-Bereiche unterscheiden sich die generierten Dateien nur im Pfad `crate::types_capnp` → `::fs_types::types_capnp`.

## Nachtrag 2026-11-17 (Baukasten): Schichten ergänzt, fs-access unter fs-rpc, keine Kante nach oben

Status: **akzeptiert** (ADR 0097) · **ergänzt** Regel 1 (Z. 21)

**Entscheidung**
1. Regel 1 gilt weiter und wird ergänzt: fs-types → {fs-interfaces, fs-jscalendar, fs-objects, fs-components} → **fs-access** → fs-rpc (mit `fs-starter`, `fs-connect`, `fs-conformance`, `fs-mcp-wrapper` (Arbeitsname), `fs-git`, `fs-backup`, `fs-workflow`) → fs-packages (Bibliothek `fs-update` im Programm-Repo) → Programme.
2. **fs-access liegt unter fs-rpc** (`fs-connect` hängt an fs-access, fs-access nie am Repo fs-rpc). **Eigenes Repo**, weil wiederverwendbar, auch für andere (SCIM-Provider, OAuth/OIDC).
3. **`fs-starter` hängt nicht an `fs-update`**; das erzeugte `-bin` jedes Programms verbindet beide.
4. Regel 2 (eine Quelle je Bibliothek im Lock) gilt für alle neuen Bibliotheken.
5. Der MCP-Wrapper ist der technische Teil des Bot-Platz-Wegs nach ADR 0091, kein zweiter Mechanismus.

## Nachtrag 2026-11-17 (2): Ort von fs-conformance

Status: **akzeptiert** (ADR 0097 Nachtrag 3) · **ändert** Nachtrag Entscheidung 1 (Z. 67): `fs-conformance` liegt im Repo fs-types (unterste Schicht) und nicht in der fs-rpc-Liste; Begründung und Bedingung stehen in ADR 0097 Nachtrag 3.

## Nachtrag 2026-11-23: fs-types kommt aus dem Registry `freesynergy`

Status: **entschieden** (Entscheid Strategie 23.11., Nutzer informiert; Schnitt „ENTSCHEID-kaskade“, Empfehlung B2) · **ergänzt** Entscheidung 6 (Quelle von fs-types) und Folgen 2 (Version = Tag) · Bereichsregel: ADR 0045, Nachtrag 2026-11-23 „eine Versionsregel“ Nr. 4 und 5 · Tag-Regel: ADR 0064, Nachtrag 2026-11-23 · Lock-Prüfung: ADR 0092, Nachtrag 2026-11-23 · Umsetzung (Schritte K-1 bis K-7) steht aus

**Kontext**
- Eine Git-Abhängigkeit ist in Cargo genau ein Commit. `version` ist dort nur eine Prüfung und wählt keinen Tag aus (Cargo-Buch, „specifying-dependencies“, Abschnitt „The role of the `version` key“). Jeder fs-types-Tag ist deshalb eine neue Quelle, und rund 25 Repos pinnen um und taggen neu.
- Ein `[patch]` auf denselben Git-URL mit anderem Tag lehnt Cargo ab („patches must point to different sources“). Ein Meta-Crate beseitigt die Kaskade also nicht.
- Echte Versionsbereiche gibt es in Cargo nur über ein Registry. Ein Git-Repo mit Index und abgelegten `.crate`-Dateien reicht dafür (Cargo-Buch, „running-a-registry“, „registry-index“).
- Belege: Proben der Strategie am 23.11. mit cargo 1.100.0, nur mit lokalen Wegwerf-Repos, Arbeitsstand, nicht veröffentlicht.

**Entscheidung**
1. **Registry `freesynergy`:** ein Git-Index-Registry im Repo `FreeSynergy-Net/fs-crates`. Es enthält den Index und die `.crate`-Dateien, ohne Server-Dienst, ohne `api` und ohne `cargo publish`. Es gilt zunächst nur für die Crates des Repos fs-types: `fs-types`, `fs-conformance`, `fs-records`.
2. **Verbraucher schreiben** `fs-types = { version = "~0.0.N", registry = "freesynergy" }`. `~0.0.N` ist die Cargo-Tilde, gleich `>=0.0.N, <0.1.0` (ADR 0045, Nachtrag „eine Versionsregel“ Nr. 4 und 5). Der Name `freesynergy` wird je Repo in `.cargo/config.toml` unter `[registries.freesynergy]` aufgelöst. Seine Untergrenze hebt ein Verbraucher nur, wenn er die neue Version wirklich nutzt. Programme ziehen mit `cargo update -p fs-types` nach. Das ist eine reine Lock-Änderung ohne neuen Tag.
3. **Nur die Release-CI schreibt in fs-crates**, und zwar nur aus einem Tag-Lauf (`cargo package --locked`, danach Indexzeile und `.crate`). Von Hand wird nie ein Eintrag gemacht. Alte Tags werden nicht nachveröffentlicht. Die erste Registry-Version ist der nächste fs-types-Tag.
4. **Innerhalb von 0.0.x nur additive Änderungen** in fs-types, fs-conformance und fs-records:
   - Öffentliche `enum`s tragen `#[non_exhaustive]`.
   - Anlass: Der Bruch in fs-mcp durch die neuen Varianten `BasicType::Time` und `BasicType::Color` war genau so eine nicht additive Änderung.
   - **Gate:** `cargo-semver-checks` gegen die letzte Registry-Version läuft im Tag-Lauf **vor** dem Index-Eintrag. Ist es rot, entsteht kein Eintrag.
   - Ehrlich gesagt: Bei 0.0.x schützt der Bereich `~0.0.N` nicht vor einem Bruch (ADR 0064, ADR 0045 Nachtrag Nr. 4). Schutz gibt nur dieses Gate.
   - Ein Bruch geschieht nur **bewusst**: als eigener Schritt mit neuem Bereich (alle Verbraucher heben ihre Untergrenze und passen den Code an) und einer Welle in der Reihenfolge des Repo-DAG. Wie das Gate dafür mit sichtbarer Begründung übergangen wird, ist offen (K-2).
   - **Erzeuger:** Wo ein Erzeuger (zum Beispiel der generierte Code in fs-mcp) über ein `#[non_exhaustive]`-enum verzweigt, erzeugt er einen Auffang-Zweig mit sichtbarer Meldung (ADR 0065 Pflichtteil Nr. 5). Ein unbekannter Wert wird nie still verschluckt.
5. **Lieferkette = Sicherheitsmodul** (CLAUDE.md §4, harte Grenze 2: voller Test und Opus-Review vor dem Release). Bedrohungsmodell:
   - **Wer in fs-crates schreiben kann, kann ein Crate tauschen.** Die Prüfsumme (`cksum` der Indexzeile) liegt im selben Repo. Sie schützt gegen einen Fehler beim Herunterladen und gegen eine getauschte `.crate` bei unveränderter Indexzeile, aber nicht gegen jemanden, der beides ändert.
   - Ein schon gelockter Verbraucher hält die Prüfsumme in seinem `Cargo.lock` fest. Ein späterer Tausch derselben Version fällt dann bei `--locked` auf **[nicht belegt]**.
   - **Gegenprobe als Pflichttest (K-2):** Eine geänderte `.crate` bei unveränderter Indexzeile muss Cargo ablehnen. Eine geänderte Indexzeile gegen einen bestehenden Lock muss ebenfalls abgelehnt werden **[beides nicht belegt, bis die Probe läuft]**.
   - **Download über `raw.githubusercontent.com`** (`dl` in `config.json`): Das ist ein fremder Dienst ohne Zusage, mit Ratenlimits. Ob er unter Windows-CI und hinter Proxies funktioniert, ist ungeprüft. Die Abhängigkeit von GitHub besteht heute mit Git-Tags schon. Sie wird damit nicht kleiner, sie liegt nur an einer anderen Adresse. Rückfall: Release-Assets von fs-crates (Cargo folgt Umleitungen).
   - **Bis zum Branch-Schutz** von fs-crates (nur der Bot der Release-CI schreibt, kein Force-Push) gilt das Registry als **„Anfangsphase, nicht geschützt“**. So steht es auch in der README von fs-crates. Es wird nirgends als gesichert beschrieben.
6. **Crate-Version = Tag:** Die Version in `Cargo.toml` muss gleich dem Tag sein. Ein Gate im Tag-Lauf prüft das vor `cargo package` und ist bei Abweichung rot. Heute steht noch `0.0.5` gegen Tag `v0.0.6`, das ist ein Fehler und zieht vor der ersten Registry-Version gleich (ADR 0064, Nachtrag 2026-11-23).
7. **Entscheidung 6 bleibt:** je Bibliothek genau eine Quelle im Lock. Nach der Umstellungswelle (K-5) ist die Quelle von fs-types das Registry `freesynergy`, und eine Git-Quelle von fs-types ist dann ein Verstoß.
8. **Lokale Entwicklung** (CLAUDE.md §4b): `[patch.freesynergy]` mit Pfad auf den lokalen Kopf, solange dessen Version in `~0.0.N` liegt. Das wird nie committet (`conventions/coding.md` §8). Die CI baut immer gegen veröffentlichte Registry-Versionen.
9. **Alles oberhalb bleibt bei Git-Tags:** fs-interfaces, fs-objects, fs-jscalendar, fs-components, fs-rpc, fs-starter, Programme, Blinc-Fork. fs-jscalendar, fs-objects und fs-interfaces können später denselben Weg gehen, jeweils mit eigenem Nachtrag. fs-components und fs-rpc gehen nicht ins Registry, weil fs-components per Git-Tag am Blinc-Fork hängt und ein Registry-Crate das nicht darf.
10. Ob fs-types später auf crates.io geht, ist eine eigene, spätere Frage an den Nutzer. Der Wechsel wäre dann eine Zeile je Abhängigkeit.

**Verworfen**
- **Exakte Tag-Pins wie bisher:** Jeder fs-types-Tag löst die Kaskade aus.
- **Registry mit 0.1.x und Caret:** bricht ADR 0064 Nr. 2 (0.1.0 erst nach dem Handtest).
- **crates.io jetzt:** Jede Veröffentlichung braucht eine Freigabe des Nutzers, und die Namen sind weltweit und für immer vergeben.
- **Meta-Crate oder Pins an einer Stelle:** Die Bibliotheken dazwischen pinnen fs-types weiter selbst, die Kaskade bleibt.
- **Git-Branch `release` mit `version`-Prüfung:** Das ist eine eigene Konvention gegen ADR 0064 Nr. 5 und eine Zwischenlösung. Sie bleibt nur als Rückfallweg, falls K-2 blockiert.

**Offen**
- Wer legt `FreeSynergy-Net/fs-crates` an, der Nutzer oder der Bot (K-1)?
- Taugt `cargo-index` 0.2.7 zum Schreiben des Index? **[nicht belegt]** Rückfall: ein kleiner Rust-Unterbefehl in fs-release.
- Verifiziert `cargo package` für fs-types mit `schema/**` sauber? **[nicht belegt]**
- Form des bewussten Übergehens des semver-Gates bei einem Bruch (Nr. 4).
