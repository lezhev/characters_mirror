# Feature reference contracts

These additions support reference authoring; they do not backfill PHB data.

## Fixed grants

`ClassFeatureData` and `SubclassFeatureData` expose `grantedSkills`,
`grantedExpertiseSkills`, `grantedLanguages`, `grantedArmorTraining`,
`grantedWeaponTraining`, `grantedToolKeys`, `grantedExpertiseToolKeys`, and
`grantedSpellKeys`. They apply whenever the owning feature is unlocked by its
class/subclass relation and class level. No choice group is necessary.

Tool/spell strings are canonical reference keys. Collections are unioned with
existing race, background, class and selected option grants. Skill proficiency
is collected before expertise; expertise upgrades an existing proficiency.
Tool expertise likewise requires effective tool proficiency. Manual overrides
retain their existing precedence. Losing a feature removes its automatic grants
without turning them into persisted manual proficiencies or spell selections.

## Choice-dependent grants and effects

Keep ordinary choice grants on `ChoiceOptionData`. Numeric feature modifiers
continue to use `FeatureModifierConditionData.selectedChoiceOption`, identified
by choice group reference key and option key.

`ClassSpellGrantData`, `FeatureResourceDefinitionData`, and
`FeatureResourceEffectData` can additionally reference `choiceOption`.
When absent, the declaration is unconditional. When present, the referenced
option must be among the character's resolved, currently available selections.
This condition is ANDed with the owning feature/source and level conditions.
Changing or losing the choice removes the corresponding automatic result.

`ClassSpellGrantData.alwaysPrepared == true` grants an always-prepared spell.
`false` and `null` grant an ordinary spell, with no always-prepared status.
Ordinary grants do not consume a known/prepared selection quota. They describe
automatic access only; casting permissions and uses require their own rules.

## Subclass spellcasting

`SubclassData` can supply `spellcastingProgression`, `spellSelectionMode`, and
`spellcastingAbilityValue`. An absent field inherits the class value. For a
subclass which introduces spellcasting, author all three fields explicitly.
They activate at `spellcastingStartLevel` (default: `levelRequired`, then 1),
and never before `levelRequired`. The subclass must belong to the class.

Use the existing `ClassLevelData` table for spell progression snapshots.
Base rows keep `subclassDataId == null`. Subclass rows identify both their owning
class and subclass. At matching levels, active subclass rows replace base spell
progression rows, including cantrips, spells, replacements and prepared rules.
These are complete spell progression snapshots, not sparse field overlays.
Existing class-only rows continue to work. Provide each supported level's row;
the sheet's preparation lookup uses the exact current level.

Class steps, spell deltas (including the optional `selectedSubclassId` argument),
level-up, server/offline slots, preparation pools and spellcasting ability use
the effective source. Third-caster rounding remains the existing single-class
ceiling / multiclass floor behavior. Below activation, the class source applies.

## Resource spend/restore contract

`FeatureResourceDefinitionData` defines the pool, capacity, rest reset and
optional choice condition. A pool's runtime identity is its owning feature
relation plus its stable resource `key`; display names are not identifiers.

`FeatureResourceEffectData.type` declares `modify`, `spend`, or `restore`:

- `modify` affects the derived definition and is already evaluated by the
  server/offline resolvers. Choice conditions apply before modification.
- `spend` / `restore` declare explicit operations for a future runtime. They
  must not run during derived resolution, hot reload or character loading.
  Both have a positive amount resolved by `amountRule`, `amountValue` and
  `amountAbility` in the owning source's level context. A runtime must reject
  missing/unsupported rules; `special` requires its dedicated implementation.
- `targetType` distinguishes feature pools, standard spell slots and pact slots.
  Feature pools use `targetResourceKey` and optional source selectors.
  Reference authors should use stable resource keys and actual source relations,
  never literal catalog row IDs as semantic identities. Ambiguous or missing
  targets must fail closed; slot targeting needs an explicit runtime slot choice.
- `activationTrigger` describes when invocation is eligible; it does not invoke
  anything. `usageResetOn` describes an invocation allowance reset, distinct
  from the target pool's `resetOn`. Neither alone implements a usage counter.

The existing `adjustResource` semantic action is the mutation contract for a
resolved finite feature pool: negative delta spends, positive delta restores.
It validates the active target and rejects values outside `[0, max]`; it does
not silently clamp an insufficient spend. Unlimited pools have no finite state
to decrement. Rest restoration follows the existing `applyRest` contract.
A future compound action must validate all costs/targets before committing
atomically, and reuse the existing sync/idempotency mechanism. No new action
dispatcher or combat engine is introduced here.

## Verification commands used for this change

From `characters_mirror_server`:

```powershell
serverpod generate
serverpod create-migration --tag feature-grant-contracts
dart analyze
dart test test/spell_progression_test.dart test/choice_eligibility_context_test.dart test/choice_eligibility_test.dart test/feature_display_properties_test.dart
```

From `characters_mirror_client`: `dart analyze`.

From `characters_mirror_flutter`:

```powershell
flutter analyze --no-pub
flutter test --no-pub test/feature_reference_contract_test.dart test/class_feature_derived_effects_test.dart test/feature_modifier_parity_test.dart test/spell_selection_stage1_test.dart test/level_up_controller_test.dart test/level_up_choices_test.dart test/expertise_choice_eligibility_test.dart test/character_creation_choice_builder_test.dart test/offline_cache_database_test.dart test/level_down_page_test.dart
```

From the repository root:

```powershell
.\scripts\test-integration.ps1
git diff --check
```

The full integration suite additionally requires a configured S3 test bucket.
This verification used an ephemeral MinIO container bound to `127.0.0.1:19000`,
with a cached image and an isolated bucket. A temporary runner invoked the
repository's integration script and removed that container afterwards.
The generated migration was applied by the test server to the test database.
The development database and its reference rows were left unchanged.
