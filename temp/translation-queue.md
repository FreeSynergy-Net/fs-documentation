# Übersetzungsliste – der Übersetzungs-Checker für den ganzen Baum

Stand: 2026-11-16 04:41 UTC · 2521 Dateien verfolgt · 1882 offen · 483 bestätigt

Erzeugt von `python3 scripts/doc_sync.py --en docs/en --de docs/de \`
    `--state temp/sync_state.json --list temp/translation-queue.md`

Wahrheit ist `temp/sync_state.json`. Diese Liste ist seine Ansicht; sie darf
per Hand oder vom Agenten annotiert werden (`· Notiz: …`) – Anmerkungen und das
Changelog bleiben beim Neu-Erzeugen erhalten. Abhaken heißt: Datei ist übersetzt
und geprüft. Das Abhaken allein ist nichts wert – erst `--confirm <pfad>` setzt den
Eintrag im Zustand auf `VERIFIED`; beim nächsten Lauf verschwindet die Zeile.

| Befund | Heißt | Zu tun |
|--------|-------|--------|
| `needs_en` | Datei fehlt in `en/` | aus `de/` übersetzen, dann `--confirm` |
| `needs_de` | Datei fehlt in `de/` | aus `en/` rückübersetzen, dann `--confirm` |
| `copy` | `en/` == `de/` (Byte für Byte) | übersetzen, dann `--confirm` |
| `en_german` | `en/` hat deutschen Rest | Rest übersetzen, dann `--confirm` |
| `code_german` | deutscher Text im Codebeispiel | Beschriftungen im Beispiel englisch machen |
| `de_english` | `de/` hat englischen Rest | Rest rückübersetzen, dann `--confirm` |
| `parity` | Überschriften/Tabellen/Links ungleich | Form angleichen, dann `--confirm` |
| `rename` | Dateiname ist deutsch (ADR 0002) | umbenennen + Links nachziehen |
| `review` | kein Befund | lesen, dann `--confirm` |

Nie über Sprachbäume hinweg verlinken (CONVENTIONS §9): Links aus `en/` zeigen
nach `en/`, Links aus `de/` nach `de/`. Dateinamen bleiben englisch (ADR 0002).

**Reihenfolge:** A–G (inkl. D2) sind die eigentliche Arbeit, H ist nur Bestätigungs-Backlog.
`Plan[x]`/`Plan[~]` kommt aus `temp/apps-plan.md`: `[x]` = an Primärquellen verifiziert
(Übersetzung also sicher), `[~]` = vorhanden ohne Beleg. Eine Datei kann in mehreren
Abschnitten stehen (z. B. `needs_en` + `rename`); die Abschnittszahlen zählen deshalb
öfter als die Gesamtzahl offener Dateien.

## Offene Posten

| Abschnitt | Dateien |
|-----------|---------|
| A. `en/` fehlt – aus `de/` übersetzen | 6 |
| B. `de/` fehlt – englische Quelle nachziehen | 340 |
| C. `en/` ist eine Kopie von `de/` – unübersetzt | 0 |
| D. `en/` enthält noch deutschen Text – Rest übersetzen | 29 |
| D2. Deutscher Text in Codebeispielen/Boxen (ADR 0002: Code ist englisch) | 4 |
| E. `de/` enthält noch englischen Text – Rest rückübersetzen | 183 |
| F. Form nicht gleich – Struktur abgleichen | 219 |
| G. Deutscher Dateiname – Pfad englisch machen (ADR 0002) | 0 |
| H. Beide Seiten da, kein Befund – lesen und bestätigen | 1207 |
| 🗑️ gelöscht (tombstone) | 156 |

## A. `en/` fehlt – aus `de/` übersetzen – 6 Dateien

### `programs/suites/projectmanagement/frontends/jira/latest/` · 6

- [ ] `programs/suites/projectmanagement/frontends/jira/latest/api.md` · 2.5k
- [ ] `programs/suites/projectmanagement/frontends/jira/latest/description.md` · 1.3k
- [ ] `programs/suites/projectmanagement/frontends/jira/latest/features.md` · 1.5k
- [ ] `programs/suites/projectmanagement/frontends/jira/latest/layout.md` · 2.3k
- [ ] `programs/suites/projectmanagement/frontends/jira/latest/menus.md` · 1.3k
- [ ] `programs/suites/projectmanagement/frontends/jira/latest/shortcuts.md` · 1.1k

## B. `de/` fehlt – englische Quelle nachziehen – 340 Dateien

### `components/styles/` · 3

- [ ] `components/styles/apple.md` · 8.8k
- [ ] `components/styles/fiori.md` · 6.3k
- [ ] `components/styles/windows.md` · 12.6k

### `programs/apps/files/frontends/files-community/` · 1

- [ ] `programs/apps/files/frontends/files-community/index.md` · 3.3k

### `programs/apps/files/frontends/files-community/latest/` · 11

- [ ] `programs/apps/files/frontends/files-community/latest/acceptance.md` · 2.0k
- [ ] `programs/apps/files/frontends/files-community/latest/api.md` · 649b
- [ ] `programs/apps/files/frontends/files-community/latest/description.md` · 1.3k
- [ ] `programs/apps/files/frontends/files-community/latest/dialogs.md` · 2.3k
- [ ] `programs/apps/files/frontends/files-community/latest/features.md` · 2.6k
- [ ] `programs/apps/files/frontends/files-community/latest/gaps.md` · 2.5k
- [ ] `programs/apps/files/frontends/files-community/latest/layout.md` · 1.2k
- [ ] `programs/apps/files/frontends/files-community/latest/menus.md` · 4.4k · auch: en_german
- [ ] `programs/apps/files/frontends/files-community/latest/shortcuts.md` · 3.5k
- [ ] `programs/apps/files/frontends/files-community/latest/states.md` · 2.3k
- [ ] `programs/apps/files/frontends/files-community/latest/workflows.md` · 4.5k

### `programs/apps/files/frontends/files-community/latest/themes/` · 1

- [ ] `programs/apps/files/frontends/files-community/latest/themes/index.md` · 371b

### `programs/apps/files/frontends/total-commander/` · 1

- [ ] `programs/apps/files/frontends/total-commander/index.md` · 3.6k

### `programs/apps/files/frontends/total-commander/latest/` · 11

- [ ] `programs/apps/files/frontends/total-commander/latest/acceptance.md` · 1.8k
- [ ] `programs/apps/files/frontends/total-commander/latest/api.md` · 783b
- [ ] `programs/apps/files/frontends/total-commander/latest/description.md` · 1.4k
- [ ] `programs/apps/files/frontends/total-commander/latest/dialogs.md` · 8.1k
- [ ] `programs/apps/files/frontends/total-commander/latest/features.md` · 4.5k
- [ ] `programs/apps/files/frontends/total-commander/latest/gaps.md` · 2.2k
- [ ] `programs/apps/files/frontends/total-commander/latest/layout.md` · 1.1k
- [ ] `programs/apps/files/frontends/total-commander/latest/menus.md` · 8.2k · auch: en_german
- [ ] `programs/apps/files/frontends/total-commander/latest/shortcuts.md` · 8.1k
- [ ] `programs/apps/files/frontends/total-commander/latest/states.md` · 4.4k
- [ ] `programs/apps/files/frontends/total-commander/latest/workflows.md` · 12.2k

### `programs/apps/files/frontends/total-commander/latest/themes/` · 1

- [ ] `programs/apps/files/frontends/total-commander/latest/themes/index.md` · 321b

### `programs/apps/files/frontends/windows-explorer/latest/` · 11

- [ ] `programs/apps/files/frontends/windows-explorer/latest/acceptance.md` · 2.5k
- [ ] `programs/apps/files/frontends/windows-explorer/latest/api.md` · 604b
- [ ] `programs/apps/files/frontends/windows-explorer/latest/description.md` · 1.8k
- [ ] `programs/apps/files/frontends/windows-explorer/latest/dialogs.md` · 3.3k
- [ ] `programs/apps/files/frontends/windows-explorer/latest/features.md` · 2.3k
- [ ] `programs/apps/files/frontends/windows-explorer/latest/gaps.md` · 2.9k
- [ ] `programs/apps/files/frontends/windows-explorer/latest/layout.md` · 1.2k
- [ ] `programs/apps/files/frontends/windows-explorer/latest/menus.md` · 3.6k · auch: en_german
- [ ] `programs/apps/files/frontends/windows-explorer/latest/shortcuts.md` · 2.6k
- [ ] `programs/apps/files/frontends/windows-explorer/latest/states.md` · 2.3k
- [ ] `programs/apps/files/frontends/windows-explorer/latest/workflows.md` · 5.7k

### `programs/apps/files/frontends/windows-explorer/latest/themes/` · 1

- [ ] `programs/apps/files/frontends/windows-explorer/latest/themes/index.md` · 421b

### `programs/apps/history/` · 1

- [ ] `programs/apps/history/requirements.md` · 2.6k

### `programs/apps/history/frontends/` · 1

- [ ] `programs/apps/history/frontends/index.md` · 3.0k

### `programs/apps/history/frontends/activitywatch/` · 1

- [ ] `programs/apps/history/frontends/activitywatch/index.md` · 2.4k

### `programs/apps/history/frontends/activitywatch/latest/` · 6

- [ ] `programs/apps/history/frontends/activitywatch/latest/api.md` · 1.0k
- [ ] `programs/apps/history/frontends/activitywatch/latest/description.md` · 1020b
- [ ] `programs/apps/history/frontends/activitywatch/latest/features.md` · 509b
- [ ] `programs/apps/history/frontends/activitywatch/latest/layout.md` · 232b
- [ ] `programs/apps/history/frontends/activitywatch/latest/menus.md` · 228b
- [ ] `programs/apps/history/frontends/activitywatch/latest/shortcuts.md` · 99b

### `programs/apps/history/frontends/day-one/` · 1

- [ ] `programs/apps/history/frontends/day-one/index.md` · 2.3k

### `programs/apps/history/frontends/day-one/latest/` · 6

- [ ] `programs/apps/history/frontends/day-one/latest/api.md` · 330b
- [ ] `programs/apps/history/frontends/day-one/latest/description.md` · 1.2k
- [ ] `programs/apps/history/frontends/day-one/latest/features.md` · 660b
- [ ] `programs/apps/history/frontends/day-one/latest/layout.md` · 320b
- [ ] `programs/apps/history/frontends/day-one/latest/menus.md` · 423b
- [ ] `programs/apps/history/frontends/day-one/latest/shortcuts.md` · 176b

### `programs/apps/history/frontends/exist-io/` · 1

- [ ] `programs/apps/history/frontends/exist-io/index.md` · 2.2k

### `programs/apps/history/frontends/exist-io/latest/` · 6

- [ ] `programs/apps/history/frontends/exist-io/latest/api.md` · 523b
- [ ] `programs/apps/history/frontends/exist-io/latest/description.md` · 1.1k
- [ ] `programs/apps/history/frontends/exist-io/latest/features.md` · 437b
- [ ] `programs/apps/history/frontends/exist-io/latest/layout.md` · 200b
- [ ] `programs/apps/history/frontends/exist-io/latest/menus.md` · 236b
- [ ] `programs/apps/history/frontends/exist-io/latest/shortcuts.md` · 93b

### `programs/apps/messenger/frontends/delta-chat/` · 1

- [ ] `programs/apps/messenger/frontends/delta-chat/index.md` · 2.4k

### `programs/apps/messenger/frontends/delta-chat/latest/` · 6

- [ ] `programs/apps/messenger/frontends/delta-chat/latest/api.md` · 180b
- [ ] `programs/apps/messenger/frontends/delta-chat/latest/description.md` · 877b
- [ ] `programs/apps/messenger/frontends/delta-chat/latest/features.md` · 915b
- [ ] `programs/apps/messenger/frontends/delta-chat/latest/layout.md` · 147b
- [ ] `programs/apps/messenger/frontends/delta-chat/latest/menus.md` · 139b
- [ ] `programs/apps/messenger/frontends/delta-chat/latest/shortcuts.md` · 51b

### `programs/apps/messenger/frontends/fastmail/` · 1

- [ ] `programs/apps/messenger/frontends/fastmail/index.md` · 2.3k

### `programs/apps/messenger/frontends/fastmail/latest/` · 6

- [ ] `programs/apps/messenger/frontends/fastmail/latest/api.md` · 201b
- [ ] `programs/apps/messenger/frontends/fastmail/latest/description.md` · 739b
- [ ] `programs/apps/messenger/frontends/fastmail/latest/features.md` · 458b
- [ ] `programs/apps/messenger/frontends/fastmail/latest/layout.md` · 145b
- [ ] `programs/apps/messenger/frontends/fastmail/latest/menus.md` · 47b
- [ ] `programs/apps/messenger/frontends/fastmail/latest/shortcuts.md` · 49b

### `programs/apps/messenger/frontends/hey/` · 1

- [ ] `programs/apps/messenger/frontends/hey/index.md` · 2.4k

### `programs/apps/messenger/frontends/hey/latest/` · 6

- [ ] `programs/apps/messenger/frontends/hey/latest/api.md` · 181b
- [ ] `programs/apps/messenger/frontends/hey/latest/description.md` · 799b
- [ ] `programs/apps/messenger/frontends/hey/latest/features.md` · 932b
- [ ] `programs/apps/messenger/frontends/hey/latest/layout.md` · 140b
- [ ] `programs/apps/messenger/frontends/hey/latest/menus.md` · 184b
- [ ] `programs/apps/messenger/frontends/hey/latest/shortcuts.md` · 113b

### `programs/apps/messenger/frontends/signal/` · 1

- [ ] `programs/apps/messenger/frontends/signal/index.md` · 2.4k

### `programs/apps/messenger/frontends/signal/latest/` · 6

- [ ] `programs/apps/messenger/frontends/signal/latest/api.md` · 150b
- [ ] `programs/apps/messenger/frontends/signal/latest/description.md` · 738b
- [ ] `programs/apps/messenger/frontends/signal/latest/features.md` · 391b
- [ ] `programs/apps/messenger/frontends/signal/latest/layout.md` · 143b
- [ ] `programs/apps/messenger/frontends/signal/latest/menus.md` · 45b
- [ ] `programs/apps/messenger/frontends/signal/latest/shortcuts.md` · 47b

### `programs/apps/messenger/frontends/spark/` · 1

- [ ] `programs/apps/messenger/frontends/spark/index.md` · 2.0k

### `programs/apps/messenger/frontends/spark/latest/` · 6

- [ ] `programs/apps/messenger/frontends/spark/latest/api.md` · 42b
- [ ] `programs/apps/messenger/frontends/spark/latest/description.md` · 648b
- [ ] `programs/apps/messenger/frontends/spark/latest/features.md` · 495b
- [ ] `programs/apps/messenger/frontends/spark/latest/layout.md` · 142b
- [ ] `programs/apps/messenger/frontends/spark/latest/menus.md` · 84b
- [ ] `programs/apps/messenger/frontends/spark/latest/shortcuts.md` · 46b

### `programs/apps/messenger/frontends/superhuman/` · 1

- [ ] `programs/apps/messenger/frontends/superhuman/index.md` · 2.9k

### `programs/apps/messenger/frontends/superhuman/latest/` · 6

- [ ] `programs/apps/messenger/frontends/superhuman/latest/api.md` · 165b
- [ ] `programs/apps/messenger/frontends/superhuman/latest/description.md` · 716b
- [ ] `programs/apps/messenger/frontends/superhuman/latest/features.md` · 639b
- [ ] `programs/apps/messenger/frontends/superhuman/latest/layout.md` · 152b
- [ ] `programs/apps/messenger/frontends/superhuman/latest/menus.md` · 205b
- [ ] `programs/apps/messenger/frontends/superhuman/latest/shortcuts.md` · 286b

### `programs/apps/messenger/frontends/zulip/` · 1

- [ ] `programs/apps/messenger/frontends/zulip/index.md` · 2.4k

### `programs/apps/messenger/frontends/zulip/latest/` · 6

- [ ] `programs/apps/messenger/frontends/zulip/latest/api.md` · 198b
- [ ] `programs/apps/messenger/frontends/zulip/latest/description.md` · 751b
- [ ] `programs/apps/messenger/frontends/zulip/latest/features.md` · 528b
- [ ] `programs/apps/messenger/frontends/zulip/latest/layout.md` · 142b
- [ ] `programs/apps/messenger/frontends/zulip/latest/menus.md` · 101b
- [ ] `programs/apps/messenger/frontends/zulip/latest/shortcuts.md` · 196b

### `programs/apps/resources/` · 1

- [ ] `programs/apps/resources/requirements.md` · 979b

### `programs/apps/resources/frontends/` · 1

- [ ] `programs/apps/resources/frontends/index.md` · 3.1k

### `programs/apps/resources/frontends/erpnext/` · 1

- [ ] `programs/apps/resources/frontends/erpnext/index.md` · 1.9k

### `programs/apps/resources/frontends/erpnext/latest/` · 6

- [ ] `programs/apps/resources/frontends/erpnext/latest/api.md` · 690b
- [ ] `programs/apps/resources/frontends/erpnext/latest/description.md` · 883b
- [ ] `programs/apps/resources/frontends/erpnext/latest/features.md` · 501b
- [ ] `programs/apps/resources/frontends/erpnext/latest/layout.md` · 227b
- [ ] `programs/apps/resources/frontends/erpnext/latest/menus.md` · 137b
- [ ] `programs/apps/resources/frontends/erpnext/latest/shortcuts.md` · 84b

### `programs/apps/resources/frontends/grocy/` · 1

- [ ] `programs/apps/resources/frontends/grocy/index.md` · 1.8k

### `programs/apps/resources/frontends/grocy/latest/` · 6

- [ ] `programs/apps/resources/frontends/grocy/latest/api.md` · 273b
- [ ] `programs/apps/resources/frontends/grocy/latest/description.md` · 845b
- [ ] `programs/apps/resources/frontends/grocy/latest/features.md` · 659b
- [ ] `programs/apps/resources/frontends/grocy/latest/layout.md` · 135b
- [ ] `programs/apps/resources/frontends/grocy/latest/menus.md` · 195b
- [ ] `programs/apps/resources/frontends/grocy/latest/shortcuts.md` · 66b

### `programs/apps/resources/frontends/odoo/` · 1

- [ ] `programs/apps/resources/frontends/odoo/index.md` · 2.1k

### `programs/apps/resources/frontends/odoo/latest/` · 6

- [ ] `programs/apps/resources/frontends/odoo/latest/api.md` · 205b
- [ ] `programs/apps/resources/frontends/odoo/latest/description.md` · 663b
- [ ] `programs/apps/resources/frontends/odoo/latest/features.md` · 386b
- [ ] `programs/apps/resources/frontends/odoo/latest/layout.md` · 119b
- [ ] `programs/apps/resources/frontends/odoo/latest/menus.md` · 52b
- [ ] `programs/apps/resources/frontends/odoo/latest/shortcuts.md` · 65b

### `programs/apps/resources/frontends/snipe-it/` · 1

- [ ] `programs/apps/resources/frontends/snipe-it/index.md` · 2.0k

### `programs/apps/resources/frontends/snipe-it/latest/` · 6

- [ ] `programs/apps/resources/frontends/snipe-it/latest/api.md` · 146b
- [ ] `programs/apps/resources/frontends/snipe-it/latest/description.md` · 651b
- [ ] `programs/apps/resources/frontends/snipe-it/latest/features.md` · 484b
- [ ] `programs/apps/resources/frontends/snipe-it/latest/layout.md` · 134b
- [ ] `programs/apps/resources/frontends/snipe-it/latest/menus.md` · 129b
- [ ] `programs/apps/resources/frontends/snipe-it/latest/shortcuts.md` · 69b

### `programs/apps/store/` · 2

- [ ] `programs/apps/store/index.md` · 1.3k
- [ ] `programs/apps/store/requirements.md` · 1.3k

### `programs/apps/store/frontends/` · 1

- [ ] `programs/apps/store/frontends/index.md` · 3.3k

### `programs/apps/store/frontends/f-droid/` · 1

- [ ] `programs/apps/store/frontends/f-droid/index.md` · 2.0k

### `programs/apps/store/frontends/f-droid/latest/` · 6

- [ ] `programs/apps/store/frontends/f-droid/latest/api.md` · 436b
- [ ] `programs/apps/store/frontends/f-droid/latest/description.md` · 754b
- [ ] `programs/apps/store/frontends/f-droid/latest/features.md` · 1018b
- [ ] `programs/apps/store/frontends/f-droid/latest/layout.md` · 329b
- [ ] `programs/apps/store/frontends/f-droid/latest/menus.md` · 98b
- [ ] `programs/apps/store/frontends/f-droid/latest/shortcuts.md` · 123b

### `programs/apps/store/frontends/flathub/` · 1

- [ ] `programs/apps/store/frontends/flathub/index.md` · 1.9k

### `programs/apps/store/frontends/flathub/latest/` · 6

- [ ] `programs/apps/store/frontends/flathub/latest/api.md` · 357b
- [ ] `programs/apps/store/frontends/flathub/latest/description.md` · 826b
- [ ] `programs/apps/store/frontends/flathub/latest/features.md` · 754b
- [ ] `programs/apps/store/frontends/flathub/latest/layout.md` · 171b
- [ ] `programs/apps/store/frontends/flathub/latest/menus.md` · 111b
- [ ] `programs/apps/store/frontends/flathub/latest/shortcuts.md` · 127b

### `programs/apps/store/frontends/kde-discover/` · 1

- [ ] `programs/apps/store/frontends/kde-discover/index.md` · 3.8k

### `programs/apps/store/frontends/kde-discover/latest/` · 11

- [ ] `programs/apps/store/frontends/kde-discover/latest/acceptance.md` · 1.1k
- [ ] `programs/apps/store/frontends/kde-discover/latest/api.md` · 534b
- [ ] `programs/apps/store/frontends/kde-discover/latest/description.md` · 1.4k
- [ ] `programs/apps/store/frontends/kde-discover/latest/dialogs.md` · 1.2k
- [ ] `programs/apps/store/frontends/kde-discover/latest/features.md` · 1.6k
- [ ] `programs/apps/store/frontends/kde-discover/latest/gaps.md` · 1.8k
- [ ] `programs/apps/store/frontends/kde-discover/latest/layout.md` · 917b
- [ ] `programs/apps/store/frontends/kde-discover/latest/menus.md` · 1.9k · auch: en_german
- [ ] `programs/apps/store/frontends/kde-discover/latest/shortcuts.md` · 1.3k
- [ ] `programs/apps/store/frontends/kde-discover/latest/states.md` · 1.1k
- [ ] `programs/apps/store/frontends/kde-discover/latest/workflows.md` · 2.3k

### `programs/apps/store/frontends/kde-discover/latest/themes/` · 1

- [ ] `programs/apps/store/frontends/kde-discover/latest/themes/index.md` · 330b

### `programs/apps/store/frontends/obtainium/` · 1

- [ ] `programs/apps/store/frontends/obtainium/index.md` · 2.0k

### `programs/apps/store/frontends/obtainium/latest/` · 6

- [ ] `programs/apps/store/frontends/obtainium/latest/api.md` · 415b
- [ ] `programs/apps/store/frontends/obtainium/latest/description.md` · 658b
- [ ] `programs/apps/store/frontends/obtainium/latest/features.md` · 900b
- [ ] `programs/apps/store/frontends/obtainium/latest/layout.md` · 290b
- [ ] `programs/apps/store/frontends/obtainium/latest/menus.md` · 105b
- [ ] `programs/apps/store/frontends/obtainium/latest/shortcuts.md` · 102b

### `programs/apps/streaming/frontends/ecamm-live/` · 1

- [ ] `programs/apps/streaming/frontends/ecamm-live/index.md` · 2.2k

### `programs/apps/streaming/frontends/ecamm-live/latest/` · 6

- [ ] `programs/apps/streaming/frontends/ecamm-live/latest/api.md` · 152b
- [ ] `programs/apps/streaming/frontends/ecamm-live/latest/description.md` · 709b
- [ ] `programs/apps/streaming/frontends/ecamm-live/latest/features.md` · 516b
- [ ] `programs/apps/streaming/frontends/ecamm-live/latest/layout.md` · 61b
- [ ] `programs/apps/streaming/frontends/ecamm-live/latest/menus.md` · 119b
- [ ] `programs/apps/streaming/frontends/ecamm-live/latest/shortcuts.md` · 55b

### `programs/apps/streaming/frontends/owncast/` · 1

- [ ] `programs/apps/streaming/frontends/owncast/index.md` · 2.4k

### `programs/apps/streaming/frontends/owncast/latest/` · 6

- [ ] `programs/apps/streaming/frontends/owncast/latest/api.md` · 464b
- [ ] `programs/apps/streaming/frontends/owncast/latest/description.md` · 827b
- [ ] `programs/apps/streaming/frontends/owncast/latest/features.md` · 815b
- [ ] `programs/apps/streaming/frontends/owncast/latest/layout.md` · 205b
- [ ] `programs/apps/streaming/frontends/owncast/latest/menus.md` · 241b
- [ ] `programs/apps/streaming/frontends/owncast/latest/shortcuts.md` · 73b

### `programs/apps/streaming/frontends/peertube/` · 1

- [ ] `programs/apps/streaming/frontends/peertube/index.md` · 2.1k

### `programs/apps/streaming/frontends/peertube/latest/` · 6

- [ ] `programs/apps/streaming/frontends/peertube/latest/api.md` · 273b
- [ ] `programs/apps/streaming/frontends/peertube/latest/description.md` · 817b
- [ ] `programs/apps/streaming/frontends/peertube/latest/features.md` · 804b
- [ ] `programs/apps/streaming/frontends/peertube/latest/layout.md` · 161b
- [ ] `programs/apps/streaming/frontends/peertube/latest/menus.md` · 141b
- [ ] `programs/apps/streaming/frontends/peertube/latest/shortcuts.md` · 53b

### `programs/apps/streaming/frontends/streamyard/` · 1

- [ ] `programs/apps/streaming/frontends/streamyard/index.md` · 2.4k

### `programs/apps/streaming/frontends/streamyard/latest/` · 6

- [ ] `programs/apps/streaming/frontends/streamyard/latest/api.md` · 107b
- [ ] `programs/apps/streaming/frontends/streamyard/latest/description.md` · 740b
- [ ] `programs/apps/streaming/frontends/streamyard/latest/features.md` · 757b
- [ ] `programs/apps/streaming/frontends/streamyard/latest/layout.md` · 157b
- [ ] `programs/apps/streaming/frontends/streamyard/latest/menus.md` · 60b
- [ ] `programs/apps/streaming/frontends/streamyard/latest/shortcuts.md` · 55b

### `programs/apps/streaming/frontends/youtube-studio/` · 1

- [ ] `programs/apps/streaming/frontends/youtube-studio/index.md` · 2.2k

### `programs/apps/streaming/frontends/youtube-studio/latest/` · 6

- [ ] `programs/apps/streaming/frontends/youtube-studio/latest/api.md` · 171b
- [ ] `programs/apps/streaming/frontends/youtube-studio/latest/description.md` · 771b
- [ ] `programs/apps/streaming/frontends/youtube-studio/latest/features.md` · 744b
- [ ] `programs/apps/streaming/frontends/youtube-studio/latest/layout.md` · 273b
- [ ] `programs/apps/streaming/frontends/youtube-studio/latest/menus.md` · 231b
- [ ] `programs/apps/streaming/frontends/youtube-studio/latest/shortcuts.md` · 81b

### `programs/apps/surveys/frontends/` · 1

- [ ] `programs/apps/surveys/frontends/index.md` · 3.4k

### `programs/apps/surveys/frontends/consul/` · 1

- [ ] `programs/apps/surveys/frontends/consul/index.md` · 1.7k

### `programs/apps/surveys/frontends/consul/latest/` · 6

- [ ] `programs/apps/surveys/frontends/consul/latest/api.md` · 99b
- [ ] `programs/apps/surveys/frontends/consul/latest/description.md` · 527b
- [ ] `programs/apps/surveys/frontends/consul/latest/features.md` · 247b
- [ ] `programs/apps/surveys/frontends/consul/latest/layout.md` · 65b
- [ ] `programs/apps/surveys/frontends/consul/latest/menus.md` · 64b
- [ ] `programs/apps/surveys/frontends/consul/latest/shortcuts.md` · 77b

### `programs/apps/surveys/frontends/decidim/` · 1

- [ ] `programs/apps/surveys/frontends/decidim/index.md` · 1.8k

### `programs/apps/surveys/frontends/decidim/latest/` · 6

- [ ] `programs/apps/surveys/frontends/decidim/latest/api.md` · 300b
- [ ] `programs/apps/surveys/frontends/decidim/latest/description.md` · 749b
- [ ] `programs/apps/surveys/frontends/decidim/latest/features.md` · 303b
- [ ] `programs/apps/surveys/frontends/decidim/latest/layout.md` · 56b
- [ ] `programs/apps/surveys/frontends/decidim/latest/menus.md` · 55b
- [ ] `programs/apps/surveys/frontends/decidim/latest/shortcuts.md` · 68b

### `programs/apps/surveys/frontends/liquidfeedback/` · 1

- [ ] `programs/apps/surveys/frontends/liquidfeedback/index.md` · 2.1k

### `programs/apps/surveys/frontends/liquidfeedback/latest/` · 6

- [ ] `programs/apps/surveys/frontends/liquidfeedback/latest/api.md` · 146b
- [ ] `programs/apps/surveys/frontends/liquidfeedback/latest/description.md` · 838b
- [ ] `programs/apps/surveys/frontends/liquidfeedback/latest/features.md` · 272b
- [ ] `programs/apps/surveys/frontends/liquidfeedback/latest/layout.md` · 63b
- [ ] `programs/apps/surveys/frontends/liquidfeedback/latest/menus.md` · 62b
- [ ] `programs/apps/surveys/frontends/liquidfeedback/latest/shortcuts.md` · 75b

### `programs/apps/surveys/frontends/loomio/` · 1

- [ ] `programs/apps/surveys/frontends/loomio/index.md` · 1.8k

### `programs/apps/surveys/frontends/loomio/latest/` · 6

- [ ] `programs/apps/surveys/frontends/loomio/latest/api.md` · 78b
- [ ] `programs/apps/surveys/frontends/loomio/latest/description.md` · 706b
- [ ] `programs/apps/surveys/frontends/loomio/latest/features.md` · 183b
- [ ] `programs/apps/surveys/frontends/loomio/latest/layout.md` · 55b
- [ ] `programs/apps/surveys/frontends/loomio/latest/menus.md` · 54b
- [ ] `programs/apps/surveys/frontends/loomio/latest/shortcuts.md` · 67b

### `programs/apps/surveys/frontends/polis/` · 1

- [ ] `programs/apps/surveys/frontends/polis/index.md` · 1.7k

### `programs/apps/surveys/frontends/polis/latest/` · 6

- [ ] `programs/apps/surveys/frontends/polis/latest/api.md` · 84b
- [ ] `programs/apps/surveys/frontends/polis/latest/description.md` · 726b
- [ ] `programs/apps/surveys/frontends/polis/latest/features.md` · 230b
- [ ] `programs/apps/surveys/frontends/polis/latest/layout.md` · 54b
- [ ] `programs/apps/surveys/frontends/polis/latest/menus.md` · 53b
- [ ] `programs/apps/surveys/frontends/polis/latest/shortcuts.md` · 66b

### `programs/apps/tasks/frontends/` · 1

- [ ] `programs/apps/tasks/frontends/index.md` · 3.6k

### `programs/apps/tasks/frontends/jira/` · 1

- [ ] `programs/apps/tasks/frontends/jira/index.md` · 2.9k

### `programs/apps/tasks/frontends/jira/latest/` · 10

- [ ] `programs/apps/tasks/frontends/jira/latest/acceptance.md` · 1.2k
- [ ] `programs/apps/tasks/frontends/jira/latest/api.md` · 2.5k
- [ ] `programs/apps/tasks/frontends/jira/latest/description.md` · 1.3k
- [ ] `programs/apps/tasks/frontends/jira/latest/dialogs.md` · 4.1k
- [ ] `programs/apps/tasks/frontends/jira/latest/features.md` · 1.5k
- [ ] `programs/apps/tasks/frontends/jira/latest/gaps.md` · 1.3k
- [ ] `programs/apps/tasks/frontends/jira/latest/layout.md` · 2.4k
- [ ] `programs/apps/tasks/frontends/jira/latest/menus.md` · 4.7k · auch: en_german
- [ ] `programs/apps/tasks/frontends/jira/latest/shortcuts.md` · 6.0k
- [ ] `programs/apps/tasks/frontends/jira/latest/workflows.md` · 5.9k

### `programs/apps/tasks/frontends/linear/` · 1

- [ ] `programs/apps/tasks/frontends/linear/index.md` · 2.2k

### `programs/apps/tasks/frontends/linear/latest/` · 6

- [ ] `programs/apps/tasks/frontends/linear/latest/api.md` · 482b
- [ ] `programs/apps/tasks/frontends/linear/latest/description.md` · 385b
- [ ] `programs/apps/tasks/frontends/linear/latest/features.md` · 599b
- [ ] `programs/apps/tasks/frontends/linear/latest/layout.md` · 126b
- [ ] `programs/apps/tasks/frontends/linear/latest/menus.md` · 73b
- [ ] `programs/apps/tasks/frontends/linear/latest/shortcuts.md` · 202b

### `programs/apps/tasks/frontends/omnifocus/` · 1

- [ ] `programs/apps/tasks/frontends/omnifocus/index.md` · 2.3k

### `programs/apps/tasks/frontends/omnifocus/latest/` · 6

- [ ] `programs/apps/tasks/frontends/omnifocus/latest/api.md` · 188b
- [ ] `programs/apps/tasks/frontends/omnifocus/latest/description.md` · 449b
- [ ] `programs/apps/tasks/frontends/omnifocus/latest/features.md` · 1.1k
- [ ] `programs/apps/tasks/frontends/omnifocus/latest/layout.md` · 148b
- [ ] `programs/apps/tasks/frontends/omnifocus/latest/menus.md` · 123b
- [ ] `programs/apps/tasks/frontends/omnifocus/latest/shortcuts.md` · 103b

### `programs/apps/tasks/frontends/taskwarrior/` · 1

- [ ] `programs/apps/tasks/frontends/taskwarrior/index.md` · 1.8k

### `programs/apps/tasks/frontends/taskwarrior/latest/` · 6

- [ ] `programs/apps/tasks/frontends/taskwarrior/latest/api.md` · 144b
- [ ] `programs/apps/tasks/frontends/taskwarrior/latest/description.md` · 344b
- [ ] `programs/apps/tasks/frontends/taskwarrior/latest/features.md` · 703b
- [ ] `programs/apps/tasks/frontends/taskwarrior/latest/layout.md` · 127b
- [ ] `programs/apps/tasks/frontends/taskwarrior/latest/menus.md` · 83b
- [ ] `programs/apps/tasks/frontends/taskwarrior/latest/shortcuts.md` · 65b

### `programs/apps/tasks/frontends/things-3/` · 1

- [ ] `programs/apps/tasks/frontends/things-3/index.md` · 3.3k

### `programs/apps/tasks/frontends/things-3/latest/` · 10

- [ ] `programs/apps/tasks/frontends/things-3/latest/acceptance.md` · 1.5k
- [ ] `programs/apps/tasks/frontends/things-3/latest/api.md` · 327b
- [ ] `programs/apps/tasks/frontends/things-3/latest/description.md` · 462b
- [ ] `programs/apps/tasks/frontends/things-3/latest/dialogs.md` · 5.3k
- [ ] `programs/apps/tasks/frontends/things-3/latest/features.md` · 912b
- [ ] `programs/apps/tasks/frontends/things-3/latest/gaps.md` · 1.6k
- [ ] `programs/apps/tasks/frontends/things-3/latest/layout.md` · 232b
- [ ] `programs/apps/tasks/frontends/things-3/latest/menus.md` · 6.0k · auch: en_german
- [ ] `programs/apps/tasks/frontends/things-3/latest/shortcuts.md` · 6.6k
- [ ] `programs/apps/tasks/frontends/things-3/latest/workflows.md` · 5.7k

### `programs/apps/tasks/frontends/todoist/` · 1

- [ ] `programs/apps/tasks/frontends/todoist/index.md` · 1.8k

### `programs/apps/tasks/frontends/todoist/latest/` · 6

- [ ] `programs/apps/tasks/frontends/todoist/latest/api.md` · 140b
- [ ] `programs/apps/tasks/frontends/todoist/latest/description.md` · 373b
- [ ] `programs/apps/tasks/frontends/todoist/latest/features.md` · 640b
- [ ] `programs/apps/tasks/frontends/todoist/latest/layout.md` · 145b
- [ ] `programs/apps/tasks/frontends/todoist/latest/menus.md` · 35b
- [ ] `programs/apps/tasks/frontends/todoist/latest/shortcuts.md` · 92b

### `programs/apps/whiteboard/frontends/figjam/` · 1

- [ ] `programs/apps/whiteboard/frontends/figjam/index.md` · 2.6k

### `programs/apps/whiteboard/frontends/figjam/latest/` · 6

- [ ] `programs/apps/whiteboard/frontends/figjam/latest/api.md` · 606b
- [ ] `programs/apps/whiteboard/frontends/figjam/latest/description.md` · 1.0k
- [ ] `programs/apps/whiteboard/frontends/figjam/latest/features.md` · 1.1k
- [ ] `programs/apps/whiteboard/frontends/figjam/latest/layout.md` · 605b
- [ ] `programs/apps/whiteboard/frontends/figjam/latest/menus.md` · 550b
- [ ] `programs/apps/whiteboard/frontends/figjam/latest/shortcuts.md` · 475b

### `programs/apps/wiki/frontends/confluence/latest/` · 5

- [ ] `programs/apps/wiki/frontends/confluence/latest/acceptance.md` · 6.3k
- [ ] `programs/apps/wiki/frontends/confluence/latest/dialogs.md` · 10.0k · auch: en_german
- [ ] `programs/apps/wiki/frontends/confluence/latest/gaps.md` · 7.0k
- [ ] `programs/apps/wiki/frontends/confluence/latest/states.md` · 5.9k
- [ ] `programs/apps/wiki/frontends/confluence/latest/workflows.md` · 16.7k

### `programs/apps/wiki/frontends/logseq/` · 1

- [ ] `programs/apps/wiki/frontends/logseq/index.md` · 2.2k

### `programs/apps/wiki/frontends/logseq/latest/` · 6

- [ ] `programs/apps/wiki/frontends/logseq/latest/api.md` · 127b
- [ ] `programs/apps/wiki/frontends/logseq/latest/description.md` · 377b
- [ ] `programs/apps/wiki/frontends/logseq/latest/features.md` · 876b
- [ ] `programs/apps/wiki/frontends/logseq/latest/layout.md` · 151b
- [ ] `programs/apps/wiki/frontends/logseq/latest/menus.md` · 34b
- [ ] `programs/apps/wiki/frontends/logseq/latest/shortcuts.md` · 91b

### `programs/apps/wiki/frontends/notion/latest/` · 5

- [ ] `programs/apps/wiki/frontends/notion/latest/acceptance.md` · 4.8k
- [ ] `programs/apps/wiki/frontends/notion/latest/dialogs.md` · 7.4k · auch: en_german
- [ ] `programs/apps/wiki/frontends/notion/latest/gaps.md` · 4.5k
- [ ] `programs/apps/wiki/frontends/notion/latest/states.md` · 3.7k
- [ ] `programs/apps/wiki/frontends/notion/latest/workflows.md` · 13.9k

### `programs/apps/wiki/frontends/obsidian/` · 1

- [ ] `programs/apps/wiki/frontends/obsidian/index.md` · 2.2k

### `programs/apps/wiki/frontends/obsidian/latest/` · 6

- [ ] `programs/apps/wiki/frontends/obsidian/latest/api.md` · 135b
- [ ] `programs/apps/wiki/frontends/obsidian/latest/description.md` · 350b
- [ ] `programs/apps/wiki/frontends/obsidian/latest/features.md` · 703b
- [ ] `programs/apps/wiki/frontends/obsidian/latest/layout.md` · 135b
- [ ] `programs/apps/wiki/frontends/obsidian/latest/menus.md` · 75b
- [ ] `programs/apps/wiki/frontends/obsidian/latest/shortcuts.md` · 141b

### `programs/apps/wiki/frontends/tana/` · 1

- [ ] `programs/apps/wiki/frontends/tana/index.md` · 1.8k

### `programs/apps/wiki/frontends/tana/latest/` · 6

- [ ] `programs/apps/wiki/frontends/tana/latest/api.md` · 109b
- [ ] `programs/apps/wiki/frontends/tana/latest/description.md` · 283b
- [ ] `programs/apps/wiki/frontends/tana/latest/features.md` · 669b
- [ ] `programs/apps/wiki/frontends/tana/latest/layout.md` · 105b
- [ ] `programs/apps/wiki/frontends/tana/latest/menus.md` · 32b
- [ ] `programs/apps/wiki/frontends/tana/latest/shortcuts.md` · 89b

## D. `en/` enthält noch deutschen Text – Rest übersetzen – 29 Dateien

### `programs/` · 1

- [ ] `programs/index.md` · 9.1k · Plan[~] · L100 DE prose in EN: ['ein', 'ein']

### `programs/apps/calendar/` · 1

- [ ] `programs/apps/calendar/index.md` · 7.3k · Plan[~] · Parität: links en-only=['frontends/cal-com/index.md', 'frontends/fantastical/index.md', 'frontends/motion/index.md'] de-only=[] · L7 DE prose in EN: ['ein', 'ein'] · hash changed since verification · auch: parity

### `programs/apps/files/` · 1

- [ ] `programs/apps/files/index.md` · 4.5k · Parität: links en-only=['frontends/dropbox/index.md', 'frontends/everything/index.md', 'frontends/files-community/index.md'] de-only=[] · L7 DE prose in EN: ['ein', 'ein'] · auch: parity

### `programs/apps/files/frontends/files-community/latest/` · 1

- [ ] `programs/apps/files/frontends/files-community/latest/menus.md` · 4.4k · L29 German umlaut in EN word → "Menü" · auch: needs_de

### `programs/apps/files/frontends/total-commander/latest/` · 1

- [ ] `programs/apps/files/frontends/total-commander/latest/menus.md` · 8.2k · L67 German umlaut in EN word → "Menü" · auch: needs_de

### `programs/apps/files/frontends/windows-explorer/latest/` · 1

- [ ] `programs/apps/files/frontends/windows-explorer/latest/menus.md` · 3.6k · L30 German umlaut in EN word → "Menü" · auch: needs_de

### `programs/apps/gallery/` · 1

- [ ] `programs/apps/gallery/requirements.md` · 12.0k · Parität: headings 5 vs 4; table rows 65 vs 4 · hash changed since verification · auch: parity

### `programs/apps/history/` · 1

- [ ] `programs/apps/history/index.md` · 4.8k · Parität: headings 7 vs 6; links en-only=['frontends/activitywatch/index.md', 'frontends/day-one/index.md', 'frontends/exist-io/index.md'] de-only=[] · L7 DE prose in EN: ['ein', 'ein'] · auch: parity

### `programs/apps/maps/` · 1

- [ ] `programs/apps/maps/index.md` · 6.2k · Plan[~] · Parität: links en-only=['frontends/felt/index.md', 'frontends/google-earth/index.md'] de-only=[] · L7 DE prose in EN: ['ein', 'ein'] · hash changed since verification · auch: parity

### `programs/apps/messenger/` · 1

- [ ] `programs/apps/messenger/index.md` · 8.0k · Plan[~] · Parität: links en-only=['frontends/delta-chat/index.md', 'frontends/fastmail/index.md', 'frontends/hey/index.md'] de-only=[] · L7 DE prose in EN: ['ein', 'ein'] · hash changed since verification · auch: parity

### `programs/apps/people/` · 1

- [ ] `programs/apps/people/index.md` · 6.1k · Parität: links en-only=['frontends/apple-contacts/index.md', 'frontends/google-contacts/index.md'] de-only=[] · L7 DE prose in EN: ['ein', 'ein'] · auch: parity

### `programs/apps/resources/` · 1

- [ ] `programs/apps/resources/index.md` · 4.9k · Parität: headings 11 vs 10; links en-only=['frontends/erpnext/index.md', 'frontends/grocy/index.md', 'frontends/index.md'] de-only=[] · L7 DE prose in EN: ['ein', 'ein'] · auch: parity

### `programs/apps/store/frontends/kde-discover/latest/` · 1

- [ ] `programs/apps/store/frontends/kde-discover/latest/menus.md` · 1.9k · L7 German umlaut in EN word → "Menü" · auch: needs_de

### `programs/apps/streaming/` · 2

- [ ] `programs/apps/streaming/index.md` · 7.4k · Plan[~] · Parität: links en-only=['frontends/ecamm-live/index.md', 'frontends/owncast/index.md', 'frontends/peertube/index.md'] de-only=[] · L7 DE prose in EN: ['ein', 'ein'] · hash changed since verification · auch: parity
- [ ] `programs/apps/streaming/requirements.md` · 13.2k · Parität: headings 6 vs 4; table rows 65 vs 4 · L45 DE prose in EN: ['am', 'ob'] · hash changed since verification · auch: parity

### `programs/apps/surveys/` · 1

- [ ] `programs/apps/surveys/index.md` · 3.9k · Parität: headings 5 vs 4; links en-only=['frontends/consul/index.md', 'frontends/decidim/index.md', 'frontends/index.md'] de-only=[] · L7 DE prose in EN: ['ein', 'ein'] · auch: parity

### `programs/apps/tasks/` · 1

- [ ] `programs/apps/tasks/index.md` · 4.0k · Parität: headings 6 vs 5; links en-only=['frontends/index.md', 'frontends/jira/index.md', 'frontends/linear/index.md'] de-only=[] · L7 DE prose in EN: ['ein', 'ein'] · auch: parity

### `programs/apps/tasks/frontends/jira/latest/` · 1

- [ ] `programs/apps/tasks/frontends/jira/latest/menus.md` · 4.7k · L5 German umlaut in EN word → "Menü" · auch: needs_de

### `programs/apps/tasks/frontends/things-3/latest/` · 1

- [ ] `programs/apps/tasks/frontends/things-3/latest/menus.md` · 6.0k · L11 German umlaut in EN word → "Menü" · auch: needs_de

### `programs/apps/whiteboard/` · 1

- [ ] `programs/apps/whiteboard/index.md` · 5.8k · Parität: links en-only=['frontends/figjam/index.md'] de-only=[] · L7 DE prose in EN: ['ein', 'ein'] · auch: parity

### `programs/apps/wiki/` · 1

- [ ] `programs/apps/wiki/index.md` · 5.9k · Plan[~] · Parität: links en-only=['frontends/logseq/index.md', 'frontends/obsidian/index.md', 'frontends/tana/index.md'] de-only=[] · L7 DE prose in EN: ['ein', 'ein'] · hash changed since verification · auch: parity

### `programs/apps/wiki/frontends/confluence/latest/` · 2

- [ ] `programs/apps/wiki/frontends/confluence/latest/dialogs.md` · 10.0k · L154 German umlaut in EN word → "Veröffentlichen" · auch: needs_de
- [ ] `programs/apps/wiki/frontends/confluence/latest/menus.md` · 9.8k · Parität: headings 24 vs 21; table rows 22 vs 0 · L116 German umlaut in EN word → "Menü" · hash changed since verification · auch: parity

### `programs/apps/wiki/frontends/notion/latest/` · 2

- [ ] `programs/apps/wiki/frontends/notion/latest/dialogs.md` · 7.4k · L107 German umlaut in EN word → "Schrägstrich" · auch: needs_de
- [ ] `programs/apps/wiki/frontends/notion/latest/menus.md` · 9.2k · Parität: headings 16 vs 23; table rows 0 vs 6 · L68 German umlaut in EN word → "Menü" · hash changed since verification · auch: parity

### `programs/platform/` · 3

- [ ] `programs/platform/groups.md` · 6.1k · L7 DE prose in EN: ['ein', 'ein']
- [ ] `programs/platform/identity.md` · 3.2k · L7 DE prose in EN: ['ein', 'ein']
- [ ] `programs/platform/store.md` · 4.2k · L14 DE prose in EN: ['ein', 'ein']

### `start/` · 1

- [ ] `start/glossary.md` · 2.4k · L9 DE prose in EN: ['ein', 'ein']

## D2. Deutscher Text in Codebeispielen/Boxen (ADR 0002: Code ist englisch) – 4 Dateien

### `programs/suites/democracy/frontends/adhocracy4/latest/` · 1

- [ ] `programs/suites/democracy/frontends/adhocracy4/latest/layout.md` · 1.6k · L7 German in code/example → "am" · Fundzeile: │ Project „Platz am Kanal“   Phase: Brainstorming (until 20.11) │ · Bezeichner ausserhalb bleiben deutsch (ADR 0002)

### `programs/suites/erp/frontends/odoo/latest/` · 1

- [ ] `programs/suites/erp/frontends/odoo/latest/layout.md` · 1.9k · L13 German word in code → "rechts" · Fundzeile: │ Form: Kopf (Status-Chips) · Reiter · Notiz · Chatter rechts    │ · Bezeichner ausserhalb bleiben deutsch (ADR 0002)

### `programs/suites/erp/frontends/sage/latest/` · 1

- [ ] `programs/suites/erp/frontends/sage/latest/layout.md` · 1.1k · L9 German in code/example → "als" · Fundzeile: Reports als Listen/Druckdialoge · Bezeichner ausserhalb bleiben deutsch (ADR 0002)

### `programs/suites/workflows/frontends/node-red/latest/` · 1

- [ ] `programs/suites/workflows/frontends/node-red/latest/api.md` · 2.0k · L46 German word in code → "geschlossen" · Fundzeile: node.warn("Ticket " + msg.payload.ticket.id + " geschlossen"); · Bezeichner ausserhalb bleiben deutsch (ADR 0002)

## E. `de/` enthält noch englischen Text – Rest rückübersetzen – 183 Dateien

### `programs/` · 1

- [ ] `programs/map.md` · 20.7k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/calendar/frontends/cal-com/` · 1

