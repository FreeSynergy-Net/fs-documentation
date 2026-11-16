# 0091 – KI-Stellvertreter-Bot: die KI hat keine Rechte, der Bot ist ihr einziger Weg

Status: Entwurf (Strategie, 2026-11-16; Entscheidungen 2.6.1 bis 2.6.11 aus den Nutzerantworten 29, 39 und 42) · ersetzt die Vorschläge „KI-Konto mit eigenen Rechten“ in 0054 (Pkt 1, 10; Nachtrag 1 Punkt 1 und 3) und die KI-Gruppen in 0082 (KI-Regel) · präzisiert 0054 Nachtrag 2 („KI erlaubt“) · Nachtrag 0056 Pkt 8 (Entwurf, eigener Auftrag) · baut auf 0047, 0052, 0056, 0070, 0076, 0082, 0085, 0090 auf

## Kontext
Eine KI soll in Gruppen und Unterhaltungen mitarbeiten, aber nach 0054 und 0082 nur unter strengen Regeln: Sie wird markiert, sie braucht eine Einladung, alle Anwesenden müssen zustimmen, sie hat höchstens ein Mindestmaß an Rechten, und sie wird nie Admin.

Bisher hatte die KI ein eigenes Konto mit eigenen Rechten, das über eine „KI-Gruppe“ Rechte bekam (0082 KI-Regel, 0054 Nachtrag 1). Das führt zu drei Problemen:

1. **Lebensdauer und Situation fehlen.** Eine KI-Gruppe hat keine Bindung an eine konkrete Gruppe oder Unterhaltung. Die Zustimmung aller (0054 Pkt 4) und die Einladung (Nachtrag 1) hängen aber an genau einer Situation.
2. **Kanidm.** Die KI-Gruppen-Kette (Rollen über `BottomUp` und `TopDown`, Ausnahmen, Fix-Runden) wird immer länger. Eine KI mit Konto in Kanidm bleibt eine Ausnahme von 0056 Pkt 8 („In Kanidm stehen nur Menschen“).
3. **Ende-zu-Ende-Schlüssel.** Nach 0054 Pkt 2 hält ein Programm dazwischen den Schlüssel, weil ein Modell bei einem Anbieter nichts verwahren kann. Dieses Programm ist im neuen Modell der Bot.

Die Nutzerentscheidung 42 verlangt: Die Zustimmung gilt für die Situation. In einer Arbeitsgruppe gilt sie, solange die Gruppe besteht. In einer Konferenz gilt sie für die Konferenz. Die Nutzerentscheidung 39 verlangt: Die KI ist nie Admin und nie in Admin- oder sensiblen Gruppen; `KI erlaubt` ist ein Schalter, den die KI nie sieht. Daraus folgt die neue Architektur: Die KI steht nie in Kanidm. In eine Situation kommt sie nur über einen Bot, und die Rechte des Bots sind die Obergrenze.

Die Begriffe und Zahlen stehen in der Arbeitsfassung des Plans (`pilot-bot/PLAN.md`, §1 bis §12) und sind hier auf die Entscheidung verdichtet.

## Verhältnis zu bestehenden Entscheidungen
Geprüft am 2026-11-16 gegen den Stand von `origin/main` (845e04da) und gegen die Nachträge 0054 (b97c77b6, 845e04da).

