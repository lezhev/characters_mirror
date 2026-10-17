import 'dart:async';
import 'dart:typed_data';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_portrait/application/character_portrait_controller.dart';
import 'package:characters_mirror_flutter/features/character_portrait/data/character_portrait_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Client client;
  late _PortraitRepository repository;
  late ProviderContainer container;

  setUp(() {
    client = Client('http://127.0.0.1:8083/');
    repository = _PortraitRepository(client);
    container = ProviderContainer(
      retry: (retryCount, error) => null,
      overrides: [
        characterPortraitRepositoryProvider.overrideWithValue(repository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
    repository.dispose();
    client.close();
  });

  test('portrait families keep character ids and state independent', () async {
    final first = characterPortraitControllerProvider(41);
    final second = characterPortraitControllerProvider(52);
    final firstSubscription = container.listen(first, (_, _) {});
    final secondSubscription = container.listen(second, (_, _) {});
    addTearDown(firstSubscription.close);
    addTearDown(secondSubscription.close);

    expect(await container.read(first.future), _url(41));
    expect(await container.read(second.future), _url(52));
    await container.read(first.notifier).upload(Uint8List(1));

    expect(repository.uploadIds, [41]);
    expect(repository.getIds, [41, 52, 41]);
    expect(container.read(first).requireValue, _url(41));
    expect(container.read(second).requireValue, _url(52));
  });

  for (final action in ['upload', 'delete', 'refresh']) {
    test('$action completes after its controller is disposed', () async {
      final provider = characterPortraitControllerProvider(41);
      final subscription = container.listen(provider, (_, _) {});
      await container.read(provider.future);
      final controller = container.read(provider.notifier);
      final completion = Completer<void>();
      final Future<void> operation;
      switch (action) {
        case 'upload':
          repository.uploadResult = completion.future.then((_) => 1);
          operation = controller.upload(Uint8List(1));
        case 'delete':
          repository.deleteResult = completion.future;
          operation = controller.delete();
        default:
          repository.urlResult = completion.future.then((_) => _url(41));
          operation = controller.refresh();
      }

      subscription.close();
      await container.pump();
      expect(container.exists(provider), isFalse);
      completion.complete();
      await expectLater(operation, completes);
      expect(container.exists(provider), isFalse);
    });
  }

  test('disposed upload still returns the original repository error', () async {
    final provider = characterPortraitControllerProvider(41);
    final subscription = container.listen(provider, (_, _) {});
    await container.read(provider.future);
    final completion = Completer<int>();
    repository.uploadResult = completion.future;
    final operation = container.read(provider.notifier).upload(Uint8List(1));
    final failure = StateError('upload failed');
    final result = expectLater(operation, throwsA(same(failure)));

    subscription.close();
    await container.pump();
    completion.completeError(failure);
    await result;
  });
}

Uri _url(int id) => Uri.https('example.invalid', '/portrait/$id');

class _PortraitRepository extends CharacterPortraitRepository {
  _PortraitRepository(Client client) : super(client: client);

  final getIds = <int>[];
  final uploadIds = <int>[];
  Future<int>? uploadResult;
  Future<void>? deleteResult;
  Future<Uri?>? urlResult;

  @override
  Future<Uri?> getUrl(int characterId) {
    getIds.add(characterId);
    return urlResult ?? Future.value(_url(characterId));
  }

  @override
  Future<int> uploadPortrait({
    required int characterId,
    required Uint8List bytes,
  }) {
    uploadIds.add(characterId);
    return uploadResult ?? Future.value(1);
  }

  @override
  Future<void> deletePortrait(int characterId) {
    return deleteResult ?? Future.value();
  }
}
