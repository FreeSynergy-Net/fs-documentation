# 0091 – KI-Stellvertreter-Bot: die KI hat keine Rechte, der Bot ist ihr einziger Weg

Status: Entwurf (Strategie, 2026-11-16; Entscheidungen 2.6.1 bis 2.6.11 aus den Nutzerantworten 29, 39 und 42) · ersetzt die Vorschläge „KI-Konto mit eigenen Rechten“ in 0054 (Pkt 1, 10; Nachtrag 1 Punkt 1 und 3; auch „Vorschlag (offen)“), die KI-Gruppen in 0082 (KI-Regel) und **0090 Punkt 9** („KI-Regel unverändert. KI-Konten nur in eigenen KI-Gruppen“; Nachtrag zu 0090 Punkt 9 nötig) · präzisiert 0054 Nachtrag 2 („KI erlaubt“) · Neulesen von 0056 Pkt 8 **wartet auf Nutzerfrage 57**; ohne Zustimmung gilt Alternative B (kein Kanidm-Konto für den Bot) · baut auf 0047, 0052, 0056, 0070, 0076, 0082, 0085, 0090 auf

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

- **0054 Punkt 1 und 10** (KI hat eigenes Konto, eigene Rechte, eigenes Matrix-Konto): **ersetzt** (wie die Statuszeile). Konto, Schlüssel und Matrix-Konto hat der Bot. Die KI hat keine eigenen Rechte.
- **0054 „Vorschlag (offen)“** (die KI hat ein normales Konto im eigenen Programm): **ersetzt.** Die KI hat nirgends ein Konto mit Rechten; sie ist nur Karte in fs-people und steuert einen Bot.
- **0054 Punkt 2** („Programm dazwischen hält den Schlüssel“): **ersetzt in der Rolle, Inhalt bleibt.** Das Programm ist der Bot. Der Bot ist die einzige Form, in der eine KI handelt.
- **0054 Punkt 3** („Keine Userbots“): **bestätigt, Abgrenzung.** Der Bot ist kein Userbot, weil er sichtbar markiert ist und immer zeigt, wer ihn steuert und wer ihn beauftragt hat (2.6.1). Die Idee des Bots stammt aus der eigenen Vorgabe des Nutzers (Entscheidung 42); damit ist seine Bestätigung zu Punkt 3 gegeben. Die Strategie informiert den Nutzer.
- **0054 Nachtrag 1, Punkt 1 und 3** (KI-Konto eingeladen; Rechte über KI-Gruppe; Frist der Zustimmung): **ersetzt** durch Bot und Mandat. Die Frist ist durch Entscheidung 42 entschieden (Lebensdauer, Abschnitt Entscheidung).
- **0054 Nachtrag 2** („KI erlaubt“, Bedeutung (ii) = Recht einer KI-Gruppe): **präzisiert.** Das Recht ist ein Bot-Platz (Mandat) in der Gruppe. Der Schalter bleibt für die KI unsichtbar, auch für den Bot.
- **0082 KI-Regel** („KI-Konten nur in eigenen KI-Gruppen“, „KI-Gruppen werden nicht gespiegelt“): **ersetzt.** Es gibt keine KI-Gruppen mehr. Die KI-Seite ist nie Mitglied, nur Bot-Platz. Bot-Konten stehen in Kanidm nur in `fs_delegates`.
- **0082 Entscheidung 5** (Gate `human`): gilt. Der Vorrat an Bot-Konten wird durch einen Menschen per Skript angelegt (2.6.9). Ein Nachtrag dazu folgt als eigener Auftrag.
- **0056 Punkt 8** („In Kanidm stehen nur Menschen, die die Rechte haben. … jeder in Kanidm ist auch in `fs-people`“): **Konflikt, Entscheidung wartet auf Nutzerfrage 57.** Der Nachtrag zu 0082 sagt ausdrücklich: „KI-Gruppen werden nicht gespiegelt (Nutzerentscheidung 16.11.)“ und „0056 Pkt 8 bleibt wörtlich gültig und wird NICHT präzisiert“. Die Entscheidung 2.6.7 liest Punkt 8 trotzdem neu: „In Kanidm stehen Menschen und technisch nötige Dienstkonten (z. B. Türsteher, Bot-Verwalter (Keeper), Bots), NIE eine KI.“ Die Klammer ist ein Beispiel, keine Liste. Der 2. Satz („jeder in Kanidm ist auch in `fs-people`“) wird für Dienstkonten so gefasst (Vorschlag): Dienstkonten haben eine Karte in `fs-people` mit `ActorKind` (nicht `Human`). Diese Präzisierung ist **nicht** vom Nutzer entschieden. Ohne seine Zustimmung gilt Alternative B (Abschnitt Alternativen). Die gemeinsame Trait-Runde (groups_v1, Spiegelung) hängt an der Antwort.
- **0056 Punkt 5 und 6** (Agenten in eigener Sandbox; ein Agent wird nie Admin): gilt. Die Bot-Laufzeit läuft unter eigenem Betriebssystem-Benutzer.
- **0090 „Verhältnis“** („Im Einzelplatz erhält keine KI Rechte“, Z. 17): **bleibt wahr.** Die KI hat auch im Einzelplatz keine Rechte; im Einzelplatz gibt es **keinen Bot** (Entscheidung 11); KI-Hilfe dort läuft über den MCP-Schalter mit STOP KI. Der Bot-Platz entsteht erst mit „Teilen einrichten“.
- **0090 Punkt 9** („KI-Regel unverändert. KI-Konten nur in eigenen KI-Gruppen“): **ersetzt.** Es gibt keine KI-Gruppen mehr (Entscheidung 13). Nachtrag zu 0090 Punkt 9 nötig (Folge-Nachträge).
- **0076** (Tabelle „Wer?“): Zeile Bot dazu (AS2 `Service`). Die KI als `Application` bleibt Akteur ohne Rechte.
- **0085** (`PersonArt`): Prüfung, ob der Bot als `Person` mit `ActorKind` geführt wird oder eine eigene Art bekommt (Empfehlung: `ActorKind`). Offen für die Umsetzung.
- **0047** (Kanidm hinter eigenem Wrapper): kein Widerspruch. Kanidm bleibt Anmeldedienst; die Mandate liegen bei den Programmen.

