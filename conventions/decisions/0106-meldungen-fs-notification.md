# 0106 – Meldungen (fs-notification): ein Modul für Meldung, Fehler und Nachfrage

Status: **Entwurf** (2026-11-23; Workflow `adr-write`, Schritt `draft`; Grundlage `.scratch/woche-11-23/meldungen/ENTSCHEID-schnitt.md` Punkt E1, von der Strategie angenommen; Urheber: Nutzerentscheid 21.11. (fs-update F4: Standard „Fragen“ als Modal) und Nutzerregel 23.11. (Toast oder Modal, nie Text oben); Opus-Prüfung ausstehend) · **setzt um** ADR 0065 §4 und §5 (Meldung gehört zum Anlass, Fehler bleibt sichtbar, Observer mit Lebensdauer) · **ergänzt** ADR 0069 Nachtrag 23.11. (E5, Update-Frage als `notification.ask`) · **verwendet** ADR 0057 (Code mit Parametern, MF2), ADR 0092 Z. 17 (Namensregel Einzahl), ADR 0100 (Einstellungen `fs.notification.*`), ADR 0069 E2 (Parameter schwärzen)

**Lesehinweis:** Jede Aussage stammt aus `ENTSCHEID-schnitt.md` E1. Was dort nur als Vorschlag oder später steht, ist so markiert.

---

## Kontext

Heute melden Programme Fehler und Ergebnisse uneinheitlich: Text in der Statuszeile, Text oben im Fenster, stderr ohne Fenster. Der Trait `Tell` in `fs-starter` (`crates/fs-starter/src/tell.rs`, Typen `Note{level: Error|Hint, code: Code}`, Standard `StderrTell`) ist ein Meldeweg, hängt aber an keinem Fenster und an keinem Betriebssystem.

Bestand (belegt):
- Die Komponenten für Toast und Modal liegen auf main vor: `fs-components-overlays` (`toast/`, `dialogs/`, `popover/`, `tooltip/`); der Banner liegt in `fs-components-widgets/src/banner/`. (Stand fs-components main 0ac9af0f, 23.11.)
- Blinc hat `blinc_app/src/notify.rs`. Es kann nur Titel, Text und `show() -> bool`. Das Icon wird gespeichert, aber nicht gesetzt (`#[allow(dead_code)]`). Es gibt keine id, kein Ersetzen, keine Aktionen und keinen Schließgrund.
- `fs-starter` ist ein eigenes Repo (`FreeSynergy-Net/fs-starter`, Crates `fs-starter` und `fs-starter-host`), nicht Teil von fs-components oder fs-rpc.

## Entscheidung

