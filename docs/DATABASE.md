# Database — Travel Trip Planner

Owner agent: database-expert. EF Core; SQL Server or PostgreSQL.

## Entities (MVP)
- **Users**(Id PK, Email unique, PasswordHash, EmailVerified bool, CreatedAt)
- **EmailVerificationTokens**(Id PK, UserId FK→Users, Token, ExpiresAt, ConsumedAt nullable)
- **RefreshTokens**(Id PK, UserId FK→Users, TokenHash, ExpiresAt, RevokedAt nullable)
- **Trips**(Id PK, UserId FK→Users, Name, StartDate nullable, EndDate nullable, CreatedAt, UpdatedAt)
- **ItineraryDays**(Id PK, TripId FK→Trips, Date, DayIndex)
- **TripDestinations**(Id PK, TripId FK→Trips, ItineraryDayId FK→ItineraryDays nullable,
  ProviderPlaceId, Name, Category nullable, ThumbnailUrl nullable, Lat, Lng, Position int, CreatedAt)
  - ItineraryDayId NULL = in "Saved Places" (not yet scheduled to a day).
- **DestinationCache**(ProviderPlaceId PK, PayloadJson, FetchedAt) — optional, for NFR-2/NFR-5.

## Relationships
User 1—* Trip; Trip 1—* ItineraryDay; Trip 1—* TripDestination; ItineraryDay 1—* TripDestination (optional).

## Key constraints & indexes
- Unique(Users.Email). Unique(Trips.UserId, Name) optional.
- Index TripDestinations(TripId, ItineraryDayId, Position) for board ordering.
- Check: Trips.StartDate ≤ EndDate (enforced in app + optional DB check).
- Prevent same ProviderPlaceId twice in the same ItineraryDay (app rule; unique filtered index optional).
- NFR-6: all Trip/TripDestination access filtered by Trips.UserId.

## Migrations workflow
`dotnet ef migrations add <Name>` → review SQL → `dotnet ef database update`. One migration per slice.

## Notes
SQL Server: use `datetime2`. PostgreSQL: `timestamptz`, `jsonb` for PayloadJson. Connection resiliency (EnableRetryOnFailure).
