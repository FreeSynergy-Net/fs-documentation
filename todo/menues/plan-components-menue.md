# PLAN fs-components: ein Menü-Modell für alle Programme (M1–M8)

Stand 2026-11-17, Opus-Plan, nur Text. Basis: fs-components `main` = v0.0.25 (7bf826c9), Blinc fs-blinc-3.1 (cf925af), fs-documentation main (980adcdc).
Quellen: todo/menues/files-menue-dossier.md, todo/features/groups-bedienung.md,
internem Editor-Plan 0.0.14, ADR 0065/0066/0074/0094 (https://github.com/FreeSynergy/fs-documentation/tree/main/conventions/decisions).

## 0. Ist-Stand (gelesen, nicht gebaut)
- `fs-components-app/src/menu.rs`: `MenuEntry {id, label, disabled, checked, children}` (`#[non_exhaustive]`), `Menu {label, entries}`, ein `MenuHandler(&str)`; nur Titelleiste. Kein Trenner, Radio, Symbol, Kürzel, Grund-Text.
- `widgets/dropdown`: eigenes Aufklappmenü mit `place` (Flip/Clamp/Scroll) und `separator()`, aber eigene Eintragsart: zweiter Weg neben `MenuEntry`.
- `widgets/keys.rs` (`bind_keys`, nur fokussiertes Element), `widgets/tree_view` (Adapter über `blinc_cn` tree, Pfeile/Home/End/Enter, kein Zeilenmenü), `widgets/share_dialog` (Personen/Gruppen wählen, Muster für M6), `widgets/dialogs` (Rahmen, modal, Enter/Esc), `widgets/slash_menu` (nur Wörter).
- Blinc cf925af: `on_right_click`/`on_context_menu` (div.rs:4578), `Key::ContextMenu` (Menü-Taste, desktop input.rs:48), KEY_DOWN mit Strg/Alt/Shift/Meta wird gesendet (keyboard.rs:262), `blinc_cn::context_menu` mit shortcut/icon/separator/submenu und AtPoint-Clamp. `AccessibilityRole` kennt nur 12 Rollen (u. a. `MenuItem`, `Checkbox`, `Radio`), kein menubar/menu/separator/tree/treeitem/dialog/toolbar; `AccessibilityNode` hat `checked`, `expanded`. **Desktop hat keine Brücke zu Screenreadern** (nur `blinc_app/src/ios/accessibility.rs`).

## 1. Zielmodell: Befehle (Programm) + Anordnung (Frontend) + Sichten (Stil)
Drei Schichten nach ADR 0074 §5/§6 und Memo „Style layers“:
1. **Befehl** (das Programm veröffentlicht ihn, ADR 0074 §5, ADR 0066 `supported`):
   `Command { id: CommandId, label: TextKey (MF2, ADR 0057), icon: Option<IconName> (freedesktop Icon Naming), shortcut: Vec<Shortcut> (Vorbelegung), state: Enabled | Disabled{reason: TextKey} | Unsupported{reason}, toggle: None | Check{on} | Radio{group, on}, role_hint }`.
   Id-Regel: freedesktop-Aktionsname (`edit-copy`, `document-new`), sonst `<programm>.<befehl>`. Ausgegraut **immer mit Grund** (Regel „nie still ausgegraut“).
   Objektbefehle (Zeile, Datei, Mitglied) bekommen den Gegenstand: `invoke(id, Target)` mit `Target = None | Objects(Vec<ObjectRef>)`.
2. **Anordnung** (das Frontend, später Datei nach ADR 0074 §6, KXMLGUI/GMenuModel-Muster):
   `MenuItem { kind: Command(CommandId) | Submenu{label, icon, children} | Separator | Group{id, children} | Placeholder(slot) }`.
   Ein Baum je Ort: `menubar`, `commandbar`, `context:<objektart>` (z. B. `context:file`, `context:file:more` für die zweite Stufe), `toolbar`, `palette` (= alle Befehle, flach, Pfad als Untertitel).
3. **Sichten** (fs-components, je Stil-Schicht gestylt; Frontends komponieren): `MenuBar`, `Dropdown` (unter Knopf), `ContextMenu` (am Zeiger/Element), `CommandBar` (Explorer-/Files-Stil: Knöpfe + Aufklapper + „Weitere“), `Toolbar`, `CommandPalette` (Suche, Kürzel rechts). Alle lösen dieselbe Anordnung gegen dieselbe Befehlsliste auf; ein Handler `on_command(id, target)`.
- **Kürzel** sind Teil des Modells: Speicherform nach W3C `aria-keyshortcuts` (`Control+Shift+P`), Modifikator `Primary` = Strg (Linux/Windows) bzw. Cmd (macOS) wie GTK `<Primary>`; Anzeige je Plattform/Sprache (Strg+Umschalt+P, ⌘⇧P) über MF2. Profil: CUA als Grundlage (ADR 0074 Z. 32); Vorrang Mensch-je-Programm → Mensch-alle → Frontend → System (ADR 0074 §8). Konflikte werden angezeigt, nie still entschieden.
- **Barrierefreiheit**: jedes Element trägt seine WAI-ARIA-Rolle im Modell (`menubar`, `menu`, `menuitem`, `menuitemcheckbox`, `menuitemradio`, `separator`, `toolbar`, `tree`, `treeitem`, `dialog`, `listbox`/`option`, `combobox` für die Palette), `aria-keyshortcuts`, `checked`, `expanded`, `disabled`+Grund. Abbildung auf Blinc, wo es die Rolle gibt; sonst Upstream-Anfrage (Abschnitt 4).
- **Ort im Code**: neues Crate `fs-components-commands` **ohne Blinc** (Modell, Kürzel-Parser/-Anzeige, Konfliktprüfung, Palettensuche, Auflösung Anordnung×Befehle): rein, schnell, mutationstestbar; über ADR 0094 auch für Frontends in eigenem Prozess (später capnp-Abbildung). Sichten in `fs-components-widgets`/`-app`.
- Muster: Command (Befehle sind Objekte mit Zustand) + Composite (Anordnung) + Strategy (Sicht) + Adapter (Blinc-Tasten/Rollen); `Menu/MenuEntry` werden Adapter auf das neue Modell (Abschnitt 3).

## 2. Bausteine in Lauf-Reihenfolge (eine Komponenten-Spur, ein Build-Slot; Programme in der zweiten Spur)
| # | Baustein | Hängt an | Aufwand | Branch |
|---|---|---|---|---|
| M1 | Modell-Crate + `MenuEntry`-Erweiterung: Trenner, Gruppe, Radio, Häkchen, Symbol, Kürzel-Feld (nur Anzeige rechts), Grund bei Ausgegraut; Titelleisten-Menü und `dropdown` lesen dasselbe Modell | – | M | `unreviewed/menu-m1-model` |
| M2 | Kürzel: Parser/Anzeige (Plattform, MF2-Tastennamen), Fenster-Tabelle, Ausführung über `keys.rs`-Adapter, Vorrang Fokus-Element > Fenster, Konflikte melden, Profile CUA | M1 | M | `unreviewed/menu-m2-shortcuts` |
| M3 | Kontextmenü: Rechtsklick, Menü-Taste, Umschalt+F10 (am fokussierten Element), Position Flip/Clamp über `dropdown::place` (AtPoint), Untermenü, zweistufig („Weitere Optionen“), Ziel = Auswahl | M1 | M | `unreviewed/menu-m3-context` |
| M4 | Tastatur in allen Menüsichten: Pfeile, Home/End, Enter/Leertaste, Esc (eine Stufe zurück), Rechts/Links für Untermenü, Typeahead, Mnemonics (Alt+Buchstabe, unterstrichen nur bei Alt); dazu Listen: Pfeile, Entf, F2, Strg+A, Mehrfachwahl Umschalt/Strg | M2, M3 | M | `unreviewed/menu-m4-keyboard` |
| M5 | Baumansicht ausbauen (`tree_view`, heute `TreeNode{key,label,open,children}` voll geladen): Laden bei Bedarf, Kind-Zahl, Mehrfach-Eltern (Zeile = Kante), Zeilenmenü (M3), Entf/F2/Strg+N als Befehle (M2), Rollen tree/treeitem; alte `TreeNode`-API bleibt | M3, M4 | M | `unreviewed/menu-m5-tree` |
| M6 | Personenauswahl-Dialog: Suche, Mehrfachwahl, Ergebnis = Liste von Personen-Verweisen (opak), keine eigene Liste; Datenquelle als Trait `CandidateSource` in fs-components, Adapter im Programm auf `person_directory_v1::PersonDirectory::{suggest, resolve_many}` (gesperrt, unverändert); fehlende Quelle sichtbar melden | Dialog-Rahmen (vorh.), sonst frei | M | `unreviewed/menu-m6-person-picker` |
| M7 | Befehlsleiste (Explorer-/Files-Stil: Neu ▾, Ausschneiden/Kopieren/Einfügen/Umbenennen/Teilen/Löschen als Symbolknöpfe, Sortieren ▾, Ansicht ▾, „Weitere“ ▾ mit Überlauf bei schmalem Fenster) + Kommandopalette (Strg+Umschalt+P, Suche über Label/Id/Pfad, Kürzel rechts, gesperrte mit Grund) | M1, M2, M4 | L | `unreviewed/menu-m7-commandbar-palette` |
Tests je Baustein (jeder ohne die Umsetzung rot; Mutanten über `cargo mutants` auf dem Modell-Crate, Ziel: keine überlebenden Mutanten in Parser/Auflösung/Konflikt/Suche/`place`):
- M1: Auflösung Anordnung×Befehle, doppelte Id → Fehler (Trenner ausgenommen), Radio-Gruppe genau einer an, Unsupported → gesperrt+Grund. Bilder: Menü aufgeklappt hell/dunkel mit Trenner/Häkchen/Radio/Symbol/Kürzel, Untermenü offen.
- M2: Parser Rundreise (`Control+Shift+P` ↔ Anzeige de/en/macOS), Konflikt erkannt, Fokus-Element gewinnt (Strg+B im Editor), Buchstabe ohne Modifikator nie Kürzel in Textfeld, nicht-US-Belegung (QWERTZ: Strg+Z). Router-Tests wie `tests/menu_common`.
- M3: Rechtsklick/Menü-Taste/Umschalt+F10 öffnen am richtigen Ort; Rand rechts/unten → Flip/Clamp; Klick außerhalb schließt; Doppelklick wählt einmal. Bilder: Kontextmenü Mitte, Rand unten rechts, zweite Stufe, hell/dunkel.
- M4: Tastaturfolgen als Tabelle (Taste → erwarteter Fokus/Zustand), gesperrte werden übersprungen, Mnemonic-Kollision gemeldet. Bild: Mnemonics sichtbar mit Alt.
- M5: Pfeile auf/zu, Zeilenmenü, F2/Entf lösen Befehl mit Ziel aus; Laden bei Bedarf fragt nur beim Aufklappen; Objekt unter zwei Eltern = zwei Zeilen, getrennte Auswahl; Kreis im Pfad wird abgeschnitten + markiert. Bild: Baum drei Ebenen mit Zeilenmenü, Knoten mit Kind-Zahl, Mehrfach-Eltern-Marke.
- M8: siehe 2a.
- M6: Suche → Kandidaten, Mehrfachwahl, Esc bricht ab, Quelle fehlt → Meldung, Rückgabe nur Verweise; Doppel (Fake) aus `fs-people-directory::fake`. Bild: Dialog leer/mit Treffern/Quelle fehlt.
- M7: Überlauf in „Weitere“ bei Breite 480, Palette filtert/ordnet, Enter führt aus. Bilder: Befehlsleiste breit/schmal, Palette offen, hell/dunkel.
Abnahme je Baustein: Bilder-Workflow `picture-acceptance` + Seitenvergleich mit Vorbild (Explorer/Files/KDE), dann Opus-Review, dann Tag.

**Welche Bausteine vor welchem Programm-Lauf:**
- fs-groups Stufe 1a (Mitglieder + Baum mit vorhandenem `tree_view`, Knöpfe) läuft **sofort** parallel; Stufe 1b (Symbolleiste, Kontextmenü Gruppe/Mitglied/Leerfläche, Personenauswahl, Pfeile/Entf/F2) braucht M1, M3, M4, M5, **M8**, M6.
- fs-files: Befehlsleiste + zweistufige Kontextmenüs + Kürzel braucht M1–M4; Ordnerbaum links später über M8; Kommandopalette und Explorer-Befehlsleiste braucht M7. **Keine zusätzliche klassische Menüleiste** (Vorbild-treu).
- fs-texts: Kürzel-Tabellen (PLAN-0.0.14 Lauf 4) braucht M1+M2; Block-/Format-Menü als Kontextmenü M3; Slash-Menü = Palette-Sicht am Cursor (M7); Seitenbaum (Wiki-Hierarchie) später über M8.
Vorgeschlagene Reihenfolge der Komponenten-Spur: M1 → M2 → M3 → M4 → M5 → **M8** → M6 → M7 (groups 1b ist nach M6 frei, files nach M4 bzw. M7). M6 hängt an nichts aus M1–M8 und wird vorgezogen, sobald ein Slot frei ist (Spur hat nur einen Slot, also im Zweifel direkt nach M1).

**Passt das Modell für alle? (Prüfung gegen die Programme)**
- fs-groups (Seitenleiste + Symbolleiste + Kontextmenü, kein Menüband): passt. Symbolleiste = `toolbar`-Anordnung, Ansicht-Umschalter Baum/Liste = Radio-Gruppe, Kontextmenüs je Objektart (`context:group`, `context:member`, `context:empty`), „Rolle ändern ›“ = Untermenü mit Radio. Lücke: Suchfeld in der Symbolleiste ist kein Befehl → Anordnung braucht `Placeholder(slot)` für eingebettete Bausteine (in M1 enthalten). Lücke: Befehle mit Ziel aus Baum **und** Liste → `Target` muss beide Auswahlquellen tragen.
- fs-texts (Editor): passt für Datei/Bearbeiten/Format-Menüs, Kontextmenü, Befehls-Kürzel. Lücke: Zeichen-Kürzel („# “, „/“) sind **keine** Tastenkürzel, sondern eine zweite Tabelle im Editor (bleibt in fs-texts/Workbench, nicht im Modell). Lücke: Slash-Menü und Format-Menü bei Markierung hängen am Cursor/an der Markierung → Palette und Kontextmenü brauchen Anker „Rechteck“ statt nur Zeiger (in M3/M7). Lücke: Strg+B muss im Editor vor dem Fenster greifen → Vorrang Fokus-Element (M2).
- fs-files: passt. Befehlsleiste mit Aufklappern = `commandbar`-Anordnung, zweistufiges Kontextmenü = `context:file` + `Submenu` „Weitere Optionen“ (Umschalt+Rechtsklick öffnet direkt Stufe 2), Palette = alle Befehle. Lücke: Symbolzeile oben im Kontextmenü (Explorer 11) → Gruppe mit Darstellung „Symbolreihe“ (Gruppen-Attribut `inline_icons`, in M3).
- Standard-Menü (ADR 0065: Programm/Ansicht/Hilfe, Strg+Q, F1) wird als feste Befehle `app.*` ins Modell gehoben (M1) und bleibt in jedem Frontend erreichbar.

## 2a. M8 Baum-Seiten-Werkbank (neu, wiederverwendbar; Aufwand L; Branch `unreviewed/menu-m8-tree-bench`)
Name `TreeBench` in `fs-components-workbenches/src/tree_bench/` (Pattern: Template method für das Gerüst + Strategy für Seiten + Adapter auf die Datenquelle). Links Baum (M5), rechts Seite mit Reitern, oben Symbolleiste, Kontextmenüs aus dem gemeinsamen Modell (M1/M3). Die Personen-Werkbank (`workbenches/people`, PeopleWidget) bleibt unberührt. Kennt kein Programm, keinen Store: nimmt Traits.
- **Baum-Knoten-Modell** (Trait `TreeSource`): `roots() -> Page<NodeSummary>`, `children(edge, place) -> Page<NodeSummary>` (Laden bei Bedarf, seitenweise), `NodeSummary { object: ObjectRef, kind: ObjectKind, label, icon, child_count: Option<u32> (None = unbekannt, Pfeil trotzdem), edge: EdgeRef, also_under: u32 }`. **Zeile = Kante, nicht Objekt**: dasselbe Objekt unter zwei Eltern ist zwei Zeilen mit eigenem `TreePath(Vec<EdgeRef>)`; Auswahl und Aufgeklappt-Zustand hängen am Pfad, Befehle bekommen Objekt **und** Kante (Ziel „Aus Gruppe lösen“ braucht die Kante). Kreise: Quelle meldet sie (groups-Kern), die Werkbank schneidet an einem schon im Pfad stehenden Objekt ab und markiert.
- **Seiten-/Reiter-Modell**: `PageSpec { tabs: Vec<TabSpec { id, label: TextKey, count: Option<u32>, state: Enabled|Disabled{reason} }> }` je `ObjectKind`; Inhalt je Reiter liefert das Programm als Surface (Strategy `PageProvider::tab(object, tab_id)`); Reiter-Wechsel ist Sichtzustand, **kein Befehl**. Ungespeicherte Änderungen: Seite meldet `dirty`, Wechsel fragt (vorhandener `confirm-dialog`).
- **Auswahl**: eine Auswahl je Werkbank (Baum **oder** Liste im Reiter hat den Fokus), `Selection { focus_area, items: Vec<Target> }`; daraus `Target` für jeden Befehl (M1). Mehrfachwahl nur in Listen der Reiter, im Baum Einzelwahl (Stufe 1).
- **Tastatur**: Pfeile/Home/End/Links-Rechts (auf/zu) im Baum (M5), F6 wechselt Baum ↔ Seite ↔ Symbolleiste, Strg+Tab/Strg+Bild ab für Reiter, Entf/F2/Strg+N/Alt+Enter = Befehle aus der Kürzel-Tabelle (M2), Menü-Taste/Umschalt+F10 = Kontextmenü der Auswahl (M3).
- **Menü-Anbindung**: Symbolleiste = Anordnung `toolbar`, Kontextmenü = `context:<ObjectKind>` bzw. `context:empty`; Suchfeld als `Placeholder(slot)`.
- Tests: Fake-`TreeSource` mit Mehrfach-Eltern, Kreis, 10 000 Kindern (nur sichtbare Seite geladen, Zähler im Fake), fehlende Quelle → Meldung statt leerem Baum; Reiter mit `dirty`; F6-Ring; Befehl erhält Objekt+Kante. Mutanten auf Pfad-/Auswahl-Logik. Bilder hell/dunkel: Werkbank breit (Baum + Reiter Mitglieder), schmal 480 px (Baum einklappbar), Kontextmenü auf Baumzeile, Reiter gesperrt mit Grund.

**Datenmodelle ohne Doppelung (Abstimmung M1 ↔ M8):** Der Baum trägt nur **Struktur** (Objekt, Art, Kante, Zahl), nie Befehle oder Menüeinträge; Seiten tragen nur **Reiter**, nie Aktionen. Was man tun kann, steht allein im Befehlsmodell (M1, ADR 0074 §5 „Funktionen“), welches Menü an welchem Objekt hängt, allein in der Anordnung über `ObjectKind` (ADR 0074 §5 „Objekte“). Verbindung nur über zwei Typen aus `fs-components-commands`: `ObjectKind` und `Target`. `tree_view`s `TreeNode` wird Adapter auf `NodeSummary` (kein zweites Knotenmodell). `Disabled{reason}` ist ein gemeinsamer Typ für Befehle und Reiter.

**Prüfung M8:**
- fs-groups: passt (Gruppen-Baum mit Mehrfach-Eltern = Kanten nach ADR 0082, Reiter Mitglieder/Untergruppen/Einladungen/Eigenschaften, Symbolleiste, Kontextmenüs). Lücke: Modus je Kante (BottomUp/TopDown/Einzeln) muss an der Kante sichtbar sein → `NodeSummary.edge_badge` (optional, Stufe 2). Lücke: Wurzel „Meine Gruppen“ vs. alle → Filter der Quelle, nicht der Werkbank.
- fs-files: passt für Ordnerbaum + Inhaltsliste. Lücke: rechts ist keine Reiter-Seite, sondern eine Liste mit eigener Befehlsleiste (M7) → `PageSpec` mit einem Reiter ohne Reiterleiste; Lücke: Ziehen/Ablegen zwischen Baum und Liste (nicht in Stufe 1, eigener Baustein).
- fs-texts: passt für Seitenbaum (Wiki-Hierarchie) + Editor als einziger Reiter. Lücke: Reihenfolge der Geschwister ist Daten (Seiten sortieren) → Befehle „nach oben/unten“ mit Kante als Ziel, Werkbank zeigt nur; Editor-Fokus darf F6/Strg+Tab nicht schlucken (Vorrang-Regel M2).

## 3. Rückwärtskompatibilität und Versionen
- `MenuEntry`/`Menu`/`set_menus` bleiben unverändert benutzbar: `#[non_exhaustive]` erlaubt neue Felder ohne Bruch; neue Fähigkeiten nur über neue Konstruktoren (`MenuEntry::separator()`, `.radio(group)`, `.icon()`, `.shortcut()`, `.reason()`). Intern Adapter `Menu → Anordnung + Befehle`. `set_menus` wird erst nach Umstellung aller Programme als veraltet markiert (frühestens v0.1; vor dem ersten Release ist Ersetzen erlaubt, aber unnötig).
- Doppelte-Id-Prüfung überspringt Trenner (sonst bricht `DuplicateMenuEntry` bei mehreren Trennern).
- `dropdown`-Builder bleibt, liest intern das Modell; alte Aufrufe kompilieren weiter.
- **Ein Tag je Baustein** (v0.0.26 = erster fertiger Baustein, danach je Baustein +1 in Lauf-Reihenfolge, M1–M8), additiv, weil groups/files/texts gestaffelt anheben; kein Sammel-Tag (sonst wartet groups auf M7). Gemeinsame Version aller Crates = Tag (Memo fs-release). Pins heute gemischt (rev bei fs-files/fs-wiki/fs-calendar/fs-maps, Tags bei fs-people/fs-store; Stand lokale Klone): beim nächsten Lift jedes Programms auf **Tag** umstellen.
- Doku zieht mit: DESIGN.md „Not built for menus“ und fs-files DESIGN.md:371 („flat menu“) werden je Baustein aktualisiert; Komponenten-Doku je Sicht (description/usage/attributes) und `shortcuts.md`-Vorlage je Programm.

## 4. Risiken
- **Barrierefreiheit (größtes Risiko):** Blinc hat auf Linux/Windows/macOS keine Screenreader-Brücke, und es fehlen Rollen (menubar, menu, separator, menuitemcheckbox/-radio, tree/treeitem, toolbar, dialog). Wir tragen Rollen im Modell und testen sie dort; git-bug-Anfrage an Blinc: Rollen erweitern + AccessKit-Brücke für Desktop. Bis dahin ist die Tastaturbedienung vollständig, aber nichts wird vorgelesen; das steht offen in der Doku.
  - Ehrlich: Tastatur ja, Vorlesen noch nicht (Blinc). Anfrage lokal angelegt als git-bug ec4693d (Desktop-Barrierefreiheit), dazu ec7815a (Alt+Buchstabe in Textfeldern, unverifiziert); noch nicht gepusht.
- **Tastatur in Blinc:** Enter/Leertaste/Tab gehen zuerst an Blincs Navigation (keys.rs); Alt+Buchstabe erzeugt zusätzlich TEXT_INPUT (nur Strg/Meta werden ausgefiltert, keyboard.rs:248) → Mnemonic tippt evtl. ins Textfeld; Alt allein (Fokus in die Leiste) nicht belegt; Tastencodes je Belegung (offener Blinc-Fix `fix-non-us-key-text`). Spike in M2 vor dem Bau.
- **Overlay/Fokus:** Klick außerhalb schließt Blinc-Dropdowns nicht, Neubau vergisst Click-outside (DESIGN.md); Fokus muss nach Esc zurück an den Auslöser; schließende Panels sind noch drückbar (Wächter vorhanden, auf Kontextmenü übertragen).
- **Plattformen:** macOS Cmd vs Strg, Windows Alt-Menü-Konvention, Linux Desktop-Kürzel (Super, Strg+Alt+…) kollidieren; Profile + Konfliktanzeige; globale Hotkeys (`blinc_app::hotkey`) **nicht** benutzen (fensterweit genügt, systemweit nur auf Wunsch).
- **Umfang:** M7 und M8 sind groß (M8: Laden bei Bedarf + Kanten-Pfade); M7 ist groß (Überlauf + Palette); bei Engpass Palette zuerst, Befehlsleiste danach. Zwei Build-Slots: Komponenten-Spur und Programm-Spur nie mehr als je einer.

## 5. Offene Fragen (mit Vorschlag)
1. Standard-Menü (ADR 0065) in Frontends ohne Menüleiste (fs-files Explorer-Stil): wohin? Vorschlag: Programm/Ansicht/Hilfe bleiben als kleine Titelleisten-Menüs der Shell, die Befehlsleiste ersetzt nur Datei/Bearbeiten; keine klassische Leiste darüber hinaus.
2. Neues Crate `fs-components-commands` (ohne Blinc) oder Modell in `fs-components-app`? Vorschlag: eigenes Crate (rein, mutationstestbar, auch für Frontends in eigenem Prozess nach ADR 0094 und später als eigenständiges Crate für andere).
3. Kürzel-Speicherform: W3C `aria-keyshortcuts` (`Control+Shift+P`) mit `Primary` als einziger Erweiterung? Vorschlag: ja; Anordnungsdatei-Format (ADR 0074 §6) erst nach M7, bis dahin Anordnung als Rust-Builder.
4. Personenauswahl: darf fs-components eine Abhängigkeit auf `fs-people-directory` bekommen? Vorschlag: nein; eigenes Trait `CandidateSource` in fs-components, Adapter im Programm (fs-groups-app), `person_directory_v1` bleibt unberührt.
5. Blinc-Anfragen (Rollen, Desktop-Screenreader, Alt-Text-Eingabe) jetzt per git-bug stellen oder erst nach M4-Spike? Vorschlag: Rollen + Brücke sofort (unabhängig), Alt-Verhalten nach dem Spike mit Wiederholungsfall.

## Nachtrag 17.11. (b7): weitere Bausteine aus den Feature-Listen forms/resources/activities/broadcast
- M9 Drag-Umsortieren (forms: Fragen umsortieren)
- M10 Zeitstreifen + Zeitraum-Auswahl (resources: Verfügbarkeitsstreifen, Reservieren)
- M11 Zeitleiste mit Tagesgruppen (activities)
- M12 Statusleiste mit Live-Zahlen (broadcast)
Einordnung: nach M8; Reihenfolge je nach Programm-Lauf (forms → resources → activities → broadcast).
