import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _protocolVersion = 4;

void main() {
  withServerpod('Character semantic sync actions', (
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

    test('serializes HP actions, retries idempotently, and honors barriers',
        () async {
      final session = authenticatedSession(501);
      final fixture = await _seedFixture(
        sessionBuilder,
        endpoints,
        session,
        initial: CharacterData(
          currentHp: 20,
          temporaryHp: 3,
          deathSaveSuccesses: 2,
          deathSaveFailures: 1,
          hpFlatBonus: 30,
        ),
      );
      final base = fixture.character;
      final damageEight = _semanticOperation(
        id: 'damage-eight',
        character: base,
        type: CharacterSyncOperationType.applyDamage,
        action: CharacterSemanticActionData(amount: 8),
        targets: const ['field:currentHp', 'field:temporaryHp'],
      );
      final damageFive = _semanticOperation(
        id: 'damage-five',
        character: base,
        type: CharacterSyncOperationType.applyDamage,
        action: CharacterSemanticActionData(amount: 5),
        targets: const ['field:currentHp', 'field:temporaryHp'],
      );

      final first = await _sync(endpoints, session, damageEight);
      final second = await _sync(endpoints, session, damageFive);
      final retry = await _sync(endpoints, session, damageFive);
      final afterDamage = await _get(endpoints, session, base.id!);

      expect(first.acknowledgedChangeIds, contains(damageEight.id));
      expect(second.acknowledgedChangeIds, contains(damageFive.id));
      expect(retry.acknowledgedChangeIds, contains(damageFive.id));
      expect(afterDamage.temporaryHp, isNull);
      expect(afterDamage.currentHp, 10);
      expect(afterDamage.syncTargetRevisions!['field:temporaryHp'],
          greaterThan(base.version!));
      expect(afterDamage.syncTargetRevisions!['field:currentHp'],
          greaterThan(base.version!));

      final heal = _semanticOperation(
        id: 'heal-five',
        character: base,
        type: CharacterSyncOperationType.heal,
        action: CharacterSemanticActionData(amount: 5),
        targets: const [
          'field:currentHp',
          'field:deathSaveSuccesses',
          'field:deathSaveFailures',
        ],
      );
      await _sync(endpoints, session, heal);
      final afterHeal = await _get(endpoints, session, base.id!);
      expect(afterHeal.currentHp, 15);
      expect(afterHeal.deathSaveSuccesses, isNull);
      expect(afterHeal.deathSaveFailures, isNull);

      final staleDamage = _semanticOperation(
        id: 'stale-damage',
        character: afterHeal,
        type: CharacterSyncOperationType.applyDamage,
        action: CharacterSemanticActionData(amount: 2),
        targets: const ['field:currentHp', 'field:temporaryHp'],
      );
      await _sync(
        endpoints,
        session,
        _absoluteField(
          id: 'manual-hp',
          character: afterHeal,
          field: 'currentHp',
          value: 40,
        ),
      );
      final rejected = await _sync(endpoints, session, staleDamage);
      final invalid = await _sync(
        endpoints,
        session,
        _semanticOperation(
          id: 'invalid-damage',
          character: await _get(endpoints, session, base.id!),
          type: CharacterSyncOperationType.applyDamage,
          action: CharacterSemanticActionData(amount: -1),
          targets: const ['field:currentHp', 'field:temporaryHp'],
        ),
      );

      expect(rejected.rejectedChanges!.single.reason, 'crossed_barrier');
      expect(invalid.rejectedChanges!.single.reason, 'invalid_action');
      expect((await _get(endpoints, session, base.id!)).currentHp, 40);
    });

    test('serializes slot spends and applies cast atomically', () async {
      final session = authenticatedSession(502);
      final fixture = await _seedFixture(sessionBuilder, endpoints, session);
      final base = fixture.character;
      expect(base.derived?.spellSlots?[1], 2);

      final spendA = _slotOperation('slot-a', base, -1);
      final spendB = _slotOperation('slot-b', base, -1);
      await _sync(endpoints, session, spendA);
      await _sync(endpoints, session, spendB);
      final empty = await _get(endpoints, session, base.id!);
      expect(empty.currentSpellSlots?[1], 0);

      final insufficient = await _sync(
        endpoints,
        session,
        _slotOperation('slot-c', base, -1),
      );
      expect(
        insufficient.rejectedChanges!.single.reason,
        'insufficient_resource',
      );

      final restore = _slotOperation('slot-restore', empty, 1);
      await _sync(endpoints, session, restore);
      final restored = await _get(endpoints, session, base.id!);
      expect(restored.currentSpellSlots?[1], 1);

      final staleSpend = _slotOperation('stale-slot-spend', restored, -1);
      await _sync(
        endpoints,
        session,
        _absoluteMap(
          id: 'manual-slot',
          character: restored,
          field: 'currentSpellSlots',
          key: '1',
          value: 2,
        ),
      );
      final barrier = await _sync(endpoints, session, staleSpend);
      expect(barrier.rejectedChanges!.single.reason, 'crossed_barrier');

      final castBase = await _get(endpoints, session, base.id!);
      final cast = _semanticOperation(
        id: 'cast-concentration',
        character: castBase,
        type: CharacterSyncOperationType.castSpell,
        action: CharacterSemanticActionData(
          level: 1,
          spellName: 'Bless',
          startsConcentration: true,
        ),
        targets: const [
          'map:currentSpellSlots:1',
          'field:activeConcentrationSpellName',
        ],
      );
      await _sync(endpoints, session, cast);
      final casted = await _get(endpoints, session, base.id!);
      expect(casted.currentSpellSlots?[1], 1);
      expect(casted.activeConcentrationSpellName, 'Bless');
      expect(casted.syncTargetRevisions!['map:currentSpellSlots:1'],
          casted.version);
      expect(
        casted.syncTargetRevisions!['field:activeConcentrationSpellName'],
        casted.version,
      );

      await _sync(endpoints, session, _slotOperation('last-slot', casted, -1));
      final noSlots = await _get(endpoints, session, base.id!);
      final failedCast = await _sync(
        endpoints,
        session,
        _semanticOperation(
          id: 'failed-cast',
          character: noSlots,
          type: CharacterSyncOperationType.castSpell,
          action: CharacterSemanticActionData(
            level: 1,
            spellName: 'Haste',
            startsConcentration: true,
          ),
          targets: const [
            'map:currentSpellSlots:1',
            'field:activeConcentrationSpellName',
          ],
        ),
      );
      final afterFailedCast = await _get(endpoints, session, base.id!);
      expect(
          failedCast.rejectedChanges!.single.reason, 'insufficient_resource');
      expect(afterFailedCast.currentSpellSlots?[1], 0);
      expect(afterFailedCast.activeConcentrationSpellName, 'Bless');
    });

    test('serializes hit dice and experience by their domain targets',
        () async {
      final session = authenticatedSession(503);
      final fixture = await _seedFixture(sessionBuilder, endpoints, session);
      final base = fixture.character;
      expect(base.derived?.hitDiceSummary, const {'d6': 2, 'd8': 2});

      final d8A = _hitDieOperation('d8-a', base, 'd8', -1);
      final d8B = _hitDieOperation('d8-b', base, 'd8', -1);
      final d6 = _hitDieOperation('d6-a', base, 'd6', -1);
      await _sync(endpoints, session, d8A);
      await _sync(endpoints, session, d8B);
      await _sync(endpoints, session, d6);
      final spent = await _get(endpoints, session, base.id!);
      expect(spent.currentHitDice, const {'d6': 1, 'd8': 0});
      final insufficient = await _sync(
        endpoints,
        session,
        _hitDieOperation('d8-c', base, 'd8', -1),
      );
      expect(
          insufficient.rejectedChanges!.single.reason, 'insufficient_resource');

      final staleDie = _hitDieOperation('stale-die', spent, 'd6', -1);
      await _sync(
        endpoints,
        session,
        _absoluteMap(
          id: 'manual-die',
          character: spent,
          field: 'currentHitDice',
          key: 'd6',
          value: 2,
        ),
      );
      expect(
        (await _sync(endpoints, session, staleDie))
            .rejectedChanges!
            .single
            .reason,
        'crossed_barrier',
      );

      final xpBase = await _get(endpoints, session, base.id!);
      final awardA = _experienceOperation('xp-a', xpBase, 100);
      final awardB = _experienceOperation('xp-b', xpBase, 50);
      await _sync(endpoints, session, awardA);
      await _sync(endpoints, session, awardB);
      final awarded = await _get(endpoints, session, base.id!);
      expect(awarded.experience, 150);
      await _sync(
        endpoints,
        session,
        _experienceOperation('xp-remove', awarded, -25),
      );
      final adjusted = await _get(endpoints, session, base.id!);
      expect(adjusted.experience, 125);

      await _sync(
        endpoints,
        session,
        _experienceOperation('xp-zero', adjusted, -125),
      );
      final zeroExperience = await _get(endpoints, session, base.id!);
      expect(zeroExperience.experience, 0);

      final staleAward =
          _experienceOperation('stale-award', zeroExperience, 10);
      await _sync(
        endpoints,
        session,
        _absoluteField(
          id: 'manual-xp',
          character: zeroExperience,
          field: 'experience',
          value: 1200,
        ),
      );
      expect(
        (await _sync(endpoints, session, staleAward))
            .rejectedChanges!
            .single
            .reason,
        'crossed_barrier',
      );
      expect((await _get(endpoints, session, base.id!)).experience, 1200);
    });

    test('validates finite resources against canonical derived state',
        () async {
      final session = authenticatedSession(504);
      final fixture = await _seedFixture(
        sessionBuilder,
        endpoints,
        session,
      );
      var base = fixture.character;
      base = await endpoints.characterData.saveCharacter(
        session,
        base.copyWith(
          resourceStates: [
            CharacterResourceStateData(
              sourceType: CharacterFeatureSourceType.classFeature,
              sourceId: fixture.feature.id!,
              resourceKey: 'charges',
              current: 1,
            ),
          ],
        ),
      );
      final spendA =
          _resourceOperation('resource-a', base, fixture.feature, -1);
      final spendB =
          _resourceOperation('resource-b', base, fixture.feature, -1);
      await _sync(endpoints, session, spendA);
      final rejected = await _sync(endpoints, session, spendB);
      expect(rejected.rejectedChanges!.single.reason, 'insufficient_resource');

      final empty = await _get(endpoints, session, base.id!);
      await _sync(
        endpoints,
        session,
        _resourceOperation('resource-restore', empty, fixture.feature, 2),
      );
      final restored = await _get(endpoints, session, base.id!);
      expect(_resourceCurrent(restored, fixture.feature.id!), 2);

      final staleSpend =
          _resourceOperation('stale-resource', restored, fixture.feature, -1);
      await _sync(
        endpoints,
        session,
        _absoluteResource(
          id: 'manual-resource',
          character: restored,
          featureId: fixture.feature.id!,
          current: 3,
        ),
      );
      expect(
        (await _sync(endpoints, session, staleSpend))
            .rejectedChanges!
            .single
            .reason,
        'crossed_barrier',
      );

      final current = await _get(endpoints, session, base.id!);
      final missing = await _sync(
        endpoints,
        session,
        _semanticOperation(
          id: 'missing-resource',
          character: current,
          type: CharacterSyncOperationType.adjustResource,
          action: CharacterSemanticActionData(
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: fixture.feature.id!,
            resourceKey: 'deleted',
            delta: -1,
          ),
          targets: [
            'resource:classFeature:${fixture.feature.id}:deleted',
          ],
        ),
      );
      expect(missing.rejectedChanges!.single.reason, 'target_not_found');
    });

    test('long rest is a barrier and protocol v3 cannot submit semantics',
        () async {
      final session = authenticatedSession(505);
      final fixture = await _seedFixture(
        sessionBuilder,
        endpoints,
        session,
        initial: CharacterData(
          currentHp: 5,
          temporaryHp: 4,
          deathSaveSuccesses: 2,
          deathSaveFailures: 1,
          hpFlatBonus: 30,
          currentSpellSlots: const {1: 0},
          currentHitDice: const {'d6': 0, 'd8': 0},
        ),
      );
      final base = fixture.character;
      final staleSpend = _slotOperation('pre-rest-spend', base, -1);
      final restTargets = <String>[
        'field:currentHp',
        'field:temporaryHp',
        'field:deathSaveSuccesses',
        'field:deathSaveFailures',
        'map:currentSpellSlots:1',
        'map:currentHitDice:d6',
        'map:currentHitDice:d8',
        'resource:classFeature:${fixture.feature.id}:charges',
      ];
      final rest = _semanticOperation(
        id: 'long-rest',
        character: base,
        type: CharacterSyncOperationType.applyRest,
        action: CharacterSemanticActionData(restType: RestType.longRest),
        targets: restTargets,
      );
      await _sync(endpoints, session, rest);
      final rested = await _get(endpoints, session, base.id!);

      expect(rested.currentHp, isNull);
      expect(rested.temporaryHp, isNull);
      expect(rested.deathSaveSuccesses, isNull);
      expect(rested.deathSaveFailures, isNull);
      expect(rested.currentSpellSlots, isNull);
      expect(rested.currentHitDice, const {'d6': 0});
      expect(rested.resourceStates, isEmpty);
      for (final target in restTargets) {
        expect(rested.syncBarrierTokens?[target], rest.id);
      }
      expect(
        (await _sync(endpoints, session, staleSpend))
            .rejectedChanges!
            .single
            .reason,
        'crossed_barrier',
      );

      final invalidRest = _semanticOperation(
        id: 'invalid-rest',
        character: rested,
        type: CharacterSyncOperationType.applyRest,
        action: CharacterSemanticActionData(restType: RestType.special),
        targets: const [],
      );
      final invalidResponse = await _sync(endpoints, session, invalidRest);
      final afterInvalid = await _get(endpoints, session, base.id!);
      expect(invalidResponse.rejectedChanges!.single.reason, 'invalid_action');
      expect(afterInvalid.version, rested.version);
      expect(afterInvalid.currentHp, rested.currentHp);
      expect(afterInvalid.temporaryHp, rested.temporaryHp);
      expect(afterInvalid.currentSpellSlots, rested.currentSpellSlots);
      expect(afterInvalid.currentHitDice, rested.currentHitDice);
      expect(afterInvalid.resourceStates, rested.resourceStates);
      expect(afterInvalid.syncBarrierTokens, rested.syncBarrierTokens);

      final oldProtocol = await endpoints.characterData.syncCharacters(
        session,
        CharacterSyncRequest(
          operations: [
            _experienceOperation('old-protocol-xp', afterInvalid, 10),
          ],
          syncProtocolVersion: 3,
        ),
      );
      expect(oldProtocol.syncProtocolVersion, _protocolVersion);
      expect(oldProtocol.capabilities, contains('semantic_counter_actions'));
      expect(
        oldProtocol.rejectedChanges!.single.reason,
        'unsupported_sync_protocol',
      );
    });

    test('rolls back every rest target when sync event insertion fails',
        () async {
      final session = authenticatedSession(506);
      final fixture = await _seedFixture(
        sessionBuilder,
        endpoints,
        session,
        initial: CharacterData(
          currentHp: 5,
          temporaryHp: 4,
          currentSpellSlots: const {1: 0},
          currentHitDice: const {'d6': 0, 'd8': 0},
          hpFlatBonus: 30,
        ),
      );
      final base = fixture.character;
      final dbSession = sessionBuilder.build();
      try {
        await dbSession.db.unsafeQuery(r'''
CREATE OR REPLACE FUNCTION cm_test_fail_rest_event()
RETURNS trigger AS $$
BEGIN
  IF NEW."changeId" = 'rollback-rest' THEN
    RAISE EXCEPTION 'injected rest event failure';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql
''');
        await dbSession.db.unsafeQuery(r'''
CREATE TRIGGER cm_test_fail_rest_event_trigger
BEFORE INSERT ON character_sync_events
FOR EACH ROW EXECUTE FUNCTION cm_test_fail_rest_event()
''');

        final response = await _sync(
          endpoints,
          session,
          _semanticOperation(
            id: 'rollback-rest',
            character: base,
            type: CharacterSyncOperationType.applyRest,
            action: CharacterSemanticActionData(restType: RestType.longRest),
            targets: [
              'field:currentHp',
              'field:temporaryHp',
              'field:deathSaveSuccesses',
              'field:deathSaveFailures',
              'map:currentSpellSlots:1',
              'map:currentHitDice:d6',
              'map:currentHitDice:d8',
              'resource:classFeature:${fixture.feature.id}:charges',
            ],
          ),
        );
        final afterFailure = await _get(endpoints, session, base.id!);

        expect(response.acknowledgedChangeIds, isEmpty);
        expect(response.rejectedChanges!.single.reason, 'invalid_operation');
        expect(afterFailure.version, base.version);
        expect(afterFailure.currentHp, base.currentHp);
        expect(afterFailure.temporaryHp, base.temporaryHp);
        expect(afterFailure.currentSpellSlots, base.currentSpellSlots);
        expect(afterFailure.currentHitDice, base.currentHitDice);
        expect(afterFailure.syncBarrierTokens, base.syncBarrierTokens);
      } finally {
        await dbSession.db.unsafeQuery('''
DROP TRIGGER IF EXISTS cm_test_fail_rest_event_trigger
ON character_sync_events
''');
        await dbSession.db.unsafeQuery(
          'DROP FUNCTION IF EXISTS cm_test_fail_rest_event()',
        );
        await dbSession.close();
      }
    });
  });
}

