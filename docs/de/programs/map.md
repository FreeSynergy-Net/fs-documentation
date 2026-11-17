# Karte der Programme

**Stand: Entwurf (2026-11-08); die Schichten und die vier Frontends sind entschieden (ADR 0066, 2026-11-09), die Programmtabelle ist noch offen.** Diese Seite führt jedes Programm, jede Facette und jede Suite an einer Stelle auf, zusammen mit den Datentypen, die jedes besitzt, und den Frontends, die es bekommt. Sie ist der Ausgangspunkt von Runde 3: Zuerst einigen wir uns auf diese Karte, dann auf die Datentypen und Schnittstellen, und erst dann bauen wir.

## Die Schichten, von unten nach oben

| Schicht | Was es ist | Wer es festlegt |
|---------|------------|-----------------|
| **Basistyp** | Ein kleiner Wert mit festen Regeln: E-Mail-Adresse, Telefonnummer, Name, Adresse, Datum. Überall gleich. | Einmal, für alle Programme |
| **Datentyp** | Ein Ding aus Basistypen, das genau einem Programm gehört: `Person`, `Event`, `Task`. Folgt einem Standard. | Das besitzende Programm (ADR 0050) |
| **Schnittstelle** | Was ein Programm mit seinen Datentypen tun kann: Befehle wie anlegen, ändern, finden, vorschlagen. | Das besitzende Programm |
| **Component** | Jeder Basistyp hat feste Components: *Eingabe*, *Anzeige*, *kompakt* (in einer Zeile), *Zelle* (in einer Liste). Ein Datentyp bekommt seine Components von seinen Basistypen. | Einmal, in `fs-components` |
| **Stil** | Das Aussehen: Abstände, Ecken, Glas oder deckend, Schriften, **ein eigener Icon-Satz**. Von jedem Frontend wiederverwendbar. | Einmal je Stil, insgesamt 5–10 |
| **Frontend** | Eine Art, ein Programm oder eine Facette zu benutzen, gebaut aus Components in einem Stil. | Je Programm oder Facette |
| **Facette** | Ein Teil eines Programms, der wie eine eigene App aussieht (ADR 0061). | Das Programm |
| **Suite** | Mehrere Programme zusammen für einen Zweck. | Programmübergreifend |

Das Backend meldet für jeden Datentyp seine Felder, deren Basistypen und seine Befehle. Ein Frontend entscheidet nie, was eine E-Mail-Adresse ist; es entscheidet nur, wo es die E-Mail-Component zeigt.

## Vier Frontends für jedes Programm (ADR 0066)

| Frontend | Zweck | Wie gebaut |
|----------|-------|------------|
| **Admin** | Jedes Feld, jede Einstellung, jeder Befehl. Das Sicherheitsnetz. Sieht aus wie SAP Fiori (ein öffentliches Designsystem für dichte Geschäftsdaten). | Aus der Datentyp-Beschreibung erzeugt, derselbe Code für alle Programme |
| **Einfach** | Für Menschen mit wenig Erfahrung: wenige Knöpfe, groß, klar. | Von Hand, ein Stil für alle Programme |
| **Apple-Stil** | Nach Apples Designsprache auf Maß nachgebaut: Abstände, Zeilenhöhen, Schriftgrößen, Ecken, Glas, Layout. | Von Hand, nach einem Messblatt |
| **Windows-Stil** | Dasselbe nach Microsofts Fluent-Design: flache Flächen, dessen Abstände und Ecken. | Von Hand, nach einem Messblatt |

Die Messblätter stammen aus den öffentlichen Richtlinien (Apple Human Interface Guidelines, Microsoft Fluent 2) und aus Bildschirmfotos der eigenen Apps der Plattformen, die lokal bleiben und nie veröffentlicht werden. Der genaue Nachbau testet auch, was die GUI-Engine kann. Eigene Icons, eigene Texte und offene Schriften mit ähnlichen Maßen; nichts davon von ihnen.