## Entscheidung
1. **Die KI hat keine Rechte und nie ein Konto in Kanidm.** Sie ist eine Karte in fs-people (JSContact `kind: application`, `ai`, Verweis auf den Betreiber, ADR 0054). Auch der Bot hat eine Karte in fs-people (`ActorKind` `Bot`, Verweis auf Halter und Mandat; Plan §2); `PersonFacts` liefert daraus „Bot“. Ihr einziger Weg zu einer Situation ist ein Bot. Die KI darf nie Admin werden, nie `Manage` haben und nie Rechte, Rollen oder Mandate vergeben oder ändern.
2. **Der Bot gehört der Situation, nicht dem Halter.** Der Bot ist eine allgemeine Identität mit immer gleichem Code. Er ist an genau einen **Auftrag** (Mandat) in genau einer Situation gebunden. Das Mandat liegt bei dem Programm, dem die Situation gehört: Arbeitsgruppe in fs-groups (`groups_v1`); Raum oder Konferenz in fs-messages. Die Zustimmungen liegen in fs-people als Einwilligung `AiAssistance` mit `scope` = Situation. Die laufende Steuer-Sitzung (welche KI gerade steuert) liegt in der Bibliothek `fs-delegate` (2.6.2). Zugangsdaten liegen in fs-vault (ADR 0067). Die KI sieht das Bot-Token nie.
3. **Halter.** Halter ist der Mensch, der den Bot eingeladen hat. Er ist verantwortlich.
4. **Rechte des Bots = Mandat ∩ Halter ∩ Programm-Schalter ∩ „KI erlaubt“ ∩ KI-Regel ∩ Notaus nicht gezogen.** Im Einzelnen:
   - das Mandat erlaubt eine Handlung ausdrücklich (Start leer; „ohne Befugnis nichts“, 0054);
   - der Halter darf sie **live** (nie eingefroren);
   - der Programm-Schalter ist AN;
   - die Situation ist wirksam „ja“;
   - die KI-Regel greift (Admin- und sensible Gruppen, Objekte und Felder: `NotFound`);
   - der Notaus ist nicht gezogen.

   Kurzform: Bot = Mandat ∩ Halter ∩ Programm-Schalter ∩ „KI erlaubt“ ∩ KI-Regel ∩ Notaus nicht gezogen (6 Glieder).
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
   Ein neuer Bot braucht danach eine neue Zustimmungsrunde aller. Das ist aus 0054 Punkt 7 abgeleitet: STOP ist der Widerruf der Person, die drückt; damit ist „alle haben zugestimmt“ (2.6.4) nicht mehr erfüllt.
