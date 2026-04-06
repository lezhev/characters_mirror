import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/repositories/repository_base.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';

class CharacterRepository implements Repository<CharacterData> {
  @override
  Future<List<CharacterData>> getAll() => client.characterData.getAll();

  @override
  Future<CharacterData?> getById(int id) => client.characterData.getCharacter(id);

  Future<CharacterData> saveCharacter(CharacterData character) =>
      client.characterData.saveCharacter(character);

  Future<CharacterData> getCharacter(int characterId) =>
      client.characterData.getCharacter(characterId);

  @override
  Future<CharacterData> upsert(CharacterData entity) => saveCharacter(entity);

  @override
  Future<void> delete(int id) => client.characterData.delete(id);
}
