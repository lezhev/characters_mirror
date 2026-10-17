import 'dart:typed_data';

import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';
import 'package:characters_mirror_flutter/features/character_portrait/data/character_portrait_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final characterPortraitRepositoryProvider =
    Provider<CharacterPortraitRepository>((ref) {
      final repository = CharacterPortraitRepository(client: client);

      ref.onDispose(repository.dispose);
      return repository;
    });

final characterPortraitControllerProvider = AsyncNotifierProvider.autoDispose
    .family<CharacterPortraitController, Uri?, int>(
      CharacterPortraitController.new,
    );

class CharacterPortraitController extends AsyncNotifier<Uri?> {
  CharacterPortraitController(this._characterId);

  late final CharacterPortraitRepository _repository;
  final int _characterId;

  @override
  Future<Uri?> build() async {
    _repository = ref.watch(characterPortraitRepositoryProvider);

    return _repository.getUrl(_characterId);
  }

  Future<void> upload(Uint8List bytes) async {
    state = const AsyncLoading();

    try {
      await _repository.uploadPortrait(characterId: _characterId, bytes: bytes);
      if (!ref.mounted) return;
      final url = await _repository.getUrl(_characterId);
      if (ref.mounted) state = AsyncData(url);
    } catch (error, stackTrace) {
      if (ref.mounted) state = AsyncError(error, stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> delete() async {
    state = const AsyncLoading();

    final result = await AsyncValue.guard<Uri?>(() async {
      await _repository.deletePortrait(_characterId);
      return null;
    });
    if (ref.mounted) state = result;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    final result = await AsyncValue.guard(
      () => _repository.getUrl(_characterId),
    );
    if (ref.mounted) state = result;
  }
}
