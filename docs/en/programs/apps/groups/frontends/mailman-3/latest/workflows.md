# Mailman 3 - Workflows

> [Mailman 3](../index.md)

## W1 Create list
- Goal: [offen]. No list creation step is documented in S1-S3.

## W2 Nest list under a parent or group
- Goal: [offen]. Not documented in S1-S3.

## W3 Add member (subscribe)
- Goal: a user subscribes to a list.
- Precondition: the list is known; an account is optional [S1].
- Steps: user opens the list information page -> optionally signs up -> chooses address and optional display name in the subscribe section -> submits [S1].
- Without account: user uses the subscribe boxes at the bottom of the page [S1].
- Admin or moderator adds a member, or approves a request: [offen].
- Errors: [offen].
- Undo: see W4.

## W4 Remove member or leave
- Goal: a user stops receiving the list.
- Steps: user logs in to show control of the address -> opens the subscription section -> clicks unsubscribe [S1].
- Owner removes a member: [offen].
- Undo: re-subscribe via W3.

## W5 Confirm subscription or invitation
- Joining: no separate confirmation email is described [S1].
- Confirmation is required when proving ownership of an address, for example for an existing subscription [S1].
- Invitation flow: [offen].

## W6 Change role or settings
- Roles: list owners maintain one list; moderators review posts before they go out; site administrators maintain the software [S1].
- Roles are assigned per list; they do not need superuser accounts [S2].
- User changes own delivery settings: user menu -> "Mailman settings" -> change setting [S1].
- Changing an owner or moderator of a list: [offen].

## W7 Delete list (and restore)
- Goal: [offen]. Not documented in S1-S3.
