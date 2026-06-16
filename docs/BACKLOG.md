# Backlog & Implementation Plan — Travel Trip Planner

Pick work from here in wave order. `MVP` = "Selected US? = Yes" in the source sheet.
Branch naming: `feature/<feature>-<us>-<slug>` (e.g. `feature/auth-us1-signup`).

## Story map (priority + scope + owner)

### Feature 1 — Destination Suggestion
| US | Title | Priority | MVP | Wave | Primary owner |
|----|-------|----------|-----|------|---------------|
| US1 | Autocomplete for search field | Medium | — | 5 | frontend-lead + backend-lead |
| US2 | Search by city/country | High | Yes | 2 | backend-lead + frontend-lead |
| US3 | View recommended attractions list | High | Yes | 2 | backend-lead + frontend-lead |
| US4 | Filter recommended attractions | Medium | — | 5 | frontend-lead |
| US5 | Sort attractions | Low | — | 5 | frontend-lead |

### Feature 2 — Destination Details
| US | Title | Priority | MVP | Wave | Primary owner |
|----|-------|----------|-----|------|---------------|
| US1 | Open a destination details view | Medium | Yes | 3 | backend-lead + frontend-lead |
| US2 | View photos in details | Medium | Yes | 3 | frontend-lead |
| US3 | View map and location info | Low | — | 5 | frontend-lead |
| US4 | View opening hours when available | Low | Yes | 3 | backend-lead |

### Feature 3 — Trip Planner
| US | Title | Priority | MVP | Wave | Primary owner |
|----|-------|----------|-----|------|---------------|
| US1 | Create a trip | High | Yes | 4 | backend-lead + database-expert |
| US2 | Set trip start/end dates (generate days) | High | Yes | 4 | backend-lead + database-expert |
| US3 | Add a destination to a trip | High | Yes | 4 | backend-lead + frontend-lead |
| US4 | Drag-drop destinations into a day | Medium | — | 5 | frontend-lead |
| US5 | Reorder destinations within a day | High | — | 5 | frontend-lead + backend-lead |
| US6 | Move a destination between days | High | — | 5 | frontend-lead + backend-lead |
| US7 | Remove a destination from itinerary | High | Yes | 4 | backend-lead + frontend-lead |
| US8 | Require login to save | Medium | Yes | 4 | backend-lead + security-auditor |
| US9 | Auto-save trips/destinations | Medium | — | 5 | backend-lead + frontend-lead |
| US10 | Load saved trips on return | Medium | Yes | 4 | backend-lead + frontend-lead |

### Feature 4 — User Authentication
| US | Title | Priority | MVP | Wave | Primary owner |
|----|-------|----------|-----|------|---------------|
| US1 | Sign up with email + password | Medium | Yes | 1 | backend-lead + security-auditor |
| US2 | Verify email to activate account | Medium | Yes | 1 | backend-lead |
| US3 | Log in with email + password | Medium | Yes | 1 | backend-lead + security-auditor |
| US4 | Log out | Medium | Yes | 1 | backend-lead + frontend-lead |

## Implementation waves (suggested order for /orchestrate)

**Wave 0 — Foundation** (systems-architect, cicd-engineer, database-expert)
Solution scaffold (API + Web), EF Core + initial migration, health check, GitHub Actions CI
(build + test + lint for .NET and React). Acceptance: pipeline green on an empty slice.

**Wave 1 — Authentication (F4 US1–US4)** — gates everything that saves data.
Register (unique email, password ≥8, bcrypt/argon2, generic errors), email verification token flow,
login (JWT access + refresh, stay signed in after refresh), logout (end session, block protected pages).
Frontend: sign-up/login/logout pages + route guards. Owner: backend-lead, security-auditor, frontend-lead.

**Wave 2 — Destination Suggestion (F1 US2, US3)**
Provider integration behind `IDestinationProvider` (OpenTripMap geocoding + POIs, Foursquare enrich).
`GET /locations/search` (cities+countries, rank exact-first, max 5, dedupe, case-insensitive, partial).
`GET /attractions` (coords+radius, city default 20 km, max 20/page, ranking, "No attractions found" empty state).
Caching layer to meet NFR-1 (≤500 ms) and NFR-2 (≤1000 ms). Frontend: search box + results grid with thumbnails/placeholders.

**Wave 3 — Destination Details (F2 US1, US2, US4)**
`GET /destinations/{providerPlaceId}` (name, category, description, photos, opening hours; opens even with missing fields).
Frontend: detail view + photo carousel + "Opening hours not available" fallback; "Add to Trip" disabled when logged out. NFR-3 ≤2 s.

**Wave 4 — Trip Planner MVP (F3 US1, US2, US3, US7, US8, US10)**
Trips CRUD (name required), set dates → generate one ItineraryDay per date (start ≤ end; warn when reducing days drops items),
add destination to trip (select a day), remove destination, require login (resume action after login), load saved trips with empty state.
Enforce NFR-6 (own-data-only) on every query. Frontend: trip list + planner board.

**Wave 5 — Backlog / enhancements**
F1 autocomplete (US1), filters (US4), sort (US5); F2 map (US3);
F3 drag-drop scheduling (US4), reorder (US5), move between days (US6) — meet NFR-4 (≤100 ms); F3 autosave (US9).

## Definition of done (every story)
- Acceptance criteria from the sheet are met and demoed.
- Unit/integration tests cover the logic; relevant E2E for the user flow.
- Build + lint clean; `docs/API.md` / `docs/DATABASE.md` updated by the owning agent.
- For auth/data stories: security-auditor checks authorization (NFR-6) and secrets handling.
