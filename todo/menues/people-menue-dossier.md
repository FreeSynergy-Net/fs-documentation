# Menü-Dossier FS-PEOPLE (nur Recherche, Stand 2026-11-17)

Regel: Nachbauen = Struktur, Benennung, Reihenfolge, Kürzel, Verhalten. Kein Code, keine Grafiken (ADR 0013). `[nicht belegt]` = in der Quelle nicht gelesen; nichts erfunden.
Quellen: `fs-documentation` origin/main 980adcdc, `docs/en/programs/apps/people/frontends/<x>/latest/menus.md` + `shortcuts.md`; Ist-Stand fs-people origin/main v0.0.14 (52438a6), fs-components origin/main v0.0.25 (7bf826c). Netz: Commons erreichbar, aber keine brauchbare freie Aufnahme der Vorbild-Menüs gespeichert (nur GNOME Contacts 48, KAddressBook: siehe Abschnitt 5/QUELLEN.md, falls geholt).
Wichtigster Befund: die Doku hat für people **nur teilweise** Menü-Inventare. GNOME Contacts, KAddressBook, Nextcloud Contacts: brauchbar (Auswahl, keine Vollständigkeit). **Google Contacts und Apple Contacts: Menüs "not checked/verified" = `[nicht belegt]`**. Thunderbird-Adressbuch: nur Entwurfs-Liste in `messages/.../thunderbird/latest/menus.md` (Hinweisgüte). Outlook "Personen": nicht in der Doku.

## 1. Vorbilder und Quellen
| Vorbild | Menüform | Güte |
|---|---|---|
| GNOME Contacts (45+) | KEINE Menüleiste: Kopfleiste + Hauptmenü ⋮ + Kontaktmenü | Hauptmenü, Kontaktmenü, Kürzel belegt (Doku) |
| KAddressBook (KDE Gear 23/24) | klassische Menüleiste, 7 Menüs (Auswahl-Einträge), Rechtsklick | Menüs nur "(selection)" = unvollständig; Rechtsklick belegt |
| Nextcloud Contacts (AGPL: nur Konzept) | linke Spalte, Aktionsmenü am Kontakt, Teilen-Menü | belegt; keine eigenen Kürzel |
| Thunderbird Adressbuch | Menü "Adressbuch" + Kontaktkontextmenü | Entwurfsgüte, Hinweis |
| Google Contacts | Hauptmenü "Zusammenführen & korrigieren" | nur 4 Orte belegt, sonst `[nicht belegt]` |
| Apple Contacts, Outlook Personen | - | `[nicht belegt]` |
Passend zu ADR 0066/Frontend-Stil: Hauptvorbild GNOME Contacts (Lean, nahe an unserem Fenster: Liste links, Detail rechts) mit KAddressBook als Gegenprobe "volle Menüleiste".

