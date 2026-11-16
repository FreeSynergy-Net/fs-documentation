# Matrix Spaces - Arbeitsabläufe

> [Matrix Spaces](../index.md)

Feste IDs W1 bis W7. Schritte als "Nutzer tut X -> Programm zeigt Y".

## W1 Gruppe (Space) anlegen

- Ziel: ein neuer Space, der Räume und Personen gruppiert.
- Voraussetzung: [offen] (Kontorechte, Serverregeln).
- Schritte: Nutzer klickt auf "+ Create a space" (Web/Desktop) [S3] -> Nutzer wählt öffentlich oder privat [S3] -> Programm legt den Space an [S3].
- Mobil: Nutzer tippt auf das Space-Symbol und wählt "create" [S3].
- Fehler: [offen]. Rückgängig: [offen].

## W2 Gruppe einer Obergruppe zuordnen (Space im Space oder Raum im Space)

- Ziel: Räume oder Spaces einem übergeordneten Space zuordnen.
- Voraussetzung: [offen].
- Schritte: Nutzer fügt im Space einen bestehenden Raum hinzu oder legt einen neuen an [S3] -> Programm verknüpft ihn [offen]; Verknüpfungsereignisse `m.space.child` / `m.space.parent` [S1].
- Space im Space: [offen].
- Fehler und Rückgängig: [offen].

## W3 Mitglied direkt aufnehmen

- Ziel: eine Person ohne Einladungsschritt in einen Space aufnehmen.
- Voraussetzung: [offen].
- Schritte: Nutzer lädt Personen in den Space ein [S3] -> genaue Schritte für direktes Hinzufügen: [offen].
- Fehler und Rückgängig: [offen].

## W4 Mitglied entfernen oder Austritt

- Ziel: ein Mitglied wird entfernt oder verlässt den Space.
- Voraussetzung: [offen].
- Schritte: [offen] (Verlassen eines Space ist auf den abgerufenen Element-Seiten nicht beschrieben).
- Fehler und Rückgängig: [offen].

## W5 Einladen, annehmen oder ablehnen

- Ziel: eine Person einladen, die annimmt oder ablehnt.
- Voraussetzung: [offen].
- Schritte: Nutzer lädt Personen in den Space ein [S3] -> Oberfläche für Annahme und Ablehnung: [offen].
- Zugangsregel für Räume: "Space members" oder "Private (invite only)" [S2].
- Fehler und Rückgängig: [offen].

## W6 Rolle ändern

- Ziel: Rolle eines Mitglieds im Space ändern.
- Voraussetzung: [offen].
- Schritte: [offen] (Rollen und Rechte nicht durch abgerufene Quellen belegt [S3]).
- Fehler und Rückgängig: [offen].

## W7 Gruppe löschen (und wiederherstellen)

- Ziel: Space entfernen; wiederherstellen, falls unterstützt.
- Voraussetzung: [offen].
- Schritte: [offen].
- Fehler und Rückgängig: [offen].

## Quellen

| Kennung | Quelle (URL) | Art | Abgerufen |
|---|---|---|---|
| S1 | https://spec.matrix.org/v1.19/client-server-api/ | Spezifikation (Inhaltsverzeichnis) | 2026-11-16 |
| S2 | https://element.io/help | Hilfeseite (Element) | 2026-11-16 |
| S3 | https://docs.element.io/latest/element-support/quick-start-guide/the-left-panel/ | Benutzerdokumentation | 2026-11-16 |
| S4 | https://docs.element.io/latest/element-support/matrix-rooms/getting-started-creating-a-room/ | Benutzerdokumentation | 2026-11-16 |
