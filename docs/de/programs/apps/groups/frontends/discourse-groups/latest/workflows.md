# Discourse Groups - Arbeitsabläufe

> [Discourse Groups](../index.md)

## W1 Gruppe anlegen
- Ziel: eine neue Gruppe existiert.
- Voraussetzung: Admin, oder Moderator wenn `moderators_manage_groups` aktiv ist [S5].
- Schritte: Nutzer öffnet die Gruppenseite -> klickt "New Group" -> füllt Name, Besitzer, Mitglieder, Mitgliedschaft, Sichtbarkeit aus -> klickt "Create" [S5].
- Fehler: [offen].
- Rückgängig: [offen].

## W2 Gruppe unter einer Obergruppe verschachteln
- Ziel: [offen]. In S1-S5 nicht belegt.

## W3 Mitglied aufnehmen
- Ziel: ein Nutzer wird Mitglied.
- Voraussetzung: mindestens ein Besitzer, wenn Anfragen genutzt werden [S2, S4].
- Direkt hinzufügen: Besitzer fügt ein Mitglied hinzu -> Mitglied erscheint in der Liste [S1].
- Anfrage: Nutzer klickt "Request" -> Besitzer erhalten die Anfrage mit Annehmen- oder Ablehnen-Link -> Besitzer nimmt an [S2].
- Freier Beitritt: Nutzer klickt "Join" -> Nutzer ist Mitglied [S2].
- Fehler: Anfragen lassen sich ohne Besitzer nicht aktivieren [S4].
- Rückgängig: siehe W4.

## W4 Mitglied entfernen oder Austritt
- Besitzer entfernt ein Mitglied [S1].
- Admin entfernt ein Mitglied über den Schraubenschlüssel im Reiter Members [S2].
- Nutzer klickt "Leave", wenn die Gruppe freien Austritt erlaubt [S2].
- Fehler: [offen].
- Rückgängig: erneut aufnehmen über W3.

## W5 Einladen und annehmen oder ablehnen
- Admins und Besitzer können Nutzer einladen [S4]. Admins können beim Hinzufügen oder Einladen Besitzer benennen [S1].
- Annahme- oder Ablehnungsablauf für den eingeladenen Nutzer: [offen].
- Rückgängig: [offen].

## W6 Rolle ändern
- Ziel: ein Mitglied wird Besitzer, oder der Besitz wird entzogen.
- Voraussetzung: Admin; nur Admins ernennen Besitzer [S1].
- Schritte: Admin öffnet den Reiter Members -> Schraubenschlüssel neben dem Mitglied -> "Make Owner" [S1]. Admin kann den Besitz auch entziehen [S2].
- Ab Discourse 3.1 können Besitzer weitere Besitzer hinzufügen; entfernen können sie nur Mitarbeiter [S1].
- Fehler: [offen].
- Rückgängig: Admin entzieht den Besitz [S2].
- Details zu Moderator- und Mitgliedsrolle: [offen].

## W7 Gruppe löschen (und wiederherstellen)
- Ziel: [offen]. In S1-S5 nicht belegt.
