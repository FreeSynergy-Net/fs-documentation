# Microsoft To Do (Windows) - APIs and protocols

> [Microsoft To Do](../index.md) · [features](features.md) · [gaps](gaps.md)

Source: Microsoft Graph To Do API overview, https://learn.microsoft.com/en-us/graph/api/resources/todo-overview?view=graph-rest-1.0 , retrieved 2026-11-16 (Microsoft Learn, graph-rest-1.0).

## Protocol and entry points

- REST via Microsoft Graph. Lists and tasks are read with these paths (taken from the overview):
  - `GET /me/todo/lists` (task lists)
  - `GET /me/todo/lists/{todoTaskListId}/tasks` (tasks of one list)
  - `GET /me/todo/lists/{todoTaskListId}/tasks/{todoTaskId}/checklistItems/{checklistItems}` (steps, named "checklistItem" in the API)
  - `GET /me/todo/lists/{todoTaskListId}/tasks/{todoTaskId}/linkedresources/{linkedResourceId}` (linked items from partner apps)
- Resources named in the overview: `todoTaskList`, `todoTask`, `checklistItem`, `linkedResource`, `singleValueExtendedProperty`.
- Creating tasks works only inside a task list (overview: "You can currently create tasks only in a task list").

## Sync

- Delta query is supported for the `todoTask` collection in a task list and for `todoTaskList`.

## Authentication

- Delegated and application permissions are both supported (overview).
- Scope names (for example the read/write task scope) are `[offen]`: not read on the page.

## Rate limits

- `[offen]`: no throttling statement read.

## Data format

- Date and time property types (for example `dateTimeTimeZone`): `[offen]`. The overview does not name them.

## Other APIs

- Microsoft To Do is not self-hostable; no other public API was read.
