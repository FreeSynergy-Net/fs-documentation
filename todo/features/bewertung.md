# Bewertung Feature-Abgleich (Auftrag 27), Opus, 2026-11-16

Stand 2026-11-16, Auftrag 27, Feature-Abgleich vor dem Feature-Freeze. Nur Deutsch: todo/ wird nicht übersetzt (ADR 0011).

**Feature-Freeze: offen (Nutzer).** Nur der Nutzer setzt ihn. Diese Bewertung ist Eingabe für seine Ideensammlung, kein Beschluss.
Grundlage: die fünf Listen in diesem Ordner, Pläne (pilot-calendar, -tasks, -people, -groups, -selbstverwaltung, -access, -software), Trait-Ordner der Fixpunkte, Repos auf `main`: fs-calendars f2b67aa, fs-tasks 9a2767f, fs-people a4443d5, fs-groups b5b6674, fs-packages e4448a8. Die 14 Fehlzuordnungen aus §1 sind danach in den fünf Listen korrigiert (Vermerk „korrigiert 16.11. nach Opus-Bewertung“); der Text dieses Abschnitts bleibt als Beleg stehen.

## 1. Stichprobe (je Liste 8 bis 10 Zeilen gegen Code und Plan geprüft)
Bestätigt (Auswahl): calendars 12, 18, 23, 28, 63, 72 · tasks 41, 43, 76, 94 · people 11, 37, 38, 85 (Merged steht im Trait) · groups 19, 46, 58, 109 · packages 38, 40, 53, 86 (`min-store`), 113 (nur Katalog und git laden; kein Sende-Code gefunden).
**Fehlzuordnungen (14), nur gemeldet:**
- calendars.md:43 Gast schlägt neue Zeit vor: `[ ]`, laut eigener Legende `[x]` (Plan A11, Trait `respond(.., proposal)` appointments_v1/api.rs:79).
- calendars.md:44 Frei/Belegt: „fehlt“ stimmt für den Kern, aber `free_busy` steht im Fixpunkt (api.rs:84). Richtig wäre „geplant (Trait)“.
- calendars.md:50 Mehrere Kalender: `calendars` und `create_calendar` stehen im Trait, also „geplant“. Ändern, löschen und wiederherstellen fehlen im Trait (siehe §4).
- tasks.md:117 claim/release/next als „gebaut“: Auf `main` gibt es kein `claim`. Das steht nur auf `unreviewed/lift-tasks` und `unreviewed/release-profile`. Richtig: `[ ]`, Trait ja.
- tasks.md:110 Erinnerung als Benachrichtigung `[x]`: T17 speichert nur `alerts`, nichts löst aus (calendars.md:29 sagt es richtig mit `[ ]`).
- tasks.md:52 Kalenderansicht „fehlt“: fs-calendars zeigt fällige Aufgaben schon (`TasksInWindow`, repo/agenda.rs). Richtig: teilweise gebaut.
- people.md:12 Phonetik „fehlt“: gebaut (`phonetic`, `phoneticScript`, fs-people-core card/parts.rs:34,51).
- people.md:41 Abgelehnte Vorschläge merken: gebaut (matching/state.rs:6, DESIGN.md:27, AS2 `Reject`). Veraltet ist README.md:33 („sieht es wieder“).
- people.md:54 Ich-Karte „fehlt“: entschieden O11(a) und im Trait `asker()` (api.rs:50), also „geplant“.
- groups.md:41 „letzter Verwalter geschützt, Kern gebaut“: `LastManager` gibt es nur in groups_v1 und im Fake (fs-groups-testdata), nicht in fs-groups-core.
- groups.md:63 KI nie Admin, „geplant“: Der Kern hat es schon teilweise (`AgentNotAdmin`, fs-groups-core repo/admins.rs:35).
- packages.md:32 Abzeichen `[x]`: Gebaut ist nur die Signaturprüfung (Zeile 55); das sichtbare Abzeichen mit Stufen ist geplant.
- packages.md:80 Download-Größe `[ ]`, der Text sagt aber „gebaut“: einer von beiden ist falsch.
- packages.md:89 je Nutzer/für alle: Der Text sagt „gebaut (scope user/system)“, auf `main` gibt es dazu nichts (nur `pkexec`-Systemweg). Das `[ ]` stimmt, der Text nicht.
Hinweise: calendars.md:105 `is_encrypted` verschlüsselt den Speicher, ist aber kein Ende-zu-Ende wie bei Proton. Der Nutzen-Satz verspricht zu viel. calendars.md:42 Blocker R5 ist wohl überholt (person_directory_v1 ist fixiert, Crate fs-people-directory existiert). people.md:29 Verteiler mit Mitgliedern in fs-people widerspricht PLAN L6 und dem Trait (Mitglieder nur in fs-groups): doppelter Eigentümer, klären. packages.md:76 `RightsRefused` gibt es auf `main` nicht; die Rechtefrage über `pkexec` ist gebaut.
**Zeilen „nicht belegt/unsicher/[offen]“:** calendars 56, 75, 79, 102 (dazu alle EV/KO-Angaben) · tasks 88 (Planka nur Startseite, Zeile 71) · people 12, 41, 98, 119, 127 · groups 29, 32, 64, 76, 83, 87, 117 · packages 24, 40–43, 45, 49, 53, 56, 64, 68, 73, 80–82, 87, 88, 105, 113 (GNOME durchgehend ohne Beleg).
**Nebenbefunde:** (a) Der Fixpunkt groups_v1 liegt unter `sperren/alt/`, ist also für das Rollen-Delta (Entscheidung 21) gelöst. Der Auftrag nennt ihn „gesperrt“. (b) `admission_v1` widerspricht sich: pilot-selbstverwaltung/PLAN.md:193 streicht es, aber §11 und S5 (Z. 118, 140) bauen es. (c) pilot-groups hat je 7 `.vor-*`-Kopien von PLAN.md und groups_v1. Regel PLATTE (1) erlaubt eine. Das Aufräumen macht der Nutzer bzw. der Koordinator.