Der Apple-Stil nimmt Apples eigene Apps als Vorlage: zuerst 1:1 nachgebaut, dann mit Funktionen gefüllt, später bei Bedarf verändert. Der Windows-Stil wird ebenfalls 1:1 nachgebaut, je Kategorie ein Windows-Programm, möglichst eines, das es unter Linux nicht gibt, damit alle davon in offener Software profitieren. Bewusst keine Linux-Programme als Vorlage: Die haben wir schon. Später kommt ein eigener **FreeSynergy-Stil**, ganz anders als alle diese (ADR 0066, Ergänzung vom 2026-11-09).

Die Analysen bekannter Programme je Kategorie (`frontends/<programm>/latest/`) bleiben die Quelle für **Funktionen**.

## Windows-Vorlagen (vom Besitzer genehmigt, 2026-11-10)

Der Windows-Stil wird 1:1 nach je einem Windows-Programm je Kategorie nachgebaut, möglichst eines ohne Linux-Gegenstück. Kein Linux-Programm ist Vorlage. Maße und Quellen: `docs/en/components/styles/windows.md`.

| Kategorie (Programm oder Facette) | Windows-Programm | Anmerkungen |
|-----------------------------------|------------------|-------------|
| People | Outlook | Personenansicht des neuen Outlook für Windows |
| Mail (Messenger) | Outlook | Mail-Modul des neuen Outlook |
| Calendar | Outlook | Kalender-Modul des neuen Outlook |
| Groups | Microsoft Teams | |
| Tasks | Microsoft To Do | |
| Files | Datei-Explorer | |
| Gallery (Facette von Files) | Fotos | Microsoft Fotos |
| Videos | Media Player | Klären, welcher der beiden Player gemeint ist: die neue Media-Player-App oder Windows Media Player Legacy (optionales Feature) |
| Wiki | OneNote | |
| Maps | Google Earth | Google Earth Pro für Windows. Street View bekommt kein eigenes Frontend |
| Whiteboard | Microsoft Whiteboard | **Offen:** Laut Microsofts Support-Seite werden die eigenständigen Whiteboard-Apps für Windows am 2026-10-16 eingestellt (Whiteboard bleibt in Teams und im Web, für Arbeits- und Schulkonten). Braucht eine Entscheidung vor dem Nachbau |
| Surveys | Microsoft Forms | **Offen:** Forms ist ein Webdienst ohne Windows-App |
| Resources | Excel | |
| Streaming | YouTube Studio | **Offen:** YouTube Studio ist ein Webdienst ohne Windows-App; sein Live Control Room ist die Referenz |
| Store | Microsoft Store | |
| Start | Startmenü und Widgets | |
| Identity | Einstellungen > Konten, plus Windows Hello | Eine Einstellungsseite, kein Programm |
| History | keines | Keine Vorlage |

**Regel für Vorlagen (Besitzer, 2026-11-10, immer):** Die Vorlage einer Kategorie ist das Programm mit den besten Funktionen, der besten UX und UI, ob Open Source, nur im Web oder eingestellt. Wir suchen, was Open Source **nicht** hat; die Open-Source-Funktionen kommen obendrauf. Die Recherche für Whiteboard, Surveys, Studio/Streaming und Videos läuft (alle bekannten Programme je Kategorie, dann eine Empfehlung). **Gallery** zeigt lokale Dateien und entfernte Quellen (YouTube, Vimeo, Odysee, PeerTube) über eine Anbieter-Schnittstelle, wie die KIs in People; **Studio** (Facette von `fs-broadcast`) ist Live-Produktion (OBS, Restream, StreamYard, vMix). ADR 0066.

## Basistypen (erste Liste)

