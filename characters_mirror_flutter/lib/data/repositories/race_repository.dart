import 'package:characters_mirror_flutter/src/serverpod_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/data/repositories/generic_repository.dart';

final raceRepositoryProvider = Provider(
  (ref) => GenericRepository<RaceData>(
    client,
    (client) => client.raceData,
  ),
);