## 2. Menübaum je Vorbild (Kürzel in [ ])
### 2.1 GNOME Contacts
```
Kopfleiste: Suche [Strg+F oder direkt tippen] | Neuer Kontakt [Strg+N] | Hauptmenü ⋮ [F10 oder .]
Hauptmenü ⋮: Neuer Kontakt | Importieren… [Strg+I, "verify"] | Exportieren… (alle als .vcf) | Kontakte zusammenführen | Drucken | Hilfe | Tastenkürzel | Info
  (Trenner/Reihenfolge der Gruppen [nicht belegt])
Kontaktansicht: Schalter "Bearbeiten": alle Felder inline, "+" fügt Feldarten (Telefon, E-Mail, Adresse, Geburtstag, Notiz, Webseite, Beziehung)
Kontaktmenü (Kopfzeile des Kontakts): Löschen | Als vCard speichern | Zusammenführen mit…
Kürzel Bearbeiten: Tab nächstes Feld, Enter bestätigt, Entf löscht markiertes Feld, Esc verlässt Detail/Bearbeiten
Foto: Ziehen auf das Porträt. Quellen: Feld "Adresse" der Karte wählt das Adressbuch (GNOME Online Accounts). Nur-Lese-Quellen (LDAP) sperren Bearbeiten.
Kontextmenü Rechtsklick auf Kontakt in der Liste / Leerfläche: [nicht belegt]
Bild GNOME Contacts 48 (Commons, niederländisch; selbst angesehen): linke Kopfzeile "+" | Titel "Contacten" | Auswahlmodus (Haken-Kreis) | Hauptmenü ☰; darunter Suchfeld, Gruppenkopf "Alle contacten", Liste mit Rundbild; rechte Kopfzeile Stift (Bearbeiten) | ⋮ (Kontaktmenü) | Schließen; Detail: große Rundbild, Name, Feldkarten (E-Mail mit Aktionsknopf, Telefon). Menü-Inhalt ist darauf zugeklappt.
```
### 2.2 KAddressBook
```
Menüleiste: Datei | Bearbeiten | Ansicht | Adressbuch | Extras | Einstellungen | Hilfe
  Datei: Neu > Kontakt / Verteilerliste [Strg+Umschalt+V*] | Import-/Export-Assistent [Strg+I / Strg+E] | Drucken [Strg+P] | Beenden [Strg+Q] (Fenster schließen Strg+W)
  Bearbeiten: Kontakt bearbeiten [Enter] | Kopieren [Strg+C] / Ausschneiden / Einfügen [Strg+V] | Kontakt löschen [Entf] | Suchen/Ersetzen   (Rückgängig [Strg+Z])
  Ansicht: Spalten ein/aus | Schnellauswahlleiste | Adressbuch-Browser ein/aus | Anzeigedesign wählen
  Adressbuch: Neues Adressbuch (Ordner/CardDAV/LDAP…) | Eigenschaften | Alle als vCard speichern
  Extras: Import/Export | Karten drucken (Visitenkartenlayouts) | Kontakte synchronisieren (Akonadi-Status)
  Einstellungen: Akonadi-Ressourcen verwalten | Kurzbefehle | KDE-PIM einrichten
  Hilfe: Handbuch | Info
  (Namen englisch in der Doku, deutsche Namen = eigene Übersetzung; "Auswahl" = Doku-Wort; Trenner [nicht belegt])
Kontextmenü Kontakt: Bearbeiten | Kopieren | Löschen | Als vCard speichern | Zur Verteilerliste hinzufügen | Details anzeigen
Adressbuch-Browser links, Rechtsklick Ordner: Eigenschaften | Jetzt synchronisieren | Offline-Verhalten
Rollen: LDAP/CardDAV lesend = Erstellen/Bearbeiten ausgegraut (belegt)
Import-Formate: vCard, LDIF/LDAP, CSV (Import)
```
### 2.3 Nextcloud Contacts (nur Konzept)
```
Linke Spalte: Alle Kontakte | Gelöschte Kontakte | Geteilte Adressbücher | Eigene Adressbücher (Persönlich, Geburtstage & Jahrestage) | + Neues Adressbuch ; Kopfleiste: Suche [/ oder Strg+K]
Kontaktdetail: Bearbeiten / Fertig | Felder hinzufügen | Favorit (Stern) | Aktionsmenü: Anrufen | Nachricht | E-Mail schreiben | Als Karte speichern (vCard) | Löschen
Teilen je Adressbuch: mit Benutzern/Gruppen/Kreisen (Lesen, Lesen/Schreiben, Bearbeiter) | öffentlicher Link (Lesen) | CardDAV-Adresse anzeigen
Import/Export: .vcf per Ziehen oder Dateidialog (Duplikaterkennung); Markieren > "Kontakte herunterladen" ; Kürzel: keine eigenen, Neu nur per Knopf
```
### 2.4 Weitere
Thunderbird (Entwurfsgüte): Adressbuch: Neuer Kontakt, Neuer Kontaktordner, Kontakt bearbeiten, Kopieren/Löschen, Importieren/Exportieren, Verteilerliste; Kontext: Bearbeiten/Löschen | E-Mail schreiben | In Kalender importieren | Karte drucken | QR-Code (Add-on). Google Contacts: Hauptmenü "Zusammenführen & korrigieren" > Duplikate zusammenführen; Kontaktliste mit Auswahl: Symbol "Zusammenführen"; Kontaktseite: Verlauf. Alles Weitere `[nicht belegt]`.

