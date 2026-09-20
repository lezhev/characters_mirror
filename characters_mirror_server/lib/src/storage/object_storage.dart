import 'dart:typed_data';

abstract interface class ObjectStorage {
  Future<void> put({
    required String key,
    required Stream<Uint8List> data,
    required int size,
  });

  Future<void> delete(String key);

  Future<Uri> createGetUrl(
    String key, {
    Duration expiresIn = const Duration(minutes: 15),
    String? responseContentType,
  });

  Future<Uri> createPutUrl(
    String key, {
    Duration expiresIn = const Duration(minutes: 5),
  });
}