## 2. Priorisierung je Programm: die 10 wichtigsten FEHLENDEN Features
Aufwand S/M/L (bis 1 / 1–3 / über 3 Agenten-Tage); „→“ = hängt an.
**calendars:** 1 Erinnerung auslösen (Systemmeldung; Mail später) M → Meldedienst §3 · 2 mehrere Kalender im Fenster ein/aus mit Farbe S · 3 Gäste aus people wählen M → person_directory_v1 `suggest` · 4 Gast schlägt Zeit vor S (Trait da) · 5 Frei/Belegt + Terminfindung M → groups (Mitglieder) · 6 Kalender teilen mit Stufen (nur frei/belegt, lesen, schreiben) L → fs-access, groups · 7 ICS-Abo (webcal, nur lesen; deckt Feiertage ab) M · 8 CalDAV-Client + Sync-Token L → Wrapper eines vorhandenen DAV-Crates, RFC 4791/6578 · 9 iTIP/iMIP Einladung per Mail L → fs-messages · 10 Geburtstage aus people als Facette S → Auszugsfeld (§4).
NICHT bauen: KI-Umplanung wie Reclaim/Motion (Cloud-KI, KI-Regel; höchstens lokal, ausdrücklich, später) · Wetter (Abfrage nach außen, Datenabfluss; als Abo-Kalender möglich) · Google/Outlook-Konten per API (geschlossen: nur Import; CalDAV reicht) · Meet/Teams-Link erzeugen (Cloud-Bindung; Link-Feld bleibt, eigener Raum über fs-messages/broadcast) · eigene Feiertagslogik (Abo genügt). Später statt nie: Buchungsseite (braucht Website/Server), Jahresansicht, Mobil-App.
**tasks:** 1 Liste teilen + Rechte, Gruppe als Eigentümer L → fs-access, groups_v1 · 2 Erinnerung auslösen M → Meldedienst · 3 Benachrichtigung bei Zuweisung M → Meldedienst · 4 claim/next auf `main` nachziehen S (Branch lift-tasks) · 5 Tastatur in allen Ansichten + Bildschirmleser M (Pflicht) · 6 Kommentare M → eigener Trait `comments`, Eigentümer fs-messages (O7) · 7 CalDAV VTODO L → gemeinsamer DAV-Wrapper mit calendars · 8 Datei-Anhänge M → fs-files (`FileRef` steht schon im Trait) · 9 Wiederholung ab Erledigung S (Trait, §4) · 10 CSV ein/aus S (RFC 4180, offen) und gespeicherte Filter S (Einstellung, nicht Trait).
NICHT bauen: Cloud-KI-Zerlegung wie Atlassian Intelligence (Cloud, KI-Regel; höchstens lokaler Vorschlag in der KI-Gruppe, Mensch bestätigt) · Webhooks nach außen jetzt (Datenabfluss; erst nach Rechte-Modell) · Todoist/Trello-Export schreiben (geschlossen: nur Import) · Gantt (ADR 0073: später).
**people:** 1 Papierkorb + Rückgängig (L5; Frist aus Settings) M · 2 Ich-Karte (O11) S · 3 Zusammenführen mit Rückgängig M (`Merged` im Trait da) · 4 DSGVO-Auskunft je Person (Art. 15) L → alle Programme §3 · 5 Einwilligungen festhalten (Art. 7; W3C DPV) M → Frage 37 · 6 Tastatur + Bildschirmleser M (Pflicht) · 7 Export einer Auswahl, Feldwahl S (`excerpt` vorhanden) · 8 Import mit Dublettenwahl M · 9 CardDAV L → DAV-Wrapper · 10 freie Labels S (JSContact `keywords`, vCard CATEGORIES) und mehrere Adressbücher M.
NICHT bauen: „zuletzt in Kontakt“ automatisch aus Nachrichten (Profilbildung; höchstens Opt-in, später) · Geschenke/Schulden (Nische; Geld gehört nach fs-resources/ValueFlows) · Google-Konto-API (nur Import) · öffentliche Kartenseite (Datenschutz; nur Opt-in, später) · Gruppenmitglieder in people (Eigentümer ist fs-groups).
**groups:** 1 Fenster G1–G16 (Liste, Anlegen, Mitglieder, Einladen) M · 2 Rollen-Delta groups_v1 (läuft, R1/R2) L · 3 Papierkorb G5 S · 4 Aufnahmeregel offen/bestätigt/Abstimmung (geheim) + Türsteher L → fs-admission · 5 Links/QR mit Ablauf und Nutzungsgrenze M → fs-admission · 6 min/max-Größe M · 7 Protokoll + Einsicht der Betroffenen M → fs-activity · 8 Gruppe als Teilnehmer/Zuständige S → calendars/tasks (`PersonArt::Group` vorhanden) · 9 SCIM lesen + OAuth-Claims `groups`/`roles` L → pilot-access · 10 Objekt-Rechte erlauben/sperren L → fs-access; dazu vCard KIND:group/LDIF S.
NICHT bauen (in fs-groups): Moderation von Beiträgen, Forum, Mailingliste (Eigentümer fs-messages; groups liefert nur Mitglieder) · Umfrage (Suite fs-forms) · Google-Groups-API (nur Import) · eigener LDAP-Abgleich (Kanidm liefert LDAP lesend) · Mehrmandant jetzt (Datenmodell vorbereitet, Entscheidung 14).
**packages:** 1 Rechte-Anzeige + Warnung bei neuen Rechten M (Manifestfeld) · 2 Schlüssel-Ablauf/Widerruf M (Sicherheit) · 3 Vertrauensstufen je Quelle/Namensraum M · 4 Neustart-Hinweis S · 5 Wiederholen nach Fehler S · 6 Changelog je Version S (AppStream `releases`) · 7 Schriften als Art (S21–S24) M · 8 MF2-Texte de/en M (ADR 0057) · 9 Tastatur + Bildschirmleser M (Pflicht) · 10 Datenschutz-/Anti-Feature-Etikett M und Admin-Richtlinien je Gruppe L → groups.
NICHT bauen: Sterne/Bewertungen (beschlossen) · Download-Zähler/Telemetrie · KI-Empfehlungen · eigene Sandbox (Flatpak per Wrapper statt Neubau) · macOS jetzt.

