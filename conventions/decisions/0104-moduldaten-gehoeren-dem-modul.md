# 0104 – Moduldaten gehören dem Modul: eine Datei je Modul und Person, ein Besitzer-Dienst, Verträge statt Programmversionen

Status: **Angenommen** (Strategie/Nutzer 19.11.2026: Entscheid 6e nach Nutzerwunsch; Präzisierung zu E3 vom Koordinator am 19.11.2026 nach Nutzerwort: verglichen wird die Vertragsversion, nicht die Modulversion) · **ändert** ADR 0099 E1 (Bauplan: Vertragseintrag mit Versionsbereich, `[[module]]`-Tag bleibt) · **ersetzt** ADR 0097 E4 („zwei Vertragsversionen = zwei Prozesse“) · **präzisiert** ADR 0097 Nachtrag N9 (Domäne = Moduldatei) · **ändert** ADR 0096 E3 (Domäne liegt im Besitzer-Modul, nicht im Programm) · **ändert** ADR 0086 (Datei je Modul-Domäne) · **ändert** ADR 0098 E3 (Person gehört dem Modul `person`) · **ändert** ADR 0100 Nachtrag E10 (Ort-Regel für Module) · **ändert** ADR 0061 (Facette bindet an ein Modul) · **ändert** ADR 0024 (Rechte-Voreinstellung je Programm) · **ändert** ADR 0101 E1 (Art 1 trägt die Datenhoheit) · baut auf ADR 0024, 0061, 0086, 0096, 0097, 0098, 0099, 0100, 0101

Die Nachträge in den genannten ADRs werden in einem eigenen Doku-Lauf geschrieben; die vollständige Liste steht unter „Nachzieh-Liste“.

**Nummer:** **0104**. Herleitung: `fs-documentation` origin/main (03740da8) endet bei `0103-board-spaltenquelle-lauf-mass.md`; die Nummer 0104 ist frei (auch in den `unreviewed/*`-Zweigen nicht belegt).

**Sprache:** Das Repo führt ADRs nur auf Deutsch (`conventions/decisions/`); daher nur eine Fassung. Die englische Kurzfassung am Ende folgt dem Muster von ADR 0103.

---

## Kontext

Heute liegen Daten je **Programm**-Datenbank, nicht je Modul. Belegt:

- ADR 0096 E3 legt die Domäne `forms` in die Datei `forms.db` des Programms fs-forms; „eine Domäne je Datei“, nur `fs-forms serve` öffnet sie.
- ADR 0086 (Nachtrag, Offen 4) und die Registry von fs-objects (`SecondDomain`, registry.rs:143): je Store-Datei nur eine Programm-Domäne.
- ADR 0100 Nachtrag E10: die Personen-Datenbank liegt unter `$XDG_DATA_HOME/freesynergy/settings/settings.db`, „wie alle Programm-DBs“.
- Die Ordnerregel im Code, `default_data_dir(program)`, ergibt `$XDG_DATA_HOME/freesynergy/<program>`.

Das Ergebnis: Zwei Programme, die dasselbe Modul nutzen (z. B. `people` und eine zweite App, die beide das Modul `person` laden), hätten jeweils eine eigene Kopie der Personendaten. Die zweite App könnte die Daten nicht sehen, ohne das erste Programm zu starten. Das widerspricht dem Zweck „dieselben Daten“ und der Selbstbestimmung über Daten (Nutzerregel: Rechte vorab per Vertrag je Modul, ADR 0024 und 0102).

Offen war außerdem, ob eine Modul-Domäne eine eigene Datei ist (ADR 0097 N9) oder Teil der Programm-DB (ADR 0086, 0096 E3). Zwei Widersprüche wurden geprüft:

- ADR 0098 Tabelle Z. 9 und Z. 28 („Person gehört fs-people“) widerspricht dem Grundsatz „Daten gehören dem Modul“.
- ADR 0097 E4 („verschiedene Vertragsversionen = zwei Prozesse“) würde zwei Besitzer für dieselbe Datei bedeuten.

Ein bereits angenommenes Vorbild gibt es: ADR 0100 Nachtrag Entscheidung 8, „ein Prozess besitzt die DB; alle anderen sprechen über den Vertrag“ (fs-objects: eine Datei, ein Prozess). Dieses Muster gilt für die Einstellungen bereits und wird hier auf alle Module übertragen.

