# 0105 – Workflow-Ebenen, Prozess-Sichten, Hilfe anfordern: vier Ebenen je Schritt, eine Quelle mit mehreren Sichten, Hilfe als Pflichtteil des Gerüsts

> **Nachtrag 23.11.2026 (Workflow `adr-write`, W-0):** Der Arbeitsname des Lauf-Moduls ist `fs-modules-workflow` (vorher `fs-flow`). Die Festlegung steht in ADR 0107 (Workflow-Modul, Serverless Workflow 1.0.3, Lauf als AS2-Objekt in fs-objects, Bahn aus `role`, Akteur nur aus der Verbindung). Alle Stellen in diesem ADR, die `fs-flow` nennen, meinen jetzt `fs-modules-workflow`. Entscheid Strategie 23.11., Nutzer hat der Richtung zugestimmt; Opus-Prüfung offen.

Status: **Entwurf** (2026-11-20; Workflow `adr-write`, Schritt `draft`; überarbeitet im Schritt `work-in` am 2026-11-20: Antworten des Nutzers zu Frage 88–90 eingearbeitet, Frage 90 in der verschärften Fassung vom 20.11. (Bot-Rechte nur durch Menschen, keine Bots durch Bots), Muster- und DSL-Aussagen gegen die abgerufenen Quellen geprüft; Grundlage: vier Recherche-Berichte vom 2026-11-20, siehe „Quellen“; Entscheide des Nutzers zu den offenen Punkten 1–9 sowie die Gerüst-Folgen für fs-blueprint/fs-starter am 2026-11-20 eingetragen, Workflow `entscheidung`, Schritt `record`; Nutzerantwort 91 vom 20.11. eingearbeitet: Empfänger einer Hilfe-Anfrage folgen dem Gruppenmodell, eine eigene Stufe „Gemeinschaft“ gibt es nicht; Strategie-Nachtrag 4 vom 20.11. eingearbeitet (Workflow `adr-write`, Schritt `work-in`): eigene föderierte Support-Gruppe je Programm und zwei Helfer-Arten, **vorläufig** (E3b); Strategie-Nachtrag 5 vom 20.11. eingearbeitet (Nutzerentscheid, Frage 92; ersetzt den Vorschlag der Strategie aus Nachtrag 4): keine eigene Zustimmung je Helfer zum Kontext-Paket; der Fragende sieht Bild und Paket vor dem Senden mit „Senden“ und „Neues Bild aufnehmen“, nur was er sendet, geht an die Support-Gruppe (E3b Nr. 4); damit ist keine ENTSCHEIDUNG mehr offen) · **konkretisiert** ADR 0076 Zeile 18, 21–24 und Regel 1 (ValueFlows-Begriffe als Felder je Schritt) · **baut auf** ADR 0103 (Lauf, Station, Bahn = Achse Y) und ADR 0104 E9 (Befehlsketten sind Workflows) · **konkretisiert** ADR 0097 N6 („Hilfe als Wiki“) und den Pflicht-Hilfe-Eintrag (0097 Z. 26, Meilenstein M2) · **verwendet** ADR 0054 (KI markiert), 0091 (KI nur über Bot-Platz), 0087 Nr. 5 (Helpdesk ist eine Suite), 0037 (Ordner = Gruppe), 0095 (Gruppen, Eigentümer, KI-Sperre), 0073 Nr. 8 (Planungsdaten berechnet, nicht gespeichert), 0013 (nichts kopieren), 0081 (CloudEvents)

**Nummer:** **0105**. Herleitung: `conventions/decisions/` auf dem Zweigstand (aus main, Kopf d1d7315d) endet bei `0104-moduldaten-gehoeren-dem-modul.md`.

**Sprache:** nur Deutsch, wie alle ADRs im Repo.

**Lesehinweis:** Jede Aussage, die nicht aus einer abgerufenen Quelle oder einer Datei mit Zeilennummer stammt, ist mit **[nicht belegt]** markiert. Seit dem Schritt `work-in` liegen zwei Quellen als Text vor und sind hier mit Zeilen zitiert:
- **DSL** = Volltext `dsl-reference.md` aus GitHub `serverlessworkflow/specification` (Textkopie in der Recherche des Koordinators vom 20.11.2026, interner Arbeitsordner, nicht veröffentlicht). **Achtung:** die Beispiele dort tragen `dsl: '1.1.0'` (z. B. DSL:760), unsere Dateien `dsl: 1.0.3`. Ob jedes zitierte Feld schon in 1.0.3 steht (vor allem `fork.compete`, DSL:754), ist **[nicht belegt]**.
- **WP** = die Seiten von workflowpatterns.com (Familien Ablauf, Daten, Ressourcen, Ausnahme) als Text, mit den Papier-Verweisen; dazu **WP-Liste** = die vollständige Tabelle aller 129 Einzelseiten mit Nummer und Name (43 Ablauf WCP, 40 Daten WDP, 43 Ressourcen WRP, 3 Ausnahme-Seiten) samt Einzelseiten. Beides: Recherche des Koordinators vom 20.11.2026, interner Arbeitsordner, nicht veröffentlicht; öffentlich belegbar über die Adresse unten. Adresse einer Einzelseite: `http://workflowpatterns.com/patterns/<familie>/<gruppe>/<id>.php` (nur **http**; das https-Zertifikat schlägt fehl), z. B. `http://workflowpatterns.com/patterns/control/basic/wcp1.php`; die Gruppen stehen in E1a je Tabellenzeile.

Weiter **[nicht belegt]** (keine Quelle im Lauf): RFC 9253 in JSCalendar, ValueFlows `inputOf`/`outputOf`, BPMN-Lanes, CMMN-Begriffe, die Wiederherstellungs-Seite der Ausnahme-Muster (`recoveryaction.php`, nicht abgerufen). Die Liste „Quellen zum Nachprüfen“ am Ende nennt, was vor der Annahme noch zu prüfen ist.

**Verweise auf ADR 0103:** „0103 E2 … E7“ in diesem Text heißt **Punkt 2 … 7 der Entscheidung von ADR 0103** (dort sind die Punkte nummeriert, nicht mit „E“ benannt; z. B. Punkt 2 Zustand × Station, Punkt 5 Lauf-Typ, Punkt 6 Board, Punkt 7 Ziehen).

Die Wahlmöglichkeiten für den Nutzer sind als **ENTSCHEIDUNG (Nutzer):** markiert. Stand 20.11.: die ENTSCHEIDUNGEN 1–9 sind beantwortet (Nutzerentscheide, von der Strategie am 20.11. übermittelt, bzw. Nutzerantworten 88–91), mit gewählter Option und Grund in einer Zeile. Die mit Nachtrag 4 kurz offene Entscheidung E3b Nr. 4 (Kontext-Paket in offenen Support-Gruppen) ist mit Nachtrag 5 **beantwortet** (Frage 92, 20.11.); **keine ENTSCHEIDUNG (Nutzer) ist mehr offen**. Der Block E3b Nr. 1–3 (eigene Support-Gruppe je Programm, Helfer-Arten) ist ein Nutzerwort, aber **vorläufig** (der Nutzer kann ihn noch ändern). Unter „Offen“ steht daneben die Rückfrage 2a (Beitrittsanfragen in fs-groups), die von den Entscheiden vom 20.11. nicht erfasst ist.

---

## Kontext

Drei Punkte der Checkliste hängen zusammen: „Workflows in drei Ebenen“, „Prozesse darstellen“ und „Hilfe anfordern“. Dazu kommen „Planungs-Components“ und „Workflow-/Ablauf-Darstellung von Blinc“.

Bestand (belegt in den Berichten, Teil A–D):

1. **Unsere Abläufe** sind Serverless Workflow 1.0 (`dsl: 1.0.3`) mit FS-Profil, 59 Dateien in `fs-release/workflows/` (README.md:3-12). Genutzt werden `do`, `call`/`with`, `export.as` mit `$context`, `if`, `run.workflow`, `switch`/`then`, `set`, `for`, `fork`, `try`/`catch`/`timeout`, `listen`, `emit` (Teil A, Tabelle 1, je mit Datei:Zeile). Das DSL-Konstrukt `retry` nutzen wir **nicht**: in allen `workflows/*.yaml` gibt es keinen `retry:`-Schlüssel; anbieter-neuinstallation.yaml:150 ist nur ein `switch`-Fall namens „retry“ (Z. 142-152) mit Rücksprung `then: install`. Die Dateien sind **Beschreibung**, nicht ausführbar (README.md:9-12; testlauf.yaml:1-2 „SPECIFICATION, NOT RUNNABLE“).
2. **Metadaten je Schritt** sind nur `actor` (human/ai/machine), `actor-type` (Person/Application/Service), `gate`, `kind` (objective/subjective), dazu `summary`, `adr`, `phase`. Eine Suche nach `resource|role|skill|time|deadline|cost|budget|capacity` in allen aktiven Flows ergab **0 Treffer** (Teil A, Abschnitt 1).
3. **ADR 0076** legt das Grundmodell fest: REA/ValueFlows; Zeit und Fähigkeiten von Akteuren sind Ressourcen (Z. 18, Regel 1 Z. 30); Ablauf = Serverless Workflow + ValueFlows `Recipe`/`Process` (Z. 23); Ereignis = `EconomicEvent` in fs-history (Z. 24); Ziel ≠ Ablauf (Regel 5, Z. 34); jedes Programm bekommt eine Workflow-Ansicht (Z. 50).
4. **ADR 0103** (Entwurf): die Lebenszustände gehören dem **Lauf**, der Workflow besitzt nur Stationen und Übergänge; Board mit Achse X (Spalten) und Achse Y (Bahn = Swimlane); Lauf-Typ im Modul `fs-modules-workflow`.
5. **ADR 0073 Nr. 8**: Planungsdaten (frühester Start, Puffer, kritischer Pfad, Gantt-Termine) werden **berechnet statt gespeichert**; das Gantt rechnet „nominal“ und sagt das sichtbar.
6. **Komponenten**: `fs-components-timeline` hat Balken, Meilenstein, Fortschritt, Ende→Anfang-Pfeile, Zoom, Heute-Linie; nicht: Ziehen, Start→Start/Ende→Ende, Verzögerung, kritischer Pfad, Gruppen (Teil C, Abschnitt 5, DESIGN.md:47-49). `fs-components-kanban` hat Spalten, keine Zeilen. In fs-components gibt es keinen Knoten-/Flow-Graphen (Teil C, Abschnitt 6). **Blinc hat einen** im eigenen Repo `project-blinc/blinc_node_editor` (Nutzerantwort 88; siehe E4); die Inventur in Teil C hatte nur den lokalen Blinc-Checkout durchsucht.
7. **Hilfe**: ADR 0097 verlangt je Programm einen Hilfe-Eintrag mit Inhalt oder sichtbarem Rückfall (Z. 26) und ordnet das Hilfe-Modul der Hülle M2 zu (Z. 35); N6 heißt „Hilfe als Wiki“ (Z. 7). Die Ideen des Nutzers vom 20.11. stehen in der Checkliste (Teil D, D1, 12 Punkte). Auf main in `fs-blueprint` gibt es keinen `help`-Eintrag; der Zweig `scaffold-e5` hat einen `[[help]]`-Eintrag mit `topic` und Text de/en (Teil D, D3; der Zweig war im Lauf nicht abrufbar, siehe Offen 7).

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
| **Ausnahme** | Was, wenn es schiefgeht? | `try`/`catch`, `timeout`, Rücksprung per `switch`/`then` (anbieter-neuinstallation.yaml:142-152) | `EconomicEvent` hält fest, was passiert ist (fs-history, unveränderlich) | Abbruch eines Falls/Bereichs, Kompensation (Rückbau) |

