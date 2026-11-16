# Feature-Abgleich: calendars (fs-calendars)

Stand 2026-11-16, Auftrag 27, Feature-Abgleich vor dem Feature-Freeze. Feature-Freeze: offen (Nutzer). Nur Deutsch: todo/ wird nicht übersetzt (ADR 0011).

Stand: 2026-11-16 · Auftrag 27 · Feature-Freeze: offen (Nutzer)
Lesart: Nutzerregel „Erst testen, dann Ideen sammeln, dann die Features anderer Programme ansehen und ebenso umsetzen, BEVOR es einen Feature-Freeze gibt.“ Kein Freeze gesetzt.

Legende Vorbilder: GC Google Calendar · OL Outlook/Microsoft 365 · AC Apple Kalender · TB Thunderbird · NC Nextcloud Calendar · PC Proton Calendar · MK Merkuro (KDE) · NT Notion Calendar · FA Fantastical · CC Cal.com · RC Reclaim · MO Motion · DV DAViCal · RA Radicale · BA Baïkal · EV GNOME Evolution (nur Blogquellen, unsicher) · KO KOrganizer (nur Vergleichsseiten, unsicher)
Legende Stand: gebaut | geplant (Plan §) | fehlt. [x] = gebaut oder fest geplant, [ ] = fehlt/offen.
Lizenz: Wir kopieren nichts; hier stehen nur Funktionsnamen.

## Ansichten
- [x] Tag-, Wochen- und Monatsraster — GC, OL, AC, NC, MK, FA — gebaut (Fenster; Kern-Raster, tests/grid.rs) — hoch — Grundbedienung jedes Kalenders.
- [x] Agenda als Liste nach Tagen — GC, OL, NC, MK, FA — gebaut (Kern `agenda`, Termine plus fällige Aufgaben) — hoch — schneller Überblick ohne Raster.
- [x] Arbeitswoche (5 Tage) — AC, MK — geplant (Plan §3.2 `week` 7 oder 5 Tage) — mittel — Woche ohne Wochenende.
- [ ] 3- oder 4-Tage-Ansicht — GC (4 Tage), MK (3 Tage) — fehlt — niedrig — Zwischenstufe zwischen Tag und Woche.
- [x] Mini-Monat zum Springen in der Seitenleiste — GC, AC, OL — geplant (Plan §3.1 `calendar-grid` Variante `compact`) — mittel — Navigation ohne Ansichtswechsel.
- [ ] Jahres- oder Mehrmonatsansicht — GC, AC, NC (`multiMonthYear`) — fehlt (Plan §4.1 „Nicht: Jahr“) — niedrig — Überblick über lange Zeiträume.
- [ ] Zeitleiste für Räume/Ressourcen — NC (Resource-Timeline) — fehlt — niedrig — Raumbelegung sehen.
- [ ] Mehrere Zeitzonen nebeneinander, mit Beschriftung — NT, OL — fehlt im Fenster (Kern nimmt `view_zone` als Parameter, Plan §1.2) — niedrig — Reisende und verteilte Teams.
- [x] Betrachter-Zone sichtbar, Termin-Zone gespeichert — GC, OL, NC, MK — geplant (Plan §4.1 Start, §4.2 CLI-Zone) — hoch — jeder sieht Zeiten in der eigenen Zone.

