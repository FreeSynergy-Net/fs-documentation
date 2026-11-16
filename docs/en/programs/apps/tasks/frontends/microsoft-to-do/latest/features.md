# Microsoft To Do (Windows) - Features

## Main features

### Lists and tasks
- Any number of lists (the welcome page names work, groceries, travel as examples); lists can be sorted, searched, renamed and deleted (article titles in the sidebar of the welcome page).
- Tasks with **due date** and **reminder** (welcome page); reminder options: "Later today", "Tomorrow", "Next week", "Pick a date & time" (article: add due dates and reminders).
- **Steps** (subtasks) with a counter of completed steps under the task name.
- **Notes**, **tags** (hashtag in the title, e.g. `#work`) and **categories** (from Outlook; the article states platform-independent steps, with no Windows-specific wording).
- **Importance**: a star per task; starred tasks appear in the Important smart list.

### My Day
- Daily list of tasks that are due that day and not completed. It clears itself every night.
- Adding a task to My Day does not move the task from its list.

### Sorting and search
- Sort a list by **Importance**, **Due date**, **Added to My Day**, **Alphabetically** or **Creation date**.
- Search covers tasks, steps, tags and notes.

### Sharing and assigning
- A list can be shared with an **invitation link**; access can be limited to current members, and sharing can be stopped.
- Tasks can be assigned to any member of a shared list, including yourself (release note, version 1.62).
- Sharing works between personal accounts, and between accounts of the same work or school organisation.

### Attachments
- Files can be added to tasks; per the release note of version 1.49, up to 25 MB per task, in personal lists only "for now". This wording is old; `[offen]` for the current limit.

## What Microsoft To Do does not do (per the read pages)

- No self-hosting; the data sits in the Microsoft cloud (welcome page).
- Rich text formatting (bold, italic, underline) in the notes is named for the **web** client only (steps article).
- Shared lists of work or school accounts are not visible to people outside the owner's organisation (help article "Why can't I join a shared list?", search excerpt only).

## Extensions and integrations

| Integration | Method |
|-------------|--------|
| Microsoft Graph To Do API | official, delegated and application permissions ([api.md](api.md)) |
| Outlook | Tasks sync automatically to Outlook tasks (welcome page); flagged email can become tasks (version 1.52, work or school accounts) |
| Calendar and due dates | `[offen]` |
