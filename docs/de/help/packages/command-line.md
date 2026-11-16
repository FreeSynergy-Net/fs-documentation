# Kommandozeile

Der Store ist ein einziger Befehl, `fs-packages`. Ohne Argumente öffnet er das Fenster. Mit einem Unterbefehl arbeitet er ähnlich wie `git`. Eine Quelle ist eine Git-Adresse (https oder file://), die eine signierte `catalog.xml` enthält.

Wenn ein Befehl fehlschlägt, schreibt er `fs-packages: ` und eine Meldung auf die Fehlerausgabe und endet mit einem Fehlercode.

## Unterbefehle

**Quellen**

    fs-packages sources

Listet deine Quellen auf: ID, `on` oder `off`, Adresse und `(reference)` für die eingebaute Quelle. Mit `add <url>`, `enable <id>`, `disable <id>` oder `remove <id>` änderst du die Liste:

    fs-packages sources add https://example.org/packages

Eine falsche Form gibt aus: `usage: fs-packages sources [add <url> | enable <id> | disable <id> | remove <id>]`.

**Verfügbar**

    fs-packages available

Gibt "name version" für jedes Programm aus, das die eingeschalteten Quellen anbieten. Gib eine Quellen-ID oder Git-Adresse an, um nur diese eine zu lesen. Einträge, die nicht angeboten werden, werden als `skipped (id): (reason)` ausgegeben. Kann eine Quelle nicht gelesen werden, nennt der Befehl den Grund und endet mit "a source could not be read".

**Installieren**

    fs-packages install fs-tasks

Installiert ein Programm, optional aus einer bestimmten Quelle (`install <name> [source]`). Bei Erfolg gibt er `installed (name) (version)` aus. Bietet keine Quelle es an, gibt er "(name) is not offered by any source" aus.

**Aktualisieren**

    fs-packages update fs-tasks

Aktualisiert ein Programm, aber nur, wenn die Quelle eine neuere Version anbietet; sonst gibt er "(name) is up to date (version)" aus. Ist es nicht installiert, gibt er "(name) is not installed; use install" aus. `fs-packages update` allein oder `fs-packages update --all` aktualisiert jedes Programm, für das automatische Updates eingeschaltet sind, und sagt, wie viele nicht aktualisiert werden konnten.

**Installiert**

    fs-packages installed

Gibt für jedes installierte Programm "name version" aus.

**Deinstallieren**

    fs-packages uninstall fs-tasks

Entfernt das Programm und gibt `removed (name)` aus. `remove` funktioniert genauso. Deine Daten bleiben erhalten.

**Prüfen**

    fs-packages check

Sagt, welche installierten Programme eine neuere Version haben, als "name old -> new", und installiert nichts. Gibt es keine, wird "everything is up to date" ausgegeben.

**Automatisch**

    fs-packages auto fs-tasks on

Schaltet automatische Updates für ein Programm ein oder aus. Jede andere Eingabe als `on` oder `off` gibt `usage: fs-packages auto <name> on|off` aus.

**Einstellungen**

    fs-packages settings check daily

Ohne Argumente zeigt er die aktuellen Einstellungen. `check` nimmt off, start, daily oder hourly. `install` nimmt ask oder auto. `notify` nimmt on oder off. Er gibt eine Zeile aus wie "check Daily, install Ask, notify true".

**Hintergrund**

    fs-packages background

Sucht einmal nach Updates, merkt sich, was er gefunden hat, sagt dir, ob Benachrichtigungen eingeschaltet sind, und installiert Updates, wenn du **Automatically** gewählt hast. Steht **Look for updates** auf Off, tut er nichts. Genau das führt der Timer aus.

**Timer**

    fs-packages timer enable

Auch `disable` und `status`. Richtet einen systemd-Benutzer-Timer ein oder entfernt ihn. `enable` braucht, dass die Prüfung täglich oder stündlich ist; sonst gibt er aus, dass der Timer nicht nötig ist, und zeigt `fs-packages settings check daily|hourly`.

**Version**

    fs-packages version

Gibt die Version aus und ob Programme als rpm oder tar.gz kommen. `--version` und `-V` tun dasselbe.

**Fenster**

    fs-packages --size 1000x700

Öffnet das Fenster. `gui` funktioniert auch. `--size WxH` legt die Größe fest.

## Option für alle Unterbefehle, die Quellen lesen

`--trust-key (file)` vertraut für diesen einen Lauf zusätzlich einem weiteren öffentlichen Schlüssel. Das ist für das Testen einer lokalen Quelle gedacht.

## Sonstiges

`fs-packages serve` startet den Server des Stores. Er wird hier nicht beschrieben. Führst du `fs-packages` als root aus, verweigert er das und erklärt warum.

[Zurück zur Store-Hilfe](index.md)