- **0054 Punkt 1 und 10** (KI hat eigenes Konto, eigene Rechte, eigenes Matrix-Konto): **umgedeutet.** Konto, Schlüssel und Matrix-Konto hat der Bot. Die KI hat keine eigenen Rechte.
- **0054 Punkt 2** („Programm dazwischen hält den Schlüssel“): **umgedeutet.** Das Programm ist der Bot. Der Bot ist die einzige Form, in der eine KI handelt.
- **0054 Punkt 3** („Keine Userbots“): **bestätigt, Abgrenzung.** Der Bot ist kein Userbot, weil er sichtbar markiert ist und immer zeigt, wer ihn steuert und wer ihn beauftragt hat (2.6.1). Die Idee des Bots stammt aus der eigenen Vorgabe des Nutzers (Entscheidung 42); damit ist seine Bestätigung zu Punkt 3 gegeben. Die Strategie informiert den Nutzer.
- **0054 Nachtrag 1, Punkt 1 und 3** (KI-Konto eingeladen; Rechte über KI-Gruppe; Frist der Zustimmung): **ersetzt** durch Bot und Mandat. Die Frist ist durch Entscheidung 42 entschieden (Lebensdauer, Abschnitt Entscheidung).
- **0054 Nachtrag 2** („KI erlaubt“, Bedeutung (ii) = Recht einer KI-Gruppe): **präzisiert.** Das Recht ist ein Bot-Platz (Mandat) in der Gruppe. Der Schalter bleibt für die KI unsichtbar, auch für den Bot.
- **0082 KI-Regel** („KI-Konten nur in eigenen KI-Gruppen“, „KI-Gruppen werden nicht gespiegelt“): **ersetzt.** Es gibt keine KI-Gruppen mehr. Die KI-Seite ist nie Mitglied, nur Bot-Platz. Bot-Konten stehen in Kanidm nur in `fs_delegates`.
- **0082 Entscheidung 5** (Gate `human`): gilt. Der Vorrat an Bot-Konten wird durch einen Menschen per Skript angelegt (2.6.9). Ein Nachtrag dazu folgt als eigener Auftrag.
- **0056 Punkt 8** („In Kanidm stehen nur Menschen, die die Rechte haben“): **neu gelesen.** Der Wortlaut passt nicht mehr zu technisch nötigen Dienstkonten. Der Nachtrag lautet: „In Kanidm stehen Menschen und technisch nötige Dienstkonten (Türsteher, Bots), NIE eine KI.“ (2.6.7). Die Klammer ist zu prüfen (siehe Offen).
- **0056 Punkt 5 und 6** (Agenten in eigener Sandbox; ein Agent wird nie Admin): gilt. Die Bot-Laufzeit läuft unter eigenem Betriebssystem-Benutzer.
- **0090 Punkt 9** („Im Einzelplatz erhält keine KI Rechte“): **bleibt wahr** und wird klargestellt. Der Bot hat dort eine lokale Identität ohne Kanidm. Im Einzelplatz gibt es Bots nur, wenn fs-groups angeschlossen ist (2.6.8).
- **0076** (Tabelle „Wer?“): Zeile Bot dazu (AS2 `Service`). Die KI als `Application` bleibt Akteur ohne Rechte.
- **0085** (`PersonArt`): Prüfung, ob der Bot als `Person` mit `ActorKind` geführt wird oder eine eigene Art bekommt (Empfehlung: `ActorKind`). Offen für die Umsetzung.
- **0047** (Kanidm hinter eigenem Wrapper): kein Widerspruch. Kanidm bleibt Anmeldedienst; die Mandate liegen bei den Programmen.

## Entscheidung
1. **Die KI hat keine Rechte und nie ein Konto in Kanidm.** Sie ist eine Karte in fs-people (JSContact `kind: application`, `ai`, Verweis auf den Betreiber, ADR 0054). Ihr einziger Weg zu einer Situation ist ein Bot. Die KI darf nie Admin werden, nie `Manage` haben und nie Rechte, Rollen oder Mandate vergeben oder ändern.
2. **Der Bot gehört der Situation, nicht dem Halter.** Der Bot ist eine allgemeine Identität mit immer gleichem Code. Er ist an genau einen **Auftrag** (Mandat) in genau einer Situation gebunden. Das Mandat liegt bei dem Programm, dem die Situation gehört: Arbeitsgruppe in fs-groups (`groups_v1`); Raum oder Konferenz in fs-messages. Die Zustimmungen liegen in fs-people als Einwilligung `AiAssistance` mit `scope` = Situation. Die laufende Steuer-Sitzung (welche KI gerade steuert) liegt in der Bibliothek `fs-delegate` (2.6.2). Zugangsdaten liegen in fs-vault (ADR 0067). Die KI sieht das Bot-Token nie.
3. **Halter.** Halter ist der Mensch, der den Bot eingeladen hat. Er ist verantwortlich.
4. **Rechte des Bots = Mandat ∩ Halter ∩ Programm-Schalter ∩ „KI erlaubt“ ∩ KI-Regel.** Im Einzelnen:
   - das Mandat erlaubt eine Handlung ausdrücklich (Start leer; „ohne Befugnis nichts“, 0054);
   - der Halter darf sie **live** (nie eingefroren);
   - der Programm-Schalter ist AN;
   - die Situation ist wirksam „ja“;
   - die KI-Regel greift (Admin- und sensible Gruppen, Objekte und Felder: `NotFound`);
   - der Notaus ist nicht gezogen.
   In fs-groups ist das Recht des Bots **höchstens `Read`** (2.6.10). Zerstörendes und Handeln im Namen der Person fragt den Halter jedes Mal.