Korrektur zum Befund (Prüfung durch den Opus-Gegenleser): Die Aussage „kein WAL gefunden“ ist falsch. Die Datenbank-Engine turso schreibt eine `-wal`-Datei (ADR 0086 Nachtrag; fs-objects turso/purge.rs:73, crypto.rs:8). Ob turso mehrere Prozesse auf einer Datei zulässt, ist **nicht belegt** (siehe Offen 1).

Bestand (belegt): ADR 0024 (jedes Programm kann OAuth2 und SCIM), ADR 0061 (Facette = Filter auf EIN Programm), ADR 0098 (Verweis statt Kopie: ein Programm speichert für Person nur `PersonRef`), ADR 0099 E1 (`[[module]]` mit `name`, `version` = exakter Tag des Modul-Repos), ADR 0101 (Art 1 Standard-Modul, Art 2 Verfahren ab zwei Programmen, Art 3 Component, Art 4 Programm = Bauplan).

---

## Entscheidung

**E1. Moduldaten gehören dem MODUL, nicht dem Programm; logisch immer einer Person.**
- Moduldaten gehören **logisch** dem Modul, und jede Zeile gehört **logisch** einer Person. Rechte, Export und Löschen gelten je Person; das ist der Vertrag.
- Die Daten werden von **jedem Programm mitbenutzt**, das dieses Modul in seinem Bauplan lädt.
- Beispiel: `people` und eine zweite App laden beide nur das Modul `person` und zeigen dieselben Daten.
- **Physisch** entscheidet der **Speicher-Treiber** des Modul-Dienstes (Strategy-Muster; austauschbar hinter einer Schnittstelle `Speicher-Treiber`, Methoden u. a. öffnen, lesen, schreiben, exportieren, löschen je Person). Die Wahl je Ort ist in E7 festgelegt.
- Vorschlag für den Ort des Gerätespeichers (Offen 2): `$XDG_DATA_HOME/freesynergy/modules/<modul>/`; Windows analog zum Standardordner.

**E2. Genau EIN Besitzer-Prozess je Modul und Person.**
- Der Modul-Dienst öffnet den Speicher (je nach Treiber E7: Datei je Gerät oder ein Speicher je Instanz); er läuft über fs-rpc und wird mit `ensure_single` gestartet (Vorbild ADR 0100 Nachtrag Entscheidung 8). „Ein Besitzer“ heißt: ein Dienst je Modul und Person auf dem Gerät bzw. ein Dienst je Modul auf dem Server.
- **Alle** Programme fragen ihn über den Vertrag des Moduls. Damit gibt es nur eine Stelle, an der Rechte durchgesetzt werden.
- Dies ersetzt die Regel aus ADR 0097 E4 („zwei Vertragsversionen = zwei Prozesse“). Sie entfällt.
- Herzschlag und Wiederverbinden sind **Pflicht**: Ein Absturz des Modul-Dienstes trifft alle Programme des Moduls; die Programme müssen sich sichtbar melden und nach dem Neustart selbst wieder verbinden.
- Der Dienst endet nach einer Frist ohne Nutzer (ADR 0097 E4, unverändert).

**E3. Unverträgliche Hauptversion: das ältere Programm wird aktualisiert.**
- Ein Programm erklärt im Bauplan **je Vertrag**, welchen Vertrag es braucht: capnp-Datei-ID und Vertragsversion (`major.minor`). Der Modul-Dienst erklärt, welche Verträge er bedient. Die Modulversion selbst ist für die Verträglichkeit egal, solange sie den Vertrag bedient.
- **Verträglich** heißt: gleiche Datei-ID UND der Vertrag wurde nur angehängt (gleiche Hauptversion; ADR 0099 Entscheidung 5, ADR 0086 „Spalten nur anhängen“).
- Der Versionsbereich gilt für den **Vertrag** (Datei-ID plus Vertragsversion gleicher Hauptversion), **nicht** für den Modul-Tag in `[[module]]`. Der Modul-Tag bleibt, was er ist (ADR 0099 E1).
- Bei Unverträglichkeit gibt es **nie eine stille zweite Datei**: der Zweck ist „dieselben Daten“. Das ältere Programm muss erst aktualisiert werden. Es meldet sichtbar „bitte aktualisieren“ und stellt nicht still aus (Regel „Fehlende Datenquelle melden“).
- Keine Migration, solange es keine echten Nutzer gibt (Daten dürfen weg; ADR 0086 und Nutzerregel „Daten nicht retten“).
- Der Modul-Dienst meldet die bedienten Verträge; das ist Pflicht und muss auffindbar sein (Offen 3).