### 1. Ein Modul `fs-notification`
1. **Name und Standard.** Bibliothek `fs-notification` (Einzahl nach ADR 0092 Z. 17), Vertrag `notification`. Der Kern ist der gemeinsame Nenner der Standards freedesktop Notifications 1.3, XDG-Portal `Notification`, Windows App Notifications, Android `Notification` und WHATWG Notifications: `id`, `replaces`, Dringlichkeit `low|normal|critical` (freedesktop urgency 0–2; das Portal kennt zusätzlich `urgent`, das wird auf `critical` abgebildet), Titel und Text als **Code mit Parametern** (`fs_types::coded`, wie `Tell` und `Settings::problems`, ADR 0057: das Programm formuliert in MF2), Aktionen (id und Text-Code), `expire`, `category`, Schließgrund `expired|dismissed|closed|undefined` (freedesktop 9.2.1).
2. **Eine Quelle der Wahrheit.** Jede Meldung, jeder Fehler und jede Nachfrage eines Programms läuft über `fs-notification` und sonst über nichts. `fs-starter::Tell` bleibt als Port erhalten und wird Adapter auf `fs-notification`. `StderrTell` bleibt nur der Rückfall ohne Fenster. Kein Programm schreibt Meldungstext in die Statuszeile oder oben ins Fenster. Die Statuszeile (`fs-components-app` `set_status`) zeigt nur noch Zustand (z. B. „verbunden“), keine Meldung. ADR 0065 §4 und §5 gelten unverändert und werden hier umgesetzt.
3. **Befehle im Befehlssatz des Scaffold.** `notification.tell` (melden), `notification.ask` (fragen, mit Aktionen und Antwort), `notification.close` (schließen per id). Sie werden wie `app.*` als feste Befehle in `fs-components-commands` geführt (`standard`, `Param`/`ResultType`, `export_blocks`). Damit sind sie Workflow-Bausteine (CLAUDE.md §8, Befehle als Makrosprache) und über MCP und CLI erreichbar.
4. **Formen.** Die Meldung erklärt ihre Formen, die Components stellen sie dar (Scaffold · Module · Form · Components):
   - Form `toast` → `fs-components-overlays::toast` (`Toasts`, `Severity` info/ok/warning/error; Warnung und Fehler bleiben stehen; WAI-ARIA `status`/`alert`). Vorhanden, braucht nur einen Adapter.
   - Form `modal` → `fs-components-overlays::dialogs` (alert_dialog, Rolle `alertdialog`, WAI-ARIA APG). Für `ask`, wenn eine Antwort Pflicht ist.
   - Form `banner` → `fs-components-widgets::banner`. Nur für Zustände einer Ansicht, die bleiben (z. B. „offline“), nicht für Meldungen.
   - Form `system` → Benachrichtigung des Betriebssystems (Punkt 5).
   - **Die Wahl der Form trifft eine Regel im Modul, keine Stelle im Programm.** `critical` oder `ask` mit Pflichtantwort → Modal, wenn Ruhe herrscht (sonst stehender Toast mit denselben Aktionen, Nachtrag zu ADR 0069 E5, Buchstabe c); alles andere → Toast. Ist das Fenster nicht im Vordergrund oder minimiert, oder gibt es kein Fenster (Server, Updater), kommt zusätzlich bzw. stattdessen `system`. Die Regel ist eine Einstellung (`fs.notification.*`, Besitzer-Art Gerüst, ADR 0100 E3), keine feste Verdrahtung.
   - Themes dekorieren Toast und Modal über die vorhandenen `styles.rs`-Variablen der Overlays. Die Systembenachrichtigung gestaltet das Betriebssystem; das ist nicht gestaltbar und wird so dokumentiert.

5. **Adapter je Betriebssystem hinter eigener Schnittstelle.** Port `Outlet` im Kern; Adapter-Crate `fs-notification-system`. Der Kern kommt ohne Blinc, ohne zbus und ohne windows aus.
   - **Linux/BSD:** `notify-rust =4.19.0` (MIT OR Apache-2.0, crates.io 2026-11-08) mit Feature `z` (zbus 6, reines Rust, ohne libdbus). Liefert Notify, CloseNotification, Aktionen und `replaces_id`. Beleg: crates.io-Abhängigkeiten 4.19.0.
   - **Flatpak/Sandbox:** `ashpd` Feature `notification` (Portal `AddNotification`, `RemoveNotification`, `ActionInvoked`). Belegt: crates.io 0.14.3, Feature-Liste. Gewählt wird die Version, die schon im Lock ist (`ashpd =0.14.0`, wie `fs-components-filepicker`, ADR 0100 Offen 1); keine zweite Version.
   - **Windows:** ebenfalls `notify-rust`. Es zieht unter `cfg(target_os="windows")` `tauri-winrt-notification ^0.8` (0.8.1, 2026-07-17, MIT OR Apache-2.0) mit; kein eigenes Crate nötig. Die API ist belegt: `title`, `text1`, `icon`, `sound`, `scenario`, `add_button`, `on_activated`, `on_dismissed`, `show`. **Wichtig:** Ein nicht verpacktes Programm braucht eine **AppUserModelID**, und die setzt eine Startmenü-Verknüpfung voraus. Das ist Sache des MSI (ADR 0069 Nachtrag 23.11.: Windows per MSI). Ohne sie gibt es nur `Toast::POWERSHELL_APP_ID`; dann erscheint als Absender „Windows PowerShell“. Das ist nur für den CI-Beweis ehrlich verwendbar (Frage 3). Die älteren Alternativen `winrt-notification` 0.5.1 (Stand 2022) und `win-toast-notify` 0.1.6 werden nicht genommen.
   - **macOS:** kommt über `notify-rust` mit (`mac-notification-sys`), ist aber jetzt kein Ziel.
   - **Android:** kein eigenständiges Rust-Crate. `tauri-plugin-notifications` 0.4.6 hängt an Tauri und passt nicht. Weg: kleiner eigener Adapter über `jni` 0.22.4 und `ndk-context` auf `NotificationManager` (Kanal-ID Pflicht ab API 26, `POST_NOTIFICATIONS` ab API 33). Erst sinnvoll, wenn ein Blinc-Android-Bau läuft. Blinc `android.rs` hat keine Meldungen (geprüft). **Später, nicht im ersten Bild.**

