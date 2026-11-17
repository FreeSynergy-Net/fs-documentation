# Beschlüsse (ADRs)

Nummerierte Entscheidungs-Records. Ein Beschluss ist unänderbar; Änderungen bekommen eine
neue Nummer und ersetzen die alte (Status `superseded by NNNN`).

Format: **Kontext → Entscheidung → Folgen**, plus Verweis auf betroffene Doku.

| Nr. | Titel | Status |
|-----|-------|--------|
| 0001 | Sechs Ebenen und Namen | akzeptiert |
| 0002 | Sprache: Identifikatoren englisch, Prosa deutsch | teilweise ersetzt durch 0011 |
| 0003 | Repo-Schale und Skript-Schattenbaum | akzeptiert |
| 0004 | Komponenten-Einteilung primitives/widgets/workbenches | akzeptiert |
| 0005 | App und Widget: derselbe Kern, unterschiedliche Ebene | akzeptiert |
| 0006 | Haken, Abbruchkriterium, Pflichtmenge pro Kategorie | teilweise ersetzt durch 0013 |
| 0007 | `skins/` wird `masks/` | superseded by 0012 |
| 0008 | Englisch zuerst, Deutsch zweite Sprache | superseded by 0011 |
| 0009 | GUI: Blinc ist gesetzt | akzeptiert |
| 0010 | Ein Prüfer für die Übersetzung: `scripts/doc_sync.py` | akzeptiert |
| 0011 | Nur Englisch wird gepflegt, Deutsch wird übersetzt | akzeptiert |
| 0012 | `masks/` wird `frontends/`, mit Versionsordner | akzeptiert |
| 0013 | Funktionen analysieren, nichts kopieren; Programme nach Ideen | akzeptiert |
| 0014 | Standards zuerst, ActivityStreams 2.0 als Basis | akzeptiert |
| 0015 | Fremdprojekte, die wir nutzen und unterstützen; Crate-Regel | akzeptiert |
| 0016 | Lizenz: MIT OR Apache-2.0, für immer kostenlos | akzeptiert |
| 0017 | Programme heißen nach Kategorie, ein Repo pro Programm | akzeptiert |
| 0018 | Messenger umfasst E-Mail und Chats; nur verschlüsselt; Backend-Stufenplan | akzeptiert; Nachtrag 17.11. |
| 0019 | Datenhaltung: `fs-store` je Programm, `fs-hub` je Gerät | akzeptiert |
| 0020 | Speicherformat: AS2-Hülle + Fachstandard + Protokoll; Leihen = Live-Verweis | akzeptiert |
| 0021 | Schnittstelle: ein Vertrag (Cap'n Proto), viele Zugänge | akzeptiert; Nachtrag 17.11. |
| 0022 | Zwei Referenz-Frontends je Programm | superseded by 0038 |
| 0023 | Darstellungs-Register; Code- und Block-Editor | Punkt 4 ersetzt durch 0039 |
| 0024 | Programm ohne Hub, Verschlüsselung, Schlüsseltresor, SCIM | akzeptiert |
| 0025 | Abschauen nur im äußersten Notfall, nie bei Closed Source | akzeptiert |
| 0026 | Immer die neueste Technik | akzeptiert |
| 0027 | IDs: UUIDv7 (RFC 9562) | akzeptiert |
| 0028 | Namen, Domains, Erreichbarkeit über den Hub (`freesynergy.net`) | akzeptiert (Technik: Vorschlag) |
| 0029 | Schutzbedürftige Daten müssen gekennzeichnet werden | akzeptiert (Form: Vorschlag) |
| 0030 | Original + Hülle: Empfangenes unverändert aufbewahren | akzeptiert |
| 0031 | Jeder Text ist ein Wiki-Eintrag; Bibliothek; Hilfe dort, wo man ist | akzeptiert (Standards offen) |
| 0032 | name-Regel; Beschlossenes bleibt | akzeptiert |
| 0033 | Markieren: ein Mechanismus (Punkt = einsetzen, Bereich = ersetzen/benennen) | akzeptiert |
| 0034 | Textstruktur technisch: Absatz, Seite, Kollektion, Regal | akzeptiert |
| 0035 | Föderation zwischen Instanzen: OpenID Federation 1.0 | akzeptiert |
| 0036 | Git als dezentrale Verteilung (gix): Pakete, Themes, Programme, Medien | akzeptiert |
| 0037 | Jedes Programm ist mindestens eine Workbench; Programme zeigen sich gegenseitig an | akzeptiert |
| 0038 | Referenz-Frontends: vier Arten, am besten ganze Suiten | akzeptiert |
| 0039 | Drei Text-Editoren | akzeptiert |
| 0040 | Cap'n-Proto-Schema-Compiler in reinem Rust; Anerkennung ohne Drama | akzeptiert |
| 0041 | Rust-Hygiene: Build-Ausgabe klein, nie in Git, regelmäßig aufräumen | akzeptiert |
| 0042 | Text + Ebenen; Datenbank ist die Wahrheit, Dateien sind Exporte; begrenztes dauerhaftes Rückgängig | akzeptiert |
| 0043 | Entwurfsmuster, Schnittstellen zuerst, kleine Dateien, Refactoring, Doku | akzeptiert |
| 0044 | Weitere Programme: Files, Kanban, Surveys, Gallery, Whiteboard, Streaming | überholt durch 0049 |
| 0045 | Jedes Thema eine Schnittstelle; Schnittstellen sind Ziele; Hot-Plugins | akzeptiert (Form der Plugins entschieden; Nachtrag 17.11.) |
| 0046 | Speichern ist nicht Exportieren | akzeptiert (Details: Vorschlag) |
| 0047 | Kanidm hinter eigenem Wrapper | akzeptiert (ergänzt 0024) |
| 0048 | Codecs ausgelagert, offene Codecs zuerst | akzeptiert |
| 0049 | Gesamtplan: Programme nach Zweck, Workbench und Suite | akzeptiert |
| 0050 | Ein Standard, ein Programm, eine Schnittstelle; `fs-contacts` heißt `fs-people` | akzeptiert (Abgrenzung: Vorschlag) |
| 0051 | Releases: `fs-release`, nur kostenlose Wege, offene Signatur | akzeptiert |
| 0052 | Eine Person mit Rollen; Rollen standardisiert oder selbst definiert; Vertrauen sichtbar machen | akzeptiert |
| 0053 | LLM-Chat als Component und Programm; Übersetzung vorerst nicht; Projektadresse | akzeptiert |
| 0054 | KIs sind markierte Teilnehmer; der Assistent ist ein Messenger-Frontend | akzeptiert (Aussperren: vorerst bestätigt; Identität offen; Nachtrag 16.11.; Nachtrag 17.11.; Nachtrag 17.11. (2) KI-Einladung, Entwurf; Nachtrag 17.11. im Auftrag (3), Entwurf) |
| 0055 | Sprechende Namen statt IDs; `fs-groups` ist die Quelle der Wahrheit für Gruppen | akzeptiert |
| 0056 | Oberster Admin; Agenten werden nie Admin; Workbench gibt Kontext; Kanidm flach | akzeptiert |
| 0057 | Was ein Mensch liest, ist übersetzbar; Bibliothek `mf2` | akzeptiert; Nachtrag 17.11. Einstellungen (Entwurf) |
| 0058 | Kontakte sind Profile; Verknüpfen nur nach Rückfrage | akzeptiert |
| 0059 | Verbinden ohne Server: jeder Client ist ein Knoten, iroh als Kandidat | Richtung akzeptiert, nichts gebaut |
| 0060 | Die Datenablage heißt `fs-objects`; `fs-store` wird der Laden | akzeptiert, Umbau nach dem Sprint |
| 0061 | Facetten: ein Programm, mehrere Apps; jedes mit Admin-Frontend | akzeptiert |
| 0062 | Pakete liegen in Git: Katalog-Repo, ein Tag je Version, TUF, Spiegel überall | akzeptiert |
| 0063 | Ein Programm, ein Befehl: `fs-<programm>` mit Unterbefehlen; Facetten als Link `fs-<facette>` | akzeptiert |
| 0064 | Versionsnummern beginnen bei 0.0.1; 0.1.0 erst nach Handtest | akzeptiert |
| 0065 | Ein Standard für jedes Fenster: Menü, Version, Hilfe, Meldungen | akzeptiert im Grundsatz; Nachtrag 17.11. Einstellungen (Entwurf) |
| 0066 | Datentypen mit festen Components, vier Frontends je Programm | akzeptiert |
| 0067 | Tresor `fs-vault`; Server hält nur Verschlüsseltes, Gruppenschlüssel (MLS), Suche auf dem Gerät | akzeptiert |
| 0068 | Fähigkeiten statt fester Anforderungen (provides/requires); fremde Pakete gespiegelt samt Quellcode; `catalog.freesynergy.net` | akzeptiert |
| 0069 | Update schließt ein laufendes Programm und startet es am selben Punkt neu (Sitzungsdatei, automatisches Speichern, Klon, `suspend_and_exit()`; Nachtrag 17.11.: Selbst-Update jedes Programms, typisierte Sitzung `session.toml`, `UpdateMode`, Ruhe-Regel, Rollback) | akzeptiert (Strategie); F1 entschieden (Nutzer, ja); Nachträge 17.11. (Selbst-Update; Namen fs-session/fs-update, Reihenfolge) |
| 0070 | Thema `storage`: ein Baum für alles, worauf man Zugriff hat (`StorageProvider` neben `BlobBackend`) | akzeptiert (Strategie); Code erst nach 3b grün |
| 0071 | Versionen, Git und Backup in Files (drei Schichten; `versions` aus 0070 erweitert; Ergänzung 2026-11-12: Platz-Profile, Backup-Ziele, Git-Nebenfenster, Backup in jedem Programm) | akzeptiert (Strategie); Code erst nach 3b und Wiki/Groups; Nachtrag 17.11. |
| 0072 | Blöcke als Quelle für Texte: Handbuch im Wiki, Store-Beschreibung und Hilfe daraus; Kopie im Paket | akzeptiert (Strategie); Code nach 3b und Wiki |
| 0073 | Kollaboration überall mit Loro (Awareness, AS2-Änderungsstrom, Rechte vor Import, „wirklich löschen“; Nachtrag 16.11.: Wahrheit in typisierten Tabellen nach 0086, Loro nur Abgleichs-Puffer für Fließtext, Tabelle `collab_buffer` als dritte Blob-Ausnahme) | Entwurf; Nachtrag 16.11. |
| 0074 | Stil, Bausteine, Bewegung, Klang und Menüs: getrennte Schichten aus Standards | akzeptiert (Gründer); Code nach dem Meilenstein „Wir benutzen es selbst“; Nachtrag 17.11. Einstellungen (Entwurf) |
| 0075 | fs-marketplace als Programm, der Store als Facette | akzeptiert (Gründer); Code nach dem Meilenstein „Wir benutzen es selbst“ |
| 0076 | Das Grundmodell: Akteure, Ressourcen, Orte, Zeit, Ziele, Abläufe, Ereignisse | akzeptiert (Gründer); fs-history heißt seit ADR 0087 fs-activity |
| 0077 | Katalog-Arten (`kind`) und Store-Gruppen; Server nur mit rpm/deb | akzeptiert (Strategie); Nutzerregel: alle Server in den Katalog, überall installierbar (Nachtrag 16.11.: font) |
| 0078 | Paketquellen apt/dnf: ein Repo `fs-packages`, getrennt vom Katalog | akzeptiert (Strategie) |
| 0079 | `fs-server`: Server einrichten und verwalten, jeder Schritt protokolliert | akzeptiert (Strategie); Nutzerentscheidung 14.11. |
| 0080 | Umzug fs-wiki → fs-text: Repo, Crates, Version, Daten, Katalog | akzeptiert (Strategie); Nutzer-JA zu Umbenennung/Löschen und „Projekt“ |
| 0081 | CI-Ereignisse (CloudEvents) ≠ Programm-Ereignisse (AS2, fs-history); Pull ohne Token, Rot-Issues | akzeptiert (Strategie, 2026-11-14); fs-history heißt seit ADR 0087 fs-activity |
| 0082 | `fs-server` verbindet: Konfiguration von außen, Anbindungen an Server | akzeptiert (Strategie, 2026-11-14; Nutzerentscheidung Vermittler + People/Groups mit Kanidm; Nachträge 16.11.) |
| 0083 | Website-Veröffentlichung aus fs-text (Arbeitstitel) | reserviert (kein Dokument) |
| 0084 | Editor-Bausteine: ein Vertrag (`TextEditor`, nur Änderungs-Operationen), Umsetzungen Block/RichText/Markdown, gemeinsame Konformitätssammlung | akzeptiert (Strategie, 2026-11-14; Nutzerentscheidung: mehrere Editor-Bausteine, Daten nur über unser Modell) |
| 0085 | Normalisierung an der Grenze: Zeiten (UTC plus IANA-Zonen-Id, Datum ohne Uhrzeit), Verweis `PersonRef` auf Profil, Person, Gruppe oder Organisation (mit eingefrorenem Abzug), schwebende Zeit `Floating`, Herkunft `Origin`, Importer/Exporter als Grenz-Adapter | akzeptiert (Nutzerregeln 2026-11-14; Abschluss Strategie 2026-11-16) |
| 0086 | Gespeichert wird typisiert: Fachstandards in typisierte Tabellen, kein JSON/Blob; nur Empfangenes behält sein Original mit Aufbewahrungsregel; Nachtrag 16.11.: Ausnahme 3, eng (`collab_buffer.loro`); Nachtrag 16.11.: Wortlisten als eigene Wort-Tabellen statt `CHECK IN`; Nachtrag 17.11. [Entwurf]: v5 vorgezogen, vor dem Beweis-Programm | akzeptiert (Nutzer, 2026-11-15) |
| 0087 | Programmnamen sind generisch (Fähigkeit/Daten, nicht Gattung); wiki→text, whiteboard→draw, messenger→messages, history→activity, streaming→broadcast, surveys→forms, store→software, hub→registry; resources bleibt (Nachtrag 16.11.: ValueFlows, Katalog ist Gruppierung und Filter, Daten-Repo fs-catalog → `FreeSynergy/Catalog`; Nachtrag 16.11.: Einzahl/Mehrzahl, Daten-Repos, Liste der Umbenennungen; Nachtrag 16.11.: fs-decisions für Beschlüsse und Abstimmungen, Terminfindung als Facette, Bibliotheken fs-tally/fs-ballot; Nachtrag 17.11.: fs-forms = Frontend-Baukasten, decisions = alle Fragen, fs-scaffold, fs-checkin; Nachtrag 17.11. (3): Workflows mit Bedingungen, Schleifen und Funktionen in v1, ändert Punkt 12, `fs-flow`) | akzeptiert (Nutzer, 2026-11-15; Nachträge 15.11. und 16.11.); Nachtrag 17.11. Entwurf (Nutzervorgabe); Nachtrag 17.11. (2) Entscheid 118–120 und Datenbausätze (Nutzer); Nachtrag 17.11. (3) Workflow v1 (Strategie-Entscheid, laut b7); Nachtrag 17.11. (klein) KI-Einladung als Modus (Entwurf) |
| 0088 | Web-Zugang der Programme und automatisches DNS (Arbeitstitel) | reserviert (kein Dokument) |
| 0089 | Schriften: freie Lizenzen, keine Schrift im Release, Installation über fs-software | akzeptiert (Nutzer, 2026-11-16) |
| 0090 | Einzelplatz-Modus: Besitzer ohne Konto | Entwurf (Strategie, 2026-11-16) |
| 0091 | KI-Stellvertreter-Bot: die KI hat keine Rechte, der Bot ist ihr einziger Weg | Entwurf (Strategie, 2026-11-16; Entscheidungen 2.6.1 bis 2.6.11; Nachtrag 17.11.; Nachtrag 17.11. im Auftrag (3), Entwurf) |
| 0092 | Bibliotheks-Repos bilden einen gerichteten Graphen (kein Kreis, ein Lock je Bibliothek eine Quelle); RPC-Laufzeit zieht aus fs-interfaces in das neue Repo fs-rpc | akzeptiert (Strategie, 2026-11-16; Variante V2) |
| 0093 | fs-types ist die unterste Bibliothek: eigenes Repo mit `types.capnp`, Wertobjekten und Typbeschreibung (Server nach fs-rpc); Repo-DAG fs-types → fs-interfaces/fs-objects/fs-jscalendar/fs-components → fs-rpc → Programme | akzeptiert (Strategie, 2026-11-16; V1+, Opus-Review 9b1ba986; Nachtrag 17.11.) |
| 0094 | Frontend-Paket: Manifest (AppStream `addon`), Fundort, `requires`/`extends`, Laden durch das Programm (Starter, Handshake, Fallback), Installation/Update über fs-packages | Entwurf (Strategie, 2026-11-16; Entscheidungen b7 O1 bis O3, O4 offen; Nachtrag 17.11.; Änderung 17.11. Frontend-Wahl als Einstellung) |
| 0095 | Eigentümer von Gruppen und drei Verwaltungsstufen | akzeptiert (Nutzer, 2026-11-17) |
| 0096 | Format und Host (Arbeitstitel) | reserviert (kein Dokument) |
| 0097 | Standardgerüst, Module und Arbeitsweise: Programme werden zusammengesteckt | akzeptiert (Nutzer, 2026-11-17; Nachträge: Gespräch 2, fs-access, fs-conformance/Vorhandenes zuerst 17.11.) |
| 0098 | Datenbausätze: einmal beschrieben, überall gleich, überall vollständig | akzeptiert (2026-11-17) |
| 0099 | Bauplan (`scaffold.toml`) und zwei Rollen: Bau-Werkzeug für das Projekt, fs-scaffold für Instanzen | akzeptiert (2026-11-17) |
| 0100 | Einstellungen als eigene Schnittstelle: Vertrag `settings`, Bibliothek `fs-settings`, Programm `fs-settings` | akzeptiert (2026-11-17; nach Fixpunkt `setting_v1`, Probe fs-settings; Nachtrag 17.11. [Entwurf]: Speicher ist die Datenbank (Domäne `settings`, Port in fs-settings), L5/L6/L7 entfallen; noch nicht gebaut: L1 coded_stub, L2 Windows-CI, L3 KI-Satz in lib.rs, L8 Texte, `profile_v1`, Programm fs-settings) |
