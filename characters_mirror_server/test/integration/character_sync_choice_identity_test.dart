import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Character choice sync v2.7', (sessionBuilder, endpoints) {
    test('upsert and replay preserve generic choice identity and effects',
        () async {
      final owner = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          307,
          <Scope>{},
        ),
      );
      final race = await endpoints.raceData.upsert(
        owner,
        RaceData(name: 'Sync choice race'),
      );
      final fixtureSession = owner.build();
      late ChoiceGroupData group;
      try {
        group = await ChoiceGroupData.db.insertRow(
          fixtureSession,
          ChoiceGroupData(
            referenceKey: 'sync_choice_language',
            sourceRaceId: race.id,
            type: ChoiceType.language,
            selectionCount: 1,
            allowDuplicates: false,
          ),
        );
        for (final (key, language) in const [
          ('common', Language.common),
          ('elvish', Language.elvish),
        ]) {
          await ChoiceOptionData.db.insertRow(
            fixtureSession,
            ChoiceOptionData(
              choiceGroupId: group.id!,
              optionKey: key,
              grantedLanguages: [language],
            ),
          );
        }
      } finally {
        await fixtureSession.close();
      }

      final saved = await endpoints.characterData.saveCharacter(
        owner,
        CharacterData(
          name: 'Sync choice identity',
          race: race,
          choices: [
            CharacterChoiceData(
              id: 'choice-a',
              groupKey: 'sync_choice_language',
              optionKey: 'common',
              selectionIndex: 0,
            ),
          ],
        ),
      );
      final beforeSync = await endpoints.characterData.getCharacter(
        owner,
        saved.id!,
      );
      expect(beforeSync.race?.id, race.id);
      expect(beforeSync.choices?.single.optionKey, 'common');
      final operation = CharacterSyncOperationData(
        id: 'choice-update-${saved.id}',
        characterId: saved.id,
        localCharacterId: saved.id,
        type: CharacterSyncOperationType.upsertListItem,
        targetType: CharacterSyncTargetType.listItem,
        targetId: 'choice-a',
        fieldPath: 'choices',
        itemPayload: CharacterSyncValueData(
          choiceValue: CharacterChoiceData(
            id: 'choice-a',
            groupKey: 'sync_choice_language',
            optionKey: 'elvish',
            selectionIndex: 0,
          ),
        ),
        baseCharacterRevision: saved.version,
        baseTargetRevision:
            saved.syncTargetRevisions?['item:choices:choice-a'] ??
                saved.version,
        createdAt: DateTime.utc(2026, 9, 26),
      );

      final first = await endpoints.characterData.syncCharacters(
        owner,
        CharacterSyncRequest(
          operations: [operation],
          syncProtocolVersion: 4,
        ),
      );
      final replay = await endpoints.characterData.syncCharacters(
        owner,
        CharacterSyncRequest(
          operations: [operation],
          syncProtocolVersion: 4,
        ),
      );
      final loaded = await endpoints.characterData.getCharacter(
        owner,
        saved.id!,
      );

      expect(first.rejectedChanges ?? const [], isEmpty);
      expect(first.acknowledgedChangeIds, contains(operation.id));
      expect(replay.acknowledgedChangeIds, contains(operation.id));
      expect(loaded.choices, hasLength(1));
      expect(loaded.choices!.single.id, 'choice-a');
      expect(loaded.choices!.single.groupKey, 'sync_choice_language');
      expect(loaded.choices!.single.optionKey, 'elvish');
      expect(loaded.derived?.languages, contains(Language.elvish));
      expect(loaded.derived?.languages, isNot(contains(Language.common)));
    });
  });
}
