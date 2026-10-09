import 'dart:convert';
import 'dart:math';

import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/feature_display_properties.dart';
import 'package:characters_mirror_server/src/choice_eligibility_context.dart';
import 'package:characters_mirror_server/src/weapon_training_values.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:characters_mirror_server/src/validation/character_quota_validator.dart';
import 'package:characters_mirror_server/src/validation/character_validator.dart';
import 'package:characters_mirror_server/src/validation/character_proficiency_override_validator.dart';
import 'package:characters_mirror_server/src/validation/character_equipment_selection_validator.dart';
import 'package:characters_mirror_server/src/validation/rules.dart';
import 'package:characters_mirror_server/src/validation/validation_exception.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart'
    as feature_modifiers;
import 'package:serverpod/serverpod.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart'
    hide
        FeatureModifierTarget,
        FeatureModifierOperation,
        FeatureModifierValueKind,
        FeatureModifierRounding,
        FeatureModifierCondition;

import 'starting_equipment_endpoints.dart';
import 'class_endpoints.dart';
import '../../../spells/class_spell_progression.dart';
import '../../../spells/spellcasting_source.dart';
import '../../../spells/spell_cast_service.dart';
import '../../../feature_grants.dart';
import '../../../armor_class_feature_modifiers.dart';

part 'character_data_endpoint/persistence_pruning_snapshot.dart';
part 'character_data_endpoint/persistence_record_write.dart';
part 'character_data_endpoint/persistence_relation_write.dart';
part 'character_data_endpoint/persistence_starting_equipment_write.dart';
part 'character_data_endpoint/persistence_normalization.dart';
part 'character_data_endpoint/persistence_transactional_save.dart';
part 'character_data_endpoint/persistence_sync_lookup.dart';
part 'character_data_endpoint/sync_events.dart';
part 'character_data_endpoint/sync_logging.dart';
part 'character_data_endpoint/sync_operation_application.dart';
part 'character_data_endpoint/sync_operation_validation.dart';
part 'character_data_endpoint/sync_semantic_actions.dart';
part 'character_data_endpoint/sync_target_keys.dart';
part 'character_data_endpoint/sync_target_revisions.dart';
part 'character_data_endpoint/aggregate_build.dart';
part 'character_data_endpoint/aggregate_derived_stats.dart';
part 'character_data_endpoint/derived_armor_class.dart';
part 'character_data_endpoint/aggregate_spell_slots.dart';
part 'character_data_endpoint/derived_resolve_context.dart';
part 'character_data_endpoint/derived_source_resolution.dart';
part 'character_data_endpoint/derived_automatic_choices.dart';
part 'character_data_endpoint/derived_collectors.dart';
part 'character_data_endpoint/derived_spells.dart';
part 'character_data_endpoint/derived_starting_equipment.dart';
part 'character_data_endpoint/derived_equipment_selection.dart';
part 'character_data_endpoint/normalization_basic_features.dart';
part 'character_data_endpoint/normalization_feature_resources.dart';
part 'character_data_endpoint/normalization_overrides_states.dart';
part 'character_data_endpoint/normalization_sorting_includes.dart';
part 'character_data_endpoint/level_up.dart';
part 'character_data_endpoint/level_up_choices.dart';
part 'character_data_endpoint/level_up_spells.dart';
part 'character_data_endpoint/spell_selection_validation.dart';
part 'character_data_endpoint/choice_replacements.dart';
part 'character_data_endpoint/level_up_resources.dart';
part 'character_data_endpoint/level_down.dart';

const _standardSpellSlotTableKey = 'standard';
const _pactMagicSpellSlotTableKey = 'pact_magic';
const _characterSyncProtocolVersion = 6;
const _characterSyncCapabilities = <String>[
  'member_operations',
  'logical_feature_override_targets',
  'logical_starting_equipment_targets',
  'sparse_proficiency_overrides',
  'post_normalization_target_revisions',
  'semantic_counter_actions',
  'semantic_barrier_tokens',
  'compound_cast_and_rest',
  'spell_cast_sources',
  'separate_pact_slots',
  'authoritative_full_resync',
  'spell_slot_recovery',
  'spell_activation_contract',
];

class CharacterDataEndpoint extends Endpoint {
  CharacterDataEndpoint({
    void Function(String key)? referenceQueryObserver,
  }) : _referenceQueryObserver = referenceQueryObserver;

  final void Function(String key)? _referenceQueryObserver;

  _CharacterResolveContext _createResolveContext(Session session) {
    return _CharacterResolveContext(
      session,
      onReferenceLoad: _referenceQueryObserver,
    );
  }

  @override
  bool get requireLogin => true;

  Future<LevelUpPreview> previewLevelUp(
    Session session,
    LevelUpRequest request,
  ) async {
    _validateLevelUpRequest(request);
    final record =
        await _requireOwnedCharacterRecord(session, request.characterId);
    final context = _createResolveContext(session);
    final before = await _buildCharacterAggregate(session, record,
        resolveContext: context);
    return _previewLevelUp(session, before, request, resolveContext: context);
  }

