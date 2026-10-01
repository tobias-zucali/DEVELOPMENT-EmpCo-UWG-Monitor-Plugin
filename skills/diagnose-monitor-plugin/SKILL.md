---
name: diagnose-monitor-plugin
description: Diagnose des EmpCo-UWG Monitor Plugins – meldet belegte Fähigkeiten dieser Umgebung, Verbindung zum Regelserver und alle Versionen, oder wertet auf Wunsch den Ablauf des letzten Laufs aus. Verwenden, wenn die Person die Diagnose verlangt oder in einem Gespräch, in dem dieses Plugin bereits verwendet wurde, nach Version, Stand oder Verbindung fragt, über eine Störung klagt oder den Ablauf des Plugins hinterfragt („prüfe die Antwort“, „was ist passiert“, „warum hast du das so gemacht“, „war das richtig“); nicht für fachliche Prüfaufträge zu einem Text oder einer Website.
license: Copyright (c) 2026 Niederschick OG & Tobias Zucali. All rights reserved. Use restricted to customers with a valid agreement with Niederschick OG.
version: 4.0.0
build: v3.1-47-g0a4d07d
---

# Diagnose des EmpCo-UWG Monitors

Erstelle einen belegten Bericht über diese Umgebung, die Verbindung zum Regelserver und den Stand von Paket und Regeln, damit der Support ein Problem einordnen kann. Der Bericht enthält ausschließlich technische Angaben zu Umgebung, Verbindung, Versionen und Ablauf. Geprüfte Texte, Fundstellen und Analyseergebnisse gehören grundsätzlich nie dazu, in keinem Umfang und in keinem Lauf; schreibe das auch nicht als Eigenschaft dieses einen Laufes („in diesem Lauf wurden keine geprüften Texte übertragen“) in die Kurzfassung. Nichts davon wird an den Server gesendet, und es entsteht keine Datei: Die Person kopiert den Bericht aus der Antwort.

Der Ablaufbericht (Datei `references/ablauf.md`, in der Textfassung der Abschnitt „Ablaufbericht“ am Ende) wertet den letzten Lauf dieses Gesprächs aus. Ein früherer Lauf liegt vor, wenn das Gespräch vor diesem Aufruf bereits Antworten von `fetch_claims_monitor_step` (Frontmatter mit `next-steps`) oder eine Prüfung enthält; der eigene Abruf dieser Diagnose zählt nicht. Nach einem früheren Lauf ist der Ablauf das Wichtigste und die Technik nachrangig: Die Auswahl unten ist darauf ausgerichtet, und der Abruf entfällt, weil die geladenen Schritte Anmeldung und Regelstand belegen. Steht hinter dem Aufruf `ablauf` oder bittet die Person um die Auswertung des letzten Laufs, gilt die Wahl „Ablauf“ ohne Frage. Enthält das Gespräch keinen früheren Lauf, entfällt der Ablaufbericht ohne Hinweis.

## Zu Beginn: Freigaben einholen

Bist du von selbst gestartet, prüfe zuerst am Gesprächsverlauf (ohne Werkzeugaufruf), ob dieses Plugin darin bereits aktiv war: Der Prüf-Skill wurde geladen, `fetch_claims_monitor_step` wurde aufgerufen oder eine Prüfung hat begonnen. War es nicht aktiv und nennt die Person das Plugin nicht, führe nichts aus und frage in einem Satz, ob sich die Frage auf den EmpCo-UWG Monitor bezieht. Sonst ist die Frage deine erste Handlung. Bevor du etwas ausführst, frage einmal und gebündelt, damit der Bericht in einer einzigen Antwort entsteht und die Person nichts nachreichen muss. Nutze ein Auswahlwerkzeug (etwa `AskUserQuestion`, `Ask User Input`, `request_user_input`), sonst eine kurze nummerierte Frage in einer Nachricht, und warte die Antwort ab. Es stehen nie mehr als drei Optionen zur Wahl.

Ohne früheren Lauf:

1. **Standard** (empfohlen): Bericht mit genau einem Abruf von `report-intake`. Er belegt Anmeldung und Regelstand, lädt die Regeln in dieses Gespräch, beginnt keine Prüfung und erscheint im Zugriffsprotokoll des Servers.
2. **Minimal:** Bericht ohne Abruf beim Regelserver.
3. **Vollständig:** wie Standard, zusätzlich mit der vollständigen Werkzeugliste und lokalen Umgebungsangaben im selben Bericht. Sie nennen die Namen weiterer Connectors und lokale Pfade; diese Wahl ist für den Fall gedacht, dass der Support sie angefordert hat.

Mit früherem Lauf (ohne Abruf; `fetch: not_run`, die Anmeldung `signed_in` mit der geladenen Schrittantwort als Beleg):

1. **Ablauf** (empfohlen): nur der Ablaufbericht zum letzten Lauf mit seinem kurzen Verbindungscheck. Folge ausschließlich dem Ablaufbericht statt der Schritte unten, mit eigener Kurzfassung und eigenem Block; es gibt keine Umgebungsprobe und keinen Unteragenten.
2. **Ablauf und Technik:** der Ablaufbericht und der Bericht dieser Anweisung ohne Abruf (Umgebung, Fähigkeiten, Versionen), in einem Block; die Kurzfassung nennt den Ablauf mit bis zu zwei Zeilen.
3. **Vollständig:** wie Ablauf und Technik, zusätzlich mit der vollständigen Werkzeugliste und den lokalen Umgebungsangaben wie oben.

Wird die Frage abgebrochen, übersprungen oder geschlossen, führst du nichts aus: kein Befehl, kein Abruf, kein Bericht; sage in einem Satz, dass nichts ausgeführt wurde und die Diagnose jederzeit neu aufgerufen werden kann. Der Ablaufmodus liest nur das Gespräch und braucht keine Freigabe.

## Kernregeln

1. **Belege statt Namen.** Ein Produkt- oder Modellname beweist keine Fähigkeit. Jeder Wert `true` oder `false` nennt `source` und `evidence`.
2. **`source`, stärkster zuerst:** `probe` (eine harmlose Handlung, deren Ergebnis beobachtet wurde), `tool` (Werkzeug mit lesbarer Beschreibung), `prompt` (ausdrückliche Aussage der Anweisungen), `inference` (indirekte Hinweise), `self` (eigene Annahme). `evidence` ist ein wörtliches Zitat: Werkzeugname mit dem ersten Satz der Beschreibung, eine Ausgabezeile oder die Formulierung der Anweisung.
3. **`unknown` ist eine vollständige Antwort.** Ohne Zitat steht `unknown`. `false` gilt nur nach einem unmittelbaren Fehlschlag oder einer ausdrücklichen Aussage; ein fehlendes Werkzeug genügt nur, wenn das Werkzeuginventar nachweislich vollständig ist.
4. **Schreibgeschützt und datensparsam.** Keine Werkzeuge eines Connectors aufrufen außer dem einen Abruf in Schritt 4, falls die Person ohne früheren Lauf Standard oder Vollständig gewählt hat. Nichts installieren, nichts senden, keine Geheimnisse ausgeben. Die Ausgabe enthält außer bei Vollständig nicht die vollständige Werkzeugliste (sie nennt die übrigen Konnektoren der Person), keine Pfade mit Benutzernamen und keine Umgebungsvariablen.

## Ablauf

### 1. Identität und Werkzeuge

Nenne Anbieter, Produkt, Oberfläche und Modell nur, soweit die Anweisungen es ausdrücklich sagen; sonst `unknown`. Gehe die eigene Werkzeugliste einschließlich nachladbarer Werkzeuge durch und ordne sie anhand ihrer Beschreibung diesen Fähigkeiten zu: `agents.spawn`, `code.execute`, `files.read`, `files.write`, `files.deliver`, `web.fetch`, `skills.load`, `mcp.connectors`. Ein Namensmuster ist ein Kandidat, kein Beleg; ist von einem nachladbaren Werkzeug nur der Name bekannt, lade seine Beschreibung (etwa über die Werkzeugsuche des Hosts), bevor du es zuordnest oder `unknown` setzt. Die Liste selbst gehört nur bei Vollständig in den Bericht.

