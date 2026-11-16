# Microsoft To Do (Windows) - Gaps of our program

> [Microsoft To Do](../index.md) · [workflows](workflows.md) · [acceptance](acceptance.md)

Our program `fs-tasks`: state from the pilot plan (`PLAN.md` §4, function list T1-T28, read 2026-11-16). No code check was run for this dossier (no build, Dossier-Gate task). `[offen]` = not checked.

| Workflow | Our state (plan §4) | Gap |
|----------|---------------------|-----|
| M1 create | T2 quick entry (title, Enter; Esc discards) | Ctrl+N not checked in code `[offen]` |
| M2 due date | T4 date or time with zone | Due date as "Today/Tomorrow/Next week/Pick a date" menu missing; the Microsoft page has no date-only type `[offen]` |
| M3 reminder | T17 reminder (`update(alerts)`) | Reminder presets not in plan |
| M4 complete | T8 progress | Keyboard path Ctrl+D `[offen]` |
| M5 steps | T14 subtasks with open-children question | Step counter and "+ Add step" line `[offen]` |
| M6 My Day | T11 Today (due today + overdue) | No My Day list that is cleared nightly and not moved by adding; plan differs `[offen]` |
| M7 share a list | T22 lists; sharing not in the function list | Sharing by invitation link missing (ADR 0049 scope `[offen]`) |
| M8 assign | T5 assign/asker, T6 unassign | Assignee as shared-list member; acceptance (T7) `[offen]` |
| M9 sort, search | T12 filter and search | Sort "Importance / Due date / Added to My Day / Alphabetically / Creation date" not in plan `[offen]` |
| Steps, notes, tags | T13 labels; notes not listed | Notes field and categories not in plan `[offen]` |
| Shortcuts | no shortcut list in plan | All of [shortcuts](shortcuts.md) |
| Menus | Board frontend has menu "Frontend" only (Jira gaps file, same program state) | Smart lists and the list menu of this dossier |
