# 0105 – Workflow-Ebenen, Prozess-Sichten, Hilfe anfordern: vier Ebenen je Schritt, eine Quelle mit mehreren Sichten, Hilfe als Pflichtteil des Gerüsts

Status: **Entwurf** (2026-11-20; Workflow `adr-write`, Schritt `draft`; Grundlage: vier Recherche-Berichte vom 2026-11-20, siehe „Quellen“; Prüfung durch Opus und Entscheide des Nutzers stehen aus) · **konkretisiert** ADR 0076 Zeile 18, 21–24 und Regel 1 (ValueFlows-Begriffe als Felder je Schritt) · **baut auf** ADR 0103 (Lauf, Station, Bahn = Achse Y) und ADR 0104 E9 (Befehlsketten sind Workflows) · **konkretisiert** ADR 0097 N6 („Hilfe als Wiki“) und den Pflicht-Hilfe-Eintrag (0097 Z. 26, Meilenstein M2) · **verwendet** ADR 0054 (KI markiert), 0091 (KI nur über Bot-Platz), 0087 Nr. 5 (Helpdesk ist eine Suite), 0037 (Ordner = Gruppe), 0073 Nr. 8 (Planungsdaten berechnet, nicht gespeichert), 0013 (nichts kopieren), 0081 (CloudEvents)

**Nummer:** **0105**. Herleitung: `conventions/decisions/` auf dem Zweigstand (aus main, Kopf d1d7315d) endet bei `0104-moduldaten-gehoeren-dem-modul.md`.

**Sprache:** nur Deutsch, wie alle ADRs im Repo.

**Lesehinweis:** Jede Aussage, die nicht aus einer abgerufenen Quelle oder einer Datei mit Zeilennummer stammt, ist mit **[nicht belegt]** markiert. Das betrifft vor allem die Namen der Workflow-Muster (workflowpatterns.com war nicht erreichbar, TLS-Fehler) und alles, was die Serverless-Workflow-Spezifikation über unsere Dateien hinaus kann (Spezifikationsseite 404). Diese Aussagen sind **nicht geprüft**; die Liste „Quellen zum Nachprüfen“ am Ende nennt, was vor der Annahme zu prüfen ist.

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
6. **Komponenten**: `fs-components-timeline` hat Balken, Meilenstein, Fortschritt, Ende→Anfang-Pfeile, Zoom, Heute-Linie; nicht: Ziehen, Start→Start/Ende→Ende, Verzögerung, kritischer Pfad, Gruppen (Teil C, Abschnitt 5, DESIGN.md:47-49). `fs-components-kanban` hat Spalten, keine Zeilen. Einen Knoten-/Flow-Graphen gibt es weder in fs-components noch in Blinc (Teil C, Abschnitt 6).
7. **Hilfe**: ADR 0097 verlangt je Programm einen Hilfe-Eintrag mit Inhalt oder sichtbarem Rückfall (Z. 26) und ordnet das Hilfe-Modul der Hülle M2 zu (Z. 35); N6 heißt „Hilfe als Wiki“ (Z. 7). Die Ideen des Nutzers vom 20.11. stehen in der Checkliste (Teil D, D1, 12 Punkte). Auf main in `fs-blueprint` gibt es keinen `help`-Eintrag; der Zweig `scaffold-e5` hat einen `[[help]]`-Eintrag mit `topic` und Text de/en (Teil D, D3; Zweig nicht geprüft).

Lücken (Teil A, Abschnitt 6, gekürzt): kein Ressourcen- und Zeitmodell; `actor: ai` ohne Bot-Platz (ADR 0091); keine Rollen/Zuteilung; Joins nur „alle“; keine Wahl zwischen Ereignissen; kein Abbruch eines Falls; keine Kompensation; Daten nur flach.

---

## Entscheidung

### E1. Vier Ebenen je Schritt: Ablauf, Daten, Ressourcen, Ausnahme

