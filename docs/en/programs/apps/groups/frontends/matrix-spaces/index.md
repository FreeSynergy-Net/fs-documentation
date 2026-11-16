# Matrix Spaces

> Category: [groups](../../index.md)

## What it is

Matrix Spaces are a way to group Matrix rooms and people. The Matrix Client-Server specification has a Spaces chapter; its table of contents names the `m.space.child` and `m.space.parent` relationships and a room hierarchy endpoint [S1]. In Element, a space is shown in the left panel, and selecting it shows only the rooms and people that belong to it [S3]. The field meanings and the full behaviour are not confirmed from the fetched text: [offen].

## Notable ideas

- A space is a room that other rooms are linked to through `m.space.child` and `m.space.parent` relationships [S1].
- A room can be joinable only by space members, set under the room's access settings [S2].

## Licence

- Specification licence: [offen] (not stated on the fetched page).
- Element licence: [offen] (not stated on the fetched pages).

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
| S1 | https://spec.matrix.org/v1.19/client-server-api/ | Spezifikation (Inhaltsverzeichnis, Spaces-Kapitel) | 2026-11-16 |
| S2 | https://element.io/help | Hilfeseite (Element) | 2026-11-16 |
| S3 | https://docs.element.io/latest/element-support/quick-start-guide/the-left-panel/ | Benutzerdokumentation (Element) | 2026-11-16 |
| S4 | https://docs.element.io/latest/element-support/matrix-rooms/getting-started-creating-a-room/ | Benutzerdokumentation (Element) | 2026-11-16 |