5. **Verbote für die KI und ihren Bot.** Nie: Admin werden, `Manage`, Admin benennen; Rechte, Rollen oder Mandate vergeben oder ändern; zustimmen, abstimmen, einladen, Einladungen annehmen; den Türsteher auslösen; den MCP-Schalter oder „KI erlaubt“ sehen oder ändern; Geheimnisse, Einwilligungen lesen oder schreiben; STOP oder Notaus abschalten; ein POSIX-, PAM- oder SSH-Konto erhalten (0082 Punkt 7); `MessageAction.decide` aufrufen; einen zweiten Bot starten.
6. **Ablauf der Eröffnung.** (a) Ein Mensch mit `Read` an der Situation schlägt Bot und Steuerer vor; das geht nur, wenn der Programm-Schalter AN ist und die Situation wirksam „ja“ hat. (b) Hinweis vor dem Eintritt: welche KI, welcher Anbieter, wohin der Text geht (0054 Punkt 2 und 3). (c) Zustimmung aller (Punkt 7). (d) Danach wird das Mandat `Active`; der Bot tritt ohne alten Verlauf ein.
7. **Zustimmung und Mitgliederkreis (2.6.4).** In einer Arbeitsgruppe stimmen **alle** wirksamen menschlichen Mitglieder zu. Neue Mitglieder werden vorgewarnt und müssen bestätigen, sonst kommen sie nicht hinein (Nutzerregel 29). In einer Konferenz oder einem Raum stimmen alle Anwesenden zu; Spätkommende gleich. Eine Absage heißt: kein Bot.
8. **Lebensdauer (2.6.3, Entscheidung 42).**
   - Arbeitsgruppe: `WhileGroup`. Das Mandat endet, wenn die Gruppe gelöscht wird, wirksam „nein“ bekommt (auch erzwungen über sensibel oder geschützt), bei STOP KI oder bei Widerruf.
   - Konferenz: `Until(Ende der Konferenz)`. Verlängern geht nur mit neuer Runde.
   - Tritt der Halter aus oder verliert er die Berechtigung, **ruht** der Bot-Platz sofort (Schnittmenge leer). Ein anderes Mitglied kann Halter werden; dann gelten neue Zustimmungen. Sonst endet der Platz nach 7 Tagen.
   - Wechselt der Steuerer (andere KI oder anderer Anbieter), braucht es eine neue Zustimmung aller, denn die Zustimmung nennt, wohin der Text geht.
   - Ein Widerruf durch irgendeinen Menschen wirkt wie STOP KI (0054 Punkt 7).
9. **STOP KI (2.6.5).** Jeder anwesende Mensch kann drücken; die KI nie. Es wirkt in dieser Reihenfolge:
   - (a) Die Steuer-Sitzung wird **sofort lokal im Bot** getrennt. Das Bot-Token liegt im Bot, nicht bei der KI.
   - (b) Das Mandat wird `Stopped`. Der Bot **verlässt** die Situation; der Knopf verschwindet erst danach.
   - (c) Absicherung in Kanidm: API-Token zerstören und `account_expire` auf „jetzt“ setzen.
   - (d) Protokolleintrag (Punkt 12).
   Ein neuer Bot braucht danach eine neue Zustimmungsrunde aller (aus 2.6.4 abgeleitet; siehe Offen).
