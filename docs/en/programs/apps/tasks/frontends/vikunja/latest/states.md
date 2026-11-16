# Vikunja - UI states

> [Vikunja](../index.md) · [workflows](workflows.md) · [gaps](gaps.md)

Source: UI strings in the repository file `frontend/src/i18n/lang/en.json` (https://raw.githubusercontent.com/go-vikunja/vikunja/main/frontend/src/i18n/lang/en.json, retrieved 2026-11-16). Each text is cited by its i18n key; line numbers were not taken. Behaviour comes from the help pages where stated.

## Empty states

| State | Shown when | Text (en) | i18n key |
|-------|------------|-----------|----------|
| No tasks on the dashboard | nothing to show | "Nothing to do — Have a nice day!" | `task.show.noTasks` |
| Empty project | project has no task | "This project is currently empty." | `project.list.empty` |
| Empty project, call to action | same | "Create a task." | `project.list.newTaskCta` |
| No labels | user has none | "You currently do not have any labels." | `label.newCTA` |
| No notifications | none | "You don't have any notifications. Have a nice day!" | `notification.none` |
| Trash, tasks | no task in trash | "There are no tasks in the trash." | `trash.noTasks` |
| Trash, projects | no project in trash | "There are no projects in the trash." | `trash.noProjects` |
| No teams | user in no team | "You are currently not part of any teams." | `team.noTeams` |
| No filter result | filter matches nothing | "No results" | `filters.noResults` |
| Time tracking, task | none | "No time tracked for this task yet." | `timeTracking.list.emptyTask` |
| Kanban bucket: empty | not stated in the strings | `[offen]` | - |
| Kanban bucket: full (WIP limit) | count reached | count turns red, "Add a task" disabled, no drop (Views help) | Views help |

## Error and connection states

| State | Text (en) | i18n key |
|-------|-----------|----------|
| Offline | "You are offline." / "Please check your network connection and try again." | `offline.title`, `offline.text` |
| Load failure, general | "Loading failed, please {0}. If the error persists, please {1}." | `loadingError.failed` |
| Generic error | "An error occurred:" | `ready.errorOccured` |
| Wrong API address | "Please check if the api url is correct." | `ready.checkApiUrl` |
| Rate limited | "The server received too many requests. Please wait a moment and reload the page." | `ready.rateLimited` |
| Project information | "Failed to load project information." | `sharing.projectLoadError` |
| Sharing, server | "Server error occurred. Please try again later." | `sharing.serverError` |
| Copy failed | "Copy to clipboard failed" | `misc.copyError` |
| Image failed | "Failed to load image" | `misc.imageLoadFailed` |
| Audio attachment | "Could not play this audio file." | `task.attachment.audioError` |
| Bulk create | "The server returned an unexpected number of created tasks." | `task.bulkCreateUnexpectedResponse` |
| Import: credentials | "The credentials for {service} could not be verified. Please connect it again." | `migrate.failure.credentials` |
| Import: upload | "The file you uploaded could not be stored. Please upload it again." | `migrate.failure.upload` |
| Login by third party | "An error occurred while authenticating against the third party." | `user.auth.openIdGeneralError` |

Saving and deleting failures: no key with that wording exists in the strings (`[offen]`).

## Transitions named in read sources

- Task done: "Done" button or `t`; done tasks are hidden in the List view by default (Views help).
- Task deleted: no confirmation; "Undo" in the message restores it (Tasks help). Trash keeps it for 30 days.
- Trash item: "Restore", "Delete forever" (with confirm), "Empty trash" (Trash help).
- Kanban drop into the done bucket marks the task done; marking done moves it there (Views help).
- Project archived: read-only until unarchived (Projects help).

## Loading states

- `[offen]`: skeleton or spinner states are not in the read sources.
