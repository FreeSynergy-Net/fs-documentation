# 0087 – Programmnamen sind generisch: Fähigkeit oder Daten, nicht Gattung

Status: akzeptiert (Nutzer, 2026-11-15) · ersetzt in ADR 0076 Punkt 3 „fs-store → Facette auf fs-marketplace“ (jetzt fs-software, Marktplatz ist Facette; Platzhalter fs-marketplace gelöscht) · erweitert ADR 0055 (sprechende Namen), 0080 (Umzug fs-wiki → fs-text) · Grundlage: Namensinventar der Strategie (Arbeitsstand, 2026-11-15)

## Entscheidung
1. **Ein Programmname nennt die Fähigkeit oder die Daten**, die das Programm besitzt (z. B. tasks, files, people, calendar, maps). Er nennt keine App-Gattung und keine Bauform wie „wiki“ oder „whiteboard“. Die konkrete Ausprägung (Wiki, Buchungen, Marktplatz …) ist eine **Facette**.
2. **Umbenennungen, jetzt statt später:**

| alt | neu |
|---|---|
| fs-wiki | fs-text (ADR 0080) |
| fs-whiteboard | fs-draw |
| fs-messenger | fs-messages |
| fs-history | fs-activity |
| fs-streaming | fs-broadcast |
| ~~fs-resources~~ | ~~fs-inventory~~ – **zurückgenommen**, fs-resources bleibt (siehe Nachtrag Ressourcen) |
| fs-surveys | fs-forms (Umfrage, Abstimmung, Anmeldung sind Facetten) |
| fs-store | fs-software (später fs-packages; Marktplatz, Server-Katalog sind Facetten; Store ist keine Facette; fs-packages hat nur seine Frontends (Einfach, Admin)) |
| fs-hub | fs-registry (wer läuft wo, Erreichbarkeit) |

3. **Ablauf** nur über den Workflow `umbenennen`. Er geht durch Repo, Crates `fs-<x>-*`, Pins in anderen Repos und Katalog (`replaces`). Die Doku zieht der Workflow `doku-mitziehen` im selben Lauf mit, sonst ist das Gate ROT. Ein alter Name wird nie wieder vergeben (ADR 0080).
4. **Nachtrag (Nutzer, 2026-11-15):** Auch fs-surveys, fs-store und fs-hub werden umbenannt (siehe Tabelle); Umbenennen soll Sinn machen und logisch sein. fs-store und fs-hub zuletzt, da viele Abhängigkeiten.
5. **Helpdesk ist eine Suite**, kein Programm: Hilfe aus fs-text, Anrufe und Nachrichten über fs-messages, Kunden aus fs-people, Rückrufe über fs-calendar, optional Tickets über fs-tasks.
6. **Geplante Programme (Nutzer-JA):** fs-data (Tabellen), fs-paint (Rasterbilder), fs-audio (Audio). Dazu (Nutzer-JA, 2026-11-15): fs-3d (3D-Modelle, glTF), fs-video (Videoschnitt, OpenTimelineIO), fs-devices (Geräte und Sensoren, W3C WoT/Matter; Hausautomation und Robotik sind Facetten), fs-web (Lesezeichen und Web-Archiv; Browser als Frontend, Engine per Wrapper), fs-finance (Buchungen und Rechnungen, XRechnung/ISO 20022), fs-learning (Kurse, xAPI), fs-vault (ADR 0067). fs-games ist für die Zukunft vorgemerkt.
7. **Ziel für den Monat (Nutzer):** Jedes Programm bekommt die Grundsachen. Das heißt: Das Programm startet, kann einfache Dinge und lässt sich beenden; dazu kommen die Frontends. Fertig ausprogrammiert wird später. Neue Programme entstehen nur über den Workflow `programm-neu`.

## Folgen
- Neue Programme bekommen nur Namen nach Regel 1. Der Workflow `programm-neu` prüft das.
- Die Umbenennung auf GitHub gibt die Strategie je Programm nach dem Befehlsplan des Koordinators frei.

## Nachtrag (Nutzer, 2026-11-15): offene Standards, in Rust
- Wir suchen **offene Standards**. Gibt es eine Umsetzung, wird sie **in Rust genutzt oder nach Rust migriert** und von uns auch auf crates.io angeboten. Keine C-Bibliotheken als Dauerlösung (Beispiel Opus: kein libopus, sondern ein Rust-Encoder, den wir unterstützen oder selbst schreiben).
- MPL-2.0 ist nur als unveränderte Abhängigkeit erlaubt; Änderungen gehen an das jeweilige Projekt.
- Browser: Kandidat ist Blitz (HTML/CSS) plus eine reine Rust-JS-Engine hinter dem Trait `WebEngine`. Entschieden wird nach Recherche und Spike.