- [ ] `programs/apps/calendar/frontends/cal-com/index.md` · 2.3k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/calendar/frontends/cal-com/latest/` · 6

- [ ] `programs/apps/calendar/frontends/cal-com/latest/api.md` · 979b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/calendar/frontends/cal-com/latest/description.md` · 1.2k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/calendar/frontends/cal-com/latest/features.md` · 1013b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/calendar/frontends/cal-com/latest/layout.md` · 449b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/calendar/frontends/cal-com/latest/menus.md` · 388b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/calendar/frontends/cal-com/latest/shortcuts.md` · 372b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/apps/calendar/frontends/fantastical/` · 1

- [ ] `programs/apps/calendar/frontends/fantastical/index.md` · 2.1k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/calendar/frontends/fantastical/latest/` · 6

- [ ] `programs/apps/calendar/frontends/fantastical/latest/api.md` · 667b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/calendar/frontends/fantastical/latest/description.md` · 988b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/calendar/frontends/fantastical/latest/features.md` · 1.3k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/calendar/frontends/fantastical/latest/layout.md` · 592b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/calendar/frontends/fantastical/latest/menus.md` · 392b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/calendar/frontends/fantastical/latest/shortcuts.md` · 594b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/calendar/frontends/motion/` · 1

- [ ] `programs/apps/calendar/frontends/motion/index.md` · 2.3k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/calendar/frontends/motion/latest/` · 6

- [ ] `programs/apps/calendar/frontends/motion/latest/api.md` · 846b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/calendar/frontends/motion/latest/description.md` · 953b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/calendar/frontends/motion/latest/features.md` · 954b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/calendar/frontends/motion/latest/layout.md` · 399b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/calendar/frontends/motion/latest/menus.md` · 387b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/calendar/frontends/motion/latest/shortcuts.md` · 371b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/apps/calendar/frontends/notion-calendar/` · 1

- [ ] `programs/apps/calendar/frontends/notion-calendar/index.md` · 2.0k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/calendar/frontends/notion-calendar/latest/` · 6

- [ ] `programs/apps/calendar/frontends/notion-calendar/latest/api.md` · 484b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/calendar/frontends/notion-calendar/latest/description.md` · 1.0k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/calendar/frontends/notion-calendar/latest/features.md` · 1.2k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/calendar/frontends/notion-calendar/latest/layout.md` · 452b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/calendar/frontends/notion-calendar/latest/menus.md` · 396b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/calendar/frontends/notion-calendar/latest/shortcuts.md` · 540b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/calendar/frontends/reclaim/` · 1

- [ ] `programs/apps/calendar/frontends/reclaim/index.md` · 2.3k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/calendar/frontends/reclaim/latest/` · 6

- [ ] `programs/apps/calendar/frontends/reclaim/latest/api.md` · 430b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/calendar/frontends/reclaim/latest/description.md` · 924b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/calendar/frontends/reclaim/latest/features.md` · 1.2k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/calendar/frontends/reclaim/latest/layout.md` · 400b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/calendar/frontends/reclaim/latest/menus.md` · 388b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/calendar/frontends/reclaim/latest/shortcuts.md` · 490b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/apps/files/frontends/dropbox/` · 1

- [ ] `programs/apps/files/frontends/dropbox/index.md` · 2.3k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/files/frontends/dropbox/latest/` · 6

- [ ] `programs/apps/files/frontends/dropbox/latest/api.md` · 519b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/files/frontends/dropbox/latest/description.md` · 885b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/files/frontends/dropbox/latest/features.md` · 1.0k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/files/frontends/dropbox/latest/layout.md` · 467b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/files/frontends/dropbox/latest/menus.md` · 418b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/files/frontends/dropbox/latest/shortcuts.md` · 371b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/apps/files/frontends/everything/` · 1

- [ ] `programs/apps/files/frontends/everything/index.md` · 2.2k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/files/frontends/everything/latest/` · 6

- [ ] `programs/apps/files/frontends/everything/latest/api.md` · 598b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/files/frontends/everything/latest/description.md` · 888b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/files/frontends/everything/latest/features.md` · 1.0k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/files/frontends/everything/latest/layout.md` · 487b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/files/frontends/everything/latest/menus.md` · 409b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/files/frontends/everything/latest/shortcuts.md` · 390b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/apps/files/frontends/syncthing/` · 1

- [ ] `programs/apps/files/frontends/syncthing/index.md` · 2.5k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/files/frontends/syncthing/latest/` · 6

- [ ] `programs/apps/files/frontends/syncthing/latest/api.md` · 1006b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/files/frontends/syncthing/latest/description.md` · 945b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/files/frontends/syncthing/latest/features.md` · 1.1k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/files/frontends/syncthing/latest/layout.md` · 494b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/files/frontends/syncthing/latest/menus.md` · 416b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/files/frontends/syncthing/latest/shortcuts.md` · 390b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/apps/gallery/frontends/apple-photos/` · 1

- [ ] `programs/apps/gallery/frontends/apple-photos/index.md` · 2.6k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/gallery/frontends/apple-photos/latest/` · 6

- [ ] `programs/apps/gallery/frontends/apple-photos/latest/api.md` · 488b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/gallery/frontends/apple-photos/latest/description.md` · 733b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/gallery/frontends/apple-photos/latest/features.md` · 963b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/gallery/frontends/apple-photos/latest/layout.md` · 494b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/gallery/frontends/apple-photos/latest/menus.md` · 364b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/gallery/frontends/apple-photos/latest/shortcuts.md` · 453b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/apps/helpdesk/frontends/chatwoot/` · 1

- [ ] `programs/apps/helpdesk/frontends/chatwoot/index.md` · 2.7k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/helpdesk/frontends/chatwoot/latest/` · 6

- [ ] `programs/apps/helpdesk/frontends/chatwoot/latest/api.md` · 612b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/helpdesk/frontends/chatwoot/latest/description.md` · 1.2k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/helpdesk/frontends/chatwoot/latest/features.md` · 1.3k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/helpdesk/frontends/chatwoot/latest/layout.md` · 605b · Parität: line count 3 vs 6 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/helpdesk/frontends/chatwoot/latest/menus.md` · 534b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/helpdesk/frontends/chatwoot/latest/shortcuts.md` · 468b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/apps/maps/frontends/felt/` · 1

- [ ] `programs/apps/maps/frontends/felt/index.md` · 2.5k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/maps/frontends/felt/latest/` · 6

- [ ] `programs/apps/maps/frontends/felt/latest/api.md` · 974b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/maps/frontends/felt/latest/description.md` · 1.4k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/maps/frontends/felt/latest/features.md` · 1.1k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/maps/frontends/felt/latest/layout.md` · 751b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/maps/frontends/felt/latest/menus.md` · 774b · Parität: line count 3 vs 6 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/maps/frontends/felt/latest/shortcuts.md` · 406b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/apps/maps/frontends/google-earth/` · 1

- [ ] `programs/apps/maps/frontends/google-earth/index.md` · 2.9k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/maps/frontends/google-earth/latest/` · 6

- [ ] `programs/apps/maps/frontends/google-earth/latest/api.md` · 882b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/maps/frontends/google-earth/latest/description.md` · 1.5k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/maps/frontends/google-earth/latest/features.md` · 1.2k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/maps/frontends/google-earth/latest/layout.md` · 790b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/maps/frontends/google-earth/latest/menus.md` · 892b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/maps/frontends/google-earth/latest/shortcuts.md` · 502b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/apps/marketing/frontends/listmonk/` · 1

- [ ] `programs/apps/marketing/frontends/listmonk/index.md` · 2.3k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/marketing/frontends/listmonk/latest/` · 6

- [ ] `programs/apps/marketing/frontends/listmonk/latest/api.md` · 527b · Parität: line count 3 vs 6 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/marketing/frontends/listmonk/latest/description.md` · 1.0k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/marketing/frontends/listmonk/latest/features.md` · 854b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/marketing/frontends/listmonk/latest/layout.md` · 360b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/marketing/frontends/listmonk/latest/menus.md` · 465b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/marketing/frontends/listmonk/latest/shortcuts.md` · 373b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/apps/marketing/frontends/umami/` · 1

- [ ] `programs/apps/marketing/frontends/umami/index.md` · 2.5k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/marketing/frontends/umami/latest/` · 6

- [ ] `programs/apps/marketing/frontends/umami/latest/api.md` · 622b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/marketing/frontends/umami/latest/description.md` · 1.2k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/marketing/frontends/umami/latest/features.md` · 1.1k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/marketing/frontends/umami/latest/layout.md` · 384b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/marketing/frontends/umami/latest/menus.md` · 460b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/marketing/frontends/umami/latest/shortcuts.md` · 403b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/apps/people/frontends/apple-contacts/` · 1