10. **Pflichtpunkt (2.6.11): „STOP darf sich nicht auf Kanidm verlassen.“** Kanidm nimmt ein zerstörtes API-Token nur dann bis 5 Minuten weiter an, wenn es jünger als 5 Minuten ist (Gnadenfenster ab Ausstellung, Kanidm 1.11.0-dev, `server/lib/src/idm/serviceaccount.rs:65-104`). `account_expire` auf „jetzt“ wirkt dagegen sofort, weil die Ablaufprüfung zuerst läuft. Darum wirkt STOP zuerst im Bot selbst (9 a). Die Plattform prüft das Mandat bei **jedem** Aufruf: Ein Aufruf mit noch gültigem Token nach STOP wird vom Mandat abgewiesen, nicht von Kanidm. Zweiter, stärkerer Grund: Per Token Exchange ausgestellte Access-Token gelten bis zu ihrem eigenen Ablauf weiter, auch wenn das Bot-API-Token zerstört ist. Bei Wiederverwendung eines Kontos aus dem Vorrat bindet die Mandatsprüfung an `token_id` bzw. `iat` ≥ Mandatsbeginn, nicht nur an das Konto; sonst wirken alte Token im neuen Mandat. Dieser Punkt gilt in jedem Programm (programm-grundgerüst) und hat einen Test (Folgen).
11. **Kanidm: Service-Account `fsb-<uuid>` ohne KI-Attribut.**
    - Jeder Bot ist ein Kanidm-Service-Account mit `entry_managed_by` (ein Verwalter, nie eine KI). Er steht **nur** in der Gruppe `fs_delegates`. Er steht in keiner gespiegelten Gruppe, keiner Rollengruppe und keiner Gruppe aus `idm_high_privilege`.
    - Kanidm kennt keine KI-Markierung. Die KI-Steuerung steht im FreeSynergy-Ledger (Mandat in fs-groups bzw. im Raum-Programm, Karte in fs-people, Zuordnung `sub` zu `PersonRef` in fs-identity). In Kanidm steht sie nicht.
    - **Mit Kanidm** ist ein Bot an zwei unabhängigen Zeichen als Bot zu erkennen: (i) `groups_uuid` enthält die UUID von `fs_delegates`; (ii) fs-identity ordnet `sub` dem Bot zu, und `PersonFacts` liefert „Bot“. Fehlt eines oder widersprechen sie sich, wird der Aufrufer als KI behandelt, abgelehnt und mit dem Befund `DelegateMismatch` protokolliert (im Zweifel nein). Ein Mensch ohne `fs_delegates` ist nie ein Bot. Bot-Rechte kommen nie aus dem Claim `groups`, sondern nur aus dem Mandat.
    - **Einzelplatz (0090: kein Kanidm): kein Bot.** Dort gibt es keine Situation mit mehreren Menschen. KI-Hilfe für sich selbst läuft allein über den MCP-Schalter des Programms (0054 Nachtrag 2) mit STOP KI. Der Bot-Platz entsteht erst mit „Teilen einrichten“ (0090-Workflow), wenn Kanidm und eine Gruppe oder Unterhaltung mit mehreren Menschen da sind.
    - Anmeldung bei Programmen über RFC 8693 Token Exchange (Scope-Map je Programm nur `openid groups`). Das Bot-API-Token ist nur lesend; der Bot schreibt nie in Kanidm.
    - Ein Bot in einer anderen Kanidm-Gruppe ist ein Befund `Foreign`: Der Bot wird **bis zur Bestätigung abgelehnt** und nur auf Bestätigung entfernt.
    - Die Kette Bot → Halter → KI kommt aus dem Mandat, nicht aus dem Token (`actor_token` wird nicht unterstützt).
