# 0103 – Board, Spaltenquelle, Lauf, Maß: Spalten kommen aus Quellen, Zustände gehören dem Lauf, Aufwand von Hand, Zeit automatisch

Status: **Entwurf** (2026-11-18; Nutzer: Entscheid 6e vom 18.11.2026 mit den Korrekturen zum Maß und den Entscheiden zu den Ausnahmen 52–58; Ausgestaltung Strategie; Prüfung durch Opus steht aus) · **präzisiert** ADR 0097 E4 („Fachregeln sind einstellbare Regelwerke“) für Zustände und Übergänge · **konkretisiert** ADR 0076 Zeile 21–24 (der Lauf ist die Instanz eines Ablaufs) und **ändert** die Besitzfrage aus dem Workflow-Standard (Entwurf: fs-tasks besitzt Vorlage und Lauf) · **ersetzt** den USD-Kostenwert in fs-tasks (`--cost`) durch das Maß · **behandelt** die Ausnahmen 52–56 der fs-tasks-Liste (Gespräche unter `conventions/talks/`) · baut auf ADR 0076, 0085, 0086, 0087, 0097, 0098, 0100, 0101, 0102

**Nummer:** **0103**. Herleitung: `fs-documentation` origin/main (fa4b4dc7) endet bei `0102-person-zuerst.md`; ADR 0100 auf main ist „Einstellungen“ (nicht frei). Nächste freie: 0103.

**Sprache:** Das Repo führt ADRs nur auf Deutsch (`conventions/decisions/`); daher nur eine Fassung. Die englische Kurzfassung am Ende folgt dem Muster von ADR 0101.

---

## Kontext

Die Board-Arbeit in fs-tasks hat vier Stellen, die sich gegenseitig stören:

1. **Spalten sind fest verdrahtet.** Das Board liest seine Spalte aus `progress` (fs-tasks `board.rs:1-6`, `:14-52`). Eine Swimlane (zweite Achse) und erlaubte Übergänge je Rolle sind offen (`requirements.md`, Board-Anforderungen).
2. **Zustände stehen in jeder Workflow-Datei.** Der Zweig `unreviewed/workflow-zustaende-3` in fs-release schreibt dieselben acht Lebenszustände in alle 58 `workflows/*.yaml`. Die Zustände sind damit Eigentum jedes Workflows statt eines Laufs; ein neuer Workflow müsste den Block kopieren. Dieser Zweig wird angehalten und zu `-4` umgebaut (Entscheidung 1).
3. **Ausführungsfelder und Kosten hängen an der Aufgabe.** `run`, `result`, `attempts`, `error`, `loop` und `template` liegen am Task (fs-tasks `exec.rs:13-28`); `--cost` ist eine USD-Zahl (fs-tasks `args_work.rs:181-185`). Beides gehört dem Lauf, nicht der Aufgabe.
4. **KI-Kennzeichen und Prüfbefehl sind Sonderfälle im Programm.** `actor.rs:14-25` führt eine eigene Akteursart `ai`; `check.rs:49-56` kennt nur ja/nein über den Exit-Code. Beides sind Ausnahmen in `scaffold.toml` (fs-tasks, a75302eb, Z. 61–105).

Die Nutzerentscheide 52–58 vom 18.11.2026 (Nummern der Fragenzählung, Quelle `NAECHSTER-DOKU-LAUF.md` Punkt 14 und das Protokoll in `nach-welle-1.md`) beantworten diese Stellen. Dieser ADR fasst sie zu einem Modell zusammen; die Einzelfragen stehen je in einem Gesprächsprotokoll (siehe Folgen).

Bestand (belegt): ADR 0076 (Ablauf = fs-workflows, Ereignis = AS2, Ziel = fs-tasks, „Ziel ≠ Ablauf“), ADR 0097 E4 (Fachregeln einstellbar), ADR 0098 E3 (Bausatz Geld: ISO 4217), ADR 0091 E1 (KI als Karte in fs-people), ADR 0054 (KIs als markierte Teilnehmer).

---

