# Project Agent Instructions

## Backend Integration Tests

- Run backend integration tests from the repository root with `scripts/test-integration.ps1`.
- Do not run `dart test test/integration` directly from chat automation; the script starts the Serverpod test database first.
- The script starts Docker Desktop if the Docker daemon is unavailable, then runs `docker compose up -d --wait postgres_test` from `characters_mirror_server`.

## User-Entered Character Fields

- Treat any character data typed, pasted, selected, or otherwise controlled by the user as untrusted on the server.
- Validate user-entered character fields with centralized server-side `Rules` categories and domain validators instead of adding separate per-field constants for every model field.
- Client-side debounce and validation are UX optimizations only; server-side limits, ownership checks, and rate limits remain authoritative.
- Prefer saving reference data in character write flows as IDs or relation rows, not as full client-provided spell, weapon, armor, magic item, class, race, or background payloads.