## 3. Gemeinsamer Nenner und VORSCHLAG
Nenner (GNOME + KAddressBook + Nextcloud): Neu [Strg+N], Suche [Strg+F], Kontakt bearbeiten/fertig, Feld hinzufügen ("+"), Löschen, Als vCard speichern, Importieren, Exportieren, Zusammenführen, Adressbuch/Quelle wählen, Teilen je Adressbuch (Nextcloud). Unterschied: GNOME/Nextcloud ohne Leiste; nur KAddressBook mit Leiste.
VORSCHLAG fs-people (Windows-/GNOME-Stil, keine eigene Menüleiste; Shell-Titelleiste nach ADR 0065):
1. Shell-Titelleiste: Programm [Importieren… vCard, Exportieren…, Beenden Strg+Q] | Ansicht [Spalten (Häkchen), Gruppieren nach] | Hilfe [Hilfe F1, Tastenkürzel, Über]. Heute: **gar keine Menüs** (siehe 4).
2. Befehlsleiste über der Liste (Reihenfolge): Suchfeld [Strg+F] | Neu [Strg+N] | Zusammenführen (Vorschläge) | ⋮ Mehr (Importieren, Exportieren, Drucken [nicht gebaut: gesperrt "kommt noch"]).
3. Detailkopf: Bearbeiten/Fertig-Schalter | Favorit | ⋮ Kontaktmenü: Als vCard speichern | Zusammenführen mit… | Als sensibel markieren | Rollen verwalten | Löschen (Reihenfolge nach GNOME, die drei letzten sind fs-people-eigen aus der README: sensibel, Rollen).
4. Kontextmenü Kontakt (Liste): Bearbeiten [Enter] | Kopieren [Strg+C] | Als vCard speichern | Zur Gruppe hinzufügen > | --- | Löschen [Entf] (KAddressBook-Muster, belegt). Leerfläche: Neuer Kontakt | Einfügen | Importieren… [Namen vorgeschlagen].
5. Seitenleiste (Nextcloud-Muster): Alle | Favoriten [nicht belegt als Vorbild] | Gruppen | Adressbücher; Rechtsklick Adressbuch: Eigenschaften | Jetzt synchronisieren | Teilen… (später, CardDAV/Sync nicht gebaut: gesperrt).
6. Verhalten: schreibgeschützte Quelle = Neu/Bearbeiten/Löschen deaktiviert mit Grund (KAddressBook belegt); Kürzel rechts; Beenden mit nicht gespeicherter Eingabe fragt (heute schon im Widget).

## 4. Ist-Stand und fs-components-Lücken
fs-people v0.0.14: `surface.rs:30-33` baut `AppWidget::new(TITLE, [Screen])` und ruft **nie `set_menus`**; ohne Menüs zeichnet die Shell keine Menüleiste (`menu_bar` liefert None). Also **kein einziges Menü, kein Kontextmenü, keine Kürzel**. Bedienung nur über Fenster-Knöpfe: Suchfeld ("Search people"), Liste (Spalten Name, E-Mail, "mehr"), Detail (Kontakt, Organisation, Adressen, Über, Rollen; "Kept on the card"), Knöpfe Neu, Bearbeiten, Speichern, Abbrechen, Löschen (mit Rückfrage), Feld hinzufügen (`people/view/actions.rs`, `frame.rs`: Liste links, Detail rechts, schmal gestapelt). Wörter nur englisch (`words.rs`); deutsch `[nicht belegt]`. Zusammenführen-Vorschläge, vCard-Import/-Export, Gruppen, Beziehungen, Rollen sind im Kern da (README), im Fenster nicht erreichbar.
| Bedarf | Stand v0.0.25 | Baustein |
|---|---|---|
| Menü-Modell mit Trenner/Radio/Kürzel/Grund | fehlt | M1 |
| Kürzel Strg+N, Strg+F, Entf, Strg+I | fehlt (`bind_keys` nur am Element) | M2 |
| Kontextmenü Kontakt/Leerfläche/Adressbuch | fehlt (nur Spaltenkopf-Menü) | M3 |
| Listen-Tastatur: Pfeile, Entf, F2/Enter, Strg+A | fehlt | M4 |
| Personenauswahl (Zur Gruppe hinzufügen, Zusammenführen mit…) | Dialog-Rahmen da, Baustein fehlt | M6 |
| Befehlsleiste mit Überlauf "Mehr" | fehlt | M7 |
| Datei-Wähler für Import/Export | `[nicht belegt]` in dieser Lesung | prüfen |
Komponenten-Lauf M1–M4 + M6 vorher: JA. Programm-Anschluss: eigener `set_menus`, danach Kontextmenüs.

