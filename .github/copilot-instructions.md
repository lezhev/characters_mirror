# Copilot Instructions: Characters Mirror

## Project Overview

This is a full-stack **D&D character creation** application built with the **Serverpod** framework, consisting of three packages:
- `characters_mirror_server`: Serverpod backend (Dart)
- `characters_mirror_client`: Auto-generated client library
- `characters_mirror_flutter`: Flutter frontend with Riverpod state management

## Architecture & Core Patterns

### Serverpod Code Generation
- **NEVER manually edit** files in `lib/src/generated/` or `characters_mirror_client/lib/src/` - they're auto-generated
- Define data models as YAML in `characters_mirror_server/lib/src/models/data/` with `.spy.yaml` extension
- Run `serverpod generate` from the server directory after modifying models to regenerate code
- Server endpoints go in `characters_mirror_server/lib/src/endpoints/` and are auto-registered

### Database Migrations
- After model changes, create migrations with `serverpod create-migration` in the server directory
- Migrations are tracked in `migrations/migration_registry.txt`
- Test migrations locally with Docker Compose before deploying

### Client-Server Communication
- Access the Serverpod client via the global `client` variable from `src/serverpod_client.dart`
- Endpoints are accessed via `client.<endpointName>.<methodName>()`
- Example: `client.classData.getAll()`, `client.raceData.upsert(entity)`
- Authentication state is managed by the global `sessionManager`

### State Management (Flutter)
- Uses **Riverpod** with code generation (`riverpod_generator`, `riverpod_annotation`)
- Annotate providers with `@riverpod` or `@Riverpod(keepAlive: true)`
- Always include `part '<filename>.g.dart';` for generated providers
- Run `dart run build_runner watch` during development to auto-regenerate provider code
- Character creation flow state is managed by `CharacterCreationNotifier` in `app/pages/creation_flow/state/`

### Repository Pattern
- Data access is abstracted via repository classes in `characters_mirror_flutter/lib/data/repositories/`
- Each repository implements CRUD operations: `getAll()`, `getById()`, `upsert()`, `delete()`
- Repositories use the global `client` instance to call server endpoints

## Development Workflow

### Server Development
```bash
cd characters_mirror_server
# Start infrastructure
docker compose up --build --detach
# Run server
dart bin/main.dart
# Generate after model/endpoint changes
serverpod generate
# Create migration after model changes
serverpod create-migration
# Stop infrastructure
docker compose stop
```

### Flutter Development
```bash
cd characters_mirror_flutter
# Ensure server is running first
flutter run
# Auto-regenerate Riverpod code
dart run build_runner watch
```

### Code Generation
- **Server models/endpoints changed**: Run `serverpod generate` in server directory (regenerates client + server)
- **Riverpod providers changed**: Run `dart run build_runner build` in Flutter directory
- **Freezed models changed**: Run `dart run build_runner build` in Flutter directory

## Routing & Navigation
- Uses `go_router` with declarative routing in `app/router/router_provider.dart`
- Character creation is a multi-step flow: `/create` → `/create/race` → `/create/classStep` → ... → `/create/summary`
- Navigation is controlled by `CharacterCreationNotifier.next()` and `previous()`
- Auth redirect: unauthenticated users are redirected to `/sign-in`

## Key Conventions

### Naming
- Data models: `<Entity>Data` (e.g., `RaceData`, `ClassData`)
- Endpoints: `<Entity>DataEndpoint` or `<Entity>Endpoint`
- Repositories: `<Entity>Repository`
- State notifiers: `<Feature>State` with generated provider `<feature>Provider`

### Model Structure
- All models have nullable `id`, `name`, `description`, `source`, `version`, `createdAt`, `updatedAt`
- Use `Map<String, int>` for key-value data (e.g., `abilityBonuses`)
- Use `List<String>` for collections (e.g., `traits`, `proficiencies`)

### Authentication
- Admin-only endpoints require `@override bool get requireLogin => true;` and `@override Set<Scope> get requiredScopes => {Scope('admin')};`
- Use `sessionManager.signedInUser` to check authentication state in Flutter

## Deployment
- Production uses Docker (see `Dockerfile` in server directory)
- Terraform configs for AWS/GCP are in `characters_mirror_server/deploy/`
- Environment variables: `runmode`, `serverid`, `logging`, `role`

## Common Pitfalls
- Forgetting to run `serverpod generate` after model changes causes compilation errors
- Client IP address for emulator testing is `10.0.2.2` (see `serverpod_client.dart`)
- Always run `docker compose up` before starting the server locally
- Don't commit generated `.g.dart` or `.freezed.dart` files unless explicitly required by the project
