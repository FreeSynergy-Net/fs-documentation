# 0100 – Einstellungen als eigene Schnittstelle: Vertrag `settings`, Bibliothek `fs-setting`, Programm `fs-settings`

Status: **Entwurf** (2026-11-17; Nutzer: Gespräch 4 vom 2026-11-17, Antworten 15 und 16; technische Ausgestaltung Strategie; Probe der Bibliothek mit Prüfung „JA“
am Kopf 222132fb, Auflagen N1–N9 vor dem Fixpunkt `setting_v1`) · **erweitert** ADR 0057 (Sprache), 0065 (Menü), 0074 (Darstellung), 0094 [Entw.] (Frontend-Wahl)
um eine gemeinsame Einstellungs-Schicht · baut auf ADR 0021, 0024, 0045, 0054, 0057, 0065, 0066, 0074, 0085, 0086, 0092, 0093, 0094 [Entw.], 0095, 0097, 0098

**Kontext**
- Nutzer (Wortlaut Gespräch 4, Z. 15): „Die Konfigurationen sollten eine eigene Schnittstelle haben, die man von außern ansteuern kann (wie das gemacht wird und ob es
  eine eigene ist oder ein teil von was anderem, ist Deine Entscheidung)“; Z. 16: „Theme, z.B. und Sprache, die wir bisher zwar geflegt haben, aber nicht wechseln
  konnten. Das muss weg, es muss jetzt schon austauschbar sein … und Settings sollte es überall geben“.
- Z. 18–19: „Es gibt allgemeine Configs, die, die zum Grundgerüst gehören, es gibt Modul Configs, Theme configs und App configs. … Dafür gibt es "Profile", die der
  Konfigurator macht, und da gibt es immer ein Allgemeines Profil und dann für jedes Programm kann, muss aber nicht, wenn es die configuration überschreiben möchte,
  überschreiben.“ Z. 21: „2 Buttons zum Speichern: für dieses Programm und im Allgemeinen. … aber, man kann von einem Programm nicht ins andere Programm gehen und das
  überschreiben.“ Z. 27–32 (Schloss): „bei jedem der Settings ein Schloss Symbol dran machen - das über die Rechte gesteuert wird“; „Wenn der Button gedrückt ist,
  darf dieser Wert nicht geändert werden. Auch ich nicht.“; „Wenn ich nicht die Rechte habe, etwas fest zu setzen, dann erscheint der Button erst gar nicht“.
- Antwort 15 (Z. 47): „noch besser die Idee.“ auf „Programm fs-settings statt fs-configurator“. Antwort 16 (Z. 48): „Nein, mach es bitte sofort. … Denn, das Prinzip
  werden wir noch sehr oft haben. das könnte man da copieren ;)“ (benannte Profile in v1).
- Bestand: Sprache als Datei je Person/Programm (ADR 0057 Z. 39–41); Stile als Daten (fs-components-styles `StyleId`); Frontend-Wahl der Person im Starter
  (ADR 0094 Z. 28 „Wahl des Menschen (Einstellungen des Programms)“); Systemeinstellungen hell/dunkel usw. (ADR 0074 Z. 35). Kein gemeinsamer Ort, keine Sperre.

**Entscheidung**
1. **Drei Teile (Entscheid der Strategie, Nutzer Z. 15 „ist Deine Entscheidung“):** Vertrag **`settings`** (fs-interfaces, eigene Vertragsversion, DRAFT nach
   ADR 0045); Bibliothek **`fs-setting`** (Einzahl; Repo fs-components, Schicht 1, ohne Blinc, capnp, tokio); Programm **`fs-settings`** (Antwort 15), das alle
   installierten Einstellungen an einer Stelle zeigt und ändert.
2. **Schichten** (Reihenfolge der Auflösung, eine Stelle `resolve`): Baustein-Voreinstellung < Instanz (Admin-Vorgabe) < System (Desktop: Sprache, hell/dunkel;
   nur lesen) < allgemeines Profil der Person < Programm-Profil. **Gerät** ist Ablageort (`$XDG_STATE_HOME`), keine Schicht. **Eine Sperre schlägt jede Schicht.**
3. **Besitzer-Arten** der Einstellungen: Gerüst, Modul, Theme, Programm (Nutzer Z. 18), dazu Frontend; jede Einstellung ist **deklariert** (Schlüssel, typisierte Art
   Flag/Ganzzahl mit Grenzen/Auswahl/Sprache/Text, Voreinstellung, Gruppe, Ablage, MF2-Texte de+en); Undeklariertes wird nie gespeichert (`not-declared`).
4. **Speichern:** zwei Ziele „für dieses Programm“ und „für alle“ (Nutzer Z. 21); ein Programm schreibt nur sein eigenes Profil und das allgemeine, **nie** das eines
   anderen Programms und nie für eine andere Person (Z. 21, 32); „für alle“ entfernt die eigene Überschreibung dieses Programms (Ausgestaltung).