Die Checkliste nennt drei Ebenen (Control, Data, Resource). Dieser Entwurf macht **vier** daraus und nimmt **Ausnahme** als eigene Ebene dazu. Grund (Logik, nicht Mode): Ausnahmen (Zeitgrenze, Fehler, Abbruch, Rückbau, Eskalation) schneiden quer durch die drei anderen Ebenen; als Teil der Ablauf-Ebene würden sie in jeder Verzweigung wiederholt, als eigene Ebene stehen sie einmal je Bereich. Die Einteilung in Ablauf-, Daten-, Ressourcen- und Ausnahme-Muster folgt der Workflow-Patterns-Sammlung von van der Aalst, ter Hofstede u. a. **[nicht belegt]** (Quelle nicht erreichbar).

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
   - **Kompensation**: ein Schritt darf `freesynergy.net:compensate: <schritt>` nennen; bei Abbruch nach diesem Schritt läuft der Rückbau-Schritt. Grund: ohne Rückbau bleiben halbe Zustände (z. B. Tag gesetzt, Release nicht gebaut). Ob Serverless Workflow 1.0 dafür ein eigenes Konstrukt hat: **[nicht belegt]**; ist es da, wird es statt des FS-Felds genutzt.
   - **Eskalation an den Menschen** bleibt `switch` → Schritt mit `gate: human` (heute belegt, README.md:52-55).
4. **Ablauf-Lücken werden nur nach Bedarf geschlossen.** Join „einer von n“ (Discriminator), Partial Join, Deferred Choice und Milestone **[nicht belegt]** als Musternamen: sie kommen erst, wenn ein echter Ablauf sie braucht, und dann zuerst mit Mitteln der Spezifikation (z. B. `listen` mit mehreren Ereignissen **[nicht belegt]**).
5. **Ereignisse**: jeder abgeschlossene Schritt eines Laufs erzeugt ein `EconomicEvent` bzw. eine AS2-Aktivität in fs-history (ADR 0076 Z. 24, 0103 E7 `Move`); nach außen als CloudEvent (ADR 0081). Der Workflow schreibt dafür nichts selbst; das macht der Lauf (`fs-flow`).

**ENTSCHEIDUNG (Nutzer) 1: Drei oder vier Ebenen?**
- A: drei Ebenen wie in der Checkliste; Ausnahmen gehören zur Ablauf-Ebene.
- B: vier Ebenen, Ausnahme eigenständig (wie oben).
- **Empfehlung: B**, weil Abbruch, Rückbau und Eskalation in jedem Zweig gleich gelten und sonst je Zweig kopiert würden.

**ENTSCHEIDUNG (Nutzer) 2: Wie streng ist `bot-seat`?**
- A: Prüffehler (rot) in `check_workflows.py`, sobald `actor: ai` ohne `bot-seat`.
- B: zuerst Warnung, rot ab dem nächsten Workflow-Release.
- **Empfehlung: B** mit festem Datum, weil heute alle `ai`-Schritte (u. a. entscheidung.yaml:30-31) das Feld nicht haben und sonst alle Flows auf einmal rot würden.

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

1. **Fragen stellt ein Mensch.** Antworten kommen von Menschen, von einer KI **nur über einen Bot-Platz** und gekennzeichnet (ADR 0054, 0091), oder von beiden.
2. **Ein Hilfe-Kanal je Programm** als Ordner in fs-messages; Ordner = Gruppe (ADR 0037). In fs-messages auf Wunsch zusammen angezeigt.
3. **Herkunft ist fest an der Frage** (Programm, Version) und nicht änderbar. fs-messages filtert danach.
4. **Hilfe erscheint nie in broadcast.** broadcast abonniert nur seinen eigenen Ordner. Die Trennung ist ein Pflichttest, kein Filter-Standard.
5. **Kontext-Paket** (Programm, Version, Ansicht, Fehler, Bild nur geschwärzt) wird **vor dem Senden gezeigt und ist änderbar**. Geheimes oder Sensibles kommt nie hinein; Prüfung über einen Kanarien-Test (eingesetzter Prüfwert darf im Paket nie auftauchen).
6. **Stufen**: eigene Gruppe → Gemeinschaft → Entwickler (Issue; später Helpdesk). Die nächste Stufe wählt der Mensch; Senden an Entwickler/Upstream erst nach Freigabe (`gate: human`, wie `upstream-anfrage`).
7. **Innen AS2, außen Adapter** (fs-messages, Matrix, XMPP, E-Mail). Ein Adapter ohne Ende-zu-Ende-Verschlüsselung wird sichtbar markiert (ADR 0054 Z. 53, 58).
8. **Zustände** `offen`, `beantwortet`, `gelöst` sind **Lauf-Zustände/Stationen eines Workflows** `hilfe-anfrage` (ADR 0103: Zustände gehören dem Lauf), keine eigene Zustandsliste im Programm.
9. **Gelöst + Zustimmung → Hilfetext** in fs-texts (ADR 0097 N6 „Hilfe als Wiki“; Helpdesk-Suite ADR 0087 Nr. 5).

