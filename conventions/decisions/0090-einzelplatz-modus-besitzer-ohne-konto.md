# 0090 – Einzelplatz-Modus: Besitzer ohne Konto

Status: Entwurf (Strategie, 2026-11-16; Nutzerentscheidung 16.11.: „ja“) · baut auf ADR 0019, 0024, 0047, 0052, 0056, 0058, 0070, 0082, 0085 · berührt 0054 (KI-Regel) und 0079 (Server einrichten)

## Kontext
Wer ein Programm allein auf seinem Rechner installiert, soll sofort arbeiten können: ohne Konto, ohne Kanidm, ohne Einrichtung. Die Person ist dann Besitzerin und Admin ihrer eigenen Daten. Erst wenn jemand anderes dazukommen soll (teilen, Server, Gruppe), wird eingerichtet.

Bisher setzen Rechte eine Identität voraus: Anmeldung und Rechte liegen in `fs-identity` und Kanidm (ADR 0047, 0058). Ohne eine Festlegung müsste der Einzelplatz später umgebaut werden. Dieser ADR legt fest, dass allein dasselbe Rechtemodell gilt wie im Mehrbenutzerbetrieb.

## Verhältnis zu bestehenden Entscheidungen
Geprüft am 2026-11-16 gegen den Stand von `origin/main` sowie gegen die Nachträge.

- **Widerspruch: nein.** Kein Punkt dieses ADR hebt eine bestehende Entscheidung auf.
- **0024** („Jedes Programm kann OAuth2, SSO und SCIM von Haus aus“): kein Widerspruch. 0024 Entscheidung 1 verlangt ohnehin lokales Speichern ohne Hub, und 0047 (Umsetzung) sagt, dass Programme ohne Kanidm weiterlaufen. Einschränkungen: SCIM ist nach 0047 „vorerst nicht“ (entgegen 0024), und laut 0082 (Bestand) hat heute kein Programm eine OIDC-Anbindung. Dieser ADR behauptet daher nicht, dass die Schnittstelle vorhanden ist; sie ist Ziel und noch nicht gebaut.
- **0047** (Kanidm hinter eigenem Wrapper): kein Widerspruch. Kanidm wird im Einzelplatz nicht angesprochen und erst mit „Teilen einrichten“ angebunden.
- **0052 und 0056** (eine Person mit Rollen; der Admin, der installiert, ist der oberste Admin; Rechte nur durch den Admin): kein Widerspruch. Die lokale Person ist genau dieser installierende oberste Admin. Nach 0056 Punkt 8 stehen in Kanidm nur Menschen mit Rechten; im Einzelplatz steht dort niemand.
- **0054** (KI als markierte Teilnehmer, Notaus) und **0056 Punkt 6** (ein Agent wird nie Admin): kein Widerspruch. Die Besitzerin ist ein Mensch. Im Einzelplatz erhält keine KI Rechte.
- **0058** (Kontakte sind Profile; Schlüssel, Rechte und Anmeldung gehören zur Identität): Hinweis, kein Widerspruch. Die Person in `fs-people` ist das Profil. Rechte und Anmeldung liegen in `fs-identity`. Der Einzelplatz braucht daher eine lokale Identität ohne Kanidm-Bindung in `fs-identity`.
- **0082 Entscheidung 6** (Zuordnung Person zu einem Kanidm-Konto liegt in `fs-identity`, nicht in `fs-people`): Festlegung für den Workflow „Teilen einrichten“. Die ID-Zuordnung gehört zu `fs-identity`.
- **0082 Entscheidung 5** (Gate `human`; kein Agent und keine KI auf dem Server): gilt unverändert für „Teilen einrichten“.
- **0085** (`PersonRef`): Die Besitzerin wird als `PersonRef` mit `art = Person` geführt. Der Begriff „Ich-Karte“ kommt in den ADRs nicht vor **[nicht belegt]**; dieser ADR nennt die Person „lokale Besitzerin“.
- **0070 Punkt 1** (jeder Aufruf trägt die Identität; der Besitzer prüft; nie mit Dienstrechten alles zeigen): gilt auch allein. Die lokale Identität wird geprüft, nicht umgangen.
- **0087** (generische Programmnamen): keine Umbenennung nötig. „Einzelplatz“ ist ein Modus, „Teilen einrichten“ ein Workflow, kein Programm.

