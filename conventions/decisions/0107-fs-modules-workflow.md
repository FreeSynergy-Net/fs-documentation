# 0107 – Workflow-Modul `fs-modules-workflow`: Serverless Workflow 1.0.3 als eine Sprache, FS-Profil, Mensch-Warten als Katalogfunktion, Lauf als AS2-Objekt

Status: **Entwurf** (2026-11-23; Workflow `adr-write`, Schritt `schreiben`, W-0). **Entscheid Strategie 23.11., Nutzer hat der Richtung zugestimmt.** Die Einzelheiten sind noch nicht vom Nutzer angenommen; eine Opus-Prüfung steht aus, bis dahin keine Annahme. Der Entwurf ersetzt den Arbeitsnamen `fs-flow` aus ADR 0103 Punkt 5 und ergänzt ADR 0105 (Lauf-Ebene und Sicht „Lauf als Fall“). Die Verweise stehen in 0103 und 0105.

Quellen: Schnitt-Papier „ENTSCHEID-Schnitt“ (Workflow `entscheidung`, Schritt `cut`, 23.11.) und Inventur „INVENTUR“ (Workflow `entscheidung`, Schritt `recherche`, 23.11.). Beide liegen im internen Arbeitsordner und sind nicht veröffentlicht. Dort stehen die Belege mit Datei- und Zeilenangaben; sie werden hier nur in Kurzform genannt.

## Kontext

Wir beschreiben Abläufe heute in 60 YAML-Dateien (`fs-release/workflows/`, alle `dsl: 1.0.3`). Die Dateien sind nur Beschreibung; sie laufen nicht. Für Programme brauchen wir denselben Ablauf als Daten, mit Menschen, die auf Entscheidungen warten, mit einem Lauf, der einen Neustart übersteht, und mit Bahnen und Zuständen in den Sichten (ADR 0103, 0105).

Drei Dinge fehlen heute:

1. Warten auf einen Menschen mit Grund (`wartet`, `auf-entscheidung`) hat keinen Baustein im Standard.
2. Ein Lauf ist kein Datensatz. Zustände und Aufenthalte gehören dem Lauf (ADR 0103 Punkt 2), nicht der Datei.
3. Akteur und Bahn sind nur Textangaben. Wer zur Laufzeit handelt, ist nicht geregelt.

Die Inventur (Teil 2) prüft die Kandidaten Serverless Workflow, BPMN, SCXML, CWL, Arazzo und ActivityStreams 2 gegen diese Mittel. Keiner deckt alles ab. Serverless Workflow deckt die Schritt-Mittel am besten (Befehl, Verzweigung, Frist, Unter-Workflow, parallele Pfade). Lauf-Zustände und die Bahn-Darstellung bleiben eigene Sache des FS-Profils und des Laufs.

## Entscheidung

### E1. Eine Sprache: Serverless Workflow (Open Workflow DSL), gepinnt auf 1.0.3

- Serverless Workflow bleibt die einzige Beschreibungssprache. Version `dsl: 1.0.3`.
- Ein Wechsel auf 1.1 erfolgt erst, wenn der Crate es liest. Das ist heute **nicht belegt** (Offen 5).
- BPMN ist nur Sicht und Import/Export (ADR 0105 E2 Nr. 3, Entscheid des Nutzers 20.11.). Kein Speicherformat.
- SCXML und Arazzo sind **nicht** die Sprache. Der Lauf hat acht Zustände als Daten (`fs-release/workflows/run/rules.yaml`, `STATES.md`), dafür braucht es keinen zweiten Standard.

### E2. FS-Profil: nur `metadata` und Katalog-Aufruf

Das Profil erweitert den Standard nicht. Es nutzt nur die Haken, die der Standard selbst anbietet.

| Teil | Form | Regel |
|---|---|---|
| Schritt-Angaben | `metadata: freesynergy.net:*` | erlaubt (Standard: freie `map`, DSL:290). Felder: `actor`, `actor-type`, `gate`, `kind`, `summary`, `bot-seat`, `adr`, `phase`, neu `role` (E5), `wait-reason` (E3). |
| Modulbefehl | `call: <modul>.<schlüssel>:<major.minor>@fs` mit `with` | erlaubt. Die Version ist die Vertragsstufe (major.minor), nicht der Tag (ADR 0104 E2). |
| Mensch-Warten | `call: ask:1.0@fs` | erlaubt, siehe E3. |
| Standard-Ablaufarten | `do`, `switch`/`then`, `listen`, `fork`, `for`, `try`/`catch`, `set`, `emit`, `run.workflow` | Standard und erlaubt. `run.workflow` (Unter-Workflow) ist in `adr-write.yaml` und `entscheidung.yaml` in Gebrauch; diese Einordnung ist eine Auslegung von mir (Offen 9). |
| Eigene Task-Arten (`Custom` in swf-runtime) | – | **verboten** in Dateien. Sie würden den Standard verlassen. |
| `run: shell`, `run: script`, `run: container` | – | **verboten.** Der Standard kennt sie, aber der Status-Befehl läuft nur nach `STATES.md:56-63`. |

