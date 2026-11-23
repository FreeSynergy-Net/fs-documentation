# 0104 – Moduldaten gehören dem Modul: logisch je Person, physisch per Speicher-Treiber, ein Besitzer-Dienst, Verträge statt Modulversionen

Status: **akzeptiert** (Strategie und Nutzer, 2026-11-19; Entscheid 6e; Präzisierungen des Nutzers zu E1, E3 und E7 durch den Koordinator am 2026-11-19; E8 nach Nutzerwort vom 2026-11-19, Strategie 6e; E9 nach Nutzerregel vom 2026-11-19) · **verweist** ADR 0103 (Befehlsketten über Module sind Workflows; E9) · **ersetzt** in ADR 0097 E4 nur die Zwei-Prozesse-Regel („verschiedene Vertragsversionen = zwei Prozesse“); die Frist-Regel aus E4 (Ende nach Frist ohne Nutzer) gilt weiter · **präzisiert** ADR 0097 Nachtrag N9 (Domäne = Moduldatei) · **ändert** ADR 0099 E1 (Bauplan: Vertragseintrag mit Versionsbereich; der `[[module]]`-Tag bleibt) · **ändert** ADR 0086 (Speicher je Modul statt je Programm) · **ändert** ADR 0096 E3 (Domäne liegt im Besitzer-Modul, nicht im Programm) · **ändert** ADR 0098 Tabelle, Zeile „Person“ (Z. 28; Modul `person`, E8) · **ändert** ADR 0100 Nachtrag E10 (Ort-Regel für Module) · **ändert** ADR 0024 (Rechte-Voreinstellung je Programm) · **ändert** ADR 0101 E1 (Art 1 trägt die Datenhoheit) · **ändert** ADR 0061 (Facette = Frontend über Daten eines oder mehrerer Module; E8) · baut auf ADR 0024, 0061, 0086, 0096, 0097, 0098, 0099, 0100, 0101

Die Nachträge in den genannten ADRs werden in einem eigenen Doku-Lauf geschrieben; die vollständige Liste steht unter „Nachzieh-Liste“.

---

## Kontext

Heute liegen Daten je **Programm**-Datenbank, nicht je Modul. Belegt:

- ADR 0096 E3 legt die Domäne `forms` in die Datei `forms.db` des Programms fs-forms; „eine Domäne je Datei“, nur `fs-forms serve` öffnet sie.
- ADR 0086 (Fakten, Punkt 4) und die Registry von fs-objects (`SecondDomain`, registry.rs:143): je Store-Datei nur eine Programm-Domäne.
- ADR 0100 Nachtrag E10: die Personen-Datenbank liegt unter `$XDG_DATA_HOME/freesynergy/settings/settings.db`, „wie alle Programm-DBs“.
- Die Ordnerregel im Code, `default_data_dir(program)`, ergibt `$XDG_DATA_HOME/freesynergy/<program>`.

Das Ergebnis: Zwei Programme, die dasselbe Modul nutzen (z. B. ein Programm, das das Modul `person` lädt, und eine zweite App, die dasselbe Modul lädt), hätten jeweils eine eigene Kopie der Personendaten. Die zweite App könnte die Daten nicht sehen, ohne das erste Programm zu starten. Das widerspricht dem Zweck „dieselben Daten“ und der Selbstbestimmung über Daten (Nutzerregel: Rechte vorab per Vertrag je Modul, ADR 0024 und 0102).

Offen war außerdem, ob eine Modul-Domäne eine eigene Datei ist (ADR 0097 N9) oder Teil der Programm-DB (ADR 0086, 0096 E3). Zwei Widersprüche wurden geprüft:

- ADR 0098, Tabelle, Zeile „Person“ (Z. 28): „gehört fs-people“ widerspricht dem Grundsatz „Daten gehören dem Modul“.
- ADR 0097 E4 („verschiedene Vertragsversionen = zwei Prozesse“) würde zwei Besitzer für dieselbe Datei bedeuten.

