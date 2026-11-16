# Matrix Spaces - Features

> [Matrix Spaces](../index.md)

## Grouping

- Spaces group rooms and people; the left panel filters to the selected space [S3].
- Rooms link to a space via `m.space.child` / `m.space.parent` [S1].
- Hierarchy endpoint (`GET /_matrix/client/v1/rooms/{roomId}/hierarchy`) is named in the spec table of contents [S1]; its behaviour: [offen].

## Access

- Rooms can be restricted to space members at creation time [S2].
- Joining without invitation: earlier history of an encrypted room is not shown to the person [S2].

## Not covered by fetched sources

- Nested spaces (space inside space) in the UI: [offen].
- Ordering of children within a space: [offen] (listed in spec TOC only [S1]).
- Suggested rooms and canonical room: [offen].
- Leaving a space: [offen].
- Deleting a space: [offen].

## Sources

| Kennung | Quelle (URL) | Art | Abgerufen |
|---|---|---|---|
| S1 | https://spec.matrix.org/v1.19/client-server-api/ | Spezifikation (Inhaltsverzeichnis) | 2026-11-16 |
| S2 | https://element.io/help | Hilfeseite (Element) | 2026-11-16 |
| S3 | https://docs.element.io/latest/element-support/quick-start-guide/the-left-panel/ | Benutzerdokumentation | 2026-11-16 |