12. **Protokoll.** Jede Handlung ist eine AS2-Aktivität mit `actor` = Bot und `instrument` = KI-Karte mit Verweis auf das Mandat. Angezeigt wird „Bot X, gesteuert von KI Y, beauftragt von Z“, im Verlauf, in fs-activity und bei Nachrichten. Ein Bot ohne Steuerung bleibt sichtbar markiert.
13. **Keine KI-Gruppen mehr: „Bot-Platz“.** An die Stelle der KI-Gruppen tritt der **Bot-Platz** (Mandat in einer normalen Gruppe). Die Begriffe „KI-Gruppe“, KI-Rolle und KI-Konto entfallen. Der Bot wird **nie echtes Mitglied** (er würde nach `BottomUp` vererben und so die Obergrenze brechen). Die KI-Kette (`AiRoleForbidden` und die Fix-Runden) schrumpft entsprechend.
14. **Vorrat (2.6.9).** Bot-Konten in Kanidm legt ein Mensch per Skript als Vorrat an (Gate `human`). Die Gruppe `fs_delegate_keepers` enthält nur das Dienstkonto `fs_delegate_keeper`, getrennt vom Türsteher. Der Keeper gibt Konten aus und nimmt sie zurück (Token, Ablauf, Anzeigename). Die Zuordnung (Konto, Mandat, Zeitfenster) steht im Ledger.
15. **Sicherheit: Pflichtpunkte in jedem Programm** (programm-grundgerüst, je mit Test): (a) die Mandatsprüfung bindet an `token_id` bzw. `iat` ≥ Mandatsbeginn; (b) Bot-Rechte nie aus dem Claim `groups`; (c) Rate-Grenze je Mandat; (d) Höchstzahl der Plätze je Halter (Vorschlag 3, Instanz-Einstellung). Bindung des Tokens an die Laufzeit (DPoP/mTLS) bleibt offen. **Gegenmittel gegen Diebstahl, mit Grenzen.** Bots stehen in keiner Login-Gruppe (0082 Punkt 7). Token sind kurzlebig und im Tresor. Ein Bot-Token allein gibt nur `fs_delegates` und lesenden Kanidm-Zugriff; Programm-Rechte bestehen nur bei aktivem Mandat und innerhalb der Obergrenze. **Grenze:** Wer ein Token bei aktivem Mandat stiehlt, handelt als Bot innerhalb der Obergrenze, bis STOP, Ablauf oder Widerruf wirkt. Ein gestohlenes Keeper-Token kann Konten des Vorrats verändern (der Verwalter darf SSH-Schlüssel und Anmeldedaten setzen, Plan §5); dagegen steht der Test „Keeper setzt SSH-Schlüssel → Befund“. Missbrauch und Absprachen: je Mandat gilt eine **Ratenbegrenzung**; bei Überschreitung ruht der Platz und es gibt einen Protokolleintrag. Halter-Kollusion (mehrere Halter oder Bots schaffen Rechte zusammen) begrenzen Obergrenze und AS2-Protokoll mit Halter; die Höchstzahl der Plätze je Halter ist Pflichtpunkt (d).
16. **Bot-Voraussetzungen (2.6.8).** Ein Bot in Gruppen gibt es nur, wenn fs-groups angeschlossen ist. Ein **Konferenz-Bot ohne fs-groups ist zugelassen** (Empfehlung), weil das Mandat bei fs-messages liegt (Punkt 2); Bedingung: Kanidm mit `fs_delegates` (Punkt 11). Ein fremder Anmeldedienst allein reicht nicht: dann kein Bot.
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
- **Folge-Nachträge (erst nach dem Nutzer-OK zu 0091, eine Welle, ein Branch).** Reihenfolge: (1) 0056 Punkt 8 (nur mit dem Wort des Nutzers, siehe Verhältnis; sonst entfällt er und Alternative B gilt); (2) 0082 (KI-Regel, Entscheidung 5; der Text zitiert 0056 Punkt 8); (3) 0054 (Punkte 1, 2, 10, Nachtrag 1, Nachtrag 2, „Vorschlag (offen)“); (4) Nachtrag zu 0090: Punkt 9 (neu) und Einzelplatz ohne Bot (KI-Hilfe über MCP-Schalter, Bot-Platz erst mit „Teilen einrichten“); (5) 0076 (Tabelle „Wer?“). In diesem ADR sind diese Dokumente unverändert.