## Entscheidung
1. **Die lokale Person ist Besitzerin.** Wer ein Programm allein installiert, ist automatisch Besitzerin bzw. Admin seiner eigenen Daten. Sie ist eine Person in `fs-people`, verwiesen über `PersonRef` (ADR 0085, `art = Person`), ohne Abzug.
2. **Kein Konto, kein Kanidm, keine Einrichtung.** Die Installation fragt keine Anmeldung ab. Das Programm läuft ohne Server, ohne Kanidm und ohne Hub-Dienst (0019, 0024).
3. **Dasselbe Rechtemodell.** Intern gilt das Modell des Mehrbenutzerbetriebs: Besitzer ist die lokale Person, und die Rechteprüfung läuft wie sonst (0070 Punkt 1). Es gibt keinen zweiten Pfad ohne Prüfung. Dadurch muss beim Teilen nichts umgebaut werden.
4. **Lokale Identität ohne Konto.** `fs-identity` führt eine lokale Identität ohne Bindung an Kanidm. Sie trägt die Rechte der Besitzerin. Die Installation verlangt kein Passwort. Schlüssel entstehen nur, wenn die Person die Verschlüsselung einschaltet (0024).
5. **Keine Kanidm-Pflicht.** Im Einzelplatz wird Kanidm nicht angesprochen (0047).
6. **Schnittstellen inaktiv.** Die OAuth2- und SSO-Schnittstelle (0024) ist Ziel, aber im Einzelplatz nicht aktiv. SCIM wird nicht genutzt (0047). Aktiviert wird beides erst durch „Teilen einrichten“.
7. **Workflow „Teilen einrichten“.** Er startet, wenn jemand anderes dazukommen soll. Schritte:
   a. Server oder Kanidm verbinden, über `fs-server` (0082). Gate `human`; vorher ein Trockenlauf, der den Plan zeigt.
   b. Die lokale Person einer Identität zuordnen. Die Zuordnung liegt in `fs-identity` (0082 Entscheidung 6). Vorschlag zeigen, Bestätigung durch den Menschen, ohne Datenverlust.
   c. Die Daten des Einzelplatzes bleiben bei der Besitzerin. Teilen ist eine Freigabe je Objekt durch die Besitzerin; es wird nichts kopiert.
   d. Jeder Schritt wird protokolliert (0079 Entscheidung 4).
8. **Daten bleiben beim Besitzer.** Der Einzelplatz speichert lokal bei der Besitzerin (0019, 0024). Der Wechsel in den geteilten Betrieb verschiebt keine Daten an einen fremden Ort.
9. **KI-Regel unverändert.** Es gilt ADR 0054 wortgleich: KI-Konten stehen nur in eigenen KI-Gruppen; eine eingeladene KI darf nichts ohne ausdrückliche Befugnis (0054, Nutzer 2026-11-07). Der Notaus „STOP KI“ ist die Einstellung der Berechtigungen (0054 Punkt 5). Er ist auch im Einzelplatz verfügbar. Ein Agent wird im Einzelplatz nie Admin (0056 Punkt 6).
10. **Grundregel Meldungen.** Fehlt eine Datenquelle oder ein Recht, wird das sichtbar gemeldet, nie still ausgegraut. Beispiel: „Teilen ist nicht eingerichtet; Workflow „Teilen einrichten“ starten.“

## Folgen
- **Tests:** Ein Programm startet und arbeitet ohne Konto, ohne Server, ohne Hub-Dienst und ohne Kanidm. Der Test läuft in einem temporären Benutzerverzeichnis (Temp-HOME, keine echten Nutzerdaten). Er prüft Anlegen, Lesen, Ändern und Löschen eigener Daten. Zugriff durch eine andere, nicht eingetragene Person wird abgelehnt, auch allein.
- **Konformitätstest je Programm „Einzelplatz“** in der gemeinsamen Konformitätssammlung (Muster ADR 0084).
- **Workflow „Teilen einrichten“** nach den Workflow-Regeln; die Umsetzung folgt nach der Freigabe dieses ADR.
- **Doku:** Die Programmseiten beschreiben den Einzelplatz nur als Entwurf, bis der ADR akzeptiert ist.
- **Keine Änderung** am Rechtemodell, an Kanidm oder an der Typbeschreibung.

## Offen
- Datenmigration beim Wechsel vom Einzelplatz in den geteilten Betrieb (Ablage, IDs, Protokoll).
- Mehrere lokale Personen auf einem Rechner (Familie)? Braucht es dafür ein lokales Konto? [offen]
- Geräte-Sync ohne Server (ADR 0059: Richtung akzeptiert, nichts gebaut).
- Verschlüsselung der lokalen Daten; der Schlüsseltresor (ADR 0067) ist noch nicht gebaut.
- Wiederherstellung, wenn das Gerät verloren geht. Ohne Konto gibt es keinen Anmeldeweg; Sicherung nach ADR 0071.
- Admin-Übergabe beim Teilen: ADR 0056 Punkt 1 nennt den Installierenden als obersten Admin; wie der Wechsel aussieht, ist offen.
