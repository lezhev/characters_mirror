import 'dart:typed_data';

import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';
import 'package:characters_mirror_flutter/features/character_portrait/data/character_portrait_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final characterPortraitRepositoryProvider =
    Provider<CharacterPortraitRepository>((ref) {
  final repository = CharacterPortraitRepository(
    client: client,
  );

  ref.onDispose(repository.dispose);
  return repository;
});

final characterPortraitControllerProvider = AsyncNotifierProvider.autoDispose
    .family<CharacterPortraitController, Uri?, int>(
  CharacterPortraitController.new,
);

class CharacterPortraitController
    extends AutoDisposeFamilyAsyncNotifier<Uri?, int> {
  late final CharacterPortraitRepository _repository;
  late final int _characterId;

  @override
  Future<Uri?> build(int characterId) async {
    _characterId = characterId;
    _repository = ref.watch(characterPortraitRepositoryProvider);

    return _repository.getUrl(characterId);
  }

  Future<void> upload(Uint8List bytes) async {
    state = const AsyncLoading();

    try {
      await _repository.uploadPortrait(
        characterId: _characterId,
        bytes: bytes,
      );

      state = AsyncData(
        await _repository.getUrl(_characterId),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> delete() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _repository.deletePortrait(_characterId);
      return null;
    });
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => _repository.getUrl(_characterId),
    );
  }
}
