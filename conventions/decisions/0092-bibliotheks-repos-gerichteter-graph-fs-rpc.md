# 0092 – Bibliotheks-Repos bilden einen gerichteten Graphen; RPC-Laufzeit in fs-rpc

Status: **akzeptiert** (Strategie, 2026-11-16; Variante V2, Opus-Review 28ca3165) · baut auf `conventions/coding.md` Abschnitt 8 (git-Abhängigkeit mit Tag, Abhängige ziehen im selben Schritt nach), ADR 0085 (Typen `Utc`, `LocalDateTime`, `Zone`, `PersonRef` in fs-types)

## Kontext
- Zwischen drei Bibliotheks-Repos besteht ein Kreis: `fs-interfaces` (Feature `rpc`) hängt von `fs-objects` ab, `fs-objects` (Feature `v5`) von `fs-types`, und `fs-types` liegt im Repo `fs-interfaces` und hängt dort von `fs-interfaces` selbst ab (Schemata `types_capnp`, `values`; 24 Quelldateien).
- Belege (Probe-Klone, 2026-11-16, Opus-Vergleich der Strategie, Arbeitsstand, nicht veröffentlicht):
  - Ohne Eingriff enthält der Lock von fs-people **zwei** `fs-types` (v0.0.22 über `fs-objects v0.0.3` über `fs-interfaces v0.0.25`, daneben das neue).
  - `fs-objects` v0.0.3 mit `fs-types` v0.0.25 allein: `cargo check -p fs-objects --features v5 --all-targets` ist grün.
  - Mit diesem `fs-objects` als `[patch]` in people: `error: cyclic package dependency: package fs-interfaces v0.0.25 … depends on itself … fs-types v0.0.25 … fs-objects v0.0.3 … fs-interfaces v0.0.25`.
  - `fs-calendars` (v5 plus rpc) hat den Kreis schon heute. `fs-tasks` hat zwei `fs-types` im Lock (über `fs-jscalendar` v0.0.2 und `fs-people-directory`). `fs-texts` und `fs-packages` laufen in den Kreis, sobald sie auf v5 gehen (Speicherung typisiert, ADR 0086).
- `rpc` nutzt von `fs-objects` nur v4-Teile (`ObjectId`, `Envelope`; 5 Quelldateien). Die Kante ist also klein, schließt aber den Kreis.
- Ein Repo-Kreis erzwingt nach `coding.md` Abschnitt 8 immer einen veralteten Pin: Ein neuer Tag in einem Glied zieht kein anderes nach, ohne dass das erste wieder nachzieht.

## Entscheidung
- **`fs-interfaces` enthält nur Verträge** (Schemata, generierter Code, `values`, `provider`, `fs-types`). Es hängt von keinem unserer Laufzeit-Repos ab. `fs-types` bleibt im Repo `fs-interfaces`.
- **Die RPC-Laufzeit** (Socket, Envelope-Adapter, Seiten, Feed, Probleme; 38 Dateien samt 23 Testdateien) zieht um in ein neues Repo `FreeSynergy/fs-rpc` mit dem Crate `fs-rpc`. Name nach Namensregel: Bibliothek, Einzahl, klein, Präfix `fs-`.
- **Regel 1, Repo-DAG:** Unsere Repos bilden einen gerichteten Graphen ohne Kreis. Eine Kante zeigt nur von oben nach unten (Pfeil heißt „wird benutzt von“; cargo-Abhängigkeiten zeigen umgekehrt): `fs-interfaces` → `fs-objects` und `fs-jscalendar` → `fs-rpc` → Programme. Eine Kante, die einen Kreis schließt, ist verboten.
- **Regel 2, eine Quelle:** Der `Cargo.lock` eines Programms enthält je Bibliothek (`fs-types`, `fs-objects`, `fs-interfaces`, `fs-jscalendar`, `fs-rpc`) genau eine Quelle. Eine CI-Prüfung in `fs-release` (Skript) liest den Lock und schlägt bei zwei Quellen fehl.

## Folgen
- Probe (V2): Alle Programmpfade `fs_interfaces::rpc` werden zu `fs_rpc` (reine Ersetzung, in fs-people 47 Dateien); in `fs-rpc` selbst `crate::` zu `fs_interfaces::` an 17 Stellen. Danach `cargo tree -i fs-types`: ein Paket, Lock 1× `fs-types`, `cargo check --workspace` (mit App) ohne Fehler.
- Das Feature `rpc` in `fs-interfaces` entfällt vor dem ersten Release ohne Übergang (kein Alias, keine Weiterleitung; Nutzerregel: vor dem ersten Release werden Schnittstellen ohne Umstände ersetzt). Der Alias `fs-objects-v5` in fs-people entfällt.
- Tags in fester Reihenfolge: `fs-interfaces` v0.0.26 (rpc-Modul und Tests raus) → `fs-objects` v0.0.4 und `fs-jscalendar` v0.0.3 (nur Pin auf v0.0.26, parallel) → `fs-rpc` v0.0.1 (neu, mit Tests und CI).
- Programme danach, je mit Pins, Ersetzung und Gates: people (Probe als Vorlage) → calendars (hat den Kreis) → tasks → groups → texts → packages.
- `fs-components` zieht auf v0.0.26 (heute v0.0.23 mit `fs-interfaces` v0.0.19, ein zweites `fs-interfaces` im Lock).
- Rest-Risiko: Ein `fs-types` nur, solange alle Pins auf denselben `fs-interfaces`-Tag zeigen (`fs-objects`, `fs-jscalendar`, `fs-rpc`, Programm). Jeder neue `fs-interfaces`-Tag zieht diese drei in der obigen Reihenfolge nach; die CI-Prüfung (Regel 2) fängt Abweichungen.
- Aufwand (Schätzung Opus): 2 bis 3 Tage.

