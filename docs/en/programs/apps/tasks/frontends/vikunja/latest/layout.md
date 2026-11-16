# Vikunja - Structure and UI/UX

Read from the help pages on 2026-11-16 (text descriptions; no screenshots were read). Pixel layout and colours: `[offen]`.

## Page structure (named regions)

```
┌────────────────────────────────────────────────────────────────────┐
│ ☰ Vikunja   [ Search / command palette  Ctrl+K ]    user         │
├──────────────┬─────────────────────────────────────────────────────┤
│ Sidebar      │ Project title                       ⋮  (three dots)  │
│ Overview     │ [ List | Table | Kanban | Gantt ]  (views)           │
│ Upcoming     │ ───────────────────────────────────────────────     │
│ Projects     │ Task list / table / buckets / timeline              │
│ (favourites  │ "Add a task" input at the top of the list           │
│  at the top) │                                                      │
│ Labels       │                                                      │
│ Teams        │                                                      │
│ Trash        │                                                      │
└──────────────┴─────────────────────────────────────────────────────┘
```

Sketch from the help text. Named items: Overview, Upcoming, Projects, Labels, Teams, Trash (sidebar and keyboard reference); views and the three-dot menu of the project (Views help).

## Regions

- **Sidebar**: navigation; favourited projects at the top; projects can be dragged under a parent (Projects help). Shown or hidden with Ctrl+E / Cmd+E (keyboard reference).
- **Project header**: title, three-dot menu (Edit, Create sub-project, Archive, Duplicate, Delete), view switch.
- **Task detail view**: opened by clicking a task (in list, kanban or table; in Gantt by double-click). Title at the top (inline edit); **Done** button at the top of the right sidebar; right sidebar holds Labels, Priority, Progress, Color, Assignees, Dates, Attachments; **Delete** at the bottom of the right sidebar (Tasks help).
- **Kanban board**: buckets as columns; a field at the far right creates a bucket; each bucket has a three-dot menu (Views help).
- **Gantt**: tasks as bars from start to end date; filtering not available (Views help).

## UI/UX

- Dark mode, colours and density: `[offen]`.
- Project colour appears in the sidebar and on the overview page (Projects help).

## Interactions

- Drag and drop: between buckets, between projects (sidebar), and to nest projects. Manual reordering in List is drag-only (accessibility page).
- Keyboard: see [shortcuts.md](shortcuts.md); "You can reach and open every task without dragging, clicking, or pointing." (accessibility page).

## Responsive design

- `[offen]`: the mobile layout. A mobile app is not named on the read pages.

## Accessibility

- "Vikunja is built with semantic structure that assistive technology can use." (accessibility page)
- Screen readers: VoiceOver works best with Safari, NVDA with Chrome or Firefox; VoiceOver with Firefox announces headings and languages poorly (accessibility page, the project's own statement).
- Known gaps (accessibility page): Kanban card reordering and List reordering are drag-only; renaming a Kanban bucket needs a pointer.
