# 0100 – Einstellungen als eigene Schnittstelle: Vertrag `settings`, Bibliothek `fs-settings`, Programm `fs-settings`

Status: **angenommen** (2026-11-17; Nutzer: Gespräch 4 vom 2026-11-17, Antworten 15 und 16; technische Ausgestaltung Strategie; Annahme nach dem Arbeits-Fixpunkt `setting_v1`, Stufe 4;
Entscheid der Strategie, b7) · **erweitert** ADR 0057 (Sprache), 0065 (Menü), 0074 (Darstellung), 0094 [Entw.] (Frontend-Wahl) um eine gemeinsame Einstellungs-Schicht ·
baut auf ADR 0021, 0024, 0045, 0054, 0057, 0065, 0066, 0074, 0085, 0086, 0092, 0093, 0094 [Entw.], 0095, 0097, 0098

**Namensausnahme:** Bibliothek und Programm heißen beide fs-settings (Nutzerwort 17.11.2026: „fs-setting mit s bitte!“, Ausnahme von der Einzahl-Regel); Programm-Crates fs-settings-bin/-server/-app; nur die Binärdatei heißt fs-settings. Die Probe-Zweige und Köpfe tragen noch den alten Namen (`unreviewed/probe-fs-setting-2`, Kopf 46566b49) und bleiben wörtlich.

**Fixpunkt `setting_v1`** (Arbeits-Fixpunkt, „interne Version“; kein Feature-Freeze, ein Freeze kommt nur durch den Nutzer): Ordner-Hash `crates/fs-settings/src` (nur `src/`)
`ea7ea6cd7943984578d18ee85f8e33c15c73c414c65c0b11e269776c7496130e`, gesetzt 2026-11-17 durch die Strategie (b7). Probe: Repo fs-components, Zweig
`unreviewed/probe-fs-setting-2`, Kopf `46566b499f036bf473a95dbd2486102f41cf3369` (Prüfung „JA“ am Kopf 222132fb mit Auflagen N1–N9, Delta-Prüfung „JA“ am Kopf 46566b49; Zweig-CI
grün: check run 44141323913, windows run 44141323377). Fixpunkt wird als settings_v1 fortgeschrieben (Vorgänger setting_v1 = ea7ea6cd7943984578d18ee85f8e33c15c73c414c65c0b11e269776c7496130e). Der Fixpunkt verschiebt sich durch die Punkte L1 und L6 [L6 entfällt, ersetzt durch Nachtrag 2026-11-17: Datei-Ablage entfällt] unter „Noch nicht gebaut“; dann gilt ein neuer Hash mit kurzer Prüfung.

**Kontext**
- Nutzer (Wortlaut Gespräch 4, Z. 15): „Die Konfigurationen sollten eine eigene Schnittstelle haben, die man von außern ansteuern kann (wie das gemacht wird und ob es
  eine eigene ist oder ein teil von was anderem, ist Deine Entscheidung)“; Z. 16: „Theme, z.B. und Sprache, die wir bisher zwar geflegt haben, aber nicht wechseln
  konnten. Das muss weg, es muss jetzt schon austauschbar sein … und Settings sollte es überall geben“.
- Z. 18–19: „Es gibt allgemeine Configs, die, die zum Grundgerüst gehören, es gibt Modul Configs, Theme configs und App configs. … Dafür gibt es "Profile", die der
  Konfigurator macht, und da gibt es immer ein Allgemeines Profil und dann für jedes Programm kann, muss aber nicht, wenn es die configuration überschreiben möchte,
  überschreiben.“ Z. 21: „2 Buttons zum Speichern: für dieses Programm und im Allgemeinen. … aber, man kann von einem Programm nicht ins andere Programm gehen und das
  überschreiben.“ Z. 27–32 (Schloss): „bei jedem der Settings ein Schloss Symbol dran machen - das über die Rechte gesteuert wird“; „Wenn der Button gedrückt ist,
  darf dieser Wert nicht geändert werden. Auch ich nicht.“; „Wenn ich nicht die Rechte habe, etwas fest zu setzen, dann erscheint der Button erst gar nicht“.
