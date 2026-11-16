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
| fs-store | fs-software (Store, Marktplatz, Server-Katalog sind Facetten) |
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
4. **Daten-Repos heißen in der Einzahl und groß geschrieben:** `Catalog` (bisher fs-catalog; kein Katalog ist ein Programm, siehe oben), `Repository` (das apt/dnf-Daten-Repo, bisher fs-packages nach ADR 0078). `Documentation` bleibt Daten-Repo; die Schreibweise ist offen (Folgepunkt, nicht entschieden). Reihenfolge: erst das Daten-Repo fs-packages → `Repository`, danach das Programm fs-store → fs-packages, weil der Name vorher belegt ist.
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
