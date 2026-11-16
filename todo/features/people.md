# Feature-Abgleich: PROGRAMM people (fs-people)

Stand 2026-11-16, Auftrag 27, Feature-Abgleich vor dem Feature-Freeze. Feature-Freeze: offen (Nutzer). Nur Deutsch: todo/ wird nicht übersetzt (ADR 0011).

Stand: 2026-11-16 · Auftrag 27 · Nutzerregel: „Erst testen, dann Ideen sammeln, dann die Features anderer Programme ansehen und ebenso umsetzen, BEVOR es einen Feature-Freeze gibt.“
Vorbilder: Google Kontakte, Apple Kontakte, Outlook People, Thunderbird, Nextcloud Contacts (zusätzlich KAddressBook, GNOME Kontakte, Monica als Dossier-Quelle).
Zustand bei uns: fs-people v0.0.2 (README „What it can do today“), DESIGN.md, PLAN.md §4 (Funktionsliste L1–L18), todo/checklisten/fs-people.md.
Legende: `[x]` gebaut (Kern: `fs-people-core`, auch wenn das Fenster es nicht zeigt) · `[ ]` geplant (Plan §) oder fehlt · Priorität: hoch = Pflicht/Kern; mittel = verbreitet, klarer Nutzen; niedrig = Nische. Prioritäten sind Vorschläge der Recherche, nicht beschlossen.
Format je Zeile: Feature — Vorbilder — Stand bei uns — Priorität — Nutzen.

## Karten (Inhalt)

- [x] Name-Teile, Anzeigename, Spitzname — Google, Apple, Nextcloud, KDE — gebaut: JSContact Name-Komponenten, `name.full`, nickname (DESIGN „Envelope derivation“, Typed Card) — hoch — Ein Mensch wird richtig angesprochen und gesucht.
- [x] Phonetik (Aussprache der Namen) — Apple, Google, Nextcloud (vCard-Felder) — gebaut (`phonetic`, `phoneticScript`, fs-people-core card/parts.rs:34,51) (korrigiert 16.11. nach Opus-Bewertung) — niedrig — Richtige Aussprache und Sortierung bei fremden Namen.
- [x] Adressen (mehrere, typisiert) — alle Vorbilder — gebaut im Kern: JSContact `address` (card/parts), Fenster zeigt sie nicht [Fenster offen] — hoch — Post an die richtige Adresse.
- [x] Telefon (E.164-artig, Index) — alle — gebaut: Index `phone`, Suche nach Ziffern — hoch — Anrufen und Finden.
- [x] E-Mail (Index, kleingeschrieben) — alle — gebaut: Index `email`, Suche, Vorschlag von Domains (`suggest`) — hoch — Schreiben und Finden.
- [x] Messenger/Online-Dienste — Apple (Social/Messenger-Felder), Nextcloud (Social), Monica — gebaut: JSContact `onlineServices` (typisiert, RFC 9553) — mittel — Kontakt über den Dienst.
- [x] Social-Profile/Links — Nextcloud, KDE, Apple — gebaut: JSContact `links` — niedrig — Verweise auf Profile.
- [x] Geburtstage/Jahrestage — Nextcloud, KDE, GNOME, Apple — gebaut: `anniversaries` typisiert; Kalender-Ableitung fehlt (PLAN §4 „Geburtstagskalender: nein, Kalender-Facette später“) — mittel — Erinnerung an Geburtstage.
- [ ] Geburtstagskalender aus Karten — Nextcloud („Personal birthdays“), KDE — geplant (PLAN §4, Kalender-Facette später) — mittel — Keine Doppelpflege mit dem Kalender.
- [x] Notizen — alle — gebaut: JSContact `notes` (`note`-Glied) — mittel — Kontext zur Person festhalten.
- [x] Fotos/Avatare — alle — gebaut: `media` typisiert; vCard PHOTO/KEY noch nicht getestet (todo: SPÄTER) — mittel — Wiedererkennen.
- [x] Beziehungen (Partner, Kind, …) — GNOME (Relationships), KDE (Reiter), Monica (gerichtete Typen) — gebaut: `relatedTo`, `relate`/`unrelate`/`relations` — mittel — Familie und Freunde verknüpfen.
- [x] Organisationen, Titel, Abteilung — alle — gebaut: `organizations`/`titles`, Index `org` — hoch — Geschäftliche Zuordnung.
- [ ] Lebensereignisse/Meilensteine — Monica („Life events“) — fehlt (in Requirements nur „proposed“, nicht im Plan) — niedrig — Persönliche Chronik.
- [ ] Geschenke/Ideen, Schulden zwischen Personen — Monica — fehlt (Nische) — niedrig — Wer hat was bekommen, wer schuldet was.