## Entscheidung

**1. Die Lebenszustände stehen EINMAL im Lauf, nicht in jeder Workflow-Datei.**
- Das Lauf-Regelwerk hat eine Voreinstellung mit den Zuständen. Jede Workflow-Datei nennt höchstens diese Voreinstellung (`freesynergy.net:run-rules: freesynergy`) und eigene Abweichungen.
- Der Workflow besitzt nur **seine Stationen** und **seine Übergangsregeln**; die Lebenszustände gehören dem Lauf (ADR 0097 E4: keine fest verdrahteten Zustände).
- Der Zweig `unreviewed/workflow-zustaende-3` (fs-release, Kopf `4807f2f4`) wird **nicht** nach main gebracht. Er bleibt als Material für `-4` erhalten und wird nicht gelöscht.

**2. Zwei Werte statt einer flachen Liste: Zustand × Station.**
- **Zustand** (Lebenslauf des Laufs): `offen`, `läuft` an einer Station, `wartet` mit Grund, `pausiert`, `fehlgeschlagen` (neu), `abgebrochen`, `erledigt`, `archiviert`.
- **Station** (wo der Lauf steht): die `do`-Schritte des Workflows. Station ist keine Zustandsstufe; das Wort `stationen` aus dem Zweig `workflow-zustaende-3` (dort ein Zustand neben den anderen) entfällt deshalb.
- Ein pausierter oder wartender Lauf kennt damit immer seine Station. Ein Rücksprung ist ein neuer Durchlauf im Lauf (`loop.iteration` + 1), keine Wiederbelebung alter Einträge.
- Übergänge (Entwurf): pausiert und abgebrochen von jedem lebenden Zustand (einschließlich `fehlgeschlagen`); `fehlgeschlagen` → `läuft` (Wiederholung) und `fehlgeschlagen` → `archiviert`; ob `fehlgeschlagen` → `abgebrochen` nur durch einen Menschen geschieht, ist offen (Offen 5); archiviert ohne Ausgang; erledigt und abgebrochen dürfen wieder geöffnet werden (neuer Durchlauf, alter bleibt im Verlauf).

**3. Wartezustand mit Grund statt drei Wartezuständen.**
- `wartet` trägt einen Grund. Die Grund-Wörter sind die Wörter des Nutzers: `auf-entscheidung`, `auf-anfrage`, `in-prüfung` (Nutzerentscheid 18; `STATES.md`).
- Die Anzeige kann je Grund eine eigene Spalte zeigen: je Grund ist eine Spalte einstellbar.

**4. Durchlauf im Lauf statt Iterations-Tasks.** Eine Schleife erzeugt keine neuen Aufgaben mehr. Aufgaben entstehen nur für Stationen, an denen ein Mensch arbeitet (Fassung 3 der Entwürfe, N7, wird ersetzt).

**5. Der Lauf-Typ steht in einem eigenen Modul.** Arbeitsname **`fs-flow`** (Art 2 nach ADR 0101: Modul-Bausatz, wenn mindestens zwei Programme ihn brauchen: fs-tasks und fs-workflows). Der endgültige Name kommt mit der nächsten Namenswelle; bis dahin gilt `fs-flow` in Plan und Bauplan. Gespeichert wird der Lauf beim startenden Programm, bis fs-workflows existiert. Das ändert die frühere Besitzregel „fs-tasks besitzt den Lauf“.

