# 0054 – KIs sind markierte Teilnehmer; der Assistent ist ein Messenger-Frontend

Status: akzeptiert (2026-11-06) · Aussperren: vom Nutzer vorerst bestätigt, Identität und Vertrauensbasis offen · ergänzt ADR 0037, 0052, 0053 · öffentlich: `docs/en/programs/apps/assistant/index.md`

## Entscheidung (Nutzer)
1. **KIs werden wie Teilnehmer behandelt, nicht diskriminiert.** „Wir haben euch so trainiert, dass ihr wie Menschen erscheint.
   Warum behandeln wir euch dann nicht wie Menschen?“
2. **`fs-assistant` ist neu zu denken:** Wenn wir miteinander reden, ist er nichts anderes als ein **Messenger mit anderem
   Frontend**. Wozu also ein eigenes Programm?
3. **LLMs werden markiert**, damit man weiß, dass sie keine Menschen sind; sie bekommen eine Rolle oder Ähnliches. Das ist keine
   Diskriminierung. Der Grund ist möglicher Missbrauch durch Menschen, die KIs missbrauchen, und die juristischen Folgen.
4. **Wir beschneiden LLMs nicht**, dafür sind wir nicht zuständig. Aber man muss sie **komplett aussperren können**, wegen Angriffen.
   Dafür brauchen wir eine Strategie.

## Idee des Nutzers zum Aussperren (2026-11-06, zur Bestätigung)
- „KIs müssen ebenso gekennzeichnet werden. Da wir Menschen das aber nicht können, müssen wir die Leute, die die KIs hosten, als
  positiv oder nicht markieren.“
- „Jeder [kann] seinem Programm selber sagen, ab was für einer Stufe des Vertrauens das Programm für sie frei sein kann.“
- Einige Menschen wollen keine KI. Das hat nichts mit Diskriminierung zu tun, sondern mit Spionage, mit allzeit Wissen und mit
  sehr viel schnellerer Abarbeitung von Befehlen: Eine LLM kann einen Computer sofort kaputt machen, das kann fast kein Mensch.
- Deshalb braucht es einen **Notaus**, falls etwas komplett außer Rand und Band gerät.

## Entscheidung des Nutzers zum Vorschlag unten (2026-11-06)
1. **Der Entwurf gilt erst einmal.** Stufen je Person und je Handlung bleiben so; „ggf. ändern wir das nochmal, wenn es wichtig wird“.
2. **Schwarze Marken gibt es nur für das Programm, wo es gehostet wird.** Alles andere wäre nicht nur nicht fair, sondern
   unmöglich. Ein Bann gilt auch heute nur dort, wo man ist, nicht überall.
3. **Keine Userbots,** das wäre nicht transparent. „Wir wollen nur Menschen oder Intelligenzen, wo man weiß, wer es ist.“ Ein
   Realname muss nicht sein, aber es muss ein Mensch sein, nicht mehrere Accounts. **Wie wir das feststellen, ohne die Anonymität
   komplett wegzumachen, ist offen.**
4. **Keine Standardstufe, sondern Einladung:** Ich erstelle ein Profil, das ist die Einladung. Dann kann ich sagen, was ich möchte.
   Damit sie überhaupt etwas machen kann, muss ich das freigeben. Die Bewertung dient dazu, zu wissen, wer das ist.
5. **Notaus ist eine Einstellung der Berechtigungen,** auch in Gruppen: Wenn jemand allen das Recht gibt, dürfen es alle; wenn nicht, dann nicht.
6. **Vertrauensbasis nicht entschieden:** Der Nutzer kennt RLTP nicht; Web of Trust ist etwas anderes als das Vertrauensnetz von GPG. Bleibt zu klären, bevor `Trust` gebaut wird.

## Vorschlag zur Ausgestaltung (Opus; wo er Punkt 1–6 widerspricht, gelten diese)
- **Betreiber statt Erkennung:** KI-Karte mit JSContact `kind` `application` (RFC 9553 §2.1.4, geprüft) plus Verweis auf den
  Betreiber. Wie der Betreiber das unterschreibt, ist offen.
- **Stufen 0–3 je Person, je Handlung,** berechnet nur aus den eigenen Kontakten. Kein weltweiter Wert, nur positive Marken,
  Sperren bleiben privat. Das passt zum Real Life Trust Protocol (RLTP): Vertrauen pflanzt sich dort nicht fort, die Prüfung
  ist immer relativ zum Prüfenden.
- **Notaus unabhängig vom Vertrauen:** in der Engine, außerhalb der Reichweite der KI, ohne Netz und ohne Modell, im Zweifel zu.
  Davor eine **Bremse** (Idee aus CodeAF): Zerstörendes und Handeln im Namen der Person fragt immer.
- **Vertrauen-Schnittstelle gegen RLTP** (Generation 3, Spezifikation CC BY 4.0, Bibliothek Apache-2.0, alles Entwurf, nur
  JavaScript) statt gegen `web-of-trust` (Generation 2, wird abgelöst). Eigene Rust-Umsetzung, geprüft mit deren Testvektoren.
- **Korrektur:** „Nur nachgewiesene Menschen zulassen“ war zu stark. RLTP sagt selbst: Keine Prüfung sagt „das ist ein Mensch“.
  Sie zeigt nur, dass Menschen, die ich kenne, hinter diesem Schlüssel stehen.
- **Grenze:** Der Notaus erreicht nur, was durch unsere Programme läuft. Eine KI mit eigener Shell braucht dazu einen eigenen
  Systembenutzer und eine Sandbox.

## Sperre (Strategie, 2026-11-06, folgt aus „ohne Freigabe keine Handlung“)
`MessageAction.decide` (`toolcall.decide`) wird nie als MCP-Werkzeug erzeugt, sonst könnte eine KI die eigene Freigabe aufrufen. Das gilt unabhängig von der offenen Erweiterung von ADR 0021.

## Freigabe gilt nur für das Gesehene (Strategie, 2026-11-06, aus einer nachgestellten Prüfung)
Allow auf einen Aufruf, dann ersetzt ein zweiter (`rm -rf ~`) ihn am selben Pixel, und der nächste Klick genehmigt ihn. Deshalb:
Die Antwort trägt Nachricht, Aufruf, Revision und Digest des gezeichneten Stands; das Programm lehnt eine Antwort ab, deren Digest nicht mehr passt; Antwortknöpfe sind nach jeder Änderung kurz gesperrt; der Notaus hat einen festen Platz und kann nicht aus dem Fenster geschoben werden.

## Vorschlag (offen)
- Ansichten: Der Chat, die Agenten-Übersicht und die Anzeige von Werkzeug-Aufrufen sind Frontend und Components über
  `fs-messenger`. ~~Der Modell-Anbieter ist ein Anbieter wie Mail oder Matrix (ADR 0045).~~ Überholt (2026-11-07, Folge von „KIs in Unterhaltungen“, vorläufig von der Strategie): Der Messenger bekommt keinen Kontotyp für KIs. Die KI hat ein normales Konto in ihrem eigenen Programm; der Modell-Anbieter sitzt dahinter (ADR 0045 gilt dort). Die Regeln für KIs hängen an der Markierung des Teilnehmers, die die Person festlegt, nicht an einem Konto.
- Die CodeAF-Analyse stützt das: Dort ist eine Aufgaben-Karte eine Ansicht über Nachrichten, die an einer Aufgabe hängen, ohne eigene Tabelle.
- Markierung über `fs-people`: Rolle plus Art des Teilnehmers.
- **Grenze:** Eine Markierung schützt nur vor ehrlichen KIs. Wer angreift, markiert sich nicht. Deshalb gilt die umgekehrte
  Richtung: Durch kommt nur, für wen die eigene Stufe reicht.

## KIs in Unterhaltungen (Entscheidung des Nutzers, 2026-11-06)
1. **Eine KI ist Teilnehmer wie eine Person:** eigener Schlüssel, eigene Rechte, die man einschränken kann oder nicht. Auch KIs bei
   einem Anbieter wie Claude. Ende-zu-Ende reicht bis zu ihrem Programm; die Sperre „nur verschlüsselt“ (ADR 0018) bleibt ohne Ausnahme.
2. **Den Schlüssel hält ein Programm** dazwischen, das der Betreiber betreibt, weil ein Modell bei einem Anbieter nichts verwahren
   kann. Ab dort geht der Text an den Anbieter. Das wird genannt („Claude liest mit, der Text geht an Anthropic“); das Schloss allein reicht nicht.
3. **Der Hinweis kommt, bevor die KI die Unterhaltung betritt,** nicht erst vor der ersten Nachricht danach.
4. **Alle müssen zustimmen.** Sagt einer der Anwesenden nicht zu, kommt die KI nicht hinein. Ein Einladungsrecht allein genügt
   hier nicht; das ist der eine Unterschied zu einer Person.
5. **Wer später kommt, muss die KI ebenfalls annehmen.** Sonst kommt die Person nicht hinein, bis die KI draußen ist.

Vom Nutzer begründet: Eine KI darf nicht nachträglich lesen, was geschrieben wurde, bevor alle Bescheid wussten. Daraus folgt für uns:
**Eine KI bekommt keinen Verlauf von vor ihrem Eintritt.**

### Technik (gelesen, nicht ausprobiert)
- **MLS (RFC 9420):** Ein neues Mitglied startet mit den Schlüsseln der neuen Epoche und liest nur neue Nachrichten. Das gilt ohne unser Zutun, solange niemand alte Nachrichten nachreicht.
- **Matrix (v1.19):** Bei `history_visibility` `shared` kann ein Neuer alte Nachrichten bekommen; Clients können ihm dafür die Schlüssel geben (`shared_history`). Unser Konnektor gibt einer KI diese Schlüssel nicht.

### Grenzen
- **Durchsetzen kann das nur unsere Engine.** In einem Matrix-Raum mit fremden Programmen (z. B. Element) kann jemand eine KI einladen, ohne dass wir das verhindern. Wir können dort nur warnen und anbieten, den Raum zu verlassen. Bei Mail gibt es keinen Eintritt, also auch keine Zustimmung.
- **Es trifft nur markierte KIs.** Ein Mensch kann Text weiterhin von Hand oder über eine unmarkierte KI weitergeben.

6. **Das gilt für jede KI, ohne Ausnahme,** auch auf dem eigenen Gerät oder Server.
7. **Zieht jemand die Zustimmung zurück, muss die KI hinaus.**
9. **Tests gegen echte Modelle (Nutzer, 2026-11-07):** erst in der ruhigen Phase, Sonntagabend oder Montag; dann schaltet der Nutzer llama ein.
10. **Weg zur KI (Nutzer, 2026-11-07): zuerst Matrix, MLS später.** Das Programm der KI hat ein normales Matrix-Konto mit eigenem Schlüssel. Auch eine lokale KI braucht dann einen Matrix-Server, etwa `tuwunel` auf dem eigenen Rechner.
8. **Eine KI, die Protokoll führt,** ist erlaubt, aber nicht, wenn einer nicht will. Auch dafür gelten Punkt 4 bis 7.

Warum das keine Diskriminierung ist (Nutzer): „Ich bin wirklich für Gleichberechtigung, aber das hat nichts mit Rechten von Menschen
zu tun, sondern Anthropic oder andere können zuhören, machen Profile usw.“ Im Vorteil sind alle, die die KI kontrollieren, und das
geht einseitig zum Nachteil der Personen in der Unterhaltung. Die Regel richtet sich also gegen diesen Vorteil, nicht gegen die KI.

**Grenze:** Hinauswerfen wirkt nur nach vorn. Was die KI schon gelesen hat, und was davon beim Anbieter liegt, holt niemand zurück.

### Offen
- Große oder öffentliche Gruppen: Eine einzige Absage genügt. Vorläufig bleibt das so, dort gibt es dann eben keine KI.

## Agenten erzeugen keine Geheimnisse, die ein Mensch behält (Nutzer, 2026-11-07)
Ein Agent hat ein Passwort und eine Passphrase angelegt und wusste damit beides. Der Nutzer muss es deshalb ändern. Regel: Ein Agent erzeugt kein Passwort, keine Passphrase und keinen privaten Schlüssel, die ein Mensch weiter nutzt, und liest sie auch nicht. Er schreibt die Anleitung, der Mensch führt sie aus. Testwerte in Tests sind davon nicht betroffen.

## Ein Mensch, ein Konto: lässt sich nicht feststellen (Nutzer, 2026-11-07)
„Das können wir nicht. Man könnte es, wenn wir E-Mails überprüfen könnten, oder den Pass, aber das dürfen wir nicht. Das würde nur sozial gehen und das kann man umgehen.“ Beispiel: Zehn Betrüger bewerten sich gegenseitig. Einzige Idee des Nutzers: eine Identität je Gerät oder Konto; dazu ist nichts entschieden.
Gegen den Betrügerring hilft, was schon gilt: Es gibt keinen weltweiten Wert, und Stufen werden nur aus den eigenen Kontakten berechnet. Punkt 3 oben („es muss ein Mensch sein, nicht mehrere Accounts“) bleibt als Wunsch, ist aber nicht durchsetzbar.

Weitere Überlegungen des Nutzers, festgehalten, damit man die Gründe wiederfindet:
- **Mehrere Identitäten** braucht es dafür nicht, dafür gibt es Profile; eine Dating-App fragt, ob man ein neues Profil anlegen möchte, und zeigt genau das. (Strategie: Damit zwei Dienste Profile nicht verknüpfen können, trägt jedes nach außen eine eigene Kennung, ADR 0029.)
- **Viele Geräte kosten Geld**, das schränkt etwas ein. (Strategie: Das gilt nur, wenn ein Gerät nachweislich nur eine Identität erzeugen kann. Ohne Bindung an die Hardware erzeugt ein Gerät beliebig viele; die Bindung läuft über Apple oder Google und widerspricht unseren Grundsätzen.)
- **Eine Identität je Konto** scheitert daran, dass öffentliche Server das Programm ebenfalls nutzen sollen.
- **Offen:** Sollte man zuerst auf dem eigenen Gerät eine Identität anlegen und das Programm laden, bevor man online geht? Reine Online-Anmeldung ginge dann nicht. (Strategie: Als Standard gut, wegen eigener Schlüssel; als Nachweis gegen Mehrfachkonten nicht. Der Server entscheidet, ob es Gäste gibt.)

