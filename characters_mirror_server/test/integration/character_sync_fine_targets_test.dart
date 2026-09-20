import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _protocolVersion = 4;

void main() {
  withServerpod('Character fine-grained sync targets', (
    sessionBuilder,
    endpoints,
  ) {
    setUp(CharacterSaveRateLimiter.resetForTests);

    TestSessionBuilder authenticatedSession(int userId) {
      return sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId,
          <Scope>{},
        ),
      );
    }

    test('negotiates protocol and rejects member operations from old clients',
        () async {
      final session = authenticatedSession(301);
      final saved = await endpoints.characterData.saveCharacter(
        session,
        CharacterData(name: 'Protocol'),
      );
      final operation = _conditionOperation(
        id: 'unsupported-member',
        character: saved,
        condition: ConditionType.poisoned,
        add: true,
      );

      final probe = await endpoints.characterData.syncCharacters(
        session,
        CharacterSyncRequest(syncProtocolVersion: _protocolVersion),
      );
      final rejected = await endpoints.characterData.syncCharacters(
        session,
        CharacterSyncRequest(operations: [operation]),
      );

      expect(probe.syncProtocolVersion, _protocolVersion);
      expect(probe.capabilities, contains('member_operations'));
      expect(rejected.rejectedChanges, hasLength(1));
      expect(
        rejected.rejectedChanges!.single.reason,
        'unsupported_sync_protocol',
      );
    });

    test('merges different set members and acknowledges repeated add',
        () async {
      final session = authenticatedSession(302);
      final saved = await endpoints.characterData.saveCharacter(
        session,
        CharacterData(name: 'Conditions'),
      );
      final poisoned = _conditionOperation(
        id: 'add-poisoned',
        character: saved,
        condition: ConditionType.poisoned,
        add: true,
      );
      final prone = _conditionOperation(
        id: 'add-prone',
        character: saved,
        condition: ConditionType.prone,
        add: true,
      );
      final repeatedPoisoned = poisoned.copyWith(id: 'repeat-poisoned');

      final first = await _sync(endpoints, session, poisoned);
      final second = await _sync(endpoints, session, prone);
      final repeated = await _sync(endpoints, session, repeatedPoisoned);
      final current = await endpoints.characterData.getCharacter(
        session,
        saved.id!,
      );

      expect(first.acknowledgedChangeIds, contains(poisoned.id));
      expect(second.acknowledgedChangeIds, contains(prone.id));
      expect(repeated.acknowledgedChangeIds, contains(repeatedPoisoned.id));
      expect(current.activeConditions?.toSet(), {
        ConditionType.poisoned,
        ConditionType.prone,
      });
    });

    test('rejects the opposite stale operation for the same member', () async {
      final session = authenticatedSession(303);
      final saved = await endpoints.characterData.saveCharacter(
        session,
        CharacterData(name: 'Same member'),
      );
      final add = _conditionOperation(
        id: 'same-member-add',
        character: saved,
        condition: ConditionType.poisoned,
        add: true,
      );
      final staleRemove = _conditionOperation(
        id: 'same-member-remove',
        character: saved,
        condition: ConditionType.poisoned,
        add: false,
      );

      await _sync(endpoints, session, add);
      final response = await _sync(endpoints, session, staleRemove);

      expect(response.rejectedChanges, hasLength(1));
      expect(response.rejectedChanges!.single.reason, 'target_conflict');
    });

    test('old coarse and new fine condition writes conflict in both orders',
        () async {
      final session = authenticatedSession(304);
      final fineFirstBase = await endpoints.characterData.saveCharacter(
        session,
        CharacterData(name: 'Fine first'),
      );
      await _sync(
        endpoints,
        session,
        _conditionOperation(
          id: 'fine-first',
          character: fineFirstBase,
          condition: ConditionType.poisoned,
          add: true,
        ),
      );
      final staleCoarse = await _sync(
        endpoints,
        session,
        _coarseConditionsOperation(
          id: 'stale-coarse',
          character: fineFirstBase,
          conditions: const [ConditionType.prone],
        ),
      );

      final coarseFirstBase = await endpoints.characterData.saveCharacter(
        session,
        CharacterData(name: 'Coarse first'),
      );
      await _sync(
        endpoints,
        session,
        _coarseConditionsOperation(
          id: 'coarse-first',
          character: coarseFirstBase,
          conditions: const [ConditionType.poisoned],
        ),
      );
      final staleFine = await _sync(
        endpoints,
        session,
        _conditionOperation(
          id: 'stale-fine',
          character: coarseFirstBase,
          condition: ConditionType.prone,
          add: true,
        ),
      );

      expect(staleCoarse.rejectedChanges!.single.reason, 'target_conflict');
      expect(staleFine.rejectedChanges!.single.reason, 'target_conflict');
    });

    test('first fine proficiency write preserves legacy effective state',
        () async {
      final session = authenticatedSession(305);
      final saved = await endpoints.characterData.saveCharacter(
        session,
        CharacterData(
          name: 'Legacy proficiencies',
          manualSkillProficiencies: [
            CharacterSkillProficiencyState(
              skill: Skill.arcana,
              level: CharacterSkillProficiencyLevel.proficient,
            ),
          ],
          manualSavingThrowProficiencies: const [Ability.strength],
        ),
      );
      final skill = _memberValueOperation(
        id: 'set-stealth',
        character: saved,
        field: 'manualSkillProficiencyOverrides',
        member: Skill.stealth.name,
        legacyField: 'manualSkillProficiencies',
        value: CharacterSyncValueData(
          skillProficiencyValue: CharacterSkillProficiencyState(
            skill: Skill.stealth,
            level: CharacterSkillProficiencyLevel.expertise,
          ),
        ),
      );
      final savingThrow = _memberValueOperation(
        id: 'set-dexterity-save',
        character: saved,
        field: 'manualSavingThrowProficiencyOverrides',
        member: Ability.dexterity.name,
        legacyField: 'manualSavingThrowProficiencies',
        value: CharacterSyncValueData(
          savingThrowProficiencyOverrideValue:
              CharacterSavingThrowProficiencyOverrideData(
            ability: Ability.dexterity,
            state: CharacterSavingThrowProficiencyOverride.add,
          ),
        ),
      );

      await _sync(endpoints, session, skill);
      await _sync(endpoints, session, savingThrow);
      final current = await endpoints.characterData.getCharacter(
        session,
        saved.id!,
      );
      final skillLevels = {
        for (final value in current.manualSkillProficiencyOverrides ??
            const <CharacterSkillProficiencyState>[])
          value.skill: value.level,
      };

      expect(
        skillLevels[Skill.arcana],
        CharacterSkillProficiencyLevel.proficient,
      );
      expect(
        skillLevels[Skill.stealth],
        CharacterSkillProficiencyLevel.expertise,
      );
      expect(
        current.derived?.savingThrowProficiencies,
        containsAll([Ability.strength, Ability.dexterity]),
      );
    });

    test('merges different prepared spells and skill members', () async {
      final session = authenticatedSession(307);
      final saved = await endpoints.characterData.saveCharacter(
        session,
        CharacterData(
          name: 'Independent members',
          preparedSpellKeys: const ['light'],
          manualSkillProficiencyOverrides: const <CharacterSkillProficiencyState>[],
        ),
      );
      final fireball = _setMemberOperation(
        id: 'prepare-fireball',
        character: saved,
        field: 'preparedSpellKeys',
        member: 'fireball',
        add: true,
        value: CharacterSyncValueData(stringValue: 'fireball'),
      );
      final haste = _setMemberOperation(
        id: 'prepare-haste',
        character: saved,
        field: 'preparedSpellKeys',
        member: 'haste',
        add: true,
        value: CharacterSyncValueData(stringValue: 'haste'),
      );
      final arcana = _memberValueOperation(
        id: 'set-arcana',
        character: saved,
        field: 'manualSkillProficiencyOverrides',
        member: Skill.arcana.name,
        legacyField: 'manualSkillProficiencies',
        value: CharacterSyncValueData(
          skillProficiencyValue: CharacterSkillProficiencyState(
            skill: Skill.arcana,
            level: CharacterSkillProficiencyLevel.proficient,
          ),
        ),
      );
      final stealth = _memberValueOperation(
        id: 'set-stealth-independent',
        character: saved,
        field: 'manualSkillProficiencyOverrides',
        member: Skill.stealth.name,
        legacyField: 'manualSkillProficiencies',
        value: CharacterSyncValueData(
          skillProficiencyValue: CharacterSkillProficiencyState(
            skill: Skill.stealth,
            level: CharacterSkillProficiencyLevel.expertise,
          ),
        ),
      );

      for (final operation in [fireball, haste, arcana, stealth]) {
        final response = await _sync(endpoints, session, operation);
        expect(response.acknowledgedChangeIds, contains(operation.id));
      }
      final current = await endpoints.characterData.getCharacter(
        session,
        saved.id!,
      );
      final skillLevels = {
        for (final value in current.manualSkillProficiencyOverrides ??
            const <CharacterSkillProficiencyState>[])
          value.skill: value.level,
      };

      expect(
        current.preparedSpellKeys,
        containsAll(['light', 'fireball', 'haste']),
      );
      expect(
        skillLevels[Skill.arcana],
        CharacterSkillProficiencyLevel.proficient,
      );
      expect(
        skillLevels[Skill.stealth],
        CharacterSkillProficiencyLevel.expertise,
      );
    });

    test('merges different starting resolution lines and isolates parent',
        () async {
      final session = authenticatedSession(308);
      final referenceSession = sessionBuilder.build();
      late final StartingEquipmentEntryData lineXReference;
      late final StartingEquipmentEntryData lineYReference;
      try {
        lineXReference = await StartingEquipmentEntryData.db.insertRow(
          referenceSession,
          StartingEquipmentEntryData(),
        );
        lineYReference = await StartingEquipmentEntryData.db.insertRow(
          referenceSession,
          StartingEquipmentEntryData(),
        );
      } finally {
        await referenceSession.close();
      }
      final saved = await endpoints.characterData.saveCharacter(
        session,
        CharacterData(
          name: 'Starting equipment',
          startingEquipmentSelections: [
            CharacterStartingEquipmentSelectionData(
              id: 'legacy-selection',
              sourceType: ChoiceSourceType.classData,
              sourceId: 5,
              selectionIndex: 0,
              isSelected: true,
              resolutions: [
                CharacterStartingEquipmentResolutionData(
                  id: 'legacy-x',
                  sourceLineEntryId: lineXReference.id,
                  referenceKey: 'rope',
                  quantity: 1,
                ),
                CharacterStartingEquipmentResolutionData(
                  id: 'legacy-y',
                  sourceLineEntryId: lineYReference.id,
                  referenceKey: 'torch',
                  quantity: 1,
                ),
              ],
            ),
          ],
        ),
      );
      const selectionId = 'classData:5::0';
      final lineX = _startingResolutionOperation(
        id: 'line-x',
        character: saved,
        selectionId: selectionId,
        sourceLineEntryId: lineXReference.id!,
        payload: CharacterStartingEquipmentResolutionData(
          id: 'legacy-x',
          sourceLineEntryId: lineXReference.id,
          referenceKey: 'silk-rope',
          quantity: 2,
        ),
      );
      final lineY = _startingResolutionOperation(
        id: 'line-y',
        character: saved,
        selectionId: selectionId,
        sourceLineEntryId: lineYReference.id!,
        payload: CharacterStartingEquipmentResolutionData(
          id: 'legacy-y',
          sourceLineEntryId: lineYReference.id,
          referenceKey: 'lantern',
          quantity: 1,
        ),
      );

      await _sync(endpoints, session, lineX);
      await _sync(endpoints, session, lineY);
      final parent = CharacterSyncOperationData(
        id: 'parent-update',
        characterId: saved.id,
        localCharacterId: saved.id,
        type: CharacterSyncOperationType.upsertListItem,
        targetType: CharacterSyncTargetType.listItem,
        targetId: selectionId,
        fieldPath: 'startingEquipmentSelections',
        itemPayload: CharacterSyncValueData(
          startingEquipmentSelectionValue:
              CharacterStartingEquipmentSelectionData(
            id: 'legacy-selection',
            sourceType: ChoiceSourceType.classData,
            sourceId: 5,
            selectionIndex: 0,
            isSelected: false,
            resolutions: saved.startingEquipmentSelections!.single.resolutions,
          ),
        ),
        baseCharacterRevision: saved.version,
        baseTargetRevision: _itemBaseRevision(
          saved,
          'startingEquipmentSelections',
          selectionId,
        ),
        createdAt: DateTime.utc(2026, 9, 14),
      );
      final parentResponse = await _sync(endpoints, session, parent);
      final current = await endpoints.characterData.getCharacter(
        session,
        saved.id!,
      );
      final resolutions = {
        for (final value
            in current.startingEquipmentSelections!.single.resolutions!)
          value.sourceLineEntryId: value,
      };

      expect(parentResponse.acknowledgedChangeIds, contains(parent.id));
      expect(resolutions[lineXReference.id]!.referenceKey, 'silk-rope');
      expect(resolutions[lineYReference.id]!.referenceKey, 'lantern');
      expect(current.startingEquipmentSelections!.single.isSelected, isFalse);
    });

    test('feature subfields merge and pruning bumps side-effect tombstones',
        () async {
      final session = authenticatedSession(309);
      final fixture = await _seedFeatureFixture(sessionBuilder, endpoints);
      final classEntry = CharacterClassEntryData(
        id: 'class-entry',
        classData: fixture.$1,
        level: 1,
        isStartingClass: true,
        classOrder: 0,
      );
      final saved = await endpoints.characterData.saveCharacter(
        session,
        CharacterData(
          name: 'Feature targets',
          classEntries: [classEntry],
          featureOverrides: [
            CharacterFeatureOverrideData(
              id: 'old-feature-id',
              sourceType: CharacterFeatureSourceType.classFeature,
              sourceId: fixture.$2.id!,
              name: 'Old name',
              description: 'Old description',
            ),
          ],
          resourceStates: [
            CharacterResourceStateData(
              sourceType: CharacterFeatureSourceType.classFeature,
              sourceId: fixture.$2.id!,
              resourceKey: 'charges',
              current: 1,
            ),
          ],
        ),
      );
      final name = _featureTextOperation(
        id: 'feature-name',
        character: saved,
        featureId: fixture.$2.id!,
        field: 'name',
        value: 'New name',
      );
      final description = _featureTextOperation(
        id: 'feature-description',
        character: saved,
        featureId: fixture.$2.id!,
        field: 'description',
        value: 'New description',
      );

      await _sync(endpoints, session, name);
      await _sync(endpoints, session, description);
      final merged = await endpoints.characterData.getCharacter(
        session,
        saved.id!,
      );
      expect(merged.featureOverrides!.single.name, 'New name');
      expect(merged.featureOverrides!.single.description, 'New description');

      final featureTarget =
          'featureOverride:classFeature:${fixture.$2.id}:name';
      final resourceTarget = 'resource:classFeature:${fixture.$2.id}:charges';
      final featureRevision = merged.syncTargetRevisions![featureTarget];
      final resourceRevision = merged.syncTargetRevisions![resourceTarget];
      final removeClass = CharacterSyncOperationData(
        id: 'remove-feature-source',
        characterId: merged.id,
        localCharacterId: merged.id,
        type: CharacterSyncOperationType.removeListItem,
        targetType: CharacterSyncTargetType.listItem,
        targetId: 'class-entry',
        fieldPath: 'classEntries',
        baseCharacterRevision: merged.version,
        baseTargetRevision:
            _itemBaseRevision(merged, 'classEntries', 'class-entry'),
        createdAt: DateTime.utc(2026, 9, 14),
      );

      await _sync(endpoints, session, removeClass);
      final pruned = await endpoints.characterData.getCharacter(
        session,
        saved.id!,
      );

      expect(pruned.featureOverrides, isEmpty);
      expect(pruned.resourceStates, isEmpty);
      expect(pruned.syncTargetRevisions![featureTarget],
          greaterThan(featureRevision!));
      expect(
        pruned.syncTargetRevisions![resourceTarget],
        greaterThan(resourceRevision!),
      );
    });

    test('rejects a second UUID for the same logical choice slot', () async {
      final session = authenticatedSession(306);
      final saved = await endpoints.characterData.saveCharacter(
        session,
        CharacterData(
          name: 'Choice identity',
          choices: [
            CharacterChoiceData(
              id: 'choice-a',
              sourceType: ChoiceSourceType.race,
              sourceId: 7,
              groupKey: 'language',
              optionKey: 'common',
              selectionIndex: 0,
            ),
          ],
        ),
      );
      final duplicate = CharacterSyncOperationData(
        id: 'duplicate-choice',
        characterId: saved.id,
        localCharacterId: saved.id,
        type: CharacterSyncOperationType.upsertListItem,
        targetType: CharacterSyncTargetType.listItem,
        targetId: 'choice-b',
        fieldPath: 'choices',
        itemPayload: CharacterSyncValueData(
          choiceValue: CharacterChoiceData(
            id: 'choice-b',
            sourceType: ChoiceSourceType.race,
            sourceId: 7,
            groupKey: 'language',
            optionKey: 'elvish',
            selectionIndex: 0,
          ),
        ),
        baseCharacterRevision: saved.version,
        baseTargetRevision: saved.version,
        createdAt: DateTime.utc(2026, 9, 14),
      );

      final response = await _sync(endpoints, session, duplicate);

      expect(response.rejectedChanges, hasLength(1));
      expect(response.rejectedChanges!.single.reason, 'invalid_operation');
      final current = await endpoints.characterData.getCharacter(
        session,
        saved.id!,
      );
      expect(current.choices, hasLength(1));
      expect(current.choices!.single.id, 'choice-a');
    });
  });
}

