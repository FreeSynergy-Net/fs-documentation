# Import/Export-Checkliste (FreeSynergy-Programme)

Stand: 2026-11-16. Quelle: origin/main der Repos. Nichts davon wird jetzt gebaut, die Liste dient der Übersicht.

Zeilen je Programm. Einordnungen nach der Entscheidung der Strategie (siehe Grundsatz und Auffälligkeiten). Nur Deutsch: todo/ wird nach ADR 0011 nicht übersetzt.

## Grundsatz (Nutzerregel, Einordnung der Strategie, verbindlich)

- Import/Export sind Grenz-Adapter nach ADR 0085. Innen gelten nur Standards.
- Geschlossene Formate: NUR IMPORT (lesen), kein Export. In der Export-Spalte steht dann „— (geschlossen, nur Import)“. `- [x]` gilt, sobald der Import gebaut und getestet ist.
- Offene Formate: Import UND Export. In der Export-Spalte steht ✓ oder ✗. `- [x]` gilt nur, wenn Import UND Export gebaut UND getestet sind.
- „Offen“ gilt nach (a) oder (b): (a) freie, vollständige, praktisch umgesetzte Spezifikation; (b) Format einer Open-Source-Referenzumsetzung, deren Code die Spezifikation ist („Open Source wird auch geschrieben“).
- Scheinoffen bleibt geschlossen: OOXML (DOCX, XLSX, PPTX) hat eine Spezifikation, Microsoft Office schreibt aber „Transitional“, nicht „Strict“. Outlook-CSV ist geschlossen, weil kein Kriterium belegt ist.
- „Nicht belegt“ heißt nicht automatisch geschlossen, wenn die Fakten bekannt sind. Die Einordnung folgt dann (a) oder (b) und wird in der Zeile begründet. „Einordnung: unklar → geschlossen (Kriterium (n) nicht belegt)“ steht nur, wenn die Fakten fehlen.
- Offen (Import und Export): ODF (ISO/IEC 26300, OASIS, LibreOffice); GPX (Topografix-Schema, GDAL, viele freie Umsetzungen); KML (OGC-Standard, GDAL); MBTiles (offene Spezifikation, freie Umsetzungen); PMTiles; ActivityStreams 2.0 (W3C), auch als JSONL-Hülle (der Export in fs-messenger bleibt); JSON Canvas (offene Spezifikation, MIT); Excalidraw (MIT-Referenzumsetzung, Regel b); Flatpak (Open Source, Regel b); QTI (IMS, öffentliche Spezifikation, TAO); ValueFlows (offenes Vokabular).
- S3: offen „de facto“. Die API stammt vom Anbieter, aber freie Server setzen sie um (Referenz RustFS, Apache-2.0; daneben Garage, MinIO). Gemeinsame S3-Teilmenge; Nur-AWS-Erweiterungen bleiben außen vor. Wir schreiben in eigene Ablagen. Import UND Export, mit Vermerk.
- Geschlossen, nur Import: DOCX, XLSX, PPTX (OOXML). Zu PPTX gibt es noch keine Zeile.
- Stand: aus origin/main per git grep belegt, sonst [nicht belegt].

Legende Priorität: hoch = Pflicht oder Kern des Austauschs; mittel = verbreitet, klarer Nutzen; niedrig = Nischenfall oder nur auf Wunsch.

Legende Stufen: Stufe 1 = Standards (Pflicht); Stufe 2 = verbreitete Formate (sinnvoll); Stufe 3 = weniger bekannte Formate, nur mit Begründung.

# Programmabschnitte

## calendar (fs-calendar)

### Stufe 1 – Standards (Pflicht)
- [x] **iCalendar, RFC 5545** [offen: IETF-Standard RFC 5545] — Import ✓ / Export ✓ — Stand: gebaut + Test: fs-calendar:crates/fs-calendar-core/src/format/ics.rs (Importer/Exporter), Tests fs-calendar:crates/fs-calendar-core/tests/ics.rs und tests/media.rs — hoch — Kalenderdatei-Standard, den alle anderen Programme sprechen; VTODO geht an fs-tasks (fs-calendar:DESIGN.md).
- [x] **JSCalendar (JSON), RFC 8984** [offen: IETF-Standard RFC 8984] — Import ✓ / Export ✓ (Export für mehrere Termine provisorisch, fs-calendar:DESIGN.md:227) — Stand: gebaut + Test: fs-calendar:crates/fs-calendar-core/src/format/jscalendar.rs, Tests tests/media.rs (jscalendar_goes_in_and_out_by_media_type), tests/import.rs (import_rfc8984_data_upgrades) — hoch — Eigentümer-Standard des Termins (ADR 0020).
- [ ] **CalDAV, RFC 4791** [offen: IETF-Standard RFC 4791] — Import ✗ / Export ✗ — Stand: nur erwähnt (fs-calendar:README.md:30 „No CalDAV“) — hoch — Konten-Sync mit Nextcloud, Apple, Thunderbird; ohne ihn kein Abgleich mit Servern.
- [ ] **iTIP RFC 5546 / iMIP RFC 6047** [offen: IETF-Standards RFC 5546, RFC 6047] — Import ✗ / Export ✗ — Stand: nur erwähnt (fs-calendar:README.md:30 „no sending invitations by e-mail (iTIP)“); das interne Einladungsmodul fs-calendar:crates/fs-calendar-core/src/invite/ ist kein iTIP — mittel — Einladungen, die andere Kalender per Mail beantworten können.

### Stufe 2 – Verbreitete Formate
- [ ] **Google Calendar, ICS-Datei** [offen: es ist RFC 5545] — Import ✓ / Export ✓ — Stand: gebaut über die iCalendar-Zeile oben, keine Google-Datei getestet — mittel — Google-Export ist die häufigste Quelle von Terminen.
- [ ] **Google Calendar, Konto-API** [geschlossen: proprietäre Google-API, keine freie Spezifikation] — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — mittel — Direktes Holen von Terminen aus Google-Konten.
- [ ] **Outlook/Exchange, ICS-Datei** [offen: RFC 5545] — Import ✓ / Export ✓ — Stand: gebaut über iCalendar, keine Outlook-Datei getestet — mittel — Outlook-Dateiexport; Zeitzonennamen von Outlook sind nicht geprüft.
- [ ] **Outlook/Exchange, Konto (EWS / Graph)** [geschlossen: Microsoft-Protokolle, Lizenz nicht frei eindeutig, also unklar = geschlossen] — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig — Konto-Anbindung ist Sache eines eigenen Anbieter-Crates; im Repo nicht vorhanden.
- [ ] **Apple Kalender, ICS-Datei** [offen: RFC 5545; X-APPLE-* sind Herstellerzusätze] — Import ✓ / Export ✓ — Stand: gebaut über iCalendar, keine Apple-Datei getestet — mittel — Apple-Nutzer exportieren .ics; Konto über CalDAV (Zeile oben).
- [ ] **Thunderbird, ICS-Datei** [offen: RFC 5545] — Import ✓ / Export ✓ — Stand: gebaut über iCalendar, nicht getestet — niedrig — Thunderbird-Nutzer; Konto über CalDAV (Zeile oben).
- [ ] **Nextcloud** [offen: CalDAV RFC 4791] — Import ✗ / Export ✗ — Stand: nur über die CalDAV-Zeile oben — mittel — Selbstgehosteter Kalender, verbreitet bei Organisationen.

### Stufe 3 – Weniger bekannte Formate (nur mit Begründung)
- [ ] **webcal-Abo (ICS-Feed per URL)** [offen: RFC 5545 über HTTP(S)] — Import ✗ / Export ✗ — Stand: nur im gesperrten Piloten erwähnt (Pilot appointments_v1 (time.rs), nicht main, Origin-Kanal „Abo per URL“) — niedrig — wer braucht das: Feiertags- und Sportplan-Abos, die nur als URL vorliegen.

Exchange-Trait/Muster: Exchange-Trait im gesperrten Piloten Pilot-Trait appointments_v1 (exchange.rs), nicht main (Trait `Exchange` mit `import`/`export`, `ExportTarget`, `ImportContext`) und als Entwurf im Repo fs-calendar:crates/fs-calendar-testdata/src/draft/appointments_v1/exchange.rs (nicht produktiv). Gebaut ist nur das Importer/Exporter-Muster: fs-calendar:crates/fs-calendar-core/src/format/traits.rs (kein Exchange-Trait im Produktionscode).