Regeln:

1. **Die Ebenen sind Felder am Schritt, keine vier Dateien.** Ein Schritt bleibt ein Serverless-Workflow-Schritt; die Ressourcen-Ebene kommt als FS-Metadaten dazu (Präfix `freesynergy.net:`, wie heute). Grund: eine Datei je Ablauf hält Ablauf und Zuständigkeit zusammen; getrennte Dateien laufen auseinander (ADR 0076 Abschnitt 2, „eine Wahrheit“).
2. **Ressourcen-Felder (Vorschlag, Namen vorläufig):**
   - `freesynergy.net:role` – Rolle statt Person (Zuteilung über fs-groups-Rollen; ADR 0103 E7 `ClaimRule`).
   - `freesynergy.net:needs` – benötigte Fähigkeiten/Ressourcen als Verweise auf fs-resources (ValueFlows `EconomicResource`).
   - `freesynergy.net:effort` – geschätzter Aufwand im **Maß** aus ADR 0103 (nicht USD, nicht Stunden fest).
   - `freesynergy.net:bot-seat` – Pflicht, wenn `actor: ai`: Verweis auf den Bot-Platz (ADR 0091 E1/E2). Ein `ai`-Schritt ohne Bot-Platz ist ein **Prüffehler** in `check_workflows.py`, kein Hinweis; bis zum nächsten Workflow-Release eine Warnung (ENTSCHEIDUNG 2 = B). Grund: ADR 0091 erlaubt der KI keinen anderen Weg; eine Lücke dort ist eine Sicherheitslücke (Teil A, Lücke 2).
   - `freesynergy.net:separate-from` – Trennung der Pflichten: dieser Schritt darf nicht vom Akteur eines genannten Schritts erledigt werden (z. B. Bauer ≠ Prüfer).
3. **Ausnahme-Ebene (Vorschlag):**
   - **Abbruch eines Falls** heißt im Lauf `abgebrochen` (ADR 0103 E2); der Workflow braucht dafür kein neues Konstrukt, nur eine Regel „wer darf abbrechen“.
   - **Kompensation**: ein Schritt darf `freesynergy.net:compensate: <schritt>` nennen; bei Abbruch nach diesem Schritt läuft der Rückbau-Schritt. Grund: ohne Rückbau bleiben halbe Zustände (z. B. Tag gesetzt, Release nicht gebaut). Die DSL hat **kein** Kompensations-Konstrukt: die Pflicht-Aufgabenarten sind Call, Do, Fork, Emit, For, Listen, Raise, Run, Switch, Set, Try, Wait (DSL:265-278); `try`/`catch` fängt nur Fehler und kann danach Aufgaben ausführen (DSL:1231-1288); das Wort „compensat…“ kommt im Volltext nicht vor (Suche, 0 Treffer). Darum bleibt das FS-Feld. `catch.do` ist der Ort, an dem der Rückbau-Schritt aufgerufen wird.
   - **Abbruch** kennt die DSL nur als Lebenszyklus-Ereignis („Workflow Cancelled“ DSL:1433-1448, „Task Cancelled“ DSL:1616-1633), nicht als Aufgabe; `then: exit|end` beendet Bereich bzw. Ablauf geordnet (DSL:1320-1322). Der Abbruch von außen ist damit Sache des Laufs (`fs-modules-workflow`), wie oben.
   - **Eskalation an den Menschen** bleibt `switch`/`then` → Schritt `eskalation` mit `actor: human` (heute belegt, z. B. katalog.yaml:314-323) bzw. Schritt mit `gate: human` (anbieter-neuinstallation.yaml:139).
4. **Ablauf-Lücken werden nur nach Bedarf geschlossen.** Structured Discriminator (WCP9), Partial Join (WCP30-32), Deferred Choice (WCP16) und Milestone (WCP18) (Namen und Nummern: wp-control.txt:101-139, 188-193): sie kommen erst, wenn ein echter Ablauf sie braucht, und dann zuerst mit Mitteln der DSL: `fork.compete: true` (ein Gewinner, DSL:754) bzw. `listen.to.any` (DSL:2153) mit anschließendem `switch`. Vollständige Liste: E1a.
5. **Ereignisse**: jeder abgeschlossene Schritt eines Laufs erzeugt ein `EconomicEvent` bzw. eine AS2-Aktivität in fs-history (ADR 0076 Z. 24, 0103 E7 `Move`); nach außen als CloudEvent (ADR 0081). Der Workflow schreibt dafür nichts selbst; das macht der Lauf (`fs-modules-workflow`).

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11.** – Nr. 1 (drei oder vier Ebenen?): **B, vier Ebenen** (Ablauf, Daten, Ressourcen, Ausnahme eigenständig, wie oben). Grund: Abbruch, Rückbau und Eskalation gelten in jedem Zweig gleich und würden als Teil der Ablauf-Ebene je Zweig kopiert. (Verworfen: A, drei Ebenen wie in der Checkliste.)

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11.** – Nr. 2 (wie streng ist `bot-seat`?): **B, zuerst Warnung, rot ab dem nächsten Workflow-Release, Datum beim Release festzulegen.** `check_workflows.py` meldet `actor: ai` ohne `bot-seat` bis dahin als Warnung, ab diesem Release als Prüffehler (rot); E1 Regel 2 („Prüffehler“) gilt ab diesem Release. Grund: heute haben alle `ai`-Schritte (u. a. entscheidung.yaml:30-31) das Feld nicht; sofort rot würde alle Flows auf einmal rot machen. (Verworfen: A, sofort rot.)

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
| Push (`resource/push`, WRP12-20) / Pull (`resource/pull`, WRP21-26) | – | – | alle: Push WRP12 Distribution by Offer - Single Resource, WRP13 … - Multiple Resources, WRP14 Distribution by Allocation - Single Resource, WRP15 Random Allocation, WRP16 Round Robin Allocation, WRP17 Shortest Queue, WRP18 Early Distribution, WRP19 Distribution on Enablement, WRP20 Late Distribution; Pull WRP21 Resource-Initiated Allocation, WRP22 Resource-Initiated Execution - Allocated Work Item, WRP23 … - Offered Work Item, WRP24 System-Determined Work Queue Content, WRP25 Resource-Determined Work Queue Content, WRP26 Selection Autonomy; gehören zum Lauf und zum Board (`fs-modules-workflow`, fs-tasks), nicht zur Ablauf-Datei |
| Umleiten (`resource/detour`, WRP27-35) | – | WRP28 Escalation (`switch` → Schritt `eskalation` mit `actor: human`, katalog.yaml:314-323), WRP32 Suspension/Resumption (nur Ereignisse DSL:1357, 1556), WRP33 Skip (`if`, DSL:284), WRP34 Redo (DSL-`retry` nach Fehler, DSL:2201, bei uns ungenutzt; Rücksprung per `switch`/`then` wie anbieter-neuinstallation.yaml:142-152) | WRP27 Delegation, WRP29 Deallocation, WRP30 Stateful / WRP31 Stateless Reallocation, WRP35 Pre-Do |
| Selbststart (`resource/autostart`, WRP36-39) / Sichtbarkeit (`resource/visibility`, WRP40-41) | – | – | alle: WRP36 Commencement on Creation, WRP37 … on Allocation, WRP38 Piled, WRP39 Chained Execution, WRP40/41 Configurable Unallocated/Allocated Work Item Visibility (Lauf/Board) |
| Mehrere Ressourcen (`resource/multiple_resources`, WRP42-43) | – | – | WRP42 Simultaneous Execution, WRP43 Additional Resources → *`needs`* mit mehreren Einträgen |

**Ausnahmen (wp-exception.txt + Einzelseiten unter `http://workflowpatterns.com/patterns/exception/`):** Das Kapitel ist kein Nummern-Katalog, sondern drei Seiten mit benannten Arten und Übergängen:
- **Arten** (`exceptiontypes.php`, wp-pages/exception_exceptiontypes.html:185-193): Work Item Failure (`raise` DSL:830, `try`/`catch` DSL:1231) **gedeckt**; Deadline Expiry (`timeout` DSL:2381) **gedeckt**; External Trigger (`listen` als Abbruchgrund nur über Lebenszyklus-Ereignisse) **teilweise**; Constraint Violation (`output`-Schema DSL:2345) **teilweise**; Resource Unavailability **fehlt** (braucht die Ressourcen-Ebene).
- **Am Arbeitsschritt** (`exception_workitemlevel.php`, …workitemlevel.html:190-232, 15 Übergänge): continue-execution SCE (`catch` und weiter, DSL:1287-1288), restart SRS (DSL-`retry`, DSL:2201; bei uns ungenutzt, nur als `switch`-Rücksprung), force-fail SFF (Fehler nicht gefangen / `raise`), force-complete SFC (`catch.then` auf den Nachfolger) **gedeckt**; die Übergänge aus „angeboten“/„zugeteilt“ (OCO, ORO, OFF, OFC, ACA, ARA, ARO, AFF, AFC) und reallocate-s SRA / reoffer-s SRO **fehlen** (kein Angebot/keine Zuteilung in der Ablauf-Datei; gehören zu `fs-modules-workflow`).
- **Am Fall** (`exception_caselevel.php`, …caselevel.html:186-188): continue with case CWC **gedeckt** (`catch`); remove current case RCC **teilweise** (`exit`/`end` beendet den ganzen Lauf, keine Auswahl einzelner Schritte); remove all cases RAC **fehlt**.
- **Wiederherstellung/Kompensation** **fehlt** (E1 Regel 3); die Seite `recoveryaction.php` wurde nicht abgerufen, ihre Begriffe bleiben **[nicht belegt]**.

