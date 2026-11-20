# 0105 – Workflow-Ebenen, Prozess-Sichten, Hilfe anfordern: vier Ebenen je Schritt, eine Quelle mit mehreren Sichten, Hilfe als Pflichtteil des Gerüsts

Status: **Entwurf** (2026-11-20; Workflow `adr-write`, Schritt `draft`; überarbeitet im Schritt `work-in` am 2026-11-20: Antworten des Nutzers zu Frage 88–90 eingearbeitet, Muster- und DSL-Aussagen gegen die abgerufenen Quellen geprüft; Grundlage: vier Recherche-Berichte vom 2026-11-20, siehe „Quellen“; Prüfung durch Opus und Entscheide des Nutzers stehen aus) · **konkretisiert** ADR 0076 Zeile 18, 21–24 und Regel 1 (ValueFlows-Begriffe als Felder je Schritt) · **baut auf** ADR 0103 (Lauf, Station, Bahn = Achse Y) und ADR 0104 E9 (Befehlsketten sind Workflows) · **konkretisiert** ADR 0097 N6 („Hilfe als Wiki“) und den Pflicht-Hilfe-Eintrag (0097 Z. 26, Meilenstein M2) · **verwendet** ADR 0054 (KI markiert), 0091 (KI nur über Bot-Platz), 0087 Nr. 5 (Helpdesk ist eine Suite), 0037 (Ordner = Gruppe), 0073 Nr. 8 (Planungsdaten berechnet, nicht gespeichert), 0013 (nichts kopieren), 0081 (CloudEvents)

**Nummer:** **0105**. Herleitung: `conventions/decisions/` auf dem Zweigstand (aus main, Kopf d1d7315d) endet bei `0104-moduldaten-gehoeren-dem-modul.md`.

**Sprache:** nur Deutsch, wie alle ADRs im Repo.

**Lesehinweis:** Jede Aussage, die nicht aus einer abgerufenen Quelle oder einer Datei mit Zeilennummer stammt, ist mit **[nicht belegt]** markiert. Seit dem Schritt `work-in` liegen zwei Quellen als Text vor und sind hier mit Zeilen zitiert:
- **DSL** = `.scratch/recherche-workflow-ebenen/sw-dsl-reference.md` (Volltext `dsl-reference.md` aus GitHub `serverlessworkflow/specification`). **Achtung:** die Beispiele dort tragen `dsl: '1.1.0'` (z. B. DSL:760), unsere Dateien `dsl: 1.0.3`. Ob jedes zitierte Feld schon in 1.0.3 steht (vor allem `fork.compete`, DSL:754), ist **[nicht belegt]**.
- **WP** = `.scratch/recherche-workflow-ebenen/wp-control.txt`, `wp-data.txt`, `wp-resource.txt`, `wp-exception.txt` (Seiten von workflowpatterns.com als Text, mit den Papier-Verweisen); dazu **WP-Liste** = `.scratch/recherche-workflow-ebenen/wp-pattern-liste-vollstaendig.tsv` (alle 129 Einzelseiten mit Nummer und Name: 43 Ablauf WCP, 40 Daten WDP, 43 Ressourcen WRP, 3 Ausnahme-Seiten) und die Einzelseiten in `wp-pages/`. Adresse einer Einzelseite: `http://workflowpatterns.com/patterns/<familie>/<gruppe>/<id>.php` (nur **http**; das https-Zertifikat schlägt fehl), z. B. `http://workflowpatterns.com/patterns/control/basic/wcp1.php`; die Gruppen stehen in E1a je Tabellenzeile.

Weiter **[nicht belegt]** (keine Quelle im Lauf): RFC 9253 in JSCalendar, ValueFlows `inputOf`/`outputOf`, BPMN-Lanes, CMMN-Begriffe, die Wiederherstellungs-Seite der Ausnahme-Muster (`recoveryaction.php`, nicht abgerufen). Die Liste „Quellen zum Nachprüfen“ am Ende nennt, was vor der Annahme noch zu prüfen ist.

Echte Wahlmöglichkeiten für den Nutzer sind als **ENTSCHEIDUNG (Nutzer):** markiert, mit Optionen und Empfehlung.

---

## Kontext

Drei Punkte der Checkliste hängen zusammen: „Workflows in drei Ebenen“, „Prozesse darstellen“ und „Hilfe anfordern“. Dazu kommen „Planungs-Components“ und „Workflow-/Ablauf-Darstellung von Blinc“.

Bestand (belegt in den Berichten, Teil A–D):

1. **Unsere Abläufe** sind Serverless Workflow 1.0 (`dsl: 1.0.3`) mit FS-Profil, 59 Dateien in `fs-release/workflows/` (README.md:3-12). Genutzt werden `do`, `call`/`with`, `export.as` mit `$context`, `if`, `run.workflow`, `switch`/`then`, `set`, `for`, `fork`, `try`/`catch`/`timeout`, `retry`, `listen`, `emit` (Teil A, Tabelle 1, je mit Datei:Zeile). Die Dateien sind **Beschreibung**, nicht ausführbar (README.md:9-12; testlauf.yaml:1-2 „SPECIFICATION, NOT RUNNABLE“).
2. **Metadaten je Schritt** sind nur `actor` (human/ai/machine), `actor-type` (Person/Application/Service), `gate`, `kind` (objective/subjective), dazu `summary`, `adr`, `phase`. Eine Suche nach `resource|role|skill|time|deadline|cost|budget|capacity` in allen aktiven Flows ergab **0 Treffer** (Teil A, Abschnitt 1).
3. **ADR 0076** legt das Grundmodell fest: REA/ValueFlows; Zeit und Fähigkeiten von Akteuren sind Ressourcen (Z. 18, Regel 1 Z. 30); Ablauf = Serverless Workflow + ValueFlows `Recipe`/`Process` (Z. 23); Ereignis = `EconomicEvent` in fs-history (Z. 24); Ziel ≠ Ablauf (Regel 5, Z. 34); jedes Programm bekommt eine Workflow-Ansicht (Z. 50).
4. **ADR 0103** (Entwurf): die Lebenszustände gehören dem **Lauf**, der Workflow besitzt nur Stationen und Übergänge; Board mit Achse X (Spalten) und Achse Y (Bahn = Swimlane); Lauf-Typ im Modul `fs-flow`.
5. **ADR 0073 Nr. 8**: Planungsdaten (frühester Start, Puffer, kritischer Pfad, Gantt-Termine) werden **berechnet statt gespeichert**; das Gantt rechnet „nominal“ und sagt das sichtbar.
6. **Komponenten**: `fs-components-timeline` hat Balken, Meilenstein, Fortschritt, Ende→Anfang-Pfeile, Zoom, Heute-Linie; nicht: Ziehen, Start→Start/Ende→Ende, Verzögerung, kritischer Pfad, Gruppen (Teil C, Abschnitt 5, DESIGN.md:47-49). `fs-components-kanban` hat Spalten, keine Zeilen. In fs-components gibt es keinen Knoten-/Flow-Graphen (Teil C, Abschnitt 6). **Blinc hat einen** im eigenen Repo `project-blinc/blinc_node_editor` (Nutzerantwort 88; siehe E4); die Inventur in Teil C hatte nur den Checkout `/srv/FreeSynergy/blinc` durchsucht.
7. **Hilfe**: ADR 0097 verlangt je Programm einen Hilfe-Eintrag mit Inhalt oder sichtbarem Rückfall (Z. 26) und ordnet das Hilfe-Modul der Hülle M2 zu (Z. 35); N6 heißt „Hilfe als Wiki“ (Z. 7). Die Ideen des Nutzers vom 20.11. stehen in der Checkliste (Teil D, D1, 12 Punkte). Auf main in `fs-blueprint` gibt es keinen `help`-Eintrag; der Zweig `scaffold-e5` hat einen `[[help]]`-Eintrag mit `topic` und Text de/en (Teil D, D3; Zweig nicht geprüft).

