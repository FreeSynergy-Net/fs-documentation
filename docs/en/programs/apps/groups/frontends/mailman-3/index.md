# Mailman 3

> Category: [groups](../../index.md)

## What it is
Mailman 3 is mailing list software. Users subscribe to lists and manage their own delivery settings [S1]. Roles are set per list: list owners maintain one list, moderators review posts, and site administrators maintain the software [S1, S2].

## Notable ideas
Delivery settings resolve in layers: per list overrides per address, which overrides global settings [S1].

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
| ID | Source (URL) | Type | Retrieved |
|---|---|---|---|
| S1 | https://docs.mailman3.org/en/latest/userguide.html | Official user guide | 2026-11-16 |
| S2 | https://docs.mailman3.org/en/latest/config-web.html | Official admin guide (web configuration) | 2026-11-16 |
| S3 | https://docs.mailman3.org/en/latest/ | Official docs index | 2026-11-16 |