## Gruppen und Labels

- [x] Gruppen (Verteiler) — KDE (distribution lists), Nextcloud (Circles), Monica (groups) — gebaut: `kind: group` + `members`, add/remove/resolve (ADR 0037) — hoch — Mails an einen Kreis.
- [ ] Gruppen-Mitglieder im Fenster verwalten — KDE, Nextcloud — geplant (PLAN §4 L6: nein in v1, O6/O7) — hoch — Gruppen ohne Umweg pflegen.
- [x] Mehrere Rollen je Person (Labels nach Rolle) — Monica (Labels), Google (Labels) — gebaut: Rollen (ADR 0052) mit `define_role`, Zuweisung als Relationship — mittel — Kunde, Mitglied, KI in einer Karte.
- [ ] Freie Labels/Kategorien (Tags) je Karte — Google („Labels“), KDE (Kategorien), Thunderbird (Kategorien über CardBook) — fehlt (Google-Dossier „Labels: not covered“) — mittel — Schnelles Sortieren ohne Gruppenbaum.
- [ ] Favoriten / „häufig kontaktiert“ — Nextcloud (Favoriten), GNOME (frequent), KDE (Favoriten) — fehlt (PLAN §4: v2) — niedrig — Oben, was oft gebraucht wird.

## Duplikate erkennen und zusammenführen

- [x] Dublettenvorschlag (gleiche Person) — Google (Merge & fix), Apple (Duplikate), Outlook (Vorschlag auf Profilkarte, Web), KDE (Ähnlichkeitsassistent), Nextcloud (bei Import) — gebaut: `same proposals`, Regeln E-Mail/Telefon/Name (ADR 0058), nur Vorschlag — hoch — Doppelte fallen auf, ohne dass etwas ohne Frage passiert.
- [x] Verknüpfen, lösen, ablehnen — GNOME (Link/Unlink) — gebaut: confirm/unlink/reject/reopen (`owl:sameAs`) — hoch — Vorschlag bestätigen oder dauerhaft verwerfen.
- [ ] Zusammenführen (ein Datensatz aus zwei) mit Rückgängig — Google (Merge), Apple (merge), Outlook (merge), Thunderbird (CardBook) — fehlt; Verknüpfung ersetzt es nicht; Plan: `contact.merge` (proposed, Requirements) — hoch — Eine saubere Karte statt zwei.
- [ ] Massen-Vorschlag „alle zusammenführen“ — Google („Merge all“), Apple — fehlt — mittel — Schnell aufräumen nach Import.
- [x] Abgelehnte Vorschläge dauerhaft merken — (Google/Apple: nicht belegt) — gebaut (matching/state.rs:6, DESIGN.md:27, AS2 `Reject`) (korrigiert 16.11. nach Opus-Bewertung); fs-people README.md:33 („sieht es wieder“) ist dazu veraltet — hoch — Nicht erneut nerven.
- [ ] Doppelte beim Import erkennen und Wahl (neu/zusammenführen) — Outlook (Klassisch: Wahl beim Import), Nextcloud (beim Import), KDE (Import-Assistent) — teils: Import überspringt bekannte `uid`s; Wahl fehlt — mittel — Kein stiller Doppel-Import.

## Suche, Vorschlag, Auto-Vervollständigung

- [x] Suche nach Name, Spitzname, E-Mail, Telefon, Organisation — alle — gebaut: `find`, Suche im Store (OR-Gruppe, Groß/Klein egal) — hoch — Eine Person schnell finden.
- [x] Sortierung nach Nachname — alle — gebaut: Index `name_sort` — hoch — Ordnung im Verzeichnis.
- [ ] Auto-Vervollständigung für andere Programme (Mail, Kalender-Gast) — Nextcloud (Mail-Autocomplete), KDE (Autocomplete in KMail), GNOME (EDS) — geplant (PLAN §5.2 Personenwähler `person-ref-picker`; CLI `pick` in §4) — hoch — Ein Name reicht in Mail und Kalender.
- [x] Vorschlag von Feldwerten (häufigste Domains) — (keine Vorlage gefunden) — gebaut: `suggest` (max 20, nie aus sensiblen Karten) — niedrig — Tippfehler weniger.
- [ ] „Zuletzt in Kontakt“ und Erinnerung, sich zu melden — Monica (Erinnerungen, „last spoke“) — proposed (Requirements `contact.keepInTouch`) — mittel — Beziehungen nicht einschlafen lassen.