class _SemanticFixture {
  const _SemanticFixture(this.character, this.feature);

  final CharacterData character;
  final ClassFeatureData feature;
}

Future<_SemanticFixture> _seedFixture(
  TestSessionBuilder referenceSession,
  TestEndpoints endpoints,
  TestSessionBuilder ownerSession, {
  CharacterData? initial,
}) async {
  await endpoints.spellSlotProgressionData.upsert(
    referenceSession,
    SpellSlotProgressionData(
      tableKey: 'standard',
      level: 2,
      spellSlots: const {1: 2},
    ),
  );
  final caster = await endpoints.classData.upsert(
    referenceSession,
    ClassData(
      name: 'Semantic caster',
      hitDieValue: 8,
      spellcastingProgression: SpellcastingProgression.full,
    ),
  );
  final secondary = await endpoints.classData.upsert(
    referenceSession,
    ClassData(name: 'Semantic secondary', hitDieValue: 6),
  );
  final feature = await endpoints.classFeatureData.upsert(
    referenceSession,
    ClassFeatureData(
      parentClassId: caster.id!,
      name: 'Semantic charges',
      level: 1,
    ),
  );
  final dbSession = referenceSession.build();
  try {
    await FeatureResourceDefinitionData.db.insertRow(
      dbSession,
      FeatureResourceDefinitionData(
        classFeatureId: feature.id!,
        key: 'charges',
        name: 'Charges',
        kind: FeatureResourceKind.uses,
        maxRule: FeatureResourceMaxRule.fixed,
        maxValue: 3,
        resetOn: RestType.shortRest,
      ),
    );
  } finally {
    await dbSession.close();
  }
  final character = await endpoints.characterData.saveCharacter(
    ownerSession,
    (initial ?? CharacterData()).copyWith(
      name: 'Semantic fixture',
      classEntries: [
        CharacterClassEntryData(
          id: 'caster-entry',
          classData: caster,
          level: 2,
          isStartingClass: true,
          classOrder: 0,
        ),
        CharacterClassEntryData(
          id: 'secondary-entry',
          classData: secondary,
          level: 2,
          isStartingClass: false,
          classOrder: 1,
        ),
      ],
    ),
  );
  return _SemanticFixture(character, feature);
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

Future<CharacterData> _get(
  TestEndpoints endpoints,
  TestSessionBuilder session,
  int id,
) {
  return endpoints.characterData.getCharacter(session, id);
}

CharacterSyncOperationData _semanticOperation({
  required String id,
  required CharacterData character,
  required CharacterSyncOperationType type,
  required CharacterSemanticActionData action,
  required List<String> targets,
}) {
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: type,
    targetType: switch (type) {
      CharacterSyncOperationType.adjustSpellSlots ||
      CharacterSyncOperationType.adjustHitDice =>
        CharacterSyncTargetType.mapEntry,
      CharacterSyncOperationType.adjustResource =>
        CharacterSyncTargetType.resource,
      CharacterSyncOperationType.applyRest => CharacterSyncTargetType.character,
      _ => CharacterSyncTargetType.field,
    },
    value: CharacterSyncValueData(
      semanticActionValue: action.copyWith(
        baseBarrierTokens: {
          for (final target in targets)
            target: _barrierToken(character, target),
        },
      ),
    ),
    baseCharacterRevision: character.version,
    baseTargetRevision: targets.isEmpty
        ? character.version
        : character.syncTargetRevisions?[targets.first] ?? character.version,
    createdAt: DateTime.utc(2026, 9, 14),
  );
}

