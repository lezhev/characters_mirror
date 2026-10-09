# Spell activation, selection filters, and progression replacement

The implementation uses canonical reference data and shared domain functions.
It adds no runtime branches for Four Elements, Shadow Arts, Mystic Arcanum,
Eldritch Knight, Arcane Trickster, or Battle Master. Existing reference names,
descriptions, short descriptions, and notes are preserved.

## Models

- `SpellActivationData`: independent `canUseStandardSlots`/`canUsePactSlots`,
  `slotless`, `atWill`, `resourceKey`/`resourceCost`, `freeCasts`/`resetOn`,
  and `castAtSpellLevel`.
- `ClassSpellGrantData` and `RaceFeatureSpellGrantData`: nullable `activation`.
  Class grants also support an explicit `castingAbility`. Existing class,
  subclass, feature, and choice-option source relations remain the grant anchors.
- `SpellSourceContextData`: activation and resolved resource owner type/ID.
  Explicit grants keep independent source identities instead of merging payment
  permissions into the ordinary class source. Legacy class grants keep their
  existing slot behavior.
- `CharacterData`/`CharacterRecord`: sparse `spellActivationUses` spent counters.
  `CharacterSemanticActionData.spellPayment` identifies slot/resource/free/atWill
  payment. Protocol 6 advertises `spell_activation_contract`; older semantic
  operations retain their original minimum protocol version.
- `SpellSelectionFilterData`: `spellListClassKey`, minimum/maximum spell level,
  schools, affected selection kinds, and cumulative `unrestrictedChoicesByLevel`.
  `ClassData`/`SubclassData` carry this policy; selection group views expose the
  filter and its unrestricted quota.
