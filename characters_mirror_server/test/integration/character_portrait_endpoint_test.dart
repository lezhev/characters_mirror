import 'dart:typed_data';

import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('CharacterPortraitEndpoint', (sessionBuilder, endpoints) {
    TestSessionBuilder authenticatedSession(int userId) {
      return sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId,
          <Scope>{},
        ),
      );
    }

    test('upload, confirm, get and delete portrait', () async {
      const userId = 701;

      final ownerSession = authenticatedSession(userId);

      final dbSession = ownerSession.build();
      final character = await CharacterRecord.db.insertRow(
        dbSession,
        CharacterRecord(
          name: 'Portrait Test',
          userId: userId,
        ),
      );
      await dbSession.close();

      final characterId = character.id!;

      final uploadUrl = await endpoints.characterPortrait.createUploadUrl(
        ownerSession,
        characterId,
      );

      final bytes = Uint8List.fromList(
        List<int>.generate(128, (index) => index),
      );

      final uploadResponse = await http.put(
        Uri.parse(uploadUrl),
        body: bytes,
      );

      expect(
        uploadResponse.statusCode,
        anyOf(200, 201, 204),
      );

      final version = await endpoints.characterPortrait.confirmUpload(
        ownerSession,
        characterId,
      );

      expect(version, 1);

      final getUrl = await endpoints.characterPortrait.getUrl(
        ownerSession,
        characterId,
      );

      expect(getUrl, isNotNull);

      final downloadResponse = await http.get(
        Uri.parse(getUrl!),
      );

      expect(downloadResponse.statusCode, 200);
      expect(downloadResponse.bodyBytes, bytes);

      await endpoints.characterPortrait.deletePortrait(
        ownerSession,
        characterId,
      );

      final deletedUrl = await endpoints.characterPortrait.getUrl(
        ownerSession,
        characterId,
      );

      expect(deletedUrl, isNull);
    });

    test('another user cannot access portrait operations', () async {
      const ownerId = 702;
      const intruderId = 703;

      final ownerSession = authenticatedSession(ownerId);
      final intruderSession = authenticatedSession(intruderId);

      final dbSession = ownerSession.build();
      final character = await CharacterRecord.db.insertRow(
        dbSession,
        CharacterRecord(
          name: 'Private Portrait Test',
          userId: ownerId,
        ),
      );
      await dbSession.close();

      await expectLater(
        () => endpoints.characterPortrait.createUploadUrl(
          intruderSession,
          character.id!,
        ),
        throwsException,
      );
    });

    test('getUrl returns null when character was deleted', () async {
      const userId = 704;
      final ownerSession = authenticatedSession(userId);
      final dbSession = ownerSession.build();
      final character = await CharacterRecord.db.insertRow(
        dbSession,
        CharacterRecord(
          name: 'Deleted Portrait Test',
          userId: userId,
        ),
      );
      await CharacterRecord.db.deleteRow(dbSession, character);
      await dbSession.close();

      final url = await endpoints.characterPortrait.getUrl(
        ownerSession,
        character.id!,
      );

      expect(url, isNull);
    });
  });
}