- Antwort 15 (Z. 47): „noch besser die Idee.“ auf „Programm fs-settings statt fs-configurator“. Antwort 16 (Z. 48): „Nein, mach es bitte sofort. … Denn, das Prinzip
  werden wir noch sehr oft haben. das könnte man da copieren ;))“ (benannte Profile in v1).
- Bestand: Sprache als Datei je Person/Programm (ADR 0057 Z. 39–41); Stile als Daten (fs-components-styles `StyleId`); Frontend-Wahl der Person im Starter
  (ADR 0094 Z. 28 „Wahl des Menschen (Einstellungen des Programms)“); Systemeinstellungen hell/dunkel usw. (ADR 0074 Z. 35). Kein gemeinsamer Ort, keine Sperre.

**Entscheidung**
1. **Drei Teile (Entscheid der Strategie, Nutzer Z. 15 „ist Deine Entscheidung“):** Vertrag **`settings`** (fs-interfaces, eigene Vertragsversion, DRAFT nach
   ADR 0045); Bibliothek **`fs-settings`** (Repo fs-components, Schicht 1, ohne Blinc, capnp, tokio); Programm **`fs-settings`** (Antwort 15), das alle
   installierten Einstellungen an einer Stelle zeigt und ändert.
2. **Schichten** (Reihenfolge der Auflösung, eine Stelle `resolve`): Baustein-Voreinstellung < Instanz (Admin-Vorgabe) < System (Desktop: Sprache, hell/dunkel;
   nur lesen) < allgemeines Profil der Person < Programm-Profil. **Gerät** ist Ablageort (`$XDG_STATE_HOME`), keine Schicht [Ablageort ersetzt durch Nachtrag 2026-11-17: Datenbank]. **Eine Sperre schlägt jede Schicht.**
3. **Besitzer-Arten** der Einstellungen: Gerüst, Modul, Theme, Programm (Nutzer Z. 18), dazu Frontend; jede Einstellung ist **deklariert** (Schlüssel, typisierte Art
   Flag/Ganzzahl mit Grenzen/Auswahl/Sprache/Text, Voreinstellung, Gruppe, Ablage, MF2-Texte de+en); Undeklariertes wird nie gespeichert (`not-declared`).
4. **Speichern:** zwei Ziele „für dieses Programm“ und „für alle“ (Nutzer Z. 21); ein Programm schreibt nur sein eigenes Profil und das allgemeine, **nie** das eines
   anderen Programms und nie für eine andere Person (Z. 21, 32); „für alle“ entfernt die eigene Überschreibung dieses Programms (Ausgestaltung).
5. **Schloss:** Instanz-Admins setzen Vorgaben und **sperren** je Einstellung (`reason`, `locked_by`, `locked_at` in UTC); gesperrt darf niemand ändern, auch der
   Sperrende nicht; ohne Recht erscheint der Knopf nicht (Nutzer Z. 27–30). Das Recht `can_lock` vergibt **nur fs-access** an Instanz-Admins (ADR 0095 Admin-Stufen),
   **nie** über Token oder Delegation (wie ADR 0054 Z. 181/185). Eine Sperre **scheitert geschlossen** (Prüfungs-Auflage N2): passt der Instanzwert nicht, gilt die
   Baustein-Voreinstellung, die Sperre bleibt sichtbar. Eine Sperre braucht einen Grund (Auflage N6).
6. **Benannte Profile in v1** (Antwort 16): „Arbeit“, „Vortrag“ … über den wiederverwendbaren Datenbausatz **`ProfileSet<V>`** (fs-types: Namen, aktives Profil,
   Umschalten, Erben vom allgemeinen Profil; eigener Fixpunkt `profile_v1`), nicht nur für Einstellungen.
7. **Außen:** die Einstellungen sind über **fs-connect** von außen ansteuerbar (Server, Programm fs-settings; Nutzer Z. 16 „von außen auch der Server“), mit den
   Rechten der Person bzw. des Admins (fs-access, AS2); eine KI hält nie `can_lock` und ändert Einstellungen nie als die Person (ADR 0054/0091 Nachträge 17.11.).
   **Ob KI erlaubt ist, ist ein Recht in fs-access, nie eine Einstellung** (Prüfungs-Auflage L3).
