# Google Groups - Workflows

> [Google Groups](../index.md) · Workflows

## W1 Create a group

- Goal: new group with its own address [S2].
- Precondition: signed in, name and address chosen [S2].
- Steps: user opens Google Groups -> clicks "Create group" -> enters name, description, email address and settings [S2] -> clicks "Create group" -> program creates the group [S2].
- Steps after: optional advanced settings [S2].
- Errors: messages sent too early (wait a few minutes) [S2]. Option missing: work/school-only or admin-controlled [S2].
- Undo: delete the group (W7) [S4].

## W2 Nest a group in another group

- Goal: group becomes a member of another group [offen].
- Precondition: [offen].
- Steps: [offen]. Nested groups exist [S5].
- Errors: [offen].
- Undo: [offen].

## W3 Add a member directly

- Goal: person joins at once [S3].
- Precondition: owner or manager with the right to manage members [S6].
- Steps: user opens Members -> "Add members" -> direct adding on -> enters email addresses, optional welcome message -> confirms -> program adds the person and sends an email notification [S3].
- Role: user picks member, manager or owner [S3].
- Errors: child accounts cannot be added [S3]. Users without Google account not added directly to @googlegroups.com groups [S3]. External users not added to internal groups until changed [S3].
- Undo: remove member (W4) [offen: removal steps not read].

## W4 Remove a member or leave

- Goal: person leaves or is removed [S5].
- Steps, leave: member clicks leave on the group page -> confirms [S5].
- Steps, stop email only: member sets subscription to no email [S5].
- Steps, unsubscribe by mail: send an empty message to the group address with "+unsubscribe" before the domain [S5].
- Steps, removal by owner or manager: [offen].
- Errors: required group in work/school accounts cannot be left [S5]. Emails continue after unsubscribing: check address, forwarding, multiple addresses, nesting [S5]. Leaving is desktop-only [S5].
- Undo: join again (article exists) [S1], steps [offen].

## W5 Invite and accept or decline

- Goal: person gets invitation and joins [S3].
- Steps: owner opens Members -> "Add members" -> direct adding off -> enters emails, optional message -> sends [S3]. Invitee accepts [S3].
- Accept or decline in the program UI: [offen].
- Role on invitation: not specified [S3].
- Errors: external user to internal group [S3]. Account without Google account can be invited [S3].
- Undo: cancel or resend pending invitations [S3].

## W6 Change a role or right

- Goal: change between owner, manager and member [S6].
- Owner: full control, includes deletion, making other owners, changing other owners' settings, exporting data [S6].
- Manager: nearly all owner rights except deletion, making owners, changing owner roles or subscription settings [S6].
- Member: basic rights by default, owner or manager can expand or limit them [S6].
- Admin: can remove some owner rights (not viewing members or conversations) [S2].
- Steps to change a role after adding: [offen].
- Errors: [offen].
- Undo: [offen].

## W7 Delete and restore a group

- Goal: remove group [S4].
- Precondition: owner (only owner may delete) [S4].
- Steps: user opens group -> Group settings -> chooses delete -> confirms [S4]. Deleted group leaves search and directory [S4].
- Restore: no restore article found; deleted groups cannot be restored [S4]. Restore steps: [offen].
- Alternative: restrict posting instead of deleting (General and Posting policies) [S4].
- Errors: non-owner cannot delete [S4].
- Undo: none [S4].
