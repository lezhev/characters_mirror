import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/state/background_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  test('creation step providers restore draft selections from character state',
      () async {
    final raceFeature = RaceFeatureData(
      id: 101,
      raceId: 1,
      name: 'Variant Human Bonus Feat',
      level: 1,
    );
    final race = RaceData(
      id: 1,
      name: 'Variant Human',
      size: CreatureSize.medium,
      speed: 30,
      visionType: SenseType.darkvision,
      features: [raceFeature],
    );
    final raceChoiceGroup = ChoiceGroupData(
      id: 11,
      referenceKey: 'variant_human_bonus_feat',
      sourceRaceFeatureId: raceFeature.id,
      type: ChoiceType.feat,
      selectionCount: 1,
      allowDuplicates: false,
    );
    final raceChoiceOption = ChoiceOptionData(
      choiceGroupId: raceChoiceGroup.id!,
      optionKey: 'skilled_feat',
      name: 'Skilled',
    );

    final subclass = SubclassData(
      id: 21,
      parentClassId: 2,
      name: 'Champion',
      levelRequired: 1,
    );
    final subclassFeature = SubclassFeatureData(
      id: 22,
      parentSubclassId: subclass.id!,
      name: 'Bonus Training',
      level: 1,
    );
    final classData = ClassData(
      id: 2,
      name: 'Fighter',
      imageURL: 'fighter',
      subclassChoiceLevel: 1,
      availableSkills: const [
        Skill.acrobatics,
        Skill.athletics,
        Skill.perception,
      ],
      skillCount: 2,
    );
    final subclassToolGroup = ChoiceGroupData(
      referenceKey: 'warlock_tool_choice',
      id: 32,
      sourceSubclassFeatureId: subclassFeature.id,
      type: ChoiceType.tool,
      selectionCount: 1,
      exclusiveKey: 'subclass_tool_pick',
      allowDuplicates: false,
    );
    final classStepView = ClassStepView(
      classData: classData,
      selectedLevel: 1,
      subclassChoice: ClassStepSubclassChoiceView(
        requiredLevel: 1,
        subclasses: [subclass],
      ),
      currentSubclassFeatures: [subclassFeature],
      skillSelectionGroups: [
        SkillSelectionGroupView(
          kind: CharacterSkillSelectionKind.classSkill,
          selectionCount: 2,
          classDataId: classData.id,
          options: const [
            Skill.acrobatics,
            Skill.athletics,
            Skill.perception,
          ],
        ),
      ],
      choiceGroups: [
        ChoiceGroupView(
          group: subclassToolGroup,
          options: [
            ChoiceOptionData(
              choiceGroupId: 32,
              optionKey: 'smith_tools',
              name: 'Smith tools',
            ),
          ],
        ),
      ],
    );

    final background = BackgroundData(
      id: 3,
      name: 'Acolyte',
      feature: 'Shelter of the Faithful',
    );
    final backgroundGroup = ChoiceGroupData(
      referenceKey: 'acolyte_language_choice',
      id: 41,
      sourceBackgroundId: background.id,
      type: ChoiceType.language,
      selectionCount: 1,
      exclusiveKey: 'background_language_pick',
      allowDuplicates: false,
    );
    final backgroundStepView = BackgroundStepView(
      background: background,
      choiceGroups: [
        ChoiceGroupView(
          group: backgroundGroup,
          options: [
            ChoiceOptionData(
              choiceGroupId: 41,
              optionKey: 'celestial_language',
              name: 'Celestial',
            ),
          ],
        ),
      ],
    );

    final container = ProviderContainer(
      overrides: [
        raceRepositoryProvider.overrideWithValue(
          _FakeRaceRepository(
            races: [race],
            stepViews: {
              race.id!: RaceStepView(
                race: race,
                features: [raceFeature],
                choiceGroups: [
                  ChoiceGroupView(
                    group: raceChoiceGroup,
                    options: [raceChoiceOption],
                  ),
                ],
              )
            },
          ),
        ),
        classRepositoryProvider.overrideWithValue(
          _FakeClassRepository(
            classes: [classData],
            stepViews: {'${classData.id}:none': classStepView},
            subclassStepViews: {
              '${classData.id}:${subclass.id}': classStepView
            },
          ),
        ),
        backgroundRepositoryProvider.overrideWithValue(
          _FakeBackgroundRepository(
            backgrounds: [background],
            stepViews: {background.id!: backgroundStepView},
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final creation = container.read(characterCreationProvider.notifier);
    creation.syncRaceDraft(
      selectedRace: race,
      choiceGroups: [
        ChoiceGroupView(
          group: raceChoiceGroup,
          options: [raceChoiceOption],
        ),
      ],
      raceChoices: [
        CharacterChoiceData(
          groupKey: raceChoiceGroup.referenceKey,
          optionKey: raceChoiceOption.optionKey,
          selectionIndex: 0,
        ),
      ],
    );
    creation.applyPrimaryClassSelection(
      classData: classData,
      subclass: subclass,
      level: 1,
      skillSelections: [
        CharacterSkillSelectionData(
          classDataId: classData.id,
          skill: Skill.acrobatics,
          kind: CharacterSkillSelectionKind.classSkill,
          selectionIndex: 0,
        ),
        CharacterSkillSelectionData(
          classDataId: classData.id,
          skill: Skill.athletics,
          kind: CharacterSkillSelectionKind.classSkill,
          selectionIndex: 1,
        ),
      ],
      choices: [
        CharacterChoiceData(
          groupKey: subclassToolGroup.referenceKey,
          optionKey: 'smith_tools',
          selectionIndex: 0,
        ),
      ],
    );
    creation.syncBackgroundDraft(
      selectedBackground: background,
      choiceGroups: backgroundStepView.choiceGroups ?? const [],
      selectedOptions: {
        'acolyte_language_choice': [
          ChoiceOptionData(
            choiceGroupId: 41,
            optionKey: 'celestial_language',
            name: 'Celestial',
          ),
        ],
      },
    );

    final raceState = await container.read(raceStateProvider.future);
    final classState = await container.read(classStateProvider.future);
    final backgroundState =
        await container.read(backgroundStateProvider.future);

    expect(backgroundState.selectedBackground?.id, background.id);
    expect(
      backgroundState
          .selectedOptions['acolyte_language_choice']?.single.optionKey,
      'celestial_language',
    );

    final nextBackground = BackgroundData(
      id: 4,
      name: 'Soldier',
      feature: 'Military Rank',
    );
    final nextBackgroundGroup = ChoiceGroupData(
      referenceKey: 'soldier_tool_choice',
      id: 42,
      sourceBackgroundId: nextBackground.id,
      type: ChoiceType.tool,
      selectionCount: 1,
      allowDuplicates: false,
    );
    creation.syncBackgroundDraft(
      selectedBackground: nextBackground,
      choiceGroups: [
        ChoiceGroupView(
          group: nextBackgroundGroup,
          options: [
            ChoiceOptionData(
              choiceGroupId: nextBackgroundGroup.id!,
              optionKey: 'dice_set',
              name: 'Dice set',
              grantedToolKeys: const ['dice_set'],
            ),
          ],
        ),
      ],
      selectedOptions: {
        'soldier_tool_choice': [
          ChoiceOptionData(
            choiceGroupId: nextBackgroundGroup.id!,
            optionKey: 'dice_set',
            name: 'Dice set',
            grantedToolKeys: const ['dice_set'],
          ),
        ],
      },
    );

    final remainingChoiceKeys = creation.state.character.choices!
        .map((choice) => choice.groupKey)
        .toSet();
    expect(remainingChoiceKeys, contains('soldier_tool_choice'));
    expect(remainingChoiceKeys, isNot(contains('acolyte_language_choice')));

    expect(raceState.selectedRace?.id, race.id);
    expect(
      raceState.selectedChoiceOptionsByGroup[raceChoiceGroup.referenceKey]
          ?.single.optionKey,
      'skilled_feat',
    );

    expect(classState.selectedClass?.id, classData.id);
    expect(classState.selectedSubclass?.id, subclass.id);
    expect(
      classState.selectedSkillSelections.map((selection) => selection.skill),
      [Skill.acrobatics, Skill.athletics],
    );
    expect(
      classState.selectedOptions[subclassToolGroup.referenceKey]
          ?.single.optionKey,
      'smith_tools',
    );

  });
}

class _FakeRaceRepository extends RaceRepository {
  _FakeRaceRepository({
    required this.races,
    required this.stepViews,
  });

  final List<RaceData> races;
  final Map<int, RaceStepView> stepViews;

  @override
  Future<List<RaceData>> getAll() async => races;

  @override
  Future<RaceStepView> getStepView(int raceId) async => stepViews[raceId]!;
}

class _FakeClassRepository extends ClassRepository {
  _FakeClassRepository({
    required this.classes,
    required this.stepViews,
    required this.subclassStepViews,
  });

  final List<ClassData> classes;
  final Map<String, ClassStepView> stepViews;
  final Map<String, ClassStepView> subclassStepViews;

  @override
  Future<List<ClassData>> getAll() async => classes;

  @override
  Future<ClassStepView> getStepView(
    int classId, {
    int selectedLevel = 1,
    bool isStartingClass = true,
    int? selectedSubclassId,
    Map<String, int>? abilityScores,
  }) async {
    if (selectedSubclassId != null) {
      return subclassStepViews['$classId:$selectedSubclassId']!;
    }
    return stepViews['$classId:none']!;
  }
}

class _FakeBackgroundRepository extends BackgroundRepository {
  _FakeBackgroundRepository({
    required this.backgrounds,
    required this.stepViews,
  });

  final List<BackgroundData> backgrounds;
  final Map<int, BackgroundStepView> stepViews;

  @override
  Future<List<BackgroundData>> getAll() async => backgrounds;

  @override
  Future<BackgroundStepView> getStepView(int backgroundId) async =>
      stepViews[backgroundId]!;
}
