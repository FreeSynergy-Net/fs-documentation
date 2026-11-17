# Help

Help for the windows of FreeSynergy programs. Every view of every window has a page of its own, and its address stays the same, so that **F1** in a window can open exactly the page that belongs to what you are looking at ([ADR 0065](../decisions/0065-standard-fensterhuelle.md)).

An address looks like this: `help/<program>/<view>/`, for example `help/tasks/list/`. The programs that have a window today are listed below. A program without a window has no help pages yet.

## Where the help comes from

Help is documentation, not a second copy: the manual of a program lives in the wiki, and every paragraph is a block with a purpose, for the help in the window `help.<topic>`. The help in the window, the description in the Store and the manual are **the same source**, so nothing is maintained twice ([ADR 0072](../decisions/0072-bloecke-als-quelle-fuer-texte.md)). Every program brings its help as a read-only wiki (ADR 0097, paragraph 2). This is decided, not built yet. Until then the help comes from this documentation (ADR 0065).

The window itself, the shell, is part of the scaffold of every program: the starter (`fs-starter`) starts it, `fs-session` restores the work, and `fs-update` keeps the program up to date ([ADR 0065](../decisions/0065-standard-fensterhuelle.md), [ADR 0097](../decisions/0097-standardgeruest-module-arbeitsweise.md)).

## Programs

- [Store](packages/index.md): install and update everything else.
- [Tasks](tasks/index.md)
- [People](people/index.md)
- [Calendar](calendar/index.md)
- [Files](files/index.md)
- [Maps](maps/index.md)
- [Wiki](texts/index.md)
- [Groups](groups/index.md)

New to FreeSynergy? Start with [Get started](../start/index.md) and the [glossary](../start/glossary.md).
