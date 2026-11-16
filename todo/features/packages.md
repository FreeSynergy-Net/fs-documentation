# Feature-Abgleich: fs-packages

Stand 2026-11-16, Auftrag 27, Feature-Abgleich vor dem Feature-Freeze. Feature-Freeze: offen (Nutzer). Nur Deutsch: todo/ wird nicht übersetzt (ADR 0011).

Auftrag 27 · Stand 2026-11-16 · Code: fs-packages main = v0.0.17 (e4448a8), Ergebnis des Lesens, nichts geändert.
Vorbilder: KDE Discover (Plasma 6) · GNOME Software · Microsoft Store · Flathub. Nur als Ergänzung genannt: F-Droid, Obtainium (Dossiere vorhanden).
Kennzeichnung je Zeile: `[x]` = bei uns gebaut (Beleg im Code/CHANGELOG), `[ ]` = geplant (Plan-§) oder fehlt.
Priorität: H hoch · M mittel · N niedrig. Nutzen: 1 Satz.
Wortwahl: Frontend (nie Gesicht). "Store" ist keine Facette (ADR 0075: Marktplatz = Programm, Store = Facette davon; Programm heißt fs-packages).

Quellen (Abruf je Vorbild):
- KDE Discover: Dossier `docs/en/programs/apps/packages/frontends/kde-discover/latest/features.md` + `gaps.md` (Quelle Q1–Q18, Quelltext `invent.kde.org/plasma/discover` master, Dossier-Stand 2026-11-14, Abruf dort). Handbuch docs.kde.org: 404 (nicht belegt).
- GNOME Software: https://help.gnome.org/users/gnome-software/stable/ (Abruf 2026-11-16 durch Haiku). Ergebnis: nur Index mit drei Hilfeseiten, keine Funktionsliste belegt. Kein Dossier im Repo. Alle GNOME-Zeilen unten sind daher [offen].
- Microsoft Store: Dossier Planordner pilot-software/dossier/dossier-microsoft-store.md` (Stand 2026-11-16); offizielle Support-Seiten M1–M3 (support.microsoft.com). Oberfläche selbst: keine offizielle Quelle, [offen].
- Flathub: Dossier `docs/en/programs/apps/packages/frontends/flathub/latest/features.md` (Dossier-Stand, Abruf dort); research/store-vorbilder.md (Stichprobe 2026-11-11, flathub.org/en/apps/org.gnome.Calculator, docs.flathub.org Sicherheitsblog und Verifikation).
- F-Droid, Obtainium: Dossier-Dateien features.md (Dossier-Stand).
Wir kopieren nichts; Bilder nicht übernommen.

## 1. Entdecken

- [x] Startseite mit Überblick (Updates, Neu, nicht unterstützte Einträge) — Discover (Start) — gebaut (v0.0.16, "Start vs. Programs") — H — Ein Blick zeigt, was es Neues und Wichtiges gibt.
- [ ] Kategorien/Arten in der Navigation (Programme, Frontends, Themes, Icon-Sets, Schriften, Server) — Discover (Browse), Flathub — teilweise: Arten im Menü, Schriften und Server fehlen (Plan S2 geplant, O13) — H — Man findet Software nach Art statt nach Name.
- [x] Suche mit Filtern Alle/Installiert/Updates/Nicht installiert und Sortierung — Discover (Search) — gebaut (Filterreihe Paketseite, Sortierung Name/neu/Größe) — H — Schnelles Finden in der Liste.
- [ ] Suche mit Strg+F, Suche innerhalb einer Kategorie — Discover (Ctrl+F, Kategorie-Scope) — Strg+F fehlt, Kategorie-Scope fehlt (Plan S3) — M — Tastatur-Nutzer finden das Feld sofort.
- [ ] Empfehlungen und ausgewählte Programme (Band oben) — Discover, Flathub — fehlt; Kuratierung braucht Katalog-Felder (research/store-vorbilder.md Variante A) — N — Neue Nutzer bekommen einen Einstieg ohne Suche.
- [ ] Bildschirmfotos auf der Paketseite — Discover (Reviews and screenshots), Flathub, GNOME [offen] — Platzhalterrahmen geplant (Plan S5), keine Bilder aus Vorbildern — H — Man sieht vor der Installation, was das Programm tut. Bilder nur vom Macher, nach Lizenzprüfung (ADR 0068 §2).
- [x] Beschreibung auf der Paketseite — Discover, Flathub — gebaut (eine Beschreibung je Paket, kann leer sein) — H — Der Text erklärt den Zweck.
- [ ] Changelog/Versionshinweise je Version — Flathub (Release notes), Discover (Updates-Ansicht) — geplant (research/store-vorbilder.md: releases[] im Katalog); Anzeige Plan S5 "Änderungen" — M — Man sieht vor dem Update, was sich ändert.
- [ ] Bewertungen und Rezensionen — Discover (Reviews), Flathub, MS Store — bewusst NICHT (research/store-vorbilder.md Antwort 7: keine Sterne, keine Zähler) — N — Entscheidung, kein Fehlen; nur Nutzer kann sie aufheben.
- [x] Lizenz-, Quellen- und Entwickler-Info (Macher-Link, Quellcode-Datei, Lizenz) — Discover (Lizenz-Dialoge), Flathub (Quellcode-Links), F-Droid — Herkunft und Quellcode-Link gebaut bzw. im Katalog; Lizenz-Feld auf Paketseite geplant (Plan S5 "Lizenz") — H — Man weiß, wer das gemacht hat und unter welcher Lizenz.
- [ ] Barrierefreiheits-Etikett — (keines der Vorbilder belegt) — fehlt — N — Man sieht, ob das Programm für Hilfsmittel taugt.
- [ ] Datenschutz-Etikett (Speicherort, sendet nach außen) — research/store-vorbilder.md Antwort 6; Flathub/F-Droid: Anti-Features als Vorbild — geplant, erst nach Runde 3b (research/store-vorbilder.md) — M — Man sieht vor der Installation, ob Daten nach außen gehen.
- [ ] Anti-Feature-/Warnhinweise (Tracking, Werbung, Lizenzlücke) — F-Droid (Anti-Features) — fehlt — M — Warnt vor Eigenschaften, die der Nutzer nicht erwartet.
- [ ] Verifizierungs-Abzeichen (Herkunft/Signatur, dreistufig) — Flathub (verified mark) — gebaut ist nur die Signaturprüfung (OpenPGP und TUF, siehe Signaturprüfung unten); das sichtbare Abzeichen mit Stufen ist geplant (research/store-vorbilder.md Antwort 4) (korrigiert 16.11. nach Opus-Bewertung) — H — Man sieht, ob der Macher das Paket selbst signiert hat.

## 2. Installieren, Aktualisieren, Entfernen

- [x] Installieren mit einer Bestätigung und Vorschau — Discover (Install), Flathub — gebaut (eine Frage, "Jetzt installieren", Quelle/Größe/Rechte; Changelog 0.0.16) — H — Keine Überraschung beim Installieren.
- [x] Fortschritt in Phasen mit Bytes — Discover (Transaktion, Fortschritt) — gebaut (Phasen, Fortschrittsbalken; Discover-Quelltext Q16/Q17) — H — Man sieht, wo der Vorgang steht.
- [x] Abbrechen — Discover (Abbrechen nur wenn abbrechbar) — teilweise: Knopf nur in Phasen Warten/Download/Prüfen/Archiv; Systemphase ohne Knopf (Plan S9, Test A5) — H — Ein hängender Vorgang lässt sich stoppen, ohne Rechner-Schaden.
- [ ] Wiederholen nach Fehler — Discover (Fehlerzustand) — fehlt (grep: retry nur 1 Treffer) — M — Ein Netzfehler kostet keinen neuen Suchweg.
- [x] Rückgängig/Rollback bei fehlgeschlagenem Update — (keines der Vorbilder hat es sichtbar; Flathub/Discover nicht belegt) — gebaut (`RolledBack`, Plan A6) — H — Ein kaputtes Update lässt die alte Version laufen.
- [ ] Rollback auf ältere Version (manuell, Versionsliste) — Flathub (Historie je Version), Microsoft nicht belegt — fehlt — N — Man kann zu einer bekannten Version zurück.
- [ ] Abhängigkeiten anzeigen und mit installieren — Discover, GNOME [offen] (Discover-Backends) — teilweise: Bietet/Braucht im Katalog (ADR 0068) gebaut, Auflösung in der Vorschau "Need::Choice" geplant (Plan S6, S25) — H — Man weiß, was noch fehlt, bevor es schiefgeht.
- [ ] Automatische Updates (je Programm) — Discover [nicht belegt], Flathub (Auto-Update) — geplant (Plan S14 "Auto-Update je Programm"; systemd-Timer) — M — Sicherheitsupdates laufen ohne Klick.
- [x] Updates zeitgesteuert prüfen (Prüfintervall, Tagestimer) — Discover (Updates konfigurieren) — gebaut (Einstellung: aus, bei Start, täglich, stündlich; "Jetzt prüfen") — M — Man muss nicht selbst dran denken.
- [ ] Update-Verlauf (Liste früherer Updates) — Discover (History) [nicht belegt], Flathub — fehlt; Meldungsverlauf der Sitzung gebaut (Store > Meldungen), nicht persistent — M — Man sieht, wann was geändert wurde.
- [ ] Neustart-Hinweis nach Update — Discover ("Neustart und Updates installieren") — fehlt — H — Man weiß, wann ein Neustart nötig ist.
- [ ] Offline-Cache des Katalogs — Discover (Offline-Dialog), research/store-vorbilder.md — teilweise: Katalog lokal, Neu-Laden verlässlich (0.0.16); Frische-Regel bis TUF (Plan) geplant — M — Der Store zeigt Daten auch ohne Netz.
- [x] Entfernen mit Bestätigung, Daten bleiben — Discover (Remove), Microsoft Store (Deinstallieren über Windows-Wege, M3) — gebaut ("Uninstall", Frage "Your data stays", Plan S12) — H — Ein Programm verschwindet, Daten bleiben.
- [ ] Entfernen blockiert, wenn das Programm läuft — Discover [nicht belegt] — geplant (Plan S12 "Programm läuft → Grund") — M — Keine halb entfernte Software.

## 3. Quellen, Kanäle, Repositorien

- [x] Mehrere Quellen gleichzeitig (an/aus, hinzufügen, entfernen) — Discover (Sources), F-Droid (extra repositories), Flathub (Beta-Remote) — gebaut (Quellen-Seite; Hinzufügen per Git-Adresse, Plan S13 "hinzufügen" teilweise [nicht belegt] bei Discover) — H — Software kommt aus mehreren getrennten Katalogen.
- [ ] Quellen-Priorität und Standardquelle je Programm — Discover (Make default, Priorität) — fehlt (gaps.md W2, W6) — M — Bei gleichem Programm aus zwei Quellen entscheidet der Nutzer.
- [x] Signaturprüfung vor der Installation (Katalog und Paket) — F-Droid (Reproducibility, Signaturen), Flathub (Verifizierung) — gebaut (OpenPGP, TUF-Client, Test: ohne Vertrauensschlüssel verweigert) — H — Nur geprüfte Pakete werden installiert.
- [ ] Schlüssel-Ablauf und Widerruf beachten — (keines der Vorbilder belegt) — offen (DESIGN.md: Ablauf/Subkey-Widerruf nicht geprüft) — H — Ein widerrufener Schlüssel installiert nichts mehr.
- [ ] Vertrauensstufen je Quelle (Macher-signiert, nur von uns signiert, nur Prüfsumme) — research/store-vorbilder.md Antwort 4 (ADR 0068) — geplant (Abzeichen-Stufen a/b/c), Vertrauen ist heute eine flache Liste — H — Der Nutzer sieht, wem er traut.
- [ ] Vertrauen pro Quelle/Namensraum statt eine Liste — ADR 0068 / Plan — offen (DESIGN.md "trust is one flat list") — M — Eine Quelle kann nicht an fremden Namen schreiben.
- [ ] Werbung/Beta-Kanal getrennt schalten — Flathub (beta remote) — fehlt — N — Beta-Builds liegen getrennt von stabilen.

## 4. Pakettypen

- [x] tar.gz (entpackt, Befehle und Facetten) — Ist, ohne Vorbild in Discover — gebaut (CHANGELOG 0.0.15, Befehle folgen der Form) — H — Eigene Programme laufen ohne Systempaketmanager.
- [x] rpm und deb (Systeminstallation, mit Rechtefrage) — Discover (PackageKit), GNOME [offen] — gebaut (Rechtefrage Container-Test; dnf nicht echt geprüft, DESIGN.md "Not yet tried") — H — Die Systemverwaltung bleibt Herr des Pakets.
- [ ] Flatpak — Discover, Flathub, GNOME — fehlt (nur Erwähnungen im Code) — M — Viele Desktop-Programme gibt es nur als Flatpak.
- [ ] AppImage — Discover (store.kde.org), Craft-Vorbild — fehlt (Erwähnungen im Code) — N — Einzeldateien laufen ohne Installation.
- [ ] Windows msi / exe — Microsoft Store — fehlt; Windows-Port geplant (Plan S8 "UAC, win-port") — M — Gleiche Oberfläche unter Windows.
- [ ] macOS dmg / pkg — Mac App Store [nicht geprüft] — fehlt — N — Gleiche Oberfläche unter macOS.
- [ ] Schriften als eigene Art mit Vorschau, Lizenz, Installation — (kein Vorbild; GNOME Fonts, Font Manager nur als Quelltext) — geplant (Plan S21–S24, A10–A12) — H — Schriften kommen aus demselben Katalog und sind vor der Installation prüfbar.

## 5. Sandbox und Berechtigungen

- [ ] Angezeigte Rechte und Zugriffe je Programm — Flathub (Rechte-Anzeige, Blog docs.flathub.org), Microsoft [offen] — fehlt (kein Sandbox-Code) — H — Man sieht, worauf ein Programm zugreifen darf.
- [ ] Warnung bei neu hinzugekommenen Rechten im Update — Flathub (Hinweis bei Rechte-Zunahme) — fehlt; Plan sieht "Neu in 1.3.0" nur für Abhängigkeiten (research/store-vorbilder.md §2) — H — Ein Update darf nicht still mehr Rechte holen.
- [ ] Sandbox-Ausführung (Flatpak-artig) — Flathub — fehlt, nicht geplant — N — Isolation ohne Vertrauen in den Macher.
- [x] Systeminstallation nur mit Rechtefrage, sonst nichts geändert — Discover (Passwort-Dialog über polkit), Microsoft (UAC) — gebaut (`RightsRefused`, Test A4); Passwort-Dialog kommt vom System (LUECKEN.md) — H — Keine Systemänderung ohne Zustimmung.

## 6. Energie und Datenvolumen

- [x] Download-Größe vor dem Installieren — Discover, Flathub (2 MiB Download), GNOME [offen] — gebaut (Größe in Vorschau, aus Katalog; Installierte Größe optional; fs-packages-app model/cards.rs:103) (korrigiert 16.11. nach Opus-Bewertung) — M — Man plant den Datenverbrauch.
- [ ] Nur bei WLAN/ohne Datenlimit laden — Discover [nicht belegt], Microsoft [offen] — fehlt — N — Mobile Geräte sparen Datenvolumen.
- [ ] Hintergrund-Prüfung nur bei Netz und Netzteil — Discover [nicht belegt] — fehlt (Timer geplant S14) — N — Akku und Netz werden geschont.

## 7. Mehrbenutzer und Admin

- [x] Gesperrte Programme nach Mindestversion (`fs:min-store`) — (kein Vorbild) — gebaut (0.0.14: Grund, Knopf aus, Modell und Engine verweigern) — M — Ein Programm, das eine neuere Store-Version braucht, bleibt gesperrt.
- [ ] Richtlinien (Admin sperrt Programme, erlaubt Quellen) — Microsoft Store (Admin), Discover [nicht belegt] — fehlt; Admin-Frontend mit Seite Prüfen geplant (Plan S18, Zeile Admin) — H — Eine Organisation bestimmt, was installiert werden darf.
- [ ] Unternehmens-Katalog (eigene Quelle für eine Gruppe) — Microsoft Store (private store), Flathub [nicht belegt] — geplant über Quellen (ADR 0068, Katalog je Gruppe) — M — Eine Gruppe hat eigene, abgenommene Software.
- [ ] Installation je Nutzer oder für alle — Discover, Flathub — fehlt auf `main` (nur der Systemweg über `pkexec`; scope user/system nicht gebaut) (korrigiert 16.11. nach Opus-Bewertung) — H — Ein Gerät, mehrere Konten, ohne Rechte-Vermischung.

## 8. Suche, Filter, Sortierung (Querschnitt)

- [x] Filter nach Art und Zustand — Discover (Installed/Updates) — gebaut (Tabs) — H — Schneller Blick auf Installiertes.
- [ ] Filter nach Lizenz, Quelle, Bildschirmfoto-Vorhanden — Discover (Kategorien) — fehlt — N — Eingrenzen nach Kriterien des Nutzers.

## 9. Lokalisierung

- [ ] Texte in Deutsch und Englisch nach MF2 (ADR 0057) — (Vorbilder: alle lokalisiert) — offen (Stand unbekannt laut todo/checklisten/fs-packages.md) — H — Nutzer versteht die Oberfläche in der eigenen Sprache.
- [ ] Namen und Beschreibungen aus dem Katalog mehrsprachig — Flathub, Discover (AppStream) — fehlt (Anzeigenamen Plan "Start-Seite, display names") — M — Pakete erscheinen in der eigenen Sprache.

## 10. Barrierefreiheit und Tastatur

- [ ] Vollständige Tastaturbedienung (Suche, Liste, Aktion) — Discover (Ctrl+F, Alt+Pfeile) — teilweise: Strg+Q, F1 vorhanden; Strg+F, Alt+Links/Rechts fehlen (gaps.md "Keys") — H — Ohne Maus benutzbar.
- [ ] Bildschirmleser-Beschriftung aller Schaltflächen — (keines der Vorbilder belegt) — offen — H — Blinde Nutzer können installieren.
- [ ] Kontrast und Skalierung nach Systemeinstellung — Discover, GNOME [offen] — offen (fs-components Theme, fs-blinc) — M — Lesbar bei Sehschwäche.

## 11. KI (nur benennen)

- [ ] KI-gestützte Empfehlungen oder Zusammenfassungen von Paketen — (keines der vier Vorbilder) — nicht geplant; nur benannt. Wenn überhaupt, dann nur in einer eigenen KI-Gruppe (Memory: KI in Gruppen) — N — Keine KI-Pflicht in der Software-Auswahl.

## 12. Telemetrie

- [x] Keine Telemetrie (wir senden nichts) — Discover [Telemetrie nicht belegt], Flathub (Statistik nicht bestätigt) — gebaut: kein Sende-Code gefunden in fs-packages — H — Nutzer wissen, dass nichts nach außen geht.

## 13. Handtest-Befunde (Nutzer, 2026-11-16)

- [ ] Aktionsmenü der Kachel öffnet außerhalb des Fensters (unten) — Discover (Menü im Fenster) — Fix läuft, noch nicht bestätigt — H — Menü bleibt sichtbar.
- [x] Deinstallieren aus der Kachel — Discover (Remove) — gebaut (Bestätigung "Uninstall", Daten bleiben); Nutzer-Handtest bestätigt Aufruf — H — Programm lässt sich aus dem Menü entfernen.

## Ideen des Nutzers

- (Platzhalter, offen: Nutzer trägt Ideen ein; keine Ideen aus diesem Lauf übernommen.)

## Feature-Freeze: offen (Nutzer)

Kein Agent und keine Strategie setzt den Freeze. Dieser Abgleich ist Eingabe, nicht Freeze.

## Grenzen dieses Laufs

- GNOME Software: Hilfe-Index geladen, keine Funktionsliste belegt; eigenes Dossier fehlt. Alle GNOME-Zeilen [offen].
- Microsoft Store: Oberfläche ohne offizielle Quelle; Zeilen nur aus Dossier-Pflichtfragen belegt.
- Discover-Quelltext aus Dossier übernommen (Stand 2026-11-14), nicht neu geprüft.
- Keine Bilder gespeichert, keine Vorbild-Texte kopiert.
