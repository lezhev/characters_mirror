import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'level_up_gateway.dart';

class LevelUpRepository implements LevelUpGateway {
  LevelUpRepository(this.characters);
  final CharacterRepository characters;
  @override
  Future<LevelUpPreview> preview(LevelUpRequest request) =>
      client.characterData.previewLevelUp(request);
  @override
  Future<CharacterData> apply(LevelUpRequest request) =>
      characters.applyLevelUp(request);
}