8. **Erster Nutzen:** Sprache und Theme (Stil, hell/dunkel) **live** in jedem Programm über die Hülle (fs-components-app): `refresh` im Takt (Stempel-Vergleich),
   Beobachter schalten Texte (MF2) und Stil um; Programme bekommen das ohne eigenen Code.
9. **Standards:** XDG Base Directory (Orte), XDG Desktop Portal `org.freedesktop.portal.Settings` (System-Schicht: `color-scheme`, `accent-color`, `contrast`;
   Adapter später), BCP 47 (Sprache), TOML 1.0 (Dateien, flache Schlüssel, nur Skalare) [ersetzt durch Nachtrag 2026-11-17: nur Import/Export], DTCG Design Tokens beim Theme (ADR 0074); GSettings/dconf nur als **Konzept**
   (Deklaration je Baustein, Schema-Datei), nicht übernommen.

**Pflichttests** (je ohne Umsetzung rot; Suite `settings` in fs-conformance, 18 Regeln aus der Probe, hinter dem Feature `conformance`, nie im normalen Abhängigkeitsgraphen): Sperre schlägt jede Schicht; Sperrender ändert selbst nicht;
ohne Recht kein Sperrknopf; fremdes Programm-Profil nie geschrieben; „für alle“ entfernt die eigene Überschreibung; undeklarierter Schlüssel abgelehnt; kaputte Datei [ersetzt durch Nachtrag 2026-11-17: kaputte DB]
bleibt byte-gleich; Sperre scheitert geschlossen; Index der Profile unter Dateisperre [ersetzt durch Nachtrag 2026-11-17: eine Transaktion] (keine doppelte Id).

**Ist-Stand der Probe (belegt, Quelle: Prüfungsbericht `review-setting-probe-opus.md`, Kopf 46566b49)**
- **Tests:** 60 Testfunktionen in 12 Dateien unter `crates/fs-settings/tests/` (56 `#[test]`, 4 `#[tokio::test]`); dazu die Suite mit 18 Regeln und 14 Bench-Mutanten im Quelltext (`src/suite/`).
  Zweig-Gates am Kopf (Skripte aus fs-release, CI-gepinnt): fmt, clippy (pedantic, alle Ziele), `test -p fs-settings --all-features` (60 grün, 0 rot), `cargo doc` mit `-D warnings`,
  Regeln, Lock: alle rc 0.
- **Mutanten (eigene Kopie, je rot, zurückgesetzt):** R1 (Index ohne config-Sperre), R1c (Wert ohne Sperre), R3, R4/R4b/R4c (Id-Prüfung), R5 (`language` erlaubt), R6, R9a/R9b (Grund leer),
  R10 (`set_default` ohne Recht), P1a/P1b (Sperre unsichtbar bzw. lässt Person durch), D1, RF, PA3 und weitere; die genannten sind je von mindestens einem Test erkannt. **Überlebt:** R1b (Index ohne state-Sperre;
  gleichwertig, weil jeder Index-Schreiber zuerst die config-Sperre nimmt, die state-Sperre bleibt als Doppelschutz); R2 (kaputter Index wird doch überschrieben) hat noch keinen Test (L7).
- **Zahlen:** 22 Fehler-Codes (`SettingCode`, `crates/fs-settings/src/codes.rs`), 7 Schicht-Wörter in den Parametern (`default`, `instance`, `system`, `person`, `program`, `named-person`,
  `named-program`; die 5 Schichten dieses ADR plus die zwei benannten Profile), 5 Standard-Deklarationen der Hülle (`fs.shell.language`, `fs.look.style`, `fs.look.scheme`,
  `fs.shell.frontend`, `fs.shell.refresh-ms`).
