import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final charactersListControllerProvider = StateNotifierProvider.autoDispose<
    CharactersListController, CharactersListState>((ref) {
  return CharactersListController(CharacterRepository());
});

class CharactersListState {
  const CharactersListState({
    this.characters = const AsyncValue<List<CharacterData>>.loading(),
    this.armedDeleteCharacterId,
    this.deletingCharacterId,
  });

  final AsyncValue<List<CharacterData>> characters;
  final int? armedDeleteCharacterId;
  final int? deletingCharacterId;

  CharactersListState copyWith({
    AsyncValue<List<CharacterData>>? characters,
    int? armedDeleteCharacterId,
    bool clearArmedDeleteCharacterId = false,
    int? deletingCharacterId,
    bool clearDeletingCharacterId = false,
  }) {
    return CharactersListState(
      characters: characters ?? this.characters,
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
      state = state.copyWith(
        characters: AsyncValue.data(characters),
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

    state = state.copyWith(deletingCharacterId: id);

    try {
      await _repository.delete(id);
      final characters = await _repository.getAll();
      state = state.copyWith(
        characters: AsyncValue.data(characters),
        clearArmedDeleteCharacterId: true,
        clearDeletingCharacterId: true,
      );

      return const CharactersListActionResult(
        success: true,
        message: 'Персонаж удалён.',
      );
    } catch (error) {
      state = state.copyWith(clearDeletingCharacterId: true);

      return const CharactersListActionResult(
        success: false,
        message: 'Не удалось удалить персонажа. Попробуйте ещё раз.',
      );
    }
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