Future<(ClassData, ClassFeatureData)> _seedFeatureFixture(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints,
) async {
  final classData = await endpoints.classData.upsert(
    sessionBuilder,
    ClassData(name: 'Fine target class', hitDieValue: 8),
  );
  final feature = await endpoints.classFeatureData.upsert(
    sessionBuilder,
    ClassFeatureData(
      parentClassId: classData.id!,
      name: 'Canonical feature',
      description: 'Canonical description',
      level: 1,
      tags: const [FeatureTag.combat],
    ),
  );
  final session = sessionBuilder.build();
  try {
    await FeatureResourceDefinitionData.db.insertRow(
      session,
      FeatureResourceDefinitionData(
        classFeatureId: feature.id!,
        key: 'charges',
        name: 'Charges',
        kind: FeatureResourceKind.uses,
        maxRule: FeatureResourceMaxRule.fixed,
        maxValue: 3,
      ),
    );
  } finally {
    await session.close();
  }
  return (classData, feature);
}

Future<CharacterSyncResponse> _sync(
  TestEndpoints endpoints,
  TestSessionBuilder session,
  CharacterSyncOperationData operation,
) {
  return endpoints.characterData.syncCharacters(
    session,
    CharacterSyncRequest(
      operations: [operation],
      syncProtocolVersion: _protocolVersion,
    ),
  );
}