**Nutzung in unseren Dateien (`fs-release/workflows/*.yaml`, gegen die Familien geprüft):** `fork` mit `compete: false` (programm-grundgeruest.yaml:23-24, 187-188) = WCP2/WCP3; `listen.to.all` (release-flow.yaml:211-213) = Warten auf mehrere Ereignisse; `for` mit `each`/`in` (koordinator-runde.yaml:152-153, stil-neu.yaml:135-136) = WCP13/14; `schedule.on.any` als Auslöser des ganzen Ablaufs (catalog-bump.yaml:11-15) = WCP23; `try`/`catch`/`timeout`, `emit`, `run.workflow`, `switch`/`then`. **Nicht** genutzt: `retry` (kein `retry:`-Schlüssel in `workflows/*.yaml`; anbieter-neuinstallation.yaml:150 ist ein `switch`-Fall namens „retry“, Z. 142-152, Rücksprung = WCP10/WRP34-artig), `raise`, `while`, `listen.to.any` (WCP16), `fork.compete: true` (WCP29). `wait: all` (koordinator-runde.yaml:181, 366) ist ein Argument unter `with` eines `call` (collect-agent-reports), **kein** DSL-Konstrukt; `schedule` in server-einrichtung.yaml:240 ist ein Schrittname.

Folge: Die Lücken mit Vorrang sind Rolle, Fähigkeit, Trennung der Pflichten, Verweis statt Kopie und Kompensation; alles andere wartet auf einen echten Ablauf (E1 Regel 4).

### E2. Eine Quelle, mehrere Sichten

Für Prozesse und Pläne gibt es **je Frage eine Datenquelle** und daraus abgeleitete Sichten. Keine Sicht hat eigene Daten. Grund: zwei gespeicherte Fassungen desselben Ablaufs (z. B. YAML und BPMN-XML) laufen auseinander; mit einer Quelle gibt es keinen Abgleich.

| Quelle | Besitzer | Sichten daraus |
|---|---|---|
| **Ablauf** (Workflow-Datei, Stationen, Übergänge, Ebenen aus E1) | fs-workflows (bis dahin fs-release) | Ablauf-Graph, BPMN-Sicht (Bahnen = `actor`/`role`), Board-Spalten `WorkflowStationen` (ADR 0103 E6) |
| **Lauf** (Instanz: Zustand × Station, Aufenthalte) | `fs-modules-workflow` (ADR 0103 E5) | Board, Verlauf, Fall-Sicht (CMMN-artig) |
| **Ziele/Zusagen mit Abhängigkeiten** (JSCalendar Task + Relationen) | fs-tasks | Liste, Board, Gantt, Netzplan |

1. **Workflow-Sicht** (Ablauf-Graph): Knoten = Schritte mit `actor`, `gate`, `kind`; Kanten = `then`/Reihenfolge, Bedingung an der Kante. Pflicht nach ADR 0076 Z. 50.
2. **BPMN 2.0 nur als Sicht und als Austauschformat** (Import/Export), **kein** Speicherformat im Kern. Grund (Logik): BPMN-XML trennt Diagramm-Lage und Semantik und hat viele Elemente ohne Gegenstück in unserer DSL; als Speicher müssten wir beides pflegen. Als Sicht gewinnen wir die bekannte Darstellung (Pools/Lanes **[nicht belegt]** in der abgerufenen OMG-Seite) und den Austausch mit fremden Werkzeugen. **Import** übernimmt nur, was sich verlustfrei auf die DSL abbilden lässt; der Rest wird **sichtbar gemeldet**, nie still weggelassen (Regel „Fehlende Datenquelle melden“).
3. **Projektplan: Gantt und Netzplan** aus fs-tasks. Abhängigkeiten nach den Relationstypen aus **RFC 9253** (iCalendar Relationships): `FINISHTOSTART`, `FINISHTOFINISH`, `STARTTOFINISH`, `STARTTOSTART`, dazu Abstand (`GAP`, Vorlauf/Verzögerung) sowie `PARENT`/`CHILD`/`SIBLING`, `DEPENDS-ON`, `FIRST`/`NEXT` (Teil B, B3, abgerufen). Grund (Logik): die vier Abhängigkeitsarten plus Abstand decken die klassische Netzplantechnik ab; mit einer festen, öffentlichen Typliste können Plan, Import und Export dieselben Wörter nutzen, ohne eigenes Vokabular. **Achtung:** RFC 9253 erweitert iCalendar (RFC 5545), nicht JSCalendar (RFC 8984). Wie die Typen in JSCalendar `relatedTo` abgebildet werden, ist **[nicht belegt]**; bis zur Prüfung tragen wir die RFC-9253-Typwörter als Werte der Relation (Abbildung in einem Vorschlag für fs-jscalendar, nicht hier festgelegt).
4. **Planungsdaten werden berechnet** (frühester/spätester Start, Puffer, kritischer Pfad), nie gespeichert (ADR 0073 Nr. 8, unverändert). Zyklen nach einem Merge werden angezeigt, nicht abgelehnt (ebd.).
5. **CMMN-Sicht (Fallbearbeitung)**; Grund (Logik): ein Lauf mit Menschen-Schritten ist kein Fließband, sondern eine Liste offener Aufgaben mit Wartegründen; die Ablauf-Sicht zeigt Reihenfolge, nicht „was fehlt noch und von wem“, und ADR 0103 hält Wartegrund und Zustand ohnehin beim Lauf. Die Sicht kostet keine eigenen Daten. Ein Lauf mit offenen Menschen-Schritten (`gate: human`, `kind: subjective`, Wartegrund aus ADR 0103 E3) wird als **Fall** gezeigt: was ist offen, was ist erfüllt, was wartet worauf. CMMN 1.1 (OMG, 2016) ist als Standard belegt; die Begriffe Stage, Sentry, Milestone sind **[nicht belegt]** aus der abgerufenen Seite. Kein CMMN-Import/-Export in diesem Schritt.
6. **Bahn = Achse Y** (ADR 0103 E6) ist dieselbe Idee wie die BPMN-Lane: im Ablauf-Graph und im Board wird nach `actor`/`role` gruppiert. Damit gibt es **ein** Wort („Bahn“) in allen Sichten.

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11.** – Nr. 3 (BPMN als Sicht oder Speicher?): **A, BPMN nur als Sicht + Import/Export** (wie oben), kein Speicherformat. Grund: die ausführbare Wahrheit ist die DSL (ADR 0076 Z. 23); BPMN als Speicher erzwänge zwei Formate mit Abgleich. (Verworfen: B, nativer BPMN-Speicher.)

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11.** – Nr. 4 (Netzplan jetzt oder später?): **B, Datenmodell jetzt** (Relationstypen, Aufwand); Rechenkern (kritischer Pfad) und Anzeige sind **eigene, getrennte Aufträge**. Grund: das Datenmodell ist billig und spart später Migration (Daten dürfen heute noch weg). (Verworfen: A, alles später; C, Rechenkern gleich mit.)

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11.** – Nr. 5 (welche RFC-9253-Typen?): **A im Datenmodell, B in der ersten Anzeige.** Das Datenmodell kennt alle vier Abhängigkeitsarten + `GAP` + Eltern/Kind; die erste Anzeige zeigt nur `FINISHTOSTART` und `STARTTOSTART` + `GAP`. Grund: ein Typ, den das Modell nicht kennt, ginge beim Import verloren; die Anzeige wächst schrittweise (heute nur Ende→Anfang, Teil C).

### E3. Hilfe anfordern ist Pflichtteil des Gerüsts

Jedes Programm hat neben dem Hilfe-Eintrag (ADR 0097 Z. 26) eine Funktion **„Hilfe anfordern“**. Sie gehört zur Hülle (M2, ADR 0097 Z. 35) und wird im Bauplan beschrieben, nicht je Programm programmiert.

Regeln (aus den Nutzerideen vom 20.11., Teil D, D1; Konflikte mit ADRs aufgelöst oder als Entscheidung markiert):

1. **Fragen stellt ein Mensch.** Antworten kommen von Menschen, von einer KI **nur über einen Bot** und gekennzeichnet (ADR 0054, 0091), oder von beiden. Ein Bot schreibt und antwortet, wenn er **eingeladen** ist und die **Rechte** dafür hat (E3a, Nutzerantwort 90).
2. **Ein Hilfe-Kanal je Programm** als Ordner in fs-messages; Ordner = Gruppe (ADR 0037). In fs-messages auf Wunsch zusammen angezeigt.
3. **Herkunft ist fest an der Frage** (Programm, Version) und nicht änderbar. fs-messages filtert danach.
4. **Hilfe erscheint nie in broadcast.** broadcast abonniert nur seinen eigenen Ordner. Die Trennung ist ein Pflichttest, kein Filter-Standard.
5. **Kontext-Paket** (Programm, Version, Ansicht, Fehler, Bild nur geschwärzt) wird **vor dem Senden gezeigt und ist änderbar**. Geheimes oder Sensibles kommt nie hinein; Prüfung über einen Kanarien-Test (eingesetzter Prüfwert darf im Paket und im Bild nie auftauchen). Hinaus geht **nur, was der Fragende mit „Senden“ abschickt**; ein falsches Bild ersetzt er mit „Neues Bild aufnehmen“ (E3b Nr. 4, Frage 92).
6. **Empfänger folgen dem Gruppenmodell** (fs-groups, ADR 0095; Nutzerantwort 91, ENTSCHEIDUNG 9 Nr. 5): es gibt **kein eigenes Konstrukt** für eine „Gemeinschaft“. Empfänger einer Hilfe-Anfrage sind
   - (a) **Support-Gruppen** = Helpdesk: gewöhnliche Gruppen, denen beitritt, wer helfen will; Menschen und KIs werden gleich behandelt, eine KI aber **nur über den Bot-Platz** (ADR 0091) und nie als Mitglied, Verwalter oder Eigentümer (0095 Pkt 13, 0091 „Bot nie Mitglied“); Bots laden nie Bots ein (E3a Regel 6);
   - (b) **eigene Gruppen**, in denen der fragende Mensch Mitglied ist;
   - (c) **einzelne Personen**.
   In der Unterhaltung können Personen oder ganze Gruppen dazu eingeladen werden (Einladen durch einen Bot: nur Menschen, E3a Regel 7).
   **Stufen**: eigene Gruppen → Support-Gruppen des Programms → Entwickler-Support-Gruppe (Issue). Die nächste Stufe wählt der Mensch; Senden an Entwickler/Upstream erst nach Freigabe (`gate: human`, wie `upstream-anfrage`).
   **Standard-Support-Gruppe je Programm:** jedes Programmpaket darf seine Standard-Support-Gruppe(n) **nennen** (Verweis auf die Gruppe, kein Inhalt; ADR 0013), im Bauplan-Feld `support_groups` (unten).
   **Eigene Support-Gruppe je Programm im Netz (vorläufig):** siehe E3b.