| Basistyp | Standard | Benutzt von |
|----------|----------|-------------|
| Text, mehrzeiliger Text | – | alle |
| Formatierter Text | RFC 9073 `STYLED-DESCRIPTION`, eigenes Textmodell (ADR 0031) | wiki, tasks, messages |
| E-Mail-Adresse | RFC 5322, JSContact `EmailAddress` | people, messenger, identity, groups |
| Telefonnummer | E.164, JSContact `Phone` | people |
| Online-Dienst, Kennung | JSContact `OnlineService` | people, messenger |
| Link | RFC 3986, JSContact `Link` | alle |
| Name einer Person | JSContact `Name` mit `components[]` | people, identity |
| Postanschrift | JSContact `Address` | people, maps, resources |
| Ort | `geo:`-URI (RFC 5870), GeoJSON | maps, calendar, people, files |
| Datum, Datum und Zeit, Zeitzone | RFC 3339, JSCalendar `LocalDateTime`, IANA-Zonen | calendar, tasks, history |
| Dauer, Wiederholung | JSCalendar `Duration`, `RecurrenceRule` | calendar, tasks |
| Sprache | BCP 47 (RFC 5646) | alle |
| Menge, Geld | UCUM, ISO 4217 | resources |
| Farbe | CSS Color 4 | alle |
| Bild, Klang, Video | AS2 `Image`/`Audio`/`Video`, Medientypen | people, files, messenger |
| Öffentlicher Schlüssel | OpenPGP-Fingerabdruck, JSContact `CryptoKey` | people, identity |
| Status, Priorität, Auswahl | JSCalendar-Enums, eigene Listen | tasks, surveys |
| Schlüsselwörter | JSContact `keywords`, JSCalendar `keywords` | alle |
| Verweis auf ein Objekt | AS2 `id` (IRI) | alle; zeigt die *kompakte* Component des Ziels |

## Programme

| Programm | Besitzt (Standard) | Nutzt | Facetten (Vorschlag) | Suites | Analysierte Programme (Funktionen) |
|----------|--------------------|-------|----------------------|--------|------------------------------------|
| `fs-people` | `Person` (JSContact `Card`) | groups, files | Contacts, Users, AIs, Partners, Team, Members | Groupware, CRM, Democracy | GNOME Contacts, KAddressBook, Monica, Nextcloud Contacts |
| `fs-groups` | `Group`, Mitgliedschaft (AS2, SCIM) | people | Groups | alle | **keines analysiert** |
| Identity (`fs-identity`) | Konto, Anmeldung (Kanidm-Wrapper) | people | Users (mit people) | alle | **keines analysiert** |
| `fs-vault` | Geheimnis: Passwort, Passkey, TOTP, Schlüssel (CXF, Secret Service) | people, groups | Passwords, Keys | alle | zu recherchieren: 1Password, Apple Passwörter, Bitwarden, KeePassXC (ADR 0067) |
| `fs-messages` | `Message`, Unterhaltung (AS2, JMAP Mail, MIMI) | people, files | Mail, Chat, Assistant, ggf. Forum | Groupware, CRM, Helpdesk | Thunderbird, Element, Telegram, Kontact, Apple Mail, Outlook, Discord, Mastodon |
| `fs-calendars` | `Event` (JSCalendar) | people, maps, resources | Calendar, Booking | Groupware, Projektmanagement | Merkuro, Google Kalender, Nextcloud Calendar, Outlook Calendar, Planner, DAViCal |
| `fs-tasks` | `Task` (JSCalendar, RFC 9253) | people, calendar, groups | To-dos, Tickets | Projektmanagement, Helpdesk | Planka, OpenProject, Taiga, Trello, Wekan, Redmine, Jira, Asana |
| `fs-files` | `Document`, Datei (AS2) | people, groups | Files, Gallery, Music, Videos, Documents | Media, alle | Nautilus, Dolphin, Seafile, Nextcloud Files; Galerie: Immich, PhotoPrism, Lychee, Piwigo |
| `fs-texts` | Text, Seite (eigene Spezifikation, ADR 0031) | files, people | Wiki, Notes | Groupware, Democracy | Wiki.js, MediaWiki, XWiki, Notion, Confluence |
| `fs-maps` | Ort (GeoJSON) | people, calendar | Maps | Groupware | Organic Maps, OsmAnd, uMap, QGIS |
| `fs-activities` | Aktivität (AS2) | alle | Timeline | Projektmanagement | **keines analysiert** |
| `fs-resources` | Ressource, Bedarf (Lücke, eigene Spezifikation) | people, calendar | Inventory, Booking (mit calendar) | ERP, Projektmanagement, Democracy | ERP: Dolibarr, ERPNext, Odoo, Tryton |
| `fs-forms` | `Question`, Abstimmung (AS2, Lücke) | people, groups | Polls, Votes | Democracy, Projektmanagement | Decidim, Polis, LiquidFeedback, Consul, adhocracy+ |
| `fs-draw` | Tafel (Lücke, eigene Spezifikation) | files | Whiteboard | Projektmanagement | Excalidraw, tldraw, draw.io, OpenBoard |
| `fs-broadcast` | Stream (WHIP/WHEP) | files | Studio (Live-Produktion und Live-Schnitt), Live | Media | OBS Studio, Restreamer, MediaMTX |
| `fs-packages` (der Store) | Katalogeintrag, Paket (TUF) | – | Store | – | **keines analysiert** |
| Desktop | – (Startseite, nutzt alle) | alle | Start | – | Homarr, Dashy, Homepage, Heimdall |