- **Erfüllt aus der Prüfung:** N1 (Index als ein Lesen-Ändern-Schreiben unter der Dateisperre, `Store::update_index`), N2 (Sperre scheitert geschlossen), N3 (`save` prüft am frischen Instanzstand),
  N4 (Id 0, doppelte oder zu große Ids: `profile{cause=id-invalid}`; `language` reserviertes Programmwort), N5 (Takt-Konstanten, Gruppe `system`, `OwnerKind::ALL` als Slice), N6 (Grund Pflicht, `reason-missing`),
  N8, N9, vorgezogen L4 (`set_default` braucht ein Recht, `no-right`). N7 teilweise (siehe L8).

**Noch nicht gebaut (offen, nicht als fertig zu lesen)**
- **L1:** `coded_stub` entfällt; `fs_types::coded` und fs-conformance kommen per Tag fs-types v0.0.2 (Workspace-Pin und `rev` in einem Commit; keine Doppel-Typen). Bis dahin trägt die Probe ein eigenes Modul `coded_stub`.
- **L2:** Windows-CI: `windows.yml` baut nur `fs-components-commands`; `fs-settings` (Dateisperre, `rename` über eine offene Datei) ist auf Windows **ungeprüft**. Die Windows-Orte (Known Folders) sind unten Offen 3. [ersetzt durch Nachtrag 2026-11-17: nur noch Windows-CI der übrigen Teile; Dateisperre/`rename` entfallen]
- **L3:** Der Satz „Ob KI erlaubt ist, ist ein Recht in fs-access, nie eine Einstellung“ steht in diesem ADR (Entscheidung 7), aber noch **nicht** in der Dokumentation (`lib.rs`) der Bibliothek.
- **L5:** Der Dateistempel nutzt (Länge, Änderungszeit); die Inode (Unix) fehlt noch. Zwei Schreibvorgänge gleicher Länge im selben Zeittakt auf groben Dateisystemen werden bis dahin übersehen. [entfällt mit der Datei-Ablage, Nachtrag 2026-11-17]
- **L6:** Ist der state-Ordner derselbe Ordner wie der config-Ordner, aber anders geschrieben (Symlink, `..`), hängt `update_index` (Selbstblockade, Probe P9, Timeout nach 3 s). Selten, ohne API-Änderung zu beheben
  (Ordner nach `make_dir` über `canonicalize` bzw. Gerät und Inode vergleichen, dann nur eine Sperre). Dazu ein Doku-Satz: Bei einem Absturz zwischen den beiden Index-Dateien gilt das alte `active`; eine Id ohne Namen
  ergibt die Basis und `profile{cause=unknown}` (sichtbar, nicht still). [L6 entfällt mit der Datei-Ablage, Nachtrag 2026-11-17]
- **L7:** Test, dass ein kaputter `profiles.toml` von `create_profile` nicht überschrieben wird (fängt R2); Doku, dass `id-invalid`-Einträge beim nächsten `update_index` aus der Datei fallen. [entfällt mit der Datei-Ablage; L7 wird Import-Test, Nachtrag 2026-11-17]
- **L8:** MF2-Texte `setting-label-fs-shell-refresh-ms`, `setting-about-fs-shell-refresh-ms` und `reason-missing` (de+en) fehlen, weil die Probe keine MF2-Datei hat; sie kommen mit dem ersten Verbraucher, der die Texte von `fs-settings` trägt (Hülle oder Programm `fs-settings`).
- **Datenbausatz `ProfileSet`/`ProfileName` in fs-types:** liegt noch in der Probe (`profile.rs`, `profile_name.rs`); der eigene Fixpunkt `profile_v1` entsteht erst, wenn beide in fs-types liegen (zweiter Nutzer: Voreinstellungen des Regelwerks).
- **Vertrag `settings`** in fs-interfaces (nur Entwurf `settings.capnp`, nicht übersetzt), **Hülle** (Sprache/Theme live, Takt), **Programm `fs-settings`** und die Komponenten (Schloss-Knopf, Speichern-Ziel, Profilauswahl): alle nicht gebaut.
- Die Probe ist **nicht released** (kein Tag); der Merge in main von fs-components ist Sache der Strategie (Reihenfolge laut Prüfung: erst `probe-fs-setting-2`, dann die Rebases der wartenden Zweige).

