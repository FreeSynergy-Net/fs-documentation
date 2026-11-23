# 0090 – Einzelplatz-Modus: Besitzer ohne Konto

Status: Entwurf (Strategie, 2026-11-16; Nutzerentscheidung 16.11.: „ja“) · baut auf ADR 0019, 0024, 0047, 0052, 0056, 0058, 0070, 0082, 0085 · berührt 0054 (Nachtrag 16.11., KI-Helfer), 0082 (Nachtrag 16.11., KI-Regel) und 0079 (Server einrichten)

## Kontext
Wer ein Programm allein auf seinem Rechner installiert, soll sofort arbeiten können: ohne Konto, ohne Kanidm, ohne Einrichtung. Die Person ist dann Besitzerin und Admin ihrer eigenen Daten. Erst wenn jemand anderes dazukommen soll (teilen, Server, Gruppe), wird eingerichtet.

Bisher setzen Rechte eine Identität voraus: Anmeldung und Rechte liegen in `fs-identity` und Kanidm (ADR 0047, 0058). Ohne eine Festlegung müsste der Einzelplatz später umgebaut werden. Dieser ADR legt fest, dass allein dasselbe Rechtemodell gilt wie im Mehrbenutzerbetrieb. Begriff: **Einzelplatz = `tenancy = single` mit impliziter Gruppe „Instanz“ und festem Mandanten** (pilot-access PLAN Z.79, F14: Wechsel ohne Datenumbau Pflicht). Nicht zu verwechseln mit „Modus allein“ im PLAN (Z.34/82), das einen Fremd-IdP mit Claims als Quelle meint.

## Verhältnis zu bestehenden Entscheidungen
Geprüft am 2026-11-16 gegen den Stand von `origin/main` sowie gegen die Nachträge.

- **Widerspruch: nein.** Kein Punkt dieses ADR hebt eine bestehende Entscheidung auf.
- **0024** („Jedes Programm kann OAuth2, SSO und SCIM von Haus aus“): kein Widerspruch. 0024 Entscheidung 1 verlangt ohnehin lokales Speichern ohne Hub, und 0047 (Umsetzung) sagt, dass Programme ohne Kanidm weiterlaufen. Einschränkungen: SCIM ist nach 0047 „vorerst nicht“ (entgegen 0024), und laut 0082 (Bestand) hat heute kein Programm eine OIDC-Anbindung. Dieser ADR behauptet daher nicht, dass die Schnittstelle vorhanden ist; sie ist Ziel und noch nicht gebaut.
- **0047** (Kanidm hinter eigenem Wrapper): kein Widerspruch. Kanidm wird im Einzelplatz nicht angesprochen und erst mit „Teilen einrichten“ angebunden.
- **0052 und 0056** (eine Person mit Rollen; der Admin, der installiert, ist der oberste Admin; Rechte nur durch den Admin): kein Widerspruch. Die lokale Person ist genau dieser installierende oberste Admin. Nach 0056 Punkt 8 stehen in Kanidm nur Menschen mit Rechten; im Einzelplatz steht dort niemand.
- **0054** (KI als markierte Teilnehmer; Notaus Punkt 5; Nachtrag 16.11.: Einladung, STOP-KI-Knopf, Zustimmung aller) und **0056 Punkt 6** (ein Agent wird nie Admin): kein Widerspruch. Die Besitzerin ist ein Mensch. Im Einzelplatz erhält keine KI Rechte.
- **0058** (Kontakte sind Profile; Schlüssel, Rechte und Anmeldung gehören zur Identität): Hinweis, kein Widerspruch. Die Person in `fs-people` ist das Profil. Rechte und Anmeldung liegen in `fs-identity`. Der Einzelplatz braucht daher eine lokale Identität ohne Kanidm-Bindung in `fs-identity`.
- **0082 Entscheidung 6** (Zuordnung Person zu einem Kanidm-Konto liegt in `fs-identity`, nicht in `fs-people`): Festlegung für den Workflow „Teilen einrichten“. Die ID-Zuordnung gehört zu `fs-identity`.
- **0082 Entscheidung 5** (Gate `human`; kein Agent und keine KI auf dem Server): gilt unverändert für „Teilen einrichten“.
- **0085** (`PersonRef`): Die Besitzerin wird als `PersonRef` mit `art = Person` geführt. Der Begriff „Ich-Karte“ kommt in den ADRs nicht vor; geplant ist er in `fs-people` (`consent.rs:63`, `asker()`; `todo/features/bewertung.md` O11). Dieser ADR nennt die Person „lokale Besitzerin“ und legt die Ich-Karte nicht fest.
- **0070 Punkt 1** (jeder Aufruf trägt die Identität; der Besitzer prüft; nie mit Dienstrechten alles zeigen): gilt auch allein. Die lokale Identität wird geprüft, nicht umgangen.
- **0087** (generische Programmnamen): keine Umbenennung nötig. „Einzelplatz“ ist ein Modus, „Teilen einrichten“ ein Workflow, kein Programm.