Plattform ohne eigenes Frontend: `fs-objects` (Objekte aufbewahren), `fs-registry` (Teilen zwischen Programmen auf einem Gerät), `fs-interfaces` (Verträge), `fs-components` (Components und Stile), `fs-release`, `fs-capnpc`.

### Repo-Schichten des Gerüsts (ADR 0097)

Die Gerüst-Crates sind in Schichten von Repos angeordnet, mit je einem Cargo-Workspace je Repo; Kanten zeigen nur nach unten (ADR 0097, Entscheidung 1, mit dem Nachtrag vom 17.11. zu `fs-access`). Das ist entschieden; die meisten der genannten Crates gibt es noch nicht.

| Schicht | Repos |
|---------|-------|
| 0 | `fs-types` (Werte, Bausätze, Typbeschreibung; auch `fs-conformance`, siehe unten) |
| 1 | `fs-interfaces`, `fs-jscalendar`, `fs-objects` (Speicher), `fs-components` (Anzeige, Hülle, `fs-session`) |
| 2 | `fs-rpc` (`fs-rpc`, `fs-starter`, `fs-connect`, `fs-git`, `fs-backup`, `fs-workflow`) und `fs-access` (SCIM-Provider, OAuth/OIDC; ein eigenes Repo, das unter `fs-rpc` liegt) |
| 3 | `fs-packages` (`fs-update`) |
| Werkzeug | `fs-release` (`fs-blueprint`, ADR 0099) |

`fs-conformance`: ADR 0097 Entscheidung 1 nennt `fs-rpc`; die Strategie hat am 2026-11-17 entschieden, dass es im Workspace von `fs-types` liegt (unterste Schicht, keine Kante nach oben); siehe ADR 0097, Nachtrag 3 (Ort von `fs-conformance`: `fs-types`). Auch der Modul-Vertrag (`fs-module`) ist entschieden: der Trait liegt in `fs-interfaces`, der Laufzeit-Host im Workspace von `fs-rpc` (ADR 0097, Nachtrag 3).

## Suites

| Suite | Programme |
|-------|-----------|
| Groupware | people, messenger, calendar, wiki, maps, files |
| Projektmanagement | tasks, history, resources, surveys, whiteboard, wiki, groups |
| Democracy | surveys, groups, wiki, messenger, tasks, resources |
| Helpdesk | tasks (Tickets), messenger, people, wiki — analysiert: Zammad, osTicket, GLPI, Request Tracker |
| CRM | people (Partners), messenger, tasks, calendar — analysiert: EspoCRM, SuiteCRM, CiviCRM |
| ERP | resources, people, tasks — analysiert: Dolibarr, ERPNext, Odoo |
| Media | files (Gallery), streaming |
| Marktplatz | später |

