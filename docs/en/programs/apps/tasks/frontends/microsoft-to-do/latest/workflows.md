# Microsoft To Do (Windows) - Workflows

> [Microsoft To Do](../index.md) · [dialogs](dialogs.md) · [shortcuts](shortcuts.md) · [acceptance](acceptance.md) · [gaps](gaps.md)

Format: goal, requirement, steps (user does X -> program shows Y), errors, undo. Read from official Microsoft help pages on 2026-11-16. `[offen]` = not on a page read. IDs M1..M9.

## M1 Create a task
Requirement: a list exists (the default list is named in the read pages as `[offen]`).
1. Press Ctrl+N (Windows 10 shortcut page) -> a new task is started.
2. Type the title -> the task appears in the list.
Errors: `[offen]`. Undo: `[offen]`.

## M2 Set a due date
1. Select the task -> the detail view opens.
2. Choose "Add due date" -> options "Today", "Tomorrow", "Next week", "Pick a date".
3. Pick one -> the due date shows; the task is listed in Planned (search excerpt). Time: the page names no time option for the due date.
Errors: `[offen]`. Undo: clear the date (`[offen]`).

## M3 Set a reminder
1. Select the task -> choose "Remind me".
2. Pick "Later today", "Tomorrow", "Next week" or "Pick a date & time" -> the reminder is set.
Errors: `[offen]`. Undo: `[offen]`.

## M4 Complete a task
1. Press Ctrl+D (Windows 10) -> the task is completed.
Mouse path (tick box): `[offen]`. Re-open: `[offen]`.

## M5 Add steps
1. Select the task -> "+ Add step".
2. Type the step, press Enter -> the step is saved and the detail view closes.
3. A counter under the task name shows completed steps of the total.
Errors and undo: `[offen]`.

## M6 Add to My Day
1. Press Ctrl+T (Windows 10) -> the task is listed in My Day.
2. The task stays in its own list. At night My Day clears itself; unfinished tasks are in their original list (My Day article).
Errors and undo: `[offen]`.

## M7 Share a list
Requirement: the list is in a personal account, or the owner's work or school account (help article, search excerpt).
1. Select the Share icon at the top of the task window -> the sharing menu opens.
2. Choose "Create invitation link", then "Copy link" -> the link is on the clipboard.
3. Paste the link into a message and send it.
4. To limit: "Manage access" -> toggle "Limit access to current members" -> the link is disabled.
5. To end: "Stop sharing" -> only the owner can access the list.
Errors: "Why can't I join a shared list?" (excerpt) names the work or school case. Undo: stop sharing.

## M8 Assign a task in a shared list
Requirement: the list is shared (M7).
1. Open the task's detail view -> choose "Assign".
2. Pick a member of the shared list, or yourself -> the task is assigned (release note, version 1.62).
Errors and undo: `[offen]`. Unassign and the acceptance by the assignee: `[offen]`.

## M9 Sort and search a list
1. Open the list menu (three dots, top right) -> "Sort by" -> one of Importance, Due date, Added to My Day, Alphabetically, Creation date.
2. Search: select the magnifying glass next to the username -> type -> select a result to open it. Search covers tasks, steps, tags and notes.
Errors and undo: `[offen]`.

## Not covered by any read source
- Repeating tasks in the Windows client (`[offen]`).
- Attachments in the current release (release note 1.49 only, 25 MB per task, `[offen]` for the current state).
