import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_operation_replay.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_experience_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('new drafts and cleared experience use zero', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(characterCreationProvider).character.experience, 0);
    final controller = container.read(characterCreationProvider.notifier);
    controller.setExperience(100);
    controller.setExperience(null);
    expect(container.read(characterCreationProvider).character.experience, 0);
  });

  test('offline legacy character starts with zero experience and level one',
      () async {
    final cache = OfflineCacheDatabase.openInMemory();
    addTearDown(cache.close);

    final character = await resolveOfflineCharacter(cache, CharacterData());
    expect(character.experience, 0);
    expect(character.derived?.totalLevel, 1);
    expect(character.derived?.proficiencyBonus, 2);
  });

  test('experience replay preserves zero and rejects negative totals', () {
    final operation = CharacterSyncOperationData(
      id: 'xp-remove',
      characterId: 42,
      type: CharacterSyncOperationType.adjustExperience,
      targetType: CharacterSyncTargetType.field,
      value: CharacterSyncValueData(
        semanticActionValue: CharacterSemanticActionData(delta: -100),
      ),
      createdAt: DateTime.utc(2026, 10, 5),
    );
    final result = replayCharacterSyncOperation(
      CharacterData(id: 42, experience: 100),
      operation,
    );
    expect(result.experience, 0);
    expect(() => replayCharacterSyncOperation(result, operation),
        throwsStateError);
  });

  testWidgets('legacy empty experience renders zero and a starting level',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CharacterExperienceSummary(character: CharacterData()),
      ),
    ));

    expect(find.text('1 уровень'), findsOneWidget);
    expect(find.text('0 опыта · порог не указан'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('experience summary preserves class levels before derived data',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CharacterExperienceSummary(
          character: CharacterData(
            experience: 1200,
            classEntries: [
              CharacterClassEntryData(level: 2),
              CharacterClassEntryData(level: 1),
            ],
          ),
        ),
      ),
    ));

    expect(find.text('3 уровень'), findsOneWidget);
    expect(find.text('1200 опыта · порог не указан'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