## Termine
- [x] Serientermine (täglich bis jährlich, Anzahl oder Enddatum) — GC, OL, NC, MK, DV, RC — gebaut (Kern RRULE; Fenster kann Serienregeln noch nicht ändern, README) — hoch — wiederkehrende Termine ohne Mehrarbeit.
- [x] Einzelne Vorkommen einer Serie ändern oder löschen — GC, OL, NC, AC — gebaut (Kern, Kennung `<id>#<recurrence id>`) — hoch — Ausnahmen ohne die ganze Serie zu zerstören.
- [x] Serienfrage „nur dieser / dieser und folgende / alle“ — GC, OL, AC, MO — geplant (Plan §1.2 `SeriesScope`, Abnahme A9/A10) — hoch — eindeutige Wahl beim Ändern und Löschen.
- [x] Zeitzone je Termin, Start in der Termin-Zone — OL, NC, MK, FA — gebaut (IANA-Zonen; unbekannte Zone wird abgelehnt) — hoch — Termin bleibt bei Zeitumstellung korrekt.
- [x] Schwebende Zeit mit Marke „Zone angenommen“ — — (eigene Idee aus ADR 0085) — geplant (Plan §1.2 `Floating`, Abnahme Z4) — mittel — ehrlich markierte Zeiten aus Fremddateien.
- [x] Ganztägige Termine (Datum statt Uhrzeit, mehrtägig) — GC, OL, AC, NC, MK — gebaut (Kern `showWithoutTime`, Ganztagszeile im Raster); Anlegen im Fenster geplant (Plan A3) — hoch — Feiertage, Urlaub, Reisen.
- [x] Erinnerungen (mehrere, Vorlauf frei wählbar, bis 5) — GC, OL, NC, MK, AC — geplant (Plan §3.1 `alert-list-field`, A6); Kern hält Alarme nur durch — hoch — rechtzeitig erinnert werden.
- [ ] Erinnerung als Benachrichtigung ausgeben (Systemmeldung, Mail) — GC, OL, NC, AC — fehlt (VALARM wird nicht ausgewertet) — hoch — ohne Auslösung nützt der Alarm nichts.
- [ ] Anhänge am Termin — GC (Drive-Dateien), OL, NC (Dateiordner), MK — fehlt (Links bleiben erhalten, nicht typisiert) — mittel — Unterlagen direkt am Termin.
- [ ] Ort mit Kartenanzeige — GC, OL, AC, NC — fehlt (Orte bleiben erhalten; fs-maps nicht angebunden) — mittel — Anfahrt sofort sehen.
- [ ] Videokonferenz-Link automatisch erzeugen — GC (Meet), OL (Online-Meeting), NC (über Talk), FA — fehlt (Links bleiben erhalten) — mittel — ein Klick zum Meeting.
- [ ] Reisezeit zwischen Terminen — FA (Reisewarnung) — fehlt, nicht geplant (Plan §4.1 „Nicht: Reisezeit“) — niedrig — Wegzeit einplanen.
- [x] Farbe und Schlagwörter je Termin — GC, OL, NC, MK — gebaut (Felder `color`, `keywords`); Anzeige nach Schlagwort fehlt — mittel — schnelle Einordnung im Raster.
- [x] Frei/Belegt- und Sichtbarkeitsstatus je Termin — OL (`showAs`, `sensitivity`), GC — gebaut (Felder `freeBusyStatus`, `privacy`) — mittel — Verfügbarkeit ehrlich zeigen.
- [x] Vertrauliche Termine vom Export ausschließen — OL (`sensitivity`), PC (Verschlüsselung) — gebaut (Marke `freesynergy.net:sensitive`, README) — hoch — Datenschutz beim Teilen von Dateien.
- [ ] Privatsphäre-Feld bis in die Hülle durchreichen — OL — fehlt (nur die Marke `sensitive` erreicht die Hülle, DESIGN „Open points“) — mittel — Schutzstufe ist überall sichtbar.
- [ ] Beschreibung mit Formatierung (Rich-Text) — OL (HTML-Text) — fehlt (Feld ist Klartext) — niedrig — Listen und Links im Termintext.

## Gäste, Antworten, Verfügbarkeit
- [x] Gäste einladen und Zusage, Absage, Vielleicht setzen — GC, OL, NC, MK, AC — gebaut (Kern `invite`, `respond`, README) — hoch — Termine mit anderen abstimmen.
- [ ] Gäste aus dem Personenverzeichnis wählen (mit Suche) — NC (Autocomplete), GC, OL, MK — geplant (Plan §3.1 `person-ref-picker`, A5); blockiert, weil lokale Personen noch nicht gebaut sind (Plan R5) — hoch — keine Adresse tippen müssen.
- [x] Gast schlägt neue Zeit vor — OL (`allowNewTimeProposals`) — geplant (Plan A11; Trait `respond(.., proposal)`, appointments_v1/api.rs:79) (korrigiert 16.11. nach Opus-Bewertung) — mittel — Abstimmung ohne Mail-Schleife.
- [ ] Frei/Belegt von Gästen sehen — GC, OL (`getSchedule`), NC — geplant (Trait `free_busy` im Fixpunkt, appointments_v1/api.rs:84; Kern und Fenster fehlen noch) (korrigiert 16.11. nach Opus-Bewertung) — hoch — Zeitfenster finden ohne Rückfragen.
- [ ] Terminfindung über Vorschläge — OL (`findMeetingTimes`), GC („Find a time“), NC — fehlt (nicht im Plan) — mittel — gemeinsamen Termin in einem Schritt finden.
- [ ] Buchungsseite mit Terminarten, Puffer und Vorlauf — CC, NT, NC (Terminbuchung), PC (nur Geschäftskunden) — fehlt (requirements.md „proposed“) — niedrig — Externe buchen selbst.
- [ ] Freie Zeitfenster als Link teilen — NT — fehlt (requirements.md „proposed“) — niedrig — Terminbuchung ohne Konto.