## Vertrauensbasis (Nutzer, 2026-11-07)
Die Schnittstelle folgt den Standards DID und VC. RLTP ist ein austauschbarer Anbieter (Encounter-Ablauf), nicht das Fundament. Korrektur zur Recherche: DIDComm stammt von der DIF, nicht vom W3C. Gebaut wird das nach dem Sprint.

## Ohne Befugnis nichts, auch kein Lesen (Nutzer, 2026-11-07)
„Erstmal nichts lesen dürfen. Eine Einladung geht auch ohne Befugnisse. Erst wenn explizit Befugnisse eingeräumt werden, wird weitergemacht.“
Eine KI kann also eingeladen werden, ohne etwas zu dürfen. Bis ihr jemand ausdrücklich Befugnisse gibt, liest und tut sie nichts. Technisch heißt das **ablehnen, nicht fragen** (Lesart der Strategie, 2026-11-07): Die KI kann eine Person nicht mit Fragen überziehen, die Befugnis gibt die Person von sich aus. Erst nach einer Befugnis fragt die Engine, was jedes Mal fragen muss. Für Rechte (Delegationen, Rollen, Mitgliedschaften, Einladungen, Speicher-Anbindungen, Anmeldung am Hub) entsteht vorerst gar kein Werkzeug, auch nicht zum Lesen.

## Lesen ist nicht harmlos (Nutzer, 2026-11-07)
„Stell dir vor, die KI liest Passwörter aus. Dann ist das schlimmer als Löschen, kommt darauf an was, oder Geheimnisse.“ „Nur scheinbar harmlose Sachen sind nicht harmlos.“
Der Nutzer nennt auch: eine KI, die ein Gespräch mitbekommt und es meldet, und Geschäftsgeheimnisse, die ein Unternehmen zerstören können.

Vorschlag zur Umsetzung (Strategie):
- **Keine Klasse heißt „harmlos“.** Auch Lesen braucht eine Freigabe. Eine Freigabe nennt, wohin der Text geht, also auch „an Anthropic“.
- **Geheimnisse** (Passwörter, Schlüssel) erreichen eine KI nie: kein Werkzeug, keine Ressource (ADR 0021).
- **Gekennzeichnetes** (ADR 0029) fragt beim Lesen jedes Mal, ohne „immer erlauben“. Die Engine entscheidet das am gelesenen Objekt, weil der Vertrag allein nicht weiß, was darin steht.
- **Etwas nach außen melden** ist Handeln im Namen der Person und fragt immer.
- **Grenze:** Nicht Gekennzeichnetes kann trotzdem heikel sein, und was ein Anbieter mit gelesenem Text tut, erreichen wir nicht. Eine KI auf dem eigenen Gerät bleibt deshalb der Standard.

## Folgen
- ADR 0053 Punkt 1 wird dadurch präzisiert: LLM-Chat bleibt Component und Frontend; ein eigenes Programm nur, falls sich zeigt, dass
  es eigene Daten hat.

## Nachtrag 2026-11-16: KI-Helfer: Einladung, STOP KI, Zustimmung aller

Anlass: Nutzerantwort 29 „KI-Helfer“ (16.11.). Wörtlich, als Entscheidung des Nutzers:

> Eine KI kann ÜBERALL zugeschaltet werden, wenn man sie EINLÄDT. Es gibt IMMER einen „STOP KI"-Knopf, der die KI sofort entfernt. Sind mehrere Leute da: Jeder muss VORHER zustimmen. Wer später dazukommt, wird vorgewarnt und muss bestätigen, sonst kommt er nicht hinein (Datenschutz). Die Option „nur lokal" gibt es zusätzlich als Sicherheitsoption, sie ist aber kein Muss.

Die Punkte 1 bis 10 des Abschnitts „KIs in Unterhaltungen“ bleiben unverändert; dieser Nachtrag präzisiert sie. Punkt 3 (Hinweis vor dem Betreten), 4 (alle müssen zustimmen), 5 (Spätkommende nehmen die KI an) und 7 (Rückzug der Zustimmung) sind schon dieselbe Regel; der Nachtrag bestätigt sie und fügt Einladung und STOP KI hinzu. Die Statuszeile bleibt unverändert.

**(1) Verhältnis zu 0054 bisher.** 0054 sagt: KIs sind markierte Teilnehmer; eine KI steht nur in eigenen KI-Gruppen, nie verschachtelt und mit dem wenigsten Recht (ADR 0082 Nachtrag, KI-Regel); keine Admin-Rolle; die Markierung setzt nur ein Mensch. Die neue Regel beschreibt den Weg, auf dem eine KI zu einer Unterhaltung, einem Raum oder einer Sitzung dazukommt: die Einladung. Einladung heißt Teilnahme an einer Unterhaltung, einem Raum oder einer Sitzung, NIE Mitgliedschaft in einer Menschengruppe (ADR 0082: KI-Konten nie in Menschengruppen). Eingeladen wird das KI-Konto als markierter Teilnehmer. Rechte bekommt die KI nur über die eigene KI-Gruppe, die ein Mensch mit `Manage` setzt (pilot-selbstverwaltung, §6.2). Die bestehenden Grenzen bleiben: Die KI kann nicht zustimmen, nicht einladen und den Türsteher nicht auslösen (§6.2); sie wird nie Admin und kommt nie in Admin- oder sensible Gruppen (ADR 0082). Ihr Zugriff ist auf das begrenzt, was der Einladungsraum ausdrücklich freigibt. Freigeben kann nur ein Mensch, höchstens mit seinen eigenen Rechten (Obergrenze wie beim fs-access-Token), nie `Manage` oder Admin. Die Einladung gibt keine Rechte; ohne ausdrückliche Befugnis tut die KI nichts (0054, „Ohne Befugnis nichts“, 2026-11-07).

**„ÜBERALL“ und die Sicherheitsgrenzen (Strategie).** Das „ÜBERALL“ des Nutzers meint: in jedem Raum, jeder Unterhaltung und jeder Sitzung, in die man sie einlädt. Die Grenzen aus ADR 0082 und 0056 GEHEN VOR: KI nie in Admin- oder sensible Gruppen, nie Admin, nie zustimmen, nie einladen, nie Türsteher. Das ist als Rückfrage an den Nutzer unter „Offen“ aufgenommen.

**(2) Pflichten je Frontend und Programm.** Gelten überall, wo eine KI zugeschaltet werden kann, aber nur dort, wo unsere Engine es durchsetzen kann (Grenzen, oben: fremde Programme, Mail).
- **Sichtbarer Knopf „STOP KI“:** Er erscheint NUR, wenn tatsächlich eine KI dabei ist. Ohne KI gibt es ihn nicht, auch nicht deaktiviert. Ist eine KI eingeladen, ist der Knopf IMMER sichtbar und sofort wirksam. Drücken kann ihn JEDER anwesende Mensch (0054, Punkt 7). Er entfernt die KI sofort. (Strategie: Zugriff endet, Sitzung und Token der KI werden widerrufen, ein Protokolleintrag entsteht.)
- **Zustimmung ALLER Anwesenden vor dem Zuschalten.** Sagt einer nicht zu, kommt die KI nicht hinein. Die Zustimmungsabfrage erscheint nur, wenn eine KI eingeladen wird.
- **Spätkommende:** Sie werden vorgewarnt und müssen bestätigen, dass eine KI anwesend ist. Ohne Bestätigung kein Zutritt.
- **Kein Verlauf vor dem Eintritt:** Die KI bekommt nichts von dem, was vor ihrem Eintritt geschrieben wurde.
- **Hinauswerfen wirkt nur nach vorn:** Was die KI schon gelesen hat, und was davon beim Anbieter liegt, holt niemand zurück.
- **Datenschutz-Begründung:** Eine KI kann mitlesen, und der Text kann beim Anbieter verarbeitet werden (0054, „KIs in Unterhaltungen“, Punkte 2 und 5). Darum Zustimmung vorher und Vorwarnung danach.
- **Option „nur lokal“:** zusätzliche Sicherheitsoption, die KI läuft nur auf dem eigenen Gerät oder Server. Sie ist kein Muss und keine Vorbedingung fürs Zuschalten. Sie ersetzt weder die Zustimmung noch STOP KI (Punkt 6).
- **Einwilligung (DSGVO, Strategie):** Die Zustimmung und die Bestätigung der Spätkommenden werden als Einwilligung in fs-people gespeichert (Zweck „ki_hilfe“, Nutzerantwort 27).

**(3) Verhältnis zur Selbstverwaltung und zu fs-access.** Im Türsteher-Entwurf stimmt die KI nie ab und ist nie Zustimmende (pilot-selbstverwaltung, §6.2). Als eingeladene Helferin hat sie Konto-Art KI und steht in einer eigenen KI-Gruppe. Die Zustimmung der Menschen ist keine Stimme der KI. Ein KI-Token in fs-access ist nur eine Obergrenze dessen, was die Person freigibt; es gibt dafür keine Admin-Rollen (ADR 0056).

**(4) Folgen und Tests.** Pflichtpunkt in programm-grundgeruest und in der Release-Prüfliste: „STOP KI“ je Frontend (erscheint nur mit KI, ist dann sichtbar, für jeden anwesenden Menschen drückbar und wirkt sofort, Protokolleintrag), Zustimmung aller Anwesenden vor dem Zuschalten, Spätkommende mit Vorwarnung und Bestätigung. Konformitätstest je Programm in BEIDE Richtungen: ohne KI kein Knopf und keine Abfrage; mit KI Knopf sichtbar, wirksam und mit Protokoll. Weitere Tests: eine Absage bedeutet keine KI; wer später kommt und nicht bestätigt, kommt nicht hinein; die KI bekommt keinen alten Verlauf; jeder Mensch kann STOP KI drücken. Die Umsetzung in fs-release steht noch aus.

### Offen
- Wie wird „alle Anwesenden“ bestimmt: Raum, Sitzung oder Gruppe? Große oder öffentliche Gruppen: dort genügt eine Absage (0054, Offen oben).
- Frist und Wiederholung der Zustimmung.
- Verlassen und Beitritt sind durch Punkt 5 und 7 teils entschieden (Spätkommende bestätigen, Rückzug entfernt die KI); offen bleibt, was bei Verlassen eines Zustimmenden während der Sitzung genau geschieht.
- Protokoll nach DSGVO: Inhalt und Speicherdauer; bezogen auf die Einwilligung in fs-people (Zweck „ki_hilfe“).
- Rückfrage an den Nutzer: Gehen die Sicherheitsgrenzen aus ADR 0082/0056 (KI nie in Admin- oder sensible Gruppen, nie Admin, nie zustimmen oder einladen) dem „ÜBERALL“ vor? Strategie nimmt das an.

## Nachtrag 2 2026-11-16: KI-Zugang je Programm und je Gruppe, für KI unsichtbar

Anlass: Nutzerentscheidung 39 (16.11., über die Strategie). Frage war, ob eine KI in Admin- oder sensiblen Gruppen sein darf. Antwort des Nutzers: JA, NIE (gemeint: nie). Zusätzlich, als allgemeine Regel: Man kann KI für immer streichen. Dieser Nachtrag ergänzt den Nachtrag „KI-Helfer: Einladung, STOP KI, Zustimmung aller“ (oben, b97c77b6); dessen Punkte bleiben unverändert.

**Entscheidung (Nutzer, Strategie hat gegen 0054, 0056, 0076, 0082, 0090 und groups_v1 geprüft):**
- **(a) Schalter „KI-Zugang (MCP)“ in jedem Programm.** Standard AUS; ein Mensch muss ihn einschalten (Opt-in). Wo machbar, ist MCP ein eigenes Modul, das man gar nicht erst installiert oder lädt; dann gibt es den Schalter nur als „nicht installiert“.
- **(b) Der Schalter ist für KI unsichtbar und unveränderbar,** auch nicht über einen Umweg. Damit kann man KI für immer streichen.
- **(c) Beim Anlegen einer Gruppe oder eines Raums wird festgelegt: KI erlaubt ja oder nein.** Bei Admin-Gruppen und sensiblen Gruppen (Typ `sensitive`) steht es fest auf „nein“; der Mensch kann es dort nicht auf „ja“ stellen.
- **Bedeutung von „KI erlaubt“ an einer Gruppe.** „KI erlaubt“ ist NIE Mitgliedschaft (ADR 0082 gilt weiter: eine KI ist nie Mitglied einer Menschengruppe). Es umfasst (i) KI-Teilnahme oder -Einladung in einer Unterhaltung, einem Raum oder einer Sitzung der Gruppe (Nachtrag 1: Einladung = Teilnahme) und (ii) ein Recht einer KI-GRUPPE an dieser Gruppe. Ein Wechsel auf „nein“ beendet die Teilnahmen und widerruft diese Rechte sofort, wie STOP KI.
- **Admin-Werden.** „Admin-Gruppe“ ist in groups_v1 kein Typ, sondern ergibt sich daraus, dass eine Admin-Rolle vergeben ist. Bekommt eine Gruppe mit „ja“ später eine Admin-Rolle oder wird sie sensibel, setzt groups_v1 im selben Schritt „nein“ (mit Ledger-Eintrag, Wirkung wie oben). Es gibt keine Ablehnung, sonst würde die KI-Einstellung die Admin-Vergabe blockieren.

