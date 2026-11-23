# 0108 – Digitales Vergessen: der Tresor (`fs-vault`) vergisst, die Speicherschicht führt aus

Status: **Entwurf** (2026-11-23; Workflow `adr-write`; Entscheide von Nutzer und Strategie vom 23.11.2026 eingearbeitet: Start des Themas (Frage 34 = JA), Voreinstellungen (Frage 35 = JA mit Ergänzung Geburtstage und Kontakte), Nachtrag „ganz abschaltbar, Backup erlaubt“; Grundlage: Opus-Schnitt VERGESSEN und Recherche VG-0r vom 23.11.; Opus-Review (Sicherheit) offen; r1: Entscheide der Strategie vom 23.11.2026 eingearbeitet: Löschen täglich und Schlüsselwechsel wöchentlich, Files-Ablage verschlüsselt mit Export, Dokument-Historie ohne Kürzung) · **ergänzt** ADR 0067 (Tresor) · **löst auf** ADR 0024 Z. 6 und ADR 0090 Z. 33 („Schlüssel entstehen nur, wenn die Person die Verschlüsselung einschaltet“) zugunsten von ADR 0067 Z. 25 · **ändert** ADR 0073 §7 (automatische Kürzung nur mit gesetzter Frist) · **präzisiert** ADR 0100 E5 (keine Admin-Sperre über Fristen eigener Daten) und ADR 0071 (Files-Ablage verschlüsselt, Backup = bewusstes Behalten) · **erledigt** ADR 0104 Offen 6 · **ergänzt** ADR 0102 E8 (Abstreitbarkeit) · baut auf ADR 0029, 0058, 0069, 0071, 0073, 0085, 0086, 0095, 0100, 0102, 0104, 0106

**Nummer:** 0108. Herleitung: `fs-documentation` origin/main 76aed119 endet bei `0107-fs-modules-workflow.md`; kein Zweig von origin und kein lokaler Zweig enthält `conventions/decisions/0108-…` oder höher.

**Form:** ein eigener ADR mit kurzen Verweis-Nachträgen in den berührten ADRs, weil Beschlossenes bleibt und Änderungen eine neue Nummer bekommen (ADR 0032 E2, README dieses Ordners) und weil das Vorhaben neun ADRs berührt, also einen einzigen Ort für die Entscheidung braucht.

**Lesehinweis:** „Belegt“ heißt gegen Quelltext oder Primärquelle geprüft (Fundstelle dabei). Was nicht belegt ist, steht als **[nicht belegt]** oder unter „Offen“. Zeilenangaben zu ADRs beziehen sich auf origin/main 76aed119.

---