## Kalender
- [ ] Mehrere Kalender, einzeln ein- und ausblenden, mit Farbe — GC, AC, NC, MK, FA — geplant (Trait `calendars` und `create_calendar` stehen im Fixpunkt; Fenster zeigt einen Kalender; Ändern, Löschen und Wiederherstellen fehlen im Trait) (korrigiert 16.11. nach Opus-Bewertung) — hoch — Arbeit und Privat trennen.
- [ ] Kalender als ICS-Abo über URL (webcal) — GC (öffentlich), TB, DV (`external_refresh`), MK — fehlt (Import-Export-Liste Stufe 3, nur erwähnt) — mittel — Feiertage, Spielpläne, Fremdkalender.
- [ ] Kalender teilen mit Rechten (nur frei/belegt, Details, bearbeiten) — GC, OL, NC, DV (ACL) — fehlt (Plan §4.1 „Nicht: Freigabe“) — mittel — Familie oder Team arbeitet zusammen.
- [ ] Feiertage nach Region — MK (`holidayRegions`), AC, TB (Feiertags-Abos) — fehlt — mittel — Feiertage sofort sichtbar.
- [ ] Geburtstage und Jubiläen als eigener Typ — GC (`birthdayProperties`), AC — fehlt — niedrig — Geburtstage aus Kontakten.
- [ ] Alternative Kalendersysteme (chinesisch, hebräisch, islamisch) — AC — fehlt — niedrig — Nutzer mit anderen Kalendern.
- [ ] Wetter im Termin — — (in keinem belegten Vorbild gefunden) — fehlt, nicht belegt — niedrig — nur auf Wunsch, Datenschutz prüfen.

## Aufgaben und Notizen
- [x] Fällige Aufgaben in der Agenda und im Raster — MK (Aufgaben in Ansichten), NC (ungeplante Aufgaben) — gebaut (Kern `TasksInWindow`, fs-tasks); ganztägige Fälligkeit fehlt (Plan R7) — hoch — Aufgaben und Termine an einem Ort.
- [ ] Aufgaben in freie Zeit einplanen (nach Priorität und Frist, bei Änderung neu) — RC, MO — fehlt (requirements.md „proposed“) — mittel — Arbeit fällt nicht zwischen die Termine.
- [ ] Serienartige Blöcke für Gewohnheiten und Fokuszeit — RC, GC („Focus time“) — fehlt (requirements.md „proposed“) — niedrig — Konzentrationszeit festhalten.
- [ ] Notiz oder Wiki-Seite an den Termin hängen — GC (Drive-Dateien) — fehlt — niedrig — Vorbereitung im selben Ort (fs-text möglich).
- [ ] Termin aus einem Satz anlegen (Datum, Uhrzeit, Ort, Kalender) — FA, GC („Quick add“), MK — fehlt (Kern meldet `quickEntry` als „kommt noch“) — mittel — schneller als das Formular.

## Suche
- [x] Termine suchen nach Begriff und Zeitraum — GC, OL, NC — gebaut (Kern `find` mit `term`, `from`, `to`) — mittel — Termin wiederfinden.
- [ ] Suche über alle Kalender, Gäste und Orte mit Filtern — GC, OL — fehlt (Plan §4.1 „Nicht: Suche über Konten“) — niedrig — große Kalenderbestände durchsuchen.

