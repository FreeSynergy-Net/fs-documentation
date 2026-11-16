# Vikunja

> Category: [tasks](../../index.md) · Type: self-hosted task and project manager · Vendor: Vikunja (open source, community project) · Licence: AGPL-3.0

## What it is

Vikunja is an open-source task and project manager with lists, tables, kanban boards and Gantt charts per project, labels, sharing with users, teams and links, and an API. It runs on your own server (Vikunja Cloud is the hosted variant) and has a desktop app.

## Notable ideas

_Documented here because it is the open-source counterpart to the proprietary task apps and because it offers four views on one project. Own wording only (ADR 0013). Gaps are marked `[offen]`: no source read for them._

- **Four views per project**: List, Table, Kanban and Gantt, each with its own filter. Since version 0.24.0 a project can have several views, each with its own layout and filter (What's new in 0.24.0).
- **Kanban buckets with WIP limits**: a full bucket turns its count red, disables "Add a task" and blocks drops. A done bucket marks tasks done when they enter it; filter-based buckets fill from a query.
- **Labels belong to the person who created them**, not to a project, so one label can be used across projects (Labels article).
- **Trash with a 30-day window** for tasks and projects, with restore and "Delete forever" (Trash article).

## Documented versions

<!-- gen:versions (scripts/gen_frontend_indexes.py) — edits inside are overwritten -->
| Version | Required files present |
|---------|------------------------|
| [latest](latest/description.md) | 6/7 |

### latest

| File | Contents |
|------|----------|
| [description.md](latest/description.md) | Detailed description, differentiation, who it suits |
| [features.md](latest/features.md) | What the program can do — and what not |
| [layout.md](latest/layout.md) | Window structure, regions, panels |
| [menus.md](latest/menus.md) | Menu structure, context menus, menus by role |
| [shortcuts.md](latest/shortcuts.md) | Keyboard shortcuts |
| [api.md](latest/api.md) | APIs and protocols, authentication, rate limits |
| [states.md](latest/states.md) | UI states and transitions |
| [dialogs.md](latest/dialogs.md) | Every dialog: purpose, fields, buttons, default, cancel |
| [workflows.md](latest/workflows.md) | Step-by-step workflows: goal, prerequisites, steps, failures, undo |
| [acceptance.md](latest/acceptance.md) | Acceptance checklist: each workflow as a yes/no click test |
| [gaps.md](latest/gaps.md) | What our program cannot do for these workflows, and what it needs |

⚠️ Missing required files: `themes/index.md`
<!-- /gen:versions -->

## Sources

Retrieved 2026-11-16. Official pages are on vikunja.io; the licence and UI strings come from the project repository.

| Source | Kind | Retrieved |
|--------|------|-----------|
| https://vikunja.io/help/ | official help index (topic list) | ✅ 2026-11-16 |
| https://vikunja.io/help/views/ | official help, views, kanban | ✅ 2026-11-16 |
| https://vikunja.io/help/tasks | official help, tasks | ✅ 2026-11-16 |
| https://vikunja.io/help/dates-and-reminders | official help, dates, reminders, repeat | ✅ 2026-11-16 |
| https://vikunja.io/help/projects | official help, projects | ✅ 2026-11-16 |
| https://vikunja.io/help/labels | official help, labels | ✅ 2026-11-16 |
| https://vikunja.io/help/sharing-and-teams | official help, sharing | ✅ 2026-11-16 |
| https://vikunja.io/help/trash | official help, trash | ✅ 2026-11-16 |
| https://vikunja.io/help/accessibility | official help, keyboard shortcuts | ✅ 2026-11-16 |
| https://vikunja.io/docs/api-documentation/ | official API documentation | ✅ 2026-11-16 |
| https://vikunja.io/changelog/whats-new-in-vikunja-0.24.0/ | official changelog (search excerpt, not opened) | ⚠️ excerpt 2026-11-16 |
| https://github.com/go-vikunja/vikunja/blob/main/LICENSE | repository licence file (AGPL-3.0) | ✅ 2026-11-16 |
| https://raw.githubusercontent.com/go-vikunja/vikunja/main/frontend/src/i18n/lang/en.json | repository, English UI strings (keys, not line numbers) | ✅ 2026-11-16 |

The source list names the repository as `go-vikunja/vikunja`; the search result named `kolaente/vikunja`, which redirects to it. Line numbers of the UI strings were not taken, so the states cite the i18n key path.
