import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Atomic feature spell recovery', (sessions, endpoints) {
    final owner = sessions.copyWith(
        authentication:
            AuthenticationOverride.authenticationInfo(9514, <Scope>{}));
    setUp(CharacterSaveRateLimiter.resetForTests);

    Future<(CharacterData, SpellData)> fixture(
        {RestType reset = RestType.dawn}) async {
      final db = sessions.build();
      try {
        final wizard = await ClassData.db.insertRow(
            db,
            ClassData(
                name: 'Recovery caster',
                referenceKey: 'recovery_caster_fixture',
                hitDieValue: 6,
                spellcastingProgression: SpellcastingProgression.full,
                spellcastingAbilityValue: Ability.intelligence));
        final pact = await ClassData.db.insertRow(
            db,
            ClassData(
                name: 'Recovery pact',
                referenceKey: 'recovery_pact_fixture',
                hitDieValue: 8,
                spellcastingProgression: SpellcastingProgression.pactMagic,
                spellcastingAbilityValue: Ability.charisma));
        await endpoints.spellSlotProgressionData.upsert(
            sessions,
            SpellSlotProgressionData(
                tableKey: 'standard',
                level: 5,
                spellSlots: {1: 4, 2: 3, 3: 2, 5: 1, 6: 1}));
        await endpoints.spellSlotProgressionData.upsert(
            sessions,
            SpellSlotProgressionData(
                tableKey: 'pact_magic', level: 5, spellSlots: {3: 2}));
        for (final mode in SpellSlotRecoveryMode.values) {
          final isPact = mode == SpellSlotRecoveryMode.all;
          final feature = await ClassFeatureData.db.insertRow(
              db,
              ClassFeatureData(
                  parentClassId: isPact ? pact.id! : wizard.id!,
                  level: 1,
                  name: mode.name,
                  referenceKey: 'recovery_fixture_${mode.name}'));
          final key =
              mode == SpellSlotRecoveryMode.singleLowerLevel ? null : mode.name;
          if (key != null) {
            await FeatureResourceDefinitionData.db.insertRow(
                db,
                FeatureResourceDefinitionData(
                    classFeatureId: feature.id,
                    key: key,
                    kind: FeatureResourceKind.uses,
                    maxRule: FeatureResourceMaxRule.fixed,
                    maxValue: 1,
                    resetOn: isPact ? RestType.longRest : reset));
          }
          await FeatureResourceEffectData.db.insertRow(
              db,
              FeatureResourceEffectData(
                  classFeatureId: feature.id,
                  type: FeatureResourceEffectType.restore,
                  targetType: isPact
                      ? FeatureResourceTargetType.pactSlots
                      : FeatureResourceTargetType.spellSlots,
                  activationTrigger: switch (mode) {
                    SpellSlotRecoveryMode.levelBudget =>
                      FeatureResourceTrigger.shortRest,
                    SpellSlotRecoveryMode.singleLowerLevel =>
                      FeatureResourceTrigger.spellCast,
                    SpellSlotRecoveryMode.all => FeatureResourceTrigger.manual,
                  },
                  recoveryPolicy: SpellSlotRecoveryPolicyData(
                      mode: mode,
                      resourceKey: key,
                      levelBudgetBySourceLevel: {
                        for (var n = 1; n <= 20; n++) n: (n + 1) ~/ 2
                      },
                      maximumSlotLevel: isPact ? 9 : 5,
                      minimumCastLevel:
                          mode == SpellSlotRecoveryMode.singleLowerLevel
                              ? 2
                              : null,
                      spellSchool:
                          mode == SpellSlotRecoveryMode.singleLowerLevel
                              ? SpellSchool.divination
                              : null,
                      activationSeconds: isPact ? 60 : null)));
        }
        final spell = await SpellData.db.insertRow(
            db,
            SpellData(
                referenceKey: 'recovery_divination_fixture',
                name: 'Recovery divination',
                level: 2,
                schoolValue: SpellSchool.divination));
        await ClassSpellGrantData.db.insertRow(
            db,
            ClassSpellGrantData(
                spellId: spell.id,
                sourceClassId: wizard.id,
                grantedAtLevel: 1,
                alwaysPrepared: true));
        final c = await endpoints.characterData.saveCharacter(
            owner,
            CharacterData(name: 'Recovery fixture', currentSpellSlots: {
              1: 1,
              2: 1,
              3: 1,
              5: 0,
              6: 0
            }, currentPactSlots: {
              3: 0
            }, classEntries: [
              CharacterClassEntryData(
                  id: 'caster',
                  classData: wizard,
                  level: 5,
                  isStartingClass: true),
              CharacterClassEntryData(
                  id: 'pact', classData: pact, level: 5, classOrder: 1),
            ]));
        return (c, spell);
      } finally {
        await db.close();
      }
    }

    SpellSlotRecoverySource source(CharacterData c, String mode) =>
        characterSpellSlotRecoverySources(c.toJson())
            .singleWhere((s) => s.mode == mode);

    CharacterSemanticActionData recovery(
        CharacterData c, String mode, Map<int, int> slots) {
      final s = source(c, mode);
      return CharacterSemanticActionData(
          sourceType: CharacterFeatureSourceType.values.byName(s.sourceType),
          sourceId: s.sourceId,
          recoveryEffectId: s.effectId,
          resourceKey: s.resourceKey,
          slotSource: s.slotSource.name,
          slotsToRestore: slots,
          recoveryTriggerId: spellSlotRecoveryTriggers(c.toJson())[s.key]
              ?['sourceActionId'] as String?);
    }

    CharacterSyncOperationData operation(
        CharacterData c,
        CharacterSyncOperationType type,
        CharacterSemanticActionData action,
        String id) {
      final targets = <String>{
        ...?c.syncTargetRevisions?.keys,
        ...?c.syncBarrierTokens?.keys,
        'field:spellRecoveryTriggers',
        'field:currentHp',
        'field:temporaryHp',
        'field:deathSaveSuccesses',
        'field:deathSaveFailures',
        for (final n in {
          ...?c.derived?.spellSlots?.keys,
          ...?c.currentSpellSlots?.keys
        })
          'map:currentSpellSlots:$n',
        for (final n in {
          ...?c.derived?.pactSlots?.keys,
          ...?c.currentPactSlots?.keys
        })
          'map:currentPactSlots:$n',
        for (final n in {
          ...?c.derived?.hitDiceSummary?.keys,
          ...?c.currentHitDice?.keys
        })
          'map:currentHitDice:$n',
        for (final f
            in c.derived?.activeFeatures ?? <CharacterFeatureViewData>[])
          for (final r in f.resources ?? <CharacterResourceViewData>[])
            'resource:${f.sourceType.name}:${f.sourceId}:${r.key}',
      };
      return CharacterSyncOperationData(
          id: id,
          characterId: c.id,
          localCharacterId: c.id,
          type: type,
          targetType: CharacterSyncTargetType.field,
          baseCharacterRevision: c.version,
          value: CharacterSyncValueData(
              semanticActionValue: action.copyWith(baseBarrierTokens: {
            for (final t in targets)
              t: c.syncBarrierTokens?[t] ??
                  'revision:${c.syncTargetRevisions?[t] ?? 0}',
          })),
          createdAt: DateTime.utc(2026, 10, 7));
    }

    Future<CharacterData> apply(
        CharacterData c,
        CharacterSyncOperationType type,
        CharacterSemanticActionData action,
        String id) async {
      final op = operation(c, type, action, id);
      final response = await endpoints.characterData.syncCharacters(owner,
          CharacterSyncRequest(syncProtocolVersion: 5, operations: [op]));
      expect(response.rejectedChanges ?? [], isEmpty);
      final after = await endpoints.characterData.getCharacter(owner, c.id!);
      final path = Platform.environment['FEATURE_COMPLETION_REPLAY_SNAPSHOTS'];
      if (path != null) {
        await File(path).writeAsString(
            '${jsonEncode({
                  'before': c.toJson(),
                  'operation': op.toJson(),
                  'after': after.toJson()
                })}\n',
            mode: FileMode.append);
      }
      return after;
    }

    Future<void> reject(CharacterData c, CharacterSemanticActionData action,
        String reason, String id) async {
      final response = await endpoints.characterData.syncCharacters(
          owner,
          CharacterSyncRequest(syncProtocolVersion: 5, operations: [
            operation(
                c, CharacterSyncOperationType.recoverSpellSlots, action, id)
          ]));
      expect(response.rejectedChanges!.single.reason, reason);
      final after = await endpoints.characterData.getCharacter(owner, c.id!);
      expect(after.currentSpellSlots, c.currentSpellSlots);
      expect(after.resourceStates?.map((s) => s.toJson()).toList(),
          c.resourceStates?.map((s) => s.toJson()).toList());
    }

    for (final reset in [RestType.dawn, RestType.longRest]) {
      test('budget, atomic use and executable reset ${reset.name}', () async {
        final (base, _) = await fixture(reset: reset);
        await reject(base, recovery(base, 'levelBudget', {1: 1}),
            'invalid_trigger', 'no-rest');
        final rested = await apply(
            base,
            CharacterSyncOperationType.applyRest,
            CharacterSemanticActionData(restType: RestType.shortRest),
            'short-rest');
        expect(source(rested, 'levelBudget').budget, 3);
        for (final selection in [
          {2: 2},
          {6: 1},
          {1: 4},
          {5: 1}
        ]) {
          await reject(
              rested,
              recovery(rested, 'levelBudget', selection),
              'resource_bounds',
              'invalid-${selection.keys.first}-${selection.values.first}');
        }
        final used = await apply(
            rested,
            CharacterSyncOperationType.recoverSpellSlots,
            recovery(rested, 'levelBudget', {1: 1, 2: 1}),
            'budget-use');
        expect(used.currentSpellSlots, {1: 2, 2: 2, 3: 1, 5: 0, 6: 0});
        expect(used.currentPactSlots, {3: 2});
        expect(source(used, 'levelBudget').resources.single['current'], 0);
        final anotherRest = await apply(
            used,
            CharacterSyncOperationType.applyRest,
            CharacterSemanticActionData(restType: RestType.shortRest),
            'another-short-rest');
        expect(
            spellSlotRecoveryOptions(
                anotherRest.toJson(), source(anotherRest, 'levelBudget')),
            isEmpty);
        final resetCharacter = await apply(
            anotherRest,
            CharacterSyncOperationType.applyRest,
            CharacterSemanticActionData(restType: reset),
            'reset-use');
        expect(
            source(resetCharacter, 'levelBudget').resources.single['current'],
            1);
        if (reset == RestType.dawn) {
          expect(resetCharacter.currentSpellSlots, used.currentSpellSlots);
        }
      });
    }

    test(
        'Expert Divination requires a successful actual cast and one lower slot',
        () async {
      final (base, spell) = await fixture();
      final caster = base.classEntries!
          .singleWhere((e) => e.isStartingClass == true)
          .classData!;
      final cast = await apply(
          base,
          CharacterSyncOperationType.castSpell,
          CharacterSemanticActionData(
              spellKey: spell.referenceKey,
              spellSourceKey: 'class:${caster.id}',
              slotSource: 'standard',
              level: 3),
          'divination-cast');
      final s = source(cast, 'singleLowerLevel');
      expect(spellSlotRecoveryOptions(cast.toJson(), s).keys, [1, 2]);
      await reject(cast, recovery(cast, 'singleLowerLevel', {3: 1}),
          'resource_bounds', 'equal-level');
      await reject(cast, recovery(cast, 'singleLowerLevel', {1: 2}),
          'invalid_action', 'two-slots');
      final recovered = await apply(
          cast,
          CharacterSyncOperationType.recoverSpellSlots,
          recovery(cast, 'singleLowerLevel', {2: 1}),
          'divination-recovery');
      expect(recovered.currentSpellSlots?[2], 2);
      expect(spellSlotRecoveryTriggers(recovered.toJson()), isEmpty);
    });

    test('Eldritch Master restores only pact and spends exactly one use',
        () async {
      final (base, _) = await fixture();
      final after = await apply(
          base,
          CharacterSyncOperationType.recoverSpellSlots,
          recovery(base, 'all', {}),
          'master-use');
      expect(after.currentPactSlots, {3: 2});
      expect(after.currentSpellSlots, base.currentSpellSlots);
      expect(source(after, 'all').resources.single['current'], 0);
      final spent = await apply(
          after,
          CharacterSyncOperationType.adjustSpellSlots,
          CharacterSemanticActionData(slotSource: 'pact', level: 3, delta: -1),
          'pact-spend');
      await reject(spent, recovery(spent, 'all', {}), 'resource_bounds',
          'master-exhausted');
    });

    test('concurrent recoveries cannot reuse one event or spend twice',
        () async {
      final (base, _) = await fixture();
      final rested = await apply(
          base,
          CharacterSyncOperationType.applyRest,
          CharacterSemanticActionData(restType: RestType.shortRest),
          'race-rest');
      final response = await endpoints.characterData.syncCharacters(
          owner,
          CharacterSyncRequest(syncProtocolVersion: 5, operations: [
            operation(rested, CharacterSyncOperationType.recoverSpellSlots,
                recovery(rested, 'levelBudget', {1: 1}), 'race-first'),
            operation(rested, CharacterSyncOperationType.recoverSpellSlots,
                recovery(rested, 'levelBudget', {2: 1}), 'race-second'),
          ]));
      expect(response.rejectedChanges!.single.reason, 'crossed_barrier');
      final after = await endpoints.characterData.getCharacter(owner, base.id!);
      expect(after.currentSpellSlots?[1], 2);
      expect(after.currentSpellSlots?[2], 1);
      expect(source(after, 'levelBudget').resources.single['current'], 0);
    });
  });
}