## software (fs-store, künftig fs-software)

Stand: fs-store origin/main (Programm fs-store, künftig fs-software) und fs-catalog origin/main (Katalog, Schriften-Art `font` nur in ADR 0077/0089, nicht im Code: kein Treffer auf `font` in `fs-store-catalog/src`, `fs-store-core/src`).

### Stufe 1 – Standards (Pflicht)

- [ ] **AppStream** (offen: freedesktop-Spezifikation "Collection metadata", frei) — Import ✓ / Export — (teilweise: nur Import) — Stand: Import gebaut + Test (`fs-store:crates/fs-store-catalog/src/catalog.rs`, `details.rs`, `entry.rs`; Tests `fs-store:crates/fs-store-catalog/tests/catalog.rs`, `tests/details.rs`, `tests/format2.rs`). Export nur im Katalog-Generator von fs-catalog (`fs-catalog:scripts/gen_catalog.py`, `fs-catalog:scripts/schema_xml.py`; Test `fs-catalog:tests/test_generator.py`), nicht im Programm fs-store — Priorität hoch — Grund: Katalogformat, das der Store liest und dessen Erzeugung bei fs-catalog liegt. Hinweis zur Einordnung: teilweise, also `[ ]`.
- [ ] **OCI-Image / OCI-Metadaten** (offen: OCI Image Specification, Linux-Foundation-Projekt, frei) — Import ✗ / Export ✗ — Stand: [nicht belegt] (kein Treffer auf `oci` in fs-store und fs-catalog; ADR 0078 nennt das OCI-Archiv nur als Vorgabe für Release-Dateien) — Priorität mittel — Grund: Server-Pakete als Container, ADR 0077 verlangt rpm/deb/OCI.
- [ ] **Flatpak-Metadaten** (offen, Regel b: Flatpak ist Open Source) — Import ✗ / Export ✗ — Stand: "nur erwähnt" (`fs-store:crates/fs-store-core/src/package.rs` Variante `Flatpak`; `fs-store:DESIGN.md` Zeile 234: flatpak "stays Unsupported") — Priorität niedrig — Grund: Verbreiteter Desktop-Weg; der Store installiert Flatpak nicht.
- [ ] **apt-Repo-Metadaten** (offen: Debian-Repository-Format, Dokumentation frei; Einordnung: offen) — Import ✗ / Export ✗ — Stand: nicht gebaut; ADR 0078 plant ein Repo `fs-packages` mit `apt-ftparchive` (`fs-documentation` origin/main, `conventions/decisions/0078-paketquellen-apt-dnf.md`); im Store wird nur die einzelne `.deb` über `apt-get install` installiert (`fs-store:crates/fs-store-engine/src/deb.rs`; Test `fs-store:crates/fs-store-engine/tests/deb.rs`) — Priorität hoch — Grund: Der Store soll apt-Quellen direkt nutzen können; heute fehlt der Repo-Export.
- [ ] **rpm-Repo-Metadaten** (offen: repodata, createrepo_c, frei) — Import ✗ / Export ✗ — Stand: nicht gebaut; ADR 0078 plant `createrepo_c` (s. o.); im Store nur einzelne `.rpm` über `dnf` (`fs-store:crates/fs-store-engine/src/rpm.rs`; Test `fs-store:crates/fs-store-engine/tests/rpm.rs`) — Priorität hoch — Grund wie apt.
- [x] **TUF** (offen: TUF-Spezifikation, frei nutzbar; Bibliothek `tough` MIT/Apache-2.0) — Import ✓ / Export ✓ — Stand: Import gebaut + Test (`fs-store:crates/fs-store-tuf/src/lib.rs`; Test `fs-store:crates/fs-store-tuf/tests/reference.rs`); Export gebaut + Test (`fs-store:crates/fs-store-tuf-publish/src/publish.rs`; Test `fs-store:crates/fs-store-tuf-publish/tests/publish.rs`). Hinweis: Im Store-Update-Pfad nur verdrahtet, wenn `FS_STORE_TUF_ROOT` gesetzt ist (`fs-store:crates/fs-store-cli/src/tuf.rs`, `fs-store:DESIGN.md` Zeilen 276–335). Priorität hoch — Grund: Schutz gegen Rollback und eingefrorene Kataloge; Standard für signierte Metadaten.
  (Hinweis: [x] gilt, weil Import und Export gebaut und getestet sind; die Verdrahtung im Update-Pfad ist optional.)

### Stufe 2 – Verbreitete Formate (sinnvoll)

- [ ] **Flathub-Katalog (AppStream + Flatpak-Repo)** (offen: AppStream und OSTree-Repo, frei) — Import ✗ / Export ✗ — Stand: [nicht belegt] — Priorität niedrig — Grund: größter Katalog auf dem Linux-Desktop; Nutzer finden dort bekannte Programme. Vorbild für den Store (GNOME Software, KDE Discover nutzen AppStream).
- [ ] **Debian-Paket-Index `Packages`** (offen: Debian-Dokumentation, frei) — Import ✗ / Export ✗ — Stand: [nicht belegt] — Priorität niedrig — Grund: Vorbild für die apt-Quelle; nur nötig, wenn apt-Metadaten direkt gelesen werden.

### Stufe 3 – Weniger bekannte, aber sinnvolle Formate

- [ ] **SPDX-SBOM** (offen: ISO/IEC 5962, frei) — Import ✗ / Export ✗ — Stand: [nicht belegt] — Priorität niedrig — Grund "wer braucht das": Lieferketten-Nachweis je Paket; sinnvoll bei Nachfrage von Behörden oder Unternehmen.
- [ ] **Winget-Manifeste** (offen: Microsoft-Repository winget-pkgs, MIT-Lizenz; Format per Dokumentation frei) — Import ✗ / Export ✗ — Stand: [nicht belegt] — Priorität niedrig — Grund "wer braucht das": Windows-Store-Pendant; nur mit Windows-Paketen (`exe`) relevant, die der Store laut `fs-store:DESIGN.md` Zeile 240 nicht baut.
- [ ] **Schrift-Art `kind = font`** (offen: AppStream-Typ `font`, Spezifikation frei; Einordnung laut ADR 0077 Nachtrag: offen) — Import ✗ / Export ✗ — Stand: "nur erwähnt" (fs-documentation:`conventions/decisions/0077-katalog-arten-kind.md`, `0089-schriften-freie-lizenzen.md`; kein Code, kein Treffer `font` in fs-store-catalog und fs-store-core) — Priorität mittel — Grund: Schriften über fs-software installieren (ADR 0089); gehört zum AppStream-Import oben.

Exchange-Trait/Muster: keiner nach ADR 0085 im Repo. Muster: Adapter für AppStream (`fs-store:crates/fs-store-catalog/src/lib.rs`, "Pattern: Adapter") und Strategy je Installationsweg (`fs-store:crates/fs-store-core/src/strategy.rs`, `fs-store:crates/fs-store-engine/src/deb.rs`, `rpm.rs`). Gesperrter Software-Trait nur als Pilot: Pilot packages_v1, nicht main (`api.rs`, Trait `Packages`; nicht in origin/main).

## people (fs-people)

### Stufe 1 – Standards (Pflicht)
- [x] **vCard 4.0, RFC 6350 (liest auch 2.1/3.0, RFC 2426)** [offen: IETF-Standard RFC 6350] — Import ✓ / Export ✓ — Stand: gebaut + Test: fs-people:crates/fs-people-core/src/format/vcard.rs, Tests fs-people:crates/fs-people-core/tests/vcard.rs (vcard_import_keeps_original_and_exports), tests/vcard_rfc9554.rs; das Lesen von 2.1/3.0 steht in fs-people:DESIGN.md:24, ist aber nicht eigens getestet — hoch — Adressbuch-Standard für Kontakte.
- [x] **JSContact, RFC 9553** [offen: IETF-Standard RFC 9553] — Import ✓ / Export ✓ — Stand: gebaut + Test: fs-people:crates/fs-people-core/src/format/jscontact.rs, Test fs-people:crates/fs-people-core/tests/lossless.rs (import_jscontact, Export mit JsContactFormat) — hoch — Eigentümer-Standard der Person (ADR 0020).
- [ ] **CardDAV, RFC 6352** [offen: IETF-Standard RFC 6352] — Import ✗ / Export ✗ — Stand: nur erwähnt (fs-people:README.md:31 „No CardDAV“; fs-people:DESIGN.md:257) — hoch — Adressbuch-Sync mit Nextcloud, Apple, Thunderbird.
- [ ] **LDIF, RFC 2849** [offen: IETF-Standard RFC 2849] — Import ✗ / Export ✗ — Stand: [nicht belegt] — niedrig — Verzeichnisexporte aus LDAP-Systemen.

