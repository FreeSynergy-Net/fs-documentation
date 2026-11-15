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

3. **Ablauf** nur über den Workflow `umbenennen`. Er geht durch Repo, Crates `fs-<x>-*`, Pins in anderen Repos und Katalog (`replaces`). Die Doku zieht der Workflow `doku-mitziehen` im selben Lauf mit, sonst ist das Gate ROT. Ein alter Name wird nie wieder vergeben (ADR 0080).
4. **fs-store und fs-hub** bleiben vorerst. Das ist eine offene Nutzerfrage, denn `fs-packages` ist schon vergeben (ADR 0078).

## Folgen
- Neue Programme bekommen nur Namen nach Regel 1. Der Workflow `programm-neu` prüft das.
- Die Umbenennung auf GitHub gibt die Strategie je Programm nach dem Befehlsplan des Koordinators frei.