- [ ] `programs/apps/people/frontends/apple-contacts/index.md` · 3.5k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/people/frontends/apple-contacts/latest/` · 6

- [ ] `programs/apps/people/frontends/apple-contacts/latest/api.md` · 525b · Parität: line count 3 vs 6 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/people/frontends/apple-contacts/latest/description.md` · 1.3k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/people/frontends/apple-contacts/latest/features.md` · 1.3k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/people/frontends/apple-contacts/latest/layout.md` · 513b · Parität: line count 3 vs 6 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/people/frontends/apple-contacts/latest/menus.md` · 535b · Parität: line count 3 vs 6 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/people/frontends/apple-contacts/latest/shortcuts.md` · 496b · Parität: line count 3 vs 6 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/apps/people/frontends/google-contacts/` · 1

- [ ] `programs/apps/people/frontends/google-contacts/index.md` · 3.1k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/apps/people/frontends/google-contacts/latest/` · 6

- [ ] `programs/apps/people/frontends/google-contacts/latest/api.md` · 647b · Parität: line count 3 vs 6 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/apps/people/frontends/google-contacts/latest/description.md` · 1.2k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/people/frontends/google-contacts/latest/features.md` · 1.4k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/people/frontends/google-contacts/latest/layout.md` · 878b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/people/frontends/google-contacts/latest/menus.md` · 794b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/apps/people/frontends/google-contacts/latest/shortcuts.md` · 490b · Parität: line count 3 vs 6 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/apps/wiki/frontends/mediawiki/1.46/` · 1

- [ ] `programs/apps/wiki/frontends/mediawiki/1.46/menus.md` · 5.1k · L29 EN prose in DE: ['this', 'from', 'your']

### `programs/apps/wiki/frontends/tango/` · 1

- [ ] `programs/apps/wiki/frontends/tango/changelog.md` · 10.2k · L88 EN prose in DE: ['how', 'the', 'how', 'the']

### `programs/apps/wiki/frontends/tango/latest/` · 5

- [ ] `programs/apps/wiki/frontends/tango/latest/api.md` · 2.1k · L19 EN prose in DE: ['what', 'is', 'how']
- [ ] `programs/apps/wiki/frontends/tango/latest/description.md` · 3.0k · L13 EN prose in DE: ['what', 'are', 'the']
- [ ] `programs/apps/wiki/frontends/tango/latest/features.md` · 5.6k · L24 EN prose in DE: ['how', 'how', 'into']
- [ ] `programs/apps/wiki/frontends/tango/latest/limits.md` · 3.1k · L5 EN prose in DE: ['where', 'does', 'are', 'there', 'what']
- [ ] `programs/apps/wiki/frontends/tango/latest/menus.md` · 2.3k · L7 EN prose in DE: ['how', 'the', 'how']

### `programs/platform/desktop/frontends/alfred/` · 1

- [ ] `programs/platform/desktop/frontends/alfred/index.md` · 2.2k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/platform/desktop/frontends/alfred/latest/` · 6

- [ ] `programs/platform/desktop/frontends/alfred/latest/api.md` · 512b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/platform/desktop/frontends/alfred/latest/description.md` · 981b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/platform/desktop/frontends/alfred/latest/features.md` · 1.1k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/platform/desktop/frontends/alfred/latest/layout.md` · 530b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/platform/desktop/frontends/alfred/latest/menus.md` · 361b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/platform/desktop/frontends/alfred/latest/shortcuts.md` · 484b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/platform/desktop/frontends/kde-plasma/` · 1

- [ ] `programs/platform/desktop/frontends/kde-plasma/index.md` · 2.4k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/platform/desktop/frontends/kde-plasma/latest/` · 6

- [ ] `programs/platform/desktop/frontends/kde-plasma/latest/api.md` · 697b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/platform/desktop/frontends/kde-plasma/latest/description.md` · 1.2k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/platform/desktop/frontends/kde-plasma/latest/features.md` · 1.1k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/platform/desktop/frontends/kde-plasma/latest/layout.md` · 577b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/platform/desktop/frontends/kde-plasma/latest/menus.md` · 470b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/platform/desktop/frontends/kde-plasma/latest/shortcuts.md` · 554b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/platform/desktop/frontends/raycast/` · 1

- [ ] `programs/platform/desktop/frontends/raycast/index.md` · 2.3k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/platform/desktop/frontends/raycast/latest/` · 6

- [ ] `programs/platform/desktop/frontends/raycast/latest/api.md` · 729b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/platform/desktop/frontends/raycast/latest/description.md` · 1.1k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/platform/desktop/frontends/raycast/latest/features.md` · 1.3k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/platform/desktop/frontends/raycast/latest/layout.md` · 608b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/platform/desktop/frontends/raycast/latest/menus.md` · 481b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/platform/desktop/frontends/raycast/latest/shortcuts.md` · 493b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/suites/crm/frontends/attio/` · 1

- [ ] `programs/suites/crm/frontends/attio/index.md` · 2.7k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/suites/crm/frontends/attio/latest/` · 6

- [ ] `programs/suites/crm/frontends/attio/latest/api.md` · 519b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/crm/frontends/attio/latest/description.md` · 1.0k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/suites/crm/frontends/attio/latest/features.md` · 1020b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/suites/crm/frontends/attio/latest/layout.md` · 357b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/crm/frontends/attio/latest/menus.md` · 357b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/crm/frontends/attio/latest/shortcuts.md` · 370b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/suites/crm/frontends/twenty/` · 1

- [ ] `programs/suites/crm/frontends/twenty/index.md` · 2.9k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/suites/crm/frontends/twenty/latest/` · 6

- [ ] `programs/suites/crm/frontends/twenty/latest/api.md` · 597b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/suites/crm/frontends/twenty/latest/description.md` · 1.2k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/suites/crm/frontends/twenty/latest/features.md` · 933b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/suites/crm/frontends/twenty/latest/layout.md` · 425b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/crm/frontends/twenty/latest/menus.md` · 358b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/crm/frontends/twenty/latest/shortcuts.md` · 371b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/suites/workflows/frontends/apple-shortcuts/` · 1

- [ ] `programs/suites/workflows/frontends/apple-shortcuts/index.md` · 2.3k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/suites/workflows/frontends/apple-shortcuts/latest/` · 6

- [ ] `programs/suites/workflows/frontends/apple-shortcuts/latest/api.md` · 674b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/workflows/frontends/apple-shortcuts/latest/description.md` · 1.0k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/suites/workflows/frontends/apple-shortcuts/latest/features.md` · 1.1k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/suites/workflows/frontends/apple-shortcuts/latest/layout.md` · 493b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/workflows/frontends/apple-shortcuts/latest/menus.md` · 370b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/workflows/frontends/apple-shortcuts/latest/shortcuts.md` · 511b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/suites/workflows/frontends/huginn/` · 1

- [ ] `programs/suites/workflows/frontends/huginn/index.md` · 2.2k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/suites/workflows/frontends/huginn/latest/` · 6

- [ ] `programs/suites/workflows/frontends/huginn/latest/api.md` · 511b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/workflows/frontends/huginn/latest/description.md` · 1.1k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/suites/workflows/frontends/huginn/latest/features.md` · 925b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/suites/workflows/frontends/huginn/latest/layout.md` · 493b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/workflows/frontends/huginn/latest/menus.md` · 361b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/workflows/frontends/huginn/latest/shortcuts.md` · 399b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/suites/workflows/frontends/power-automate/` · 1

- [ ] `programs/suites/workflows/frontends/power-automate/index.md` · 2.3k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/suites/workflows/frontends/power-automate/latest/` · 6

- [ ] `programs/suites/workflows/frontends/power-automate/latest/api.md` · 486b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/workflows/frontends/power-automate/latest/description.md` · 940b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/suites/workflows/frontends/power-automate/latest/features.md` · 978b · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/suites/workflows/frontends/power-automate/latest/layout.md` · 651b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/workflows/frontends/power-automate/latest/menus.md` · 627b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/workflows/frontends/power-automate/latest/shortcuts.md` · 408b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

### `programs/suites/workflows/frontends/windmill/` · 1

- [ ] `programs/suites/workflows/frontends/windmill/index.md` · 2.2k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']

### `programs/suites/workflows/frontends/windmill/latest/` · 6

- [ ] `programs/suites/workflows/frontends/windmill/latest/api.md` · 560b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/workflows/frontends/windmill/latest/description.md` · 1.1k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/suites/workflows/frontends/windmill/latest/features.md` · 1.0k · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been']
- [ ] `programs/suites/workflows/frontends/windmill/latest/layout.md` · 503b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/workflows/frontends/windmill/latest/menus.md` · 363b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity
- [ ] `programs/suites/workflows/frontends/windmill/latest/shortcuts.md` · 402b · Parität: line count 2 vs 5 · L5 EN prose in DE: ['this', 'from', 'the', 'has', 'yet', 'been'] · auch: parity

## F. Form nicht gleich – Struktur abgleichen – 219 Dateien

### `components/primitives/fields/select/` · 1

- [ ] `components/primitives/fields/select/usage.md` · 5.3k · Parität: box frames broken en=3 de=1 · hash changed since verification

### `components/primitives/fields/textarea/` · 1

- [ ] `components/primitives/fields/textarea/usage.md` · 4.5k · Parität: headings 12 vs 11 · hash changed since verification

### `components/widgets/data/table/` · 1

- [ ] `components/widgets/data/table/appearance.md` · 2.6k · Parität: box frames broken en=2 de=1 · hash changed since verification

### `components/widgets/fields/file-upload/` · 1

- [ ] `components/widgets/fields/file-upload/appearance.md` · 2.7k · Parität: box frames broken en=3 de=2 · hash changed since verification

### `components/widgets/media/carousel/` · 1

- [ ] `components/widgets/media/carousel/appearance.md` · 1.8k · Parität: box frames broken en=1 de=0 · hash changed since verification

### `components/widgets/navigation/pagination/` · 1

- [ ] `components/widgets/navigation/pagination/usage.md` · 3.8k · Parität: box frames broken en=1 de=0 · hash changed since verification

### `components/widgets/navigation/tabs/` · 1

- [ ] `components/widgets/navigation/tabs/usage.md` · 4.1k · Parität: box frames broken en=1 de=0 · hash changed since verification

### `components/widgets/overlays/drawer/` · 1

- [ ] `components/widgets/overlays/drawer/appearance.md` · 3.3k · Parität: box frames broken en=2 de=0 · hash changed since verification

### `components/widgets/overlays/modal/` · 1

- [ ] `components/widgets/overlays/modal/appearance.md` · 3.2k · Parität: box frames broken en=1 de=0 · hash changed since verification

### `interactions/animations/feedback/tick-draw/` · 1

- [ ] `interactions/animations/feedback/tick-draw/appearance.md` · 1.8k · Parität: box frames broken en=1 de=0 · hash changed since verification

### `interactions/animations/transition/reorder/` · 1

- [ ] `interactions/animations/transition/reorder/appearance.md` · 1.8k · Parität: box frames broken en=1 de=0 · hash changed since verification

### `interactions/animations/transition/rotate/` · 1

- [ ] `interactions/animations/transition/rotate/appearance.md` · 1.1k · Parität: box frames broken en=1 de=0 · hash changed since verification

### `programs/apps/` · 1

- [ ] `programs/apps/roadmap.md` · 7.8k · Parität: table rows 43 vs 41; links en-only=['assistant/index.md', 'https://github.com/FreeSynergy/fs-components', 'https://github.com/FreeSynergy/fs-interfaces'] de-only=[]

### `programs/apps/calendar/` · 2

- [ ] `programs/apps/calendar/index.md` · 7.3k · Plan[~] · Parität: links en-only=['frontends/cal-com/index.md', 'frontends/fantastical/index.md', 'frontends/motion/index.md'] de-only=[] · hash changed since verification · auch: en_german
- [ ] `programs/apps/calendar/requirements.md` · 1.5k · Parität: table rows 10 vs 4 · hash changed since verification

### `programs/apps/calendar/frontends/` · 1

- [ ] `programs/apps/calendar/frontends/index.md` · 4.8k · Parität: table rows 13 vs 8; links en-only=['cal-com/index.md', 'cal-com/latest/description.md', 'fantastical/index.md'] de-only=[] · hash changed since verification

### `programs/apps/calendar/frontends/cal-com/latest/` · 3

- [ ] `programs/apps/calendar/frontends/cal-com/latest/layout.md` · 99b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/calendar/frontends/cal-com/latest/menus.md` · 59b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/calendar/frontends/cal-com/latest/shortcuts.md` · 40b · Parität: line count 2 vs 5 · auch: de_english

### `programs/apps/calendar/frontends/fantastical/latest/` · 3

- [ ] `programs/apps/calendar/frontends/fantastical/latest/api.md` · 290b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/calendar/frontends/fantastical/latest/layout.md` · 229b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/calendar/frontends/fantastical/latest/menus.md` · 63b · Parität: line count 2 vs 5 · auch: de_english

### `programs/apps/calendar/frontends/motion/latest/` · 3

- [ ] `programs/apps/calendar/frontends/motion/latest/layout.md` · 63b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/calendar/frontends/motion/latest/menus.md` · 58b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/calendar/frontends/motion/latest/shortcuts.md` · 39b · Parität: line count 2 vs 5 · auch: de_english

### `programs/apps/calendar/frontends/notion-calendar/latest/` · 3

- [ ] `programs/apps/calendar/frontends/notion-calendar/latest/api.md` · 140b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/calendar/frontends/notion-calendar/latest/layout.md` · 114b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/calendar/frontends/notion-calendar/latest/menus.md` · 67b · Parität: line count 2 vs 5 · auch: de_english

### `programs/apps/calendar/frontends/reclaim/latest/` · 4

- [ ] `programs/apps/calendar/frontends/reclaim/latest/api.md` · 90b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/calendar/frontends/reclaim/latest/layout.md` · 64b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/calendar/frontends/reclaim/latest/menus.md` · 59b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/calendar/frontends/reclaim/latest/shortcuts.md` · 152b · Parität: line count 2 vs 5 · auch: de_english

### `programs/apps/files/` · 3

- [ ] `programs/apps/files/design.md` · 7.3k · Parität: links en-only=['https://github.com/FreeSynergy/fs-interfaces/blob/main/schema/files.capnp'] de-only=[]
- [ ] `programs/apps/files/index.md` · 4.5k · Parität: links en-only=['frontends/dropbox/index.md', 'frontends/everything/index.md', 'frontends/files-community/index.md'] de-only=[] · auch: en_german
- [ ] `programs/apps/files/requirements.md` · 5.5k · Parität: table rows 44 vs 23; links en-only=['frontends/dolphin/index.md', 'frontends/finder/index.md', 'frontends/google-drive/index.md'] de-only=[]

### `programs/apps/files/frontends/` · 1

- [ ] `programs/apps/files/frontends/index.md` · 4.4k · Parität: headings 3 vs 4; table rows 15 vs 10

### `programs/apps/files/frontends/dolphin/` · 1

- [ ] `programs/apps/files/frontends/dolphin/index.md` · 2.6k · Parität: headings 8 vs 7

### `programs/apps/files/frontends/dropbox/latest/` · 4

- [ ] `programs/apps/files/frontends/dropbox/latest/api.md` · 184b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/files/frontends/dropbox/latest/layout.md` · 110b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/files/frontends/dropbox/latest/menus.md` · 78b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/files/frontends/dropbox/latest/shortcuts.md` · 39b · Parität: line count 2 vs 5 · auch: de_english

### `programs/apps/files/frontends/everything/latest/` · 3

- [ ] `programs/apps/files/frontends/everything/latest/layout.md` · 146b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/files/frontends/everything/latest/menus.md` · 83b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/files/frontends/everything/latest/shortcuts.md` · 54b · Parität: line count 2 vs 5 · auch: de_english

### `programs/apps/files/frontends/finder/` · 1

- [ ] `programs/apps/files/frontends/finder/index.md` · 2.3k · Parität: headings 8 vs 7

### `programs/apps/files/frontends/google-drive/` · 1

- [ ] `programs/apps/files/frontends/google-drive/index.md` · 2.3k · Parität: headings 8 vs 7

### `programs/apps/files/frontends/nautilus/` · 1

- [ ] `programs/apps/files/frontends/nautilus/index.md` · 2.8k · Parität: headings 8 vs 7

### `programs/apps/files/frontends/nextcloud-files/` · 1

- [ ] `programs/apps/files/frontends/nextcloud-files/index.md` · 2.9k · Parität: headings 9 vs 8

### `programs/apps/files/frontends/rclone/` · 1

- [ ] `programs/apps/files/frontends/rclone/index.md` · 3.3k · Parität: headings 8 vs 7

### `programs/apps/files/frontends/seafile/` · 1

- [ ] `programs/apps/files/frontends/seafile/index.md` · 2.2k · Parität: headings 8 vs 7

### `programs/apps/files/frontends/syncthing/latest/` · 3

- [ ] `programs/apps/files/frontends/syncthing/latest/layout.md` · 153b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/files/frontends/syncthing/latest/menus.md` · 77b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/files/frontends/syncthing/latest/shortcuts.md` · 54b · Parität: line count 2 vs 5 · auch: de_english

### `programs/apps/files/frontends/windows-explorer/` · 1

- [ ] `programs/apps/files/frontends/windows-explorer/index.md` · 3.5k · Parität: headings 9 vs 7; table rows 26 vs 9

### `programs/apps/gallery/` · 2

- [ ] `programs/apps/gallery/index.md` · 4.0k · Plan[~] · Parität: links en-only=['design.md', 'files/design.md', 'frontends/apple-photos/index.md'] de-only=[] · hash changed since verification
- [ ] `programs/apps/gallery/requirements.md` · 12.0k · Parität: headings 5 vs 4; table rows 65 vs 4 · hash changed since verification · auch: en_german

### `programs/apps/gallery/frontends/` · 1

- [ ] `programs/apps/gallery/frontends/index.md` · 4.4k · Parität: table rows 11 vs 10; links en-only=['apple-photos/index.md', 'apple-photos/latest/description.md'] de-only=[] · hash changed since verification

### `programs/apps/gallery/frontends/apple-photos/latest/` · 4

- [ ] `programs/apps/gallery/frontends/apple-photos/latest/api.md` · 131b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/gallery/frontends/apple-photos/latest/layout.md` · 149b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/gallery/frontends/apple-photos/latest/menus.md` · 40b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/gallery/frontends/apple-photos/latest/shortcuts.md` · 97b · Parität: line count 2 vs 5 · auch: de_english

### `programs/apps/helpdesk/` · 2

- [ ] `programs/apps/helpdesk/index.md` · 4.5k · Plan[~] · Parität: links en-only=['frontends/chatwoot/index.md'] de-only=[] · hash changed since verification
- [ ] `programs/apps/helpdesk/requirements.md` · 2.0k · Parität: headings 5 vs 4; table rows 14 vs 4 · hash changed since verification

### `programs/apps/helpdesk/frontends/` · 1

- [ ] `programs/apps/helpdesk/frontends/index.md` · 4.4k · Parität: table rows 11 vs 10; links en-only=['chatwoot/index.md', 'chatwoot/latest/description.md'] de-only=[] · hash changed since verification

### `programs/apps/helpdesk/frontends/chatwoot/latest/` · 3

- [ ] `programs/apps/helpdesk/frontends/chatwoot/latest/layout.md` · 265b · Parität: line count 3 vs 6 · auch: de_english
- [ ] `programs/apps/helpdesk/frontends/chatwoot/latest/menus.md` · 191b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/helpdesk/frontends/chatwoot/latest/shortcuts.md` · 121b · Parität: line count 2 vs 5 · auch: de_english

### `programs/apps/history/` · 1

- [ ] `programs/apps/history/index.md` · 4.8k · Parität: headings 7 vs 6; links en-only=['frontends/activitywatch/index.md', 'frontends/day-one/index.md', 'frontends/exist-io/index.md'] de-only=[] · auch: en_german

### `programs/apps/maps/` · 2

- [ ] `programs/apps/maps/index.md` · 6.2k · Plan[~] · Parität: links en-only=['frontends/felt/index.md', 'frontends/google-earth/index.md'] de-only=[] · hash changed since verification · auch: en_german
- [ ] `programs/apps/maps/requirements.md` · 1.1k · Parität: table rows 10 vs 4 · hash changed since verification

### `programs/apps/maps/frontends/` · 1

- [ ] `programs/apps/maps/frontends/index.md` · 4.5k · Parität: table rows 11 vs 9; links en-only=['felt/index.md', 'felt/latest/description.md', 'google-earth/index.md'] de-only=[] · hash changed since verification

### `programs/apps/maps/frontends/felt/latest/` · 2

- [ ] `programs/apps/maps/frontends/felt/latest/menus.md` · 365b · Parität: line count 3 vs 6 · auch: de_english
- [ ] `programs/apps/maps/frontends/felt/latest/shortcuts.md` · 89b · Parität: line count 2 vs 5 · auch: de_english

### `programs/apps/maps/frontends/google-earth/latest/` · 1

- [ ] `programs/apps/maps/frontends/google-earth/latest/shortcuts.md` · 162b · Parität: line count 2 vs 5 · auch: de_english

### `programs/apps/marketing/` · 2

- [ ] `programs/apps/marketing/index.md` · 4.7k · Plan[~] · Parität: links en-only=['frontends/listmonk/index.md', 'frontends/umami/index.md'] de-only=[] · hash changed since verification
- [ ] `programs/apps/marketing/requirements.md` · 1.2k · Parität: table rows 9 vs 4 · hash changed since verification

### `programs/apps/marketing/frontends/` · 1

- [ ] `programs/apps/marketing/frontends/index.md` · 4.2k · Parität: table rows 10 vs 8; links en-only=['listmonk/index.md', 'listmonk/latest/description.md', 'umami/index.md'] de-only=[] · hash changed since verification

### `programs/apps/marketing/frontends/listmonk/latest/` · 4

- [ ] `programs/apps/marketing/frontends/listmonk/latest/api.md` · 189b · Parität: line count 3 vs 6 · auch: de_english
- [ ] `programs/apps/marketing/frontends/listmonk/latest/layout.md` · 37b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/marketing/frontends/listmonk/latest/menus.md` · 117b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/marketing/frontends/listmonk/latest/shortcuts.md` · 53b · Parität: line count 2 vs 5 · auch: de_english

### `programs/apps/marketing/frontends/umami/latest/` · 3

- [ ] `programs/apps/marketing/frontends/umami/latest/layout.md` · 56b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/marketing/frontends/umami/latest/menus.md` · 121b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/apps/marketing/frontends/umami/latest/shortcuts.md` · 71b · Parität: line count 2 vs 5 · auch: de_english

### `programs/apps/messenger/` · 2

- [ ] `programs/apps/messenger/index.md` · 8.0k · Plan[~] · Parität: links en-only=['frontends/delta-chat/index.md', 'frontends/fastmail/index.md', 'frontends/hey/index.md'] de-only=[] · hash changed since verification · auch: en_german
- [ ] `programs/apps/messenger/requirements.md` · 24.6k · Parität: table rows 136 vs 119 · hash changed since verification

### `programs/apps/messenger/frontends/` · 1

- [ ] `programs/apps/messenger/frontends/index.md` · 5.3k · Parität: table rows 18 vs 9; links en-only=['apple-mail/index.md', 'apple-mail/ios-26/description.md', 'delta-chat/index.md'] de-only=[] · hash changed since verification

### `programs/apps/messenger/frontends/outlook/` · 1

- [ ] `programs/apps/messenger/frontends/outlook/index.md` · 5.7k · Parität: headings 7 vs 6; table rows 25 vs 12 · hash changed since verification

### `programs/apps/people/` · 2

- [ ] `programs/apps/people/index.md` · 6.1k · Parität: links en-only=['frontends/apple-contacts/index.md', 'frontends/google-contacts/index.md'] de-only=[] · auch: en_german
- [ ] `programs/apps/people/requirements.md` · 1.9k · Parität: table rows 10 vs 4

### `programs/apps/people/frontends/` · 1

- [ ] `programs/apps/people/frontends/index.md` · 3.7k · Parität: table rows 8 vs 6; links en-only=['apple-contacts/index.md', 'apple-contacts/latest/description.md', 'google-contacts/index.md'] de-only=[]

### `programs/apps/people/frontends/apple-contacts/latest/` · 4

- [ ] `programs/apps/people/frontends/apple-contacts/latest/api.md` · 181b · Parität: line count 3 vs 6 · auch: de_english
- [ ] `programs/apps/people/frontends/apple-contacts/latest/layout.md` · 172b · Parität: line count 3 vs 6 · auch: de_english
- [ ] `programs/apps/people/frontends/apple-contacts/latest/menus.md` · 193b · Parität: line count 3 vs 6 · auch: de_english
- [ ] `programs/apps/people/frontends/apple-contacts/latest/shortcuts.md` · 153b · Parität: line count 3 vs 6 · auch: de_english

### `programs/apps/people/frontends/google-contacts/latest/` · 2

- [ ] `programs/apps/people/frontends/google-contacts/latest/api.md` · 292b · Parität: line count 3 vs 6 · auch: de_english
- [ ] `programs/apps/people/frontends/google-contacts/latest/shortcuts.md` · 156b · Parität: line count 3 vs 6 · auch: de_english

### `programs/apps/resources/` · 1

- [ ] `programs/apps/resources/index.md` · 4.9k · Parität: headings 11 vs 10; links en-only=['frontends/erpnext/index.md', 'frontends/grocy/index.md', 'frontends/index.md'] de-only=[] · auch: en_german

### `programs/apps/streaming/` · 3

- [ ] `programs/apps/streaming/design.md` · 5.0k · Parität: links en-only=['https://github.com/FreeSynergy/fs-streaming'] de-only=[]
- [ ] `programs/apps/streaming/index.md` · 7.4k · Plan[~] · Parität: links en-only=['frontends/ecamm-live/index.md', 'frontends/owncast/index.md', 'frontends/peertube/index.md'] de-only=[] · hash changed since verification · auch: en_german
- [ ] `programs/apps/streaming/requirements.md` · 13.2k · Parität: headings 6 vs 4; table rows 65 vs 4 · hash changed since verification · auch: en_german

### `programs/apps/streaming/frontends/` · 1

- [ ] `programs/apps/streaming/frontends/index.md` · 5.8k · Parität: table rows 17 vs 12; links en-only=['ecamm-live/index.md', 'ecamm-live/latest/description.md', 'owncast/index.md'] de-only=[] · hash changed since verification

### `programs/apps/surveys/` · 2

- [ ] `programs/apps/surveys/index.md` · 3.9k · Parität: headings 5 vs 4; links en-only=['frontends/consul/index.md', 'frontends/decidim/index.md', 'frontends/index.md'] de-only=[] · auch: en_german
- [ ] `programs/apps/surveys/requirements.md` · 5.2k · Parität: headings 5 vs 4; table rows 33 vs 26

### `programs/apps/tasks/` · 2

- [ ] `programs/apps/tasks/index.md` · 4.0k · Parität: headings 6 vs 5; links en-only=['frontends/index.md', 'frontends/jira/index.md', 'frontends/linear/index.md'] de-only=[] · auch: en_german
- [ ] `programs/apps/tasks/requirements.md` · 15.9k · Parität: table rows 80 vs 71; links en-only=['../../components/charts.md', '../platform/groups.md', '../platform/identity.md'] de-only=['../suites/projectmanagement/frontends/jira/index.md']

### `programs/apps/whiteboard/` · 3

- [ ] `programs/apps/whiteboard/design.md` · 5.4k · Parität: links en-only=['https://github.com/FreeSynergy/fs-whiteboard'] de-only=[]
- [ ] `programs/apps/whiteboard/index.md` · 5.8k · Parität: links en-only=['frontends/figjam/index.md'] de-only=[] · auch: en_german
- [ ] `programs/apps/whiteboard/requirements.md` · 11.9k · Parität: table rows 63 vs 4; links en-only=['../../data/models.md', 'frontends/drawio/index.md', 'frontends/excalidraw/index.md'] de-only=[]

### `programs/apps/whiteboard/frontends/` · 1

- [ ] `programs/apps/whiteboard/frontends/index.md` · 3.8k · Parität: table rows 9 vs 8; links en-only=['figjam/index.md', 'figjam/latest/description.md'] de-only=[]

### `programs/apps/wiki/` · 2

- [ ] `programs/apps/wiki/index.md` · 5.9k · Plan[~] · Parität: links en-only=['frontends/logseq/index.md', 'frontends/obsidian/index.md', 'frontends/tana/index.md'] de-only=[] · hash changed since verification · auch: en_german
- [ ] `programs/apps/wiki/requirements.md` · 3.0k · Parität: table rows 23 vs 4; line count 32 vs 11 · hash changed since verification

### `programs/apps/wiki/frontends/` · 1

- [ ] `programs/apps/wiki/frontends/index.md` · 4.1k · Parität: table rows 12 vs 8; links en-only=['logseq/index.md', 'logseq/latest/description.md', 'mediawiki/1.46/description.md'] de-only=[] · hash changed since verification

### `programs/apps/wiki/frontends/confluence/` · 1

- [ ] `programs/apps/wiki/frontends/confluence/index.md` · 8.1k · Parität: headings 8 vs 5; table rows 61 vs 11 · hash changed since verification

### `programs/apps/wiki/frontends/confluence/latest/` · 6