  Future<CharacterData> applyLevelUp(
    Session session,
    LevelUpRequest request,
  ) async {
    _validateLevelUpRequest(request);
    final userId = await _requireCurrentUserId(session);
    return _runCharacterMutationTransaction(session, (transaction) async {
      final record = await _lockOwnedCharacterRecord(session,
          characterId: request.characterId,
          userId: userId,
          transaction: transaction);
      if (record == null) {
        throw InputValidationException('characterId', 'Character unavailable.');
      }
      final context = _createResolveContext(session);
      final before = await _buildCharacterAggregate(session, record,
          transaction: transaction, resolveContext: context);
      final preview = await _previewLevelUp(session, before, request,
          transaction: transaction, resolveContext: context);
      if (preview.missingDecisions.isNotEmpty) {
        throw InputValidationException(
            'levelUp', preview.missingDecisions.join('; '));
      }
      return _saveCharacterSnapshotInTransaction(session,
          character:
              preview.character.copyWith(updatedAt: DateTime.now().toUtc()),
          userId: userId,
          transaction: transaction,
          expectedVersion: request.expectedVersion,
          requireExistingWhenIdPresent: true,
          trustedChoiceReplacementHistory: true,
          trustedSpellSelectionReplacements: true,
          resolveContext: context);
    }, userId: userId);
  }

  Future<LevelDownPreview> previewLevelDown(
    Session session,
    LevelDownRequest request,
  ) async {
    _validateLevelDownRequest(request);
    final record =
        await _requireOwnedCharacterRecord(session, request.characterId);
    final context = _createResolveContext(session);
    final before = await _buildCharacterAggregate(session, record,
        resolveContext: context);
    return _previewLevelDown(session, before, request, resolveContext: context);
  }

  Future<CharacterData> applyLevelDown(
    Session session,
    LevelDownRequest request,
  ) async {
    _validateLevelDownRequest(request);
    final userId = await _requireCurrentUserId(session);
    return _runCharacterMutationTransaction(session, (transaction) async {
      final record = await _lockOwnedCharacterRecord(session,
          characterId: request.characterId,
          userId: userId,
          transaction: transaction);
      if (record == null) {
        throw InputValidationException('characterId', 'Character unavailable.');
      }
      final context = _createResolveContext(session);
      final before = await _buildCharacterAggregate(session, record,
          transaction: transaction, resolveContext: context);
      final preview = await _previewLevelDown(session, before, request,
          transaction: transaction, resolveContext: context);
      if (preview.missingDecisions.isNotEmpty) {
        throw InputValidationException(
            'levelDown', preview.missingDecisions.join('; '));
      }
      return _saveCharacterSnapshotInTransaction(session,
          character:
              preview.character.copyWith(updatedAt: DateTime.now().toUtc()),
          userId: userId,
          transaction: transaction,
          expectedVersion: request.expectedVersion,
          requireExistingWhenIdPresent: true,
          trustedChoiceReplacementHistory: true,
          trustedSpellSelectionReplacements: true,
          resolveContext: context);
    }, userId: userId);
  }

  Future<List<CharacterData>> getAll(Session session) async {
    final userId = await _requireCurrentUserId(session);
    final resolveContext = _createResolveContext(session);
    final records = await CharacterRecord.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
      include: _characterRecordInclude(),
    );

