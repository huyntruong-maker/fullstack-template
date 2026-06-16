# Travel Trip Planner — project guidance

@.claude/fullstack-pack.CLAUDE.md

## This project
ASP.NET Core Web API (.NET 8+) + React (TypeScript). Discover destinations (OpenTripMap + Foursquare),
view details, and plan a saved multi-day trip itinerary.

## Source of truth
- docs/PRD.md — requirements, MVP scope, NFRs.
- docs/BACKLOG.md — feature/user-story plan with implementation waves. Pick work here.
- docs/ARCHITECTURE.md, docs/API.md, docs/DATABASE.md — living technical docs.

## How to work
Open docs/BACKLOG.md, pick a story by wave order, then `/plan` → `/orchestrate "<story>"` → `/review` → `/ship`.
Enforce NFR-1 (search ≤500ms) and NFR-6 (users access only their own data).