## Querschnittsziele (Besitzer, 2026-11-09)

1. **Befehlspalette** über alle Programme; die Befehle kommen aus den Typbeschreibungen (gesehen bei Raycast, Linear).
2. **Eingabe in einfacher Sprache** für Termine, Aufgaben und Kontakte („Mittagessen mit Ana Fr 13 Uhr“; Fantastical, Things, Todoist).
3. **Typisierte Notizen:** Ein Tag macht aus einer Notiz einen Datentyp mit Feldern (Tana-Supertags, Frappe-DocTypes; bestätigt ADR 0066).
4. **Screener:** Wer neu ist, erreicht dich erst, nachdem du ihn hereingelassen hast, bei Mail und Chat (HEY).
5. **Anleitungen als Befehle aufgezeichnet** und das **Wiki überall einbettbar** (Tango; siehe Wiki-Anforderungen).
6. **Gemeinsam entscheiden** mit den Verfahren aus den Democracy-Anforderungen (Polis, Loomio, systemisches Konsensieren, wachsender Abstimmungsradius).

## Funktionsvorbilder (geprüft 2026-11-10, Sprint Runde 3)

Programme, deren Macher weiter gedacht haben als der Rest. Wir nehmen Ideen, nie Code oder Aussehen (ADR 0025).

Von Thread F gegen Webquellen geprüft (Sprint Runde 3, 2026-11-10). Die Quellen jedes Programms stehen in dessen `index.md` (verlinkt in der letzten Spalte). ✅ an einer Primärquelle bestätigt · ⚠️ nicht voll bestätigt (ein Suchergebnis, Dritte oder nicht lesbar) · ❌ weg. Korrekturen sind mit **Korrigiert** markiert. In diesem Lauf nicht geprüft: Immich.

