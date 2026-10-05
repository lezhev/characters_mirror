# Spell progression, Stage 1

`ClassData.spellSelectionMode` is authoritative when present. `knownCantrips`
and `knownSpells` are totals, with the latter used only in known mode.
`spellbookSpells` counts free class progression gains, excluding copied spells.
`knownSpellReplacements` is the allowance at the target level.

Preparation uses `PreparedSpellRuleData` (ability modifier, scaled class level,
rounding, flat bonus, minimum). The calculation and limited legacy formula
adapter live in `characters_mirror_shared`. Paladin uses floor(level / 2).

`ClassDataEndpoint.getSpellDelta(classId, fromLevel, toLevel, abilityScores)`
loads exact progression rows and returns positive differences in totals,
target-level replacements, and preparation limits. It never reads character
spellbook contents. Missing preparation ability scores produce nullable limits.

Spellbook selections use the existing character selection records and sync IDs.
Logical membership is `(classEntry.id, otherwise classDataId) + kind + spellKey`.
Creation view groups declare `optionSourceSelectionKind`; the client filters and
reconciles prepared drafts against the normalized book draft. Runtime book
preparation uses only that entry's `spellbookSpell` selections. The existing UI
can visually merge spells; `preparedSpellKeys` remains a legacy aggregate UI
override. This stage does not add independent per-class preparation controls.

## Compatibility

New catalog fields are nullable. Existing JSON, offline character snapshots, and
reference cache rows remain readable, so the SQLite cache version stays at v9.
Absent mode falls back to recognized preparation metadata or existing known
spell/cantrip totals. Class display names are never used for this decision.
For legacy Wizard progression formulas, missing spellbook totals use 6 at level
1 and +2 per subsequent level, independently of `knownSpells` or actual book
size. Explicit modes use explicit spellbook totals. Generic legacy `knownSpell`
records are retained and are never silently treated as book records.

## Migration and validation

`20261005153915764-spell-stage1` only adds nullable catalog columns. No data
backfill or database migration was applied. Existing weapon-training source
types differ from the previous migration's Dart-type metadata; ordinary CLI
generation proposes dropping those unrelated columns. This migration was
generated with `serverpod create-migration --tag spell-stage1` in a temporary
model workspace retaining their previous schema, then reviewed and copied in.
Those pre-existing metadata differences still need separate resolution before
future migration generation. No `--force` was used.

Database integration tests were intentionally not run: the repository harness
defaults to applying migrations. Run `scripts/test-integration.ps1` only after
database migration application is authorized in a disposable test environment.
Level-up UI, catalog backfill, and conversion of legacy character books remain
outside Stage 1.

## Checks performed

From `characters_mirror_server`:

```powershell
serverpod generate
dart analyze
dart test test/admin_endpoint_contract_test.dart test/development_log_profile_test.dart test/feature_display_properties_test.dart test/proficiency_override_validation_test.dart test/spell_progression_test.dart test/spell_selection_identity_test.dart
```

Generation succeeded, analysis reported no issues, and all 23 tests passed.
The initial new progression tests failed before the implementation existed.

From `characters_mirror_flutter`:

```powershell
flutter analyze
flutter test test/spell_selection_stage1_test.dart test/spells_step_test.dart test/spell_page_test.dart test/offline_cache_database_test.dart test/offline_character_sync_operations_test.dart test/offline_sync_coordinator_test.dart test/multi_client_sync_harness_test.dart test/spell_slot_local_state_test.dart
flutter test
flutter test test/class_features_test.dart --plain-name 'renders resolved display properties below feature description'
```

Analysis reported no issues. The final focused run passed all 90 tests. The
broader run passed 508 tests and failed one unrelated feature-display test:
`class_features_test.dart:310` expected a text widget `Параметр` that was absent.
The failure also reproduced in isolation. Its handwritten sources and test were
not modified by Stage 1. The full run preceded the final extra focused tests.

`dart analyze` also passed in `characters_mirror_client` and
`characters_mirror_shared`. `git diff --check` passed at the repository root.
Handwritten changes were formatted with `dart format` (20 files initially,
followed by formatting of subsequent edits); generated files were formatted by
Serverpod code generation.

Automation used readable inline PowerShell commands and named temporary Python
scripts under `C:/Users/Matvey/.codex/.tmp/`. No browser debug tools or live UI
sessions were used. Cache tests used an isolated in-memory SQLite database;
the local/dev Serverpod database was not accessed or modified.
