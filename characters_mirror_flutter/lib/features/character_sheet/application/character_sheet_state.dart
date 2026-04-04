import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_sheet_state.g.dart';

final characterRepositoryProvider = Provider<CharacterRepository>((ref) {
  return CharacterRepository();
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

  @override
  Future<CharacterData> build(int characterId) async {
    _characterId = characterId;
    _repository = ref.watch(characterRepositoryProvider);
    return _repository.getCharacter(characterId);
  }

  Future<void> reload() async {
    state =
        await AsyncValue.guard(() => _repository.getCharacter(_characterId));
  }

  Future<void> addAttack(CharacterAttackData attack) async {
    final current = _requireCharacter();
    final attacks = [...?current.attacks, attack];
    await _saveCharacter(current.copyWith(attacks: attacks));
  }

  Future<void> updateAttack(int index, CharacterAttackData attack) async {
    final current = _requireCharacter();
    final attacks = [...?current.attacks];
    if (index < 0 || index >= attacks.length) {
      throw RangeError.index(index, attacks, 'index');
    }

    attacks[index] = attack;
    await _saveCharacter(current.copyWith(attacks: attacks));
  }

  Future<void> deleteAttack(int index) async {
    final current = _requireCharacter();
    final attacks = [...?current.attacks];
    if (index < 0 || index >= attacks.length) {
      throw RangeError.index(index, attacks, 'index');
    }

    attacks.removeAt(index);
    await _saveCharacter(current.copyWith(attacks: attacks));
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
    final revision = ++_saveRevision;
    state = AsyncValue.data(updated);

    try {
      final saved = await _repository.saveCharacter(updated);
      if (revision == _saveRevision) {
        state = AsyncValue.data(saved);
        ref.invalidate(characterSheetProvider(_characterId));
      }
    } catch (error, stackTrace) {
      if (revision == _saveRevision) {
        state = AsyncValue.data(previous);
      }
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
