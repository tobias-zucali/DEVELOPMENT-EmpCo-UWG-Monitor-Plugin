---
license: Copyright (c) 2026 Niederschick OG & Tobias Zucali. All rights reserved. Use restricted to customers with a valid agreement with Niederschick OG.
build: v3.1-46-gb8b9bc8
---

# Einrichtung: Plugin für Claude und ChatGPT

Der EmpCo-UWG Monitor wird als **Plugin** „EmpCo-UWG Monitor (Dev)" installiert. Es ist ein einziges Paket für Claude und ChatGPT und enthält beides, was nötig ist:

1. die Verbindung zum EmpCo-UWG Wissensdatenbank-Server, über die die Prüfregeln abgerufen werden, und
2. den **Skill**, der festlegt, wie und wann die Regeln abgerufen werden.

Ohne angemeldete Verbindung steht das Tool `fetch_claims_monitor_step` nicht zur Verfügung und keine Prüfung ist möglich.

**Voraussetzung:** ein gekaufter Zugangscode (Lizenz). Er wird bei der Anmeldung der Verbindung eingegeben, nicht im Chat.

## Claude

Claude läuft im Browser (claude.ai) und in der Claude-Desktop-App und hat drei Modi: Chat, Cowork und Code.

### Installation

Das Plugin wird über einen **Marketplace** installiert, ein öffentliches GitHub-Repository mit dem Plugin: `tobias-zucali/EmpCo-UWG-Monitor-Plugin`. Er ist der empfohlene Weg, weil sich das Plugin darüber aktualisieren und entfernen lässt. Ein bereits über Zip-Upload installiertes Plugin mit demselben Namen zuerst entfernen (**Customize > Plugins > Yours**), damit Befehle nicht mit der alten Installation verwechselt werden.

1. Den Marketplace hinzufügen: in der Desktop-App oder auf claude.ai unter **Customize > Plugins > Add** (deutsche Oberfläche: **Anpassungen > Plugins > Hinzufügen**) die Option für einen Marketplace wählen und `tobias-zucali/EmpCo-UWG-Monitor-Plugin` eingeben; in Claude Code im Terminal `/plugin marketplace add tobias-zucali/EmpCo-UWG-Monitor-Plugin`.
2. Das Plugin `EmpCo-UWG Monitor (Dev)` aus diesem Marketplace installieren; in Claude Code `/plugin install empco-uwg-monitor-dev@empco-uwg-monitor-dev`.
3. Den Connector des Plugins verbinden: Claude leitet zur Anmeldung weiter, dort den Zugangscode eingeben und bestätigen. Erst danach steht `fetch_claims_monitor_step` zur Verfügung – die Installation allein reicht nicht.

Ist der Marketplace nicht erreichbar, lässt sich dasselbe Paket als Zip-Datei installieren: `https://snowflake-blasphemy-waged.ngrok-free.dev/downloads/empco-uwg-monitor-plugin.zip` herunterladen und unter **Customize > Plugins > Add > Upload plugin** (deutsche Oberfläche: **Anpassungen > Plugins > Hinzufügen > Plugin hochladen**) auswählen. Danach den Connector wie in Schritt 3 verbinden.

### Verwendung

**Empfohlen wird Cowork**; dort ist der gesamte Ablauf bis zur Prüfung getestet. Andere Modi können das Plugin unter Umständen ebenfalls nutzen, sind aber nicht vollständig getestet; die Nutzung erfolgt auf eigene Verantwortung. Derzeit sind im Chat Skill und (nach der Anmeldung) Connector sichtbar, ein vollständiger Prüfauftrag ist dort nicht getestet, und in Claude Code im Web wird der Skill des Plugins nicht geladen. Die Anbieter erweitern die Unterstützung des Plugin-Formats laufend, die Lage in einzelnen Modi kann sich deshalb schnell ändern.

