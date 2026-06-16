# Architecture — Travel Trip Planner

Owner agent: systems-architect. Living doc — update when structure changes.

## Overview
React SPA → ASP.NET Core Web API → (EF Core) SQL database + cache + external providers (OpenTripMap, Foursquare).

```
[React SPA] --HTTPS/JSON--> [ASP.NET Core Web API] --EF Core--> [SQL Server / PostgreSQL]
                                   |  \--> [Cache: IMemoryCache / Redis]
                                   \--> [Provider clients: OpenTripMap, Foursquare]
```

## Backend (ASP.NET Core Web API, .NET 8+)
Layered solution:
- `Api` — controllers/minimal endpoints, auth middleware, ProblemDetails, request validation (FluentValidation).
- `Application` — use-case services (search, attractions, details, trips), DTOs.
- `Domain` — entities (User, Trip, ItineraryDay, TripDestination), rules.
- `Infrastructure` — EF Core DbContext + migrations, provider clients, caching, email sender.

Cross-cutting: JWT auth (access + refresh), global exception → ProblemDetails, structured logging, options pattern for provider keys.

### External providers
Wrap behind `IDestinationProvider` and `IGeocodingProvider` so providers are swappable and mockable in tests.
- OpenTripMap: geocoding (name → lat/lng), POIs by radius (city default 20 km).
- Foursquare: enrich POIs with categories/reviews.
Responses normalized to internal `DestinationDto`. Cache normalized results (see NFRs).

### Performance / scalability (NFR-1,2,5)
- Cache geocoding + attractions responses (key = normalized query / placeId), short TTL.
- Pagination (max 20/page) and provider-side filtering; never load all records.
- Optional `DestinationCache` table for popular places to cut provider latency.

## Frontend (React + TypeScript, Vite)
- Server state: TanStack Query (search, attractions, details, trips) with caching/optimistic updates.
- Client state: lightweight store (Zustand) for trip-board UI; forms via react-hook-form + zod.
- Routing with guarded routes (auth required for trip pages). Accessibility: WCAG 2.1 AA.
- Map (Leaflet) and drag-drop (dnd-kit) are deferred (Wave 5).

## Auth & authorization
- JWT access token (short-lived) + refresh token; "stay signed in after refresh".
- Email verification token before activation.
- NFR-6: every trip/destination query is scoped by the authenticated `UserId`; no cross-user access.

## Environments
local (docker-compose: api + web + db) → staging → production. Health check endpoint for probes.
