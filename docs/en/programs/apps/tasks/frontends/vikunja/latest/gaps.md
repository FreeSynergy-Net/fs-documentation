# Vikunja - Gaps of our program

> [Vikunja](../index.md) · [workflows](workflows.md) · [acceptance](acceptance.md)

Our program `fs-tasks`: state from the pilot plan (`PLAN.md` §4, function list T1-T28, read 2026-11-16). No code check was run for this dossier (no build, Dossier-Gate task). `[offen]` = not checked.

| Workflow | Our state (plan §4) | Gap |
|----------|---------------------|-----|
| V1 create | T2 quick entry (title, Enter; Esc discards) | Quick Add Magic and `*label` syntax `[offen]` |
| V2 edit | T3 form (title, description, list, due, start, priority, labels, assignees) | Right-sidebar layout and inline title `[offen]` |
| V3 done | T8 done and reopen | Shortcut `t` and "Shift+T" not in plan |
| V4 delete, undo, trash | T19 delete and restore; T20 trash | Undo message after delete `[offen]` |
| V5 relations | T15 dependencies and "blocked by" (`relate`, `readiness`) | Relation types beyond blocking `[offen]` |
| V6 repeat | T16 repeat, `Unsupported` outside the subset | Repeat modes "Default", "Monthly", "From completion date": plan has no mode list |
| V7 dates | T4 due date and start with zone; reminders T17 | Date-only due value: the Vikunja page defines none, so no comparison is possible `[offen]`; default due time setting missing; end date missing from plan |
| V8 attachments | T28 links; file attachment waits for fs-files (O15) | Attachments in the detail view `[offen]` |
| V9 share | Not in function list | Sharing with user, team, link and the three levels missing |
| V10 kanban buckets | T9 Board: columns are the stand, card moves, "+" in an empty column | WIP limit, done bucket, filter-based buckets missing |
| Views | T1 Today, T9 Board, T11 Today/Upcoming lists; no per-project view list | Table view and Gantt view missing; several views per project missing |
| Labels | T13 labels set and removed | Labels per person (not per project); link-share rule missing |
| Projects | T22 lists; "Persönlich" as first list | Sub-projects, favourites, archive, duplicate missing |
| Shortcuts | no shortcut list in plan | All of [shortcuts](shortcuts.md) |
