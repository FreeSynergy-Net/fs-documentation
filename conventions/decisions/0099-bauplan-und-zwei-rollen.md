# 0099 – Bauplan (`scaffold.toml`) und zwei Rollen: Bau-Werkzeug für das Projekt, fs-scaffold für Instanzen

Status: **akzeptiert** (Nutzer, Gespräch 1 vom 2026-11-17: Antworten 123, 127, 128, 133, 134; Gespräch 2: Start jetzt; Grundidee „Wir programmieren keine Programme mehr, wir stecken sie nur noch zusammen“, 17.11.) · **ändert** ADR 0087 Nachtrag 17.11. [Entw.] Punkt 10: fs-scaffold „nutzt“ den Workflow `scaffold-ai` nicht mehr, das Gerüst entsteht deterministisch (Rolle 1); Punkt 10 bleibt als Rolle 2 · **ersetzt** im Workflow `grundfassung` den Schritt `geruest` (`call: scaffold-ai`, fs-release `workflows/grundfassung.yaml:79-80`), sobald das Bau-Werkzeug gleichwertig ist (Antwort 127) · baut auf ADR 0021, 0045, 0063, 0066, 0068, 0076, 0086, 0092, 0093, 0094 [Entw.], 0098 [Entw.] · Grundlage: Plan Baukasten (Fassung 5) §c

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
