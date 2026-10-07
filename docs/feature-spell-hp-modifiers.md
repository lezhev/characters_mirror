# Feature spell context, maximum HP and damage presentation

Implemented on the existing uncommitted worktree. No commits, resets, reverts,
branch changes, dependency additions or production connections were made.

## Model and evaluation

`FeatureModifierTarget` appends `hitPointMaximum`, `spellHealing`, `spellDamage`
and `spellRange`. `FeatureModifierOperation` appends `setValue` (Dart reserves
`set`). `FeatureModifierValueKind` appends `abilityModifier` and `castLevel`.
Existing enum indexes remain stable. `FeatureModifierData` adds nullable
`spellKey` and `minimumCastLevel`. The existing `staticValue` is the offset for
`castLevel`; no expression language or extra per-feature value type was added.

Serverpod regenerated the server/client bindings. The shared protocol adapter
supports Serverpod's indexed enums and `{k,v}` map entry lists. It resolves
source metadata through separate class-feature and subclass-feature ID spaces,
checks class/subclass ownership and required level, and keeps the active source
metadata in derived snapshots. The same adapter feeds server derived totals,
offline derived totals, sheet HP recalculation and spell presentation.

The shared evaluator receives a separate optional spell context. Only spell
targets evaluate `spellKey` / `minimumCastLevel`; character targets do not depend
on spell context. A `castLevel` operand cannot affect a character target.
Presentation numeric targets support deterministic set-then-add evaluation.

## Exact data records

Disciple of Life:

```text
source referenceKey: cleric_life_disciple_of_life
modifier referenceKey: cleric_life_disciple_of_life.spell_healing
target: spellHealing
operation: add
value: {kind: castLevel, staticValue: 2}
spellKey: null
minimumCastLevel: 1
```

`SpellPresentationResolver` applies the bonus after selecting base/upcast healing
formula. Effective cast level is the selected preview level, falling back to the
spell's base level. A third-level Cure Wounds preview therefore displays
`3к8 + 5 + модификатор`, or `3к8 + 5 + 4` with WIS +4. Healing Word follows the same
path. Cantrips, non-healing spells and characters without the active feature do
not gain the bonus. Presentation never selects targets or mutates HP.

Draconic Resilience:

```text
source referenceKey: sorcerer_draconic_bloodline_draconic_resilience
modifier referenceKey: sorcerer_draconic_resilience.hit_point_maximum
target: hitPointMaximum
operation: add
value: {kind: classLevelProgression, progression: {1: 1, 2: 2, ..., 20: 20}}
```

The source subclass resolves its owning class entry, so Sorcerer 3 / Fighter 2
adds +3, and Sorcerer 2 / Fighter 2 adds +2. The existing AC row
`sorcerer_draconic_resilience.armor_class` remains separate and unchanged.
Maximum HP is normal/base maximum (including manual `hpFlatBonus` and
`hpPerLevelBonus`) plus active HP modifiers. No persistent bonus is accumulated.

The existing server `_preserveLevelChangeResources` clamps current HP during
level-down. Offline resolution uses the same upper-bound rule. HP below the new
maximum stays unchanged; there is no damage/healing event. Sheet HP settings and
rest calculations also evaluate the active modifier from the current class
entries. Removing the source subclass/feature removes the derived bonus.

Wrath of the Storm:

```text
source referenceKey: cleric_tempest_wrath_of_the_storm
key: damage
label: Урон
valueKind: formula
formula: 2d8
sortOrder: 0
```

The existing formatter renders `2к8`. The reference full description changes
only `2к8 урона` to `урон`; the new short description uses the original trigger,
visibility, reaction, lightning/thunder choice and Dexterity-save wording,
including half damage on success. Resource definition/effect rows are unchanged.

## Migration and local database

