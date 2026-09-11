import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_mutation_stamper.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/character_model_extensions.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_proficiency_state.dart';
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
  bool _isPersisting = false;
  CharacterData? _lastPersistedCharacter;
  CharacterData? _pendingSave;
  int _pendingSaveRevision = 0;
  Completer<void>? _pendingSaveCompleter;

  @override
  Future<CharacterData> build(int characterId) async {
    _characterId = characterId;
    _repository = ref.watch(characterRepositoryProvider);
    final character = await _repository.getCharacter(characterId);
    _lastPersistedCharacter = character;
    return character;
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

  CharacterData _requireCharacter() {
    final current = state.valueOrNull;
    if (current == null) {
      throw StateError('Character sheet is not loaded yet.');
    }
    return current;
  }

  Future<void> _saveCharacter(CharacterData updated) async {
    final previous = _requireCharacter();
    final stamped = stampCharacterMutation(previous: previous, next: updated);
    final revision = ++_saveRevision;
    state = AsyncValue.data(stamped);

    if (_isPersisting) {
      if (_pendingSaveCompleter?.isCompleted == false) {
        _pendingSaveCompleter!.complete();
      }
      _pendingSave = stamped;
      _pendingSaveRevision = revision;
      _pendingSaveCompleter = Completer<void>();
      return _pendingSaveCompleter!.future;
    }

    await _persistSaves(stamped, revision);
  }

  Future<void> _persistSaves(CharacterData initial, int initialRevision) async {
    _isPersisting = true;
    var nextCharacter = initial;
    var nextRevision = initialRevision;
    Completer<void>? activeCompleter;

    try {
      while (true) {
        try {
          final saved = await _repository.saveCharacter(nextCharacter);
          _lastPersistedCharacter = saved;
          if (nextRevision == _saveRevision) {
            state = AsyncValue.data(saved);
          }
          ref.invalidate(characterSheetProvider(_characterId));
          ref.invalidate(offlineCharacterRecordProvider(_characterId));
          if (activeCompleter?.isCompleted == false) {
            activeCompleter!.complete();
          }
        } catch (error, stackTrace) {
          if (nextRevision == _saveRevision) {
            final rollbackCharacter =
                _lastPersistedCharacter ?? state.valueOrNull ?? nextCharacter;
            state = AsyncValue.data(rollbackCharacter);
            if (activeCompleter?.isCompleted == false) {
              activeCompleter!.completeError(error, stackTrace);
            }
            Error.throwWithStackTrace(error, stackTrace);
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
        _pendingSave = null;
        _pendingSaveRevision = 0;
        _pendingSaveCompleter = null;
      }
    } finally {
      _isPersisting = false;
    }
  }
}