## Nachtrag (Nutzer, 2026-11-16): Ressourcen nach ValueFlows, Katalog ist Filter
- **fs-resources bleibt** (die Umbenennung nach fs-inventory ist zurückgenommen). Es besitzt nach ValueFlows: Arten von Sachen (ResourceSpecification, das „Produkt“), konkrete Sachen bzw. Bestand (EconomicResource), **Angebote und Gesuche** (Intent, dieselbe Form in beide Richtungen), Zusammenstellungen (Proposal/Katalog), Absprachen und Übergaben (Commitment, EconomicEvent). Die Abläufe aus ValueFlows (Recipe/Process) bleiben bei fs-workflows (ADR 0076). Ein eigenes fs-product oder fs-offers gibt es nicht.
- **Ein Katalog ist Gruppierung und Filter:** Er erklärt, was er enthalten darf (Art aus einer festen Liste, Bedingungen aus typisierten Feldern, z. B. Preis = 0 für „kostenlos“). Eine Prüfung meldet Einträge, die nicht passen. Ein **Marktplatz** ist ein Katalog, der andere Kataloge zusammenfasst. Ein **Laden** ist eine Suite (fs-groups, fs-maps, fs-resources, ggf. fs-finance).
- **Keine konkreten Kataloge als Programm:** Das heutige Repo fs-catalog enthält nur die Daten des Katalogs von FreeSynergy (Filter: Software, kostenlos). Es heißt künftig **`FreeSynergy/Catalog`**.
- **Schreibweise der Repos (Nutzer, 2026-11-16):** Programme werden klein geschrieben (`fs-text`). Daten-Repos werden groß geschrieben wie ihr Name (`Catalog`).
- **fs-calendar bleibt:** Es besitzt die Termine (JSCalendar Event). „date“ ist ein Datentyp, und „events“ wäre mit den Ereignissen der Workflows (CloudEvents, ADR 0081) verwechselbar.

## Nachtrag 2026-11-16: Einzahl/Mehrzahl, Daten-Repos

Der Nutzer hat die Namensregel endgültig festgelegt. Dieser Nachtrag gilt vor den Nachträgen oben, soweit er von ihnen abweicht (siehe „Ersetzt“).

**Regel**
1. **Ein Programm, das viele gleichartige Dinge verwaltet, heißt in der Mehrzahl und klein:** fs-files, fs-tasks, fs-texts, fs-activities, fs-messages, fs-forms, fs-packages, fs-calendars, fs-sounds, fs-videos, fs-models (Audio, Video, 3D: nur geplant).
2. **Eine Tätigkeit wird als Verb benannt:** fs-draw, fs-broadcast, fs-paint.
3. **Wörter ohne Mehrzahl bleiben:** `data` (fs-data) bleibt. `software` ist kein Programmname mehr (das Store-Programm heißt fs-packages). fs-sounds, fs-videos und fs-models sind trotzdem Mehrzahl-Namen, weil „audios“ im Englischen ungewöhnlich ist. **Ausnahme:** fs-registry steht in der Einzahl, weil es nur eine gibt. `people` ist schon Mehrzahl.
4. **Daten-Repos heißen in der Einzahl und groß geschrieben:** `Catalog` (bisher fs-catalog; kein Katalog ist ein Programm, siehe oben), `Repository` (das apt/dnf-Daten-Repo, bisher fs-packages nach ADR 0078). `Documentation` bleibt Daten-Repo; die Schreibweise ist offen (Folgepunkt, nicht entschieden). Reihenfolge: erst das Daten-Repo fs-packages → `Repository`, danach das Programm fs-store → fs-packages, weil der Name vorher belegt ist. Bewusste einmalige Ausnahme von ADR 0080: Der Name fs-packages geht an das Programm (früher fs-store); das apt/dnf-Daten-Repo heißt jetzt Repository; es gibt keine Nutzer, Nutzerentscheidung 16.11.2026; die Umbenennung fs-packages → Repository steht deshalb nicht als Paar in retired-names.
5. **Bibliotheken behalten ihre Namen:** fs-components, fs-objects, fs-jscalendar, fs-types, fs-blinc, fs-interfaces.
6. **Capability-Keys bleiben unverändert** (append-only).
7. **Übersetzungsordner heißen `locales/`** (de.mf2, en.mf2), nie `texts/`, weil das mit dem Programm fs-texts kollidiert. Gilt ab jetzt für alle neuen Programme.
8. **Umbenennungen laufen nur über den Workflow `umbenennen`** (Skript mit `--keep`, `replaces`, Sperrliste). **Jede** Umbenennung bekommt eine Weiterleitung (mkdocs `redirect_maps`).
9. **Beschlossene Umbenennungen:**

| alt | neu | Hinweis |
|---|---|---|
| fs-wiki | fs-texts | ersetzt den Zielnamen fs-text aus ADR 0080 |
| fs-history | fs-activity → fs-activities | zweite Stufe, siehe Risiken |
| fs-messenger | fs-messages | |
| fs-surveys | fs-forms | |
| fs-whiteboard | fs-draw | Verb (Regel 2) |
| fs-streaming | fs-broadcast | Verb (Regel 2) |
| fs-hub | fs-registry | Einzahl (Regel 3) |
| fs-calendar | fs-calendars | ohne Ausnahme |
| fs-store | fs-packages | erst nach dem Daten-Repo fs-packages → Repository |
| fs-catalog | Catalog | Daten-Repo, kein Programm |

10. **Bestandsschutz:** Bis zur Umbenennung gelten die alten Namen. Die Reihenfolge nach Risiko legt die Strategie in einem Ablaufplan fest; der Ablaufplan ist nicht Teil dieses ADR.

