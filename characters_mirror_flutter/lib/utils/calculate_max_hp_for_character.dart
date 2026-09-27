import 'dart:math' as math;

import 'package:characters_mirror_client/characters_mirror_client.dart';

int calculateMaxHpForCharacter(
  CharacterData character, {
  List<CharacterClassEntryData>? classEntries,
  int? hpPerLevelBonus,
  int? hpFlatBonus,
}) {
  final entries = classEntries ??
      character.classEntries ??
      const <CharacterClassEntryData>[];
  final descriptors = hitPointLevelDescriptors(entries);
  final constitutionModifier =
      character.derived?.abilityModifiers?[Ability.constitution] ?? 0;
  var total = 0;
  for (final descriptor in descriptors) {
    total += descriptor.value + constitutionModifier;
  }
  total +=
      descriptors.length * (hpPerLevelBonus ?? character.hpPerLevelBonus ?? 0);
  total += hpFlatBonus ?? character.hpFlatBonus ?? 0;
  return math.max(1, total);
}

List<HitPointLevelDescriptor> hitPointLevelDescriptors(
  List<CharacterClassEntryData> entries,
) {
  final indexedEntries = [
    for (var index = 0; index < entries.length; index++)
      _IndexedClassEntry(index, entries[index]),
  ]..sort((left, right) {
      final orderCompare =
          (left.entry.classOrder ?? 0).compareTo(right.entry.classOrder ?? 0);
      if (orderCompare != 0) {
        return orderCompare;
      }
      return left.index.compareTo(right.index);
    });

  final result = <HitPointLevelDescriptor>[];
  var characterLevel = 0;
  for (final indexedEntry in indexedEntries) {
    final entry = indexedEntry.entry;
    final level = math.max(0, entry.level ?? 0);
    final hitDie = math.max(1, entry.classData?.hitDieValue ?? 8);
    final values = entry.hpRolledValues ?? const <int>[];
    for (var levelIndex = 0; levelIndex < level; levelIndex++) {
      characterLevel++;
      final defaultValue = defaultHpGain(
        hitDie,
        isFirstCharacterLevel: characterLevel == 1,
      );
      final explicitValue =
          levelIndex < values.length ? values[levelIndex] : defaultValue;
      result.add(
        HitPointLevelDescriptor(
          entryIndex: indexedEntry.index,
          entry: entry,
          levelIndex: levelIndex,
          characterLevel: characterLevel,
          hitDie: hitDie,
          defaultGain: defaultValue,
          value: normalizeHpGain(explicitValue, hitDie),
        ),
      );
    }
  }
  return result;
}

class _IndexedClassEntry {
  const _IndexedClassEntry(this.index, this.entry);

  final int index;
  final CharacterClassEntryData entry;
}

class HitPointLevelDescriptor {
  const HitPointLevelDescriptor({
    required this.entryIndex,
    required this.entry,
    required this.levelIndex,
    required this.characterLevel,
    required this.hitDie,
    required this.defaultGain,
    required this.value,
  });
  final int entryIndex;
  final CharacterClassEntryData entry;
  final int levelIndex;
  final int characterLevel;
  final int hitDie;
  final int defaultGain;
  final int value;
}

int defaultHpGain(int hitDie, {required bool isFirstCharacterLevel}) {
  if (isFirstCharacterLevel) {
    return math.max(1, hitDie);
  }
  return math.max(1, (hitDie ~/ 2) + 1);
}

int normalizeHpGain(int value, int hitDie) {
  return value.clamp(1, math.max(1, hitDie)).toInt();
}
