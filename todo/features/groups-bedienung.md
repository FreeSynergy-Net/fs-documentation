# Feature-Liste fs-groups (Workflow feature-liste, Sonnet, 2026-11-17)

Anlass (Nutzer, hoch): "fs-groups ist völlig unbrauchbar, hat nicht eine Sache, die die Vorbilder haben". Entwurf, nicht gepusht; Feature-Freeze: offen (Nutzer). ADR 0013: nur Konzepte gelesen, nichts kopiert. Ergänzt (ersetzt nicht) fs-documentation `todo/features/groups.md` (Auftrag 27, 145 Zeilen, Spezifikationsebene: Gruppentypen, Türsteher, SCIM, Spiegel). Hier neu: Bedienung (Ansichten, Abläufe, Menüs), damit das FENSTER nutzbar wird.

## 0. Stand heute (ehrlich)
- Fenster `fs-groups-app` (Dossier-Hilfe docs/de/help/groups/*): Liste (Spalten Name/Art, Suche, "New", "Show more"), rechts Seite der Gruppe (Details: Art; "Part of"; "Members" mit Rolle, nur Lesen), Edit (Name, Art), Delete, Save/Cancel mit Verwerfen-Frage. Keine Pfeiltasten in der Liste, keine eigenen Kürzel, keine Menüleiste, kein Kontextmenü.
- Das Fenster sagt selbst: kein Mitglied hinzufügen/entfernen, nicht verschachteln, keine Eltern-Anfrage, keine Einladung, keine Rechte, keine Beitrittsanfragen.
- Kern (nur Programm, nicht im Fenster; belegt gegen main v0.0.2, 43b9d68b): Verschachtelung (mehrere Eltern, Kreis = benannter Fehler `Cycle`, Anfrage/Zustimmung `request_parent/approve_parent/decline_parent/parent_requests/remove_parent`, `ancestors/descendants`), Mitglieder `Memberships` (direct/add/remove/effective/groups_of/is_member), Rolle = opake Zeichenkette (leer = einfaches Mitglied; `in_force=false` bei KI auf Verwalterrolle, ADR 0056), wirksame Mitgliedschaft `EffectiveMember{person, via: Pfad}`, Einladungen (list/invite/accept/accept_proved/decline/revoke/expire_due; Einladender = IRI oder E-Mail, Rolle, Ablauf), Delegation (grant/revoke/may_do, nur Auskunft), Spiegel nach Kanidm (GroupDirectory, Option B, vorläufig), Feed `subscribe`, Follows/Quellen, Server (Unix-Socket, kein Authentifizierter Aufrufer). Ein Mitglied kann auch eine Gruppe sein (`Member::Group`).
- Vererbungs-Modus im Kern: NUR `RightFlow` je GRUPPE (None | Down | Up, Vorgabe None) fuer Rechte; BottomUp/TopDown/Einzeln je Kante (ADR 0082) ist nicht im Kern. Die Mitgliedschaft laeuft immer durch die Verschachtelung (wirksam mit Pfad).
- Fenster (`crates/fs-groups-app`, 797 Zeilen, nur Verdrahtung): kein eigenes Fenster, sondern die Listen-und-Seiten-Werkbank `PeopleWidget` aus fs-components-workbenches (gebaut fuer Personen) ueber einen Adapter `GroupsAdapter` (`PeopleSource`). Die Schnittstelle des Fensters `GroupsApi` hat NUR: list, get, create, rename, set_kind, delete, members (direkt). Es gibt also im Fenster-Code weder Aufruf fuer Mitglied hinzufuegen/entfernen, Untergruppen/Kinder, Eltern einhaengen/Anfrage, wirksame Mitglieder, Einladungen noch Rollen setzen; kein Menue-, Symbolleisten-, Kontextmenue- oder Tastaturcode in fs-groups (alles, was die Werkbank an Knoepfen/Tasten mitbringt, liegt in fs-components-workbenches, dort nicht geprueft). Sicht: Liste Name/Art + Suche; Seite: Abschnitt Details (Art), "Part of" (Namen der Eltern), "Members" (nur DIREKTE Mitglieder, Rolle als Beschriftung, leer = "Member"; Gruppen als Mitglied mit Namen); Formular Name+Art (freier Text, Name Pflicht); Anlegen/Bearbeiten/Loeschen. Kein Beschreibungsfeld, keine Revision (Aenderung durch andere wird beim Speichern nicht erkannt), kein Live-Feed (Fenster liest neu), kein Timeout beim Server-Warten. Hinweis: `fs-groups-people` (Crate) bindet nur die KI-Kennzeichnung aus dem People-Rollenbuch an den Kern, keine Personenauswahl fuer das Fenster.
- NICHT im Kern (anders als Zeile 9 der Liste vermuten laesst): "letzter Verwalter geschuetzt" (kein Treffer fuer LastAdmin/last admin im Kern) und Eigentuemer-Uebertragung; Rollen sind opak, es gibt keine Rollenliste (Member/Verwalter/...) im Kern. Beides muss im Kern ZUERST kommen (Stufe 1, Punkt 2). Ebenso fehlt: Beitrittsanfragen/Tuerste­her, Aufnahme-Regel, Sichtbarkeit.
- Kernaussage: fast alles, was Vorbilder im Alltag tun, existiert im Kern, ist aber nicht bedienbar. Das ist der Hauptbefund.

## 1. Vorbilder und Quellen (offiziell, abgerufen 2026-11-17)
| Kürzel | Vorbild | Quelle |
|---|---|---|
| KC | Keycloak (Admin-Konsole) | https://www.keycloak.org/docs/latest/server_admin/index.html (Abschnitt "Groups", Teil gelesen; Abschnitt "Managing groups" war im abgerufenen Ausschnitt nicht erreichbar) |
| NC | Nextcloud Benutzer + Teams (früher Circles) | https://docs.nextcloud.com/server/latest/admin_manual/configuration_user/user_configuration.html ; https://docs.nextcloud.com/server/latest/user_manual/en/groupware/contacts.html |
| EN | Microsoft Entra ID Gruppen | https://learn.microsoft.com/en-us/entra/fundamentals/how-to-manage-groups |
| GW | Google Workspace Gruppen (Admin-Konsole) + Groups | https://knowledge.workspace.google.com/admin/groups/create-a-group-in-your-organization ; Dossier todo/features/groups.md (support.google.com/groups/answer/2464926) |
| GH | GitHub Teams | https://docs.github.com/en/organizations/organizing-members-into-teams/about-teams |
| KD | Kanidm (CLI, Spiegel-Partner) | https://kanidm.github.io/kanidm/stable/accounts/groups.html ; Dossier research/kanidm-control.md (Tabelle Z.137-152) ; ADR 0047/0056/0082 |
Eigene Dossiers: ADR 0082 (Modi BottomUp/TopDown/Single), ADR 0055/0056 (Rechtefluss, Spiegel Option B), ADR 0054 (KI-Regel), todo/features/groups.md, interne Personen-Plan-Unterlagen (Personenverweis, betreute Konten), docs/de/components/widgets/navigation/{toolbar,sidebar,menu}.
Nicht belegt (Seite nicht lesbar): Helfa-Oberfläche (nur als Modell BottomUp im ADR), Authentik/Authelia (in früherem Lauf 404), Discourse, Matrix-Räume-Oberfläche. Kanidm hat laut Dossier keine Gruppen-Maske für Verwaltung; Web-UI-Belege fehlen: [nicht belegt].

## 2. Ansichten und Abläufe je Vorbild (nur Belegtes)
- KC: Linkes Menü "Groups"; Baumansicht Gruppe/Untergruppen; "Create group" innerhalb der Elterngruppe, danach Klick auf den Namen öffnet die Verwaltungsseite; Reiter u. a. "Members" (Mitglieder); Mitglied aufnehmen auch vom Benutzer aus (Users > Reiter "Groups" > "Join Group" > Dialog/Baum "Available Groups"); "Leave" in der Tabellenzeile; Pfad `/top/level1/level2`; Attribute und Rollenzuordnung der Gruppe werden an Untergruppen und Mitglieder vererbt; "Default groups" für neue Benutzer. Weitere Reiter (Attributes, Role mapping, Permissions) laut Inhaltsverzeichnis, Bedienung [nicht belegt].
- NC: Benutzerverwaltung: linke Spalte Gruppenfilter + "Add Group" oben, Zahnrad unten links (Einstellungen), Abschnitt "disabled"; Spalte "Group Admin" (Dropdown); Zeile mit "…"-Menü (Disable/Enable/Delete, Undo kurz); Stift zum Bearbeiten von Feldern; Gruppen beim Anlegen eines Benutzers wählbar/neu. Teams: "+" neben "Teams" im linken Menü, Name; Konfigurationsseite mit Mitgliedern, Drei-Punkte-Menü je Person = Rolle ändern; einladen: Konten, Gruppen, E-Mail-Adressen, andere Teams; Rollen Member < Moderator < Admin < Owner (genau ein Owner, Übertragung); Optionen: Einladungen/Mitgliedschaft, Sichtbarkeit, Team in Team erlauben, Passwortschutz (Namen belegt, Bedeutung [nicht belegt]). Gruppen löschen: [nicht belegt].
- EN: Entra ID > Groups > All groups; Symbolleiste "New group"; Felder: Group type (Security/Microsoft 365), Name (Namensprüfung, kein Leerzeichen am Anfang), E-Mail (nur M365), Beschreibung, "Microsoft Entra roles can be assigned" (Ja/Nein), Membership type (Assigned/Dynamic u. a.), Owners, Members (Auswahl-Dialog, "Select"), "Create". Gruppenseite: Seitenmenü mit Overview, Members, Owners, Properties, Group memberships; "+ Add", Haken + "Remove"; Properties: Name, Beschreibung, Membership type (Gruppentyp nach dem Anlegen nicht änderbar: löschen und neu), Object ID kopieren; Verschachteln: Group memberships > "+ Add memberships" (nur Sicherheitsgruppen, Einschränkungen belegt), Entfernen über "Remove"; "Delete"; Massenaufnahme "bulk" belegt (Verweis).
- GW: Menü > Verzeichnis > Gruppen; "Create group" oben; Felder Name (73 Zeichen), E-Mail (63), Beschreibung, Besitzer, Sicherheitslabel; Zugriffstyp Public/Team/Announcement only/Restricted (Voreinstellungen, bei Einzeländerung "Custom"); "Wer darf beitreten" (Antrag / direkt / nur eingeladen); "Wer sieht Mitglieder"; externe Mitglieder; "Restrict membership" (Bedingung); Rollen Owner/Manager/Member; Mitglieder: "Add members", Auswahl aus Liste, CSV hochladen, andere Gruppen, alle Nutzer; Gruppe in Gruppe.
- GH: Teams in mehreren Ebenen (Kind hat genau einen Eltern; erbt Repository-Rechte; Erwähnung des Elternteams benachrichtigt Kinder); Rollen Owner der Organisation / Team-Maintainer / Mitglied; Sichtbarkeit "Visible" / "Secret" (Secret kann nicht verschachtelt werden); Team nach Verwendung: Review-Anfragen, CODEOWNERS; IdP-Sync (Enterprise); Seiten "Create team", "Add members", "Move team in hierarchy" (Inhalt [nicht belegt]); Beitrittsanfragen [nicht belegt].
- KD (CLI): `group create <Name> [entry_managed_by]`, `add-members`, `list-members`, Gruppe in Gruppe, `entry_managed_by` nur bei Anlegen durch group_admins, später nur access_control_admins; `person get` zeigt memberof; POSIX: `group posix` (Dossier); Konto-Richtlinie je Gruppe (Dossier).

## 3. VOLLSTÄNDIGE Feature-Liste (Bedienung)
Stufen: heute = im Fenster nutzbar | als Nächstes | später. "Kern" = im Programm vorhanden, Fenster fehlt (zählt NICHT als heute). Vorbilder: KC NC EN GW GH KD.
| # | Funktion | Stufe | Vorbilder |
|---|---|---|---|
| 1 | Liste mit Suche, Spalten Name/Art | heute | alle |
| 2 | Gruppe anlegen (Name, Art) | heute | alle |
| 3 | Umbenennen, Art ändern, Beschreibung | heute (Beschreibung: später) | KC NC EN GW |
| 4 | Gruppe löschen mit Frage | heute | KC EN GW NC |
| 5 | Mitglieder der Gruppe als Liste mit Rolle (lesen) | heute | alle |
| 6 | Mitglied hinzufügen (Person wählen, Auswahldialog mit Suche, Mehrfachwahl) | als Nächstes (Kern) | KC NC EN GW KD |
| 7 | Mitglied entfernen (Haken + "Entfernen", Zeilenmenü) | als Nächstes (Kern) | KC NC EN GW KD |
| 8 | Rolle je Mitglied ändern (Member/Manager/Owner o. ä.) | als Nächstes (Kern: Rolle opak) | NC EN GW GH |
| 9 | Letzter Verwalter geschützt, Verwalter ernennen/Eigentümer übertragen | als Nächstes (Kern: fehlt noch, zuerst dort) | NC GW |
| 10 | Von Person aus: "Gruppen" der Person, beitreten/verlassen | später (fs-people) | KC NC EN |
| 11 | Untergruppen anzeigen (Baum, Pfad "Eltern > Kind") | als Nächstes (Kern) | KC GH EN KD |
| 12 | Gruppe unter Eltern einhängen / aus Eltern lösen; Anfrage an Eltern, Zustimmung, Ablehnen | als Nächstes (Kern) | EN GW GH NC KD |
| 13 | Verschachtelung: Kreis wird mit Pfad abgelehnt (Meldung zeigen) | als Nächstes (Kern) | EN KD |
| 14 | Wirksame Mitglieder "direkt / geerbt aus X" (Spalte "Herkunft") | als Nächstes (Kern) | KD KC |
| 15 | Vorschau vor dem Einhängen ("+N Personen") | später | (eigen) |
| 16 | Modus je Kante BottomUp/TopDown/Einzeln, Vorgabe je Baum (ADR 0082) | später (Kern: Rechtefluss vorläufig) | (eigen; Kanidm/Helfa) |
| 17 | Einladung: Person oder E-Mail, Ablauf, widerrufen, Liste offener Einladungen | als Nächstes (Kern) | NC GW KD(CLI nicht) |
| 18 | Beitrittsanfragen: Liste für Verwalter, annehmen/ablehnen | später (Türsteher fehlt im Kern) | GW GH(nicht belegt) |
| 19 | Aufnahme-Regel je Gruppe: offen / auf Antrag / nur eingeladen | später | GW |
| 20 | Sichtbarkeit: Mitglieder sehen / Gruppe geheim | später | GW GH NC |
| 21 | Rechte (Delegation) vergeben/entziehen/anzeigen | später (Kern, nicht erzwungen) | KD KC GW |
| 22 | Rollenvererbung an Untergruppen, Rollen-Baum | später | KC |
| 23 | Einladungs-Link/QR mit Ablauf und Grenze | später | (eigen Plan) |
| 24 | Massenaufnahme: Liste/CSV einfügen, alle aus Gruppe X | später | EN GW |
| 25 | Papierkorb, Wiederherstellen; Archivieren | später | NC(Undo) |
| 26 | Rückgängig-Hinweis nach Löschen (Undo kurz) | später | NC |
| 27 | Beschreibung, Gruppenadresse (Mail) | später | GW EN KD |
| 28 | Spiegel-Zustand nach Kanidm: Trockenlauf, Abweichungen | später (Kern) | KD |
| 29 | Protokoll je Gruppe, Auskunft über sich | später | EN(Audit) |
| 30 | Nur-meine-Gruppen-Filter, Sortierung, Spaltenwahl | als Nächstes | NC EN GW |
| 31 | Tastatur: Pfeile in der Liste, Entf, Strg+N, F2 | als Nächstes | (Standard) |
| 32 | Export/Import (vCard KIND:group, LDIF) | später | (Standards) |
| 33 | Standard-Gruppen für neue Personen ("default groups") | später | KC |
| 34 | KI-Konten nur in KI-Gruppen, nie Verwalter (sichtbar kennzeichnen) | als Nächstes (Kern: AgentNotAdmin) | ADR 0054, (eigen) |
| 35 | Dynamische Gruppen (Regel) | später, offen ob gewollt | EN KD(Schema, kein Verwaltungsweg) |

## 4. Menübäume (nur Belegtes; Rest "[nicht belegt]")
Keines der Vorbilder hat in den offiziellen Texten eine klassische Menüleiste mit Kürzeln: es sind Web-Konsolen mit Seitenmenü + Symbolleiste. Belegbar:
- KC: Seitenmenü "Groups" > Baum; Tabelle mit Zeilenmenü (belegt: "Leave"); Dialog "Join Group". Kürzel, Kontextmenü, Trenner: [nicht belegt].
- NC: Links: Gruppenfilter, "Add Group"; Zahnrad (Einstellungen: Quota, Spalten); Zeile: "…" = Disable/Enable/Delete; Stift an Feldern. Team: "+", Drei-Punkte je Person = Rolle ändern. Kürzel: [nicht belegt].
- EN: Seitenmenü Gruppe: Overview, Members, Owners, Properties, Group memberships; Symbolleiste: "New group", "+ Add", "Remove", "Delete", "+ Add memberships". Reihenfolge der Seitenmenü-Einträge unvollständig belegt.
- GW: Menü > Verzeichnis > Gruppen; oben "Create group"; "Add members". Rest [nicht belegt].
- GH: Menüs nicht belegt (nur Seiten-Titel).
- KD: nur Befehle (siehe 2).
Gemeinsames Muster daraus: (a) Liste links/oben mit Suche; (b) Gruppenseite mit Reitern Mitglieder / Untergruppen / Eigenschaften / Rechte; (c) Aktion "+ Hinzufügen" öffnet Auswahldialog mit Suche; (d) Zeilenmenü "…"; (e) Mitglieder: Haken + "Entfernen".

### VORSCHLAG Menübaum fs-groups (eigenes Konzept, Standards: ADR 0074; Namen = Verben/Funktion)
Hauptmenüs (Reihenfolge): Gruppe | Mitglieder | Struktur | Ansicht | Hilfe
- Gruppe: Neue Gruppe… (Strg+N) | Neue Untergruppe… (Strg+Umschalt+N) | Trenner | Umbenennen (F2) | Eigenschaften… (Alt+Enter) | Trenner | Löschen… (Entf) | Trenner | Schließen (Strg+W)
- Mitglieder: Person hinzufügen… (Strg+M) | Person einladen… (Strg+I) | Entfernen (Strg+Entf) | Trenner | Rolle ändern > (Untermenü, Radio: Mitglied/Verwalter/…) | Verwalter ernennen | Trenner | Beitrittsanfragen… | Offene Einladungen…
- Struktur: Unter Gruppe einhängen… | Aus Gruppe lösen | Trenner | Anfragen der Eltern… | Modus > (Radio: Mitglieder nach oben / Rechte nach oben / nur Ordnung) | Trenner | Rechte vergeben…
- Ansicht: Baum / Liste (Radio) | Nur meine Gruppen (Häkchen) | Wirksame Mitglieder zeigen (Häkchen) | Trenner | Spalten > (Häkchen) | Aktualisieren (F5)
- Hilfe: Hilfe zu Gruppen (F1) | Kürzel anzeigen
Kontextmenü Gruppe (Rechtsklick Zeile): Öffnen | Neue Untergruppe… | Person hinzufügen… | Umbenennen | Trenner | Unter Gruppe einhängen… | Trenner | Löschen…
Kontextmenü Mitglied: Rolle ändern > | Entfernen | Trenner | Zu Person (fs-people) öffnen
Kontextmenü Leerfläche: Neue Gruppe… | Aktualisieren
Werkzeugleiste: Neu | Hinzufügen | Einladen | Entfernen | Trenner | Suchfeld | Ansicht-Umschalter (Baum/Liste)
Hinweis: Alle Einträge, die der Kern noch nicht kann, erscheinen ausgegraut MIT Grund (Regel "nie still ausgegraut", Fehlende Datenquelle melden). Kürzel sind Vorschlag, nicht aus Vorbildern belegt.

## 5. Die wichtigsten nächsten Funktionen
1. Mitglied hinzufügen/entfernen (Auswahldialog mit Suche, Mehrfachwahl, Zeilenmenü) [M]: ohne sie kann man eine Gruppe nicht füllen; heute nur lesen. Kern fertig, Personenquelle (fs-people) nötig.
2. Rolle je Mitglied setzen + letzter Verwalter geschützt [S-M]: wer darf was in der Gruppe; sonst ist "Rolle" nur eine Anzeige.
3. Untergruppen sehen und bilden: Baumansicht, einhängen, Anfrage/Zustimmung des Elternteils, Kreis-Meldung [L]: das Alleinstellungsmerkmal (Abteilung im Verein); Kern vollständig, aber im Fenster unsichtbar.
4. Wirksame Mitglieder mit Herkunft ("direkt/geerbt aus X") [S]: man versteht, warum jemand drin ist; im Kern vorhanden.
5. Einladungen: Person/E-Mail einladen, Liste offener, widerrufen, Ablauf [M]: sonst kann man niemanden von außen holen; nur die eingeladene Person nimmt an (Kern).
6. Gruppenseite mit Reitern (Mitglieder, Untergruppen, Einladungen, Eigenschaften) + Tastatur/Pfeile/Entf/F2 [M]: ohne Struktur und Bedienung wirkt das Fenster unbrauchbar (Nutzerbefund).
7. Menüs und Kontextmenü (Abschnitt 4) [M, hängt an fs-components]: das Vorbilder-Bedienmuster; heute gibt es nichts zum Klicken außer vier Knöpfen.
8. Aufnahme-Regel + Beitrittsanfragen + Sichtbarkeit [L]: offene/geschlossene/private Gruppen, Verwalter entscheidet; Kern fehlt teilweise (Türsteher, Plan Selbstverwaltung).

## 6. Lücken in fs-components (Stand fs-components-app/src/menu.rs, Kopf origin 7bf826c9)
Heute: `Menu { label, entries: Vec<MenuEntry> }`, `MenuEntry { id, label, disabled }`: flach, nur Beschriftung/ausgegraut. Gebraucht:
- Untermenüs (Eintrag mit Kindern), Trenner, Gruppen.
- Häkchen- und Radio-Einträge mit Zustand.
- Kürzel-Anzeige und Kürzel-Bindung (zentrale Tabelle, Konflikte melden).
- Symbol je Eintrag, Grund-Text bei Ausgegraut (Tooltip/Statuszeile).
- Kontextmenü an Zeile/Leerfläche (Rechtsklick, Menütaste, Umschalt+F10), selbe Eintragsbeschreibung.
- Werkzeugleiste aus derselben Beschreibung (Docs toolbar: `buttons`, `groups`, `commands` vorhanden als Entwurf).
- Dialoge: Personenauswahl mit Suche und Mehrfachwahl, Bestätigungsdialog mit Folgen-Vorschau, Baumansicht (Tree) mit Auf-/Zuklappen und Zeilenmenü, Tabs/Reiter, Tabelle mit Mehrfachauswahl + Haken.
- Pfeiltasten-Navigation in Liste/Baum (Hilfe sagt: fehlt).
- Quelle der Menüs: Anordnungsdatei des Frontends (ADR 0074 Z.77), nicht im Programmcode.

## 7. Offene Fragen an die Strategie
1. Personenquelle: darf die Personenauswahl (Mitglied hinzufügen) fs-people direkt nutzen (Personen-Verweis-Baustein), und gilt "Kern vorhanden" schon als erledigt, wenn das Fenster nicht folgt?
2. Reihenfolge: zuerst Mitglieder + Baum im Fenster (ohne Menüs) oder zuerst fs-components Untermenüs/Kontextmenü, dann alles?
3. Nesting-Regeln: wer muss beim Einhängen zustimmen (nur Elternteil laut Kern, "vorläufig")? Antwort steuert die Eltern-Anfrage-Ansicht (#12).
4. Gruppenart: bleibt "Art" freier Text oder feste Liste (offen, geschlossen, privat, sensibel, KI)? Die Vorbilder (Google/Entra) nutzen feste Typen mit Voreinstellungen.
5. Menüleiste ja/nein: Vorbilder sind Web-Konsolen ohne Menüleiste; unser Vorschlag ist ein Desktop-Menü. Gewollt (ADR 0074) oder Seitenmenü + Symbolleiste zuerst?

Abgleich main v0.0.2 (43b9d68b) am 17.11.: Kopf per ls-remote belegt (main = HEAD = 43b9d68b, Tag v0.0.2); Abschnitt 0 neu gegen Quellen geprueft. Korrekturen: Fenster ist die generische Personen-Werkbank per Adapter, Schnittstelle GroupsApi nur 7 Aufrufe (nur direkte Mitglieder); Kern-Aufzaehlung praezisiert (Memberships/Invitations/Parent-Anfragen mit Namen); NEU: "letzter Verwalter geschuetzt" existiert im Kern NICHT; Rollen opak ohne Liste; Vererbung im Kern = RightFlow None/Down/Up je Gruppe, nicht BottomUp/TopDown/Einzeln je Kante; Entscheidung b7 (Stufe 1 = 1-4, Seitenleiste+Symbolleiste+Kontextmenues, keine eigene Menueleiste; Personenauswahl ueber Personen-Verweis-Baustein) gilt vor Abschnitt 4 (Menueleiste-Vorschlag dort ist ueberholt).
