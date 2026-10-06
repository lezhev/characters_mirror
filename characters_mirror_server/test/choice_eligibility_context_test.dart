import 'package:characters_mirror_server/src/choice_eligibility_context.dart';
import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

void main() {
  test('legacy spell selections use the linked spell reference key', () {
    final context = buildChoiceEligibilityContext(
      character: CharacterData(
        spellSelections: [
          CharacterSpellSelectionData(
            spell: SpellData(referenceKey: 'legacy_spell'),
            kind: CharacterSpellSelectionKind.knownSpell,
          ),
        ],
      ),
      evaluatingGroupKey: 'invocations',
      selectedOptionsByGroupKey: const {},
      groups: const [],
      abilityScores: const {},
      currentClassFeatures: const [],
      currentSubclassFeatures: const [],
    );

    expect(context.knownSpellKeys, contains('legacy_spell'));
  });

  test('class and subclass features remain distinct when numeric ids match',
      () {
    final classFeature = ClassFeatureData(
      id: 17,
      parentClassId: 1,
      referenceKey: 'class_feature',
      level: 1,
    );
    final subclassFeature = SubclassFeatureData(
      id: 17,
      parentSubclassId: 2,
      referenceKey: 'subclass_feature',
      level: 1,
    );
    final built = buildChoiceEligibilityContext(
      character: CharacterData(),
      evaluatingGroupKey: 'invocations',
      selectedOptionsByGroupKey: const {},
      groups: const [],
      abilityScores: const {},
      currentClassFeatures: [classFeature],
      currentSubclassFeatures: [subclassFeature],
    );

    expect(
      evaluateChoiceOptionEligibility(
        requirements: [
          const ChoiceRequirement(
            kind: ChoiceRequirementKind.feature,
            referenceKey: 'class_feature',
          ),
          const ChoiceRequirement(
            kind: ChoiceRequirementKind.feature,
            referenceKey: 'subclass_feature',
          ),
        ],
        context: built,
      ).isEligible,
      isTrue,
    );
    expect(
        built.featureKeys, containsAll(['class_feature', 'subclass_feature']));
  });
}
