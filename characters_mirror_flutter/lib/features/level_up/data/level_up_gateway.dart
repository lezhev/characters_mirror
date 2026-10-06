import 'package:characters_mirror_client/characters_mirror_client.dart';

abstract interface class LevelUpGateway {
  Future<LevelUpPreview> preview(LevelUpRequest request);
  Future<CharacterData> apply(LevelUpRequest request);
}