## Ich-Karte

- [ ] Eigene Karte („Ich“) festlegen und pflegen — Apple (eigene Karte, NameDrop-Quelle), Google (Profil), Nextcloud — geplant (entschieden O11(a), Trait `asker()` api.rs:50) (korrigiert 16.11. nach Opus-Bewertung); Fenster: handelnde Person fest als Platzhalter, kein Login) — hoch — Eigene Daten für Export und Teilen.
- [ ] Eigene Karte teilen oder nahe übergeben — Apple (NameDrop) — proposed (Requirements `contact.shareNearby`; Transport offen, ADR 0059) — niedrig — Kontakt tauschen ohne Zettel.

## Teilen, Rechte, Sichtbarkeit

- [ ] Adressbuch mit anderen teilen (Rechte je Stufe) — Nextcloud (drei Stufen), KDE (nicht; nur CardDAV) — fehlt (Sync/CardDAV SPÄTER; keine Rechte im Kern) — mittel — Familie oder Team nutzt dasselbe Verzeichnis.
- [x] Sensibel markieren (Sichtbarkeit beim Export) — (ohne Vorbild; DPV-Kategorien) — gebaut im Kern: `freesynergy.net:sensitive`; Export ohne Freigabe ausgelassen; Fenster-Knopf nicht in v1 (PLAN §4 L16, O8 verschoben) — hoch — Gesundheits- oder Glaubensdaten bleiben draußen.
- [ ] Felderweise Filter beim Export/Teilen — (ohne Vorbild; Nextcloud: Privacy-/Sync-Filter bei CardDAV) — geplant (todo: SPÄTER; ADR 0029) — mittel — Nur die Felder teilen, die man will.
- [ ] Zugriffsrechte je Person (Lesen/Schreiben) — Nextcloud, Google (Konto) — fehlt (kein Login; Plan §4 „Konten: nein“) — niedrig — Mehrere Nutzer auf einem Server.

## Datenschutz, Auszug, Einwilligungen

- [ ] Auszug („Excerpt“) einer Karte für Dritte, mit Feldwahl — Apple (Karte bearbeiten, nur Initialen), Apple NameDrop — fehlt (Export mit Feldwahl SPÄTER) — mittel — Nur Name und Telefon weitergeben.
- [ ] Einwilligungen festhalten (wer hat zugestimmt, wann, wofür) — (keine Vorlage in den Dossiers; Gap) — fehlt — hoch — Nachweis nach DSGVO, Art. 7.
- [x] Sensible Daten: Kategorie-Liste (DPV) — (ohne Vorbild) — gebaut im Kern (siehe Teilen) — hoch — Gesetzeskonforme Kennzeichnung.
- [ ] Verschlüsselung im Ruhezustand — (ohne Vorbild; KDE: nur Betriebssystem) — geplant: fs-objects verweigert sensible Objekte ohne Verschlüsselung (DESIGN, getestet) — hoch — Sensible Karten nur verschlüsselt.

## Import und Export

- [x] vCard 2.1/3.0/4.0 Import und Export — alle — gebaut (`calcard`, Original je Karte erhalten; DESIGN, README) — hoch — Umzug von Google, Apple, Nextcloud.
- [x] JSContact (JSCard, RFC 9553) Import und Export — (offene Spezifikation; Monica JSON-Export, Nextcloud nicht) — gebaut: `JsContactFormat` — mittel — Verlustfrei zwischen FreeSynergy-Programmen.
- [ ] CSV Import und Export — Monica, KDE (CSV/TSV), Google (CSV), Outlook (CSV) — fehlt; Einordnung nach Import/Export-Regel offen (RFC 4180, schema-los; Begründung nötig) — mittel — Tabelle in Excel bearbeiten.
- [ ] LDIF Import und Export — KDE, Thunderbird (LDAP) — fehlt; Einordnung offen (LDIF = RFC 2849, offen) — niedrig — Umzug aus LDAP oder Mutt.
- [ ] Import-Bericht mit Auswahl (neu, überspringen, zusammenführen) — Outlook (klassisch), KDE (Assistent) — teils: Bericht mit `created`/`skipped`/`failed` gebaut; Wahl fehlt — mittel — Nach dem Import genau wissen, was passiert ist.
- [ ] Export einzelner oder ausgewählter Karten — KDE, Monica, Apple — teils: `export` ganzer Bestand; Auswahl fehlt (CLI-Plan: `export <id…>`) — mittel — Eine Familie an einen Freund schicken.
- [ ] Öffentliche Karte als Link (vCard-Seite) — Monica — fehlt (nicht geplant) — niedrig — Kontakt teilen ohne Datei.

