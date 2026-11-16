# Microsoft 365 Groups - Workflows

> [Microsoft 365 Groups](../index.md) · Workflows

## W1 Create a group

- Goal: new group with shared resources [S1][S2].
- Precondition: user with permission to create groups (admins may limit this) [S2].
- Steps (user): opens the groups page -> create -> enters name, unique email alias, description, optional options -> Create [S1]. The program makes the creator owner and member [S1].
- Steps (admin, Entra): New group -> group type -> name, email address, description, membership type, optional owners and members -> Create [S5].
- Errors: alias not unique [S1]. Options missing: admin policy [S1]. Limit of 250 groups per user [S2].
- Undo: delete (W7) [S1].

## W2 Nest a group in another group

- Goal: group becomes a member of another group [S5].
- Microsoft 365 groups cannot be added to another Microsoft 365 group or to a security group [S5].
- Security group: All groups -> group -> Group memberships -> Add memberships -> choose group -> Select [S5].
- Errors: unsupported combinations [S5].
- Undo: Group memberships -> Remove [S5] (for security groups).

## W3 Add a member

- Goal: person becomes member [S1].
- Steps (owner): open group -> add (+) -> search person -> add [S1].
- Steps (admin center): Teams & groups -> Active teams & groups -> group -> Membership -> Members -> Add [S3].
- Steps (Entra): All groups -> group -> Members -> Add, choose names -> Select [S5].
- Result: person receives an invitation [S1].
- Errors: admin role missing [S5]. Groups with more than 1,000 members: delays in group conversations [S2].
- Undo: remove (W4).

## W4 Remove a member or leave

- Goal: person removed [S3][S5].
- Steps (admin center): Membership -> Members -> click X next to the name -> Close [S3].
- Steps (Entra): Members or Owners -> check name -> Remove [S5].
- Steps (member leaving): [offen].
- Errors: membership of groups synced from on-premises or dynamic groups: [offen].
- Undo: add back (W3).

## W5 Invite, accept or decline

- Goal: outside person joins as guest, or member gets invitation [S1][S2].
- Steps: owner adds a person (W3) -> person receives an invitation [S1].
- Members may invite guests by default; admins can change this [S2].
- Accept or decline: [offen].
- Cancel or resend an invitation: [offen].
- Undo: [offen].

## W6 Change a role

- Goal: member becomes owner or the reverse [S5].
- Roles: owners manage membership and settings; members use resources but cannot change settings [S2][S3].
- Steps: admin center: Membership -> choose Owners or Members -> Add or X [S3]. Entra: Owners -> + Add, or select name -> Remove [S5].
- Limit: 100 owners per group [S2].
- Group type cannot be changed later [S1].
- Errors: owner limit reached [S2].
- Undo: remove from Owners list [S5].

## W7 Delete and restore a group

- Goal: remove group [S1][S5].
- Steps (owner): open group -> Delete group -> confirm with Yes [S1].
- Steps (Entra admin): All groups -> select group -> Delete [S5].
- Soft delete: kept for 30 days [S4].
- Restore (owner, in Outlook): deleted groups page -> Restore tab [S4].
- Restore (admin center): Groups -> Deleted groups -> select -> Restore group [S4].
- Restore (PowerShell): see Entra restore article [S4].
- Permanent deletion before 30 days (PowerShell): [S3].
- Errors: after 30 days not restorable [S4]. Restored group: mail may fail for one hour [S4]. Owner help article calls deletion permanent [S1], which conflicts with the 30-day restore [S4]; resolved: [offen].
- Undo: restore within 30 days [S4].
