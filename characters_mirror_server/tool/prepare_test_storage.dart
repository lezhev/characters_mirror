import 'dart:io';

import 'package:characters_mirror_server/src/storage/object_storage_config.dart';
import 'package:minio/minio.dart';

Future<void> main() async {
  try {
    final config = ObjectStorageConfig.fromEnvironment();
    final client = Minio(
      endPoint: config.host,
      port: config.port,
      accessKey: config.accessKey,
      secretKey: config.secretKey,
      useSSL: config.useSsl,
      region: config.region,
      pathStyle: config.pathStyle,
    );
    if (!await client.bucketExists(config.bucket)) {
      await client.makeBucket(config.bucket, config.region);
    }
    stdout.writeln('Integration-test storage bucket is ready.');
  } catch (error) {
    stderr.writeln(
      'Could not prepare integration-test storage (${error.runtimeType}).',
    );
    exitCode = 1;
  }
}