## Sync, Offline, Konten

- [ ] CardDAV (Sync mit Nextcloud, Thunderbird, Apple, Android) — Nextcloud, Thunderbird (CardBook), KDE (Akonadi), GNOME (EDS), Apple — SPÄTER (todo; Plan §8 Adapter-Grenze) — hoch — Ein Adressbuch auf allen Geräten.
- [ ] Sync-Token/Delta (nur Änderungen) — Nextcloud (COLLECTION-REPORT) — SPÄTER (todo: CardDAV/Sync-Token RFC 6352) — mittel — Schnell auch bei vielen Karten.
- [x] Live-Aktualisierung (andere Fenster sehen Änderungen) — (ohne Vorbild; GNOME EDS-Dienst nahe) — gebaut: `PeopleFeed`/`PersonListener` (Karten, nicht Rollen); Fenster noch nicht (PLAN L15 `ja`) — mittel — Änderung sofort überall.
- [ ] Offline arbeiten, später abgleichen — GNOME (EDS offline), Apple, Google (Android) — fehlt — mittel — Unterwegs ohne Netz.
- [ ] Konten (Google, Nextcloud, LDAP als Quelle) — GNOME (Online-Konten), KDE (Akonadi), Nextcloud — fehlt (PLAN §4: eigene Anbieter, nicht v1) — niedrig — Vorhandene Adressen direkt übernehmen.
- [ ] Mehrere Adressbücher nebeneinander (Quelle je Buch) — KDE (mehrere Quellen), Nextcloud, GNOME — fehlt (ein Store) — mittel — Privat und Arbeit trennen.

## Mobil

- [ ] Mobile Ansicht (Telefon, Tablet) — Apple, Google, Nextcloud (Web) — fehlt (kein Frontend für Mobil geplant; KDE: Plasma Mobile nur im Entstehen) — mittel — Kontakte unterwegs.
- [ ] Anrufen, schreiben, navigieren aus der Karte — Apple, Google, Nextcloud (Talk, Mail) — fehlt — mittel — Eine Berührung statt Kopieren.

## Tastatur und Barrierefreiheit

- [ ] Tastaturkürzel (Neu, Suche, Löschen, Speichern) — Apple (Kurzbefehle-Seite), GNOME, Google (shortcuts), Monica — fehlt (Dossier-Seiten `shortcuts.md` vorhanden, Inhalte fremd; nicht übernehmen) — hoch — Ohne Maus arbeiten.
- [ ] Fokus-Reihenfolge und Bildschirmleser-Namen je Feld — (keine Vorlage belegt) — fehlt; [nicht belegt] — hoch — Barrierefreiheit nach Standard.
- [ ] Hell/dunkel und Schriftgröße je Fenster — Apple, Google — geplant (PLAN §5.1: hell und dunkel, Stile aus unseren Mitteln) — mittel — Lesbar bei jedem Licht.

## KI-Konten, Organisationen, Gruppen als Personen-Arten

- [x] Art der Karte: Person, Organisation, Gruppe — Google (Kontakte/Gruppen), Monica (Personen/Kreise), KDE (Verteiler) — gebaut: `kind` (individual/org/group/application) — hoch — Richtig sortieren und anzeigen.
- [x] KI als Person markieren (`application` + Rolle `ai`; schränkt nichts ein) — (ohne Vorbild; ADR 0054) — gebaut: `mark_ai` — mittel — Man weiß, mit wem man zu tun hat.
- [ ] Organisation mit Mitarbeitern verknüpfen — Google (Organisation), Nextcloud (Firma), Monica — teils: Rollen und Beziehungen vorhanden; Anzeige „Mitarbeiter von…“ fehlt — mittel — Wer arbeitet wo.

## Adressbücher, Kalender, Aufgaben

