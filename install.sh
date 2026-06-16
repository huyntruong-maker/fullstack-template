#!/usr/bin/env bash
# claude-fullstack-pack — drop-in installer
# Copies pack components into a target project's .claude/ directory (additive, non-destructive).
# Usage:
#   ./install.sh                 # install into current directory
#   ./install.sh /path/to/proj   # install into a specific project
#   ./install.sh --with-mcp /path/to/proj   # also merge MCP server hints into .mcp.json
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WITH_MCP=0
TARGET=""

for arg in "$@"; do
  case "$arg" in
    --with-mcp) WITH_MCP=1 ;;
    -h|--help)
      grep '^#' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) TARGET="$arg" ;;
  esac
done
TARGET="${TARGET:-$PWD}"

if [ ! -d "$TARGET" ]; then
  echo "error: target directory '$TARGET' does not exist" >&2; exit 1
fi

echo "Installing claude-fullstack-pack into: $TARGET/.claude"
mkdir -p "$TARGET/.claude"/{agents,commands,skills,rules,hooks}

copy() { # copy <srcdir> <destdir>
  if [ -d "$SCRIPT_DIR/$1" ]; then
    cp -R "$SCRIPT_DIR/$1/." "$TARGET/.claude/$2/"
    echo "  + $2/"
  fi
}
copy agents agents
copy commands commands
copy skills skills
copy rules rules
copy hooks hooks
chmod +x "$TARGET/.claude/hooks/"*.sh 2>/dev/null || true

# Pack-level guidance file (kept separate so we never clobber a project's own CLAUDE.md)
cp "$SCRIPT_DIR/CLAUDE.md" "$TARGET/.claude/fullstack-pack.CLAUDE.md"
echo "  + .claude/fullstack-pack.CLAUDE.md (import this from your project's CLAUDE.md)"

if [ "$WITH_MCP" -eq 1 ]; then
  echo "MCP configs are in this pack under mcp/. Review and merge into $TARGET/.mcp.json:"
  ls "$SCRIPT_DIR/mcp/"*.json | sed 's#^#  #'
  echo "See mcp/README.md for the exact env vars and merge steps."
fi

cat <<MSG

Done. Next steps:
  1. Add this line to your project's CLAUDE.md (create it if absent):
        @.claude/fullstack-pack.CLAUDE.md
  2. Open the project in Claude Code and run:  /start
  3. (Optional) wire MCP servers: see mcp/README.md
Nothing existing was overwritten — only new files were added under .claude/.
MSG