Ein bereits angenommenes Vorbild gibt es: ADR 0100 Nachtrag Entscheidung 8, „ein Prozess besitzt die DB; alle anderen sprechen über den Vertrag“ (fs-objects: eine Datei, ein Prozess). Dieses Muster gilt für die Einstellungen bereits und wird hier auf alle Module übertragen.

Korrektur zum Befund (Prüfung durch den Opus-Gegenleser): Die Aussage „kein WAL gefunden“ ist falsch. Die Datenbank-Engine turso schreibt eine `-wal`-Datei (ADR 0086 Nachtrag; fs-objects turso/purge.rs:73, crypto.rs:8). Ob turso mehrere Prozesse auf einer Datei zulässt, ist **nicht belegt** (siehe Offen 1).

Bestand (belegt): ADR 0024 (jedes Programm kann OAuth2 und SCIM), ADR 0061 (Facette = Filter auf EIN Programm), ADR 0098 (Verweis statt Kopie: ein Programm speichert für eine Person nur einen Personen-Verweis), ADR 0099 E1 (`[[module]]` mit `name`, `version` = exakter Tag des Modul-Repos), ADR 0101 (Art 1 Standard-Modul, Art 2 Verfahren ab zwei Programmen, Art 3 Component, Art 4 Programm = Bauplan).

---

## Entscheidung

**E1. Moduldaten gehören dem Modul; logisch gehört jede Zeile einer Person.**
- Moduldaten gehören **logisch** dem Modul, und jede Zeile gehört **logisch** einer Person. Rechte, Export und Löschen gelten je Person; das ist der Vertrag.
- Die Daten werden von **jedem Programm mitbenutzt**, das dieses Modul in seinem Bauplan lädt.
- Beispiel: Zwei Programme, die beide nur das Modul `person` laden, zeigen dieselben Daten.
- **Physisch** entscheidet der **Speicher-Treiber** des Modul-Dienstes (Strategy-Muster; Arbeitsname `Speicher-Treiber`, austauschbar hinter einer Schnittstelle, Methoden u. a. öffnen, lesen, schreiben, exportieren, löschen je Person). Die Wahl je Ort ist in E7 festgelegt.
- Vorschlag für den Ort des Gerätespeichers (Offen 2): `$XDG_DATA_HOME/freesynergy/modules/<modul>/` nach der [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/); Windows analog zum Standardordner.

**E2. Genau EIN Besitzer-Prozess je Modul und Person (Gerät) bzw. je Modul und Instanz (Server).**
- Der Modul-Dienst öffnet den Speicher (je nach Treiber E7: Datei je Gerät oder ein Speicher je Instanz). Er läuft über fs-rpc und wird mit `ensure_single` gestartet (Vorbild ADR 0100 Nachtrag Entscheidung 8).
- Auf dem Gerät gibt es damit einen Dienst je Modul und Person. Auf dem Server gibt es einen Dienst je Modul und Instanz. Diese Festlegung je Ort ist eine **Folgerung aus E1 und E7**, nicht eine eigene Entscheidung.
- **Alle** Programme fragen ihn über den Vertrag des Moduls. Damit gibt es nur eine Stelle, an der Rechte durchgesetzt werden.
- Ersetzt wird in ADR 0097 E4 nur die Zwei-Prozesse-Regel („verschiedene Vertragsversionen = zwei Prozesse“). Die Frist-Regel aus E4 gilt weiter: Der Dienst endet nach einer Frist ohne Nutzer.
- Herzschlag und Wiederverbinden sind **Pflicht**: Ein Absturz des Modul-Dienstes trifft alle Programme des Moduls; die Programme müssen sich sichtbar melden und nach dem Neustart selbst wieder verbinden.