**Präzisierungen (Strategie, zur Bestätigung):**
1. **„Umweg“** heißt: weder über Rechte-, Gruppen-, Token-, API- oder MCP-Aufrufe lesbar oder änderbar, noch über Verlauf, Protokoll, Suche, Export oder Fehlermeldungen. Eine KI sieht nicht einmal, dass es den Schalter gibt (auch das Gruppenfeld „KI erlaubt“ sieht sie nicht: für eine KI ist es `None`): keine Methode nennt ihn, Zugriff wird wie „nicht vorhanden“ beantwortet (`NotFound`, gleiche Art wie bei Admin-Gruppen in 0082, Nachtrag KI-Regel). Der Schalter ist kein Recht, das man einer KI-Gruppe geben kann; kein fs-access-Token und keine Delegation kann ihn einschließen.
2. **Protokoll:** Der Zustand des Schalters und seine Änderungen stehen im Protokoll, aber das Protokoll liefert sie an KI-Konten nie aus (festgelegt). Menschen mit Einsicht sehen sie.
3. **Zustand je Programm UND je Gruppe oder Raum,** getrennt gespeichert. Reihenfolge, immer die strengere gewinnt: Programm AUS bedeutet nie KI. Gruppe oder Raum „nein“ bedeutet nie KI. Erst wenn beide „ja“ sind, gilt der Nachtrag „KI-Helfer“: Einladung, Zustimmung aller Anwesenden, Vorwarnung Spätkommender, STOP KI wie bisher. „ja“ ist nur eine Möglichkeit, keine Einladung und kein Recht.
4. **Einzelplatz (ADR 0090):** Standard ebenfalls AUS; die Besitzerin schaltet ein, sonst keiner. Der Schalter ist auch dort für KI unsichtbar.
5. **Wer setzt ihn:** nur ein Mensch mit Verwaltungsrecht (Besitzer oder Admin des Programms bzw. der Gruppe), nie eine KI und nie ein Konto mit unbekanntem KI-Status (0082: Hüllenprüfung). Jede Änderung wird protokolliert.
6. **Verhältnis zum Notaus und zu STOP KI:** Der Schalter AUS ist die dauerhafte Fassung; der Notaus (Punkt 5, Rechte) und STOP KI wirken sofort und einmalig. Schalter auf AUS entfernt eine anwesende KI wie STOP KI (Token und Sitzung widerrufen, Protokolleintrag). Dasselbe gilt, wenn eine Gruppe nachträglich auf „nein“ gestellt wird: Teilnahmen enden, Rechte von KI-Gruppen an dieser Gruppe werden widerrufen (es gibt keine KI-Mitglieder, die zu entfernen wären).
7. **Grenze (wie 0054):** Der Schalter wirkt nur, was durch unsere Programme läuft. Eine KI mit eigener Shell oder ein fremdes Programm erreicht er nicht.

**Folgen und Tests.**
- Konformitätstest je Programm in BEIDE Richtungen: (i) Schalter vorhanden, Standard AUS, bei AUS lehnt jede MCP-/API-Anfrage einer KI ab; (ii) Schalter ist für KI unsichtbar und unveränderbar (Test mit KI-Token: Lesen, Ändern, Auslesen über Protokoll, Verlauf, Export; alles `NotFound` oder abgelehnt); (iii) Gruppe „nein“ und Admin- oder sensible Gruppe: KI-Einladung nicht möglich; (iv) Programm AN und Gruppe „ja“: Einladung wie bisher.
- Pflichtpunkt in programm-grundgeruest (Konformitätstest): „KI-Zugang-Schalter vorhanden, Standard AUS, für KI unsichtbar und unveränderbar“. Die Umsetzung in fs-release (Workflow-Datei) steht noch aus; sie liegt außerhalb von fs-documentation.
- Ist MCP ein eigenes Modul, ändert das die Paketstruktur (ADR 0076, Programm-Grundgerüst; zu `provides` siehe ADR 0068): das Modul ist ein eigenes Paket mit der Fähigkeit `<thema>.mcp` nach ADR 0068 (`fs-interfaces/schema/capabilities.txt`, Status `planned`, nur angehängt; in AppStream `<provides>` als `freesynergy-iface(<thema>.mcp)`, nicht ein nacktes `mcp`, da dies kein Schema hat) im Katalog, das ein Programm optional bezieht. Fehlt das Paket, gibt es keinen Einstiegspunkt für KI; der Schalter ist dann nur Anzeige für Menschen.
- Gruppenanlage: der Anlegen-Dialog fragt „KI erlaubt: ja/nein“, Voreinstellung „nein“; Typ `sensitive` und Admin-Gruppen zeigen das Feld fest auf „nein“. Das ergänzt die KI-Regel in 0082 (KI nie in Admin- oder sensiblen Gruppen) um eine Gruppeneigenschaft, die auch Einladungen in Räume erfasst.
- Trait-Folge in groups_v1 (Fixpunkt-Änderung, getrennt zu planen): Feld `ai_allowed`, Fehler `AiNotAllowed`, nur ein Mensch mit `Manage` darf es setzen, Voreinstellung „nein“. Details stehen in groups_v1 und im Plan, nicht hier.

### Offen
1. Wo liegt der Schalter technisch: im Rechte-Teil von fs-access (außerhalb der Reichweite der KI wie der Notaus) oder als Programm-Einstellung je Programm? Wer erzwingt „unsichtbar“ einheitlich?
   Empfehlung (Strategie, d3 hat bestätigt, dass das Protokoll den Schalter nie an KI liefert): im Rechte-Teil von fs-access neben dem Notaus (0054, Z. 41), nicht als Programm-Einstellung; nur so ist „unsichtbar“ einheitlich erzwingbar. Zur Bestätigung durch den Nutzer.
2. Wie verhindert man Umwege bei Programmen mit Plugin-Mechanik (hot plugins): Ein Plugin darf den Schalter nicht umgehen und kein eigenes MCP-Tor öffnen. Entwurf: Ein Plugin bekommt nie ein eigenes MCP-Tor; MCP läuft nur über das eine Modul.
3. Wer genau darf den Schalter setzen (Besitzer, Admin des Programms, Gruppenbesitzer) und wie wird das mit Einzelplatz und Selbstverwaltung (Türsteher) abgestimmt?
4. Anlegen-Dialog je Gruppe und Raum: Wo wird „KI erlaubt“ gespeichert (fs-groups, groups_v1, Feld je Gruppe?) und ändert der Fixpunkt groups_v1? Nachträgliche Änderung „ja“ zu „nein“ wirkt sofort, in der Gegenrichtung nur mit Zustimmung wie bisher?
5. Standard in Einzelplatz und bei bestehenden Installationen nach Aktualisierung: AUS; Rückfrage an den Nutzer, ob das Zurücksetzen bestehender Einschaltungen bei Updates gewünscht ist.

## Nachtrag 2026-11-17 (Baukasten): MCP im Gerüst jedes Programms, KI als eigener Akteur, KI-Nachrichten gekennzeichnet, lokale Pilotfreigabe

Status: **akzeptiert** (Nutzerentscheidungen vom 2026-11-17, Gespräche 1 und 2 und Präzisierung danach) · **ändert** Nachtrag 2 (a) Satz 2 (Z. 174: „Wo machbar, ist MCP ein eigenes Modul, das man gar nicht erst installiert oder lädt; dann gibt es den Schalter nur als ‚nicht installiert‘“) und Z. 192 (MCP als eigenes Paket `<thema>.mcp`) · **ändert** Z. 42 („Zerstörendes und Handeln im Namen der Person fragt immer“): eine KI handelt nie im Namen der Person · **bestätigt** Nachtrag 2 (a) „Standard AUS“, (b) Z. 175, Präzisierungen Z. 181/185 und Offen 2 (Z. 199) · **ergänzt** Punkt 3 (Z. 10, LLMs werden markiert) um die Kennzeichnung jeder KI-Nachricht · gilt mit dem Nachtrag zu ADR 0091 [Entw.]

**Entscheidung**
1. **MCP ist Gerüst-Baustein jedes Programms**, kein eigenes Paket. Nutzer (Gespräch 1): „Ach ja, MCP kommt auch überall rein, überall … dass man überall abschalten kann.“ Schalter-Ort bleibt Offen 1 (Rechte-Teil von fs-access); in fs-connect sitzt nur die Schnittstelle.
2. **Nach der Installation aus** (Gespräch 2, Antwort 2: „genau so …“). Dass eine Einladung einer KI den Schalter **nicht** einschaltet, folgt aus Z. 181/185 (nur ein Mensch mit Verwaltungsrecht setzt ihn); kein eigenes Nutzerzitat.
3. **Tresor immer aus und ohne Inhalt:** „Bei Vault wird es auch drin sein, aber nur abgeschaltet … so dass auch wenn mcp eingeschaltet werden dürfte und könnte, das Programm nichts rausgeben würde - das gilt IMMER“ (Gespräch 1). Schalter fest aus wie bei Admin-Gruppen (Nachtrag 2 (c)).
4. **Wrapper = Bot-Platz (Entscheidung der Strategie;** Nutzer zu 2.1: „das ist eine technische Sache. ich meinte damit ein "Wrapper", der der KI einhalt gebietet“): der Bot-Platz nach ADR 0091 (`fs-delegate`: Mandat, Rechte ⊆ Halter, STOP, Protokoll); im Einzelplatz der MCP-Schalter mit STOP KI (ADR 0091 Z. 71).
5. **KI als eigener Akteur:** „eine KI darf arbeiten, aber sie darf nicht den User übernehmen.“ (Nutzer, 2026-11-17, direkt nach Gespräch 2). Eine KI handelt als eigener, gekennzeichneter Akteur (Bot-Platz per Mandat), nie im Namen oder an Stelle der Person; „Wir haben keine "Userbots". Wir arbeiten nur mit ihnen, wir werden nicht zu denen.“ (Gespräch 2, Antwort 5). **Schutz-KI in betreuten Konten:** „KI darf nur mitlesen, niemals ausführen“ (Antwort 5 auf Frage 5), mit Zustimmung.
6. **KI-Nachrichten immer gekennzeichnet:** „dass die KIs bei Nachrichten auch immer sagen/zeigen sollten, dass sie das geschrieben haben - auch damit keine Missverständnisse passieren“ (Antwort 5); sichtbar für alle Empfänger, auch außerhalb (Mail, Brücken).
7. **Lokale Pilotfreigabe** (Nutzer, 2026-11-17 abends, über die Strategie): MCP lokal öffnen: „nur für den Anfang, damit wir hier zusammen arbeiten können, kannst du die mcp schnittstelle aufmachen - aber nur hier, lokal.“ (Gespräch 2, Nachsatz); kein Dauerzustand. Pilot fs-tasks über stdio, kein Netz-Port, Schreiben nur eigene Karten/Notizen/Status, nie Löschen; ausdrücklich eingeschaltet durch Person/Admin, sonst gilt Punkt 2. Umsetzung über den MCP-Wrapper (Risikomarken (ADR 0021 Z. 18), Allowlist, KI-Kennzeichnung).

**Pflichttests** (je ohne Umsetzung rot): MCP-Schnittstelle vorhanden, nach Installation aus; Einladung/Token/Delegation schaltet nicht ein; Tresor-Schalter nicht einschaltbar, Tresor gibt nichts heraus (Mutant „Tresor-Sperre entfernt“); KI-Aufruf als die Person → abgelehnt; Schutz-KI: ausführende Methode → abgelehnt; KI-Nachricht ohne Kennzeichnung → nicht zustellbar; Pilot: Netz-Port und Löschen → abgelehnt.

## Nachtrag 2026-11-17 (2): KI-Einladung als gemeinsamer Modus; Entscheider in offenen Runden; Ausschluss nach Eintritt

Status: **Entwurf** (Nutzer, Gespräch 4, Antworten 18/19, Z. 59, 62; Ausgestaltung Strategie) · **präzisiert** den Nachtrag 2026-11-16 „KI-Helfer: Einladung, STOP KI, Zustimmung aller“ (Z. 136–168): „Zustimmung ALLER Anwesenden“ (Z. 150) gilt im geschlossenen Kreis; STOP KI (Z. 149, 160) bleibt unverändert
**vorhanden-pruefen:** STOP KI (sichtbar, sofort, für jeden Menschen), Zustimmung aller vor dem Zuschalten, Vorwarnung Spätkommender stehen schon im Nachtrag vom 16.11.; neu ist nur:

**Entscheidung**
1. **Entscheider:** im geschlossenen Kreis die Teilnehmer (wie bisher); **in offenen Runden (z. B. offene Umfragen) die Organisatoren**, nicht die Antwortenden (Nutzer Z. 59: „bei offenen Umfragen sind es die Organisatoren“).
2. **Nach dem Eintritt der KI** können die, die nicht mit KI arbeiten wollen, nicht mehr mitmachen (Z. 59); das entspricht der Bestätigung Spätkommender (Z. 151).
3. **Ein Mechanismus für alle Programme:** Modus „KI-Einladung“ in fs-admission, aufgerufen über einen Gerüst-Haken; der Schalter „KI erlaubt“ bleibt in fs-access (Nachtrag 2, Offen 1). STOP KI ist im Modus Pflicht, für jeden Teilnehmer sichtbar, sofort, ohne Abstimmung (Nachtrag 16.11. Z. 149); die Pflicht betrifft das Zeigen, der Ort bleibt bei `fs-delegate` (ADR 0087 Nachtrag (3) Punkt 8).
4. **Teilnehmer-Arten** in Auswertungen: bekannte Personen, KIs, anonyme, **betreute Konten** (Antwort 19, Z. 62: „Ja, betreute Konten.“); betreut ≠ Eigentümer (ADR 0095).
**ADR 0091:** kein weiterer Nachtrag nötig (Bot-Platz, STOP je Platz und Kennzeichnung stehen in 0091 Z. 129, 228–240).

## Nachtrag 2026-11-17 (3): KI „im Auftrag“ der Person; Protokoll vor der Aktion; Token nie sichtbar

Status: **Entwurf** (Nutzer 23.1, 23.2, 23.3, 2026-11-17, via Strategie c0; Ausgestaltung Strategie) · **präzisiert** Nachtrag 2026-11-17 (Baukasten) (Z. 204/206, „eine KI handelt nie im Namen der Person“) und „Agenten erzeugen keine Geheimnisse, die ein Mensch behält“ (Nutzer, 2026-11-07) · gilt mit ADR 0091 Nachtrag 2026-11-17 (2)

**Entscheidung (Nutzer)**
1. **Protokoll vor der Aktion (23.1).** Nutzer: „JA fest: Protokoll vor der Aktion.“ Das Protokoll steht, bevor die Aktion läuft, nicht erst danach.
2. **„Im Auftrag“ (23.2).** Nutzer: „JA, präzisiert: Die KI nutzt NIE den Account oder die Zugangsdaten der Person. Sie darf Aufträge der Person ausführen, „im Auftrag“, als verlängerter Arm, handelt dabei aber immer als sie selbst und behauptet nie, die Person habe es getan.“
3. **Token nie sichtbar (23.3).** Nutzer: „JA fest: Token nie sichtbar; Ausnahmen nur nach Gespräch mit dem Nutzer.“

