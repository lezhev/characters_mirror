import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import '../../../test_fixtures/selected_feature_choice_contract.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Feature presentation', (sessions, endpoints) {
    setUp(CharacterSaveRateLimiter.resetForTests);
    final owner = sessions.copyWith(
        authentication:
            AuthenticationOverride.authenticationInfo(967, <Scope>{}));
    for (final subclass in [false, true]) {
      test('server selected-choice contract, subclass=$subclass', () async {
        final session = owner.build();
        try {
          var data = await ClassData.db.insertRow(session,
              ClassData(name: 'Class', hitDieValue: 8, subclassChoiceLevel: 1));
          final feature = await ClassFeatureData.db.insertRow(
              session,
              ClassFeatureData(
                  parentClassId: data.id!,
                  name: 'Feature',
                  level: 1,
                  shortDescription: 'Short feature',
                  description: 'Full text must not be shown'));
          data = await ClassData.db.updateRow(
              session, data.copyWith(subclassChoiceFeatureId: feature.id));
          final sub = await SubclassData.db.insertRow(
              session,
              SubclassData(
                  parentClassId: data.id!,
                  name: 'Ограждения',
                  subclassName: 'Школа',
                  levelRequired: 1));
          final subfeature = await SubclassFeatureData.db.insertRow(
              session,
              SubclassFeatureData(
                  parentSubclassId: sub.id!,
                  name: 'Subfeature',
                  level: 1,
                  description: 'Full subfeature text must not be shown'));
          for (var i = 0; i < 2; i++) {
            final group = await ChoiceGroupData.db.insertRow(
                session,
                ChoiceGroupData(
                    referenceKey: 'decision_${i == 0 ? 'a' : 'b'}',
                    name: 'Refinement ${i == 0 ? 'A' : 'B'}',
                    sourceFeatureId: subclass ? null : feature.id,
                    sourceSubclassFeatureId: subclass ? subfeature.id : null,
                    sortOrder: i,
                    minimumSelectionCount: 0,
                    selectionCount: 1));
            await ChoiceOptionData.db.insertRow(
                session,
                ChoiceOptionData(
                    choiceGroupId: group.id!,
                    optionKey: i == 0 ? 'a' : 'b',
                    name: i == 0 ? 'Selected A' : 'Selected B',
                    shortDescription: i == 0 ? 'Short A' : null,
                    description: i == 0 ? 'Full A' : 'Full B'));
          }
          await FeatureDisplayPropertyData.db.insertRow(
              session,
              FeatureDisplayPropertyData(
                  sourceClassFeatureId: feature.id!,
                  key: 'amount',
                  label: 'Amount',
                  valueKind: FeatureDisplayPropertyValueKind.staticValue,
                  staticValue: '2'));
          await FeatureResourceDefinitionData.db.insertRow(
              session,
              FeatureResourceDefinitionData(
                  classFeatureId: feature.id,
                  key: 'pool',
                  name: 'Pool',
                  kind: FeatureResourceKind.points,
                  maxRule: FeatureResourceMaxRule.fixed,
                  maxValue: 2,
                  resetOn: RestType.shortRest));
          final character = await endpoints.characterData.saveCharacter(
              owner,
              CharacterData(name: 'Presentation test', classEntries: [
                CharacterClassEntryData(
                    id: 'entry',
                    classData: data,
                    subclass: subclass ? sub : null,
                    level: 1,
                    isStartingClass: true)
              ], choices: [
                CharacterChoiceData(
                    groupKey: 'decision_b',
                    optionKey: 'b',
                    classEntry: CharacterClassEntryData(id: 'entry')),
                CharacterChoiceData(
                    groupKey: 'decision_a',
                    optionKey: 'a',
                    classEntry: CharacterClassEntryData(id: 'entry')),
              ]));
          final resolved = character.derived!.activeFeatures!.firstWhere((f) =>
              f.sourceId == (subclass ? subfeature.id : feature.id) &&
              f.sourceType ==
                  (subclass
                      ? CharacterFeatureSourceType.subclassFeature
                      : CharacterFeatureSourceType.classFeature));
          expect(
              selectedChoiceProjection(
                  resolved.selectedChoiceDetails!.map((c) => c.toJson())),
              selectedFeatureChoiceContract);
          expect(
              resolved.description,
              subclass
                  ? 'Full subfeature text must not be shown'
                  : 'Short feature');
          expect(
              resolved.shortDescription, subclass ? isNull : 'Short feature');
          if (subclass) expect(resolved.sourceName, 'Школа ограждения');
          final step = await endpoints.classData.getStepView(owner, data.id!,
              selectedLevel: 1, isStartingClass: true);
          expect(step.subclassChoice!.sourceFeatureId, feature.id);
          final view = step.currentLevelFeatureViews!.single;
          expect(view.displayProperties!.single.value, '2');
          expect(view.resources!.single.max, 2);
          expect(
              character.derived!.activeFeatures!
                  .firstWhere((f) =>
                      f.sourceType == CharacterFeatureSourceType.classFeature)
                  .displayProperties!
                  .single
                  .value,
              '2');
        } finally {
          await session.close();
        }
      });
    }
  });
}