**E4. Rechte und Identität.**
- Ein selbst installiertes Programm hat **volle eigene Rechte** auf die eigenen Moduldaten. Die Rechte sind **je Programm einschränkbar** (Nutzerregel „Einstellbar statt fest“; ADR 0024 wird entsprechend geändert).
- Der Zugriff läuft **immer** über den Vertrag mit der Identität der Person (ADR 0098 Freigabe; ADR 0102).
- KI greift nie ohne ausdrückliche Freigabe zu (Bot-Platz, ADR 0091).

**E5. Einordnung zweiter Apps.**
- Eine zweite App, die nur Daten eines Moduls zeigt (Beispiel: „Kontaktbörse“ nur mit Personendaten und Filter), ist ein **Frontend** (forms-Beschreibung auf dem Modul), kein Programm.
- Hat sie **eigene Daten** (Beispiel: Gesuche, Inserate), ist sie ein eigenes Programm mit eigenem Modul; Personen kommen per Vertrag aus dem Modul `person`.
- Eine Suite entsteht erst, wenn mehrere Programme gebündelt werden (Facette ≠ Suite; ADR 0061).
- ADR 0061 bindet Facetten künftig an ein **Modul** statt an ein Programm (Nachzieh-Liste).

**E6. Umsetzung im Gerüst.**
- Umgesetzt wird **Modul-Dienst mit Speicher-Treiber** statt Programm-DB, in S8 (Speicher aus dem Bauplan) und S10 (Client und Root).
- Heutige Programm-DBs dürfen wegfallen; Daten werden **nicht** gerettet (Nutzerregel).
- Das Messen der Aufrufkosten (ADR 0097 Offen 4) und der Speicherbedarf bei 1000 Personen je Instanz sind Teil von S10.

**E7. Speicher-Treiber: logisch je Person, physisch je Ort.**
- Der Modul-Dienst spricht einen **Speicher-Treiber** über eine Schnittstelle (Strategy-Muster; der Treiber ist austauschbar, der Vertrag bleibt gleich). Der Treiber kennt die Person bei jedem Zugriff; der Vertrag prüft die Rechte.
- **Gerät** (eine oder wenige Personen): **eine Datei je Modul und Person** (Treiber „Datei je Person“).
- **Server**: **EIN Speicher je Modul und Instanz**, mit einem **Personen-Schlüssel in jeder Zeile**; Treiber-Ziel ist eine Turso-Datei, später Postgres; ein gemeinsamer Cache. **Keine Datei je Person** auf dem Server.
- Begründung: Viele Personen auf einem Server würden sonst viele Dateien und Caches erzeugen. Ziel sind dezentrale kleine Server für 100 bis 1000 Menschen; der Speicherbedarf dafür wird in S10 gemessen (Offen 6).

---

## Pflichttests (Vorschlag; nichts davon ist gebaut)

- **Konformität des Treibers und des Modul-Dienstes (gelten unabhängig vom Treiber, Gerät wie Server):**
  1. **Export einer Person vollständig:** alle Zeilen dieser Person, keine fremden; Mutante „Export lässt Zeilen aus“ → rot.
  2. **Ohne Recht keine fremde Zeile:** eine Person sieht ohne Recht keine Zeile einer anderen Person; Mutante „Filter nach Person fehlt“ → rot.
  3. **Löschen einer Person vollständig:** nach dem Löschen bleibt keine Zeile dieser Person (auch nicht im Cache); Mutante „Cache behält Zeilen“ → rot.