- [ ] `programs/apps/wiki/frontends/confluence/latest/api.md` · 7.0k · Parität: headings 16 vs 29; table rows 37 vs 34 · hash changed since verification
- [ ] `programs/apps/wiki/frontends/confluence/latest/description.md` · 2.3k · Parität: headings 7 vs 10; table rows 17 vs 0 · hash changed since verification
- [ ] `programs/apps/wiki/frontends/confluence/latest/features.md` · 3.3k · Parität: headings 4 vs 24; table rows 33 vs 23 · hash changed since verification
- [ ] `programs/apps/wiki/frontends/confluence/latest/layout.md` · 3.9k · Parität: headings 13 vs 18; table rows 16 vs 13 · hash changed since verification
- [ ] `programs/apps/wiki/frontends/confluence/latest/menus.md` · 9.8k · Parität: headings 24 vs 21; table rows 22 vs 0 · hash changed since verification · auch: en_german
- [ ] `programs/apps/wiki/frontends/confluence/latest/shortcuts.md` · 6.8k · Parität: headings 13 vs 20; table rows 79 vs 142 · hash changed since verification

### `programs/apps/wiki/frontends/mediawiki/` · 1

- [ ] `programs/apps/wiki/frontends/mediawiki/index.md` · 5.8k · Parität: headings 8 vs 5; table rows 31 vs 11 · hash changed since verification

### `programs/apps/wiki/frontends/notion/` · 1

- [ ] `programs/apps/wiki/frontends/notion/index.md` · 8.0k · Parität: headings 9 vs 5; table rows 84 vs 11 · hash changed since verification

### `programs/apps/wiki/frontends/notion/latest/` · 3

- [ ] `programs/apps/wiki/frontends/notion/latest/features.md` · 7.1k · Parität: links en-only=['2026-11-07/features.md', 'acceptance.md', 'dialogs.md'] de-only=[] · hash changed since verification
- [ ] `programs/apps/wiki/frontends/notion/latest/menus.md` · 9.2k · Parität: headings 16 vs 23; table rows 0 vs 6 · hash changed since verification · auch: en_german
- [ ] `programs/apps/wiki/frontends/notion/latest/shortcuts.md` · 5.5k · Parität: headings 3 vs 17; table rows 62 vs 149 · hash changed since verification

### `programs/apps/wiki/frontends/wikijs/` · 1

- [ ] `programs/apps/wiki/frontends/wikijs/index.md` · 5.9k · Parität: headings 9 vs 5; table rows 38 vs 11 · hash changed since verification

### `programs/platform/` · 1

- [ ] `programs/platform/releases.md` · 4.6k · Parität: headings 9 vs 7

### `programs/platform/crates/` · 1

- [ ] `programs/platform/crates/gui.md` · 12.8k · Parität: headings 7 vs 6; table rows 16 vs 10

### `programs/platform/desktop/` · 2

- [ ] `programs/platform/desktop/index.md` · 7.4k · Plan[~] · Parität: links en-only=['frontends/alfred/index.md', 'frontends/kde-plasma/index.md', 'frontends/raycast/index.md'] de-only=[] · hash changed since verification
- [ ] `programs/platform/desktop/requirements.md` · 980b · Parität: table rows 8 vs 4 · hash changed since verification

### `programs/platform/desktop/frontends/` · 1

- [ ] `programs/platform/desktop/frontends/index.md` · 6.1k · Parität: table rows 17 vs 14; links en-only=['alfred/index.md', 'alfred/latest/description.md', 'kde-plasma/index.md'] de-only=[] · hash changed since verification

### `programs/platform/desktop/frontends/alfred/latest/` · 4

- [ ] `programs/platform/desktop/frontends/alfred/latest/api.md` · 169b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/platform/desktop/frontends/alfred/latest/layout.md` · 169b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/platform/desktop/frontends/alfred/latest/menus.md` · 38b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/platform/desktop/frontends/alfred/latest/shortcuts.md` · 137b · Parität: line count 2 vs 5 · auch: de_english

### `programs/platform/desktop/frontends/dashy/` · 1

- [ ] `programs/platform/desktop/frontends/dashy/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/platform/desktop/frontends/gethomepage/` · 1

- [ ] `programs/platform/desktop/frontends/gethomepage/index.md` · 1.4k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/platform/desktop/frontends/heimdall/` · 1

- [ ] `programs/platform/desktop/frontends/heimdall/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/platform/desktop/frontends/homarr/` · 1

- [ ] `programs/platform/desktop/frontends/homarr/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/platform/desktop/frontends/homarr/latest/` · 1

- [ ] `programs/platform/desktop/frontends/homarr/latest/layout.md` · 7.6k · Parität: box frames broken en=2 de=1

### `programs/platform/desktop/frontends/homepage/` · 1

- [ ] `programs/platform/desktop/frontends/homepage/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/platform/desktop/frontends/homer/` · 1

- [ ] `programs/platform/desktop/frontends/homer/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/platform/desktop/frontends/kde-plasma/latest/` · 3

- [ ] `programs/platform/desktop/frontends/kde-plasma/latest/api.md` · 310b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/platform/desktop/frontends/kde-plasma/latest/layout.md` · 216b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/platform/desktop/frontends/kde-plasma/latest/menus.md` · 143b · Parität: line count 2 vs 5 · auch: de_english

### `programs/platform/desktop/frontends/launchboard/` · 1

- [ ] `programs/platform/desktop/frontends/launchboard/index.md` · 1.6k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/platform/desktop/frontends/opnsense/` · 1

- [ ] `programs/platform/desktop/frontends/opnsense/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/platform/desktop/frontends/proxmox/` · 1

- [ ] `programs/platform/desktop/frontends/proxmox/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/platform/desktop/frontends/raycast/latest/` · 3

- [ ] `programs/platform/desktop/frontends/raycast/latest/layout.md` · 243b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/platform/desktop/frontends/raycast/latest/menus.md` · 132b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/platform/desktop/frontends/raycast/latest/shortcuts.md` · 147b · Parität: line count 2 vs 5 · auch: de_english

### `programs/platform/desktop/frontends/synology-dsm/` · 1

- [ ] `programs/platform/desktop/frontends/synology-dsm/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/platform/desktop/frontends/truenas/` · 1

- [ ] `programs/platform/desktop/frontends/truenas/index.md` · 1.4k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/platform/desktop/frontends/unraid/` · 1

- [ ] `programs/platform/desktop/frontends/unraid/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/platform/desktop/frontends/unraid/latest/` · 1

- [ ] `programs/platform/desktop/frontends/unraid/latest/layout.md` · 7.9k · Parität: box frames broken en=1 de=0

### `programs/suites/crm/` · 2

- [ ] `programs/suites/crm/index.md` · 4.5k · Plan[~] · Parität: links en-only=['frontends/attio/index.md', 'frontends/twenty/index.md'] de-only=[] · hash changed since verification
- [ ] `programs/suites/crm/requirements.md` · 1.0k · Parität: table rows 7 vs 4 · hash changed since verification

### `programs/suites/crm/frontends/` · 1

- [ ] `programs/suites/crm/frontends/index.md` · 4.2k · Parität: table rows 10 vs 8; links en-only=['attio/index.md', 'attio/latest/description.md', 'twenty/index.md'] de-only=[] · hash changed since verification

### `programs/suites/crm/frontends/attio/latest/` · 4

- [ ] `programs/suites/crm/frontends/attio/latest/api.md` · 175b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/crm/frontends/attio/latest/layout.md` · 34b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/crm/frontends/attio/latest/menus.md` · 33b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/crm/frontends/attio/latest/shortcuts.md` · 50b · Parität: line count 2 vs 5 · auch: de_english

### `programs/suites/crm/frontends/civicrm/` · 1

- [ ] `programs/suites/crm/frontends/civicrm/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/crm/frontends/espocrm/` · 1

- [ ] `programs/suites/crm/frontends/espocrm/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/crm/frontends/hubspot/` · 1

- [ ] `programs/suites/crm/frontends/hubspot/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/crm/frontends/pipedrive/` · 1

- [ ] `programs/suites/crm/frontends/pipedrive/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/crm/frontends/salesforce/` · 1

- [ ] `programs/suites/crm/frontends/salesforce/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/crm/frontends/suitecrm/` · 1

- [ ] `programs/suites/crm/frontends/suitecrm/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/crm/frontends/twenty/latest/` · 3

- [ ] `programs/suites/crm/frontends/twenty/latest/layout.md` · 101b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/crm/frontends/twenty/latest/menus.md` · 34b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/crm/frontends/twenty/latest/shortcuts.md` · 51b · Parität: line count 2 vs 5 · auch: de_english

### `programs/suites/democracy/` · 1

- [ ] `programs/suites/democracy/requirements.md` · 3.4k · Parität: headings 5 vs 4; table rows 20 vs 4 · hash changed since verification

### `programs/suites/democracy/frontends/adhocracy4/` · 1

- [ ] `programs/suites/democracy/frontends/adhocracy4/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/democracy/frontends/circo/` · 1

- [ ] `programs/suites/democracy/frontends/circo/index.md` · 1.4k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/democracy/frontends/consul/` · 1

- [ ] `programs/suites/democracy/frontends/consul/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/democracy/frontends/consul/latest/` · 1

- [ ] `programs/suites/democracy/frontends/consul/latest/layout.md` · 1.5k · Parität: box frames broken en=1 de=0

### `programs/suites/democracy/frontends/decidim/` · 1

- [ ] `programs/suites/democracy/frontends/decidim/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/democracy/frontends/liquid-feedback/` · 1

- [ ] `programs/suites/democracy/frontends/liquid-feedback/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/democracy/frontends/polis/` · 1

- [ ] `programs/suites/democracy/frontends/polis/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/erp/frontends/axelor/` · 1

- [ ] `programs/suites/erp/frontends/axelor/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/erp/frontends/dolibarr/` · 1

- [ ] `programs/suites/erp/frontends/dolibarr/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/erp/frontends/erpnext/` · 1

- [ ] `programs/suites/erp/frontends/erpnext/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/erp/frontends/odoo/` · 1

- [ ] `programs/suites/erp/frontends/odoo/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/erp/frontends/sage/` · 1

- [ ] `programs/suites/erp/frontends/sage/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/erp/frontends/tryton/` · 1

- [ ] `programs/suites/erp/frontends/tryton/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/marketplace/frontends/arcemall/` · 1

- [ ] `programs/suites/marketplace/frontends/arcemall/index.md` · 1.4k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/marketplace/frontends/cs-cart-multivendor/` · 1

- [ ] `programs/suites/marketplace/frontends/cs-cart-multivendor/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/marketplace/frontends/ebay/` · 1

- [ ] `programs/suites/marketplace/frontends/ebay/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/marketplace/frontends/etsy/` · 1

- [ ] `programs/suites/marketplace/frontends/etsy/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/marketplace/frontends/kleinanzeigen/` · 1

- [ ] `programs/suites/marketplace/frontends/kleinanzeigen/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/marketplace/frontends/sharetribe/` · 1

- [ ] `programs/suites/marketplace/frontends/sharetribe/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/projectmanagement/` · 1

- [ ] `programs/suites/projectmanagement/index.md` · 4.7k · Parität: links en-only=['../apps/roadmap.md', '../apps/tasks/index.md'] de-only=['frontends/jira/index.md']

### `programs/suites/projectmanagement/frontends/` · 1

- [ ] `programs/suites/projectmanagement/frontends/index.md` · 4.1k · Parität: table rows 9 vs 10; links en-only=[] de-only=['jira/index.md', 'jira/latest/description.md']

### `programs/suites/projectmanagement/frontends/jira/` · 1

- [ ] `programs/suites/projectmanagement/frontends/jira/index.md` · 369b · Parität: headings 1 vs 5; table rows 0 vs 11

### `programs/suites/workflows/` · 2

- [ ] `programs/suites/workflows/index.md` · 4.8k · Plan[~] · Parität: links en-only=['frontends/apple-shortcuts/index.md', 'frontends/huginn/index.md', 'frontends/power-automate/index.md'] de-only=[] · hash changed since verification
- [ ] `programs/suites/workflows/requirements.md` · 1.0k · Parität: table rows 9 vs 4 · hash changed since verification

### `programs/suites/workflows/frontends/` · 1

- [ ] `programs/suites/workflows/frontends/index.md` · 4.8k · Parität: table rows 12 vs 8; links en-only=['apple-shortcuts/index.md', 'apple-shortcuts/latest/description.md', 'huginn/index.md'] de-only=[] · hash changed since verification

### `programs/suites/workflows/frontends/apache-airflow/` · 1

- [ ] `programs/suites/workflows/frontends/apache-airflow/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/workflows/frontends/apple-shortcuts/latest/` · 4

- [ ] `programs/suites/workflows/frontends/apple-shortcuts/latest/api.md` · 271b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/workflows/frontends/apple-shortcuts/latest/layout.md` · 141b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/workflows/frontends/apple-shortcuts/latest/menus.md` · 47b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/workflows/frontends/apple-shortcuts/latest/shortcuts.md` · 177b · Parität: line count 2 vs 5 · auch: de_english

### `programs/suites/workflows/frontends/huginn/latest/` · 4

- [ ] `programs/suites/workflows/frontends/huginn/latest/api.md` · 170b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/workflows/frontends/huginn/latest/layout.md` · 150b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/workflows/frontends/huginn/latest/menus.md` · 38b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/workflows/frontends/huginn/latest/shortcuts.md` · 73b · Parität: line count 2 vs 5 · auch: de_english

### `programs/suites/workflows/frontends/make/` · 1

- [ ] `programs/suites/workflows/frontends/make/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/workflows/frontends/n8n/` · 1

- [ ] `programs/suites/workflows/frontends/n8n/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/workflows/frontends/node-red/` · 1

- [ ] `programs/suites/workflows/frontends/node-red/index.md` · 1.3k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/workflows/frontends/power-automate/latest/` · 4

- [ ] `programs/suites/workflows/frontends/power-automate/latest/api.md` · 151b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/workflows/frontends/power-automate/latest/layout.md` · 306b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/workflows/frontends/power-automate/latest/menus.md` · 275b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/workflows/frontends/power-automate/latest/shortcuts.md` · 79b · Parität: line count 2 vs 5 · auch: de_english

### `programs/suites/workflows/frontends/prefect/` · 1

- [ ] `programs/suites/workflows/frontends/prefect/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

### `programs/suites/workflows/frontends/windmill/latest/` · 4

- [ ] `programs/suites/workflows/frontends/windmill/latest/api.md` · 212b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/workflows/frontends/windmill/latest/layout.md` · 153b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/workflows/frontends/windmill/latest/menus.md` · 40b · Parität: line count 2 vs 5 · auch: de_english
- [ ] `programs/suites/workflows/frontends/windmill/latest/shortcuts.md` · 75b · Parität: line count 2 vs 5 · auch: de_english

### `programs/suites/workflows/frontends/zapier/` · 1

- [ ] `programs/suites/workflows/frontends/zapier/index.md` · 1.2k · Parität: headings 5 vs 3; table rows 11 vs 0

## H. Beide Seiten da, kein Befund – lesen und bestätigen – 1207 Dateien

### `(wurzel)/` · 2

- [ ] `index.md` · 5.3k · hash changed since verification
- [ ] `manifesto.md` · 7.3k

### `components/` · 3

- [ ] `components/charts.md` · 2.0k
- [ ] `components/index.md` · 6.7k · hash changed since verification
- [ ] `components/planned.md` · 4.0k

### `components/primitives/` · 1

- [ ] `components/primitives/index.md` · 2.5k · hash changed since verification

### `components/primitives/actions/` · 1

- [ ] `components/primitives/actions/index.md` · 1.1k · hash changed since verification

### `components/primitives/actions/button/` · 5

- [ ] `components/primitives/actions/button/appearance.md` · 2.3k · hash changed since verification
- [ ] `components/primitives/actions/button/attributes.md` · 1.7k · hash changed since verification
- [ ] `components/primitives/actions/button/description.md` · 2.3k · hash changed since verification
- [ ] `components/primitives/actions/button/index.md` · 324b
- [ ] `components/primitives/actions/button/usage.md` · 1.2k · hash changed since verification

### `components/primitives/actions/button-group/` · 5

- [ ] `components/primitives/actions/button-group/appearance.md` · 2.0k · hash changed since verification
- [ ] `components/primitives/actions/button-group/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/primitives/actions/button-group/description.md` · 2.1k · hash changed since verification
- [ ] `components/primitives/actions/button-group/index.md` · 354b
- [ ] `components/primitives/actions/button-group/usage.md` · 1.3k · hash changed since verification

### `components/primitives/actions/floating-action-button/` · 5

- [ ] `components/primitives/actions/floating-action-button/appearance.md` · 2.4k · hash changed since verification
- [ ] `components/primitives/actions/floating-action-button/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/primitives/actions/floating-action-button/description.md` · 1.9k · hash changed since verification
- [ ] `components/primitives/actions/floating-action-button/index.md` · 416b
- [ ] `components/primitives/actions/floating-action-button/usage.md` · 1.6k · hash changed since verification

### `components/primitives/basics/` · 2

- [ ] `components/primitives/basics/base.md` · 5.9k · hash changed since verification
- [ ] `components/primitives/basics/index.md` · 1.3k · hash changed since verification

### `components/primitives/basics/kbd/` · 5

- [ ] `components/primitives/basics/kbd/appearance.md` · 1.1k · hash changed since verification
- [ ] `components/primitives/basics/kbd/attributes.md` · 919b · hash changed since verification
- [ ] `components/primitives/basics/kbd/description.md` · 1.7k · hash changed since verification
- [ ] `components/primitives/basics/kbd/index.md` · 309b
- [ ] `components/primitives/basics/kbd/usage.md` · 936b · hash changed since verification

### `components/primitives/basics/label/` · 5

- [ ] `components/primitives/basics/label/appearance.md` · 1.3k · hash changed since verification
- [ ] `components/primitives/basics/label/attributes.md` · 1007b · hash changed since verification
- [ ] `components/primitives/basics/label/description.md` · 1.8k · hash changed since verification
- [ ] `components/primitives/basics/label/index.md` · 319b
- [ ] `components/primitives/basics/label/usage.md` · 893b · hash changed since verification

### `components/primitives/basics/link/` · 5

- [ ] `components/primitives/basics/link/appearance.md` · 1.2k · hash changed since verification
- [ ] `components/primitives/basics/link/attributes.md` · 1.4k · hash changed since verification
- [ ] `components/primitives/basics/link/description.md` · 1.9k · hash changed since verification
- [ ] `components/primitives/basics/link/index.md` · 314b
- [ ] `components/primitives/basics/link/usage.md` · 940b · hash changed since verification

### `components/primitives/basics/separator/` · 5

- [ ] `components/primitives/basics/separator/appearance.md` · 1.4k · hash changed since verification
- [ ] `components/primitives/basics/separator/attributes.md` · 1.1k · hash changed since verification
- [ ] `components/primitives/basics/separator/description.md` · 2.0k · hash changed since verification
- [ ] `components/primitives/basics/separator/index.md` · 339b
- [ ] `components/primitives/basics/separator/usage.md` · 1.0k · hash changed since verification

### `components/primitives/feedback/` · 1

- [ ] `components/primitives/feedback/index.md` · 2.3k · hash changed since verification

### `components/primitives/feedback/alert/` · 5

- [ ] `components/primitives/feedback/alert/appearance.md` · 2.6k · hash changed since verification
- [ ] `components/primitives/feedback/alert/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/primitives/feedback/alert/description.md` · 1.6k · hash changed since verification
- [ ] `components/primitives/feedback/alert/index.md` · 319b
- [ ] `components/primitives/feedback/alert/usage.md` · 895b · hash changed since verification

### `components/primitives/feedback/badge/` · 5

- [ ] `components/primitives/feedback/badge/appearance.md` · 1.7k · hash changed since verification
- [ ] `components/primitives/feedback/badge/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/primitives/feedback/badge/description.md` · 2.0k · hash changed since verification
- [ ] `components/primitives/feedback/badge/index.md` · 319b
- [ ] `components/primitives/feedback/badge/usage.md` · 1.0k · hash changed since verification

### `components/primitives/feedback/empty-state/` · 5

- [ ] `components/primitives/feedback/empty-state/appearance.md` · 1.6k · hash changed since verification
- [ ] `components/primitives/feedback/empty-state/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/primitives/feedback/empty-state/description.md` · 1.7k · hash changed since verification
- [ ] `components/primitives/feedback/empty-state/index.md` · 349b
- [ ] `components/primitives/feedback/empty-state/usage.md` · 1004b · hash changed since verification

### `components/primitives/feedback/encryption-state/` · 5

- [ ] `components/primitives/feedback/encryption-state/appearance.md` · 1.1k
- [ ] `components/primitives/feedback/encryption-state/attributes.md` · 1.2k
- [ ] `components/primitives/feedback/encryption-state/description.md` · 2.8k
- [ ] `components/primitives/feedback/encryption-state/index.md` · 374b
- [ ] `components/primitives/feedback/encryption-state/usage.md` · 1.3k

### `components/primitives/feedback/message-status/` · 5

- [ ] `components/primitives/feedback/message-status/appearance.md` · 1.1k
- [ ] `components/primitives/feedback/message-status/attributes.md` · 1.3k
- [ ] `components/primitives/feedback/message-status/description.md` · 2.9k
- [ ] `components/primitives/feedback/message-status/index.md` · 364b
- [ ] `components/primitives/feedback/message-status/usage.md` · 1.5k

### `components/primitives/feedback/progress/` · 5

- [ ] `components/primitives/feedback/progress/appearance.md` · 1.6k · hash changed since verification
- [ ] `components/primitives/feedback/progress/attributes.md` · 1.4k · hash changed since verification
- [ ] `components/primitives/feedback/progress/description.md` · 1.8k · hash changed since verification
- [ ] `components/primitives/feedback/progress/index.md` · 334b
- [ ] `components/primitives/feedback/progress/usage.md` · 1.0k · hash changed since verification

### `components/primitives/feedback/skeleton/` · 5

- [ ] `components/primitives/feedback/skeleton/appearance.md` · 1.6k · hash changed since verification
- [ ] `components/primitives/feedback/skeleton/attributes.md` · 1.1k · hash changed since verification
- [ ] `components/primitives/feedback/skeleton/description.md` · 2.2k · hash changed since verification
- [ ] `components/primitives/feedback/skeleton/index.md` · 334b
- [ ] `components/primitives/feedback/skeleton/usage.md` · 1012b · hash changed since verification

### `components/primitives/feedback/spinner/` · 5

- [ ] `components/primitives/feedback/spinner/appearance.md` · 1.1k · hash changed since verification
- [ ] `components/primitives/feedback/spinner/attributes.md` · 963b · hash changed since verification
- [ ] `components/primitives/feedback/spinner/description.md` · 1.8k · hash changed since verification
- [ ] `components/primitives/feedback/spinner/index.md` · 329b
- [ ] `components/primitives/feedback/spinner/usage.md` · 944b · hash changed since verification

### `components/primitives/feedback/toast/` · 5

- [ ] `components/primitives/feedback/toast/appearance.md` · 2.6k · hash changed since verification
- [ ] `components/primitives/feedback/toast/attributes.md` · 1.6k · hash changed since verification
- [ ] `components/primitives/feedback/toast/description.md` · 2.2k · hash changed since verification
- [ ] `components/primitives/feedback/toast/index.md` · 319b
- [ ] `components/primitives/feedback/toast/usage.md` · 633b · hash changed since verification

### `components/primitives/fields/` · 1

- [ ] `components/primitives/fields/index.md` · 4.0k · hash changed since verification

### `components/primitives/fields/checkbox/` · 5

- [ ] `components/primitives/fields/checkbox/appearance.md` · 1.9k · hash changed since verification
- [ ] `components/primitives/fields/checkbox/attributes.md` · 1.0k · hash changed since verification
- [ ] `components/primitives/fields/checkbox/description.md` · 1.6k · hash changed since verification
- [ ] `components/primitives/fields/checkbox/index.md` · 334b
- [ ] `components/primitives/fields/checkbox/usage.md` · 2.8k · hash changed since verification

### `components/primitives/fields/color-input/` · 4

- [ ] `components/primitives/fields/color-input/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/primitives/fields/color-input/description.md` · 1.7k · hash changed since verification
- [ ] `components/primitives/fields/color-input/index.md` · 349b
- [ ] `components/primitives/fields/color-input/usage.md` · 656b · hash changed since verification

### `components/primitives/fields/combobox/` · 5

- [ ] `components/primitives/fields/combobox/appearance.md` · 3.3k · hash changed since verification
- [ ] `components/primitives/fields/combobox/attributes.md` · 1.2k · hash changed since verification
- [ ] `components/primitives/fields/combobox/description.md` · 2.0k · hash changed since verification
- [ ] `components/primitives/fields/combobox/index.md` · 334b
- [ ] `components/primitives/fields/combobox/usage.md` · 615b · hash changed since verification

### `components/primitives/fields/date-input/` · 5

- [ ] `components/primitives/fields/date-input/appearance.md` · 2.8k · hash changed since verification
- [ ] `components/primitives/fields/date-input/attributes.md` · 1.7k · hash changed since verification
- [ ] `components/primitives/fields/date-input/description.md` · 2.1k · hash changed since verification
- [ ] `components/primitives/fields/date-input/index.md` · 344b
- [ ] `components/primitives/fields/date-input/usage.md` · 690b · hash changed since verification

### `components/primitives/fields/field/` · 5

- [ ] `components/primitives/fields/field/appearance.md` · 1.8k · hash changed since verification
- [ ] `components/primitives/fields/field/attributes.md` · 1.6k · hash changed since verification
- [ ] `components/primitives/fields/field/description.md` · 2.2k · hash changed since verification
- [ ] `components/primitives/fields/field/index.md` · 319b
- [ ] `components/primitives/fields/field/usage.md` · 1.1k · hash changed since verification

### `components/primitives/fields/input-group/` · 5

- [ ] `components/primitives/fields/input-group/appearance.md` · 2.6k · hash changed since verification
- [ ] `components/primitives/fields/input-group/attributes.md` · 1.7k · hash changed since verification
- [ ] `components/primitives/fields/input-group/description.md` · 2.8k · hash changed since verification
- [ ] `components/primitives/fields/input-group/index.md` · 349b
- [ ] `components/primitives/fields/input-group/usage.md` · 1.5k · hash changed since verification

### `components/primitives/fields/mention-input/` · 5

- [ ] `components/primitives/fields/mention-input/appearance.md` · 2.5k · hash changed since verification
- [ ] `components/primitives/fields/mention-input/attributes.md` · 1.2k · hash changed since verification
- [ ] `components/primitives/fields/mention-input/description.md` · 1.8k · hash changed since verification
- [ ] `components/primitives/fields/mention-input/index.md` · 359b
- [ ] `components/primitives/fields/mention-input/usage.md` · 618b · hash changed since verification

### `components/primitives/fields/number-input/` · 5

- [ ] `components/primitives/fields/number-input/appearance.md` · 2.4k · hash changed since verification
- [ ] `components/primitives/fields/number-input/attributes.md` · 1.2k · hash changed since verification
- [ ] `components/primitives/fields/number-input/description.md` · 1.8k · hash changed since verification
- [ ] `components/primitives/fields/number-input/index.md` · 354b
- [ ] `components/primitives/fields/number-input/usage.md` · 536b · hash changed since verification

### `components/primitives/fields/otp-input/` · 5

- [ ] `components/primitives/fields/otp-input/appearance.md` · 1.4k · hash changed since verification
- [ ] `components/primitives/fields/otp-input/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/primitives/fields/otp-input/description.md` · 1.7k · hash changed since verification
- [ ] `components/primitives/fields/otp-input/index.md` · 419b
- [ ] `components/primitives/fields/otp-input/usage.md` · 857b · hash changed since verification

### `components/primitives/fields/radio-group/` · 5

- [ ] `components/primitives/fields/radio-group/appearance.md` · 2.0k · hash changed since verification
- [ ] `components/primitives/fields/radio-group/attributes.md` · 1.1k · hash changed since verification
- [ ] `components/primitives/fields/radio-group/description.md` · 1.6k · hash changed since verification
- [ ] `components/primitives/fields/radio-group/index.md` · 349b
- [ ] `components/primitives/fields/radio-group/usage.md` · 538b · hash changed since verification

### `components/primitives/fields/rating/` · 4

- [ ] `components/primitives/fields/rating/appearance.md` · 2.5k · hash changed since verification
- [ ] `components/primitives/fields/rating/attributes.md` · 1.1k · hash changed since verification
- [ ] `components/primitives/fields/rating/description.md` · 1.7k · hash changed since verification
- [ ] `components/primitives/fields/rating/index.md` · 324b

### `components/primitives/fields/search-field/` · 5

- [ ] `components/primitives/fields/search-field/appearance.md` · 2.3k · hash changed since verification
- [ ] `components/primitives/fields/search-field/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/primitives/fields/search-field/description.md` · 2.1k · hash changed since verification
- [ ] `components/primitives/fields/search-field/index.md` · 354b
- [ ] `components/primitives/fields/search-field/usage.md` · 3.5k · hash changed since verification

### `components/primitives/fields/select/` · 4

- [ ] `components/primitives/fields/select/appearance.md` · 2.1k · hash changed since verification
- [ ] `components/primitives/fields/select/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/primitives/fields/select/description.md` · 1.9k · hash changed since verification
- [ ] `components/primitives/fields/select/index.md` · 324b

### `components/primitives/fields/slider/` · 5