**Ersetzt**
- In „Entscheidung“, Punkt 2: fs-wiki → fs-text wird fs-texts; fs-store → fs-software wird fs-packages.
- In „Nachtrag (Nutzer, 2026-11-15)“, Punkt 6 (geplante Programme): fs-audio wird fs-sounds, fs-3d wird fs-models, fs-video wird fs-videos. fs-data und fs-paint bleiben.
- In „Nachtrag (Nutzer, 2026-11-16): Ressourcen“: „fs-calendar bleibt“ entfällt; es gilt fs-calendars (Regel 9). Die Schreibweise „groß wie ihr Name“ wird durch Regel 4 (Einzahl) konkretisiert.

**Folgen**
- Neue Programme folgen den Regeln 1 bis 3. Der Workflow `programm-neu` prüft das.
- **Risiko fs-history → fs-activity → fs-activities:** GitHub dokumentiert Weiterleitungen nur für eine einmalige Umbenennung; eine Kette über zwei Namen ist nicht belegt [nicht belegt]. Pins auf den ältesten Namen könnten brechen. mkdocs `redirect_maps` zeigen beide Stufen direkt auf den Endnamen. Die zweite Stufe erst nach der Pin-Prüfung.
- **Risiko fs-packages → Repository:** Die Pages-URL ändert sich, apt- und dnf-Quellen der Nutzer würden brechen. Eine Weiterleitung für Pages ist nicht belegt [nicht belegt]. Domain und Pages-URL werden vor der Umbenennung festgelegt (ADR 0078, offen).
- **Folgepunkte (nicht erledigt):** `conventions/CONVENTIONS.md` (Abschnitt 4) und `conventions/doku-standard.md` auf `locales/` und diese Regel ziehen; die Schreibweise von `Documentation` entscheiden.

**Store (Nutzer, 2026-11-16):** Store ist keine Facette; fs-packages hat nur seine Frontends (Einfach, Admin).

## Nachtrag 2026-11-16: fs-decisions (Beschlüsse und Abstimmungen), Terminfindung als Facette

Der Nutzer hat Frage 49 mit JA beantwortet (2026-11-16). Dieser Nachtrag ändert die Tabelle in „Entscheidung“, Punkt 2: Dort steht bei fs-surveys → fs-forms „Umfrage, Abstimmung, Anmeldung sind Facetten“ (Zeile 17); „Abstimmung“ ist ab hier keine Facette von fs-forms mehr.

**Kontext**
- Der Entscheidungs-Plan (Arbeitsstand `pilot-decisions/PLAN.md`, §4, §9) wendet den „Wessen Daten?“-Test an: Fragebogen, Fragen, Antworten, Anmeldung, Quiz und Meinungsbild gehören dem Ersteller der Fragen und haben kein bindendes Ergebnis (fs-forms). Ein Beschluss dagegen hat einen eigenen Lebenslauf: Vorschlag in Fassungen, Verfahren, Wahlvolk, Stimmen und Einwände, Ergebnis, Zuständige, Fristen, Überprüfungsdatum, Weitergabe, Speicherdauer. Das Ergebnis bleibt, auch wenn die Stimmen gelöscht sind.
- Einen Standard für „Entscheidung mit Verfahren, Einwänden, Ergebnis, Weitergabe“ gibt es nicht; innen entsteht ein eigenes typisiertes Modell (Begriffe nach Popolo: Motion, VoteEvent, Count, Vote), an den Grenzen gelten AS2 `Question`, JSON, CSV, ICS (Plan §3).
- Die Terminfindung ist eine Entscheidung „wann“.

**Entscheidung**
1. **`fs-decisions` ist ein Programm** (Name nach Regel 1 der Einzahl/Mehrzahl-Regel: viele gleichartige Dinge, Mehrzahl, klein) für Beschlüsse und Abstimmungen: Verfahren Konsens, Mehrheit, Konsent, Rangwahl und Einzelentscheidung (weitere Verfahren siehe Plan §5.3), Einwände, Ergebnis, Weitergabe (Nachricht, Mail, Aufgabe, Termin über Workflows), Überprüfungsdatum, gestufte Speicherdauer (alles → nur Ergebnis → nichts). Auch allein nutzbar (Entscheidungs-Tagebuch).
2. **Terminfindung ist eine Facette von fs-decisions** (Filter: Entscheidungen, deren Optionen Zeitfenster sind). Der Gesamtablauf (Kalender, Gäste, Zustellung, Aufgabe) bleibt eine **Suite**; Arbeitsname **`fs-scheduling`** (nicht gesetzt). Die Eingabefelder der Terminfrage kommen EINGEBETTET aus fs-forms (nicht neu in fs-decisions gebaut); fs-decisions besitzt Verfahren, Stimmen, Einwände, Ergebnis, Weitergabe.
3. **„Abstimmung“ als Facette von fs-forms entfällt.** fs-forms behält Fragebogen, Anmeldung, Quiz und das **Meinungsbild**. Weitere Facetten von fs-decisions: Vereinsbeschluss, Konsent-Runde, Wahl, Einzelentscheidung mit Begründung.
4. **Die Aufnahme-Abstimmung im Türsteher bleibt bei fs-admission** (Daten beim Ziel-Programm). Sie zählt mit derselben Bibliothek `fs-tally`; es gibt keine dritte Zählung.
5. **Zwei eigenständige Bibliotheken** (Einzahl, klein, auch für andere nutzbar): **`fs-tally`** (reine Zählverfahren, aus `fs-forms-methods` herausgelöst) und **`fs-ballot`** (Urne ohne Protokoll, Tokens, anonyme Stimmzettel).
6. **Nicht zu kopieren:** Loomio, Decidim, CONSUL, LiquidFeedback und andere sind ganze Dienste mit eigener Datenbank; sie sind nur Ablauf-Vorbilder im Dossier, nie Code. Nur die Krypto für anonyme Stimmen kommt später als gepinnte Bibliothek mit Adapter (Plan §2).
7. **KI-Grenze** (nach ADR 0054 mit Nachträgen 1 und 2 sowie ADR 0091): Eine KI ist nie im Wahlvolk und hat nie Stimme, Token oder Einwand; sie bekommt nie `decide`, auch nicht als MCP-Werkzeug. Ein KI-Helfer kommt nur per Einladung oder über seinen Bot-Platz (siehe `pilot-decisions/PLAN.md` §5.7).