CharacterSyncOperationData _setMemberOperation({
  required String id,
  required CharacterData character,
  required String field,
  required String member,
  required bool add,
  CharacterSyncValueData? value,
}) {
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: add
        ? CharacterSyncOperationType.addSetMember
        : CharacterSyncOperationType.removeSetMember,
    targetType: CharacterSyncTargetType.member,
    targetId: member,
    fieldPath: field,
    value: value,
    baseCharacterRevision: character.version,
    baseTargetRevision: _memberBaseRevision(
      character,
      field,
      member,
      field,
    ),
    createdAt: DateTime.utc(2026, 9, 14),
  );
}

CharacterSyncOperationData _startingResolutionOperation({
  required String id,
  required CharacterData character,
  required String selectionId,
  required int sourceLineEntryId,
  required CharacterStartingEquipmentResolutionData payload,
}) {
  final targetKey =
      'startingEquipmentResolution:${_encodeTargetPart(selectionId)}:'
      '$sourceLineEntryId';
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: CharacterSyncOperationType.upsertListItem,
    targetType: CharacterSyncTargetType.startingEquipmentResolution,
    targetId: '${_encodeTargetPart(selectionId)}:$sourceLineEntryId',
    fieldPath: 'startingEquipmentSelections',
    itemPayload: CharacterSyncValueData(
      startingEquipmentResolutionValue: payload,
    ),
    baseCharacterRevision: character.version,
    baseTargetRevision:
        character.syncTargetRevisions?[targetKey] ?? character.version,
    createdAt: DateTime.utc(2026, 9, 14),
  );
}

