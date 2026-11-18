# Gespräch 2026-11-18-tasks-ki-kennzeichen

- **Id:** `2026-11-18-tasks-ki-kennzeichen`
- **Datum:** 2026-11-18 (Entscheid des Nutzers)
- **Teilnehmer (Rollen):** Nutzer (entscheidet); Strategie (protokolliert)
- **Bezug:** Ausnahme `[[exception]]` in fs-tasks `scaffold.toml` (KI-Kennzeichen, C16; `crates/fs-tasks-core/src/model/actor.rs:14-25`, `:43-95`); ADR 0091 E1 (KI als Karte in fs-people); ADR 0054; ADR 0103 Punkt 12 (Nummer 54)
- **Frage (Nummer 54):** Wie wird erkennbar, dass ein Akteur eine KI ist, ohne ein eigenes Kennzeichen je Aufgabe?

**Entscheid des Nutzers (Nutzerwort 18.11.2026): Das KI-Kennzeichen entfällt.**
- Ein Bot oder eine KI ist eine **Bot-Person mit Karte** in fs-people: JSContact `kind: application` (RFC 9553 §2.1.4), dazu das **KI-Merkmal der Karte** nach ADR 0091 E1 (dort: „`kind: application`, `ai`, Verweis auf den Betreiber“).
- Die Anzeige leitet das Zeichen aus der Person ab.
- **Kein Vendor-Feld je Aufgabe.** Aufgaben und Läufe speichern nur `PersonRef`.
- Die Akteursarten von `claim` kommen aus der Person.

**Ehrlicher Hinweis:** `kind: application` allein heißt nicht „KI“, auch ein CI-Runner ist eine Anwendung. Das Zeichen muss aus dem KI-Merkmal der Karte kommen.

**Folge:**
- Die Ausnahme 54 wird aus dem tasks-Bauplan genommen (Entscheid 6e; Sonnet-Bauplan `bauplan-schema2-4`).
- Der eigene `ActorType`-Enum in fs-tasks entfällt.

**Verweis:** ADR 0103 Punkt 12 (Nummer 54); ADR 0091 E1 (Feldform „`ai`“ ist beim Bau gegen die Karte zu prüfen, siehe ADR 0103 Offen 2).
