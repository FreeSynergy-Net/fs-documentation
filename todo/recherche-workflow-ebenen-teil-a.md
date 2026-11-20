# Recherche Workflow-Ebenen, Teil A (berichtigt): Workflow Patterns gegen unsere DSL

Notiz zu ADR 0105 (E1a). Ersetzt die Erstfassung des Koordinators (interner Arbeitsordner, nicht veröffentlicht) vom 2026-11-20, deren Musternamen aus dem Gedächtnis stammten. Stand: 2026-11-20, Prüflauf gegen die abgerufenen Quellen.

**Quellen:**
- Workflow Patterns Initiative, http://workflowpatterns.com/ (nur http; das https-Zertifikat schlägt fehl). Vollständige Liste (129 Einzelseiten: 43 Ablauf WCP, 40 Daten WDP, 43 Ressourcen WRP, 3 Ausnahme-Seiten): interne Mustertabelle des Koordinators (nicht veröffentlicht), Seiten wie unten adressierbar. Adresse einer Seite: `http://workflowpatterns.com/patterns/<familie>/<gruppe>/<id>.php`, z. B. `…/patterns/control/basic/wcp1.php`; Ausnahmen: `…/patterns/exception/exceptiontypes.php`, `exception_workitemlevel.php`, `exception_caselevel.php`.
- Serverless Workflow DSL Reference (`dsl-reference.md`, GitHub `serverlessworkflow/specification`), Text interner Textabzug des Koordinators (nicht veröffentlicht) (= DSL:Zeile). Aufgabenarten: Call, Do, Emit, For, Fork, Listen, Raise, Run, Set, Switch, Try, Wait (DSL:265-278). Beispiele tragen `dsl: '1.1.0'`, unsere Dateien `1.0.3`: ob jedes Feld schon in 1.0.3 steht, ist **[nicht belegt]**.
- Unsere DSL: `fs-release/workflows/*.yaml`.

## 1. Was unsere Dateien tatsächlich nutzen (nachgeprüft)

| Element | Beleg | Muster |
|---|---|---|
| `do` | entscheidung.yaml:9 | WCP1 Sequence |
| `call` + `with` | entscheidung.yaml:11-13 | WDP15/16 Task ↔ Environment |
| `export.as` → `$context` | entscheidung.yaml:14-15 | WDP5 Case Data, WDP9 Task to Task |
| `if` | entscheidung.yaml:58, 67 | WDP35 Task Precondition - Data Value, WRP33 Skip |
| `run.workflow` | entscheidung.yaml:50-54 | WCP22 Recursion, WDP10/11 |
| `switch` + `then` | geruest-ausbau.yaml:82-90 | WCP4 Exclusive Choice, WCP10 Arbitrary Cycles, WDP40 |
| `fork` mit `compete: false` | programm-grundgeruest.yaml:23-24, 187-188 | WCP2 Parallel Split + WCP3 Synchronization |
| `for` mit `each`/`in` | koordinator-runde.yaml:152-153; stil-neu.yaml:135-136 | WCP13/14 (nacheinander) |
| `listen.to.all` | release-flow.yaml:211-213 | Warten auf mehrere Ereignisse (WDP38) |
| `schedule.on.any` | catalog-bump.yaml:11-15 | WCP23 Transient Trigger (Auslöser des ganzen Ablaufs) |
| `try`/`catch`/`timeout` | testlauf.yaml:192-209; upstream-update.yaml:215-233 | Ausnahme: Work Item Failure, Deadline Expiry |
| `emit` | catalog-bump.yaml:40, 62; release-flow.yaml:183 | WDP15 Task to Environment - Push |

**Nicht genutzt:** `retry` (kein `retry:`-Schlüssel in `workflows/*.yaml`; anbieter-neuinstallation.yaml:150 ist ein `switch`-Fall namens „retry“, Z. 142-152, Rücksprung = WCP10/WRP34-artig), `raise`, `while`, `listen.to.any`, `fork.compete: true`. `wait: all` (koordinator-runde.yaml:181, 366) ist ein Argument unter `with` eines `call` (collect-agent-reports), kein DSL-Konstrukt. `schedule` in server-einrichtung.yaml:240 ist ein Schrittname.

FS-Metadaten (`freesynergy.net:*`, README.md:3-12): `actor`, `actor-type`, `gate`, `kind`, `summary`, `adr`, `phase`. Kein Feld für Rolle, Fähigkeit, Zeit, Ressource, Kosten.

