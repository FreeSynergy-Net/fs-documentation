# Gespräch 2026-11-18-tasks-ki-kennzeichen

- **Id:** `2026-11-18-tasks-ki-kennzeichen`
- **Datum:** 2026-11-18 (Entscheid)
- **Teilnehmer (Rollen):** Nutzer (Nutzerwort); Strategie (Entscheid, protokolliert)
- **Bezug:** Ausnahme `[[exception]]` in fs-tasks `scaffold.toml` (KI-Kennzeichen, C16; `crates/fs-tasks-core/src/model/actor.rs:14-25`, `:43-95`); ADR 0091 (Nachtrag „Folgen für die Traits (BotRef)“); ADR 0054; ADR 0103 Punkt 12 (Nummer 54)
- **Frage (Nummer 54):** Wie wird erkennbar, dass ein Akteur eine KI ist, ohne ein eigenes Kennzeichen je Aufgabe?

**Entscheid (Strategie, nach dem Nutzerwort 18.11.2026 „der Bot/Wrapper trägt die Kennzeichnung in sich“):**
- Das KI-Zeichen kommt aus dem **Akteurstyp**: ein Bot ist `BotRef` (fs-identity, ADR 0091). Der Akteurstyp selbst ist die Kennzeichnung.
- Die Anzeige leitet das Zeichen daraus ab. **Kein Feld je Aufgabe**, kein Vendor-Feld.
- Die frühere Form über JSContact `kind: application` in einer Personenkarte ist **zurückgenommen**. `kind: application` allein heißt nicht „KI“ (auch ein CI-Runner ist eine Anwendung).
- Läufe und Aufgaben verweisen auf den Akteur: Person (`PersonRef`) oder Bot (`BotRef`) gemäß ADR 0091.

**Folge:**
- Die Ausnahme 54 wird aus dem tasks-Bauplan genommen (Auftrag der Strategie vom 18.11.2026, 22:37 UTC; Umsetzung noch zu belegen).
- Der eigene `ActorType`-Enum in fs-tasks entfällt.

**Verweis:** ADR 0103 Punkt 12 (Nummer 54); ADR 0091 (BotRef).
