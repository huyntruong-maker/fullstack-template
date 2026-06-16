# Database — <PROJECT_NAME>

Owner agent: database-expert.

## Engine
SQL Server / PostgreSQL via EF Core.

## Schema
<tables / entities, relationships, key indexes>

## Migrations
Workflow: `dotnet ef migrations add <Name>` → review → `dotnet ef database update`.

## Query notes
Hot paths, indexing decisions, N+1 risks.