- `ChoiceGroupData`: stable `progressionKey`, `replacementsAllowed`, and optional
  `replacementProgressionKeys` (defaults to the group's own line).
- `LevelUpRequest.choiceReplacements`: group key, prior selection ID, new option
  key. `CharacterChoiceData`/record retain replacement history containing the
  class level, previous option key, and replacement authority's group key.

## Declaration examples

### Activation validation and legacy precedence

Explicit activation is validated by the shared `validateSpellActivation` domain
validator when class/race grants are written, active spell sources are collected,
and cast/payment policies are resolved. Invalid policies throw
`SpellCastFailure` with code `invalid_activation`; they never fall back to legacy
permissions. This validation runs on both server and offline cast paths.

- All four permission flags must be booleans. At least one slot pool must be
  enabled when `slotless` is false.
- `slotless` requires at-will permission, a resource payment, or a free-cast
  counter. These payment fields cannot appear when `slotless` is false.
- `resourceKey` and `resourceCost` must occur together, with a non-empty key and
  positive integer cost. `freeCasts` and `resetOn` must occur together, with a
  positive integer limit and a `RestType` value.
- At-will casting cannot also declare resource payment or a free-cast counter.
  Finite resource payment and free casts can be alternative methods, alongside
  independently enabled slot pools.
- `castAtSpellLevel`, when present, must be an integer from 0 through 9.
  Available casts still respect the spell's base level. `special` reset remains
  a declared reset requiring its existing runtime handling.

For `RaceFeatureSpellGrantData`, a non-null `activation` replaces the entire
legacy payment/level policy. `canAlsoCastWithSpellSlots`, `freeCastsFormula`,
`freeCastsPerRest`, and `castAtSpellLevel` are consulted only when activation is
absent, including when an optional activation field is null. Legacy fields remain
stored for older clients, but are omitted from explicit resolved race sources.
Creation grant labels follow the same precedence. Casting ability is independent
of this payment policy and remains effective in either mode.

Four Elements `burning_hands`, and the same pricing contract for Shadow Arts:

```json
{
  "canUseStandardSlots": false,
  "canUsePactSlots": false,
  "slotless": true,
  "atWill": false,
  "resourceKey": "ki",
  "resourceCost": 2,
  "castAtSpellLevel": 1
}
```

The resource owner is resolved from active canonical features belonging to the
grant's class entry. The client cannot supply a cheaper cost or different owner.
Cast validation and payment happen in one semantic operation, including
concentration changes, resource revisions, and rest barriers.

Mystic Arcanum uses `slotless: true`, both slot flags false, `freeCasts: 1`,
`resetOn: longRest`, and its fixed spell level. An invocation can use
`slotless: true, atWill: true`. A normal slot grant can explicitly enable either
or both slot pools; grants without activation preserve the old slot contract.

EK and AT use the Wizard list by semantic class key. EK declares
Abjuration/Evocation; AT declares Enchantment/Illusion. School restrictions apply
to `knownSpell`, leaving cantrips unrestricted by school. Both have cumulative
unrestricted quotas of 1/2/3/4 at class levels 3/8/14/20. Unrestricted choices
still obey the spell list and level bounds. Creation normalization, picker
selection, level-up, ordinary saves, and sync validation share these rules.
The server resolves spell IDs from its catalog and rejects inconsistent IDs/keys.

Battle Master groups share `fighter_battle_master_maneuvers`; Four Elements
groups share `monk_four_elements_disciplines`. Later learning snapshots permit
one optional replacement. Validation checks the old selection's ownership,
source line, replacement budget, new option requirements, and duplicates across
the line. Choices retain their logical IDs and acquisition group. Options that
exist only in a later snapshot resolve through the recorded replacement
authority; the same resolver runs offline. Level-down pops only history newer
than the target level and restores the original option. Ordinary snapshots
cannot forge history or bypass level-up replacement.

## Minimal reference backfill

- EK/AT: third-caster metadata, subclass progression rows for levels 3–20, Wizard
  spell-list filters and school quotas. AT's selectable cantrip count excludes
  the existing fixed `mage_hand` grant.
- Battle Master: learning snapshots at 7/10/15 with the existing maneuver catalog.
- Four Elements: learning snapshots at 6/11/17 with the existing discipline
  catalog; ki-only grants for the existing Burning Hands, Thunderwave and Gust
  of Wind options, using Wisdom.
- No new disciplines, maneuvers, or feature descriptions were authored. No
  canonical Shadow Arts, Mystic Arcanum, or invocation backfill was attempted;
  their activation declarations are exercised with integration fixtures.

Schema migrations were generated with Serverpod and reviewed before application:

1. `20261007220404658-spell-activation-selection-replacement`
2. `20261007221219840-spell-grant-ability-filter-format`

The second migration supplies explicit grant casting ability and corrects the
nested integer-map wire format. The first, already-applied migration remains
unchanged. Serverpod-generated bindings were regenerated from `.spy.yaml` files.

## Remaining runtime responsibilities

- Damage, healing, saves, target effects, duration tracking, and discipline
  effects that are not spell casts retain the existing runtime workflows.
- Variable ki costs, optional resource-funded upcasting, and complex legacy
  `freeCastsFormula` expressions need separate data policies; this contract uses
  fixed resource costs and numeric free-cast limits.
- Features outside the small backfill keep their existing reference metadata.
- Level-up/down commits still use the existing online server gateway. Their
  optimistic projection and choice replacement/rollback domain logic are shared;
  this change does not introduce a new offline level-up persistence protocol.
- School exceptions use a cumulative unrestricted budget. Tracking the exact
  acquisition slot of an unrestricted spell for additional spell-replacement
  rules is not added by this filter contract.

## Verification

- Final results: 72 shared tests, 35 server unit tests, 752 Flutter tests, and 66
  relevant backend integration tests passed. Two existing Flutter export tests
  were skipped without their separate fixture files; the new server/offline
  export replay test ran. All four package analyzers and `git diff --check` passed.
- `serverpod generate` after model changes; `serverpod create-migration --tag
  spell-activation-selection-replacement` and `--tag
  spell-grant-ability-filter-format`; no force flags.
- `dart run bin/main.dart --mode development --role maintenance
  --apply-migrations`: both additive migrations applied to development; integration
  startup applied them to the isolated test database.
- Shared unit tests cover fixed-resource casting, free-cast resets, independent
  slot flags, fixed-level at-will casting, school/level filters, quotas,
  replacement/rollback, legacy binding, and later-snapshot options.
- Flutter tests cover offline canonical grant/resource resolution, creation
  filters, optimistic replacement, later-snapshot option resolution, and the
  optional replacement picker. Actual server cast/rest operations are exported
  and replayed through the Flutter offline pipeline, comparing counters and
  barrier tokens.
- Backend integration tests run only via root `scripts/test-integration.ps1`
  with `-TestPath`: `spell_infrastructure_test.dart`, `character_level_up_test.dart`,
  `character_level_down_test.dart`, `character_sync_semantic_actions_test.dart`,
  `character_sync_fine_targets_test.dart`, `spell_slot_recovery_test.dart`, and
  `conditional_spell_grant_test.dart`.
- Reference snapshots were compared by existing row ID, proving all original
  names/descriptions/short descriptions/notes unchanged. Generated model readers
  successfully decoded the deployed EK/AT filters and all 12 Four Elements grants.

Automation used readable inline commands and temporary scripts under
`C:/Users/Matvey/.codex/.tmp/spell-infrastructure`. Database connections were
loopback-only. No live UI/browser session, commits, or destructive Git commands
were used.