## Import und Export
- [x] iCalendar-Datei importieren (RFC 5545) — alle Vorbilder mit ICS — gebaut (Import-Export-Liste: ✓, Tests ics.rs) — hoch — Wechsel von anderen Programmen.
- [x] iCalendar-Datei exportieren mit Originalrundlauf — AC, GC, OL, MK, TB — gebaut (Import-Export-Liste: ✓, Tests media.rs) — hoch — Daten bleiben bei uns frei.
- [x] JSCalendar-JSON importieren und exportieren (RFC 8984) — — (kein belegtes Vorbild; offener Standard) — gebaut (Export für mehrere Termine provisorisch, DESIGN) — hoch — eigener Standard des Termins (ADR 0020).
- [ ] CalDAV-Abgleich mit Servern (RFC 4791) — NC, DV, RA, BA, MK, TB, AC — fehlt (Plan §1.3: „nein“) — hoch — ohne ihn kein Abgleich mit anderen Geräten.
- [ ] Einladung per Mail beantworten (iTIP/iMIP, RFC 5546/6047) — TB, OL, GC, RA (per E-Mail) — fehlt (Plan §1.3: später) — mittel — Gäste ohne unser Programm erreichen.
- [ ] Anbindung an Google- oder Outlook-Konten — GC, OL, MK (über Konten), EV (Blogquelle) — fehlt (Plan §1.3: eigene Anbieter, nicht geplant) — mittel — bestehende Konten übernehmen.

## Synchronisation und Offline
- [x] Lokale Speicherung, Stand bleibt nach Neustart erhalten — alle — gebaut (Store über fs-objects; README) — hoch — Arbeit ohne Netz.
- [x] Vollständig offen nutzbar, ohne Netz — GC (Offline laut Hilfe, Umfang nicht geprüft), AC — gebaut (lokaler Store, kein Netz nötig) — hoch — Zug, Flugzeug, schlechtes Netz.
- [ ] Änderungsabgleich mit dem Server (Sync-Token, ETag) — DV (RFC 6578), RA (Sync-Token), NC — fehlt (hängt an CalDAV) — hoch — nur Geändertes wird übertragen.
- [ ] Konfliktbehandlung bei gleichzeitiger Änderung — OL, GC, NC — geplant nur lokal (Plan §1.2 `expected: Revision`, Fehler `Changed`) — mittel — Änderungen gehen nicht verloren.

## Tastatur und Barrierefreiheit
- [x] Tastaturbedienung für Anlegen, Ändern, Löschen, Bestätigen, Abbrechen — GC (Kürzel), OL, AC, MK, NC — geplant (Plan §4.3 A1, A9, A12) — hoch — Bedienung ohne Maus.
- [x] Raster mit Rolle `grid` (WAI-ARIA) und Zuständen — — (Barrierefreiheit-Standard) — geplant (Plan §3.2) — hoch — Bildschirmleser können das Raster lesen.
- [x] Hell- und Dunkel-Stil, Kontrast-Stil lesbar — GC, OL, AC, NC — geplant (Plan §3.2, ADR 0074 §3) — mittel — Lesbarkeit bei Licht und bei Sehschwäche.
- [ ] Tastaturkürzel frei belegbar oder einsehbar — GC, OL, MK — fehlt (keine Liste beschrieben) — niedrig — Kürzel nachschlagen und anpassen.

## Mobil
- [ ] Mobile App für iOS und Android — GC, AC, NC, PC, FA — fehlt (vier Frontends geplant, ADR 0066; kein mobiles Ziel) — niedrig — unterwegs Termine sehen.
- [ ] Uhr-App — GC — fehlt — niedrig — Termin am Handgelenk.
- [ ] Desktop-Widget oder Menüleisten-Ansicht — FA — fehlt — niedrig — heutige Termine ohne Fenster.

## Benachrichtigungen
- [ ] Erinnerung als Systemmeldung oder Mail — GC, OL, NC, AC — fehlt (siehe Termine) — hoch — rechtzeitige Hinweise.
- [ ] Hinweis bei neuer Einladung oder Antwort — OL, GC, NC — fehlt — mittel — Antworten nicht übersehen.
- [x] Andere Programme über Änderungen informieren — — (fs-intern) — gebaut (README: „Tell other programs when an event changes“) — mittel — Verknüpfung mit Aufgaben, Personen, Wiki.