## 3. Programmübergreifend: Eigentümer nach dem „wessen Daten?“-Test, Reihenfolge
| # | Feature | Eigentümer (Daten) | beteiligt | Reihe |
|---|---|---|---|---|
| a | Personenwahl, Namens-Verweis, Abzug | people (`person_directory_v1`) | alle | 1 |
| b | Papierkorb-Frist | jedes Programm (Wert in Settings, `restorable_until` im Trait) | Settings | 1 |
| c | Gruppe als Teilnehmer/Zuständige | Termin → calendars, Aufgabe → tasks; Mitglieder → groups | people | 2 |
| d | Erinnerung/Benachrichtigung | Alarm gehört dem Termin/der Aufgabe; Zustellung ist ein Dienst (freedesktop Notifications; Mail über fs-messages) | Shell | 2 |
| e | Import/Export | jedes Programm sein offenes Format; Gesamt-Export (Art. 20) = Suite | alle | 2 |
| f | Verlauf/Protokoll | jedes Programm `history`; fs-activity sammelt AS2 | activity | 2 |
| g | Teilen/Rechte an Objekten | Eigentümer-Programm speichert erlauben/sperren; Regel fs-access; Mitgliedschaft groups | access, groups | 3 |
| h | Einladungen, Links, QR | Daten bei groups (`groups_admission_*`), Logik fs-admission, Zustellung fs-messages | messages | 3 |
| i | DSGVO-Auskunft/Löschung je Person | jedes Programm für seine Daten; Sammelauskunft = Suite | people (Verweis) | 3 |
| j | Aufgaben aus Terminen | tasks (Verweis `related` RFC 9253 auf den Termin) | calendars | 3 |
| k | Terminfindung/Abstimmung | calendars (`free_busy`, Vorschläge); Mitgliederliste groups; keine groups-Abstimmung | groups, people | 4 |
| l | Geburtstage im Kalender | people (Daten), calendars (Facette, nur Ansicht) | – | 4 |
| m | Suche über Programme | jedes Programm durchsucht seine Daten; Sammelsuche = Shell/Suite | alle | 5 |
| n | CalDAV/CardDAV | Client: calendars/tasks/people je als Anbieter, ein gemeinsamer DAV-Wrapper-Crate; Server später eigenes Programm | Server | 5 |
| o | Offline-Abgleich | lokal gebaut (fs-objects); Abgleich über n | objects | 6 |
| p | Mobil | Frontends (ADR 0066), kein Programm | components | 7 |

