# Project Agent Instructions

## Backend Integration Tests

- Run backend integration tests from the repository root with `scripts/test-integration.ps1`.
- Do not run `dart test test/integration` directly from chat automation; the script starts the Serverpod test database first.
- The script starts Docker Desktop if the Docker daemon is unavailable, then runs `docker compose up -d --wait postgres_test` from `characters_mirror_server`.