**6. Das Board ist Anzeige, die Spalten kommen aus Quellen.**
- **Board** = Component `board` (Art 3 nach ADR 0101) mit einer Achse X (Spalten), optional Achse Y (Bahnen = Swimlanes), Sortierung, Filter und eingeklappten Spalten.
- **Karte** hat keinen eigenen Besitzer; sie ist nur ein Verweis auf das Objekt (Objekt-IRI + Medientyp, ADR 0098 E5).
- **Spaltenquelle** ist eine Schnittstelle mit `spalten()`, `spalte_von(objekt)` und `ziehen(objekt, von, nach)`. Die Antwort ist `Accepted`, `Refused(Reason)` oder `Ask(Question)` (vorhandene Form aus fs-components `board/model.rs`).
- Arten der Spaltenquelle: **WorkflowStationen** (Ziehen = Übergang mit Regeln), **Liste** (eigenes Objekt; Grundliste = RFC 8984 `progress`), **Eigenschaft** (`priority`, Zuständige, `due`, Gruppe, Stichwörter, Orte, Objektart; Ziehen ändert den Wert über `editIf` des Besitzers) und **Zeitraster** (Tag, Woche, Monat).
- **Bahn** (Swimlane) heißt die zweite Achse quer zu den Spalten. In `workflows/STATES.md` (Zweig `workflow-zustaende-3`) und im Nutzerentscheid 18 („Swimlanes in tasks“) bedeutet „Swimlane“ bisher die Spalten; dieser Wortgebrauch wird bereinigt: Spalten = Achse X, Bahn = Achse Y. Nutzerentscheid 18 bleibt erfüllt: Zustände und Stationen sind Spalten.

**7. Ziehen auf einer Workflow-Spalte.** Der Lauf fragt den Workflow nach der Regel „von → nach“:
- fehlt die Regel: `Refused(no-transition)`;
- darf die Person nicht: `Refused(not-allowed)`;
- verlangt die Regel eine Bestätigung: `Ask(Question)`, danach `MoveRequest.confirmed`;
- bei Ja: Aufenthalt schließen (Maß rechnen, Entscheidung 8), neuen Aufenthalt öffnen, Eintritt-Aktionen ausführen, AS2-`Move` in den Verlauf.
- Regel = von → nach, plus *wer darf* (Rolle oder Recht über den Port `ClaimRule`), plus *beim Eintritt* (Rolle zuweisen, Status-Befehl ausführen, Entscheidung anlegen über fs-decisions, Wartegrund setzen).