Lücken (Teil A, Abschnitt 6, gekürzt): kein Ressourcen- und Zeitmodell; `actor: ai` ohne Bot-Platz (ADR 0091); keine Rollen/Zuteilung; Joins nur „alle“; keine Wahl zwischen Ereignissen; kein Abbruch eines Falls; keine Kompensation; Daten nur flach.

---

## Entscheidung

### E1. Vier Ebenen je Schritt: Ablauf, Daten, Ressourcen, Ausnahme

Die Checkliste nennt drei Ebenen (Control, Data, Resource). Dieser Entwurf macht **vier** daraus und nimmt **Ausnahme** als eigene Ebene dazu. Grund (Logik, nicht Mode): Ausnahmen (Zeitgrenze, Fehler, Abbruch, Rückbau, Eskalation) schneiden quer durch die drei anderen Ebenen; als Teil der Ablauf-Ebene würden sie in jeder Verzweigung wiederholt, als eigene Ebene stehen sie einmal je Bereich. Die Einteilung in Ablauf-, Daten-, Ressourcen- und Ausnahme-Muster folgt der Workflow Patterns Initiative, die genau diese vier Sammlungen führt (WP: wp-exception.txt:31-34 Menü „Workflow Patterns / Data Patterns / Resource Patterns“ und „Exception Handling Patterns“ Z. 37). Papiere: Kontrollfluss Russell, ter Hofstede, van der Aalst, Mulyar, BPM Center Report BPM-06-22, 2006, auf Grundlage von van der Aalst, ter Hofstede, Kiepuszewski, Barros 2003 (wp-control.txt:39-49); Daten Russell, ter Hofstede, Edmond, van der Aalst, QUT FIT-TR-2004-01 (wp-data.txt:39-43); Ressourcen dieselben, BETA WP 127, TU Eindhoven 2004 (wp-resource.txt:39-43); Ausnahmen Russell, van der Aalst, ter Hofstede, BPM-06-04, 2006 (wp-exception.txt:39-43). Die Ausnahme-Sammlung ist dort eine **eigene** Sammlung neben den drei anderen; das stützt die vierte Ebene.

| Ebene | Frage | Unser Mittel heute (belegt) | ValueFlows (ADR 0076) | Lücke |
|---|---|---|---|---|
| **Ablauf** (Control Flow) | In welcher Reihenfolge? | `do`, `switch`/`then`, `fork`, `for`, `if`, `run.workflow`, `listen` | `Process` / `Recipe` (die Flow-Datei) | Join „einer von n“, Wahl zwischen Ereignissen, Meilenstein-Wache |
| **Daten** | Was geht von Schritt zu Schritt? | `export.as` → `$context`, `${…}`-Ausdrücke, `.input` | Ein- und Ausgaben eines `Process` **[nicht belegt]**: ValueFlows-Begriffe `inputOf`/`outputOf` aus dem Gedächtnis | Gültigkeitsbereich je Block/Fall; Verweis statt Kopie |
| **Ressourcen** | Wer und womit? | `actor`, `actor-type`, `gate` | `Agent` (fs-people/fs-groups), `EconomicResource` inkl. Zeit und Fähigkeit (fs-resources), `Commitment` (fs-tasks) | Rolle, Fähigkeit, Zeitbedarf, Bot-Platz, Zuteilung, Trennung der Pflichten |
| **Ausnahme** | Was, wenn es schiefgeht? | `try`/`catch`, `timeout`, `retry`, Rücksprung zu `eskalation` | `EconomicEvent` hält fest, was passiert ist (fs-history, unveränderlich) | Abbruch eines Falls/Bereichs, Kompensation (Rückbau) |

Regeln:

1. **Die Ebenen sind Felder am Schritt, keine vier Dateien.** Ein Schritt bleibt ein Serverless-Workflow-Schritt; die Ressourcen-Ebene kommt als FS-Metadaten dazu (Präfix `freesynergy.net:`, wie heute). Grund: eine Datei je Ablauf hält Ablauf und Zuständigkeit zusammen; getrennte Dateien laufen auseinander (ADR 0076 Abschnitt 2, „eine Wahrheit“).
2. **Ressourcen-Felder (Vorschlag, Namen vorläufig):**
   - `freesynergy.net:role` – Rolle statt Person (Zuteilung über fs-groups-Rollen; ADR 0103 E7 `ClaimRule`).
   - `freesynergy.net:needs` – benötigte Fähigkeiten/Ressourcen als Verweise auf fs-resources (ValueFlows `EconomicResource`).
   - `freesynergy.net:effort` – geschätzter Aufwand im **Maß** aus ADR 0103 (nicht USD, nicht Stunden fest).
   - `freesynergy.net:bot-seat` – Pflicht, wenn `actor: ai`: Verweis auf den Bot-Platz (ADR 0091 E1/E2). Ein `ai`-Schritt ohne Bot-Platz ist ein **Prüffehler** in `check_workflows.py`, kein Hinweis. Grund: ADR 0091 erlaubt der KI keinen anderen Weg; eine Lücke dort ist eine Sicherheitslücke (Teil A, Lücke 2).
   - `freesynergy.net:separate-from` – Trennung der Pflichten: dieser Schritt darf nicht vom Akteur eines genannten Schritts erledigt werden (z. B. Bauer ≠ Prüfer).
3. **Ausnahme-Ebene (Vorschlag):**
   - **Abbruch eines Falls** heißt im Lauf `abgebrochen` (ADR 0103 E2); der Workflow braucht dafür kein neues Konstrukt, nur eine Regel „wer darf abbrechen“.
   - **Kompensation**: ein Schritt darf `freesynergy.net:compensate: <schritt>` nennen; bei Abbruch nach diesem Schritt läuft der Rückbau-Schritt. Grund: ohne Rückbau bleiben halbe Zustände (z. B. Tag gesetzt, Release nicht gebaut). Die DSL hat **kein** Kompensations-Konstrukt: die Pflicht-Aufgabenarten sind Call, Do, Fork, Emit, For, Listen, Raise, Run, Switch, Set, Try, Wait (DSL:265-278); `try`/`catch` fängt nur Fehler und kann danach Aufgaben ausführen (DSL:1231-1288); das Wort „compensat…“ kommt im Volltext nicht vor (Suche, 0 Treffer). Darum bleibt das FS-Feld. `catch.do` ist der Ort, an dem der Rückbau-Schritt aufgerufen wird.
   - **Abbruch** kennt die DSL nur als Lebenszyklus-Ereignis („Workflow Cancelled“ DSL:1433-1448, „Task Cancelled“ DSL:1616-1633), nicht als Aufgabe; `then: exit|end` beendet Bereich bzw. Ablauf geordnet (DSL:1320-1322). Der Abbruch von außen ist damit Sache des Laufs (`fs-flow`), wie oben.
   - **Eskalation an den Menschen** bleibt `switch` → Schritt mit `gate: human` (heute belegt, README.md:52-55).
4. **Ablauf-Lücken werden nur nach Bedarf geschlossen.** Structured Discriminator (WCP9), Partial Join (WCP30-32), Deferred Choice (WCP16) und Milestone (WCP18) (Namen und Nummern: wp-control.txt:101-139, 188-193): sie kommen erst, wenn ein echter Ablauf sie braucht, und dann zuerst mit Mitteln der DSL: `fork.compete: true` (ein Gewinner, DSL:754) bzw. `listen.to.any` (DSL:2153) mit anschließendem `switch`. Vollständige Liste: E1a.
5. **Ereignisse**: jeder abgeschlossene Schritt eines Laufs erzeugt ein `EconomicEvent` bzw. eine AS2-Aktivität in fs-history (ADR 0076 Z. 24, 0103 E7 `Move`); nach außen als CloudEvent (ADR 0081). Der Workflow schreibt dafür nichts selbst; das macht der Lauf (`fs-flow`).

