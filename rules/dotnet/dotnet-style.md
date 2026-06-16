# .NET / C# Style

C# conventions for the ASP.NET Core backend (.NET 8+).

- Enable `<Nullable>enable</Nullable>` and `<TreatWarningsAsErrors>` where feasible.
  Avoid `!` null-forgiving except at proven-safe boundaries.
- Use file-scoped namespaces and `var` when the type is obvious.
- Prefer records for DTOs and value objects; mark types `sealed` by default.
- Naming: PascalCase for types/methods/properties, camelCase for locals/params,
  `_camelCase` for private fields, `I`-prefix for interfaces.
- Async all the way: suffix async methods `Async`, accept and pass `CancellationToken`,
  never `.Result`, `.Wait()`, or `.GetAwaiter().GetResult()`.
- One public type per file; keep `Program.cs` thin via DI extension methods.
- EF Core: register `DbContext` as Scoped, use `AsNoTracking()` for reads, project to DTOs,
  manage schema with migrations (never `EnsureCreated` in prod), avoid N+1 with `Include`/`Select`.
- Validate input with FluentValidation at the boundary; return RFC 7807 ProblemDetails for errors.
- Bind config via the Options pattern with `ValidateOnStart`.
- Use `ILogger<T>` structured logging; never log secrets or PII.
- Dispose / `await using` `IDisposable`/`IAsyncDisposable` resources.
- Run `dotnet format` before committing.

Prefer explicit, async, null-safe code.
