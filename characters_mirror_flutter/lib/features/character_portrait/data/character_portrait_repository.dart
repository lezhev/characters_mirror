import 'dart:typed_data';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:http/http.dart' as http;

class CharacterPortraitRepository {
  CharacterPortraitRepository({
    required Client client,
    http.Client? httpClient,
  })  : _client = client,
        _httpClient = httpClient ?? http.Client();

  final Client _client;
  final http.Client _httpClient;

  Future<Uri> createUploadUrl(int characterId) async {
    final url = await _client.characterPortrait.createUploadUrl(
      characterId,
    );

    return Uri.parse(url);
  }

  Future<int> confirmUpload(int characterId) {
    return _client.characterPortrait.confirmUpload(characterId);
  }

  Future<Uri?> getUrl(int characterId) async {
    final url = await _client.characterPortrait.getUrl(
      characterId,
    );

    if (url == null) {
      return null;
    }

    return Uri.parse(url);
  }

  Future<void> deletePortrait(int characterId) {
    return _client.characterPortrait.deletePortrait(characterId);
  }

  Future<int> uploadPortrait({
    required int characterId,
    required Uint8List bytes,
  }) async {
    final uploadUrl = await createUploadUrl(characterId);

    final response = await _httpClient.put(
      uploadUrl,
      headers: const {
        'Content-Type': 'image/webp',
      },
      body: bytes,
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw CharacterPortraitUploadException(
        statusCode: response.statusCode,
      );
    }

    return confirmUpload(characterId);
  }

  void dispose() {
    _httpClient.close();
  }
}

class CharacterPortraitUploadException implements Exception {
  const CharacterPortraitUploadException({
    required this.statusCode,
  });

  final int statusCode;

  @override
  String toString() {
    return 'Character portrait upload failed with HTTP $statusCode.';
  }
}
