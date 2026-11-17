# Feature-Liste fs-broadcast (Workflow feature-liste, Sonnet, 2026-11-17)

Entwurf, nicht gepusht. ADR 0013: nur Konzepte, nichts kopiert. Dossier vorhanden (fs-documentation docs/de/programs/apps/broadcast/frontends/{obs-studio,restreamer,restream,ant-media-server,mediamtx,mistserver,nginx-rtmp-module,ffmpeg,gstreamer,wowza}/latest/{features,menus,layout,shortcuts,api}.md, alle 10 gelesen bzw. die UI-relevanten 5 im Wortlaut); dort fehlen die Pflichtabschnitte im neuen Format (Menübaum (vollständig), Kontextmenüs, Werkzeugleiste, Tastenkürzel): hier aus vorhandenen Abschnitten "Menüpunkte"/"Shortcuts" übernommen, Lücken "[nicht belegt]". Ergänzt um Owncast und PeerTube Live (Zuschauerseite, offizielle Doku). Name: ADR 0087 streaming -> broadcast (Repo fs-streaming, Kopf a5ab369; Capability `streaming`, `streaming.capnp` bleiben). Anrufe = eigenes Programm (ADR 0037).

## 0. Stand heute (ehrlich)
- Kern (94 Tests mit echten Sockets, ffmpeg/ffprobe nur als Testwerkzeug): EIN RTMP-Strom empfangen, unverändert an viele RTMP/RTMPS-Ziele weiterleiten, als FLV in Ordner aufzeichnen, Ziel vor Live-Gang prüfen (soweit im Voraus erkennbar). Schlüssel nur einmal angezeigt, nur Hash gespeichert, nie in Logs/Fehlern. Langsames/totes Ziel bremst niemanden; bei Senderausfall bleiben Ziele eine Weile verbunden. Nur Loopback getestet, nie gegen echte Plattform.
- Version widersprüchlich: README Tag v0.0.1, Doku-Seite v0.2.0 / "Stufe 1 v0.0.1".
- Nicht da: Fenster, Server, Aufnahme an fs-files übergeben, alles übrige im Vertrag meldet "nicht möglich"; Empfang ist einfaches RTMP (standardmäßig nur Loopback); Weiterleitungsschleife über andere Maschine nicht erkennbar; Codecs/Kodierung (Design: ausgelagerte Anbieter, offene zuerst: AV1/rav1e, Opus), Nicht-live-Veröffentlichen, einfache Aufnahme (Szenen) = "schwer".
- "heute" im Fenster-Sinn: nichts bedienbar. "Kern" = im Programm, Fenster fehlt.