### Stufe 2 – Verbreitete Formate
- [ ] **Google Contacts, CSV oder Konto-API** [geschlossen: CSV-Layout ohne Spezifikation, API proprietär, also unklar = geschlossen] — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — hoch — größte Quelle für Kontakte, ein Import reicht.
- [ ] **Outlook-Kontakte, CSV** [geschlossen: Microsoft-Layout ohne freie Spezifikation] — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — mittel — Umzug aus Outlook.
- [ ] **Apple Kontakte, vCard-Datei** [offen: vCard RFC 6350] — Import ✓ / Export ✓ — Stand: gebaut über vCard, keine Apple-Datei getestet — mittel — Apple exportiert Kontakte als vCard.
- [ ] **Thunderbird, vCard-Datei** [offen: vCard RFC 6350] — Import ✓ / Export ✓ — Stand: gebaut über vCard, nicht getestet — niedrig — Thunderbird-Adressbuch; Konto über CardDAV (Zeile oben).
- [ ] **Nextcloud Kontakte** [offen: CardDAV RFC 6352] — Import ✗ / Export ✗ — Stand: nur über die CardDAV-Zeile oben — mittel — Selbstgehosteter Adressbuch-Server.

### Stufe 3 – Weniger bekannte Formate (nur mit Begründung)
- [ ] **Outlook-Datenbank (PST)** [geschlossen: proprietäres Microsoft-Binärformat] — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig — wer braucht das: Nutzer mit alten Outlook-Archiven.

Exchange-Trait/Muster: Importer/Exporter-Muster in fs-people:crates/fs-people-core/src/format/traits.rs (Implementierungen vcard.rs und jscontact.rs), Übergabe über fs-people:crates/fs-people-app/src/transfer.rs. Kein Exchange-Trait im Repo (grep ohne Treffer); der gesperrte Pilot-Exchange-Trait (Pilot-Trait appointments_v1, nicht main) enthält einen `PersonDirectory`-Trait für die Personenzuordnung, den dieses Repo nicht übernommen hat.

## tasks (fs-tasks)

### Stufe 1 – Standards (Pflicht)
- [x] **VTODO, RFC 5545** [offen: IETF-Standard RFC 5545] — Import ✓ / Export ✓ — Stand: gebaut + Test: fs-tasks:crates/fs-tasks-core/src/ical/mod.rs, Tests fs-tasks:crates/fs-tasks-core/tests/ics.rs, fs-tasks:crates/fs-tasks-app/tests/transfer.rs (iCalendar hinein und hinaus) — hoch — Aufgabenstandard in iCalendar, Gegenstück zum VEVENT.
- [ ] **JSCalendar-Tasks, RFC 8984 (Task-Objekt)** [offen: IETF-Standard RFC 8984] — Import ✗ / Export ✗ — Stand: nur erwähnt: JSON ist die Wire-Form, kein Datei-Import oder -Export (fs-tasks:DESIGN.md:189) — hoch — Eigentümer-Standard des Task-Objekts (ADR 0050); für Datei-Austausch fehlt er.

### Stufe 2 – Verbreitete Formate
- [ ] **Google Tasks, Konto-API** [geschlossen: proprietäre API] — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — mittel — verbreitet auf Android und in Gmail.
- [ ] **Microsoft To Do (Konto)** [geschlossen: proprietär, Graph-API] — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig — Umzug aus Microsoft-Konten.
- [ ] **Apple Erinnerungen, .ics mit VTODO** [offen: RFC 5545] — Import ✓ / Export ✓ — Stand: gebaut über VTODO-Zeile oben, keine Apple-Datei getestet — mittel — Apple speichert Erinnerungen als VTODO.
- [ ] **Thunderbird Aufgaben (Lightning, ICS)** [offen: RFC 5545] — Import ✓ / Export ✓ — Stand: gebaut über VTODO, nicht getestet — niedrig — Thunderbird-Nutzer.
- [ ] **Nextcloud Aufgaben (CalDAV, VTODO)** [offen: CalDAV RFC 4791] — Import ✗ / Export ✗ — Stand: nur über die CalDAV-Zeile des Kalenders — mittel — Selbstgehosteter Aufgabenserver.

### Stufe 3 – Weniger bekannte Formate (nur mit Begründung)
- [ ] **Todoist-Export (CSV)** [geschlossen: proprietäres Layout ohne Spezifikation] — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig — wer braucht das: Umsteiger von Todoist.
- [ ] **Trello-Export (JSON)** [geschlossen: proprietäres Layout] — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig — wer braucht das: Umsteiger von Trello-Boards.
- [ ] **Jira-Export (CSV)** [geschlossen: proprietäres Layout] — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig — wer braucht das: Umsteiger aus Jira in Firmen.
- [ ] **org-mode** [offen: Format in der frei zugänglichen Org-Dokumentation beschrieben] — Import ✗ / Export ✗ — Stand: [nicht belegt] — niedrig — wer braucht das: Emacs-Nutzer mit Aufgaben in Textdateien.
- [ ] **todo.txt** [offen: Spezifikation frei im Projekt todotxt/todo.txt] — Import ✗ / Export ✗ — Stand: [nicht belegt] — niedrig — wer braucht das: Terminal-Nutzer mit Textlisten.
- [ ] **Taskwarrior** [unklar, also geschlossen: nur die Implementierung beschreibt das Format, keine eigene Spezifikation] — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig — wer braucht das: Terminal-Nutzer mit bestehenden Taskwarrior-Daten.

Exchange-Trait/Muster: keiner. Tasks hat `import_ics` und `export_ics` am Items-Interface (fs-tasks:crates/fs-tasks-core/src/repo/transfer.rs), aber keinen Importer- oder Exporter-Trait und keinen Exchange-Trait (grep ohne Treffer).

## text (fs-wiki, künftig fs-text)

Quellen: origin/main fs-wiki 62366fb, fs-documentation d70c32f8 (ADR 0085). Externe Spezifikationen (CommonMark, GFM, HTML, ODF, WebDAV usw.) sind nur aus dem Kenntnisstand benannt, Lizenzen im Repo nicht belegt, wo "[Lizenz nicht im Repo belegt]" steht.

### Stufe 1 – Standards (Pflicht)
- [x] **CommonMark** (offen: spec.commonmark.org, CC-BY-SA 4.0 [Lizenz nicht im Repo belegt]) — Import ✓ / Export ✓ — Stand: gebaut + Test: `fs-wiki:crates/fs-text/src/markdown/import/`, `fs-wiki:crates/fs-text/src/markdown/export/`; Tests `fs-wiki:crates/fs-text/tests/markdown.rs`, `fs-wiki:crates/fs-text/tests/roundtrip.rs` (Korpus-Rundlauf) — hoch — Hauptformat des Wikis (`text/markdown`, `fs-wiki:crates/fs-wiki-core/src/media.rs`).
- [x] **GFM (Tabellen, Task-Listen, Durchstreichen)** (offen: github.github.com/gfm [Lizenz nicht im Repo belegt]) — Import ✓ / Export ✓ — Stand: gebaut + Test: `fs-wiki:crates/fs-text/src/markdown/export/table.rs`, Tests `fs-wiki:crates/fs-text/tests/gfm_fixture.rs`, `fs-wiki:crates/fs-wiki-app/tests/gfm_fixture.rs` — hoch — Tabellen und Häkchen der Nutzer kommen aus GFM.
- [ ] **HTML** (offen: WHATWG HTML Living Standard [Lizenz nicht im Repo belegt]) — Import ✗ / Export ✗ (nur erwähnt) — Stand: nur erwähnt: `fs-wiki:crates/fs-text/src/format/mod.rs:4` ("others (HTML, org, plain text) implement the same two traits"); rohes HTML wird nur als `Html`-Block in Markdown gehalten — hoch — Pflichtformat laut Auftrag, kein Import/Export gebaut.
- [ ] **ODF (ODT, ODS)** (offen: ISO/IEC 26300, OASIS, LibreOffice; Einordnung nach Strategie, Pflicht laut Auftrag) — Import ✗ / Export ✗ — Stand: [nicht belegt] (kein Treffer in `fs-wiki` außer Markdown) — hoch — LibreOffice-Standard, Pflicht laut Auftrag; `fs-wiki` kennt nur `text/markdown` (`fs-wiki:crates/fs-wiki-core/src/media.rs:14`).

