---
license: Copyright (c) 2026 Niederschick OG & Tobias Zucali. All rights reserved. Use restricted to customers with a valid agreement with Niederschick OG.
build: v3.1-49-gda9d29d
---

# Ablaufbericht

Werte den letzten Lauf des EmpCo-UWG Monitors in diesem Gespräch aus und vergleiche ihn mit dem Soll der geladenen Schrittantworten. Der Bericht beschreibt nur Struktur: Schritt-Kennungen, Versionen, Werkzeugnamen, Status, Reihenfolge und Zählungen. Geprüfte Texte, Fundstellen, Bewertungen und Eingaben der Person gehören nie in den Bericht. Alles stammt aus dem Verlauf dieses Gesprächs; nichts wird an den Server gesendet, und es entsteht keine Datei: Die Person kopiert den Bericht aus der Antwort.

## Grenzen des Verlaufs

Fehlen frühe Teile des Gesprächs im Kontext (zum Beispiel nach einer Kürzung), benenne das und melde die betroffenen Punkte als `unknown`, statt sie zu rekonstruieren. Läuft die Prüfung noch oder ist sie abgebrochen, setze `status: incomplete` und nenne die Stelle, an der sie stand; verglichen wird nur, was im Verlauf belegt ist.

## 1. Schrittkette

Liste die geladenen Schritte in der Reihenfolge ihres Ladens mit Kennung, `version`, `build` (soweit vorhanden), `platform`, `variant` und `request-id` (soweit vorhanden) aus dem Frontmatter der Antwort. Entnimm das Soll der Abschnitte „Übergabe“ der geladenen Antworten: welche Folgeschritte erlaubt waren und welcher tatsächlich folgte. Ein vorausgesetzter, aber nicht geladener Schritt ist ein Befund.

## 2. Friction

Halte jeden Bruch mit der Schritt-Kennung fest, in der er auftrat:

```
- [<Schritt>] <Art> – <eine Zeile>
```

Arten: Abruf fehlgeschlagen, Abruf wiederholt, Werkzeug oder Fähigkeit angefordert, aber nicht verfügbar oder fehlgeschlagen (etwa Unteragent, Websuche, Dateizugriff; jede Fehlermeldung eines Werkzeugaufrufs im Verlauf zählt), Schritt übersprungen, Antwort vor geladenem Folgeschritt, Schrittantwort unvollständig oder abgeschnitten, Rückfrage des Assistenten ohne Einfluss auf die Bewertung, Korrektur durch die Person. Nenne nur belegte Fälle; eine Reihung ohne Bruch ist kein Befund.

Ordne jeden Befund einer Ursachengruppe zu, die der Support zuerst prüft:

- **Host:** eine Fähigkeit fehlt oder verhält sich anders als vorausgesetzt.
- **Verbindung:** Werkzeug fehlt, Anmeldung verlangt, Abruf scheitert.
- **Regeln:** die geladene Anweisung war mehrdeutig oder widersprüchlich.
- **Eingabe:** Quelle unzugänglich, leer oder nicht prüfbar.

Widersprüche oder Mehrdeutigkeiten in den geladenen Anweisungen (etwa zwei Regeln, die Verschiedenes verlangen) gehören als Eintrag der Gruppe Regeln in die Friction-Liste, nicht nur in die Notiz eines Kriteriums; ein Kriterium, dessen Notiz einen Widerspruch nennt, ist `partial` oder `not_met`, nicht `met`.

Nicht zuordenbar: `unknown`.

## Verbindung und Host (kurzer Check)

Prüfe ohne Abruf, was der Verlauf und die Werkzeugliste belegen: ob `fetch_claims_monitor_step` sichtbar ist (Werkzeugname wörtlich) und ob die Anmeldung besteht (belegt durch erfolgreich geladene Schrittantworten, widerlegt durch eine Anmelde- oder Verbindungsmeldung im Verlauf, sonst `unknown`). Die Kurzfassung benennt das Ergebnis mit seinem Beleg. „Keine Befunde“ steht nur für Brüche im Verlauf, nie für eine nicht geprüfte Verbindung; ohne Beleg lautet die Angabe „nicht geprüft“. Wer mehr braucht (Fähigkeiten, Versionen, Abruf), ruft die Standarddiagnose auf. Innerhalb der Diagnose entfällt dieser Abschnitt, weil sie `connection` selbst belegt.

## Eckdaten

