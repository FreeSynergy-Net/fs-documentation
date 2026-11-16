# Microsoft 365 Groups - Arbeitsabläufe

> [Microsoft 365 Groups](../index.md) · Arbeitsabläufe

## W1 Gruppe anlegen

- Ziel: neue Gruppe mit gemeinsamen Ressourcen [S1][S2].
- Voraussetzung: Nutzer mit Recht zum Anlegen (Admins können dies begrenzen) [S2].
- Schritte (Nutzer): öffnet die Gruppenseite -> Erstellen -> trägt Name, eindeutigen E-Mail-Alias, Beschreibung und optionale Einstellungen ein -> Erstellen [S1]. Das Programm macht den Ersteller zum Besitzer und Mitglied [S1].
- Schritte (Admin, Entra): Neue Gruppe -> Gruppentyp -> Name, E-Mail-Adresse, Beschreibung, Mitgliedschaftstyp, optionale Besitzer und Mitglieder -> Erstellen [S5].
- Fehler: Alias nicht eindeutig [S1]. Optionen fehlen wegen Admin-Richtlinie [S1]. Limit 250 Gruppen je Nutzer [S2].
- Rückgängig: löschen (W7) [S1].

## W2 Gruppe in eine andere Gruppe verschachteln

- Ziel: Gruppe wird Mitglied einer anderen Gruppe [S5].
- Microsoft-365-Gruppen können nicht in eine andere Microsoft-365-Gruppe oder in eine Sicherheitsgruppe aufgenommen werden [S5].
- Sicherheitsgruppe: Alle Gruppen -> Gruppe -> Gruppenmitgliedschaften -> Mitgliedschaften hinzufügen -> Gruppe wählen -> Auswählen [S5].
- Fehler: nicht unterstützte Kombinationen [S5].
- Rückgängig: Gruppenmitgliedschaften -> Entfernen [S5] (für Sicherheitsgruppen).

## W3 Mitglied hinzufügen

- Ziel: Person wird Mitglied [S1].
- Schritte (Besitzer): Gruppe öffnen -> (+) -> Person suchen -> hinzufügen [S1].
- Schritte (Admin-Center): Teams & Gruppen -> Aktive Teams & Gruppen -> Gruppe -> Mitgliedschaft -> Mitglieder -> Hinzufügen [S3].
- Schritte (Entra): Alle Gruppen -> Gruppe -> Mitglieder -> Hinzufügen, Namen wählen -> Auswählen [S5].
- Ergebnis: Person erhält eine Einladung [S1].
- Fehler: fehlende Admin-Rolle [S5]. Gruppen mit mehr als 1.000 Mitgliedern: Verzögerungen bei Gruppenunterhaltungen [S2].
- Rückgängig: entfernen (W4).

## W4 Mitglied entfernen oder austreten

- Ziel: Person wird entfernt [S3][S5].
- Schritte (Admin-Center): Mitgliedschaft -> Mitglieder -> X neben dem Namen -> Schließen [S3].
- Schritte (Entra): Mitglieder oder Besitzer -> Namen markieren -> Entfernen [S5].
- Schritte (Mitglied verlässt selbst): [offen].
- Fehler: Mitgliedschaft in aus lokalem Verzeichnis synchronisierten oder dynamischen Gruppen: [offen].
- Rückgängig: wieder hinzufügen (W3).

## W5 Einladen, annehmen oder ablehnen

- Ziel: Außenstehende Person tritt als Gast bei, oder Mitglied erhält Einladung [S1][S2].
- Schritte: Besitzer fügt eine Person hinzu (W3) -> Person erhält Einladung [S1].
- Mitglieder dürfen standardmäßig Gäste einladen; Admins können dies ändern [S2].
- Annehmen oder ablehnen: [offen].
- Einladung abbrechen oder erneut senden: [offen].
- Rückgängig: [offen].

## W6 Rolle ändern

- Ziel: Mitglied wird Besitzer oder umgekehrt [S5].
- Rollen: Besitzer verwalten Mitgliedschaft und Einstellungen; Mitglieder nutzen Ressourcen, ändern aber keine Einstellungen [S2][S3].
- Schritte: Admin-Center: Mitgliedschaft -> Besitzer oder Mitglieder wählen -> Hinzufügen oder X [S3]. Entra: Besitzer -> + Hinzufügen, oder Namen wählen -> Entfernen [S5].
- Grenze: 100 Besitzer je Gruppe [S2].
- Gruppentyp lässt sich nachträglich nicht ändern [S1].
- Fehler: Besitzergrenze erreicht [S2].
- Rückgängig: aus der Besitzerliste entfernen [S5].

## W7 Gruppe löschen und wiederherstellen

- Ziel: Gruppe entfernen [S1][S5].
- Schritte (Besitzer): Gruppe öffnen -> Gruppe löschen -> mit Ja bestätigen [S1].
- Schritte (Entra-Admin): Alle Gruppen -> Gruppe wählen -> Löschen [S5].
- Soft-Delete: 30 Tage aufbewahrt [S4].
- Wiederherstellen (Besitzer, in Outlook): Seite gelöschte Gruppen -> Reiter Wiederherstellen [S4].
- Wiederherstellen (Admin-Center): Gruppen -> Gelöschte Gruppen -> Gruppe wählen -> Gruppe wiederherstellen [S4].
- Wiederherstellen (PowerShell): siehe Entra-Artikel [S4].
- Endgültiges Löschen vor Ablauf der 30 Tage (PowerShell): [S3].
- Fehler: nach 30 Tagen nicht wiederherstellbar [S4]. Nach Wiederherstellung kann Mail eine Stunde lang fehlschlagen [S4]. Die Besitzer-Hilfe nennt das Löschen endgültig [S1], was der 30-Tage-Wiederherstellung [S4] widerspricht; Auflösung: [offen].
- Rückgängig: Wiederherstellung innerhalb von 30 Tagen [S4].
