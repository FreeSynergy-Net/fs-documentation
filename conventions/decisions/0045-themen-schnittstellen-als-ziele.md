# 0045 – Jedes Thema eine Schnittstelle; Schnittstellen sind Ziele; Hot-Plugins

Status: akzeptiert (2026-11-06) · Form der Plugins: Vorschlag · ergänzt ADR 0014, 0021, 0043

## Entscheidung (Nutzer)
1. **Jedes Thema bekommt eine eigene Schnittstelle**, ab sofort und für alles, was schon gebaut ist: Mail-Client,
   Mail-Server, Matrix, Telegram (auch wenn nicht selbst gehostet), Datenbank, Nachrichten, Dateien, Personen,
   Gruppen … Die Schnittstellen müssen gleich sein, damit man austauschen oder hinzufügen kann. Deshalb sind
   Standards absolut notwendig.
2. **Eine Schnittstelle ist ein Ziel und wächst nicht.** Wachsen hat keinen Endpunkt, ein Ziel schon. Muss sie sich
   ändern, ist das ein **Sprung**, kein Wachsen. Lose zusammenarbeitende Projekte wissen sonst nicht, wann sich was ändert.
3. **Plugins sind immer Hot-Plugins.**
4. Das Backend darf mehr können, als ein Frontend nutzt. Frontends mit eingebauten Filtern sind Mini-Server oder
   Engines (ADR 0021 weitergedacht).

## Vorschlag zur Umsetzung
- Katalog: `docs/en/interfaces/index.md`. Zwei Ebenen: Thema (Nachrichten) und Anbieter (Mail, Matrix, Telegram).
- **Korrektur des Nutzers (2026-11-06), ersetzt „Kern plus optionale Fähigkeiten“:** Wie eine Elternklasse: Jeder Anbieter bietet **alle** Methoden und Attribute. Fehlt einem Anbieter etwas, suchen wir einen Weg, es trotzdem umzusetzen. Geht das wirklich nicht, antwortet er ausdrücklich „nicht möglich“. Erst nachdenken, wie es geht, statt zu sagen, dass es nicht geht. Rust: Trait mit Standardmethode, die `Unsupported` liefert.
- Ablauf: Entwurf → mindestens zwei unabhängige Nutzer der Schnittstelle (bei Anbieter-Schnittstellen: zwei Anbieter) → 1.0 fest → danach nur Sprünge. Korrigiert 2026-11-06: Ein Thema hat nach ADR 0050 nur einen Besitzer, also kann nicht „zwei Umsetzungen“ die Bedingung sein.
- **Hot-Plugins nach dem Vorbild Zentinel** (Hinweis des Nutzers): Viele Schnittstellen sind nur Konfiguration, die geprüft und atomar getauscht wird. Größere sind Agenten: eigene, absturzsichere Prozesse über eine lokale Verbindung, die ihre Fähigkeiten melden. Bei uns mit Cap'n Proto. Zeichnet ein Agent, liefert er eine Szenenbeschreibung. Nicht gemessen, Textmessung ungelöst.
- **Öffentliches Repo `fs-interfaces`: vom Nutzer bestätigt.**
- Das Ziel darf schrittweise genauer werden, solange wir es nicht ganz kennen (Nutzer): erst Ziel festlegen, dann weitersehen.
- **Der Umbau gilt für alles, auch für Fertiges (Nutzer).**

## Folgen
- **ADR 0021** erlaubt Erweiterung ohne Bruch. Das bleibt technisch möglich, aber nach 1.0 ist es nicht mehr der Weg:
  Änderungen kommen als neue Version, mit Übergang, in dem beide angeboten werden.
- Die bestehenden Kerne werden gegen den Katalog geprüft und umgebaut.

## Nachtrag 2026-11-17 (Baukasten, Gespräch 2): Form der Plugins entschieden

Status: **akzeptiert** (Nutzer, Gespräch 1 und 2 vom 2026-11-17; Strategie) · **ändert** den Status „Form der Plugins: Vorschlag“ (Z. 3, Abschnitt „Vorschlag zur Umsetzung“ Z. 20) zu **entschieden** · baut auf ADR 0097