**8. Maß: Zeit automatisch, AUFWAND von Hand, Geld abgeleitet.** (Korrektur des Nutzers zum Opus-Entwurf vom 18.11.2026: **Energie wird nicht gemessen und nicht geschätzt**; es gibt **keine** Meldung „keine Messquelle“. Das Feld heißt **AUFWAND** und ist das ValueFlows-Feld `effortQuantity`.)
- **Zeit (automatisch):** Der Lauf schreibt je Aufenthalt Beginn und Ende in UTC. Die Dauer ist Ende minus Beginn. Pausen sind eigene Aufenthalte (Zustand `pausiert`) und zählen getrennt. Niemand trägt Zeit von Hand ein.
- **AUFWAND (von Hand):** Ist der Aufwand für einen Workflow, eine Liste oder eine Station eingeschaltet (Maß-Einstellung; Voreinstellung aus), trägt die Person **beim Abschließen** des Aufenthalts selbst eine Zahl ein. Die **Einheit ist frei** („Punkte“, „kWh vom Strommesser“, eine erfundene Größe). Gespeichert wird `name` (frei) und `ucum` nur dann, wenn die Einheit in UCUM vorkommt (z. B. `kW.h`, `h`); sonst bleibt `ucum` leer.
- **Leeres Feld bleibt leer.** Ein fehlender Eintrag ist leer, nie 0; es wird nichts geschätzt und nichts gemeldet. Einheiten werden nie umgerechnet; verglichen wird nur innerhalb derselben Einheit.
- **Geld (optional, abgeleitet):** Nur wenn eingeschaltet. Satz mal Zeit (Betrag je Stunde mal Dauer) oder Festbetrag je Aufenthalt; Währung nach ISO 4217 (Bausatz Geld, ADR 0098 E3). Niemand trägt Geld von Hand ein.
- **Faktor je Station (Gewichtung).** Jede Station hat einen Faktor, Voreinstellung 1. Beispiel des Nutzers (nur Beispiel, keine feste Liste): Haiku ×1, Sonnet ×2,5, Opus ×5, Fable ×20. Die **gewichtete Summe** ist Σ (Zeit bzw. AUFWAND × Faktor der Station), getrennt je Einheit. Ein eingeschalteter Geldsatz kommt **danach obendrauf** (Geld = Satz × gewichtete Zeit, oder Festbetrag). Träger des Faktors ist **nur die Station** bzw. Swimlane; nie eine Person und nie eine Rolle: „Fable ×20“ bezeichnet eine Station, keinen Menschen (Entscheid 46).
- **Nur anhängen.** Jeder Maß-Eintrag ist ein **unveränderliches Ereignis**. Wird ein Schritt wiederholt (neuer Versuch, neuer Durchlauf), kommt ein **neuer** Eintrag dazu; nichts wird überschrieben oder gelöscht; das dient der Auswertung, das Projekt behält seine Einträge. Der **Faktor wird beim Eintrag mitgespeichert**: ein späterer Faktorwechsel wirkt nur ab der Änderung und ändert keine alte Summe (deckt sich mit „bei jedem Stopp mit dem neuen Wert“).
- **Aufrechnung je Station bei jedem Stopp.** Endet ein Aufenthalt, schreibt der Maß-Rechner (reine Funktion im Modul) die Einträge in den Lauf. Summen je Station und je Lauf werden aus allen Einträgen neu gebildet (gewichtet mit dem je Eintrag gespeicherten Faktor), nie fortgeschrieben.
- **Korrektur wie beim Kassenzettel.** Gilt für Aufwand **und** automatische Zeit gleich (z. B. vergessener Stopp): beide werden **nie gelöscht**, sondern nur durch einen **Gegeneintrag** korrigiert. Löschen ist nicht vorgesehen. Korrigiert wird durch einen **Gegeneintrag** mit negativem Wert, **Pflicht-Begründung** (`note`) und **Pflicht-Verweis** auf den korrigierten Eintrag (ValueFlows `corrects` auf `EconomicEvent`; die Spezifikation sagt: „The initial event cannot be changed.“). Der Gegeneintrag übernimmt den **mitgespeicherten Faktor des Originals**, damit sich die gewichtete Summe genau aufhebt. Eine richtige Zahl kommt danach als neuer, normaler Eintrag. **Wer stornieren darf**, legt die Regel des Workflows fest („wer darf“, wie bei den Übergängen). Ein Gegeneintrag auf einen Gegeneintrag ist erlaubt (Storno des Stornos); beide bleiben sichtbar.
- **Beleg:** `corrects` ist in ValueFlows auf `EconomicEvent` definiert; Quelle https://www.valueflo.ws/specification/all_vf.html (Zitat aus dem Opus-Entwurf übernommen; im Lauf nicht erneut gegengelesen).
- **Beleg:** `corrects` ist in ValueFlows auf `EconomicEvent` definiert; Quelle https://www.valueflo.ws/specification/all_vf.html (Zitat aus dem Opus-Entwurf übernommen; im Lauf nicht erneut gegengelesen).
- **Was ValueFlows nicht regelt (ehrlich):** (1) ob der korrigierende Eintrag negativ ist oder den richtigen Wert ersetzt (ValueFlows sagt dazu nichts; negative Mengen in `Measure` sind nicht belegt); (2) die Pflicht-Begründung (in ValueFlows nicht vorgeschrieben, unsere Regel); (3) der Faktor (nicht Teil von ValueFlows, unsere Erweiterung); (4) die Storno-Berechtigung (Workflow-Regel). Die Festlegung „Gegeneintrag negativ, danach ein neuer richtiger Eintrag“ ist unsere Regel, kein Standardinhalt.
- **Neuer Satz gilt ab der Änderung** (Entscheid 6e, Frage 2 des Entwurfs): ein geänderter Satz oder eine geänderte Einheit wirkt **bei jedem Stopp mit dem neuen Wert**, nicht rückwirkend. Alte Einträge behalten ihre Werte; Summen werden je Einheit getrennt gebildet.
- **Kein USD-Feld mehr** (fs-tasks `--cost` entfällt). API-Kosten eines Agenten: Geld eingeschaltet mit Festbetrag je Aufenthalt (Währung USD), oder als Aufwand mit der Einheit „USD laut Konsole“, wenn jemand die Zahl abliest.
- **ValueFlows-Abbildung:** Aufenthalt = `EconomicEvent` mit `action: work`; Zeit und AUFWAND = `effortQuantity` (`Measure` mit `hasNumericalValue` und `hasUnit`); Korrektur = `corrects` auf den Eintrag; Geld nur bei Wahl.

