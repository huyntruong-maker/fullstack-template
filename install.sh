#!/usr/bin/env bash
# fullstack-pack — drop-in installer (copy .claude/ and docs/ into a project).
# Usage: ./install.sh /path/to/your-project
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-$PWD}"
[ -d "$TARGET" ] || { echo "error: '$TARGET' not found" >&2; exit 1; }
echo "Installing pack into: $TARGET"
mkdir -p "$TARGET/.claude"
cp -R "$SCRIPT_DIR/.claude/." "$TARGET/.claude/"
chmod +x "$TARGET/.claude/hooks/"*.sh 2>/dev/null || true
# docs: copy without overwriting existing project docs
mkdir -p "$TARGET/docs"
cp -Rn "$SCRIPT_DIR/docs/." "$TARGET/docs/" 2>/dev/null || cp -R "$SCRIPT_DIR/docs/." "$TARGET/docs/"
# CLAUDE import line
if [ -f "$TARGET/CLAUDE.md" ]; then
  grep -q 'fullstack-pack.CLAUDE.md' "$TARGET/CLAUDE.md" || printf '\n@.claude/fullstack-pack.CLAUDE.md\n' >> "$TARGET/CLAUDE.md"
else
  printf '@.claude/fullstack-pack.CLAUDE.md\n' > "$TARGET/CLAUDE.md"
fi
cp "$SCRIPT_DIR/.claude-guidance.md" "$TARGET/.claude/fullstack-pack.CLAUDE.md"
echo "Done. Open in Claude Code and run /start. Nothing existing was overwritten."
