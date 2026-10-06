import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_fixtures/selected_feature_choice_contract.dart';

void main() {
  for (final subclass in [false, true]) {
    test('offline selected-choice contract, subclass=$subclass', () async {
      final cache = OfflineCacheDatabase.openInMemory();
      addTearDown(cache.close);
      final data = ClassData(id: 1, name: 'Class');
      final sub = SubclassData(
          id: 2, parentClassId: 1, name: 'Ограждения', subclassName: 'Школа');
      final feature = ClassFeatureData(
          id: 3,
          parentClassId: 1,
          name: 'Feature',
          level: 1,
          description: 'Full text must not be shown',
          shortDescription: 'Short feature',
          resources: [
            FeatureResourceDefinitionData(
                classFeatureId: 3,
                key: 'pool',
                name: 'Pool',
                kind: FeatureResourceKind.points,
                maxRule: FeatureResourceMaxRule.fixed,
                maxValue: 2,
                resetOn: RestType.shortRest)
          ]);
      final subfeature = SubclassFeatureData(
          id: 4,
          parentSubclassId: 2,
          level: 1,
          name: 'Subfeature',
          description: 'Full subfeature text must not be shown');
      await cache.putReference(
          offlineClassStepKind,
          offlineClassStepKey(1, selectedSubclassId: subclass ? 2 : null),
          ClassStepView(
              classData: data,
              currentLevelFeatures: [feature],
              currentLevelFeatureViews: [
                ClassStepFeatureView(classFeature: feature, displayProperties: [
                  FeatureDisplayPropertyView(
                      key: 'amount', label: 'Amount', value: '2')
                ])
              ],
              currentSubclassFeatures: subclass ? [subfeature] : []),
          (v) => v.toJson());
      await cache.putReferenceList(
          'class_feature', offlineAllKey, [feature], (v) => v.toJson());
      await cache.putReferenceList(
          'subclass_feature', offlineAllKey, [subfeature], (v) => v.toJson());
      final groups = [
        for (var i = 0; i < 2; i++)
          ChoiceGroupData(
              id: 10 + i,
              referenceKey: 'decision_${i == 0 ? 'a' : 'b'}',
              name: 'Refinement ${i == 0 ? 'A' : 'B'}',
              sourceFeatureId: subclass ? null : 3,
              sourceSubclassFeatureId: subclass ? 4 : null,
              sortOrder: i,
              minimumSelectionCount: 0,
              selectionCount: 1)
      ];
      final options = [
        ChoiceOptionData(
            choiceGroupId: 10,
            optionKey: 'a',
            name: 'Selected A',
            shortDescription: 'Short A',
            description: 'Full A'),
        ChoiceOptionData(
            choiceGroupId: 11,
            optionKey: 'b',
            name: 'Selected B',
            description: 'Full B'),
      ];
      await cache.putReferenceList(
          'choice_group', offlineAllKey, groups, (v) => v.toJson());
      await cache.putReferenceList(
          'choice_option', offlineAllKey, options, (v) => v.toJson());
      final derived = await buildOfflineDerivedData(
          cache,
          CharacterData(classEntries: [
            CharacterClassEntryData(
                id: 'entry',
                classData: data,
                subclass: subclass ? sub : null,
                level: 1,
                isStartingClass: true)
          ], choices: [
            CharacterChoiceData(groupKey: 'decision_b', optionKey: 'b'),
            CharacterChoiceData(groupKey: 'decision_a', optionKey: 'a'),
          ]));
      final resolved = derived.activeFeatures!
          .firstWhere((f) => f.sourceId == (subclass ? 4 : 3));
      final baseFeature = derived.activeFeatures!.firstWhere(
          (f) => f.sourceType == CharacterFeatureSourceType.classFeature);
      expect(baseFeature.displayProperties!.single.value, '2');
      expect(baseFeature.resources!.single.max, 2);
      expect(
          selectedChoiceProjection(
              resolved.selectedChoiceDetails!.map((c) => c.toJson())),
          selectedFeatureChoiceContract);
      expect(
          resolved.description,
          subclass
              ? 'Full subfeature text must not be shown'
              : 'Short feature');
      expect(resolved.shortDescription, subclass ? isNull : 'Short feature');
      if (subclass) expect(resolved.sourceName, 'Школа ограждения');
      final restored = CharacterFeatureViewData.fromJson(resolved.toJson());
      expect(
          selectedChoiceProjection(
              restored.selectedChoiceDetails!.map((c) => c.toJson())),
          selectedFeatureChoiceContract);
    });
  }
  test('legacy cache payload remains readable without full-text fallback', () {
    final old = CharacterFeatureViewData.fromJson({
      'sourceType': 'classFeature',
      'sourceId': 1,
      'description': 'Legacy full text',
      'selectedChoices': ['Legacy label'],
    });
    expect(old.shortDescription, isNull);
    expect(old.selectedChoiceDetails, isNull);
    expect(old.description, 'Legacy full text');
  });
}