**ENTSCHEIDUNG (Nutzer) 1: Drei oder vier Ebenen?**
- A: drei Ebenen wie in der Checkliste; Ausnahmen gehören zur Ablauf-Ebene.
- B: vier Ebenen, Ausnahme eigenständig (wie oben).
- **Empfehlung: B**, weil Abbruch, Rückbau und Eskalation in jedem Zweig gleich gelten und sonst je Zweig kopiert würden.

**ENTSCHEIDUNG (Nutzer) 2: Wie streng ist `bot-seat`?**
- A: Prüffehler (rot) in `check_workflows.py`, sobald `actor: ai` ohne `bot-seat`.
- B: zuerst Warnung, rot ab dem nächsten Workflow-Release.
- **Empfehlung: B** mit festem Datum, weil heute alle `ai`-Schritte (u. a. entscheidung.yaml:30-31) das Feld nicht haben und sonst alle Flows auf einmal rot würden.

### E1a. Muster-Lückenliste (neu gegen die Quellen, ersetzt die Liste aus dem Gedächtnis)

Bewertung je Musterfamilie gegen die DSL (Datei:Zeile) und unsere `freesynergy.net:*`-Metadaten (heute: `actor`, `actor-type`, `gate`, `kind`; Vorschläge aus E1 kursiv). **gedeckt** = direkt ausdrückbar; **teilweise** = nur mit Umweg oder nur Laufzeit-Ereignis; **fehlt** = kein Mittel. Musternamen und -nummern aus WP. Ob eine Laufzeit die Semantik genau so ausführt, ist nicht Teil dieser Liste (unsere Dateien sind Beschreibung, README.md:9-12).

**Ablauf (wp-control.txt):**

Namen und Nummern genau wie in der WP-Liste (WCP = Ablauf, WDP = Daten, WRP = Ressourcen; die Nummern zählen je Familie getrennt). Spalte „Gruppe“ = Pfadteil der Adresse, z. B. WCP29 = `http://workflowpatterns.com/patterns/control/new/wcp29.php`.

| Familie (Gruppe) | gedeckt | teilweise | fehlt |
|---|---|---|---|
| Basis (`control/basic`) | WCP1 Sequence (`do`, DSL:268), WCP2 Parallel Split + WCP3 Synchronization (`fork`, Ergebnis aller Zweige, DSL:754), WCP4 Exclusive Choice (`switch`, DSL:275), WCP5 Simple Merge (gemeinsames `then`-Ziel, DSL:1323) | – | – |
| Verzweigen (`control/advanced_branching`, WCP6-9; dazu `control/new`) | – | WCP6 Multi-Choice (`fork` + `if` je Zweig, DSL:284), WCP7 Structured Synchronizing Merge (übersprungene Zweige gelten als erledigt, DSL:284), WCP29 Cancelling Discriminator (`fork.compete`, ein Gewinner, DSL:754; ob die Verlierer abgebrochen werden, sagt die Stelle nicht) | WCP8 Multi-Merge, WCP9 Structured Discriminator, WCP28 Blocking Discriminator, WCP30 Structured / WCP31 Blocking / WCP32 Cancelling Partial Join, WCP33 Generalized AND-Join, WCP37 Local / WCP38 General Synchronizing Merge, WCP41 Thread Merge, WCP42 Thread Split |
| Mehrfach-Instanzen (`control/multiple_instance`, WCP12-15; dazu `control/new`) | – | WCP13 … with a priori Design-Time Knowledge, WCP14 … with a priori Run-Time Knowledge (`for` über eine Sammlung, DSL:705-717; nacheinander, keine Gleichzeitigkeit genannt) | WCP12 Multiple Instances without Synchronization, WCP15 … without a priori Run-Time Knowledge, WCP34 Static / WCP35 Cancelling / WCP36 Dynamic Partial Join for Multiple Instances |
| Zustandsbasiert (`control/state`, WCP16-18; dazu `control/new`) | – | WCP16 Deferred Choice (`listen.to.any`, DSL:2153, danach `switch`) | WCP17 Interleaved Parallel Routing, WCP18 Milestone (Kandidat: Lauf-Zustand aus ADR 0103), WCP39 Critical Section, WCP40 Interleaved Routing |
| Abbruch (`control/cancellation`, WCP19-20; dazu `control/new`) | – | WCP19 Cancel Task / WCP20 Cancel Case (nur Lebenszyklus-Ereignisse DSL:1433, 1616; Lauf `abgebrochen`, ADR 0103 E2) | WCP25 Cancel Region, WCP26 Cancel Multiple Instance Task, WCP27 Complete Multiple Instance Task |
| Wiederholung (`control/new`, `control/structural`) | WCP21 Structured Loop (`for` + `while`, DSL:716), WCP22 Recursion (`run.workflow`, DSL:274) | WCP10 Arbitrary Cycles (`then: <name>`, nur im eigenen Bereich, DSL:1326) | – |
| Ende (`control/structural`, `control/new`) | WCP11 Implicit Termination (`continue` am Ende, DSL:1320), WCP43 Explicit Termination (`end`/`exit`, DSL:1321-1322) | – | – |
| Auslöser (`control/new`) | – | WCP23 Transient / WCP24 Persistent Trigger (`listen`; Warteschlange nur bei `foreach`, DSL:803) | – |

**Daten (wp-data.txt; Nummern aus der WP-Liste):**

| Familie (Gruppe) | gedeckt | teilweise | fehlt |
|---|---|---|---|
| Sichtbarkeit (`data/visibility`, WDP1-8) | WDP1 Task Data (`input`/`output`, DSL:285-286), WDP5 Case Data (`export` → `$context`, DSL:287, 2318) | WDP2 Block Data, WDP4 Multiple Instance Data (`for.each`/`for.at`, DSL:713-715), WDP8 Environment Data (nur über `call`, DSL:267) | WDP3 Scope Data, WDP6 Folder Data, WDP7 Workflow Data (Daten für **alle** Fälle eines Ablaufs, wp-pages/…wdp7.php:185; `$workflow` gilt nur je Lauf, DSL:380) |
| Interaktion innen (`data/internal`, WDP9-14) | WDP9 Task to Task, WDP10 Block Task to Sub-Workflow Decomposition, WDP11 Sub-Workflow Decomposition to Block Task (`run.workflow`) | WDP12 To / WDP13 From Multiple Instance Task (`for`) | WDP14 Case to Case |
| Interaktion außen (`data/external`, WDP15-26) | WDP15 Task to Environment - Push, WDP16 Environment to Task - Pull, WDP17 Environment to Task - Push, WDP18 Task to Environment - Pull (`call`, DSL:267; `emit`/`listen`, DSL:270-272) | WDP19-22 Case ↔ Environment, WDP23-26 Workflow ↔ Environment (nur über Ereignisse) | – |
| Übergabe (`data/mechanisms`, WDP27-33) | WDP27/28 Data Transfer by Value - Incoming/Outgoing, WDP29 Copy In/Copy Out, WDP32/33 Data Transformation - Input/Output (`input`/`output`, DSL:2251, 2287) | – | **WDP30 Data Transfer by Reference - Unlocked, WDP31 … - With Lock** (ADR 0013 „nichts kopieren“ verlangt Verweise: Lücke für uns wichtig) |
| Datenbasiertes Routing (`data/routing`, WDP34-40) | WDP35 Task Precondition - Data Value (`if`, DSL:284), WDP38 Event-Based Task Trigger (`listen`), WDP40 Data-Based Routing (`switch`) | WDP34 Task Precondition - Data Existence, WDP36/37 Task Postcondition - Data Existence/Value (`output`-Schema, DSL:2345) | WDP39 Data-Based Task Trigger |