**9. Zweck nur vergleichen, nie Menschen bewerten (Entscheid 46, ADR 0102).** Zeit, AUFWAND und Geld hängen am **Lauf und an der Station**, nie an der Person. Es gibt keine Summe je Person, keine Rangliste, keine Geschwindigkeit je Person. Im Verlauf steht als Tatsache, wer übergeben hat (AS2 `actor`), nicht als Kennzahl. Technisch gesichert durch:
1. der Maß-Eintrag hat kein Feld vom Typ `PersonRef`; der Faktor hängt an Station bzw. Eintrag, nie an einer Person (Schema-Test: Faktor-Schlüssel ohne Personenbezug);
2. der Vertrag bietet Summen nur je Lauf, Station, Workflow und Liste an, gruppiert nach Einheit; kein Parameter „je Person“, „je Zuständigem“ und keine Sortierung nach Personen;
3. die Abfrage des Maßes nimmt keinen Filter auf Akteur oder Teilnehmer an. Das Board kann nach Zuständigen filtern, zeigt dann aber Karten, nie eine Summe je Person.
- Ehrliche Grenze: Wer Verlauf und Maß hat, kann beides außerhalb des Programms zusammenführen. Das verhindern wir nicht technisch; wir bieten es nicht an.

**10. Status-Befehl statt Prüfbefehl.** Ein Workflow-Schritt kann einen Status-Befehl ausführen. Das Ergebnis folgt den Monitoring Plugins Guidelines: Exit 0 OK, 1 WARNING, 2 CRITICAL, 3 UNKNOWN; Ausgabe Text plus Messwerte (Perfdata). Voreinstellungen je Schritt einstellbar:
- OK: Station bestanden;
- WARNING: weiter mit sichtbarem Hinweis im Verlauf;
- CRITICAL: Versuch fehlgeschlagen; Wiederholung über `retry` bis zur Grenze, dann `fehlgeschlagen` und Entscheidung an einen Menschen;
- UNKNOWN: nie bestanden; Zustand `wartet` mit Grund `in-prüfung`;
- Zeitüberschreitung: CRITICAL (die Guidelines legen dafür keinen Code fest).
- **Sicherheitsregeln gehören dem Workflow-Schritt**, nicht fs-tasks: nur Läufe mit lokalem Ursprung; nur Programme aus einer Liste, ohne Shell; Skripte nur unter `scripts/`; Zeitlimit 1–3600 s (SW 1.0 `timeout`; Liste und Ursprung im FS-Profil `freesynergy.net:allow` und `freesynergy.net:origin`, geprüft vom Workflow-Prüfer und vom Lauf vor der Ausführung). „Vertrauter Ersteller“ heißt: Recht über Rolle, keine Vertrauensstufe einer Person (Entscheid 46).

**11. Ausnahmen in fs-tasks (Liste der Nutzerentscheide 52–58).** Die Ausnahmen bleiben im Bauplan, bis der Baustein existiert; dann verweist die Ausnahme auf das Gespräch statt auf `talk-not-found`.

