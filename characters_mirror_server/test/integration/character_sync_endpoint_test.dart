import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Character sync', (sessionBuilder, endpoints) {
    TestSessionBuilder authenticatedSession(int userId) {
      return sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId,
          <Scope>{},
        ),
      );
    }

    test('syncCharacters acknowledges newer snapshot changes', () async {
      final ownerSession = authenticatedSession(101);
      final createdAt = DateTime.utc(2026, 4, 24, 0, 0, 0);

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Старое имя',
          updatedAt: createdAt,
          createdAt: createdAt,
        ),
      );

      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          changes: [
            CharacterChangeData(
              id: 'change-1',
              changeType: CharacterChangeType.upsert,
              entityType: CharacterEntityType.character,
              entityId: saved.id!.toString(),
              createdAt: DateTime.utc(2026, 4, 24, 0, 5, 0),
              baseUpdatedAt: saved.updatedAt,
              payload: saved.copyWith(
                name: 'Новое имя',
                updatedAt: DateTime.utc(2026, 4, 24, 0, 10, 0),
              ),
            ),
          ],
          pullSince: DateTime.utc(2026, 4, 24, 0, 1, 0),
        ),
      );

      expect(response.acknowledgedChangeIds, contains('change-1'));
      expect(response.rejectedChanges, isEmpty);
      expect(
        response.characters?.where((character) => character.id == saved.id).length,
        1,
      );
      expect(
        response.characters
            ?.firstWhere((character) => character.id == saved.id)
            .name,
        'Новое имя',
      );
    });

    test('syncCharacters rejects stale snapshot changes', () async {
      final ownerSession = authenticatedSession(101);
      final createdAt = DateTime.utc(2026, 4, 24, 1, 0, 0);

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Актуальный герой',
          updatedAt: createdAt,
          createdAt: createdAt,
        ),
      );

      final fresherServerVersion = await endpoints.characterData.saveCharacter(
        ownerSession,
        saved.copyWith(
          name: 'Сервер новее',
          updatedAt: DateTime.utc(2026, 4, 24, 1, 20, 0),
        ),
      );

      final response = await endpoints.characterData.syncCharacters(
        ownerSession,
        CharacterSyncRequest(
          changes: [
            CharacterChangeData(
              id: 'change-2',
              changeType: CharacterChangeType.upsert,
              entityType: CharacterEntityType.character,
              entityId: saved.id!.toString(),
              createdAt: DateTime.utc(2026, 4, 24, 1, 25, 0),
              baseUpdatedAt: saved.updatedAt,
              payload: saved.copyWith(
                name: 'Локально устарело',
                updatedAt: DateTime.utc(2026, 4, 24, 1, 10, 0),
              ),
            ),
          ],
          pullSince: DateTime.utc(2026, 4, 24, 1, 5, 0),
        ),
      );

      expect(response.acknowledgedChangeIds, isNot(contains('change-2')));
      expect(response.rejectedChanges, hasLength(1));
      expect(response.rejectedChanges?.single.reason, 'stale_update');
      expect(
        response.rejectedChanges?.single.character?.name,
        fresherServerVersion.name,
      );
    });
  });
}