- [ ] `components/primitives/fields/slider/appearance.md` · 2.8k · hash changed since verification
- [ ] `components/primitives/fields/slider/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/primitives/fields/slider/description.md` · 1.9k · hash changed since verification
- [ ] `components/primitives/fields/slider/index.md` · 324b
- [ ] `components/primitives/fields/slider/usage.md` · 478b · hash changed since verification

### `components/primitives/fields/switch/` · 5

- [ ] `components/primitives/fields/switch/appearance.md` · 2.5k · hash changed since verification
- [ ] `components/primitives/fields/switch/attributes.md` · 1.0k · hash changed since verification
- [ ] `components/primitives/fields/switch/description.md` · 1.6k · hash changed since verification
- [ ] `components/primitives/fields/switch/index.md` · 324b
- [ ] `components/primitives/fields/switch/usage.md` · 575b · hash changed since verification

### `components/primitives/fields/tags-input/` · 5

- [ ] `components/primitives/fields/tags-input/appearance.md` · 2.7k · hash changed since verification
- [ ] `components/primitives/fields/tags-input/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/primitives/fields/tags-input/description.md` · 1.7k · hash changed since verification
- [ ] `components/primitives/fields/tags-input/index.md` · 344b
- [ ] `components/primitives/fields/tags-input/usage.md` · 602b · hash changed since verification

### `components/primitives/fields/text-input/` · 4

- [ ] `components/primitives/fields/text-input/appearance.md` · 3.3k · hash changed since verification
- [ ] `components/primitives/fields/text-input/attributes.md` · 2.0k · hash changed since verification
- [ ] `components/primitives/fields/text-input/description.md` · 2.4k · hash changed since verification
- [ ] `components/primitives/fields/text-input/index.md` · 344b

### `components/primitives/fields/textarea/` · 4

- [ ] `components/primitives/fields/textarea/appearance.md` · 2.8k · hash changed since verification
- [ ] `components/primitives/fields/textarea/attributes.md` · 1.4k · hash changed since verification
- [ ] `components/primitives/fields/textarea/description.md` · 1.9k · hash changed since verification
- [ ] `components/primitives/fields/textarea/index.md` · 334b

### `components/primitives/media/` · 1

- [ ] `components/primitives/media/index.md` · 793b · hash changed since verification

### `components/primitives/media/icon/` · 5

- [ ] `components/primitives/media/icon/appearance.md` · 2.7k · hash changed since verification
- [ ] `components/primitives/media/icon/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/primitives/media/icon/description.md` · 3.1k · hash changed since verification
- [ ] `components/primitives/media/icon/index.md` · 314b
- [ ] `components/primitives/media/icon/usage.md` · 3.5k · hash changed since verification

### `components/primitives/media/image/` · 5

- [ ] `components/primitives/media/image/appearance.md` · 2.8k · hash changed since verification
- [ ] `components/primitives/media/image/attributes.md` · 2.5k · hash changed since verification
- [ ] `components/primitives/media/image/description.md` · 3.5k · hash changed since verification
- [ ] `components/primitives/media/image/index.md` · 319b
- [ ] `components/primitives/media/image/usage.md` · 7.3k · hash changed since verification

### `components/widgets/` · 1

- [ ] `components/widgets/index.md` · 3.5k · hash changed since verification

### `components/widgets/containers/` · 1

- [ ] `components/widgets/containers/index.md` · 1.7k · hash changed since verification

### `components/widgets/containers/accordion/` · 5

- [ ] `components/widgets/containers/accordion/appearance.md` · 2.5k · hash changed since verification
- [ ] `components/widgets/containers/accordion/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/widgets/containers/accordion/description.md` · 2.6k · hash changed since verification
- [ ] `components/widgets/containers/accordion/index.md` · 339b
- [ ] `components/widgets/containers/accordion/usage.md` · 663b · hash changed since verification

### `components/widgets/containers/card/` · 5

- [ ] `components/widgets/containers/card/appearance.md` · 1.7k · hash changed since verification
- [ ] `components/widgets/containers/card/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/widgets/containers/card/description.md` · 2.3k · hash changed since verification
- [ ] `components/widgets/containers/card/index.md` · 314b
- [ ] `components/widgets/containers/card/usage.md` · 830b · hash changed since verification

### `components/widgets/containers/panel/` · 5

- [ ] `components/widgets/containers/panel/appearance.md` · 2.2k · hash changed since verification
- [ ] `components/widgets/containers/panel/attributes.md` · 1.1k · hash changed since verification
- [ ] `components/widgets/containers/panel/description.md` · 2.8k · hash changed since verification
- [ ] `components/widgets/containers/panel/index.md` · 319b
- [ ] `components/widgets/containers/panel/usage.md` · 642b · hash changed since verification

### `components/widgets/containers/scroll-area/` · 5

- [ ] `components/widgets/containers/scroll-area/appearance.md` · 1.6k · hash changed since verification
- [ ] `components/widgets/containers/scroll-area/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/widgets/containers/scroll-area/description.md` · 1.8k · hash changed since verification
- [ ] `components/widgets/containers/scroll-area/index.md` · 349b
- [ ] `components/widgets/containers/scroll-area/usage.md` · 955b · hash changed since verification

### `components/widgets/containers/split-view/` · 5

- [ ] `components/widgets/containers/split-view/appearance.md` · 1.4k · hash changed since verification
- [ ] `components/widgets/containers/split-view/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/widgets/containers/split-view/description.md` · 2.4k · hash changed since verification
- [ ] `components/widgets/containers/split-view/index.md` · 344b
- [ ] `components/widgets/containers/split-view/usage.md` · 633b · hash changed since verification

### `components/widgets/containers/wizard/` · 5

- [ ] `components/widgets/containers/wizard/appearance.md` · 2.2k · hash changed since verification
- [ ] `components/widgets/containers/wizard/attributes.md` · 1.7k · hash changed since verification
- [ ] `components/widgets/containers/wizard/description.md` · 2.7k · hash changed since verification
- [ ] `components/widgets/containers/wizard/index.md` · 324b
- [ ] `components/widgets/containers/wizard/usage.md` · 709b · hash changed since verification

### `components/widgets/data/` · 1

- [ ] `components/widgets/data/index.md` · 3.9k · hash changed since verification

### `components/widgets/data/avatar/` · 5

- [ ] `components/widgets/data/avatar/appearance.md` · 2.0k · hash changed since verification
- [ ] `components/widgets/data/avatar/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/widgets/data/avatar/description.md` · 2.5k · hash changed since verification
- [ ] `components/widgets/data/avatar/index.md` · 324b
- [ ] `components/widgets/data/avatar/usage.md` · 4.9k · hash changed since verification

### `components/widgets/data/calendar-view/` · 5

- [ ] `components/widgets/data/calendar-view/appearance.md` · 1.9k · hash changed since verification
- [ ] `components/widgets/data/calendar-view/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/widgets/data/calendar-view/description.md` · 2.3k · hash changed since verification
- [ ] `components/widgets/data/calendar-view/index.md` · 359b
- [ ] `components/widgets/data/calendar-view/usage.md` · 623b · hash changed since verification

### `components/widgets/data/chart/` · 5

- [ ] `components/widgets/data/chart/appearance.md` · 3.2k · hash changed since verification
- [ ] `components/widgets/data/chart/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/widgets/data/chart/description.md` · 2.1k · hash changed since verification
- [ ] `components/widgets/data/chart/index.md` · 319b
- [ ] `components/widgets/data/chart/usage.md` · 540b · hash changed since verification

### `components/widgets/data/description-list/` · 5

- [ ] `components/widgets/data/description-list/appearance.md` · 1.3k · hash changed since verification
- [ ] `components/widgets/data/description-list/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/widgets/data/description-list/description.md` · 1.8k · hash changed since verification
- [ ] `components/widgets/data/description-list/index.md` · 374b
- [ ] `components/widgets/data/description-list/usage.md` · 841b · hash changed since verification

### `components/widgets/data/grid-view/` · 5

- [ ] `components/widgets/data/grid-view/appearance.md` · 1.9k · hash changed since verification
- [ ] `components/widgets/data/grid-view/attributes.md` · 1.4k · hash changed since verification
- [ ] `components/widgets/data/grid-view/description.md` · 2.0k · hash changed since verification
- [ ] `components/widgets/data/grid-view/index.md` · 339b
- [ ] `components/widgets/data/grid-view/usage.md` · 567b · hash changed since verification

### `components/widgets/data/link-preview/` · 5

- [ ] `components/widgets/data/link-preview/appearance.md` · 1.1k
- [ ] `components/widgets/data/link-preview/attributes.md` · 1.2k
- [ ] `components/widgets/data/link-preview/description.md` · 2.3k
- [ ] `components/widgets/data/link-preview/index.md` · 354b
- [ ] `components/widgets/data/link-preview/usage.md` · 1.1k

### `components/widgets/data/list-view/` · 5

- [ ] `components/widgets/data/list-view/appearance.md` · 2.3k · hash changed since verification
- [ ] `components/widgets/data/list-view/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/widgets/data/list-view/description.md` · 2.1k · hash changed since verification
- [ ] `components/widgets/data/list-view/index.md` · 339b
- [ ] `components/widgets/data/list-view/usage.md` · 3.0k · hash changed since verification

### `components/widgets/data/mail-view/` · 5

- [ ] `components/widgets/data/mail-view/appearance.md` · 1.8k
- [ ] `components/widgets/data/mail-view/attributes.md` · 1.3k
- [ ] `components/widgets/data/mail-view/description.md` · 2.7k
- [ ] `components/widgets/data/mail-view/index.md` · 339b
- [ ] `components/widgets/data/mail-view/usage.md` · 1.2k

### `components/widgets/data/message-bubble/` · 5

- [ ] `components/widgets/data/message-bubble/appearance.md` · 1.3k
- [ ] `components/widgets/data/message-bubble/attributes.md` · 1.4k
- [ ] `components/widgets/data/message-bubble/description.md` · 2.7k
- [ ] `components/widgets/data/message-bubble/index.md` · 364b
- [ ] `components/widgets/data/message-bubble/usage.md` · 1.3k

### `components/widgets/data/message-list/` · 5

- [ ] `components/widgets/data/message-list/appearance.md` · 1.9k
- [ ] `components/widgets/data/message-list/attributes.md` · 1.4k
- [ ] `components/widgets/data/message-list/description.md` · 2.9k
- [ ] `components/widgets/data/message-list/index.md` · 354b
- [ ] `components/widgets/data/message-list/usage.md` · 1.4k

### `components/widgets/data/reaction-bar/` · 5

- [ ] `components/widgets/data/reaction-bar/appearance.md` · 818b
- [ ] `components/widgets/data/reaction-bar/attributes.md` · 1.2k
- [ ] `components/widgets/data/reaction-bar/description.md` · 2.2k
- [ ] `components/widgets/data/reaction-bar/index.md` · 354b
- [ ] `components/widgets/data/reaction-bar/usage.md` · 1.1k

### `components/widgets/data/repeater/` · 5

- [ ] `components/widgets/data/repeater/appearance.md` · 2.1k · hash changed since verification
- [ ] `components/widgets/data/repeater/attributes.md` · 1.4k · hash changed since verification
- [ ] `components/widgets/data/repeater/description.md` · 1.8k · hash changed since verification
- [ ] `components/widgets/data/repeater/index.md` · 334b
- [ ] `components/widgets/data/repeater/usage.md` · 512b · hash changed since verification

### `components/widgets/data/table/` · 4

- [ ] `components/widgets/data/table/attributes.md` · 1.9k · hash changed since verification
- [ ] `components/widgets/data/table/description.md` · 2.2k · hash changed since verification
- [ ] `components/widgets/data/table/index.md` · 319b
- [ ] `components/widgets/data/table/usage.md` · 4.4k · hash changed since verification

### `components/widgets/data/table-of-contents/` · 5

- [ ] `components/widgets/data/table-of-contents/appearance.md` · 2.5k · hash changed since verification
- [ ] `components/widgets/data/table-of-contents/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/widgets/data/table-of-contents/description.md` · 2.7k · hash changed since verification
- [ ] `components/widgets/data/table-of-contents/index.md` · 379b
- [ ] `components/widgets/data/table-of-contents/usage.md` · 594b · hash changed since verification

### `components/widgets/data/timeline/` · 5

- [ ] `components/widgets/data/timeline/appearance.md` · 2.0k · hash changed since verification
- [ ] `components/widgets/data/timeline/attributes.md` · 1.0k · hash changed since verification
- [ ] `components/widgets/data/timeline/description.md` · 2.9k · hash changed since verification
- [ ] `components/widgets/data/timeline/index.md` · 334b
- [ ] `components/widgets/data/timeline/usage.md` · 549b · hash changed since verification

### `components/widgets/data/tree-view/` · 5

- [ ] `components/widgets/data/tree-view/appearance.md` · 2.2k · hash changed since verification
- [ ] `components/widgets/data/tree-view/attributes.md` · 1.6k · hash changed since verification
- [ ] `components/widgets/data/tree-view/description.md` · 2.0k · hash changed since verification
- [ ] `components/widgets/data/tree-view/index.md` · 339b
- [ ] `components/widgets/data/tree-view/usage.md` · 4.5k · hash changed since verification

### `components/widgets/fields/` · 1

- [ ] `components/widgets/fields/index.md` · 1.7k · hash changed since verification

### `components/widgets/fields/date-picker/` · 2

- [ ] `components/widgets/fields/date-picker/appearance.md` · 3.5k · hash changed since verification
- [ ] `components/widgets/fields/date-picker/index.md` · 349b

### `components/widgets/fields/emoji-picker/` · 5

- [ ] `components/widgets/fields/emoji-picker/appearance.md` · 2.8k · hash changed since verification
- [ ] `components/widgets/fields/emoji-picker/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/widgets/fields/emoji-picker/description.md` · 1.9k · hash changed since verification
- [ ] `components/widgets/fields/emoji-picker/index.md` · 354b
- [ ] `components/widgets/fields/emoji-picker/usage.md` · 613b · hash changed since verification

### `components/widgets/fields/file-upload/` · 4

- [ ] `components/widgets/fields/file-upload/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/widgets/fields/file-upload/description.md` · 1.8k · hash changed since verification
- [ ] `components/widgets/fields/file-upload/index.md` · 349b
- [ ] `components/widgets/fields/file-upload/usage.md` · 558b · hash changed since verification

### `components/widgets/fields/range-calendar/` · 5

- [ ] `components/widgets/fields/range-calendar/appearance.md` · 1.8k · hash changed since verification
- [ ] `components/widgets/fields/range-calendar/attributes.md` · 1.4k · hash changed since verification
- [ ] `components/widgets/fields/range-calendar/description.md` · 1.7k · hash changed since verification
- [ ] `components/widgets/fields/range-calendar/index.md` · 364b
- [ ] `components/widgets/fields/range-calendar/usage.md` · 832b · hash changed since verification

### `components/widgets/fields/rule-editor/` · 5

- [ ] `components/widgets/fields/rule-editor/appearance.md` · 1.3k
- [ ] `components/widgets/fields/rule-editor/attributes.md` · 1.3k
- [ ] `components/widgets/fields/rule-editor/description.md` · 2.5k
- [ ] `components/widgets/fields/rule-editor/index.md` · 349b
- [ ] `components/widgets/fields/rule-editor/usage.md` · 1.2k

### `components/widgets/fields/time-picker/` · 5

- [ ] `components/widgets/fields/time-picker/appearance.md` · 1.3k · hash changed since verification
- [ ] `components/widgets/fields/time-picker/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/widgets/fields/time-picker/description.md` · 1.6k · hash changed since verification
- [ ] `components/widgets/fields/time-picker/index.md` · 349b
- [ ] `components/widgets/fields/time-picker/usage.md` · 855b · hash changed since verification

### `components/widgets/media/` · 1

- [ ] `components/widgets/media/index.md` · 1.6k · hash changed since verification

### `components/widgets/media/audio/` · 5

- [ ] `components/widgets/media/audio/appearance.md` · 2.3k · hash changed since verification
- [ ] `components/widgets/media/audio/attributes.md` · 2.1k · hash changed since verification
- [ ] `components/widgets/media/audio/description.md` · 2.7k · hash changed since verification
- [ ] `components/widgets/media/audio/index.md` · 319b
- [ ] `components/widgets/media/audio/usage.md` · 7.4k · hash changed since verification

### `components/widgets/media/call-controls/` · 5

- [ ] `components/widgets/media/call-controls/appearance.md` · 816b
- [ ] `components/widgets/media/call-controls/attributes.md` · 1.3k
- [ ] `components/widgets/media/call-controls/description.md` · 2.3k
- [ ] `components/widgets/media/call-controls/index.md` · 359b
- [ ] `components/widgets/media/call-controls/usage.md` · 1.2k

### `components/widgets/media/carousel/` · 4

- [ ] `components/widgets/media/carousel/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/widgets/media/carousel/description.md` · 2.0k · hash changed since verification
- [ ] `components/widgets/media/carousel/index.md` · 334b
- [ ] `components/widgets/media/carousel/usage.md` · 616b · hash changed since verification

### `components/widgets/media/gallery/` · 5

- [ ] `components/widgets/media/gallery/appearance.md` · 3.7k · hash changed since verification
- [ ] `components/widgets/media/gallery/attributes.md` · 2.3k · hash changed since verification
- [ ] `components/widgets/media/gallery/description.md` · 3.0k · hash changed since verification
- [ ] `components/widgets/media/gallery/index.md` · 329b
- [ ] `components/widgets/media/gallery/usage.md` · 8.4k · hash changed since verification

### `components/widgets/media/media-player/` · 5

- [ ] `components/widgets/media/media-player/appearance.md` · 2.5k · hash changed since verification
- [ ] `components/widgets/media/media-player/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/widgets/media/media-player/description.md` · 2.0k · hash changed since verification
- [ ] `components/widgets/media/media-player/index.md` · 354b
- [ ] `components/widgets/media/media-player/usage.md` · 515b · hash changed since verification

### `components/widgets/media/video/` · 5

- [ ] `components/widgets/media/video/appearance.md` · 4.0k · hash changed since verification
- [ ] `components/widgets/media/video/attributes.md` · 2.7k · hash changed since verification
- [ ] `components/widgets/media/video/description.md` · 2.8k · hash changed since verification
- [ ] `components/widgets/media/video/index.md` · 319b
- [ ] `components/widgets/media/video/usage.md` · 6.9k · hash changed since verification

### `components/widgets/navigation/` · 1

- [ ] `components/widgets/navigation/index.md` · 2.5k · hash changed since verification

### `components/widgets/navigation/bottom-navigation/` · 5

- [ ] `components/widgets/navigation/bottom-navigation/appearance.md` · 2.8k · hash changed since verification
- [ ] `components/widgets/navigation/bottom-navigation/attributes.md` · 1.4k · hash changed since verification
- [ ] `components/widgets/navigation/bottom-navigation/description.md` · 2.1k · hash changed since verification
- [ ] `components/widgets/navigation/bottom-navigation/index.md` · 379b
- [ ] `components/widgets/navigation/bottom-navigation/usage.md` · 2.8k · hash changed since verification

### `components/widgets/navigation/breadcrumb/` · 5

- [ ] `components/widgets/navigation/breadcrumb/appearance.md` · 2.2k · hash changed since verification
- [ ] `components/widgets/navigation/breadcrumb/attributes.md` · 1.6k · hash changed since verification
- [ ] `components/widgets/navigation/breadcrumb/description.md` · 1.9k · hash changed since verification
- [ ] `components/widgets/navigation/breadcrumb/index.md` · 343b
- [ ] `components/widgets/navigation/breadcrumb/usage.md` · 3.9k · hash changed since verification

### `components/widgets/navigation/command/` · 5

- [ ] `components/widgets/navigation/command/appearance.md` · 1.9k · hash changed since verification
- [ ] `components/widgets/navigation/command/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/widgets/navigation/command/description.md` · 1.8k · hash changed since verification
- [ ] `components/widgets/navigation/command/index.md` · 329b
- [ ] `components/widgets/navigation/command/usage.md` · 849b · hash changed since verification

### `components/widgets/navigation/language-switcher/` · 5

- [ ] `components/widgets/navigation/language-switcher/appearance.md` · 2.3k · hash changed since verification
- [ ] `components/widgets/navigation/language-switcher/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/widgets/navigation/language-switcher/description.md` · 2.5k · hash changed since verification
- [ ] `components/widgets/navigation/language-switcher/index.md` · 379b
- [ ] `components/widgets/navigation/language-switcher/usage.md` · 4.0k · hash changed since verification

### `components/widgets/navigation/menu/` · 5

- [ ] `components/widgets/navigation/menu/appearance.md` · 2.0k · hash changed since verification
- [ ] `components/widgets/navigation/menu/attributes.md` · 2.0k · hash changed since verification
- [ ] `components/widgets/navigation/menu/description.md` · 2.5k · hash changed since verification
- [ ] `components/widgets/navigation/menu/index.md` · 314b
- [ ] `components/widgets/navigation/menu/usage.md` · 3.1k · hash changed since verification

### `components/widgets/navigation/pagination/` · 4

- [ ] `components/widgets/navigation/pagination/appearance.md` · 2.6k · hash changed since verification
- [ ] `components/widgets/navigation/pagination/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/widgets/navigation/pagination/description.md` · 2.1k · hash changed since verification
- [ ] `components/widgets/navigation/pagination/index.md` · 344b

### `components/widgets/navigation/radial-menu/` · 5

- [ ] `components/widgets/navigation/radial-menu/appearance.md` · 8.2k · hash changed since verification
- [ ] `components/widgets/navigation/radial-menu/attributes.md` · 4.0k · hash changed since verification
- [ ] `components/widgets/navigation/radial-menu/description.md` · 7.0k · hash changed since verification
- [ ] `components/widgets/navigation/radial-menu/index.md` · 349b
- [ ] `components/widgets/navigation/radial-menu/usage.md` · 3.6k · hash changed since verification

### `components/widgets/navigation/sidebar/` · 5

- [ ] `components/widgets/navigation/sidebar/appearance.md` · 2.3k · hash changed since verification
- [ ] `components/widgets/navigation/sidebar/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/widgets/navigation/sidebar/description.md` · 2.7k · hash changed since verification
- [ ] `components/widgets/navigation/sidebar/index.md` · 329b
- [ ] `components/widgets/navigation/sidebar/usage.md` · 4.9k · hash changed since verification

### `components/widgets/navigation/tabs/` · 4

- [ ] `components/widgets/navigation/tabs/appearance.md` · 3.7k · hash changed since verification
- [ ] `components/widgets/navigation/tabs/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/widgets/navigation/tabs/description.md` · 2.0k · hash changed since verification
- [ ] `components/widgets/navigation/tabs/index.md` · 313b

### `components/widgets/navigation/toolbar/` · 5

- [ ] `components/widgets/navigation/toolbar/appearance.md` · 3.3k · hash changed since verification
- [ ] `components/widgets/navigation/toolbar/attributes.md` · 2.2k · hash changed since verification
- [ ] `components/widgets/navigation/toolbar/description.md` · 2.9k · hash changed since verification
- [ ] `components/widgets/navigation/toolbar/index.md` · 329b
- [ ] `components/widgets/navigation/toolbar/usage.md` · 3.1k · hash changed since verification

### `components/widgets/overlays/` · 1

- [ ] `components/widgets/overlays/index.md` · 2.2k · hash changed since verification

### `components/widgets/overlays/alert-dialog/` · 5

- [ ] `components/widgets/overlays/alert-dialog/appearance.md` · 1.6k · hash changed since verification
- [ ] `components/widgets/overlays/alert-dialog/attributes.md` · 1.6k · hash changed since verification
- [ ] `components/widgets/overlays/alert-dialog/description.md` · 1.9k · hash changed since verification
- [ ] `components/widgets/overlays/alert-dialog/index.md` · 354b
- [ ] `components/widgets/overlays/alert-dialog/usage.md` · 1.0k · hash changed since verification

### `components/widgets/overlays/context-menu/` · 5

- [ ] `components/widgets/overlays/context-menu/appearance.md` · 2.8k · hash changed since verification
- [ ] `components/widgets/overlays/context-menu/attributes.md` · 1.4k · hash changed since verification
- [ ] `components/widgets/overlays/context-menu/description.md` · 2.2k · hash changed since verification
- [ ] `components/widgets/overlays/context-menu/index.md` · 354b
- [ ] `components/widgets/overlays/context-menu/usage.md` · 3.7k · hash changed since verification

### `components/widgets/overlays/drawer/` · 4

- [ ] `components/widgets/overlays/drawer/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/widgets/overlays/drawer/description.md` · 1.9k · hash changed since verification
- [ ] `components/widgets/overlays/drawer/index.md` · 324b
- [ ] `components/widgets/overlays/drawer/usage.md` · 5.4k · hash changed since verification

### `components/widgets/overlays/hover-card/` · 5

- [ ] `components/widgets/overlays/hover-card/appearance.md` · 1.4k · hash changed since verification
- [ ] `components/widgets/overlays/hover-card/attributes.md` · 1.5k · hash changed since verification
- [ ] `components/widgets/overlays/hover-card/description.md` · 1.9k · hash changed since verification
- [ ] `components/widgets/overlays/hover-card/index.md` · 344b
- [ ] `components/widgets/overlays/hover-card/usage.md` · 871b · hash changed since verification

### `components/widgets/overlays/key-verification/` · 5

- [ ] `components/widgets/overlays/key-verification/appearance.md` · 1.2k
- [ ] `components/widgets/overlays/key-verification/attributes.md` · 1.2k
- [ ] `components/widgets/overlays/key-verification/description.md` · 2.2k
- [ ] `components/widgets/overlays/key-verification/index.md` · 374b
- [ ] `components/widgets/overlays/key-verification/usage.md` · 1.2k

### `components/widgets/overlays/modal/` · 4

- [ ] `components/widgets/overlays/modal/attributes.md` · 1.4k · hash changed since verification
- [ ] `components/widgets/overlays/modal/description.md` · 1.8k · hash changed since verification
- [ ] `components/widgets/overlays/modal/index.md` · 319b
- [ ] `components/widgets/overlays/modal/usage.md` · 4.5k · hash changed since verification

### `components/widgets/overlays/popover/` · 5

- [ ] `components/widgets/overlays/popover/appearance.md` · 1.5k · hash changed since verification
- [ ] `components/widgets/overlays/popover/attributes.md` · 1.9k · hash changed since verification
- [ ] `components/widgets/overlays/popover/description.md` · 2.1k · hash changed since verification
- [ ] `components/widgets/overlays/popover/index.md` · 329b
- [ ] `components/widgets/overlays/popover/usage.md` · 1.1k · hash changed since verification

### `components/widgets/overlays/tooltip/` · 5

- [ ] `components/widgets/overlays/tooltip/appearance.md` · 1.4k · hash changed since verification
- [ ] `components/widgets/overlays/tooltip/attributes.md` · 1.6k · hash changed since verification
- [ ] `components/widgets/overlays/tooltip/description.md` · 1.9k · hash changed since verification
- [ ] `components/widgets/overlays/tooltip/index.md` · 329b
- [ ] `components/widgets/overlays/tooltip/usage.md` · 1.0k · hash changed since verification

### `components/widgets/special/` · 1

- [ ] `components/widgets/special/index.md` · 659b · hash changed since verification

### `components/widgets/special/map-view/` · 5

- [ ] `components/widgets/special/map-view/appearance.md` · 2.7k · hash changed since verification
- [ ] `components/widgets/special/map-view/attributes.md` · 1.6k · hash changed since verification
- [ ] `components/widgets/special/map-view/description.md` · 1.9k · hash changed since verification
- [ ] `components/widgets/special/map-view/index.md` · 334b
- [ ] `components/widgets/special/map-view/usage.md` · 601b · hash changed since verification

### `components/workbenches/` · 1

- [ ] `components/workbenches/index.md` · 1.2k · hash changed since verification

### `components/workbenches/fields/` · 1

- [ ] `components/workbenches/fields/index.md` · 888b · hash changed since verification

### `components/workbenches/fields/block-editor/` · 5

- [ ] `components/workbenches/fields/block-editor/appearance.md` · 1.3k
- [ ] `components/workbenches/fields/block-editor/attributes.md` · 1.2k
- [ ] `components/workbenches/fields/block-editor/description.md` · 2.5k
- [ ] `components/workbenches/fields/block-editor/index.md` · 354b
- [ ] `components/workbenches/fields/block-editor/usage.md` · 1.1k

### `components/workbenches/fields/rich-text-editor/` · 5

- [ ] `components/workbenches/fields/rich-text-editor/appearance.md` · 2.9k · hash changed since verification
- [ ] `components/workbenches/fields/rich-text-editor/attributes.md` · 1.4k · hash changed since verification
- [ ] `components/workbenches/fields/rich-text-editor/description.md` · 2.0k · hash changed since verification
- [ ] `components/workbenches/fields/rich-text-editor/index.md` · 374b
- [ ] `components/workbenches/fields/rich-text-editor/usage.md` · 636b · hash changed since verification

### `components/workbenches/special/` · 1

- [ ] `components/workbenches/special/index.md` · 1.7k · hash changed since verification

### `components/workbenches/special/code-editor/` · 5

- [ ] `components/workbenches/special/code-editor/appearance.md` · 2.1k · hash changed since verification
- [ ] `components/workbenches/special/code-editor/attributes.md` · 1.4k · hash changed since verification
- [ ] `components/workbenches/special/code-editor/description.md` · 1.9k · hash changed since verification
- [ ] `components/workbenches/special/code-editor/index.md` · 349b
- [ ] `components/workbenches/special/code-editor/usage.md` · 517b · hash changed since verification

