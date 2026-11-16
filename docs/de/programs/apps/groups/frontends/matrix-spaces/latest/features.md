# Matrix Spaces - Funktionen

> [Matrix Spaces](../index.md)

## Gruppierung

- Spaces gruppieren Räume und Personen; die linke Leiste filtert auf den gewählten Space [S3].
- Räume werden über `m.space.child` / `m.space.parent` verknüpft [S1].
- Der Hierarchie-Endpunkt (`GET /_matrix/client/v1/rooms/{roomId}/hierarchy`) steht im Inhaltsverzeichnis der Spezifikation [S1]; sein Verhalten: [offen].

## Zugang

- Räume können beim Anlegen auf Space-Mitglieder beschränkt werden [S2].
- Beitritt ohne Einladung: Die frühere Historie eines verschlüsselten Raums wird der Person nicht angezeigt [S2].

## Nicht durch abgerufene Quellen belegt

- Verschachtelte Spaces (Space in Space) in der Oberfläche: [offen].
- Reihenfolge der Kinder in einem Space: [offen] (nur im Inhaltsverzeichnis der Spezifikation genannt [S1]).
- Vorgeschlagene Räume und Hauptraum: [offen].
- Space verlassen: [offen].
- Space löschen: [offen].

## Quellen

| Kennung | Quelle (URL) | Art | Abgerufen |
|---|---|---|---|
| S1 | https://spec.matrix.org/v1.19/client-server-api/ | Spezifikation (Inhaltsverzeichnis) | 2026-11-16 |
| S2 | https://element.io/help | Hilfeseite (Element) | 2026-11-16 |
| S3 | https://docs.element.io/latest/element-support/quick-start-guide/the-left-panel/ | Benutzerdokumentation | 2026-11-16 |