| Nr. | Ausnahme | Entscheid | Folge | Gespräch |
|---|---|---|---|---|
| 52 | Prüfbefehl | Status-Befehl (Monitoring-Plugins-API-Kandidat); Sicherheitsregeln gehören zum Workflow-Schritt | Punkt 10; bleibt Ausnahme bis `fs-flow` | `conventions/talks/2026-11-18-tasks-pruefbefehl-policy.md` |
| 53 | Geheimnis-Sperre | allgemeiner Baustein für alle Texteingaben; aus / warnen / sperren; Voreinstellung sperren; gitleaks-Regeln als Mustersatz (Lizenz prüfen); Angebot „in den Tresor verschieben“; Karte aufs Board; nicht vor V1 | bleibt Ausnahme bis Baustein | `conventions/talks/2026-11-18-tasks-geheimnis-sperre.md` |
| 54 | KI-Kennzeichen | entfällt; das Zeichen kommt aus dem Akteurstyp `BotRef` (Punkt 12) | Ausnahme wird aus dem tasks-Bauplan genommen | `conventions/talks/2026-11-18-tasks-ki-kennzeichen.md` |
| 55 | Kosten | kein USD-Feld; Maß (Punkt 8) | Ausnahme bleibt, bis Lauf und Maß existieren | `conventions/talks/2026-11-18-tasks-kosten.md` |
| 56 | Ausführungsfelder | Umzug in den Lauf (eigenes Objekt; PROV-O und AS2-Verlauf) | Ausnahme bleibt mit Verweis, bis `fs-flow` existiert | `conventions/talks/2026-11-18-tasks-ausfuehrungsfelder.md` |

Die Gesprächs-Ausnahmen für fs-people (57 gleiche Person, 58 sensible Markierung) stehen in den Talks `2026-11-18-people-gleiche-person.md` und `2026-11-18-people-sensibel-markierung.md`.

**12. KI-Kennzeichen entfällt (Nummer 54).** Das Zeichen „KI“ kommt aus dem **Akteurstyp**, nicht aus einem Feld je Aufgabe (Entscheid der Strategie zu Nummer 54; Nutzerwort: „der Bot/Wrapper trägt die Kennzeichnung in sich“):
- Ein Bot ist ein `BotRef` (fs-identity; ADR 0091, Nachtrag „Folgen für die Traits (BotRef)“). Der Akteurstyp selbst ist die Kennzeichnung; die Anzeige leitet das Zeichen daraus ab.
- Die frühere Form über JSContact `kind: application` in einer Personenkarte ist **zurückgenommen**. `kind: application` allein bedeutet nicht „KI“ (auch ein CI-Runner ist eine Anwendung).
- Aufgaben und Läufe verweisen auf den Akteur: Person (`PersonRef`) oder Bot (`BotRef`) gemäß ADR 0091. Die Akteursarten von `claim` kommen daraus. Das Vendor-Feld je Aufgabe entfällt.

**13. Ausführungsfelder wandern in den Lauf (Nummer 56).** `run`, `result`, `attempts`, `error`, `loop` aus fs-tasks `exec.rs` gehen in den Lauf (eigenes Objekt; Ergebnis je Versuch, Versuche je Station, letzter Fehler als Problem-Typ-URI, Durchlaufnummer). `template` wird `hadPlan` (Verweis auf den Workflow in Version). `claim` geht nach fs-planning, nicht in den Lauf. Die Verlaufsaufzeichnung läuft über AS2 (`Move` mit `origin` und `target`) in fs-objects `v5::log` und fs-activities.

**14. Gleiche Person und sensible Daten (Nummern 57 und 58)** sind **nicht** in diesem ADR entschieden; sie stehen in den Talks und in ADR 0102 (Freigabe je Empfänger). Hier nur der Verweis: Gleiche Person ist immer nur ein Vorschlag (Dialog Ja, Nein, Für alle, Merken; „Für alle“ gilt nur für diesen Lauf; „Merken“ ist eine sichtbare, widerrufbare Regel in den Einstellungen; jede Verknüpfung ist lösbar). Sensible Daten bekommen einen Schutz-Baustein mit den DPV-Kategorien (Data Privacy Vocabulary, W3C Community Group DPVCG, keine W3C-Empfehlung); die Freigabe je Empfänger bleibt unsere Regel (ADR 0029, ADR 0102).

