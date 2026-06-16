# claude-fullstack-pack

A drop-in **Claude Code** pack that turns Claude into a coordinated fullstack team for *any*
project. It bundles specialist **agents**, lifecycle + stack **skills**, slash **commands**,
**rules**, **hooks**, and **MCP** configs — designed to be attached to a codebase that is
*already set up* and used immediately.

Default target stack: **ASP.NET Core Web API (.NET 8+) backend + React (TypeScript) frontend**.
The lifecycle layer is stack-agnostic; the stack layer is .NET/React-specific and easy to swap.

> Built by studying and combining the best ideas from
> [orchestrated-project-template](https://github.com/josipjelic/orchestrated-project-template) (wave orchestration + living docs),
> [ECC](https://github.com/affaan-m/ECC) (plugin packaging + rules + hooks),
> [claude-howto](https://github.com/luongnv89/claude-howto) (clean component layout + MCP configs), and
> [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) (verification-gated lifecycle skills).

---

## Two ways to use it

### A. Plugin (marketplace)
```
/plugin marketplace add https://github.com/huyakai-109/fullstack-template
/plugin install fullstack-pack@fullstack-pack-marketplace
```

### B. Drop-in into an existing project (recommended for your own repos)
From the pack directory:
```
# macOS / Linux
./install.sh /path/to/your-project

# Windows PowerShell
.\install.ps1 -Target C:\path\to\your-project
```
This copies the components into `your-project/.claude/` **additively** (nothing is overwritten),
then tells you to add one import line to your project's `CLAUDE.md` and run `/start`.

See **[INTEGRATION.md](INTEGRATION.md)** for the full attach workflow (including the `git stash`
pattern for layering the pack onto an in-progress checkout).

---

## Quick start (after install)
1. `/start` — Claude detects your stack, summarizes the architecture, and seeds `docs/` + a TODO backlog. It never edits your code.
2. `/spec "<feature>"` → `/plan` → `/orchestrate "<feature>"` — design, break down, and build wave by wave.
3. `/review` then `/ship` — quality + security review, then PR/release.

---

## What's inside
- `agents/` — 11 specialist subagents (orchestrator + BE/FE/QA/DB/CICD/deploy/architect/reviewer/security/docs).
- `skills/` — 16 skills: 7 lifecycle + 9 stack-specific. Each has a verification gate.
- `commands/` — 9 slash commands mapping to the development lifecycle.
- `rules/` — always-follow guidelines (common + dotnet + react).
- `hooks/` — format / test / security-scan hooks (`hooks.json` + scripts).
- `mcp/` — ready-to-merge MCP server configs (github, filesystem, postgres, mssql).
- `docs/templates/` — PRD, ARCHITECTURE, API, DATABASE, DECISIONS, CICD, DEPLOY, USER_GUIDE, TASK.

Full component list with one-line descriptions: **[CATALOG.md](CATALOG.md)**.

---

## Design principles
- **Design before code** — architect produces specs/ADRs; specialists implement.
- **Verification is non-negotiable** — every skill ends with evidence requirements (tests/build/lint).
- **Small atomic changes** — thin vertical slices, Conventional Commits, rollback-friendly.
- **Additive integration** — the pack supports an existing codebase; it doesn't rewrite it.
- **Document ownership** — each `docs/` file has one owning agent.

## License
MIT — see [LICENSE](LICENSE).
