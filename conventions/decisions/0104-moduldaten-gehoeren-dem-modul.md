# 0104 – Moduldaten gehören dem Modul: logisch je Person, physisch per Speicher-Treiber, ein Besitzer-Dienst, Verträge statt Modulversionen

Status: **akzeptiert** (Strategie und Nutzer, 2026-11-19; Entscheid 6e; Präzisierungen des Nutzers zu E1, E3 und E7 durch den Koordinator am 2026-11-19) · **ersetzt** in ADR 0097 E4 nur die Zwei-Prozesse-Regel („verschiedene Vertragsversionen = zwei Prozesse“); die Frist-Regel aus E4 (Ende nach Frist ohne Nutzer) gilt weiter · **präzisiert** ADR 0097 Nachtrag N9 (Domäne = Moduldatei) · **ändert** ADR 0099 E1 (Bauplan: Vertragseintrag mit Versionsbereich; der `[[module]]`-Tag bleibt) · **ändert** ADR 0086 (Speicher je Modul statt je Programm) · **ändert** ADR 0096 E3 (Domäne liegt im Besitzer-Modul, nicht im Programm) · **ändert** ADR 0098 Tabelle, Zeile „Person“ (Z. 28) · **ändert** ADR 0100 Nachtrag E10 (Ort-Regel für Module) · **ändert** ADR 0024 (Rechte-Voreinstellung je Programm) · **ändert** ADR 0101 E1 (Art 1 trägt die Datenhoheit) · **prüft** ADR 0061 (Verhältnis Facette zum Modul; keine Festlegung hier) · baut auf ADR 0024, 0061, 0086, 0096, 0097, 0098, 0099, 0100, 0101

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

---

## Pflichttests

**Entschieden** (gelten je Treiber, siehe E6): die drei Konformitätstests Export, keine fremde Zeile ohne Recht, Löschen.

**Vorschlag** (nichts davon ist gebaut):

- **Zwei Programme mit demselben Modul** sehen dieselbe Zeile; Mutante „zweite Kopie je Programm“ → rot.
- **Ein Besitzer:** zweiter Modul-Dienst derselben Person und desselben Moduls wird nicht gestartet (`ensure_single`); Mutante „zweiter Prozess erlaubt“ → rot.
- **Herzschlag:** Absturz des Modul-Dienstes wird von jedem Programm sichtbar gemeldet; Wiederverbinden nach Neustart; Mutante „stummes Ausgrauen“ → rot.
- **Verträglichkeit:** gleiche Datei-ID und angehängter Vertrag gleicher Hauptversion → verträglich; andere Hauptversion oder andere Datei-ID → „bitte aktualisieren“, keine zweite Datei; Mutante „zweite Datei bei Unverträglichkeit“ → rot.
- **Vertragseintrag:** Bauplan-Eintrag ohne Datei-ID oder ohne Vertragsversion → abgelehnt (`deny_unknown_fields`, ADR 0099); der `[[module]]`-Tag wird nicht als Vertragsbereich gelesen.
- **Rechte:** Programm ohne Recht auf ein Feld bekommt es nicht; ein eingeschränktes Programm bekommt kein Recht, das ihm nicht gegeben wurde; KI-Aufruf ohne Freigabe → abgelehnt.
- **Keine Rettung:** Migrationen von Programm-DBs in Moduldateien sind nicht vorhanden (Mutante „Migrationsschritt eingebaut“ → rot).

---

## Folgen

- **Gerüst (fs-rpc, fs-settings, fs-starter):** Der Modul-Dienst kommt in fs-rpc. Der Speicher-Treiber ist eine Schnittstelle mit einem Treiber je Ort (Gerät: Datei je Person; Server: ein Speicher je Modul und Instanz mit Personen-Schlüssel); die drei entschiedenen Konformitätstests gelten je Treiber.
- **Bauplan (ADR 0099):** `[[module]]` behält `name`, `kind`, `version` (Tag). Für Verträge kommt ein Eintrag je Vertrag mit Datei-ID und Vertragsversion als Bereich gleicher Hauptversion hinzu (Feldname offen, Offen 3).
- **Module (Art 1, ADR 0101):** Die Datenhoheit liegt beim Modul; ein Art-1-Modul liefert den Vertrag und seine Datei.
- **Personendaten:** Sie gehören dem Modul `person`; Programme, die es laden, greifen per Vertrag zu. Wie sich einzelne Programme dazu einordnen (z. B. `people`), ist **nicht entschieden** (Offen 7).
- **Konflikt-Auflösung:** Eine zweite App ohne eigene Daten ist ein Frontend, mit eigenen Daten ein Programm (E5).
- **Standards:** Der Bezug zu den Standards bleibt wie bisher (ADR 0098 je Datenart); der Speicherort ändert nur die Ablage, nicht das Datenmodell.

---

## Nachzieh-Liste (eigener Doku-Lauf; in diesem ADR NICHT geschrieben)

Je Punkt: ADR und Fundstelle, Änderung.