| Bereich | Programme und ihre herausragende Idee | Prüfung (2026-11-10) |
|---------|---------------------------------------|----------------------|
| People | Monica: Erinnerungen, „zuletzt gesprochen“, Aktivitäten; ein Tagebuch für Lebensereignisse; v3 für 2026 angekündigt · Google Kontakte: Zusammenführungsvorschläge („Merge & fix“, innerhalb eines Kontos) · **Korrigiert:** Apple Kontakte: NameDrop (iOS 17) | ✅ [people](apps/people/frontends/index.md) · Monica ⚠️ Lebensereignisse (nur README) |
| Mail | HEY: Screener, Imbox/Feed/Paper Trail · Superhuman Mail: Tastatur, geteilter Posteingang (eine geteilte Liste, kein gemeinsamer Posteingang) · Spark: Team-Kommentare zu einer Mail · Fastmail: maskierte Adressen · Delta Chat: Chat über E-Mail | ✅ [messenger](apps/messages/frontends/index.md) · Superhuman ⚠️ **Korrigiert:** Grammarly hat Superhuman Mail 2025 gekauft und die Firma in Superhuman umbenannt (ein Suchergebnis) |
| Chat | Zulip: ein Thema an jeder Nachricht · Signal: keine herausragende Funktion genannt; Protokolldokumente (PQXDH, Double Ratchet) · Telegram: Themen, geplante Nachrichten · Discord: Rollen je Kanal; Drop-in-Sprachräume ⚠️ (nicht geprüft) · Element: Spaces, Bridges | ✅ [messenger](apps/messages/frontends/index.md) · Discord ⚠️ Sprachräume |
| Calendar | Fantastical: Eingabe in einfacher Sprache ⚠️ (Einzelheiten aus einer Anleitung eines Dritten von 2019) · Notion Calendar: Zeitzonen nebeneinander, freie Zeitfenster teilen · Cal.com: Buchungsseiten · Reclaim, Motion: Aufgaben in freie Zeit legen | ✅ [calendar](apps/calendars/frontends/index.md) · Fantastical ⚠️ |
| Tasks | Things 3: Heute / Heute Abend / Irgendwann, Schnelleingabe (⚠️ Kürzel nicht geprüft) · OmniFocus: Perspektiven, Review (v4) · Todoist: Filtersprache · Linear: Triage, Zyklen; ⚠️ „Geschwindigkeit“ nicht geprüft · Taskwarrior: berechnete Dringlichkeit (v3.5.0) | ✅ [tasks](apps/tasks/frontends/index.md) · Linear ⚠️ Geschwindigkeit |
| Files | Dolphin: geteilte Ansicht, Terminal-Panel, Orte · **Korrigiert:** Service-Menüs nur in den KDE-Entwicklerdokumenten, nicht im Handbuch · Finder: Übersicht (Quick Look) · Everything: sofortige Namenssuche (NTFS-Journal, nur Windows) · Dropbox: Dateianfragen (Absender braucht kein Konto) · Seafile: clientseitig verschlüsselte Bibliotheken ⚠️ (nur Desktop-Client; Dateinamen nicht verschlüsselt) · Syncthing: Abgleich von Gerät zu Gerät | ✅ [files](apps/files/frontends/index.md) · Dolphin ⚠️ Service-Menüs · Seafile ⚠️ |
| Gallery | Immich: Suche in einfacher Sprache, Gesichter, Karte, Partner-Teilen (noch nicht geprüft) · Apple Fotos: Duplikate (Album ab macOS Ventura) · **Korrigiert:** Text in Bildern nicht bestätigt (⚠️) | ✅ [gallery](apps/gallery/frontends/index.md) · Immich offen · Apple Fotos ⚠️ Text |
| Wiki, Notizen | Tango: Anleitungen aus Klicks (**Korrigiert:** das Produkt ist tango.ai) · Tana: Supertags mit Vererbung und Tabellenansicht · Obsidian: Rückverweise, Canvas · Logseq: Blockverweise ⚠️ (nur Forenquelle) · Notion: Datenbanken in Seiten | ✅ [wiki](apps/texts/frontends/index.md) · Logseq ⚠️ |
| Maps | Google Earth: 3D-Globus; Projekte (eigene Karten, teilbar), Messen, Höhenprofil (2026) · geführte Touren ⚠️ (nur für den Start 2017 bestätigt) · **Korrigiert:** Street View ist eine Funktion von Google Maps/Earth, kein Programm (Entscheidung offen) · OsmAnd: offline; Höhenlinien nur mit einem kostenpflichtigen Plugin · Organic Maps · uMap · Felt: gemeinsames Live-Bearbeiten | ✅ [maps](apps/maps/frontends/index.md) · Google Earth ⚠️ Touren · OsmAnd ⚠️ Höhenlinien |
| History | Day One: Ort und Wetter, „an diesem Tag“ (seit 2025-09 auch im Web) · ActivityWatch: automatisch, lokal (v0.14.1) · Exist.io: Korrelationen; Dienst noch online | ✅ [history](apps/activities/frontends/index.md) |
| Resources, ERP | ERPNext/Frappe: DocTypes erzeugen Liste und Formular · **Korrigiert:** SAP Fiori ist ein Designsystem, kein Programm (nicht analysiert) · Odoo: verknüpfte Module ⚠️ (indirekter Beleg) · Grocy: Haushaltsvorrat · Snipe-IT: Ausgabe und Rücknahme (Verbrauchsmaterial wird nie zurückgegeben) | ✅ [resources](apps/resources/frontends/index.md) · Odoo ⚠️ |
| Decisions | Polis: aktiv (Commits Nov 2026) · Loomio: aktiv (v3.15.0) · LiquidFeedback: Delegation ✅, **Korrigiert:** kein Release seit Core 4.2.2 (2021), ein Stillstand · Decidim: Beteiligungsräume mit Components (v0.32.2) · Consul: 2.6.1 · die Verfahren von dieBasis sind Verfahren, keine Software (siehe Democracy-Anforderungen) | ✅ [surveys](apps/forms/frontends/index.md) · LiquidFeedback Stillstand |
| Whiteboard | tldraw ⚠️ „Gefühl“ ist subjektiv; Fakten: React-SDK, unendliche Fläche · Excalidraw: handgezeichnet; **Korrigiert:** Ende-zu-Ende-Verschlüsselung nur in der gehosteten App, nicht im npm-Paket · FigJam: Stempel, Timer, Abstimmen mit bis zum Ende verborgenen Stimmen | ✅ [whiteboard](apps/draw/frontends/index.md) · tldraw ⚠️ |
| Streaming | OBS Studio: Szenen · YouTube Studio: Live Control Room, Analysen danach · StreamYard: Gäste im Browser · Ecamm Live: nur Mac ⚠️ (Dritte) · Owncast: ActivityPub · PeerTube: AGPL-3.0, ActivityPub, P2P-Live | ✅ [streaming](apps/broadcast/frontends/index.md) · Ecamm Live ⚠️ |
| Store | F-Droid: Anti-Feature-Kennzeichnung, reproduzierbare Builds · Obtainium: installiert direkt aus Git-Releases · Flathub: verifizierte Herausgeber (Prüfung des App-ID-Besitzes) | ✅ [store](apps/packages/frontends/index.md) |
| Start | Raycast: eine Palette für alles · Alfred: Palette, Workflows (⚠️ „nur macOS“ nicht ausdrücklich genannt) · KDE Plasma: Aktivitäten mit eigenen Favoriten, Widgets, Hintergrund, Fensterregeln; Energie und Panels gelten für alle (informelle Quellen ⚠️) | ✅ [desktop](platform/desktop/frontends/index.md) · Alfred ⚠️ |
| Helpdesk | Chatwoot: alle Kanäle in einem Posteingang, Website-Widget · **Korrigiert:** Zammad hat ein CTI-Anrufprotokoll (Placetel, sipgate, generische CTI-API), kein eigenes SIP; Warnung bei Bearbeitungskonflikt · Help Scout: Kundenleiste | ✅ [helpdesk](apps/helpdesk/frontends/index.md) · Zammad korrigiert |
| CRM | Twenty: eigene Objekte und Felder (Lizenz aus einer Quelle Dritter ⚠️) · Attio: Anreicherung | ✅ [crm](suites/crm/frontends/index.md) · Twenty-Lizenz ⚠️ |
| Workflows | n8n: Knoten-Canvas, Code-Knoten (Zahl der Integrationen uneinheitlich: 400+ gegenüber 1500+) · Huginn: Agenten und Ereignisse · Windmill: Skripte werden zu Formularen, Endpunkten und Jobs · Apple Kurzbefehle: persönliches Gerätewerkzeug · Power Automate: gehostetes Produkt | ✅ [workflows](suites/workflows/frontends/index.md) · n8n-Zahl offen |
| Marketing | Plausible: ohne Cookies, Trichter, Statistik-API · Umami: ohne Cookies, Trichter, Bindung, Verläufe · Listmonk: Newsletter-Verwaltung (AGPL-3.0) | ✅ [marketing](apps/marketing/frontends/index.md) |

## Offene Punkte dieses Entwurfs

1. **Marketing** (analysiert: Matomo, Plausible, Mautic): eigenes Programm mit eigenen Daten oder eine Suite über messenger und people?
2. **Workflows** (analysiert: n8n, Node-RED): ein Programm, das Workflow-Definitionen besitzt (Kandidat für den Standard: CNCF Serverless Workflow, BPMN), oder später?
3. **Helpdesk**: Suite wie oben vorgeschlagen oder eigenes Programm?
4. **Groups, Identity**: noch keine Vorbilder analysiert; Haiku recherchiert Kandidaten. History und Store haben ihre ersten Analysen (2026-11-10).
5. **Stile**: Die ersten vier sind durch die Frontends festgelegt: *Admin* (dicht), *Einfach* (groß), *Apple* (runde Ecken, Glas), *Windows* (flach, Fluent-Abstände). Jeder mit einem eigenen Icon-Satz. Weitere können folgen.