**Folgen**
- Nachträge (eine Welle): ADR 0057 (Sprache über fs-settings), 0065 (Menü Programm › Einstellungen öffnet fs-settings), 0074 (Darstellung als Einstellung,
  Portal-System-Schicht), 0094 [Entw.] (Frontend-Wahl `fs.shell.frontend` als Einstellung).
- Reihenfolge (Probe-Nachlauf N1–N9 und Fixpunkt `setting_v1` sind erledigt): L1 (+ L2) → fs-types-Lift (`coded`, `ProfileSet`, `profile_v1`) → Vertrag `settings` in fs-interfaces → Hülle
  (Sprache/Theme live, Takt) → Programm fs-settings → Komponenten (Schloss-Knopf, Speichern-Ziel, Profilauswahl).
- Nachträge (eine Welle) zu ADR 0057, 0065, 0074 und 0094 bleiben als **Entwurf** gekennzeichnet; sie verweisen auf diesen ADR als angenommen. Ihre eigene Annahme ist nicht Teil dieser Stufe.

**Offen**
1. Portal-Adapter: **Entscheid der Strategie (b7, 2026-11-17):** zuerst ein Spike mit `ashpd =0.14.0`, derselben Version wie in `fs-components-filepicker` (keine zweite Version im Lock); bis zum Adapter bleibt die System-Schicht aus Umgebungsvariablen. [entschieden, Spike offen]
2. Instanz-Vorgaben auf einem Server schreiben (v1 nur lesen; `Admin::set_default` mit Admin-Recht aus fs-access, Auflage L4): **Entscheid der Strategie (b7, 2026-11-17):** die Datei `instance.toml` [ersetzt durch Nachtrag 2026-11-17: Datenbank] schreibt vor fs-connect ein **Admin per Skript**, nie ein Agent (vereinbar mit der Regel „keine KI auf Servern“); das Skript liefert `fs-settings` als Befehl mit, die Ausführung liegt beim Menschen. [entschieden]
3. Windows-Orte (Known Folders). [offen] [erledigt durch Nachtrag 2026-11-17: Entscheidung 10]
4. Gleichzeitiges Schreiben zweier Programme ins allgemeine Profil (letzte Umbenennung gewinnt). [erledigt durch Nachtrag 2026-11-17: Transaktion]