1. **0097** (Nachtrag N9, Z. 15): Domäne = Moduldatei. E4 (Z. 55): nur die Zwei-Prozesse-Regel durch E2 dieses ADR ersetzen; die Frist-Regel bleibt.
2. **0086** (Fakten, Punkt 4, Z. 88; „Programm-Stores“, Z. 107): Speicher je Modul statt je Programm; für Server eine Zeile mit Personen-Schlüssel neu aufnehmen (keine solche Zeile heute belegt, daher neu zu ergänzen).
3. **0096** E3 (Z. 25): Wortlaut „im Programm“ → „im Besitzer-Modul“.
4. **0098** Tabelle, Zeile „Person“ (Z. 28): „gehört fs-people“ → Modul `person`. Die Einordnung von `people` bleibt offen (Offen 7).
5. **0099** E1 (Z. 13 und Z. 77): `[[module]]` bleibt Tag; Vertragseintrag mit Datei-ID und Versionsbereich (gleiche Hauptversion) ergänzen (Feldname offen, Offen 3).
6. **0100** Nachtrag E10 (Z. 113): Ort-Regel für Module ergänzen (`$XDG_DATA_HOME/freesynergy/modules/<modul>/`, Windows analog); Speicher-Treiber je Ort (Gerät: Datei je Person; Server: ein Speicher je Modul und Instanz mit Personen-Schlüssel), Strategy-Muster mit Schnittstelle des Treibers. Die Einstellungs-DB bleibt Modul `settings`.
7. **0061** (Entscheidung 1 und 2): **zu prüfen, keine Festlegung:** Facette ist heute an EIN Programm gebunden; das Verhältnis zum Modul-Dienst ist offen (Gespräch).
8. **0024** (Z. 9, Rechte): Voreinstellung je Programm: selbst installiertes Programm hat volle eigene Rechte auf die Moduldaten der Person, je Programm einschränkbar (E4).
9. **0101** E1 (Datenhoheit): Art 1 trägt die Datenhoheit beim Modul.
10. **Code-Folge (kein Doku-Nachtrag):** fs-rpc `default_data_dir(program)` wird für Moduldaten durch den Modul-Ort ersetzt; Umbau in S10.

---

## Offen

1. **Mehrprozess-Fähigkeit von turso nicht belegt.** Nicht nötig bei E2 (ein Besitzer je Datei); Prüfung nur, falls E2 je fällt.
2. **Ort-Name der Moduldatei ist Vorschlag.** `$XDG_DATA_HOME/freesynergy/modules/<modul>/` und der Windows-Standardordner analog; Verwaltung auf Servern je Instanz.
3. **Feld im Bauplan für die Vertragserklärung fehlt.** ADR 0099 kennt heute für `[[module]]` nur `name`, `kind`, `version`. Vorschlag: ein Vertragseintrag je Vertrag mit Datei-ID und Vertragsversion (Bereich gleicher Hauptversion). Zusätzlich offen: wo der Modul-Dienst die bedienten Verträge meldet, damit sie auffindbar sind (Vorschlag: Manifest des Moduls, vom Dienst abgefragt).
4. **Aufrufkosten ungemessen.** Messung in S10 (ADR 0097 Offen 4).
5. **Speicherbedarf ungemessen.** Messpunkt in S10: Speicher und Cache bei 1000 Personen je Instanz (Ziel kleine Server, 100 bis 1000 Menschen); mitgemessen neben den Aufrufkosten.
6. **Verschlüsselung je Person auf dem Server (später).** Schlüssel je Person für Felder als Schutz beim Thema „Vergessen“ (Gerätediebstahl und Serverzugriff). Nur notiert, nicht jetzt gebaut.
7. **Einordnung von `people` und Verhältnis Facette zum Modul (ADR 0061).** Nicht entschieden; Gespräch mit dem Nutzer nötig.

---

**English summary.** ADR 0104 (accepted 2026-11-19 by strategy and user). Module data belongs to the module. Logically every row belongs to one person; rights, export and deletion work per person. Physically a storage driver decides (strategy pattern, exchangeable): on a device, one file per module and person; on a server, one store per module and instance with a person key in every row, never one file per person. Three conformance tests apply to every driver: full export of one person, no foreign rows without right, full deletion of one person. One owner process per module (per person on a device, per instance on a server) is served over fs-rpc with `ensure_single`, following the settings precedent in ADR 0100; all programs ask it through the contract. Compatibility is judged by the contract, not the module version: the program declares contract file ID and contract version in its blueprint; the module service declares which contracts it serves. Compatible means same file ID and only appended changes (same major version). On an incompatible major version, the older program must be updated and shows "please update"; there is never a silent second file, and no migration before real users exist. Installed programs get full rights on the person's module data, restrictable per program; access always runs through the contract with the person's identity; AI never without explicit approval. A second app that only shows a module's data is a frontend, not a program. Implementation replaces the program DB in S8 and S10. Open items: turso multi-process use is unverified, the file location is a proposal, the blueprint field for the contract declaration is not yet defined, call costs and storage needs are not yet measured.

---

## Quellen

- Befund der Strategie-Recherche vom 2026-11-19 (nur Lesen; Papier der Strategie, nicht im Repo)
- Opus-Bewertung vom 2026-11-19 mit Fundstellen (Papier der Strategie, nicht im Repo)
- ADR 0024, 0061, 0086, 0096, 0097, 0098, 0099, 0100, 0101 im Repo `conventions/decisions/` (Zeilenangaben beziehen sich auf den Stand 03740da8)
- Externe Standards: [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/); [Cap'n Proto, Sprachdefinition, eindeutige IDs](https://capnproto.org/language.html#unique-ids)
- Nutzerentscheid 6e vom 2026-11-19 (Strategie) mit den Präzisierungen des Nutzers zu E1, E3 und E7, weitergegeben durch den Koordinator am 2026-11-19