Migration: `20261007141026044-feature-spell-hp-presentation`.
It adds two nullable columns, inserts two modifier rows and one display-property
row, and updates only Wrath's description/shortDescription/version/timestamp.
The SQL fails before data updates unless every expected canonical referenceKey
exists exactly once across class/subclass sources and identifies a subclass
feature. Conflicting modifier ownership and duplicate Wrath damage properties
also fail. Missing-source and duplicate-source guard rehearsals passed in
rollback-only transactions in the isolated test database.

Commands:

```text
serverpod generate
serverpod create-migration --tag feature-spell-hp-presentation
dart run bin/main.dart --mode development --role maintenance --apply-migrations
```

The migration was applied with exit 0 to `127.0.0.1:5432 / characters_mirror`.
The exact before/after audit confirmed two new modifiers, one new property and
one changed feature row. All other audited class/subclass, modifier, display,
resource-definition and resource-effect rows stayed unchanged, including AC.

Audit artifacts and the fresh verified custom-format backup are under
`C:\Users\Matvey\.codex\.tmp\feature-modifiers`:

```text
dev-before.json
dev-after.json
dev-changes.json
dev-apply.log
characters_mirror-before-feature-modifiers.dump
```

Backup: 2,768,685 bytes, `pg_dump -Fc` and `pg_restore --list` both succeeded.
SHA-256: `eff3cbb8af6f18eda8b33b22116363d209c58df6c697ea68735d9afe3edef785`.

The existing isolated test database
`127.0.0.1:9090 / characters_mirror_spell_structured_20261007` was used through
process-local database overrides. Only the three canonical feature fixtures,
their class/subclass parents, the existing Draconic AC row and Wrath resource
were added before its normal Serverpod migration application. Repository
password/config files were not modified.

## Future cases and deliberate gaps

Fixture tests demonstrate Agonizing Blast as `spellDamage / add /
abilityModifier(charisma) / spellKey=eldritch_blast`, and Eldritch Spear as
`spellRange / setValue / staticValue=300 / spellKey=eldritch_blast`. Neither
invocation is backfilled, and damage/range UI consumers are outside this change.

Wrath trigger, target, damage-type choice and save execution stay text-only.
Target selection, damage/healing application, enemy states, conditional saves,
mass spell backfill and other combat-runtime work remain outside scope.

## Verification

Shared full suite: `dart test` — 46 passed.

Server full unit suite, excluding integration:

```powershell
$unitFiles = Get-ChildItem -LiteralPath test -File -Filter '*_test.dart' |
    ForEach-Object { 'test/' + $_.Name }
dart test @unitFiles
```

Result: 35 passed.

New backend integration:

```powershell
scripts/test-integration.ps1 -TestPath test/integration/feature_spell_hp_test.dart
```

Result: 3 passed, including a final rerun with manual bonuses present during
another level-down. These tests verify the real migrated reference rows, Life
presentation without HP mutation, source-class HP, ordinary and multiclass
level-down, clamp/no-clamp, AC, independent manual bonuses and Wrath resource /
display presentation. They can export synthetic character/step snapshots via
`FEATURE_MODIFIER_SERVER_SNAPSHOTS` for direct offline comparison.

Relevant Flutter regression, with that environment variable pointing to the
exported snapshots:

```text
flutter test --no-pub test/feature_spell_hp_parity_test.dart test/feature_modifier_parity_test.dart test/offline_character_resolver_test.dart test/feature_presentation_contract_test.dart test/feature_presentation_regression_test.dart test/feature_display_property_resolver_test.dart test/feature_display_properties_layout_test.dart test/character_feature_card_test.dart test/spell_presentation_widgets_test.dart test/spell_structured_pilot_widgets_test.dart test/spell_page_test.dart test/resolved_spell_pipeline_test.dart test/level_down_page_test.dart test/hit_points_calculator_test.dart test/character_sheet_navigation_test.dart test/character_sheet_canonical_id_test.dart test/armor_class_derivation_test.dart test/armor_class_settings_sheet_test.dart test/fight_page_formatters_test.dart
```