Pflicht je Datei: `use.catalogs.fs` mit dem Endpunkt des Katalogs. **Heute fehlt dieser Eintrag in allen 60 Dateien** (`grep '^use:'` leer). Das ist eine echte Abweichung vom Standard (dsl-reference.md:1985-2021). Sie wird mit W-2 behoben, nicht mit diesem ADR.

Eine Datei mit `call`, dessen Katalog fehlt, ist ungültig. Der Prüfer (`check_workflows.py`, später der Profil-Leser im Modul) meldet das als Fehler.

### E3. Mensch-Warten ist eine Katalogfunktion `ask`

- `ask:1.0@fs` ist eine Katalogfunktion. Im Standard ist sie ein Task (dsl-reference.md:136, :1987), also zusammengesetzt aus Standard-Teilen:
  1. `call: planning.task.create` mit Zuständigen, Frage und Verweis auf den Lauf;
  2. `listen` auf ein Antwort-Ereignis (CloudEvent, Filter auf Lauf und Schritt) mit `timeout`.
- Der Wartegrund steht in `metadata: freesynergy.net:wait-reason` (Werte aus ADR 0103 E3: `auf-entscheidung`, `auf-anfrage`, `in-prüfung`).
- Die Antwort ist eine AS2-Aktivität `Accept` oder `Reject` auf die Frage (AS2-Vokabular, Activity `Question`).
- `gate: human` bleibt als Angabe. Der Prüfer verlangt: ein Schritt mit `gate: human` nutzt `ask`. Ein Menschen-Schritt ohne `ask` ist ein Fehler.

### E4. Der Lauf ist ein AS2-Objekt in fs-objects

- Typ `fs:Run` per JSON-LD-Erweiterung (AS2-Erweiterungsregel). Speicher: fs-objects, typisierte Spalten (ADR 0086), nicht JSON oder Blob.
- Spalten: `workflow` und `version`; Zustand × Station × Wartegrund; `loop.iteration`; Akteur und Starter; `$context` als Liste von Verweisen.
- Zustände aus `fs-release/workflows/run/rules.yaml` (acht Stück: offen, läuft, wartet, pausiert, fehlgeschlagen, abgebrochen, erledigt, archiviert).
- Activities je Schritt: Stationswechsel `Move` (origin → target, ADR 0103 Punkt 7); Antwort `Accept`/`Reject`; ein Modulbefehl protokolliert seine eigene Änderung selbst (`Create`/`Update`). Der Lauf hält davon nur den Verweis und einen Kurztext (ADR 0086).
- Nach außen als CloudEvent (ADR 0081). fs-activity indiziert die Activities.
- Die Beschreibung (Workflow) ist ein AS2-Objekt `fs:Workflow`; das SW-Dokument liegt als Inhalt in Standardform, wie HTML im Inhalt einer Notiz. **Richtung zugestimmt, Feinschnitt offen** (Offen 3).
- YAML-Dateien sind Import und Export. Die Entwicklungs-Workflows bleiben YAML in `fs-release`, weil dort Review und CI laufen (Werkzeug-Dateien). Das Modul importiert sie nur lesend (Nutzer 17.11.).

### E5. Bahn = `freesynergy.net:role`

- Die Bahn (Achse Y, ADR 0103 Punkt 6) gruppiert nach `role`. Ersatzweise nach `actor`.
- `role` ist neu. Es ist das Feld, das WRP2 (Role-Based Distribution) abbildet (ADR 0105 E1a).
- Dieselbe Gruppierung gilt im Ablauf-Graph und im Board.

### E6. Akteur nur aus der Verbindung

- Wer zur Laufzeit handelt, kommt **nur aus der Verbindung** des Laufs, nie aus der Datei.
- Ein Bot hat höchstens die Rechte des Starters (ADR 0091, ADR 0105 E3a).
- Eine KI handelt nur als `ai:<name>` über den Bot-Platz und nur mit Freigabe (ADR 0091 E1/E2). In der Datei heißt sie `actor: ai`, `actor-type: Service` mit `bot-seat` (ADR 0105, Entscheidung 8).
- Ein Schritt ohne `gate: human` darf nicht `destructive` oder mit Außenwirkung (`actsInName`) sein. Das ist Pflicht im Läufer (Schnitt Teil 4).

### E7. Ein Modul `fs-modules-workflow` (Arbeitsname) für Beschreibung und Lauf

