# Feature-Abgleich: PROGRAMM messages (fs-messages)

Stand 2026-11-16, Grundfassung messages (Workflow grundfassung, von Hand). Feature-Freeze: offen (Nutzer). Nur Deutsch: todo/ wird nicht übersetzt (ADR 0011).

Stand: 2026-11-16 · Nutzerregel: „Erst testen, dann Ideen sammeln, dann die Features anderer Programme ansehen und ebenso umsetzen, BEVOR es einen Feature-Freeze gibt.“
Vorbilder: Element (Matrix), Signal, Telegram, Mattermost, Zulip, Discord, Thunderbird, Outlook, Apple Mail, Kontact, Delta Chat, HEY, Superhuman, Spark, Fastmail, Mastodon (Dossiers unter docs/*/programs/apps/messages/frontends/; Mattermost nur als Konzeptquelle, kein Dossier).
Zustand bei uns: fs-messages v0.0.2 (README „What it can do today“), DESIGN.md, docs/en/programs/apps/messages/requirements.md (Fähigkeiten, Kennungen `<Objekt>.<Aktion>`), Vertrag `messenger.capnp` Entwurf 0.3 (fs-interfaces v0.0.27), Grundfassung 0.0.3 (Fenster, Server mit `capabilities`/`supportReport`, Client, Starter).
Legende: `[x]` gebaut (Kern: `fs-messages-core`/`-guard`/`-mail`/`-matrix`, auch wenn das Fenster es noch nicht zeigt) · `[ ]` geplant oder fehlt · Priorität: hoch = Pflicht/Kern; mittel = verbreitet, klarer Nutzen; niedrig = Nische · Stufe: heute = im Kern gebaut; als Nächstes = nächste Schritte, Fenster/Vertrag zuerst; später = vorgesehen, nicht terminiert (kein Versprechen). Prioritäten und Stufen sind Vorschläge der Recherche, nicht beschlossen.
Format je Zeile: Feature — Vorbilder — Stand bei uns — Priorität — Nutzen — Stufe.

## Konten und Anschlüsse

- [x] Mehrere Konten in einem Programm (Mail, Matrix) — Kontact, Outlook, Thunderbird, Telegram — Kern: `Accounts`, Anbieter je Konto — hoch — Alles an einem Ort — Stufe: heute (Kern), Fenster als Nächstes.
- [x] Mail holen/senden (IMAP, JMAP, SMTP, JMAP-Submission) — Thunderbird, Kontact, Fastmail — `fs-messages-mail`, nur gegen lokalen Stalwart getestet — hoch — Mail lesen und schreiben — Stufe: heute (Kern).
- [x] Matrix-Konto (Anmeldung mit Passwort, Sitzung, Ende-zu-Ende, Räume = Unterhaltungen) — Element — `fs-messages-matrix`, nur gegen tuwunel getestet — hoch — Chat nach Standard — Stufe: heute (Kern).
- [ ] Konto-Einrichtung im Fenster (Assistent, Fehlermeldungen in Klartext) — Thunderbird, Element — fehlt — hoch — Ohne Kommandozeile starten — Stufe: als Nächstes.
- [ ] Zugangsdaten sicher speichern (Schlüsselbund) — alle — fehlt, wartet auf den Schlüsselverwahrer — hoch — Passwörter nie im Klartext — Stufe: als Nächstes.
- [ ] Absender-Aliase je Konto, maskierte Adressen — Apple Mail (Aliase), Fastmail (Masked Email) — fehlt — niedrig — Privatsphäre — Stufe: später.
- [ ] Weitere Anbieter (MIMI, Nostr, Brücken zu Telegram/Discord/WhatsApp, installierbar, als „nicht Ende-zu-Ende“ gekennzeichnet) — Element (Brücken), Delta Chat — fehlt, `Provider` bereit — niedrig — Reichweite — Stufe: später.
- [ ] Chat über Relais ohne Profildaten (Delta-Chat-Art) — Delta Chat — fehlt — niedrig — Datensparsamkeit — Stufe: später.

## Unterhaltungen und Ordner

- [x] Unterhaltungen über alle Konten, neueste zuerst, Seiten ohne Springen bei neuer Post — alle — Kern: Cursor-Seiten — hoch — Übersicht — Stufe: heute (Kern).
- [x] Öffnen, flach (Chat) oder als Baum (Mail) lesen — Element, Thunderbird — Kern: `context`, `inReplyTo` — hoch — Lesen — Stufe: heute (Kern); Ansicht als Nächstes.
- [x] Ungelesen-Marken, „gelesen bis hier“, nächste ungelesene — Telegram, Element, Mail-Programme — Kern — hoch — Nichts übersehen — Stufe: heute (Kern).
- [x] Anheften, in Ordner verschieben — Element, Thunderbird, Outlook — Kern, nur lokal (kein Anbieter erfährt es) — mittel — Ordnung — Stufe: heute (Kern).
- [ ] Ordner/Kategorien/Farb-Etiketten anlegen und verwalten — Thunderbird, Outlook, Discord — Kern kennt Ordnernamen, Verwalten fehlt — mittel — Ordnung — Stufe: als Nächstes.
- [ ] Benachrichtigung je Unterhaltung (alle, nur Erwähnungen, stumm) — Discord, Element, Telegram — fehlt — hoch — Ruhe — Stufe: als Nächstes.
- [ ] Stummschalten/Ignorieren, Zurückstellen bis zu einer Zeit — Outlook, Apple Mail — fehlt — mittel — Ruhe — Stufe: später.
- [ ] Gespeicherte Ansichten (Suchordner), aufgeteilter Posteingang, automatische Kategorien lokal — Outlook, Apple Mail, Superhuman, HEY — fehlt — niedrig — Ordnung — Stufe: später.
- [ ] Sortieren/Gruppieren (Datum, Absender, Betreff, Unterhaltung) — Thunderbird, Telegram — fehlt — mittel — Übersicht — Stufe: später.
- [ ] Neue-Absender-Prüfung (Screener), Stapel „später“, „Antworten später“ — HEY — fehlt — niedrig — Ruhe im Postfach — Stufe: später.

## Schreiben und Senden

- [x] Antworten, Weiterleiten, Entwürfe (automatisch gesichert), Suche, Markieren, Verschieben — alle — Kern — hoch — Grundfunktionen — Stufe: heute (Kern); Fenster als Nächstes.
- [x] Nur verschlüsselt senden, klare Ablehnung mit den Empfängern, die nicht erreichbar sind, kein Überschreiben — Element (Standard), Signal, Telegram (Geheimchat) — Kern, ADR 0018 — hoch — Verschlüsselung ohne Ausnahme — Stufe: heute (Kern).
- [ ] Verschlüsselung erklären: warum eine Nachricht nicht verschlüsselt ist und wie man das ändert — eigene Idee 9 — fehlt — hoch — Verständnis — Stufe: als Nächstes.
- [ ] Anhänge senden/ansehen/speichern, Vorschau von Bildern, Video, Dokumenten — Element, Telegram, Discord, Signal — Kern: Anhänge als Daten, Fenster fehlt — hoch — Dateien teilen — Stufe: als Nächstes.
- [ ] Text formatieren (fett, kursiv, Code, Zitat, Listen, Links) — Element, Mastodon (Markdown), Mail-Programme — fehlt — hoch — Lesbare Nachrichten — Stufe: als Nächstes.
- [ ] Bearbeiten einer gesendeten Nachricht, Löschen für alle (wo der Transport es kann) — Discord, Element, Telegram, Mastodon — Löschen „für mich“ gebaut, Bearbeiten antwortet „nicht möglich“ — mittel — Fehler korrigieren — Stufe: später.
- [ ] Zitieren eines Teils, Erwähnen einer Person (Benachrichtigung) — Discord, Element, Mastodon — fehlt — mittel — Bezug herstellen — Stufe: später.
- [ ] Reaktionen mit Emoji, Emoji-Auswahl, eigene Emoji — Discord, Element, Telegram, Signal — Datenfeld `Reaction` im Vertrag, Fenster fehlt — mittel — Schnelle Antwort — Stufe: später.
- [ ] Threads/Unterthemen, Themen je Nachricht (Zulip-Art), „zuletzt aktive Themen“ — Element, Discord, Zulip — Vertrag kennt `context`, Umsetzung fehlt — mittel — Große Gruppen lesbar halten — Stufe: später.
- [ ] Abgehen lassen: Zeitversand, Senden rückgängig (Wartezeit), Abkühl-Hinweis „jetzt oder in 10 Minuten“ — Outlook, Gmail-Art; eigene Idee 1 — Kern: `cooldown` vorhanden, Fenster fehlt — mittel — Weniger Reue — Stufe: später.
- [ ] Sprachnachrichten (mit Text auf dem Gerät), Linkvorschau vom Absender erzeugt — Telegram, Signal, Element — fehlt — niedrig — Bequemlichkeit — Stufe: später.
- [ ] Umfragen in der Unterhaltung — Element, Telegram (Bots), Zulip — fehlt, Programm surveys vorgesehen — mittel — Gemeinsam entscheiden — Stufe: später.
- [ ] Signaturen, Abwesenheitsnotiz, Priorität einer Nachricht — Thunderbird, Outlook — fehlt — niedrig — Mail-Alltag — Stufe: später.
- [ ] GIFs/Sticker aus Git-Paketen statt Tracking-Diensten — Discord, Signal (Sticker) — fehlt, ADR 0036 — niedrig — Spaß ohne Spuren — Stufe: später.
- [ ] Nachricht in eine Aufgabe, einen Termin oder eine Textseite verwandeln — eigene Idee 5 — fehlt — mittel — Weiterarbeiten — Stufe: später.
- [ ] Verschwindende Nachrichten mit Zeitgeber — Signal, Telegram — fehlt — niedrig — Datensparsamkeit — Stufe: später.
- [ ] Kalendereinladungen in der Nachricht beantworten — Thunderbird, Outlook, Kontact — fehlt, über das Kalender-Programm — mittel — Termine ohne Umweg — Stufe: später.

## Suche, Regeln, Ablage

- [x] Volltextsuche über Konten — alle — Kern — hoch — Wiederfinden — Stufe: heute (Kern); Fenster als Nächstes.
- [ ] Filter/Regeln (Sieve bei Mail, gleiches Modell für Chat) — Thunderbird, Outlook, Kontact — fehlt — mittel — Automatisch ordnen — Stufe: später.
- [ ] Spam/Junk mit Lernen — Thunderbird, Outlook — fehlt, nötig sobald wir einen eigenen Mailserver haben — mittel — Weniger Müll — Stufe: später.
- [ ] Original behalten, EML/mbox importieren und exportieren, jede Unterhaltung offen exportieren — Thunderbird, eigene Idee 10 — Original byte-genau gebaut, Export fehlt — mittel — Daten mitnehmen — Stufe: als Nächstes.
- [ ] Offline arbeiten, auf allen Geräten gleich (Sync), wählen was wie lange gehalten wird — Thunderbird, Outlook, Telegram — Nachrichten bleiben bewusst auf dem Gerät, bis der Schlüsselverwahrer da ist — hoch — Geräte wechseln — Stufe: später.
- [ ] Drucken einer Nachricht, Lesezeichen/Ablage über Unterhaltungen — Outlook, Thunderbird, Mastodon — fehlt — niedrig — Ablage — Stufe: später.
- [ ] Fremde Inhalte (Bilder, Tracker) nur auf Wunsch laden; Datenschutz-Proxy — Thunderbird, Apple Mail — Regel fest, Proxy fehlt — hoch — Datenschutz — Stufe: als Nächstes (Regel), später (Proxy).

## Gruppen, Rollen, Moderation

- [ ] Gruppen anlegen, benennen, einladen, verlassen — Discord, Element, Telegram, Signal — fehlt — hoch — Gemeinsam sprechen — Stufe: als Nächstes.
- [ ] Rollen und Rechte in einer Gruppe — Discord, Element, Telegram, Mastodon — fehlt — mittel — Ordnung in Gruppen — Stufe: später.
- [ ] Entfernen, sperren, melden, Langsam-Modus, Abstimmungs-Moderation, offenes Moderationsprotokoll — Discord, Element, Mastodon; eigene Idee 11 — fehlt — mittel — Schutz in Gruppen — Stufe: später.
- [ ] Moderator und geschützter Raum für Gespräche, die einen brauchen (nur Kontext, Eltern-Richtung) — eigene Richtung — nur benannt, nichts gebaut — mittel — Schutz — Stufe: später (kein Versprechen).
- [ ] Gemeinsamer Posteingang, gemeinsamer Entwurf, private Kommentare im Team — Spark, Superhuman, Zammad/Chatwoot — fehlt — niedrig — Teamarbeit — Stufe: später (eigene Programmteile, vermutlich Facette/Suite).

## Verschlüsselung, Schlüssel, Vertrauen

- [x] Verschlüsselungszustand an jeder Nachricht, nie „sicher“ ohne Beleg — Element, Telegram — Kern — hoch — Ehrlichkeit — Stufe: heute (Kern).
- [ ] Signaturen, Schlüssel und Geräte prüfen, Fingerabdrücke vergleichen — Thunderbird, Element, Signal, Delta Chat — fehlt (`signature` im Modell, `notVerified`) — hoch — Echtheit — Stufe: als Nächstes.
- [ ] Schlüssel finden und Gegenstelle auffinden (Autocrypt, Schlüsselbestätigung beim Treffen; kein Web of Trust, ADR 0102 Entscheid 46) — Thunderbird, Delta Chat — teilweise im Mail-Anschluss — mittel — Verschlüsseln ohne Mühe — Stufe: später.
- [ ] Hinweis bei Empfängern außerhalb des vertrauten Kreises — Apple Mail — fehlt — niedrig — Fehlversand vermeiden — Stufe: später.

## Menschen und Kontakte

- [ ] Empfänger aus dem Adressbuch wählen, Karte des Absenders öffnen (lebende Verweise auf fs-people) — alle Mail-Programme — fehlt, Verweis laut ADR 0020 — hoch — Richtige Person — Stufe: als Nächstes.
- [ ] Eigenes Profil (Name, Bild, Text) — Discord, Element, Mastodon, Telegram — fehlt, aus fs-people — mittel — Wiedererkennen — Stufe: später.
- [ ] Anwesenheit (online, abwesend, beschäftigt), nur freiwillig — Discord, Element, Telegram — fehlt — niedrig — Erreichbarkeit — Stufe: später.
- [ ] Lesebestätigungen nur beidseitig; „zustellen, wenn die Person wach ist“ — eigene Ideen 2 und 4 — fehlt — mittel — Respekt — Stufe: später.

## KI als Teilnehmer

- [x] KI-Wächter: Einladung je KI, Freigabe je KI und Art der Handlung, Rückfragen bei riskanten Schritten, Geheimnisse nie an eine KI, Notaus — eigene Regel ADR 0054/0056/0091 — `fs-messages-guard` — hoch — Kontrolle — Stufe: heute (Kern).
- [ ] KI nur mit der Zustimmung aller in der Unterhaltung; wer später kommt, stimmt zu oder bleibt draußen; STOP-KI überall — eigene Regel — Regel noch nicht gebaut — hoch — Selbstbestimmung — Stufe: als Nächstes.
- [ ] Anzeige, was eine KI tun will oder getan hat, Entscheidung nur auf dem Gerät der Person, Antwort beim Entstehen zeigen, Verbrauch zeigen — eigene Regel — Vertrag kennt `toolcall.*`, `turn.stop`, `text.stream` — mittel — Nachvollziehbarkeit — Stufe: später.
- [ ] Zusammenfassen und Übersetzen auf dem Gerät, nur wenn alle zugestimmt haben — Outlook, eigene Ideen 14, 15 — fehlt — niedrig — Lesen erleichtern — Stufe: später.

## Anrufe und andere Wege

- [ ] Sprach- und Videoanrufe, Bildschirm teilen — Discord, Element, Signal, Telegram — offen, ob im Programm — mittel — Sprechen — Stufe: später (Frage offen).
- [ ] Ohne Netz: Bluetooth/lokales WLAN für Treffen und Notfälle — eigene Idee 8, ADR 0059 — fehlt — niedrig — Notfall — Stufe: später.
- [ ] Ankündigungskanal, einer an viele; öffentlichen Zeitleisten folgen; teilen/weiterverbreiten (Mastodon) — Telegram (Kanäle), Mastodon — fehlt, Anbieter offen (Nostr) — niedrig — Reichweite — Stufe: später.
- [ ] Kleine Programme im Chat ohne Internet (webxdc) — Delta Chat — fehlt — niedrig — Spiele, Listen — Stufe: später.
- [ ] Bots und Automatisierung über den eigenen Vertrag (kein eigenes Bot-Schnittstellenformat) — Discord, Telegram, Element — Vertrag vorhanden, Bot-Platz ADR 0091 — mittel — Erweiterbar — Stufe: später.

## Bewusst nicht

Unverschlüsselt senden, Verschlüsselung als Sondermodus, kostenpflichtige Stufen, Werbung, Tracking-Pixel/Fernladen als Voreinstellung, Klartext in einer Anbieter-Wolke, Brücken als „Ende-zu-Ende“ gezeigt, GIF-Suchdienste mit Tracking, eigene Anmeldung/2FA (Kanidm), Kalender/Kontakte/Aufgaben im Messenger eingebaut, Newsgroups, XMPP, IRC (Begründung: `docs/en/programs/apps/messages/requirements.md`, „Not planned“).

## Ablage

Quellen: requirements.md (Pflicht, optional, angenommene Ideen 2026-11-08), Dossiers der Vorbilder, `DESIGN.md` und README des Programms. Fachbegriffe der Vorbilder sind Konzepte, Quellcode wurde nicht übernommen (ADR 0013).