CharacterSyncOperationData _slotOperation(
  String id,
  CharacterData character,
  int delta,
) {
  return _semanticOperation(
    id: id,
    character: character,
    type: CharacterSyncOperationType.adjustSpellSlots,
    action: CharacterSemanticActionData(level: 1, delta: delta),
    targets: const ['map:currentSpellSlots:1'],
  );
}

CharacterSyncOperationData _hitDieOperation(
  String id,
  CharacterData character,
  String kind,
  int delta,
) {
  return _semanticOperation(
    id: id,
    character: character,
    type: CharacterSyncOperationType.adjustHitDice,
    action: CharacterSemanticActionData(dieKind: kind, delta: delta),
    targets: ['map:currentHitDice:$kind'],
  );
}

CharacterSyncOperationData _resourceOperation(
  String id,
  CharacterData character,
  ClassFeatureData feature,
  int delta,
) {
  return _semanticOperation(
    id: id,
    character: character,
    type: CharacterSyncOperationType.adjustResource,
    action: CharacterSemanticActionData(
      sourceType: CharacterFeatureSourceType.classFeature,
      sourceId: feature.id!,
      resourceKey: 'charges',
      delta: delta,
    ),
    targets: ['resource:classFeature:${feature.id}:charges'],
  );
}

CharacterSyncOperationData _experienceOperation(
  String id,
  CharacterData character,
  int delta,
) {
  return _semanticOperation(
    id: id,
    character: character,
    type: CharacterSyncOperationType.adjustExperience,
    action: CharacterSemanticActionData(delta: delta),
    targets: const ['field:experience'],
  );
}