**Ressourcen (wp-resource.txt; Nummern aus der WP-Liste):**

| Familie (Gruppe) | gedeckt | teilweise | fehlt → Vorschlag |
|---|---|---|---|
| Erzeugen (`resource/creation`, WRP1-11) | WRP11 Automatic Execution (`actor: machine`) | WRP1 Direct Distribution (`actor` nennt nur die Art, keine Person) | WRP2 Role-Based Distribution → *`role`*; WRP8 Capability-Based Distribution → *`needs`*; WRP5 Separation of Duties → *`separate-from`*; WRP4 Authorization → Rechte je Programm (ADR 0103 E7 `ClaimRule`); WRP3 Deferred Distribution, WRP6 Case Handling, WRP7 Retain Familiar, WRP9 History-Based, WRP10 Organisational Distribution: offen |
| Push (`resource/push`, WRP12-20) / Pull (`resource/pull`, WRP21-26) | – | – | alle (u. a. WRP12-14 Distribution by Offer/Allocation, WRP15 Random, WRP16 Round Robin Allocation, WRP17 Shortest Queue, WRP21 Resource-Initiated Allocation, WRP26 Selection Autonomy); gehören zum Lauf und zum Board (`fs-flow`, fs-tasks), nicht zur Ablauf-Datei |
| Umleiten (`resource/detour`, WRP27-35) | – | WRP28 Escalation (`switch` → `gate: human`, README.md:52-55), WRP32 Suspension/Resumption (nur Ereignisse DSL:1357, 1556), WRP33 Skip (`if`, DSL:284), WRP34 Redo (nur `retry` nach Fehler, DSL:2201) | WRP27 Delegation, WRP29 Deallocation, WRP30 Stateful / WRP31 Stateless Reallocation, WRP35 Pre-Do |
| Selbststart (`resource/autostart`, WRP36-39) / Sichtbarkeit (`resource/visibility`, WRP40-41) | – | – | alle: WRP36 Commencement on Creation, WRP37 … on Allocation, WRP38 Piled, WRP39 Chained Execution, WRP40/41 Configurable Unallocated/Allocated Work Item Visibility (Lauf/Board) |
| Mehrere Ressourcen (`resource/multiple_resources`, WRP42-43) | – | – | WRP42 Simultaneous Execution, WRP43 Additional Resources → *`needs`* mit mehreren Einträgen |

**Ausnahmen (wp-exception.txt + Einzelseiten unter `http://workflowpatterns.com/patterns/exception/`):** Das Kapitel ist kein Nummern-Katalog, sondern drei Seiten mit benannten Arten und Übergängen:
- **Arten** (`exceptiontypes.php`, wp-pages/exception_exceptiontypes.html:185-193): Work Item Failure (`raise` DSL:830, `try`/`catch` DSL:1231) **gedeckt**; Deadline Expiry (`timeout` DSL:2381) **gedeckt**; External Trigger (`listen` als Abbruchgrund nur über Lebenszyklus-Ereignisse) **teilweise**; Constraint Violation (`output`-Schema DSL:2345) **teilweise**; Resource Unavailability **fehlt** (braucht die Ressourcen-Ebene).
- **Am Arbeitsschritt** (`exception_workitemlevel.php`, …workitemlevel.html:190-232, 15 Übergänge): continue-execution SCE (`catch` und weiter, DSL:1287-1288), restart SRS (`retry`, DSL:2201), force-fail SFF (Fehler nicht gefangen / `raise`), force-complete SFC (`catch.then` auf den Nachfolger) **gedeckt**; die Übergänge aus „angeboten“/„zugeteilt“ (OCO, ORO, OFF, OFC, ACA, ARA, ARO, AFF, AFC) und reallocate-s SRA / reoffer-s SRO **fehlen** (kein Angebot/keine Zuteilung in der Ablauf-Datei; gehören zu `fs-flow`).
- **Am Fall** (`exception_caselevel.php`, …caselevel.html:186-188): continue with case CWC **gedeckt** (`catch`); remove current case RCC **teilweise** (`exit`/`end` beendet den ganzen Lauf, keine Auswahl einzelner Schritte); remove all cases RAC **fehlt**.
- **Wiederherstellung/Kompensation** **fehlt** (E1 Regel 3); die Seite `recoveryaction.php` wurde nicht abgerufen, ihre Begriffe bleiben **[nicht belegt]**.

**Nutzung in unseren Dateien (`fs-release/workflows/*.yaml`, gegen die Familien geprüft):** `fork` mit `compete: false` (programm-grundgeruest.yaml:23-24, 187-188) = WCP2/WCP3; `listen.to.all` (release-flow.yaml:211-213) = Warten auf mehrere Ereignisse; `for` mit `each`/`in` (koordinator-runde.yaml:152-153, stil-neu.yaml:135-136) = WCP13/14; `schedule.on.any` als Auslöser des ganzen Ablaufs (catalog-bump.yaml:11-15) = WCP23; `retry` (anbieter-neuinstallation.yaml:150), `try`/`catch`/`timeout`, `emit`, `run.workflow`, `switch`/`then`. **Nicht** genutzt: `raise`, `while`, `listen.to.any` (WCP16), `fork.compete: true` (WCP29). `wait: all` (koordinator-runde.yaml:181, 366) ist ein Argument unter `with` eines `call` (collect-agent-reports), **kein** DSL-Konstrukt; `schedule` in server-einrichtung.yaml:240 ist ein Schrittname.

Folge: Die Lücken mit Vorrang sind Rolle, Fähigkeit, Trennung der Pflichten, Verweis statt Kopie und Kompensation; alles andere wartet auf einen echten Ablauf (E1 Regel 4).

### E2. Eine Quelle, mehrere Sichten

Für Prozesse und Pläne gibt es **je Frage eine Datenquelle** und daraus abgeleitete Sichten. Keine Sicht hat eigene Daten. Grund: zwei gespeicherte Fassungen desselben Ablaufs (z. B. YAML und BPMN-XML) laufen auseinander; mit einer Quelle gibt es keinen Abgleich.

| Quelle | Besitzer | Sichten daraus |
|---|---|---|
| **Ablauf** (Workflow-Datei, Stationen, Übergänge, Ebenen aus E1) | fs-workflows (bis dahin fs-release) | Ablauf-Graph, BPMN-Sicht (Bahnen = `actor`/`role`), Board-Spalten `WorkflowStationen` (ADR 0103 E6) |
| **Lauf** (Instanz: Zustand × Station, Aufenthalte) | `fs-flow` (ADR 0103 E5) | Board, Verlauf, Fall-Sicht (CMMN-artig) |
| **Ziele/Zusagen mit Abhängigkeiten** (JSCalendar Task + Relationen) | fs-tasks | Liste, Board, Gantt, Netzplan |