Result: 216 passed, including real server/offline snapshot parity for maximum HP,
current HP, AC, spell formulas, resources and display properties.

Additional offline sync/HP regression:

```text
flutter test --no-pub test/feature_spell_hp_parity_test.dart test/offline_character_sync_operations_test.dart test/offline_sync_coordinator_test.dart test/hit_points_calculator_test.dart test/resolved_spell_pipeline_test.dart
```

Result: 83 passed, including the final server snapshots, manual bonuses across
level-down and the minimum-base-HP case with a negative manual flat bonus.

Analyzer commands:

```text
# In each shared, client and server package:
dart analyze
# In the Flutter package:
flutter analyze --no-pub
```

All four packages: exit 0, no issues. Targeted `dart format` covered the new
handwritten files and small changed files; large existing files received only
localized edits. `git -c core.safecrlf=false diff --check` passed. New task files
also passed UTF-8 decoding and trailing-whitespace checks.

Full backend integration:

```powershell
scripts/test-integration.ps1
```

Result: **198 passed, 2 failed**, exit 1. The only failures are the known missing
`S3_ENDPOINT` in `character_portrait_endpoint_test.dart` and
`object_storage_test.dart`. These were left untouched. Modifier/derived,
level-down/up, character sync, feature presentation, resolved spell cast and
spell protocol integration tests passed. Full runtime: approximately 4m 51s.

Actual local runner invocations, which set process-local test database overrides
before invoking the repository script:

```text
python C:\Users\Matvey\.codex\.tmp\feature-modifiers\database-audit.py test test/integration/feature_spell_hp_test.dart
python C:\Users\Matvey\.codex\.tmp\feature-modifiers\database-audit.py test
python C:\Users\Matvey\.codex\.tmp\feature-modifiers\database-audit.py guards
```

The first full integration attempt
could not start: another ongoing task had registered
`20261007170600000-subclass-level1-safe-presentation` before its SQL file existed.
The user requested waiting for that task; its source/migration files were left
untouched. After completion, one Dark One's Blessing reference fixture and its
parents were added only to the isolated test database so that migration's
fail-fast guard could run. Its normal migration application then succeeded.

The development audit for this task was captured immediately after applying
`20261007141026044-feature-spell-hp-presentation`. A final read-only state check
shows both dev and the isolated test database now at
`20261007170600000-subclass-level1-safe-presentation`; the later dev application
was performed by the parallel task.

Initial focused runs exposed the indexed-enum / enum-key-map protocol boundary
and a fixture's class-entry ordering; both were corrected and rerun successfully.
No unresolved task-related test failures remain. Full integration was not
repeated after adding the final focused manual-HP assertions; those assertions
were verified by the targeted backend and offline parity reruns.

Automation used readable inline shell commands and temporary Python scripts;
database connections were local-only. No live UI/browser debug session or
Marionette hot reload/restart was needed for these widget/contract checks.

## Files and diff

This task owns **38 files: 25 changed from the incoming baseline, 13 new**.
The complete list is in
`C:\Users\Matvey\.codex\.tmp\feature-modifiers\task-owned-files.json`.
Main groups:

- Four model/enum source definitions and nine regenerated server/client files.
- Shared evaluator, protocol/source adapter, presentation context and resolver.
- Server derived totals / admin import and Flutter offline / spell / HP adapters.
- Five migration files plus the registry entry.
- Shared, server and offline parity tests, their common fixture and this report.

Full `git diff --stat` (tracked files only, including the incoming dirty worktree
and the completed parallel changes):

```text
85 files changed, 2934 insertions(+), 2340 deletions(-)
```

Full per-file stat:
`C:\Users\Matvey\.codex\.tmp\feature-modifiers\git-diff-stat.txt`.
Untracked new files are not included in Git's tracked diff stat.