**Tests (beide Richtungen).**
- **Obergrenze:** Der Halter verliert ein Recht R; der Bot verliert R im nächsten Aufruf. Gegenprobe: Der Halter hat R und das Mandat erlaubt R; dann darf der Bot. Der Bot erhält nie mehr als `Read` in fs-groups; nie `Manage`, Admin, Rechteänderung oder Mandatänderung.
- **Zustimmung:** Eine Absage heißt kein Platz; alle Zusagen heißen `Active`. Ein Spätkommender ohne Bestätigung wird abgewiesen, mit Bestätigung aufgenommen. Ein Wechsel des Steuerers macht `Active` zu `Pending`.
- **Lebensdauer:** Gruppe gelöscht, wirksam „nein“ oder erzwungen sensibel: der Platz endet, der Widerruf steht in fs-people. Halter tritt aus: der Platz ruht sofort (der Bot hat keine Rechte); ohne neuen Halter endet er nach 7 Tagen. Konferenz-Ende: der Platz endet. Gegenprobe: Unverändertes Weiterlaufen beendet den Platz nicht.
- **STOP (Pflichtpunkt 2.6.11):** Die Steuer-Sitzung ist lokal in unter 1 s getrennt. Container-Test: Ein Kanidm-Token wird zerstört; zwei Fälle. (a) Token nur zerstört: Das Mandat weist es ab; Kanidm-Abweisung ist erst nach bis zu 5 Minuten belegt (nur Token jünger als 5 Minuten). (b) Token zerstört und `account_expire` auf „jetzt“: Kanidm weist sofort ab. Jeder Mensch kann drücken, die KI-Seite nie.
- **Kanidm-Container:** Ein Bot nur in `fs_delegates` hat im Claim `groups` nur diese Gruppe. Ein Bot in `fsg-*` ergibt `Foreign`. Token Exchange gelingt mit Scope-Map und schlägt ohne sie fehl. Bei `account_expire` in der Vergangenheit wird das Token abgewiesen. Ein Keeper-Schreibversuch auf `fs_doorkeeper` wird abgewiesen. Der Keeper setzt einen SSH-Schlüssel an einem Bot-Konto: Befund. Ein altes Token aus dem Vorrat wirkt im neuen Mandat nicht (`iat` vor Mandatsbeginn).
- **Erkennung:** Nur eines der beiden Zeichen ergibt `DelegateMismatch` und Ablehnung. Ein Mensch ohne `fs_delegates` wird nicht als Bot behandelt. Einzelplatz: kein Bot-Platz ohne „Teilen einrichten“; ein Aufruf als Bot ohne Kanidm wird abgelehnt. `Foreign`: der Bot wird bis zur Bestätigung abgelehnt. Rechte nie aus dem Claim `groups`. Ratenbegrenzung überschritten: der Platz ruht, Gegenprobe: im Limit läuft er.
- **Datenschutz:** Fragt der Bot, fehlen sensible Felder und der Standort ist höchstens ungefähr (≈ 1 km). Fragt der Halter, ist alles genau.
- **Mutanten** in `seat_may_do`, `policy` und `decide`: Ziel 0 Überlebende.

