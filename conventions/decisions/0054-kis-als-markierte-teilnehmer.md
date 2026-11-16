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