Der Bericht trägt immer die Eckdaten der Umgebung, damit der Support den Lauf einordnen kann: Anbieter, Produkt, Oberfläche und Modell (nur soweit die Anweisungen es ausdrücklich sagen, sonst `unknown`), Plugin-Version und Version je Skill des Pakets (Schritt 5 der Anweisung, Kurzform) sowie die einfachen Checks für Unteragenten und Webzugriff (Schritt 2 der Anweisung). Jeder Wert nennt `source` und `evidence`.

## 3. Vergleich mit dem Soll

Gehe die Kriterien der geladenen Antworten einzeln durch: die Voraussetzung einer Prüfantwort (Übergabe des zuletzt geladenen Schritts) und die Punkte des Abschnitts „Ausgabe vor Versand prüfen“ in der Antwort von `report-compose`. Markiere jedes Kriterium als erfüllt, nicht erfüllt, teilweise oder `unknown` mit einer Zeile Begründung, die auf Struktur verweist (etwa „Ausgabeabschnitt 2 ohne Quellenangabe“), nicht auf Inhalt. War `report-compose` nicht geladen, lautet der Befund „Ausgabeprüfung nicht möglich: Schritt nicht geladen“.

## Ausgabe

Gib in dieser Reihenfolge aus:

1. **Kurzfassung** in höchstens acht Zeilen für die Person: eine Zeile Eckdaten (Oberfläche, Plugin-Version), dann gruppiert nach Ursachengruppe mit dem ersten Schritt, den der Support prüfen sollte.
2. **Bericht für den Support** in genau einem Codeblock (Format YAML; innerhalb der Diagnose derselbe Block wie dort, mit diesen Schlüsseln auf oberster Ebene), den du der Person als „den Bericht“ nennst:

```yaml
ablauf: {version: 1, status: complete | incomplete, observed_at: "<UTC-Zeit oder unknown>"}
eckdaten:                       # nur eigenständig; innerhalb der Diagnose stehen dieselben Werte in `runtime`, `capabilities` und `versions`
  runtime: {vendor: ..., product: ..., surface: ..., model: ...}        # je {value, source, evidence}
  capabilities: {agents.spawn: ..., web.fetch: ...}                      # je {value, source, evidence}
  versions: [{component: plugin, version: "..."}, {component: "skill:<Name>", version: "...", build: "..."}]
connection: {tool_visible: true | false | unknown, name: "...", auth: signed_in | required | unknown, evidence: "..."}   # nur eigenständig
steps:                          # in der Reihenfolge des Ladens
  - {step: report-intake, version: "...", build: unknown, platform: "...", variant: "... | basis", request_id: "<oder unknown>", next_expected: [...], next_actual: "..."}
skipped: []                     # vorausgesetzte, aber nicht geladene Schritte
friction:
  - {step: "...", kind: "...", group: host | verbindung | regeln | eingabe | unknown, note: "..."}
gates:                          # je Kriterium
  - {criterion: "...", result: met | not_met | partial | unknown, note: "..."}
counts: {friction: {host: 0, verbindung: 0, regeln: 0, eingabe: 0, unknown: 0}, gates: {met: 0, not_met: 0, partial: 0, unknown: 0}}
```

3. **Senden** (nur bei eigenständigem Aufruf): wie bei der Standarddiagnose an die Supportadresse (`references/support.md`, ohne Skill die Seite `/support`), Betreff: `Ablaufbericht EmpCo-UWG Monitor – <Datum>`. Mit `request_id` und Uhrzeit findet der Support die Abrufe im Zugriffsprotokoll des Servers und vergleicht sie mit diesem Verlauf.

Empfiehl keine Änderungen an den Regeln; beschreibe nur, was im Verlauf geschah.

## Definition of done

- [ ] Die Eckdaten nennen Oberfläche, Plugin- und Skill-Versionen sowie die Checks für Unteragenten und Webzugriff mit Beleg oder `unknown`.
- [ ] Die Schrittkette nennt jeden geladenen Schritt mit Kennung, Version und `request_id` (oder `unknown`) und benennt vorausgesetzte, aber nicht geladene Schritte.
- [ ] Jeder Friction-Eintrag nennt Schritt, Art und Ursachengruppe und beruht auf einem Beleg im Verlauf.
- [ ] Jedes Kriterium des Vergleichs trägt ein Ergebnis und eine strukturelle Begründung; nicht Belegbares ist `unknown`.
- [ ] Der Bericht enthält keinen geprüften Text, keine Fundstelle und keine Bewertung der Person.
- [ ] Fehlende frühe Teile des Verlaufs sind benannt; ein unvollständiger Lauf trägt `status: incomplete`.
