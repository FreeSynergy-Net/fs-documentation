# Microsoft 365 Groups - States

> [Microsoft 365 Groups](../index.md) · States

## Group states

- Soft-deleted: restorable for 30 days; then permanently deleted [S4].
- Restored: members and content come back, may take up to 24 hours [S4].
- Restored, mail not yet working: wait at least one hour before sending mail, otherwise a 550 5.1.10 RecipientNotFound error [S4].
- Ownerless: an automated system assigns a new owner [S6].
- Expired: owners get reminders; unrenewed groups are deleted [S2].

## Access states

- Admin role needed for membership changes: Groups Administrator or User Administrator [S5].
- Delegated admin: cannot manage these groups [S2].
- Owner limit reached (100) [S2].
- Group creation limited by admin policy: user cannot create SharePoint, Planner, Teams and similar [S2].

## Invitation states

- Member added: person receives an invitation [S1]. Accept or decline in the program: [offen].

## Not documented

- Empty state: [offen]
- Loading state: [offen]
- Generic error messages: [offen]
- Pending invitation list and how to cancel it: [offen]