**E3. Unverträgliche Hauptversion: das ältere Programm wird aktualisiert.**
- Ein Programm erklärt im Bauplan **je Vertrag**, welchen Vertrag es braucht: capnp-Datei-ID und Vertragsversion (`major.minor`). Die capnp-Datei-ID ist eine [eindeutige Kennung des Cap'n-Proto-Schemas](https://capnproto.org/language.html#unique-ids). Der Modul-Dienst erklärt, welche Verträge er bedient. Die Modulversion selbst ist für die Verträglichkeit egal, solange sie den Vertrag bedient.
- **Verträglich** heißt: gleiche Datei-ID UND der Vertrag wurde nur angehängt (gleiche Hauptversion; ADR 0099 Entscheidung 5, ADR 0086 „Spalten nur anhängen“).
- Der Versionsbereich gilt für den **Vertrag** (Datei-ID plus Vertragsversion gleicher Hauptversion), **nicht** für den Modul-Tag in `[[module]]`. Der Modul-Tag bleibt, was er ist (ADR 0099 E1).
- Bei Unverträglichkeit gibt es **nie eine stille zweite Datei**: der Zweck ist „dieselben Daten“. Das ältere Programm muss erst aktualisiert werden. Es meldet sichtbar „bitte aktualisieren“ und stellt nicht still aus (Regel „Fehlende Datenquelle melden“).
- Keine Migration, solange es keine echten Nutzer gibt (Daten dürfen weg; ADR 0086 und Nutzerregel „Daten nicht retten“).
- Der Modul-Dienst meldet die bedienten Verträge; das ist Pflicht und muss auffindbar sein (Offen 3).

**E4. Rechte und Identität.**
- Ein selbst installiertes Programm hat **volle eigene Rechte** auf die Moduldaten der Person. Die Rechte sind **je Programm einschränkbar** (Nutzerregel „Einstellbar statt fest“; ADR 0024 wird entsprechend geändert).
- Der Zugriff läuft **immer** über den Vertrag mit der Identität der Person (ADR 0098 Freigabe; ADR 0102).
- KI greift **nie ohne ausdrückliche Freigabe** zu (Bot-Platz, ADR 0091).

**E5. Einordnung zweiter Apps.**
- Eine zweite App, die **nur Moduldaten** zeigt (Beispiel: eine Kontaktbörse mit Personendaten und Filter), ist ein **Frontend** (forms-Beschreibung auf dem Modul), kein Programm.
- Hat sie **eigene Daten** (Beispiel: Gesuche, Inserate), ist sie ein eigenes Programm mit eigenem Modul; Personen kommen per Vertrag aus dem Modul `person`.
- Eine Suite entsteht erst, wenn mehrere Programme gebündelt werden (Facette ≠ Suite; ADR 0061).

**E6. Umsetzung im Gerüst und Pflicht-Tests je Treiber.**
- Umgesetzt wird **Modul-Dienst mit Speicher-Treiber** statt Programm-DB, in S8 (Speicher aus dem Bauplan) und S10 (Client und Root).
- Heutige Programm-DBs dürfen wegfallen; Daten werden **nicht** gerettet (Nutzerregel).
- Das Messen der Aufrufkosten (ADR 0097 Offen 4) und des Speicherbedarfs bei 1000 Personen je Instanz sind Teil von S10.
- **Entschieden** sind drei Konformitätstests, die **jeder Treiber** besteht, auf dem Gerät wie auf dem Server:
  1. **Export einer Person vollständig:** alle Zeilen dieser Person, keine fremden.
  2. **Keine fremde Zeile ohne Recht:** eine Person sieht ohne Recht keine Zeile einer anderen Person.
  3. **Löschen einer Person vollständig:** nach dem Löschen bleibt keine Zeile dieser Person, auch nicht im Cache.

**E7. Speicher-Treiber: logisch je Person, physisch je Ort.**
- Der Modul-Dienst spricht den Speicher-Treiber über eine Schnittstelle (Strategy-Muster; der Treiber ist austauschbar, der Vertrag bleibt gleich). Der Treiber kennt die Person bei jedem Zugriff; der Vertrag prüft die Rechte.
- **Gerät** (eine oder wenige Personen): **eine Datei je Modul und Person** (Treiber „Datei je Person“).
- **Server**: **EIN Speicher je Modul und Instanz**, mit einem **Personen-Schlüssel in jeder Zeile**; Treiber-Ziel ist eine Turso-Datei, später Postgres; ein gemeinsamer Cache. **Keine Datei je Person** auf dem Server.
- Begründung: Viele Personen auf einem Server würden sonst viele Dateien und Caches erzeugen. Ziel sind dezentrale kleine Server für 100 bis 1000 Menschen; der Speicherbedarf dafür wird in S10 gemessen (Offen 5).

**E8. Facette, Programm und Suite: Einordnung nach den Daten.** Grundlage ist der Nutzersatz „Facette ohne eigene Daten ist per Definition ein Frontend.“ (2026-11-19).
1. **Facette** (ADR 0061) ist ein **Frontend über die Daten eines oder mehrerer Module**. Eine Facette hat keine eigenen Daten. „Facette“ bleibt nur als **Anzeige-Begriff** erhalten; eine eigene technische Art „Facette“ gibt es nicht.
2. **`people` ist ein Programm wie jedes andere** (Nutzerentscheid vom 2026-11-19: alle Programme sind gleich). Es **besitzt die Personendaten nicht**; das tut das Modul `person`. Zwei Baupläne mit dem Modul `person` (`people` und eine Kontaktbörse) sind **gleichrangig**.
3. **Ein Programm mit eigenem Modul** (eigene Daten) **bleibt ein Programm**. **Eine Suite** bleibt ein Bündel mehrerer Programme (ADR 0061: Facette ist das Gegenteil einer Suite).

**E9. Module sprechen direkt über Verträge; Befehlsketten sind Workflows.** Grundlage ist die Nutzerregel vom 2026-11-19 (sinngemäß unter „Quellen“).
1. **Kein Zwischenmodul.** Eine Regel über mehrere Module hat kein Vermittler-Modul. Ein Modul fragt ein anderes **direkt über dessen Vertrag**; das Objekt schickt dem anderen Objekt eine Nachricht. Beispiel: Eine Buchung fragt den Kalender „wann ist frei?“.
2. **„Kurz laden“** heißt: Die Verbindung zum Modul-Dienst des anderen Moduls holen bzw. ihn starten. Das ist eine Cap'n-Proto-Capability ([Cap'n Proto RPC](https://capnproto.org/rpc.html)), die mit den **Rechten der Person** nach E4 genutzt wird. Der Aufrufer liest **keine fremden Dateien** und lädt **keinen fremden Code** in den eigenen Prozess.
3. **Abhängigkeit steht im Bauplan bzw. im Vertrag** als `requires`. **Zyklen sind verboten.** Das Feld selbst ist noch nicht definiert (Offen 7).
4. **Befehlsketten über Module sind Workflows.** Sie liegen als Daten vor, sind im Lauf nachverfolgbar und änderbar (ADR 0103). **Fest programmiert** wird nur, was ein Modul mit seinen **eigenen** Daten tut.
5. **Fehlendes Modul: fragen, nie still installieren.** Fehlt das gefragte Modul (z. B. kein Kalender), fragt das Programm die Person, ob es installiert werden darf. Es installiert **nie still**. Sagt die Person nein, gilt die Angabe im Bauplan je Abhängigkeit:
   - **`required` (Pflicht):** Die Funktion geht nicht und zeigt sichtbar, warum (z. B. „braucht Kalender“). Nie stilles Ausgrauen (Regel „Fehlende Datenquelle melden“).
   - **`fallback = "manual"` (mit Rückfall):** Die Person trägt den Wert von Hand ein (z. B. ein Datum). Sichtbarer Hinweis: „nicht geprüft, Überschneidungen möglich“. Der Lauf vermerkt „ungeprüft“.
   - Die Angabe steht im Bauplan neben `requires`. Feldname und Schema sind ein **Entwurf** (Offen 7).

Muster und Schnittstellen: Muster „Capability“ (Zugriff nur über eine übergebene Fähigkeit, Objekt-Fähigkeiten); Schnittstelle ist der Vertrag des Moduls (Cap'n Proto). Muster „Befehlskette als Daten“ (Workflow-Schritte statt fester Aufrufkette).

Verhältnis zu den übrigen Entscheidungen dieses ADR:
- **E2:** Die Capability zeigt auf den Modul-Dienst je Modul und Person (Gerät) bzw. je Modul und Instanz (Server). Ein Aufruf geht nie an eine zweite Kopie der Daten.
- **E3:** Vorschlag (Offen 7): `requires` nennt Datei-ID und Vertragsversion. Die Verträglichkeit richtet sich nach E3; bei Unverträglichkeit meldet das aufrufende Programm „bitte aktualisieren“.
- **E4:** Die Rechte der Person gelten für jeden Aufruf über die Capability; ein Umweg über fremde Dateien ist ausgeschlossen.

---

## Pflichttests

**Entschieden** (gelten je Treiber, siehe E6): die drei Konformitätstests Export, keine fremde Zeile ohne Recht, Löschen.

**Entschieden** (E9, Punkt 5; Umsetzung folgt): fehlendes Modul → Frage, nie stille Installation; Nein bei Pflicht → sichtbare Meldung; Nein mit Rückfall → Handeingabe, Hinweis „nicht geprüft, Überschneidungen möglich“ und Lauf-Vermerk „ungeprüft“. Mutanten dazu: „stille Installation“, „stilles Ausgrauen“, „Rückfall ohne Vermerk“ → rot.

**Vorschlag** (nichts davon ist gebaut):

- **Zwei Programme mit demselben Modul** sehen dieselbe Zeile; Mutante „zweite Kopie je Programm“ → rot.
- **Ein Besitzer:** zweiter Modul-Dienst derselben Person und desselben Moduls wird nicht gestartet (`ensure_single`); Mutante „zweiter Prozess erlaubt“ → rot.
- **Herzschlag:** Absturz des Modul-Dienstes wird von jedem Programm sichtbar gemeldet; Wiederverbinden nach Neustart; Mutante „stummes Ausgrauen“ → rot.
- **Verträglichkeit:** gleiche Datei-ID und angehängter Vertrag gleicher Hauptversion → verträglich; andere Hauptversion oder andere Datei-ID → „bitte aktualisieren“, keine zweite Datei; Mutante „zweite Datei bei Unverträglichkeit“ → rot.
- **Vertragseintrag:** Bauplan-Eintrag ohne Datei-ID oder ohne Vertragsversion → abgelehnt (`deny_unknown_fields`, ADR 0099); der `[[module]]`-Tag wird nicht als Vertragsbereich gelesen.
- **Rechte:** Programm ohne Recht auf ein Feld bekommt es nicht; ein eingeschränktes Programm bekommt kein Recht, das ihm nicht gegeben wurde; KI-Aufruf ohne Freigabe → abgelehnt.
- **Keine Rettung:** Migrationen von Programm-DBs in Moduldateien sind nicht vorhanden (Mutante „Migrationsschritt eingebaut“ → rot).
- **Kein Zwischenmodul, Direktaufruf:** Aufruf eines fremden Moduls ohne Capability (direkter Dateizugriff oder fremder Code im Prozess) → abgelehnt; Mutante „Vermittler-Modul eingebaut“ → rot.
- **Zyklen:** `requires` mit Zyklus → Bau abgelehnt (Mutante „Zyklus zugelassen“ → rot).

---

## Folgen

- **Gerüst (fs-rpc, fs-settings, fs-starter):** Der Modul-Dienst kommt in fs-rpc. Der Speicher-Treiber ist eine Schnittstelle mit einem Treiber je Ort (Gerät: Datei je Person; Server: ein Speicher je Modul und Instanz mit Personen-Schlüssel); die drei entschiedenen Konformitätstests gelten je Treiber.
- **Bauplan (ADR 0099):** `[[module]]` behält `name`, `kind`, `version` (Tag). Für Verträge kommt ein Eintrag je Vertrag mit Datei-ID und Vertragsversion als Bereich gleicher Hauptversion hinzu (Feldname offen, Offen 3).
- **Module (Art 1, ADR 0101):** Die Datenhoheit liegt beim Modul; ein Art-1-Modul liefert den Vertrag und seine Datei.
- **Personendaten:** Sie gehören dem Modul `person`; Programme, die es laden, greifen per Vertrag zu. Einordnung einzelner Programme (z. B. `people`): E8.
- **Konflikt-Auflösung:** Eine zweite App ohne eigene Daten ist ein Frontend, mit eigenen Daten ein Programm (E5, E8).
- **Standards:** Der Bezug zu den Standards bleibt wie bisher (ADR 0098 je Datenart); der Speicherort ändert nur die Ablage, nicht das Datenmodell.
- **Befehlsketten (E9):** Ketten über mehrere Module sind Workflows (ADR 0103: Lauf, Stationen, Buchungszeilen). Fest programmiert wird nur die Logik mit den eigenen Daten eines Moduls. Der Modul-Dienst bleibt Endpunkt für die Capability (E2, E4).

---

## Nachzieh-Liste (eigener Doku-Lauf; in diesem ADR NICHT geschrieben)

Je Punkt: ADR und Fundstelle, Änderung.

1. **0097** (Nachtrag N9, Z. 15): Domäne = Moduldatei. E4 (Z. 55): nur die Zwei-Prozesse-Regel durch E2 dieses ADR ersetzen; die Frist-Regel bleibt.
2. **0086** (Fakten, Punkt 4, Z. 88; „Programm-Stores“, Z. 107): Speicher je Modul statt je Programm; für Server eine Zeile mit Personen-Schlüssel neu aufnehmen (keine solche Zeile heute belegt, daher neu zu ergänzen).
3. **0096** E3 (Z. 25): Wortlaut „im Programm“ → „im Besitzer-Modul“.
4. **0098** Tabelle, Zeile „Person“ (Z. 28; am main 49c3a9f9 geprüft): „gehört fs-people“ → Modul `person`. `people` ist ein Programm, das das Modul nutzt (E8).
5. **0099** E1 (Z. 13 und Z. 77): `[[module]]` bleibt Tag; Vertragseintrag mit Datei-ID und Versionsbereich (gleiche Hauptversion) ergänzen (Feldname offen, Offen 3).
6. **0100** Nachtrag E10 (Z. 113): Ort-Regel für Module ergänzen (`$XDG_DATA_HOME/freesynergy/modules/<modul>/`, Windows analog); Speicher-Treiber je Ort (Gerät: Datei je Person; Server: ein Speicher je Modul und Instanz mit Personen-Schlüssel), Strategy-Muster mit Schnittstelle des Treibers. Die Einstellungs-DB bleibt Modul `settings`.
7. **0061** (Entscheidung 1 und 3; Folgen): Facette = Frontend über Daten eines oder mehrerer Module (E8); „Facette“ nur noch Anzeige-Begriff. Ersetzt die bisherige Angabe „zu prüfen“. Der Filter auf EIN Programm entfällt.
8. **0024** (Z. 9, Rechte): Voreinstellung je Programm: selbst installiertes Programm hat volle eigene Rechte auf die Moduldaten der Person, je Programm einschränkbar (E4).
9. **0101** E1 (Datenhoheit): Art 1 trägt die Datenhoheit beim Modul.
10. **Code-Folge (kein Doku-Nachtrag):** fs-rpc `default_data_dir(program)` wird für Moduldaten durch den Modul-Ort ersetzt; Umbau in S10.
11. **0103** (Folgen): Verweis auf E9 ist in diesem Lauf erledigt (Zweig `unreviewed/adr-0104-e9`); Status „Entwurf“ unverändert.
12. **0099** (Bauplan, Feldliste): Felder `requires`, `required` und `fallback` je Abhängigkeit als Entwurf aufnehmen (Offen 7).

---

## Offen

1. **Mehrprozess-Fähigkeit von turso nicht belegt.** Nicht nötig bei E2 (ein Besitzer je Datei); Prüfung nur, falls E2 je fällt.
2. **Ort-Name der Moduldatei ist Vorschlag.** `$XDG_DATA_HOME/freesynergy/modules/<modul>/` und der Windows-Standardordner analog; Verwaltung auf Servern je Instanz.
3. **Feld im Bauplan für die Vertragserklärung fehlt.** ADR 0099 kennt heute für `[[module]]` nur `name`, `kind`, `version`. Vorschlag: ein Vertragseintrag je Vertrag mit Datei-ID und Vertragsversion (Bereich gleicher Hauptversion). Zusätzlich offen: wo der Modul-Dienst die bedienten Verträge meldet, damit sie auffindbar sind (Vorschlag: Manifest des Moduls, vom Dienst abgefragt).
4. **Aufrufkosten ungemessen.** Messung in S10 (ADR 0097 Offen 4).
5. **Speicherbedarf ungemessen.** Messpunkt in S10: Speicher und Cache bei 1000 Personen je Instanz (Ziel kleine Server, 100 bis 1000 Menschen); mitgemessen neben den Aufrufkosten.
6. **Verschlüsselung je Person auf dem Server (später).** Schlüssel je Person für Felder als Schutz beim Thema „Vergessen“ (Gerätediebstahl und Serverzugriff). Nur notiert, nicht jetzt gebaut.
7. **Felder für Abhängigkeiten im Bauplan sind Entwurf.** Prüfung am 2026-11-19 (Suche in `conventions/decisions/`): ADR 0097, 0098, 0099, 0100 und 0101 definieren keine Modul-Abhängigkeit `requires`, `required` oder `fallback`. ADR 0099 nutzt `fs:requires` nur für Components im Frontend-Manifest; das ist ein anderes Feld. Vorschlag: `requires` je Modul mit Datei-ID und Vertragsversion (Regeln wie E3); je Abhängigkeit `required` oder `fallback = "manual"` (E9, Punkt 5); Zyklen-Prüfung beim Bauen.
8. **Lauf-Vermerk „ungeprüft“ fehlt.** ADR 0103 kennt für WARNING einen „sichtbaren Hinweis im Verlauf“ (Punkt 10), aber keinen Vermerk für Eingaben ohne Prüfung. Offen: ob der Vermerk als Feld des Laufs (ADR 0103 Punkt 8, Buchungszeile) oder als Verlaufseintrag gilt.
9. **Idee: Workflow-Schritte aus Verträgen erzeugen (nicht entschieden).** Der capnp-Compiler könnte neben CLI und MCP auch Workflow-Schritte erzeugen (Schalter `--workflow`); jede Vertragsmethode wäre ein Workflow-Baustein aus derselben Quelle, mit demselben Schutz wie bei MCP. Bewertung: sinnvoll, aber nach V1 und ohne Vorrang (Papier zuerst). Die Passung zu ADR 0103 und zu den bestehenden Workflow-Dateien ist noch nicht abschließend geprüft.

---

**English summary.** ADR 0104 (accepted 2026-11-19 by strategy and user). Module data belongs to the module. Logically every row belongs to one person; rights, export and deletion work per person. Physically a storage driver decides (strategy pattern, exchangeable): on a device, one file per module and person; on a server, one store per module and instance with a person key in every row, never one file per person. Three conformance tests apply to every driver: full export of one person, no foreign rows without right, full deletion of one person. One owner process per module (per person on a device, per instance on a server) is served over fs-rpc with `ensure_single`, following the settings precedent in ADR 0100; all programs ask it through the contract. Compatibility is judged by the contract, not the module version: the program declares contract file ID and contract version in its blueprint; the module service declares which contracts it serves. Compatible means same file ID and only appended changes (same major version). On an incompatible major version, the older program must be updated and shows "please update"; there is never a silent second file, and no migration before real users exist. Installed programs get full rights on the person's module data, restrictable per program; access always runs through the contract with the person's identity; AI never without explicit approval. A second app that only shows a module's data is a frontend, not a program. Implementation replaces the program DB in S8 and S10. E8: a facet (ADR 0061) is a frontend over the data of one or more modules; "facet" stays only as a display term. `people` is a program like any other (user decision of 2026-11-19) and does not own person data; the module `person` owns them. Two blueprints that use module `person` (`people`, a contact exchange) are equal. A program with its own module stays a program; a suite stays a bundle of several programs (facet is the opposite of a suite). E9: a module asks another module directly through that module's contract; there is no intermediary module. "Loading briefly" means obtaining, or starting, the other module's service connection, a Cap'n Proto capability used with the person's rights; no reading of foreign files and no foreign code in one's own process. Dependencies are declared in the blueprint or contract (`requires`), and cycles are forbidden. Command chains across modules are workflows (data, traceable in a run, editable), while fixed code covers only a module's own data. If a required module is missing, the program asks whether it may be installed and never installs silently. On "no" the blueprint decides per dependency: `required` stops the function with a visible reason; `fallback = "manual"` lets the person enter the value by hand with a visible "not checked, overlaps possible" note, and the run records "unchecked". Open items: turso multi-process use is unverified, the file location is a proposal, the blueprint field for the contract declaration and `requires` are not yet defined, call costs and storage needs are not yet measured, and the idea of generating workflow steps from contracts is not decided.

---

## Quellen

- Befund der Strategie-Recherche vom 2026-11-19 (nur Lesen; Papier der Strategie, nicht im Repo)
- Opus-Bewertung vom 2026-11-19 mit Fundstellen (Papier der Strategie, nicht im Repo)
- ADR 0024, 0061, 0086, 0096, 0097, 0098, 0099, 0100, 0101 im Repo `conventions/decisions/` (Zeilenangaben beziehen sich auf den Stand 03740da8)
- Externe Standards: [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/); [Cap'n Proto, Sprachdefinition, eindeutige IDs](https://capnproto.org/language.html#unique-ids)
- Nutzerentscheid 6e vom 2026-11-19 (Strategie) mit den Präzisierungen des Nutzers zu E1, E3 und E7, weitergegeben durch den Koordinator am 2026-11-19
- Nutzerwort zu E8 vom 2026-11-19 („Facette ohne eigene Daten ist per Definition ein Frontend.“), Strategie 6e; Nutzerentscheid vom 2026-11-19 (alle Programme gleich), nicht als Datei im Repo
- Nutzerregel vom 2026-11-19 zu E9 (sinngemäß): (1) kein Zwischenmodul für Regeln über mehrere Module; ein Modul fragt ein anderes direkt über dessen Vertrag; (2) Befehlsketten über Module sind Workflows, fest programmiert wird nur die Logik mit eigenen Daten; (3) Idee capnp-Workflow-Schritte als offener Punkt (Offen 9); Zusatz: fehlendes Modul wird erfragt, nie still installiert; bei Nein gilt `required` oder `fallback = "manual"` (Offen 7, E9 Punkt 5)
- [Cap'n Proto, RPC-Protokoll (Capabilities)](https://capnproto.org/rpc.html)

## Nachtrag 2026-11-23: Zahlenformat der Vertragsversion

Status: **Entscheid Strategie 23.11., Nutzer informiert** · ändert in E3 (Z. 50–52), in den Pflichttests (Z. 117), in den Folgen (Z. 129), in der Nachzieh-Liste (Z. 146) und in Offen 3 (Z. 161) **nur das Zahlenformat**. Der Inhalt bleibt: verträglich heißt gleiche Datei-ID und Vertrag nur angehängt. · Regel: ADR 0045, Nachtrag 2026-11-23 „eine Versionsregel“
- Die Vertragsversion ist SemVer `x.y.z` statt `major.minor`. Der Bereich im Bauplan ist ein Bereich in Cargo-Schreibweise.
- „Gleiche Hauptversion“ wird als Cargo-Caret gelesen. Ab 1.0.0 heißt das gleiche Hauptversion. Für `0.y.z` (y ≥ 1) heißt es gleiche Nebenversion.
- Für `0.0.x`-Verträge setzt der Erzeuger `>=0.0.N, <0.1.0` voreingestellt (ADR 0045, Nachtrag, Nr. 4). `0.0.x` darf brechen. Ein Bruch zeigt sich als die sichtbare Meldung „bitte aktualisieren“ aus E3, nie als stiller Fehler.
