import 'dart:convert';
import 'dart:typed_data';

import 'package:characters_mirror_server/src/storage/object_storage_config.dart';
import 'package:characters_mirror_server/src/storage/s3_object_storage.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  test('S3 object storage: put, get, delete', () async {
    final config = ObjectStorageConfig.fromEnvironment();
    final storage = S3ObjectStorage(config);

    const key = 'tests/object-storage-test.txt';
    const content = 'Characters Mirror object storage test';

    final bytes = Uint8List.fromList(
      utf8.encode(content),
    );

    await storage.put(
      key: key,
      data: Stream.value(bytes),
      size: bytes.length,
    );

    final url = await storage.createGetUrl(
      key,
      expiresIn: const Duration(minutes: 1),
      responseContentType: 'text/plain',
    );

    final response = await http.get(url);

    expect(response.statusCode, 200);
    expect(response.body, content);

    await storage.delete(key);

    final deletedResponse = await http.get(url);

    expect(deletedResponse.statusCode, isNot(200));
  });
}