## KI-Funktionen (nur benennen)
- [ ] Natürlichsprachige Eingabe — FA, GC („Quick add“) — fehlt (`quickEntry` nicht unterstützt) — niedrig — siehe Termine „aus einem Satz“.
- [ ] Automatische Umplanung von Aufgaben und Terminen — RC, MO — fehlt (nur benannt) — niedrig — Entlastung bei vollem Kalender.
- [ ] Assistent oder Zusammenfassung — PC (Lumo, eigenes Produkt, nicht im Kalender belegt) — fehlt, nicht belegt — niedrig — nur mit klarer Datenschutz-Regel.

## Datenschutz und Verschlüsselung
- [x] Termine im Speicher verschlüsseln — PC (Ende-zu-Ende für Termin-Inhalte) — geplant (Plan §2.3 Nr. 10, `is_encrypted`) — hoch — Inhalte bleiben auf dem Gerät des Nutzers lesbar, nicht auf dem Server.
- [ ] Ende-zu-Ende für geteilte Termine und Gäste — PC — fehlt, nicht geplant — niedrig — Gäste sehen nur, was freigegeben ist.
- [ ] Nur Frei/Belegt teilen, ohne Details — OL (`showAs`), GC („see availability“) — fehlt (Freigabe nicht geplant) — mittel — Verfügbarkeit zeigen, Inhalte schützen.

## Selbstverwaltung
- [x] Lokaler Dienst über Unix-Socket, Verwaltungsfenster aus der Typbeschreibung — — (eigene Architektur) — gebaut (DESIGN 0.0.3) — mittel — Ein Programm für Fenster und Dienst.
- [ ] Eigener CalDAV-Server, selbst betrieben — DV, RA, BA, NC — fehlt (Server im Plan nicht vorgesehen) — mittel — Daten bleiben beim Betreiber; passt zu „Dezentral, kleine Server“.
- [ ] Konten, Gruppen und Rechte pro Kalender verwalten — DV (ACL, Principals), RA (Rechte-Backends) — fehlt — niedrig — Mehrbenutzerbetrieb.
- [ ] Verwaltung im Browser — BA, DV, RA (Weboberfläche) — fehlt (Verwaltungsfenster ist Desktop) — niedrig — Administration ohne Installation.

## Ideen des Nutzers
_Platzhalter: die Strategie trägt die Ideen des Nutzers ein (z. B. Selbstverwaltung/Türsteher, Papierkorb-Einstellungen)._

## Quellen (Abruf 2026-11-16, wenn nicht anders angegeben)
- Dossiers aus fs-documentation origin/main, `docs/en/programs/apps/calendars/frontends/<programm>/latest/features.md` (Hersteller-Quellen laut `index.md` je Programm; Dossier-Stand laut Datei): GC (2026-11-02), OL (2026-11-02), NC (2026-10-26, Quelltext v6.6.4), MK (Merkuro 26.08.2, Quelltext), DV (1.1.13), CC, FA, MO, NT (kurze Suchtreffer-Dossiers, schwach). RC und MO nur aus `docs/en/programs/apps/calendars/requirements.md`.
- AC: https://support.apple.com/guide/calendar/welcome/mac (Guide, macOS 27; Seitendatum nicht angegeben). Dünn: Ansichten Woche/Jahr/Liste und Zeitzonen nicht belegt.
- TB: https://www.thunderbird.net/en-US/features/ und https://support.mozilla.org/en-US/kb/creating-new-calendars. Die Features-Seite nennt keine Kalenderfunktionen; belegt sind nur Abo-Hinweise und CalDAV.
- PC: https://proton.me/calendar. Ende-zu-Ende, Verfügbarkeit, Terminplanung nur Geschäft; Ansichten, Abo, Sync nicht genannt.
- RA: https://radicale.org/v3.html (Seite gekürzt gelesen, Abschnitt Grenzen vollständig).
- BA: https://sabre.io/baikal/ (Produktseite; Freigabe, Abo, iTIP nicht genannt).
- EV, KO: nur Blogs und Vergleichsseiten per Suche (z. B. opensource.com/alternatives/google-calendar). Unsicher, keine Herstellerdoku gelesen; Zeilen mit „unsicher“ bitte gegenprüfen.
- Nicht belegt: Freigabe und Terminfindung bei TB, AC und EV; Erinnerungsdetails bei TB.
