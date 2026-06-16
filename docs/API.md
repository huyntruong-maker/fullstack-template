# API Reference — Travel Trip Planner

Owner agent: backend-lead. Base path `/api/v1`. Errors as RFC 7807 ProblemDetails. Update after every endpoint change.

## Auth (Feature 4)
- `POST /auth/register` — body {email, password}. 201 on success; generic 400 if email taken / weak password (no enumeration). [F4-US1]
- `GET  /auth/verify-email?token=` — activate account. [F4-US2]
- `POST /auth/login` — {email, password} → {accessToken, refreshToken}. 401 invalid (generic). [F4-US3]
- `POST /auth/refresh` — {refreshToken} → new tokens (stay signed in). 
- `POST /auth/logout` — revoke refresh token / end session. [F4-US4]

## Destination suggestion (Feature 1)
- `GET /locations/search?q=` — cities + countries; rank exact-first; max 5; dedupe; case-insensitive; partial match. [F1-US2] (NFR-1 ≤500ms)
- `GET /attractions?lat=&lng=&radius=&page=` (or `?placeId=`) — POIs; city default radius 20 km; max 20/page; name, category, rating, thumbnail; empty → "No attractions found". [F1-US3] (NFR-2 ≤1000ms)

## Destination details (Feature 2)
- `GET /destinations/{providerPlaceId}` — name, category, description, photos[], openingHours?, address?, website?. Opens even if fields missing. [F2-US1/US2/US4] (NFR-3 ≤2s)

## Trips (Feature 3) — all require auth; scoped to current user (NFR-6)
- `GET    /trips` — list current user's trips (empty state allowed). [F3-US10]
- `POST   /trips` — {name} required → created trip. [F3-US1]
- `GET    /trips/{id}` — trip with itinerary days + destinations. [F3-US10]
- `PUT    /trips/{id}` — {name?, startDate?, endDate?}; start ≤ end; regenerate days; warn-confirm when reducing days drops items. [F3-US2]
- `POST   /trips/{id}/destinations` — add destination {providerPlaceId, name, category, thumbnailUrl, lat, lng, itineraryDayId}. [F3-US3]
  - MVP: `itineraryDayId` is **required** — US3 has the user select a day (drag-drop scheduling US4 is out of MVP). The column stays nullable in the DB to support a future "Saved Places" bucket (US4).
- `DELETE /trips/{id}/destinations/{destinationId}` — remove from itinerary. [F3-US7]

## Backlog endpoints (Wave 5)
- `PATCH /trips/{id}/destinations/{destinationId}` — move day / reorder (position, itineraryDayId). [F3-US5/US6]
- Autocomplete, filter, sort params on search/attractions. [F1-US1/US4/US5]

## Conventions
JWT Bearer auth; pagination via `page` (size 20); 400 validation, 401 unauthenticated, 403 not-owner, 404 missing.