CharacterSyncOperationData _absoluteField({
  required String id,
  required CharacterData character,
  required String field,
  required int value,
}) {
  final target = 'field:$field';
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: CharacterSyncOperationType.setField,
    targetType: CharacterSyncTargetType.field,
    targetId: field,
    fieldPath: field,
    value: CharacterSyncValueData(intValue: value),
    baseCharacterRevision: character.version,
    baseTargetRevision:
        character.syncTargetRevisions?[target] ?? character.version,
    createdAt: DateTime.utc(2026, 9, 14),
  );
}

CharacterSyncOperationData _absoluteMap({
  required String id,
  required CharacterData character,
  required String field,
  required String key,
  required int value,
}) {
  final target = 'map:$field:$key';
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: CharacterSyncOperationType.setMapEntry,
    targetType: CharacterSyncTargetType.mapEntry,
    targetId: key,
    fieldPath: field,
    value: CharacterSyncValueData(intValue: value),
    baseCharacterRevision: character.version,
    baseTargetRevision:
        character.syncTargetRevisions?[target] ?? character.version,
    createdAt: DateTime.utc(2026, 9, 14),
  );
}

CharacterSyncOperationData _absoluteResource({
  required String id,
  required CharacterData character,
  required int featureId,
  required int current,
}) {
  final target = 'resource:classFeature:$featureId:charges';
  return CharacterSyncOperationData(
    id: id,
    characterId: character.id,
    localCharacterId: character.id,
    type: CharacterSyncOperationType.upsertListItem,
    targetType: CharacterSyncTargetType.resource,
    targetId: 'classFeature:$featureId:charges',
    fieldPath: 'resourceStates',
    itemPayload: CharacterSyncValueData(
      resourceStateValue: CharacterResourceStateData(
        sourceType: CharacterFeatureSourceType.classFeature,
        sourceId: featureId,
        resourceKey: 'charges',
        current: current,
      ),
    ),
    baseCharacterRevision: character.version,
    baseTargetRevision:
        character.syncTargetRevisions?[target] ?? character.version,
    createdAt: DateTime.utc(2026, 9, 14),
  );
}

String _barrierToken(CharacterData character, String target) {
  return character.syncBarrierTokens?[target] ??
      'revision:${character.syncTargetRevisions?[target] ?? 0}';
}

int? _resourceCurrent(CharacterData character, int featureId) {
  for (final state
      in character.resourceStates ?? const <CharacterResourceStateData>[]) {
    if (state.sourceType == CharacterFeatureSourceType.classFeature &&
        state.sourceId == featureId &&
        state.resourceKey == 'charges') {
      return state.current;
    }
  }
  return character.derived?.activeFeatures
      ?.expand(
          (feature) => feature.resources ?? const <CharacterResourceViewData>[])
      .where((resource) => resource.key == 'charges')
      .firstOrNull
      ?.current;
}