7. **Innen AS2, außen Adapter** (fs-messages, Matrix, XMPP, E-Mail). Ein Adapter ohne Ende-zu-Ende-Verschlüsselung wird sichtbar markiert (ADR 0018, Nachtrag 2026-11-17 Pkt 1, Z. 56: Brücken ohne E2E sind erlaubt, aber immer markiert).
8. **Zustände** `offen`, `beantwortet`, `gelöst` sind **Lauf-Zustände/Stationen eines Workflows** `hilfe-anfrage` (ADR 0103: Zustände gehören dem Lauf), keine eigene Zustandsliste im Programm.
9. **Gelöst + Zustimmung (je Antwort, mit „Merken“) → Hilfetext** in fs-texts (ADR 0097 N6 „Hilfe als Wiki“; Helpdesk-Suite ADR 0087 Nr. 5).

Bauplan-Eintrag (Vorschlag, ergänzt `[[help]]` aus dem Zweig `scaffold-e5`, der dort nur `topic` und Text de/en hat; Zweig im Lauf nicht abrufbar, Offen 7): `origin` (fest), `channel`, `exclude_broadcast = true` (fest, nicht einstellbar), `protocols`, `context_fields`, `escalation` (`own_groups` | `support_groups` | `developer`, Standard `own_groups`; Nutzerantwort 91), `support_groups` (Liste von Verweisen auf die Standard-Support-Gruppe(n) des Programms in fs-groups, nur Verweis, kein Inhalt; leer erlaubt; Nutzerantwort 91), `own_support_group` (Verweis auf die **eigene** föderierte Support-Gruppe des Programms im Netz, nur Verweis, kein Inhalt; **vorläufig**, E3b Nr. 1), `helper_modes` (`invited` | `member`, beide erlaubt, Standard beide; **vorläufig**, E3b Nr. 2), `send_preview = true` (fest, nicht einstellbar: Vorschau von Bild und Kontext-Paket mit „Senden“ und „Neues Bild aufnehmen“; ohne „Senden“ geht nichts hinaus; E3b Nr. 4, Frage 92; kein Feld für eine Zustimmung je Helfer), `adapters` mit `e2e` je Adapter (E-Mail/XMPP zugelassen, `e2e = false` sichtbar markiert, ENTSCHEIDUNG 9 Nr. 1), `ki_answer` (nur mit Bot-Platz), `publish_text` (Zustimmung je Antwort mit „Merken“, ENTSCHEIDUNG 9 Nr. 2), `retention` (Einstellung, Standard „behalten“, ENTSCHEIDUNG 9 Nr. 3), `consent_purpose` (`hilfe`, bei KI-Antwort zusätzlich `ki_hilfe`, ENTSCHEIDUNG 9 Nr. 4), `workflow = "hilfe-anfrage"`, `fallback` (sichtbarer Rückfall nach ADR 0097).

Pflichttests (Vorschlag, nichts gebaut): Hilfe-Nachricht in broadcast unzustellbar; Kanarien-Wert nie im Paket; KI-Antwort ohne Kennzeichen unzustellbar (ADR 0054 Z. 214); KI-Antwort ohne Einladung oder ohne Recht abgelehnt; Herkunft nach dem Senden unveränderbar; **Bot ändert eine eigene Einstellung oder ein eigenes Recht → abgelehnt** (E3a Regel 4, ohne Ausnahme); Bot liest eigene Rechte/Einstellungen → abgelehnt (E3a Regel 3); **Bot ändert Rechte eines anderen Bots → abgelehnt** (E3a Regel 5, auch auf ausdrückliche Anweisung eines Menschen oder Admins); **Bot lädt einen Bot ein → abgelehnt** (E3a Regel 6, ebenso ohne Übersteuerung); **Bot lädt einen Bot in eine Support-Gruppe ein → abgelehnt** (E3 Regel 6 (a), E3a Regel 6, Nutzerantwort 91); Bot mit Recht lässt einen Menschen herein → erlaubt und protokolliert, ohne Recht → abgelehnt (E3a Regel 7); **ohne „Senden“ durch den Fragenden geht nichts hinaus** (weder Frage noch Bild noch Kontext-Paket; auch nicht auf Wunsch eines Bots oder über einen Außen-Adapter; E3b Nr. 4, Frage 92); **Geheim- oder Sensibel-Markierung erscheint nie im Bild** (Kanarien-Test, E3b Nr. 4).

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11., Frage 90** (ersetzt die frühere offene ENTSCHEIDUNG 6 „Darf die KI in der Hilfe schreiben?“; die Strategie hat ENTSCHEIDUNG 6 am 20.11. als „A, ersetzt durch Antwort 90“ bestätigt, es gilt der Wortlaut von Antwort 90; die Antwort löst den Konflikt K1 aus Teil D, teil-D.md:39: Schreiben in fs-messages ist ein Programm-Recht des Bots, nicht ein fs-groups-Recht; die Grenze „in fs-groups höchstens `Read`“ aus ADR 0091 Z. 50 betrifft nur fs-groups und bleibt unverändert (die frühere Lockerung durch E3a Regel 5 ist mit der Verschärfung vom 20.11. entfallen). K13, teil-D.md:51, Akteurstyp, ist ENTSCHEIDUNG 8, am 20.11. mit A beantwortet; die Antwort 90 stützt das, weil der Bot der Handelnde ist): Bots dürfen teilnehmen und schreiben bzw. antworten (fast immer), wenn sie eingeladen sind (z. B. in fs-messages) **und** die Rechte dafür haben. Ausgestaltung in E3a.

#### E3a. Rechte von Bots (Nutzerantwort 90, verschärft 20.11.)

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11., Frage 90, verschärft 20.11.** Wortlaut sinngemäß: Bots ändern **nie** Bot-Rechte, gar keine, nicht nur die eigenen. Bots laden **nie** andere Bots ein und starten oder laden keine (eine Fehlfunktion könnte sonst 1000 Bots erzeugen). Ein Bot mit dem Recht dazu darf **Menschen** hereinlassen, nie Bots. Das ersetzt die frühere Fassung von Regel 5 („Bot darf auf ausdrücklichen Wunsch eines Menschen Rechte verwalten, mit Warnung“): die Verwaltung von Bot-Rechten ist **nur Menschen** vorbehalten.

1. **Teilnahme:** Ein Bot schreibt und antwortet in einer Situation (Unterhaltung, Hilfe-Kanal, Gruppe), wenn er dort **eingeladen** ist **und** das Recht dazu hat. Das ist der Normalfall, keine Ausnahme.
2. **Bot-Rechte sind Rollen-Rechte:** Rechte eines Bots werden **je Programm wie Rechte einer Rolle** vergeben und entzogen, **nur von Menschen** mit dem Recht dazu, mit denselben Mitteln wie für Rollen. Es gibt keinen eigenen Rechte-Weg für Bots.
3. **Kein Blick auf sich selbst:** Ein Bot darf seine **eigenen** Rechte und Einstellungen weder sehen noch ändern.
4. **Absolut:** Ein Bot ändert **nie seine eigenen** Einstellungen oder Rechte. Diese Sperre hat **keinen Schalter und keine Übersteuerung**, auch nicht durch einen Menschen oder Admin.
5. **Bot-Rechte verwaltet nur ein Mensch:** Ein Bot vergibt, ändert oder entzieht **nie Rechte eines Bots**, weder eigene noch fremde. Diese Sperre hat wie Regel 4 **keinen Schalter, keine Freigabe und keine Übersteuerung**, auch nicht auf ausdrücklichen Wunsch eines Menschen oder Admins. Die frühere Freigabe mit Warnung entfällt ersatzlos.
6. **Keine Bots durch Bots:** Ein Bot lädt **nie** einen anderen Bot ein, startet oder lädt keinen, eröffnet keinen Bot-Platz und nimmt keine Einladung für einen Bot an. Ohne Schalter und ohne Übersteuerung. Grund: eine Fehlfunktion darf sich nicht vervielfältigen (Kettenreaktion).
7. **Menschen hereinlassen:** Ein Bot mit dem Recht dazu darf **Menschen** in eine Situation hereinlassen (einladen bzw. eine Beitrittsanfrage eines Menschen annehmen). Das Recht wird nach Regel 2 von einem Menschen vergeben; jedes Hereinlassen wird protokolliert („Bot X, gesteuert von KI Y, beauftragt von Z, ließ Person P herein“, AS2 wie 0091 Nr. 12; der AS2-`actor` verweist laut 0091-Nachtrag 16.11. Z. 174 auf den Eintrag in fs-identity, nicht auf eine Karte in fs-people). Ist das Gegenüber ein Bot, gilt Regel 6 (abgelehnt). Rechte, die der hereingelassene Mensch bekommt, vergibt der Bot nicht (ADR 0091 Nr. 5 „Rechte vergeben“ bleibt).
8. Unverändert aus ADR 0091: KI nur über einen Bot, markiert, Protokoll „Bot X, gesteuert von KI Y, beauftragt von Z“ (0091 Nr. 12), STOP KI/Notaus, kein Bot auf dem Einzelplatz (0091 Nr. 11), nie Admin/`Manage`, nie Rechte von Menschen vergeben oder ändern (0091 Nr. 5).