1. **Workflow-Sicht** (Ablauf-Graph): Knoten = Schritte mit `actor`, `gate`, `kind`; Kanten = `then`/Reihenfolge, Bedingung an der Kante. Pflicht nach ADR 0076 Z. 50.
2. **BPMN 2.0 nur als Sicht und als Austauschformat** (Import/Export), **kein** Speicherformat im Kern. Grund (Logik): BPMN-XML trennt Diagramm-Lage und Semantik und hat viele Elemente ohne Gegenstück in unserer DSL; als Speicher müssten wir beides pflegen. Als Sicht gewinnen wir die bekannte Darstellung (Pools/Lanes **[nicht belegt]** in der abgerufenen OMG-Seite) und den Austausch mit fremden Werkzeugen. **Import** übernimmt nur, was sich verlustfrei auf die DSL abbilden lässt; der Rest wird **sichtbar gemeldet**, nie still weggelassen (Regel „Fehlende Datenquelle melden“).
3. **Projektplan: Gantt und Netzplan** aus fs-tasks. Abhängigkeiten nach den Relationstypen aus **RFC 9253** (iCalendar Relationships): `FINISHTOSTART`, `FINISHTOFINISH`, `STARTTOFINISH`, `STARTTOSTART`, dazu Abstand (`GAP`, Vorlauf/Verzögerung) sowie `PARENT`/`CHILD`/`SIBLING`, `DEPENDS-ON`, `FIRST`/`NEXT` (Teil B, B3, abgerufen). Grund (Logik): die vier Abhängigkeitsarten plus Abstand decken die klassische Netzplantechnik ab; mit einer festen, öffentlichen Typliste können Plan, Import und Export dieselben Wörter nutzen, ohne eigenes Vokabular. **Achtung:** RFC 9253 erweitert iCalendar (RFC 5545), nicht JSCalendar (RFC 8984). Wie die Typen in JSCalendar `relatedTo` abgebildet werden, ist **[nicht belegt]**; bis zur Prüfung tragen wir die RFC-9253-Typwörter als Werte der Relation (Abbildung in einem Vorschlag für fs-jscalendar, nicht hier festgelegt).
4. **Planungsdaten werden berechnet** (frühester/spätester Start, Puffer, kritischer Pfad), nie gespeichert (ADR 0073 Nr. 8, unverändert). Zyklen nach einem Merge werden angezeigt, nicht abgelehnt (ebd.).
5. **CMMN-Sicht (Fallbearbeitung)**: ein Lauf mit offenen Menschen-Schritten (`gate: human`, `kind: subjective`, Wartegrund aus ADR 0103 E3) wird als **Fall** gezeigt: was ist offen, was ist erfüllt, was wartet worauf. CMMN 1.1 (OMG, 2016) ist als Standard belegt; die Begriffe Stage, Sentry, Milestone sind **[nicht belegt]** aus der abgerufenen Seite. Kein CMMN-Import/-Export in diesem Schritt.
6. **Bahn = Achse Y** (ADR 0103 E6) ist dieselbe Idee wie die BPMN-Lane: im Ablauf-Graph und im Board wird nach `actor`/`role` gruppiert. Damit gibt es **ein** Wort („Bahn“) in allen Sichten.

**ENTSCHEIDUNG (Nutzer) 3: BPMN nur als Sicht oder auch als Speicher?**
- A: nur Sicht + Import/Export (wie oben).
- B: ein Prozesseditor speichert BPMN nativ, die DSL wird daraus erzeugt.
- **Empfehlung: A**, weil die ausführbare Wahrheit die DSL ist (ADR 0076 Z. 23) und B zwei Speicherformate mit Abgleich erzwingt.

**ENTSCHEIDUNG (Nutzer) 4: Netzplan jetzt oder später?**
- A: Gantt und Netzplan bleiben „später“ (ADR 0073 Nr. 8, todo/features/tasks.md:55).
- B: jetzt das **Datenmodell** (Relationstypen, Aufwand) festlegen, die Anzeige später.
- C: Datenmodell und Rechenkern (kritischer Pfad) jetzt, Anzeige über `fs-components-timeline` (Wrap).
- **Empfehlung: B**, weil das Datenmodell billig ist und später Migration spart (Daten dürfen heute noch weg); Rechenkern und Anzeige sind eigene Aufträge.

**ENTSCHEIDUNG (Nutzer) 5: Welche RFC-9253-Typen?**
- A: alle vier Abhängigkeitsarten + `GAP` + Eltern/Kind.
- B: nur `FINISHTOSTART` und `STARTTOSTART` + `GAP` zuerst.
- **Empfehlung: A im Datenmodell, B in der ersten Anzeige**, weil ein Typ, den das Modell nicht kennt, beim Import verloren ginge; die Anzeige kann schrittweise wachsen (heute nur Ende→Anfang, Teil C).

### E3. Hilfe anfordern ist Pflichtteil des Gerüsts

Jedes Programm hat neben dem Hilfe-Eintrag (ADR 0097 Z. 26) eine Funktion **„Hilfe anfordern“**. Sie gehört zur Hülle (M2, ADR 0097 Z. 35) und wird im Bauplan beschrieben, nicht je Programm programmiert.

Regeln (aus den Nutzerideen vom 20.11., Teil D, D1; Konflikte mit ADRs aufgelöst oder als Entscheidung markiert):

1. **Fragen stellt ein Mensch.** Antworten kommen von Menschen, von einer KI **nur über einen Bot** und gekennzeichnet (ADR 0054, 0091), oder von beiden. Ein Bot schreibt und antwortet, wenn er **eingeladen** ist und die **Rechte** dafür hat (E3a, Nutzerantwort 90).
2. **Ein Hilfe-Kanal je Programm** als Ordner in fs-messages; Ordner = Gruppe (ADR 0037). In fs-messages auf Wunsch zusammen angezeigt.
3. **Herkunft ist fest an der Frage** (Programm, Version) und nicht änderbar. fs-messages filtert danach.
4. **Hilfe erscheint nie in broadcast.** broadcast abonniert nur seinen eigenen Ordner. Die Trennung ist ein Pflichttest, kein Filter-Standard.
5. **Kontext-Paket** (Programm, Version, Ansicht, Fehler, Bild nur geschwärzt) wird **vor dem Senden gezeigt und ist änderbar**. Geheimes oder Sensibles kommt nie hinein; Prüfung über einen Kanarien-Test (eingesetzter Prüfwert darf im Paket nie auftauchen).
6. **Stufen**: eigene Gruppe → Gemeinschaft → Entwickler (Issue; später Helpdesk). Die nächste Stufe wählt der Mensch; Senden an Entwickler/Upstream erst nach Freigabe (`gate: human`, wie `upstream-anfrage`).
7. **Innen AS2, außen Adapter** (fs-messages, Matrix, XMPP, E-Mail). Ein Adapter ohne Ende-zu-Ende-Verschlüsselung wird sichtbar markiert (ADR 0054 Z. 53, 58).
8. **Zustände** `offen`, `beantwortet`, `gelöst` sind **Lauf-Zustände/Stationen eines Workflows** `hilfe-anfrage` (ADR 0103: Zustände gehören dem Lauf), keine eigene Zustandsliste im Programm.
9. **Gelöst + Zustimmung → Hilfetext** in fs-texts (ADR 0097 N6 „Hilfe als Wiki“; Helpdesk-Suite ADR 0087 Nr. 5).

Bauplan-Eintrag (Vorschlag, ergänzt `[[help]]` aus dem Zweig `scaffold-e5`, der dort nur `topic` und Text de/en hat; Zweig **nicht geprüft**): `origin` (fest), `channel`, `exclude_broadcast = true` (fest, nicht einstellbar), `protocols`, `context_fields`, `escalation` (`group` | `community` | `developer`, Standard `group`), `adapters` mit `e2e` je Adapter, `ki_answer` (nur mit Bot-Platz), `publish_text` (Zustimmung Pflicht), `workflow = "hilfe-anfrage"`, `fallback` (sichtbarer Rückfall nach ADR 0097).