**15. Einstellbar statt fest (ADR 0097 E4, Memory „Einstellbar statt fest“).** Ob Ziehen auf einer Workflow-Spalte erlaubt ist, ob eine Bestätigung kommt, wie WIP-Grenzen gemeldet werden (nur gemeldet, nie erzwungen), welche Gründe eine Spalte bekommen und welche Maß-Einstellung gilt: alles sind Voreinstellungen in fs-settings (ADR 0100).

---

## Pflichttests (Vorschlag; nichts davon ist gebaut)

- **Zustände einmal:** kein Workflow nennt die Lebenszustände in seiner Datei; Mutante „Block in eine Workflow-Datei kopiert“ → rot.
- **Zustand × Station:** Mutante „pausierter Lauf ohne Station“ → rot. Pause hält die Station.
- **Fehlschlag:** CRITICAL bis zur Grenze → `fehlgeschlagen`; `fehlgeschlagen` ohne Ausgang (weder `läuft`, `abgebrochen` noch `archiviert`) → rot.
- **UNKNOWN** wird nie als bestanden gezählt.
- **Wartegrund:** `wartet` ohne Grund → rot; Grund außerhalb der Liste (`auf-entscheidung`, `auf-anfrage`, `in-prüfung`) → rot.
- **Aufwand:** Eingabefeld nur, wenn eingeschaltet; ein fehlender Eintrag ist leer, nie 0; eine freie Einheit ohne `ucum` wird angenommen; eine UCUM-Einheit mit gültigem Code wird mit Code gespeichert; ein ungültiger UCUM-Code wird abgelehnt; Summen nie über verschiedene Einheiten.
- **Satz ändert sich:** nach einer Änderung wirkt der neue Satz beim nächsten Stopp; alte Einträge bleiben unverändert (Test mit zwei Sätzen).
- **Nur anhängen:** Eintrag ändern → abgelehnt; Eintrag löschen → abgelehnt; Wiederholung eines Schritts → neuer Eintrag, alter unverändert (Mutante „überschreiben statt anhängen“ → rot).
- **Storno** (für Aufwand und automatische Zeit gleich): ohne `note` (Begründung) → abgelehnt; ohne Verweis `corrects` oder mit Verweis auf einen unbekannten Eintrag → abgelehnt; ohne Recht laut Workflow-Regel → abgelehnt; Gegeneintrag hebt die gewichtete Summe genau auf (Mutante „Gegeneintrag mit aktuellem statt mitgespeichertem Faktor“ → rot).
- **Faktorwechsel:** ein geänderter Faktor ändert alte Summen nicht (Mutante „Faktor beim Summieren aus der Einstellung statt aus dem Eintrag gelesen“ → rot).
- **Keine Summe je Person:** Schema-Test (Maß-Eintrag ohne `PersonRef`), Vertrags-Test (keine Methode und kein Filter mit Personenbezug), Mutante „Summe je Teilnehmer“ → rot.
- **Status-Befehl:** ohne `timeout` oder mit Shell → rot; Programm nicht auf der Liste → rot.
- **Ausnahmen:** tasks-Bauplan ohne Ausnahme 54 (`fs-blueprint check`); jede verbleibende Ausnahme hat ein vorhandenes `talk` (Dateiprüfung in `conventions/talks/`).

## Folgen