## 4. Trait-relevant VOR dem ersten Release (ändert die Schnittstelle, nicht die Oberfläche)
Regel „Änderung vor dem ersten Release“ (pilot-selbstverwaltung §3): Die Version bleibt v1, der Fixpunkt wandert, danach Neu-Fixpunkt mit Vorgänger-Hash.
**Querschnitt (Empfehlung):** Objekt-Rechte und DSGVO-Auskunft als je EIN gemeinsamer Teil-Trait, den jeder Eigentümer umsetzt (z. B. in fs-access: `allow/deny/rights(object)` und `about_person(PersonRef)`, `erase_person`). Dann brauchen appointments_v1 und tasks_v1 nur ein Eigentümerfeld und keine vier Einzelumbauten.
**appointments_v1:** `CalendarInfo.owner` (Person ODER Gruppe) · `update_calendar`/`delete_calendar`/`restore_calendar` (fehlen, nur `create_calendar` da) · Abo-Kalender: Quelle (URL, nur lesen, Abrufintervall) + `subscribe_calendar` · Teilen über den Querschnitts-Trait. Nicht nötig: Terminfindung (`free_busy` reicht), Alarme bestätigen (`alerts.acknowledged` + `update` reicht).
**tasks_v1:** Eigentümer der Liste darf Gruppe sein (`PersonRef` mit `PersonArt::Group` ausdrücklich zulassen, ebenso `assign` an eine Gruppe; Regel: wer aus der Gruppe `claim`t) · Wiederholung ab Erledigung (Erweiterungsfeld neben RFC 8984 `RecurrenceRule`, z. B. `freesynergy.net:repeatFrom`) · Checklisten nur, wenn Teilaufgaben nicht reichen (Frage 38). Kommentare bleiben eigener Trait.
**person_directory_v1:** `ExcerptField::Birthday`/`Anniversary` (Geburtstags-Facette) · Zweck beim Auszug (`excerpt(.., purpose)`, Zweckbindung Art. 5 Abs. 1 b) · Einwilligungsstand nur, wenn Frage 37 „in people“ ergibt.
**groups_v1 (Delta läuft):** Rollen (R1) · Grant mit Wirkung Erlauben/Sperren (Sperre schlägt Erlaubnis, Frage 15) · befristete Mitgliedschaft `Membership.until` (Frage 35) · Selbstverwaltungs-Einstellungen (min/max, Links erlaubt, Abstimmung geheim/offen, Dauer, `on_expiry`, Anfrage ohne Einladung): klären, ob in `GroupPatch` oder `admission_v1` (Widerspruch §1 b), JETZT entscheiden · `non_exhaustive` (Entscheidung 6). Mandant: implizit beim Anbieter, kein Feld.
**Top 5 Trait-relevant:** (1) Objekt-Rechte/Teilen mit Gruppe als Eigentümer (Querschnitt) · (2) groups_v1 Grant mit Sperre + Klärung `admission_v1` · (3) appointments_v1 Kalender verwalten + Abo-Quelle · (4) person_directory_v1 Geburtstag + Zweck im Auszug · (5) tasks_v1 Gruppe als Zuständige + Wiederholung ab Erledigung.