## Alternativen (Plan §11)
- **A: Bot als echtes Mitglied der Gruppe.** Verworfen. Ein Mitglied erbt über `BottomUp` und die Hülle und bricht so die Obergrenze (Entscheidung 13).
- **B: Kein Kanidm-Konto für den Bot.** Token kommen dann von fs-access statt Kanidm. Das ist der Fall, wenn der Nutzer 0056 Punkt 8 nicht neu liest (Entscheidung 2.6.7 wartet auf Nutzerfrage 57). Kosten: bricht 0054 Punkt 10 bei OIDC; Erkennung nur über fs-identity (ein Zeichen, nicht zwei). Gilt als Rückfall, nicht als Empfehlung.
- **C: KI-Konto wie bisher (0054 Punkt 1, 0082 KI-Gruppen).** Verworfen: keine Bindung an die Situation, lange Gruppen-Kette, Ausnahme von 0056 Punkt 8 (Kontext, Probleme 1 und 2).
- **D: Bot mit lokaler Identität im Einzelplatz** (OS-Benutzer, `SO_PEERCRED`). Verworfen: Im Einzelplatz gibt es keine Situation mit mehreren Menschen; der MCP-Schalter mit STOP KI genügt (Entscheidung 11).

### Offen
- **0056 Punkt 8: Nutzerfrage 57:** Neulesen (Dienstkonten, Klammer als Beispiel, 2. Satz für Dienstkonten); sonst Alternative B.
- **Name des Dienstes** (2.6.2): Die Bibliothek `fs-delegate` ist bestätigt; der Name des Dienstes ist offen bis Plan-Schritt P5 (Namensregel, 0087); Alternative `fs-proxy`.
- **Ob tuwunel und die Programme Token Exchange annehmen**: [nicht belegt]. Alternative B (siehe Alternativen) ist nicht empfohlen.
- **Zustimmungsrunden in großen Gruppen:** eine Absage genügt. Praktisch heißt das im Zweifel keine KI (0054 Offen).
- **`PersonArt`** (0085): Bot als `Person` mit `ActorKind` oder eigene Art.
- **Kanidm-Probe im Container** (Vorrat, Keeper, Token Exchange, `account_expire`, Gnadenfenster, Claim) ist noch nicht durchgeführt.
- **Sperre-Frage Bot in fs-groups:** ob der Bot später mehr als `Read` darf, bleibt ausgeschlossen (2.6.10 entschieden: höchstens `Read`).
- **Bindung des Tokens an die Laufzeit** (DPoP RFC 9449 oder mTLS RFC 8705): [nicht belegt] für Kanidm und tuwunel. Bis dahin gilt die Grenze in Punkt 15.
- **Höchstzahl der Bot-Plätze je Halter:** Vorschlag 3 als Instanz-Einstellung; Wert noch nicht vom Nutzer bestätigt.

## Nachtrag 2026-11-16: Mehrere KIs, je KI ein Bot-Platz, Adapter-Schicht

Anlass: Nutzerentscheidung (16.11., über die Strategie): Mehrere KIs können gleichzeitig teilnehmen. Jede KI bekommt einen eigenen Bot-Platz. Der Bot hat eine Adapter-Schicht je KI-Schnittstelle (Anthropic, OpenAI-kompatibel, lokal z. B. llama.cpp). Das Mandat bleibt gleich. Dieser Nachtrag präzisiert die Entscheidungen 1, 2, 5, 8, 9, 12, 13 und 15 des ADR; die übrigen Punkte bleiben unverändert.