- **Zwei Programme mit `person`** sehen dieselbe Zeile; Mutante „zweite Kopie je Programm“ → rot.
- **Ein Besitzer:** zweiter Modul-Dienst derselben Person und desselben Moduls wird nicht gestartet (`ensure_single`); Mutante „zweiter Prozess erlaubt“ → rot.
- **Herzschlag:** Absturz des Modul-Dienstes wird von jedem Programm sichtbar gemeldet; Wiederverbinden nach Neustart; Mutante „stummes Ausgrauen“ → rot.
- **Verträglichkeit:** gleiche Datei-ID und angehängter Vertrag gleicher Hauptversion → verträglich; andere Hauptversion oder andere Datei-ID → „bitte aktualisieren“, keine zweite Datei; Mutante „zweite Datei bei Unverträglichkeit“ → rot.
- **Vertragseintrag:** Bauplan-Eintrag ohne Datei-ID oder ohne Vertragsversion → abgelehnt (`deny_unknown_fields`, ADR 0099); der `[[module]]`-Tag wird nicht als Vertragsbereich gelesen.
- **Rechte:** Programm ohne Recht auf ein Feld bekommt es nicht; ein eingeschränktes Programm bekommt kein Recht, das ihm nicht gegeben wurde (Rechte je Programm); KI-Aufruf ohne Freigabe → abgelehnt.
- **Keine Rettung:** Migrationen von Programm-DBs in Moduldateien sind nicht vorhanden (Mutante „Migrationsschritt eingebaut“ → rot).

---

## Folgen

- **Gerüst (fs-rpc, fs-settings, fs-starter):** Der Modul-Dienst kommt in fs-rpc; `default_data_dir(program)` wird für Moduldaten durch den Modul-Ort ersetzt (Code, S10). Der Speicher-Treiber ist eine Schnittstelle mit Treiber je Ort (Gerät: Datei je Person; Server: ein Speicher je Modul und Instanz mit Personen-Schlüssel), Konformitätstests je Treiber (siehe Pflichttests).
- **Bauplan (ADR 0099):** `[[module]]` behält `name`, `kind`, `version` (Tag). Für Verträge kommt ein Eintrag je Vertrag mit Datei-ID und Vertragsversion als Bereich gleicher Hauptversion hinzu (Feldname offen, Offen 3).
- **Module (Art 1, ADR 0101):** Die Datenhoheit liegt beim Modul; ein Art-1-Modul liefert den Vertrag und seine Datei. Programme mit einem Modul sind Frontends oder Bauplan-Programme über den Vertrag.
- **Personen:** Das Modul `person` hält die Personendaten. Das Programm `people` ist ein Frontend auf diesem Modul (Nachzieh-Liste).
- **Konflikt-Auflösung:** Die zweite App ohne eigene Daten ist ein Frontend, mit eigenen Daten ein Programm (E5).
- **Standards:** Der Bezug zu den Standards bleibt wie bisher (ADR 0098 je Datenart); der Speicherort ändert nur die Ablage, nicht das Datenmodell.

---

## Nachzieh-Liste (eigener Doku-Lauf; in diesem ADR NICHT geschrieben)

Je Punkt: ADR und Abschnitt, Änderung.

1. **0097** (Nachtrag N9, Z. 15): Domäne = Moduldatei. E4 (Z. 55) durch E2 dieses ADR ersetzen (Prozess-Modell: ein Besitzer je Modul und Person; „zwei Vertragsversionen = zwei Prozesse“ entfällt; Gegenwort des Nutzers ist mit diesem ADR beantwortet).
2. **0086** (Fakten, Nachtrag, „Programm-Stores“): Datei je Modul-Domäne statt je Programm.
3. **0096** E3 (Z. 25): Wortlaut „im Programm“ → „im Besitzer-Modul“; `default_data_dir(program)` als Gegenstück nennen.
4. **0098** E3 Tabelle (Z. 9) und Z. 28: „Person gehört fs-people“ → Modul `person`; `people` = Programm/Frontend auf diesem Modul.
5. **0099** E1: `[[module]]` bleibt Tag; Vertragseintrag mit Datei-ID und Versionsbereich (gleiche Hauptversion) ergänzen (Feldname offen, Offen 3).
6. **0100** Nachtrag E10 (Z. 113): Ort-Regel für Module ergänzen (`$XDG_DATA_HOME/freesynergy/modules/<modul>/`, Windows analog); die Einstellungs-DB bleibt Modul `settings`.
7. **0061** (Entscheidung 1 und 2): Facette bindet an ein Modul; Frontends je Modul-Facette.
8. **0024** (Z. 9, Rechte): Voreinstellung je Programm: selbst installiertes Programm hat volle eigene Rechte auf die eigenen Moduldaten, je Programm einschränkbar (E4).
9. **0101** E1 (Art 1 trägt die Datenhoheit: Modul).
10. **fs-rpc** `default_data_dir(program)`: Code, nicht Doku; Umbau in S10.
11. **0100 Nachtrag E10 (Ort-Regel)** wird zusätzlich präzisiert: Der Speicher-Treiber je Ort (Gerät: Datei je Person; Server: ein Speicher je Modul und Instanz mit Personen-Schlüssel) ersetzt die Ordnerregel je Programm; Vorlage: Strategy-Muster mit Schnittstelle des Treibers.
12. **0086** (Zeile mit Personen-Schlüssel): Moduldaten auf dem Server tragen in jeder Zeile den Personen-Schlüssel; Gerät: Datei je Person ohne Schlüssel-Pflicht.

