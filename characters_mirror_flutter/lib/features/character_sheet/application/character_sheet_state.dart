import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character_spells/spell_selection_support.dart';
import 'package:characters_mirror_flutter/core/offline/character_mutation_stamper.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_item_id.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_dev_log.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/character_model_extensions.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_proficiency_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_save_timing.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/hit_points_calculator.dart';
import 'package:characters_mirror_flutter/utils/calculate_max_hp_for_character.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_sheet_state.g.dart';
part 'character_sheet_state/combat_operations.dart';
part 'character_sheet_state/spell_operations.dart';
part 'character_sheet_state/personal_operations.dart';
part 'character_sheet_state/ability_operations.dart';
part 'character_sheet_state/feature_resource_operations.dart';
part 'character_sheet_state/feature_helpers.dart';
part 'character_sheet_state/rest_helpers.dart';
part 'character_sheet_state/spell_helpers.dart';

final characterRepositoryProvider = Provider<CharacterRepository>((ref) {
  return CharacterRepository();
});

final offlineCharacterRecordProvider =
    FutureProvider.autoDispose.family<OfflineCharacterRecord?, int>(
  (ref, characterId) {
    final coordinator = offlineSyncCoordinator;
    if (coordinator != null) {
      void reloadAfterSync() => ref.invalidateSelf();

      coordinator.addListener(reloadAfterSync);
      ref.onDispose(() => coordinator.removeListener(reloadAfterSync));
    }
    return ref.watch(characterRepositoryProvider).getOfflineRecord(characterId);
  },
);

final selectedFightFeatureTagsProvider =
    StateProvider.autoDispose.family<Set<FeatureTag>, int>((ref, characterId) {
  return {
    FeatureTag.combat,
    FeatureTag.defense,
  };
});

final characterSheetLocalSavePendingProvider =
    StateProvider.autoDispose.family<bool, int>((ref, characterId) => false);

@riverpod
Future<CharacterData> characterSheet(Ref ref, int characterId) async {
  final repository = ref.watch(characterRepositoryProvider);
  return repository.getCharacter(characterId);
}

final characterSheetControllerProvider = AsyncNotifierProvider.autoDispose
    .family<CharacterSheetController, CharacterData, int>(
  CharacterSheetController.new,
);

