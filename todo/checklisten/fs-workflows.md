# fs-workflows – Abhak-Liste

Stand: 2026-11-16 · Grundlage: ADR 0076, 0077, 0081, Gespräch Nutzer/Strategie 2026-11-15
Bild: **Auslöser → Bedingung → Aktion(en)**. Längere Ketten sind Unter-Workflows, die gruppiert und eingeklappt angezeigt werden.
Standards: Serverless Workflow 1.0 (Ablauf), CloudEvents (Ereignisse, ADR 0081), AS2 (Objekte).

## Grundlagen
- [ ] **GRUNDSACHE** Repo fs-workflows mit Kern-Trait, CLI und einem Frontend (über `programm-neu` / `programm-grundgeruest`)
- [ ] **GRUNDSACHE** Jedes Programm meldet in seinem Manifest bei fs-registry, was es kann: Ereignisse, Objekte, Aktionen. Funktioniert lokal, ohne Server.
- [ ] **GRUNDSACHE** fs-workflows liest das Repertoire aller installierten Programme aus fs-registry.
- [ ] **GRUNDSACHE** Speicherung typisiert (ADR 0086): Workflows, Schritte, Läufe, Schritt-Ergebnisse.

## Auslöser
- [ ] **GRUNDSACHE** Ereignis eines Programms (z. B. fs-text „gespeichert“)
- [ ] **GRUNDSACHE** Knopf (von Hand starten)
- [ ] **SPÄTER** Zeitplan (z. B. jeden Montag 8 Uhr)
- [ ] **SPÄTER** Datenänderung mit Bedingung (z. B. Status = erledigt)
- [ ] **SPÄTER** Webhook von außen
- [ ] **SPÄTER** Ort

## Ablauf
- [ ] **GRUNDSACHE** Bedingung (einfacher Vergleich)
- [ ] **GRUNDSACHE** Aktion eines anderen Programms aufrufen (z. B. fs-data: Zeile aktualisieren)
- [ ] **GRUNDSACHE** Schleifenschutz: Eine Kette, die sich selbst wieder auslöst, wird erkannt und gestoppt.
- [ ] **SPÄTER** Felder zuordnen (z. B. Titel → Spalte B)
- [ ] **SPÄTER** Verzweigen, Schleifen, Parallel-Schritte
- [ ] **SPÄTER** Unter-Workflows, Ketten gruppieren und einklappen
- [ ] **SPÄTER** Warten auf einen Menschen (Freigabe)

## Regeln im Programm (sofort, z. B. „Superman“ → Icon)
- [ ] **SPÄTER** Ablauf-Bibliothek als Crate, die Programme einbauen können
- [ ] **SPÄTER** Regeln werden trotzdem in fs-workflows gespeichert und angezeigt

## Sicher und zuverlässig
- [ ] **GRUNDSACHE** Probelauf mit Beispieldaten, bevor ein Workflow scharf geschaltet wird
- [ ] **GRUNDSACHE** Ausführungsprotokoll: jeder Lauf mit Ein- und Ausgabe je Schritt
- [ ] **GRUNDSACHE** Ein- und ausschalten
- [ ] **SPÄTER** Fehlerbehandlung: neu versuchen, Fehler-Workflow, Bescheid geben
- [ ] **SPÄTER** Fehlgeschlagene Läufe wiederholen
- [ ] **SPÄTER** Warteschlange offline (senden, sobald das Ziel erreichbar ist)
- [ ] **SPÄTER** Zugänge nur aus fs-vault, nie im Workflow selbst
- [ ] **SPÄTER** Datenschutz-Warnung beim Senden nach außen (ADR 0029)
- [ ] **SPÄTER** Rechte: Wer darf in einer Gruppe was anlegen oder auslösen?
- [ ] **SPÄTER** Versionen eines Workflows
- [ ] **GRUNDSACHE** **Immer:** läuft ohne KI (deterministisch)

## Frontends und Ansichten
- [ ] **GRUNDSACHE** Liste aller Workflows, gruppiert und gefiltert
- [ ] **GRUNDSACHE** Text-Ansicht (Serverless Workflow)
- [ ] **GRUNDSACHE** Protokoll der Läufe
- [ ] **SPÄTER** Graph-Ansicht mit Kästchen und Pfeilen (Spike Blinc `node_editor`)
- [ ] **SPÄTER** Workflow-Ansicht in jedem Programm („Das kann man hier tun“, ADR 0076)
- [ ] **SPÄTER** Vorlagen-Bibliothek; anbieten und installieren über den Katalog (Art `workflow`, ADR 0077)
- [ ] **SPÄTER** Vorschläge („Das hast du fünfmal von Hand gemacht …“)

## Eigene Nutzung
- [ ] **SPÄTER** Die Bau-Abläufe aus fs-release laufen über fs-workflows.
