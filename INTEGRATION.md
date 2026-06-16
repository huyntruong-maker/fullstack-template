# Attaching the pack to an existing project

Goal: drop the pack into a project that is already set up, then implement the features in `docs/BACKLOG.md`.

## Quick install (drop-in copy)
Copy `.claude/` + `docs/` additively and wire the `CLAUDE.md` import, then run `/start`:
```bash
# macOS / Linux
cp -R fullstack-pack/.claude  /your-project/.claude
cp -R fullstack-pack/docs     /your-project/docs
echo '@.claude/fullstack-pack.CLAUDE.md' >> /your-project/CLAUDE.md
```
```powershell
# Windows PowerShell
Copy-Item -Recurse fullstack-pack\.claude C:\your-project\.claude
Copy-Item -Recurse fullstack-pack\docs    C:\your-project\docs
Add-Content C:\your-project\CLAUDE.md "`n@.claude/fullstack-pack.CLAUDE.md"
```

## The git stash attach pattern (clean, on its own commit)
Use when you have uncommitted work and want the pack on a separate, reviewable commit:
```bash
cd /path/to/your-project

# 1. Park your in-progress work
git stash push -u -m "wip before attaching fullstack-pack"

# 2. Attach the pack on its own branch/commit
git checkout -b chore/attach-fullstack-pack
cp -R /path/to/fullstack-pack/.claude .claude
cp -R /path/to/fullstack-pack/docs    docs
echo '@.claude/fullstack-pack.CLAUDE.md' >> CLAUDE.md
git add .claude docs CLAUDE.md
git commit -m "chore: attach fullstack-pack (.claude + docs/plan)"

# 3. Restore your work on top
git stash pop
```

## MCP (optional)
Copy the server blocks you want from `.claude/mcp/*.json` into your project's `.mcp.json`
(or `claude mcp add ...`) and set env vars — see `.claude/mcp/README.md`.

## Updating / removing
- Update: re-copy `.claude/` + `docs/` or run `/sync-pack`.
- Remove: delete the pack-owned items under `.claude/` and the import line in `CLAUDE.md`. Your code is untouched.
