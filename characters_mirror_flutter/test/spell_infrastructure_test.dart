import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/character_semantic_sync.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_operation_replay.dart';
import 'package:characters_mirror_flutter/core/character_spells/spell_selection_support.dart';
import 'package:characters_mirror_flutter/features/level_up/application/level_up_optimistic_preview.dart';
import 'package:characters_mirror_flutter/features/level_up/presentation/level_up_choice_replacements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('offline canonical grants bind ki and suppress bare grantedSpellKeys',
      () async {
    final cache = OfflineCacheDatabase.openInMemory();
    addTearDown(cache.close);
    final data =
        ClassData(id: 11, referenceKey: 'source_fixture', hitDieValue: 8);
    final feature =
        ClassFeatureData(id: 12, parentClassId: 11, level: 1, resources: [
      FeatureResourceDefinitionData(
          key: 'ki',
          kind: FeatureResourceKind.points,
          maxRule: FeatureResourceMaxRule.sourceClassLevel,
          resetOn: RestType.shortRest)
    ]);
    final spell = SpellData(id: 13, referenceKey: 'burning_hands', level: 1);
    final group = ChoiceGroupData(
        id: 14,
        referenceKey: 'choice_fixture',
        sourceClassId: 11,
        level: 1,
        type: ChoiceType.custom,
        selectionCount: 1);
    final option = ChoiceOptionData(
        id: 15,
        choiceGroupId: 14,
        optionKey: 'selected',
        grantedSpellKeys: ['burning_hands']);
    final grant = ClassSpellGrantData(
        id: 16,
        sourceClassId: 11,
        choiceOptionId: 15,
        spell: spell,
        castingAbility: Ability.wisdom,
        activation: SpellActivationData(
            canUseStandardSlots: false,
            canUsePactSlots: false,
            slotless: true,
            atWill: false,
            resourceKey: 'ki',
            resourceCost: 2));
    await cache.putReferenceList(
        'class_feature', 'all', [feature], (r) => r.toJson());
    await cache.putReferenceList(
        'choice_group', 'all', [group], (r) => r.toJson());
    await cache.putReferenceList(
        'choice_option', 'all', [option], (r) => r.toJson());
    await cache.putReferenceList(
        'class_spell_grant', 'all', [grant], (r) => r.toJson());
    await cache.putReferenceList('spell', 'all', [spell], (r) => r.toJson());
    final entry =
        CharacterClassEntryData(id: 'entry', classData: data, level: 3);
    var c = CharacterData(id: 1, classEntries: [
      entry
    ], choices: [
      CharacterChoiceData(
          id: 'chosen',
          classEntry: entry,
          groupKey: group.referenceKey,
          optionKey: option.optionKey)
    ]);
    c = c.copyWith(derived: await buildOfflineDerivedData(cache, c));
    final source = c.derived!.resolvedSpells!.single.sources.single;
    expect(source.resourceSourceId, 12);
    expect(source.castingAbility, Ability.wisdom);
    final operation = createCharacterSemanticOperation(
        character: c,
        localId: 1,
        serverId: 1,
        type: CharacterSyncOperationType.castSpell,
        changeId: 'cast',
        createdAt: DateTime.utc(2026),
        action: CharacterSemanticActionData(
            spellKey: 'burning_hands',
            spellSourceKey: source.sourceKey,
            slotSource: 'none',
            level: 1,
            spellPayment: 'resource'));
    final cast = replayCharacterSyncOperation(c, operation);
    expect(cast.resourceStates!.single.current, 1);
    expect(cast.currentSpellSlots, isNull);
    expect(() => replayCharacterSyncOperation(cast, operation),
        throwsA(isA<SpellCastFailure>()));
  });
  test(
      'creation normalizes a separate unrestricted quota through protocol JSON',
      () {
    final spells = [
      for (var i = 0; i < 3; i++)
        SpellData(
            id: i + 1,
            referenceKey: 'spell_$i',
            level: 1,
            schoolValue: i == 0 ? SpellSchool.evocation : SpellSchool.illusion)
    ];
    final group = ClassSpellSelectionGroupView(
        kind: CharacterSpellSelectionKind.knownSpell,
        classDataId: 1,
        classLevel: 3,
        selectionCount: 3,
        options: spells,
        selectionFilter: SpellSelectionFilterData(
            schools: [SpellSchool.evocation],
            kinds: [CharacterSpellSelectionKind.knownSpell],
            unrestrictedChoicesByLevel: {3: 1}));
    final selected = normalizeDraftSpells([
      for (final spell in spells)
        CharacterSpellSelectionData(
            classDataId: 1,
            spellId: spell.id,
            spellKey: spell.referenceKey,
            kind: group.kind)
    ], [
      ClassSpellSelectionGroupView.fromJson(group.toJson())
    ]);
    expect(selected.map((s) => s.spellId), [1, 2]);
  });

  final oldEntry = CharacterClassEntryData(
      id: 'entry', classData: ClassData(id: 1, hitDieValue: 8), level: 1);
  final nextEntry = oldEntry.copyWith(level: 2);
  final groups = [
    for (final level in [1, 2])
      ChoiceGroupView(
          group: ChoiceGroupData(
              referenceKey: 'line_$level',
              sourceClassId: 1,
              level: level,
              type: ChoiceType.custom,
              progressionKey: 'line',
              replacementsAllowed: level == 2 ? 1 : 0,
              selectionCount: 1),
          options: [
            for (final key in ['old', 'new'])
              if (level != 1 || key != 'new')
                ChoiceOptionData(
                    choiceGroupId: level, optionKey: key, name: key)
          ])
  ];
  final before = CharacterData(id: 1, classEntries: [
    oldEntry
  ], choices: [
    CharacterChoiceData(
        id: 'prior', classEntry: oldEntry, groupKey: 'line_1', optionKey: 'old')
  ]);
  final preview = LevelUpPreview(
      before: before,
      character: before.copyWith(classEntries: [nextEntry]),
      classStep: ClassStepView(choiceGroups: groups),
      choiceGroups: [groups.last],
      missingDecisions: [],
      spellDelta: ClassSpellDeltaView(
          cantripsToAdd: 0,
          knownSpellsToAdd: 0,
          spellbookSpellsToAdd: 0,
          knownSpellReplacements: 0));
  final request =
      LevelUpRequest(characterId: 1, expectedVersion: 1, classEntryId: 'entry');
  final replacement = LevelUpChoiceReplacementData(
      groupKey: 'line_2', selectionId: 'prior', optionKey: 'new');
  test(
      'offline optimistic replacement uses the same history and identity contract',
      () {
    final result = optimisticLevelUpPreview(
        preview, request, request.copyWith(choiceReplacements: [replacement]));
    expect(result.character.choices!.single.id, 'prior');
    expect(result.character.choices!.single.optionKey, 'new');
    expect(
        result.character.choices!.single.replacementHistory!.single
            .previousOptionKey,
        'old');
  });
  test('offline spell replacement preserves its original unrestricted slot',
      () {
    final rule = SpellSelectionFilterData(
        schools: [SpellSchool.abjuration, SpellSchool.evocation],
        kinds: [CharacterSpellSelectionKind.knownSpell],
        unrestrictedChoicesByLevel: {1: 1, 8: 2});
    final original = SpellData(
        id: 40,
        referenceKey: 'original',
        level: 1,
        schoolValue: SpellSchool.necromancy);
    final replacement = SpellData(
        id: 41,
        referenceKey: 'replacement',
        level: 1,
        schoolValue: SpellSchool.evocation);
    final selection = CharacterSpellSelectionData(
        id: 'known-slot',
        classEntry: oldEntry,
        classDataId: 1,
        spell: original,
        spellId: original.id,
        spellKey: original.referenceKey,
        kind: CharacterSpellSelectionKind.knownSpell,
        selectionIndex: 1,
        selectionFilter: rule,
        selectionRuleLevel: 1,
        selectionUnrestricted: true);
    final spellGroup = ClassSpellSelectionGroupView(
        kind: CharacterSpellSelectionKind.knownSpell,
        classDataId: 1,
        classLevel: 2,
        selectionCount: 2,
        selectionFilter: rule,
        options: [replacement]);
    final spellPreview = LevelUpPreview(
        before: before.copyWith(spellSelections: [selection]),
        character: before
            .copyWith(classEntries: [nextEntry], spellSelections: [selection]),
        classStep: ClassStepView(spellSelectionGroups: [spellGroup]),
        choiceGroups: [],
        missingDecisions: [],
        spellDelta: ClassSpellDeltaView(
            cantripsToAdd: 0,
            knownSpellsToAdd: 0,
            spellbookSpellsToAdd: 0,
            knownSpellReplacements: 1));
    final result = optimisticLevelUpPreview(
        spellPreview,
        request,
        request.copyWith(spells: [
          LevelUpSpellChoice(
              spellId: replacement.id!,
              kind: CharacterSpellSelectionKind.knownSpell,
              replacesSelectionId: selection.id)
        ]));
    final projected = result.character.spellSelections!.single;
    expect(projected.id, selection.id);
    expect(projected.spellId, replacement.id);
    expect(projected.selectionUnrestricted, isTrue);
    expect(projected.spellReplacementHistory!.single.spellId, original.id);
  });
  test('offline derived data resolves an option introduced in a later snapshot',
      () async {
    final cache = OfflineCacheDatabase.openInMemory();
    addTearDown(cache.close);
    await cache.putReferenceList(
        'class_feature',
        'all',
        [
          ClassFeatureData(
              id: 30, parentClassId: 1, level: 1, name: 'Line feature')
        ],
        (f) => f.toJson());
    await cache.putReferenceList(
        'choice_group',
        'all',
        [
          for (var i = 0; i < groups.length; i++)
            groups[i]
                .group!
                .copyWith(id: i + 1, sourceClassId: null, sourceFeatureId: 30)
        ],
        (g) => g.toJson());
    await cache.putReferenceList(
        'choice_option',
        'all',
        [
          ChoiceOptionData(id: 10, choiceGroupId: 1, optionKey: 'old'),
          ChoiceOptionData(
              id: 20,
              choiceGroupId: 2,
              optionKey: 'new',
              grantedAbilityBonuses: {'dexterity': 2}),
        ],
        (o) => o.toJson());
    final projected = optimisticLevelUpPreview(preview, request,
        request.copyWith(choiceReplacements: [replacement])).character;
    final derived = await buildOfflineDerivedData(cache, projected);
    expect(derived.abilityScores?[Ability.dexterity], 12);
    expect(
        derived.activeFeatures!.single.selectedChoiceDetails!.single.optionKey,
        'new');
    final original = projected.copyWith(
        classEntries: [oldEntry],
        choices: rollbackProgressionChoices(
                projected.choices!.map((c) => c.toJson()),
                classEntryId: 'entry',
                targetLevel: 1)
            .map(CharacterChoiceData.fromJson)
            .toList());
    final restored = await buildOfflineDerivedData(cache, original);
    expect(restored.abilityScores?[Ability.dexterity], 10);
  });
  testWidgets(
      'optional replacement picker selects prior choice then new option',
      (tester) async {
    LevelUpChoiceReplacementData? selected;
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: LevelUpChoiceReplacements(
                preview: preview,
                request: request,
                onChanged: (r) => selected = r,
                onClear: (id) {}))));
    await tester.tap(find.textContaining('Заменить ·'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('old'));
    await tester.pump();
    await tester.tap(find.text('Готово'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('new'));
    await tester.pump();
    await tester.tap(find.text('Готово'));
    await tester.pumpAndSettle();
    expect(selected?.selectionId, 'prior');
    expect(selected?.optionKey, 'new');
  });
  final path = Platform.environment['SPELL_INFRASTRUCTURE_REPLAY'];
  test(
      'actual server cast/rest operations replay with identical counters and barriers',
      () {
    final rows = File(path!)
        .readAsLinesSync()
        .where((s) => s.isNotEmpty)
        .map((s) => jsonDecode(s) as Map);
    expect(rows, isNotEmpty);
    for (final row in rows) {
      final before = CharacterData.fromJson(
          (row['before'] as Map).cast<String, dynamic>());
      final op = CharacterSyncOperationData.fromJson(
          (row['operation'] as Map).cast<String, dynamic>());
      final after =
          CharacterData.fromJson((row['after'] as Map).cast<String, dynamic>());
      final local = replayCharacterSyncOperation(before, op);
      expect(local.spellActivationUses, after.spellActivationUses,
          reason: op.id);
      expect(local.resourceStates?.map((s) => s.toJson()).toList() ?? [],
          after.resourceStates?.map((s) => s.toJson()).toList() ?? [],
          reason: op.id);
      expect(local.currentSpellSlots, after.currentSpellSlots, reason: op.id);
      final barriers = materializeLocalBarrierTokens(before, op);
      for (final target in characterSemanticActionTargetKeys(
          before, op.type, op.value!.semanticActionValue!)) {
        expect(barriers.syncBarrierTokens?[target],
            after.syncBarrierTokens?[target],
            reason: '${op.id}:$target');
      }
    }
  },
      skip: path == null
          ? 'Set SPELL_INFRASTRUCTURE_REPLAY to server integration exports.'
          : false);
}