Bauplan-Eintrag (Vorschlag, ergänzt `[[help]]` aus dem Zweig `scaffold-e5`, der dort nur `topic` und Text de/en hat; Zweig **nicht geprüft**): `origin` (fest), `channel`, `exclude_broadcast = true` (fest, nicht einstellbar), `protocols`, `context_fields`, `escalation` (`group` | `community` | `developer`, Standard `group`), `adapters` mit `e2e` je Adapter, `ki_answer` (nur mit Bot-Platz), `publish_text` (Zustimmung Pflicht), `workflow = "hilfe-anfrage"`, `fallback` (sichtbarer Rückfall nach ADR 0097).

Pflichttests (Vorschlag, nichts gebaut): Hilfe-Nachricht in broadcast unzustellbar; Kanarien-Wert nie im Paket; KI-Antwort ohne Kennzeichen unzustellbar (ADR 0054 Z. 57, 62); KI-Antwort ohne Bot-Platz abgelehnt; Herkunft nach dem Senden unveränderbar.

**ENTSCHEIDUNG (Nutzer) 6: Darf die KI in der Hilfe schreiben?** ADR 0091 gibt dem Bot höchstens die Rechte aus Mandat ∩ Halter ∩ …; Zustimmen und Einladen sind ihm verboten (0091 Z. 49-51, Teil D K1).
- A: Bot schreibt Antworten in den Hilfe-Kanal (Mandat der fragenden Person nötig).
- B: Bot schlägt nur vor; ein Mensch schickt ab.
- **Empfehlung: A mit Mandat**, weil die fragende Person die KI selbst einlädt und die Antwort ohnehin gekennzeichnet ist; „zustimmen“ (z. B. Hilfetext veröffentlichen) bleibt beim Menschen.

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
| Gantt | Balken (Start, Ende, Fortschritt), Meilenstein, Abhängigkeit | `fs-components-timeline` | **erweitern**: Start→Start, Ende→Ende, `GAP`, Gruppen/Zeilen, feste Titelspalte |
| Netzplan / kritischer Pfad | Knoten mit Aufwand, Vorgänger, Typ, Abstand | fehlt (timeline DESIGN.md:48 „unsupported“) | **neu**: Rechenkern im Modul (nicht in der Komponente, ADR 0073 „berechnet“), Anzeige = Flow-Graph |
| Ablauf-Graph (Workflow, BPMN-Sicht) | Knoten (id, Titel, actor, gate, kind), Kanten (Bedingung), Bahnen | fehlt in fs-components und Blinc | **neu** auf Blinc-Canvas (`blinc_layout::canvas`, schon in timeline `view/arrows.rs` genutzt) + eigenes Ebenen-Layout |
| Board mit Bahnen | Spalten, Karten, Zeilen | `fs-components-kanban` (nur Spalten) | **erweitern** um Achse Y (ADR 0103 E6) |
| Zeitleiste | Zeitpunkte, Meilensteine | timeline, calendar-grid | **wrap** |
| Baum (Gliederung/PSP) | Knoten, Kinder | `fs-components-widgets` tree_view über `blinc_cn` Tree | **wrap** |
| Kapazität (Ressource × Zeit) | Ressource, Raster, Belegung | fehlt | **neu**, nach E1 `needs`/`effort` |
| Stepper (Schrittstatus) | Schritte, aktiver Schritt | fehlt in `blinc_cn` | **neu** (oder breadcrumb + progress als Platzhalter) |
| Diagramme (Last, Verlauf) | Serien | `fs-components-charts` | **wrap** |

