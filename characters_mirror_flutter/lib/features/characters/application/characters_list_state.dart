import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final charactersListControllerProvider = StateNotifierProvider.autoDispose<
    CharactersListController, CharactersListState>((ref) {
  final controller = CharactersListController(CharacterRepository());
  final coordinator = offlineSyncCoordinator;
  if (coordinator != null) {
    void reloadAfterSync() => controller.reloadFromStore();

    coordinator.addListener(reloadAfterSync);
    ref.onDispose(() => coordinator.removeListener(reloadAfterSync));
  }
  return controller;
});

class CharactersListState {
  const CharactersListState({
    this.characters = const AsyncValue<List<CharacterData>>.loading(),
    this.offlineRecordsByCharacterId = const {},
    this.armedDeleteCharacterId,
    this.deletingCharacterId,
  });

  final AsyncValue<List<CharacterData>> characters;
  final Map<int, OfflineCharacterRecord> offlineRecordsByCharacterId;
  final int? armedDeleteCharacterId;
  final int? deletingCharacterId;

  CharactersListState copyWith({
    AsyncValue<List<CharacterData>>? characters,
    Map<int, OfflineCharacterRecord>? offlineRecordsByCharacterId,
    int? armedDeleteCharacterId,
    bool clearArmedDeleteCharacterId = false,
    int? deletingCharacterId,
    bool clearDeletingCharacterId = false,
  }) {
    return CharactersListState(
      characters: characters ?? this.characters,
      offlineRecordsByCharacterId:
          offlineRecordsByCharacterId ?? this.offlineRecordsByCharacterId,
      armedDeleteCharacterId: clearArmedDeleteCharacterId
          ? null
          : armedDeleteCharacterId ?? this.armedDeleteCharacterId,
      deletingCharacterId: clearDeletingCharacterId
          ? null
          : deletingCharacterId ?? this.deletingCharacterId,
    );
  }
}

class CharactersListActionResult {
  const CharactersListActionResult({
    required this.success,
    required this.message,
  });

  final bool success;
  final String message;
}

class CharactersListController extends StateNotifier<CharactersListState> {
  CharactersListController(this._repository)
      : super(const CharactersListState()) {
    reload();
  }

  final CharacterRepository _repository;

  Future<void> reload() async {
    if (!state.characters.hasValue) {
      state = state.copyWith(
        characters: const AsyncValue<List<CharacterData>>.loading(),
      );
    }

    try {
      final characters = await _repository.getAll();
      final offlineRecords = await _repository.getOfflineRecords();
      state = state.copyWith(
        characters: AsyncValue.data(characters),
        offlineRecordsByCharacterId: {
          for (final record in offlineRecords) record.localId: record,
        },
        armedDeleteCharacterId: _resolveArmedDeleteCharacterId(
            characters, state.armedDeleteCharacterId),
        clearDeletingCharacterId: true,
      );
    } catch (error, stackTrace) {
      state = state.copyWith(
        characters: AsyncValue.error(error, stackTrace),
        clearDeletingCharacterId: true,
      );
    }
  }

  Future<void> reloadFromStore() async {
    try {
      final records = await _repository.getOfflineRecords();
      if (!mounted) return;
      final characters = [for (final record in records) record.character];
      state = state.copyWith(
        characters: AsyncValue.data(characters),
        offlineRecordsByCharacterId: {
          for (final record in records) record.localId: record,
        },
        armedDeleteCharacterId: _resolveArmedDeleteCharacterId(
          characters,
          state.armedDeleteCharacterId,
        ),
      );
    } catch (_) {
      // A background refresh keeps the last usable list on local read errors.
    }
  }

  void armDeleteCharacter(int id) {
    if (state.deletingCharacterId != null) {
      return;
    }

    state = state.copyWith(armedDeleteCharacterId: id);
  }

  void disarmDeleteCharacter() {
    if (state.armedDeleteCharacterId == null) {
      return;
    }

    state = state.copyWith(clearArmedDeleteCharacterId: true);
  }

  Future<CharactersListActionResult> deleteCharacter(int id) async {
    if (state.deletingCharacterId != null) {
      return const CharactersListActionResult(
        success: false,
        message: 'Удаление уже выполняется.',
      );
    }

    final previousCharacters = state.characters;
    final previousOfflineRecords = state.offlineRecordsByCharacterId;
    final currentCharacters =
        state.characters.hasValue ? state.characters.value : null;
    final optimisticCharacters = currentCharacters
        ?.where((character) => character.id != id)
        .toList(growable: false);
    final optimisticOfflineRecords =
        Map<int, OfflineCharacterRecord>.of(previousOfflineRecords)..remove(id);

    state = state.copyWith(
      characters: optimisticCharacters == null
          ? null
          : AsyncValue.data(optimisticCharacters),
      offlineRecordsByCharacterId: optimisticOfflineRecords,
      clearArmedDeleteCharacterId: true,
      deletingCharacterId: id,
    );

    try {
      await _repository.delete(id);
    } catch (error) {
      state = state.copyWith(
        characters: previousCharacters,
        offlineRecordsByCharacterId: previousOfflineRecords,
        clearArmedDeleteCharacterId: true,
        clearDeletingCharacterId: true,
      );

      return const CharactersListActionResult(
        success: false,
        message: 'Не удалось удалить персонажа. Попробуйте ещё раз.',
      );
    }

    try {
      final offlineRecords = await _repository.getOfflineRecords();
      state = state.copyWith(
        offlineRecordsByCharacterId: {
          for (final record in offlineRecords) record.localId: record,
        },
        clearDeletingCharacterId: true,
      );
    } catch (_) {
      state = state.copyWith(clearDeletingCharacterId: true);
    }

    return const CharactersListActionResult(
      success: true,
      message: 'Персонаж удалён.',
    );
  }

  int? _resolveArmedDeleteCharacterId(
    List<CharacterData> characters,
    int? armedDeleteCharacterId,
  ) {
    if (armedDeleteCharacterId == null) {
      return null;
    }

    final exists =
        characters.any((character) => character.id == armedDeleteCharacterId);
    return exists ? armedDeleteCharacterId : null;
  }
}