## 1. Vorbilder und Quellen
| Kürzel | Vorbild | Quelle / Lesestand |
|---|---|---|
| OB | OBS Studio (GPL) | Dossier .../obs-studio/latest/*.md (Menüs, Docks, Hotkeys belegt) |
| RR | Restreamer (Datarhei) | Dossier .../restreamer/latest/*.md (Web-UI-Bereiche belegt) |
| RS | Restream (restream.io, SaaS) | Dossier .../restream/latest/*.md |
| AM | Ant Media Server (Web-Panel) | Dossier .../ant-media-server/latest/*.md |
| MM | MediaMTX (kein UI; HTTP-API/YAML) | Dossier .../mediamtx/latest/*.md |
| OC | Owncast (Zuschauerseite + Admin) | https://owncast.online/docs/ (gelesen: nur Überblick) |
| PT | PeerTube Live | https://docs.joinpeertube.org/use/create-upload-video (gelesen, Abschnitt Live) |
Im Dossier außerdem (für Listenzwecke nicht einzeln gelesen): MistServer, nginx-rtmp-module, FFmpeg, GStreamer, Wowza (Manager, REST, DRM). Nicht belegt: Jitsi-Livestream, BigBlueButton (nicht gelesen; Anruf-Programm, ADR 0037). Eigene Dossiers: docs/de/programs/apps/broadcast/{index,design,requirements}.md, research/streaming-landscape.md.

## 2. Ansichten und Abläufe je Vorbild (nur Belegtes)
- OB: Hauptfenster: Docks Szenen | Vorschau | Quellen | Audio-Mischer | Übergänge | Steuerungen (Start Streaming, Aufnahme, Studio-Modus, Rekorde, Einstellungen); Statusleiste FPS/Verluste/CPU/Bandbreite; rote Umrandung = Ausgang, grün = Studio-Vorschau; Szenen mit Ordnern, Übergänge (Schnitt, Wischen, Fade); Quellen (Fenster, Bildschirm, Browser, Bild, Video, Text, Farbe, Folie, Kamera, Audio); Filter je Quelle/Szene; Mischer mit Rauschunterdrückung/Kompressor/Limiter, Mehrspur; Ausgabe RTMP(S)/SRT/RIST, Aufnahme MKV/MP4/MOV, Encoder x264/NVENC/AMF/QuickSync/VideoToolbox; Studio-Modus; Replay-Puffer; virtuelle Kamera; obs-websocket; Skripte Python/Lua. Drag&Drop, Ränder ziehen zum Transformieren. Nicht: Schnitt, Chat-Dashboard, Mehrpersonensteuerung.
- RR: Linkes Menü: Start/Dashboard (laufende Streams, Vorschau, Statistik), Push Key (neu erzeugen), Player (HLS, Einbettungscode, Direktlinks), Settings (Ports, Passwort, Speicherort), Advanced (nginx-rtmp, Transcoding, WebRTC, Aufzeichnungsintervall), Multi-Target (Name+URL, aktivieren/deaktivieren), Logs/Diagnose (Support-Paket). Hooks on_publish/on_publish_done/on_record_done. Rollen: anonym (Player), Webui-Benutzer, Admin.
- RS: Seitliches Dashboard: Live (Go Live, Ingest-URL/Key, Ziele mit Status), Studio (Browser-Produktion, Szenen, Gäste per Link), Channels/Destinations (30+ Plattformen per Login, eigene RTMP-Ziele), Events (Zeitplan, Countdown, Aufnahme danach, Erinnerungen), Chat (alle Plattformen vereint, Moderation), Analytics (Zuschauer, Watch-Time je Plattform/Event), Video (Bibliothek, Einbettung), Settings (Account, Branding, Sicherheit/Key zurücksetzen, Billing, API). Zielanzahl planabhängig.
- AM: Web-Panel (Port 5080/5443): Apps, Live Streaming (Stream anlegen: Live/IP-Kamera/Quelle/Liste; Liste mit Status, Zuschauer, Bitrate; URLs kopieren; Test-Player; Aufnahme), VoD, Dashboard (CPU/RAM/Netz), Settings (General, Advanced, Security Token/JWT/IP-Filter, Restreaming-Ziele, Cluster, SSL).
- MM: Kein UI; Pfade/Verbindungen per HTTP-API, YAML; Protokolle RTSP/RTMP/SRT/WebRTC/HLS. Ableitung: Vorbild für Kern, nicht für Fenster.
- OC: Chat im Web, Admin unter /admin, Stream-Schlüssel, Eintrag im Verzeichnis, Plugins/Webhooks, Qualitätseinstellungen. Followers/ActivityPub, Clips, Benachrichtigungen, Einbettung: im Abruf nicht belegt.
- PT: Veröffentlichen > "Live starten" > Kanal + Datenschutz + Live-Art > "Live starten"; Reiter "Live-Einstellungen" mit RTMP-URL und privatem Schlüssel (Warnung: jeder mit Schlüssel kann senden); normales Live (Wiederholung ersetzt Live) oder dauerhaftes Live (jede Wiederholung = eigenes Video).

## 3. VOLLSTÄNDIGE Feature-Liste
Stufen: heute (Fenster nutzbar) | als Nächstes | später. "Kern" = im Programm. Vorbilder: OB RR RS AM MM OC PT.
| # | Funktion | Stufe | Vorbilder |
|---|---|---|---|
| 1 | Fenster Dashboard: Eingang (Adresse + einmal angezeigter Schlüssel), Ziele mit Status (live/Fehler/getrennt) | als Nächstes (Kern: Weiterleitung) | RR RS AM |
| 2 | Ziel hinzufügen (Name, RTMP/RTMPS-URL, Schlüssel verdeckt), aktivieren/deaktivieren, entfernen | als Nächstes (Kern) | RR RS AM |
| 3 | Ziel vor Live-Gang prüfen, Ergebnis mit Grund anzeigen | als Nächstes (Kern) | RS (nicht belegt) |
| 4 | Eingangsschlüssel: einmal anzeigen, neu erzeugen, nur Hash gespeichert | als Nächstes (Kern) | RR RS PT |
| 5 | Aufnahme starten/stoppen (FLV, Ordner wählen: Dateiauswahl) | als Nächstes (Kern) | OB RR AM |
| 6 | Statusleiste: Bitrate, Dauer, verlorene Frames, Ziel-Zustände | als Nächstes | OB AM |
| 7 | Ziel fällt aus ohne die anderen zu stören: Anzeige "Ziel X getrennt, wiederverbinden" | als Nächstes (Kern) | (eigen) |
| 8 | Hinweis "nur Loopback / unverschlüsselter Empfang" sichtbar, Empfang nach außen freigeben mit Warnung | als Nächstes (Kern: Loopback Standard) | (Regel ehrlich) |
| 9 | Aufnahme an fs-files übergeben (Ordner = Videos) | später (nicht gebaut) | RR AM |
| 10 | Aufzeichnung in Segmente, Intervall, Aufbewahrung | später | RR AM |
| 11 | Wiedergabe-Seite/Player (HLS) mit Einbettungscode | später | RR RS AM OC PT |
| 12 | Zuschauerzahl, Verlauf, Watch-Time je Ziel | später | RS AM OC |
| 13 | Ziele per Login verbinden (YouTube, Twitch ...) statt Schlüssel einfügen | später (Plattform-APIs) | RS |
| 14 | Chat der Ziele vereint, moderieren | später (Plattform-APIs; fs-messages) | RS OC |
| 15 | Geplante Lives: Zeitplan, Countdown, Erinnerungen, Event-Seite (fs-calendars) | später | RS |
| 16 | Dauerhafter Kanal, Wiederholungen als eigene Videos / ersetzen | später | PT |
| 17 | Datenschutz je Live (öffentlich, nicht gelistet, privat) | später | PT |
| 18 | Zuschauer ohne Konto; Einladen über Links, Token-Schutz | später | AM PT RR |
| 19 | Einfache Aufnahme: Kamera/Bildschirm direkt, Ziele wählen, alles automatisch (Design) | später (L: Kodierung) | (eigen) vs OB |
| 20 | Szenen, Quellen, Übergänge, Filter, Mischer, Studio-Modus, Replay-Puffer | später, offen ob gewollt (OBS-Gebiet; Design: "weit einfacher als OBS") | OB RS |
| 21 | Gäste per Link in die Sendung (Interview) | später (Anrufe = eigenes Programm, ADR 0037) | RS |
| 22 | Transcoding/Mehrfach-Qualitäten (Adaptive Bitrate), Profile | später (Codec-Anbieter, Design) | AM RR |
| 23 | Weitere Eingänge/Ausgänge: SRT, RTSP, WebRTC/WHIP, HLS; Enhanced RTMP (AV1) | später | MM AM OB |
| 24 | Nicht live veröffentlichen (Upload zu Plattformen, API) | später | RS |
| 25 | Weiterleitungsschleife erkennen, Doppelziele warnen | später (Kern: nur lokal) | (eigen) |
| 26 | Hooks/Webhooks (Start, Ende, Aufnahme fertig); Aktivität an fs-activities | später | RR OC AM |
| 27 | Fernsteuerung/API (obs-websocket-Muster): Zielzustand, Start/Stop | später | OB MM AM RS |
| 28 | Rollen: Betreiber, Moderator, Zuschauer; mehrere Bediener | später | RS AM RR |
| 29 | Branding/Wasserzeichen, Overlays | später, offen ob gewollt | RS OB |
| 30 | Diagnose/Support-Paket, Logs ohne Schlüssel | später | RR AM |
| 31 | Verzeichnis/Auffindbarkeit (ActivityPub-Follow, Benachrichtigung "geht live") | später | OC PT |
| 32 | Kürzel: Live starten/beenden (Strg+Umschalt+S), Aufnahme (Strg+Umschalt+R) | als Nächstes | OB (nicht belegt, dort unbelegt) |
Hinweis: Nr. 3, 7, 8, 25 sind ehrliche Alleinstellungen der Weiterleitung; Nr. 19 ist Designziel (kein offenes Werkzeug erfüllt "einfach + plattformübergreifend + selbst gehostet").

## 4. Menübäume je Vorbild (nur Belegtes)
- OB: Menüleiste Datei | Ansicht | Bearbeiten | Einstellungen | Hilfe (Layout-Skizze Dossier). Datei: Szenensammlungs-Gruppe, Szenen kopieren, Einstellungen (Reiter: Allgemein, Video, Audio, Ausgabe, Aufnahmen, Stream, Erweitert, Hotkeys, Erweiterungen), Bildschirmaufnahme starten/stoppen, alle stoppen, Beenden. Ansicht: Docks ein/aus (Szenen, Quellen, Mischer, Steuerungen, Übergänge), Vollbild-Vorschau, Vollbild-Projektion, Fortgeschrittenes Audio, Skalierung, Auflösung sperren. Bearbeiten: Rückgängig/Wiederholen, Kopieren/Einfügen von Quellen, Eigenschaften-Zwischenablage. Rechtsmenüs (Drei-Punkt in Steuerungen): Rekorde, Untertitel, Studio-Modus, virtuelle Kamera, Tools (Enhancer, Shader, Skripting, Websocket). Kontextmenüs: Szene (umbenennen, duplizieren, Übergang setzen, Transform zurück), Quelle (umbenennen, sperren, Sichtbarkeit, transformieren, duplizieren, Filter, Eigenschaften, Skalierung), Gruppe (auflösen, bearbeiten). Tastenkürzel: alle in Einstellungen > Hotkeys vergeben, ab Werk meist unbelegt; Übergang ausführen = Return (Studio-Modus). Hilfe-Menü Inhalt: [nicht belegt].
- RR: linkes Menü wie Abschnitt 2 (7 Einträge); Kontextmenüs/Werkzeugleiste/Kürzel: [nicht belegt].
- RS: seitliche Navigation Live | Studio | Channels | Events | Chat | Analytics | Video | Settings; Kontextmenüs: Kanal (verbinden, trennen, umbenennen, Chat), Szene/Quelle (duplizieren, sperren, anordnen, entfernen), Event (bearbeiten, duplizieren, löschen, teilen). Kürzel: keine dokumentiert (Tab, Enter, Esc, Strg+Enter im Chat).
- AM: Menü Apps | Live Streaming | VoD | Dashboard | Settings (General/Advanced/Security/Restreaming/Cluster/SSL); Kontextmenüs: Stream-Kachel (Start, Stop, Löschen, URLs kopieren, Aufnahme, Statistiken), VoD-Eintrag, Application; Kürzel: Strg+F Filter; sonst keine dokumentiert.
- MM, OC, PT: kein eigenes Menümodell belegt (MM: nur API; OC: /admin-Seite; PT: Publish-Dialog mit Reitern Live starten | Live-Einstellungen).
Werkzeugleiste: OB "Steuerungen" (Start Streaming | Aufnahme | Studio-Modus | Rekorde | Einstellungen) ist belegt; sonst [nicht belegt].

### VORSCHLAG Menübaum fs-broadcast (eigenes Konzept; Entscheidung b7: Seitenleiste + Symbolleiste + Kontextmenüs, keine Menüleiste)
Seitenleiste: Sendung (Dashboard) | Ziele | Aufnahmen | Eingang | Protokoll (ohne Schlüssel) | Einstellungen.
Symbolleiste: Live starten/beenden (großer Knopf, Zustand idle/checking/live/ended/error) | Aufnahme ● | Ziel hinzufügen… | Prüfen | Suchfeld | Weitere ▾ (Schlüssel neu erzeugen, Diagnosepaket).
Kontextmenü Ziel: Aktivieren/Deaktivieren | Prüfen | Bearbeiten… | Schlüssel ersetzen… | Entfernen… (Frage). Kontextmenü Aufnahme: Öffnen in fs-files | Ordner zeigen | Löschen…. Kontextmenü Eingang: Adresse kopieren | Schlüssel neu erzeugen….
Kürzel (Vorschlag, nicht belegt; OBS lässt sie leer): Strg+Umschalt+S Live, Strg+Umschalt+R Aufnahme, Strg+N Ziel, Entf entfernen. Ausgegraut immer mit Grund (z. B. "Ziel nicht geprüft").

## 5. Die wichtigsten nächsten Funktionen
1. Dashboard-Fenster: Eingang, Ziele mit Zustand, Live-Knopf [M-L]: macht den geprüften Kern bedienbar; Vorbilder RR/RS/AM zeigen genau diese Seite.
2. Ziele verwalten (hinzufügen, aktivieren, prüfen, entfernen), Schlüssel verdeckt [M]: Kernversprechen "einmal zeigen, überall hin"; Kern vorhanden.
3. Eingangsschlüssel einmal anzeigen/neu erzeugen mit klarer Warnung [S]: Sicherheitsversprechen; Kern vorhanden.
4. Aufnahme starten/stoppen mit Ordner-Wahl [S-M]: Alltag; FLV im Kern.
5. Statusleiste (Bitrate, Dauer, Ziel-Zustände, Ausfall-Meldung) [M]: Vertrauen beim Senden; Vorbild OB/AM; braucht Statusabfrage im Kern.
6. Aufnahme an fs-files übergeben [M]: schließt Kreis zur Medien-Suite; im Kern "nicht gebaut".
7. Geplantes Live + Erinnerung (fs-calendars) [M-L]: Vorbild RS; nutzt vorhandene Programme.
8. Wiedergabe-Seite/Player mit Einbettung [L]: Zuschauerseite (RR/OC/PT); braucht Server und HLS.

## 6. Lücken in fs-components (Verweis PLAN-components-menue.md M1-M8)
M1 Befehlsmodell (Live-Knopf mit Zustand/Grund), M2 Kürzel (globale Fenster-Kürzel auch im Hintergrund?: Plan sagt nur Fenster/Fokus: Lücke), M3 Kontextmenü (Ziel/Aufnahme), M4 Tastatur, M7 Befehlsleiste. Zusätzlich fehlend: Statusleiste mit Echtzeit-Zahlen, Zustands-/Pegelanzeige (Meter), Passwortfeld "Schlüssel einmal zeigen" (verdecken/kopieren), Dateiauswahl (Ordner) nach Regel "überall wo ein Pfad nötig ist", Player-Widget (später).

## 7. Offene Fragen
1. Umfang des Fensters: nur "Weiterleiten + Aufnehmen" (Restreamer-Stil) oder später auch Szenen (OBS-Gebiet)? Design sagt "einfacher als OBS".
2. Zuschauerseite (Player, Chat) hier oder in einem eigenen Programm/Suite (Medien-Suite, fs-videos)?
3. Version: README v0.0.1, Doku v0.2.0: welche gilt? Plattformtest (echtes YouTube/Twitch/Odysee) vor erstem Fenster nötig?
4. Verwandtes im Dossier nicht gelesen: Jitsi/BigBlueButton-Livestream: als Vorbild zusätzlich zu Anrufe-Programm gewollt?