## Verworfen
- **V1, `fs-types` als eigenes Repo:** bricht den Kreis nicht, solange `fs-types` von `fs-interfaces` abhängt (Probe: derselbe `cyclic package dependency`-Fehler).
- **V1+, `fs-types` ohne Kante zu `fs-interfaces`:** wäre kreisfrei (Manifest-Probe), verlangt aber den Umzug von `types.capnp` und `values` (13 Schemata importieren `types.capnp`) und ein neues Regenerieren; 4 bis 6 Tage, deutlich teurer als V2.
- **V3, `fs-objects` v5 ohne `fs-types`:** bricht den Code (12× E0432) und verlangt eine zweite Kopie der Typen oder Generik über rund 23 Dateien; das verstößt gegen R13 in `docs/v5-entwurf.md` von fs-objects („Types come from fs-types“) und gegen ADR 0085 (Typen liegen in fs-types).

## Offene Punkte
- Bei V1+ ist der Codegen-Querverweis über Crate-Grenzen nicht belegt; falls V1+ später wieder erwogen wird, zuerst eine Probe.
- `fs-components`-Pin: getrennt nachziehen (v0.0.23 pinnt `fs-interfaces` v0.0.19); eigener Auftrag.
- Prüfen, ob `conventions/coding.md` Abschnitt 8 einen Nachtrag braucht (Repo-DAG und Lock-Regel dort aufnehmen oder bei diesem ADR belassen).

## Nachtrag 2026-11-16
- Regel 1 und der Punkt „Verworfen V1+“ werden durch ADR 0093 ersetzt (Entscheidung der Strategie: `fs-types` wird ein eigenes Repo mit `types.capnp`; der neue Repo-DAG steht dort als Regel 1). Regel 2 gilt unverändert. Der offene Punkt „Codegen-Querverweis bei V1+“ ist durch die Probe in ADR 0093 erledigt.

## Nachtrag 2026-11-23: Regel 2 bei Registry-Quellen

Status: **entschieden** (Entscheid Strategie 23.11., Nutzer informiert; Schnitt „ENTSCHEID-kaskade“, Empfehlung B2) · **ergänzt** Regel 2 (Fix-Weg, Registry-Quellen), Wortlaut der Regel bleibt · Grund: ADR 0093, Nachtrag 2026-11-23
1. **Regel 2 bleibt wörtlich.** „Eine Quelle“ heißt im Lock: genau ein `[[package]]`-Eintrag je Bibliothek. Zwei 0.0.x-Versionen von fs-types aus demselben Registry sind zwei Einträge und damit rot. Das passiert, wenn ein Verbraucher seine Untergrenze hebt und der Lock noch die alte Version hält (Probe der Strategie, 23.11.).
2. **Fix-Weg bei einer Registry-Quelle:** `cargo update -p fs-types` im Programm. Das ist eine reine Lock-Änderung. Neue Pins oder neue Tags der Bibliotheken dazwischen braucht es dafür nicht mehr. Die Fix-Meldung der Prüfung nennt diesen Befehl. Bei Git-Quellen bleibt der bisherige Weg („alle Abhängigen auf denselben Tag“).
3. **Änderung an der Prüfung in fs-release (K-3):**
   - Registry-Quellen (`registry+…`, `sparse+…`) werden normalisiert wie Git-Quellen.
   - Für fs-types ist die einzige erlaubte Quelle die Index-URL von `freesynergy`.
   - Prüffälle: Registry-Doppel rot, Registry einzeln grün, Git-fs-types unter der Quellenregel rot.
   - Streng (rot statt Warnung) wird die Prüfung für fs-types erst nach der Umstellungswelle (K-5).
   - Die Prüfung ist heute ein Python-Skript. Die Änderung ist ein Auftrag nach CLAUDE.md §7, kein neues Python. Der Umzug nach Rust folgt der Inventur.
4. Das Rest-Risiko aus „Folgen“ (jeder `fs-interfaces`-Tag zieht nach) gilt weiter für alle Bibliotheken, die per Git-Tag gepinnt sind.