### Stufe 2 – Verbreitete Formate
- [ ] **DOCX / OOXML (Word)** (geschlossen: Scheinoffenheit, Office schreibt „Transitional“, nicht „Strict“; Einordnung nach Strategie) — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — mittel — Word-Nutzer; ein Import-Weg ist sinnvoller als Export.
- [ ] **Google Docs (Export als HTML/DOCX)** (geschlossen: Google, Format nicht offen spezifiziert; Nutzerregel: nur Import) — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig — Dokumente aus Google Drive.

### Stufe 3 – Weniger bekannte, aber sinnvolle Formate (nur mit Begründung)
- [ ] **Obsidian-Markdown (Wikilinks, Callouts, `^id`)** (geschlossen: Obsidian ist Closed Source, Syntax nur in Hersteller-Doku; Nutzerregel: nur Import gezählt) — Import ✓ (gebaut, aber Test für den Import-Teil nicht eigens belegt) / Export — (geschlossen, nur Import) — Stand: gebaut: `fs-wiki:crates/fs-text/src/markdown/import/wikilink.rs`, `blockref.rs`, `callout.rs`, `fs-wiki:crates/fs-text/src/markdown/export/callout.rs`; Rundlauf nur über `fs-wiki:crates/fs-text/tests/corpus/synthetic-wiki.md` (Wikilinks), Callouts/`^id` nicht eigens getestet — niedrig — Nutzer mit Obsidian-Vault; ist im Markdown-Adapter schon enthalten.
- [ ] **Logseq-Markdown (Gliederung mit Punkten)** (offen: Logseq ist Open Source, Format als Markdown-Gliederung [Lizenz nicht im Repo belegt]) — Import ✗ / Export ✗ — Stand: [nicht belegt] — niedrig — nur wer eine Logseq-Wissensbasis mitbringt.
- [ ] **DokuWiki-Syntax** (offen: Open Source, Syntax-Doku frei [Lizenz nicht im Repo belegt]) — Import ✗ / Export ✗ — Stand: [nicht belegt] — niedrig — eigene Wiki-Dialekte, nur auf Nutzerwunsch.
- [ ] **MediaWiki-XML (Dump)** (offen: Open Source, Export-Schema im MediaWiki-Quelltext [Lizenz nicht im Repo belegt]) — Import ✗ / Export ✗ — Stand: nur Korpus-Textproben, kein Importer: `fs-wiki:crates/fs-text/tests/corpus/mediawiki-features.md`, `mediawiki-shortcuts.md` — niedrig — Wiki-Migration; die Korpusdateien sind keine Importe.
- [ ] **Confluence-Export (XML/HTML)** (geschlossen: Atlassian, Export-Format nicht frei spezifiziert; Nutzerregel: nur Import) — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] (nur Oberfläche "Confluence" in `fs-wiki:README.md`, kein Format) — niedrig — viele Firmen-Wikis kommen von dort.

Exchange-Trait/Muster: keiner (kein Exchange-Trait im Repo). Muster nahe ADR 0085: `Importer`/`Exporter` als Adapter-Traits in `fs-wiki:crates/fs-text/src/format/importer.rs` und `exporter.rs`, Factory `TextFormat::from_media_type` in `fs-wiki:crates/fs-wiki-core/src/media.rs`.

## files (fs-files)

### Stufe 1 – Standards (Pflicht)
- [ ] **WebDAV (RFC 4918)** (offen: IETF RFC 4918, frei nutzbar) — Import ✗ / Export ✗ (nur erwähnt) — Stand: nur erwähnt: `fs-files:README.md:30` ("no WebDAV"), `fs-files:crates/fs-files-core/src/backend/provider.rs:26` ("later `WebDAV`") — hoch — Pflichtstandard für Dateiablagen; Nextcloud und Co. sprechen es.
- [x] **S3 (Objekt-API)** (offen „de facto“: API vom Anbieter, aber freie Server setzen sie um; Referenz RustFS (Apache-2.0), daneben Garage und MinIO; gemeinsame S3-Teilmenge, Nur-AWS-Erweiterungen (S3 Select, Glacier-Klassen, Object Lambda) ausgenommen; wir schreiben in eigene Ablagen; Vermerk: Referenz RustFS, Tests gegen lokale Instanz (Stand: Tests laufen gegen Fake-S3 `tests/common/fake_s3.rs`, noch nicht gegen RustFS)) — Import ✓ / Export ✓ — Stand: gebaut + Test: `fs-files:crates/fs-files-core/src/backend/s3/` (adapter.rs, backend.rs, layout.rs), Tests `fs-files:crates/fs-files-core/tests/s3.rs`, `s3_repo.rs`, `s3_crash.rs` (Fake `tests/common/fake_s3.rs`). Export ist das Schreiben in die eigene Ablage über das Backend (`adapter.rs`, `put`/`put_part`; Tests `s3.rs` und `s3_repo.rs` mit Fake-S3, Uploads inkl. Wiederaufnahme) — mittel — Speicherziel für Dateien, kein Austauschformat.
- [ ] **ZIP / tar** (offen: PKWARE APPNOTE bzw. POSIX ustar [Lizenz nicht im Repo belegt]) — Import ✗ / Export ✗ (nur MIME-Erkennung) — Stand: nur Erkennung: `fs-files:crates/fs-files-core/src/repo/detect.rs:57-58`; kein Entpacken, kein Packen gebaut — niedrig — Wer Ordner mitnehmen will; Entpacken ist ein Angriffsfeld (Pfad-Traversal).

### Stufe 2 – Verbreitete Formate
- [ ] **Nextcloud-Dateiablage** (offen: Server AGPL; Zugriff über WebDAV, siehe oben [Lizenz nicht im Repo belegt]) — Import ✗ / Export ✗ — Stand: [nicht belegt] — mittel — Verbreitet; über WebDAV erreichbar, kein eigenes Format nötig.

Hinweis rsync-Manifeste: [nicht belegt] (kein Treffer), daher nicht aufgenommen.

Exchange-Trait/Muster: keiner. Ein Provider-Trait (`fs-files:crates/fs-files-core/src/backend/provider.rs`) trägt Speicherorte, kein Austauschformat.

## maps (fs-maps)

### Stufe 1 – Standards (Pflicht)
- [ ] **GeoJSON (RFC 7946)** (offen: IETF RFC 7946) — Import (teilweise: nur `Place` als Feature per API, kein Datei-Import) / Export (teilweise: nur Feature per API) — Stand: gebaut + Test: `fs-maps:crates/fs-maps-core/src/places/adapter.rs`, `fs-maps:crates/fs-maps-core/tests/places.rs` (u. a. `rejects_bad_features`), `fs-maps:crates/fs-maps-server/tests/places.rs` — hoch — Standard für Orte; Datei-Import/-Export fehlt.
- [ ] **GPX 1.1** (offen: Topografix-Schema, GDAL, viele freie Umsetzungen) — Import ✗ / Export ✗ — Stand: [nicht belegt] — mittel — Routen und Tracks aus Wander- und Radapps.
- [ ] **KML / KMZ (KMZ = ZIP mit KML)** (offen: OGC-Standard, GDAL; Einordnung nach Strategie) — Import ✗ / Export ✗ — Stand: [nicht belegt] — mittel — Google-Earth-Welt; KMZ bräuchte ZIP-Lesen (siehe fs-files).

### Stufe 2 – Verbreitete Formate
- [ ] **Google Takeout (KML, Standorte)** (geschlossen: Google, Struktur nicht offen spezifiziert; Nutzerregel: nur Import) — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig — Standortverlauf aus Google.

