import 'package:characters_mirror_flutter/src/serverpod_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/data/repositories/generic_repository.dart';

final characterRepositoryProvider = Provider(
  (ref) => GenericRepository<CharacterData>(
    client,
    (client) => client.characterData,
  ),
);
