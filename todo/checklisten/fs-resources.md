# fs-resources (bleibt; nach ValueFlows) – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0075, 0076, 0087 (Nachtrag 2026-11-16: fs-resources bleibt, ValueFlows); Plan `/srv/FreeSynergy/.scratch/strang-d/PLAN.md` Abschnitt 17 (der Umbenennungsplan `plan-umbenennen-inventory.md` ist VERWORFEN); Vorab-Stände `/srv/FreeSynergy/.scratch/vorab-staende-strang-c.md`; Repo `/srv/FreeSynergy/fs-resources`
Tags auf GitHub: `v0.0.1` (2026-11-08). Lokal alte Tags `v0.1.0`, `v0.2.0`. Lokal ist alles sauber (`main` = `origin/main` 8cf27c5).

## Erledigt (Beleg)
- [x] **GRUNDSACHE** Programmkern: Ressourcen, Bestand, Reservierungen, Kapazität, Zuteilungen, Gruppenlast, Bedarf und Angebot mit Reservierung beim Annehmen (Tag `v0.0.1`, `DESIGN.md` State, 115 Tests mit echten Stores)
- [x] **GRUNDSACHE** Pedantic-clippy-Gate auf `main` grün (Commit 8cf27c5)

## Grundsache: startet, einfache Dinge, beenden, Frontend
- [ ] **GRUNDSACHE** Typbeschreibung für 6 Typen (Resource, Reservation, Need, Offer, Capacity, Allocation), `fs-resources-server`, App mit 6 Backends und Fenster – nur auf `origin/r3-types` (+7, Kopf 2ad8eff, 2026-11-10; lokal nie geholt); fs-types v0.0.11, CI rot
- [ ] **GRUNDSACHE** Empfehlung der Vorabstände: übernehmen (v0.0.19, Clippy, Merge)
- [ ] **GRUNDSACHE** Programm startet, zeigt Ressourcen, lässt sich beenden (Fenstertest mit Bild)
- [ ] **GRUNDSACHE** Frontend nach neuem System mit Dossier (R2); in der Doku keine Frontend-Ordner (de: 1 Datei)
- [ ] **GRUNDSACHE** Offer/Need gegen fs-marketplace (ADR 0075, Angebot/Gesuch) abgrenzen [offen, Strategie]
- [ ] **GRUNDSACHE** Speicherung typisiert (ADR 0086) prüfen [offen]
- [ ] **GRUNDSACHE** Manifest bei fs-registry
- [ ] SPÄTER capnp-Server (muss Kapazität und Zuteilung ablehnen, solange der Transport den Aufrufer nicht kennt), Kosten, MSPDI, Fähigkeiten

## Umbenennung fs-resources → fs-inventory: ZURÜCKGENOMMEN (ADR 0087 Nachtrag 2026-11-16)
Entfällt: Namensklärung `fs-inventory`, `rename-inventory`, Doku-Ordner nach `inventory/`, preapproved-Eintrag. Offen bleiben (ohne Umbenennung) die Punkte unten.
- [ ] **GRUNDSACHE** Vorab-Branch auf fs-types v0.0.19 heben (Branch nutzt v0.0.2, v0.0.8 oder v0.0.11) und pedantic clippy grün machen; CI der Vorab-Branches ist rot (Quelle `vorab-staende-strang-c.md`)
- [ ] **GRUNDSACHE** PR #1 `ci-concurrency` mergen oder schließen (Stand 2026-11-15 offen; lokale Remote-Liste nicht aktuell) [offen]
- [ ] **GRUNDSACHE** Alt-Branches mit alten Crate-Namen: übernehmen oder archivieren (`archiv/<name>`-Tag), nicht offen lassen

## Neuschnitt nach ValueFlows (ADR 0087 Nachtrag 2026-11-16; Plan strang-d/PLAN.md Abschnitt 17)
Standard belegt: ValueFlows 1.0.0 (Ontologie `owl:versionInfo "1.0.0"`, Turtle `https://w3id.org/valueflows/ont/vf`), Spezifikation `https://www.valueflo.ws/specification/all_vf/`, Repo `https://codeberg.org/valueflows/valueflows`, Lizenz CC BY-SA 4.0, kein offizieller JSON-LD-Kontext in 1.0.0. fs-marketplace: Platzhalter-Repo gelöscht (404), Zuständigkeiten (Angebot, Gesuch, Zusage, Übergabe, Bestand, Katalog) liegen bei fs-resources.
- [ ] **GRUNDSACHE** Strategie-OK zur Abbildung (Plan Abschnitt 17): Resource→EconomicResource, Art→ResourceSpecification (neu), Need/Offer→Intent (receiver/provider), Reservation→Commitment + EconomicEvent; Capacity/Allocation/GroupShare bleiben eigenes Modul [offen, Strategie]
- [ ] **GRUNDSACHE** Thema `resources` in fs-interfaces nach ValueFlows neu schneiden (heute Entwurf „kein Standard gefunden“; Schnittstellenbruch, Review)
- [ ] **GRUNDSACHE** ResourceSpecification (Art von Sachen) als eigener Typ; `ResourceKind` und Freitext-`unit` ablösen (typisierte Einheit)
- [ ] **GRUNDSACHE** Intent als Angebot und Gesuch in einer Form (`provider`/`receiver`), auch ohne Gegenstück; Annehmen = Zusage mit Überbuchungsprüfung (heutiger Kern bleibt)
- [ ] **GRUNDSACHE** Übergabe (EconomicEvent): verbuchen, Verbrauch/Rückgabe (heutiges `finish`)
- [ ] **GRUNDSACHE** Katalog als Filter: erlaubte Art, typisierte Bedingungen (z. B. Preis = 0), Prüfung meldet nicht passende Einträge; Marktplatz = Katalog von Katalogen
- [ ] **GRUNDSACHE** ADR 0075 Nachtrag: Besitz von Angebot/Gesuch/Zusage/Übergabe/Bestand liegt bei fs-resources, nicht bei fs-marketplace (Platzhalter gelöscht) [Strategie]
- [ ] **GRUNDSACHE** Lizenzfolge CC BY-SA 4.0 für Doku-Auszüge klären (keine Ontologie ins Repo kopieren, Namensnennung + Link) [offen]
- [ ] SPÄTER Proposal mit Gegenleistung (`reciprocal`), Agreement-Bündel, Claim, Batch/Lot, Plan; Rezepte nur als Verweis auf fs-workflows
- [ ] SPÄTER Import/Export von ValueFlows (Turtle, GraphQL) am Grenzrand; JSON-LD-Kontext selbst festlegen, da keiner offiziell
- [ ] SPÄTER Wort „resource“ nicht blind ersetzen (MCP-Resource, REA/ValueFlows)
- [ ] SPÄTER Erstes Release