10. **Pflichtpunkt (2.6.11): „STOP darf sich nicht auf Kanidm verlassen.“** Kanidm nimmt ein zerstörtes API-Token bis 5 Minuten nach seiner Ausstellung weiter an (Gnadenfenster, Kanidm 1.11.0-dev, `server/lib/src/idm/serviceaccount.rs`, Prüfung der Ablaufzeit zuerst). Darum wirkt STOP zuerst im Bot selbst (9 a). Die Plattform prüft das Mandat bei **jedem** Aufruf: Ein Aufruf mit noch gültigem Token nach STOP wird vom Mandat abgewiesen, nicht von Kanidm. Dieser Punkt gilt in jedem Programm (programm-grundgerüst) und hat einen Test (Folgen).
11. **Kanidm: Service-Account `fsb-<uuid>` ohne KI-Attribut.**
    - Jeder Bot ist ein Kanidm-Service-Account mit `entry_managed_by` (ein Verwalter, nie eine KI). Er steht **nur** in der Gruppe `fs_delegates`. Er steht in keiner gespiegelten Gruppe, keiner Rollengruppe und keiner Gruppe aus `idm_high_privilege`.
    - Kanidm kennt keine KI-Markierung. Die KI-Steuerung steht im FreeSynergy-Ledger (Mandat in fs-groups bzw. im Raum-Programm, Karte in fs-people, Zuordnung `sub` zu `PersonRef` in fs-identity). In Kanidm steht sie nicht.
    - Ein Bot ist per Erkennung an zwei unabhängigen Zeichen als Bot zu erkennen: (i) `groups_uuid` enthält die UUID von `fs_delegates`; (ii) fs-identity ordnet `sub` dem Bot zu, und `PersonFacts` liefert „Bot“. Fehlt eines oder widersprechen sie sich, wird der Aufrufer als KI behandelt, abgelehnt und mit dem Befund `DelegateMismatch` protokolliert (im Zweifel nein). Ein Mensch ohne `fs_delegates` ist nie ein Bot.
    - Anmeldung bei Programmen über RFC 8693 Token Exchange (Scope-Map je Programm nur `openid groups`). Das Bot-API-Token ist nur lesend; der Bot schreibt nie in Kanidm.
    - Ein Bot in einer anderen Kanidm-Gruppe ist ein Befund `Foreign` und wird nur auf Bestätigung entfernt.
    - Die Kette Bot → Halter → KI kommt aus dem Mandat, nicht aus dem Token (`actor_token` wird nicht unterstützt).
12. **Protokoll.** Jede Handlung ist eine AS2-Aktivität mit `actor` = Bot und `instrument` = KI-Karte mit Verweis auf das Mandat. Angezeigt wird „Bot X, gesteuert von KI Y, beauftragt von Z“, im Verlauf, in fs-activity und bei Nachrichten. Ein Bot ohne Steuerung bleibt sichtbar markiert.
13. **Keine KI-Gruppen mehr: „Bot-Platz“.** An die Stelle der KI-Gruppen tritt der **Bot-Platz** (Mandat in einer normalen Gruppe). Die Begriffe „KI-Gruppe“, KI-Rolle und KI-Konto entfallen. Der Bot wird **nie echtes Mitglied** (er würde nach `BottomUp` vererben und so die Obergrenze brechen). Die KI-Kette (`AiRoleForbidden` und die Fix-Runden) schrumpft entsprechend.
14. **Vorrat (2.6.9).** Bot-Konten in Kanidm legt ein Mensch per Skript als Vorrat an (Gate `human`). Die Gruppe `fs_delegate_keepers` enthält nur das Dienstkonto `fs_delegate_keeper`, getrennt vom Türsteher. Der Keeper gibt Konten aus und nimmt sie zurück (Token, Ablauf, Anzeigename). Die Zuordnung (Konto, Mandat, Zeitfenster) steht im Ledger.
15. **Gegenmittel gegen Diebstahl.** Bots stehen in keiner Login-Gruppe (0082 Punkt 7). Token sind kurzlebig und im Tresor. Ein Bot-Token allein gibt nur `fs_delegates` und lesenden Kanidm-Zugriff; Programm-Rechte bestehen nur bei aktivem Mandat und innerhalb der Obergrenze.
16. **Bots nur mit fs-groups (2.6.8).** Ein Bot in Gruppen gibt es nur, wenn fs-groups angeschlossen ist, nicht mit einem fremden Anmeldedienst allein. Konferenzen laufen über fs-messages.
17. **Umgang mit dem laufenden Fix (2.6.6).** Der laufende groups_v1-Fix B5 (H20/H21) ist **gestoppt**. Der Branch `unreviewed/groups-delta` (30a8860) bleibt stehen, es wird nichts fixiert. Sein Nicht-KI-Teil (z. B. H20 `role_restore`) geht in die gemeinsame Trait-Runde.

