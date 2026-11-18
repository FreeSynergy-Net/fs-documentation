# 0015 – Fremdprojekte, die wir nutzen und unterstützen; Crate-Regel

Status: akzeptiert (2026-11-05) · ergänzt 0009 (Blinc) und 0013 (nichts kopieren)

## Kontext
„Nichts kopieren“ (0013) heißt nicht „alles selbst bauen“. Fertige, offene Bausteine machen uns
schneller. Gleichzeitig soll der Stack klein bleiben und 100 % Rust sein.

## Entscheidung
1. **100 % Rust** ist das Ziel.
2. **Projekte, die wir bewusst nutzen und unterstützen** (Issues, Feature-Requests, ggf. Beiträge):

   | Projekt | Rolle | Umgang |
   |---------|-------|--------|
   | Blinc | GUI-Fundament (ADR 0009) | aktiv mitbauen: fehlende Components und Gesten (Finger, Maus, Stift) mit dem Autor abstimmen oder beitragen |
   | Turso / libSQL | Datenbank | nutzen, beobachten |
   | Web of Trust (`github.com/real-life-org/web-of-trust`) | Vertrauen/Identität zwischen Menschen | nutzen, Einordnung neben Kanidm offen |
   | Kanidm | Identität, Login | nutzen |
   | Zentinel (`github.com/zentinelproxy/zentinel`) | Reverse-Proxy auf Pingora, Apache-2.0; Sicherheitslogik in abgeschotteten Agenten, versteht MCP/A2A | nutzen |

3. **Andere Rust-Crates** dürfen genutzt werden, wenn sie **vollständig offen** sind (keine
   Paywall, kein Open-Core mit bezahltem Kern) und eine OSI-Lizenz haben, die zu ADR 0016 passt.
4. **Keine doppelten Crates für dieselbe Aufgabe.** Gibt es Blinc, kommt kein egui/iced dazu —
   fehlt etwas, wird es nachgebaut (auf Blinc) statt ein zweites Framework zu ziehen.
5. Wünsche an Fremdprojekte werden in `todo/upstream.md` gesammelt; der Nutzer schreibt die
   Issues.

## Folgen
- `programs/platform/crates/` dokumentiert jedes genutzte Projekt (Rolle, Lizenz, Version, Lücken).
- Gesten werden nach Eingabegerät erweitert: `interactions/gestures/` bekommt die Achse
  Finger / Maus / Stift.

## Nachtrag (Nutzer, 2026-11-18): Web of Trust (Zeile 17)
Die Zeile „Web of Trust (`real-life-org/web-of-trust`) … nutzen“ gilt **nicht für Vertrauen zwischen Menschen**: kein Web of Trust, keine Vertrauensstufen (Entscheid 46). Das Projekt wird dafür **nicht genutzt**; höchstens Teile davon für die **Schlüsselbestätigung** (a), falls sie dazu passen (offen, Einzelfall). **Gestrichen:** Stufen, Prozente und Zahlen über Menschen sowie Web of Trust. **Bleibt (technisch, keine Bewertung):** (a) Bestätigung, dass eine Identität bzw. ein Schlüssel wirklich zu der Person gehört (z. B. Schlüsselvergleich beim Treffen, `fs-messages` vouch/Autocrypt); (b) Paket-Signaturstufen in `fs-packages` (TrustLevel = Vertrauen in **Software**, nicht in Menschen); (c) sachliche Vorgangsdaten (z. B. „Lieferung abgeschlossen“) dürfen sichtbar sein, werden aber **nie zu einer Personen-Zahl verdichtet**. Verweis: ADR 0102 Entscheidung 4.1 und Entscheid 46 (Nutzer, 18.11.2026; Begründung: quantifiziertes Vertrauen nimmt die Möglichkeit, jemanden neu kennenzulernen, macht die Vergangenheit zur Zukunft und hilft Masken).