---

## Offen

1. **Mehrprozess-Fähigkeit von turso nicht belegt.** Nicht nötig bei E2 (ein Besitzer je Datei); Prüfung nur, falls E2 je fällt.
2. **Ort-Name der Moduldatei ist Vorschlag.** `$XDG_DATA_HOME/freesynergy/modules/<modul>/` und der Windows-Standardordner analog; Verwaltung auf Servern je Instanz.
3. **Feld im Bauplan für Vertragserklärung fehlt.** ADR 0099 kennt heute für `[[module]]` nur `name`, `kind`, `version`. Vorschlag: ein Vertragseintrag je Vertrag mit Datei-ID und Vertragsversion (Bereich gleicher Hauptversion). Zusätzlich offen: wo der Modul-Dienst die bedienten Verträge meldet, damit sie auffindbar sind (Vorschlag: Manifest des Moduls, vom Dienst abgefragt).
4. **Aufrufkosten ungemessen.** Messung in S10 (ADR 0097 Offen 4).
6. **Speicherbedarf ungemessen.** Messpunkt in S10: Speicher und Cache bei 1000 Personen je Instanz (Ziel kleine Server, 100 bis 1000 Menschen); mitgemessen neben den Aufrufkosten.
7. **Verschlüsselung je Person auf dem Server (später).** Schlüssel je Person für Felder als Schutz beim Thema „Vergessen“ (Gerätediebstahl und Serverzugriff). Nur notiert, nicht jetzt gebaut; Bezug: Vorhaben „Vergessen und Geräteangriff“ (nur lesen, nicht entschieden).
5. **Gegenwort zu ADR 0097 E4** ist mit E2 beantwortet; die Strategie hat diese Antwort nach Nutzerwort 19.11.2026 übernommen.

---

**English summary.** ADR 0104 (number 0104, free on main at 03740da8; accepted 19 Nov 2026 by strategy and user). Module data belongs to the module, not to the program. Logically every row belongs to one person; rights, export and deletion work per person. Physically a storage driver decides (strategy pattern, exchangeable): on a device, one file per module and person; on a server, one store per module and instance with a person key in every row, never one file per person. Three conformance tests apply to every driver: full export of one person, no foreign rows without right, full deletion of one person. Exactly one owner process per module and person, served over fs-rpc with `ensure_single`, following the settings precedent in ADR 0100; all programs ask it through the contract. Compatibility is judged by the contract, not the module version: the program declares contract file ID and contract version in its blueprint; the module service declares which contracts it serves. Compatible means same file ID and only appended changes (same major version). On an incompatible major version, the older program must be updated and shows "please update"; there is never a silent second file, and no migration before real users exist. Installed programs get full rights on their own module data, restrictable per program; access always runs through the contract with the person's identity; AI never without explicit approval. A second app that only shows a module's data is a frontend, not a program. Implementation replaces the program DB in S8 and S10. Open items: turso multi-process use is unverified, the file location is a proposal, the blueprint field for the contract declaration is not yet defined, and call costs are not yet measured.

---

## Quellen

- Befund der Strategie-Recherche vom 19.11.2026 (nur Lesen; Papier der Strategie, nicht im Repo)
- Opus-Bewertung vom 19.11.2026 mit Fundstellen (Papier der Strategie, nicht im Repo)
- ADR 0024, 0061, 0086, 0096, 0097, 0098, 0099, 0100, 0101 im Repo `conventions/decisions/` (Zeilenangaben beziehen sich auf den Stand 03740da8)
- Nutzerentscheid 6e vom 19.11.2026 (Strategie) und Präzisierung zu E3 durch den Koordinator am 19.11.2026