## Kontext
- Wer ein Gerät beschlagnahmt oder später ein Passwort erzwingt, soll nur finden, was die Person noch behalten will. Besonders wertvoll für Angreifer ist der **Kontaktgraph** (wer wann mit wem), den die Person selbst kaum braucht.
- Bestand: ADR 0067 Z. 25 „Datenbankdatei immer verschlüsselt, Schlüssel im Tresor“; Papierkorb mit Frist und `keep_until` (ADR 0073, Nachtrag 16.11.); „wirklich löschen“ im Loro-Puffer (ADR 0073 §7); Löschen einer Person als Treibertest (ADR 0104 E6); `history.forget` im Verlauf-Index (fs-interfaces `schema/history.capnp`). Es fehlen: Fristen je Datenart über Module hinweg, Schlüsselwechsel, Schnellsperre, ein Besitzer des Ganzen. Ein Repo `fs-vault` gibt es noch nicht.
- Auf SSDs erreicht Überschreiben nicht zuverlässig alle Kopien (Wear Leveling, Reserve-Bereiche); der übliche Weg ist kryptografisches Löschen: die Daten bleiben verschlüsselt, der Schlüssel wird vernichtet (Wei u. a., FAST '11; NIST SP 800-88 Rev. 2; nur teilweise gelesen, Vorbedingungen von NIST **[nicht belegt]**). Darum hängt Vergessen an der Verschlüsselung im Ruhezustand.

## Entscheidung

### E1. Vergessen gehört dem Tresor
| Schicht | Aufgabe |
|---|---|
| **Tresor `fs-vault`** (ADR 0067) | Besitzer des Vergessens: Schlüsselbaum (Root → optional Hardware-Anker → Dateischlüssel je Moduldatei (ADR 0104 E7) → Abschnittsschlüssel für Bytes außerhalb der DB), **Fristen-Plan** (Datenart, Frist, nächster Lauf), **Lauf**, **Schnellsperre**. Vertrag `vault`, Teil `forget` (`plan`, `setDeadline`, `keep`, `forgetNow`, `lock`) [Namen Vorschlag, wird in VG-3 entschieden]. |
| **Speicherschicht** (fs-objects hinter `KeyProvider`) | führt aus: Zeilen nach Datenart und Alter löschen (Kaskade wie beim Papierkorb), Datei mit neuem Schlüssel neu schreiben (E3), Mengen je Datenart melden. Kein Programm hat eigenen Code dafür. |
| **fs-settings** (ADR 0100) | hält die Fristen als typisierte Einstellungen der Person bzw. der Gruppe (`fs.vault.retention.<datenart>` [Name Vorschlag, wird in VG-3 entschieden]). Der Tresor liest sie; keine zweite Ablage. |
| **Jedes Modul** | **erklärt nur** je Datentyp seine Datenart `retention_class` (E5) in der Typbeschreibung bzw. im Bauplan, und welche Ableitungen es erzeugt. Fehlt die Angabe, gilt `content` (nie automatisch ohne Wahl der Person). |
| **Form und Components** | Form `retention-overview` und Toast über `notification.ask` (ADR 0106 §1 Punkt 3). Kein Programm zeigt selbst etwas an. |

### E2. Boden: die Datenbankdatei ist immer verschlüsselt
- ADR 0067 Z. 25 gilt ohne Ausnahme, auch im Einzelplatz (ADR 0090). Begründung: Ohne Verschlüsselung im Ruhezustand lässt sich auf einer SSD nichts verlässlich vergessen (Kontext). „Wahlweise“ betrifft nur noch, **wo der Schlüssel liegt**, nicht ob es einen gibt.
- **Voreinstellung:** der Dateischlüssel liegt im **Schlüsselbund des Betriebssystems** (Secret Service, Windows Credential Manager, Apple Keychain; über `keyring-core` mit den Speicher-Crates, hinter der Schnittstelle des Tresors; das ist die Übergangsschnittstelle aus ADR 0071 §2). Damit fragt die Installation weiter nach keinem Passwort (ADR 0090 E4).
- **Wählbar:** Passwort (Argon2id) oder Hardware-Schlüssel (Passkey-PRF, CTAP2 `hmac-secret`), wie ADR 0067 §1.
- **Ehrlich, einmal beim Einrichten gesagt:** Die Voreinstellung schützt die Datei **so gut wie die Anmeldung am Betriebssystem**. Sie schützt gegen jemanden, der das ausgeschaltete Gerät oder die ausgebaute Platte hat und die Anmeldung nicht kennt. Sie schützt **nicht** gegen jemanden, der als die Person angemeldet ist, Schadcode in ihrer Sitzung hat oder das Anmeldepasswort erzwingt. Wer mehr will, wählt Passwort oder Hardware-Schlüssel. Wie die einzelnen Schlüsselbunde ihren Inhalt absichern, ist **[nicht belegt]**.
- Bekannt: die Turso-Verschlüsselung läuft hinter `experimental_encryption(true)` (fs-objects `src/turso/encryption.rs:18`); Seite 1 enthält unverschlüsselte Formatangaben.

### E3. Vergessen in zwei Takten: täglich löschen, wöchentlich neuer Schlüssel
- **Kein Schlüssel je Zeitabschnitt in der lebenden Datenbank.** Begründung: ein Schlüssel je Abschnitt hieße Chiffrat je Feld; nach ADR 0086 liegen eigene Daten aber typisiert und durchsuchbar in Spalten, Chiffrat nur in markierten Feldern (Ausnahme 2). Suche und Abfragen gingen sonst nur über Entschlüsseln im Speicher.
- **Zwei Takte** (Entscheid Strategie 23.11.2026, einstellbar):
  - **Täglich: Löschlauf.** Abgelaufene Zeilen nach `retention_class` und Alter werden logisch gelöscht, mit allen Ableitungen (E9). Das ist billig; für die Person und alle Programme ist das Abgelaufene ab dann weg.
  - **Wöchentlich: Schlüssellauf** (je Moduldatei), nur wenn seit dem letzten etwas gelöscht wurde:
  1. (Löschlauf, falls noch offen);
  2. die verbleibenden Zeilen in eine **neue Datei mit neuem Dateischlüssel** schreiben;
  3. die neue Datei prüfen und atomar gegen die alte tauschen;
  4. alte Datei und WAL löschen, **den alten Schlüssel vernichten** (im RAM per `zeroize`, im Tresor löschen, Hardware-Anker neu setzen, E4).

  Alles, was die SSD noch hält (alte Seiten, WAL-Rahmen, Dateisystem-Schnappschüsse), ist danach Chiffrat unter einem vernichteten Schlüssel.
- **Warum eine neue Datei:** Turso 0.8.3 kann den Schlüssel einer bestehenden Datei nicht wechseln (belegt: `turso_core-0.8.3/connection.rs:4719-4722` setzt nur einen noch fehlenden Schlüssel, `:4763-4775` verweigert die Änderung; Upstream-Blog „Encrypting SQLite databases with Turso“: „Native rekeying … is not yet supported“, Ausweg Export und Import in eine neue Datei). Ob `VACUUM INTO` mit einem **anderen** Schlüssel geht, ist **[nicht belegt]** (der einzige Test nutzt denselben Codec, `database.rs:5079-5107`). Ein Rekey in Turso ist ein Kandidat für einen Upstream-Beitrag (Kooperation).
- **Selten und einstellbar:** der Schlüssellauf läuft im Leerlauf oder beim Sperren. **Ehrlich gesagt:** zwischen dem täglichen Löschen und dem nächsten Schlüssellauf (bis zu 7 Tage bei der Voreinstellung) stecken gelöschte Zeilen noch in freien Seiten oder im WAL der Datei. Wer in dieser Zeit die Datei **und** den Schlüssel hat (etwa ein Forensiker mit einem entsperrten Gerät oder dem Schlüsselbund), kann Gelöschtes noch herausholen. Erst der Schlüssellauf macht das unmöglich. Wer das Fenster verkürzen will, stellt den Takt kürzer; das kostet Neuschreiben. Das Fenster verspricht nichts, was nicht belegt ist (Offen 9). Die Übersicht zeigt den nächsten Schlüssellauf. Während des Laufs ist die Moduldatei kurz gesperrt.
- **Abschnittsschlüssel** (z. B. Monat × Datenart) gibt es **nur** für Bytes außerhalb der lebenden DB: Datei-Inhalte und Versionen der eigenen Files-Ablage (Nachtrag ADR 0071), Kopien auf eigenen Servern (ADR 0067 §2), Abgleichs-Puffer bei Bedarf. Fristablauf heißt dort: Abschnittsschlüssel vernichten, Chiffrat löschen. Kopien, die nur Chiffrat halten (auch Server-Schnappschüsse), werden damit unlesbar.
- **Server** (ein Speicher je Modul und Instanz, ADR 0104 E7): kein Neuschreiben der Server-Datei je Lauf; dort genügen Abschnittsschlüssel je Person bzw. Gruppe (der Server hält nur Chiffrat) und das Löschen des Chiffrats.

### E3a. Files-Ablage verschlüsselt, Weg nach außen ist der Export

Bestätigt (Strategie 23.11.2026, W6): Inhalte und Versionen der **eigenen** fs-files-Ablage liegen verschlüsselt (Abschnittsschlüssel, E3). Andere Programme sehen diese Dateien daher **nicht mehr direkt im Dateisystem**. Das folgt dem Grundsatz „Speichern = Datenbank, nur Export macht Dateien“: wer eine Datei außerhalb braucht, **exportiert** sie (offene Formate; ADR 0071, Nachtrag). Ein Export ist eine Kopie außerhalb des Vergessens und zählt wie ein Backup als bewusstes Behalten. Dateien in normalen Ordnern der Person (Home) verschlüsselt Files nicht; das sagt Files offen. Format und Oberfläche des Exports: Offen 8.

### E4. Hardware-Anker: die eine löschbare Stelle
- Die Dateischlüssel liegen verpackt im Tresor, und der Tresor liegt selbst auf der SSD; alte verpackte Fassungen können dort physisch überleben. Wer später das Passwort erzwingt, könnte sie entpacken. Darum bekommt der Root-Schlüssel eine **rotierende Zutat in Hardware**: einen TPM-NV-Index oder einen Secure-Enclave-Schlüssel, bei jedem Lauf neu gesetzt, der alte entfernt.
- Belegt ist nur: `tss-esapi` kann einen NV-Index mit `nv_undefine_space` entfernen (docs.rs). Formulierung daher: **„Der Lauf entfernt den alten Schlüssel aus dem TPM; ob das forensisch hält, ist nicht geprüft.“** Windows (NCrypt „Platform Crypto Provider“) und Apple (Secure Enclave über `security-framework`) sind **[nicht belegt]**. `keyring-core` kann keinen Hardware-Anker (belegt, docs.rs). Ein FIDO-Stick mit `hmac-secret` hilft beim Entsperren, kann aber nicht rotieren.
- Der Anker ist ein **optionaler Adapter** des Tresors. Ohne Hardware sagt die Einrichtung **einmal**: „Ohne Sicherheitschip können alte Schlüssel auf der SSD überleben. Wer später dein Passwort erzwingt und das Gerät forensisch untersucht, kann damit Reste lesen, die schon vergessen waren.“

### E5. Datenarten (`retention_class`) und Voreinstellungen beim ersten Start
| Datenart | Beispiele | Voreinstellung |
|---|---|---|
| `connection` | wer wann mit wem (Verbindungs- und Anrufprotokolle), Zustell- und Lesebestätigungen, Anwesenheit, „zuletzt gesehen“, gesehene Geräte und Netzadressen | **7 Tage** |
| `location` | geteilte Orte, Ortsverlauf (Notfall ausgenommen) | **7 Tage** |
| `activity` | Verlauf-Index `fs-activities`, Undo-Verlauf der Sitzung (ADR 0069) | **30 Tage** |
| `trash` | Papierkorb | 30 Tage (Bestand, ADR 0073 Nachtrag 16.11.) |
| `draft` | Entwürfe, Sitzungs-Klone | 30 Tage (Bestand, ADR 0069) |
| `message` | Chat, Mail | **aus**; beim Einrichten Vorschlag 1 Jahr |
| `content` | Dokumente, Texte, Bilder, Aufgaben, Termine | **aus** |
| `record` | Verträge, Buchungen, Pakete, gesicherte Beweise (E8) | **nie automatisch** (fest) |
| `emergency` | Notfall-Daten | **nie automatisch** (fest) |
| `contact` | Personen und Profile (Kontakte, ADR 0058), **Geburtstage**, auch als Termin | **nie automatisch** (fest) |

- „Fest“ heißt: kein Automatismus, die Frist ist dort nicht einstellbar; **von Hand löschen geht immer**. Ein Geburtstag ist `contact`, auch wenn er als Termin erscheint; ein Termin aus einem Geburtstag ist eine Ableitung des Kontakts (E9) und folgt ihm.
- Der **Verlauf eines Inhalts-Objekts** (`activity_change`, `collab_buffer`) gehört zum Objekt und folgt dessen Datenart. Für Dokumente bleibt daher der volle Verlauf Voreinstellung (ADR 0073 §7); `activity` meint den programmübergreifenden Verlauf und den Undo-Verlauf der Sitzung. **Bestätigt (Strategie 23.11.2026):** keine voreingestellte Kürzung der Dokument-Historie; der Verlauf folgt der Datenart des Dokuments, und Inhalte stehen auf „aus“.
- `hold`/`keep_until` geht vor jeder Frist (vorhanden, fs-objects `src/v5/hold.rs`; ADR 0073 Nachtrag 16.11.). „Behalten“ je Objekt setzt genau das.

### E5a. Kontakt bleibt, vergessen werden nur die Verbindungsdaten über ihn
- **Bleibt (`contact`):** die Person bzw. das Profil selbst mit allem, was auf der Karte steht (Name, Adressen, Geburtstag, Schlüssel und lokale Schlüsselbestätigungen), dazu seine Herkunft (`Origin`, ADR 0085: Kanal, Quelle, Importzeit).
- **Wird vergessen (`connection`):** Zeilen, die ein **Ereignis zwischen Personen** festhalten: wer wann mit wem Kontakt hatte, Zustellung und Lesen, Anwesenheit, gesehene Geräte und Adressen.
- **Grenze im Datenmodell:**
  1. Verbindungsdaten zeigen auf die Person nur per `PersonRef` (ADR 0085). Vergessen löscht die Zeile mit dem Verweis, **nie das Ziel**.
  2. Was **Teil eines behaltenen Inhalts** ist (Absender und Zeit einer behaltenen Nachricht, `attributedTo`/`published` der AS2-Hülle), gehört zum Inhalt und folgt dessen Frist. Sonst stünde eine behaltene Nachricht ohne Absender da. Offen gesagt: wer Nachrichten behält, behält auch, wer wann schrieb.
  3. Was aus Verbindungen **abgeleitet** wird („zuletzt Kontakt“, Häufigkeit, Sortierung nach Nähe), wird nicht am Profil gespeichert, sondern berechnet oder als `connection` geführt.
- **Offen (nicht überdeckt):** Heute ist die Grenze nicht sauber ziehbar. Es gibt keinen eigenen Datentyp für Verbindungsdaten mit `retention_class`; Zustell- und Lesestatus, Anwesenheit und Gerätelisten liegen, soweit vorhanden, in den Programmen oder in den Speichern fremder SDKs (z. B. `matrix-sdk` in fs-messages). Geprüft ist nur, dass fs-people keine Felder „zuletzt gesehen“ oder „zuletzt Kontakt“ führt (grep, 23.11.); fs-messages ist nicht geprüft.

### E6. Selbstbestimmung und Sichtbarkeit: alles einstellbar, ganz abschaltbar
- Grundsatz des Nutzers (23.11.2026): **„Wir können die Menschen nicht vor sich selbst schützen, aber wir können ihnen beibringen, bewusster zu reagieren, wenn Gefahren kommen.“**
- **Alles einstellbar** (außer den festen Datenarten aus E5); **das Vergessen ist ganz abschaltbar**. **Backup ist erlaubt und ist bewusstes Behalten**: es hebt das Vergessen für die Kopie auf. Kein Zwang, keine Sperre gegen den Besitzer.
- **Übersicht** (Form `retention-overview`): eine Zeile je Datenart mit Menge (Anzahl, Größe), Frist (Auswahl oder aus), nächstem Ablauf (Datum, Anzahl) und Zahl der behaltenen Objekte; oben der Schalter „Digitales Vergessen an/aus“; je Sicherungsziel sachlich „in Sicherungen bis …“ (ADR 0071), ohne Warnfarbe. In jedem Programm je Objekt die Befehle „behalten“ und „jetzt vergessen“.
- **Ein Toast** (`notification.ask`), einmal **7 Tage vor** einem Ablauf von **Inhalten** (`message`, `content`), gebündelt je Tag, nicht für `connection`, `location`, `activity`. Aktionen: [Frist ändern] [Sichern/Exportieren] [Auswählen und behalten] [In Ordnung]. Ohne Inhalte und Namen; in Systembenachrichtigungen nur die Anzahl (ADR 0106 §1 Punkt 8).
- **Eine Erklärung** (drei Sätze, Bestätigen per Knopf, kein Tipptest) beim **Abschalten**, beim **Verlängern** über die Voreinstellung und beim **Einrichten eines Sicherungsziels**: was passiert, wer es dann lesen kann, wie man es rückgängig macht. Danach keine Dauerwarnung.
- **Hilfe-Kapitel „Wenn Gefahr kommt“** (Hilfe = Doku in texts): Schnellsperre, Gerät ausschalten statt sperren, was Vergessen kann und was nicht, Backup bewusst aufbewahren, was außerhalb unserer Hand liegt (Swap, Ruhezustand, Zwischenablage, „zuletzt geöffnet“ des Systems). Aus Erklärung und Übersicht verlinkt.
- **Telegram nur als Idee:** belegt sind allein die Cache-Frist für Medien („Keep Media“, betrifft den lokalen Cache, Blog 08.12.2015) und das automatische Löschen von Nachrichten mit 24 Stunden, 7 Tagen, 1 Monat oder frei (telegram.org/faq). Aufbau und Aussehen von Telegrams Speicher-Ansicht sind **[nicht belegt]** und werden nicht als Vorbild zitiert.

### E7. Gruppen
- Gruppen-Daten gehören der Gruppe. **Die Gruppe setzt die Frist ihrer Daten nach ihrer eigenen Entscheidungsregel** (ADR 0095). Die Frist gilt auf dem Gruppen-Server und in unseren Programmen auf den Geräten der Mitglieder.
- Ein Mitglied darf **für sich früher vergessen**. Länger behalten (Backup, Export, Bildschirmfoto) kann die Gruppe nicht verhindern; das wird gesagt, nicht als Schutz verkauft (ADR 0102 E8).
- **Kein Admin sperrt die Fristen der eigenen Daten einer Person** (Ausnahme zu ADR 0100 E5 für `fs.vault.retention.*` der Schicht Person).
- Technik: Abschnittsschlüssel der Gruppen-Daten werden aus dem Gruppenschlüssel abgeleitet (MLS-Epochen sind schon Zeitabschnitte, ADR 0067 §2). Fristablauf: die Geräte der Mitglieder vernichten den Abschnittsschlüssel, der Server löscht das Chiffrat.

### E8. Gespräche: Signatur prüfen, nicht speichern
- MLS signiert **jede** Nachricht (RFC 9420 §6.1: „Recipients of an MLSMessage MUST verify the signature“). Diese Signatur ist ein übertragbarer Beweis, wer schrieb. Das wird nicht verschwiegen.
- **Regel des Geräts:** die Signatur wird beim Empfang geprüft, gespeichert werden Inhalt und das Ergebnis „geprüft“, **nicht die Signatur**. Ein beschlagnahmtes Gerät enthält dann keinen übertragbaren Beweis. Dasselbe gilt für signierte Änderungen gemeinsamer Dokumente (ADR 0073 §6). Das ist eine Regel unserer Programme, kein Merkmal des Protokolls; was andere Clients speichern, liegt nicht in unserer Hand.
- **„Beweis sichern“** auf Wunsch des Empfängers, je Nachricht oder Verlauf (Opferschutz vor Täterschutz, Nutzer 18.11.): das signierte Original bleibt und fällt unter `record`. Ehrlich: das ist symmetrisch, auch ein Täter kann so sichern. Nur asymmetrisches Message Franking (ePrint 2019/565) würde das lösen; dafür gibt es kein Rust-Crate (Suche crates.io 23.11.), es bleibt Forschung.
- **Echte, dauerhafte Signaturen** nur bei Verträgen, Paketen und öffentlichen Stellen.

### E9. Alle Ableitungen vergessen mit
- Mitvergessen werden: Suchindex, Vorschaubilder, Loro-Puffer (per Epochenwechsel, ADR 0073 Nachtrag 16.11. Punkt 3), Versionen in Files, AS2-Aktivitätsverlauf (`activity`, `activity_change`, `history.forget` in fs-activities), Sicherungen (sachlich „bleibt bis …“, ADR 0071), Entwürfe und Sitzungs-Klone, alte Megolm- und MLS-Epochenschlüssel, Meldungs-Verlauf, Logs (sie enthalten keine Inhalte, ADR 0106 §1 Punkt 8; sonst gehören sie dazu).
- **Herkunftsverweis:** jede Ableitung trägt die Objekt-Id ihrer Herkunft. Ohne Verweis darf sie nicht entstehen; der Workflow `programm-neu` prüft das.
- **Konformitätstest „vergessen vollständig“** für jeden Speicher-Treiber (vierter Test neben ADR 0104 E6): nach dem Lauf ist eine eingesetzte Nadel weder in der Datei noch im WAL noch in einer Ableitung zu finden, und die alte Datei ist mit dem neuen Schlüssel nicht lesbar. Die heutige Eigenaussage in fs-objects (`src/turso/purge.rs:66-81`, „the needle is gone from both files“) ist nicht nachgemessen und ersetzt den Test nicht.
- Damit gilt für ADR 0073 §7: automatische Kürzung **nur, wenn für die Datenart eine Frist gesetzt ist**; für Inhalte bleibt die Voreinstellung aus (Nachtrag dort).

### E10. Schnellsperre ja, Duress nein
- **Schnellsperre:** Tastenkürzel, Tray-Knopf, Abziehen des FIDO-Sticks (einstellbar), Bildschirmsperre des Systems (einstellbar), Leerlauf-Zeit. Wirkung: DB-Verbindungen schließen, alle Schlüssel im RAM per `zeroize` überschreiben, Schlüsselseiten per `mlock` gegen Auslagern schützen. Danach ist das Gerät so geschützt wie ausgeschaltet. Gegen Auslesen des RAM **vor** der Sperre hilft das nicht.
- **Bekannter Mangel (Sicherheitsmodul, erste Bauwelle):** `EncryptionKey.key: Vec<u8>` hat kein `zeroize`, und `hex()` legt eine zweite Kopie des Schlüssels als `String` an, die an Turso geht und nie überschrieben wird (fs-objects `crates/fs-objects/src/crypto.rs:45-50`, `:73-79`; `src/turso/encryption.rs:21`). Heute stünde der Schlüssel nach einer Sperre noch im Speicher.
- **Kein Duress-Passwort, keine versteckten Bereiche.** Begründung: der Code ist offen, ein Angreifer weiß also, dass es die Funktion gibt; niemand kann beweisen, dass es keinen weiteren Bereich gibt, und der Druck steigt auf alle, auch auf die, die nichts versteckt haben; ein löschendes Duress-Passwort wird umgangen, indem zuerst kopiert und dann gefragt wird. Das wäre Schein-Schutz.
- Der stille Alarm des Notfall-Knopfs ist etwas anderes und bleibt: er gibt keinen falschen Tresor vor.

### E11. Bedrohungsmodell
1. **Wirkt gegen** ein ausgeschaltetes oder gesperrtes beschlagnahmtes Gerät und gegen ein **später** erzwungenes Passwort: Vergessenes ist nicht mehr lesbar, auch nicht in alten SSD-Blöcken, **sofern ein Hardware-Anker rotiert wurde** (forensisch nicht geprüft, E4).
2. **Ohne Hardware-Anker:** alte verpackte Schlüssel können auf der SSD überleben; mit erzwungenem Passwort und Forensik sind alte Reste lesbar.
3. **Wirkt nicht gegen** ein entsperrtes oder laufend übernommenes Gerät: der Angreifer sieht alles, was noch nicht abgelaufen ist, und kann ab dann mitlesen.
4. **Wirkt nicht gegen** ein erzwungenes Passwort für das, was **noch nicht** vergessen ist.
5. **Wirkt nicht gegen Kopien bei anderen:** Empfänger, Gruppenmitglieder, deren Sicherungen, Bildschirmfotos (ADR 0102 E8), fremde Server (Mail, Matrix-Homeserver).
6. **Server-Betreiber:** liest nur Chiffrat (ADR 0067 §2), sieht aber Metadaten (wer wann wie viel); unsere Server löschen sie nach Frist, seine eigenen Logs erreichen wir nicht.
7. **Sicherungen** behalten bewusst; wer das Sicherungsziel und dessen Schlüssel hat, liest alles bis zur Sicherungsfrist. Swap, Ruhezustand und Zwischenablage des Betriebssystems liegen außerhalb unserer Hand.

## Verhältnis zu bestehenden ADRs: Widersprüche W1–W7
| # | Stelle | Auflösung |
|---|---|---|
| W1 | ADR 0024 Z. 6 „wahlweise verschlüsselt“; ADR 0090 Z. 33 „Schlüssel entstehen nur, wenn die Person die Verschlüsselung einschaltet“ gegen ADR 0067 Z. 25 „immer verschlüsselt“ | **aufgelöst:** 0067 gilt (E2); Nachträge in 0024 und 0090. Die Wahl betrifft nur den Ort des Schlüssels. |
| W2 | ADR 0073 Z. 44 „keine automatische Kürzung und kein Standardwert“ | **aufgelöst:** Kürzung nur mit gesetzter Frist; Inhalte bleiben ohne Frist (E5, E9); Nachtrag in 0073. |
| W3 | Checkliste `FEATURES-OFFEN.md` (Zeile „Aufbewahrungsregeln (optional, Voreinstellung aus …)“) | **aufgelöst in der Sache** wie W2: „Voreinstellung aus“ gilt für Inhalte. Die Checkliste pflegt der Koordinator (kein ADR-Text). |
| W4 | ADR 0067 §2 (MLS) gegen „Gespräche abstreitbar“ (Nutzer 18.11.) | **aufgelöst als Regel des Geräts** (E8: prüfen, nicht speichern; „Beweis sichern“ auf Wunsch). **Offen:** ob MLS mit Schlüsseln je Gruppe echte Abstreitbarkeit innerhalb der Gruppe ergibt (Forschung). |
| W5 | ADR 0073 §6 „jede Änderung ist signiert“ | **aufgelöst** wie W4 (E8); ob heute Signaturen gespeichert werden, ist **[nicht belegt]**, es gibt noch keinen Code. |
| W6 | ADR 0071 Z. 11/21: Files speichert unter echten Namen, Versionen unter `.fs-files/versions/`, im Klartext außerhalb der DB | **aufgelöst und bestätigt (Strategie 23.11.2026) für die eigene Ablage:** Inhalte und Versionen mit Abschnittsschlüssel (E3); Nachtrag in 0071. Andere Programme sehen diese Dateien nicht mehr direkt im Dateisystem; das deckt der Grundsatz „Speichern = Datenbank, nur Export macht Dateien“. Der Weg nach außen ist der **Export** (E3a). **Bleibt offen gesagt:** Dateien in normalen Ordnern der Person (Home) verschlüsselt Files nicht. |
| W7 | Notfall-Täuschungs-Code gegen „kein Duress“ | **kein Widerspruch:** stiller Alarm, kein falscher Tresor (E10). |

## Folgen
- Bauwellen (Kürzel VG): VG-1 fs-objects (Mangel aus E10, `KeyProvider::rotate`/`lock`, Lauf nach `retention_class`, Konformitätstest, Messung) erst nach dem fs-objects-Tag der laufenden Pin-Welle; VG-2 neues Repo `fs-vault` (Schlüsselbaum, `keyring-core`, Hardware-Anker als Adapter, Fristen-Plan, Lauf, Schnellsperre); VG-3 Vertrag `vault`/`forget` und `retention_class` in der Typbeschreibung; VG-4 Fristen in fs-settings; VG-5 Form `retention-overview` und Toast; VG-6 Files-Ablage und Versionen verschlüsselt; VG-7 Messenger (E8, alte Epochenschlüssel). Hilfe-Kapitel und Texte der Erklärung als eigener Doku-Auftrag (VG-0h).
- Alles mit Schlüsseln ist **Sicherheitsmodul**: voller Test und Opus-Review vor dem Release.
- Crates (crates.io, 23.11.): `zeroize`, `secrecy`, `region` (mlock), `argon2`, `hkdf`, `age` (Blobs), `keyring-core` mit `windows-native-keyring-store`, `apple-native-keyring-store`, `zbus-secret-service-keyring-store`; `tss-esapi` nur hinter optionalem Adapter. Wartung und Audits sind nicht nachgelesen.

## Offen
1. **Leistung des Laufs** (Neuschreiben einer Moduldatei, O(Dateigröße)) ist nicht gemessen; Messung mit 100 MB in VG-1.
2. **Neuer Schlüssel beim Neuschreiben:** ob `VACUUM INTO` oder `ATTACH` in Turso einen anderen Schlüssel erlaubt, ist nicht belegt; sonst Export/Import. Ob Turso den Schlüssel als Bytes statt als Hex-Text annimmt, ist nicht belegt (Upstream-Frage).
3. **Hardware-Anker:** TPM unter Windows (NCrypt) und Secure Enclave unter Apple nicht geprüft; forensische Wirkung von `nv_undefine_space` nicht geprüft; ob `tss-esapi` die C-Bibliothek tpm2-tss bindet, nicht nachgelesen.
4. **Vorhandenes zuerst:** `esuiss-retention` 0.7.4 („retention classes, schedules, legal holds and the destroy decision“) und `pvlt-*` 0.3.0 (Schlüsselbaum, shred) vor jedem Eigenbau auf Passung und Erweiterbarkeit prüfen; Lizenzen nicht belegt.
5. **Franking:** kein Rust-Crate gefunden; asymmetrisches Franking bleibt Forschung.
6. **Grenze Kontakt/Verbindungsdaten** im Datenmodell (E5a, letzter Punkt): es gibt keinen Datentyp für Verbindungsdaten. **Karte für VG-3**; bis dahin wird nichts zugesagt, was diese Grenze voraussetzt.
7. **Abstreitbarkeit innerhalb einer MLS-Gruppe** (W4) als Forschungsauftrag.
8. Gestalt des Export-Wegs der Files-Ablage (E3a): Format, Ziel und Oberfläche entscheidet VG-3; dass es kein direktes Dateisystem-Sichtfenster gibt, ist entschieden.
9. Der Nadeltest in `purge.rs` ist eine Eigenaussage; der Konformitätstest (E9) muss ihn belegen.

---

**English summary.** Draft. Forgetting is owned by the vault (`fs-vault`): key tree, deadline plan, the forgetting run and quick lock. The storage layer (fs-objects) executes; every module only declares a `retention_class` per data type; deadlines live in fs-settings. The database file is always encrypted (ADR 0067 holds; 0024 and 0090 are aligned); by default the key sits in the OS keyring, with passphrase or hardware key as options, and the setup says once that the default protects only as well as the OS login. No per-period keys inside the live database: a run deletes expired rows, writes a new file under a new key (Turso 0.8.3 has no rekey), swaps it and destroys the old key; deletion runs daily (logically gone), the key run (rewrite with a new key) weekly by default and configurable; between the two, someone holding both file and key can still recover deleted rows, and this is stated. Per-period keys only for file contents, versions and server copies. A TPM/Secure Enclave anchor is the one erasable place; without it old keys may survive on the SSD. Defaults on first start: connection data 7 days, locations 7 days, activity 30 days, trash and drafts 30 days, messages off (setup suggests 1 year), documents/images/tasks/events off; contracts, bookings, secured evidence, emergency data, contacts and birthdays are never forgotten automatically. A contact stays; only connection data about the contact is forgotten; where that line sits in today's data model is open. Everything is configurable, forgetting can be switched off entirely, backup is allowed and counts as deliberate keeping; one overview, one toast 7 days before content expires, one explanation when switching off, extending or adding a backup target, and a help chapter. Groups set deadlines for their own data; no admin locks a person's deadlines. Conversation signatures are verified but not stored; "secure evidence" on the recipient's request; MLS signs every message and this is stated. All derived data is forgotten too, with a conformance test per storage driver. No duress password, no hidden volumes; quick lock with zeroized keys; the current fs-objects key handling is a known defect. ADR 0073 §7 changes: automatic trimming only when a deadline is set.