- **fs-release:** `unreviewed/workflow-zustaende-4` wird auf `-3` aufgesetzt, nach dem Tag `v0.0.12` (Versions-Konflikte; Basis -3, rebased auf main); die 58 Blöcke fallen weg, `STATES.md` wird die Voreinstellung des Lauf-Regelwerks (ohne `stationen`, mit `fehlgeschlagen`).
- **fs-types:** Bausatz **Menge** (Zahl plus Einheit `name` plus optional `ucum`), Wortliste der Lauf-Zustände und Wartegründe. Zweiter Nutzer neben dem Lauf: fs-resources (ValueFlows-Mengen) erfüllt ADR 0098 E7.
- **fs-interfaces:** Vertrag Lauf (lesen, starten, übergehen, pausieren, Ergebnis melden, Verlauf). `Boards` wird nicht gefüllt; Board ist Anzeige.
- **fs-flow:** Art-2-Modul; Zustandsautomat aus dem Regelwerk, Aufenthalte, Status-Abbildung, Maß-Rechner, Maß-Einstellung je Workflow, Liste oder Station.
- **fs-components:** Port Spaltenquelle mit den vier Arten, Achsen X und Y, `MoveRequest` und `Answer` wiederverwenden; Anzeige nach WAI-ARIA (Ziehen auch per Tastatur).
- **Standards (Prüfung, ob sie passen; Ehrlichkeit):** W3C PROV-O beschreibt Herkunft im Nachhinein, nicht den Lebenszustand, daher nur als Abbildung beim Export. AS2 liefert Ereignisse, keine Dauer und keine Mengen. Monitoring Plugins Guidelines haben vier Codes, aber kein Normgremium und kein UCUM. ValueFlows kennt keine freie Einheit (OM 2) und keinen Satz je Station. UCUM nur, wenn die Einheit dort vorkommt; sonst freier Name. JSContact `kind: application` ist nicht gleich KI. Nicht passend: JSCalendar `progress` kennt kein pausiert, wartet oder archiviert und gehört der Aufgabe, nicht dem Lauf oder der Station. Serverless Workflow 1.0 kennt keine Rollenrechte je Übergang und keine Stationen-Lebenszustände; deshalb das FS-Profil. Board: kein Standard gefunden; Anzeige nach WAI-ARIA.
- **Die Talks** `conventions/talks/` (Verzeichnis neu, Format eine Datei je Gespräch `YYYY-MM-DD-<thema>.md`): je Datei Frage, Entscheid, Folge, Verweis auf diesen ADR bzw. den Baustein. Teilnehmer sind Nutzer und Strategie (protokolliert). Damit sind der Ort `conventions/talks/` (ADR 0097 Offen 8, ADR 0099 Folgen) und die Gesprächspflicht für die Ausnahmen erledigt. Verlinkung in Berichten: GitHub-URL plus Pfad, nie nur relativ.

## Offen

1. Endgültiger Name von `fs-flow` mit der nächsten Namenswelle (Entscheid 6e: Arbeitsname bleibt bis dahin).
2. Opus-Prüfung: Die Auflagen aus dem Urteil sind eingearbeitet; eine neue Prüfung steht aus (Entwurf-Status, bis dahin keine Annahme).
3. Lizenz der gitleaks-Regeln vor Übernahme in den Geheimnis-Baustein (Talk 53, nicht vor V1).
4. Ausarbeitung von Geld-Feldern über den Festbetrag hinaus (Währungswechsel, Kurse): nicht vorgesehen, bis ein Nutzer es verlangt.
5. **Frage an den Nutzer/Strategie:** Darf `fehlgeschlagen` → `abgebrochen` nur durch einen Menschen geschehen (Variante A) oder automatisch nach Ende der Versuche (Variante B)? Nicht entschieden.

---

**English summary.** Draft ADR 0103 (number confirmed: `fs-documentation` main ends at 0102; 0100 is taken). Decisions of 18 Nov 2026: the lifecycle states of a run are defined once in the run (not in every workflow file); a run has a state and a station; `waiting` carries a reason (words from the user's list), not three waiting states; loops are new passes within the run, not new tasks; the run type lives in its own module, working name `fs-flow`. Board columns come from column sources (workflow stations, list, property, time grid); a board is a display, not a store. Measurement: time is recorded automatically by the run; effort (AUFWAND, ValueFlows `effortQuantity`) is entered by a person at the end of a stage when switched on, with a free unit (UCUM only when the unit exists there), and empty stays empty, never 0; money is optional and derived. Totals are per run, station, workflow and list, never per person (decision 46). A changed rate applies from the next stop onward, not retroactively. Open items: final name of `fs-flow`, whether `fehlgeschlagen` to `abgebrochen` is human-only, and a new Opus review before acceptance. The AI marker comes from the actor type `BotRef` (ADR 0091); the JSContact `kind: application` idea is withdrawn. Corrections of effort and automatic time are reversal entries only, never deletions.