## Folgen
Nur die Liste. Nichts davon ist in diesem ADR eingebaut.

- **groups_v1:** Streichen: `Group::ai`, `GroupDraft.ai`, `GroupPatch.ai`, `GroupSummary.ai`; die Regel „`ai` mit `ai_allowed` = Invalid“; `RoleKind::Ai` samt `Error::AiRoleForbidden`; `Error::AiNotMirrored`; Befund `AiGroupExcluded`; KI-Fälle in `AiNesting`, `AiStatusUnknown`, `KindMismatch`; KI-Kette `reaches_admin`; „KI-Gruppe nur `Single`-Blatt“; Weg (ii) „Grant an KI-Gruppe oder KI-Konto“. Ändern: `PersonFacts::is_agent` wird `kind(&PersonRef) -> Option<ActorKind>` mit `Human`, `Bot`, `Ai`; `ai_allowed` gilt für jede Gruppe und meint Bot-Platz und dessen Rechte. Neu: `BotSeat` mit `open_seat`, `seat_ready`, `stop_seat`, `end_seat`, `seats_of`, `seat_may_do`; Fehler `ConsentMissing`, `SeatNotActive`, `HalterLacks`, `AiAckRequired`. Ein Bot ist nie in `effective_members`, `GroupMembers` oder im Spiegel.
- **person_directory_v1:** `PersonView` bekommt `actor: ActorKind`. Der Bot als `asker` gilt immer als KI. Einwilligung `AiAssistance`: `recipient` ist der Bot; neu `controller` (Pflicht). Endet die Situation, wird die Einwilligung mit `ConsentOrigin::SituationEnded` als Widerruf festgehalten.
- **fs-access:** `Subject` bekommt `actor`, `on_behalf_of` (Halter) und `seat`. `policy` rechnet nach der Obergrenze, die Halter-Rechte frisch.
- **Türsteher (`fs_doorkeeper`):** neuer Prüfschritt `AiAckRequired` für Beitritte; getrennte Konten und Verwalter (`fs_selfmanaged` gegenüber `fs_delegate_keepers`).
- **fs-messages:** Der Bot ist Matrix-Teilnehmer mit eigenem Schlüssel, ohne `shared_history`-Schlüssel. Der STOP-Knopf erscheint, solange ein Bot anwesend ist. Konferenzen mit `Until` über `delegate_v1`, später.
- **MCP-Modul:** Die KI spricht MCP nur mit dem Bot. Programm-Schalter AUS heißt: der Bot ist dort `NotFound`. Ein Plugin bekommt kein eigenes MCP-Tor.
- **Neue Bibliothek `fs-delegate`:** Laufzeit, Steuer-Sitzung, STOP, Protokoll (AS2), MCP-Brücke. Name des Dienstes offen (siehe Offen).
- **programm-grundgerüst (Konformitätspunkte):** Bot-Rechte ⊆ Halter; STOP trennt sofort und lokal; der Bot prüft das Mandat bei jedem Aufruf (Pflichtpunkt 10); ein Bot ist nie Mitglied; Anzeige „gesteuert von …“; Einwilligung je Situation. Umsetzung nur über `workflow-pflege` zuerst.
- **Nachträge (eigene Aufträge):** 0054 (Punkte 1, 2, 10 und Nachtrag 1, Nachtrag 2), 0056 (Punkt 8), 0082 (KI-Regel, Entscheidung 5), 0076 (Tabelle „Wer?“). In diesem ADR sind diese Dokumente unverändert.

