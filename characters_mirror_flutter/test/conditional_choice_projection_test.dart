import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/conditional_choice_support.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final data = ClassData(
      id: 9101, referenceKey: 'conditional_caster_fixture', hitDieValue: 6);
  final sub = SubclassData(id: 9102, parentClassId: data.id!, levelRequired: 2);
  final feature = SubclassFeatureData(
      id: 9103, parentSubclassId: sub.id!, level: 2, name: 'Conditional');
  final group = ChoiceGroupData(
      id: 9104,
      referenceKey: 'conditional_cantrip_fixture',
      sourceSubclassFeatureId: feature.id,
      level: 2,
      type: ChoiceType.custom,
      autoSelectSingleEligible: true,
      selectionCount: 1,
      minimumSelectionCount: 1);
  final spells = [
    for (var i = 0; i < 3; i++)
      SpellData(
          id: 9110 + i,
          referenceKey: [
            'conditional_default',
            'conditional_fallback',
            'conditional_duplicate'
          ][i],
          name: ['default', 'fallback', 'duplicate'][i],
          level: 0,
          availableForClassIds: [data.id!])
  ];
  final options = [
    for (var i = 0; i < spells.length; i++)
      ChoiceOptionData(
          id: 9120 + i,
          choiceGroupId: group.id!,
          optionKey: spells[i].referenceKey,
          automaticSelection: i == 0,
          name: spells[i].name,
          grantedSpellKeys: [
            spells[i].referenceKey
          ],
          requirements: [
            ChoiceRequirementData(
                type: ChoiceRequirementType.knownCantrip,
                referenceKey: spells.first.referenceKey,
                negate: i == 0),
            if (i > 0)
              ChoiceRequirementData(
                  type: ChoiceRequirementType.knownCantrip,
                  referenceKey: spells[i].referenceKey,
                  negate: true),
          ])
  ];
  final view = ChoiceGroupView(group: group, options: options);
  CharacterData draft(List<SpellData> known) => CharacterData(classEntries: [
        CharacterClassEntryData(
            id: 'entry',
            classData: data,
            subclass: sub,
            level: 2,
            isStartingClass: true)
      ], spellSelections: [
        for (final spell in known)
          CharacterSpellSelectionData(
              classDataId: data.id,
              spellKey: spell.referenceKey,
              spell: spell,
              kind: CharacterSpellSelectionKind.knownCantrip)
      ]);

  late OfflineCacheDatabase cache;
  setUp(() async {
    cache = OfflineCacheDatabase.openInMemory();
    await cache.putReferenceList(
        'choice_group', offlineAllKey, [group], (g) => g.toJson());
    await cache.putReferenceList(
        'choice_option', offlineAllKey, options, (o) => o.toJson());
    await cache.putReferenceList(
        'spell', offlineAllKey, spells, (s) => s.toJson());
    await cache.putReferenceList(
        'subclass_feature', offlineAllKey, [feature], (f) => f.toJson());
    await cache.putReference(
        offlineClassStepKind,
        offlineClassStepKey(data.id!,
            selectedLevel: 2, selectedSubclassId: sub.id),
        ClassStepView(
            classData: data,
            selectedLevel: 2,
            currentSubclassFeatures: [feature],
            choiceGroups: [view]),
        (v) => v.toJson());
  });
  tearDown(() => cache.close());

  test(
      'creation auto selects grant, but a known default requires an eligible replacement',
      () {
    expect(
        resolveConditionalChoiceSelections(
                character: draft([]),
                groups: [view],
                selections: {})[group.referenceKey]!
            .single
            .optionKey,
        spells.first.referenceKey);
    final fallback = resolveConditionalChoiceSelections(
        character: draft([spells.first, spells[2]]),
        groups: [
          view
        ],
        selections: {
          group.referenceKey: [options[2]]
        });
    expect(fallback[group.referenceKey], isEmpty);
  });

  test('conditional groups disappear and clear selections without their parent',
      () {
    const parentKey = 'conditional_parent_fixture';
    const childKey = 'conditional_child_fixture';
    final parent = ChoiceGroupView(
      group: ChoiceGroupData(referenceKey: parentKey),
      options: [ChoiceOptionData(choiceGroupId: 1, optionKey: 'tome')],
    );
    final child = ChoiceGroupView(
      group: ChoiceGroupData(
        referenceKey: childKey,
        selectionCount: 3,
        minimumSelectionCount: 3,
        requirements: [
          ChoiceRequirementData(
            type: ChoiceRequirementType.selectedChoiceOption,
            choiceGroupKey: parentKey,
            optionKey: 'tome',
          ),
        ],
      ),
      options: [
        for (final key in ['cantrip_a', 'cantrip_b', 'cantrip_c'])
          ChoiceOptionData(choiceGroupId: 2, optionKey: key),
      ],
    );
    final selected = <String, List<ChoiceOptionData>>{
      parentKey: [parent.options!.single],
      childKey: [child.options!.first],
    };
    expect(
        resolveConditionalChoiceSelections(
                character: draft([]),
                groups: [parent, child],
                selections: selected)
            .keys,
        contains(childKey));
    final withoutParent = resolveConditionalChoiceSelections(
      character: draft([]),
      groups: [parent, child],
      selections: {
        childKey: [child.options!.first]
      },
    );
    expect(withoutParent.containsKey(childKey), isFalse);
  });

  test('offline enforces active conditional group minimums and rejects orphans',
      () async {
    const parentKey = 'offline_parent_fixture';
    const childKey = 'offline_child_fixture';
    final parentGroup = ChoiceGroupData(
      id: 9130,
      referenceKey: parentKey,
      sourceSubclassFeatureId: feature.id,
      selectionCount: 1,
    );
    final childGroup = ChoiceGroupData(
      id: 9131,
      referenceKey: childKey,
      sourceSubclassFeatureId: feature.id,
      selectionCount: 3,
      minimumSelectionCount: 3,
      requirements: [
        ChoiceRequirementData(
          type: ChoiceRequirementType.selectedChoiceOption,
          choiceGroupKey: parentKey,
          optionKey: 'tome',
        ),
      ],
    );
    final parentOption = ChoiceOptionData(
      id: 9132,
      choiceGroupId: parentGroup.id!,
      optionKey: 'tome',
    );
    final childOptions = [
      for (var i = 0; i < 3; i++)
        ChoiceOptionData(
          id: 9133 + i,
          choiceGroupId: childGroup.id!,
          optionKey: 'child_$i',
        ),
    ];
    await cache.putReferenceList('choice_group', offlineAllKey,
        [group, parentGroup, childGroup], (g) => g.toJson());
    await cache.putReferenceList('choice_option', offlineAllKey,
        [...options, parentOption, ...childOptions], (o) => o.toJson());
    final valid = draft([]).copyWith(choices: [
      CharacterChoiceData(id: 'parent', groupKey: parentKey, optionKey: 'tome'),
      for (var i = 0; i < 3; i++)
        CharacterChoiceData(
            id: 'child_$i', groupKey: childKey, optionKey: 'child_$i'),
    ]);
    expect(await resolveOfflineCharacter(cache, valid), isNotNull);
    await expectLater(
      resolveOfflineCharacter(
        cache,
        valid.copyWith(choices: [valid.choices!.first]),
      ),
      throwsA(isA<StateError>()),
    );
    final withoutParent = await resolveOfflineCharacter(
      cache,
      valid.copyWith(choices: valid.choices!.skip(1).toList()),
    );
    expect(withoutParent.choices!.any((choice) => choice.groupKey == childKey),
        isFalse);
    final multiclass = valid.copyWith(
      classEntries: [
        ...valid.classEntries!,
        CharacterClassEntryData(
          id: 'other_entry',
          classData: ClassData(id: 9199, referenceKey: 'other_class'),
          level: 1,
        ),
      ],
      choices: [
        valid.choices!.first,
        for (final choice in valid.choices!.skip(1))
          choice.copyWith(
              classEntry: CharacterClassEntryData(id: 'other_entry')),
      ],
    );
    await expectLater(
      resolveOfflineCharacter(cache, multiclass),
      throwsA(isA<StateError>()),
    );
  });

  test(
      'offline automatic grant is a choice shown on the feature, outside selections',
      () async {
    final c =
        await resolveOfflineCharacter(cache, draft([spells[1], spells[2]]));
    expect(c.spellSelections, hasLength(2));
    expect(c.choices!.single.optionKey, spells.first.referenceKey);
    expect(c.derived!.resolvedSpells, hasLength(3));
    expect(c.derived!.activeFeatures!.single.selectedChoiceDetails!.single.name,
        'default');
    final again = await resolveOfflineCharacter(cache, c);
    expect(again.choices!.single.id, c.choices!.single.id);
  });

  test(
      'offline known default has no automatic duplicate; selected fallback is shown',
      () async {
    final c = await resolveOfflineCharacter(cache, draft([spells.first]));
    expect(c.choices ?? [], isEmpty);
    expect(
        c.derived!.activeFeatures!.single.selectedChoiceDetails ?? [], isEmpty);
    expect(c.derived!.resolvedSpells, hasLength(1));
    final selected = await resolveOfflineCharacter(
        cache,
        c.copyWith(choices: [
          CharacterChoiceData(
              id: 'choice',
              groupKey: group.referenceKey,
              optionKey: spells[1].referenceKey)
        ]));
    expect(
        selected
            .derived!.activeFeatures!.single.selectedChoiceDetails!.single.name,
        'fallback');
    final down = await resolveOfflineCharacter(
        cache,
        selected.copyWith(classEntries: [
          selected.classEntries!.single.copyWith(level: 1, subclass: null)
        ], choices: []));
    expect(down.derived!.resolvedSpells!.map((s) => s.spellKey),
        contains(spells.first.referenceKey));
    expect(down.derived!.resolvedSpells!.map((s) => s.spellKey),
        isNot(contains(spells[1].referenceKey)));
  });

  test(
      'offline canonical class cantrip grants participate in acquisition facts',
      () async {
    await cache.putReferenceList(
        'class_spell_grant',
        offlineAllKey,
        [
          ClassSpellGrantData(
              sourceClassId: data.id,
              spellId: spells.first.id,
              spell: spells.first,
              grantedAtLevel: 1)
        ],
        (g) => g.toJson());
    final c = await resolveOfflineCharacter(cache, draft([]));
    expect(c.choices ?? [], isEmpty);
    expect(
        c.derived!.resolvedSpells!.single.spellKey, spells.first.referenceKey);
  });
}
