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

**8. Maß: Buchungen als Rohwerte, Auswertung als eigene Sicht.** Rohwerte und Auswertung sind getrennt (Entscheidung der Strategie nach Nutzerentscheid 6e). Energie wird nicht gemessen und nicht geschätzt; es gibt keine Meldung „keine Messquelle“.
- **Buchung** (unveränderlich, nur anhängen): je Eintrag Lauf, Station, Durchlauf, Aufenthalt, **Zeit** (gemessen: Beginn und Ende in UTC, Dauer = Ende minus Beginn; Pausen sind eigene Aufenthalte), **Menge** (Aufwand: Zahl plus Einheit; die Einheit ist frei, `ucum` nur, wenn die Einheit in UCUM vorkommt), der **Stationsfaktor** und der **Einsatzartfaktor** (beide beim Eintrag mitgespeichert) und der Zeitpunkt.
- **Menge von Hand:** Ist die Menge für Workflow, Liste oder Station eingeschaltet (Voreinstellung aus), trägt ein Mensch sie **beim Abschließen** des Aufenthalts ein. Ein fehlender Eintrag bleibt leer, nie 0; nichts wird geschätzt oder gemeldet. Einheiten werden nie umgerechnet.
- **Faktoren:** Träger sind **Station und Einsatzart**. Die Einsatzart hängt an der Beziehung zwischen Mensch und Gruppe bzw. an der Zuweisung im Lauf (z. B. `org:Membership`), nie an der Person selbst. Voreinstellungen sind Wörter nach dem schema.org-Eigenschaftswert `employmentType` (Beleg: https://schema.org/employmentType, „Type of employment (e.g. full-time, part-time, contract, temporary, seasonal, internship).“) und nach Googles Aufzählung `FULL_TIME`, `PART_TIME`, `CONTRACTOR`, `TEMPORARY`, `INTERN`, `VOLUNTEER`, `PER_DIEM`, `OTHER` (nur bei Google, nicht bei schema.org). „KI“ ist eine eigene Art aus `BotRef` (je Modell möglich). schema.org kennt keine Aufzählung `EmploymentType` und kein „volunteer“; die Eigenschaft gehört zur Stellenanzeige, nicht zur Beziehung. Übernommen werden nur die Wörter als einstellbare Voreinstellung. Die Liste ist einstellbar; eigene Arten sind erlaubt. Beispiel des Nutzers: Ein Kassierer kann ehrenamtlich oder bezahlt sein. Es gibt **kein Faktor-Feld an Personen**; ein Faktor mit `PersonRef`-Schlüssel wird abgelehnt. `org:Role` (ADR 0052) bleibt unberührt und trägt keinen Faktor. Voreinstellung der Faktoren 1. Beispiel des Nutzers für Stationen (nur Beispiel): Haiku ×1, Sonnet ×2,5, Opus ×5, Fable ×20. Ein Faktorwechsel wirkt nur für neue Buchungen.
- **Geld** ist optional und abgeleitet: Satz mal Zeit oder Festbetrag je Aufenthalt, Währung nach ISO 4217 (ADR 0098 E3). Ein neuer Satz gilt ab der Änderung, nicht rückwirkend (Entscheid 6e, Frage 2 des Entwurfs).
- **Korrektur** (Zeit und Menge gleich, z. B. vergessener Stopp): Löschen und Ändern sind nicht vorgesehen. Korrigiert wird durch einen **Gegeneintrag** (Buchung mit negativen Werten) mit Pflicht-Begründung `note` und Pflicht-Verweis `corrects` auf die korrigierte Buchung; der Gegeneintrag übernimmt Stations- und Einsatzartfaktor des Originals. Ein Gegeneintrag auf einen Gegeneintrag ist erlaubt; beide bleiben sichtbar. Wer korrigieren darf, legt die Workflow-Regel fest.
- **Beleg:** an der Quelle gelesen 2026-11-18 (Opus-Gegenleser): https://www.valueflo.ws/specification/all_vf.html, `vf:corrects`, Domain und Range `EconomicEvent`, „(The initial event cannot be changed.)“ wörtlich; über negative Mengen sagt die Seite nichts. Was ValueFlows nicht regelt (negativer oder ersetzender Wert, Pflicht-Begründung, Faktoren, Korrekturrecht) ist unsere Regel.
- **ValueFlows-Abbildung:** Buchung = `EconomicEvent` mit `action: work`; Menge = `effortQuantity` (`Measure`); Korrektur = `corrects`.

**Auswertung** (eigenes Objekt; ändert nie eine Buchung). Die Leute wählen:
- welcher Rohwert: Zeit, Menge oder beide;
- welcher Faktor auf welchen Wert: Station, Einsatzart, beide oder keiner;
- zusammenzählen oder getrennt;
- gruppiert nach Station, Einsatzart, Workflow oder Liste;
- optional der Geld-Satz.

Mehrere Auswertungen stehen nebeneinander, sind speicherbar und teilbar. Voreinstellungen: „nur Zeit“, „Zeit × Station“, „Zeit × Station × Einsatzart“, „Menge“, „Geld = Zeit × Satz“.
- **Pflicht:** Jede Auswertung zeigt ihre **Formel sichtbar** und daneben die **Rohsummen Zeit und Menge**, damit sich niemand hinter einer Rechnung versteckt.
- **Gruppierung nach Person gibt es nicht** (Entscheid 46).

**9. Zweck nur vergleichen, nie Menschen bewerten (Entscheid 46, ADR 0102).** Zeit, Menge, Faktoren und Geld hängen an **Lauf, Station und Einsatzart**, nie an der Person. Die Einsatzart hängt an der Beziehung, nicht am Menschen. Es gibt keine Summe je Person, keine Rangliste, keine Geschwindigkeit je Person. Im Verlauf steht als Tatsache, wer übergeben hat (AS2 `actor`), nicht als Kennzahl. Technisch gesichert durch:
1. die Buchung hat kein Feld vom Typ `PersonRef`; ein Faktor mit `PersonRef`-Schlüssel wird abgelehnt;
2. die Auswertung bietet Gruppierung nur nach Station, Einsatzart, Workflow und Liste an, nie nach Person; kein Filter auf Akteur oder Teilnehmer im Maß;
3. das Board kann nach Zuständigen filtern, zeigt dann aber Karten, nie eine Summe je Person.
- Ehrliche Grenze: Wer Verlauf und Maß hat, kann beides außerhalb des Programms zusammenführen. Das verhindern wir nicht technisch; wir bieten es nicht an.
- Offen (Einsatzart mit einem Mitglied): Offen 6.

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
- Die KI-Karte in fs-people bleibt (JSContact `kind: application` mit dem KI-Merkmal `PersonView.ai`, ADR 0054 und 0091 Nachtrag „Folgen für die Traits (BotRef)“). `kind: application` allein bedeutet nicht „KI“ (auch ein CI-Runner ist eine Anwendung); das Zeichen der Anzeige für einen Bot kommt aus dem Akteurstyp `BotRef`, nicht aus `kind`.
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
- **Menge:** Eingabefeld nur, wenn eingeschaltet; ein fehlender Eintrag ist leer, nie 0; eine freie Einheit ohne `ucum` wird angenommen; eine UCUM-Einheit mit gültigem Code wird mit Code gespeichert; ein ungültiger UCUM-Code wird abgelehnt; Summen nie über verschiedene Einheiten.
- **Faktor an Person:** ein Faktor mit `PersonRef`-Schlüssel wird abgelehnt (Schema-Test); Faktor an Station und Einsatzart wird angenommen.
- **Auswertung ändert Buchungen nie:** Anlegen, Ändern und Speichern einer Auswertung lässt alle Buchungen unverändert (Vorher-Nachher-Vergleich; Mutante „Auswertung schreibt Summe in die Buchung“ → rot).
- **Formel und Rohsummen immer sichtbar:** eine Auswertung ohne sichtbare Formel oder ohne die Rohsummen Zeit und Menge → rot.
- **Gruppierung nach Person nicht angeboten:** Vertrags-Test (kein Gruppierungsparameter Person, kein Filter mit Personenbezug); Mutante „Gruppierung nach Person hinzugefügt“ → rot.
- **Satz ändert sich:** nach einer Änderung wirkt der neue Satz beim nächsten Stopp; alte Buchungen bleiben unverändert (Test mit zwei Sätzen).
- **Nur anhängen:** Buchung ändern → abgelehnt; Buchung löschen → abgelehnt; Wiederholung eines Schritts → neue Buchung, alte unverändert (Mutante „überschreiben statt anhängen“ → rot).
- **Storno:** ohne `note` → abgelehnt; ohne `corrects` oder mit Verweis auf eine unbekannte Buchung → abgelehnt; ohne Recht laut Workflow-Regel → abgelehnt; der Gegeneintrag hebt Zeit und Menge samt Faktoren genau auf (Mutante „Gegeneintrag mit aktuellem statt mitgespeichertem Faktor“ → rot).
- **Faktorwechsel:** ein geänderter Faktor ändert alte Summen nicht (Mutante „Faktor beim Summieren aus der Einstellung statt aus der Buchung gelesen“ → rot).
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
6. **Offen (nur notiert, nicht gelöst):** Hat eine Einsatzart in der Beziehung nur ein Mitglied, wirkt ihr Faktor praktisch wie eine Bewertung dieses Menschen. Anzeige-Hinweis prüfen, nicht sperren (Nutzer: „jeder wie er mag“). Begriffsfrage entschieden: Faktor-Träger heißt Einsatzart, nicht Rolle; `org:Role` (ADR 0052) trägt keinen Faktor; die Rechte-Sache heißt Rechte-Vorlage.

---

**English summary.** Draft ADR 0103 (number confirmed: `fs-documentation` main ends at 0102; 0100 is taken). Decisions of 18 Nov 2026: the lifecycle states of a run are defined once in the run (not in every workflow file); a run has a state and a station; `waiting` carries a reason (words from the user's list), not three waiting states; loops are new passes within the run, not new tasks; the run type lives in its own module, working name `fs-flow`. Board columns come from column sources (workflow stations, list, property, time grid); a board is a display, not a store. Measurement is split: bookings hold raw values (time measured by the run; quantity entered by a person when switched on, free unit, UCUM only where it exists; empty stays empty, never 0) plus station and employment-type factors stored with each booking; bookings are append-only and corrected only by reversal entries with a mandatory note and a `corrects` reference. An evaluation is a separate view over the bookings that never changes them; it shows its formula and the raw sums of time and quantity. Factors belong to a station or an employment type (Einsatzart), never to a person; totals are never grouped by person (decision 46). A changed rate or factor applies from the next booking onward, not retroactively. Open items: final name of `fs-flow`, whether `fehlgeschlagen` to `abgebrochen` is human-only, a single-member employment type (notice, not a lock), and a new Opus review before acceptance.