## Entscheidung
1. **Die lokale Person ist Besitzerin.** Wer ein Programm allein installiert, ist automatisch Besitzerin bzw. Admin seiner eigenen Daten. Sie ist eine Person in `fs-people`, verwiesen über `PersonRef` (ADR 0085, `art = Person`), ohne Abzug. Ist `fs-people` nicht installiert, gilt die kleine lokale Ablage im selben Format nach 0085 (Abschnitt „Ohne installiertes People“), damit der Verweis gültig bleibt.
2. **Kein Konto, kein Kanidm, keine Einrichtung.** Die Installation fragt keine Anmeldung ab. Das Programm läuft ohne Server, ohne Kanidm und ohne Hub-Dienst (0019, 0024).
3. **Dasselbe Rechtemodell.** Intern gilt das Modell des Mehrbenutzerbetriebs: Besitzer ist die lokale Person, und die Rechteprüfung läuft wie sonst (0070 Punkt 1). Es gibt keinen zweiten Pfad ohne Prüfung. Dadurch muss beim Teilen nichts umgebaut werden.
4. **Lokale Identität ohne Konto.** `fs-identity` führt eine lokale Identität ohne Bindung an Kanidm. Sie trägt die Rechte der Besitzerin. Die Installation verlangt kein Passwort. Die Bindung ist der **Betriebssystem-Benutzer**:
   - Besitzerin = OS-Benutzer (uid), der installiert hat. Gleiche uid = Besitzerin.
   - Datenordner 0700, Dateien 0600 (Muster 0069, atomares Schreiben mit Rechten 0600).
   - Der lokale Socket (Unix-Socket) ist nur für den Besitzer zugänglich; der Dienst prüft die Gegenstelle per Peer-Credentials (`SO_PEERCRED`) und lehnt andere uids ab. Dadurch ist „andere Person abgelehnt“ prüfbar.
   - Grenze: Schutz gegen eigene Prozesse derselben uid gibt es nicht; nach 0082 (Z.57) kann jeder Prozess des Nutzers jeden Namen beanspruchen. 0063 regelt nur argv0-Symlinks und stiftet keine Identität. Schlüssel entstehen nur, wenn die Person die Verschlüsselung einschaltet (0024).
5. **Keine Kanidm-Pflicht.** Im Einzelplatz wird Kanidm nicht angesprochen (0047).
6. **Schnittstellen inaktiv.** Die OAuth2- und SSO-Schnittstelle (0024) ist Ziel, aber im Einzelplatz nicht aktiv. Davon getrennt: das SCIM von Kanidm wird nicht genutzt (0047, „vorerst nicht“). Ebenfalls getrennt: die eigene SCIM- und OAuth-Schnittstelle je Programm (`fs-access`, pilot-access PLAN §1) ist im Einzelplatz inaktiv. Aktiviert wird sie erst durch „Teilen einrichten“.
7. **Workflow „Teilen einrichten“.** Er startet, wenn jemand anderes dazukommen soll. Schritte:
   a. Server oder Kanidm verbinden, über `fs-server` (0082). Gate `human`; vorher ein Trockenlauf, der den Plan zeigt.
   b. Die lokale Person einem Kanidm-Konto zuordnen. Die Zuordnung liegt in `fs-identity` (0082 Entscheidung 6). Sie gilt nur nach **Nachweis durch Anmeldung an genau diesem Konto**; ein Treffer über Name oder E-Mail genügt nie (sonst Übernahme fremder Daten). Bestätigung durch den Menschen, ohne Datenverlust.
   c. Keine Rechteausweitung: Der lokale Admin wird dadurch **nicht** automatisch Admin auf dem Server oder in einer Gruppe. 0056 Punkt 1 gilt für den, der den Server installiert; alles andere vergibt ein Admin (0056).
   d. Die Daten des Einzelplatzes bleiben bei der Besitzerin. Teilen ist eine Freigabe je Objekt durch die Besitzerin. Wird dabei etwas an einen anderen Ort übernommen, gilt 0080 (Datenregel): **kopieren, nie verschieben**; der alte Stand bleibt lesbar.
   e. Jeder Schritt wird protokolliert (0079 Entscheidung 4).
   f. **Rückweg** („Teilen beenden“ oder Austritt): Die Daten bleiben lokal bei der Besitzerin. Die Zuordnung zum Kanidm-Konto wird gelöst; was schon geteilt oder kopiert wurde, bleibt als Kopie bei den Empfängern. Der Einzelplatz läuft danach wieder ohne Konto. Einzelheiten sind offen (siehe Offen).
