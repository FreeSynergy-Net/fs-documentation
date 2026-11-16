# Vikunja - Description

## What the program does

Vikunja organises work in projects. Each project has tasks, labels, due and reminder dates, and one or more views: List, Table, Kanban or Gantt. Projects can nest (sub-projects), be archived, favourited, and shared with users, teams or by link. Tasks can be related to each other (task relations).

## Advantages

- **Open source** under AGPL-3.0 (repository LICENSE file). Self-hosting is the project's own model; Vikunja Cloud is the hosted variant.
- **Four views** per project, and several views per project from version 0.24.0.
- **API with tokens** (see [api.md](api.md)) and a documented keyboard reference.

## Differentiation

No comparison is stated here. The comparison pages on vikunja.io (Trello, Planka, WeKan, Notion) were listed in a search result but not opened; a differentiation table needs a source per row `[offen]`.

The read help pages show the features that set Vikunja apart within one project: four views (List, Table, Kanban, Gantt), kanban WIP limits, and labels that belong to a person rather than a project (see [features.md](features.md)).

## Technical details

- **Model**: self-hosted (own server) or Vikunja Cloud (hosted). Clients: web app, desktop app (help topic), CalDAV (help topic).
- **Authentication**: API tokens (recommended), JWT via login on self-hosted instances; Vikunja Cloud has no username/password login (API documentation).
- **Licence**: AGPL-3.0 (repository).

## Who it suits

- Teams and individuals who want a self-hosted task manager with several views per project.
- FreeSynergy frontends: the view model (one project, several views with their own filters) and the kanban WIP limit are references for the Board and List views (see [features.md](features.md)).