**Folgen**
- **Migration:** `fs-forms-methods` → `fs-tally`; der Urnen-Speicher aus fs-forms → `fs-ballot`; der Speichertyp `Decision` samt Verweisen auf Aufgaben zieht von fs-forms nach fs-decisions. fs-forms nutzt `fs-tally` und `fs-ballot` weiter (Tests bleiben grün). Der Ablauf läuft über Workflows (Plan §7, Schritte D0 bis D2).
- **Katalog:** Eintrag `fs-decisions` im Daten-Repo `Catalog` (derzeit noch `fs-catalog`; dort steht heute kein Eintrag mit diesem Namen); fs-forms erhält die Beschreibung ohne „Abstimmung“.
- **Namensprüfung (D0, 2026-11-16):** `fs-decisions`, `fs-tally`, `fs-ballot`, `fs-delegate` sind auf GitHub (Organisation FreeSynergy, `git ls-remote`) und `fs-decisions`, `fs-tally`, `fs-ballot`, `fs-delegate`, `fs-workflows`, `fs-workflow` auf crates.io (API) frei. Kein Kollisionsfund im Katalog. Einzelheiten und Belege: Arbeitsstand `pilot-decisions/namenspruefung-d0.md`. `git ls-remote` sieht nur öffentliche Repos; ein privates Repo gleichen Namens bliebe unsichtbar: keine Reservierung, vor dem Veröffentlichen erneut prüfen.
- **Dokumentation:** Programmseite fs-decisions, Anpassung der Seiten zu fs-forms und der Programmübersicht im Lauf des Workflows `doku-mitziehen`; die Zuordnung „Abstimmung → fs-surveys“ in ADR 0076 bleibt als Entscheidungsstand der damaligen Zeit stehen (ADR 0087 gilt vor ihm). Die Zeile „Wie entscheiden wir?“ in ADR 0076 (Zeilen 26/65: Abstimmung → fs-surveys/fs-forms) gilt jetzt für fs-decisions.

**Offen**
- Name der Suite `fs-scheduling` (Terminfindung als Gesamtablauf).
- Die Schnittstelle von `fs-tally` und `fs-ballot` (auch für fs-admission) wird im Vertrag `decisions_v1` festgelegt.
- Anonyme Stimmen: Stufe A1 (Betreiber sieht kurz das Token) gegen Stufe A2 (blinde Signatur) steht im Plan; die Bauform ist eigener ADR-Gegenstand und nicht Teil dieses Nachtrags.
- Name der Suite: Arbeitsname `fs-scheduling` (nicht gesetzt; siehe `pilot-terminfindung/PLAN.md` Z. 63).

## Nachtrag 2026-11-16: Abgrenzung der Fähigkeiten fs-forms / fs-decisions

Dieser Nachtrag ersetzt keine Regel und ändert den Status nicht; er hält die Abgrenzung der beiden Fähigkeiten fest, die der vorige Nachtrag (fs-decisions) eingeführt hat.

- **fs-forms** sammelt Daten mit Formularen und Umfragen (Fragebögen, Anmeldungen, Quiz, Meinungsbild) und wertet sie aus. Seine Capability ist `surveys` (Anzeigename „Forms“); der Schlüssel bleibt, denn nach ADR 0068 ist der Fähigkeiten-Name der Name der Themen-Schnittstelle (`surveys.capnp`) und „Namen werden nie umbenannt oder entfernt“ (Nachtrag „Status `planned`“).
- **fs-decisions** entscheidet in der Gruppe: Abstimmungen, Beschlüsse, Terminfindung als Facette. Es bekommt eine eigene Capability `decisions`, sobald sein Trait `decisions_v1` steht; bis dahin liegt das Interface `Decisions` im Schema `surveys.capnp` und wandert mit dem Trait.
- Die Eingabefelder (etwa der Terminfrage) kommen EINGEBETTET aus fs-forms (Nachtrag „fs-decisions“, Punkt 2, Zeile 97); „Abstimmung“ als Facette von fs-forms entfällt (Punkt 3, Zeile 98).

## Nachtrag 2026-11-17: forms = Frontend-Baukasten, decisions = alle Fragen, Datenmodell-Baukasten, Veranstaltungen

