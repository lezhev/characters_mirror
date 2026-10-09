import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_semantic_sync.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_operation_replay.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart'
    as shared;
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> runtime(CharacterData c) => {
      'standard': c.currentSpellSlots,
      'pact': c.currentPactSlots,
      'resources': [
        for (final s in c.resourceStates ?? <CharacterResourceStateData>[])
          s.toJson()
      ],
      'triggers': shared.spellSlotRecoveryTriggers(c.toJson()),
      'hitDice': c.currentHitDice,
      'hp': c.currentHp,
      'temporaryHp': c.temporaryHp,
    };

void main() {
  test('replay uses generated protocol maps and resets sparse resources', () {
    final feature = CharacterFeatureViewData(
        sourceType: CharacterFeatureSourceType.classFeature,
        sourceId: 41,
        sourceClassLevel: 5,
        resources: [
          CharacterResourceViewData(
              key: 'recovery',
              kind: FeatureResourceKind.uses,
              current: 0,
              max: 1,
              resetOn: RestType.dawn)
        ],
        spellSlotRecoveryEffects: [
          FeatureResourceEffectData(
              id: 42,
              type: FeatureResourceEffectType.restore,
              targetType: FeatureResourceTargetType.spellSlots,
              activationTrigger: FeatureResourceTrigger.shortRest,
              recoveryPolicy: SpellSlotRecoveryPolicyData(
                  mode: SpellSlotRecoveryMode.levelBudget,
                  resourceKey: 'recovery',
                  levelBudgetBySourceLevel: {5: 3},
                  maximumSlotLevel: 5))
        ]);
    var c = CharacterData(
        id: 1,
        currentSpellSlots: {1: 1},
        currentPactSlots: {3: 1},
        derived: CharacterDerivedData(
            spellSlots: {1: 4}, pactSlots: {3: 2}, activeFeatures: [feature]),
        resourceStates: [
          CharacterResourceStateData(
              sourceType: feature.sourceType,
              sourceId: feature.sourceId,
              resourceKey: 'recovery',
              current: 0)
        ]);
    CharacterData apply(CharacterSyncOperationType type,
            CharacterSemanticActionData action, String id) =>
        replayCharacterSyncOperation(
            c,
            createCharacterSemanticOperation(
                character: c,
                localId: 1,
                serverId: 1,
                type: type,
                action: action,
                changeId: id,
                createdAt: DateTime.utc(2026)));
    c = apply(CharacterSyncOperationType.applyRest,
        CharacterSemanticActionData(restType: RestType.dawn), 'day');
    expect(c.resourceStates ?? [], isEmpty);
    expect(c.currentPactSlots, {3: 1});
    c = apply(CharacterSyncOperationType.applyRest,
        CharacterSemanticActionData(restType: RestType.shortRest), 'rest');
    final action = CharacterSemanticActionData(
        sourceType: feature.sourceType,
        sourceId: 41,
        recoveryEffectId: 42,
        resourceKey: 'recovery',
        slotSource: 'standard',
        slotsToRestore: {1: 3},
        recoveryTriggerId: 'rest');
    c = apply(CharacterSyncOperationType.recoverSpellSlots, action, 'recover');
    expect(
        shared.SpellSlotPools.fromCharacter(c.toJson()).standardCurrent[1], 4);
    expect(c.resourceStates!.single.current, 0);
    expect(c.spellRecoveryTriggers, isNull);
  });

  final path = Platform.environment['FEATURE_COMPLETION_REPLAY_SNAPSHOTS'];
  test(
      'actual server operations replay identically offline, including barriers',
      () {
    final rows = File(path!)
        .readAsLinesSync()
        .where((l) => l.isNotEmpty)
        .map((l) => jsonDecode(l) as Map);
    expect(rows, isNotEmpty);
    for (final row in rows) {
      final before = CharacterData.fromJson(
          (row['before'] as Map).cast<String, dynamic>());
      final op = CharacterSyncOperationData.fromJson(
          (row['operation'] as Map).cast<String, dynamic>());
      final after =
          CharacterData.fromJson((row['after'] as Map).cast<String, dynamic>());
      final local = replayCharacterSyncOperation(before, op);
      expect(runtime(local), runtime(after), reason: op.id);
      final targets = characterSemanticActionTargetKeys(
          before, op.type, op.value!.semanticActionValue!);
      final withBarriers = materializeLocalBarrierTokens(before, op);
      for (final target in targets) {
        expect(withBarriers.syncBarrierTokens?[target],
            after.syncBarrierTokens?[target],
            reason: '${op.id}: $target');
      }
    }
  },
      skip: path == null
          ? 'Set FEATURE_COMPLETION_REPLAY_SNAPSHOTS to integration exports.'
          : false);
}