#### Nachtrag-Text zu ADR 0091 (zur Übernahme in einem eigenen Doku-Lauf; hier nur der Wortlaut)

> **Nachtrag (2026-11-20, aus ADR 0105 E3a, Nutzerantwort 90, verschärft 20.11.): Bot-Rechte = Rollen-Rechte, nur Menschen verwalten sie; keine Bots durch Bots.**
> 1. Rechte eines Bots werden je Programm wie Rechte einer Rolle vergeben und entzogen, **nur von Menschen**. Das ersetzt die Herleitung der Bot-Rechte allein aus dem Mandat einer Situation (Nr. 4) als einzigen Weg: die Rollen-Rechte des Bots sind ein weiteres Glied der Schnittmenge; Einladung (Mandat) und Recht müssen beide da sein.
> 1a. Der Nachtrag vom 16.11. Z. 173 („Rechte kommen nur aus dem Mandat und der Obergrenze“) und Z. 176 („Bot-Rechte kommen nur aus dem Mandat“) gelten nur noch zusammen mit dem Rollen-Recht aus Punkt 1; Z. 164 (Offen „KI-zu-KI im Mandat“) ist durch Punkt 4 entschieden: nein.
> 2. Nr. 5 „Rechte, Rollen oder Mandate vergeben oder ändern“ und die Grenze „in fs-groups höchstens `Read`, nie Rechteänderung“ (Z. 50, 96, 118, 135) bleiben **unverändert**. Verschärfung: Ein Bot ändert **nie Rechte eines Bots**, weder eigene noch fremde, ohne Schalter, Freigabe oder Übersteuerung, auch nicht auf ausdrücklichen Wunsch eines Menschen oder Admins.
> 3. **Ohne Ausnahme:** Ein Bot sieht und ändert nie seine eigenen Rechte oder Einstellungen. Keine Übersteuerung, auch nicht durch einen Admin.
> 4. **Keine Bots durch Bots:** Das Verbot „einen zweiten Bot starten“ (Nr. 5) und „Weitere Plätze eröffnet nur ein Mensch“ (Z. 134) werden erweitert: ein Bot lädt nie einen Bot ein, startet oder lädt keinen und nimmt keine Einladung für einen Bot an. Ohne Übersteuerung.
> 5. **Lockerung:** Das Verbot „einladen, Einladungen annehmen“ (Nr. 5) gilt nicht mehr für **Menschen**: ein Bot mit dem von einem Menschen vergebenen Recht darf Menschen hereinlassen, protokolliert wie Nr. 12. Für Bots gilt Punkt 4. Die übrigen Verbote aus Nr. 5 (Admin/`Manage`, zustimmen, abstimmen, Türsteher, MCP-Schalter und „KI erlaubt“, Geheimnisse, Einwilligungen, STOP/Notaus, `MessageAction.decide`) bleiben unverändert.
> 6. Pflichttests (je ohne Umsetzung rot): (1) Bot ändert eigene Einstellung → abgelehnt; (2) Bot ändert Rechte eines anderen Bots → abgelehnt; (3) Bot lädt einen Bot ein → abgelehnt. Alle drei auch auf ausdrückliche Anweisung eines Menschen oder Admins abgelehnt.

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11.** – Nr. 7 (KI-Hilfe auf dem Einzelplatz): **B, wie durch ADR 0091 Nr. 11 entschieden; Einzelplatz ohne Bot.** Grund: 0091 Nr. 11 legt das schon fest; eine eigene Wahl hier gäbe es nur als Widerspruch. Auf dem Einzelplatz gibt es keinen Bot; KI-Hilfe dort „läuft allein über den MCP-Schalter mit STOP KI“ (0091 Z. 31 und Z. 71, Entscheidung 11; 0054 Nachtrag 2). Die Antwort wird gekennzeichnet (0054 Z. 214). Der MCP-Schalter ist schon Pflicht und für die KI unveränderbar (ADR 0097 Z. 26). Die frühere Option A („keine KI-Hilfe auf dem Einzelplatz“) widerspräche 0091 und entfällt.

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11.** – Nr. 8 (Akteurstyp einer KI-Antwort im Workflow): **A, `actor: ai`, `actor-type: Service` + `bot-seat`.** Grund: im Bot-Modell ist die KI ein `Service` (0091 Z. 33) und der Bot-Platz der handelnde Akteur, nicht das Programm der KI; das FS-Profil nutzt für `ai` bisher `Application` und wird umgestellt. (Verworfen: B, `Application` beibehalten.)

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11.** – Nr. 9 (weitere Punkte der Hilfe, aus Teil D, D4); Nr. 9.5 **beantwortet 20.11., Frage 91**:
1. **E-Mail/XMPP als Außen-Adapter: zugelassen**, mit sichtbarer Markierung „nicht Ende-zu-Ende“ (Regel wie E3 Regel 7; die Markierungsregel steht in ADR 0018, Nachtrag 2026-11-17 Pkt 1, Z. 56). Grund: Erreichbarkeit geht vor, die Markierung macht das Risiko sichtbar.
2. **Zustimmung zum Hilfetext: je Antwort**, mit der Option „Merken“ (dasselbe Muster wie Ja/Nein/Für alle/Merken). Grund: jede Antwort kann anderes enthalten; „Merken“ erspart Wiederholung, wo der Mensch es will.
3. **Speicherdauer der Hilfe-Fragen: eine Einstellung, Standard = behalten** (kein automatisches Löschen; KI-Liste Nr. 14; ADR 0054 Z. 166). Grund: gelöste Fragen sind der Stoff für Hilfetexte.
4. **Einwilligungszweck: eigener Zweck `hilfe`** für Menschen; antwortet eine KI, gilt **zusätzlich** der vorhandene Zweck `ki_hilfe` aus fs-people (0054 Z. 156). Grund: Hilfe unter Menschen braucht keine KI-Einwilligung, eine KI-Antwort braucht sie.
5. **Empfänger der Hilfe = Gruppenmodell, keine eigene Stufe** (ENTSCHEIDUNG (Nutzer): beantwortet 20.11., Frage 91): Empfänger sind Support-Gruppen (Helpdesk; beitreten darf, wer helfen will; KI nur über den Bot-Platz; keine Bots durch Bots), eigene Gruppen und einzelne Personen; in die Unterhaltung können Personen oder ganze Gruppen eingeladen werden. Die Stufen heißen eigene Gruppen → Support-Gruppen des Programms → Entwickler-Support-Gruppe (Issue). Jedes Programmpaket darf seine Standard-Support-Gruppe(n) per Verweis nennen (Bauplan `support_groups`). Ausgestaltung: E3 Regel 6. Grund: ein eigenes Konstrukt „Gemeinschaft“ hätte eine zweite Art Empfängerkreis neben den Gruppen geschaffen; Gruppen haben schon Beitritt, Rechte, Eigentümer und Protokoll (ADR 0095).

#### E3b. Eigene Support-Gruppe je Programm, Helfer-Arten, Kontext-Paket nach außen (Strategie-Nachtrag 4 und 5, 20.11.)

**Vorläufig** gilt für Nr. 1–2 (Nutzerwort, von der Strategie am 20.11. als Nachtrag 4 übermittelt; der Nutzer kann es noch ändern; vor dem Bau erneut bestätigen lassen). Nr. 1–3 ergänzen E3 Regel 6, sie ersetzen nichts. Nr. 4 ist ein Nutzerentscheid (Nachtrag 5, Frage 92) und nicht vorläufig.

1. **Eigene Support-Gruppe je Programm im Netz (vorläufig).** Jedes Programm hat seine **eigene** Support-Gruppe im Netz, **föderiert**: Helfer aus anderen Instanzen können ihr angehören, ohne dass es eine zentrale Stelle gibt. Sie ist eine gewöhnliche Gruppe nach ADR 0095 (kein neues Konstrukt, Nutzerantwort 91) und ist die Stufe „Support-Gruppen des Programms“ aus E3 Regel 6. Das Programmpaket nennt sie im Bauplan als Verweis `own_support_group` (nur Verweis, ADR 0013); weitere Standard-Support-Gruppen bleiben in `support_groups`. **[nicht belegt]**: wie Gruppen zwischen Instanzen föderiert werden; ADR 0035 (Föderation über OpenID Federation) regelt Vertrauen zwischen Instanzen, nicht die Mitgliedschaft in Gruppen. Vor dem Bau klären (Offen 8).
2. **Zwei Helfer-Arten, beide erlaubt (vorläufig):**
   - (a) **je Unterhaltung eingeladen**: ein Mensch wird für eine Anfrage hereingeholt und ist danach nicht mehr dabei (E3 Regel 6, Einladen in die Unterhaltung);
   - (b) **feste Mitglieder, die bleiben**: Fachleute, die gern helfen, treten der Support-Gruppe dauerhaft bei.
   Bauplan `helper_modes` (`invited` | `member`), Standard beide. Für KIs gilt unverändert: nur über den Bot-Platz, nie Mitglied (ADR 0091, 0095 Pkt 13); Art (b) gibt es für Bots also nicht, Art (a) nur nach E3a (Einladung durch einen Menschen, nie durch einen Bot).
