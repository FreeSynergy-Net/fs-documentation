# fs-identity – Abhak-Liste

Stand: 2026-11-16 · Quellen: DESIGN.md, README, Tags v0.0.1/v0.2.0, ADR 0047, ADR 0082
Hinweis: Belege sind Commit/Tag aus dem Repo (/srv/FreeSynergy/fs-identity, origin/main). Unklares steht als [offen].

Ehrlich: heute nur eine kleine Brücke (Kanidm spiegelt die Gruppen aus fs-groups), noch kein Login.

## Grundlagen
- [x] **GRUNDSACHE** Gruppen in Kanidm anlegen/lesen/ändern/auflisten/entfernen, wiederholbar sicher; eigener REST-Client gegen Kanidm 1.12.0 (README; Tag v0.0.1, e0b3b56)
- [x] **GRUNDSACHE** Pedantic-Clippy grün (Commit 0a80624)
- [ ] **GRUNDSACHE** Neuer Tag ab main (2 Commits nach v0.0.1) und Release [offen: keine Releases]
- [ ] **GRUNDSACHE** Name von Repo und Crate festlegen [offen: Nutzerentscheidung, „vorläufig"]
- [ ] **GRUNDSACHE** Vertragstest in CI gegen gepinnten Kanidm-Container (heute Livetest von Hand)
- [ ] **GRUNDSACHE** `apply` umbauen (handoff-strategy Punkt 9: nur nach Bestätigung des Nutzers) [offen]

## Später
- [ ] SPÄTER Mediator zwischen Personen/Gruppen und Kanidm (ADR 0082), Pilot 3 Anmeldung kanidm-unixd/PAM
- [ ] SPÄTER Anmeldung/Zugangsdaten (`kanidm_client` ungenutzt)
- [ ] SPÄTER Kontrolle zurückgeben, wenn Kanidm Einladungen (#4659), feinere Delegation (#4641), eigene Felder (#3493) kann