## 5. Bildpaket-Plan (nur lokal; interne Referenzbilder, nicht im Repo; unser: Offscreen-Bild gleiche Größe)
Namen `people-menue-<teil>-<vorbild|unser>.png`:
1. `fenster-ruhend` (Liste leer/mit 5 Kontakten, nichts gewählt) | `fenster-kontakt-gewaehlt` | `fenster-bearbeiten`
2. `hauptmenue-auf` (GNOME ⋮) | `kontaktmenue-auf` (GNOME) | `leiste-datei-auf` ... `leiste-hilfe-auf` (KAddressBook, Vorbild FEHLT) | `shell-titelleiste-programm/-ansicht/-hilfe` (nur unser)
3. `kontext-kontakt` (KAddressBook) | `kontext-leerflaeche` [nicht belegt] | `kontext-adressbuch` (KAddressBook, Nextcloud) | `teilen-menue` (Nextcloud)
4. `feld-hinzufuegen-menue` (GNOME "+") | `zusammenfuehren-dialog` (GNOME/Google) | `import-dialog`
Gesperrter Eintrag, Hover, Fokus je Menü hell/dunkel. Aufnahmen der Vorbilder: Nutzer/Test-Agent am laufenden Programm (GNOME Contacts 48 und KAddressBook auf Commons ggf. als Ersatz, Lizenz prüfen).

## 6. Deutsche Namen (nur belegte)
fs-people: keine deutschen Menünamen `[nicht belegt]`. Vorbilder: Doku englisch; deutsche Namen nicht belegt (Übersetzung eigen, vor Bau mit deutschen Oberflächen vergleichen: GNOME "Kontakte", KDE "Adressbuch" `[nicht belegt]`).

## 7. Offene Fragen
1. Soll fs-people im GNOME-Stil (Kopfleiste + ⋮, keine Leiste) oder im KAddressBook-Stil (volle Menüleiste) gebaut werden? Empfehlung: GNOME-Stil + Shell-Titelleiste, Leiste nur als zweites Frontend.
2. Wo erscheinen Rollen und die Markierung "sensibel" (fs-people-eigen, kein Vorbild)? Empfehlung: Kontaktmenü und Detailkopf, nie in der Liste.
3. Zusammenführen: eigener Menüpunkt wie GNOME (Dialog mit Vorschlägen) oder nur Hinweisleiste? Empfehlung: Menüpunkt + Vorschlagsliste, nichts ohne Bestätigung.
4. Vorbild-Aufnahmen GNOME Contacts / KAddressBook / Nextcloud: Nutzer oder VM? (Google/Apple/Outlook ohne Aufnahme bleiben `[nicht belegt]`.)

## Entscheidung (b7, 17.11.)
Standard-Frontend im GNOME-Stil (Kopfleiste, Menü ⋮ und Kontextmenü). Ein KAddressBook-artiges Frontend mit Menüleiste kommt später als zweites Frontend.
