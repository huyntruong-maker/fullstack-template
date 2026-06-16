# Build Playbook — Travel Trip Planner

Copy-paste prompts for building the app **backend-first**, following the phases in
`docs/BACKLOG.md` ("Implementation plan"). Order is strict: finish Phase 0 → Phase 1
(all MVP DB + API) → Phase 2 (frontend) → Phase 3 (enhancements). Do not start a feature's
UI until its API contract is implemented and integration-tested.

Per feature, the flow is: contract → DB → endpoint → tests → docs, then `/review` → `/ship`.
Branch per story: `feature/<feature>-<us>-slug` (e.g. `feature/auth-us1-signup`).

---

## Kickoff (first time only)

If this pack was dropped into an **existing** repo, first reconcile it with the codebase
(see `INTEGRATION.md` → "After attaching"): read the existing code base, update `.claude/rules/` to
match the real style/conventions, fix "Stack defaults", and **reconcile** `docs/ARCHITECTURE.md` /
`API.md` / `DATABASE.md` with the existing code — compare what already exists and update both sides to
agree, **do not** overwrite or rewrite from scratch. For style/conventions specifically, the repo wins
over pack defaults.

```
/start Read the entire existing codebase and report the stack, structure, and conventions. Then update .claude/rules to match the real style, and reconcile docs/ARCHITECTURE.md, API.md, DATABASE.md with the existing code (compare and update both sides to agree, don't rewrite from scratch). Style: the repo wins over pack defaults.
```

Once reconciliation is done, run the kickoff against the plan:

```
/start Onboard the trip planner project per docs/PRD.md and docs/BACKLOG.md. Confirm the stack and build a TODO from the backend-first Implementation plan.
```

---

## Phase 0 — Foundation

```
/orchestrate "Phase 0 Foundation: scaffold the ASP.NET Core Web API solution, wire EF Core, design the DB schema for all MVP entities + create the initial migration, add a health check, and set up GitHub Actions CI (build + test + lint for the .NET API). Acceptance: pipeline green on an empty API slice."
```

Gate:

```
/review Confirm the pipeline is green, the migration runs, and docs/DATABASE.md & docs/API.md reflect the schema/contract.
```

---

## Phase 1 — Backend & Database (build before any UI)

Do one feature at a time. After each: run the gate, then move on.

### 1.1 Auth API — F4 US1–US4

```
/plan "Phase 1.1 Auth API (F4 US1–US4): DB Users/EmailVerificationTokens/RefreshTokens; endpoints register/verify/login/refresh/logout; JWT access+refresh; bcrypt/argon2 hashing; generic errors to prevent account enumeration."
```
```
/orchestrate "Build Phase 1.1 Auth API per the approved plan. Include integration tests (WebApplicationFactory + Testcontainers) and update docs/API.md & docs/DATABASE.md."
```

### 1.2 Destination Suggestion API — F1 US2, US3

```
/orchestrate "Phase 1.2 Destination Suggestion API (F1 US2,US3): IDestinationProvider/IGeocodingProvider (OpenTripMap+Foursquare), GET /locations/search (cities+countries, exact-first, max 5, dedupe, case-insensitive, partial) and GET /attractions (coords+radius, city 20km, max 20/page, empty 'No attractions found'), caching to meet NFR-1 ≤500ms & NFR-2 ≤1000ms. Include tests + docs."
```

### 1.3 Destination Details API — F2 US1, US2, US4

```
/orchestrate "Phase 1.3 Destination Details API (F2 US1,US2,US4): GET /destinations/{providerPlaceId} returning name/category/description/photos/address?/website?/openingHours, opens even when fields are missing, NFR-3 ≤2s. Include tests + docs."
```

### 1.4 Trips API + DB — F3 US1, US2, US3, US7, US8, US10

```
/orchestrate "Phase 1.4 Trips API + DB (F3 US1,US2,US3,US7,US8,US10): Trips/ItineraryDays/TripDestinations + migration; trip CRUD (name required); set dates → generate one ItineraryDay per date (start ≤ end, warn when reducing days drops items); add-destination requires itineraryDayId; remove; load saved trips (empty state). Auth-gate + NFR-6 on every query. Include tests + docs."
```

### Gate per feature (and exit gate for Phase 1)

```
/review Current branch: all of the feature's endpoints present, integration tests green, relevant NFRs met (NFR-1/NFR-6), docs/API.md & docs/DATABASE.md updated.
```
```
/ship feature/<feature>-<us>-slug
```

Phase 1 is done when: all MVP endpoints are implemented, integration tests are green, NFR-1 and NFR-6 are verified, and docs are updated.

---

## Phase 2 — Frontend (only after Phase 1 is done)

```
/orchestrate "Phase 2 Frontend, wired to the stable APIs, in feature order: auth (pages + route guards) → search box + results grid (thumbnails/placeholders) → detail view + photo carousel + 'Opening hours not available' fallback (Add to Trip disabled when logged out) → trip list + planner board (create trip, set dates, add to a selected day, remove, load saved). Use TanStack Query + react-hook-form/zod."
```

Gate:

```
/review UI: renders loading/empty/error/success states, basic accessibility (roles/labels/focus), RTL/MSW tests green, typecheck + lint clean.
```

---

## Phase 3 — Enhancements (post-MVP, backend-then-frontend per item)

Pick one at a time:

```
/orchestrate "F1-US1 Autocomplete for the search field (≥2 chars, up to 5 suggestions). Backend first, then frontend."
```
```
/orchestrate "F1-US4 Filter + F1-US5 Sort attractions (category, rating/popularity; sort recommended/highest). Backend first, then frontend."
```
```
/orchestrate "F2-US3 View map + location info (marker, zoom/pan, address label)."
```
```
/orchestrate "F3-US4/US5/US6 Drag-drop scheduling, reorder within a day, drag between days — meet NFR-4 ≤100ms. Backend (position/itineraryDayId) first, then frontend with dnd-kit."
```
```
/orchestrate "F3-US9 Autosave trips/destinations (saving indicator, retry on failure)."
```

---

## Tips to stay backend-first
- Phase 0 and Phase 1: DB + API + tests only, no frontend.
- Do one feature at a time; finish `/review` + `/ship` before moving to the next.
- One branch per story (`feature/...`), commit with Conventional Commits.
- Always enforce NFR-1 (search ≤500ms) and NFR-6 (own-data-only) on the relevant stories.