## 5. Fragen an den Nutzer (Nummern ab 30, stabil)
30. Sollen Kalender, Aufgabenlisten und Termine einer **Gruppe gehören** können (der Verein besitzt den Kalender), oder gehört alles einer Person, die es teilt?
31. Muss der **Abgleich mit dem Handy** (CalDAV/CardDAV, z. B. über DAVx5) vor dem ersten Release gehen, oder reicht zuerst Datei-Import und -Export?
32. Reicht eine **Erinnerung als Meldung am Rechner**, oder muss sie auch per Mail oder Nachricht kommen? Das braucht einen Dienst auf dem Server.
33. Wollen wir eine **Terminabstimmung** („Doodle“) für Vereine? Wer darf mitstimmen: nur Mitglieder oder auch Gäste über einen Link?
34. Sollen **fremde Kalender per Link abonniert** werden können (Feiertage, Spielplan)? Dafür holt das Programm Daten aus dem Netz, nur auf Klick.
35. Soll eine **Mitgliedschaft ablaufen** können (Projektteam, Beitragsjahr)?
36. Soll man **eine einzelne Person in einer Gruppe sperren** können, sodass die Sperre jede Erlaubnis schlägt, auch die aus der Gruppe?
37. Sollen wir **Einwilligungen** festhalten (wer hat wann zugestimmt, dass seine Daten gespeichert oder weitergegeben werden)? Wenn ja: in people oder in einem eigenen Programm?
38. Aufgaben: Brauchen wir **Wiederholung ab dem Erledigen** („3 Tage nach dem letzten Gießen“)? Und **Checklisten** in einer Aufgabe, oder reichen Teilaufgaben?
39. **KI-Helfer** (Termin aus einem Satz, Aufgabe zerlegen): gar nicht, oder nur mit lokaler KI, nur auf Wunsch, standardmäßig aus?

## 6. Empfehlung zur Reihenfolge
1. Die Fragen 30, 35 und 36 und den Widerspruch `admission_v1` klären, solange groups_v1 ohnehin offen ist, dann im selben Zug neu fixieren.
2. Den Querschnitts-Trait für Objekt-Rechte/Auskunft entwerfen (fs-access), dann appointments_v1 und tasks_v1 nur um Eigentümer, Kalender-Verwaltung und Abo erweitern (ein Delta je Trait, Opus-Delta-Review).
3. Danach bauen, wie vereinbart (Kalender → tasks nutzbar → people → groups): Erinnerung auslösen (Meldedienst), Personenwahl, Papierkorb, Ich-Karte, claim auf `main`.
4. DAV-Wrapper (CalDAV/CardDAV) als gemeinsamer Baustein nach Frage 31; Barrierefreiheit in jeder Runde als Abnahme-Pflicht, nicht als eigenes Feature.

Feature-Freeze: offen (Nutzer).
