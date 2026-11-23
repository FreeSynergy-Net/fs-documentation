# 0064 – Versionsnummern beginnen bei 0.0.1

Status: akzeptiert (Nutzer, 2026-11-08: „Ja, zurücksetzen bitte.“) · ersetzt die bisherige Zählung (coding.md §8 bleibt: Abhängigkeiten über Git-Tags)

## Entscheidung (Nutzer, 2026-11-08: „0.9 glaubt uns niemand“)
1. Alle FreeSynergy-Repos zählen 0.0.N. Jeder Tag erhöht nur die letzte Stelle (v0.0.1, v0.0.2, …). Keine Minor- oder Major-Sprünge, solange die Regel unten nicht erfüllt ist.
2. **0.1.0** wird erst vergeben, wenn ein Programm für normale Menschen benutzbar ist **und** den Handtest des Nutzers (`todo/handtest.md`) besteht. Gilt je Programm; Kerne und Verträge folgen dem Programm, das sie braucht.
3. **1.0.0** wird erst vergeben, wenn die Schnittstelle (der Vertrag) von zwei voneinander unabhängigen Nutzern verwendet wird.
4. Vorabversionen (`-rc.N`) sind im Reset nicht vorgesehen; ein Entwurf trägt dieselbe Nummer wie der spätere Tag und wird erst mit dem Tag veröffentlicht.
5. Abhängigkeiten zeigen auf Tags, nicht auf Branches oder `rev` (Ausnahme nur mit Begründung in der `DESIGN.md`); je Crate gilt in einem Abhängigkeitsgraphen **eine** Version (keine Aliase auf zwei Versionen derselben Crate).

## Folgen
- Die bisherigen Tags und Releases (v0.1.x–v0.9.x, Entwürfe, Vorabversionen) werden gelöscht; der heutige Stand jedes Repos wird als v0.0.1 gesetzt, in Abhängigkeitsreihenfolge.
- rpm/deb: Version 0.0.1 ist kleiner als die bisherigen; wer alte Pakete installiert hat, entfernt sie einmal selbst (`dnf remove`), sonst gilt „Update“ nicht. Der Katalog (`fs-catalog`) führt nur noch 0.0.N.
- Signaturen: neue Tags werden neu signiert; alte signierte Dateien verlieren ihre Veröffentlichung.
- Offene Branches zeigen auf alte Tags; sie werden einmal mit einem Umstellungscommit auf v0.0.1 gezogen.

## Begründung
Eine hohe Nullversion (0.9) verspricht Reife, die nicht belegt ist. Der Nutzer will, dass Nummern etwas bedeuten: 0.0.N = Entwicklung, 0.1.0 = ein Mensch kann es benutzen, 1.0.0 = die Schnittstelle trägt zwei Nutzer.

## Verworfen
- Beibehalten der bisherigen Nummern: widerspricht der Aussage der Nummer.
- Eine gemeinsame Version für alle Repos: Repos reifen unterschiedlich schnell.

## Nachtrag 2026-11-23: Registry-Version aus dem Tag zählt als Tag (Nr. 5)

Status: **entschieden** (Entscheid Strategie 23.11., Nutzer wird informiert, Kurzvorlage vor K-5; Schnitt „ENTSCHEID-kaskade“, Empfehlung B2) · **ergänzt** Nr. 5 · Nr. 1 bis 4 gelten unverändert · Grund und Umfang: ADR 0093, Nachtrag 2026-11-23 · Bereichsregel: ADR 0045, Nachtrag 2026-11-23 Nr. 4 und 5
1. **Eine Version im Registry `freesynergy` zählt als Tag im Sinne von Nr. 5**, wenn sie die Release-CI aus genau diesem Tag-Lauf veröffentlicht hat. Von Hand gibt es keinen Eintrag. Ein Kopf, ein Branch oder eine `rev` wird nie veröffentlicht.
2. **Crate-Version = Tag.** Die Version in `Cargo.toml` muss gleich dem Tag sein (Tag `v0.0.7` → Crate `0.0.7`). Ein Gate im Tag-Lauf prüft das vor dem Paketieren und ist bei Abweichung rot. Heute steht in fs-types noch `0.0.5` gegen Tag `v0.0.6`, und das ist ein Fehler.
3. Für Abhängigkeiten aus dem Registry ist statt eines exakten Tags ein **Bereich** `~0.0.N` erlaubt. Das gilt nur für die in ADR 0093 (Nachtrag 2026-11-23) genannten Crates. Für alles andere bleibt der Git-Tag.
4. **„Eine Version je Crate im Abhängigkeitsgraphen“ bleibt.** Liegen zwei 0.0.x-Versionen aus dem Registry im Lock, ist das ein Verstoß (ADR 0092, Nachtrag 2026-11-23).
5. Kein Sprung auf 0.1.x: Nr. 2 gilt auch für fs-types. Mit dem ersten 0.1.0 gilt das normale Caret (ADR 0045, Nachtrag Nr. 4).
- Die Kopfzeile („coding.md §8 bleibt: Abhängigkeiten über Git-Tags“) gilt mit dieser Ausnahme, siehe `conventions/coding.md` §8, Nachtrag 2026-11-23.