**Blinc:** Im Checkout `/srv/FreeSynergy/blinc` wurde **keine** Workflow-, Flow-Graph-, Gantt- oder Swimlane-Anzeige gefunden; `blinc_flow` und `blinc_core/src/flow.rs` sind ein Shader-Graph, `blinc_debugger` hat eine Debugger-Zeitleiste (Teil C, Abschnitt 6). Vorschlag:
1. Nichts aus Blinc „übernehmen“, was es nicht gibt. Der Ablauf-Graph wird in fs-components auf dem Blinc-Canvas gebaut.
2. Ein **allgemeiner Knoten-Kanten-Graph** (ohne Workflow-Wissen) ist ein Kandidat für einen Beitrag an Blinc (`blinc_cn`), weil er nicht FS-spezifisch ist; die Workflow-Bedeutung (actor, gate, Bahn) bleibt im Wrapper in fs-components. Beitrag nur als neuer Zweig im Fork mit der erlaubten Identität (Push-Regeln).
3. Shader-Graph und Debugger-Zeitleiste werden **nicht** genutzt (Werkzeuge, keine Planungsbausteine).

**ENTSCHEIDUNG (Nutzer) 10: Welche Blinc-Anzeige war gemeint?** Die Checkliste sagt „von Blinc übernehmen“; gefunden wurde nichts (Teil C, Offen 1–2; `fs-blinc-3.2` als Verzeichnis nicht gefunden, Tag nicht geprüft).
- A: Der Nutzer nennt Stand/Zweig, dann neu prüfen.
- B: Es gibt keine; der Ablauf-Graph wird neu gebaut (wie oben).
- **Empfehlung: zuerst A fragen**, bei „gibt es nicht“ B.

**ENTSCHEIDUNG (Nutzer) 11: Gantt nur lesen oder bearbeiten?** Heute ist timeline Absicht „nur lesen, der Host ändert“ (DESIGN.md:47).
- A: nur lesen.
- B: Ziehen von Balken und Abhängigkeiten, Änderung geht über den Besitzer (fs-tasks).
- **Empfehlung: B später**, A jetzt; ein Ziehen braucht dieselbe Antwortform wie das Board (`Accepted`/`Refused`/`Ask`, ADR 0103 E6), die erst mit der Spaltenquelle steht.

---

## Abweichungen von bestehenden ADRs

- **Keine harte Abweichung.** Erweiterungen:
  - ADR 0076 Z. 15: der Akteurstyp der KI wird im Workflow `Service` (Bot-Platz) statt `Application` – nur wenn ENTSCHEIDUNG 8 = A; 0076 nennt beide, also keine Änderung von 0076, nur des FS-Profils (README.md:4-5).
  - Checkliste „drei Ebenen“ → vier Ebenen (ENTSCHEIDUNG 1).
  - ADR 0073 Nr. 8 (Gantt „später“): unverändert; ENTSCHEIDUNG 4 B zieht nur das Datenmodell vor.
- **Namen:** ADR 0076 Z. 25 schreibt „fs-messenger“, ADR 0087 Z. 23 „fs-text“; nach der Namensregel heißen die Programme fs-messages und fs-texts. Dieser ADR nutzt die gültigen Namen und ändert die alten ADRs nicht (Nachzieh-Liste).

## Folgen

- FS-Profil der Workflows (README.md) bekommt die Felder aus E1; `check_workflows.py` prüft sie (fs-release, eigener Auftrag).
- Neuer Workflow `hilfe-anfrage` (fs-release, über `workflow-pflege`).
- fs-blueprint: `[[help]]` erweitern (nach Prüfung von `scaffold-e5`).
- fs-components: Ablauf-Graph, Bahnen im Board, timeline-Erweiterung (je eigener Auftrag, Bahn 1).
- fs-tasks / fs-jscalendar: Relationstypen nach RFC 9253 im Datenmodell (nach ENTSCHEIDUNG 4/5).