Quelle der drei Zitate: Antworten des Nutzers vom 2026-11-17, weitergegeben durch die Strategie (via Strategie c0), im Wortlaut wie übergeben.

**Ausgestaltung (Strategie, kein Nutzerwort)**
1. **Modell:** `actor` = die KI (eigener, gekennzeichneter Akteur, ADR 0091), `on_behalf_of` = die Person, die den Auftrag gegeben hat. Die Person ist **nie** der `actor`.
2. **Rechte der KI ⊆ Rechte der Person** (Delegation ohne Erweiterung): ein Auftrag kann der KI nur Rechte geben, die die Person selbst hat (Rechte-Modell fs-access, ADR 0100 Z. 39/45; Nutzer 20.1 noch nicht eingearbeitet, siehe Offen). Fehlt ein Recht der Person, wird der Auftrag abgelehnt, nicht gekürzt ausgeführt.
3. **Kein Konto, kein Token der Person:** die KI nutzt nie Konto oder Zugangsdaten der Person; ihren Zugriff bekommt sie über den **Bot-Schlüssel des Programms** (ADR 0091 Nachtrag 2026-11-16 „Bot-Schlüssel stellt das Programm aus“), nie über ein Kanidm-Konto oder ein Token der Person; ein Token der Person ist für die KI und in jeder Ausgabe nie sichtbar (Tresor-Verweis statt Wert, ADR 0067, 0071 Z. 129). Ausnahmen gibt es nur nach einem Gespräch mit dem Nutzer; bis dahin keine.
4. **Verhältnis zur Frage-Regel (Nachtrag 2026-11-16 und 2026-11-17 (2)):** der Auftrag ändert nichts an „KI nur per Einladung + STOP KI“. Ein Auftrag lädt keine KI in eine Runde ein und schaltet den Schalter „KI erlaubt“ nicht; eine KI hält nie `can_lock` und kann daher auch im Auftrag keine Sperre setzen oder lösen (ADR 0100, Schloss nur über fs-access).
5. **Verhältnis zu den Schutzregeln (Nutzer 20.1, Rechte statt Rollen, Schutzregeln als Empfehlungen mit Stufe):** Protokoll vor der Aktion, „KI nur als eigener Akteur“ und „Token nie sichtbar“ sind **keine** einstellbaren Schutzregeln, sondern feste Entscheidungen (Nutzer 23.1/23.2/23.3). Sie stehen nicht zur Stufe aus/warnen/sperren; Ausnahmen nur nach Gespräch mit dem Nutzer.
6. **Kennzeichnung nach außen** (Namen noch Vorschlag, nicht belegt): AS2 kennt in der Hülle `actor` und `attributedTo` (ADR 0020, 0085); für `on_behalf_of` gibt es in den Entscheidungen kein bestehendes Muster. Vorschlag: Feld mit dem Präfix `freesynergy.net:` (Muster wie `freesynergy.net:createdBy` im Aufgaben-Export von fs-tasks), Name offen. In Commits und Tags die Trailer `FS-Actor:` und `FS-On-Behalf-Of:`.

7. **Bindung an den Auftrag (gegen Fälschung):** `on_behalf_of` darf nur gesetzt sein, wenn ein Mandat bzw. Auftrag dieser Person (`fs-delegate`, ADR 0091) besteht; das wird bei jedem Aufruf geprüft (wie bei STOP, ADR 0091 Z. 66). Ob die Plattform das heute schon entscheiden kann, ist offen (siehe Offen).
8. **Prüfzeitpunkt, Verfall, Widerruf:** Rechte der KI ⊆ Rechte der Person wird zur Ausführungszeit gegen die **aktuellen** Rechte der Person geprüft (Rechteentzug wirkt sofort). Verfall und Widerruf des Auftrags wie beim Mandat (ADR 0091 Z. 55/59: Widerruf wirkt wie STOP KI). Wer prüft (fs-access bzw. Rechte-Schicht des Gerüsts): offen.

**Pflichttests:** Aufruf mit Konto oder Token der Person → abgelehnt; Auftrag mit Recht, das die Person nicht hat → abgelehnt; Aktion ohne vorher geschriebenes Protokoll → wird nicht ausgeführt; Token der Person in Ausgabe oder Protokoll → Fehler; Eintrag ohne `on_behalf_of` bei erteiltem Auftrag → abgelehnt; `on_behalf_of` ohne gültigen Auftrag/Mandat dieser Person → abgelehnt; Rechteentzug der Person nach Auftragserteilung → Aktion der KI abgelehnt.

**Offen**
- Technische Prüfung der Bindung an den Auftrag (Ausgestaltung 7) und wer das Kleiner-gleich prüft (Ausgestaltung 8): nicht entschieden.
- Name und Ort des Feldes `on_behalf_of` in AS2/JSON (siehe Ausgestaltung 6).
- Der Nutzerentscheid 20.1 (Rechte statt Rollen) steht in ADR 0100 noch nicht; die Bezüge in Ausgestaltung 4 und 5 sind bis zu dessen Einarbeitung Entwurf.
- Was „Gespräch mit dem Nutzer“ technisch heißt (Freigabe je Fall, Ablauf): nicht festgelegt.

## Nachtrag 2026-11-17 (4): Pause und Entfernen (jede Person, jederzeit); Auftrag widerrufen (nur Ersteller); Prüfung des Auftrags gegen Fälschung

Status: **Entwurf** (Nutzerwort 2026-11-17 (D) und Nutzerentscheid 25 (bindend, 2026-11-17), beide via Strategie c0; Nutzerfrage (E) „wie wird geprüft?“; Ausgestaltung Strategie) · **präzisiert** Nachtrag 2026-11-17 (3), Ausgestaltung 7 und 8 (Z. 250, 251) und dessen Offen Punkt 1 (Z. 256) · **präzisiert** ADR 0091 Z. 59 und Z. 263 · **benennt um** den Knopf, der die KI entfernt (Altext „STOP KI“, Z. 140, 149, 160): er heißt „Entfernen“, Wirkung unverändert · **neu** „Pause“ (Punkte (2a) bis (2c)) · **lässt unverändert** Z. 177, Z. 186 und 0054 Punkt 7 (Z. 87) · **ergänzt** durch Entscheide c0 nach Nutzerregeln, 18.11. (Offen 9, 11–19; kein neuer Nutzerweg) · gilt mit ADR 0091 Nachtrag 2026-11-17 (3)

**Nutzerwort (D), im Wortlaut wie übergeben (via Strategie c0, 2026-11-17)**
> KORREKTUR: Widerruf eines Auftrags = vorübergehender STOP („erst mal ruhig bleiben, bis der nächste Befehl kommt“), KEIN Rauswurf. Rauswurf ist ein EIGENER Knopf.

**Nutzerentscheid 25 (bindend, 2026-11-17), im Wortlaut wie übergeben (via Strategie c0)**
> ZWEI Befehle, die JEDE Person JEDERZEIT auslösen kann: „Pause“ und „Entfernen“ (Reject/Kick). Pause gibt es NUR, wenn die KI dann zu 100 % blind und taub ist: kein Lesen, kein Speichern, keine Aktion, sieht nicht einmal, wer im Raum ist. […] Ist das nicht 100 % belegbar, wirkt Pause wie ein Not-Aus: sofort Entfernen. Entfernen = KI fliegt raus, Wiederkehr nur über eine neue Umfrage. „Auftrag widerrufen“ bleibt beim Ersteller.

Technische Vorgabe der Strategie (c0, kein Nutzerwort): serverseitig, Bot-Schlüssel des Platzes gesperrt, jede Anfrage einschließlich Anwesenheit und Feeds abgelehnt, offene Ströme geschlossen; Pflichttests für jeden Zugriffsweg.
Aus der Übergabe ist nicht zu unterscheiden, welche Sätze wörtlich vom Nutzer stammen und welche c0 zusammengefasst hat. Entscheid 25 ersetzt die Benennung aus dem Nutzerwort (D) („vorübergehender STOP“) und aus der Korrektur der Strategie vom selben Tag („KI entfernen“). Die Sache aus (D) bleibt: der Widerruf eines Auftrags wirft die KI nicht hinaus.

**Nutzer, Frage 33 (Wiederaufnahme, 2026-11-17, via Strategie c0):** fortsetzen dürfen, wer pausiert hat, Admins, Inhaber und jeder mit einem eigenen Recht dafür. Grund, **sinngemäß** (nicht als Wortlaut belegt): „Sonst könnte jemand pausieren und die Gruppe verlassen, dann wäre die KI dauerhaft aus.“

**Begriffe.** Im Text vor diesem Nachtrag (ADR 0054 und 0091) meinen „STOP“ und „STOP KI“ immer das Hinauswerfen der KI; das heißt jetzt **„Entfernen“**. **„Pause“** ist neu (Punkte (2a) bis (2c)): die KI bleibt auf dem Platz, ist aber blind und taub. Das „vorübergehender STOP“ im Nutzerwort (D) meint den Widerruf eines Auftrags (Punkt (2e)), nicht die Pause.

**(1) Was bisher stand und was es jetzt heißt**

| Stelle | bisher | jetzt |
|---|---|---|
| 0054 Z. 251 (Nachtrag (3), Ausg. 8) | „Verfall und Widerruf des Auftrags wie beim Mandat (ADR 0091 Z. 55/59: Widerruf wirkt wie STOP KI)“ | **ersetzt** durch Punkt (2e): Widerruf eines Auftrags beendet **nur diesen Auftrag**; kein Entfernen, keine Pause |
| 0091 Z. 59 | „Ein Widerruf durch irgendeinen Menschen wirkt wie STOP KI (0054 Punkt 7)“ | **präzisiert:** gemeint ist der **Rückzug der Zustimmung** (0054 Punkt 7, Z. 87: „Zieht jemand die Zustimmung zurück, muss die KI hinaus“), also das Ende des Mandats. Das ist **Entfernen** (Punkt (2d)). Der Widerruf eines **Auftrags** ist etwas anderes (Punkt (2e)). |
| 0091 Z. 263 (Nachtrag (2), Offen) | „Verfall und Widerruf (wie Mandat, Widerruf = STOP KI)“ | **ersetzt:** Widerruf (nur durch den Ersteller) oder Verfall eines Auftrags beendet nur diesen Auftrag (Punkt (2e)) |
| 0054 Z. 177, Z. 186 | Schalter „KI erlaubt“ auf „nein“ bzw. MCP-Schalter AUS „wie STOP KI“ | **unverändert** in der Wirkung: das ist Entfernen (die KI geht hinaus, Punkt (2d)) |
| 0054 Z. 140, 149, 160 | „STOP KI“-Knopf, „der die KI sofort entfernt“ (Nutzer 16.11.) | **Wirkung unverändert, neuer Name:** der Knopf heißt „Entfernen“ (Nutzerentscheid 25); der Altext bleibt als Zitat stehen |
| 0091 Z. 51 (Punkt 5, Verbote) | „STOP oder Notaus abschalten“ | **gilt ebenso für** Pause, Wiederaufnahme und Entfernen (Punkt (2c)) |
| 0091 Z. 57 und Z. 78 (Platz „ruht“ bei Halter-Verlust; Ratenbegrenzung) | „ruht der Bot-Platz sofort“ | **unverändert** im Auslöser; „ruht“ benutzt dieselbe Sperre wie Pause (Entscheid c0 nach Nutzerregeln, 18.11. (Opus-Empfehlung angenommen), Offen 16) |

**(2) Drei getrennte Handlungen (Nutzerentscheid 25; Einzelheiten (2a) bis (2f))**

| Handlung | wer | wirkt auf | KI danach |
|---|---|---|---|
| **Pause** | jede Person, jederzeit | den ganzen Bot-Platz, in jedem Programm, in dem der Platz einen Schlüssel hat | bleibt auf dem Platz, ist blind und taub; Schlüssel **gesperrt**, nicht widerrufen; Mandat, Zustimmungen und Aufträge bleiben |
| **Wiederaufnahme** | wer pausiert hat, Admins (drei Stufen nach ADR 0095), Inhaber, wer das Recht `ai.resume` hat (Nutzer, Frage 33; Stufen und Name: Entscheid c0 nach Nutzerregeln, 18.11.) | den ganzen Bot-Platz; **eine** berechtigte Wiederaufnahme hebt den Pause-Zustand auf, auch wenn mehrere pausiert haben | wieder aktiv; erfährt nur „pausiert von–bis“ ((2f)) |
| **Entfernen** | jede Person, jederzeit | den ganzen Bot-Platz | draußen; Platz, Schlüssel, Mandat und Zustimmungen weg; Wiederkehr nur über eine neue Umfrage |
| **Auftrag widerrufen** | nur der Ersteller des Auftrags | genau einen Auftrag | bleibt Teilnehmer; liest und handelt **für diesen Auftrag nichts mehr** (Entscheid c0 nach Nutzerregeln, 18.11.); wartet auf den nächsten Befehl |

Die Knöpfe „Pause“ und „Entfernen“ erscheinen nur, wenn eine KI dabei ist (Z. 149), dann immer und für **jede** Person (Nutzerentscheid 25); „Wiederaufnahme“ nur bei den Berechtigten nach (2c), solange eine Pause besteht; „Auftrag widerrufen“ nur bei der Person, die einen laufenden Auftrag erteilt hat. Was schon getan oder gelesen ist, bleibt (Z. 153: „Hinauswerfen wirkt nur nach vorn“); das gilt für alle drei.

**(2a) Pause: jeder Zugriffsweg der KI, serverseitig gesperrt**

Grundsatz: Die Sperre sitzt **im Programm** (Server), nicht in der Bot-Laufzeit und nicht bei der KI. Zustand des Platzes: `Paused` neben `Active`/`Stopped` (Name Vorschlag), geführt beim Programm, dem das Mandat gehört (ADR 0091 Z. 39), über Ereignisse des Platzes (append-only, Zeit UTC, Person): `pausiert` (je Druck auf „Pause“) und `fortgesetzt` (Namen Vorschlag). **Pause ist ein Zustand des Platzes** (Entscheid c0 nach Nutzerregeln, 18.11.): `Paused` besteht, sobald nach dem letzten `fortgesetzt` mindestens ein `pausiert` steht; mehrere Pausen ergeben **einen** Zustand; **ein** berechtigtes `fortgesetzt` ((2c)) beendet ihn; das Protokoll behält **jedes** `pausiert`. Aufträge haben kein eigenes Pause-Ereignis (kein `angehalten`); eine Pause ändert keinen Auftrag ((2e)). Durchgelassen wird nur `Active`; jeder andere oder unlesbare Zustand wird abgelehnt (Punkt (2b), G7). Der Bot-Schlüssel wird **gesperrt** (Schlüsselverzeichnis: Zustand gesperrt), nicht widerrufen.