**Tests (beide Richtungen).**
- **Obergrenze:** Der Halter verliert ein Recht R; der Bot verliert R im nächsten Aufruf. Gegenprobe: Der Halter hat R und das Mandat erlaubt R; dann darf der Bot. Der Bot erhält nie mehr als `Read` in fs-groups; nie `Manage`, Admin, Rechteänderung oder Mandatänderung.
- **Zustimmung:** Eine Absage heißt kein Platz; alle Zusagen heißen `Active`. Ein Spätkommender ohne Bestätigung wird abgewiesen, mit Bestätigung aufgenommen. Ein Wechsel des Steuerers macht `Active` zu `Pending`.
- **Lebensdauer:** Gruppe gelöscht, wirksam „nein“ oder erzwungen sensibel: der Platz endet, der Widerruf steht in fs-people. Halter tritt aus: der Platz ruht sofort (der Bot hat keine Rechte); ohne neuen Halter endet er nach 7 Tagen. Konferenz-Ende: der Platz endet. Gegenprobe: Unverändertes Weiterlaufen beendet den Platz nicht.
- **STOP (Pflichtpunkt 2.6.11):** Die Steuer-Sitzung ist lokal in unter 1 s getrennt. Container-Test: Ein Kanidm-Token wird zerstört; im Gnadenfenster wird es vom Bot-Mandat abgewiesen, und Kanidm-Abweisung ist frühestens nach 5 Minuten belegt. Jeder Mensch kann drücken, die KI-Seite nie.
- **Kanidm-Container:** Ein Bot nur in `fs_delegates` hat im Claim `groups` nur diese Gruppe. Ein Bot in `fsg-*` ergibt `Foreign`. Token Exchange gelingt mit Scope-Map und schlägt ohne sie fehl. Bei `account_expire` in der Vergangenheit wird das Token abgewiesen. Ein Keeper-Schreibversuch auf `fs_doorkeeper` wird abgewiesen.
- **Erkennung:** Nur eines der beiden Zeichen ergibt `DelegateMismatch` und Ablehnung. Ein Mensch ohne `fs_delegates` wird nicht als Bot behandelt.
- **Datenschutz:** Fragt der Bot, fehlen sensible Felder und der Standort ist höchstens ungefähr (≈ 1 km). Fragt der Halter, ist alles genau.
- **Mutanten** in `seat_may_do`, `policy` und `decide`: Ziel 0 Überlebende.

### Offen
- **Keeper in der Klammer von 0056 Punkt 8.** Der Nachtrag nennt „Türsteher, Bots“. Der Keeper (`fs_delegate_keeper`) ist ein technisch nötiges Dienstkonto und fehlt darin. Wortlaut vor dem Nachtrag prüfen.
- **Neue Zustimmungsrunde für einen neuen Bot nach STOP** (2.6.5): aus 2.6.4 abgeleitet, nicht ausdrücklich bestätigt.
- **Konferenz-Bot ohne fs-groups** (2.6.8): ob erlaubt, ist aus dem Wortlaut nicht sicher ableitbar.
- **Name des Dienstes** (2.6.2): Die Bibliothek `fs-delegate` ist bestätigt; der Name des Dienstes ist offen (Alternative `fs-proxy`).
- **Ob tuwunel und die Programme Token Exchange annehmen**: [nicht belegt]. Alternative B (Token von fs-access statt Kanidm) ist nicht empfohlen; sie bricht 0054 Punkt 10 bei OIDC.
- **Zustimmungsrunden in großen Gruppen:** eine Absage genügt. Praktisch heißt das im Zweifel keine KI (0054 Offen).
- **`PersonArt`** (0085): Bot als `Person` mit `ActorKind` oder eigene Art.
- **Kanidm-Probe im Container** (Vorrat, Keeper, Token Exchange, `account_expire`, Gnadenfenster, Claim) ist noch nicht durchgeführt.
- **Sperre-Frage Bot in fs-groups:** ob der Bot später mehr als `Read` darf, bleibt ausgeschlossen (2.6.10 entschieden: höchstens `Read`).
