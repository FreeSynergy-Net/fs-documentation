# Vikunja - Menus

> [Vikunja](../index.md) · [features](features.md) · [shortcuts](shortcuts.md) · [dialogs](dialogs.md)

Sources: help pages on https://vikunja.io/help/ (Projects, Views, Trash, Sharing & Teams, Accessibility), retrieved 2026-11-16. Menu names in quotes are the help text's names; the exact labels of the UI may differ and are `[offen]` where not quoted.

## Menu structure

- **Sidebar**: Overview, Upcoming, Projects (with favourites at the top), Labels, Teams, Trash. Toggle: Ctrl+E / Cmd+E.
- **Global search and command palette**: Ctrl+K / Cmd+K ("opens search, which also works as a command palette").
- **Project three-dot menu** (next to the project title)
  - "Edit": title, parent project, description, identifier, colour
  - "Create sub-project"
  - "Views": create, edit, delete, reorder views
  - "Archive" (reversible from the same menu)
  - "Duplicate": copies tasks, views, sub-projects and settings
  - "Delete": Admin permission required
  - Background image entry: named in the help text, label `[offen]`
- **Project share**: from the same three-dot menu; methods "With a user", "With a team", "Via link share" (sharing article, names as written).
- **Trash page**: tabs "Tasks" and "Projects"; per item "Restore" (arrow icon) and "Delete forever"; "Empty trash".

## Task detail (right sidebar)

- "Done" (top): marks done or undone
- Labels, Priority, Progress, Color, Assignees, Dates, Attachments
- "Delete" (bottom); no confirmation, "Undo" in the message
- "Add a relation" (task relations; the only way to link tasks as parent or child)

## Context menus

- `[offen]`: no read page names a right-click menu for tasks. Drag between sidebar and task list is named (Tasks help).

## Menus by role

- Admin: "Delete" a project (Projects help; Permissions page not read).
- Write access on a task: add and remove labels (Labels help).
- Creator of a label: delete it from the labels overview (Labels help).
- Admin permission on a project: "Delete" (Projects help).
