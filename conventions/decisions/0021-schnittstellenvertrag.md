# 0021 – Schnittstelle: ein Vertrag, viele Zugänge

Status: akzeptiert (2026-11-05) · Protokoll §9, §21.5

## Entscheidung
- **Daten:** Standards sind die Quelle der Wahrheit (ADR 0014).
- **Schnittstelle:** das schnellste Transportformat ist die Quelle der Wahrheit — **Cap'n Proto**
  (Schema mit eingebauten Regeln, wie man erweitert, ohne zu brechen). JSON-API, CLI und
  MCP-Tools werden **daraus erzeugt**, nicht von Hand parallel gepflegt.
- Programm ↔ Frontend wie Backend ↔ Frontend im Web, nur lokal (Unix-Socket / Named Pipe);
  entfernt über JSON/HTTPS.
- Für alles andere: **Voreinstellungen und Empfehlungen**, damit Menschen es einfach haben.
- Ein **Frontend ist ein Paket** mit Manifest (benötigte Fähigkeiten, Vertragsversion);
  installieren → es ist da. Das Programm bietet Fähigkeiten an; das Frontend nutzt sie oder nicht
  (Mails nur anzeigen und wegwischen ↔ voller Outlook-Nachbau mit Matrix und Telegram).

## Erweiterung für MCP (Nutzer, 2026-11-07)
- **Risikomarken im Vertrag,** je Methode und Union-Mitglied, gesetzt von der Engine und nie vom Aufrufer.
- **Ereignisse und Dateien** werden MCP-Ressourcen, keine Werkzeuge.
- **Geheimnisse sind von der Erzeugung ausgeschlossen:** Für sie entsteht kein Werkzeug und keine Ressource.
- **Lesen ist nicht harmlos,** siehe ADR 0054, Abschnitt „Lesen ist nicht harmlos“. Der MCP-Hinweis `readOnlyHint` sagt nichts darüber, ob etwas gefahrlos ist.

## Folgen
- Fähigkeitenliste (Protokoll §9) wird aus dem Schema erzeugt und ist über API/CLI/MCP abfragbar.

## Nachtrag 2026-11-17 (Baukasten, Gespräch 2): Cap'n Proto auch von außen, gRPC als Modul, nur TLS

Status: **akzeptiert** (Nutzerentscheidungen Gespräch 2 vom 2026-11-17, Antworten 1 und 10) · **ergänzt** Z. 11 („entfernt über JSON/HTTPS.“): entfernt außerdem Cap'n Proto über TLS · gilt mit ADR 0097 (Außen-Schnittstelle `fs-connect`)

**Entscheidung**
1. **Außen HTTPS + JSON** bleibt der allgemeine Weg (aus dem Vertrag erzeugt, Beschreibung OpenAPI 3.1).
2. **Cap'n Proto auch von außen:** „ja - wobei auch von außen, wir veröffentlichen die Schnittstelle - also können sie ebenso capnproto nutzen.“ (Antwort 1). **Veröffentlicht** heißt: die Schemas sind als Paket und Doku öffentlich, und der Cap'n-Proto-Endpunkt ist über TLS von außen erreichbar.
3. **gRPC nur als Modul** (Anbieter-Modul hinter fs-connect), aus dem Vertrag erzeugt, nie zweite Quelle.
4. **Nur TLS** nach außen (Version 1.3, RFC 8446), kein Klartext; **Ausnahmen nur begründet** und sichtbar markiert: „ja - mit ausnahmen (z.B. Telegram), die aber begründet.“ (Antwort 10).
5. **Modul-Kommunikation nach Nähe** (Vorschlag des Nutzers mit Rückfrage, von der Strategie bestätigt): „die Sachen, die "Nah" an dem Modul sind, sind alle WebAssably, die, die ohne das Programm auskommen, sind capnproto - die, die ganz weit weg sind, sind capnproto, json, grpc - das klingt doch nach einem Plan, oder?“; Einzelheiten ADR 0097 Nachtrag.

**Pflichttests:** Außen-Aufruf ohne TLS → abgelehnt außer markierter, begründeter Ausnahme; veröffentlichte Schemas stimmen mit dem Vertrag überein.
