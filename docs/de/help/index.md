# Hilfe

Hilfe zu den Fenstern der FreeSynergy-Programme. Jede Ansicht jedes Fensters hat eine eigene Seite, und ihre Adresse bleibt gleich, damit **F1** in einem Fenster genau die Seite öffnen kann, die zu dem gehört, was du gerade siehst ([ADR 0065](../decisions/0065-standard-fensterhuelle.md)).

Eine Adresse sieht so aus: `help/<programm>/<ansicht>/`, zum Beispiel `help/tasks/list/`. Unten stehen die Programme, die heute ein Fenster haben. Ein Programm ohne Fenster hat noch keine Hilfe-Seiten.

## Woher die Hilfe kommt

Die Hilfe ist Dokumentation, keine zweite Kopie: Das Handbuch eines Programms liegt im Wiki, und jeder Absatz ist ein Block mit einem Zweck, für die Hilfe im Fenster `help.<thema>`. Die Hilfe im Fenster, die Beschreibung im Store und das Handbuch sind **dieselbe Quelle**, sodass nichts doppelt gepflegt wird ([ADR 0072](../decisions/0072-bloecke-als-quelle-fuer-texte.md)). Jedes Programm bringt die Hilfe als Lese-Wiki mit (ADR 0097, Absatz 2). So ist es entschieden; gebaut ist es noch nicht. Bis dahin kommt die Hilfe aus dieser Dokumentation (ADR 0065).

Das Fenster selbst, die Hülle, gehört zum Gerüst jedes Programms: Der Starter (`fs-starter`) startet es, `fs-session` stellt die Arbeit wieder her, und `fs-update` hält das Programm aktuell ([ADR 0065](../decisions/0065-standard-fensterhuelle.md), [ADR 0097](../decisions/0097-standardgeruest-module-arbeitsweise.md)).

## Programme

- [Store](packages/index.md): alles Weitere installieren und aktuell halten.
- [Tasks](tasks/index.md)
- [People](people/index.md)
- [Calendar](calendar/index.md)
- [Files](files/index.md)
- [Maps](maps/index.md)
- [Wiki](texts/index.md)
- [Groups](groups/index.md)

Neu bei FreeSynergy? Fang mit [Loslegen](../start/index.md) und dem [Glossar](../start/glossary.md) an.
