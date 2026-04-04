import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final raceRepositoryProvider = Provider<RaceRepository>((ref) {
  return RaceRepository();
});

final classRepositoryProvider = Provider<ClassRepository>((ref) {
  return ClassRepository();
});

final backgroundRepositoryProvider = Provider<BackgroundRepository>((ref) {
  return BackgroundRepository();
});
