# Character level-up

The character sheet opens a Level / XP bottom sheet, then a single hub. HP and
ASI stay inline. Subclasses, feats, spells and complex choices use child pickers
that return to the hub. There is no wizard or separate confirmation page.

The class card stays directly below the app bar and uses the class catalog's
SVG asset name. The multiclass placeholder is inside that card. HP methods and
the calculation stay together in an outlined card without an HP icon. Missing
decision messages are hidden in the footer; validation still disables applying
an incomplete draft.

All spell lists share `SpellCard` with the character sheet's Spells tab. In its
optional selection mode, the leading checkbox and the card toggle selection;
the trailing information button opens the existing full spell details dialog.
This includes cantrips, known/spellbook spells, both replacement pickers, and
selected draft spells in the hub. The details remain available when a selection
limit disables adding another spell.

Virtual HP rolls run from the result panel; a result exposes the existing dice
SVG as a reroll action. There is no separate roll button below the HP methods.
Manual mode places the shared compact number input from character creation
beside the result on its right. The input is square and rounded, with a single
outline and no additional inner border, including focused and error states.
All HP result panels use the same height
as this input.

`LevelUpController` owns an in-memory draft. `previewLevelUp` uses the existing
class step, spell progression, choice eligibility and derived-value builders.
`applyLevelUp` locks the owned character, checks its version, repeats validation
and saves the whole result through the existing character transaction and sync
event machinery. No new database tables or migrations are required.

Level-up requires a server connection and a synchronized character. Pending
sheet edits are flushed and synchronized before opening the hub. An old draft is
rejected if another device changes the character. Closing the hub discards it.
XP is informational: the button also supports advancement by milestones.

Draft edits project immediately from the last confirmed preview. HP reuses the
character sheet calculation; ability bonuses come from selected catalog options.
Choices, spell facts and subclass selection update without blocking further
input or navigation while the server resolves the latest preview. Older replies
cannot overwrite newer drafts. A failed preview preserves editable draft input
and shows its error. Applying requires confirmation of the latest preview and
remains atomic; only this final request locks input. There is no footer save
indicator.

## Catalog contract

- Progression comes from `ClassData`, `ClassLevelData`, class/subclass features
  and `ChoiceGroupData`; no class name or advancement level is hardcoded.
- New choice groups are the difference between the old and new class step.
  `minimumSelectionCount = 0` makes a choice optional; otherwise its minimum
  (or `selectionCount` when the minimum is absent) must be satisfied.
- A subclass is required only when this advancement crosses its catalog unlock
  level. An unassigned subclass from an earlier level is not added automatically
  or treated as a new choice.
- ASI groups have type `abilityIncrease`. Their authoritative option bonuses
  must represent the legal +2 or +1/+1 combinations. The grid maps its allocation
  to those options, including duplicate +1 options when `allowDuplicates` permits
  them. Unsupported catalog combinations keep application disabled.
- An alternative feat group has type `feat` and shares the ASI group's
  `exclusiveKey`. Feats persist as canonical generic choices and use their typed
  option grants. The separate `FeatData` catalog has no character relation or
  complete effect model in the current project; it is not silently copied into
  character notes or ability scores. If no feat group exists, its picker reports
  that no feats are available.
- New features are identified using their level and `referenceKey` (source ID is
  the fallback). Numerical upgrades of the same semantic feature are omitted.
  A resource key appearing for the first time on an existing feature is a new
  mechanic and is announced. Other changes to an existing feature's mechanics
  require distinct semantic feature data: descriptions are never diffed to guess
  mechanics. The current models have no separate mechanic-unlock event field.
- Spell gains and optional known-spell replacement allowances use
  `buildClassSpellDelta`. Only canonical IDs from the new class spell groups are
  accepted. Prepared-spell management remains in the existing spell UI.
- Choice rendering is independent of persistence. Small choices default to
  inline rendering; large/long options, feats and invocations default to pickers.
  `LevelUpChoicePresentation` supports presentation overrides.

Feature-backed choices use `ChoiceGroupData.sourceFeatureId` (or
`sourceSubclassFeatureId`) as the canonical composition link. A feature may own
multiple choice groups at different levels; the group's own `level` still controls
when that choice unlocks. `ClassFeatureData.choiceGroupKey` remains legacy metadata
and is not used for this composition because a feature can have more than one group.

The Warlock invocation groups (`warlock_eldritch_invocations_2/5/7/9/12/15/18`)
are linked to the `eldritch_invocations` feature, and `warlock_pact_boon` is
linked to the level-3 Pact Boon feature. Existing Fighting Style, Expertise,
Favored Enemy/language, and Favored Terrain groups remain feature-owned.

## Counters and hit points

The HP input is the die result, not the final gain. Existing HP calculations
apply CON and the character's HP bonuses to all levels, including retroactive
CON changes. Current HP is preserved.

All existing counters preserve their current value when the maximum grows.
Implicit full values are materialized before progression changes. New finite
feature resources and new spell-slot levels start full. Hit dice and existing
slot levels are not restored. The rest endpoint is never called.

## Verification

From `characters_mirror_flutter`:

```powershell
flutter analyze --no-pub
flutter test test/level_experience_sheet_test.dart test/level_up_choices_test.dart test/level_up_controller_test.dart test/level_up_hub_test.dart test/level_up_hp_test.dart test/level_up_page_test.dart test/level_up_picker_test.dart test/level_up_spells_test.dart test/level_up_overview_test.dart test/character_page_presentation_test.dart test/spell_page_test.dart
flutter test --no-pub
```

From the repository root:

```powershell
scripts/test-integration.ps1 -TestPath test/integration/character_level_up_test.dart
scripts/test-integration.ps1
```

From `characters_mirror_server`:

```powershell
serverpod generate
dart analyze
$unitTestPaths = @(Get-ChildItem -LiteralPath test -Filter '*_test.dart' -File | ForEach-Object { $_.FullName })
dart test @unitTestPaths
```

The new tests were written before implementation, with structural stubs only
where needed to compile. They cover transient previews, resource preservation,
retroactive CON, ownership/version rejection, multiple required choices,
subclass unlocks, spell gains and new slots, ASI budget/maxima, child navigation,
draft request ordering, and locking input while applying.

Live desktop/mobile interaction has not been verified. UI checks use Flutter
widget tests, including a narrow viewport. Test logs are saved under
`C:\Users\Matvey\.codex\.tmp\characters-mirror-level-up`.
