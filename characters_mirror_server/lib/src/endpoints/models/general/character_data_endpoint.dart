import 'dart:math';

import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

import 'starting_equipment_endpoints.dart';

part 'character_data_endpoint/persistence_pruning_snapshot.dart';
part 'character_data_endpoint/persistence_record_write.dart';
part 'character_data_endpoint/persistence_relation_write.dart';
part 'character_data_endpoint/persistence_starting_equipment_write.dart';
part 'character_data_endpoint/persistence_normalization.dart';
part 'character_data_endpoint/persistence_sync_lookup.dart';
part 'character_data_endpoint/aggregate_build.dart';
part 'character_data_endpoint/aggregate_derived_stats.dart';
part 'character_data_endpoint/aggregate_spell_slots.dart';
part 'character_data_endpoint/derived_source_resolution.dart';
part 'character_data_endpoint/derived_collectors.dart';
part 'character_data_endpoint/derived_starting_equipment.dart';
part 'character_data_endpoint/derived_equipment_selection.dart';
part 'character_data_endpoint/normalization_basic_features.dart';
part 'character_data_endpoint/normalization_feature_resources.dart';
part 'character_data_endpoint/normalization_overrides_states.dart';
part 'character_data_endpoint/normalization_sorting_includes.dart';

const _standardSpellSlotTableKey = 'standard';
const _pactMagicSpellSlotTableKey = 'pact_magic';

class CharacterDataEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<CharacterData>> getAll(Session session) async {
    final userId = await _requireCurrentUserId(session);
    final records = await CharacterRecord.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
      include: _characterRecordInclude(),
    );

    return Future.wait(
      records.map((record) => _buildCharacterAggregate(session, record)),
    );
  }

  Future<CharacterData> saveCharacter(
    Session session,
    CharacterData character,
  ) async {
    final userId = await _requireCurrentUserId(session);
    // TODO: Add server-side abuse limits for character count, text lengths,
    // list sizes, and save rate before accepting user-controlled payloads.
    var normalizedCharacter = character.copyWith(
      featureOverrides: await _pruneFeatureOverrides(session, character),
      resourceStates: await _pruneResourceStates(session, character),
    );
    final existingRecord = character.id == null
        ? null
        : await _findOwnedCharacterRecord(session, character.id!, userId);
    if (_serverSnapshotIsNewer(existingRecord, normalizedCharacter)) {
      return _buildCharacterAggregate(session, existingRecord!);
    }

    normalizedCharacter = _normalizeIncomingCharacter(
      normalizedCharacter,
      fallbackUpdatedAt:
          normalizedCharacter.updatedAt ?? existingRecord?.updatedAt,
    );
    if (character.id == null) {
      normalizedCharacter = await _applyInitialEquipmentSnapshot(
        session,
        normalizedCharacter,
      );
    }
    final savedRecord =
        await _upsertCharacterRecord(session, normalizedCharacter, userId);
    await _upsertCharacterRelations(session, savedRecord, normalizedCharacter);

    final hydratedRecord = await _requireOwnedCharacterRecord(
      session,
      savedRecord.id!,
      userId: userId,
    );
    return _buildCharacterAggregate(session, hydratedRecord);
  }

  Future<CharacterSyncResult> syncSaveCharacter(
    Session session,
    CharacterData character,
    int? expectedVersion,
  ) async {
    final userId = await _requireCurrentUserId(session);
    final characterId = character.id;
    if (characterId != null) {
      final currentRecord = await _findOwnedCharacterRecord(
        session,
        characterId,
        userId,
      );
      if (currentRecord == null) {
        return CharacterSyncResult(
          status: CharacterSyncStatus.notFound,
          message: 'Character was not found for this user.',
        );
      }
      if (currentRecord.version != expectedVersion) {
        return CharacterSyncResult(
          status: CharacterSyncStatus.conflict,
          conflictCharacter:
              await _buildCharacterAggregate(session, currentRecord),
          message: 'Character version conflict.',
        );
      }
    }

    final saved = await saveCharacter(session, character);
    return CharacterSyncResult(
      status: CharacterSyncStatus.saved,
      character: saved,
    );
  }

  Future<CharacterSyncResponse> syncCharacters(
    Session session,
    CharacterSyncRequest request,
  ) async {
    final userId = await _requireCurrentUserId(session);
    final acknowledgedChangeIds = <String>[];
    final rejectedChanges = <CharacterRejectedChangeData>[];
    for (final change in request.changes ?? const <CharacterChangeData>[]) {
      if (change.entityType != CharacterEntityType.character) {
        rejectedChanges.add(
          CharacterRejectedChangeData(
            changeId: change.id,
            reason: 'unsupported_entity',
            message: 'Unsupported entity type ${change.entityType.name}.',
          ),
        );
        continue;
      }

      switch (change.changeType) {
        case CharacterChangeType.upsert:
          final payload = change.payload;
          if (payload == null) {
            rejectedChanges.add(
              CharacterRejectedChangeData(
                changeId: change.id,
                reason: 'missing_payload',
                message: 'Upsert change requires payload.',
              ),
            );
            continue;
          }

          final currentRecord = payload.id == null
              ? null
              : await _findOwnedCharacterRecord(session, payload.id!, userId);
          if (_serverSnapshotIsNewer(currentRecord, payload)) {
            rejectedChanges.add(
              CharacterRejectedChangeData(
                changeId: change.id,
                reason: 'stale_update',
                message:
                    'Stored character is newer than the incoming snapshot.',
                character: currentRecord == null
                    ? null
                    : await _buildCharacterAggregate(session, currentRecord),
              ),
            );
            continue;
          }

          await saveCharacter(session, payload);
          acknowledgedChangeIds.add(change.id);
          continue;
        case CharacterChangeType.delete:
          final existing = await _findOwnedCharacterRecordByEntityId(
            session,
            userId,
            change.entityId,
          );
          if (existing == null) {
            acknowledgedChangeIds.add(change.id);
            continue;
          }
          if (_serverDeleteShouldWin(existing, change.baseUpdatedAt)) {
            rejectedChanges.add(
              CharacterRejectedChangeData(
                changeId: change.id,
                reason: 'stale_delete',
                message: 'Stored character is newer than the delete base.',
                character: await _buildCharacterAggregate(session, existing),
              ),
            );
            continue;
          }
          await delete(session, existing.id!);
          acknowledgedChangeIds.add(change.id);
          continue;
      }
    }

    final pullCharacters = await _loadCharactersUpdatedAfter(
      session,
      userId: userId,
      updatedAfter: request.pullSince,
    );

    return CharacterSyncResponse(
      acknowledgedChangeIds: acknowledgedChangeIds,
      rejectedChanges: rejectedChanges,
      characters: pullCharacters,
      serverTime: DateTime.now().toUtc(),
    );
  }

  Future<CharacterData> getCharacter(Session session, int id) async {
    final record = await _requireOwnedCharacterRecord(session, id);
    return _buildCharacterAggregate(session, record);
  }

  Future<CharacterSyncResult> syncDeleteCharacter(
    Session session,
    int id,
    int? expectedVersion,
  ) async {
    final userId = await _requireCurrentUserId(session);
    final currentRecord = await _findOwnedCharacterRecord(session, id, userId);
    if (currentRecord == null) {
      return CharacterSyncResult(
        status: CharacterSyncStatus.notFound,
        message: 'Character was not found for this user.',
      );
    }
    if (currentRecord.version != expectedVersion) {
      return CharacterSyncResult(
        status: CharacterSyncStatus.conflict,
        conflictCharacter:
            await _buildCharacterAggregate(session, currentRecord),
        message: 'Character version conflict.',
      );
    }

    await delete(session, id);
    return CharacterSyncResult(status: CharacterSyncStatus.deleted);
  }

  Future<void> delete(Session session, int id) async {
    await _requireOwnedCharacterRecord(session, id);
    await _deleteStartingEquipmentRecords(session, id);
    await CharacterSkillSelectionRecord.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(id),
    );
    await CharacterSpellSelectionRecord.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(id),
    );
    await CharacterChoiceRecord.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(id),
    );
    await CharacterClassEntryRecord.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(id),
    );
    await CharacterRecord.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }
}