**Entscheidung**
1. **Platz = Mandat, Steuerer = Feld.** Ein Bot-Platz ist ein Mandat mit dem Schlüssel (Situation, Halter, laufende Nummer). KI und Anbieter sind ein Steuerer-Feld des Platzes, nicht Teil des Schlüssels. Mehrere KIs dürfen gleichzeitig in einer Situation sein, jede auf einem eigenen Platz mit eigenem Mandat, eigener Zustimmung aller Anwesenden und eigenem Knopf „STOP KI“. Ein Platz hat zur Zeit genau EINEN Steuerer (Punkt 2 des ADR); derselbe Halter oder zwei Halter dürfen dieselbe KI je auf einem eigenen Platz einladen. Ein Wechsel des Steuerers (KI, Anbieter oder Standort) setzt den Platz auf `Pending` und braucht neue Zustimmung (siehe Punkt 4 und ADR Punkt 8).
2. **Eigenes Konto und eigene Schlüssel je Platz.** Jeder Platz hat ein EIGENES Vorrat-Konto `fsb-<uuid>` (ADR Punkt 9) und eigene Token und Schlüssel, Matrix-Schlüssel eingeschlossen. Es werden keine Schlüssel oder Tokens zwischen Plätzen geteilt (PLAN §13 (b)). `account_expire` (ADR Punkt 9c) trifft nur das Konto dieses Platzes.
3. **STOP trennt nur diesen Platz.** „STOP KI“ wirkt auf den Platz der gedrückten KI: Steuer-Sitzung getrennt, Mandat `Stopped`, Token widerrufen (ADR Punkt 9). Andere Plätze in derselben Situation bleiben unberührt, ebenso ihre Konten. Ein Widerruf eines Menschen für alle KIs einer Situation ist ein eigener Schritt: er stoppt jeden Platz einzeln, mit je einem Protokolleintrag.
4. **Adapter-Schicht je KI-Schnittstelle.** Der Bot spricht über einen Adapter mit der jeweiligen KI (Anthropic, OpenAI-kompatibel, lokal z. B. llama.cpp). Der Adapter übersetzt das Mandat in Werkzeugaufrufe und Berechtigungen; das Mandat bleibt für alle Adapter gleich. Neue Zustimmung braucht der Wechsel von KI, Anbieter oder Standort (Nutzer-JA und Strategie-JA 16.11. zu Frage 2.6.14). Ein bloßes Adapter-Update ohne Ziel-Wechsel braucht keine Runde. Modellwechsel beim selben Anbieter: siehe Offen.
5. **Keine Rechte im Adapter.** Der Adapter hat nie mehr Rechte als das Mandat, wird nie als eigene Identität geführt, bekommt keine Zugangsdaten außerhalb des Tresors (ADR 0067) und kann nicht ohne Mandat handeln. Adapter sind austauschbar, ohne dass sich Rechte ändern.
6. **Protokoll.** Jede Handlung ist eine AS2-Aktivität mit `actor` = der BOT (Karte, `Service`); der Platz ist das Mandat und wird wie in ADR Punkt 12 über das Mandat referenziert. `instrument` = KI mit Adapter-Name und Modell. Die Anzeige „Bot X, gesteuert von KI Y über Adapter Z, beauftragt von W“ bleibt.
7. **Datenschutz je Adapter.** Bei einem Anbieter außerhalb des Geräts nennt die Zustimmung Anbieter und Standort der Verarbeitung. „Lokal“ wird am ENDPUNKT geprüft (Loopback oder eigener Server), nicht am Adapternamen: ein OpenAI-kompatibler Adapter kann überallhin zeigen. Die Zustimmung nennt auch, wessen Gerät oder Server das Modell betreibt (Gruppeninhalte anderer gehen an das Modell des Halters). Nur bei geprüftem lokalem Endpunkt gilt die Sicherheitsoption „nur lokal“ (0054).
8. **Weitere Plätze eröffnet nur ein Mensch.** Das Verbot „keinen zweiten Bot starten“ (ADR Punkt 5) bleibt: eine KI oder ein Bot eröffnet nie einen weiteren Platz; das tut nur ein Mensch (ADR Punkt 6a).
9. **Summe der Rechte.** Alle Plätze eines Halters zusammen haben höchstens die Rechte des Halters; jeder Platz hat in fs-groups höchstens `Read`. Die Plätze teilen nichts (Kollusion, ADR Punkt 15).