Status: Entwurf (Nutzervorgabe über b7, Antwort 115 vom 2026-11-17; Ausgestaltung Opus; Namen `fs-scaffold` und `fs-checkin` vom Nutzer entschieden, Fragen 116/117) · **ändert** den Nachtrag „fs-decisions“: Punkt 2 (Eingabefelder der Terminfrage „EINGEBETTET aus fs-forms“), Punkt 3 („fs-forms behält Fragebogen, Anmeldung, Quiz und das Meinungsbild“) und die Folge „Migration“ („fs-forms nutzt fs-tally und fs-ballot weiter“); den Nachtrag „Abgrenzung der Fähigkeiten“ (fs-forms sammelt Daten mit Formularen; eigene Capability `decisions`, siehe Punkt 1); die Tabelle in „Entscheidung“ Punkt 2 (Zeile fs-surveys → fs-forms, „Umfrage, Abstimmung, Anmeldung sind Facetten“) gilt als geändert und bleibt nur als Stand der Zeit stehen · **erweitert** ADR 0074 §1 (Paketart der Anordnung) und ADR 0077 §1 (`kind`-Liste) um `layout` · **beantwortet** ADR 0074 „Offen“ (Editor für Anordnungsdateien: eigenes Programm, keine Facette des Zeichenprogramms) · **legt die Richtung fest** für ADR 0094 O5 (Host = `fs-forms-run`); Format und Host-Vertrag kommen in einen eigenen ADR (Etappe E4) · baut auf ADR 0013, 0014, 0021, 0024, 0045, 0057, 0061, 0065, 0066, 0068, 0069, 0074, 0076, 0077, 0085, 0086, 0091, 0092, 0093, 0094

**Kontext**
- **fs-forms heute** (Repo fs-forms, früher fs-surveys; `main` f6309e5, Zweig `unreviewed/forms-d1-tally-ballot` a16172e): nur Kern `fs-forms-core` (Umfragen, Fragen, Bedingungen, namentliche und anonyme Antworten, Einmal-Tokens, Mindestgruppe, CSV) und `fs-forms-methods` (10 Zählverfahren). Kein Fenster, kein Server, Vertrag `surveys.capnp` vorläufig. Capability `surveys` (fs-interfaces `main` 1280a1b, `schema/capabilities.txt` Z. 25: `surveys | Forms | stable | Asking and deciding together`; ADR 0068: Schlüssel werden nie umbenannt oder entfernt). Das Repo `FreeSynergy/fs-decisions` existiert (HEAD 5cd8806).
- **Nutzervorgabe (über b7, Antwort 115):** fs-forms wird der **Frontend-Baukasten**: Oberflächen aus unseren Komponenten zusammenklicken; jede Komponente bekommt eine **vorhandene** Datenquelle (Felder der Programme über deren Verträge, mit den Rechten der Person); Knöpfe/Texte ohne Daten → Workflows oder nichts; **kein freier Code**. Gespeichert wird ein eigenes kleines Programm (Aussehen + Verknüpfungen); die Daten bleiben bei den Besitzern. Umfragen, Fragebögen, Meinungsbild, Quiz ziehen zu fs-decisions („ob eine Frage oder 30, kein Unterschied“). Dazu ein Datenmodell-Baukasten (nur mit Standard-Beschreibung) und ein Veranstaltungsprogramm mit Standard-Formularen.
- **Bestand, an den das passt:** ADR 0074 §6 will Frontends als **Anordnungsdatei** („Menschen bearbeiten die Datei über einen Editor“; Format als Standard-Vorschlag) und lässt offen, wer der Editor ist. ADR 0094 (Entwurf) O5 schlägt vor: „ein gemeinsamer Frontend-Prozess (`fs:exec` = Host) liest die Anordnungsdatei“, mit eigenem ADR. ADR 0066 liefert die **Typbeschreibung** je Datentyp (Felder, Grundtyp, Pflicht/mehrfach, Befehle) und die vier Components je Grundtyp (Eingabe, Anzeige, kompakt, Zelle). Der Block-Vertrag von fs-components (`contract/blocks/*.toml`, Vertragsversion 0.2, Entwurf) nennt je Baustein Name, Teile, Zustände, Varianten, Kurzbeschreibung, aber **nicht**, welchen Grundtyp ein Baustein anzeigen oder eingeben kann.

