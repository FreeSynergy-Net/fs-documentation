# Vikunja - Dialogs

> [Vikunja](../index.md) · [features](features.md) · [menus](menus.md) · [workflows](workflows.md)

Platform: web app (and the desktop app where the same dialogs apply `[offen]`). Read from https://vikunja.io/help/ pages on 2026-11-16. `[offen]` = not on a page read. The cancel behaviour of each dialog is `[offen]` unless a read page says so.

| Dialog | Purpose | Fields and options | Buttons | Cancel | Source |
|--------|---------|--------------------|---------|--------|--------|
| Task creation input | Make a task | Input at the top of the List view or on the dashboard; Quick Add Magic in the same field; `*` prefix for a label | Enter (`[offen]` exact button) | `[offen]` | tasks |
| Task detail | Edit a task | Title (inline), description (editor), right sidebar: Labels, Priority ("Unset" to "Do Now"), Progress (0 to 100), Color, Assignees, Dates, Attachments, Project | "Done" (top right sidebar); "Delete" (bottom) | `[offen]` | tasks |
| Delete task | Remove a task | none | "Delete" or Delete/Backspace key; no confirmation; "Undo" in the message | Undo | tasks |
| Views (dialog or panel) | Create, edit, delete, reorder views | Title, type (list, table, kanban), optional filter | three-dot menu next to the project title, "Views" | `[offen]` | views |
| Project edit | Change project settings | Title, parent project, description, identifier, colour | "Edit" in the three-dot menu | `[offen]` | projects |
| Share project | Share with user, team or link | User: search by username (name or email if allowed); team; link: optional name and password; levels Read, Read & Write, Admin | three-dot menu, share; link | `[offen]` | sharing-and-teams |
| Delete project | Remove a project | none named | "Delete" (Admin only) | `[offen]` | projects |
| Trash: delete forever | Remove an item early | confirmation (text not quoted) | "Delete forever" | confirm asked | trash |
| Trash: empty | Clear the current tab | confirmation | "Empty trash" | `[offen]` | trash |
| Label creation | Make a label | name; created when a new name is typed in a task | label overview; task label field | `[offen]` | labels |
| Due date, reminders | Set dates and reminders | Due date, start date, end date, default due time (Settings > General > Projects & Tasks); reminders absolute or relative; repeat with quick buttons | `[offen]` exact labels | `[offen]` | dates-and-reminders |
| Keyboard reference | Show shortcuts | list of keys | `?` | `[offen]` | accessibility |
