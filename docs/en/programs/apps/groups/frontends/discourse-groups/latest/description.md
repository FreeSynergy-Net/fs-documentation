# Discourse Groups - Description

> [Discourse Groups](../index.md)

## Scope
- A group is a named set of members inside a Discourse site [S5].
- Owners manage membership of the groups they are assigned to. They cannot create new groups [S1].
- Admins create groups and appoint owners [S1, S5]. Moderators can create groups only if the setting `moderators_manage_groups` is enabled [S5].
- Group visibility only affects the directory listing. Access to group content depends on category security [S2].

## Known gaps
- Licence of the program: [offen] (not checked against the official repository).
- Nesting of groups, group deletion and renaming: [offen] (not covered in S1-S5).
- The source S1 has a disputed comment on whether regular members can see who the owners are. Behaviour: [offen].
