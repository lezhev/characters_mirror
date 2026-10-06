import 'dart:math';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/utils/get_level_by_xp.dart';

class LevelExperience {
  LevelExperience(CharacterData character)
      : level = max(
            1,
            character.derived?.totalLevel ??
                (character.classEntries ?? const <CharacterClassEntryData>[])
                    .fold<int>(0, (sum, e) => sum + (e.level ?? 0))),
        experience = max(0, character.experience ?? 0);
  final int level;
  final int experience;
  int get start => xpThresholds[min(level, 20) - 1];
  int? get next => level >= 20 ? null : xpThresholds[level];
  int get remaining => next == null ? 0 : max(0, next! - experience);
  double get progress => next == null
      ? 1
      : ((experience - start) / (next! - start)).clamp(0.0, 1.0);
}
