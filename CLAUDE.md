# fullstack-pack — operating guidance

This file is imported into a project's `CLAUDE.md` (via `@.claude/fullstack-pack.CLAUDE.md`)
when the pack is installed as a drop-in. It tells Claude how to use the pack in this project.

## What this project has available
- Specialist agents in `.claude/agents/` (orchestrator, systems-architect, backend-lead,
  frontend-lead, database-expert, qa-engineer, cicd-engineer, deploy-engineer, code-reviewer,
  security-auditor, docs-writer).
- Skills in `.claude/skills/` — lifecycle (spec → plan → build → test → review → ship) and
  stack-specific (.NET Web API, React, EF Core, API design, security, CI/CD, deploy).
- Slash commands in `.claude/commands/` (/start, /orchestrate, /spec, /plan, /build, /test,
  /review, /ship, /sync-pack).
- Rules in `.claude/rules/` and hooks in `.claude/hooks/`.

## Default workflow
1. New project or feature: `/spec` → `/plan` → `/orchestrate` (or `/build`).
2. Always verify before declaring done: tests pass, build succeeds, lint clean.
3. `/review` runs code-reviewer + security-auditor before merge.
4. `/ship` prepares the PR / release through the git + CI/CD skills.

## Hard rules
- Follow Conventional Commits and `feature/<id>-desc` branch naming.
- Prefer small, atomic, rollback-friendly changes (thin vertical slices).
- Treat `PRD.md` / `docs/` as living docs; the owning agent updates its doc before a task is done.
- Be additive when integrating into an existing codebase: do not rewrite working code without an
  explicit request. Match the project's existing conventions over the pack's defaults when they conflict.

## Stack defaults (override per project)
- Backend: ASP.NET Core Web API (.NET 8+), EF Core, FluentValidation, ProblemDetails.
- Frontend: React + TypeScript, TanStack Query, react-hook-form + zod.
- Tests: xUnit (backend), Vitest/Testing Library (frontend), Playwright (E2E).
