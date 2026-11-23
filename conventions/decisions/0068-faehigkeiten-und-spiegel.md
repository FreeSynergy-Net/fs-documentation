# ADR 0068: Fähigkeiten statt fester Anforderungen; fremde Pakete werden gespiegelt

- **Status:** akzeptiert (Nutzer, 2026-11-10); gebaut wird nach Runde 3b
- **Bezug:** ADR 0015 (Fremdprojekte), 0017 (Repo-Namen), 0045 (Themen-Schnittstellen als Ziele), 0063 (Facetten), 0066 (`supported` je Befehl), Katalog `fs-catalog` (TUF)

## 1. Fähigkeiten (Provides/Requires)
- Jedes Paket im Katalog meldet, **was es anbietet**: Themen-Schnittstellen mit Version, z. B. `people.persons 1.2`, `people.users`, `identity.oidc`, `identity.accounts`, `groups`.
- Und **was es braucht** (Pflicht) oder **gut gebrauchen kann** (Empfehlung), mit Mindestversion, z. B. Kanidm braucht etwas, das Personen und Gruppen verwaltet.
- Facetten genauso: „Kontakte“ braucht `people.persons`; ob das `fs-people` liefert oder eine Suite, ist gleich.
- Der Store löst auf: gibt es einen Anbieter, nimmt er ihn; gibt es mehrere, bietet er die Auswahl an; fehlt einer, sagt er es.
- Abbildung auf Standards: AppStream `<provides>`/`<requires>`/`<recommends>`; in rpm und deb als versionierte virtuelle Pakete (`Provides: freesynergy-iface(people.persons) = 1.2`). Kein eigenes Format.
- Fremde Programme (Kanidm, Zentinel, Stalwart …) bekommen ihre Fähigkeiten von uns im Katalog eingetragen; sie müssen nichts ändern.
- Zur Laufzeit meldet die Schnittstelle selbst, was wirklich geht (Typbeschreibung, `supported`). Der Store prüft beim Installieren, die Schnittstelle beim Benutzen.

## 2. Fremde Pakete werden gespiegelt, nicht verlinkt
- Pakete der Macher (signiert, wo vorhanden) werden **in unsere Quelle kopiert**: Signatur und Prüfsumme beim Übernehmen prüfen, dann mit unserem Schlüssel im Katalog (TUF) signieren.
- Ändert oder schließt ein Macher sein Repo, geht bei uns nichts kaputt: es bleibt die letzte Version, bis wir nachziehen.
- Zu jedem gespiegelten Paket wird der **Quellcode** derselben Version mitgespiegelt (Pflicht bei Copyleft wie AGPL, z. B. Stalwart; außerdem können wir so selbst weiterbauen, wenn ein Projekt die Lizenz wechselt oder eingestellt wird, wie bei Redis oder OpenOffice).
- Lizenzdateien bleiben bei den Paketen. Gespiegelt wird nur, was die Lizenz erlaubt.
- Selbst gebaut wird nur, wo ein Format fehlt (z. B. rpm für ein System, Windows-Paket). Dafür, und nur dafür, gibt es Forks (nur Paketbau, Korrekturen gehen upstream).
- Macher können ihre Quelle auch direkt an unseren Katalog anschließen.
- Dateien liegen nicht in der Git-Geschichte, sondern als Release-Dateien bzw. auf unserem Paket-Server; der Katalog nennt sie.

## 3. Namen und Adressen
- Programm `fs-store` (für Menschen **FreeSynergy.Store**), Paketliste `fs-catalog`.
- Heute: Quelle der Wahrheit ist `github.com/FreeSynergy/fs-catalog`.
- Später auf eigenem Server nach der Subdomain-Regel (Name ohne `fs-`): **`catalog.freesynergy.net`** für Katalog und Paketquellen (dnf, apt, Flatpak, winget, Homebrew); `store.freesynergy.net` bleibt frei für eine Web-Fassung des Stores.

## Folgen
- Thread T: Fähigkeiten-Namen = Namen der Themen-Schnittstellen (eine Liste, in `fs-interfaces`).
- `fs-catalog`: Felder für provides/requires/recommends, Spiegel-Herkunft (Quelle, Upstream-Signatur, Quellcode-Datei).
- Prüfen (Haiku): Welche Pakete bieten Kanidm, Zentinel, Stalwart selbst an, signiert, in welchen Formaten, unter welcher Lizenz.

## Nachtrag 2026-11-16: Status `planned`
- Die eine Liste (`fs-interfaces`, `schema/capabilities.txt`) führt je Name einen Status: `stable` (Schnittstelle gebaut) oder `planned` (Name festgehalten, Schnittstelle kommt später). Ein `planned`-Name ist bekannt (`is_known`), `is_planned` sagt es; der Katalog-Check (`fs-catalog`) nimmt ihn an und **warnt** nur, ein Paket darf ihn also schon anbieten.
- Als `planned` geführt (Stand: `fs-interfaces` v0.0.21): `storage.provider` (seit v0.0.19), `identity.oauth2`, `identity.ssh-keys`, `identity.passkeys` (seit v0.0.20), **neu in v0.0.21** `gateway.reverse-proxy` (Zentinel), `messages.matrix` und `messages.matrix.oidc-server` (Tuwunel; Anmeldeserver nur für Matrix-Clients, kein Anmeldedienst für andere Programme). Der Schlüssel heißt `messages.*` passend zum künftigen `fs-messages` (ADR 0087); das bestehende Thema `messenger` wird später zu `messages` umbenannt.
- Nur Namen und Kurzbeschreibung; die vollen Schnittstellen (Cap'n Proto) kommen später, Namen werden nie umbenannt oder entfernt.

## Nachtrag 2026-11-23: Versionen dreiteilig

Status: **entschieden** (Entscheid Strategie 23.11., Nutzer informiert) · ändert in §1 nur das Zahlenformat · Regel: ADR 0045, Nachtrag 2026-11-23 „eine Versionsregel“
- Schnittstellen-Versionen sind dreiteilig nach SemVer und werden `name@x.y.z` geschrieben. Aus `people.persons 1.2` (§1, Z. 7) wird `people.persons@1.2.0`; ein Bedarf ist ein Bereich wie `people.persons@^1.2.0`.
- Das virtuelle rpm/deb-Paket (§1, Z. 11) trägt ebenfalls drei Teile: `Provides: freesynergy-iface(people.persons) = 1.2.0`. rpmvercmp ordnet `1.2` vor `1.2.0`. Gemischte Formen würden also falsch verglichen; einheitlich dreiteilig ist sicher.
- Wie ein Caret-Bereich als rpm-Abhängigkeit geschrieben wird (z. B. mit `with` zwischen `>=` und `<`), ist [nicht belegt] und wird erst mit dem Paketbau entschieden.
- Versionen gespiegelter fremder Pakete (§2) sind Paketversionen: Für sie gilt RPM-EVR, nicht SemVer (ADR 0045, Nachtrag, Nr. 7).