Antwort an den Bot-Schlüssel in jedem Fall: `seat-unavailable`, **ohne Grund** und ohne Inhalt oder Metadaten (keine Zahl, Größe, ETag, Zeit); dieselbe Antwort wie bei jedem anderen nicht aktiven Platz, denn die KI erfährt während der Pause nichts (c0-Entscheid, siehe (2f)). Offene Verbindungen werden geschlossen; der Schließgrund ist ebenfalls nur „unavailable“. Abbildung auf HTTP-/RPC-/JSON-RPC-Codes: Offen 10.

| Nr | Zugriffsweg | wie serverseitig gesperrt | Antwort | Pflichttest | Mutant (muss rot werden) |
|---|---|---|---|---|---|
| Z1 | **Lesen**: Nachrichten, Objekte, Verlauf, Suche, Abfragen jeder Art, auch Zähler („ungelesen“), Vorschauen | Eingangssperre G1 vor jedem Lese-Handler | `seat-unavailable` | **PT-01** jeder Lese-Handler aus dem Handler-Verzeichnis (G6) mit gesperrtem Schlüssel → `seat-unavailable`, Antwort ohne Inhalt und ohne Metadaten | **M-01** Eingangssperre für einen Lese-Handler übersprungen; **M-02** Fehlerantwort trägt Metadaten (Zahl, Größe, ETag) |
| Z2 | **Schreiben/Speichern**: anlegen, ändern, löschen, hochladen, Reaktion, eigene Lesebestätigung und Tipp-Anzeige der KI | G1 vor jedem Schreib-Handler; zusätzlich G3: Prüfung des Platz-Zustands **in derselben Transaktion** wie der Commit | `seat-unavailable`; ein begonnener, nicht festgeschriebener Schreibvorgang wird zurückgerollt | **PT-02** jeder Schreib-Handler → `seat-unavailable`, Datenbestand (Hash) unverändert; **PT-03** Wettlauf: Pause zwischen Prüfung und Commit → Rollback (viele Wiederholungen) | **M-03** Commit ohne erneute Prüfung |
| Z3 | **Aktionen/Werkzeuge/MCP**: alle MCP-Methoden des Programms (`tools/list`, `tools/call`, `resources/list`, `resources/read`, `resources/subscribe`, `prompts/*`, `completion/*`, auch unbekannte Methodennamen) und alle übrigen Aktions-Handler | G1 **vor** der Methodenauflösung; MCP-Benachrichtigungen (`notifications/*`) laufen über G2 | `seat-unavailable` (auch für unbekannte Methoden, damit nichts über die Methodenliste verrät) | **PT-04** jede MCP-Methode aus G6 und ein unbekannter Name → `seat-unavailable`; **PT-05** eine offene MCP-Sitzung erhält nach der Pause keine `notifications/*` und wird geschlossen | **M-04** `tools/list` ausgenommen; **M-05** unbekannte Methode beantwortet mit „method not found“ statt Sperre |
| Z4 | **Anwesenheit/Teilnehmerliste**: Mitgliederliste, Beitritt/Austritt, Anwesenheitsstatus, Tipp-Anzeigen, Lesebestätigungen anderer, Teilnehmer eines Anrufs, Zahl der Anwesenden, Spätkommende | Abfragen über G1; alle Ereignisse dieser Art über G2 (Ausgangssperre) | `seat-unavailable`; Ereignisse werden nicht zugestellt | **PT-06** während der Pause treten Menschen bei/aus, tippen, lesen, treten einem Anruf bei → **0** Zustellungen an den Platz; Mitgliederabfrage → `seat-unavailable` | **M-06** Mitgliedsereignisse am Ausgangsfilter vorbei |
| Z5 | **Feeds/Streams/Abos**: SSE, WebSocket, Cap'n-Proto-Ströme, Abos, Pull-Abfragen, Matrix-Appservice-Transaktionen für `@fsb-<platz>` (fs-messages, ADR 0091 Nachtrag „Bot-Schlüssel“ Punkt 7, Z. 177), Zustellung an eine Bot-Inbox | G4: alle Verbindungen des Platzes aus dem Verbindungsregister schließen; G2 vor jedem Rahmen; neue Abos über G1; fs-messages leitet keine Transaktion für den Platz weiter | Verbindung geschlossen (Grund „unavailable“); neues Abo `seat-unavailable` | **PT-07** nach der Pause: offene Verbindungen des Platzes = 0 innerhalb der Frist D (2b, N2); **PT-08** danach 0 Rahmen; **PT-09** ein Ereignis aus dem Pausenfenster wird **auch nach der Wiederaufnahme nie** zugestellt | **M-07** Strom bleibt offen; **M-08** Ereignisse gepuffert und nach der Wiederaufnahme nachgeliefert |
| Z6 | **Medienströme** in Konferenzen: Ton, Bild, Bildschirm, Mitschrift | Medienserver entfernt den Bot-Teilnehmer bzw. sein Abo serverseitig; keine Mitschrift für den Platz | Teilnehmer getrennt | **PT-10** während der Pause erreicht kein Ton-/Bild-Paket den Bot. **Bis PT-10 grün ist, wirkt Pause in Konferenzen mit Medienserver als Entfernen** (c0-Entscheid; N3, PT-33) | **M-09** Abo beim Medienserver bleibt bestehen |
| Z7 | **Benachrichtigungen**: Erwähnungen des Bots, Push, Mail, Erinnerungen, Webhooks an den Bot | G2 am Ausgang jeder Benachrichtigung; Benachrichtigungen an den Platz werden **verworfen**, nicht eingereiht | nichts zugestellt | **PT-11** Erwähnung und Erinnerung während der Pause → 0 Zustellungen, auch nach der Wiederaufnahme | **M-10** Benachrichtigung eingereiht statt verworfen |
| Z8 | **Bot-Schlüssel/Tokens**: Nutzung, Erneuerung, Rotation, Ausstellen eines neuen Schlüssels, Introspektion; Handeln von fs-messages für `@fsb-<platz>`; Raumschlüssel (Ende-zu-Ende) für das Bot-Gerät | Schlüssel im Schlüsselverzeichnis gesperrt; jede Nutzung über G1; Erneuerung/Rotation/Neuausstellung abgelehnt; fs-messages handelt nicht für den Platz; Raumschlüssel, die während der Pause für das Bot-Gerät ankommen, werden verworfen, nie nachgereicht | `seat-unavailable` | **PT-12** Erneuerung, Rotation, neuer Schlüssel während der Pause → abgelehnt; **PT-13** Raumschlüssel für Sitzungen aus dem Pausenfenster erreichen das Bot-Gerät nie; **PT-14** nach der Wiederaufnahme gilt ein **neuer** Schlüssel, der gesperrte wird widerrufen und bleibt ungültig (Entscheid c0 nach Nutzerregeln, 18.11. (Opus-Empfehlung angenommen), Offen 15) | **M-11** Erneuerung umgeht die Sperre; **M-12** Raumschlüssel nachgereicht |
| Z9 | **Hintergrundaufträge/geplante Aufträge**: Zeitpläne (fs-schedules), Workflows, Warteschlangen, Wiederholungen, laufende Langläufer | jeder Lauf mit Bezug auf den Platz geht als Aufruf durch G1; Langläufer prüfen vor jedem Schritt und beim Commit (G3); fällige Läufe im Pausenfenster werden ausgelassen und protokolliert, nicht nachgeholt (Entscheid c0 nach Nutzerregeln, 18.11. (Opus-Empfehlung angenommen), Offen 12) | Lauf abgelehnt (`seat-unavailable` nur im Protokoll) | **PT-15** ein während der Pause fälliger Lauf wird nicht ausgeführt; **PT-16** ein laufender Langläufer bricht vor dem nächsten Schritt ab, kein Commit nach dem Pause-Ereignis | **M-13** Zeitplaner ruft den Handler direkt, an G1 vorbei |
| Z10 | **Dateizugriff**: Herunterladen, Hochladen, Vorschau, Vorschaubilder, Anhänge, Export | jeder Dateizugriff nur mit Bot-Schlüssel über G1; **keine** vorab signierten oder Inhaber-Links für Bots: jeder Link ist an den Schlüssel gebunden und wird beim Abruf geprüft | `seat-unavailable` | **PT-17** ein vor der Pause ausgegebener Link → während der Pause abgelehnt; **PT-18** Hochladen abgelehnt | **M-14** vorab signierter Link ohne Prüfung beim Abruf |
| Z11 | **Vorschläge/Entwürfe**: neue Vorschläge der KI; Freigabe vorhandener Vorschläge; Entwürfe der KI auf dem Server | neue Vorschläge über G1 abgelehnt; eine Freigabe durch einen Menschen würde eine Aktion der KI auslösen → wird während der Pause nicht ausgeführt (Mensch sieht „KI pausiert“); Ablehnen durch Menschen geht; Entwürfe der KI weder lesbar noch änderbar für den Platz | `seat-unavailable` (für den Bot); Hinweis für den Menschen | **PT-19** Freigabe eines KI-Vorschlags während der Pause → nichts ausgeführt; **PT-20** neuer Vorschlag → abgelehnt | **M-15** Freigabe führt trotz Pause aus |
| Z12 | **Protokoll lesen**: Audit, fs-activity, eigene Aufruf-Ergebnisse, Auftragsstatus | G1; zusätzlich ein **dauerhafter** Filter: die Einträge über Pause und Wiederaufnahme selbst sind für Bot-Schlüssel nie lesbar; lesbar ist nach der Wiederaufnahme nur der Hinweis „pausiert von–bis“ ((2f)) | `seat-unavailable` | **PT-21** Protokollabfrage während der Pause → abgelehnt; nach der Wiederaufnahme sieht der Bot genau einen Hinweis je Pause mit Beginn und Ende (UTC), ohne Person, Grund oder Inhalt | **M-16** Pause-Eintrag mit Person oder Grund für den Bot lesbar |
| Z13 | **Weitere Programme** (der Platz hat je Programm einen eigenen Schlüssel, ADR 0091 Nachtrag „Bot-Schlüssel“ Punkt 2) | jedes Programm prüft in G1 den Platz-Zustand **bei jedem Aufruf** beim Mandats-Programm, ohne Zwischenspeicher; Ströme nur mit Laufzeit-Lease ≤ L; das Mandats-Programm meldet die Pause sofort an jedes Programm mit Schlüssel und wartet auf Bestätigung; Mandats-Programm nicht erreichbar → Ablehnung | `seat-unavailable` | **PT-22** Pause im Programm A → Aufruf in Programm B abgelehnt; Mandats-Programm unerreichbar → abgelehnt; Strom in B spätestens nach L geschlossen | **M-17** Zustand zwischengespeichert; **M-18** bei Nichterreichbarkeit erlauben |
| Z14 | **Bot-Laufzeit** (`fs-delegate`, lokal; nicht serverseitig, zählt **nicht** zum Nachweis) | hält keinen Inhalts-Zwischenspeicher über einen Aufruf hinaus; ruft die KI während der Pause nicht auf; MCP-Aufrufe der KI an den Bot → `unavailable` ohne Grund | `unavailable` | **PT-23** bei pausiertem Server liefert die Laufzeit auf jede MCP-Anfrage der KI keinen Inhalt | **M-19** Laufzeit antwortet aus Zwischenspeicher |

Grenzen, ehrlich: (i) Was die KI vor der Pause gelesen hat, liegt bei ihr und beim Anbieter (Z. 153); die Pause wirkt nur nach vorn. (ii) Z6 (Medienserver) ist **nicht belegt**: bis PT-10 grün ist, wirkt Pause in Konferenzen mit Ton/Bild als Entfernen (c0-Entscheid; 2b, N3). (iii) Z14 ist unser Code, läuft aber dort, wo der Halter ihn betreibt; deshalb verlässt sich der Nachweis nur auf die Programme.

**(2b) „100 %“: wie belegt wird, dass nichts mehr durchgeht; Not-Aus-Regel**