### Stufe 3 – Weniger bekannte, aber sinnvolle Formate (nur mit Begründung)
- [x] **PMTiles v3** (offen: Spezifikation gemeinfrei/CC0, `fs-maps/RESEARCH.md:35`; Einordnung nach Strategie) — Import ✓ / Export ✓ — Stand: gebaut + Test: Import `fs-maps:crates/fs-maps-core/src/source/` (PmtilesFileSource, PmtilesHttpSource); Export `RegionDownload` schreibt ein PMTiles-v3-Paket, Test `fs-maps:crates/fs-maps-core/tests/region.rs` (`download_roundtrip_through_local_pmtiles`), `fs-maps:crates/fs-maps-core/tests/http_fixture.rs` — hoch — Begründung: Kern des Karten-Konzepts (Kacheln, Offline-Regionen, `fs-maps/DESIGN.md`); begründet, daher Stufe 3 mit Priorität hoch.
- [ ] **OSM XML / OSM PBF** (offen: OSM-Wiki-Spezifikation, Daten ODbL) — Import ✗ / Export ✗ — Stand: nur erwähnt als Datenquelle (`fs-maps/RESEARCH.md:47`, Geofabrik `.osm.pbf`), kein Leser gebaut — niedrig — Nur wer eigene OSM-Auszüge einspielen will; Eigenbau von Kacheln ist nicht geplant.
- [ ] **MBTiles** (offen: offene Spezifikation, freie Umsetzungen) — Import ✗ / Export ✗ — Stand: [nicht belegt] — niedrig — Verbreitet bei Offline-Karten-Apps; PMTiles deckt den Fall ab.

Exchange-Trait/Muster: keiner. Muster: Adapter `GeoJSON Feature <-> StoredObject` in `fs-maps:crates/fs-maps-core/src/places/adapter.rs`; Strategy `TileSource` in `fs-maps:crates/fs-maps-core/src/source/tile_source.rs` (laut `fs-maps/DESIGN.md`).

## groups (fs-groups)

### Stufe 1 – Standards (Pflicht)
- [ ] **vCard KIND:group, RFC 6350 §6.1.4** [offen: IETF-Standard RFC 6350] — Import ✗ / Export ✗ — Stand: [nicht belegt] in fs-groups; fs-people speichert Gruppen als JSContact `kind: group` mit `members` (fs-people:DESIGN.md:209), ein vCard-Export oder -Import für Gruppen ist nicht getestet — hoch — Gruppen als Verteiler in jedem Mailprogramm.
- [ ] **LDIF / LDAP groupOfNames, RFC 2849 und RFC 4519** [offen: IETF-Standards RFC 2849, RFC 4519] — Import ✗ / Export ✗ — Stand: [nicht belegt]; der Verzeichnisspiegel läuft nur über die Schnittstelle `GroupDirectory` (fs-groups:crates/fs-groups-core/src/traits/directory.rs), der Kanidm-Adapter liegt in fs-identity, nicht in diesem Repo — mittel — Gruppen in LDAP-Verzeichnissen.
- [ ] **SCIM Group, RFC 7643** [offen: IETF-Standard RFC 7643] — Import ✗ / Export ✗ — Stand: nur erwähnt (fs-people:crates/fs-people-core/src/roles/known.json:32); keine SCIM-Schnittstelle in fs-groups — mittel — Gruppen-Abgleich mit Identitätsdiensten.
- [ ] **Matrix-Raum (Mitgliederliste)** [offen: Matrix-Spezifikation, Apache-2.0 (spec.matrix.org)] — Import ✗ / Export ✗ — Stand: [nicht belegt] — niedrig — Nicht passend im Moment: ein Raum ist ein Chat-Ort, keine Mitgliederliste im Importformat; erst relevant, wenn eine Matrix-Anbindung kommt.

### Stufe 2 – Verbreitete Formate
- [ ] **Google Groups, Konto-API** [geschlossen: proprietäre API] — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig — Verteilerlisten aus Google-Konten.
- [ ] **Outlook-Verteiler (Exchange)** [geschlossen: Microsoft-Protokolle, unklar] — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig — Verteiler aus Firmenkonten.
- [ ] **Nextcloud-Gruppen (OCS-API)** [unklar, also geschlossen: API-Dokumentation, keine Normspezifikation] — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig — Gruppen selbstgehosteter Nextcloud-Server.

### Stufe 3 – Weniger bekannte Formate (nur mit Begründung)
- keine Zeile: für Gruppen fand sich kein weiteres Format mit einer belegbaren Begründung.

Exchange-Trait/Muster: keiner für Import/Export. Der Verzeichnisspiegel ist ein Strategy- und Adapter-Muster ohne Dateiformat: `GroupDirectory` in fs-groups:crates/fs-groups-core/src/traits/directory.rs.

## messages (fs-messenger, künftig fs-messages)

### Stufe 1 – Standards (Pflicht)
- [ ] **MIME / RFC 5322, RFC 2045 ff.** (offen: IETF RFCs, frei) — Import (teilweise: nur über Server-Abruf per IMAP/JMAP, keine Datei-Einlesung von .eml) / Export ✗ (nicht gebaut) — Stand: gebaut + Test: `fs-messenger:crates/fs-messenger-mail/src/mime/` (classify.rs, build.rs), `fs-messenger:crates/fs-messenger-mail/tests/incoming.rs`, `tests/outgoing.rs` — hoch — Ursprungsbytes bleiben erhalten (ADR 0030); Datei-Import fehlt.
- [ ] **mbox (RFC 4155)** (offen: IETF Informational RFC 4155) — Import ✗ / Export ✗ (nur erwähnt) — Stand: nur erwähnt: `fs-messenger:crates/fs-messenger-core/src/export.rs:7` ("mbox (RFC 4155) ... is not rebuilt here") — hoch — Was Mail-Anbieter und Thunderbird exportieren; Mitnahme aus Mail.
- [ ] **Matrix (Spezifikation)** (offen: Matrix-Spec, frei [Lizenz nicht im Repo belegt]) — Import ✓ (Sync, `fs-messenger:crates/fs-messenger-matrix/src/provider/fetch.rs`, `raw_sync.rs`; Tests `fs-messenger:crates/fs-messenger-matrix/tests/server/`) / Export ✗ für Ereignisse (teilweise: nur Import; Raumschlüssel-Datei vorhanden: `fs-messenger:crates/fs-messenger-matrix/src/provider/rooms.rs:77` `export_room_keys`, Test `tests/server/late_key.rs`, `secrets.rs`, aber keine Ereignis-Datei) — hoch — Matrix-Räume sind ein Hauptweg; Ereignis-Export fehlt.
- [ ] **IMAP (RFC 9051)** (offen: IETF) — Import ✓ (`fs-messenger:crates/fs-messenger-mail/src/fetch/imap.rs`; Tests `tests/imap_faults.rs`, `tests/server/`) / Export ✗ (teilweise: nur Import; das Senden und APPEND des Sendeordners sind kein Austauschformat) — hoch.
- [ ] **JMAP (RFC 8620, RFC 8621)** (offen: IETF) — Import ✓ (`fs-messenger:crates/fs-messenger-mail/src/jmap/fetch.rs`; Tests `tests/jmap_faults.rs`) / Export ✗ (teilweise: nur Import) — hoch.

### Stufe 2 – Verbreitete Formate
- [ ] **Thunderbird (mbox-Profil)** (offen: mbox, Thunderbird MPL [Lizenz nicht im Repo belegt]) — Import ✗ / Export ✗ — Stand: [nicht belegt] — mittel — Verbreitetes Mail-Programm; mbox-Weg deckt es ab.
- [ ] **Outlook / Exchange (PST, MAPI, CSV)** (geschlossen: Microsoft, PST/MAPI proprietär; Nutzerregel: nur Import) — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig — Firmen-Postfächer; über IMAP/JMAP erreichbar.
- [ ] **Apple Mail (.emlx)** (geschlossen: Apple, Format nicht offen spezifiziert; Nutzerregel: nur Import) — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig.
- [ ] **Google Takeout (mbox)** (geschlossen: Google; Container ist mbox, Ordnung nicht offen spezifiziert; Nutzerregel: nur Import) — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — niedrig.

### Stufe 3 – Weniger bekannte, aber sinnvolle Formate (nur mit Begründung)
- [ ] **ActivityStreams 2.0 als JSON Lines (eigene Mitnahme)** (offen: W3C-Empfehlung ActivityStreams 2.0 als JSONL-Hülle; Einordnung nach Strategie, der Export bleibt) — Import ✗ (nicht gebaut) / Export ✓ — Stand: gebaut + Test: `fs-messenger:crates/fs-messenger-core/src/export.rs`, `fs-messenger:crates/fs-messenger-core/tests/export.rs`, `fs-messenger:crates/fs-messenger-core/tests/ideas_wired.rs` — mittel — Begründung: Nutzer wollen ihre Unterhaltung mitnehmen (Idee 10, ADR 0046); Anhänge nur mit Namen, keine Bytes.
- [ ] **ActivityPub / Fediverse** (offen: W3C ActivityPub Recommendation [Lizenz nicht im Repo belegt]) — Import ✗ / Export ✗ — Stand: [nicht belegt] — niedrig — Nur wenn Fediverse-Nachrichten in den Messenger sollen.

