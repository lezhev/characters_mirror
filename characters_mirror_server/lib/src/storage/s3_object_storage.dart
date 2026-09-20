import 'dart:typed_data';

import 'package:minio/minio.dart';

import 'object_storage.dart';
import 'object_storage_config.dart';

final class S3ObjectStorage implements ObjectStorage {
  S3ObjectStorage(ObjectStorageConfig config)
      : _bucket = config.bucket,
        _client = Minio(
          endPoint: config.host,
          port: config.port,
          accessKey: config.accessKey,
          secretKey: config.secretKey,
          useSSL: config.useSsl,
          region: config.region,
          pathStyle: config.pathStyle,
        );

  static const _maxPresignedUrlLifetime = Duration(days: 7);

  final Minio _client;
  final String _bucket;

  @override
  Future<void> put({
    required String key,
    required Stream<Uint8List> data,
    required int size,
  }) async {
    _validateKey(key);

    if (size < 0) {
      throw ArgumentError.value(
        size,
        'size',
        'Object size cannot be negative.',
      );
    }

    await _client.putObject(
      _bucket,
      key,
      data,
      size: size,
    );
  }

  @override
  Future<void> delete(String key) async {
    _validateKey(key);

    await _client.removeObject(
      _bucket,
      key,
    );
  }

  @override
  Future<Uri> createGetUrl(
    String key, {
    Duration expiresIn = const Duration(minutes: 15),
    String? responseContentType,
  }) async {
    _validateKey(key);
    _validateExpiration(expiresIn);

    final url = await _client.presignedGetObject(
      _bucket,
      key,
      expires: expiresIn.inSeconds,
      respHeaders: responseContentType == null
          ? null
          : {
              'response-content-type': responseContentType,
            },
    );

    return Uri.parse(url);
  }

  static void _validateKey(String key) {
    if (key.trim().isEmpty) {
      throw ArgumentError.value(
        key,
        'key',
        'Object key cannot be empty.',
      );
    }
  }

  static void _validateExpiration(Duration duration) {
    if (duration <= Duration.zero) {
      throw ArgumentError.value(
        duration,
        'expiresIn',
        'Expiration must be greater than zero.',
      );
    }

    if (duration > _maxPresignedUrlLifetime) {
      throw ArgumentError.value(
        duration,
        'expiresIn',
        'Presigned URL lifetime cannot exceed 7 days.',
      );
    }
  }

  @override
  Future<Uri> createPutUrl(
    String key, {
    Duration expiresIn = const Duration(minutes: 5),
  }) async {
    _validateKey(key);
    _validateExpiration(expiresIn);

    final url = await _client.presignedPutObject(
      _bucket,
      key,
      expires: expiresIn.inSeconds,
    );

    return Uri.parse(url);
  }
}