CharacterSyncOperationData _featureTextOperation({
  required String id,
  required CharacterData character,
  required int featureId,
  required String field,
  required String value,
}) {
  final targetId = 'classFeature:$featureId:$field';
  final targetKey = 'featureOverride:$targetId';
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: CharacterSyncOperationType.setMemberValue,
    targetType: CharacterSyncTargetType.member,
    targetId: targetId,
    fieldPath: 'featureOverrides',
    value: CharacterSyncValueData(stringValue: value),
    baseCharacterRevision: character.version,
    baseTargetRevision: character.syncTargetRevisions?[targetKey] ??
        character.syncTargetRevisions?['memberBaseline:featureOverrides'] ??
        character.version,
    createdAt: DateTime.utc(2026, 9, 14),
  );
}

int? _itemBaseRevision(
  CharacterData character,
  String field,
  String itemId,
) {
  return character
          .syncTargetRevisions?['item:$field:${_encodeTargetPart(itemId)}'] ??
      character.version;
}

String _encodeTargetPart(String value) {
  return value.replaceAll('%', '%25').replaceAll(':', '%3A');
}

CharacterSyncOperationData _conditionOperation({
  required String id,
  required CharacterData character,
  required ConditionType condition,
  required bool add,
}) {
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: add
        ? CharacterSyncOperationType.addSetMember
        : CharacterSyncOperationType.removeSetMember,
    targetType: CharacterSyncTargetType.member,
    targetId: condition.name,
    fieldPath: 'activeConditions',
    value: add ? CharacterSyncValueData(conditionValue: condition) : null,
    baseCharacterRevision: character.version,
    baseTargetRevision: _memberBaseRevision(
      character,
      'activeConditions',
      condition.name,
      'activeConditions',
    ),
    createdAt: DateTime.utc(2026, 9, 14),
  );
}