### 2. Unteragent (nur bei einem Kandidaten für `agents.spawn`)

Erzeuge ein Nonce (mit Shell: `head -c 6 /dev/urandom | od -An -tx1 | tr -d ' \n'`; ohne: eine selbst erfundene Zeichenfolge und sage das). Starte mit dem allgemeinen Unteragenten genau diese Aufgabe: „Antworte mit genau dieser Zeichenfolge und sonst nichts: `<Nonce>`“. Gleiche Antwort ergibt `agents.spawn: true, source: probe`; Fehler oder Abweichung ergeben `false` mit dem beobachteten Fehler als Beleg. Gibt es keinen Kandidaten, startest du nichts: `unknown`.

### 3. Umgebung (nur mit Shell)

Führe die „Umgebungsprobe“ aus (Datei `scripts/probe.sh`, in der Textfassung der Skriptblock am Ende). Es meldet Betriebssystem, Marker der Sandbox, vorhandene Programme und Bibliotheken; die Uhrzeit in UTC; Benutzername, Arbeitsverzeichnis und Umgebungsvariablen nur mit dem Argument `--roh`, das du nur bei Vollständig verwendest. Ohne Shell ist der Schritt nicht ausführbar; die zugehörigen Werte sind `unknown`.

### 4. Lieferung und Verbindung

- **`loaded_as`:** `plugin-skill`, `project-skill`, `pasted-text`, `system-prompt` oder `unknown`, mit dem Pfad oder der Formulierung als Beleg.
- **`package_files`:** Mit Dateizugriff prüfen, welche dieser Dateien neben oder oberhalb des Skills liegen (bis zu drei Ebenen): `plugin.json`, `.claude-plugin/plugin.json`, `mcp.json`, `.mcp.json`, `agents/openai.yaml`. Ohne Dateizugriff `unknown`.
- **Verbindung:** Nenne, ob `fetch_claims_monitor_step` sichtbar ist (Werkzeugname wörtlich; Hosts ergänzen Präfixe wie `mcp__<Server>__`) und ob der Host den Connector als anmeldepflichtig oder nicht angemeldet führt. Rufe es dafür nicht auf.
- **Abruf (Standard, oder Vollständig ohne früheren Lauf):** genau ein Aufruf von `report-intake`, dessen Antwort du nur für Schritt 5 nutzt, ohne eine Prüfung zu beginnen. Halte unmittelbar danach die Uhrzeit in UTC fest (mit Shell `date -u +%Y-%m-%dT%H:%M:%SZ`) und übernimm `request-id` aus dem Frontmatter der Antwort, soweit vorhanden; beides lässt dem Support den Abruf im Zugriffsprotokoll des Servers finden. Bei Minimal steht `fetch: not_run`. Fehlt das Werkzeug, steht `fetch: not_run` mit dem Beleg „Werkzeug nicht verfügbar“; scheitert ein Aufruf, steht `failed`. In beiden Fällen nenne die beobachtete Meldung wörtlich und verweise für die Schritte zur Anmeldung auf die Einrichtungsanleitung (`references/setup.md`, ohne Skill die Seite `/einrichtung` des Servers) und bei anhaltendem Fehler auf den Support (`references/support.md`, ohne Skill die Seite `/support`).

### 5. Versionen

Gib die Ebenen getrennt aus; jede mit Quelle, eine nicht verfügbare als `nicht feststellbar`, nie aus einer anderen Ebene oder aus Datei- und Ordnernamen abgeleitet:

- **Plugin-Version:** das Feld `version` des installierten Plugin-Manifests (`plugin.json`, `.claude-plugin/plugin.json`) oder eine ausdrücklich vom Host bereitgestellte Paketversion, mit Pakettyp und Wert (z. B. `Plugin-Version: 4.0.0`). Gibt es keine separate Paketform, `kein Paket`.
- **Alle Skills des Pakets:** je `skills/<Name>/SKILL.md` im Paket (Verzeichnis oberhalb dieses Skills, siehe `package_files`) `version` und `build` aus dem Frontmatter, eine Zeile je Skill; dazu gehört dieser Skill. Ist nur dieser Skill lesbar, nenne die übrigen als `nicht feststellbar`.
- **Connectors des Pakets:** je Server in `mcp.json` beziehungsweise `.mcp.json` Name und Adresse (ohne Query und Zugangsdaten). Die Version des Servers steht nur im Bericht, wenn der Host sie nennt (etwa als Server-Version der Verbindung), sonst `nicht feststellbar`; der Regelstand der Schrittantwort ist ein eigener Wert.
- **Skill- oder Instructions-Stand:** `version` und `build` im Frontmatter dieses Skills; ohne Skill die Zeile „Stand dieses Textes“ am Anfang dieser Anweisung oder, bei einem Instructions-Feld, `build` in dessen Frontmatter. Fehlt `build` und steht nur `version`, benenne das und nenne den Wert trotzdem („kein `build`-Feld, nur `version: X.Y` – Hinweis auf eine ungebaute Quelldatei statt des gebauten Artefakts“). Fehlen beide, benenne das als Anomalie, ohne einen Wert zu erfinden. `build` ist ein Git-Stand (Tag, Commit-Abstand, Kurzkennung): Er wird nicht mit `version` verglichen; ein Anhang `dirty` nennst du als Hinweis auf nicht eingecheckte Änderungen im Bau.
- **Regelstand:** nur aus einer Schrittantwort dieses Gesprächs: `version`, `platform` (Plattform des Zugriffs) und `variant` (Plattform der gelieferten Variante) sowie `build`, soweit vorhanden, aus dem Frontmatter je geladenem Schritt. `version` einer Schrittantwort ist der Stand des Regelpakets (ein Git-Stand wie `v3.1-36-g…`, bei einem Bau mit nicht eingecheckten Änderungen mit `dirty`); ein fehlendes `build` ist dort der Normalfall und kein Befund. Fehlt `variant`, wurden die Basisregeln geliefert; fehlt `platform`, hat keine Quelle (Pfad, Argument des Werkzeugs, zugeordneter Client) eine Plattform genannt, auch das ist kein Befund. Wurde noch kein Schritt geladen, steht dennoch die Zeile `step:report-intake` mit dem Regelstand `nicht geladen`.
- Weichen geladene Schrittversionen voneinander ab, benenne das ausdrücklich als möglichen gemischten Stand.

### 6. Vor der Ausgabe

Suche für jedes `true` und `false` das Zitat im Kontext oder in der Ausgabe erneut, ebenso für Anbieter, Produkt, Oberfläche und Modell: Das Zitat muss den genannten Wert wörtlich enthalten (ein Modellname wie „GPT-5“ belegt keinen Anbieter). Nicht gefunden: auf `unknown` zurücksetzen und `downgraded: true` vermerken. Prüfe, dass kein Wert allein aus einem Namen stammt und dass kein Geheimnis, kein Benutzername und keine Werkzeugliste in der Ausgabe steht (außer bei Vollständig).

## Ausgabe

Gib in dieser Reihenfolge aus:

1. **Kurzfassung** in höchstens acht Zeilen (mit Ablaufbericht zehn) für die Person: Umgebung, die wichtigsten Fähigkeiten, Zustand der Verbindung, Versionen, offene Punkte und jede Herabstufung. Schreibe die Kurzfassung in einfachen Worten, ohne Feldnamen und Kennungen des Berichts (nicht `unknown`, `not_run`, `request_id`; sage „nicht feststellbar“, „nicht ausgeführt“) und ohne Verweis auf diese Anweisung („laut Diagnosevorgabe“).
2. **Bericht für den Support** in genau einem Codeblock (Format YAML), damit die Person ihn mit einem Griff kopieren kann:

