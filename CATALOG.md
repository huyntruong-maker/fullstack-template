# Component Catalog

Every component in the pack. After install they live under your project's `.claude/`.

## Agents (`agents/`)
| Agent | Model | Role |
| --- | --- | --- |
| orchestrator | sonnet | Tech-lead. Plans wave-based execution across specialists; approval-gated; stops on failure. |
| systems-architect | opus | High-level design, tech decisions, ADRs. Owns ARCHITECTURE.md, DECISIONS.md. |
| backend-lead | sonnet | ASP.NET Core Web API: DI, EF Core, validation, ProblemDetails, auth. Owns API.md. |
| frontend-lead | sonnet | React/TypeScript: components, TanStack Query, forms, a11y. Owns frontend docs. |
| database-expert | sonnet | EF Core + SQL Server/PostgreSQL: schema, migrations, indexing. Owns DATABASE.md. |
| qa-engineer | sonnet | Test strategy: xUnit, Vitest/Testing Library, Playwright E2E. Owns tests/. |
| cicd-engineer | sonnet | GitHub Actions, build/test/lint gates, releases. Owns .github/workflows, CICD.md. |
| deploy-engineer | sonnet | Docker/GHCR, compose, health checks, rollout/rollback. Owns DEPLOY.md, Dockerfiles. |
| code-reviewer | sonnet | Read-only five-axis review with severity labels. |
| security-auditor | sonnet | Read-only OWASP Top 10 / secrets / dependency audit. |
| docs-writer | haiku | README/USER_GUIDE and living-doc upkeep. |

## Skills (`skills/`)
Lifecycle: using-the-pack (meta router), spec-driven-development, planning-and-task-breakdown,
incremental-implementation, test-driven-development, code-review-and-quality, git-workflow-and-versioning.

Stack: dotnet-webapi-patterns, dotnet-testing, react-ui-engineering, react-data-and-state,
api-and-interface-design, database-and-ef-core, security-and-hardening, ci-cd-and-automation,
deployment-and-release.

## Commands (`commands/`)
| Command | Does |
| --- | --- |
| /start | Onboard into an existing project: detect stack, seed docs + TODO. Code-safe. |
| /orchestrate <task> | Run the orchestrator: plan waves, approve, execute specialists. |
| /spec <idea> | Write a PRD/spec before code. |
| /plan <spec> | Break a spec into small verifiable tasks. |
| /build <task> | Implement in thin vertical slices. |
| /test <target> | TDD / test-strategy pass. |
| /review | code-reviewer + security-auditor on the current diff. |
| /ship <change> | Git + CI/CD checks, prepare PR / release. |
| /sync-pack | Pull latest pack components into .claude/ (diff + confirm, no deletes). |

## Rules (`rules/`)
common/: coding-style, git-workflow, testing, security, agents.
dotnet/: dotnet-style, dotnet-testing. react/: react-style, react-testing.

## Hooks (`hooks/`)
hooks.json + format-code.sh, run-tests.sh, security-scan.sh. All degrade gracefully if tools absent.

## MCP (`mcp/`)
github-mcp.json, filesystem-mcp.json, postgres-mcp.json, mssql-mcp.json (+ README with env vars).

## Doc templates (`docs/templates/`)
PRD, ARCHITECTURE, API, DATABASE, DECISIONS, CICD, DEPLOY, USER_GUIDE, TASK_TEMPLATE.
