# fullstack-pack (drop-in)

A lean, **drop-in** set of Claude Code agents, skills, commands, rules, hooks and MCP configs that
you stash into an existing fullstack project and use to implement features. No plugin/marketplace —
just copy `.claude/` + `docs/` into your repo.

Target stack: **ASP.NET Core Web API (.NET 8+) + React (TypeScript)**.
This copy is pre-loaded with the plan for a **travel trip-planner** app (see `docs/BACKLOG.md`).

## Install (drop-in)
```
# macOS / Linux
./install.sh /path/to/your-project

# Windows PowerShell
.\install.ps1 -Target C:\path\to\your-project
```
This copies `.claude/` and `docs/` into your project (additive — nothing overwritten) and adds
`@.claude/fullstack-pack.CLAUDE.md` to your `CLAUDE.md`. Then open the project in Claude Code and run `/start`.

Prefer doing it on its own commit? See **[INTEGRATION.md](INTEGRATION.md)** (the `git stash` attach flow).

## Daily use
1. Open `docs/BACKLOG.md`, pick a story (follow the wave order).
2. `/plan` → `/orchestrate "<story>"` (or `/build`).
3. `/review` → `/ship`.

## What's inside
```
.claude/
  agents/    11 specialists (orchestrator, backend-lead, frontend-lead, database-expert,
             qa-engineer, cicd-engineer, deploy-engineer, systems-architect, code-reviewer,
             security-auditor, docs-writer)
  skills/    16 skills — 7 lifecycle + 9 stack (.NET/React/EF Core/API/security/ci-cd/deploy)
  commands/  /start /orchestrate /spec /plan /build /test /review /ship /sync-pack
  rules/     always-on guidelines (common + dotnet + react)
  hooks/     auto format / test / security-scan
  mcp/       github · filesystem · postgres · mssql server configs (merge into .mcp.json)
docs/
  PRD.md · BACKLOG.md · ARCHITECTURE.md · API.md · DATABASE.md   (this project's plan)
  templates/   blank docs for future features
```

## License
MIT — see [LICENSE](LICENSE).
