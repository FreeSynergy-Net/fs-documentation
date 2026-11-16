# Feature-Abgleich fs-groups (Auftrag 27)

Stand 2026-11-16, Auftrag 27, Feature-Abgleich vor dem Feature-Freeze. Feature-Freeze: offen (Nutzer). Nur Deutsch: todo/ wird nicht übersetzt (ADR 0011).

Stand: 2026-11-16 · Programm: fs-groups (Repo `fs-groups`, main `b5b6674`; Tags v0.0.1 bis v0.4.0 laut Checkliste)
Quellen Eigenstand: `fs-groups/DESIGN.md`, `fs-documentation` origin/main `todo/checklisten/fs-groups.md`, `docs/en/programs/platform/groups.md`, ADR 0037, 0054, 0055, 0056, 0063, 0082, 0086, 0087, Planordner pilot-groups/PLAN.md` (G1–G25, §3–§7, §12), Planordner pilot-selbstverwaltung/PLAN.md` (§3–§8, §16), Planordner pilot-access/PLAN.md` (§5–§7a, §14).
Format: `- [x]` = Kern gebaut (Fenster ggf. fehlt, steht im Stand), `- [ ]` = geplant (Plan §) | fehlt | verschoben | offen.
Feature-Freeze: offen (Nutzer). Handtest und Ideensammlung des Nutzers stehen noch aus; dieser Abgleich ist Vorarbeit dafür.

## Vorbilder und Abruf (2026-11-16, nur gelesen, nichts kopiert)
- Google Groups Hilfe, Gruppeneinstellungen: https://support.google.com/groups/answer/2464926 (abgerufen 2026-11-16, belegt: Beitritt, Posting, Moderation, Rollen Member/Manager/Owner, keine Größen- oder Ablaufgrenze)
- Microsoft 365 Groups, Verwaltung: https://learn.microsoft.com/en-us/microsoft-365/admin/create-groups/manage-groups?view=o365-worldwide (abgerufen 2026-11-16, belegt: Besitzer/Mitglieder, Kopie an Posteingang, Gäste, endgültiges Löschen nach 30 Tagen Papierkorb)
- Kanidm Gruppen: https://kanidm.github.io/kanidm/stable/accounts/groups.html (abgerufen 2026-11-16, belegt: Gruppe in Gruppe, memberof, entry_managed_by, nur idm_access_control_admins ändert den Verwalter)
- Kanidm Zugriffskontrolle: https://kanidm.github.io/kanidm/stable/access_control/intro.html (abgerufen 2026-11-16, belegt: Rollen haben keine Rechte an sich, Rechte kommen über Gruppenmitgliedschaft; idm_high_privilege als Sperrgruppe)
- Keycloak Server-Admin, Gruppen und Rollen: https://www.keycloak.org/docs/latest/server_admin/index.html#_group_role_mappings (abgerufen 2026-11-16, nur Einstieg gelesen: Mitglieder erben Attribute und Rollen-Mappings, Composite-Rollen)
- Matrix Spec, Spaces: https://spec.matrix.org/latest/client-server-api/#spaces (abgerufen 2026-11-16, nur Gliederung belegt: m.space.child, m.space.parent, Hierarchie-Endpunkt; Inhalt der Abschnitte nicht gelesen)
- Nicht belegt (Abruf scheiterte, keine Funktion aus dem Kopf eingetragen): Mailman 3 (docs.mailman3.org, 404), Discourse Gruppen (docs.discourse.org, nur Titelseite), Authentik (docs.goauthentik.io, 404; Einladungsseite lieferte Fremdinhalt), Nextcloud Circles (apps.nextcloud.com/apps/circles, nur Store-Seite). Zeilen mit diesen Vorbildern sind als "[Vorbild nicht belegt]" markiert.
- Kanidm, Keycloak und Authentik-Praxis sind hier Standard für Rollen und Gruppen; Kanidm ist der Spiegel-Partner (ADR 0047).

## 1. Gruppentypen (offen / geschlossen / privat / sensibel / KI)
- [x] Gruppe als Akteur (AS2 `Group`) — Standard AS2, Kanidm-Gruppe — Kern gebaut (v0.0.1) — hoch — Eine Gruppe kann selbst handeln und Dinge besitzen.
- [x] Gruppe anlegen, ändern, löschen (Kern) — Google Groups, M365 — Kern gebaut, Fenster fehlt (G3, G4) — hoch — Grundbedienung für jede Gruppe.
- [ ] Papierkorb mit Wiederherstellen — M365 (30 Tage, belegt) — geplant (G5, Frist vorbei: nicht angeboten) — hoch — Versehentliches Löschen ist rückgängig zu machen.
- [ ] Offene Gruppe (Beitritt ohne Prüfung) — Google Groups "anyone on the web can join" (belegt) — geplant (Selbstverwaltung §5c, Aufnahme "offen") — mittel — Gemeinschaften ohne Hürde.
- [ ] Geschlossene Gruppe (Beitritt nur auf Antrag oder Einladung) — Google Groups "can ask / invited only" (belegt) — geplant (Selbstverwaltung §5b) — hoch — Die Gruppe entscheidet selbst, wer hineinkommt.
- [ ] Privatgruppe (Mitglieder nur für Mitglieder sichtbar) — Google Groups "who can view members" (belegt), M365 privat (belegt) — geplant (G10, Zustand "nur für Mitglieder", ab min-Größe) — hoch — Mitgliederliste und Inhalt bleiben intern.
- [ ] Sensible Gruppe (keine Gruppen-Links, nur persönliche Einladung) — Plan Entscheidung 3 — verschoben (O12: Typ `sensitive` da, kein Schutzknopf) — hoch — Schützt Gruppen mit Admin-Rechten.
- [ ] KI-Gruppe (nur KI-Konten, nie verschachtelt über Admin-Ketten) — ADR 0054, ADR 0056 — geplant (G9b) — hoch — KI bleibt sichtbar und abgegrenzt.

## 2. Mitgliedschaft (Einladen, Anfrage, Aufnahmeregeln, Moderation, Größen, Ablauf, Rollen)
- [x] Einladung mit Ablauf (Kern) — Google Groups "invite" (belegt), Nextcloud Circles [Vorbild nicht belegt] — Kern gebaut (v0.0.1), Fenster fehlt (G15, G16) — hoch — Man lädt Menschen ein, ohne sie sofort aufzunehmen.
- [ ] Persönliche Einladung über Messages als signierte Einladung (JWS, einmalig) — Plan Selbstverwaltung §5, Entscheidung 8 (jsonwebtoken belegt) — geplant — hoch — Nur die eingeladene Person kann annehmen.
- [ ] Link oder QR mit Ablauf und Nutzungsgrenze, jederzeit widerrufbar — Plan Selbstverwaltung §5, Entscheidung 7 (14 Tage, max 90) — geplant — mittel — Einladen beim Treffen ohne Mailadresse; Nähe-Austausch offen (ADR 0054).
- [ ] Beitrittsanfrage mit Bestätigung durch Verwalter — Google Groups "membership approval" (belegt), M365 Beitrittsanfragen [Vorbild teils nicht belegt] — geplant (Selbstverwaltung §5b) — hoch — Verwalter sieht und entscheidet jede Anfrage.
- [ ] Abstimmung über Aufnahme (Ja-Anteil in %, Anzahl oder beides; Frist 7 Tage) — kein Vorbild belegt; Eigenentwurf — geplant (Selbstverwaltung §8) — mittel — Gemeinschaft entscheidet über neue Mitglieder.
- [ ] Abstimmung geheim (Standard), Ergebnis prüfbar — Plan Entscheidung 2 — geplant — mittel — Niemand muss offen Nein sagen.
- [ ] Türsteher als eine Prüfkette (Signatur, Ablauf, Größe, KI-Ausschluss, Regel) — eigener Entwurf, Plan Selbstverwaltung §6 — geplant — hoch — Eine Stelle entscheidet, nachvollziehbar und "im Zweifel nein".
- [ ] Mindestgröße (unter n Mitglieder nur intern sichtbar) — kein Vorbild belegt (Google Groups nennt keine Größen, belegt) — geplant (Selbstverwaltung §7) — mittel — Kleine Gruppen bleiben geschützt.
- [ ] Höchstgröße hart und weich (weich: keine neuen Links, hart: Vollmeldung) — kein Vorbild belegt — geplant (Selbstverwaltung §7) — mittel — Begrenzt Gruppen auf eine handhabbare Größe.
- [ ] Mindestdauer der Mitgliedschaft vor dem Stimmrecht (14 Tage) — Plan Entscheidung 11 — geplant — mittel — Schützt gegen Scheinkonten, die kurz vor einer Abstimmung eintreten.
- [x] Rolle je Mitglied (Kern: `Membership.role`, opak) — Google Groups Member/Manager/Owner (belegt), M365 Owner/Member (belegt) — Kern gebaut, Rechte je Rolle geplant (G13) — hoch — Wer darf was in der Gruppe.
- [ ] Moderation (Beiträge und neue Mitglieder prüfen) — Google Groups "message moderation" (belegt) — fehlt (kein Plan-Punkt) — mittel — Hält Diskussionen sauber, sobald es Beiträge gibt.
- [x] Mitglied entfernen oder austreten, letzter Verwalter bleibt geschützt (Kern) — Google Groups (Owner-Regel, belegt), Kern-Fehler `LastManager` (Plan G14) — nur Trait und Fake (`LastManager` in groups_v1 und fs-groups-testdata), nicht in fs-groups-core; Fenster fehlt (korrigiert 16.11. nach Opus-Bewertung) — hoch — Eine Gruppe bleibt nie ohne Verwalter.
- [ ] Verfallsdatum der Mitgliedschaft — kein Vorbild belegt — fehlt (nur Einladung hat Ablauf) — niedrig — Befristete Mitarbeit, z. B. Projektteams.
- [x] Wirksame Mitglieder mit Herkunft ("direkt", "geerbt aus X") (Kern) — Kanidm memberof (belegt) — Kern gebaut, Anzeige geplant (G11) — hoch — Man sieht, warum jemand Mitglied ist.

## 3. Verschachtelung und Vererbung (Modi)
- [x] Untergruppen, mehrere Eltern, Kreis mit Pfad abgelehnt (Kern) — Kanidm Gruppe in Gruppe (belegt), Matrix Spaces (Gliederung belegt) — Kern gebaut (v0.0.1), Fenster fehlt (G6) — hoch — Strukturen wie Abteilung in Verein.
- [ ] Modus je Kante: BottomUp / TopDown / Single mit Vorgabe je Baum — Eigenentwurf nach Kanidm-Grenze (ADR 0056), Plan O1 — geplant (Plan §4.1, G9a, G9b) — hoch — Man steuert, ob Rechte nach oben oder unten wirken.
- [ ] TopDown in Kanidm nativ gespiegelt (Kante umgekehrt) — Kanidm: Rechte nur Kind nach oben (belegt, ADR 0056) — geplant (Plan §4.1) — hoch — Kanidm bekommt den richtigen Baum statt einer flachen Liste.
- [ ] Zustimmung beider Seiten beim Einhängen (Anfrage, Vorschau, Zurückziehen) — ADR 0056/0082, DESIGN.md offene Frage — geplant (G7, G8), offen — hoch — Keine Gruppe bekommt Rechte ohne Zustimmung.
- [ ] Vorschau vor dem Einhängen ("+N Personen in M Gruppen") — kein Vorbild belegt — geplant (G7) — mittel — Folgen sind vor dem Klick sichtbar.
- [ ] Moduswechsel des ganzen Baums mit Zusammenfassung (sofort, angefragt, gescheitert) — Eigenentwurf (G9b) — geplant — niedrig — Große Umbauten sind nachvollziehbar.
- [ ] Rollen-Baum mit gleicher Nesting-Logik (eigener Baum, keine Kante Gruppe zu Rolle) — Keycloak Composite-Rollen (belegt Einstieg) — geplant (pilot-access §7a, Entscheidung 16) — mittel — Rollen können Rollen enthalten.
- [ ] Vererbung von Rollen an Untergruppen (wirksame Rollen) — Keycloak (Mitglieder erben Rollen-Mappings, belegt) — geplant (Plan §3 `effective_roles`) — mittel — Untergruppen brauchen keine Doppelpflege.
- [ ] Wirkungsbereich eines Modus im Spiegel sichtbar — Eigenentwurf — geplant (G21) — niedrig — Man sieht, was Kanidm tatsächlich bekommt.

## 4. Rollen und Rechte (Rollen an Personen und Gruppen, Sperre schlägt Erlaubnis)
- [ ] Rollen an Person UND an Gruppe vergeben (Option C) — Kanidm und Keycloak: Rollen über Gruppenmitgliedschaft (belegt), Entscheidung 18 — geplant (`groups_v1`, Entscheidung 21) — hoch — Eine Gruppe kann einer Rolle als Ganzes angehören.
- [x] Rechte vergeben, entziehen, prüfen ("darf X") (Kern: grant, revoke, may_do; "im Zweifel nein") — Kanidm Berechtigungsgruppen (belegt) — Kern gebaut, nur Auskunft, nicht erzwungen — hoch — Man weiß, wer was darf.
- [ ] Rechte erzwungen (nicht nur Auskunft) — Kanidm erzwingt über Berechtigungsgruppen (belegt) — fehlt (Durchsetzung liegt bei fs-access, pilot-access) — hoch — Ohne Durchsetzung ist eine Erlaubnis nur ein Vermerk.
- [ ] Sperre schlägt Erlaubnis, auch für Admins bei Objektzugriff (Admin darf Sperre ändern, auditiert) — pilot-access §7a, Entscheidung 13 — geplant — hoch — Eine Sperre bleibt wirksam, bis sie bewusst aufgehoben wird.
- [ ] Verwalter-Recht: Gruppe darf Mitglieder pflegen, nicht Einstellungen — Kanidm `entry_managed_by` (belegt, nur idm_access_control_admins ändert ihn) — geplant (Plan §6.3, Risiko 3) — mittel — Delegation ohne Vollrechte.
- [ ] Rechte an Objekten (Gruppe oder Rolle erlauben/sperren, Eigentümer-Programm speichert) — pilot-access §7a — geplant — hoch — Dokumente und Termine gehören einer Gruppe, nicht nur einer Person.
- [ ] Admin-Rechte nie für KI, nie in selbstverwalteter Gruppe — ADR 0054, ADR 0056, Plan Selbstverwaltung §6.2 und Risiko 3 — geplant (Pflichtprüfung, mit Test); im Kern teilweise gebaut (`AgentNotAdmin`, fs-groups-core repo/admins.rs:35) (korrigiert 16.11. nach Opus-Bewertung) — hoch — Schutz vor Missbrauch durch KI-Konten.
- [ ] Oberster Admin (der Installierende) ernennt weitere Admins — ADR 0056 Punkt 1 — entschieden, Bau nicht belegt — hoch — Klare Wurzel der Verwaltung.
- [ ] Rollenvergabe nur durch Mensch mit Manage-Recht — Google Groups (Owner-only, belegt), Plan Selbstverwaltung §6.2 — geplant — hoch — Keine automatische Rechteausweitung.

## 5. Sichtbarkeit und Verzeichnis
- [ ] Gruppenliste mit Suche, "nur meine", Papierkorb — M365 Liste aktiver Gruppen (belegt) — geplant (G1, G2) — mittel — Schnell finden, was man sucht.
- [ ] Mitglieder einzeln sichtbar oder verborgen einstellen — Google Groups "who can view members" (belegt) — fehlt (kein Plan-Punkt, nur Privatgruppe) — mittel — Mitgliederliste bleibt intern, Gruppe bleibt sichtbar.
- [ ] Eigene Gruppenadresse (Mailadresse der Gruppe) — Google Groups und M365 (belegt) — fehlt — mittel — Eine Adresse für ein Team.

## 6. Kommunikation (Mailinglisten, Foren, Chaträume als Anbindung)
- [ ] Mailingliste je Gruppe (Mail an die Gruppe, alle Mitglieder erhalten) — Google Groups (belegt), M365 (belegt), ADR 0037 "Ordner = Gruppe = Verteiler" — fehlt bei fs-groups (Anbindung über fs-messages, nicht geplant in Pläne) — hoch — Gruppe und Verteiler sind ein Konzept.
- [ ] Wer darf in der Gruppe posten (Einstellung) — Google Groups (belegt) — fehlt — mittel — Verhindert Spam aus dem Umfeld.
- [ ] Kopie der Gruppenmails in den Posteingang der Mitglieder (abschaltbar) — M365 (belegt) — fehlt — niedrig — Gruppenmail auch dort sehen, wo man ohnehin liest.
- [ ] Forum je Gruppe — [Vorbild nicht belegt, Discourse nicht abrufbar] — fehlt — niedrig — Dauerhafte Diskussion ohne Mailflut.
- [ ] Chatraum je Gruppe, verknüpft mit der Gruppe — Matrix Spaces (Gliederung belegt) — fehlt (Anbindung an fs-messages) — mittel — Gruppe und Chat gehören zusammen.

## 7. Gemeinsame Ressourcen (je Gruppe)
- [ ] Gruppe als Teilnehmer im Kalender — Plan §2.5 (Gruppen als Teilnehmer) — geplant — hoch — Termine für ein Team mit einem Klick.
- [ ] Gruppe als Zuständige für Aufgaben — Plan §2.5 — geplant — hoch — Aufgaben gehören einem Team, nicht nur einer Person.
- [ ] Dateien und Ordner je Gruppe mit Rechten je Gruppe — docs groups.md "Sharing then means sharing with a group" (belegt), pilot-access §7a — geplant — hoch — Teilen mit einer Gruppe statt mit Einzelnen.
- [ ] Eigentümer ist Person oder Gruppe, ohne Umbau wechselbar — docs groups.md Idee (belegt) — geplant (Bau nicht geprüft) — mittel — Ein Objekt wandert vom Einzelnen ins Team.

## 8. Abstimmungen und Umfragen
- [ ] Abstimmung mit Frist und Regel (Prozent, Anzahl, beides) — Eigenentwurf (Selbstverwaltung §8) — geplant — mittel — Entscheidungen mit klarer Regel.
- [ ] Umfrage in der Gruppe (ohne Aufnahme) — [Vorbild nicht belegt] — fehlt; Formulare sind Suite (fs-forms), nicht fs-groups — niedrig — Meinungsbild ohne Mitgliedschaftsfolge.

## 9. Protokoll und Audit
- [ ] Protokoll je Gruppe (wer, wen, wann, Ergebnis; nie Token, nie Namen im Klartext) — Plan Selbstverwaltung §4, Plan G23 — geplant — hoch — Nachvollziehbar, wer was geändert hat.
- [ ] Betroffene Person sieht das Protokoll über sich (Art. 15 DSGVO) — Plan Selbstverwaltung §5 — geplant — hoch — Auskunftsrecht ohne Rückfrage.
- [ ] Aufbewahrung 12 Monate, einstellbar — Plan Selbstverwaltung Entscheidung 9 — geplant — mittel — Frist ist begründet und kürzbar.
- [ ] Gruppenereignisse an fs-activity — Plan §4 — geplant — mittel — Gruppen erscheinen im Aktivitätsverlauf.

## 10. Import und Export
- [ ] vCard KIND:group (RFC 6350) Import und Export — Standard IETF — fehlt bei fs-groups (fs-people kann Gruppen als JSContact) — hoch — Verteiler aus Adressbüchern übernehmen (Checkliste import-export, groups).
- [ ] LDIF groupOfNames (RFC 2849, RFC 4519) Import und Export — Standard IETF — fehlt, nur Schnittstelle `GroupDirectory` — mittel — Gruppen aus LDAP-Verzeichnissen.
- [ ] Gruppen aus Google-Konten (nur Import, geschlossen) — Google Groups API (geschlossen, Regel "nur Import") — fehlt — niedrig — Verteiler aus alten Konten übernehmen.

## 11. SCIM, OAuth2 und LDAP-Abgleich
- [ ] SCIM Group lesen (RFC 7643; nur displayName und members) — RFC 7643 (belegt), Kanidm — geplant (pilot-access §5, Entscheidung 10) — hoch — Gruppen aus dem Identitätsdienst übernehmen.
- [ ] SCIM schreibt Rollen zurück (Option C) — pilot-access Entscheidung 10 — geplant (nach Lesen) — mittel — Rechte auch ohne unsere Programme vergeben.
- [ ] SCIM darf selbstverwaltete Gruppen nicht ändern (nur lesen) — pilot-access Entscheidung 10 — geplant — hoch — Der Türsteher bleibt Leitquelle.
- [ ] OAuth2 Claim `groups` mit wirksamen Gruppen (UUID und Name) — Kanidm (belegt: Scope groups) — geplant (pilot-access §7a) — hoch — Programme erkennen Gruppen beim Anmelden.
- [ ] OAuth2 Claim `roles` je Client über Claim-Map (Werte `rolle@gruppe`) — Kanidm Claim-Map (belegt) — geplant (pilot-access §7a, Entscheidung 11) — hoch — Ein Programm sieht genau die Rollen, die es braucht.
- [ ] LDAP-Abgleich — kein Plan-Punkt — fehlt — niedrig — Für Dienste ohne SCIM.

## 12. Spiegel nach Kanidm
- [x] Spiegel-Schnittstelle `Mirror::sync_to(&dyn GroupDirectory)` mit Option B (Kern, Trait) — ADR 0056 (belegt) — Kern gebaut; Kanidm-Adapter liegt in fs-identity, nicht in diesem Repo — hoch — Kanidm bekommt, was fs-groups entscheidet.
- [ ] Spiegel-Zustand, Trockenlauf und Befunde sichtbar — Plan G21, G22 — geplant — hoch — Kein Spiegelschritt ohne Vorschau.
- [ ] Türsteher spiegelt selbstverwaltete Gruppen automatisch, nur Attribut `member` — Plan Selbstverwaltung Entscheidung 1 — geplant — hoch — Selbstverwaltung wirkt ohne Freigabe je Schritt.
- [ ] Verwalter-Umleitung über Gruppe `fs_selfmanaged`, Admin- und sensible Gruppen dort verboten — Plan Selbstverwaltung §6.3, Risiko 3 (Kanidm-Belege belegt) — geplant — hoch — Kein Verwalter-Recht auf Hochprivilegierte.
- [ ] Präfix `role_` bei Rollen im Spiegel — Plan §3 — geplant — mittel — Rollen sind in Kanidm klar erkennbar.
- [ ] Anbindung an Kanidm über fs-identity — checkliste "SPÄTER" — offen — mittel — Der Spiegel läuft über ein eigenes Programm.

## 13. Archivieren und Papierkorb
- [ ] Gruppe archivieren (nur lesbar) — [Vorbild nicht belegt] — fehlt — niedrig — Ruhende Gruppen bleiben nachschlagbar.
- [ ] Endgültig löschen nach Papierkorb-Frist — M365 nach 30 Tagen (belegt) — geplant (Papierkorb G5) — mittel — Speicher und Daten werden wirklich entfernt. Hinweis: Löschen läuft über Nutzerskript (Regel).

## 14. Mandanten
- [ ] Einzelbetrieb mit festem Standard-Mandant, Wechsel zu Mehrmandant ohne Datenumbau — pilot-access §7a, Entscheidung 14 (PFLICHT) — geplant — hoch — Eine Installation kann später mehrere Organisationen tragen.
- [ ] Mehrmandant in einer Instanz über OAuth2 — ADR 0024 (belegt) — geplant (später) — mittel — Mehrere Organisationen, eine Instanz.

## 15. DSGVO
- [ ] Protokollaufbewahrung und Auskunft (siehe §9) — Plan Selbstverwaltung §5, Entscheidung 9 — geplant — hoch — Rechtlich nötig.
- [ ] Datenminimierung: nur Hash des Geheimnisses, nie Token im Klartext — Plan Selbstverwaltung §4 — geplant — hoch — Ein Einladungslink lässt sich nicht nachlesen.
- [ ] Verschlüsselung der Gruppendaten — Plan O12 (verschoben, wie bei people) — verschoben — mittel — Vorerst Klartext; im Plan sichtbar vermerkt.

## 16. Barrierefreiheit
- [ ] Gruppenbaum und Dialoge tastatur- und screenreader-bedienbar — kein Plan-Punkt, kein Vorbild geprüft — fehlt — mittel — Verschachtelte Bäume sind leicht unzugänglich.
- [ ] Zustandsmeldungen nicht nur farbig (leer, laden, Fehler, teilweise) — Plan G1–G25 zeigt Zustände, Fenster fehlt — geplant — mittel — Jeder Zustand ist in Text lesbar.

## 17. KI-Regeln
- [ ] KI als markierter Teilnehmer, komplett aussperrbar — ADR 0054 (belegt) — geplant (Kontoart, Plan §6.2) — hoch — Missbrauch durch KI-Konten wird verhindert.
- [ ] KI nie Admin, nie stimmberechtigt, nie Auslöser des Türstehers — Plan Selbstverwaltung §6.2 — geplant — hoch — KI darf am wenigsten.
- [ ] KI-Kette über alle Verschachtelungen geprüft (`AiNesting{path}`) — Plan §3 — geplant — hoch — Keine Umgehung durch Umwege.
- [ ] Markierung KI nur durch Mensch setzbar oder aufhebbar — pilot-access Entscheidung 4 — geplant — hoch — Ein Dienst darf nur verschärfen.

## Ideen des Nutzers
- (Platzhalter, Strategie füllt nach dem Handtest des Nutzers)

## Feature-Freeze: offen (Nutzer)
- Kein Freeze gesetzt. Nur der Nutzer setzt ihn, nach Handtest und Ideensammlung (ARBEITS-FIXPUNKT, Regel FIXPUNKT).