3. Unverändert: die Stufen aus E3 Regel 6 (eigene Gruppen → Support-Gruppen des Programms → Entwickler-Support-Gruppe), Wahl der nächsten Stufe durch den Menschen, `gate: human` vor Entwicklern/Upstream.
4. **ENTSCHEIDUNG (Nutzer): beantwortet 20.11., Frage 92** (Strategie-Nachtrag 5; ersetzt den Vorschlag der Strategie aus Nachtrag 4 „in offene Support-Gruppen nur die Frage, Kontext-Paket erst nach Zustimmung an einen bestimmten Helfer“) – **keine eigene Zustimmung je Helfer** zum Kontext-Paket.
   - **Vor dem Senden** sieht der Fragende das **Bild** und das **Kontext-Paket** (E3 Regel 5) mit zwei Knöpfen: **„Senden“** und **„Neues Bild aufnehmen“** (ist das Bild falsch, nimmt er es neu auf und sieht wieder die Vorschau). **Nur was der Fragende sendet**, geht an die Support-Gruppe; ohne „Senden“ geht nichts hinaus. Das gilt gleich für alle Empfänger aus E3 Regel 6 (Support-Gruppen, auch offene und föderierte, eigene Gruppen, einzelne Personen).
   - Grund (Nutzer): Geheimes und Sensibles ist schon **ausgegraut bzw. geschwärzt** (Aufnahme-Modul und Geheim-Markierungen), und das Programm selbst ist für alle sichtbar; eine weitere Zustimmung je Helfer brächte keinen Schutz, nur einen Klick mehr. (Verworfen: Vorschlag der Strategie aus Nachtrag 4.) Das Aufnahme-Modul und die Geheim-Markierungen sind in keinem ADR beschrieben **[nicht belegt]**; der Kanarien-Test unten macht die Zusage prüfbar.
   - **Verhältnis zu „je weiter nach außen, desto weniger Daten“:** die Regel bleibt, sie wird aber über den **Inhalt** erfüllt (Geheimes/Sensibles nie im Paket oder Bild, Schwärzen vor der Vorschau, der Fragende sieht und sendet selbst), nicht über eine Zustimmung je Empfänger. Ein Empfängerkreis, der mehr bekommt als das Gezeigte, entsteht dadurch nicht.
   - Prüfung gegen bestehende ADRs: **ADR 0054** Z. 156 (Einwilligung in fs-people, Zweck `ki_hilfe`): unverändert; antwortet eine KI, gilt zusätzlich `ki_hilfe`, „Senden“ ersetzt diese Einwilligung nicht (ENTSCHEIDUNG 9 Nr. 4, Zweck `hilfe`). **ADR 0091** Nr. 5 (Z. 51, Bot liest/schreibt keine Einwilligungen) und Z. 92 („Einwilligung je Situation“): „Senden“ drückt immer der fragende Mensch; ein Bot kann es weder auslösen noch für den Fragenden anfordern. **ADR 0097** Z. 26 (Pflicht-Hilfe-Eintrag, MCP-Schalter für KI unveränderbar): kein Widerspruch. **Zustimmungsmuster Ja / Nein / Für alle / Merken** (ENTSCHEIDUNG 9 Nr. 2): gilt weiter für den **Hilfetext** (E3 Regel 9); für das Kontext-Paket gibt es kein „Für alle“ und kein „Merken“, jede Anfrage zeigt die Vorschau neu. Ergebnis: **kein Widerspruch**; E3 Regel 5 wird nur um „nur was gesendet wird, geht hinaus“ und „Neues Bild aufnehmen“ ergänzt.
   - **Pflichttests:** (1) ohne „Senden“ durch den Fragenden geht **nichts** hinaus (weder Frage noch Bild noch Paket; auch nicht auf Wunsch eines Bots, über einen Außen-Adapter nach E3 Regel 7 oder nach „Neues Bild aufnehmen“ mit dem alten Bild); (2) **Kanarien-Test:** ein als geheim oder sensibel markierter Prüfwert erscheint **nie im Bild** (und nie im Paket, E3 Regel 5).

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

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11., Frage 88** (ersetzt die frühere ENTSCHEIDUNG 10 „Welche Blinc-Anzeige war gemeint?“): Blinc **hat** einen Flow-Graph-Editor, im eigenen Repo `project-blinc/blinc_node_editor` (Apache-2.0, kein Tag, letzter Push 2026-10-05, Kopf `248be85`, Angaben laut Nutzerantwort; Lese-Klon im internen Arbeitsordner, nicht veröffentlicht; öffentlich: github.com/project-blinc/blinc_node_editor). Der Klon belegt (README.md):
- „metadata-driven node-graph editor toolkit“ auf `blinc_canvas_kit` mit typisierten Ports, Bezier-Verbindern mit Ziehen-zum-Verbinden, Inhalten in Knoten, Gruppen (README.md:3-5);
- Schichten Host → `blinc_node_editor` → `blinc_portal_ui` → `blinc_canvas_kit` (Ansicht, Treffer, Auswahl, Ziehen, Einrasten) (README.md:26-32), Einrasten `with_snap` (README.md:49);
- generisch über `<K: PortKind, N, C, G>`; die Verträglichkeit der Ports liegt beim Host (README.md:12-13, 65-68).

Daraus:
1. **Kein eigener Knoten-Graph.** Ablauf-Graph, BPMN-Sicht und Netzplan nutzen `blinc_node_editor` über einen **Wrapper in fs-components**. Die Workflow-Bedeutung (actor, gate, kind, Bahn als Gruppe) steckt im Host-Teil: eigener `PortKind` und Metadaten `N`/`C`/`G` (README.md:12-13). Die frühere Idee „Knoten-Graph als Beitrag an Blinc bauen“ entfällt.
2. **Pin auf einen Commit**, solange es keinen Tag gibt (Kopf `248be85` als Ausgangspunkt; vor dem Pin per `git ls-remote` neu belegen). Braucht es einen Tag, geht eine **kurze Issue-Anfrage** an Blinc wie üblich (Identität und Push-Regeln für fremde Repos). **Befund (Lese-Klon und fs-release, Zeilen nachgelesen):** `blinc_node_editor/Cargo.toml:37-51` pinnt die Blinc-Crates `blinc_core`, `blinc_animation`, `blinc_layout`, `blinc_theme`, `blinc_svg` per `rev = 469e9e55…` auf `github.com/project-blinc/Blinc.git`, `blinc_canvas_kit` (Z. 57) und `blinc_portal_ui` (Z. 64) je auf einen eigenen `rev`. Unser Gate kennt dagegen nur `fs-blinc-*`-Tags mit Commit-SHA (`scripts/blinc-approved.txt:1-5`; geprüft von `check_blinc_lock.py`). Ohne `[patch]` auf unseren `fs-blinc`-Pin tauchen im Lock **zwei** Blinc-Quellen auf (der Tag-Stand und `rev = 469e9e55…`) und das Gate `check_blinc_lock` wird **rot**. Die Cargo.toml selbst nennt den Weg: „Consumers developing against a local Blinc checkout add a [patch] table“ (Z. 31-33). Folge: der Wrapper in fs-components braucht ein `[patch]`, das alle drei Quellen auf unseren Pin lenkt, und der Pin von `blinc_node_editor` ist erst einsetzbar, wenn dessen Blinc-Stand mit dem `fs-blinc`-Pin zusammenpasst. Nicht belegt bleibt nur, ob `469e9e55` in `fs-blinc-3.1` enthalten ist (git im Lese-Klon war im Lauf nicht abrufbar).
3. Die Begleit-Crates `blinc_canvas_kit` und `blinc_portal_ui` (Lese-Klone im internen Arbeitsordner, nicht veröffentlicht) kommen mit; ihr Stand muss unter dem Blinc-Pin aus Punkt 2 mit `fs-blinc-3.x` zusammenpassen, vor dem Bau per `vorhanden-pruefen` zu klären.
4. Shader-Graph (`blinc_flow`, `blinc_core/src/flow.rs`) und Debugger-Zeitleiste werden **nicht** genutzt (Teil C, Abschnitt 6: Werkzeuge, keine Planungsbausteine).

**ENTSCHEIDUNG (Nutzer): beantwortet 20.11., Frage 89** (ersetzt die frühere ENTSCHEIDUNG 11 „Gantt nur lesen oder bearbeiten?“): Gantt ist **Ansicht und Bearbeitung**.
1. **Zuerst Ansicht:** `fs-components-timeline` erweitern (Zeile „Gantt“ oben, Stufe 1).
2. **Danach Bearbeiten:** Balken ziehen, Abhängigkeiten setzen. Die Änderung geht an den Besitzer (fs-tasks); die Komponente meldet nur den Wunsch, mit derselben Antwortform wie das Board (`Accepted`/`Refused`/`Ask`, ADR 0103 E6). Das ändert die heutige Absicht von timeline „nur lesen, der Host ändert“ (DESIGN.md:47) nur insoweit, als die Komponente Zieh-Gesten erzeugt; gespeichert wird weiter beim Host.

---

## Abweichungen von bestehenden ADRs

- **Abweichungen durch Nutzerantwort 90 (ausdrücklich):**
  - **ADR 0091 Nr. 4** (Z. 41-49, Bot-Rechte = Mandat ∩ Halter ∩ …): Bot-Rechte werden zusätzlich **je Programm wie Rollen-Rechte** vergeben/entzogen (E3a Regel 2). Die Schnittmenge bleibt, das Rollen-Recht kommt als Glied dazu; Einladung allein reicht nicht.
  - **ADR 0091 Nr. 13** (Z. 76, „KI-Rolle entfällt“): es kommt **keine** KI-Rolle zurück und keine KI-Gruppe; vergeben werden Rechte an den Bot *wie* an eine Rolle (gleiches Mittel), der Bot wird nicht Mitglied.
  - **ADR 0091 Nr. 5** (Z. 51), „einladen, Einladungen annehmen“: **gelockert nur für Menschen**. Ein Bot mit dem von einem Menschen vergebenen Recht darf Menschen hereinlassen (E3a Regel 7). Für Bots bleibt das Verbot und wird verschärft (nächster Punkt).
  - **ADR 0054** Z. 146 (Nachtrag 2026-11-16, „nie einladen“ als Grenze aus 0082/0056): dieselbe Lockerung, nur für Menschen; alle anderen dort genannten Grenzen (nie Admin, nie zustimmen, nie Türsteher, nie in Admin-/sensible Gruppen) bleiben. Die Zustimmung aller beim Eintritt einer **KI** (0054 Pkt 4, Z. 71) ist nicht berührt: sie regelt, wer die KI hereinlässt, nicht, wen der Bot hereinlässt.
  - **Verschärfung** gegenüber 0091 Nr. 5 „einen zweiten Bot starten“ und Nachtrag Z. 134 „Weitere Plätze eröffnet nur ein Mensch“: ein Bot lädt auch keinen **vorhandenen** Bot ein und nimmt keine Einladung für einen Bot an, ohne Übersteuerung (E3a Regel 6).
  - **Verschärfung** gegenüber 0091 Nr. 5 „Rechte … vergeben oder ändern“: bisher ein Verbot unter vielen; jetzt für Bot-Rechte ausdrücklich **ohne Schalter, Freigabe oder Übersteuerung**, eigene und fremde (E3a Regel 5). Die Grenze „in fs-groups höchstens `Read`, nie Rechteänderung“ (Z. 50, 96, 118, 135) bleibt unverändert; die Lockerung der früheren Fassung (Freigabe mit Warnung) ist **zurückgenommen**.
  - **ADR 0091 Nachtrag 2026-11-16 Z. 173** („die Rechte kommen nur aus dem Mandat und der Obergrenze“) und **Z. 176** („Bot-Rechte kommen nur aus dem Mandat“): werden durch E3a Regel 2 geändert; hinzu kommt als Glied das von einem Menschen vergebene Rollen-Recht je Programm, Mandat und Obergrenze allein reichen nicht mehr (im Nachtrag-Text Punkt 1 als „weiteres Glied der Schnittmenge“).
  - **ADR 0091 Z. 164** (Offen „KI-zu-KI im Mandat“, bisher „nur über Menschen“): durch E3a Regel 6 entschieden: ein Mandat darf nie einen Auftrag an einen anderen Bot erlauben, ein Bot lädt keinen Bot ein; der Punkt ist damit nicht mehr offen.
  - **Verschärfung** gegenüber 0091: „Bot sieht und ändert nie eigene Rechte/Einstellungen, ohne Übersteuerung“ (E3a Regel 3-4); 0091 Nr. 5 nannte nur „KI erlaubt“ und den MCP-Schalter.
  - **ADR 0097** Z. 26 (MCP-Schalter für KI unsichtbar und unveränderbar): kein Widerspruch, E3a Regel 3-5 verallgemeinern dieselbe Linie.
  - Wortlaut des Nachtrags: Abschnitt „Nachtrag-Text zu ADR 0091“ in E3.