**Entscheidung**
1. **fs-forms ist der Frontend-Baukasten** (Editor, keine Facette). Der Name bleibt: Seine Daten sind die Oberflächen-Beschreibungen („forms“ = Gestalt), es besitzt keine Fachdaten. Neue Capability **`forms`** (`planned`). **Capabilities von fs-decisions (löst den Widerspruch zum Nachtrag „Abgrenzung“):** fs-decisions bietet **beide** an: `surveys` (Fragen und Antworten; der Schlüssel bleibt nach ADR 0068, nur der Anbieter wechselt, Anzeigename „Forms“ → „Decisions“) und, wie im Nachtrag „Abgrenzung“ beschlossen, `decisions` (Beschlüsse), sobald `decisions_v1` steht.
2. **Alle Fragen gehören zu fs-decisions:** Umfrage, Fragebogen, Meinungsbild, Quiz, Abstimmung, Terminfrage. Fragetypen, Antworten, Anonymität, Tokens, Mindestgruppe, Auswertung und CSV ziehen mit dem Code aus `fs-forms-core` um (Plan D0 bis D2 mit `fs-tally`/`fs-ballot`). Danach nutzt nicht mehr fs-forms, sondern fs-decisions `fs-tally` und `fs-ballot`. Die Eingabefelder der Terminfrage kommen aus **fs-components** (Grundtyp-Components nach ADR 0066), nicht aus fs-forms. Eine Datenmigration ist nicht nötig, weil fs-forms nie ein Fenster oder einen Server hatte [Annahme: keine Installation mit Antworten; vor dem Umzug prüfen]. Aus `features/forms.md` gehen Nr. 1–38 und 44–59 an decisions und Nr. 39–43 an das Veranstaltungsprogramm.
3. **Komponentenkatalog = Block-Vertrag von fs-components.** Jeder Baustein bekommt im Vertrag (Vertragsversion 0.3, geprüft in `contract/check`) zusätzlich **`accepts`**: welche Grundtypen er in welcher Rolle bindet (`input`, `display`, `compact`, `cell`; ADR 0066 §4), dazu `list` für Bausteine, die eine Menge zeigen (`grid`, Liste, Brett). Rahmen ohne Daten (`section`, `sidebar`, `card`) haben `accepts = []`. Der Baukasten bietet nur, was im Vertrag steht; neue Bausteine entstehen in fs-components, nie im Baukasten.
4. **Datenquellen = Typbeschreibungen der installierten Programme.** Jedes Programm bietet neben jeder Capability eine **eigene Schnittstelle `TypeCatalog`** an (wie `Control`, common.capnp Z. 38), umgesetzt mit dem vorhandenen `TypeCatalog`/`CatalogServer` aus fs-rpc (ADR 0093 §2.1). Es ist keine Methode in den Fachschnittstellen, denn nach ADR 0045 bietet jeder Anbieter alle Methoden seiner Schnittstelle an. Eine Verknüpfung ist typisiert: `(capability, Vertragsversion, Datentyp, Feldpfad, Rolle)`. Sie ist nur gültig, wenn der Grundtyp des Feldes in `accepts` des Bausteins steht. Sonst lehnt die Prüfung ab und das Feld wird mit Grund gesperrt gezeigt (ADR 0066; Nutzerregel „fehlende Datenquelle melden, nie still ausgegraut“). Schreiben geht nur über die **Befehle** der Typbeschreibung (ADR 0066 §3), nie an der Engine vorbei.
5. **Knöpfe und Texte ohne Daten:** Ein Knopf ruft genau eins auf: einen Befehl eines Programms (ADR 0066 §3) oder einen Workflow aus fs-workflows (Verweis auf Id + Version, Serverless Workflow 1.0 nach ADR 0076), oder er entfällt. **Ein Workflow hinter einem Knopf läuft im Namen der Person** (ihr Socket bzw. ihr Token), nie mit einem Dienstkonto von fs-workflows. Ein späterer oder zeitgesteuerter Lauf braucht eine eigene Zustimmung der Person. Freie Texte sind übersetzbare Texte (MF2, ADR 0057). **Kein freier Code:** keine Formeln, keine Ausdrücke, kein JavaScript, keine Abfragesprache in der Beschreibung. Logik ist ein Workflow. Erweiterungen kommen später nur als **signierte, abgeschottete Plugins** (eigener Prozess nach ADR 0045/0094, später WASM; eigener ADR).
6. **Das kleine Programm ist eine Beschreibung, kein Code:** Anordnung (Bausteine, Seiten, Navigation, Menüs nach ADR 0065/0074 §6) + Verknüpfungen + Stilwahl (ADR 0074 §1). Format **TOML mit festen Typen** (`deny_unknown_fields`, `schema`-Version, geschlossene Enums, wie `session.toml` in ADR 0069), ohne personenbezogene Daten. **Dasselbe Format trägt zwei Fälle:**
   - (i) die Anordnungsdatei **eines** Programms nach ADR 0074 §6 (`kind` frontend, `extends` = Programm, `fs:exec` = `fs-forms-run`, mit Menüs, Werkzeugleisten, Tastenkürzeln);
   - (ii) das kleine Programm **über mehrere** Programme (neue Paketart **`layout`**: AppStream `addon`, `extends` = fs-forms, `fs:requires` = alle benutzten Capabilities mit Mindestversion). Für beide gilt: eigene Version (= Tag), signiert, Installation und Update über fs-packages. Das Format wird als Standard-Vorschlag veröffentlicht (ADR 0074 §6, ADR 0014 Punkt 3).
7. **Laufzeit: ein Host `fs-forms-run`** (Richtung für ADR 0094 O5; ein Frontend-Prozess, kein Server). Er liest die Beschreibung und prüft beim Start jede Verknüpfung gegen `SupportReport` und `TypeCatalog` der Programme (Handshake ADR 0094 §4). Er zeichnet mit fs-components und spricht nur über die Client-Verträge (ADR 0092: hängt an Clients und fs-components, nie an `-core`/`-server`). Passt ein Vertrag nicht: sichtbare Meldung, die betroffenen Teile sind gesperrt mit Grund, nie still. Live-Änderungen kommen über den Feed des jeweiligen Programms (fs-rpc). Format und Host-Vertrag legt ein eigener ADR in E4 fest.
8. **Rechte: nie mehr als die Person.** Der Host verbindet sich als die Person (lokal: Socket in ihrem `$XDG_RUNTIME_DIR`; entfernt: OAuth-Token der Person, ADR 0024). Die Beschreibung enthält nie Zugangsdaten und nie ein Dienstkonto. Wer ein kleines Programm teilt, teilt nur die Beschreibung; jede Person sieht darin nur, was sie selbst darf. Risikomarken setzt die Engine (ADR 0021). Keine KI im Baukasten; KI nur über den Bot-Platz (ADR 0091).
   - **Installieren eines `layout`-Pakets** (wie ADR 0094 Punkt 5): Signatur und sha256 werden geprüft, `fs:requires` gegen die `provides` der installierten Programme. Die genutzten Capabilities werden **vorher angezeigt**.
   - Ungeprüfte Beschreibungen gibt es nur als „lokal, nicht geprüft“ (ADR 0094 §7).