### `components/workbenches/special/dashboard/` · 5

- [ ] `components/workbenches/special/dashboard/appearance.md` · 2.5k · hash changed since verification
- [ ] `components/workbenches/special/dashboard/attributes.md` · 1.4k · hash changed since verification
- [ ] `components/workbenches/special/dashboard/description.md` · 1.9k · hash changed since verification
- [ ] `components/workbenches/special/dashboard/index.md` · 338b
- [ ] `components/workbenches/special/dashboard/usage.md` · 534b · hash changed since verification

### `components/workbenches/special/embed/` · 5

- [ ] `components/workbenches/special/embed/appearance.md` · 2.2k · hash changed since verification
- [ ] `components/workbenches/special/embed/attributes.md` · 2.0k · hash changed since verification
- [ ] `components/workbenches/special/embed/description.md` · 2.6k · hash changed since verification
- [ ] `components/workbenches/special/embed/index.md` · 319b
- [ ] `components/workbenches/special/embed/usage.md` · 1.0k · hash changed since verification

### `components/workbenches/special/html-view/` · 5

- [ ] `components/workbenches/special/html-view/appearance.md` · 1.3k
- [ ] `components/workbenches/special/html-view/attributes.md` · 1.2k
- [ ] `components/workbenches/special/html-view/description.md` · 2.3k
- [ ] `components/workbenches/special/html-view/index.md` · 339b
- [ ] `components/workbenches/special/html-view/usage.md` · 1.1k

### `components/workbenches/special/message-composer/` · 5

- [ ] `components/workbenches/special/message-composer/appearance.md` · 1.6k
- [ ] `components/workbenches/special/message-composer/attributes.md` · 1.3k
- [ ] `components/workbenches/special/message-composer/description.md` · 2.9k
- [ ] `components/workbenches/special/message-composer/index.md` · 374b
- [ ] `components/workbenches/special/message-composer/usage.md` · 1.2k

### `components/workbenches/special/whiteboard/` · 5

- [ ] `components/workbenches/special/whiteboard/appearance.md` · 2.9k · hash changed since verification
- [ ] `components/workbenches/special/whiteboard/attributes.md` · 1.3k · hash changed since verification
- [ ] `components/workbenches/special/whiteboard/description.md` · 2.0k · hash changed since verification
- [ ] `components/workbenches/special/whiteboard/index.md` · 343b
- [ ] `components/workbenches/special/whiteboard/usage.md` · 553b · hash changed since verification

### `data/` · 9

- [ ] `data/api.md` · 8.7k · hash changed since verification
- [ ] `data/conventions.md` · 8.1k · hash changed since verification
- [ ] `data/fields.md` · 10.0k · hash changed since verification
- [ ] `data/formats.md` · 5.1k · hash changed since verification
- [ ] `data/index.md` · 6.7k · hash changed since verification
- [ ] `data/mappings.md` · 14.6k · hash changed since verification
- [ ] `data/models.md` · 9.5k · hash changed since verification
- [ ] `data/requirements.md` · 6.9k · hash changed since verification
- [ ] `data/standards.md` · 25.3k · hash changed since verification

### `data/documents/` · 2

- [ ] `data/documents/standards.md` · 3.7k · hash changed since verification
- [ ] `data/documents/technical.md` · 2.7k · hash changed since verification

### `data/events/` · 5

- [ ] `data/events/description.md` · 1.5k · hash changed since verification
- [ ] `data/events/examples.md` · 2.5k · hash changed since verification
- [ ] `data/events/index.md` · 1.4k · hash changed since verification
- [ ] `data/events/standards.md` · 3.7k · hash changed since verification
- [ ] `data/events/technical.md` · 3.0k · hash changed since verification

### `data/geodata/` · 5

- [ ] `data/geodata/description.md` · 1.5k · hash changed since verification
- [ ] `data/geodata/examples.md` · 1.8k · hash changed since verification
- [ ] `data/geodata/index.md` · 1.1k · hash changed since verification
- [ ] `data/geodata/standards.md` · 2.9k · hash changed since verification
- [ ] `data/geodata/technical.md` · 1.8k · hash changed since verification

### `data/identity/` · 4

- [ ] `data/identity/description.md` · 1.8k · hash changed since verification
- [ ] `data/identity/examples.md` · 2.3k · hash changed since verification
- [ ] `data/identity/index.md` · 3.1k · hash changed since verification
- [ ] `data/identity/standards.md` · 2.6k · hash changed since verification

### `data/login/` · 5

- [ ] `data/login/description.md` · 1.1k · hash changed since verification
- [ ] `data/login/examples.md` · 2.0k · hash changed since verification
- [ ] `data/login/index.md` · 2.0k · hash changed since verification
- [ ] `data/login/standards.md` · 3.5k · hash changed since verification
- [ ] `data/login/technical.md` · 2.1k · hash changed since verification

### `data/messages/` · 2

- [ ] `data/messages/standards.md` · 4.0k · hash changed since verification
- [ ] `data/messages/technical.md` · 3.0k · hash changed since verification

### `data/people/` · 5

- [ ] `data/people/description.md` · 2.1k
- [ ] `data/people/examples.md` · 2.0k
- [ ] `data/people/index.md` · 1.5k
- [ ] `data/people/standards.md` · 3.0k
- [ ] `data/people/technical.md` · 3.2k

### `data/people/jscontact/` · 2

- [ ] `data/people/jscontact/description.md` · 4.3k
- [ ] `data/people/jscontact/storage.md` · 2.8k

### `data/profile/` · 3

- [ ] `data/profile/description.md` · 1.6k · hash changed since verification
- [ ] `data/profile/index.md` · 1.4k · hash changed since verification
- [ ] `data/profile/standards.md` · 3.0k · hash changed since verification

### `data/projects/` · 5

- [ ] `data/projects/description.md` · 1.5k · hash changed since verification
- [ ] `data/projects/examples.md` · 1.9k · hash changed since verification
- [ ] `data/projects/index.md` · 1.9k · hash changed since verification
- [ ] `data/projects/standards.md` · 3.2k · hash changed since verification
- [ ] `data/projects/technical.md` · 2.1k · hash changed since verification

### `help/` · 1

- [ ] `help/index.md` · 853b

### `help/calendar/` · 7

- [ ] `help/calendar/agenda.md` · 883b
- [ ] `help/calendar/day.md` · 1.3k
- [ ] `help/calendar/edit-event.md` · 1.5k
- [ ] `help/calendar/event.md` · 1.1k
- [ ] `help/calendar/index.md` · 934b
- [ ] `help/calendar/month.md` · 1.4k
- [ ] `help/calendar/week.md` · 1.4k

### `help/files/` · 9

- [ ] `help/files/filter.md` · 824b
- [ ] `help/files/folders.md` · 1.3k
- [ ] `help/files/grid.md` · 833b
- [ ] `help/files/index.md` · 984b
- [ ] `help/files/list.md` · 1.8k
- [ ] `help/files/questions.md` · 1.4k
- [ ] `help/files/selected-item.md` · 1.4k
- [ ] `help/files/trash.md` · 1.3k
- [ ] `help/files/what-the-rescan-found.md` · 935b

### `help/groups/` · 5

- [ ] `help/groups/delete-group.md` · 525b
- [ ] `help/groups/edit-group.md` · 1.1k
- [ ] `help/groups/group.md` · 980b
- [ ] `help/groups/groups.md` · 1012b
- [ ] `help/groups/index.md` · 705b

### `help/maps/` · 5

- [ ] `help/maps/delete-place.md` · 549b
- [ ] `help/maps/edit-place.md` · 1.3k
- [ ] `help/maps/index.md` · 644b
- [ ] `help/maps/place.md` · 906b
- [ ] `help/maps/places.md` · 1.2k

### `help/people/` · 4

- [ ] `help/people/edit-person.md` · 1.7k
- [ ] `help/people/index.md` · 823b
- [ ] `help/people/people-list.md` · 1.2k
- [ ] `help/people/person.md` · 1.1k

### `help/store/` · 7

- [ ] `help/store/about.md` · 649b
- [ ] `help/store/command-line.md` · 3.5k
- [ ] `help/store/index.md` · 1.5k
- [ ] `help/store/installing.md` · 1.5k
- [ ] `help/store/programs.md` · 2.4k
- [ ] `help/store/settings.md` · 1.8k
- [ ] `help/store/sources.md` · 1.5k

### `help/tasks/` · 5

- [ ] `help/tasks/edit-task.md` · 1.6k
- [ ] `help/tasks/index.md` · 779b
- [ ] `help/tasks/list.md` · 1.5k
- [ ] `help/tasks/status.md` · 1.6k
- [ ] `help/tasks/task.md` · 1.2k

### `help/wiki/` · 7

- [ ] `help/wiki/edit.md` · 1.8k
- [ ] `help/wiki/export.md` · 661b
- [ ] `help/wiki/import-problems.md` · 1.0k
- [ ] `help/wiki/index.md` · 1.1k
- [ ] `help/wiki/page-tree.md` · 944b
- [ ] `help/wiki/page.md` · 1.1k
- [ ] `help/wiki/search-results.md` · 617b

### `interactions/animations/entrance/` · 1

- [ ] `interactions/animations/entrance/index.md` · 1.3k · hash changed since verification

### `interactions/animations/entrance/bounce-in/` · 3

- [ ] `interactions/animations/entrance/bounce-in/appearance.md` · 1.3k · hash changed since verification
- [ ] `interactions/animations/entrance/bounce-in/attributes.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/entrance/bounce-in/description.md` · 1003b · hash changed since verification

### `interactions/animations/entrance/expand/` · 3

- [ ] `interactions/animations/entrance/expand/appearance.md` · 1.6k · hash changed since verification
- [ ] `interactions/animations/entrance/expand/attributes.md` · 1.7k · hash changed since verification
- [ ] `interactions/animations/entrance/expand/description.md` · 796b · hash changed since verification

### `interactions/animations/entrance/fade-in/` · 3

- [ ] `interactions/animations/entrance/fade-in/appearance.md` · 1.2k · hash changed since verification
- [ ] `interactions/animations/entrance/fade-in/attributes.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/entrance/fade-in/description.md` · 860b · hash changed since verification

### `interactions/animations/entrance/pop-in/` · 3

- [ ] `interactions/animations/entrance/pop-in/appearance.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/entrance/pop-in/attributes.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/entrance/pop-in/description.md` · 1.0k · hash changed since verification

### `interactions/animations/entrance/radial-out/` · 4

- [ ] `interactions/animations/entrance/radial-out/appearance.md` · 2.0k · hash changed since verification
- [ ] `interactions/animations/entrance/radial-out/attributes.md` · 1.8k · hash changed since verification
- [ ] `interactions/animations/entrance/radial-out/description.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/entrance/radial-out/index.md` · 311b

### `interactions/animations/entrance/scale-in/` · 3

- [ ] `interactions/animations/entrance/scale-in/appearance.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/entrance/scale-in/attributes.md` · 1.6k · hash changed since verification
- [ ] `interactions/animations/entrance/scale-in/description.md` · 961b · hash changed since verification

### `interactions/animations/entrance/slide-in/` · 3

- [ ] `interactions/animations/entrance/slide-in/appearance.md` · 1.3k · hash changed since verification
- [ ] `interactions/animations/entrance/slide-in/attributes.md` · 1.6k · hash changed since verification
- [ ] `interactions/animations/entrance/slide-in/description.md` · 879b · hash changed since verification

### `interactions/animations/entrance/unfold/` · 3

- [ ] `interactions/animations/entrance/unfold/appearance.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/entrance/unfold/attributes.md` · 1.7k · hash changed since verification
- [ ] `interactions/animations/entrance/unfold/description.md` · 950b · hash changed since verification

### `interactions/animations/entrance/zoom-in/` · 3

- [ ] `interactions/animations/entrance/zoom-in/appearance.md` · 1.2k · hash changed since verification
- [ ] `interactions/animations/entrance/zoom-in/attributes.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/entrance/zoom-in/description.md` · 864b · hash changed since verification

### `interactions/animations/exit/` · 1

- [ ] `interactions/animations/exit/index.md` · 1.4k · hash changed since verification

### `interactions/animations/exit/bounce-out/` · 3

- [ ] `interactions/animations/exit/bounce-out/appearance.md` · 1.2k · hash changed since verification
- [ ] `interactions/animations/exit/bounce-out/attributes.md` · 1.6k · hash changed since verification
- [ ] `interactions/animations/exit/bounce-out/description.md` · 978b · hash changed since verification

### `interactions/animations/exit/collapse/` · 3

- [ ] `interactions/animations/exit/collapse/appearance.md` · 1.6k · hash changed since verification
- [ ] `interactions/animations/exit/collapse/attributes.md` · 1.7k · hash changed since verification
- [ ] `interactions/animations/exit/collapse/description.md` · 810b · hash changed since verification

### `interactions/animations/exit/fade-out/` · 3

- [ ] `interactions/animations/exit/fade-out/appearance.md` · 1.2k · hash changed since verification
- [ ] `interactions/animations/exit/fade-out/attributes.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/exit/fade-out/description.md` · 838b · hash changed since verification

### `interactions/animations/exit/pop-out/` · 3

- [ ] `interactions/animations/exit/pop-out/appearance.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/exit/pop-out/attributes.md` · 1.6k · hash changed since verification
- [ ] `interactions/animations/exit/pop-out/description.md` · 1.1k · hash changed since verification

### `interactions/animations/exit/radial-in/` · 4

- [ ] `interactions/animations/exit/radial-in/appearance.md` · 1.9k · hash changed since verification
- [ ] `interactions/animations/exit/radial-in/attributes.md` · 1.9k · hash changed since verification
- [ ] `interactions/animations/exit/radial-in/description.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/exit/radial-in/index.md` · 307b

### `interactions/animations/exit/scale-out/` · 3

- [ ] `interactions/animations/exit/scale-out/appearance.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/exit/scale-out/attributes.md` · 1.6k · hash changed since verification
- [ ] `interactions/animations/exit/scale-out/description.md` · 925b · hash changed since verification

### `interactions/animations/exit/slide-out/` · 3

- [ ] `interactions/animations/exit/slide-out/appearance.md` · 1.3k · hash changed since verification
- [ ] `interactions/animations/exit/slide-out/attributes.md` · 1.6k · hash changed since verification
- [ ] `interactions/animations/exit/slide-out/description.md` · 914b · hash changed since verification

### `interactions/animations/exit/zoom-out/` · 3

- [ ] `interactions/animations/exit/zoom-out/appearance.md` · 1.2k · hash changed since verification
- [ ] `interactions/animations/exit/zoom-out/attributes.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/exit/zoom-out/description.md` · 854b · hash changed since verification

### `interactions/animations/feedback/` · 1

- [ ] `interactions/animations/feedback/index.md` · 1.1k · hash changed since verification

### `interactions/animations/feedback/elastic/` · 3

- [ ] `interactions/animations/feedback/elastic/appearance.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/feedback/elastic/attributes.md` · 1.3k · hash changed since verification
- [ ] `interactions/animations/feedback/elastic/description.md` · 968b · hash changed since verification

### `interactions/animations/feedback/highlight/` · 3

- [ ] `interactions/animations/feedback/highlight/appearance.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/feedback/highlight/attributes.md` · 1.6k · hash changed since verification
- [ ] `interactions/animations/feedback/highlight/description.md` · 878b · hash changed since verification

### `interactions/animations/feedback/lift/` · 3

- [ ] `interactions/animations/feedback/lift/appearance.md` · 1.7k · hash changed since verification
- [ ] `interactions/animations/feedback/lift/attributes.md` · 1.7k · hash changed since verification
- [ ] `interactions/animations/feedback/lift/description.md` · 1.2k · hash changed since verification

### `interactions/animations/feedback/press/` · 3

- [ ] `interactions/animations/feedback/press/appearance.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/feedback/press/attributes.md` · 1.6k · hash changed since verification
- [ ] `interactions/animations/feedback/press/description.md` · 1.2k · hash changed since verification

### `interactions/animations/feedback/ripple/` · 3

- [ ] `interactions/animations/feedback/ripple/appearance.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/feedback/ripple/attributes.md` · 1.7k · hash changed since verification
- [ ] `interactions/animations/feedback/ripple/description.md` · 915b · hash changed since verification

### `interactions/animations/feedback/rubber-band/` · 3

- [ ] `interactions/animations/feedback/rubber-band/appearance.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/feedback/rubber-band/attributes.md` · 1.3k · hash changed since verification
- [ ] `interactions/animations/feedback/rubber-band/description.md` · 1.0k · hash changed since verification

### `interactions/animations/feedback/shake/` · 4

- [ ] `interactions/animations/feedback/shake/appearance.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/feedback/shake/attributes.md` · 1.7k · hash changed since verification
- [ ] `interactions/animations/feedback/shake/description.md` · 1.1k · hash changed since verification
- [ ] `interactions/animations/feedback/shake/index.md` · 291b

### `interactions/animations/feedback/tick-draw/` · 2

- [ ] `interactions/animations/feedback/tick-draw/attributes.md` · 1.8k · hash changed since verification
- [ ] `interactions/animations/feedback/tick-draw/description.md` · 1.1k · hash changed since verification

### `interactions/animations/feedback/wiggle/` · 3

- [ ] `interactions/animations/feedback/wiggle/appearance.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/feedback/wiggle/attributes.md` · 1.7k · hash changed since verification
- [ ] `interactions/animations/feedback/wiggle/description.md` · 888b · hash changed since verification

### `interactions/animations/loading/` · 1

- [ ] `interactions/animations/loading/index.md` · 945b · hash changed since verification

### `interactions/animations/loading/dots/` · 3

- [ ] `interactions/animations/loading/dots/appearance.md` · 1.6k · hash changed since verification
- [ ] `interactions/animations/loading/dots/attributes.md` · 1.7k · hash changed since verification
- [ ] `interactions/animations/loading/dots/description.md` · 1.1k · hash changed since verification

### `interactions/animations/loading/progress/` · 3

- [ ] `interactions/animations/loading/progress/appearance.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/loading/progress/attributes.md` · 1.3k · hash changed since verification
- [ ] `interactions/animations/loading/progress/description.md` · 911b · hash changed since verification

### `interactions/animations/loading/skeleton/` · 3

- [ ] `interactions/animations/loading/skeleton/appearance.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/loading/skeleton/attributes.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/loading/skeleton/description.md` · 1.1k · hash changed since verification

### `interactions/animations/loading/typing/` · 3

- [ ] `interactions/animations/loading/typing/appearance.md` · 1.3k · hash changed since verification
- [ ] `interactions/animations/loading/typing/attributes.md` · 1.3k · hash changed since verification
- [ ] `interactions/animations/loading/typing/description.md` · 900b · hash changed since verification

### `interactions/animations/loop/` · 1

- [ ] `interactions/animations/loop/index.md` · 928b · hash changed since verification

### `interactions/animations/loop/glow/` · 3

- [ ] `interactions/animations/loop/glow/appearance.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/loop/glow/attributes.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/loop/glow/description.md` · 990b · hash changed since verification

### `interactions/animations/loop/heartbeat/` · 3

- [ ] `interactions/animations/loop/heartbeat/appearance.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/loop/heartbeat/attributes.md` · 1.7k · hash changed since verification
- [ ] `interactions/animations/loop/heartbeat/description.md` · 954b · hash changed since verification

### `interactions/animations/loop/pulse/` · 3

- [ ] `interactions/animations/loop/pulse/appearance.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/loop/pulse/attributes.md` · 1.7k · hash changed since verification
- [ ] `interactions/animations/loop/pulse/description.md` · 847b · hash changed since verification

### `interactions/animations/loop/spin/` · 3

- [ ] `interactions/animations/loop/spin/appearance.md` · 1.8k · hash changed since verification
- [ ] `interactions/animations/loop/spin/attributes.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/loop/spin/description.md` · 895b · hash changed since verification

### `interactions/animations/movement/` · 1

- [ ] `interactions/animations/movement/index.md` · 904b · hash changed since verification

### `interactions/animations/movement/parallax/` · 3

- [ ] `interactions/animations/movement/parallax/appearance.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/movement/parallax/attributes.md` · 1.2k · hash changed since verification
- [ ] `interactions/animations/movement/parallax/description.md` · 1.0k · hash changed since verification

### `interactions/animations/organization/` · 1

- [ ] `interactions/animations/organization/index.md` · 1.0k · hash changed since verification

### `interactions/animations/organization/cascade/` · 3

- [ ] `interactions/animations/organization/cascade/appearance.md` · 1.9k · hash changed since verification
- [ ] `interactions/animations/organization/cascade/attributes.md` · 1.7k · hash changed since verification
- [ ] `interactions/animations/organization/cascade/description.md` · 1.2k · hash changed since verification

### `interactions/animations/organization/stagger/` · 3

- [ ] `interactions/animations/organization/stagger/appearance.md` · 1.5k · hash changed since verification
- [ ] `interactions/animations/organization/stagger/attributes.md` · 1.3k · hash changed since verification
- [ ] `interactions/animations/organization/stagger/description.md` · 1.1k · hash changed since verification

### `interactions/animations/transition/` · 1

- [ ] `interactions/animations/transition/index.md` · 1.1k · hash changed since verification

### `interactions/animations/transition/cross-fade/` · 3

- [ ] `interactions/animations/transition/cross-fade/appearance.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/transition/cross-fade/attributes.md` · 1.3k · hash changed since verification
- [ ] `interactions/animations/transition/cross-fade/description.md` · 928b · hash changed since verification

### `interactions/animations/transition/cross-slide/` · 3

- [ ] `interactions/animations/transition/cross-slide/appearance.md` · 1.8k · hash changed since verification
- [ ] `interactions/animations/transition/cross-slide/attributes.md` · 1.8k · hash changed since verification
- [ ] `interactions/animations/transition/cross-slide/description.md` · 1.2k · hash changed since verification

### `interactions/animations/transition/flip/` · 3

- [ ] `interactions/animations/transition/flip/appearance.md` · 1.3k · hash changed since verification
- [ ] `interactions/animations/transition/flip/attributes.md` · 1.7k · hash changed since verification
- [ ] `interactions/animations/transition/flip/description.md` · 930b · hash changed since verification

### `interactions/animations/transition/morph/` · 3

- [ ] `interactions/animations/transition/morph/appearance.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/transition/morph/attributes.md` · 1.4k · hash changed since verification
- [ ] `interactions/animations/transition/morph/description.md` · 979b · hash changed since verification

### `interactions/animations/transition/reorder/` · 2

- [ ] `interactions/animations/transition/reorder/attributes.md` · 1.9k · hash changed since verification
- [ ] `interactions/animations/transition/reorder/description.md` · 1.2k · hash changed since verification

### `interactions/animations/transition/rotate/` · 2

- [ ] `interactions/animations/transition/rotate/attributes.md` · 1.6k · hash changed since verification
- [ ] `interactions/animations/transition/rotate/description.md` · 920b · hash changed since verification

### `interactions/gestures/device/` · 1

- [ ] `interactions/gestures/device/index.md` · 1.3k · hash changed since verification

### `interactions/gestures/swipe/edge-swipe/` · 1

- [ ] `interactions/gestures/swipe/edge-swipe/description.md` · 1.7k · hash changed since verification

### `interactions/gestures/transform/` · 1

- [ ] `interactions/gestures/transform/index.md` · 1.1k · hash changed since verification

### `interfaces/` · 2

- [ ] `interfaces/index.md` · 8.1k
- [ ] `interfaces/roles.md` · 10.2k

### `programs/apps/assistant/` · 1

- [ ] `programs/apps/assistant/index.md` · 25.6k

### `programs/apps/gallery/` · 1

- [ ] `programs/apps/gallery/design.md` · 3.6k

### `programs/apps/gallery/frontends/nextcloud-photos/latest/` · 1

- [ ] `programs/apps/gallery/frontends/nextcloud-photos/latest/api.md` · 2.6k · hash changed since verification

### `programs/apps/helpdesk/frontends/freshdesk/latest/` · 1

- [ ] `programs/apps/helpdesk/frontends/freshdesk/latest/api.md` · 2.4k · hash changed since verification

### `programs/apps/helpdesk/frontends/zendesk/latest/` · 1

- [ ] `programs/apps/helpdesk/frontends/zendesk/latest/api.md` · 3.1k · hash changed since verification

### `programs/apps/messenger/` · 1

- [ ] `programs/apps/messenger/contract.md` · 2.7k

### `programs/apps/messenger/frontends/apple-mail/` · 1

- [ ] `programs/apps/messenger/frontends/apple-mail/index.md` · 4.0k

### `programs/apps/messenger/frontends/apple-mail/ios-26/` · 9

- [ ] `programs/apps/messenger/frontends/apple-mail/ios-26/api.md` · 959b
- [ ] `programs/apps/messenger/frontends/apple-mail/ios-26/dependencies.md` · 2.5k
- [ ] `programs/apps/messenger/frontends/apple-mail/ios-26/description.md` · 3.1k
- [ ] `programs/apps/messenger/frontends/apple-mail/ios-26/features.md` · 3.7k
- [ ] `programs/apps/messenger/frontends/apple-mail/ios-26/interaction.md` · 1.6k
- [ ] `programs/apps/messenger/frontends/apple-mail/ios-26/layout.md` · 3.0k
- [ ] `programs/apps/messenger/frontends/apple-mail/ios-26/menus.md` · 2.3k
- [ ] `programs/apps/messenger/frontends/apple-mail/ios-26/shortcuts.md` · 664b
- [ ] `programs/apps/messenger/frontends/apple-mail/ios-26/states.md` · 1.5k

### `programs/apps/messenger/frontends/apple-mail/ios-26/themes/` · 2

- [ ] `programs/apps/messenger/frontends/apple-mail/ios-26/themes/index.md` · 997b
- [ ] `programs/apps/messenger/frontends/apple-mail/ios-26/themes/light.md` · 1.7k

### `programs/apps/messenger/frontends/freesynergy-simple/` · 1

- [ ] `programs/apps/messenger/frontends/freesynergy-simple/index.md` · 2.1k

### `programs/apps/messenger/frontends/freesynergy-simple/0.1/` · 8

- [ ] `programs/apps/messenger/frontends/freesynergy-simple/0.1/api.md` · 275b
- [ ] `programs/apps/messenger/frontends/freesynergy-simple/0.1/dependencies.md` · 767b
- [ ] `programs/apps/messenger/frontends/freesynergy-simple/0.1/description.md` · 1.1k
- [ ] `programs/apps/messenger/frontends/freesynergy-simple/0.1/features.md` · 1.2k
- [ ] `programs/apps/messenger/frontends/freesynergy-simple/0.1/interaction.md` · 1.4k
- [ ] `programs/apps/messenger/frontends/freesynergy-simple/0.1/layout.md` · 2.0k
- [ ] `programs/apps/messenger/frontends/freesynergy-simple/0.1/menus.md` · 186b
- [ ] `programs/apps/messenger/frontends/freesynergy-simple/0.1/shortcuts.md` · 263b

### `programs/apps/messenger/frontends/freesynergy-simple/0.1/themes/` · 1

- [ ] `programs/apps/messenger/frontends/freesynergy-simple/0.1/themes/index.md` · 259b

### `programs/apps/messenger/frontends/outlook/m365-2026-11/` · 9

- [ ] `programs/apps/messenger/frontends/outlook/m365-2026-11/api.md` · 1.3k
- [ ] `programs/apps/messenger/frontends/outlook/m365-2026-11/dependencies.md` · 3.5k
- [ ] `programs/apps/messenger/frontends/outlook/m365-2026-11/description.md` · 3.1k
- [ ] `programs/apps/messenger/frontends/outlook/m365-2026-11/features.md` · 5.5k
- [ ] `programs/apps/messenger/frontends/outlook/m365-2026-11/interaction.md` · 1.9k
- [ ] `programs/apps/messenger/frontends/outlook/m365-2026-11/layout.md` · 6.2k
- [ ] `programs/apps/messenger/frontends/outlook/m365-2026-11/menus.md` · 4.0k
- [ ] `programs/apps/messenger/frontends/outlook/m365-2026-11/shortcuts.md` · 667b
- [ ] `programs/apps/messenger/frontends/outlook/m365-2026-11/states.md` · 1.9k

### `programs/apps/messenger/frontends/outlook/m365-2026-11/themes/` · 4

- [ ] `programs/apps/messenger/frontends/outlook/m365-2026-11/themes/dark.md` · 1020b
- [ ] `programs/apps/messenger/frontends/outlook/m365-2026-11/themes/index.md` · 1.4k
- [ ] `programs/apps/messenger/frontends/outlook/m365-2026-11/themes/light.md` · 1.7k
- [ ] `programs/apps/messenger/frontends/outlook/m365-2026-11/themes/picture.md` · 1.1k

### `programs/apps/people/frontends/gnome-contacts/` · 1

- [ ] `programs/apps/people/frontends/gnome-contacts/index.md` · 1.3k

### `programs/apps/people/frontends/gnome-contacts/latest/` · 6

- [ ] `programs/apps/people/frontends/gnome-contacts/latest/api.md` · 1.7k
- [ ] `programs/apps/people/frontends/gnome-contacts/latest/description.md` · 1.7k
- [ ] `programs/apps/people/frontends/gnome-contacts/latest/features.md` · 1.3k
- [ ] `programs/apps/people/frontends/gnome-contacts/latest/layout.md` · 2.4k
- [ ] `programs/apps/people/frontends/gnome-contacts/latest/menus.md` · 1.1k
- [ ] `programs/apps/people/frontends/gnome-contacts/latest/shortcuts.md` · 997b

