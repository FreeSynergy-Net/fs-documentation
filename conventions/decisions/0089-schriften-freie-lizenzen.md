# 0089 – Schriften: freie Lizenzen, keine Schrift im Release, Installation über fs-software

Status: akzeptiert (Nutzer, 2026-11-16) · ergänzt ADR 0077 (Katalogart `kind`) · baut auf ADR 0066 (Stile ohne fremde Schriften, Punkt 6), 0068 (gespiegelte Pakete, Fähigkeiten), 0074 (Schrift gehört zum Stil), 0087 (fs-software)

## Kontext
- Die Stile nennen Schriften. Die Dossiers (`docs/en/components/styles/`: Apple, Windows, Fiori) nennen Inter und Noto Sans. Im Code (`fs-components-styles`) steht bei fünf Stilen zusätzlich DejaVu Sans. Craft, Simple und Admin haben kein Dossier. **[Messung 2026-11-16]**
- Die Lizenzen sind nicht alle OFL 1.1. DejaVu Sans steht unter der Bitstream-Vera-Lizenz (mit Public Domain für die Änderungen), nicht unter OFL, Apache-2.0 oder UFL. Selawik (Windows) trägt einen Reserved Font Name. **[Messung: Lizenztexte; rechtliche Bewertung offen]**
- Im Google-Fonts-Repo fehlt bei 10 Familien jede Lizenzdatei im Ordner (4 OFL, 6 Apache). Zwei UFL-Familien haben `LICENCE.txt` statt `UFL.txt`. Das Lizenzfeld in den Metadaten reicht nicht als Nachweis. **[Messung 2026-11-16]**
- ADR 0077 §1 nennt die Werte von `kind`. Eine Schrift hat darin keinen Wert.
- Craft liefert JetBrains Mono heute im Binary aus: `fs-components-render` mit `include_bytes!`, Feature `craft-font` standardmäßig an. Das steht im Widerspruch zu `fs-components/DESIGN.md` Zeile 21 („We do not carry fonts in the release“) und zu Zeilen 363 und 390. **[Messung]**

## Entscheidung
1. **Lizenz.** Jede freie Schriftlizenz ist erlaubt, nicht nur OFL, Apache-2.0 und UFL. Dazu gehören Bitstream Vera und DejaVu, MIT, CC0 und vergleichbare Lizenzen. DejaVu Sans bleibt in den Stilen. Ist eine Lizenz unfrei oder unklar, wird die Familie nicht gespiegelt, sondern gemeldet. Entscheidend ist der Lizenztext, nicht der Dateiname.
2. **Pflichten je Schrift.** Lizenztext und Copyright-Zeile gehören zur Schrift im Paket und bleiben unverändert, auch wenn darin ein Firmenname steht. Ein Reserved Font Name wird erfasst. Eine geänderte Fassung trägt ihn nur, wenn die Lizenz das erlaubt; nach OFL-FAQ Q2.2 und Q2.6 ist ein Formatwechsel oder eine Teilmenge eine Änderung. **[Quelle: openfontlicense.org/ofl-faq]**
3. **Keine Schrift im Release.** JetBrains Mono wird nicht mehr per `include_bytes!` und Feature `craft-font` in `fs-components-render` eingebaut. Bis die Schrift über fs-software installiert ist, gilt der Rückfall auf die System-Monospace-Schrift (Fontconfig `monospace`). **Ausnahme (entschieden):** Die Noto-Emoji-Teilmenge im Blinc-Binary ist als Upstream-Ausnahme erlaubt (Glyphen-Rückfall des Upstreams, keine Designerschrift).
4. **Katalogart `kind = font`.** Ein Eintrag beschreibt eine Schriftfamilie mit allen ihren Schnitten (Dateien). Die Einzelheiten (Felder, AppStream-Typ `font`, Ist-Stand-Korrektur) stehen im Nachtrag 2026-11-16 in ADR 0077. **[Quelle: AppStream, Abschnitt Fonts, laut Recherche]**
5. **Installation über fs-software.** Schriften werden über fs-software installiert, nach `~/.local/share/fonts` bzw. über fontconfig. Sie kommen aus unserem Spiegel (ADR 0068), nie von fremden Schrift-Servern zur Laufzeit.
6. **Herkunft und Anzeige** (Quelle: Recherche). Angezeigt werden nur Familienname, Gestalter bzw. Copyright laut Lizenz und die Lizenz. Ein Hinweis auf den Upstream-Dienst (z. B. „Google Fonts“) steht nicht in Anzeige, Katalogtext oder Paketname. Quelle, Pin und Prüfsumme stehen in der Spiegel-Metadatei `mirror.toml`.
7. **Format im Spiegel.** Bis geklärt ist, ob der eigene Konverter die Bedingungen der OFL erfüllt, liefert der Spiegel TTF (siehe Offene Punkte, WOFF2).

## Folgen
- Craft verliert seine eingebaute Schrift. Bis zur Installation über fs-software zeigt Craft die System-Monospace-Schrift. Das ändert die Bildtests der Craft-Bilder. Der Umbau von `fs-components-render` ist ein eigener Auftrag.
- `fs-components/DESIGN.md` Zeilen 363 und 390 werden angepasst. Zeile 21 passt dann zur Entscheidung.
- Die Stil-Dossiers und `fs-components-styles` werden auf eine gemeinsame Schriftliste gebracht, damit Dossier und Code übereinstimmen.
- Anzeige fremder Schriften von fremden Servern entfällt. Das folgt aus Datenschutzgründen (Urteil LG München I, Az. 3 O 17493/20, gelesen nur über eine Sekundärquelle). **[nicht belegt im Volltext]**

## Offene Punkte
- **Lizenz-Gate:** Umsetzung und Ort offen. Der Nutzer nennt fs-software. Die Recherche schlägt einen Schritt `license-gate` im Workflow `upstream-update` (fs-release) vor, für alle Spiegel. Das Gate prüft Lizenztext, Copyright und Reserved Font Names und meldet Unklares. Das Katalog-Gate prüft Anzeigetexte auf Markennamen.
- **Vorschau** der Schrift in fs-software: offen.
- **Lizenzen der 10 Familien ohne Lizenzdatei:** Upstream-Tag prüfen oder ausschließen. Betroffen sind kumaroneoutline, mplusrounded1c, playwritenzbasicguides, tinos (OFL) und sechs jsmath-Familien (Apache-2.0, aus MetaFont erzeugt).
- **DejaVu Sans:** Die Rechtsbewertung des Bitstream-Vera-Textes durch den Eigentümer steht aus. **[nicht belegt]**
- **Startliste der Schriften:** Noto Sans, Noto Sans Mono, Noto Emoji, Inter, JetBrains Mono, Atkinson Hyperlegible, Selawik. Die Strategie entscheidet.
- **WOFF2:** Ob der eigene Konverter die Bedingungen der OFL erfüllt, ist nicht geprüft.
- **Herkunft der Anzeigeregel (Punkt 6):** Ob sie eine Nutzerregel vom 2026-11-16 ist, ist nicht belegt. Geführt wird sie als Quelle: Recherche; die Bestätigung durch den Nutzer steht aus. **[nicht belegt]**
- **Rückfrage bei fehlender Schrift** und Verhalten bei Ablehnung (Theme ausgegraut) sind nicht entschieden.
- **Craft ohne installierte Schrift:** ob die System-Monospace-Schrift ausreicht, ist nicht gemessen. **[nicht belegt]**
- **Markenfrage** (Namensnutzung „FreeSynergy Schriften“): Rechtsprüfung durch den Eigentümer. **[offen]**