Pflichttests (Vorschlag, nichts gebaut): Hilfe-Nachricht in broadcast unzustellbar; Kanarien-Wert nie im Paket; KI-Antwort ohne Kennzeichen unzustellbar (ADR 0054 Z. 57, 62); KI-Antwort ohne Einladung oder ohne Recht abgelehnt; Herkunft nach dem Senden unveränderbar; **Bot ändert eine eigene Einstellung oder ein eigenes Recht → abgelehnt** (E3a Regel 4, ohne Ausnahme); Bot liest eigene Rechte/Einstellungen → abgelehnt (E3a Regel 3); Bot verwaltet fremde Rechte ohne ausdrückliche Freigabe eines Menschen → abgelehnt, mit Freigabe → Warnung sichtbar und protokolliert (E3a Regel 5).

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11., Frage 90** (ersetzt die frühere offene ENTSCHEIDUNG 6 „Darf die KI in der Hilfe schreiben?“ und löst den Konflikt K1 aus Teil D, teil-D.md:39: Schreiben in fs-messages ist ein Programm-Recht des Bots, nicht ein fs-groups-Recht; die Grenze „in fs-groups höchstens `Read`“ aus ADR 0091 Z. 50 betrifft nur fs-groups und wird nur durch E3a Regel 5 berührt. K13, teil-D.md:51, Akteurstyp, bleibt ENTSCHEIDUNG 8; die Antwort stützt dort Option A, weil der Bot der Handelnde ist): Bots dürfen teilnehmen und schreiben bzw. antworten (fast immer), wenn sie eingeladen sind (z. B. in fs-messages) **und** die Rechte dafür haben. Ausgestaltung in E3a.

#### E3a. Rechte von Bots (Nutzerantwort 90)

1. **Teilnahme:** Ein Bot schreibt und antwortet in einer Situation (Unterhaltung, Hilfe-Kanal, Gruppe), wenn er dort **eingeladen** ist **und** das Recht dazu hat. Das ist der Normalfall, keine Ausnahme.
2. **Bot-Rechte sind Rollen-Rechte:** Rechte eines Bots werden **je Programm wie Rechte einer Rolle** vergeben und entzogen, von Menschen mit dem Recht dazu, mit denselben Mitteln wie für Rollen. Es gibt keinen eigenen Rechte-Weg für Bots.
3. **Kein Blick auf sich selbst:** Ein Bot darf seine **eigenen** Rechte und Einstellungen weder sehen noch ändern.
4. **Absolut:** Ein Bot ändert **nie seine eigenen** Einstellungen oder Rechte. Diese Sperre hat **keinen Schalter und keine Übersteuerung**, auch nicht durch einen Menschen oder Admin.
5. **Rechte verwalten nur auf ausdrücklichen Wunsch:** Will ein Mensch ausdrücklich, dass ein Bot Rechte (anderer) verwaltet, ist das erlaubt, mit einer **deutlichen Warnung** vor der Freigabe; die Freigabe wird protokolliert (AS2-Aktivität wie ADR 0091 Nr. 12). Regel 4 gilt trotzdem: auch ein verwaltender Bot ändert nie sich selbst.
6. Unverändert aus ADR 0091: KI nur über einen Bot, markiert, Protokoll „Bot X, gesteuert von KI Y, beauftragt von Z“ (0091 Nr. 12), STOP KI/Notaus, kein Bot auf dem Einzelplatz (0091 Nr. 11).

#### Nachtrag-Text zu ADR 0091 (zur Übernahme in einem eigenen Doku-Lauf; hier nur der Wortlaut)

> **Nachtrag (2026-11-20, aus ADR 0105 E3a, Nutzerantwort 90): Bot-Rechte = Rollen-Rechte; Selbständerung hart gesperrt.**
> 1. Rechte eines Bots werden je Programm wie Rechte einer Rolle vergeben und entzogen. Das ersetzt die Herleitung der Bot-Rechte allein aus dem Mandat einer Situation (Nr. 4) als einzigen Weg: die Rollen-Rechte des Bots sind ein weiteres Glied der Schnittmenge; Einladung (Mandat) und Recht müssen beide da sein.
> 2. Nr. 5 „Rechte, Rollen oder Mandate vergeben oder ändern“ sowie die Grenze „in fs-groups höchstens `Read`, nie Rechteänderung“ (Z. 50, 96, 118, 135): bleiben der Normalfall, **außer** ein Mensch gibt einem Bot ausdrücklich die Verwaltung von Rechten frei; dann mit deutlicher Warnung und Protokoll. Die übrigen Verbote aus Nr. 5 (zustimmen, abstimmen, einladen, Türsteher, MCP-Schalter und „KI erlaubt“, Geheimnisse, STOP/Notaus, zweiter Bot) bleiben unverändert. Ob die Freigabe `Manage` bzw. Admin einschließt („nie Admin“, Nutzerentscheidung 39), ist **offen** (Frage an den Nutzer, siehe „Offen“).
> 3. **Ohne Ausnahme:** Ein Bot sieht und ändert nie seine eigenen Rechte oder Einstellungen. Keine Übersteuerung, auch nicht durch Regel 2 oder einen Admin.
> 4. Pflichttest: „Bot ändert eigene Einstellung → abgelehnt“ (auch mit erteilter Verwaltungsfreigabe).

**ENTSCHEIDUNG (Nutzer) 7: Einzelplatz ohne Bot.** Auf dem Einzelplatz gibt es keinen Bot (0091 Z. 31, 71).
- A: keine KI-Hilfe auf dem Einzelplatz.
- B: KI-Hilfe nur über den MCP-Schalter (aus, „STOP KI“), Antwort gekennzeichnet.
- **Empfehlung: B**, weil der MCP-Schalter schon Pflicht und für die KI unveränderbar ist (ADR 0097 Z. 26).

**ENTSCHEIDUNG (Nutzer) 8: Akteurstyp einer KI-Antwort im Workflow.** Im Bot-Modell ist die KI ein `Service` (0091 Z. 33), das FS-Profil nutzt für `ai` bisher `Application`.
- A: `actor: ai`, `actor-type: Service` + `bot-seat`.
- B: `Application` beibehalten.
- **Empfehlung: A**, weil der Bot-Platz der handelnde Akteur ist, nicht das Programm der KI.

**ENTSCHEIDUNG (Nutzer) 9: weitere offene Punkte der Hilfe** (aus Teil D, D4; je ohne Empfehlung, weil Fakten fehlen): Wer ist die Stufe „Gemeinschaft“ (Forum, Matrix-Raum, Liste)? E-Mail/XMPP als Außen-Adapter mit Ausnahme-Markierung zulassen? Zustimmung zum Hilfetext je Antwort oder dauerhaft? Speicherdauer der Hilfe-Fragen (ADR 0054 Z. 166)? Eigener Einwilligungszweck oder `ki_hilfe` aus fs-people mitnutzen (0054 Z. 156)?

### E4. Planungs-Components (fs-components) und Blinc

Nach ADR 0103 E6 und der Frontend-Regel (Frontends nur aus Komponenten) liegen alle Anzeigen in fs-components. Liste aus Teil C, Abschnitt 4:

| Komponente | Daten | Bestand | Aktion |
|---|---|---|---|
| Gantt | Balken (Start, Ende, Fortschritt), Meilenstein, Abhängigkeit | `fs-components-timeline` | **erweitern**, Stufe 1 Ansicht: Start→Start, Ende→Ende, `GAP`, Gruppen/Zeilen, feste Titelspalte; Stufe 2 Bearbeiten: Balken ziehen, Abhängigkeiten setzen (Nutzerantwort 89) |
| Netzplan / kritischer Pfad | Knoten mit Aufwand, Vorgänger, Typ, Abstand | fehlt (timeline DESIGN.md:48 „unsupported“) | **neu**: Rechenkern im Modul (nicht in der Komponente, ADR 0073 „berechnet“), Anzeige = Wrapper um `blinc_node_editor` |
| Ablauf-Graph (Workflow, BPMN-Sicht) | Knoten (id, Titel, actor, gate, kind), Kanten (Bedingung), Bahnen | fehlt in fs-components; in Blinc vorhanden als `blinc_node_editor` | **wrap**: `blinc_node_editor` per Pin auf einen Commit + Wrapper in fs-components (Nutzerantwort 88) |
| Board mit Bahnen | Spalten, Karten, Zeilen | `fs-components-kanban` (nur Spalten) | **erweitern** um Achse Y (ADR 0103 E6) |
| Zeitleiste | Zeitpunkte, Meilensteine | timeline, calendar-grid | **wrap** |
| Baum (Gliederung/PSP) | Knoten, Kinder | `fs-components-widgets` tree_view über `blinc_cn` Tree | **wrap** |
| Kapazität (Ressource × Zeit) | Ressource, Raster, Belegung | fehlt | **neu**, nach E1 `needs`/`effort` |
| Stepper (Schrittstatus) | Schritte, aktiver Schritt | fehlt in `blinc_cn` | **neu** (oder breadcrumb + progress als Platzhalter) |
| Diagramme (Last, Verlauf) | Serien | `fs-components-charts` | **wrap** |

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11., Frage 88** (ersetzt die frühere ENTSCHEIDUNG 10 „Welche Blinc-Anzeige war gemeint?“): Blinc **hat** einen Flow-Graph-Editor, im eigenen Repo `project-blinc/blinc_node_editor` (Apache-2.0, kein Tag, letzter Push 2026-10-05, Kopf `248be85`, Angaben laut Nutzerantwort; Lese-Klon `.scratch/blinc-org/blinc_node_editor`). Der Klon belegt (README.md):
- „metadata-driven node-graph editor toolkit“ auf `blinc_canvas_kit` mit typisierten Ports, Bezier-Verbindern mit Ziehen-zum-Verbinden, Inhalten in Knoten, Gruppen (README.md:3-5);
- Schichten Host → `blinc_node_editor` → `blinc_portal_ui` → `blinc_canvas_kit` (Ansicht, Treffer, Auswahl, Ziehen, Einrasten) (README.md:26-32), Einrasten `with_snap` (README.md:49);
- generisch über `<K: PortKind, N, C, G>`; die Verträglichkeit der Ports liegt beim Host (README.md:12-13, 65-68).

Daraus:
1. **Kein eigener Knoten-Graph.** Ablauf-Graph, BPMN-Sicht und Netzplan nutzen `blinc_node_editor` über einen **Wrapper in fs-components**. Die Workflow-Bedeutung (actor, gate, kind, Bahn als Gruppe) steckt im Host-Teil: eigener `PortKind` und Metadaten `N`/`C`/`G` (README.md:12-13). Die frühere Idee „Knoten-Graph als Beitrag an Blinc bauen“ entfällt.
2. **Pin auf einen Commit**, solange es keinen Tag gibt (Kopf `248be85` als Ausgangspunkt; vor dem Pin per `git ls-remote` neu belegen). Braucht es einen Tag, geht eine **kurze Issue-Anfrage** an Blinc wie üblich (Identität und Push-Regeln für fremde Repos). Pin-Prüfung über die übliche Freigabeliste (`blinc-approved.txt`) **[nicht belegt]**, ob sie Zusatz-Repos von project-blinc schon abdeckt.
3. Die Begleit-Crates `blinc_canvas_kit` und `blinc_portal_ui` (Lese-Klone unter `.scratch/blinc-org/`) kommen mit; ihr Stand und ihre Verträglichkeit mit unserem Blinc-Pin (`fs-blinc-3.x`) sind **[nicht belegt]** und vor dem Bau per `vorhanden-pruefen` zu klären.
4. Shader-Graph (`blinc_flow`, `blinc_core/src/flow.rs`) und Debugger-Zeitleiste werden **nicht** genutzt (Teil C, Abschnitt 6: Werkzeuge, keine Planungsbausteine).

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11., Frage 89** (ersetzt die frühere ENTSCHEIDUNG 11 „Gantt nur lesen oder bearbeiten?“): Gantt ist **Ansicht und Bearbeitung**.
1. **Zuerst Ansicht:** `fs-components-timeline` erweitern (Zeile „Gantt“ oben, Stufe 1).
2. **Danach Bearbeiten:** Balken ziehen, Abhängigkeiten setzen. Die Änderung geht an den Besitzer (fs-tasks); die Komponente meldet nur den Wunsch, mit derselben Antwortform wie das Board (`Accepted`/`Refused`/`Ask`, ADR 0103 E6). Das ändert die heutige Absicht von timeline „nur lesen, der Host ändert“ (DESIGN.md:47) nur insoweit, als die Komponente Zieh-Gesten erzeugt; gespeichert wird weiter beim Host.

---

## Abweichungen von bestehenden ADRs

- **Abweichungen durch Nutzerantwort 90 (ausdrücklich):**
  - **ADR 0091 Nr. 4** (Z. 41-49, Bot-Rechte = Mandat ∩ Halter ∩ …): Bot-Rechte werden zusätzlich **je Programm wie Rollen-Rechte** vergeben/entzogen (E3a Regel 2). Die Schnittmenge bleibt, das Rollen-Recht kommt als Glied dazu; Einladung allein reicht nicht.
  - **ADR 0091 Nr. 13** (Z. 76, „KI-Rolle entfällt“): es kommt **keine** KI-Rolle zurück und keine KI-Gruppe; vergeben werden Rechte an den Bot *wie* an eine Rolle (gleiches Mittel), der Bot wird nicht Mitglied.
  - **ADR 0091 Nr. 5** (Z. 51) und die Grenze „in fs-groups höchstens `Read`, nie Rechteänderung“ (Z. 50, 96, 118, 135; dort „2.6.10 entschieden“): **gelockert** für den einen Fall, dass ein Mensch ausdrücklich einem Bot die Verwaltung von Rechten freigibt, mit Warnung (E3a Regel 5). Ob das auch Admin/`Manage` heißt: offen.
  - **Verschärfung** gegenüber 0091: „Bot sieht und ändert nie eigene Rechte/Einstellungen, ohne Übersteuerung“ (E3a Regel 3-4); 0091 Nr. 5 nannte nur „KI erlaubt“ und den MCP-Schalter.
  - Wortlaut des Nachtrags: Abschnitt „Nachtrag-Text zu ADR 0091“ in E3.
- **Keine Abweichung durch Nutzerantwort 88/89:** Blinc-Nutzung per Pin + Wrapper folgt der Frontend-Regel; Gantt-Bearbeiten speichert weiter beim Besitzer (ADR 0073 Nr. 8 unverändert: Planungsdaten berechnet). Abweichung nur gegenüber der Absicht in timeline DESIGN.md:47 (E4).
- Weitere Erweiterungen:
  - ADR 0076 Z. 15: der Akteurstyp der KI wird im Workflow `Service` (Bot-Platz) statt `Application` – nur wenn ENTSCHEIDUNG 8 = A; 0076 nennt beide, also keine Änderung von 0076, nur des FS-Profils (README.md:4-5).
  - Checkliste „drei Ebenen“ → vier Ebenen (ENTSCHEIDUNG 1).
  - ADR 0073 Nr. 8 (Gantt „später“): unverändert; ENTSCHEIDUNG 4 B zieht nur das Datenmodell vor.
- **Namen:** ADR 0076 Z. 25 schreibt „fs-messenger“, ADR 0087 Z. 23 „fs-text“; nach der Namensregel heißen die Programme fs-messages und fs-texts. Dieser ADR nutzt die gültigen Namen und ändert die alten ADRs nicht (Nachzieh-Liste).

## Folgen

