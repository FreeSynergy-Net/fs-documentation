# Matrix Spaces - Workflows

> [Matrix Spaces](../index.md)

Fixed IDs W1 to W7. Steps are given as "user does X -> program shows Y".

## W1 Create a group (space)

- Goal: a new space that groups rooms and people.
- Precondition: [offen] (account rights, server rules).
- Steps: user clicks "+ Create a space" (Web/Desktop) [S3] -> user chooses public or private [S3] -> program creates the space [S3].
- Mobile: user taps the space icon and selects "create" [S3].
- Errors: [offen]. Undo: [offen].

## W2 Attach a group to a parent group (space in space, or room in space)

- Goal: link rooms or spaces to a parent space.
- Precondition: [offen].
- Steps: user adds an existing room or creates a new one in the space [S3] -> program links it [offen]; link events `m.space.child` / `m.space.parent` [S1].
- Nested space in space: [offen].
- Errors and undo: [offen].

## W3 Add a member directly

- Goal: add a person to a space without an invitation step.
- Precondition: [offen].
- Steps: user invites people to the space [S3] -> exact steps for a direct add: [offen].
- Errors and undo: [offen].

## W4 Remove a member or leave

- Goal: a member is removed or leaves.
- Precondition: [offen].
- Steps: [offen] (leaving a space not covered by fetched Element pages).
- Errors and undo: [offen].

## W5 Invite and accept or decline

- Goal: invite a person who accepts or declines.
- Precondition: [offen].
- Steps: user invites people to the space [S3] -> acceptance and decline UI: [offen].
- Room access rule: "Space members" or "Private (invite only)" [S2].
- Errors and undo: [offen].

## W6 Change a role

- Goal: change a member's role in a space.
- Precondition: [offen].
- Steps: [offen] (roles and permissions not covered by fetched sources [S3]).
- Errors and undo: [offen].

## W7 Delete a group (and restore)

- Goal: remove a space; restore if supported.
- Precondition: [offen].
- Steps: [offen].
- Errors and undo: [offen].

## Sources

| Kennung | Quelle (URL) | Art | Abgerufen |
|---|---|---|---|
| S1 | https://spec.matrix.org/v1.19/client-server-api/ | Spezifikation (Inhaltsverzeichnis) | 2026-11-16 |
| S2 | https://element.io/help | Hilfeseite (Element) | 2026-11-16 |
| S3 | https://docs.element.io/latest/element-support/quick-start-guide/the-left-panel/ | Benutzerdokumentation | 2026-11-16 |
| S4 | https://docs.element.io/latest/element-support/matrix-rooms/getting-started-creating-a-room/ | Benutzerdokumentation | 2026-11-16 |