Eine neue Cowork-Sitzung starten und einen Prüfauftrag stellen, z. B. „Prüfe: „Unsere Verpackung ist 100 % umweltfreundlich."" Fragt Claude dabei um Erlaubnis, den Connector zu kontaktieren, **„Immer erlauben"** wählen – sonst erscheint die Abfrage bei jedem einzelnen Regelabruf erneut.

### Aktualisieren

Der Marketplace liefert neue Versionen des Plugins: In der Plugin-Verwaltung den Marketplace `empco-uwg-monitor-dev` aktualisieren und das Plugin auf die neue Version heben; in Claude Code `/plugin marketplace update empco-uwg-monitor-dev`. Die Plugin-Version auf der Seite des Plugins bestätigt den neuen Stand. Danach eine neue Cowork-Sitzung starten; der Connector bleibt in der Regel verbunden, andernfalls wie unter „Verbindung neu anmelden“ erneut verbinden.

Ein per Zip-Upload installiertes Plugin lässt sich nicht zuverlässig überschreiben: Es zuerst unter **Customize > Plugins**, Reiter **Yours** (deutsche Oberfläche: **Anpassungen > Plugins > Deine**) über **Entfernen** löschen, dann die neue Zip-Datei hochladen. Erscheint die neue Fassung nicht sofort, kann sie verzögert sein; nach einer Stunde erneut prüfen.

### Verbindung neu anmelden

