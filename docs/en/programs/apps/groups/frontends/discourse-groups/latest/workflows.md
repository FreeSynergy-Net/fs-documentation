# Discourse Groups - Workflows

> [Discourse Groups](../index.md)

## W1 Create group
- Goal: a new group exists.
- Precondition: admin, or moderator if `moderators_manage_groups` is enabled [S5].
- Steps: user opens the Groups page -> clicks "New Group" -> fills in name, owners, members, membership, visibility -> clicks "Create" [S5].
- Errors: [offen].
- Undo: [offen].

## W2 Nest group under a parent group
- Goal: [offen]. Not documented in S1-S5.

## W3 Add member
- Goal: a user becomes a member.
- Precondition: at least one owner if requests are used [S2, S4].
- Direct add: owner adds a member -> member appears in the list [S1].
- Request: user clicks "Request" -> owners get the request with accept or reject links -> owner accepts [S2].
- Free join: user clicks "Join" -> user is a member [S2].
- Errors: requests cannot be enabled without an owner [S4].
- Undo: see W4.

## W4 Remove member or leave
- Owner removes a member [S1].
- Admin removes a member via the wrench icon on the Members tab [S2].
- User clicks "Leave" if the group allows free leaving [S2].
- Errors: [offen].
- Undo: re-add via W3.

## W5 Invite and accept or decline
- Admins and owners can invite users [S4]. Admins can name owners when adding or inviting [S1].
- Accept or decline flow for the invited user: [offen].
- Undo: [offen].

## W6 Change role
- Goal: a member becomes owner, or ownership is removed.
- Precondition: admin; only admins appoint owners [S1].
- Steps: admin opens Members tab -> wrench icon beside the member -> "Make Owner" [S1]. Admin can also remove ownership [S2].
- From Discourse 3.1 owners can add owners, but only staff can remove them [S1].
- Errors: [offen].
- Undo: admin removes ownership [S2].
- Moderator and member role details: [offen].

## W7 Delete group (and restore)
- Goal: [offen]. Not documented in S1-S5.