6. **Blinc `notify.rs` wird nicht benutzt.** Es fehlen id, Ersetzen, Aktionen und Schließgrund; außerdem gehört das Systemmeldungs-Thema nicht in die GUI-Engine, denn `fs-notification` muss auch ohne Fenster laufen (Server, Updater). Kooperation nach Blinc-Regeln: ein kleiner PR, der `icon` wirklich setzt (PRs zuerst, kurz, kein KI-Vermerk, git-bug-Trailer). Optional, blockiert nichts.

7. **Verlauf über activities (AS2), nicht als eigene Liste.** Jede Meldung wird beim Schließen als AS2-Aktivität an `fs-activities` gegeben, mit Zusammenfassung ohne Inhalt (README von fs-activities: „keeps a summary, never the content“). Gemeldet wird `Create` + `Note`. Gefragt wird mit AS2 `Question` (`oneOf`/`anyOf`, `closed`); die Antwort ist `Update`/`Note` mit `inReplyTo`. Der Schließgrund landet im Erweiterungsfeld `fs:closeReason`. `fs-notification` führt **keine** eigene Verlaufsliste. Voraussetzung: der Kern von fs-activities ist noch nicht ans Fenster angeschlossen (README v0.0.2). Bis dahin gibt es keine Liste und keinen Verlauf; das wird sichtbar gesagt.

8. **Sicherheit des Aktions-Rückwegs.** Aktionen aus dem Betriebssystem (`ActionInvoked`, `on_activated`) sind ein Eingang von außen. Es zählen nur ids, die das Modul selbst vergeben hat. Unbekannte ids werden verworfen und protokolliert, nie als Befehl ausgeführt. Geheimnisse und Personendaten kommen nie in `system` (die Anzeige auf dem Sperrbildschirm ist dort nicht steuerbar); Parameter werden geschwärzt (wie ADR 0069 E2). Für den Aktions-Rückweg gilt deshalb das Gate „Sicherheitsmodul“: voller Test und Opus-Review im Bündel.

### 2. Nachtrag zu ADR 0069 E5 und ADR 0094 sowie Richtigstellung ADR 0097
Stehen in den Nachträgen der jeweiligen ADRs (dort als Nachtrag 23.11.2026 eingetragen). Dieser ADR legt nur das Modul fest.

## Verhältnis zu bestehenden ADRs
- **ADR 0065 §4/§5:** unverändert; Meldung gehört zum Anlass, Fehler bleibt bis zum Schließen oder bis zur Behebung, Observer mit Lebensdauer. Die Umsetzung ist dieses Modul.
- **ADR 0069 Z. 137 (E5):** die Update-Frage ist `notification.ask` (Nachtrag zu 0069). Der Schutzzweck „nie ein Dialog über Eingaben“ bleibt erhalten.
- **ADR 0097:** fs-starter steht im eigenen Repo; siehe Nachtrag zu 0097.

## Folgen
- Neue Crates: `fs-notification` (Kern, in fs-components, Schicht 1 wie fs-settings) und `fs-notification-system` (Adapter, Sicherheitsmodul).
- Auftragsfolge (ENTSCHEID-schnitt E5): A1 Kern, A2 Adapter, A3 Formen, A4 Host, A5 Bild (Linux und Windows), A7 Verlauf, A8 Umstellung der Programme, A10 Android später.
- `fs-starter::Tell` wird Adapter; die Statuszeile zeigt nur Zustand.

## Offen
1. Windows: die AppUserModelID braucht das MSI; bis dahin nur der CI-Beweis über PowerShell (Frage 3).
2. Verlauf (Punkt 7): erst, wenn der Kern von fs-activities angeschlossen ist.
3. Android (Punkt 5): erst nach einem Blinc-Android-Bau.
4. Blinc-PR für `icon` (Punkt 6): optional.
5. Die Form-Regel (Punkt 4) ist als Einstellung `fs.notification.*` angelegt; ihre Werte und Schwellen sind in ENTSCHEID-schnitt nicht festgelegt und müssen im Kern (A1) entschieden werden.
