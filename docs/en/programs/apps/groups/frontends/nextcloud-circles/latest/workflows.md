# Nextcloud Circles - Workflows

> [Nextcloud Circles](../index.md)

Fixed IDs W1 to W7 as required. Steps are given as "user does X -> program shows Y".

## W1 Create a group

- Goal: a new named circle with members.
- Precondition: [offen] (which account or app rights are needed).
- Steps: user clicks "+" beside Teams in the left menu [S1] -> program asks for a team name [S1] -> user enters name -> program opens the configuration screen [S1] -> user adds members [S1].
- Errors: [offen].
- Undo: [offen].

## W2 Nest a group under a parent group

- Goal: a circle becomes a member of another circle.
- Precondition: [offen].
- Steps: circles can be added as members [S1] -> exact UI steps: [offen].
- Errors and undo: [offen].

## W3 Add a member directly

- Goal: add a person, group, email address or circle directly.
- Precondition: [offen].
- Steps: user adds local account, group, email address or circle as member [S1] -> program applies the group's or circle's role to all its members [S1] -> exact UI steps: [offen].
- Errors and undo: [offen].

## W4 Remove a member or leave

- Goal: a member is removed, or a member leaves.
- Precondition: [offen].
- Steps: [offen] (removal and leaving not covered by fetched sources).
- Errors and undo: [offen].

## W5 Invite and accept or decline

- Goal: invite a person who then accepts or declines.
- Precondition: [offen].
- Steps: [offen] (invitation flow not confirmed on a fetched page).
- Errors and undo: [offen].

## W6 Change a role

- Goal: change a member to Member, Moderator, Admin or Owner.
- Precondition: [offen] (who may change roles).
- Steps: user opens the three-dot menu next to a user [S1] -> user changes the role [S1] -> program applies it [offen].
- Rule: only one Owner per circle [S1].
- Errors: [offen]. Undo: [offen].

## W7 Delete a group (and restore)

- Goal: remove a circle; restore if supported.
- Precondition: [offen].
- Steps: [offen].
- Errors and undo: [offen].

## Sources

| Kennung | Quelle (URL) | Art | Abgerufen |
|---|---|---|---|
| S1 | https://docs.nextcloud.com/server/stable/user_manual/en/groupware/contacts.html | Benutzerhandbuch (Nextcloud 35, Teams) | 2026-11-16 |