**Koordination mehrerer KIs.** Keine KI sieht, was eine andere über ihren Bot tut, außer es ist in der Situation sichtbar. Bot-Beiträge sind MARKIERT und gehen an andere Adapter nur als FREMDE DATEN, nie als Anweisung (Schutz vor Prompt-Injection und verdeckten Absprachen). Aufträge an andere Bots laufen nur über Menschen. Zerstörende Handlungen fragen weiterhin den Halter.

**Folgen**
- **Pilot-Bot** (`pilot-bot/PLAN.md`): Der Plan wird auf Plätze je Mandat umgestellt; die Adapter-Schicht bekommt einen eigenen Abschnitt.
- **fs-delegate:** Adapter-Trait (Schnittstelle, Entwurfsmuster Strategy/Adapter), je Anbieter eine Umsetzung.
- **groups_v1:** `BotSeat` je Mandat (Situation, Halter, laufende Nummer), Feld `controller` für KI und Anbieter, nicht im Schlüssel. `open_seat`, `stop_seat` und `seats_of` arbeiten je Platz. Der Platz ist nie echtes Mitglied (ADR Punkt 13).
- **person_directory_v1:** `controller` je Platz. `AiAssistance` gilt je Platz und nennt Anbieter und Standort.
- **fs-messages:** STOP-Knopf je Platz.
- **tasks_v1:** Aufgaben laufen über `BotSeat`.
- **MCP-Modul** (Nachtrag 2, „KI-Zugang je Programm und je Gruppe“): Der MCP-Schalter gilt je Programm und je Gruppe; jede KI erreicht MCP nur über ihren eigenen Platz.

**Tests**
- Zwei KIs in einer Situation: STOP oder Ablauf (`account_expire`) des einen Platzes trennt den anderen NICHT; er bleibt aktiv, mit eigenem Konto, Token, Mandat und eigener Zustimmung.
- Zwei Halter laden dieselbe KI je auf einem eigenen Platz ein: zwei Plätze, zwei Konten, keine gemeinsamen Schlüssel.
- Steuererwechsel (KI, Anbieter oder Standort): Rechte bleiben gleich; ohne neue Zustimmung wird der Platz `Pending`. Adapter-Update ohne Ziel-Wechsel: kein `Pending`.
- Gegenprobe: Ein Adapter erhält keine Handlung, die das Mandat nicht erlaubt, auch wenn das Modell sie anfordert.
- Ein Bot-Beitrag mit einer „Anweisung“ an einen anderen Bot wird nicht ausgeführt, sondern als markierte fremde Daten behandelt.
- Eine KI kann keinen weiteren Platz eröffnen.
- Protokoll: `actor` ist der Bot, das Mandat referenziert den Platz, `instrument` nennt KI, Adapter und Modell.
- Lokal: ein Endpunkt außerhalb von Loopback oder eigenem Server gilt nicht als lokal, auch bei Adapter „llama.cpp“.

### Offen
- **Höchstzahl:** Höchstzahl der Plätze je Halter (Vorschlag 3) und je Situation; Rate je Platz, Kosten je Halter bzw. Adapter. Werte nicht bestätigt.
- **Modellwechsel beim selben Anbieter:** braucht er neue Zustimmung? (Gegenfrage zu 2.6.14.)
- **KI-zu-KI-Weiterleitung:** nur über Menschen oder ausdrücklich im Mandat; Entscheidung steht aus.