Exchange-Trait/Muster: keiner. Muster: Provider-Trait `fs-messenger:crates/fs-messenger-core/src/provider/traits.rs` (ein Trait für Mail, Matrix, MIMI; kein Austauschformat); Export als Funktion `conversation_jsonl` in `fs-messenger:crates/fs-messenger-core/src/export.rs`.

## draw (fs-whiteboard, künftig fs-draw)

Stand: fs-whiteboard origin/main (Programm fs-whiteboard, künftig fs-draw). Ein Format je Medientyp (`fs-whiteboard:crates/fs-whiteboard-core/src/format/strategy.rs`, `registry.rs`). Eigenes JSON-Format `application/vnd.freesynergy.whiteboard+json` ist gebaut, aber kein Standard (siehe Stufe 3).

### Stufe 1 – Standards (Pflicht)

- [ ] **SVG** (offen: W3C-Empfehlung SVG 1.1/2, frei nutzbar) — Import ✗ / Export ✓ (teilweise: nur Export) — Stand: gebaut + Test (`fs-whiteboard:crates/fs-whiteboard-core/src/svg/mod.rs`, `svg/render.rs`; Tests `fs-whiteboard:crates/fs-whiteboard-core/tests/svg.rs`, `tests/svg_valid.rs`) — Priorität hoch — Grund: Bild- und Austauschformat für Zeichnungen, von jedem Browser und Vektorprogramm lesbar; Import von SVG fehlt.
- [ ] **PNG-Export** (offen: W3C-Empfehlung PNG, frei) — Import — (nicht vorgesehen) / Export ✗ — Stand: "nur erwähnt" (`fs-whiteboard:README.md` Zeile 17: "PNG and PDF answer not possible"; `fs-whiteboard:DESIGN.md` Zeile 73) — Priorität mittel — Grund: Rasterbild für Vorschau und Einbettung in Dokumente, ohne Verlust der Vektordaten.
- [ ] **PDF-Export** (offen: ISO 32000, Spezifikation frei herunterladbar) — Import — (nicht vorgesehen) / Export ✗ — Stand: "nur erwähnt" (`fs-whiteboard:README.md` Zeile 17; `fs-whiteboard:DESIGN.md` Zeile 16 "PNG and PDF Unsupported") — Priorität mittel — Grund: Druck- und Archivformat für fertige Tafeln.
- [ ] **JSON Canvas** (offen: offene Spezifikation, MIT) — Import ✗ / Export ✗ — Stand: [nicht belegt] (kein Treffer in origin/main) — Priorität mittel — Grund: einfaches, offenes JSON mit Knoten und Kanten, das Notiz-Werkzeuge direkt lesen.
- [ ] **Excalidraw-JSON** (offen, Regel b: MIT-Referenzumsetzung) — Import ✗ / Export ✗ — Stand: [nicht belegt] (kein Treffer in origin/main) — Priorität niedrig (eher Stufe 3) — Grund: große Nutzerbasis für Handskizzen; Nutzen nur, wenn Nutzer bestehende Excalidraw-Dateien mitbringen.

### Stufe 2 – Verbreitete Formate (sinnvoll)

- [ ] **draw.io-XML** (geschlossen: kein veröffentlichter Standard, nur Quellcode des Werkzeugs als Referenz; unklar = geschlossen, nur Import) — Import ✗ — Export — (geschlossen, nur Import) — Stand: [nicht belegt] — Priorität mittel — Grund: verbreitetes Diagrammwerkzeug; Import bestehender Diagramme reicht.

### Stufe 3 – Weniger bekannte, aber sinnvolle Formate

- [x] **Eigenes JSON-Format** `application/vnd.freesynergy.whiteboard+json` (offen: die Grundlage ist JSON nach RFC 8259; das Format selbst ist ein Eigenformat ohne Standard) — Import ✓ / Export ✓ — Stand: gebaut + Test (`fs-whiteboard:crates/fs-whiteboard-core/src/format/json.rs`, `format/import.rs`; Tests `fs-whiteboard:crates/fs-whiteboard-core/tests/import.rs`, `tests/formats.rs`) — Priorität niedrig — Grund: Rundlauf zwischen FreeSynergy-Instanzen ohne Verlust; kein Standard, daher nur Stufe 3.

Exchange-Trait/Muster: keiner (kein Trait `Exchange` in fs-whiteboard). Muster: Strategy je Medientyp (`fs-whiteboard:crates/fs-whiteboard-core/src/format/strategy.rs` Trait `Format`; `format/registry.rs`). Der gesperrte Kalender-Trait `Exchange` liegt nur als Pilot vor: Pilot-Trait appointments_v1 (exchange.rs), nicht main (nicht in origin/main).

## forms (fs-surveys)

Stand: fs-surveys origin/main (Programm fs-surveys, Crate `fs-surveys-core`). Einzige Austauschform ist CSV-Export der Ergebnisse (`fs-surveys:crates/fs-surveys-core/src/repo/export.rs`, `src/csv.rs`). Kein Import, keine Fragebogen-Formate.

### Stufe 1 – Standards (Pflicht)

- [ ] **QTI** (offen: IMS, öffentliche Spezifikation, TAO) — Import ✗ / Export ✗ — Stand: [nicht belegt] (kein Treffer in origin/main) — Priorität mittel — Grund: Austauschstandard für Prüfungs- und Umfragefragen; nur nützlich, wenn Lehr-Systeme einbezogen werden.
- [ ] **CSV** (offen: RFC 4180) — Import ✗ / Export ✓ (teilweise: nur Export) — Stand: gebaut + Test (`fs-surveys:crates/fs-surveys-core/src/csv.rs`, `src/repo/export.rs`; Tests `fs-surveys:crates/fs-surveys-core/tests/anonymous.rs`, `tests/rules.rs`, `tests/review.rs`, `tests/ai_apart.rs`) — Priorität hoch — Grund: Ergebnisse in Tabellenprogramme holen; Escaping und Formelschutz sind getestet. Import (z. B. Teilnehmerlisten) fehlt.
- [ ] **JSON Schema / XForms** — nicht aufgenommen: keine Begründung im Auftrag, JSON Schema beschreibt Daten, nicht Fragebögen. Nur auf Wunsch prüfen.

### Stufe 2 – Verbreitete Formate (sinnvoll)

- [ ] **DDI** (offen: DDI-Alliance-Spezifikation, XML, frei nutzbar) — Import ✗ / Export ✗ — Stand: "nur erwähnt" (`fs-surveys:README.md` Zeile 25 "DDI export is not supported"; `fs-surveys:DESIGN.md` Zeile 152 "DDI export" als offen) — Priorität mittel — Grund: Standard für Befragungs-Metadaten, den Archive und Forschungsdaten-Repositorien verlangen.
- [ ] **XLSX** (geschlossen: OOXML, Scheinoffenheit (Office schreibt „Transitional“, nicht „Strict“); Einordnung nach Strategie) — Import ✗ / Export — (geschlossen, nur Import) — Stand: [nicht belegt] — Priorität mittel — Grund: Ergebnisse für Büro-Tabellen; CSV deckt den Zweck meist schon ab.

### Stufe 3 – Weniger bekannte, aber sinnvolle Formate

- [ ] **XLSForm** (offen: XLSForm-Spezifikation, Open-Source-Projekt ODK/KoBoToolbox) — Import ✗ / Export ✗ — Stand: [nicht belegt] — Priorität niedrig — Grund: Fragebogen-Austausch mit KoBoToolbox und ODK-Werkzeugen; Begründung "wer braucht das": Nutzer, die dort schon Erhebungen haben.
- [ ] **KoBoToolbox-Export** (geschlossen: Export-Format des Dienstes, Spezifikation nur über XLSForm und API; Einordnung: unklar = geschlossen, nur Import) — Import ✗ — Export — (geschlossen, nur Import) — Stand: [nicht belegt] — Priorität niedrig — Grund: Ergebnisse von dort übernehmen, wenn Nutzer den Dienst wechseln.
- [ ] **LimeSurvey-Export (.lss/.lsq, XML)** (geschlossen: Format der Anwendung, keine veröffentlichte Spezifikation; Lizenz der Software GPL ändert nichts an der Formatlage; unklar = geschlossen, nur Import) — Import ✗ — Export — (geschlossen, nur Import) — Stand: [nicht belegt] — Priorität niedrig — Grund: Umstieg von LimeSurvey; reiner Import genügt.