### `programs/apps/people/frontends/kaddressbook/` · 1

- [ ] `programs/apps/people/frontends/kaddressbook/index.md` · 1.2k

### `programs/apps/people/frontends/kaddressbook/latest/` · 6

- [ ] `programs/apps/people/frontends/kaddressbook/latest/api.md` · 2.1k
- [ ] `programs/apps/people/frontends/kaddressbook/latest/description.md` · 1.7k
- [ ] `programs/apps/people/frontends/kaddressbook/latest/features.md` · 1.7k
- [ ] `programs/apps/people/frontends/kaddressbook/latest/layout.md` · 2.7k
- [ ] `programs/apps/people/frontends/kaddressbook/latest/menus.md` · 1.5k
- [ ] `programs/apps/people/frontends/kaddressbook/latest/shortcuts.md` · 1.3k

### `programs/apps/people/frontends/monica/` · 1

- [ ] `programs/apps/people/frontends/monica/index.md` · 1.2k

### `programs/apps/people/frontends/monica/latest/` · 6

- [ ] `programs/apps/people/frontends/monica/latest/api.md` · 2.3k
- [ ] `programs/apps/people/frontends/monica/latest/description.md` · 1.6k
- [ ] `programs/apps/people/frontends/monica/latest/features.md` · 1.4k
- [ ] `programs/apps/people/frontends/monica/latest/layout.md` · 2.9k
- [ ] `programs/apps/people/frontends/monica/latest/menus.md` · 1.6k
- [ ] `programs/apps/people/frontends/monica/latest/shortcuts.md` · 723b

### `programs/apps/people/frontends/nextcloud-contacts/` · 1

- [ ] `programs/apps/people/frontends/nextcloud-contacts/index.md` · 1.2k

### `programs/apps/people/frontends/nextcloud-contacts/latest/` · 6

- [ ] `programs/apps/people/frontends/nextcloud-contacts/latest/api.md` · 2.6k
- [ ] `programs/apps/people/frontends/nextcloud-contacts/latest/description.md` · 1.7k
- [ ] `programs/apps/people/frontends/nextcloud-contacts/latest/features.md` · 1.7k
- [ ] `programs/apps/people/frontends/nextcloud-contacts/latest/layout.md` · 2.4k
- [ ] `programs/apps/people/frontends/nextcloud-contacts/latest/menus.md` · 1.5k
- [ ] `programs/apps/people/frontends/nextcloud-contacts/latest/shortcuts.md` · 932b

### `programs/apps/surveys/` · 1

- [ ] `programs/apps/surveys/design.md` · 9.4k

### `programs/apps/tasks/` · 1

- [ ] `programs/apps/tasks/design.md` · 3.2k

### `programs/apps/whiteboard/frontends/drawio/` · 1

- [ ] `programs/apps/whiteboard/frontends/drawio/index.md` · 1.2k

### `programs/apps/whiteboard/frontends/drawio/latest/` · 6

- [ ] `programs/apps/whiteboard/frontends/drawio/latest/api.md` · 6.1k
- [ ] `programs/apps/whiteboard/frontends/drawio/latest/description.md` · 3.1k
- [ ] `programs/apps/whiteboard/frontends/drawio/latest/features.md` · 5.6k
- [ ] `programs/apps/whiteboard/frontends/drawio/latest/layout.md` · 6.1k
- [ ] `programs/apps/whiteboard/frontends/drawio/latest/menus.md` · 4.1k
- [ ] `programs/apps/whiteboard/frontends/drawio/latest/shortcuts.md` · 4.8k

### `programs/apps/whiteboard/frontends/excalidraw/` · 1

- [ ] `programs/apps/whiteboard/frontends/excalidraw/index.md` · 1.2k

### `programs/apps/whiteboard/frontends/excalidraw/latest/` · 6

- [ ] `programs/apps/whiteboard/frontends/excalidraw/latest/api.md` · 5.6k
- [ ] `programs/apps/whiteboard/frontends/excalidraw/latest/description.md` · 3.2k
- [ ] `programs/apps/whiteboard/frontends/excalidraw/latest/features.md` · 5.2k
- [ ] `programs/apps/whiteboard/frontends/excalidraw/latest/layout.md` · 6.3k
- [ ] `programs/apps/whiteboard/frontends/excalidraw/latest/menus.md` · 3.3k
- [ ] `programs/apps/whiteboard/frontends/excalidraw/latest/shortcuts.md` · 4.7k

### `programs/apps/whiteboard/frontends/miro/` · 1

- [ ] `programs/apps/whiteboard/frontends/miro/index.md` · 1.2k

### `programs/apps/whiteboard/frontends/miro/latest/` · 6

- [ ] `programs/apps/whiteboard/frontends/miro/latest/api.md` · 2.4k
- [ ] `programs/apps/whiteboard/frontends/miro/latest/description.md` · 1.2k
- [ ] `programs/apps/whiteboard/frontends/miro/latest/features.md` · 1.3k
- [ ] `programs/apps/whiteboard/frontends/miro/latest/layout.md` · 2.0k
- [ ] `programs/apps/whiteboard/frontends/miro/latest/menus.md` · 1.1k
- [ ] `programs/apps/whiteboard/frontends/miro/latest/shortcuts.md` · 997b

### `programs/apps/whiteboard/frontends/mural/` · 1

- [ ] `programs/apps/whiteboard/frontends/mural/index.md` · 1.2k

### `programs/apps/whiteboard/frontends/mural/latest/` · 6

- [ ] `programs/apps/whiteboard/frontends/mural/latest/api.md` · 1.3k
- [ ] `programs/apps/whiteboard/frontends/mural/latest/description.md` · 1.1k
- [ ] `programs/apps/whiteboard/frontends/mural/latest/features.md` · 1.0k
- [ ] `programs/apps/whiteboard/frontends/mural/latest/layout.md` · 1.8k
- [ ] `programs/apps/whiteboard/frontends/mural/latest/menus.md` · 993b
- [ ] `programs/apps/whiteboard/frontends/mural/latest/shortcuts.md` · 670b

### `programs/apps/whiteboard/frontends/openboard/` · 1

- [ ] `programs/apps/whiteboard/frontends/openboard/index.md` · 1.2k

### `programs/apps/whiteboard/frontends/openboard/latest/` · 6

- [ ] `programs/apps/whiteboard/frontends/openboard/latest/api.md` · 1.2k
- [ ] `programs/apps/whiteboard/frontends/openboard/latest/description.md` · 1.1k
- [ ] `programs/apps/whiteboard/frontends/openboard/latest/features.md` · 1.2k
- [ ] `programs/apps/whiteboard/frontends/openboard/latest/layout.md` · 1.7k
- [ ] `programs/apps/whiteboard/frontends/openboard/latest/menus.md` · 869b
- [ ] `programs/apps/whiteboard/frontends/openboard/latest/shortcuts.md` · 694b

### `programs/apps/whiteboard/frontends/tldraw/` · 1

- [ ] `programs/apps/whiteboard/frontends/tldraw/index.md` · 1.2k

### `programs/apps/whiteboard/frontends/tldraw/latest/` · 6

- [ ] `programs/apps/whiteboard/frontends/tldraw/latest/api.md` · 3.0k
- [ ] `programs/apps/whiteboard/frontends/tldraw/latest/description.md` · 3.2k
- [ ] `programs/apps/whiteboard/frontends/tldraw/latest/features.md` · 4.5k
- [ ] `programs/apps/whiteboard/frontends/tldraw/latest/layout.md` · 2.9k
- [ ] `programs/apps/whiteboard/frontends/tldraw/latest/menus.md` · 1.8k
- [ ] `programs/apps/whiteboard/frontends/tldraw/latest/shortcuts.md` · 1.6k

### `programs/apps/wiki/frontends/confluence/` · 1

- [ ] `programs/apps/wiki/frontends/confluence/changelog.md` · 11.0k

### `programs/apps/wiki/frontends/confluence/latest/` · 3

- [ ] `programs/apps/wiki/frontends/confluence/latest/dependencies.md` · 5.4k
- [ ] `programs/apps/wiki/frontends/confluence/latest/events.md` · 4.9k
- [ ] `programs/apps/wiki/frontends/confluence/latest/limits.md` · 2.0k

### `programs/apps/wiki/frontends/confluence/latest/themes/` · 1

- [ ] `programs/apps/wiki/frontends/confluence/latest/themes/index.md` · 3.0k

### `programs/apps/wiki/frontends/mediawiki/` · 1

- [ ] `programs/apps/wiki/frontends/mediawiki/changelog.md` · 18.0k

### `programs/apps/wiki/frontends/mediawiki/1.46/` · 9

- [ ] `programs/apps/wiki/frontends/mediawiki/1.46/api.md` · 8.2k
- [ ] `programs/apps/wiki/frontends/mediawiki/1.46/dependencies.md` · 6.0k
- [ ] `programs/apps/wiki/frontends/mediawiki/1.46/description.md` · 3.1k
- [ ] `programs/apps/wiki/frontends/mediawiki/1.46/events.md` · 2.8k
- [ ] `programs/apps/wiki/frontends/mediawiki/1.46/features.md` · 5.5k
- [ ] `programs/apps/wiki/frontends/mediawiki/1.46/i18n.md` · 2.6k
- [ ] `programs/apps/wiki/frontends/mediawiki/1.46/layout.md` · 5.1k
- [ ] `programs/apps/wiki/frontends/mediawiki/1.46/limits.md` · 3.0k
- [ ] `programs/apps/wiki/frontends/mediawiki/1.46/shortcuts.md` · 5.6k

### `programs/apps/wiki/frontends/mediawiki/1.46/themes/` · 1

- [ ] `programs/apps/wiki/frontends/mediawiki/1.46/themes/index.md` · 5.9k

### `programs/apps/wiki/frontends/mediawiki/latest/` · 6

- [ ] `programs/apps/wiki/frontends/mediawiki/latest/api.md` · 5.0k · hash changed since verification
- [ ] `programs/apps/wiki/frontends/mediawiki/latest/description.md` · 1.8k · hash changed since verification
- [ ] `programs/apps/wiki/frontends/mediawiki/latest/features.md` · 3.6k · hash changed since verification
- [ ] `programs/apps/wiki/frontends/mediawiki/latest/layout.md` · 5.6k · hash changed since verification
- [ ] `programs/apps/wiki/frontends/mediawiki/latest/menus.md` · 2.0k · hash changed since verification
- [ ] `programs/apps/wiki/frontends/mediawiki/latest/shortcuts.md` · 6.3k · hash changed since verification

### `programs/apps/wiki/frontends/notion/` · 1

- [ ] `programs/apps/wiki/frontends/notion/changelog.md` · 10.4k

### `programs/apps/wiki/frontends/notion/2026-11-07/` · 9

- [ ] `programs/apps/wiki/frontends/notion/2026-11-07/api.md` · 7.5k
- [ ] `programs/apps/wiki/frontends/notion/2026-11-07/dependencies.md` · 5.6k
- [ ] `programs/apps/wiki/frontends/notion/2026-11-07/description.md` · 1.9k
- [ ] `programs/apps/wiki/frontends/notion/2026-11-07/events.md` · 3.2k
- [ ] `programs/apps/wiki/frontends/notion/2026-11-07/features.md` · 4.0k
- [ ] `programs/apps/wiki/frontends/notion/2026-11-07/layout.md` · 2.8k
- [ ] `programs/apps/wiki/frontends/notion/2026-11-07/limits.md` · 2.3k
- [ ] `programs/apps/wiki/frontends/notion/2026-11-07/menus.md` · 1.9k
- [ ] `programs/apps/wiki/frontends/notion/2026-11-07/shortcuts.md` · 4.2k

### `programs/apps/wiki/frontends/notion/2026-11-07/themes/` · 1

- [ ] `programs/apps/wiki/frontends/notion/2026-11-07/themes/index.md` · 2.1k

### `programs/apps/wiki/frontends/notion/latest/` · 3

- [ ] `programs/apps/wiki/frontends/notion/latest/api.md` · 5.2k · hash changed since verification
- [ ] `programs/apps/wiki/frontends/notion/latest/description.md` · 1.8k · hash changed since verification
- [ ] `programs/apps/wiki/frontends/notion/latest/layout.md` · 5.2k · hash changed since verification

### `programs/apps/wiki/frontends/tango/` · 1

- [ ] `programs/apps/wiki/frontends/tango/index.md` · 4.7k

### `programs/apps/wiki/frontends/tango/latest/` · 3

- [ ] `programs/apps/wiki/frontends/tango/latest/dependencies.md` · 3.1k
- [ ] `programs/apps/wiki/frontends/tango/latest/layout.md` · 2.6k
- [ ] `programs/apps/wiki/frontends/tango/latest/shortcuts.md` · 1.4k

### `programs/apps/wiki/frontends/tango/latest/themes/` · 1

- [ ] `programs/apps/wiki/frontends/tango/latest/themes/index.md` · 1.4k

### `programs/apps/wiki/frontends/wikijs/` · 1

- [ ] `programs/apps/wiki/frontends/wikijs/changelog.md` · 15.5k

### `programs/apps/wiki/frontends/wikijs/3.1.1/` · 9

- [ ] `programs/apps/wiki/frontends/wikijs/3.1.1/api.md` · 10.2k
- [ ] `programs/apps/wiki/frontends/wikijs/3.1.1/dependencies.md` · 7.7k
- [ ] `programs/apps/wiki/frontends/wikijs/3.1.1/description.md` · 3.6k
- [ ] `programs/apps/wiki/frontends/wikijs/3.1.1/events.md` · 4.4k
- [ ] `programs/apps/wiki/frontends/wikijs/3.1.1/features.md` · 8.2k
- [ ] `programs/apps/wiki/frontends/wikijs/3.1.1/layout.md` · 5.6k
- [ ] `programs/apps/wiki/frontends/wikijs/3.1.1/limits.md` · 5.1k
- [ ] `programs/apps/wiki/frontends/wikijs/3.1.1/menus.md` · 4.7k
- [ ] `programs/apps/wiki/frontends/wikijs/3.1.1/shortcuts.md` · 3.1k

### `programs/apps/wiki/frontends/wikijs/3.1.1/themes/` · 1

- [ ] `programs/apps/wiki/frontends/wikijs/3.1.1/themes/index.md` · 5.8k

### `programs/apps/wiki/frontends/wikijs/latest/` · 6

- [ ] `programs/apps/wiki/frontends/wikijs/latest/api.md` · 4.1k · hash changed since verification
- [ ] `programs/apps/wiki/frontends/wikijs/latest/description.md` · 2.0k · hash changed since verification
- [ ] `programs/apps/wiki/frontends/wikijs/latest/features.md` · 3.3k · hash changed since verification
- [ ] `programs/apps/wiki/frontends/wikijs/latest/layout.md` · 6.0k · hash changed since verification
- [ ] `programs/apps/wiki/frontends/wikijs/latest/menus.md` · 2.2k · hash changed since verification
- [ ] `programs/apps/wiki/frontends/wikijs/latest/shortcuts.md` · 4.8k · hash changed since verification

### `programs/platform/desktop/frontends/dashy/latest/` · 6

- [ ] `programs/platform/desktop/frontends/dashy/latest/api.md` · 7.1k
- [ ] `programs/platform/desktop/frontends/dashy/latest/description.md` · 3.6k
- [ ] `programs/platform/desktop/frontends/dashy/latest/features.md` · 6.5k
- [ ] `programs/platform/desktop/frontends/dashy/latest/layout.md` · 7.8k
- [ ] `programs/platform/desktop/frontends/dashy/latest/menus.md` · 4.5k
- [ ] `programs/platform/desktop/frontends/dashy/latest/shortcuts.md` · 5.7k

### `programs/platform/desktop/frontends/gethomepage/latest/` · 6

- [ ] `programs/platform/desktop/frontends/gethomepage/latest/api.md` · 8.2k
- [ ] `programs/platform/desktop/frontends/gethomepage/latest/description.md` · 4.3k
- [ ] `programs/platform/desktop/frontends/gethomepage/latest/features.md` · 6.2k
- [ ] `programs/platform/desktop/frontends/gethomepage/latest/layout.md` · 6.7k
- [ ] `programs/platform/desktop/frontends/gethomepage/latest/menus.md` · 5.6k
- [ ] `programs/platform/desktop/frontends/gethomepage/latest/shortcuts.md` · 6.6k

### `programs/platform/desktop/frontends/heimdall/latest/` · 6

- [ ] `programs/platform/desktop/frontends/heimdall/latest/api.md` · 6.8k
- [ ] `programs/platform/desktop/frontends/heimdall/latest/description.md` · 3.5k
- [ ] `programs/platform/desktop/frontends/heimdall/latest/features.md` · 5.8k
- [ ] `programs/platform/desktop/frontends/heimdall/latest/layout.md` · 7.4k
- [ ] `programs/platform/desktop/frontends/heimdall/latest/menus.md` · 4.1k
- [ ] `programs/platform/desktop/frontends/heimdall/latest/shortcuts.md` · 4.9k

### `programs/platform/desktop/frontends/homarr/latest/` · 5

- [ ] `programs/platform/desktop/frontends/homarr/latest/api.md` · 7.9k
- [ ] `programs/platform/desktop/frontends/homarr/latest/description.md` · 3.4k
- [ ] `programs/platform/desktop/frontends/homarr/latest/features.md` · 5.8k
- [ ] `programs/platform/desktop/frontends/homarr/latest/menus.md` · 4.3k
- [ ] `programs/platform/desktop/frontends/homarr/latest/shortcuts.md` · 5.4k

### `programs/platform/desktop/frontends/homepage/latest/` · 6

- [ ] `programs/platform/desktop/frontends/homepage/latest/api.md` · 9.1k
- [ ] `programs/platform/desktop/frontends/homepage/latest/description.md` · 3.9k
- [ ] `programs/platform/desktop/frontends/homepage/latest/features.md` · 6.6k
- [ ] `programs/platform/desktop/frontends/homepage/latest/layout.md` · 7.1k
- [ ] `programs/platform/desktop/frontends/homepage/latest/menus.md` · 5.4k
- [ ] `programs/platform/desktop/frontends/homepage/latest/shortcuts.md` · 5.6k

### `programs/platform/desktop/frontends/homer/latest/` · 6

- [ ] `programs/platform/desktop/frontends/homer/latest/api.md` · 7.0k
- [ ] `programs/platform/desktop/frontends/homer/latest/description.md` · 3.1k
- [ ] `programs/platform/desktop/frontends/homer/latest/features.md` · 5.3k
- [ ] `programs/platform/desktop/frontends/homer/latest/layout.md` · 7.5k
- [ ] `programs/platform/desktop/frontends/homer/latest/menus.md` · 4.3k
- [ ] `programs/platform/desktop/frontends/homer/latest/shortcuts.md` · 5.0k

### `programs/platform/desktop/frontends/launchboard/latest/` · 6

- [ ] `programs/platform/desktop/frontends/launchboard/latest/api.md` · 8.7k
- [ ] `programs/platform/desktop/frontends/launchboard/latest/description.md` · 4.6k
- [ ] `programs/platform/desktop/frontends/launchboard/latest/features.md` · 6.4k
- [ ] `programs/platform/desktop/frontends/launchboard/latest/layout.md` · 8.6k
- [ ] `programs/platform/desktop/frontends/launchboard/latest/menus.md` · 4.6k
- [ ] `programs/platform/desktop/frontends/launchboard/latest/shortcuts.md` · 6.0k

### `programs/platform/desktop/frontends/opnsense/latest/` · 6

- [ ] `programs/platform/desktop/frontends/opnsense/latest/api.md` · 7.1k
- [ ] `programs/platform/desktop/frontends/opnsense/latest/description.md` · 3.6k
- [ ] `programs/platform/desktop/frontends/opnsense/latest/features.md` · 5.2k
- [ ] `programs/platform/desktop/frontends/opnsense/latest/layout.md` · 6.5k
- [ ] `programs/platform/desktop/frontends/opnsense/latest/menus.md` · 5.5k
- [ ] `programs/platform/desktop/frontends/opnsense/latest/shortcuts.md` · 5.4k

### `programs/platform/desktop/frontends/proxmox/latest/` · 6

- [ ] `programs/platform/desktop/frontends/proxmox/latest/api.md` · 6.4k
- [ ] `programs/platform/desktop/frontends/proxmox/latest/description.md` · 3.8k
- [ ] `programs/platform/desktop/frontends/proxmox/latest/features.md` · 5.5k
- [ ] `programs/platform/desktop/frontends/proxmox/latest/layout.md` · 7.2k
- [ ] `programs/platform/desktop/frontends/proxmox/latest/menus.md` · 5.0k
- [ ] `programs/platform/desktop/frontends/proxmox/latest/shortcuts.md` · 5.5k

### `programs/platform/desktop/frontends/synology-dsm/latest/` · 6

- [ ] `programs/platform/desktop/frontends/synology-dsm/latest/api.md` · 7.9k
- [ ] `programs/platform/desktop/frontends/synology-dsm/latest/description.md` · 4.5k
- [ ] `programs/platform/desktop/frontends/synology-dsm/latest/features.md` · 6.6k
- [ ] `programs/platform/desktop/frontends/synology-dsm/latest/layout.md` · 8.1k
- [ ] `programs/platform/desktop/frontends/synology-dsm/latest/menus.md` · 4.9k
- [ ] `programs/platform/desktop/frontends/synology-dsm/latest/shortcuts.md` · 6.0k

### `programs/platform/desktop/frontends/truenas/latest/` · 6

- [ ] `programs/platform/desktop/frontends/truenas/latest/api.md` · 6.2k
- [ ] `programs/platform/desktop/frontends/truenas/latest/description.md` · 3.7k
- [ ] `programs/platform/desktop/frontends/truenas/latest/features.md` · 5.4k
- [ ] `programs/platform/desktop/frontends/truenas/latest/layout.md` · 6.3k
- [ ] `programs/platform/desktop/frontends/truenas/latest/menus.md` · 4.7k
- [ ] `programs/platform/desktop/frontends/truenas/latest/shortcuts.md` · 5.4k

### `programs/platform/desktop/frontends/unraid/latest/` · 5

- [ ] `programs/platform/desktop/frontends/unraid/latest/api.md` · 6.7k
- [ ] `programs/platform/desktop/frontends/unraid/latest/description.md` · 3.5k
- [ ] `programs/platform/desktop/frontends/unraid/latest/features.md` · 5.6k
- [ ] `programs/platform/desktop/frontends/unraid/latest/menus.md` · 4.7k
- [ ] `programs/platform/desktop/frontends/unraid/latest/shortcuts.md` · 5.3k

### `programs/suites/crm/frontends/civicrm/latest/` · 6

- [ ] `programs/suites/crm/frontends/civicrm/latest/api.md` · 2.5k
- [ ] `programs/suites/crm/frontends/civicrm/latest/description.md` · 1.6k
- [ ] `programs/suites/crm/frontends/civicrm/latest/features.md` · 1.7k
- [ ] `programs/suites/crm/frontends/civicrm/latest/layout.md` · 2.4k
- [ ] `programs/suites/crm/frontends/civicrm/latest/menus.md` · 1.5k
- [ ] `programs/suites/crm/frontends/civicrm/latest/shortcuts.md` · 648b

### `programs/suites/crm/frontends/espocrm/latest/` · 6

- [ ] `programs/suites/crm/frontends/espocrm/latest/api.md` · 2.3k
- [ ] `programs/suites/crm/frontends/espocrm/latest/description.md` · 1.4k
- [ ] `programs/suites/crm/frontends/espocrm/latest/features.md` · 1.4k
- [ ] `programs/suites/crm/frontends/espocrm/latest/layout.md` · 2.1k
- [ ] `programs/suites/crm/frontends/espocrm/latest/menus.md` · 1.2k
- [ ] `programs/suites/crm/frontends/espocrm/latest/shortcuts.md` · 773b

### `programs/suites/crm/frontends/hubspot/latest/` · 6

- [ ] `programs/suites/crm/frontends/hubspot/latest/api.md` · 2.5k
- [ ] `programs/suites/crm/frontends/hubspot/latest/description.md` · 1.3k
- [ ] `programs/suites/crm/frontends/hubspot/latest/features.md` · 1.3k
- [ ] `programs/suites/crm/frontends/hubspot/latest/layout.md` · 2.1k
- [ ] `programs/suites/crm/frontends/hubspot/latest/menus.md` · 1.3k
- [ ] `programs/suites/crm/frontends/hubspot/latest/shortcuts.md` · 631b

### `programs/suites/crm/frontends/pipedrive/latest/` · 6

- [ ] `programs/suites/crm/frontends/pipedrive/latest/api.md` · 6.9k
- [ ] `programs/suites/crm/frontends/pipedrive/latest/description.md` · 3.3k
- [ ] `programs/suites/crm/frontends/pipedrive/latest/features.md` · 5.6k
- [ ] `programs/suites/crm/frontends/pipedrive/latest/layout.md` · 6.1k
- [ ] `programs/suites/crm/frontends/pipedrive/latest/menus.md` · 4.3k
- [ ] `programs/suites/crm/frontends/pipedrive/latest/shortcuts.md` · 6.3k

### `programs/suites/crm/frontends/salesforce/latest/` · 6

- [ ] `programs/suites/crm/frontends/salesforce/latest/api.md` · 2.7k
- [ ] `programs/suites/crm/frontends/salesforce/latest/description.md` · 1.6k
- [ ] `programs/suites/crm/frontends/salesforce/latest/features.md` · 1.5k
- [ ] `programs/suites/crm/frontends/salesforce/latest/layout.md` · 2.3k
- [ ] `programs/suites/crm/frontends/salesforce/latest/menus.md` · 1.4k
- [ ] `programs/suites/crm/frontends/salesforce/latest/shortcuts.md` · 965b

### `programs/suites/crm/frontends/suitecrm/latest/` · 6

- [ ] `programs/suites/crm/frontends/suitecrm/latest/api.md` · 7.9k
- [ ] `programs/suites/crm/frontends/suitecrm/latest/description.md` · 3.2k
- [ ] `programs/suites/crm/frontends/suitecrm/latest/features.md` · 6.2k
- [ ] `programs/suites/crm/frontends/suitecrm/latest/layout.md` · 6.2k
- [ ] `programs/suites/crm/frontends/suitecrm/latest/menus.md` · 4.3k
- [ ] `programs/suites/crm/frontends/suitecrm/latest/shortcuts.md` · 6.4k

### `programs/suites/democracy/` · 1

- [ ] `programs/suites/democracy/index.md` · 4.2k · Plan[~] · hash changed since verification

### `programs/suites/democracy/frontends/` · 1

- [ ] `programs/suites/democracy/frontends/index.md` · 4.0k · hash changed since verification

### `programs/suites/democracy/frontends/adhocracy4/latest/` · 5

- [ ] `programs/suites/democracy/frontends/adhocracy4/latest/api.md` · 1.8k
- [ ] `programs/suites/democracy/frontends/adhocracy4/latest/description.md` · 1.3k
- [ ] `programs/suites/democracy/frontends/adhocracy4/latest/features.md` · 1.2k
- [ ] `programs/suites/democracy/frontends/adhocracy4/latest/menus.md` · 959b
- [ ] `programs/suites/democracy/frontends/adhocracy4/latest/shortcuts.md` · 417b

### `programs/suites/democracy/frontends/circo/latest/` · 6

- [ ] `programs/suites/democracy/frontends/circo/latest/api.md` · 1.1k
- [ ] `programs/suites/democracy/frontends/circo/latest/description.md` · 1.2k
- [ ] `programs/suites/democracy/frontends/circo/latest/features.md` · 874b
- [ ] `programs/suites/democracy/frontends/circo/latest/layout.md` · 890b
- [ ] `programs/suites/democracy/frontends/circo/latest/menus.md` · 827b
- [ ] `programs/suites/democracy/frontends/circo/latest/shortcuts.md` · 314b

### `programs/suites/democracy/frontends/consul/latest/` · 5

- [ ] `programs/suites/democracy/frontends/consul/latest/api.md` · 1.7k
- [ ] `programs/suites/democracy/frontends/consul/latest/description.md` · 1.1k
- [ ] `programs/suites/democracy/frontends/consul/latest/features.md` · 1.1k
- [ ] `programs/suites/democracy/frontends/consul/latest/menus.md` · 969b
- [ ] `programs/suites/democracy/frontends/consul/latest/shortcuts.md` · 377b

### `programs/suites/democracy/frontends/decidim/latest/` · 6

- [ ] `programs/suites/democracy/frontends/decidim/latest/api.md` · 1.8k
- [ ] `programs/suites/democracy/frontends/decidim/latest/description.md` · 1.3k
- [ ] `programs/suites/democracy/frontends/decidim/latest/features.md` · 1.3k
- [ ] `programs/suites/democracy/frontends/decidim/latest/layout.md` · 1.6k
- [ ] `programs/suites/democracy/frontends/decidim/latest/menus.md` · 870b
- [ ] `programs/suites/democracy/frontends/decidim/latest/shortcuts.md` · 455b

### `programs/suites/democracy/frontends/liquid-feedback/latest/` · 6