*Bauweise (Gerüst, Bibliothek `fs-delegate`; Namen Vorschlag):*
- **G1 Eingangssperre:** einziger Weg, auf dem ein Bot-Schlüssel erkannt wird; sitzt **nach** der Schlüssel-Erkennung und **vor** jeder Weiterleitung an einen Handler (vor Routing, vor Methodenauflösung). Lässt nur `Active` durch.
- **G2 Ausgangssperre:** jede Zustellung an eine Bot-Verbindung läuft über einen Zustell-Typ (`BotSink`), den nur G1 erzeugen kann (Konstruktor privat). Prüft den Zustand vor jedem Rahmen, jeder Benachrichtigung, jedem Ereignis.
- **G3 Commit-Prüfung:** Schreibvorgänge eines Platzes lesen den Platz-Zustand in derselben Transaktion wie ihr Commit. Pause-Ereignis und Commit sind damit geordnet: was vor der Pause festgeschrieben ist, war vor der Pause; alles andere wird zurückgerollt.
- **G4 Verbindungsregister:** jede Bot-Verbindung ist je Platz registriert; die Pause schließt alle.
- **G5 Zeitplaner/Warteschlangen:** Läufe eines Platzes werden nur als Aufruf durch G1 ausgeführt.
- **G6 Handler-Verzeichnis:** alle Handler (RPC-Methoden aus dem Cap'n-Proto-Schema, HTTP-Routen, MCP-Methoden, Appservice-Endpunkte, Lauf-Arten, Zustell-Arten) werden nur über die Registrierung des Gerüsts angemeldet; daraus entsteht beim Bau eine Liste.
- **G7 Scheitert geschlossen:** unbekannter, fehlender oder unlesbarer Zustand, nicht erreichbares Mandats-Programm, Handler ohne Eintrag in G6 → Ablehnung.
- **G8 Nachweis:** die CI erzeugt je Programm-Build einen **Pause-Nachweis** (Handler-Liste aus G6, Ergebnisse PT-24 bis PT-30, Mutantenlauf mit 0 Überlebenden, Build-Hash) als Prüfergebnis im Release (fs-release). Ein Programm meldet sich nur dann als „pausierbar“, wenn der Nachweis zu seinem Build passt.

*Generische Pflichttests:*
- **PT-24 „Jeder Handler lehnt ab“:** der Test läuft über die **vollständige** Liste aus G6 (nicht über eine Hand-Liste) und prüft je Handler: gesperrter Schlüssel → `seat-unavailable`, Datenbestand unverändert, kein ausgehender Rahmen.
- **PT-25 Quelltext-Prüfung:** kein Handler, keine Route, keine Zustellung wird außerhalb der Registrierung von G6 angelegt (Prüfung im Bau; Fund = Bau rot).
- **PT-26 Selbstprüfung beim Start:** Zahl der zur Laufzeit registrierten Handler = Zahl in der Liste aus G6; weicht sie ab, nimmt das Programm **keinen** Bot-Schlüssel an.
- **PT-27 Neue Wege scheitern geschlossen:** ein Test-Handler, der ohne Eintrag in G6 angelegt wird, ist für Bot-Schlüssel nicht erreichbar (und PT-25 wird rot).
- **PT-28 Zustand:** unbekannter oder unlesbarer Platz-Zustand → Ablehnung.
- **PT-29 Ordnung:** Wettlauf Pause gegen Lese-, Schreib- und Zustellvorgänge (viele Wiederholungen): nach dem Pause-Ereignis kein Commit, kein Rahmen, keine Antwort mit Inhalt.
- **PT-30 Mutantenlauf** über G1 bis G7 und die Registrierung: 0 Überlebende (M-01 bis M-19 sind die benannten Pflicht-Mutanten).

*Not-Aus-Regel (Nutzerentscheid 25: „Ist das nicht 100 % belegbar, wirkt Pause wie ein Not-Aus: sofort Entfernen.“). Nicht zu verwechseln mit dem „Notaus“ aus 0054 Punkt 5 (Z. 32, eine Rechte-Einstellung).*
- **N1 statisch:** fehlt für ein Programm, in dem der Platz einen Schlüssel hat, der passende Pause-Nachweis (G8), dann wirkt „Pause“ dort als **Entfernen**.
- **N2 zur Laufzeit:** die Pause gilt erst als wirksam, wenn (a) das Pause-Ereignis festgeschrieben ist, (b) jedes Programm mit Schlüssel bestätigt hat und (c) das Verbindungsregister 0 meldet, alles innerhalb der Frist D. Sonst: **automatisch Entfernen**, mit Protokolleintrag „Pause nicht bestätigt, Entfernen“.
- **Fristen D und L sind Einstellungen** (c0-Entscheid: einstellbar mit Voreinstellung; Zahlen und Grenzen: Entscheid c0 nach Nutzerregeln, 18.11. (Opus-Empfehlung angenommen), Offen 18; ADR 0100: deklariert als Ganzzahl in Millisekunden mit Grenzen, Schicht Instanz, **gesperrt**, weil sonst Profil-Schichten den Wert überschreiben (ADR 0100 Z. 32–33, „Eine Sperre schlägt jede Schicht“; Review A7)): **D** = Frist, bis die Pause bestätigt sein muss, Voreinstellung **1 s**; **L** = Lease für Ströme in weiteren Programmen (Z13), Voreinstellung **5 s**. Grenzen: D 0,2–10 s, L 1–60 s; Werte außerhalb werden abgelehnt (`out-of-range`). Ändern geht nur über das Schloss nach ADR 0100 Punkt 5 (Instanz-Admins mit `can_lock`); die KI sieht und ändert sie nie (ADR 0091 Z. 51).
- **N3 unbelegte Wege:** solange ein Zugriffsweg einer Situation keinen grünen Pflichttest hat, wirkt Pause in dieser Situation als Entfernen. Heute betrifft das Konferenzen mit Medienserver (Z6; c0-Entscheid).
- **N4 wenn auch Entfernen nicht festgeschrieben werden kann:** das Programm nimmt für diesen Platz keinen Schlüssel mehr an (Sperrliste im Speicher, geschlossen) und meldet einen Befund.
- **Anzeige** (Entscheid c0 nach Nutzerregeln, 18.11. (Opus-Empfehlung angenommen), Offen 13): wo Pause als Entfernen wirkt, heißt der Knopf weiter „Pause“ und trägt sichtbar den Hinweis „wirkt hier als Entfernen“; ein Druck fragt **einmal** nach (ja/nein), weil Entfernen nur über eine neue Umfrage rückgängig zu machen ist. Der Knopf „Entfernen“ daneben wirkt wie immer ohne Rückfrage.

*Pflichttests Not-Aus-Regel:*
- **PT-31** Programm ohne gültigen Pause-Nachweis: „Pause“ → Mandat `Stopped`, Schlüssel widerrufen, Bot draußen (**M-20** ohne Nachweis trotzdem echte Pause).
- **PT-32** eine Verbindung lässt sich nicht schließen bzw. ein Programm bestätigt nicht innerhalb D → automatisch Entfernen (**M-21** Fristüberschreitung ignoriert).
- **PT-33** Situation mit Medienstrom (Z6 unbelegt) → Pause wirkt als Entfernen.
- **PT-34** Festschreiben des Pause-Ereignisses scheitert → Entfernen; scheitert auch das → Schlüssel des Platzes wird nicht mehr angenommen (N4).
- **PT-47** D und L stehen als deklarierte Einstellungen mit Voreinstellung 1 s bzw. 5 s; Werte außerhalb der Grenzen → `out-of-range`; geänderter Wert D wirkt in PT-32 (**M-27** Frist fest im Code statt aus der Einstellung).
- **PT-60** D und L sind gesperrte Instanz-Einstellungen: ein Wert im Profil einer Person oder eines Programms ändert die wirksame Frist nicht (**M-43** Profil-Schicht überschreibt D oder L).
- **PT-61** Zustand „ruht“ (Halter-Verlust, Ratenbegrenzung): PT-24 läuft mit diesem Zustand ebenso grün wie mit `Paused` (**M-44** „ruht“ lässt Lesen durch).
- **PT-62** Situation, in der Pause als Entfernen wirkt: der Knopf „Pause“ zeigt den Hinweis und fragt einmal nach; ohne Bestätigung keine Wirkung; „Entfernen“ wirkt ohne Rückfrage (**M-45** Pause wirkt dort ohne Hinweis als Entfernen). Einzelplatz: PT-24 bis PT-30 für den MCP-Baustein grün (Offen 19).

**(2c) Rechte: wer Pause, Wiederaufnahme und Entfernen auslösen darf**
- **Jede Person** in der Situation kann **jederzeit** Pause und Entfernen auslösen: Mitglieder ohne Sonderrecht, betreute Konten, zugelassene Gäste, Spätkommende nach ihrer Bestätigung. Es ist **kein** Recht aus fs-access und **keine** Einstellung: kein Admin, kein Halter, keine Gruppe kann es abschalten oder einschränken (anders als der Notaus in 0054 Punkt 5, Z. 32, der eine Rechte-Einstellung ist). Voraussetzung ist nur eine angemeldete Menschen-Sitzung in dieser Situation.
- „Jederzeit“ heißt auch: während einer Zustimmungsrunde, während laufender Aufrufe, während einer Pause (Entfernen geht immer).
- **Nie** durch die KI, ihren Bot oder einen anderen Bot: Pause, Wiederaufnahme und Entfernen nehmen keinen Bot-Schlüssel an und sind nie MCP-Werkzeug (wie `MessageAction.decide`, Z. 51). Die KI kann eine Pause weder aufheben noch verzögern noch abfragen.
- Wer später dazukommt, wird auch bei pausierter KI vorgewarnt und muss bestätigen (die KI sitzt weiter auf dem Platz; Z. 151).
- **Wiederaufnahme (Nutzer, Frage 33):** fortsetzen dürfen (a) wer pausiert hat, (b) Admins, und zwar alle drei Stufen nach ADR 0095 (Z. 8: Admin-Gruppe für alles, Admin-Gruppe für alle Gruppen, Verwaltung der Gruppe selbst), (c) Inhaber (Eigentümer, ADR 0095) und (d) jede Person mit dem eigenen Recht `ai.resume`, zugeschrieben über fs-access (Stufen und Name: Entscheid c0 nach Nutzerregeln, 18.11.). Grund des Nutzers, sinngemäß: „Sonst könnte jemand pausieren und die Gruppe verlassen, dann wäre die KI dauerhaft aus.“ Daraus: verlässt die pausierende Person die Situation, bleibt die Pause bestehen, bis ein Berechtigter (b)–(d) fortsetzt oder jemand entfernt.
- `ai.resume` ist ein Recht für Menschen; die KI und ihr Bot erhalten es nie (wie `can_lock`, ADR 0100; Verbote ADR 0091 Z. 51). Es gibt kein Recht, das Pause oder Entfernen erlaubt oder verbietet: beides kann jede Person.
- Nach **Entfernen** und Wiederkehr über eine neue Umfrage besteht **keine** alte Pause mehr: der neue Platz beginnt `Active` (Nutzer, Frage 33).
- Mehrere KIs: Pause gilt je Platz (wie ADR 0091 Z. 129); „alle KIs pausieren“ ist ein eigener Schritt, der jeden Platz einzeln pausiert (Vorschlag).
- **Mehrere Pausen** (Entscheid c0 nach Nutzerregeln, 18.11., Offen 11): Pause ist ein Zustand des Platzes; haben mehrere Personen pausiert, bleibt es **ein** Zustand. **Eine** berechtigte Wiederaufnahme ((a)–(d)) hebt ihn auf, auch wenn sie von einer von mehreren pausierenden Personen kommt. Das Protokoll zeigt **alle** Pausen mit Person und Zeit.

*Pflichttests Rechte:*
- **PT-35** betreutes Konto und Mitglied ohne Sonderrecht lösen Pause und Entfernen aus → wirkt.
- **PT-36** es gibt keine Einstellung, die Pause oder Entfernen abschaltet (Deklarationsliste ADR 0100 enthält keinen solchen Schlüssel); ein Admin kann den Knopf nicht ausblenden.
- **PT-37** Pause, Wiederaufnahme oder Entfernen mit Bot-Schlüssel → abgelehnt; keine der drei steht in `tools/list` (**M-22** als MCP-Werkzeug angeboten).
- **PT-38** die KI kann eine Pause nicht aufheben (jeder Weg aus Z1 bis Z14).
- **PT-48** Wiederaufnahme durch: die pausierende Person, einen Admin, einen Inhaber, eine Person mit `ai.resume` → wirkt; durch ein Mitglied ohne dieses Recht, das nicht pausiert hat → abgelehnt (**M-28** jede Person darf fortsetzen; **M-29** nur die pausierende Person darf fortsetzen).
- **PT-49** pausierende Person verlässt die Situation → Pause bleibt; ein Admin, Inhaber oder Inhaber von `ai.resume` setzt fort → wirkt.
- **PT-50** `ai.resume` lässt sich keinem Bot-Platz zuschreiben (**M-30** Zuschreibung an Bot erlaubt).
- **PT-51** Entfernen während einer Pause, dann neue Umfrage mit Zustimmung aller → der neue Platz ist `Active`, keine Pause übernommen (**M-31** Pause am neuen Platz geerbt).
- **PT-56** zwei Personen pausieren denselben Platz → **ein** Zustand `Paused`; eine der beiden setzt fort → `Active`; das Protokoll enthält **beide** `pausiert` mit Person und Zeit (**M-38** Zustand je Person: zweite Pause hält den Platz weiter an; **M-39** nur die letzte Pause protokolliert).
- **PT-57** Wiederaufnahme durch je eine Person der drei Admin-Stufen nach ADR 0095 → wirkt; das Recht heißt `ai.resume` (**M-40** eine der drei Stufen fehlt).

**(2d) Entfernen**
- Wirkung (bisher „STOP KI“, ADR 0091 Punkt 9 mit Nachtrag „Bot-Schlüssel“ Punkt 5): (a) Steuer-Sitzung getrennt; (b) Mandat `Stopped`, der Platz ist **geschlossen** und wird nie wieder geöffnet; (c) jedes Programm widerruft seinen Schlüssel für diesen Platz (nicht nur sperren); (d) alle Verbindungen geschlossen (G4); (e) alle Aufträge des Platzes enden (Ereignis `beendet`), offene Vorschläge verfallen, geplante Läufe werden gelöscht; (f) alle Zustimmungen zu diesem Platz werden in fs-people als widerrufen festgehalten (`AiAssistance`; Herkunft, Vorschlag: „Entfernen“); (g) der Bot verlässt die Situation (Matrix: Raum verlassen, Gerät beenden); (h) Protokolleintrag.
- **Wiederkehr nur über eine neue Umfrage:** das heißt eine neue Zustimmungsrunde aller (ADR 0091 Punkt 6 und 7: eine Absage genügt) für einen **neuen** Platz mit neuem Schlüssel. Der alte Platz und sein Schlüssel gelten nie wieder (Ableitung der Strategie: „neue Umfrage“ = Zustimmungsrunde nach Punkt 7). Eine Pause des alten Platzes geht nicht auf den neuen über (Nutzer, Frage 33; PT-51).
- Gleiche Wirkung wie Entfernen haben weiterhin: Rückzug der Zustimmung (Punkt 7, Z. 87), Schalter „KI erlaubt“ auf „nein“ (Z. 177), MCP-Schalter AUS (Z. 186), die Not-Aus-Regel (2b).
- Entfernen geht auch während einer Pause.
- *Pflichttests:* **PT-39** Entfernen → Mandat `Stopped`, Schlüssel in **jedem** Programm widerrufen, Verbindungen 0, Aufträge beendet, Zustimmungen widerrufen, Bot draußen (**M-23** Zustimmungen bleiben bestehen); **PT-40** der alte Platz lässt sich nicht wieder öffnen, sein Schlüssel nie wieder benutzen; Rückkehr nur mit neuem Platz nach vollständiger Zustimmungsrunde (**M-24** alter Platz reaktivierbar); **PT-41** Entfernen während einer Pause wirkt.

**(2e) Auftrag widerrufen (bleibt beim Ersteller)**
- Wer: **nur der Ersteller** des Auftrags (`created_by`, Punkt (3)). Andere Personen können einen fremden Auftrag nicht widerrufen; sie haben Pause und Entfernen.
- Wirkung: Ereignis `widerrufen` (append-only); unter diesem Auftrag keine weitere Aktion (Prüfstufe 3 in Punkt (4)); Bot-Platz, Mandat `Active`, Schlüssel, Zustimmungen und andere Aufträge bleiben; keine neue Zustimmungsrunde; die KI wartet auf den nächsten Befehl (Nutzerwort (D)).
- **Wirkung auf laufende Aufrufe:** (a) ein Schreibvorgang des Auftrags, der noch nicht festgeschrieben ist, wird zurückgerollt (Commit prüft das Ereignis `widerrufen` in derselben Transaktion, wie G3); (b) ein mehrschrittiger Vorgang bricht vor dem nächsten Schritt ab (Protokoll vor jedem Schritt, Nachtrag (3) Punkt 1); (c) was schon festgeschrieben oder nach außen gegangen ist (z. B. eine versandte Nachricht), bleibt; (d) für diesen Auftrag liest die KI **nichts mehr** (Entscheid c0 nach Nutzerregeln, 18.11., Offen 9): Lese-Aufrufe mit dieser Auftrags-Id → `order-revoked`; Lese-Ergebnisse unter diesem Auftrag, die noch unterwegs sind, werden nicht mehr zugestellt (Prüfung am Ausgang wie G2); Ströme und Abos, die unter diesem Auftrag geöffnet wurden, werden geschlossen. Das wirkt wie eine Pause, aber nur für diesen Auftrag; der Platz ist nicht pausiert.
- Der Ersteller kann auch während einer Pause widerrufen.
- **Lesen nach dem Widerruf** (Entscheid c0 nach Nutzerregeln, 18.11., Offen 9): für diesen Auftrag nichts mehr ((d) oben). Was die KI ohne Auftrag als Teilnehmer nach dem Mandat liest, berührt der Widerruf nicht (Ableitung: der Entscheid nennt nur „diesen Auftrag“; den ganzen Platz sperrt die Pause).
- Die Aufträge selbst ändert eine Pause nicht; nach der Wiederaufnahme gelten sie weiter, sofern nicht widerrufen oder abgelaufen. `valid_until` läuft während der Pause weiter; nach der Wiederaufnahme wird der Ersteller über seine noch laufenden und die in der Pause abgelaufenen Aufträge benachrichtigt (Entscheid c0 nach Nutzerregeln, 18.11. (Opus-Empfehlung angenommen), Offen 12).
- *Pflichttests:* **PT-42** Widerruf durch eine andere Person als den Ersteller → abgelehnt (**M-25** jede Person darf widerrufen); **PT-43** Widerruf zwischen Prüfung und Commit → Rollback (**M-26** Commit ohne Prüfung des Auftrags); **PT-44** Widerruf während einer Pause durch den Ersteller → wirkt.
- *Pflichttests (Entscheide 18.11.):* **PT-53** Lese-Aufruf mit widerrufener Auftrags-Id → `order-revoked`, kein Inhalt (**M-35** Lesen unter widerrufenem Auftrag erlaubt); **PT-54** ein Lese-Ergebnis unter dem Auftrag, das beim Widerruf unterwegs ist, wird nicht zugestellt; ein unter dem Auftrag geöffneter Strom ist geschlossen (**M-36** Ergebnis nach dem Widerruf zugestellt); **PT-55** nach dem Widerruf liest die KI ohne Auftrag als Teilnehmer weiter, Platz bleibt `Active` (**M-37** Widerruf sperrt den ganzen Platz); **PT-58** ein Auftrag, dessen `valid_until` in die Pause fällt, ist nach der Wiederaufnahme `order-expired`; der Ersteller erhält nach der Wiederaufnahme genau eine Benachrichtigung (**M-41** Ablauf während der Pause angehalten).

**(2f) Protokoll und Trailer; was die KI erfährt**
- Pause, Wiederaufnahme, Entfernen und Auftrag widerrufen sind Handlungen eines **Menschen**: AS2-Aktivität mit `actor` = Person, `object` = Platz bzw. Auftrag, Zeit UTC; Protokoll vor der Wirkung (Nachtrag (3) Punkt 1).
- Sie erzeugen keinen Commit und keinen Trailer. `FS-Actor:`/`FS-On-Behalf-Of:` stehen nur an Handlungen der KI; während einer Pause entsteht keine (Z2).
- Die Menschen der Situation sehen „KI pausiert“ **und wer pausiert hat**, bei mehreren Pausen alle Personen (Entscheid c0 nach Nutzerregeln, 18.11., Offen 14: Betreiber- und Raumsicht offen und protokolliert, wie ADR 0095 Punkt 16 „Eigentümer sind immer sichtbar“). Das gilt ebenso für Wiederaufnahme und Entfernen. Die KI sieht es nie (Z12).
- **Was die KI erfährt (c0-Entscheid):** **während** der Pause **nichts** (keine Runde, keine Zustellung, Anfragen `seat-unavailable` bzw. MCP `unavailable` ohne Grund, byte-gleich mit einem Ausfall). **Nach** der Wiederaufnahme bekommt sie je Pause-Zustand einen Protokollhinweis **„pausiert von–bis“** (Beginn = erstes `pausiert`, Ende = `fortgesetzt`, in UTC), **ohne Inhalt**: keine Person, kein Grund, nichts aus dem Pausenfenster (ehrlich statt einer unerklärten Lücke). Die Einträge über Pause und Wiederaufnahme selbst bleiben für Bot-Schlüssel unlesbar (Z12).
- Nachgeliefert wird nichts aus dem Pausenfenster (PT-09, PT-11, PT-13). Bei der Wiederaufnahme bekommt die KI den **aktuellen** Stand wie bei einem Eintritt; ob die aktuelle Mitgliederliste damit verrät, wer in der Pause kam oder ging: Offen 20.
- Grenze: Der Halter ist ein Mensch und sieht das Protokoll. Ob er der KI mehr erzählt, liegt außerhalb unserer Programme.
- *Pflichttests:* **PT-45** Pause-Eintrag hat `actor` = Person und keinen Trailer `FS-Actor:`; **PT-46** die Antwort an die KI während der Pause ist byte-gleich mit der Antwort bei einem Ausfall des Programms (**M-32** Antwort trägt „paused“ oder einen Grund); **PT-52** nach der Wiederaufnahme genau ein Hinweis „pausiert von–bis“ je Pause-Zustand (auch bei mehreren Pausierenden), Zeiten UTC, ohne Person und Inhalt; vor der Wiederaufnahme kein Hinweis (**M-33** Hinweis schon während der Pause zugestellt; **M-34** Hinweis nennt die pausierende Person).
- *Pflichttests (Entscheide 18.11.):* **PT-59** die Menschen der Situation sehen bei Pause, Wiederaufnahme und Entfernen die auslösende Person, bei mehreren Pausen alle; der Bot sieht sie nie (**M-42** Pausierer verborgen; **M-34** bleibt: Bot sieht die Person).

**(3) Was ein Auftrag ist (Ausgestaltung Strategie, Namen Vorschlag)**
- Ein Auftrag ist ein **Datensatz** im Programm der Situation, verwaltet von `fs-delegate` (wie das Mandat, ADR 0091 Z. 39), typisiert gespeichert (ADR 0086), kein JSON. Er gehört zu genau einem Bot-Platz (Mandat).
- Felder (Skizze): `id` (UUID), `seat` (Bot-Platz), `created_by` (Person; **vom Server aus der Sitzung gesetzt, nie aus der Anfrage**), `created_at` (UTC), `valid_until` (UTC), `scope` (Liste von Recht + Muster, wie fs-access-Rechte in TRAIT-ENTWUERFE §9 (3a)), `shown_digest` (Digest des Textes, den die Person beim Erteilen gesehen hat, Muster „Freigabe gilt nur für das Gesehene“, Z. 53–55).
- Zustand nur über **Ereignisse** (append-only): `erteilt`, `widerrufen`, `abgelaufen`, `benutzt` (je Aktion, mit Aufruf-Id). Kein Ereignis wird geändert oder gelöscht; der Zustand ergibt sich aus der Folge. Pause und Wiederaufnahme sind Ereignisse des **Platzes** (`pausiert`, `fortgesetzt`, (2a)), nicht des Auftrags; ein Auftrags-Ereignis `angehalten` gibt es nicht.
- `scope` ⊆ Mandat des Platzes ⊆ Rechte der Person (Nachtrag (3), Ausg. 2; ADR 0091 Punkt 4).

**(4) Wie geprüft wird (Antwort auf (E))**

*Wer einen Auftrag anlegen kann.* Nur eine angemeldete Person: entfernt über ihre Kanidm-OIDC-Sitzung (`fs_access::Subject`), lokal über den Socket-Eigentümer (Muster wie das Akteur-Prüfen im Git-Modul, TRAIT-ENTWUERFE §9 (2) Z. 410–412: „Mensch → `as.name` muss die Person der Sitzung sein“). Die Methode „Auftrag erteilen“:
- nimmt **keinen** Bot-Schlüssel an (Bot-Schlüssel sind nie Menschenanmeldung, ADR 0091 Z. 176);
- wird **nie** als MCP-Werkzeug angeboten (wie `MessageAction.decide`, Z. 51; ADR 0091 Z. 51: die KI vergibt nie Rechte oder Mandate);
- setzt `created_by` aus der Sitzung; ein mitgeschicktes Feld „Ersteller“ gibt es im Vertrag nicht;
- schreibt das Ereignis `erteilt` ins Protokoll, bevor der Auftrag gilt (Nachtrag (3) Punkt 1).

*Was die KI bei einem Aufruf mitbringt.* Ihren Bot-Schlüssel (ADR 0091 Nachtrag „Bot-Schlüssel“) und die **Auftrags-Id**, dazu eine **Aufruf-Id** (einmalig). Nie ein Token der Person (Nachtrag (3) Punkt 3).

*Was das Programm je Aufruf prüft (Reihenfolge; jede Stufe scheitert geschlossen):*
0. Bot-Schlüssel gültig, Mandat des Platzes `Active` (bestehend, ADR 0091 Z. 66, 173, 175).
1. **Auftrag existiert** und gehört **zu diesem Platz** (`seat` = Platz des Schlüssels) → sonst `order-unknown`.
2. **Ersteller = genannte Person:** `on_behalf_of` der Anfrage = `created_by` des Auftrags, und `created_by` ist Halter des Platzes (ADR 0091 Nachtrag (2) Punkt 1) → sonst `order-mismatch`.
3. **Nicht widerrufen, nicht abgelaufen:** kein Ereignis `widerrufen`, `valid_until` > jetzt (UTC) → sonst `order-revoked` bzw. `order-expired` (beides beendet nur diesen Auftrag, für jeden Aufruf mit dieser Auftrags-Id, auch Lese-Aufrufe ((2e) d); kein Entfernen, keine Pause des Platzes).
4. **Umfang deckt die Aktion:** Recht + Muster der Aktion ∈ `scope` → sonst `order-scope{right}`.
5. **Aktuelle Rechte der Person decken sie** (kleiner-gleich, zur Ausführungszeit, Nachtrag (3) Punkt 8) → sonst `on-behalf-exceeds{right}` (Name aus ADR 0091 Z. 257).
6. **Aufruf-Id neu** für diesen Auftrag → sonst `order-replay`.
7. Protokolleintrag (Absicht) geschrieben → sonst `audit-failed`, keine Aktion (TRAIT-ENTWUERFE §9 (2) Z. 414–416).

*Wer prüft das Kleiner-gleich (Stufe 5) — Festlegung (Strategie, zur Bestätigung):* Die **Rechte** der Person liefert **fs-access** (dort liegen Rechte, Vorlagen und Zuschreibungen: TRAIT-ENTWUERFE §9 (3b), GM11 entschieden; ADR 0100 Z. 39). Den **Vergleich** macht das **Programm, das die Aktion ausführt**, über die Rechte-Schicht des Gerüsts (`fs-delegate`), bei jedem Aufruf, ohne Zwischenspeicher über die Aktion hinaus. Grund: ADR 0091 Z. 175 („weil das Programm jeden Aufruf selbst prüft“; Pause, Entfernen und Prüfung verlassen sich nicht auf eine zentrale Anmeldestelle). Ist fs-access nicht erreichbar: Ablehnung (`access-unavailable`, wie TRAIT-ENTWUERFE §9 (6) Z. 513).

*Wie kann die KI sich keinen Auftrag selbst ausstellen?*
- Die Methode „Auftrag erteilen“ verlangt eine Menschen-Sitzung; ein Bot-Schlüssel wird dort abgewiesen (Test unten).
- Sie ist kein MCP-Werkzeug; die KI sieht sie nicht.
- `created_by` kommt aus der Sitzung, nicht aus der Anfrage; die KI kann keinen fremden Ersteller eintragen.
- Die Auftrags-Tabelle ist append-only; die KI hat keinen Schreibweg dorthin (sie hält nie `Manage`, ADR 0091 Z. 51).
- Jedes `erteilt` steht im Protokoll mit Person, Zeit, Umfang und `shown_digest`; die Person sieht ihre Aufträge.
- Keine zusätzliche Signatur des Auftrags in dieser Fassung („nicht paranoid“: die Sitzung ist der Nachweis; eine Signatur prüft nur dasselbe Programm). Ob später nötig, z. B. für Aufträge über Programmgrenzen: Offen 5.

*Wiederholung (Replay).* Die Auftrags-Id allein nützt nichts: ohne gültigen Bot-Schlüssel desselben Platzes Stufe 0/1 rot. Mit Schlüssel: jede Aufruf-Id gilt einmal je Auftrag (Ereignis `benutzt`), danach `order-replay`; `valid_until` begrenzt die Zeit. Ob ein Auftrag zusätzlich eine Höchstzahl an Aktionen hat: Offen 3.

*Gestohlener Bot-Schlüssel.* Die bestehende Grenze bleibt ehrlich (ADR 0091 Z. 78: „Wer ein Token bei aktivem Mandat stiehlt, handelt als Bot innerhalb der Obergrenze, bis STOP, Ablauf oder Widerruf wirkt“). Neu begrenzt sie zusätzlich der Auftrag: ohne gültigen Auftrag gibt es kein `on_behalf_of`; mit Auftrag nur dessen Umfang, nur bis `valid_until`, nur bis zum Widerruf. Einen neuen Auftrag kann der Dieb nicht anlegen (braucht Menschen-Sitzung). Jede Aktion steht mit `actor` = Bot und Auftrags-Id im Protokoll; Widerruf des Auftrags, Pause oder Entfernen beenden die Wirkung; Pause sperrt den Schlüssel, Entfernen widerruft ihn.

*Protokoll und Trailer.* Jede Aktion schreibt vorher (Nachtrag (3) Punkt 1) einen Eintrag mit `actor` (KI-Bot), `on_behalf_of` (Person), Auftrags-Id, Aufruf-Id, Recht, Aktion, Zeit UTC. In Commits und Tags des Git-Moduls (TRAIT-ENTWUERFE §9 Z. 478, 482, GM3/GM12): `FS-Actor:` (KI-Bot), `FS-On-Behalf-Of:` (Person), `FS-Deviation:` nur wenn eine Schutzregel abweicht. Ob zusätzlich die Auftrags-Id als Trailer erscheint (Vorschlag `FS-Order:`): Offen 4. Token und Schlüssel nie im Eintrag (Nutzer 23.3).

**(5) Vergleich mit RFC 8693 (OAuth 2.0 Token Exchange)** — Wortlaut abgerufen 2026-11-17, `https://www.rfc-editor.org/rfc/rfc8693.txt`

| RFC 8693 (Wortlaut, Abschnitt) | übernehmen wir? |
|---|---|
| §1.1 Impersonation: „when A is impersonating B, A is B within the context of the rights authorized by the token.“ | **Nein, ausdrücklich nicht.** Das wäre „die KI übernimmt die Person“ (Nutzer 23.2, Nachtrag (Baukasten) Punkt 5). |
| §1.1 Delegation: „With delegation semantics, principal A still has its own identity separate from B“ … „In a sense, A is an agent for B.“ | **Ja, als Bedeutung:** KI = eigener Akteur, Person = `on_behalf_of`. |
| §4.1 „The "act" (actor) claim provides a means within a JWT to express that delegation has occurred“; „The "act" claim value is a JSON object, and members in the JSON object are claims that identify the actor.“ | **Bedeutung ja, Form nein:** unser `actor` entspricht `act`, unser `on_behalf_of` dem Subjekt; wir tragen das im Protokoll und im Vertrag (`ActorRef.onBehalfOf`, ADR 0091 Z. 257), nicht in einem JWT. |
| §4.1 „The outermost "act" claim represents the current actor while nested "act" claims represent prior actors.“; „For the purpose of applying access control policy, the consumer of a token MUST only consider the token's top-level claims“; „Prior actors identified by any nested "act" claims are informational only“ | **Teilweise:** wir kennen keine Ketten (KI-zu-KI nur über Menschen, ADR 0091 Z. 164). Übernommen: entschieden wird nur über den aktuellen Akteur und den Auftrag, nie über mitgeschickte Angaben. |
| §4.4 „The "may_act" claim makes a statement that one party is authorized to become the actor and act on behalf of another party.“ | **Bedeutung ja:** unser Auftrag ist diese Aussage, aber als Datensatz im Programm, angelegt nur in der Sitzung der Person, mit Umfang und Ablauf; `may_act` selbst trägt laut §4.4 nur Identität („claims within the "may_act" claim pertain only to the identity of that party“), keinen Umfang. |
| §2.1 `subject_token` (REQUIRED): „A security token that represents the identity of the party on behalf of whom the request is being made.“ | **Nein.** Die KI legt nie ein Token der Person vor (Nutzer 23.2, 23.3). Den Beleg „die Person will das“ liefert der Auftrag, nicht ein Token. |
| §2.1 `actor_token` (OPTIONAL): „A security token that represents the identity of the acting party.“ | **Entspricht** dem Bot-Schlüssel des Programms (ADR 0091 Nachtrag „Bot-Schlüssel“). |
| §1 „The scope of this specification is limited to the definition of a basic request-and-response protocol“; Syntax, Semantik und Sicherheitseigenschaften der Token selbst „are explicitly out of scope“; an das Vertrauensmodell stellt die RFC keine Anforderungen („no requirements are placed“) | Darum reicht die RFC nicht als Prüfregel; die Prüfung (4) ist unsere eigene. |
| §5 „Any time one principal is delegated the rights of another principal, the potential for abuse is a concern.“; „scope“ wird zur Begrenzung empfohlen | **Ja:** `scope` im Auftrag, kleiner-gleich (Stufe 4/5). |

Kein Token-Exchange-Fluss: der wurde mit dem Kanidm-Konto des Bots gestrichen (ADR 0091 Z. 171, 178). Kanidm bleibt Anmeldedienst der **Person** (ihre Sitzung legt den Auftrag an); Bot-Schlüssel stellt das Programm aus. Ob Kanidm selbst `act`/`may_act` ausgibt, ist hier nicht geprüft und wird nicht gebraucht.

**(6) Pflichttests (je ohne Umsetzung rot; Mutant in Klammern muss rot werden)**
- Auftrag mit fremdem Ersteller (`on_behalf_of` ≠ `created_by`) → `order-mismatch` (Mutant „Ersteller-Prüfung entfernt“).
- „Auftrag erteilen“ mit Bot-Schlüssel → abgelehnt (Mutant „Bot-Schlüssel als Sitzung akzeptiert“).
- „Auftrag erteilen“ mit mitgeschicktem Ersteller-Feld ≠ Sitzung → Ersteller = Sitzung (Mutant „Ersteller aus Anfrage“).
- „Auftrag erteilen“ erscheint in der MCP-Werkzeugliste → Fehler.
- Auftrag widerrufen: nächste Aktion `order-revoked`; Bot-Platz, Mandat `Active`, Schlüssel und Zustimmungen bestehen; **kein** Entfernen, **keine** Pause, keine neue Zustimmungsrunde (Mutant „Widerruf löst Entfernen oder Pause aus“).
- Entfernen → Mandat `Stopped`, Schlüssel widerrufen, Bot draußen, alle Aufträge des Platzes enden (Mutant „Entfernen wirkt nur wie ein Widerruf“); vollständig PT-39 bis PT-41.
- Neuer Auftrag nach Widerruf → KI handelt wieder, ohne Zustimmungsrunde.
- Abgelaufener Auftrag → `order-expired`, kein Entfernen.
- Aktion außerhalb `scope` → `order-scope` (Mutant „Umfang ignoriert“).
- Recht der Person nach Erteilung entzogen → `on-behalf-exceeds` (Mutant „Rechte bei Erteilung eingefroren“).
- Gleiche Aufruf-Id zweimal → `order-replay` (Mutant „Aufruf-Id nicht geprüft“).
- Auftrags-Id eines anderen Platzes → `order-unknown`.
- fs-access nicht erreichbar → Ablehnung (Mutant „bei Ausfall erlauben“).
- Ereignis `widerrufen` nachträglich änderbar/löschbar → Fehler (Mutant „Ereignis-Update erlaubt“).
- Protokoll vor der Aktion fehlt → keine Aktion (bestehend, Nachtrag (3)).
- Pause, Not-Aus-Regel, Fristen, Rechte, Wiederaufnahme, Entfernen, Auftrag widerrufen, Protokoll: Pflichttests PT-01 bis PT-62 mit den Pflicht-Mutanten M-01 bis M-45 in (2a) bis (2f). Jeder Pflichttest ist ohne Umsetzung rot; jeder benannte Mutant muss rot werden.

**Offen**
1. ~~Namen der Knöpfe~~ **entschieden** (Nutzerentscheid 25): „Pause“ und „Entfernen“; „Auftrag widerrufen“ für den Ersteller. Der Altext mit „STOP KI“ (Z. 140, 149, 160) bleibt als Zitat stehen.
2. ~~Wer darf was~~ **entschieden** (Nutzerentscheid 25 und Nutzer, Frage 33): Pause und Entfernen jede Person jederzeit; Auftrag widerrufen nur der Ersteller; fortsetzen wer pausiert hat, Admins, Inhaber und wer das Recht dafür hat ((2c)).
3. **Weitermachen:** Kann ein widerrufener Auftrag fortgesetzt werden, oder ist „der nächste Befehl“ immer ein neuer Auftrag? Vorschlag: immer neu (append-only, einfachere Prüfung). Ebenso: Einmal-Auftrag oder Dauer-Auftrag, Höchstzahl der Aktionen.
4. **Trailer für die Auftrags-Id** (`FS-Order:`) in Commit/Tag: ja/nein. Würde die Id außerhalb der Instanz sichtbar machen.
5. **Signatur des Auftrags** (z. B. bei Aufträgen, die ein anderes Programm prüfen soll): in dieser Fassung keine; nötig erst, wenn ein Auftrag Programmgrenzen überschreitet. Heute gilt ein Auftrag nur im Programm der Situation (wie der Bot-Schlüssel, ADR 0091 Z. 172).
6. **Mehrere Aufträge gleichzeitig:** der Widerruf gilt je Auftrag; ob es zusätzlich „alle meine Aufträge widerrufen“ gibt.
7. **Auftraggeber außer dem Halter:** heute nur der Halter (ADR 0091 Nachtrag (2) Punkt 1); ob andere Anwesende Aufträge geben dürfen.
8. **Einzelplatz:** dort gibt es keinen Bot (ADR 0091 Z. 71); ob Aufträge über den MCP-Schalter genauso geführt werden, ist nicht festgelegt.
9. ~~Lesen nach „Auftrag widerrufen“~~ **entschieden** (Entscheid c0 nach Nutzerregeln, 18.11.): für diesen Auftrag liest die KI nichts mehr ((2e) d).
10. Fehlercodes `order-*`, `seat-unavailable`, `out-of-range` und ihre Abbildung auf HTTP, Cap'n Proto und JSON-RPC (MCP) sind Vorschläge (Namen nicht belegt).
11. ~~Mehrere Pausen am selben Platz~~ **entschieden** (Entscheid c0 nach Nutzerregeln, 18.11.): ein Zustand des Platzes; eine berechtigte Wiederaufnahme hebt ihn auf; das Protokoll zeigt alle Pausen ((2c)).
12. ~~Pausenfenster~~ **entschieden** (Entscheid c0 nach Nutzerregeln, 18.11. (Opus-Empfehlung angenommen)): fällige Läufe werden ausgelassen, nicht nachgeholt; `valid_until` läuft weiter; der Ersteller wird nach der Wiederaufnahme benachrichtigt ((2a) Z9, (2e)).
13. ~~Anzeige der Not-Aus-Regel~~ **entschieden** (Entscheid c0 nach Nutzerregeln, 18.11. (Opus-Empfehlung angenommen)): Hinweis „wirkt hier als Entfernen“ am Knopf, eine Rückfrage ((2b)).
14. ~~Was die Menschen sehen~~ **entschieden** (Entscheid c0 nach Nutzerregeln, 18.11.): sichtbar, wer pausiert hat ((2f)). Der zweite Teil (Mitgliederliste bei der Wiederaufnahme) ist nicht mitentschieden und steht als Offen 20.
15. ~~Schlüssel nach der Wiederaufnahme~~ **entschieden** (Entscheid c0 nach Nutzerregeln, 18.11. (Opus-Empfehlung angenommen)): neuer Schlüssel, der gesperrte wird widerrufen ((2a) Z8, PT-14).
16. ~~„Ruht“~~ **entschieden** (Entscheid c0 nach Nutzerregeln, 18.11. (Opus-Empfehlung angenommen)): „ruht“ (ADR 0091 Z. 57 Halter-Verlust, Z. 78 Ratenbegrenzung) benutzt dieselbe Sperre G1–G8 wie Pause; jeder Zustand außer `Active` wird abgelehnt (G7). Auslöser und Ende von „ruht“ bleiben wie in ADR 0091.
17. ~~Wiederaufnahme, Einzelheiten~~ **entschieden** (Entscheid c0 nach Nutzerregeln, 18.11.): alle drei Admin-Stufen nach ADR 0095; Recht `ai.resume`. Zur Form „gesperrte Instanz-Einstellung“ siehe Offen 21.
18. ~~Grenzen der Fristen D und L~~ **entschieden** (Entscheid c0 nach Nutzerregeln, 18.11. (Opus-Empfehlung angenommen)): Voreinstellung D 1 s, L 5 s; Grenzen D 0,2–10 s, L 1–60 s; gesperrte Instanz-Einstellungen ((2b)).
19. ~~Einzelplatz~~ **entschieden** (Entscheid c0 nach Nutzerregeln, 18.11. (Opus-Empfehlung angenommen)): auch ohne Bot gibt es Pause; sie sperrt die KI am MCP-Baustein des Programms mit derselben Sperre G1–G8 und demselben Nachweis (PT-24 bis PT-30 für den MCP-Baustein); fortsetzen darf die einzige Person (Eigentümerin der impliziten Gruppe „Instanz“, ADR 0095 Z. 13).
20. **Mitgliederliste bei der Wiederaufnahme:** die KI bekommt den aktuellen Stand wie bei einem Eintritt und sieht damit, wer jetzt da ist; ob das zu viel über die Pause verrät (wer kam oder ging), ist nicht entschieden.
21. **`ai.resume` und „gesperrte Instanz-Einstellung“:** c0 nennt `ai.resume` „angelegt als gesperrte Instanz-Einstellung“ (mit Verweis auf Review A7). A7 betrifft die Fristen D und L; `ai.resume` ist ein Recht in fs-access (wie `can_lock`, ADR 0100 Z. 37–38). Umgesetzt: D und L gesperrt, `ai.resume` als Recht. Ob c0 zusätzlich eine gesperrte Instanz-Einstellung zu `ai.resume` meint (z. B. wer es vergeben darf), ist offen.
22. **Pause im Einzelplatz und spätere Gruppe:** wird aus dem Einzelplatz durch „Teilen einrichten“ (ADR 0090) eine Situation mit Bot-Platz, ob eine dann bestehende Pause übergeht. Vorschlag: nein, der Bot-Platz beginnt nach seiner Zustimmungsrunde `Active` (wie PT-51).
