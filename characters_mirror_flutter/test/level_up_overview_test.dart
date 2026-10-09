import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/level_up/application/level_up_overview.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'first resource mechanic on an existing feature is announced, ordinary max growth is silent',
      () {
    final entry = CharacterClassEntryData(id: 'entry', level: 4);
    final preview = LevelUpPreview(
      before: CharacterData(
          classEntries: [entry],
          derived: CharacterDerivedData(activeFeatures: [
            CharacterFeatureViewData(
                sourceType: CharacterFeatureSourceType.classFeature,
                sourceId: 1,
                name: 'Feature',
                resources: [
                  CharacterResourceViewData(
                      key: 'old',
                      name: 'Old pool',
                      current: 1,
                      max: 4,
                      kind: FeatureResourceKind.points)
                ]),
          ])),
      character: CharacterData(
          classEntries: [entry.copyWith(level: 5)],
          derived: CharacterDerivedData(activeFeatures: [
            CharacterFeatureViewData(
                sourceType: CharacterFeatureSourceType.classFeature,
                sourceId: 1,
                name: 'Feature',
                resources: [
                  CharacterResourceViewData(
                      key: 'old',
                      name: 'Old pool',
                      current: 1,
                      max: 5,
                      kind: FeatureResourceKind.points),
                  CharacterResourceViewData(
                      key: 'new',
                      name: 'New mechanic',
                      current: 2,
                      max: 2,
                      kind: FeatureResourceKind.points),
                ]),
          ])),
      classStep: ClassStepView(currentLevelFeatures: [
        ClassFeatureData(
            parentClassId: 1,
            id: 1,
            referenceKey: 'feature',
            level: 1,
            name: 'Feature')
      ]),
      choiceGroups: [],
      missingDecisions: [],
      spellDelta: ClassSpellDeltaView(
          cantripsToAdd: 0,
          knownSpellsToAdd: 0,
          knownSpellReplacements: 0,
          spellbookSpellsToAdd: 0),
    );
    expect(
        newLevelUpFeatures(preview, 'entry').map((n) => n.name), ['Feature']);
    expect(
        newLevelUpFeatures(preview, 'entry').single.resources.map((r) => r.key),
        ['new']);
    final derivedOnly = newLevelUpFeatures(
        preview.copyWith(classStep: ClassStepView()), 'entry');
    expect(derivedOnly.map((f) => f.name), ['Feature']);
    expect(derivedOnly.single.resources.map((r) => r.key), ['new']);
  });

  test('level-up hides a choice group until its selected-option prerequisite',
      () {
    const parentKey = 'boon_fixture';
    final conditionalGroup = ChoiceGroupData(
      referenceKey: 'conditional_cantrips_fixture',
      requirements: [
        ChoiceRequirementData(
          type: ChoiceRequirementType.selectedChoiceOption,
          choiceGroupKey: parentKey,
          optionKey: 'tome',
        ),
      ],
    );
    final view = ChoiceGroupView(group: conditionalGroup, options: []);
    final character = CharacterData(
      classEntries: [
        CharacterClassEntryData(
          id: 'entry',
          classData: ClassData(referenceKey: 'warlock'),
          level: 3,
        ),
      ],
      choices: [
        CharacterChoiceData(groupKey: parentKey, optionKey: 'tome'),
      ],
      derived: CharacterDerivedData(totalLevel: 3),
    );
    final preview = LevelUpPreview(
      before: character,
      character: character,
      classStep: ClassStepView(),
      choiceGroups: [view],
      missingDecisions: [],
      spellDelta: ClassSpellDeltaView(
        cantripsToAdd: 0,
        knownSpellsToAdd: 0,
        spellbookSpellsToAdd: 0,
        knownSpellReplacements: 0,
      ),
    );
    expect(eligibleLevelUpGroup(view, preview).group, isNotNull);
    final withoutParent = preview.copyWith(
        character: character.copyWith(choices: const <CharacterChoiceData>[]));
    expect(eligibleLevelUpGroup(view, withoutParent).group, isNull);
  });
}