9. **Datenschutz: keine Kopie.** Das kleine Programm hat keinen eigenen Datenspeicher; es zeigt und ändert Daten nur bei ihren Besitzern. Erlaubt ist nur der Arbeitsstand der Sitzung (ADR 0069, `session.toml`, Entwürfe im `DraftStore`). Braucht eine Oberfläche Felder, die kein Programm hat, entsteht ein neues Programm mit dem Datenmodell-Baukasten (Punkt 10), nie eine Ablage im Baukasten.
10. **Datenmodell-Baukasten `fs-scaffold`** (Name vom Nutzer entschieden, Frage 116; Tätigkeit = Verb nach der Namensregel) ist ein eigenes Programm. Nicht zu verwechseln mit dem Schritt `scaffold-ai` in fs-release (Workflow `grundfassung`, `call: scaffold-ai`), der das Gerüst eines Programms anlegt; fs-scaffold nutzt diesen Workflow nur (Ausgabe d). Er besitzt Datenmodell-Beschreibungen, also neue Datentypen samt Vertrag. Abgrenzung: fs-data (geplant, ADR 0087 Punkt 6) besitzt Tabellen mit ihren Inhalten; fs-scaffold besitzt keine Inhalte, nur Modelle, aus denen eigene Programme entstehen. Ein neues Feld braucht **Pflicht** eine Standard-Beschreibung:
    - entweder einen Verweis auf einen vorhandenen Standard: RFC (z. B. 8984, 9553), W3C (AS2), schema.org-Typ/-Eigenschaft, ISO; je Feld URI + Abschnitt;
    - oder eine eigene offene Spezifikation in `data/` von fs-documentation, die wir nach ADR 0014 Punkt 3 veröffentlichen. **Einreichen** (IETF-Draft oder W3C Community Group) ist ein Ziel, keine Pflicht.
    - **Prüfung:** Die Maschine prüft die Form (URI und Abschnitt bzw. Spezifikation vorhanden, Grundtyp passt). Den Inhalt prüft ein Admin der Instanz bei der Freigabe. Ohne Standardbeleg wird nicht gespeichert, ohne Freigabe nicht erzeugt.
    - Felder bestehen aus Grundtypen (ADR 0066 §1); Zeiten nach ADR 0085; AS2 ist die Hülle (ADR 0014).
    - **Ausgabe:**
      - (a) Cap'n-Proto-Vertrag: eigene 64-bit-Datei-ID; Felder nur anhängen mit steigender `@N`; nie Nummer, Typ oder Standardwert ändern.
      - (b) typisierte Tabellen nach ADR 0086 (Spalte je Feld, Untertabellen für Listen, kein JSON).
      - (c) Typbeschreibung (ADR 0066 §3).
      - (d) Programmgerüst über die Workflows `programm-neu` und `grundfassung` (Name nach Namensregel geprüft, eigenes SCIM/OAuth nach ADR 0024).
      - Die Oberfläche baut man danach mit fs-forms. Erzeugte Programme werden bei Vertragsänderungen über einen Workflow `schema-update` nachgezogen (nur anhängen).
11. **Veranstaltungsprogramm `fs-checkin`** (Name vom Nutzer entschieden, Frage 117; Tätigkeit = Verb nach der Namensregel) ist ein eigenes Programm. Es besitzt Anmeldungen, Kontingente, Sitzplätze, Tickets und Check-ins zu einem Termin. Der Termin selbst bleibt in fs-calendars (JSCalendar), der Ort in fs-maps, die Terminfindung in fs-decisions, Personen in fs-people (`PersonRef`, ADR 0085).
    - Standards: schema.org `EventReservation` (`reservationFor`, `underName`, `reservationStatus`, `reservedTicket` → `Ticket`/`ticketedSeat` → `Seat`) und `Event.maximumAttendeeCapacity`/`remainingAttendeeCapacity`; an der Grenze zu fs-calendars JSCalendar `participants` mit `participationStatus` (RFC 8984 §4.4.6); Aktivitäten AS2 `Invite`, `Accept`, `TentativeAccept`, `Reject`.
    - **Standard-Formulare** kommen als `layout`-Pakete mit dem Programm (gebaut mit fs-forms): ohne Sitzplatz (Kontingent, Warteliste), mit Sitzplatz (Plan, Kategorie je Angebot), Check-in (Liste/QR).
    - **Profil-Übergabe:** Die Person gibt Angaben beim Anmelden ausdrücklich frei (Einwilligung, Zeitpunkt festgehalten), am liebsten als Verweis statt Kopie, widerrufbar (Nutzerregel Selbstbestimmung über Daten). **OFFEN (Frage 118):** ob der Veranstalter Angaben zur Pflicht machen darf. Das berührt die Nutzerregel „über sich alles teilen dürfen, von anderen nie verlangen“.
    - **Verträge über das Konto:** Teilnahmebedingungen werden mit dem Baustein `license-dialog` gezeigt und je Konto mit Fassung und Zeitpunkt festgehalten.
    - **Bezahlte Tickets** erst mit fs-finance.
    - Vorbild pretix (AGPL v3 mit Zusatzbedingungen): nur Konzepte (Kontingente, Sitzkategorien, Check-in-Listen), nichts kopieren (ADR 0013).
