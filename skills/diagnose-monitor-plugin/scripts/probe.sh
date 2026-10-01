#!/usr/bin/env bash
# Umgebungsprobe des Diagnose-Skills: lesend, ohne Netzwerkzugriff.
# Standard: keine Benutzernamen, Pfade oder Umgebungsvariablen.
# Mit --roh zusätzlich Benutzer, Arbeitsverzeichnis und markierte Umgebungshinweise
# (nur auf Anfrage des Supports mit Freigabe der Person).
set -u
roh=0
[ "${1:-}" = "--roh" ] && roh=1

echo "## time"
date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || echo unknown

echo "## os"
uname -srm 2>/dev/null || echo unknown

echo "## path_markers"
for p in /mnt/data /mnt/user-data /mnt/user-data/uploads /mnt/user-data/outputs /mnt/skills /home/claude /home/sandbox /workspace; do
  [ -e "$p" ] && echo "present: $p"
done
for p in "${HOME:-/nonexistent}/.claude" "${HOME:-/nonexistent}/.codex"; do
  [ -e "$p" ] && echo "present: ~/${p##*/}"
done

echo "## binaries"
for b in python3 node pandoc libreoffice soffice git curl; do
  command -v "$b" >/dev/null 2>&1 && echo "$b: yes"
done

echo "## python_libs"
python3 - <<'PY' 2>/dev/null
import importlib.util as u
for m in ["docx", "openpyxl", "pptx", "jinja2", "reportlab", "pypdf"]:
    print(f"{m}: {'yes' if u.find_spec(m) else 'no'}")
PY

if [ "$roh" = 1 ]; then
  echo "## roh"
  echo "user=$(id -un 2>/dev/null) cwd=$(pwd)"
  env 2>/dev/null | grep -E '^(CLAUDE|CLAUDECODE|CODEX|OPENAI_|CHATGPT|TERM_PROGRAM|CI|GITHUB_ACTIONS)' |
    sed -E 's/((KEY|TOKEN|SECRET|PASSWORD|AUTH|COOKIE)[^=]*=).*/\1<redacted>/' | sed -E 's/(=.{60}).*/\1.../'
fi
