# Command line

The Store is one command, `fs-packages`. With no arguments it opens the window. With a subcommand it works like `git`. A source is a Git address (https or file://) that holds a signed `catalog.xml`.

When a command fails, it prints `fs-packages: ` and a message on the error output, and ends with a failure code.

## Subcommands

**Sources**

    fs-packages sources

Lists your sources: id, `on` or `off`, address, and `(reference)` for the built-in one. With `add <url>`, `enable <id>`, `disable <id>` or `remove <id>` it changes the list:

    fs-packages sources add https://example.org/packages

A wrong form prints: `usage: fs-packages sources [add <url> | enable <id> | disable <id> | remove <id>]`.

**Available**

    fs-packages available

Prints "name version" for every program the switched-on sources offer. Give a source id or Git address to read only that one. Entries that are not offered are printed as `skipped (id): (reason)`. If a source cannot be read the command prints why and ends with "a source could not be read".

**Install**

    fs-packages install fs-tasks

Installs a program, optionally from one source (`install <name> [source]`). On success it prints `installed (name) (version)`. If no source offers it, it prints "(name) is not offered by any source".

**Update**

    fs-packages update fs-tasks

Updates one program, only if the source offers a newer version; otherwise it prints "(name) is up to date (version)". If it is not installed, it prints "(name) is not installed; use install". `fs-packages update` alone, or `fs-packages update --all`, updates every program that has automatic updates on, and says how many could not be updated.

**Installed**

    fs-packages installed

Prints "name version" for each installed program.

**Uninstall**

    fs-packages uninstall fs-tasks

Takes the program away and prints `removed (name)`. `remove` works the same. Your data stays.

**Check**

    fs-packages check

Says which installed programs have a newer version, as "name old -> new", and installs nothing. If none, it prints "everything is up to date".

**Auto**

    fs-packages auto fs-tasks on

Switches automatic updates on or off for one program. Anything else than `on` or `off` prints `usage: fs-packages auto <name> on|off`.

**Settings**

    fs-packages settings check daily

Without arguments it prints the current settings. `check` takes off, start, daily or hourly. `install` takes ask or auto. `notify` takes on or off. It prints a line such as "check Daily, install Ask, notify true".

**Background**

    fs-packages background

Looks for updates once, remembers what it found, tells you if notifications are on, and installs updates if you chose Automatically. It does nothing when **Look for updates** is Off. This is what the timer runs.

**Timer**

    fs-packages timer enable

Also `disable` and `status`. It sets up or removes a systemd user timer. `enable` needs the check to be daily or hourly; otherwise it prints that the timer is not needed and shows `fs-packages settings check daily|hourly`.

**Version**

    fs-packages version

Prints the version and whether programs come as rpm or tar.gz. `--version` and `-V` do the same.

**Window**

    fs-packages --size 1000x700

Opens the window. `gui` also works. `--size WxH` sets the size.

## Option for all subcommands that read sources

`--trust-key (file)` also trusts one more public key for that run. It is meant for testing a local source.

## Other

`fs-packages serve` starts the Store's server. It is not described here. If you run `fs-packages` as root, it refuses and explains why.

[Back to Store help](index.md)