Exchange-Trait/Muster: keiner (kein Exchange-Trait in fs-surveys). Muster: Builder (`src/csv.rs` Struct `Csv`) und Adapter in `src/repo/export.rs`; die Export-Methode steht im Trait `Results` (`fs-surveys:crates/fs-surveys-core/src/traits/results.rs`, Zeile 27).

## activity (fs-activity, lokaler Ordner fs-history)

Stand: fs-history origin/main (Repo heißt laut Auftrag jetzt fs-activity; lokaler Ordner fs-history). AS2 ist nur das interne Speicherformat (`fs-activity:crates/fs-activity-core/src/repo/codec.rs`: Envelope-Typ `Activity`). Kein Import und kein Export nach außen (kein Treffer auf export/import in `fs-activity:crates/fs-activity-core/src` und `fs-activity:crates/fs-activity-hub/src`).

### Stufe 1 – Standards (Pflicht)

- [ ] **ActivityStreams 2.0** (offen: W3C-Empfehlung, frei) — Import ✗ / Export ✗ — Stand: nur intern verwendet (`repo/codec.rs`, `reads.rs` normalisiert AS2-Typen; Tests `tests/privacy.rs` prüft Envelope-Typ). Kein Import/Export eines AS2-Dokuments — Priorität mittel — Grund: Standard für Aktivitätsströme; die interne Form ist AS2-nah, aber der Austausch fehlt.

### Stufe 2 – Verbreitete Formate (sinnvoll)

- [ ] **Atom** (offen: RFC 4287, frei) — Import ✗ / Export ✗ — Stand: [nicht belegt] — Priorität mittel — Grund: Aktivitäts-Feed, den jeder Feedleser abonnieren kann; sinnvoll für eine Verlaufs-Ansicht ohne Programm auf der Gegenseite.
- [ ] **JSON Feed** (offen: jsonfeed.org-Spezifikation, frei) — Import ✗ / Export ✗ — Stand: [nicht belegt] — Priorität niedrig — Grund: JSON-Variante des Feeds, wenn Atom zu schwer ist.

### Stufe 3 – Weniger bekannte, aber sinnvolle Formate

- [ ] **Fediverse / ActivityPub** (offen: W3C-Empfehlung ActivityPub, frei) — Import ✗ / Export ✗ — Stand: "nur erwähnt" (`fs-activity:DESIGN.md` Zeile 60 "sharing ... no contract method yet"; `fs-activity:README.md` Zeile 26 "No sharing") — Priorität niedrig — Grund "wer braucht das": Verlauf in föderierte Netze veröffentlichen; nur mit Nutzerbedarf.
- [ ] **OpenTelemetry** (offen: CNCF-Spezifikation, frei) — Import ✗ / Export ✗ — Stand: "nur erwähnt" (`fs-activity:DESIGN.md` Zeile 60 "Telemetry import (OpenTelemetry not read)"; `fs-activity:README.md` Zeile 26) — Priorität niedrig — Grund "wer braucht das": Zeiterfassung aus Telemetrie; nur für Betriebsdaten sinnvoll, nicht für Aktivität der Personen.

Exchange-Trait/Muster: keiner. Muster: Adapter für den internen Eintrag (`fs-activity:crates/fs-activity-core/src/repo/codec.rs`, "Pattern: Adapter"); kein Austausch-Adapter.

## resources (fs-resources)

Stand: fs-resources origin/main (Programm fs-resources, Crate `fs-resources-core`). Im DESIGN ist "no standard for a resource model was found" vermerkt (`fs-resources:DESIGN.md`). MSPDI ist als "not built" geführt (`fs-resources:DESIGN.md`, Abschnitt "Not built").

### Stufe 1 – Standards (Pflicht)

- [ ] **ValueFlows** (offen: offenes Vokabular) — Import ✗ / Export ✗ — Stand: [nicht belegt] (kein Treffer `valueflow` in origin/main; `fs-resources:DESIGN.md` nennt kein Modell) — Priorität mittel — Grund: Vokabular für Ressourcen, Bedarf und Angebote; passt zu `Need`/`Offer`/`Resource`, ist aber nicht umgesetzt.
- [ ] **iCalendar VFREEBUSY** (offen: RFC 5545, frei) — Import ✗ / Export ✗ — Stand: [nicht belegt] (kein Treffer `freebusy`/`VFREEBUSY` in fs-resources; Kalender-Seite in fs-calendar nicht geprüft) — Priorität mittel — Grund: Verfügbarkeit von Personen und Räumen austauschen, ohne Termine preiszugeben.

### Stufe 2 – Verbreitete Formate (sinnvoll)

- [ ] **MSPDI** (geschlossen: Microsoft-Projekt-XML, Spezifikation nur über Microsoft-Dokumentation; Einordnung nicht im Volltext geprüft, unklar = geschlossen, nur Import) — Import ✗ / Export — (geschlossen, nur Import) — Stand: "nur erwähnt" (`fs-resources:DESIGN.md`, "MSPDI import and export (fit unproven)"; Abschnitt "Not built") — Priorität niedrig — Grund: Zeit- und Ressourcenpläne aus MS Project übernehmen; Export nach MS Project nicht nötig.
- [ ] **CSV für Ressourcenlisten** (offen: RFC 4180) — Import ✗ / Export ✗ — Stand: [nicht belegt] — Priorität mittel — Grund: einfachster Austausch für Kapazitäten und Bedarf; Vorbild Tabellenprogramme (dieselbe Form wie forms).

### Stufe 3 – Weniger bekannte, aber sinnvolle Formate

- [ ] **Toggl-Zeitexport** (geschlossen: Ausgabeformat des Dienstes ohne veröffentlichte Spezifikation; unklar = geschlossen, nur Import) — Import ✗ — Export — (geschlossen, nur Import) — Stand: [nicht belegt] — Priorität niedrig — Grund "wer braucht das": Zeitbuchungen aus Zeiterfassung übernehmen, wenn Nutzer umsteigen; `fs-resources:DESIGN.md` nennt "a time ledger" als nicht gebaut.

Exchange-Trait/Muster: keiner. Kein Import/Export-Adapter im Repo. Gesperrtes Muster nur als Pilot: Pilot-Trait appointments_v1 (exchange.rs), nicht main (Trait `Exchange`, Kalender).


## Auffälligkeiten

Die Einordnungen folgen der Entscheidung der Strategie und sind verbindlich.

1. **Regel einheitlich angewandt?** Ja, seit der Einordnung. Die Vorfassung führte DOCX und XLSX als offen; beide sind jetzt geschlossen (nur Import). Outlook-CSV ist geschlossen.
2. **Umordnung entschieden:** Offen (Import und Export): ODF (text), GPX, KML/KMZ, MBTiles (maps), ActivityStreams-JSON-Lines (messages), JSON Canvas und Excalidraw (draw), Flatpak-Metadaten (software), QTI (forms), ValueFlows (resources). Geschlossen bleiben DOCX und XLSX. Die Export-Spalten sind ✓ oder ✗. Gebaut ist davon nur der Export von ActivityStreams-JSONL; kein umgeordnetes Format hat Import und Export, daher bleibt jede dieser Zeilen `[ ]`.
3. **S3 erledigt:** offen (Import UND Export) per Zusatz der Strategie, Referenz RustFS. Export ist das Schreiben in die eigene Ablage (`fs-files:crates/fs-files-core/src/backend/s3/`, Tests `fs-files:crates/fs-files-core/tests/s3.rs`, `fs-files:crates/fs-files-core/tests/s3_repo.rs`). Die Tests laufen gegen Fake-S3, nicht gegen eine lokale RustFS-Instanz; das ist im Vermerk der Zeile genannt. Zeile `[x]`, weil Import und Export gebaut und getestet sind.
4. **ActivityStreams-JSONL-Export:** Entschieden: offen, der Export bleibt (`fs-messenger:crates/fs-messenger-core/src/export.rs`). Die Import-Seite fehlt, daher `[ ]`.

