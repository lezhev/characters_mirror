import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_semantic_sync.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_operation_replay.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final canonical = CharacterData(
    id: 1,
    version: 7,
    derived: CharacterDerivedData(spellSlots: const {1: 2}),
  );

  CharacterSyncOperationData semanticOperation({
    required String id,
    required CharacterSyncOperationType type,
    required CharacterSemanticActionData action,
  }) {
    return createCharacterSemanticOperation(
      character: canonical,
      localId: 1,
      serverId: 1,
      type: type,
      action: action,
      changeId: id,
      createdAt: DateTime.utc(2026, 9, 24),
    );
  }

  test('cast spell replays 2 slots to 1 and then to 0', () {
    final cast = semanticOperation(
      id: 'cast-1',
      type: CharacterSyncOperationType.castSpell,
      action: CharacterSemanticActionData(level: 1),
    );
    final afterFirstCast = replayCharacterSyncOperation(canonical, cast);
    final afterSecondCast = replayCharacterSyncOperation(
      afterFirstCast,
      cast.copyWith(id: 'cast-2'),
    );

    expect(afterFirstCast.currentSpellSlots, const {1: 1});
    expect(afterSecondCast.currentSpellSlots, const {1: 0});
    expect(afterSecondCast.derived?.spellSlots, const {1: 2});
  });

  test('long rest replay restores spell slots without reconciliation', () {
    final exhausted = canonical.copyWith(currentSpellSlots: const {1: 0});
    final rest = semanticOperation(
      id: 'rest-1',
      type: CharacterSyncOperationType.applyRest,
      action: CharacterSemanticActionData(restType: RestType.longRest),
    );

    final restored = replayCharacterSyncOperation(exhausted, rest);

    expect(restored.currentSpellSlots, isNull);
    expect(restored.derived?.spellSlots, const {1: 2});
  });

  test('replaying pending cast after canonical reconciliation keeps slots', () {
    final serverSnapshot = canonical.copyWith(version: 8);
    final pendingCast = semanticOperation(
      id: 'cast-pending',
      type: CharacterSyncOperationType.castSpell,
      action: CharacterSemanticActionData(level: 1),
    );

    final visible = replayCharacterSyncOperation(serverSnapshot, pendingCast);

    expect(visible.currentSpellSlots, const {1: 1});
    expect(visible.derived?.spellSlots, const {1: 2});
  });
}
