# Microsoft To Do (Windows)

> Category: [tasks](../../index.md)

## What it is

Microsoft To Do is a personal task manager from Microsoft with lists, due dates, reminders, steps (subtasks), notes, tags and shared lists. The Windows app is one of its clients (next to web, Mac, iOS and Android). Tasks are stored in the Microsoft cloud. The Microsoft Graph To Do API gives programs access to lists and tasks.

## Notable ideas

_Documented here for the Windows client and its shared, day-oriented lists. Own wording only (ADR 0013). Gaps are marked `[offen]`: no source read for them._

- **My Day** is a daily working list: it is filled with open tasks due that day, and it clears itself every night (source: Plan your day with My Day). Adding a task to My Day does not move it out of its list.
- **Assigning in shared lists**: a task can be assigned to any member of a shared list, including yourself (What's new, version 1.62).
- **Smart due date**: due dates and reminders can be typed into the task title in plain words. Only a search excerpt was read for this (page not opened, `[offen]` for the details).

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

Retrieved 2026-11-16. Every source is an official Microsoft page. Where a page did not name a platform, the entry says so.

| Source | Kind | Retrieved |
|--------|------|-----------|
| https://support.microsoft.com/en-us/office/welcome-to-microsoft-to-do-762cbbf9-7fc1-48e5-b619-005622da89d0 | official help, overview and navigation | ✅ 2026-11-16 |
| https://support.microsoft.com/en-us/office/plan-your-day-with-my-day-4cafa6fe-8891-4ad5-985f-65912146a73e | official help, My Day | ✅ 2026-11-16 (no steps on the page) |
| https://support.microsoft.com/en-us/office/add-steps-importance-notes-tags-and-categories-to-your-tasks-bf9fdff6-f85f-4e03-9534-c587eb32515c | official help, steps, notes, tags, categories | ✅ 2026-11-16 |
| https://support.microsoft.com/en-us/office/sort-and-search-in-lists-133fa637-3f47-4633-8d78-7289059fa630 | official help, sorting and search | ✅ 2026-11-16 |
| https://support.microsoft.com/en-us/office/add-due-dates-and-reminders-in-microsoft-to-do-064d9696-08d1-4433-bfdd-f661dc97491f | official help, due dates and reminders | ✅ 2026-11-16 |
| https://support.microsoft.com/en-us/todo/share-a-task-list | official help, sharing (page is marked Outlook.com) | ✅ 2026-11-16 |
| https://support.microsoft.com/en-us/todo/what-s-new-in-microsoft-to-do | official release notes (version list, no dates) | ✅ 2026-11-16 |
| https://support.microsoft.com/en-us/todo/using-keyboard-shortcuts-in-microsoft-to-do | official help, keyboard shortcuts (Windows 10 only) | ✅ 2026-11-16 |
| https://learn.microsoft.com/en-us/graph/api/resources/todo-overview?view=graph-rest-1.0 | official API reference, To Do resources | ✅ 2026-11-16 |
| https://support.microsoft.com/en-us/todo/smart-due-date-reminder-recognition-in-microsoft-to-do | official help, smart due date (search excerpt, not opened) | ⚠️ excerpt 2026-11-16 |
| https://support.microsoft.com/en-us/office/create-recurring-tasks-88a4d903-38c3-4665-870e-4810b752f2c4 | opened, but it is the Microsoft Project article: no To Do repeat steps | ❌ not usable |

Not found in any read source: exact menu names for the Windows client, the window layout, the empty and error texts, and whether a repeat option exists in the Windows app. These are `[offen]` in the files.
