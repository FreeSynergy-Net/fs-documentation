# Microsoft To Do (Windows) - UI states

> [Microsoft To Do](../index.md) · [workflows](workflows.md) · [gaps](gaps.md)

No read page names UI states (empty list, loading, offline, sync error) and no page quotes a message text for them. Every state below is therefore `[offen]`. Nothing is guessed (ADR 0013).

| State | Shown when | Text on screen | Source |
|-------|------------|----------------|--------|
| Empty list | a list has no open task | `[offen]` | - |
| Empty My Day | no task is due today and none was added | `[offen]` | - |
| Loading | the list is fetched | `[offen]` | - |
| Offline | no connection | `[offen]` | - |
| Sync error | the cloud rejects a change | `[offen]` | - |
| Sharing: link disabled | "Limit access to current members" is on (the invitation link is disabled) | `[offen]` text; behaviour named | share-a-task-list |
| Sharing stopped | "Stop sharing" is pressed; only the owner can access the list | `[offen]` text; behaviour named | share-a-task-list |
| Shared list: no join | a list owned by a work or school account is opened by someone outside that organisation: "unavailable" | `[offen]` text; behaviour from help title excerpt | search excerpt only |

## Transitions named in read sources

- Task done: Ctrl+D (Windows 10); the done state itself is `[offen]`.
- Task added to My Day: Ctrl+T; My Day clears itself every night (My Day article). Unfinished tasks return to their own list.
- Reminder set: "Remind me" with the options listed in [dialogs.md](dialogs.md).