12. **Bedingungen und Navigation ohne Code:** In v1 gibt es kein bedingtes Anzeigen. Später kommt eine **geschlossene Liste** fester Bedingungen (Muster Tally), nie Ausdrücke. Seitenwechsel und Auswahl (Liste → Detail) sind feste Navigations-Arten im Format (geschlossene Enum, festgelegt in E4).
13. **Teilen und Veröffentlichen:** Kleine Programme dürfen öffentlich in den Katalog, nur signiert. Im öffentlichen `Catalog` signiert die Aufnahme in den Katalog, wie bei jedem Paket. Geteilt in einer Gruppe oder unter Personen signiert der Schlüssel der Person; angezeigt wird, wer signiert hat. Jede Person sieht nur mit eigenen Rechten (Punkt 8).
14. **Web-Fassung des Hosts** (entfernt, im Browser) später über WASM (ADR 0094); bis dahin nur Desktop.
15. **Reihenfolge (Etappen):**
    - **E1** dieser Nachtrag (Namen 116/117 entschieden; Frage 118 offen);
    - **E2** Umzug der Fragen nach fs-decisions (D0–D2 mit fs-tally/fs-ballot);
    - **E3** Block-Vertrag 0.3 `accepts`; `TypeCatalog` neben jeder Capability: in common.capnp nur anhängen (DRAFT 0.2), neue fs-interfaces-Version, alle Anbieter ziehen nach (fs-tasks, fs-registry, fs-messages, fs-calendars …);
    - **E4** eigener ADR für Format und Host, `fs-forms-run` zunächst nur lesend;
    - **E5** Editor fs-forms (Einfach + Admin) mit Schreiben über Befehle und Knöpfen → Workflows, vorher Vorbild-Dossier;
    - **E6** Paketart `layout` in Catalog und fs-packages;
    - **E7** fs-scaffold Grundfassung;
    - **E8** Veranstaltungsprogramm Grundfassung + drei Standard-Formulare;
    - später Plugins (eigener ADR).

    Weitere forms-Arbeit erst nach Annahme dieses Nachtrags.

**Folgen**
- **Capabilities** (`fs-interfaces/schema/capabilities.txt`, Muster `key | display name | status | description`, nur anhängen):
  - `forms | Forms | planned | Building user interfaces from components, bound to the data of other programs`
  - `scaffold | Scaffold | planned | Data models with a standards reference, generating contract, typed storage and program skeleton`
  - `checkin | Check-in | planned | Registrations, quotas, seats, tickets and check-in for events`
  - `surveys`: nur der Anzeigename wechselt zu „Decisions“ (`surveys | Decisions | stable | …`, Status `stable` bleibt), Anbieter wird fs-decisions. `decisions` kommt mit `decisions_v1` (Nachtrag „Abgrenzung“). **common.capnp:** `TypeCatalog` als eigene Schnittstelle anhängen (E3).
- **Katalog:** Beschreibung von fs-forms neu („Oberflächen aus Bausteinen zusammenstellen“); Einträge für die zwei neuen Programme; `kind = layout` (ADR 0077 §1 und ADR 0074 §1 erweitern).
- **Doku:** `doku-mitziehen` für die Programmseiten forms/decisions, die Übersicht, ADR 0074 „Offen“ und ADR 0094 O5 (Verweis hierher). Feature-Listen: `forms.md` neu (Baukasten), `decisions.md` ergänzt.
- **Pflichttests** (je ohne Umsetzung rot):
  - Verknüpfung mit falschem Grundtyp → abgelehnt.
  - Feld ohne Leserecht → gesperrt mit Grund, kein Wert im Speicher oder Log.
  - Beschreibung mit unbekanntem Schlüssel → abgelehnt; Beschreibung mit Ausdruck/Code → abgelehnt.
  - Host hängt nicht an `-core`/`-server` (`cargo tree`).
  - Geteiltes Programm zeigt einer zweiten Person nur deren Daten.
  - Workflow-Knopf läuft mit der Identität der Person, nie mit Dienstkonto.
  - `layout` mit falscher Signatur oder unerfülltem `requires` → nicht installiert.
  - fs-scaffold speichert kein Feld ohne Standardbeleg.
  - Vertragsänderung, die eine `@N` ändert → abgelehnt.

**Offen**
Entschieden (Nutzer über b7): 116 → `fs-scaffold`, 117 → `fs-checkin` (Name vom Nutzer entschieden).

1. **(118) Pflichtangaben bei der Anmeldung:** Darf der Veranstalter Angaben verlangen, ohne die es keine Anmeldung gibt? Nutzerregel „über sich alles teilen dürfen, von anderen nie verlangen“. Keine Empfehlung; Entscheidung beim Nutzer.