5. **Schloss:** Instanz-Admins setzen Vorgaben und **sperren** je Einstellung (`reason`, `locked_by`, `locked_at` in UTC); gesperrt darf niemand ändern, auch der
   Sperrende nicht; ohne Recht erscheint der Knopf nicht (Nutzer Z. 27–30). Das Recht `can_lock` vergibt **nur fs-access** an Instanz-Admins (ADR 0095 Admin-Stufen),
   **nie** über Token oder Delegation (wie ADR 0054 Z. 181/185). Eine Sperre **scheitert geschlossen** (Prüfungs-Auflage N2): passt der Instanzwert nicht, gilt die
   Baustein-Voreinstellung, die Sperre bleibt sichtbar. Eine Sperre braucht einen Grund (Auflage N6).
6. **Benannte Profile in v1** (Antwort 16): „Arbeit“, „Vortrag“ … über den wiederverwendbaren Datenbausatz **`ProfileSet<V>`** (fs-types: Namen, aktives Profil,
   Umschalten, Erben vom allgemeinen Profil; eigener Fixpunkt `profile_v1`), nicht nur für Einstellungen.
7. **Außen:** die Einstellungen sind über **fs-connect** von außen ansteuerbar (Server, Programm fs-settings; Nutzer Z. 16 „von außen auch der Server“), mit den
   Rechten der Person bzw. des Admins (fs-access, AS2); eine KI hält nie `can_lock` und ändert Einstellungen nie als die Person (ADR 0054/0091 Nachträge 17.11.).
   **Ob KI erlaubt ist, ist ein Recht in fs-access, nie eine Einstellung** (Prüfungs-Auflage L3).
8. **Erster Nutzen:** Sprache und Theme (Stil, hell/dunkel) **live** in jedem Programm über die Hülle (fs-components-app): `refresh` im Takt (Stempel-Vergleich),
   Beobachter schalten Texte (MF2) und Stil um; Programme bekommen das ohne eigenen Code.
9. **Standards:** XDG Base Directory (Orte), XDG Desktop Portal `org.freedesktop.portal.Settings` (System-Schicht: `color-scheme`, `accent-color`, `contrast`;
   Adapter später), BCP 47 (Sprache), TOML 1.0 (Dateien, flache Schlüssel, nur Skalare), DTCG Design Tokens beim Theme (ADR 0074); GSettings/dconf nur als **Konzept**
   (Deklaration je Baustein, Schema-Datei), nicht übernommen.

**Pflichttests** (je ohne Umsetzung rot; Suite `settings` in fs-conformance, 18 Regeln aus der Probe): Sperre schlägt jede Schicht; Sperrender ändert selbst nicht;
ohne Recht kein Sperrknopf; fremdes Programm-Profil nie geschrieben; „für alle“ entfernt die eigene Überschreibung; undeklarierter Schlüssel abgelehnt; kaputte Datei
bleibt byte-gleich; Sperre scheitert geschlossen; Index der Profile unter Dateisperre (keine doppelte Id).

**Folgen**
- Nachträge (eine Welle): ADR 0057 (Sprache über fs-setting), 0065 (Menü Programm › Einstellungen öffnet fs-settings), 0074 (Darstellung als Einstellung,
  Portal-System-Schicht), 0094 [Entw.] (Frontend-Wahl `fs.shell.frontend` als Einstellung).
- Reihenfolge: Probe-Nachlauf N1–N9 → Fixpunkt `setting_v1` → fs-types-Lift (`coded`, `ProfileSet`, `profile_v1`) → Vertrag `settings` in fs-interfaces → Hülle
  (Sprache/Theme live) → Programm fs-settings.

**Offen**
1. Portal-Adapter: **Entscheid der Strategie (b7, 2026-11-17):** zuerst ein Spike mit `ashpd =0.14.0`, derselben Version wie in `fs-components-filepicker` (keine zweite Version im Lock); bis zum Adapter bleibt die System-Schicht aus Umgebungsvariablen. [entschieden, Spike offen]
2. Instanz-Vorgaben auf einem Server schreiben (v1 nur lesen; `Admin::set_default` mit Admin-Recht aus fs-access, Auflage L4): **Entscheid der Strategie (b7, 2026-11-17):** die Datei `instance.toml` schreibt vor fs-connect ein **Admin per Skript**, nie ein Agent (vereinbar mit der Regel „keine KI auf Servern“); das Skript liefert `fs-setting` als Befehl mit, die Ausführung liegt beim Menschen. [entschieden]
3. Windows-Orte (Known Folders). [offen]
4. Gleichzeitiges Schreiben zweier Programme ins allgemeine Profil (letzte Umbenennung gewinnt). [offen]