- [ ] Teilnehmer in Terminen aus Personen wählen — Nextcloud (Kalender-Gäste), KDE, Apple — geplant (PLAN §2.5: Übergang freier Namen zu `PersonRef`; PLAN §5.2 `person-ref-picker`) — hoch — Gäste sauber verbinden.
- [ ] Aufgabe einer Person zuweisen — Monica (Aufgaben je Person), Google — geplant (Verweis wie oben; Aufgaben-Programm fs-tasks) — mittel — Wer macht was.
- [ ] Geburtstage in den Kalender — Nextcloud, KDE — geplant (Kalender-Facette später) — mittel — siehe oben.
- [ ] Verlauf je Kontakt (Änderungen, Rückgängig) — Google („History“, Undo-Artikel) — geplant (PLAN §4 L13 `ja`; L14 Rückgängig: ohne Vorbild) — mittel — Frühere Fassung zurückholen.
- [ ] Gesprächs- und Kontakthistorie aus Nachrichten — Monica (Aktivitäten, Zeitleiste) — proposed (Requirements; Quelle: Nachrichten-Programm) — niedrig — Wann habe ich zuletzt geschrieben.

## DSGVO: Auskunft und Löschung

- [ ] Auskunft: alle Daten einer Person als Datei (Art. 15) — (ohne Vorbild in Dossiers; Export als Hilfe) — teils: Export aller Karten; „Auskunft je Person mit Verweisen“ fehlt — hoch — Pflicht nach DSGVO.
- [x] Löschen einer Karte, Verknüpfungen mit entfernen — alle — gebaut: `delete` entfernt Verknüpfungen (DESIGN) — hoch — Ende der Speicherung.
- [ ] Papierkorb mit Frist, „Gelöscht – Rückgängig“ — Google (Papierkorb, Frist nicht belegt), Apple (nicht belegt) — geplant (PLAN §4 L5 `ja`; Stand: nicht gebaut) — hoch — Versehentliches Löschen zurücknehmen.
- [ ] Löschen eines ganzen Bestands auf Wunsch (Nutzerskript) — (Regel: Massenlöschen führt der Nutzer per Skript aus) — Regel, kein Feature — hoch — Verweis, keine Agenten-Löschung.

## Selbstverwaltung

- [x] Rollen selbst definieren (Vokabular) — (ohne Vorbild; SKOS) — gebaut: `define_role`, Rollenregister je Basis — mittel — Eigene Gruppen von Rollen.
- [x] Typen-Beschreibung und Prüfung der Felder (für Programme) — (ohne Vorbild) — gebaut: `DescribesType`, `check`, `patch` — mittel — Andere Programme wissen, was gültig ist.
- [ ] Eigene Felder (benutzerdefiniert) — Monica (eigene Felder), Nextcloud (Vorlagen fehlen), KDE (nicht) — fehlt; `extra`-Felder bleiben erhalten, nicht bearbeitbar — niedrig — Zusatzangaben ohne Programmänderung.
- [ ] Felder-Vorlagen oder Feldgruppen — Nextcloud (nicht belegt als Stärke), KDE (Reiter) — fehlt — niedrig — Gleiche Felder für alle Kontakte einer Art.

## Ideen des Nutzers

- (Platzhalter: Ideen des Nutzers werden hier gesammelt, sobald er sie nennt. Nichts davon ist bisher bewertet.)

## Feature-Freeze: offen (Nutzer)

Kein Freeze gesetzt. Nur der Nutzer setzt ihn, nach Handtest, seiner Ideensammlung und diesem Abgleich.

## Quellen

- Dossiers (fs-documentation, origin/main, Stand 2026-11-16, per git show gelesen): docs/en/programs/apps/people/index.md, requirements.md; frontends/google-contacts, apple-contacts, nextcloud-contacts, kaddressbook, gnome-contacts, monica (features.md).
- todo/checklisten/fs-people.md (origin/main, 2026-11-16); research/contacts-identity-standards.md (nicht gelesen).
- Outlook: https://support.microsoft.com/en-US/outlook/people/manage-duplicate-contacts-in-outlook (Abruf 2026-11-16, nur Suchauszug gelesen, nicht vollständig geöffnet).
- Thunderbird: https://developer.thunderbird.net/thunderbird-development/codebase-overview/address-book (Abruf 2026-11-16, Suchauszug); CardBook-Add-on: https://addons.mozilla.org/en-US/thunderbird/addon/cardbook/versions/24.6 (Abruf 2026-11-16, Suchauszug).
- Eigene Stände: fs-people/DESIGN.md, fs-people/README.md, Planordner pilot-people/PLAN.md (§2, §4, §5, §8).
- Nicht belegt: Google-Papierkorb-Frist, Thunderbird-Funktionen 2025/26 (Suche ergab kaum Neues), Apple-Phonetik-Felder. Markiert als [nicht belegt].
