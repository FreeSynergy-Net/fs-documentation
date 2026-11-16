# Vikunja - Workflows

> [Vikunja](../index.md) · [dialogs](dialogs.md) · [shortcuts](shortcuts.md) · [acceptance](acceptance.md) · [gaps](gaps.md)

Format: goal, requirement, steps (user does X -> program shows Y), errors, undo. Platform: web app. Read from https://vikunja.io/help/ pages on 2026-11-16 (retrieved as text; no screenshots). `[offen]` = not on a page read. IDs V1..V9.

## V1 Create a task
Requirement: a project exists (the Inbox or a chosen project).
1. Type in the input at the top of the List view or on the dashboard -> the task is created.
2. Optional: Quick Add Magic in the same input; `*` before a label name (for example `*logistics`).
Errors: `[offen]`. Undo: delete the task (V4).

## V2 Edit a task
1. Click the task in List, Kanban or Table (double-click in Gantt) -> the detail view opens.
2. Click the title to edit it inline; edit the description in the editor.
3. Change the fields in the right sidebar: Labels, Priority, Progress, Color, Assignees, Dates, Attachments.
Errors: an assignee who has no access to the project cannot be chosen (tasks help). Undo: `[offen]`.

## V3 Mark a task done
1. Click the "Done" button at the top of the right sidebar, or press `t` -> the task is done.
2. Click again to reopen.
In a Kanban view, dropping the task in the done bucket also marks it done (views help).
Errors and undo: `[offen]`.

## V4 Delete and restore a task
1. Click "Delete" at the bottom of the right sidebar, or press Delete (Backspace on a Mac) -> the task goes to the trash at once; no confirmation.
2. Click "Undo" in the message -> the task is restored.
3. Later: Trash > Tasks > "Restore" next to the item -> the task is back. Items are kept for 30 days, then removed permanently (Trash help).
Errors: after 30 days the item is gone. Permanent early: "Delete forever" (asks to confirm).

## V5 Relate tasks (no subtask feature)
1. In the detail view click "Add a relation", find the other task, choose the relation type -> the link is saved.
The tasks help names subtasks and parent tasks as examples of relation types; the full list is on the task relations page, not read (`[offen]`). Subtasks as a separate feature: none named.

## V6 Repeat a task
1. Set a due date (V7), then choose repeat: "Every Day", "Every Week", "Every 30 Days", or a custom interval in hours, days or weeks.
2. Choose the repeat mode: "Default" (fixed interval from the current dates), "Monthly" (same day each month; short months use the last day), "From completion date" (interval after done).
3. Mark the task done -> it is not copied; the same task moves to the next occurrence with its dates and reminders; checklist items are unchecked.
Errors: rules like "every 2 weeks on Tuesday" are not supported yet. Undo: `[offen]`.

## V7 Set dates and reminders
1. Open "Dates" in the right sidebar: due date ("when a task must be finished"), start date and end date (planning window, not deadlines).
2. Default due time (Settings > General > Projects & Tasks) applies to dates set without a time, including Quick Add Magic.
3. Add reminders: absolute (date and time), or relative to due, start or end date. A relative reminder does not fire without its date.
Errors: a date-only type is not defined on the page; `[offen]`. Time zones: `[offen]` (page says nothing).

## V8 Attach a file or a link
Attachments are in the right sidebar of the detail view; shortcut `f` adds an attachment (keyboard reference). Upload limits and link handling: `[offen]`.

## V9 Share a project
1. Open the three-dot menu next to the project title -> share.
2. Choose "With a user" (search by username), "With a team", or "Via link share" (optional name and password; anyone with the link, no account needed).
3. Set the level: Read, Read & Write, or Admin.
Errors and undo: `[offen]`. Link shares cannot create labels (labels help).

## V10 Kanban buckets and WIP limit
1. Create a bucket in the field at the far right of the board.
2. Bucket three-dot menu: "WIP limit", default or done bucket, collapse, delete.
3. A full bucket: count red, "Add a task" disabled, tasks cannot be dropped in.
Deleting a bucket moves its tasks to the default bucket; the last bucket cannot be deleted.

## V11 Projects: create, archive, duplicate, delete
1. Projects > create button at the top right -> new project.
2. Three-dot menu: "Create sub-project", "Archive" (read-only; reversible), "Duplicate" (tasks, views, sub-projects, settings), "Delete" (Admin only).
Errors and undo: archive can be reversed from the same menu (projects help).
