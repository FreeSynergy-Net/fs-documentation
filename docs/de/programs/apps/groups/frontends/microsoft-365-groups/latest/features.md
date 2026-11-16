# Microsoft 365 Groups - Funktionen

> [Microsoft 365 Groups](../index.md) · Funktionen

## Anlegen und Bearbeiten

- Anlegen mit Name, eindeutigem E-Mail-Alias, optionaler Beschreibung, optionaler Vertraulichkeitsbezeichnung, öffentlich oder privat, Willkommens-Mails, Sendeberechtigung und externen Absendern [S1].
- Name und Beschreibung bearbeiten [S1][S3].
- E-Mail-Adresse ändern (Admin-Center oder PowerShell) [S3].

## Mitgliedschaft

- Besitzer fügen Mitglieder und Besitzer hinzu und entfernen sie [S2][S3][S5].
- Beim Hinzufügen erhält die Person eine Einladung [S1].
- Mitglieder dürfen standardmäßig Gäste einladen; Admins können dies ändern [S2].
- Gäste sind Personen von außerhalb, die mitarbeiten sollen [S2][S6].
- Dynamische Mitgliedschaftsregeln fügen Mitglieder anhand von Attributen hinzu oder entfernen sie [S7].

## Steuerung

- Ablaufrichtlinie mit Erinnerungen vor der Verlängerung [S2].
- Vertraulichkeitsbezeichnungen legen Sichtbarkeit, Gastzugriff und Zugriff von nicht verwalteten Geräten fest [S2].
- Audit-Protokolle erfassen, wer eine Gruppe angelegt oder gelöscht hat und wer die Mitgliedschaft geändert hat [S7].
- Einstellungen: Kopien von Unterhaltungen in Postfächer der Mitglieder senden; externen Absendern erlauben, die Gruppe anzuschreiben [S3].

## Verschachtelung

- Sicherheitsgruppen können verschachtelt werden [S5].
- Microsoft-365-Gruppen können nicht in Sicherheitsgruppen oder andere Microsoft-365-Gruppen aufgenommen werden [S5].

## Löschen

- Gruppe löschen (Besitzer, in Entra durch Admin) [S1][S5].
- Wiederherstellung innerhalb von 30 Tagen (siehe W7) [S4].
- Endgültiges Entfernen per PowerShell vor Ablauf der 30 Tage [S3].
- Wiederhergestellt werden Mitglieder, E-Mail-Adressen, Gruppenpostfach und Kalender, SharePoint-Seite, OneNote, Planner und Teams [S4].