8. **Daten bleiben beim Besitzer.** Der Einzelplatz speichert lokal bei der Besitzerin (0019, 0024). Der Wechsel in den geteilten Betrieb verschiebt keine Daten an einen fremden Ort.
9. **KI-Regel unverändert.** „KI-Konten nur in eigenen KI-Gruppen“ steht im Nachtrag 16.11. zu 0082 (0082:108). Einladung, STOP-KI-Knopf (erscheint nur bei anwesender KI, für jeden anwesenden Menschen drückbar), Zustimmung aller und Vorwarnung Spätkommender stehen im Nachtrag 16.11. zu 0054 (cc8fb376, b97c77b6). 0054 Punkt 6 gilt „auch auf dem eigenen Gerät“ und damit im Einzelplatz. Der Notaus (0054 Punkt 5, Einstellung der Berechtigungen) ist davon getrennt und wird nicht mit dem STOP-KI-Knopf vermischt. Ein Agent wird im Einzelplatz nie Admin (0056 Punkt 6).
10. **Grundregel Meldungen.** Fehlt eine Datenquelle oder ein Recht, wird das sichtbar gemeldet, nie still ausgegraut. Beispiel: „Teilen ist nicht eingerichtet; Workflow „Teilen einrichten“ starten.“

## Folgen
- **Tests:** Ein Programm startet und arbeitet ohne Konto, ohne Server, ohne Hub-Dienst und ohne Kanidm. Der Test läuft in einem temporären Benutzerverzeichnis (Temp-HOME, keine echten Nutzerdaten). Er prüft Anlegen, Lesen, Ändern und Löschen eigener Daten. Zugriff durch eine andere, nicht eingetragene Person wird abgelehnt, auch allein.
- **Konformitätstest je Programm „Einzelplatz“** in der gemeinsamen Konformitätssammlung (Muster ADR 0084).
- **Workflow „Teilen einrichten“** nach den Workflow-Regeln; die Umsetzung folgt nach der Freigabe dieses ADR.
- **Doku:** Die Programmseiten beschreiben den Einzelplatz nur als Entwurf, bis der ADR akzeptiert ist.
- **Keine Änderung** am Rechtemodell, an Kanidm oder an der Typbeschreibung.

## Offen
- Rückweg/Austritt im Einzelnen: Daten zurück auf den Einzelplatz, Umgang mit bereits geteilten Kopien, Widerruf der Zuordnung.
- Mehrere OS-Benutzer auf einem Rechner: getrennte Einzelplätze oder gemeinsame Instanz? (getrennt von „Familie“ unten)
- Datenmigration beim Wechsel vom Einzelplatz in den geteilten Betrieb (Ablage, IDs, Protokoll).
- Mehrere lokale Personen auf einem Rechner (Familie)? Braucht es dafür ein lokales Konto? [offen]
- Geräte-Sync ohne Server (ADR 0059: Richtung akzeptiert, nichts gebaut).
- Verschlüsselung der lokalen Daten; der Schlüsseltresor (ADR 0067) ist noch nicht gebaut.
- Wiederherstellung, wenn das Gerät verloren geht. Ohne Konto gibt es keinen Anmeldeweg; Sicherung nach ADR 0071.
- Admin-Übergabe beim Teilen: ADR 0056 Punkt 1 nennt den Installierenden als obersten Admin; wie der Wechsel aussieht, ist offen.

## Nachtrag 2026-11-23 (ADR 0108, Entwurf): Schlüssel von Anfang an
- **E4, letzter Satz** („Schlüssel entstehen nur, wenn die Person die Verschlüsselung einschaltet (0024)“; Widerspruch W1) gilt nicht mehr: der Dateischlüssel entsteht bei der Installation, die Datenbankdatei ist immer verschlüsselt (ADR 0067 Z. 25, ADR 0108 E2). Er liegt per Voreinstellung im Schlüsselbund des Betriebssystems; deshalb bleibt „Die Installation verlangt kein Passwort“ (E4) gültig.
- **Offen „Verschlüsselung der lokalen Daten“** ist in der Richtung entschieden (ADR 0108); gebaut wird sie mit `fs-vault` (ADR 0108 Folgen).