CharacterSyncOperationData _memberValueOperation({
  required String id,
  required CharacterData character,
  required String field,
  required String member,
  required String legacyField,
  required CharacterSyncValueData value,
}) {
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: CharacterSyncOperationType.setMemberValue,
    targetType: CharacterSyncTargetType.member,
    targetId: member,
    fieldPath: field,
    value: value,
    baseCharacterRevision: character.version,
    baseTargetRevision: _memberBaseRevision(
      character,
      field,
      member,
      legacyField,
    ),
    createdAt: DateTime.utc(2026, 9, 14),
  );
}

CharacterSyncOperationData _coarseConditionsOperation({
  required String id,
  required CharacterData character,
  required List<ConditionType> conditions,
}) {
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: CharacterSyncOperationType.setField,
    targetType: CharacterSyncTargetType.field,
    targetId: 'activeConditions',
    fieldPath: 'activeConditions',
    value: CharacterSyncValueData(conditionListValue: conditions),
    baseCharacterRevision: character.version,
    baseTargetRevision:
        character.syncTargetRevisions?['field:activeConditions'] ??
            character.version,
    createdAt: DateTime.utc(2026, 9, 14),
  );
}

int? _memberBaseRevision(
  CharacterData character,
  String field,
  String member,
  String legacyField,
) {
  return character.syncTargetRevisions?['member:$field:$member'] ??
      character.syncTargetRevisions?['memberBaseline:$field'] ??
      character.syncTargetRevisions?['field:$legacyField'] ??
      character.version;
}
