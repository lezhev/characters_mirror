# Unarmored Defense and derived Armor Class

The reference keys repaired by the migration are `barbarian_unarmored_defense` and
`monk_unarmored_defense`. Both features are available at level 1. Their display
names and descriptions are preserved; display properties do not implement AC.

The previous reference migration assigned `unarmoredDefenseRule` using imported
IDs 1 and 46. The server and main offline resolver could calculate these legacy
rules, but the local resolver without an offline cache recalculated only equipment
AC and overwrote the feature result. `FeatureModifierData` originally supported
only additive effects, so these alternative formulas were outside its pipeline.

The reference-data migration `20261006200000000-unarmored-defense-formulas`
upserts formula modifiers by feature key and parent class key, without changing
the database schema. Its canonical modifier keys are
`barbarian_unarmored_defense.armor_class` and
`monk_unarmored_defense.armor_class`:

| Feature | Operation | Constant | Ability terms | Conditions |
| --- | --- | --- | --- | --- |
| Barbarian | `baseArmorClass` | 10 | Dexterity, Constitution | `unarmored` |
| Monk | `baseArmorClass` | 10 | Dexterity, Wisdom | `unarmored`, `noShield` |

`FeatureModifierValueData.abilityModifiers` is optional. Existing `add`
modifiers retain their semantics. Reference imports accept ability names in
`value.abilityModifiers`; formula operations require the `armorClass` target.
Older `unarmoredDefenseRule` catalogs are adapted to equivalent candidate
modifiers. An explicit formula row on that feature supersedes the legacy rule.

The pipeline is:

1. Resolve reference features from the character's class/subclass levels.
2. Collect modifiers attached to those active features and retain their source
   metadata in `derived.featureModifiers` for recalculation without a cache.
3. Resolve catalog statistics only for `equippedArmor` and `equippedShield`.
   Inventory contents do not equip an item. Custom equipment has no inferred
   catalog statistics, but an equipped selection blocks the relevant conditions.
4. The shared pure `resolveArmorClass` evaluates modifier conditions, selects
   the greatest applicable base candidate, then adds the shield's catalog bonus,
   `customArmorClassBonus`, and applicable additive feature effects once.
5. Server derived, offline derived, and local recalculation use that same helper.
   The character sheet consumes `derived.armorClass`, source, and formula.

The ordinary candidate preserves existing equipment semantics: equipped armor
uses its catalog base, Dexterity rule, and cap; otherwise the base is 10 + DEX.
Equipped armor disables both Unarmored Defense formulas. A shield disables only
the monk formula. Multiple formulas compete rather than stack. A future Natural
Armor formula can use the same operation with its own constant, ability terms,
and conditions, and compete with equipment without calculator changes.
Proficiency and armor training do not contribute to these AC formulas.

The manual setting is an additive `customArmorClassBonus`, not a replacement AC.
It is preserved with or without armor and with feature formulas/effects.

Regression cases are shared between server and offline tests in
`test_fixtures/armor_class_contract.dart`. Backend tests can export fixture
snapshots to the path in `ARMOR_CLASS_SERVER_SNAPSHOTS`; the Flutter test consumes
the same file and compares AC, source, and formula against actual server output.
Use `scripts/test-integration.ps1` for backend integration tests.

The development database was unavailable during this repair. The reference
migration was applied and checked on the test database, including stable-key
lookup, repeated execution, and preservation of Russian feature copy. Applying
the migration to development/production and refreshing existing reference caches
remain deployment steps. Server and regenerated client should be released
together because the modifier operation enum gained a value.

Offline recalculation also retains AC modifiers from the character's derived
snapshot when the exact class/level/subclass step is missing from the cache or
predates modifier metadata. Source class/subclass and feature level are checked,
and formulas are reevaluated against current ability scores and equipment.
A cached step with an explicit modifier list takes precedence, including an
empty list. This keeps both the AC total and its source/formula available in the
AC settings sheet while reference data is incomplete.

## Files changed

- Shared: `lib/src/armor_class_resolver.dart`,
  `lib/src/feature_modifier_evaluator.dart`, `lib/characters_mirror_shared.dart`,
  `test/armor_class_resolver_test.dart`.
- Server: `lib/src/armor_class_feature_modifiers.dart`,
  `lib/src/endpoints/admin_endpoint.dart`,
  `lib/src/endpoints/models/general/character_data_endpoint.dart`, and its parts
  `aggregate_derived_stats.dart` and `derived_armor_class.dart`;
  `lib/src/models/enums/feature_modifier_operation.spy.yaml`,
  `lib/src/models/data/general/feature_modifier_value_data.spy.yaml`;
  `test/integration/unarmored_defense_test.dart`.
- Flutter: `lib/core/character/armor_class_feature_modifiers.dart`,
  `lib/core/character/armor_class_calculator.dart`,
  `lib/core/offline/offline_character_resolver.dart`, and its parts
  `armor_class_helpers.dart` and `feature_modifier_helpers.dart`;
  `test/unarmored_defense_test.dart`.
- Server/client generated bindings: `feature_modifier_value_data.dart`,
  `enums/feature_modifier_operation.dart`, and `protocol.dart`, regenerated with
  Serverpod rather than edited manually.
- Migration: `migrations/20261006200000000-unarmored-defense-formulas/`
  (SQL, empty schema action list, and unchanged schema snapshots), plus
  `migrations/migration_registry.txt`.
- Shared fixtures/documentation: `test_fixtures/armor_class_contract.dart` and
  this document.

## Verification performed

Commands run from the indicated package, or repository root for the script:

| Location | Command | Result |
| --- | --- | --- |
| Server | `serverpod generate` | Generated successfully after model and endpoint edits |
| Server | `serverpod create-migration --tag unarmored-defense-formulas` | No schema changes detected; created a data-only migration in the existing style, without `--force` |
| Root | `scripts/test-integration.ps1 -TestPath test/integration/unarmored_defense_test.dart` | 3 tests passed; PHB snapshots, reference import validation, and migration repeatability/copy preservation |
| Root | `scripts/test-integration.ps1 -TestPath test/integration/character_data_endpoint_test.dart` | 74 existing tests passed |
| Root | `scripts/test-integration.ps1 -TestPath test/integration/character_equipment_selection_test.dart` | 10 existing tests passed |
| Flutter | `flutter test test/unarmored_defense_test.dart test/armor_class_calculator_test.dart test/armor_class_derivation_test.dart test/class_feature_derived_effects_test.dart test/feature_modifier_parity_test.dart test/armor_class_equipment_settings_test.dart test/armor_class_settings_sheet_test.dart` | 39 tests passed, including actual server/offline/local snapshot parity |
| Shared | `dart pub get --offline` | Existing dev dependencies resolved from cache; no dependency changes |
| Shared | `dart test` | 10 tests passed |
| Server | `dart test test/admin_endpoint_contract_test.dart` | 2 existing tests passed |
| Server, Shared | `dart analyze` | No issues |
| Flutter | `flutter analyze` | No issues |

For the actual-snapshot parity run, set `ARMOR_CLASS_SERVER_SNAPSHOTS` to the same
initially absent JSONL path for the backend and Flutter processes. The verified
export contains 19 server snapshots at
`C:\Users\Matvey\.codex\.tmp\unarmored-defense\server-snapshots.jsonl`.

Only changed Dart source/test files were formatted. `git diff --check` passed.
Pre-existing uncommitted work was preserved. Automation used readable PowerShell
commands and temporary Python scripts under
`C:\Users\Matvey\.codex\.tmp\unarmored-defense`; backend checks used the local
Docker test database. No live UI session or browser debug tools were used.
