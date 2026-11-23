# 0047 – Kanidm hinter eigenem Wrapper

Status: akzeptiert (2026-11-06) · ergänzt und schränkt ADR 0024 ein · Befunde: `research/kanidm-control.md`

## Entscheidung (Nutzer)
- **Wir legen fest, was geschieht, und gleichen Kanidm an.** Kanidm ist per REST-API oder Client ferngesteuert.
- **Was Kanidm nicht kann, übernehmen wir.** Setzt Kanidm es später um, geben wir die Kontrolle zurück.
- PAM, RADIUS und Ähnliches sind Möglichkeiten, die in Betracht gezogen werden, keine Pflicht.
- RustFS wird ebenfalls stark genutzt, bleibt aber optional; die Zusammenarbeit wird gesucht.

## Umsetzung (nach Recherche, Quellcode 1.13.0-dev, nicht am laufenden System geprüft)
- REST v1 mit Service-Account-Token über einen eigenen schlanken Client. `kanidm_client`, an die Serverversion gebunden, nur
  für komplizierte Abläufe.
- **SCIM vorerst nicht**, entgegen ADR 0024: ausdrücklich instabil, allgemeines Anlegen wirkt defekt.
- Hierarchie, Art, Rollen, Einladungen liegen in `fs-groups` (Schlüssel: Gruppen-ID). Zyklen verhindern wir selbst.
- Ohne Kanidm laufen die Programme weiter (ADR 0024).

## Nachtrag 23.11.2026 (Entwurf): REST gilt nur für die Client-Richtung; Client ist `kanidm_client`

Status: **Entwurf** (Strategie-Entscheid 23.11.2026; Nutzerentscheid: `kanidm_client` nutzen und erweitern; KI hilft offen gekennzeichnet, Erweiterungen kommen als eigenes Crate auf `kanidm_client`; Agenten und Bot senden nie selbst an Kanidm, der Nutzer sendet) · **ändert** Abschnitt „Umsetzung“ (eigener schlanker Client wird ersetzt; SCIM vorerst nicht) und löst den scheinbaren Widerspruch zu ADR 0024

- **Zwei Richtungen, kein Widerspruch.** ADR 0024: **wir sind SCIM-Anbieter** (jedes Programm über `fs-access`). ADR 0047: **REST v1 gilt nur für uns als Client zu Kanidm**, weil Kanidms SCIM nicht als stabil erklärt ist (Issue kanidm#4638 offen; Maintainer 28.10.2026). Umschalten auf SCIM geschieht nur im Adapter, sobald Kanidm es stabil erklärt.
- **Client = Crate `kanidm_client`** (1.12.1 laut Entscheid, MPL-2.0, an die Serverversion gebunden) statt Eigenbau. Der heutige eigene Client in `fs-identity-kanidm` (reqwest, „no Kanidm crates“) wird im Transport ersetzt; Adapter, Bericht und Befunde bleiben unsere. **Pin: `kanidm_client` = die mitgelieferte Kanidm-Version; beim Update der mitgelieferten Version wird der Pin im selben Schritt nachgezogen** (Strategie-Entscheid 23.11.2026). Fehlt dem Crate etwas, wird dort mitgearbeitet (Grundsatz Kooperation).
- **Offen:** Der Tausch ist als Folgeauftrag K2 vorgemerkt, noch nicht ausgeführt.