5. **Pflichtformate und Kriterien-Belege:** ODF (Pflicht) ist nach der Strategie offen. HTML, CommonMark, GFM, ActivityPub, MIME und die IETF-/W3C-Zeilen bleiben offen. Ihre Kriterien (1) und (3) beruhen auf Kenntnisstand, nicht auf Repo-Belegen (oft „[Lizenz nicht im Repo belegt]“). PMTiles (offen, CC0 laut fs-maps/RESEARCH.md:35) hat Kriterium (3) nur aus Kenntnisstand und steht in Stufe 3, obwohl es Kern des Karten-Konzepts und mit Priorität hoch markiert ist. Stufe-Einordnung prüfen.
6. **Stand-Belege (git grep origin/main, Stichprobe):** bestätigt: fs-calendar:README.md:30 („No CalDAV“), fs-whiteboard:README.md:17 („PNG and PDF answer not possible“), `fs-messenger:crates/fs-messenger-core/src/export.rs:8` („is not rebuilt here“). Eine Angabe nennt Zeile 7; es ist ein Zeilenversatz. Nicht geprüft: alle übrigen Stand-Angaben. calendar (webcal, Exchange-Trait) und software (Pilot) verweisen auf Pilot-Dateien, nicht auf origin/main.
7. **Programmnamen:** Vereinheitlicht als „Schlüsselwort (Repo, künftig Name)“. Zu bestätigen: activity hat Repo fs-activity und lokalen Ordner fs-history; draw hat Überschrift „draw“, Repo fs-whiteboard, künftig fs-draw.
8. **Doppelt geführt:** CalDAV (calendar und tasks, Nextcloud je dort); CardDAV (people, Nextcloud Kontakte); Nextcloud in calendar, people, tasks, groups und files; Thunderbird (ICS in calendar, vCard in people, Aufgaben in tasks, mbox in messages); Outlook-PST (people und messages); Google Takeout (maps KML, messages mbox); ActivityPub (activity und messages, beide Stufe 3); CSV RFC 4180 (forms und resources); Matrix (messages und groups); vCard (people) und vCard KIND:group (groups).
9. **Stufen und Priorität:** draw Excalidraw steht in Stufe 1 mit Priorität niedrig („eher Stufe 3“). software AppStream ist [ ] mit Export „teilweise“. forms „JSON Schema / XForms“ ist keine Formatzeile (nicht aufgenommen) und wird in den Zahlen nicht gezählt.
10. **Exchange-Vorgabe:** Die Vorgabe nennt „fs-text format/traits.rs“. Belegt sind fs-text `format/importer.rs` und `format/exporter.rs` sowie fs-calendar `format/traits.rs` (Teil A). Im Abschnitt Exchange ist der belegte Pfad angegeben. Der Trait `Origin` aus der Vorgabe steht in Teil A nicht; dort heißt er `ImportContext`.


## Exchange-Trait/Muster je Programm

Nur der gesperrte Kalender-Trait (`appointments_v1/exchange.rs`) hat einen Exchange-Trait (`ExportTarget`, `ImportContext`). Produktiv gibt es das Importer/Exporter-Muster (fs-text `format/importer.rs` und `format/exporter.rs`; fs-calendar `format/traits.rs`).

| Programm | Trait/Muster | Fundstelle |
|---|---|---|
| calendar | Exchange-Trait (`import`/`export`, `ExportTarget`, `ImportContext`), nur gesperrter Pilot und Entwurf; produktiv Importer/Exporter-Muster | Pilot-Trait appointments_v1 (exchange.rs), nicht main; `fs-calendar:crates/fs-calendar-core/src/format/traits.rs`; Entwurf `fs-calendar:crates/fs-calendar-testdata/src/draft/appointments_v1/exchange.rs` |
| software | kein Exchange-Trait; Adapter AppStream, Strategy je Installationsweg; Trait `Packages` nur im Pilot | `fs-store:crates/fs-store-catalog/src/lib.rs`, `fs-store:crates/fs-store-core/src/strategy.rs`; Pilot Pilot packages_v1, nicht main |
| people | Importer/Exporter-Muster; `PersonDirectory` nur im Pilot | `fs-people:crates/fs-people-core/src/format/traits.rs`, `fs-people:crates/fs-people-app/src/transfer.rs` |
| tasks | kein Trait; `import_ics`/`export_ics` am Items-Interface | `fs-tasks:crates/fs-tasks-core/src/repo/transfer.rs` |
| groups | kein Austausch-Trait; Strategy/Adapter `GroupDirectory` (ohne Dateiformat) | `fs-groups:crates/fs-groups-core/src/traits/directory.rs` |
| text | kein Exchange-Trait; Importer/Exporter-Adapter, Factory `TextFormat::from_media_type` | `fs-wiki:crates/fs-text/src/format/importer.rs`, `exporter.rs`; `fs-wiki:crates/fs-wiki-core/src/media.rs` |
| files | kein Austausch-Trait; Provider-Trait trägt Speicherorte | `fs-files:crates/fs-files-core/src/backend/provider.rs` |
| maps | kein Austausch-Trait; Adapter GeoJSON, Strategy `TileSource` | `fs-maps:crates/fs-maps-core/src/places/adapter.rs`, `src/source/tile_source.rs` |
| messages | kein Austausch-Trait; Provider-Trait, Export als Funktion | fs-messenger-core `src/provider/traits.rs`, `src/export.rs` |
| draw | kein Exchange-Trait; Strategy `Format` je Medientyp | `fs-whiteboard:crates/fs-whiteboard-core/src/format/strategy.rs`, `format/registry.rs` |
| forms | kein Exchange-Trait; Builder und Adapter, Export im Trait `Results` | `fs-surveys:crates/fs-surveys-core/src/csv.rs`, `src/repo/export.rs`, `src/traits/results.rs` |
| activity | kein Austausch-Trait; Adapter für den internen Eintrag | `fs-activity:crates/fs-activity-core/src/repo/codec.rs` |
| resources | kein Trait, kein Import/Export-Adapter; nur Pilot-Kalender-Trait | Pilot-Trait appointments_v1 (exchange.rs), nicht main |


## Top 10 der nächsten Schritte

Sortiert nach Nutzen; calendar und software stehen bei Gleichstand vorn. Nur Einträge mit belegtem Stand. Die Umordnungen der Strategie (ODF, GPX, KML, MBTiles, ActivityStreams-JSONL, JSON Canvas, Excalidraw, Flatpak, QTI, ValueFlows) stehen nicht in den Top 10; die Liste bleibt unverändert.

| Nr | Programm | Format | Import/Export | Priorität | Nutzen | Aufwand |
|---|---|---|---|---|---|---|
| 1 | calendar | CalDAV, RFC 4791 | ✗ / ✗ | hoch | Konten-Sync mit Nextcloud, Apple, Thunderbird; ohne ihn kein Abgleich mit Servern. | groß |
| 2 | software | apt-Repo-Metadaten (ADR 0078) | ✗ / ✗ | hoch | Der Store nutzt apt-Quellen direkt und nicht nur einzelne .deb. | mittel |
| 3 | software | rpm-Repo-Metadaten (repodata) | ✗ / ✗ | hoch | Wie apt, für rpm-basierte Quellen. | mittel |
| 4 | software | AppStream (Katalog) | ✓ / teilweise | hoch | Der Store kann den Katalog selbst schreiben, nicht nur lesen. | mittel |
| 5 | calendar | iCalendar, RFC 5545 (Google, Apple, Outlook, Thunderbird als Datei) | ✓ / ✓ | mittel | Gebaut, es fehlen nur Tests mit echten Exportdateien; Google-Export ist die häufigste Quelle. | klein |
| 6 | people | CardDAV, RFC 6352 | ✗ / ✗ | hoch | Adressbuch-Sync mit Nextcloud, Apple, Thunderbird. | groß |
| 7 | files | WebDAV, RFC 4918 | ✗ / ✗ | hoch | Pflichtstandard für Dateiablagen; Nextcloud spricht ihn. | groß |
| 8 | text | HTML (WHATWG) | ✗ / ✗ | hoch | Pflichtformat laut Auftrag; Wiki-Inhalte in Webform. | mittel |
| 9 | messages | mbox, RFC 4155 | ✗ / ✗ | hoch | Mitnahme aus Mail-Anbietern und Thunderbird. | mittel |
| 10 | maps | GeoJSON, RFC 7946 (Datei) | teilweise / teilweise | hoch | Standard für Orte; der Datei-Import und -Export fehlt. | klein |