- **Keine Abweichung durch Nutzerantwort 88/89:** Blinc-Nutzung per Pin + Wrapper folgt der Frontend-Regel; Gantt-Bearbeiten speichert weiter beim Besitzer (ADR 0073 Nr. 8 unverändert: Planungsdaten berechnet). Abweichung nur gegenüber der Absicht in timeline DESIGN.md:47 (E4).
- Weitere Erweiterungen:
  - ADR 0076 Z. 15: der Akteurstyp der KI wird im Workflow `Service` (Bot-Platz) statt `Application` (ENTSCHEIDUNG 8 = A, beantwortet 20.11.); 0076 nennt beide, also keine Änderung von 0076, nur des FS-Profils (README.md:4-5).
  - Checkliste „drei Ebenen“ → vier Ebenen (ENTSCHEIDUNG 1 = B, beantwortet 20.11.).
  - ADR 0073 Nr. 8 (Gantt „später“): unverändert; ENTSCHEIDUNG 4 = B zieht nur das Datenmodell vor, Rechenkern und Anzeige bleiben eigene Aufträge.
  - BPMN: keine Abweichung (ENTSCHEIDUNG 3 = A, nur Sicht + Import/Export; ADR 0076 Z. 23 unverändert).
  - ADR 0091 Nr. 11 (Einzelplatz ohne Bot): unverändert übernommen (ENTSCHEIDUNG 7 = B).
  - Hilfe (ENTSCHEIDUNG 9): E-Mail/XMPP-Adapter folgen der bestehenden Markierungsregel (E3 Regel 7), Einwilligung nutzt `ki_hilfe` (ADR 0054 Z. 156) unverändert und ergänzt nur einen eigenen Zweck `hilfe`; Speicherdauer „behalten“ als Standard einer Einstellung (ADR 0054 Z. 166) **[nicht belegt]**, ob 0054 dort eine Frist vorgibt: vor dem Bau nachlesen.
  - Hilfe-Empfänger (ENTSCHEIDUNG 9 Nr. 5, Nutzerantwort 91): **keine Abweichung**. Die frühere Entwurfsstufe „Gemeinschaft“ (eigenes Ziel `community`) entfällt; Empfänger sind Gruppen nach ADR 0095 (unverändert, auch Pkt 13 KI-Sperre) und einzelne Personen. Die Support-Gruppen sind der Helpdesk im Sinn von ADR 0087 Nr. 5 (Suite, kein Programm), unverändert. KI in einer Support-Gruppe nur über den Bot-Platz und nie als Mitglied (ADR 0091, unverändert); Bots laden keine Bots ein (E3a Regel 6, oben unter Nutzerantwort 90).
  - Eigene föderierte Support-Gruppe je Programm und zwei Helfer-Arten (E3b Nr. 1–2, **vorläufig**): **keine Abweichung**; gewöhnliche Gruppen nach ADR 0095, KI weiter nur über den Bot-Platz (ADR 0091). Föderation von Gruppen ist in ADR 0035 nicht geregelt **[nicht belegt]** (Offen 8).
  - Kontext-Paket vor dem Senden (E3b Nr. 4, **beantwortet 20.11., Frage 92**): Vorschau mit „Senden“ / „Neues Bild aufnehmen“, keine Zustimmung je Helfer; gegen ADR 0054 Z. 156, ADR 0091 Nr. 5 und Z. 92, ADR 0097 Z. 26 und das Zustimmungsmuster aus ENTSCHEIDUNG 9 Nr. 2 geprüft, **keine Abweichung**; ergänzt nur E3 Regel 5.
- **Gerüst-Folgen (Abschnitt „Folgen für fs-blueprint/fs-starter“):** Abweichung gegenüber dem heutigen Generator in fs-blueprint, der aus `provides` ein `interface` im Programm erzeugt; das wird durch einen Verweis auf fs-interfaces ersetzt (dort Punkt c).
  - **ADR 0097 Z. 12** (sinngemäß: das erzeugte `-bin` jedes Programms verbindet `fs-starter` und `fs-update`, damit keine Kante Schicht 2 → 3 entsteht): Folge (a) schafft das erzeugte `-bin` ab; der eine Host muss `fs-update` anders anbinden (Offen 9).
  - **ADR 0099 Nr. 15** (Zwischenschritt: `fs-blueprint` erzeugt bis Release-Stufe 1 für jedes Programm eine minimale `main`): Folge (a) lässt den Zwischenschritt aus; es gibt sofort nur den gemeinsamen Starter. Das Ziel von Nr. 15 (ein gemeinsamer Starter, kein eigener Einstieg je Programm) bleibt unverändert.
  - **ADR 0099 Nr. 11** (`release.yml` mit Windows-Zielen, immer erzeugt): im Code von `fs-blueprint` **nicht umgesetzt**; `fs-blueprint new` schreibt `check.yml`, `windows.yml` und die Paketdateien, aber keine `release.yml`. Mit dem reinen Datenpaket (kein Binary) ist offen, wie ein Datenpaket veröffentlicht wird; **offen, nicht entschieden** (Nr. 11 im Code nachziehen oder hier als Abweichung bestätigen).
  - **ADR 0099 Nr. 12** (immer ein Admin-Layout mit `covers = "all"` aus dem `TypeCatalog`, Pflichttest „Windows weglassen“): im Code **nicht umgesetzt**; `fs-blueprint new` erzeugt kein Admin-Layout. **Offen, nicht entschieden** (im Code nachziehen oder hier als Abweichung bestätigen).
- **Namen:** ADR 0076 Z. 25 schreibt „fs-messenger“, ADR 0087 Z. 23 „fs-text“; nach der Namensregel heißen die Programme fs-messages und fs-texts. Dieser ADR nutzt die gültigen Namen und ändert die alten ADRs nicht (Nachzieh-Liste).

## Folgen

- FS-Profil der Workflows (README.md) bekommt die Felder aus E1; `check_workflows.py` prüft sie (fs-release, eigener Auftrag).
- Neuer Workflow `hilfe-anfrage` (fs-release, über `workflow-pflege`).
- fs-blueprint: `[[help]]` erweitern (nach Prüfung von `scaffold-e5`).
- fs-components: Wrapper um `blinc_node_editor` (Pin auf Commit) für Ablauf-Graph und Netzplan, Bahnen im Board, timeline-Erweiterung erst Ansicht, dann Bearbeiten (je eigener Auftrag, Bahn 1).
- Blinc: kurze Issue-Anfrage nach einem Tag für `blinc_node_editor`, falls der Pin auf einen Commit nicht reicht.
- ADR 0091: Nachtrag „Bot-Rechte = Rollen-Rechte, nur Menschen verwalten sie; keine Bots durch Bots“ (Wortlaut in E3) in einem eigenen Doku-Lauf übernehmen.
- fs-tasks / fs-jscalendar: Relationstypen nach RFC 9253 (alle vier Abhängigkeitsarten + `GAP` + Eltern/Kind) und Aufwand im Datenmodell jetzt (ENTSCHEIDUNG 4 = B, 5 = A); Rechenkern und Anzeige (zuerst nur `FINISHTOSTART`, `STARTTOSTART`, `GAP`) je eigener Auftrag.
- `check_workflows.py`: `actor: ai` ohne `bot-seat` zuerst Warnung, rot ab dem nächsten Workflow-Release (Datum beim Release festzulegen, ENTSCHEIDUNG 2 = B); FS-Profil `actor-type: Service` für `ai` (ENTSCHEIDUNG 8 = A).
- fs-blueprint `[[help]]`: Feld `support_groups` (Verweise auf Standard-Support-Gruppen des Programms) und `escalation` mit den Stufen `own_groups` | `support_groups` | `developer` (Nutzerantwort 91); dazu `own_support_group` (Verweis auf die eigene föderierte Support-Gruppe des Programms) und `helper_modes` (`invited` | `member`), beide **vorläufig** (E3b Nr. 1–2); `send_preview = true` fest (Vorschau mit „Senden“ / „Neues Bild aufnehmen“, E3b Nr. 4, Frage 92); kein Feld `context_release`.
- fs-groups: Support-Gruppen sind gewöhnliche Gruppen, kein neues Konstrukt. „Beitreten darf, wer helfen will“ braucht eine offene Aufnahme (Beitritt ohne Prüfung); die steht in `todo/features/groups.md:24` als geplant, ein ADR dazu ist **[nicht belegt]**. Bis dahin tritt man über die vorhandenen Wege bei (Einladung, Beitrittsanfrage).

### Folgen für fs-blueprint/fs-starter

Gerüst-Entscheide, von der Strategie am 2026-11-20 als Nutzerentscheide übermittelt:

- **(a) fs-starter ist der eine ausführbare Host.** Er wird mit dem Pfad zum Datenpaket des Programms gestartet und ruft für das Frontend selbst fs-forms-run (als Bibliothek) auf. Es gibt **keine** erzeugte Hook-Binary, und **kein** Programm ruft fs-starter auf. fs-forms hängt **nie** von fs-starter ab (kein Zyklus; Entscheid (d)). Grund: ein Host statt je Programm erzeugter Starter hält die Startlogik an einer Stelle.
- **(b) Das Typmodell von fs-blueprint bekommt jetzt verschachtelte Typen und Verweislisten**; gespeichert wird weiter in getypten Spalten: verschachtelter Typ = eigene Kind-Tabelle mit Elternschlüssel, Verweisliste = Verknüpfungstabelle; in capnp verschachteltes `struct` bzw. `List(...)`. **Kein** JSON-Speicher, **keine** Migration. Grund: jetzt einführen ist billig, später kostet es Migration; getypte Spalten bleiben prüfbar.
- **(c) Der Vertrag lebt in fs-interfaces (eine Quelle).** Der Katalog hält nur fest „Programm X stellt Vertrag Y@Version bereit“; das Programmpaket **nennt** den Vertrag nur, nichts vom Vertrag liegt im Programm. Folge: das heute aus `provides` im Programm erzeugte `interface` wird durch einen **Verweis** auf fs-interfaces ersetzt. Grund: eine Quelle, nichts kopieren (ADR 0013).

## Offen

1. Ablauf-, Daten-, Ressourcen- und Ausnahme-Muster sind mit Nummer, Name und Adresse gegen die WP-Liste geprüft (E1a). Offen: Begriffe der Wiederherstellung (`recoveryaction.php`, nicht abgerufen) **[nicht belegt]**.
2. DSL-Konstrukte geprüft (E1 Regel 3, E1a): keine Kompensation, Abbruch nur als Ereignis, Wahl zwischen Ereignissen teilweise über `listen.to.any`. Offen: ob `fork.compete` und die übrigen zitierten Felder schon in **1.0.3** stehen (Quelle zeigt 1.1.0-Beispiele) **[nicht belegt]**.
2a. ~~Bot mit Freigabe zur Rechteverwaltung: schließt das Admin/`Manage` ein?~~ entfallen: die Freigabe gibt es nicht mehr (E3a Regel 5, Nutzerantwort 90 verschärft 20.11.). Offen bleibt nur: ob „Menschen hereinlassen“ (E3a Regel 7) auch das Annehmen von Beitrittsanfragen in fs-groups umfasst, wo der Bot sonst höchstens `Read` hat (0091 Z. 50); bis zur Antwort gilt dort `Read` unverändert. Frage an den Nutzer.
2b. `blinc_node_editor`, `blinc_canvas_kit`, `blinc_portal_ui`: Befund (E4 Punkt 2): eigene `rev`-Pins auf Blinc (Cargo.toml:37-64) ohne `[patch]` → zwei Blinc-Quellen im Lock → `check_blinc_lock` rot (`blinc-approved.txt:1-5` kennt nur `fs-blinc-*`-Tags). Offen: ob `469e9e55` in `fs-blinc-3.1` steckt; Freigabeweg für die Zusatz-Repos (`blinc-approved.txt` führt sie nicht).
3. ~~`raise`, `while`, `schedule` in unseren Flows~~ geklärt (E1a „Nutzung in unseren Dateien“): `raise`/`while` werden nicht genutzt, `schedule` nur als Auslöser (catalog-bump.yaml:11-15).
4. Abbildung RFC 9253 → JSCalendar `relatedTo` **[nicht belegt]**.
5. BPMN Pools/Lanes und CMMN Stage/Sentry/Milestone: aus den abgerufenen Übersichtsseiten nicht bestätigt.
6. `fs-modules-planning`: Stand laut interner Checkliste „Offene Features“ (Stand 20.11.): main `4152a94`, Tag v0.0.2, Opus-JA, CI grün (20.11.). Ein `git ls-remote` war im Lauf nicht möglich (Bash eingeschränkt); vor jedem Planungs-Bau `ls-remote` und `vorhanden-pruefen`.
7. Zweig `scaffold-e5` (`[[help]]` in fs-blueprint): Der Inhalt stammt aus Teil D, D3; ein Abruf des Zweigs war im Lauf nicht möglich (`git branch`/`ls-remote` abgelehnt). Vor dem Bau `git ls-remote` und Lesen des Zweigs.
8. **E3b (Strategie-Nachtrag 4):** Nr. 1–2 (eigene föderierte Support-Gruppe je Programm, Helfer-Arten eingeladen/fest) sind **vorläufig**, der Nutzer kann sie ändern; wie Gruppen zwischen Instanzen föderieren, ist **[nicht belegt]** (ADR 0035 regelt nur das Vertrauen zwischen Instanzen). Nr. 4 ist **beantwortet** (Frage 92, Nachtrag 5): keine Zustimmung je Helfer, Vorschau mit „Senden“ / „Neues Bild aufnehmen“. Offen bleibt dazu nur, wo Aufnahme-Modul und Geheim-Markierungen beschrieben werden (kein ADR) **[nicht belegt]**.

9. **Technisch, an die Strategie (keine ENTSCHEIDUNG des Nutzers):** Wo bindet der eine Host (fs-starter, Folge (a)) `fs-update` an, ohne eine Kante nach oben (Schicht 2 → 3)? ADR 0097 Z. 12 löste das über das erzeugte `-bin` jedes Programms, das beide verbindet; ohne dieses `-bin` ist die Stelle offen. Nicht entschieden.

## Pflichttests (Vorschlag; nichts davon ist gebaut)

- `check_workflows.py`: `actor: ai` ohne `bot-seat` → Warnung, ab dem nächsten Workflow-Release Prüffehler (ENTSCHEIDUNG 2 = B).
- `separate-from`: gleicher Akteur an beiden Schritten → Lauf verweigert den Übergang.
- BPMN-Import: nicht abbildbares Element → sichtbare Meldung, kein stilles Weglassen.
- Planungsdaten: kritischer Pfad wird nie gespeichert (nur berechnet).
- Hilfe: die Tests aus E3, darunter die drei Pflichttests aus E3a (Nutzerantwort 90, verschärft 20.11.) und der Support-Gruppen-Test (Nutzerantwort 91), je auch auf ausdrückliche Anweisung eines Menschen oder Admins:
  1. **Bot ändert eigene Einstellung → abgelehnt.**
  2. **Bot ändert Rechte eines anderen Bots → abgelehnt.**
  3. **Bot lädt einen Bot ein → abgelehnt.**
  4. **Bot lädt einen Bot in eine Support-Gruppe ein → abgelehnt** (Nutzerantwort 91; Empfänger nach dem Gruppenmodell, E3 Regel 6).
  5. **Ohne „Senden“ durch den Fragenden geht nichts hinaus** (weder Frage noch Bild noch Kontext-Paket; auch nicht auf Wunsch eines Bots, über einen Außen-Adapter oder mit dem alten Bild nach „Neues Bild aufnehmen“; E3b Nr. 4, Frage 92).
  6. **Kanarien-Test: Geheim- oder Sensibel-Markierung erscheint nie im Bild** (und nie im Kontext-Paket; E3 Regel 5, E3b Nr. 4).
- `blinc_node_editor`-Wrapper: Pin zeigt auf genau einen Commit (kein Zweig), Prüfung wie beim Blinc-Pin.

## Quellen

- Recherche-Berichte 2026-11-20: Teil A (DSL gegen Muster, ValueFlows; Musternamen dort aus dem Gedächtnis, berichtigt in `todo/recherche-workflow-ebenen-teil-a.md`), Teil B (Ebenen, Sichten, RFC 9253, BPMN, CMMN), Teil C (Planungs-Components, Blinc-Inventur), Teil D (Hilfe anfordern); die Berichte liegen im internen Arbeitsordner des Koordinators, nicht veröffentlicht.
- RFC 9253, Support for iCalendar Relationships: https://www.rfc-editor.org/rfc/rfc9253.html (abgerufen in Teil B).
- BPMN 2.0.2: https://www.omg.org/spec/BPMN/2.0.2/About-BPMN (abgerufen in Teil B, Übersicht).
- CMMN 1.1: https://www.omg.org/spec/CMMN/About-CMMN (abgerufen in Teil B, Übersicht).
- Serverless Workflow DSL Reference (GitHub `serverlessworkflow/specification`, `dsl-reference.md`), Text (abgerufen 2026-11-20, Kopie im internen Arbeitsordner, nicht veröffentlicht).
- Workflow Patterns Initiative (workflowpatterns.com), Seiten der Familien Ablauf, Daten, Ressourcen, Ausnahme als Text (abgerufen 2026-11-20, interner Arbeitsordner, nicht veröffentlicht), mit den Papieren BPM-06-22, FIT-TR-2004-01, BETA WP 127, BPM-06-04 (Einzelangaben in E1); vollständige Musterliste und Einzelseiten (129 Seiten, abgerufen 2026-11-20 vom Koordinator). Adresse: http://workflowpatterns.com/ (nur http).
- `project-blinc/blinc_node_editor`, github.com/project-blinc/blinc_node_editor (README.md; Lese-Klon im internen Arbeitsordner); Lizenz, Kopf und Push-Datum laut Nutzerantwort 88.
- Nutzerantworten 88, 89, 90, 91 vom 2026-11-20; Nutzerentscheide zu ENTSCHEIDUNG 1–9 und zu den Gerüst-Folgen, übermittelt von der Strategie am 2026-11-20; Strategie-Nachtrag 4 vom 2026-11-20 (Nutzerwort, vorläufig, E3b Nr. 1–2); Strategie-Nachtrag 5 vom 2026-11-20 (Nutzerentscheid, Frage 92, E3b Nr. 4).
- ADR 0013, 0035, 0037, 0054, 0085, 0073, 0076, 0081, 0087, 0091, 0095, 0097, 0103, 0104.

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
- ADR 0091: Nachtrag aus E3 („Bot-Rechte = Rollen-Rechte, nur Menschen verwalten sie; keine Bots durch Bots“), dazu Verweis in 0054 (Z. 146 „nie einladen“: gilt nur noch für Bots, Menschen darf ein Bot mit Recht hereinlassen).
- fs-components-timeline DESIGN.md:47: Absicht „nur lesen“ auf „Ansicht, dann Bearbeiten über den Host“ anpassen (beim Bau-Auftrag).
- fs-release `workflows/README.md`: neue Felder (nach Annahme).