**Entscheidung**
1. **Zwei Stufen:** Konfigurations-Modul (Beschreibung, geprüft und atomar getauscht; Vorbild Zentinel, Z. 20) und Agenten-Modul (Code).
2. **Kommunikation nach Nähe** (Vorschlag des Nutzers mit Rückfrage, von der Strategie bestätigt): „die Sachen, die "Nah" an dem Modul sind, sind alle WebAssably, die, die ohne das Programm auskommen, sind capnproto - die, die ganz weit weg sind, sind capnproto, json, grpc - das klingt doch nach einem Plan, oder?“ Also: nah = **WebAssembly** (Host und Plugin-ABI nach Messung); ohne Programm lauffähig = eigener Prozess über **Cap'n Proto**; ganz weit weg = **Cap'n Proto, JSON, gRPC**.
3. **Prozess-Modell** (Entscheidung der Strategie, Gegenwort des Nutzers steht aus): einmal je Person und Vertragsversion, Start bei Bedarf, Ende nach Frist, eigene Rechte je Aufrufer (ADR 0097).
4. „Plugins sind immer Hot-Plugins“ (Z. 12) bleibt.

## Nachtrag 23.11.2026 (Entwurf): bis zu echten Nutzern kein `_vN` nebeneinander

Status: **Entwurf** (Nutzerentscheid 23.11.2026: keine Versionen nebeneinander; Geltungsbereich „alle Namen“: Strategie-Entscheid 23.11.2026) · **setzt** den Satz des Haupttextes „Änderungen kommen als neue Version, mit Übergang, in dem beide angeboten werden“ **bis zu echten Nutzern aus; der Übergangssatz (beide Versionen angeboten) ist für diese Zeit aufgehoben**

- **Regel (Strategie-Entscheid 23.11.2026, ADR 0045 ist der richtige Ort):** Bis es echte Nutzer gibt, gilt für **alle Namen** (Verträge, Crates, Repos, Tabellen, Bauplan- und DB-Schemata, Befehle): **kein `_vN` im Namen und keine Fassungen nebeneinander** (nicht `_v1` und `_v2`). Eine **Version ist immer ein Datenfeld oder Attribut** (z. B. Form `tree@1.0`, Schema-Version als Spalte), nie Teil des Namens. Eine Änderung ersetzt, statt einen zweiten Namen daneben zu legen; Sperren wie die Hash-Sperre von `groups_v1` gelten dafür nicht und sind durch Nutzerwort aufgehoben. Erst mit echten Nutzern wird neu entschieden, wie Versionen koexistieren. Andere ADRs verweisen auf diese Regel, statt sie zu wiederholen.
- **Begründung des Ortes:** ADR 0045 legt fest, dass jedes Thema eine Schnittstelle ist und die Verträge in `fs-interfaces` liegen; die Regel gilt für alle Namen, am deutlichsten für diese Verträge. Sie entspricht ADR 0064 (frühe Phase: Versionen springen); Paketversionen (Tags) bleiben Versionen, sie stehen nie im Namen.
- **Folgen:** `groups` wird ein Vertrag (ADR 0095, Nachtrag), `events` entsteht ohne `_v1` (ADR 0050, Nachtrag). `person_directory_v1` wird **jetzt nicht** angefasst; eine Angleichung der Namen in einer Welle steht als Checklistenzeile für später.

## Nachtrag 2026-11-23: eine Versionsregel (SemVer, `name@…`, Paketversionen nach RPM-EVR)

Status: **entschieden** (Entscheid Strategie 23.11.2026, Technik; Schnitt „VERSION-EINE-QUELLE“ mit den Antworten 9f zu den Fragen 1–3; Nutzer informiert) · **ändert** im Nachtrag 2026-11-23 oben nur das Beispiel: aus Form `tree@1.0` wird `tree@1.0.0` (die Regel „Version ist ein Datenfeld“ bleibt) · **gilt für** ADR 0068, 0077, 0086, 0094, 0096, 0099, 0104; diese verweisen hierher, statt die Regel zu wiederholen · stützt sich auf ADR 0051 (SemVer für Releases) und ADR 0064 (0.0.N, keine Vorabversionen)