class CharacterSheetController
    extends AutoDisposeFamilyAsyncNotifier<CharacterData, int> {
  late final CharacterRepository _repository;
  late final int _characterId;
  int _saveRevision = 0;
  Timer? _saveDebounceTimer;
  CharacterData? _debouncedSave;
  int _debouncedSaveRevision = 0;
  Completer<void>? _debouncedSaveCompleter;
  bool _isPersisting = false;
  bool _isDisposed = false;
  CharacterData? _lastPersistedCharacter;
  CharacterData? _pendingSave;
  int _pendingSaveRevision = 0;
  Completer<void>? _pendingSaveCompleter;
  Completer<void>? _activeSaveCompleter;
  Future<void> _semanticPersistenceTail = Future<void>.value();
  bool _syncReloadRequested = false;
  bool _isReloadingAfterSync = false;
  int _semanticSavesInFlight = 0;

  @override
  Future<CharacterData> build(int characterId) async {
    _characterId = characterId;
    _repository = ref.watch(characterRepositoryProvider);
    ref.onDispose(_disposeSaveQueue);
    final coordinator = offlineSyncCoordinator;
    if (coordinator != null) {
      coordinator.addListener(_reloadAfterSync);
      ref.onDispose(() => coordinator.removeListener(_reloadAfterSync));
    }
    final character = await _repository.getCharacter(characterId);
    _lastPersistedCharacter = character;
    return character;
  }

  void _reloadAfterSync() {
    if (_isDisposed) return;
    _syncReloadRequested = true;
    unawaited(_reloadFromLocalStoreWhenIdle());
  }

  Future<void> _reloadFromLocalStoreWhenIdle() async {
    if (_isDisposed ||
        _isReloadingAfterSync ||
        _isPersisting ||
        _semanticSavesInFlight > 0 ||
        _debouncedSave != null ||
        _pendingSave != null) {
      return;
    }
    _syncReloadRequested = false;
    _isReloadingAfterSync = true;
    final revisionBeforeRead = _saveRevision;
    try {
      final record = await _repository.getOfflineRecord(_characterId);
      if (_isDisposed ||
          record == null ||
          record.status == OfflineCharacterSyncStatus.deleting) {
        return;
      }
      if (revisionBeforeRead != _saveRevision ||
          _isPersisting ||
          _semanticSavesInFlight > 0 ||
          _debouncedSave != null ||
          _pendingSave != null) {
        _syncReloadRequested = true;
        return;
      }
      _lastPersistedCharacter = record.character;
      state = AsyncValue.data(record.character);
      _setLocalSavePending(false);
    } finally {
      _isReloadingAfterSync = false;
      if (_syncReloadRequested && !_isDisposed) {
        unawaited(_reloadFromLocalStoreWhenIdle());
      }
    }
  }

  Future<void> reload() async {
    final nextState =
        await AsyncValue.guard(() => _repository.getCharacter(_characterId));
    state = nextState;
    final character = nextState.valueOrNull;
    if (character != null) {
      _lastPersistedCharacter = character;
    }
  }

  Future<void> saveProficiencyOverrides(CharacterData updated) async {
    await _saveCharacter(updated, debounce: false);
  }

  CharacterData _requireCharacter() {
    final current = state.valueOrNull;
    if (current == null) {
      throw StateError('Character sheet is not loaded yet.');
    }
    return current;
  }

  Future<void> _saveCharacter(
    CharacterData updated, {
    bool debounce = true,
  }) async {
    final previous = _requireCharacter();
    final stamped = stampCharacterMutation(previous: previous, next: updated);
    final revision = ++_saveRevision;
    _setLocalSavePending(true);
    state = AsyncValue.data(stamped);

    if (!debounce) {
      return _saveImmediately(stamped, revision);
    }

    if (_debouncedSaveCompleter?.isCompleted == false) {
      _debouncedSaveCompleter!.complete();
    }
    _debouncedSave = stamped;
    _debouncedSaveRevision = revision;
    _debouncedSaveCompleter = Completer<void>();
    _saveDebounceTimer?.cancel();
    _saveDebounceTimer = Timer(
      characterSheetAutosaveDelay,
      _flushDebouncedSave,
    );
    return _debouncedSaveCompleter!.future;
  }

  Future<void> _saveImmediately(CharacterData stamped, int revision) async {
    _saveDebounceTimer?.cancel();
    _saveDebounceTimer = null;
    _debouncedSave = null;
    _debouncedSaveRevision = 0;
    if (_debouncedSaveCompleter?.isCompleted == false) {
      _debouncedSaveCompleter!.complete();
    }
    _debouncedSaveCompleter = null;

    if (_isPersisting) {
      if (_pendingSaveCompleter?.isCompleted == false) {
        _pendingSaveCompleter!.complete();
      }
      _pendingSave = stamped;
      _pendingSaveRevision = revision;
      _pendingSaveCompleter = Completer<void>();
      return _pendingSaveCompleter!.future;
    }

    final completer = Completer<void>();
    unawaited(_persistSaves(stamped, revision, completer));
    return completer.future;
  }

  Future<void> flushPendingSave() async {
    if (_isDisposed) {
      return;
    }

    await _flushAbsoluteSaves();
    await _semanticPersistenceTail;
    await _flushAbsoluteSaves();
  }

  Future<void> _flushAbsoluteSaves() async {
    _saveDebounceTimer?.cancel();
    _saveDebounceTimer = null;
    if (_debouncedSave != null) {
      _flushDebouncedSave();
    }

    while (true) {
      final pending = _pendingSaveCompleter;
      final active = _activeSaveCompleter;
      final save = pending?.future ?? active?.future;
      if (save == null) {
        return;
      }
      await save;

      if (_debouncedSave != null) {
        _flushDebouncedSave();
      }
    }
  }

  Future<void> _saveSemanticAction(
    CharacterData updated, {
    required CharacterSyncOperationType type,
    required CharacterSemanticActionData action,
  }) {
    final previous = _requireCharacter();
    final stamped = stampCharacterMutation(previous: previous, next: updated);
    final revision = ++_saveRevision;
    _setLocalSavePending(true);
    state = AsyncValue.data(stamped);
    final completer = Completer<void>();
    final previousTail = _semanticPersistenceTail;
    _semanticSavesInFlight += 1;

    _semanticPersistenceTail = () async {
      try {
        try {
          await previousTail;
        } catch (_) {
          // Each action reports its own failure through its returned future.
        }
        await _flushAbsoluteSaves();
        try {
          final saved = await _repository.saveSemanticAction(
            character: stamped,
            type: type,
            action: action,
          );
          _lastPersistedCharacter = saved;
          if (!_isDisposed && revision == _saveRevision) {
            state = AsyncValue.data(saved);
          }
          if (!_isDisposed) {
            ref.invalidate(characterSheetProvider(_characterId));
            ref.invalidate(offlineCharacterRecordProvider(_characterId));
          }
          if (!_isDisposed &&
              revision == _saveRevision &&
              !_syncReloadRequested) {
            _setLocalSavePending(false);
          }
          completer.complete();
        } catch (error, stackTrace) {
          if (!_isDisposed && revision == _saveRevision) {
            state = AsyncValue.data(
              _lastPersistedCharacter ?? previous,
            );
            _setLocalSavePending(false);
          }
          completer.completeError(error, stackTrace);
        }
      } finally {
        _semanticSavesInFlight -= 1;
        if (_syncReloadRequested && !_isDisposed) {
          unawaited(_reloadFromLocalStoreWhenIdle());
        }
      }
    }();
    return completer.future;
  }

  void _flushDebouncedSave() {
    _saveDebounceTimer?.cancel();
    _saveDebounceTimer = null;

    final nextSave = _debouncedSave;
    final nextRevision = _debouncedSaveRevision;
    final nextCompleter = _debouncedSaveCompleter;
    _debouncedSave = null;
    _debouncedSaveRevision = 0;
    _debouncedSaveCompleter = null;

    if (nextSave == null) {
      if (nextCompleter?.isCompleted == false) {
        nextCompleter!.complete();
      }
      return;
    }

    if (_isPersisting) {
      if (_pendingSaveCompleter?.isCompleted == false) {
        _pendingSaveCompleter!.complete();
      }
      _pendingSave = nextSave;
      _pendingSaveRevision = nextRevision;
      _pendingSaveCompleter = nextCompleter;
      return;
    }

    unawaited(_persistSaves(nextSave, nextRevision, nextCompleter));
  }

  void _disposeSaveQueue() {
    _isDisposed = true;
    _saveDebounceTimer?.cancel();
    _saveDebounceTimer = null;

    final debouncedSave = _debouncedSave;
    final debouncedRevision = _debouncedSaveRevision;
    final debouncedCompleter = _debouncedSaveCompleter;
    _debouncedSave = null;
    _debouncedSaveRevision = 0;
    _debouncedSaveCompleter = null;

    if (debouncedSave != null) {
      if (_isPersisting) {
        if (_pendingSaveCompleter?.isCompleted == false) {
          _pendingSaveCompleter!.complete();
        }
        _pendingSave = debouncedSave;
        _pendingSaveRevision = debouncedRevision;
        _pendingSaveCompleter = debouncedCompleter;
      } else {
        unawaited(
          _persistSaves(
            debouncedSave,
            debouncedRevision,
            debouncedCompleter,
          ),
        );
      }
    } else if (debouncedCompleter?.isCompleted == false) {
      debouncedCompleter!.complete();
    }
  }

  Future<void> _persistSaves(
    CharacterData initial,
    int initialRevision, [
    Completer<void>? initialCompleter,
  ]) async {
    _isPersisting = true;
    var nextCharacter = initial;
    var nextRevision = initialRevision;
    var activeCompleter = initialCompleter;
    _activeSaveCompleter = activeCompleter;

    try {
      while (true) {
        try {
          final saved = await _repository.saveCharacter(nextCharacter);
          _lastPersistedCharacter = saved;
          if (!_isDisposed && nextRevision == _saveRevision) {
            state = AsyncValue.data(saved);
          }
          if (!_isDisposed) {
            ref.invalidate(characterSheetProvider(_characterId));
            ref.invalidate(offlineCharacterRecordProvider(_characterId));
          }
          if (!_isDisposed &&
              nextRevision == _saveRevision &&
              !_syncReloadRequested) {
            _setLocalSavePending(false);
          }
          if (activeCompleter?.isCompleted == false) {
            activeCompleter!.complete();
          }
        } catch (error, stackTrace) {
          if (!_isDisposed && nextRevision == _saveRevision) {
            final rollbackCharacter =
                _lastPersistedCharacter ?? state.valueOrNull ?? nextCharacter;
            state = AsyncValue.data(rollbackCharacter);
            _setLocalSavePending(false);
            if (activeCompleter?.isCompleted == false) {
              activeCompleter!.completeError(error, stackTrace);
            }
            return;
          }
          if (activeCompleter?.isCompleted == false) {
            activeCompleter!.complete();
          }
        }

        final pending = _pendingSave;
        if (pending == null) {
          return;
        }

        nextCharacter = pending;
        nextRevision = _pendingSaveRevision;
        activeCompleter = _pendingSaveCompleter;
        _activeSaveCompleter = activeCompleter;
        _pendingSave = null;
        _pendingSaveRevision = 0;
        _pendingSaveCompleter = null;
      }
    } finally {
      _isPersisting = false;
      _activeSaveCompleter = null;
      if (_syncReloadRequested && !_isDisposed) {
        unawaited(_reloadFromLocalStoreWhenIdle());
      }
    }
  }

  void _setLocalSavePending(bool value) {
    if (_isDisposed) return;
    ref
        .read(characterSheetLocalSavePendingProvider(_characterId).notifier)
        .state = value;
    if (!value && _syncReloadRequested) {
      unawaited(_reloadFromLocalStoreWhenIdle());
    }
  }
}