- [ ] `programs/suites/democracy/frontends/liquid-feedback/latest/api.md` · 1.5k
- [ ] `programs/suites/democracy/frontends/liquid-feedback/latest/description.md` · 1.3k
- [ ] `programs/suites/democracy/frontends/liquid-feedback/latest/features.md` · 1.2k
- [ ] `programs/suites/democracy/frontends/liquid-feedback/latest/layout.md` · 1.8k
- [ ] `programs/suites/democracy/frontends/liquid-feedback/latest/menus.md` · 1.0k
- [ ] `programs/suites/democracy/frontends/liquid-feedback/latest/shortcuts.md` · 364b

### `programs/suites/democracy/frontends/polis/latest/` · 6

- [ ] `programs/suites/democracy/frontends/polis/latest/api.md` · 1.7k
- [ ] `programs/suites/democracy/frontends/polis/latest/description.md` · 1.3k
- [ ] `programs/suites/democracy/frontends/polis/latest/features.md` · 1.1k
- [ ] `programs/suites/democracy/frontends/polis/latest/layout.md` · 1.6k
- [ ] `programs/suites/democracy/frontends/polis/latest/menus.md` · 857b
- [ ] `programs/suites/democracy/frontends/polis/latest/shortcuts.md` · 421b

### `programs/suites/erp/` · 1

- [ ] `programs/suites/erp/index.md` · 4.1k · Plan[~] · hash changed since verification

### `programs/suites/erp/frontends/` · 1

- [ ] `programs/suites/erp/frontends/index.md` · 3.9k · hash changed since verification

### `programs/suites/erp/frontends/axelor/latest/` · 6

- [ ] `programs/suites/erp/frontends/axelor/latest/api.md` · 2.1k
- [ ] `programs/suites/erp/frontends/axelor/latest/description.md` · 1.2k
- [ ] `programs/suites/erp/frontends/axelor/latest/features.md` · 1.1k
- [ ] `programs/suites/erp/frontends/axelor/latest/layout.md` · 1.6k
- [ ] `programs/suites/erp/frontends/axelor/latest/menus.md` · 886b
- [ ] `programs/suites/erp/frontends/axelor/latest/shortcuts.md` · 426b

### `programs/suites/erp/frontends/dolibarr/latest/` · 6

- [ ] `programs/suites/erp/frontends/dolibarr/latest/api.md` · 2.6k
- [ ] `programs/suites/erp/frontends/dolibarr/latest/description.md` · 1.2k
- [ ] `programs/suites/erp/frontends/dolibarr/latest/features.md` · 1.2k
- [ ] `programs/suites/erp/frontends/dolibarr/latest/layout.md` · 1.8k
- [ ] `programs/suites/erp/frontends/dolibarr/latest/menus.md` · 1.0k
- [ ] `programs/suites/erp/frontends/dolibarr/latest/shortcuts.md` · 438b

### `programs/suites/erp/frontends/erpnext/latest/` · 6

- [ ] `programs/suites/erp/frontends/erpnext/latest/api.md` · 2.2k
- [ ] `programs/suites/erp/frontends/erpnext/latest/description.md` · 1.4k
- [ ] `programs/suites/erp/frontends/erpnext/latest/features.md` · 1.3k
- [ ] `programs/suites/erp/frontends/erpnext/latest/layout.md` · 1.8k
- [ ] `programs/suites/erp/frontends/erpnext/latest/menus.md` · 912b
- [ ] `programs/suites/erp/frontends/erpnext/latest/shortcuts.md` · 547b

### `programs/suites/erp/frontends/odoo/latest/` · 5

- [ ] `programs/suites/erp/frontends/odoo/latest/api.md` · 2.4k
- [ ] `programs/suites/erp/frontends/odoo/latest/description.md` · 1.4k
- [ ] `programs/suites/erp/frontends/odoo/latest/features.md` · 1.4k
- [ ] `programs/suites/erp/frontends/odoo/latest/menus.md` · 1.0k
- [ ] `programs/suites/erp/frontends/odoo/latest/shortcuts.md` · 813b

### `programs/suites/erp/frontends/sage/latest/` · 5

- [ ] `programs/suites/erp/frontends/sage/latest/api.md` · 1.8k
- [ ] `programs/suites/erp/frontends/sage/latest/description.md` · 1.4k
- [ ] `programs/suites/erp/frontends/sage/latest/features.md` · 1.1k
- [ ] `programs/suites/erp/frontends/sage/latest/menus.md` · 964b
- [ ] `programs/suites/erp/frontends/sage/latest/shortcuts.md` · 766b

### `programs/suites/erp/frontends/tryton/latest/` · 6

- [ ] `programs/suites/erp/frontends/tryton/latest/api.md` · 2.2k
- [ ] `programs/suites/erp/frontends/tryton/latest/description.md` · 1.1k
- [ ] `programs/suites/erp/frontends/tryton/latest/features.md` · 1.0k
- [ ] `programs/suites/erp/frontends/tryton/latest/layout.md` · 1.7k
- [ ] `programs/suites/erp/frontends/tryton/latest/menus.md` · 984b
- [ ] `programs/suites/erp/frontends/tryton/latest/shortcuts.md` · 578b

### `programs/suites/marketplace/` · 1

- [ ] `programs/suites/marketplace/index.md` · 3.8k · Plan[~]

### `programs/suites/marketplace/frontends/` · 1

- [ ] `programs/suites/marketplace/frontends/index.md` · 3.8k · hash changed since verification

### `programs/suites/marketplace/frontends/arcemall/latest/` · 6

- [ ] `programs/suites/marketplace/frontends/arcemall/latest/api.md` · 1.4k
- [ ] `programs/suites/marketplace/frontends/arcemall/latest/description.md` · 1.3k
- [ ] `programs/suites/marketplace/frontends/arcemall/latest/features.md` · 923b
- [ ] `programs/suites/marketplace/frontends/arcemall/latest/layout.md` · 889b
- [ ] `programs/suites/marketplace/frontends/arcemall/latest/menus.md` · 730b
- [ ] `programs/suites/marketplace/frontends/arcemall/latest/shortcuts.md` · 300b

### `programs/suites/marketplace/frontends/cs-cart-multivendor/latest/` · 6

- [ ] `programs/suites/marketplace/frontends/cs-cart-multivendor/latest/api.md` · 1.7k
- [ ] `programs/suites/marketplace/frontends/cs-cart-multivendor/latest/description.md` · 1.1k
- [ ] `programs/suites/marketplace/frontends/cs-cart-multivendor/latest/features.md` · 878b
- [ ] `programs/suites/marketplace/frontends/cs-cart-multivendor/latest/layout.md` · 935b
- [ ] `programs/suites/marketplace/frontends/cs-cart-multivendor/latest/menus.md` · 896b
- [ ] `programs/suites/marketplace/frontends/cs-cart-multivendor/latest/shortcuts.md` · 394b

### `programs/suites/marketplace/frontends/ebay/latest/` · 6

- [ ] `programs/suites/marketplace/frontends/ebay/latest/api.md` · 2.5k
- [ ] `programs/suites/marketplace/frontends/ebay/latest/description.md` · 1.1k
- [ ] `programs/suites/marketplace/frontends/ebay/latest/features.md` · 1.2k
- [ ] `programs/suites/marketplace/frontends/ebay/latest/layout.md` · 917b
- [ ] `programs/suites/marketplace/frontends/ebay/latest/menus.md` · 908b
- [ ] `programs/suites/marketplace/frontends/ebay/latest/shortcuts.md` · 426b

### `programs/suites/marketplace/frontends/etsy/latest/` · 6

- [ ] `programs/suites/marketplace/frontends/etsy/latest/api.md` · 2.0k
- [ ] `programs/suites/marketplace/frontends/etsy/latest/description.md` · 1.0k
- [ ] `programs/suites/marketplace/frontends/etsy/latest/features.md` · 952b
- [ ] `programs/suites/marketplace/frontends/etsy/latest/layout.md` · 930b
- [ ] `programs/suites/marketplace/frontends/etsy/latest/menus.md` · 850b
- [ ] `programs/suites/marketplace/frontends/etsy/latest/shortcuts.md` · 374b

### `programs/suites/marketplace/frontends/kleinanzeigen/latest/` · 6

- [ ] `programs/suites/marketplace/frontends/kleinanzeigen/latest/api.md` · 1.2k
- [ ] `programs/suites/marketplace/frontends/kleinanzeigen/latest/description.md` · 1.1k
- [ ] `programs/suites/marketplace/frontends/kleinanzeigen/latest/features.md` · 963b
- [ ] `programs/suites/marketplace/frontends/kleinanzeigen/latest/layout.md` · 1.5k
- [ ] `programs/suites/marketplace/frontends/kleinanzeigen/latest/menus.md` · 796b
- [ ] `programs/suites/marketplace/frontends/kleinanzeigen/latest/shortcuts.md` · 328b

### `programs/suites/marketplace/frontends/sharetribe/latest/` · 6

- [ ] `programs/suites/marketplace/frontends/sharetribe/latest/api.md` · 2.3k
- [ ] `programs/suites/marketplace/frontends/sharetribe/latest/description.md` · 1.4k
- [ ] `programs/suites/marketplace/frontends/sharetribe/latest/features.md` · 1.2k
- [ ] `programs/suites/marketplace/frontends/sharetribe/latest/layout.md` · 1.7k
- [ ] `programs/suites/marketplace/frontends/sharetribe/latest/menus.md` · 946b
- [ ] `programs/suites/marketplace/frontends/sharetribe/latest/shortcuts.md` · 389b

### `programs/suites/projectmanagement/` · 1

- [ ] `programs/suites/projectmanagement/requirements.md` · 593b

### `programs/suites/projectmanagement/frontends/asana/` · 1

- [ ] `programs/suites/projectmanagement/frontends/asana/index.md` · 1.2k

### `programs/suites/projectmanagement/frontends/asana/latest/` · 6

- [ ] `programs/suites/projectmanagement/frontends/asana/latest/api.md` · 2.3k
- [ ] `programs/suites/projectmanagement/frontends/asana/latest/description.md` · 1.2k
- [ ] `programs/suites/projectmanagement/frontends/asana/latest/features.md` · 1.3k
- [ ] `programs/suites/projectmanagement/frontends/asana/latest/layout.md` · 2.0k
- [ ] `programs/suites/projectmanagement/frontends/asana/latest/menus.md` · 1.1k
- [ ] `programs/suites/projectmanagement/frontends/asana/latest/shortcuts.md` · 763b

### `programs/suites/projectmanagement/frontends/openproject/` · 1

- [ ] `programs/suites/projectmanagement/frontends/openproject/index.md` · 1.3k

### `programs/suites/projectmanagement/frontends/openproject/latest/` · 6

- [ ] `programs/suites/projectmanagement/frontends/openproject/latest/api.md` · 6.6k
- [ ] `programs/suites/projectmanagement/frontends/openproject/latest/description.md` · 3.4k
- [ ] `programs/suites/projectmanagement/frontends/openproject/latest/features.md` · 4.6k
- [ ] `programs/suites/projectmanagement/frontends/openproject/latest/layout.md` · 4.8k
- [ ] `programs/suites/projectmanagement/frontends/openproject/latest/menus.md` · 4.0k
- [ ] `programs/suites/projectmanagement/frontends/openproject/latest/shortcuts.md` · 4.9k

### `programs/suites/projectmanagement/frontends/planka/` · 1

- [ ] `programs/suites/projectmanagement/frontends/planka/index.md` · 1.2k

### `programs/suites/projectmanagement/frontends/planka/latest/` · 6

- [ ] `programs/suites/projectmanagement/frontends/planka/latest/api.md` · 2.8k
- [ ] `programs/suites/projectmanagement/frontends/planka/latest/description.md` · 3.3k
- [ ] `programs/suites/projectmanagement/frontends/planka/latest/features.md` · 4.2k
- [ ] `programs/suites/projectmanagement/frontends/planka/latest/layout.md` · 3.0k
- [ ] `programs/suites/projectmanagement/frontends/planka/latest/menus.md` · 3.6k
- [ ] `programs/suites/projectmanagement/frontends/planka/latest/shortcuts.md` · 1.1k

### `programs/suites/projectmanagement/frontends/redmine/` · 1

- [ ] `programs/suites/projectmanagement/frontends/redmine/index.md` · 1.3k

### `programs/suites/projectmanagement/frontends/redmine/latest/` · 6

- [ ] `programs/suites/projectmanagement/frontends/redmine/latest/api.md` · 6.9k
- [ ] `programs/suites/projectmanagement/frontends/redmine/latest/description.md` · 3.3k
- [ ] `programs/suites/projectmanagement/frontends/redmine/latest/features.md` · 4.8k
- [ ] `programs/suites/projectmanagement/frontends/redmine/latest/layout.md` · 4.7k
- [ ] `programs/suites/projectmanagement/frontends/redmine/latest/menus.md` · 3.3k
- [ ] `programs/suites/projectmanagement/frontends/redmine/latest/shortcuts.md` · 5.3k

### `programs/suites/projectmanagement/frontends/taiga/` · 1

- [ ] `programs/suites/projectmanagement/frontends/taiga/index.md` · 1.2k

### `programs/suites/projectmanagement/frontends/taiga/latest/` · 6

- [ ] `programs/suites/projectmanagement/frontends/taiga/latest/api.md` · 2.2k
- [ ] `programs/suites/projectmanagement/frontends/taiga/latest/description.md` · 1.3k
- [ ] `programs/suites/projectmanagement/frontends/taiga/latest/features.md` · 1.2k
- [ ] `programs/suites/projectmanagement/frontends/taiga/latest/layout.md` · 2.0k
- [ ] `programs/suites/projectmanagement/frontends/taiga/latest/menus.md` · 1.2k
- [ ] `programs/suites/projectmanagement/frontends/taiga/latest/shortcuts.md` · 511b

### `programs/suites/projectmanagement/frontends/trello/` · 1

- [ ] `programs/suites/projectmanagement/frontends/trello/index.md` · 1.2k

### `programs/suites/projectmanagement/frontends/trello/latest/` · 6

- [ ] `programs/suites/projectmanagement/frontends/trello/latest/api.md` · 2.5k
- [ ] `programs/suites/projectmanagement/frontends/trello/latest/description.md` · 1.3k
- [ ] `programs/suites/projectmanagement/frontends/trello/latest/features.md` · 1.2k
- [ ] `programs/suites/projectmanagement/frontends/trello/latest/layout.md` · 2.3k
- [ ] `programs/suites/projectmanagement/frontends/trello/latest/menus.md` · 1.0k
- [ ] `programs/suites/projectmanagement/frontends/trello/latest/shortcuts.md` · 874b

### `programs/suites/projectmanagement/frontends/wekan/` · 1

- [ ] `programs/suites/projectmanagement/frontends/wekan/index.md` · 1.2k

### `programs/suites/projectmanagement/frontends/wekan/latest/` · 6

- [ ] `programs/suites/projectmanagement/frontends/wekan/latest/api.md` · 2.5k
- [ ] `programs/suites/projectmanagement/frontends/wekan/latest/description.md` · 1.2k
- [ ] `programs/suites/projectmanagement/frontends/wekan/latest/features.md` · 1.2k
- [ ] `programs/suites/projectmanagement/frontends/wekan/latest/layout.md` · 2.5k
- [ ] `programs/suites/projectmanagement/frontends/wekan/latest/menus.md` · 1.1k
- [ ] `programs/suites/projectmanagement/frontends/wekan/latest/shortcuts.md` · 760b

### `programs/suites/workflows/frontends/apache-airflow/latest/` · 6

- [ ] `programs/suites/workflows/frontends/apache-airflow/latest/api.md` · 2.5k
- [ ] `programs/suites/workflows/frontends/apache-airflow/latest/description.md` · 1.3k
- [ ] `programs/suites/workflows/frontends/apache-airflow/latest/features.md` · 1.3k
- [ ] `programs/suites/workflows/frontends/apache-airflow/latest/layout.md` · 2.0k
- [ ] `programs/suites/workflows/frontends/apache-airflow/latest/menus.md` · 987b
- [ ] `programs/suites/workflows/frontends/apache-airflow/latest/shortcuts.md` · 737b

### `programs/suites/workflows/frontends/make/latest/` · 6

- [ ] `programs/suites/workflows/frontends/make/latest/api.md` · 2.1k
- [ ] `programs/suites/workflows/frontends/make/latest/description.md` · 1.2k
- [ ] `programs/suites/workflows/frontends/make/latest/features.md` · 1.3k
- [ ] `programs/suites/workflows/frontends/make/latest/layout.md` · 1.9k
- [ ] `programs/suites/workflows/frontends/make/latest/menus.md` · 943b
- [ ] `programs/suites/workflows/frontends/make/latest/shortcuts.md` · 465b

### `programs/suites/workflows/frontends/n8n/latest/` · 6

- [ ] `programs/suites/workflows/frontends/n8n/latest/api.md` · 2.3k
- [ ] `programs/suites/workflows/frontends/n8n/latest/description.md` · 1.2k
- [ ] `programs/suites/workflows/frontends/n8n/latest/features.md` · 1.3k
- [ ] `programs/suites/workflows/frontends/n8n/latest/layout.md` · 2.0k
- [ ] `programs/suites/workflows/frontends/n8n/latest/menus.md` · 1.2k
- [ ] `programs/suites/workflows/frontends/n8n/latest/shortcuts.md` · 730b

### `programs/suites/workflows/frontends/node-red/latest/` · 5

- [ ] `programs/suites/workflows/frontends/node-red/latest/description.md` · 1.2k
- [ ] `programs/suites/workflows/frontends/node-red/latest/features.md` · 1.4k
- [ ] `programs/suites/workflows/frontends/node-red/latest/layout.md` · 2.0k
- [ ] `programs/suites/workflows/frontends/node-red/latest/menus.md` · 1.1k
- [ ] `programs/suites/workflows/frontends/node-red/latest/shortcuts.md` · 789b

### `programs/suites/workflows/frontends/prefect/latest/` · 6

- [ ] `programs/suites/workflows/frontends/prefect/latest/api.md` · 2.3k
- [ ] `programs/suites/workflows/frontends/prefect/latest/description.md` · 1.3k
- [ ] `programs/suites/workflows/frontends/prefect/latest/features.md` · 1.4k
- [ ] `programs/suites/workflows/frontends/prefect/latest/layout.md` · 1.9k
- [ ] `programs/suites/workflows/frontends/prefect/latest/menus.md` · 961b
- [ ] `programs/suites/workflows/frontends/prefect/latest/shortcuts.md` · 694b

### `programs/suites/workflows/frontends/zapier/latest/` · 6

- [ ] `programs/suites/workflows/frontends/zapier/latest/api.md` · 2.1k
- [ ] `programs/suites/workflows/frontends/zapier/latest/description.md` · 1.1k
- [ ] `programs/suites/workflows/frontends/zapier/latest/features.md` · 1.1k
- [ ] `programs/suites/workflows/frontends/zapier/latest/layout.md` · 2.1k
- [ ] `programs/suites/workflows/frontends/zapier/latest/menus.md` · 1.0k
- [ ] `programs/suites/workflows/frontends/zapier/latest/shortcuts.md` · 414b

### `start/` · 3

- [ ] `start/help.md` · 2.4k
- [ ] `start/index.md` · 521b
- [ ] `start/install.md` · 4.9k

## 🗑️ Gelöscht – 156

- [x] `data/anforderungen.md` · nicht mehr im Baum
- [x] `data/contacts/description.md` · nicht mehr im Baum
- [x] `data/contacts/examples.md` · nicht mehr im Baum
- [x] `data/contacts/index.md` · nicht mehr im Baum
- [x] `data/contacts/jscontact/beschreibung.md` · nicht mehr im Baum
- [x] `data/contacts/jscontact/description.md` · nicht mehr im Baum
- [x] `data/contacts/jscontact/speicherung.md` · nicht mehr im Baum
- [x] `data/contacts/jscontact/storage.md` · nicht mehr im Baum
- [x] `data/contacts/standards.md` · nicht mehr im Baum
- [x] `data/contacts/technical.md` · nicht mehr im Baum
- [x] `data/felder.md` · nicht mehr im Baum
- [x] `data/formate.md` · nicht mehr im Baum
- [x] `data/konventionen.md` · nicht mehr im Baum
- [x] `data/modelle.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/gnome-contacts/index.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/gnome-contacts/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/gnome-contacts/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/gnome-contacts/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/gnome-contacts/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/gnome-contacts/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/gnome-contacts/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/index.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/kaddressbook/index.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/kaddressbook/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/kaddressbook/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/kaddressbook/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/kaddressbook/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/kaddressbook/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/kaddressbook/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/monica/index.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/monica/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/monica/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/monica/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/monica/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/monica/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/monica/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/nextcloud-contacts/index.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/nextcloud-contacts/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/nextcloud-contacts/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/nextcloud-contacts/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/nextcloud-contacts/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/nextcloud-contacts/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/contact/frontends/nextcloud-contacts/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/contact/index.md` · nicht mehr im Baum
- [x] `programs/apps/contact/requirements.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/asana/index.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/asana/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/asana/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/asana/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/asana/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/asana/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/asana/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/index.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/jira/index.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/jira/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/jira/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/jira/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/jira/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/jira/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/jira/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/openproject/index.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/openproject/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/openproject/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/openproject/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/openproject/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/openproject/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/openproject/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/planka/index.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/planka/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/planka/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/planka/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/planka/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/planka/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/planka/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/redmine/index.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/redmine/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/redmine/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/redmine/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/redmine/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/redmine/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/redmine/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/taiga/index.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/taiga/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/taiga/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/taiga/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/taiga/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/taiga/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/taiga/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/trello/index.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/trello/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/trello/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/trello/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/trello/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/trello/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/trello/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/wekan/index.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/wekan/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/wekan/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/wekan/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/wekan/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/wekan/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/frontends/wekan/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/index.md` · nicht mehr im Baum
- [x] `programs/apps/projectmanagement/requirements.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/drawio/index.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/drawio/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/drawio/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/drawio/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/drawio/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/drawio/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/drawio/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/excalidraw/index.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/excalidraw/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/excalidraw/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/excalidraw/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/excalidraw/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/excalidraw/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/excalidraw/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/index.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/miro/index.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/miro/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/miro/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/miro/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/miro/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/miro/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/miro/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/mural/index.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/mural/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/mural/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/mural/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/mural/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/mural/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/mural/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/openboard/index.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/openboard/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/openboard/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/openboard/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/openboard/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/openboard/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/openboard/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/tldraw/index.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/tldraw/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/tldraw/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/tldraw/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/tldraw/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/tldraw/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/frontends/tldraw/latest/shortcuts.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/index.md` · nicht mehr im Baum
- [x] `programs/apps/whiteboards/requirements.md` · nicht mehr im Baum
- [x] `programs/apps/wiki/frontends/tango.io/index.md` · nicht mehr im Baum
- [x] `programs/apps/wiki/frontends/tango.io/latest/api.md` · nicht mehr im Baum
- [x] `programs/apps/wiki/frontends/tango.io/latest/description.md` · nicht mehr im Baum
- [x] `programs/apps/wiki/frontends/tango.io/latest/features.md` · nicht mehr im Baum
- [x] `programs/apps/wiki/frontends/tango.io/latest/layout.md` · nicht mehr im Baum
- [x] `programs/apps/wiki/frontends/tango.io/latest/menus.md` · nicht mehr im Baum
- [x] `programs/apps/wiki/frontends/tango.io/latest/shortcuts.md` · nicht mehr im Baum

## Changelog

- 2026-11-05 15:27 · Lauf: 1532 verfolgt, 554 offen, 971 bestätigt · needs_en=423 needs_de=17 parity=27 review=87
- 2026-11-05 15:28 · Lauf: 1532 verfolgt, 467 offen, 1058 bestätigt · needs_en=423 needs_de=17 parity=27
- 2026-11-05 15:43 · Lauf: 1537 verfolgt, 476 offen, 1054 bestätigt · needs_en=423 needs_de=22 parity=13 review=18
- 2026-11-05 16:18 · Lauf: 1537 verfolgt, 458 offen, 1072 bestätigt · needs_en=423 needs_de=22 parity=13
- 2026-11-05 16:19 · Lauf: 1537 verfolgt, 458 offen, 1072 bestätigt · needs_en=423 needs_de=5 parity=13 review=17
- 2026-11-05 16:19 · Lauf: 1537 verfolgt, 441 offen, 1089 bestätigt · needs_en=423 needs_de=5 parity=13
- 2026-11-05 16:21 · Lauf: 1537 verfolgt, 441 offen, 1089 bestätigt · needs_en=423 needs_de=2 parity=13 review=3
- 2026-11-05 16:23 · Lauf: 1537 verfolgt, 441 offen, 1089 bestätigt · needs_en=423 parity=13 review=5
- 2026-11-05 16:23 · Lauf: 1537 verfolgt, 436 offen, 1094 bestätigt · needs_en=423 parity=13
- 2026-11-05 16:43 · Lauf: 1537 verfolgt, 437 offen, 1093 bestätigt · needs_en=423 parity=1 review=13
- 2026-11-05 16:44 · Lauf: 1537 verfolgt, 437 offen, 1093 bestätigt · needs_en=423 review=14
- 2026-11-05 16:44 · Lauf: 1537 verfolgt, 423 offen, 1107 bestätigt · needs_en=423
- 2026-11-05 16:55 · Lauf: 1537 verfolgt, 431 offen, 1099 bestätigt · needs_en=417 parity=5 review=9
- 2026-11-05 17:01 · Lauf: 1537 verfolgt, 425 offen, 1105 bestätigt · needs_en=411 parity=5 review=9
- 2026-11-05 17:10 · Lauf: 1537 verfolgt, 419 offen, 1111 bestätigt · needs_en=405 parity=5 review=9
- 2026-11-05 17:20 · Lauf: 1537 verfolgt, 414 offen, 1116 bestätigt · needs_en=405 parity=1 review=8
- 2026-11-05 17:28 · Lauf: 1537 verfolgt, 414 offen, 1116 bestätigt · needs_en=405 review=9
- 2026-11-05 17:28 · Lauf: 1537 verfolgt, 405 offen, 1125 bestätigt · needs_en=405
- 2026-11-05 17:34 · Lauf: 1537 verfolgt, 405 offen, 1125 bestätigt · needs_en=399 review=6
- 2026-11-05 17:34 · Lauf: 1537 verfolgt, 399 offen, 1131 bestätigt · needs_en=399
- 2026-11-05 17:40 · Lauf: 1537 verfolgt, 399 offen, 1131 bestätigt · needs_en=393 review=6
- 2026-11-05 17:40 · Lauf: 1537 verfolgt, 393 offen, 1137 bestätigt · needs_en=393
- 2026-11-05 17:49 · Lauf: 1537 verfolgt, 393 offen, 1137 bestätigt · needs_en=387 review=6
- 2026-11-05 17:49 · Lauf: 1537 verfolgt, 387 offen, 1143 bestätigt · needs_en=387
- 2026-11-05 17:56 · Lauf: 1537 verfolgt, 387 offen, 1143 bestätigt · needs_en=381 review=6
- 2026-11-05 17:56 · Lauf: 1537 verfolgt, 381 offen, 1149 bestätigt · needs_en=381
- 2026-11-05 18:53 · Lauf: 1537 verfolgt, 396 offen, 1134 bestätigt · needs_en=344 parity=15 review=37
- 2026-11-05 19:01 · Lauf: 1537 verfolgt, 360 offen, 1170 bestätigt · needs_en=344 parity=13 review=3
- 2026-11-05 19:14 · Lauf: 1537 verfolgt, 360 offen, 1170 bestätigt · needs_en=339 review=21
- 2026-11-05 19:15 · Lauf: 1537 verfolgt, 339 offen, 1191 bestätigt · needs_en=339
- 2026-11-05 19:28 · Lauf: 1537 verfolgt, 339 offen, 1191 bestätigt · needs_en=327 review=12
- 2026-11-05 19:36 · Lauf: 1537 verfolgt, 327 offen, 1203 bestätigt · needs_en=321 review=6
- 2026-11-05 19:44 · Lauf: 1547 verfolgt, 331 offen, 1209 bestätigt · needs_en=315 needs_de=10 review=6
- 2026-11-05 19:58 · Lauf: 1572 verfolgt, 366 offen, 1199 bestätigt · needs_en=303 needs_de=35 parity=15 review=13
- 2026-11-05 20:10 · Lauf: 1573 verfolgt, 356 offen, 1210 bestätigt · needs_en=297 needs_de=36 parity=16 review=7
- 2026-11-05 20:11 · Lauf: 1573 verfolgt, 349 offen, 1217 bestätigt · needs_en=297 needs_de=36 parity=16
- 2026-11-05 20:15 · Lauf: 1573 verfolgt, 349 offen, 1217 bestätigt · needs_en=297 needs_de=36 parity=4 review=12
- 2026-11-16 04:33 · Lauf: 2609 verfolgt, 1970 offen, 483 bestätigt · needs_en=6 needs_de=341 copy=87 en_german=117 code_german=8 de_english=187 parity=219 rename=31 review=1207
- 2026-11-16 04:38 · Lauf: 2609 verfolgt, 1882 offen, 483 bestätigt · needs_en=6 needs_de=341 en_german=29 code_german=4 de_english=182 parity=219 review=1207
- 2026-11-16 04:38 · Lauf: 2521 verfolgt, 1882 offen, 483 bestätigt · needs_en=6 needs_de=341 en_german=29 code_german=4 de_english=182 parity=219 review=1207
- 2026-11-16 04:41 · Lauf: 2521 verfolgt, 1882 offen, 483 bestätigt · needs_en=6 needs_de=340 en_german=29 code_german=4 de_english=183 parity=219 review=1207
