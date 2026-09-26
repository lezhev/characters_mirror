import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/storage/object_storage.dart';
import 'package:characters_mirror_server/src/storage/object_storage_config.dart';
import 'package:characters_mirror_server/src/storage/s3_object_storage.dart';
import 'package:serverpod/serverpod.dart';

class CharacterPortraitEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  ObjectStorage _createStorage() {
    return S3ObjectStorage(
      ObjectStorageConfig.fromEnvironment(),
    );
  }

  Future<String> createUploadUrl(
    Session session,
    int characterId,
  ) async {
    await _requireOwnedCharacter(session, characterId);

    final url = await _createStorage().createPutUrl(
      _portraitKey(characterId),
      expiresIn: const Duration(minutes: 5),
    );

    return url.toString();
  }

  Future<int> confirmUpload(
    Session session,
    int characterId,
  ) async {
    final record = await _requireOwnedCharacter(
      session,
      characterId,
    );

    final nextVersion = (record.portraitVersion ?? 0) + 1;

    record.portraitVersion = nextVersion;

    await CharacterRecord.db.updateRow(
      session,
      record,
    );

    return nextVersion;
  }

  Future<String?> getUrl(
    Session session,
    int characterId,
  ) async {
    final record = await _findOwnedCharacter(
      session,
      characterId,
    );

    if (record?.portraitVersion == null) {
      return null;
    }

    final url = await _createStorage().createGetUrl(
      _portraitKey(characterId),
      expiresIn: const Duration(minutes: 15),
      responseContentType: 'image/webp',
    );

    return url.toString();
  }

  Future<void> deletePortrait(
    Session session,
    int characterId,
  ) async {
    final record = await _requireOwnedCharacter(
      session,
      characterId,
    );

    if (record.portraitVersion == null) {
      return;
    }

    await _createStorage().delete(
      _portraitKey(characterId),
    );

    record.portraitVersion = null;

    await CharacterRecord.db.updateRow(
      session,
      record,
    );
  }

  Future<CharacterRecord> _requireOwnedCharacter(
    Session session,
    int characterId,
  ) async {
    final record = await _findOwnedCharacter(session, characterId);
    if (record == null) {
      throw Exception(
        'Character not found or access denied.',
      );
    }
    return record;
  }

  Future<CharacterRecord?> _findOwnedCharacter(
    Session session,
    int characterId,
  ) async {
    final userId = (await session.authenticated)?.userId;

    if (userId == null) {
      throw Exception('Authentication required.');
    }

    final records = await CharacterRecord.db.find(
      session,
      where: (t) => t.id.equals(characterId) & t.userId.equals(userId),
      limit: 1,
    );

    return records.firstOrNull;
  }

  String _portraitKey(int characterId) {
    return 'characters/$characterId/portrait.webp';
  }
}
