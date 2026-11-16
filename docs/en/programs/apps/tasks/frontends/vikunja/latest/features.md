# Vikunja - Features

## Main features

### Tasks
- Title, description (Markdown editor), labels, priority ("Unset" to "Do Now"), progress (0 to 100), colour, assignees, dates, attachments (help: Tasks).
- **Due date** ("when a task must be finished"), **start date** and **end date** (planning window, not deadlines), **reminders** (absolute, or relative to due, start or end date) (help: Dates & Reminders).
- **Repeat**: quick buttons "Every Day", "Every Week", "Every 30 Days", or a custom interval in hours, days or weeks; repeat modes "Default", "Monthly", "From completion date". Checklist items in the description are unchecked on repeat.
- **Task relations** (help: Task Relations); the Tasks help page names relations as the way to link tasks, and the page has no separate subtask feature.
- **Quick Add Magic**: details while typing; a label prefix `*` (for example `*logistics`).
- **Done** button in the detail view; undo by clicking it again.
- **Trash**: deleted tasks and projects are kept for 30 days; restore and "Delete forever" (help: Trash).

### Views
- List (flat, sort by one field: Manually, title, date, priority, % done, created or updated), Table (configurable columns, sort by header click, Ctrl or Cmd for several columns), Kanban (buckets), Gantt (bars from start to end date) (help: Views).
- Create, edit, delete and reorder views from the three-dot menu next to the project title, "Views".
- Filtering: available in List, Table and Kanban; "Filtering is not available in the Gantt view."
- Remembered view settings per browser: sort, filter, search and page (List, Table) and the date range (Gantt).

### Kanban
- Buckets with a three-dot menu ("WIP limit", default or done bucket, collapse, delete).
- A deleted bucket moves its tasks to the default bucket; the last bucket cannot be deleted.
- Filter-based buckets fill from a query and do not accept drags.

### Projects
- Create in the Projects overview; sub-projects ("Create sub-project"), favourites (star), colour, archive (read-only; reversible), duplicate, delete (Admin only).

### Labels
- Created on the label overview or while adding a label to a task; per user, not per project; only the creator can delete them.

### Sharing
- Share with a **user**, a **team** or by **link** (optional name and password), with the levels **Read**, **Read & Write** and **Admin** (help: Sharing & Teams).
- Assignees: only users who already have access to the project can be assigned.

### Import, export and API
- Import and export (help topic), CalDAV (help topic), webhooks (help topic), API with tokens (see [api.md](api.md)).

## What Vikunja does NOT do (per the read pages)

- **No delete confirmation** for tasks: they go to the trash, and an Undo message appears (help: Tasks).
- **Reordering** a kanban bucket's cards and a List view manually is drag-and-drop only (accessibility page, "Not keyboard-accessible yet").
- **Renaming a kanban bucket** still needs a pointer (accessibility page).
- **Repeat rules** like "every 2 weeks on Tuesday" are not supported yet (dates and reminders page).
- **Shared links cannot create labels**; only labels already used in the shared project can be added (labels page).
- **Vikunja Cloud has no username and password login** (API documentation).

## Extensions and integrations

| Integration | Method |
|-------------|--------|
| REST API | tokens, `/api/v1` ([api.md](api.md)) |
| CalDAV | help topic, not read in detail `[offen]` |
| Webhooks | help topic, not read in detail `[offen]` |
| MCP | help topic listed in index, not read `[offen]` |