- **Ein** Modul für Standard, Beschreibung und Lauf. Beschreibung und Lauf teilen Modell und Stationen; zwei Module müssten das Modell doppelt kennen (CLAUDE.md §8: Standard → Modul → eine Quelle). Es ersetzt den Arbeitsnamen `fs-flow`.
- `fs-workflows` bleibt das Programm mit reinen Daten (Forms, Frontend, Hilfe). Dort liegt kein Code (Regel „Kein Extra-Code“).
- Crate: **`swf-core = "=1.0.0-alpha14"`**, exakter Pin, eigener Adapter, kein Fork. Der Pin ist exakt, weil `^1.0.0-alpha14` nach dem Text-Vergleich der Pre-Release-Kennung auch `alpha9` zöge (Schnitt §0, Befund vom 23.11.). Das Crate ist pre-1.0 und hat einen Betreuer; das zählt nicht gegen es (CLAUDE.md §8).
- **swf-runtime nutzen wir vorerst nicht.** Es hält den Lauf nur im Speicher, bringt Shell und Container mit und hat keinen Resolver-Trait. Unser Läufer führt genau einen Schritt aus dem gespeicherten Lauf-Datensatz aus und schreibt das Ergebnis zurück. Er nutzt swf-core und `jaq-core` (dieselbe jq-Engine wie swf-runtime). **Richtung zugestimmt, Feinentscheid offen** (Offen 2).
- Upstream (W-1): Vorschlag an ejfkdev/ServerlessWorkflow-rs für einen `CatalogResolver`-Trait und Snapshot/Resume. Wird das angenommen, wechseln wir auf swf-runtime; das Datenmodell bleibt gleich.

### E8. Befehl-Aufruf über den Schreibweg

- Ein `call` `<modul>.<schlüssel>:<version>@fs` löst der Host über seinen Befehlssatz (`commands.json`, `capability` und `params`) auf.
- `with` wird zu Argumenten. Die Prüfung „Argumente ⊆ `params`“ ist dieselbe wie bei `host-notice-invoke-args`.
- Danach `FormSource.invoke(key, record, args)` mit der Verbindung des Lauf-Akteurs. Ein Fehler wird zur Meldung über fs-notification (ADR 0106) und zum Lauf-Zustand.
- Lücke: `invoke` liefert heute kein Ergebnis (`formsource.capnp:50` nur `failed`, `problem`). Vorschlag: Feld `result :Text` (IRI) hinten anhängen, im Vertrags-Bündel nach 0.0.32 (W-4). **Nicht gebaut.**

### E9. Darstellung

- Lauf als Spalten (Station × Zustand) mit Bahnen: Form `cards-in-columns@1.1` mit Kanal `lane`. Die Component ist da; eine Bahn-Achse im Kanban ist **nicht belegt** (Offen 8).
- Lauf als Zeitbalken: Form `bars-in-time@1.0`, Component da (ADR 0105 E4).
- Beschreibung als Graph: neue Form `steps-graph@1.0` aus dem Graph von swf-core. Die Component fehlt; Vorbilder sind zu prüfen. Das folgt in ADR 0105 E4 und W-8.
- Die Sicht „Lauf als Fall“ (ADR 0105, Punkt 5) zeigt offene Menschen-Schritte mit Wartegrund. Sie kostet keine eigenen Daten.

## Folgen

- Vor dem Bau: `workflow-pflege` ergänzt `use.catalogs.fs` in allen 60 Dateien und prüft sie mit swf-core (W-2). Ein Mutant ohne `use` muss rot werden.
- Das Modul kommt nach dem Vertrags-Bündel 0.0.32 und nach SW-5/SW-6 (Schnitt §5). Kein Workflow-Auftrag fasst `forms.txt`, `formsource.capnp` oder `capabilities.txt` vor 0.0.32 an.
- Der Lauf bekommt einen eigenen Opus-Review, wenn er Rechte und Sockets berührt (Harte Grenze 2, CLAUDE.md §4).
- Der Schreibweg (SW-1/4a/5/6) liefert den Modulbefehl mit Argumenten, Rechten und Meldung. Damit ist „später nach V1“ aus ADR-Entwurf 19.11. überholt.

## Abweichungen von bestehenden ADRs