## 2. Lückenliste (gedeckt | teilweise | fehlt)

Die vollständige Tabelle mit allen 129 Nummern, Namen und Gruppen steht in ADR 0105, E1a. Hier nur die Zählung (Bewertung gegen die DSL, nicht gegen unsere Nutzung):

| Familie | gedeckt | teilweise | fehlt |
|---|---|---|---|
| Ablauf WCP1-43 | WCP1-5, 11, 21, 22, 43 | WCP6, 7, 10, 13, 14, 16, 19, 20, 23, 24, 29 | WCP8, 9, 12, 15, 17, 18, 25-28, 30-42 |
| Daten WDP1-40 | WDP1, 5, 9-11, 15-18, 27-29, 32, 33, 35, 38, 40 | WDP2, 4, 8, 12, 13, 19-26, 34, 36, 37 | WDP3, 6, 7, 14, 30, 31, 39 |
| Ressourcen WRP1-43 | WRP11 | WRP1, 28, 32, 33, 34 | alle übrigen (Vorschläge `role`, `needs`, `separate-from` in ADR 0105 E1) |
| Ausnahme-Arten | Work Item Failure, Deadline Expiry | External Trigger, Constraint Violation | Resource Unavailability |
| Am Arbeitsschritt (15) | SCE, SRS, SFF, SFC | – | OCO, ORO, OFF, OFC, ACA, ARA, ARO, AFF, AFC, SRA, SRO |
| Am Fall | CWC | RCC | RAC |

## 3. Berichtigte Gedächtnisfehler der Erstfassung

1. Synchronization „gedeckt durch `wait: all`“: falsch, `wait: all` ist ein Aufruf-Argument; gedeckt ist WCP3 durch `fork` (compete: false).
2. Simple Merge „teilweise“: gedeckt (gemeinsames `then`-Ziel, DSL:1323).
3. Implicit Termination „gedeckt durch `then: end`“: vertauscht. `end` ist WCP43 Explicit Termination (DSL:1321); WCP11 Implicit = `continue` am Ende (DSL:1320). Explicit war als „teilweise“ geführt: gedeckt.
4. Structured Loop „teilweise per `switch`“: in der DSL gedeckt (`for` + `while`, DSL:716); unsere Dateien nutzen nur `for`.
5. Recursion „[nicht belegt]“: gedeckt (`run.workflow`, DSL:274).
6. Deferred Choice „fehlt“: teilweise (`listen.to.any`, DSL:2153, dann `switch`); bei uns ungenutzt.
7. Cancel Task/Case/Region „teilweise durch `timeout`“: `timeout` ist die Ausnahme Deadline Expiry, kein Abbruch. WCP19/20 teilweise (nur Lebenszyklus-Ereignisse, DSL:1433, 1616); WCP25 Cancel Region fehlt.
8. Blocking/Cancelling Discriminator gemeinsam „fehlt“: WCP29 Cancelling Discriminator teilweise (`fork.compete`, DSL:754), WCP28 fehlt.
9. „MI ohne Synchronisation teilweise“: WCP12 fehlt (`for` läuft nacheinander).
10. Daten „Workflow-Kontext gedeckt durch `$context`“: `$context` ist WDP5 Case Data (je Lauf); WDP7 Workflow Data (für alle Fälle, wp-pages/patterns_data_visibility_wdp7.php:185) fehlt.
11. Daten „Übergabe an Umgebung teilweise (`.input`)“: WDP15-18 gedeckt (`call`, `emit`/`listen`).
12. „`raise`, `while`, `schedule`: 22 Treffer“: als Schlüssel 0× `raise`, 0× `while`; `schedule` 1× als Auslöser (catalog-bump.yaml:11).
13. Ausnahme „Gesamtabbruch nur über `timeout`“: remove current case RCC teilweise über `exit`/`end`.
14. Musternummern fehlten ganz; jetzt alle mit WCP/WDP/WRP-Nummer und Adresse.

## 4. Weiter [nicht belegt]

- Wiederherstellungs-Seite http://workflowpatterns.com/patterns/exception/recoveryaction.php (nicht abgerufen).
- Stand der DSL-Felder in 1.0.3 gegenüber den 1.1.0-Beispielen der Referenz.
- ValueFlows `inputOf`/`outputOf` (valueflo.ws nicht abgerufen); Abschnitt 4 der Erstfassung (ValueFlows-Abbildung aus ADR 0076 Z. 15-26) bleibt dort unverändert gültig, soweit er sich auf ADR 0076 stützt.