Wenn `fetch_claims_monitor_step` fehlt: **Customize > Plugins**, Reiter **Yours** (deutsche Oberfläche: **Anpassungen > Plugins > Deine**) → das installierte Plugin `EmpCo-UWG Monitor (Dev)` öffnen → dort auf dem plugin-eigenen Reiter **Connectors** (nicht der allgemeine „Connectors"-Menüpunkt in der Customize-Navigation) beim Eintrag `empco-uwg-monitor-dev` erneut verbinden und den Hinweisen im geöffneten Browserfenster folgen. Nach erfolgreicher Anmeldung eine neue Cowork-Sitzung starten und die Anfrage erneut stellen.

## ChatGPT

ChatGPT läuft als Desktop-App und im Browser (chatgpt.com, Web-App) und hat drei Modi: Chat, Work und Codex.

### Installation

Das Plugin gilt für die ChatGPT-Desktop-App, in allen Tarifen einschließlich Free. Es wird über den **Marketplace** `tobias-zucali/EmpCo-UWG-Monitor-Plugin` installiert (empfohlen; darüber lässt sich das Plugin aktualisieren und entfernen).

**Voraussetzung in der Desktop-App:** Unter **Einstellungen > Allgemein** muss **Plugins** („Allow ChatGPT to use installed plugins") eingeschaltet sein. Dieser Schalter erlaubt ChatGPT, installierte Plugins zu verwenden.

1. In der Desktop-App unter **Plugins** → **Hinzufügen** den Marketplace hinzufügen und `tobias-zucali/EmpCo-UWG-Monitor-Plugin` eingeben. In Codex im Terminal: `codex plugin marketplace add tobias-zucali/EmpCo-UWG-Monitor-Plugin`.
2. Das Plugin `EmpCo-UWG Monitor (Dev)` aus diesem Marketplace installieren.
3. In der Desktop-App **Plugins** → Reiter **Persönlich** öffnen und beim Eintrag `EmpCo-UWG Monitor (Dev)` auf **+** klicken. ChatGPT leitet zur Anmeldung weiter: dort den Zugangscode eingeben und bestätigen.

Ist der Marketplace nicht erreichbar, lässt sich dasselbe Paket als Zip-Datei hochladen: `https://snowflake-blasphemy-waged.ngrok-free.dev/downloads/empco-uwg-monitor-plugin.zip` herunterladen und in der Desktop-App oder im Browser (chatgpt.com) unter **Plugins** → **Hinzufügen** → **Plugin hochladen** auswählen; danach Schritt 3. Ein hochgeladenes Plugin lässt sich in ChatGPT weder aktualisieren noch löschen.

### Aktualisieren

In der Desktop-App den Marketplace unter **Plugins** aktualisieren; in Codex im Terminal `codex plugin marketplace upgrade`. Danach einen neuen Chat im Modus **Work** starten.

### Verwendung

In der Desktop-App den Modus **Work** wählen (empfohlen; im Standard-Chat und in der Web-App sind Skill und Verbindung des Plugins derzeit nicht verfügbar, beides kann sich mit der Unterstützung durch ChatGPT ändern), neuen Chat starten und einen Prüfauftrag stellen, z. B. „Prüfe: „Unsere Verpackung ist 100 % umweltfreundlich."" Im Browser steht die Verbindung des Plugins derzeit nicht zur Verfügung – dort ist keine Prüfung möglich.

### Verbindung neu anmelden

Wenn `fetch_claims_monitor_step` fehlt: **Einstellungen** → **Plugins** → Reiter **MCPs** → unter „From plugins" beim Eintrag `empco-uwg-monitor-dev` auf **Authenticate** klicken und den Hinweisen im geöffneten Browserfenster folgen. Nach erfolgreicher Anmeldung einen neuen Chat starten und die Anfrage erneut stellen.

## Wenn es nicht funktioniert

Angaben für eine Supportanfrage und die Kontaktadresse stehen unter `https://snowflake-blasphemy-waged.ngrok-free.dev/support`. Jeder Supportanfrage liegt der Bericht der Diagnose bei (letzter Punkt dieser Liste).

- **Die Verbindung fehlt oder die Sitzung ist nicht mehr gültig:** Einmal wie oben beschrieben in der jeweiligen Anwendung neu anmelden (in ChatGPT auf **Authenticate**). Ein abgelaufenes OAuth-Token kann dabei erneuert werden; danach einen neuen Chat starten.
- **Die Anmeldeseite meldet, dass der Zugangscode gesperrt oder abgelaufen ist:** Eine erneute Anmeldung mit demselben Code stellt den Zugriff nicht wieder her. Die Diagnose ausführen. Den Support kontaktieren, deren Bericht beifügen und die angezeigte Meldung nennen.
- **Anmeldung kann nicht abgeschlossen werden oder `fetch_claims_monitor_step` fehlt weiterhin:** Die Diagnose ausführen. Den Support kontaktieren und deren Bericht beifügen. Der Assistent nennt die im Plugin mitgelieferte Supportadresse.
- **Marketplace lässt sich nicht hinzufügen oder Plugin nicht installieren:** Schreibweise `tobias-zucali/EmpCo-UWG-Monitor-Plugin` prüfen und die Anwendung aktualisieren. Als Rückfall die Zip-Datei hochladen (siehe Installation); bei einem Fehler zur Zip-Struktur die Datei erneut vom Server laden statt manuell zu bearbeiten. Die manuelle Einrichtung nur der MCP-Verbindung ist kein Ersatz, weil dabei der Skill des Plugins fehlt.
- **Bericht für den Support (jeder Anfrage beifügen):** Der Diagnose-Skill des Plugins erzeugt einen belegten Bericht mit ausschließlich technischen Angaben zu Umgebung, Verbindung und Versionen; geprüfte Inhalte gehören nie dazu. Aufruf in Claude mit `/empco-uwg-monitor-dev:diagnose-monitor-plugin`, in ChatGPT mit `@` und Auswahl des Skills, in Codex mit `$`; gefragt wird zuerst nach dem Umfang (Standard mit Abruf, Minimal ohne Abruf, Vollständig mit Werkzeugliste); enthält das Gespräch bereits eine Prüfung, wertet der Bericht deren Ablauf mit aus. Den Bericht (der Kasten mit dem Text) kopieren und senden. Wo Skills nicht verfügbar sind, steht derselbe Text unter `https://snowflake-blasphemy-waged.ngrok-free.dev/docs/diagnose` zum Einfügen bereit.
- **Öffentliche Dokumentation der Schnittstelle:** `https://snowflake-blasphemy-waged.ngrok-free.dev/docs/mcp`
