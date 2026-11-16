# Nextcloud Circles

> Category: [groups](../../index.md)

## What it is

Nextcloud Circles (app ID `circles`) is a group feature inside Nextcloud for sharing resources with a named set of people. In the Nextcloud 35 user manual the feature is called "Teams" and is managed in a separate Teams app [S1]. The app store page lists the app as no longer actively distributed through the app store and as part of the Nextcloud Server release packages [S2]. The licence stated in the source file is AGPL-3.0-or-later [S3]; the app store page itself names no licence [S2].

## Notable ideas

- A circle can hold local accounts, groups, email addresses and other circles as members; a role given to a group or circle applies to all of its members [S1].
- Four fixed roles (Member, Moderator, Admin, Owner), with exactly one Owner per circle [S1].

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
|---|---|---|---|
| S1 | https://docs.nextcloud.com/server/stable/user_manual/en/groupware/contacts.html | Benutzerhandbuch (Nextcloud 35, Abschnitt Teams) | 2026-11-16 |
| S2 | https://apps.nextcloud.com/apps/circles | App-Store-Seite (Lizenz nicht angegeben) | 2026-11-16 |
| S3 | https://raw.githubusercontent.com/nextcloud/circles/master/appinfo/info.xml | Quelltext, nur zur Faktenprüfung (Lizenz, Name) | 2026-11-16 |
| S4 | https://docs.nextcloud.com/server/stable/user_manual/en/ | Benutzerhandbuch, Inhaltsübersicht (Groupware) | 2026-11-16 |