**Regel (ein Ort, gilt für alle Repos)**
1. **Eine Version ist immer dreiteilig `x.y.z` nach [SemVer 2.0.0](https://semver.org/spec/v2.0.0.html).** Version heißt: was etwas **ist**, also Vertrag, Form, Befehlssatz, Modul, Gerüst, Tag. `0.1` ist keine Version. Ein Leser lehnt sie mit Meldung ab und ergänzt nie still eine `.0`.
2. **Ein Bedarf ist ein Versionsbereich in Cargo-Schreibweise** (`semver::VersionReq`, Vergleiche durch Komma getrennt). Bedarf heißt: was etwas **braucht**, also Range in Beschreibungen, `fs:requires`/`fs:needs`, die Formen einer Component, `skeleton`, der Vertragseintrag im Bauplan. Der Erzeuger schreibt außerhalb von Listen immer die volle Form `>=a.b.c, <d.e.f` (in Listen siehe Nr. 5).
3. **Verträglich heißt Cargo-Caret (`^`).** Ab Hauptversion 1 ist das genau die bisherige Regel „Haupt gleich, Neben ≥“. Für `0.y.z` ist es strenger: 0.2 → 0.3 ist ein Bruch ([SemVer §4](https://semver.org/spec/v2.0.0.html#spec-item-4), ADR 0064). Wo ältere ADRs für 0.x „Haupt gleich, Neben ≥“ schreiben, gilt diese Regel.
4. **Voreinstellung des Erzeugers für `0.0.x`-Verträge (Entscheid 9f, 23.11.2026):** `>=0.0.N, <0.1.0`, nicht das Caret `<0.0.(N+1)`.
   - Das ist eine bewusste Voreinstellung der Anfangsphase: Sonst würde jeder Schritt jedes Programm aussperren.
   - Ehrlich gesagt: **`0.0.x` darf brechen** (ADR 0064). Der weite Bereich verspricht keine Verträglichkeit.
   - Bricht etwas, muss das als **sichtbare Meldung im Fenster** ankommen (ADR 0065 Pflichtteil Nr. 5, ADR 0104 E3 „bitte aktualisieren“), nie als stiller Fehler.
   - Mit dem ersten `0.1.0` eines Vertrags gilt für diesen Vertrag das normale Caret. Dann wird die Voreinstellung umgestellt.
   - Die Voreinstellung ist **im Erzeuger einstellbar** (fs-blueprint), nicht fest im Code.
5. **Eine Schreibweise für Name und Version: `name@…`.** Beispiele: Version `tree@1.0.0`, Bedarf `tasks@>=0.2.0, <0.3.0` oder `tree@^1.0.0`.
   - So machen es Cargo (`cargo add serde@>=1.0, <2`, `cargo install x@1.2.3`), fs-release (`name@x.y.z`) und ADR 0077 §3.
   - Die Leerzeichen-Form (`tasks >=0.2 <0.3`, `texts 1.0`) entfällt. Ein Leser meldet sie als unlesbar.
   - **Listen** (`fs:provides`, `fs:requires`, `fs:needs`) bleiben kommagetrennt. Damit das Komma eindeutig bleibt, steht in einer Liste je Eintrag nur **ein** Vergleich: `name@^x.y.z`, für Verträge der Voreinstellung `0.0.x` aber `name@~0.0.N` (Cargo-Tilde, gleich `>=0.0.N, <0.1.0`; `^0.0.N` hieße `<0.0.(N+1)` und wäre falsch). Die volle Form mit zwei Vergleichen steht nur außerhalb von Listen. Ein Bruchstück ohne `@` ist unlesbar und wird gemeldet, nie still übergangen.
6. **Gelesen wird nur mit dem Crate [`semver`](https://crates.io/crates/semver)** (1.0.x). Was `semver` nicht kennt, ist nur „Name + Version“ und „Name + Bedarf“.
   - Dafür gibt es genau einen gemeinsamen Typ: `fs_types::interface::{InterfaceVersion, InterfaceReq}` (Pattern: Value Object). Der Name folgt der Schlüsselregel von `capabilities.txt` (`[a-z][a-z0-9.-]*`).
   - Wo Name und Version schon getrennte Felder sind, wird `semver::Version` direkt genutzt, ohne Adapter.
   - Kein Repo schreibt einen eigenen Versionsleser. Ein Gate in fs-release prüft das (Schritt V-9, noch nicht gebaut).
7. **Paketversionen sind ein anderer Standard: RPM-EVR.** Paketversionen sind installierte Pakete und Katalog-Stände, auch gespiegelte fremde Pakete (ADR 0068) wie `26.11_2` oder `1.0~rc1`.
   - Verglichen wird über das Crate [`rpm-version`](https://crates.io/crates/rpm-version) (gepinnt). Es sortiert wie RPM und kennt `~` und `^`.
   - Unsere eigenen Tags sind SemVer ohne Vorabversion (ADR 0064 Nr. 4). rpmvercmp ordnet sie gleich, also gibt es einen Vergleicher für alle Paketversionen.
8. **Fremde Standards behalten ihre Nummer**, z. B. iCalendar `VERSION:2.0`, JSContact `1.0`, JSCalendar, DTCG, AppStream, Zentinel `schema-version "1.0"` (Fremdgebiet).
9. **Patch bei Schnittstellen** heißt „keine Änderung an der Schnittstelle“ (Text, Doku, Anzeigename). Neben = angehängt, Haupt = Bruch (bei 0.x: Neben = Bruch). Drei Teile sind eine Obermenge von zwei. Wo es keinen Patch gibt, bleibt er `0`.

**Begründung**
- Kein ADR begründet zweiteilige Versionen. `major.minor` steht in ADR 0077, 0094, 0099 und 0104 nur als Format, ohne Grund (Prüfung im Schnitt).
- Zwei Teile haben zu vielen eigenen Lesern geführt. Der Suchbericht zählt über 20 eigene Versions- und Range-Leser. Zwei davon (fs-forms-client, fs-packages-core) lassen für einen Bedarf 0.2 fälschlich 0.3 durch.
- Ein fertiges Crate und eine Schreibweise ersetzen das (Grundsatz „nicht neu erfinden“).

**Folgen**
- Die Umstellung läuft als eine Welle mit der ohnehin fälligen Pin-Welle (Schritte V-1 bis V-9). **Bis dahin stehen in Code und Daten noch zweiteilige Versionen und die Leerzeichen-Form.** Diese Regel beschreibt das Ziel; sie ist noch nicht umgesetzt.
- Verweise auf diesen Nachtrag stehen in ADR 0068, 0077, 0086, 0094, 0096, 0099 und 0104 sowie in `conventions/coding.md` §4.

**English summary.** One version rule for all repos (strategy decision of 2026-11-23, user informed). A version (what something *is*: contract, form, command set, module, skeleton, tag) is always three-part SemVer `x.y.z`. `0.1` is rejected, never silently completed. A requirement (what something *needs*) is a Cargo-style `semver::VersionReq` with comma-separated comparators, and compatibility is Cargo caret. For major ≥ 1 that equals the old “same major, minor ≥” rule; for 0.x it is stricter. For `0.0.x` contracts the generator's default is `>=0.0.N, <0.1.0`. This is a deliberate early-phase default: `0.0.x` may break, and a break must reach the window as a visible message, never as a silent error. From a contract's first `0.1.0` on, normal caret applies to it, and the default is configurable in the generator. Name and version are written one way only: `name@<version>` or `name@<req>`. In comma lists each entry holds a single comparator. Versions are read only with the `semver` crate. Name plus version/requirement uses the shared value objects `fs_types::interface::{InterfaceVersion, InterfaceReq}`, and no repo writes its own version reader. Package versions are a different standard: RPM EVR, compared with the `rpm-version` crate. Foreign standards keep their own numbers. The code still uses two-part versions until the migration wave (V-1 to V-9) has landed.