## Offen

1. Musternamen und -nummern (Workflow Patterns) gegen die Quelle prüfen; bis dahin **[nicht belegt]**.
2. Serverless Workflow 1.0.3: hat die Spezifikation eigene Konstrukte für Kompensation, Abbruch, Wahl zwischen Ereignissen? Wenn ja, statt FS-Feldern nutzen. **[nicht belegt]**.
3. `raise`, `while`, `schedule` in unseren Flows: Treffer gezählt, nicht gelesen (Teil A).
4. Abbildung RFC 9253 → JSCalendar `relatedTo` **[nicht belegt]**.
5. BPMN Pools/Lanes und CMMN Stage/Sentry/Milestone: aus den abgerufenen Übersichtsseiten nicht bestätigt.
6. Stand `fs-modules-planning` (Checkliste: v0.0.2, 4152a94) nicht per `git ls-remote` belegt; vor jedem Planungs-Bau `vorhanden-pruefen`.
7. Zweig `scaffold-e5` (`[[help]]`) nicht geprüft.

## Pflichttests (Vorschlag; nichts davon ist gebaut)

- `check_workflows.py`: `actor: ai` ohne `bot-seat` → Befund (Warnung/rot nach ENTSCHEIDUNG 2).
- `separate-from`: gleicher Akteur an beiden Schritten → Lauf verweigert den Übergang.
- BPMN-Import: nicht abbildbares Element → sichtbare Meldung, kein stilles Weglassen.
- Planungsdaten: kritischer Pfad wird nie gespeichert (nur berechnet).
- Hilfe: die fünf Tests aus E3.

## Quellen

- Recherche-Berichte 2026-11-20: `.scratch/recherche-workflow-ebenen/teil-A.md` (DSL gegen Muster, ValueFlows), `teil-B.md` (Ebenen, Sichten, RFC 9253, BPMN, CMMN), `teil-C.md` (Planungs-Components, Blinc-Inventur), `teil-D.md` (Hilfe anfordern).
- RFC 9253, Support for iCalendar Relationships: https://www.rfc-editor.org/rfc/rfc9253.html (abgerufen in Teil B).
- BPMN 2.0.2: https://www.omg.org/spec/BPMN/2.0.2/About-BPMN (abgerufen in Teil B, Übersicht).
- CMMN 1.1: https://www.omg.org/spec/CMMN/About-CMMN (abgerufen in Teil B, Übersicht).
- ADR 0013, 0037, 0054, 0073, 0076, 0081, 0087, 0091, 0097, 0103, 0104.

## Quellen zum Nachprüfen (vor Annahme)

1. Workflow Patterns Initiative (workflowpatterns.com): Kontrollfluss-, Daten-, Ressourcen- und Ausnahme-Muster mit Nummern – **nicht erreichbar** (TLS-Fehler).
2. Serverless Workflow Specification 1.0.x (serverlessworkflow.io bzw. GitHub `serverlessworkflow/specification`) – Weiterleitung lief auf 404.
3. ValueFlows-Vokabular (valueflo.ws): `Process`, `Recipe`, `EconomicResource`, `Commitment`, `inputOf`/`outputOf` – in keinem Bericht abgerufen.
4. RFC 8984 (JSCalendar), Abschnitt zu `relatedTo` – für die Abbildung von RFC 9253.
5. BPMN 2.0.2 Spezifikation (Volltext) für Pools/Lanes; CMMN 1.1 Volltext für Stage/Sentry/Milestone.

## Nachzieh-Liste (eigener Doku-Lauf)

- ADR 0076: Nachtrag „Ebenen je Schritt“ (Verweis auf 0105 E1); Namen fs-messages/fs-texts (nur Hinweis, Agenten benennen nicht um).
- ADR 0097: Nachtrag zu N6 und M2 „Hilfe anfordern“ (Verweis auf 0105 E3).
- ADR 0103: Verweis „Bahn = BPMN-Lane“ (0105 E2 Nr. 6).
- fs-release `workflows/README.md`: neue Felder (nach Annahme).