    return Future.wait(
      records.map(
        (record) => _buildCharacterAggregate(
          session,
          record,
          resolveContext: resolveContext,
        ),
      ),
    );
  }

  Future<CharacterData> saveCharacter(
    Session session,
    CharacterData character,
  ) async {
    final userId = await _requireCurrentUserId(session);
    final resolveContext = _createResolveContext(session);
    return _runCharacterMutationTransaction(
      session,
      (transaction) => _saveCharacterSnapshotInTransaction(
        session,
        character: character,
        userId: userId,
        transaction: transaction,
        resolveContext: resolveContext,
      ),
      userId: userId,
    );
  }

  Future<CharacterSyncResult> syncSaveCharacter(
    Session session,
    CharacterData character,
    int? expectedVersion,
  ) async {
    final userId = await _requireCurrentUserId(session);
    final resolveContext = _createResolveContext(session);
    CharacterData saved;
    try {
      saved = await _runCharacterMutationTransaction(
        session,
        (transaction) => _saveCharacterSnapshotInTransaction(
          session,
          character: character,
          userId: userId,
          transaction: transaction,
          expectedVersion: expectedVersion,
          requireExistingWhenIdPresent: character.id != null,
          resolveContext: resolveContext,
        ),
        userId: userId,
      );
    } on _SnapshotVersionConflict catch (error) {
      return CharacterSyncResult(
        status: CharacterSyncStatus.conflict,
        conflictCharacter: await _buildCharacterAggregate(
          session,
          error.record,
          resolveContext: resolveContext,
        ),
        message: 'Character version conflict.',
      );
    } on _SnapshotNotFound {
      return CharacterSyncResult(
        status: CharacterSyncStatus.notFound,
        message: 'Character was not found for this user.',
      );
    }
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
    CharacterValidator.validateSyncRequest(request);
    final resolveContext = _createResolveContext(session);

    final operations =
        request.operations ?? const <CharacterSyncOperationData>[];
    if (operations.isNotEmpty) {
      final response = await _syncCharacterOperations(
        session,
        userId: userId,
        request: request,
        resolveContext: resolveContext,
      );
      _logCharacterSyncSummary(session, request, response);
      return response;
    }

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
                    : await _buildCharacterAggregate(
                        session,
                        currentRecord,
                        resolveContext: resolveContext,
                      ),
              ),
            );
            continue;
          }

          try {
            await _runCharacterMutationTransaction(
              session,
              (transaction) => _saveCharacterSnapshotInTransaction(
                session,
                character: payload,
                userId: userId,
                transaction: transaction,
                resolveContext: resolveContext,
              ),
              userId: userId,
            );
          } on InputValidationException catch (error) {
            rejectedChanges.add(
              CharacterRejectedChangeData(
                changeId: change.id,
                reason: 'invalid_change',
                message: error.toString(),
              ),
            );
            continue;
          }
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
                character: await _buildCharacterAggregate(
                  session,
                  existing,
                  resolveContext: resolveContext,
                ),
              ),
            );
            continue;
          }
          CharacterSaveRateLimiter.instance.consume(
            userId: userId,
            characterId: existing.id,
          );
          await delete(session, existing.id!);
          acknowledgedChangeIds.add(change.id);
          continue;
      }
    }

    final pullDelta = request.fullResync == true
        ? await _loadAuthoritativeCharacterFullResync(
            session,
            userId: userId,
            resolveContext: resolveContext,
          )
        : await _loadCharacterSyncDelta(
            session,
            userId: userId,
            pullAfterEventId: request.pullAfterEventId,
            pullSince: request.pullSince,
            resolveContext: resolveContext,
          );

    final response = CharacterSyncResponse(
      acknowledgedChangeIds: acknowledgedChangeIds,
      rejectedChanges: rejectedChanges,
      characters: pullDelta.characters,
      serverTime: DateTime.now().toUtc(),
      pullCursor: pullDelta.cursor,
      deletedCharacterIds: pullDelta.deletedCharacterIds,
      syncProtocolVersion: _characterSyncProtocolVersion,
      capabilities: _characterSyncCapabilities,
    );
    _logCharacterSyncSummary(session, request, response);
    return response;
  }

  Future<CharacterData> getCharacter(Session session, int id) async {
    final record = await _requireOwnedCharacterRecord(session, id);
    return _buildCharacterAggregate(
      session,
      record,
      resolveContext: _createResolveContext(session),
    );
  }

  Future<CharacterSyncResult> syncDeleteCharacter(
    Session session,
    int id,
    int? expectedVersion,
  ) async {
    final userId = await _requireCurrentUserId(session);
    final resolveContext = _createResolveContext(session);
    final result = await _runCharacterMutationTransaction(
      session,
      (transaction) async {
        final currentRecord = await _lockOwnedCharacterRecord(
          session,
          characterId: id,
          userId: userId,
          transaction: transaction,
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
            conflictCharacter: await _buildCharacterAggregate(
              session,
              currentRecord,
              transaction: transaction,
              resolveContext: resolveContext,
            ),
            message: 'Character version conflict.',
          );
        }
        await _deleteCharacterInTransaction(
          session,
          currentRecord.id!,
          transaction: transaction,
        );
        await _recordCharacterSyncEvent(
          session,
          userId: userId,
          characterId: currentRecord.id!,
          characterVersion: currentRecord.version,
          eventType: _characterSyncEventDeleted,
          transaction: transaction,
        );
        return CharacterSyncResult(status: CharacterSyncStatus.deleted);
      },
      userId: userId,
    );
    if (result.status != CharacterSyncStatus.deleted) {
      return result;
    }
    return CharacterSyncResult(status: CharacterSyncStatus.deleted);
  }

  Future<void> delete(Session session, int id) async {
    final userId = await _requireCurrentUserId(session);
    await _runCharacterMutationTransaction(
      session,
      (transaction) async {
        final record = await _lockOwnedCharacterRecord(
          session,
          characterId: id,
          userId: userId,
          transaction: transaction,
        );
        if (record == null) {
          await _requireOwnedCharacterRecord(
            session,
            id,
            userId: userId,
            transaction: transaction,
          );
        }
        if (record != null) {
          await _recordCharacterSyncEvent(
            session,
            userId: userId,
            characterId: record.id!,
            characterVersion: record.version,
            eventType: _characterSyncEventDeleted,
            transaction: transaction,
          );
        }
        await _deleteCharacterInTransaction(
          session,
          id,
          transaction: transaction,
        );
      },
      userId: userId,
    );
  }
}
