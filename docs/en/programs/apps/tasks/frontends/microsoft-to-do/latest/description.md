# Microsoft To Do (Windows) - Description

## What the program does

Microsoft To Do keeps personal tasks in lists. A task can carry a due date, a reminder, steps, notes, tags and a star for importance. The daily view is **My Day**: each night it clears itself, and it is filled again with the tasks due that day. Lists can be shared with other people through an invitation link; members of a shared list can be assigned tasks.

## Advantages

- Simple model: lists, tasks, steps. A new task needs only a title.
- Daily focus through My Day, with unfinished tasks returning to their own list the next day.
- Official Graph API for lists and tasks, with delta query for syncing (see [api.md](api.md)).

## Differentiation

| System | Difference |
|--------|------------|
| **Todoist** | Projects, sections and filters with a query language; no My Day clearing |
| **Things 3** | Apple platforms only; fixed lists (Today, Anytime, Someday) |
| **Vikunja** | Self-hostable, open source; views for list, table, kanban and Gantt |

## Technical details

- **Model**: cloud service with clients for Windows, Mac, web, iOS and Android (download tabs on the help page).
- **Sync**: tasks are stored in the Microsoft cloud (welcome page). Syncing is described for other clients; the Windows app's sync behaviour is `[offen]`.
- **Licence**: proprietary service and clients. No licence text was read: `[offen]`. The API is public (Microsoft Graph).

## Who it suits

- People who already use a Microsoft account and want personal lists with a daily focus.
- FreeSynergy frontends: the My Day and shared-list model is a reference for the "Heute" view and for assignment in shared lists (see [features.md](features.md)).
