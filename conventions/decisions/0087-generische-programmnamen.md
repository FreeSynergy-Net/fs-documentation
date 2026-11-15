# 0087 – Programmnamen sind generisch: Fähigkeit oder Daten, nicht Gattung

Status: akzeptiert (Nutzer, 2026-11-15) · erweitert ADR 0055 (sprechende Namen), 0080 (Umzug fs-wiki → fs-text) · Grundlage: Namensinventar der Strategie (Arbeitsstand, 2026-11-15)

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
| fs-resources | fs-inventory |
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