## Nachtrag (Nutzer, 2026-11-17, Frage 18: Speicher ist die Datenbank, nicht Dateien) [Entwurf]
**Nutzerwortlaut** (Frage 18, 2026-11-17, über die Strategie weitergegeben): „Kein JSON und kein TOML als Speicher oder Konfig. JSON/TOML nur für Import/Export und Kompatibilität. Alles liegt in der Datenbank, hinter Schnittstellen. Ausnahme nur Werkzeug-Dateien (Cargo.toml, CI-/Workflow-YAML). Typisierte Speicherung (fs-objects Schema v5, ADR 0086) kommt JETZT, vor dem Beweis-Programm; grundlegend richtig, nicht voll ausdifferenziert, Spalten später ergänzen ok. fs-settings speichert in der DB statt in settings.toml/instance.toml.“
**Frage 19** (über die Strategie): „contract/*.toml, scaffold.toml und AppStream-XML bleiben JETZT Dateien (nur Zeitdruck), später in die DB (Datei = Export).“

**Entscheidung**
1. **Speicher:** `fs-settings` speichert in der Datenbank, nicht in `settings.toml`, `instance.toml`, `profiles.toml` oder einer anderen Datei. Die Ebenen (Instanz, Profil allgemein, Profil je Programm, benanntes Profil, Gerät) sind Zeilen bzw. Tabellen in der DB. Das Schloss (`reason`, `locked_by`, `locked_at` in UTC) und das Protokoll der Änderungen liegen ebenfalls dort. Die Schichten und die Regel „Eine Sperre schlägt jede Schicht“ (Entscheidung 2 und 5) bleiben unverändert.
2. **Schnittstelle und Schichtung** (Plan `PLAN-speicher-schnittstelle` §3, Entscheid der Strategie c0, 2026-11-17): Der Port **`SettingsStore`** (heute `Store`) und `InstanceStore` bleiben in der Bibliothek `fs-settings` (Repo fs-components, Schicht 1); sie kennt keine Dateien und keine Datenbank. `fs-objects` v5 liefert nur die Domäne `settings` (Tabellen `settings_*`, typisierte Zeilen-Funktionen) und kennt `fs-settings` nicht. Der Adapter `DbSettingsStore` liegt im Programm fs-settings (`fs-settings-server`); Programme und Hülle bekommen `RpcSettingsStore` aus dem neuen Schicht-2-Crate `fs-settings-rpc` (Repo fs-rpc). Es entsteht keine Kante zwischen Schicht-1-Repos (ADR 0093). `MemoryStore` bleibt der Fake (ADR 0097).
3. **DB-Ort:** per Konvention (Linux XDG, Windows Standardordner); änderbar per Startargument.
4. **Kaputte DB:** die eingebauten Voreinstellungen gelten, der Fehler wird **offen gemeldet** (nie still, kein Überschreiben der kaputten Datei).
5. **Instanz-Vorgaben:** ein **Admin-Skript** ruft einen Befehl (`fs-settings`), der in die DB schreibt; der Mensch führt es aus, nie ein Agent (Offen 2 bleibt in dieser Form, nur das Ziel ist die DB statt `instance.toml`).
6. **JSON und TOML** nur noch als Import/Export und für Kompatibilität (ADR 0086 Entscheidung 3); Ausnahme nur Werkzeug-Dateien (`Cargo.toml`, CI- und Workflow-YAML).
7. **Ersetzt** wird die Datei-Ablage der Probe (`XdgFiles`, `files.rs`, `files_index.rs`, `files_write.rs`; Probe `probe-fs-setting-2`, Lift `settings-lift-1/-2`); `XdgFiles` wird zum Import/Export-Leser und -Schreiber mit Rundlauftest: sie wurde **in keinem Tag veröffentlicht** (fs-components main, kein Tag), es gibt **keine Migration**. Entscheidung 2 (Ort Gerät), Entscheidung 9 (TOML 1.0 als Dateiformat) und Offen 2 (`instance.toml`) sind oben als „ersetzt durch Nachtrag“ gekennzeichnet; dazu entfallen mit der Datei-Ablage die Dateisperre-Punkte L5 und L6 und der Datei-Teil von L7 unter „Noch nicht gebaut“ (L2: nur noch für andere Teile der Bibliothek zu prüfen).

8. **Ein Prozess besitzt die DB** (Frage 1, ja): der Server `fs-settings serve` besitzt die Einstellungs-DB der Person; alle anderen sprechen über den Vertrag `settings` (fs-objects: eine Datei, ein Prozess).
9. **Vertrag:** `settings.capnp` kommt in die laufende Pin-Kaskade, fs-interfaces 0.0.28 (Frage 2, ja).
10. **Orte** (Fragen 3 und 4, ja): Personen-DB `$XDG_DATA_HOME/freesynergy/settings/settings.db` (wie alle Programm-DBs, nicht CONFIG); Windows `%LOCALAPPDATA%\FreeSynergy\settings\` (Person) und `%ProgramData%\FreeSynergy\instance\` (Instanz). Offen 3 ist damit geschlossen.
11. **Instanz-Schicht** (Frage 5, ja): eigene DB hinter einem System-Dienst; das Admin-Skript spricht mit ihm. Bis dieser Dienst gebaut ist, bleibt die Instanz-Schicht leer.
12. **Entsperren** verlangt ebenfalls einen Grund und steht im Protokoll (Frage 6, ja).
13. **Gleiche Regel überall** (Frage 8, ja): Sitzung (`session.toml`, ADR 0069 Nachtrag) und die Frontend-Wahl-Datei (fs-tasks) liegen in der DB; bestehende Dateien nur einmaliger Import.
14. **Werkzeug-Dateien vorläufig** (Frage 19): Block-Vertrag `contract/*.toml`, `scaffold.toml` (ADR 0099) und AppStream-XML bleiben jetzt Dateien (nur Zeitdruck); später in die DB, die Datei ist dann Export.

**Grund:** eine einzige Wahrheit hinter Schnittstellen (ADR 0042, 0086), typisierte Werte statt Text-Dateien, Schloss und Protokoll transaktional statt über Dateisperren und Umbenennen.

**Folgen**
- Folge-Verweise (eine Welle, Entwurf): ADR 0069 Nachtrag (Sitzung in der DB statt `session.toml`), ADR 0087 Nachtrag Punkt 6 und ADR 0074 §6 (Beschreibung/Anordnung: Datei = Austausch, Speicher = DB), ADR 0099 (`scaffold.toml` vorläufig Datei, Frage 19), ADR 0094 [Entw.] (Frontend-Wahl in der DB), ADR 0057 (Sprachdateien nur Import).
- Neue Reihenfolge (Strategie, 2026-11-17): fs-types 0.0.3 -> Pin-Kaskade -> fs-objects v5 typisiert (mit Domäne `settings`) -> fs-settings auf DB -> F1/F2 (forms-Beschreibungen als Daten in der DB, `tasks-board.toml` nur Import) -> fs-tasks.
- Der Fixpunkt `setting_v1` und die Zweig-Köpfe der Probe bleiben wörtlich als Probe-Stand; ein neuer Fixpunkt entsteht nach dem Umbau mit kurzer Prüfung.
- Die Pflichttests (Sperre, fremdes Profil, „für alle“, undeklariert, kaputte Datei bleibt byte-gleich) gelten weiter, gegen den `SettingsStore`; „kaputte Datei“ wird zu „kaputte DB: Voreinstellung, offen gemeldet“.

**Offen**
1. **DAG-Platz des Trait `SettingsStore`** [entschieden c0, 2026-11-17: siehe Entscheidung 2 dieses Nachtrags]
2. Aufbau der typisierten Settings-Tabellen (Spalten je Einstellungsart) und Zusammenspiel mit `ProfileSet<V>`: mit v5 „grundlegend richtig“, Spalten additiv (ADR 0086 Nachtrag 2026-11-17). [offen]
3. Gerät-Ebene: eigene DB je Gerät oder Zeilen mit Geräte-Id in der gemeinsamen DB. [offen]

## Nachtrag 2026-11-17: Einstellungen des forms-Hosts [Entwurf]
- Neue Schlüssel (ADR 0096 Punkt 20): `fs.forms.records.page-max`, `fs.forms.records.conditions-max`, `fs.forms.records.call-ms`, `fs.forms.layout.*` (Grenzen der Beschreibungen), `fs.forms.search.kind`, `fs.forms.live.poll-ms`. Grenzen sind Einstellungen mit Instanz-Vorgabe und Schloss (O7); fest nur technisch Erzwungenes mit Beleg.
- `fs.shell.style` (Wahl der Person) gewinnt über den Stilnamen der Beschreibung (`forms_layout.style`).
- **Abgrenzung:** gespeicherte Ansichten und Filter einer Person sind Daten der Beschreibung (`forms_view`, `forms_filter_node` in fs-forms), keine Einstellungen; fs-settings hält nur Skalare. Das Instanz-Schloss für Beschreibungen (ADR 0096 Punkt 10) folgt dem Muster dieses ADR (Grund Pflicht für Sperren und Entsperren, Protokoll, Instanz-Dienst später), liegt aber in der forms-DB.

## Nachtrag 2026-11-23 (ADR 0108, Entwurf): keine Sperre über Fristen eigener Daten
- Die Fristen des digitalen Vergessens liegen als Einstellungen in fs-settings (`fs.vault.retention.<datenart>` [Name Vorschlag, wird in VG-3 entschieden]; ADR 0108 E1).
- **Ausnahme zu E5 (Schloss):** Die Fristen der **eigenen** Daten einer Person kann kein Instanz-Admin sperren (ADR 0108 E7). Fristen von **Gruppen-Daten** setzt die Gruppe nach ihrer eigenen Entscheidungsregel (ADR 0095).
