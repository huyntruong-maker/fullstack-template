# Integrating the pack into an existing project

The pack is designed to attach to a project that is **already set up** (codebase, structure,
build all in place) and support development from there — without disturbing your code.

## Option 1 — Run the installer (simplest)
```
# macOS / Linux
git clone https://github.com/huyakai-109/fullstack-template
./claude-fullstack-pack/install.sh /path/to/your-project

# Windows PowerShell
.\claude-fullstack-pack\install.ps1 -Target C:\path\to\your-project
```
Then in your project's `CLAUDE.md` add:
```
@.claude/fullstack-pack.CLAUDE.md
```
Open the project in Claude Code and run `/start`.

The installer is **additive**: it only creates new files under `.claude/`. It never overwrites
your source, your existing `CLAUDE.md`, or any existing `.claude/` file with the same name unless
that file came from the pack.

## Option 2 — git subtree / submodule (keeps the pack updatable)
Vendor the pack under `.claude/` and pull updates later:
```
git subtree add --prefix .claude/_pack https://github.com/huyakai-109/fullstack-template main --squash
# then point your CLAUDE.md import at the vendored copy, or run its install.sh into .claude/
```
Update later with `git subtree pull --prefix .claude/_pack ... main --squash` or `/sync-pack`.

## Option 3 — the git stash attach pattern (layering onto an in-progress checkout)
Use this when you have uncommitted work in the project and want to drop the pack in cleanly,
on its own commit, without entangling it with your changes:
```
cd /path/to/your-project

# 1. Park your in-progress work so the tree is clean
git stash push -u -m "wip before attaching fullstack-pack"

# 2. Attach the pack on its own branch/commit
git checkout -b chore/attach-fullstack-pack
/path/to/claude-fullstack-pack/install.sh .
git add .claude CLAUDE.md
git commit -m "chore: attach claude-fullstack-pack (.claude agents/skills/commands)"

# 3. Restore your work on top
git stash pop
```
Now the pack lives in its own commit (easy to review, revert, or cherry-pick), and your
work-in-progress is back on top of it. Continue developing with `/spec`, `/orchestrate`, etc.

## Wiring MCP servers (optional)
The `mcp/` configs are not copied by default. To enable them, copy the server blocks you want
into your project's `.mcp.json` (or run `claude mcp add ...`) and set the env vars described in
`mcp/README.md` (GitHub token, DB connection strings, etc.).

## Updating the pack
Run `/sync-pack` (shows a diff and asks before changing anything; never deletes local-only files),
or re-run the installer / `git subtree pull`.

## Uninstalling
Delete the pack-owned items under `.claude/` (agents, commands, skills, rules, hooks that came
from the pack) and remove the `@.claude/fullstack-pack.CLAUDE.md` import line. Your code is untouched.