- **ADR 0103 Punkt 5:** Arbeitsname `fs-flow` wird `fs-modules-workflow` (E7). Die Begründung dort (Art 2, Modul-Bausatz) gilt für das neue Modul. Nachtrag in 0103 gesetzt.
- **ADR 0105:** Die Lauf-Zeile (`fs-flow`, ADR 0103 E5) heißt jetzt `fs-modules-workflow` (E7). Die Fassung in 0105 zu Lauf und Ablauf bleibt; die Entscheidung über den Lauf-Speicher liegt hier (E4). Nachtrag in 0105 gesetzt.
- **ADR 0087 Punkt 5 und 0097 Punkt 7** nennen `fs-flow` als Bibliotheksnamen. Sie bleiben unverändert; ein Nachtrag ist nötig (Offen 10).
- Talks `2026-11-18-tasks-*` nennen `fs-flow` als Ort der Ausnahmen. Die Gespräche sind Verlauf und bleiben unverändert.

## Offen

1. **Schritt `cut` in `fs-release/workflows/entscheidung.yaml` fehlt.** Der Schritt ist als Karte bei `workflow-pflege` offen (Schnitt §0, Hinweis zu CLAUDE.md §2). Dieser Entwurf ist die Vorlage dafür. Der Schritt ist nicht gebaut.
2. **Läufer:** eigener Ein-Schritt-Läufer über swf-core und jaq (E7) oder vorerst swf-runtime. Empfehlung der Strategie: eigener Läufer. Nicht entschieden.
3. **Inhalt von `fs:Workflow` und `fs:Run`:** Das SW-Dokument als Inhalt eines AS2-Objekts (E4). Empfehlung: ja. Die Tabellen-Spalten und das Schema von `fs:Run` sind **nicht belegt** und noch nicht festgelegt.
4. **Ein Modul für alles** (E7). Empfehlung: ja. Nicht geprüft gegen eine zweite Lösung mit Vertrag.
5. **swf-core 1.1:** Liest das Crate Serverless Workflow 1.1? **[U]**. Außerdem die Reihenfolge der Pre-Release-Versionen (`alpha9` vor `alpha14` im Text-Vergleich): belegt in der crates.io-API, Konsequenz nur über den exakten Pin (E7).
6. **Katalog `fs` ohne abrufbaren Endpunkt:** Erfüllt er die Spec? Die Spec verlangt eine Dateistruktur am Endpunkt (dsl-reference.md:1989). **[U]**. Der Katalog wird über den Host aufgelöst, nicht über HTTP (Schnitt §2.6 iii).
7. **Agenten:** Gibt es einen A2A-Endpunkt für unsere Agenten (`call: a2a`)? **[U]**. Bis dahin ist der KI-Schritt `ask`-artig (Bericht-Antwort) und kein Modulbefehl.
8. **Bahn-Achse im Kanban:** Die Komponente hat keine Bahn-Achse (grep `lane`/`swim` leer). **[U]**, prüfen bei W-8.
9. **`run.workflow` im FS-Profil:** Ist die Unter-Workflow-Art Teil des Profils? Auslegung hier: ja, weil sie in Gebrauch ist. Vom Nutzer nicht bestätigt.
10. **Nachträge zu 0087 Punkt 5 und 0097 Punkt 7** (Bibliotheksname `fs-flow`). Nicht gesetzt.
11. **Zählung der Dateien:** Der Schnitt zählt 60 Dateien mit `dsl: 1.0.3`; ADR 0105 zählt 59. Vor W-2 mit `grep -l` nachzählen. **[U]**.
12. **Gate-Regel:** Die Pflicht `gate: human` für `unmarked`/`destructive`/`actsInName` stammt aus der Bewertung vom 19.11. (intern). Ob sie im Profil steht oder nur im Läufer, ist nicht entschieden.
13. **Nummer 0107:** Zum Zeitpunkt des Entwurfs ist 0107 frei (ls-remote der Zweige geprüft). Vor dem Zusammenführen erneut prüfen.
14. **Opus-Prüfung** des Entwurfs steht aus.

## Pflichttests (Vorschlag; nichts davon ist gebaut)

- W-2: alle 60 Dateien parsen mit swf-core und sind valide; Mutant ohne `use.catalogs.fs` muss rot werden.
- W-3: alle 60 Dateien importiert; `entscheidung` hat fünf Stationen; Mutant „Bahn ignoriert“ muss rot werden.
- W-5: Lauf übersteht einen Neustart zwischen Schritt 1 und 2; fremdes Recht ergibt `wartet auf-entscheidung`; `destructive` ohne Gate wird abgelehnt.
- W-6: ein Lauf mit zwei Modulbefehlen, nach Neustart derselbe Stand.

## Verweise

- ADR 0076 (Grundmodell, Ablauf = Serverless Workflow), 0081 (CloudEvents), 0086 (typisierte Speicherung), 0091 (KI über Bot-Platz), 0101 (Arten von Objekten), 0103 (Lauf, Bahn, Zustände), 0104 (Verträge statt Modulversionen, Befehlsketten), 0105 (Ebenen, Sichten, Hilfe), 0106 (fs-notification).