- FS-Profil der Workflows (README.md) bekommt die Felder aus E1; `check_workflows.py` prüft sie (fs-release, eigener Auftrag).
- Neuer Workflow `hilfe-anfrage` (fs-release, über `workflow-pflege`).
- fs-blueprint: `[[help]]` erweitern (nach Prüfung von `scaffold-e5`).
- fs-components: Wrapper um `blinc_node_editor` (Pin auf Commit) für Ablauf-Graph und Netzplan, Bahnen im Board, timeline-Erweiterung erst Ansicht, dann Bearbeiten (je eigener Auftrag, Bahn 1).
- Blinc: kurze Issue-Anfrage nach einem Tag für `blinc_node_editor`, falls der Pin auf einen Commit nicht reicht.
- ADR 0091: Nachtrag „Bot-Rechte = Rollen-Rechte; Selbständerung hart gesperrt“ (Wortlaut in E3) in einem eigenen Doku-Lauf übernehmen.
- fs-tasks / fs-jscalendar: Relationstypen nach RFC 9253 im Datenmodell (nach ENTSCHEIDUNG 4/5).

## Offen

1. Ablauf-, Daten-, Ressourcen- und Ausnahme-Muster sind mit Nummer, Name und Adresse gegen die WP-Liste geprüft (E1a). Offen: Begriffe der Wiederherstellung (`recoveryaction.php`, nicht abgerufen) **[nicht belegt]**.
2. DSL-Konstrukte geprüft (E1 Regel 3, E1a): keine Kompensation, Abbruch nur als Ereignis, Wahl zwischen Ereignissen teilweise über `listen.to.any`. Offen: ob `fork.compete` und die übrigen zitierten Felder schon in **1.0.3** stehen (Quelle zeigt 1.1.0-Beispiele) **[nicht belegt]**.
2a. Bot mit Freigabe zur Rechteverwaltung (E3a Regel 5): schließt das Admin/`Manage` ein, trotz „nie Admin“ (Nutzerentscheidung 39, ADR 0091 Z. 14)? Frage an den Nutzer.
2b. `blinc_node_editor`, `blinc_canvas_kit`, `blinc_portal_ui`: Verträglichkeit mit unserem Blinc-Pin und Freigabeweg für Zusatz-Repos **[nicht belegt]**.
3. ~~`raise`, `while`, `schedule` in unseren Flows~~ geklärt (E1a „Nutzung in unseren Dateien“): `raise`/`while` werden nicht genutzt, `schedule` nur als Auslöser (catalog-bump.yaml:11-15).
4. Abbildung RFC 9253 → JSCalendar `relatedTo` **[nicht belegt]**.
5. BPMN Pools/Lanes und CMMN Stage/Sentry/Milestone: aus den abgerufenen Übersichtsseiten nicht bestätigt.
6. Stand `fs-modules-planning` (Checkliste: v0.0.2, 4152a94) nicht per `git ls-remote` belegt; vor jedem Planungs-Bau `vorhanden-pruefen`.
7. Zweig `scaffold-e5` (`[[help]]`) nicht geprüft.

## Pflichttests (Vorschlag; nichts davon ist gebaut)

- `check_workflows.py`: `actor: ai` ohne `bot-seat` → Befund (Warnung/rot nach ENTSCHEIDUNG 2).
- `separate-from`: gleicher Akteur an beiden Schritten → Lauf verweigert den Übergang.
- BPMN-Import: nicht abbildbares Element → sichtbare Meldung, kein stilles Weglassen.
- Planungsdaten: kritischer Pfad wird nie gespeichert (nur berechnet).
- Hilfe: die Tests aus E3, darunter **„Bot ändert eigene Einstellung → abgelehnt“** (Pflicht, auch mit Verwaltungsfreigabe und auch auf Anweisung eines Admins).
- `blinc_node_editor`-Wrapper: Pin zeigt auf genau einen Commit (kein Zweig), Prüfung wie beim Blinc-Pin.

## Quellen

- Recherche-Berichte 2026-11-20: `.scratch/recherche-workflow-ebenen/teil-A.md` (DSL gegen Muster, ValueFlows; Musternamen dort aus dem Gedächtnis, berichtigt in `todo/recherche-workflow-ebenen-teil-a.md`), `teil-B.md` (Ebenen, Sichten, RFC 9253, BPMN, CMMN), `teil-C.md` (Planungs-Components, Blinc-Inventur), `teil-D.md` (Hilfe anfordern).
- RFC 9253, Support for iCalendar Relationships: https://www.rfc-editor.org/rfc/rfc9253.html (abgerufen in Teil B).
- BPMN 2.0.2: https://www.omg.org/spec/BPMN/2.0.2/About-BPMN (abgerufen in Teil B, Übersicht).
- CMMN 1.1: https://www.omg.org/spec/CMMN/About-CMMN (abgerufen in Teil B, Übersicht).
- Serverless Workflow DSL Reference (GitHub `serverlessworkflow/specification`, `dsl-reference.md`), Text: `.scratch/recherche-workflow-ebenen/sw-dsl-reference.md` (abgerufen 2026-11-20).
- Workflow Patterns Initiative (workflowpatterns.com), Seiten als Text: `.scratch/recherche-workflow-ebenen/wp-control.txt`, `wp-data.txt`, `wp-resource.txt`, `wp-exception.txt` (abgerufen 2026-11-20), mit den Papieren BPM-06-22, FIT-TR-2004-01, BETA WP 127, BPM-06-04 (Einzelangaben in E1); vollständige Musterliste `wp-pattern-liste-vollstaendig.tsv` und Einzelseiten `wp-pages/` (129 Seiten, abgerufen 2026-11-20 vom Koordinator). Adresse: http://workflowpatterns.com/ (nur http).
- `project-blinc/blinc_node_editor`, Lese-Klon `.scratch/blinc-org/blinc_node_editor/README.md`; Lizenz, Kopf und Push-Datum laut Nutzerantwort 88.
- Nutzerantworten 88, 89, 90 vom 2026-11-20.
- ADR 0013, 0037, 0054, 0073, 0076, 0081, 0087, 0091, 0097, 0103, 0104.

## Quellen zum Nachprüfen (vor Annahme)

1. Workflow Patterns: nur noch die Wiederherstellungs-Seite http://workflowpatterns.com/patterns/exception/recoveryaction.php (Arten, Schritt- und Fall-Ebene sind belegt).
2. Serverless Workflow: Stand der Felder in Version 1.0.3 (unsere Dateien) gegenüber der abgerufenen Referenz mit 1.1.0-Beispielen.
3. ValueFlows-Vokabular (valueflo.ws): `Process`, `Recipe`, `EconomicResource`, `Commitment`, `inputOf`/`outputOf` – in keinem Bericht abgerufen.
4. RFC 8984 (JSCalendar), Abschnitt zu `relatedTo` – für die Abbildung von RFC 9253.
5. BPMN 2.0.2 Spezifikation (Volltext) für Pools/Lanes; CMMN 1.1 Volltext für Stage/Sentry/Milestone.

## Nachzieh-Liste (eigener Doku-Lauf)

- ADR 0076: Nachtrag „Ebenen je Schritt“ (Verweis auf 0105 E1); Namen fs-messages/fs-texts (nur Hinweis, Agenten benennen nicht um).
- ADR 0097: Nachtrag zu N6 und M2 „Hilfe anfordern“ (Verweis auf 0105 E3).
- ADR 0103: Verweis „Bahn = BPMN-Lane“ (0105 E2 Nr. 6).
- ADR 0091: Nachtrag aus E3 („Bot-Rechte = Rollen-Rechte; Selbständerung hart gesperrt“), dazu Verweis in 0054.
- fs-components-timeline DESIGN.md:47: Absicht „nur lesen“ auf „Ansicht, dann Bearbeiten über den Host“ anpassen (beim Bau-Auftrag).
- fs-release `workflows/README.md`: neue Felder (nach Annahme).