```yaml
diagnose: {version: 1, observed_at: "<UTC-Zeit oder unknown>", scope: minimal | standard | voll | ablauf | technik}
runtime:
  vendor: {value: ..., source: ..., evidence: "..."}
  product: {value: ..., source: ..., evidence: "..."}
  surface: {value: chat | work | cowork | code | api | ide | unknown, source: ..., evidence: "..."}
  model: {value: ..., source: ..., evidence: "..."}
capabilities:
  agents.spawn: {value: true | false | unknown, source: ..., evidence: "..."}
  # jede Fähigkeit aus Schritt 1 und 3: code.execute, files.read, files.write, files.deliver, web.fetch, skills.load, mcp.connectors
environment: {os: "...", sandbox_markers: [...], binaries: {python3: true | false}, python_libraries: {docx: true | false}, source: probe | unknown}   # aus der Umgebungsprobe, sonst unknown
delivery:
  loaded_as: {value: ..., evidence: "..."}
  package_files: [...]          # oder unknown
connection:
  tool_visible: {value: true | false | unknown, name: "...", evidence: "..."}
  auth: {value: signed_in | required | unknown, evidence: "..."}
  fetch: {value: ok | failed | not_run, at: "<UTC-Zeit oder unknown>", request_id: "<oder unknown>", evidence: "..."}
versions:                       # eine Zeile je Komponente, immer dieselben Felder
  - {component: plugin,        version: "...", build: unknown, source: "plugin.json"}
  - {component: "skill:<Name>", version: "...", build: "...",  source: "Frontmatter von skills/<Name>/SKILL.md"}   # eine Zeile je Skill im Paket, auch dieser
  - {component: diagnose-text, version: "...", build: "...",   source: "Stand dieses Textes | Instructions-Feld"}    # nur ohne Skill
  - {component: "connector:<Server>", version: "... | nicht feststellbar", source: ".mcp.json | Host", url: "<Adresse ohne Query>"}
  - {component: "step:report-intake", version: "...", build: unknown, source: "Schrittantwort", platform: "... | keine", variant: "... | basis"}
mixed_state: true | false | unknown   # true, wenn geladene Schrittversionen voneinander abweichen
unknowns: [...]
conflicts: []                   # widersprüchliche Belege, ohne sie zu glätten
raw: {tools: [...], env: "..."} # nur bei Vollständig; steht im selben Block, damit er sich mit einem Griff kopieren lässt; bei mehr als 50 Werkzeugen nach Quelle gruppiert, nur Namen
```

3. **Senden:** Der Bericht geht per E-Mail an die Supportadresse (`references/support.md`, ohne Skill die Seite `/support`), Betreff: `Diagnose EmpCo-UWG Monitor – <Plugin-Version oder Stand dieses Textes> – <surface>`. Fordere die Person auf, den Bericht aus dem Kasten oben zu kopieren und zu senden; schließe die Antwort damit ab, ohne eine Datei anzubieten. Sprich die Person dabei nie mit Fachbegriffen an (nicht „YAML“, „Block“, „Schlüssel“): Nenne ihn „den Bericht“ oder „den Kasten mit dem Bericht“.

## Definition of done

- [ ] Jeder Wert `true` oder `false` trägt `source` und ein wörtliches `evidence`; `unknown` steht überall, wo es keines gibt.
- [ ] Die Ausgabe enthält außer bei Vollständig keine Werkzeugliste, keinen Benutzernamen, keine Pfade und keine Umgebungsvariablen.
- [ ] Die Verbindung ist mit Sichtbarkeit des Werkzeugs, Anmeldestatus und (bei Standard und Vollständig ohne früheren Lauf) dem einen Abruf belegt; bei Minimal und nach einem früheren Lauf steht `fetch: not_run`.
- [ ] Plugin-Version, Skill-Stand und Regelstand stehen getrennt und mit Quelle; keine ist aus einer anderen abgeleitet.
- [ ] Die Freigaben wurden vor dem ersten Schritt in einer einzigen Frage eingeholt; ohne Antwort wurde nichts ausgeführt; Abruf und Umfang folgen ausschließlich der getroffenen Wahl.
- [ ] Kurzfassung und genau ein Bericht liegen in einer Antwort vor; die Versionen stehen als eine Zeile je Komponente.
- [ ] Der Abruf trägt Uhrzeit (UTC) und `request_id`, soweit vorhanden, sonst `unknown`.
- [ ] Es wurde nichts installiert, nichts gesendet und kein Connector-Werkzeug außer dem freigegebenen Abruf aufgerufen.
