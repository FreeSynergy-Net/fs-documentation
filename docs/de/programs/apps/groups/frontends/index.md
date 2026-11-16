# Gruppen — Frontends

Frontends bekannter Programme für Gruppen, analysiert nach ihren **Funktionen** — nichts wird kopiert (ADR 0013). Jeder Eintrag stützt sich auf die offizielle Hilfe des Herstellers, abgerufen am 2026-11-16; was die Hilfe nicht zeigt, steht als `[offen]` (kein belegtes Vorbild). Unser eigenes Programm dieser Kategorie ist `fs-groups`; sein Stand steht auf der [Programmseite](../index.md).

## Programme

| Programm | Versionen | Was es ist |
|----------|-----------|------------|
| [Google Groups](google-groups/index.md) | [latest](google-groups/latest/description.md) | Google Groups: Verteilergruppen und gemeinsame Gruppen in Google Workspace und Google-Konten. |
| [Microsoft 365 Gruppen](microsoft-365-groups/index.md) | [latest](microsoft-365-groups/latest/description.md) | Microsoft 365 Gruppen: eine Gruppe für Mitglieder, Post, Dateien und Kalender in Microsoft 365, mit Besitzern und Mitgliedern. |
| [Nextcloud Circles](nextcloud-circles/index.md) | [latest](nextcloud-circles/latest/description.md) | Nextcloud Circles: Gruppen aus Personen und Kreisen innerhalb einer Nextcloud-Instanz, mit Mitgliedschaftsstufen. |
| [Matrix Spaces](matrix-spaces/index.md) | [latest](matrix-spaces/latest/description.md) | Matrix Spaces: Räume, die Räume enthalten, damit eine Gemeinschaft ihre Kanäle verschachteln kann. |
| [Discourse-Gruppen](discourse-groups/index.md) | [latest](discourse-groups/latest/description.md) | Discourse-Gruppen: Benutzergruppen im Forum Discourse, mit Besitzern, Moderatoren und Beitrittsanfragen. |
| [Mailman 3](mailman-3/index.md) | [latest](mailman-3/latest/description.md) | Mailman 3: Mailinglisten mit Mitgliedern, Besitzern, Moderatoren und Bestätigung der Anmeldung. |

## Dateisatz pro Programm (ADR 0012)

```
programs/apps/groups/frontends/<programm>/
├── index.md        was es ist, bemerkenswerte Ideen, Quellen
└── latest/
    ├── description.md    was es ist, Offenheit, für wen es passt
    ├── features.md       was das Programm kann — und was nicht
    ├── menus.md          Menü-Inventar
    ├── states.md         Zustände: leer, laden, Fehler, teilweise, kein Zugriff
    └── workflows.md      W1 Gruppe anlegen, W2 verschachteln, W3 Mitglied aufnehmen, W4 entfernen oder austreten,
                          W5 einladen und antworten, W6 Rolle oder Recht ändern, W7 löschen und wiederherstellen
```

Protokolle (Matrix, SMTP, LDAP, …) sind keine Frontends; sie werden unter [Daten](../../../../data/standards.md) beschrieben.
