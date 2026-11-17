# ToDo – SignPath (Windows-Code-Signing)

Ziel: Windows-Programme von FreeSynergy (.exe/.msi) werden über die kostenlose Open-Source-Förderung der SignPath Foundation signiert.

## Status

**Vorbereitung offen: Policy + CI.**

- [ ] Code-Signing-Policy-Seite schreiben (Gliederung in [bericht.md](bericht.md), Abschnitt 4). Rollen Author, Reviewer, Approver sind noch zu benennen.
- [ ] Signier-Schritt für den Release-Lauf in `fs-release` vorbereiten (Plan in [bericht.md](bericht.md), Abschnitt 3), mit Haltepunkt für die manuelle Freigabe.
- [ ] Offene Fragen aus [bericht.md](bericht.md), Abschnitt 4, beantworten.

**Eigentümer beantragt:** Die Bewerbung bei der SignPath Foundation stellt der Eigentümer selbst. Wir bereiten Policy und CI vor.

**Entscheidung des Nutzers (76/77):** Die Signier-Umgebung kommt später; bis dahin wird nur vorbereitet. Bis zum Kontowechsel bleiben Repo-Secrets; Prüfer wird später das Konto FreeSynergy (Variante b). Harte Sperre: Claude/Agents erteilen nie eine Deployment- oder Signatur-Freigabe.

## Inhalt

- [bericht.md](bericht.md): Recherche-Bericht (Stand 2026-11-13, nur Recherche, kein Code): Bedingungen der SignPath Foundation, GitHub-Action zum Einreichen, Plan für den Release-Lauf, Gliederung der Policy-Seite, Alternativen, Grenzen der Recherche. Unbelegtes ist darin mit **[nicht belegt]** markiert.
- [bericht-kurz.md](bericht-kurz.md): Kurzfassung des Recherche-Berichts (Stand 16.11., Herkunft siehe Kopfzeile der Datei); die Vollversion bleibt [bericht.md](bericht.md).
