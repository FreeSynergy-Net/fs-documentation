# Microsoft 365 Groups

> Category: [groups](../../index.md)

## What it is

Microsoft 365 Groups are collaboration groups with owners and members; a new group gets a shared inbox, calendar, document library and other resources for its members [S2][S6].

## Notable ideas

- Membership is the access control: adding someone to the group grants access to its shared resources [S2].
- Three roles: owners manage membership and settings, members use resources, guests are invited from outside the organization [S2][S6].
- Lifecycle: expiration policies send owners renewal reminders 30, 15 and 1 day before expiry; groups not renewed are deleted [S2].
- Deletion is soft for 30 days; an admin can restore the group in that window [S4].
- A group without an owner gets a new owner automatically [S6].

## Documented versions

<!-- gen:versions (scripts/gen_frontend_indexes.py) — edits inside are overwritten -->
| Version | Required files present |
|---------|------------------------|
| [latest](latest/description.md) | 3/7 |

### latest

| File | Contents |
|------|----------|
| [description.md](latest/description.md) | Detailed description, differentiation, who it suits |
| [features.md](latest/features.md) | What the program can do — and what not |
| [menus.md](latest/menus.md) | Menu structure, context menus, menus by role |
| [states.md](latest/states.md) | UI states and transitions |
| [workflows.md](latest/workflows.md) | Step-by-step workflows: goal, prerequisites, steps, failures, undo |

⚠️ Missing required files: `layout.md`, `shortcuts.md`, `api.md`, `themes/index.md`
<!-- /gen:versions -->

## Sources

| Kennung | Quelle (URL) | Art | Abgerufen |
| --- | --- | --- | --- |
| S1 | https://support.microsoft.com/en-us/accounts-billing/work-school/create-and-update-microsoft-365-groups-for-your-work-or-school-account | Hersteller-Hilfe, Artikel anlegen, bearbeiten, löschen | 2026-11-16 |
| S2 | https://learn.microsoft.com/en-us/microsoft-365/admin/create-groups/office-365-groups?view=o365-worldwide | Hersteller-Doku, Übersicht für Administratoren | 2026-11-16 |
| S3 | https://learn.microsoft.com/en-us/microsoft-365/admin/create-groups/manage-groups?view=o365-worldwide | Hersteller-Doku, Gruppe im Admin-Center verwalten | 2026-11-16 |
| S4 | https://learn.microsoft.com/en-us/microsoft-365/admin/create-groups/restore-deleted-group?view=o365-worldwide | Hersteller-Doku, gelöschte Gruppe wiederherstellen | 2026-11-16 |
| S5 | https://learn.microsoft.com/en-us/entra/fundamentals/how-to-manage-groups | Hersteller-Doku, Entra-Gruppen verwalten | 2026-11-16 |
| S6 | https://support.microsoft.com/en-us/office/learn-about-group-types-in-microsoft-365 | Hersteller-Hilfe, Gruppentypen und Rollen | 2026-11-16 |
| S7 | https://support.microsoft.com/en-us/outlook/administrator-guide-to-microsoft-365-groups-in-outlook | Hersteller-Hilfe, Administratorhandbuch in Outlook | 2026-11-16 |
