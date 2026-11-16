# Microsoft 365 Groups - Features

> [Microsoft 365 Groups](../index.md) · Features

## Creating and editing

- Create with name, unique email alias, optional description, optional sensitivity label, public or private, welcome emails, who may send, external senders [S1].
- Edit name and description [S1][S3].
- Change the email address (admin center, or PowerShell) [S3].

## Membership

- Owners add and remove members and owners [S2][S3][S5].
- Adding a member sends an invitation to that person [S1].
- By default members may invite guests; admins can change this [S2].
- Guests are outside people invited to take part [S2][S6].
- Dynamic membership rules add or remove members from attributes [S7].

## Governance

- Expiration policy with renewal reminders [S2].
- Sensitivity labels set privacy, guest access and unmanaged device access [S2].
- Audit logs record who created or deleted a group and who changed its membership [S7].
- Settings: send copies of conversations to member inboxes; allow outside senders to email the group [S3].

## Nesting

- Security groups can be nested [S5].
- Microsoft 365 groups cannot be added to security groups or to other Microsoft 365 groups [S5].

## Deletion

- Delete a group (owner, or in Entra by an admin) [S1][S5].
- Restore within 30 days (see W7) [S4].
- Permanent purge via PowerShell before the 30 days end [S3].
- Restore covers members, email addresses, shared inbox and calendar, SharePoint site, OneNote, Planner and Teams [S4].
