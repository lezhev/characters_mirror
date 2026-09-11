import 'dart:math' as math;

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/utils/calculate_max_hp_for_character.dart';

enum HitPointAction {
  heal,
  damage,
  temporary,
}

class HitPointTotals {
  const HitPointTotals({
    required this.currentHp,
    required this.maxHp,
    required this.temporaryHp,
  });

  final int currentHp;
  final int maxHp;
  final int temporaryHp;

  HitPointTotals copyWith({
    int? currentHp,
    int? maxHp,
    int? temporaryHp,
  }) {
    return HitPointTotals(
      currentHp: currentHp ?? this.currentHp,
      maxHp: maxHp ?? this.maxHp,
      temporaryHp: temporaryHp ?? this.temporaryHp,
    );
  }
}

class SavedHitPoints {
  const SavedHitPoints({
    required this.currentHp,
    required this.temporaryHp,
  });

  final int? currentHp;
  final int? temporaryHp;
}

class HitPointSettingsDraft {
  const HitPointSettingsDraft({
    required this.classEntries,
    required this.hpPerLevelBonus,
    required this.hpFlatBonus,
    required this.currentHitDice,
    required this.hitDiceMaxOverrides,
  });

  final List<CharacterClassEntryData> classEntries;
  final int hpPerLevelBonus;
  final int hpFlatBonus;
  final Map<String, int> currentHitDice;
  final Map<String, int> hitDiceMaxOverrides;

  HitPointSettingsDraft copyWith({
    List<CharacterClassEntryData>? classEntries,
    int? hpPerLevelBonus,
    int? hpFlatBonus,
    Map<String, int>? currentHitDice,
    Map<String, int>? hitDiceMaxOverrides,
  }) {
    return HitPointSettingsDraft(
      classEntries: classEntries ?? this.classEntries,
      hpPerLevelBonus: hpPerLevelBonus ?? this.hpPerLevelBonus,
      hpFlatBonus: hpFlatBonus ?? this.hpFlatBonus,
      currentHitDice: currentHitDice ?? this.currentHitDice,
      hitDiceMaxOverrides: hitDiceMaxOverrides ?? this.hitDiceMaxOverrides,
    );
  }
}

HitPointTotals hitPointTotalsFromCharacter(CharacterData character) {
  final maxHp = math.max(0, character.derived?.maxHp ?? 0);
  return HitPointTotals(
    currentHp: (character.currentHp ?? maxHp).clamp(0, maxHp),
    maxHp: maxHp,
    temporaryHp: math.max(0, character.temporaryHp ?? 0),
  );
}

HitPointSettingsDraft hitPointSettingsFromCharacter(CharacterData character) {
  final baseHitDiceMax = baseHitDiceMaxFromCharacter(character);
  final effectiveHitDiceMax = effectiveHitDiceMaxFromCharacter(character);
  return HitPointSettingsDraft(
    classEntries: [
      for (final entry
          in character.classEntries ?? const <CharacterClassEntryData>[])
        entry.copyWith(
          hpRolledValues:
              entry.hpRolledValues == null ? null : [...entry.hpRolledValues!],
        ),
    ],
    hpPerLevelBonus: character.hpPerLevelBonus ?? 0,
    hpFlatBonus: character.hpFlatBonus ?? 0,
    currentHitDice: effectiveCurrentHitDice(
      character.currentHitDice,
      effectiveHitDiceMax,
    ),
    hitDiceMaxOverrides: normalizeHitDiceMaxOverridesForSave(
          baseHitDiceMax,
          character.hitDiceMaxOverrides ?? const <String, int>{},
        ) ??
        const <String, int>{},
  );
}

HitPointTotals applyHitPointChange({
  required HitPointTotals totals,
  required int value,
  required HitPointAction action,
}) {
  if (value <= 0) {
    return totals;
  }

  final maxHp = math.max(0, totals.maxHp);
  final currentHp = totals.currentHp.clamp(0, maxHp);
  final temporaryHp = math.max(0, totals.temporaryHp);

  switch (action) {
    case HitPointAction.heal:
      return totals.copyWith(
        currentHp: math.min(maxHp, currentHp + value),
        maxHp: maxHp,
        temporaryHp: temporaryHp,
      );
    case HitPointAction.damage:
      final absorbedByTemporary = math.min(temporaryHp, value);
      final remainingDamage = value - absorbedByTemporary;
      return totals.copyWith(
        currentHp: math.max(0, currentHp - remainingDamage),
        maxHp: maxHp,
        temporaryHp: temporaryHp - absorbedByTemporary,
      );
    case HitPointAction.temporary:
      return totals.copyWith(
        currentHp: currentHp,
        maxHp: maxHp,
        temporaryHp: temporaryHp + value,
      );
  }
}

SavedHitPoints normalizeHitPointsForSave({
  required int currentHp,
  required int maxHp,
  required int temporaryHp,
}) {
  final normalizedMaxHp = math.max(0, maxHp);
  final normalizedCurrentHp = currentHp.clamp(0, normalizedMaxHp);
  final normalizedTemporaryHp = math.max(0, temporaryHp);

  return SavedHitPoints(
    currentHp:
        normalizedCurrentHp == normalizedMaxHp ? null : normalizedCurrentHp,
    temporaryHp: normalizedTemporaryHp == 0 ? null : normalizedTemporaryHp,
  );
}

int normalizeDeathSaveCount(int? value) {
  return (value ?? 0).clamp(0, 3).toInt();
}

int? normalizeDeathSaveCountForSave(int? value) {
  final normalized = normalizeDeathSaveCount(value);
  return normalized == 0 ? null : normalized;
}

List<CharacterClassEntryData> setHpGainForLevel({
  required List<CharacterClassEntryData> entries,
  required int entryIndex,
  required int levelIndex,
  required int value,
}) {
  if (entryIndex < 0 || entryIndex >= entries.length || levelIndex < 0) {
    return entries;
  }

  final descriptors = hitPointLevelDescriptors(entries);
  final descriptor = descriptors
      .where(
        (item) =>
            item.entryIndex == entryIndex && item.levelIndex == levelIndex,
      )
      .firstOrNull;
  if (descriptor == null) {
    return entries;
  }

  final entry = entries[entryIndex];
  final gains = [...?entry.hpRolledValues];
  while (gains.length <= levelIndex) {
    final missingDescriptor = descriptors
        .where(
          (item) =>
              item.entryIndex == entryIndex && item.levelIndex == gains.length,
        )
        .firstOrNull;
    gains.add(missingDescriptor?.defaultGain ?? descriptor.defaultGain);
  }
  gains[levelIndex] = normalizeHpGain(value, descriptor.hitDie);

  final nextEntries = [...entries];
  nextEntries[entryIndex] = entry.copyWith(hpRolledValues: gains);
  return normalizeHitPointClassEntries(nextEntries);
}

List<CharacterClassEntryData> normalizeHitPointClassEntries(
  List<CharacterClassEntryData> entries,
) {
  final descriptors = hitPointLevelDescriptors(entries);
  return [
    for (var entryIndex = 0; entryIndex < entries.length; entryIndex++)
      _normalizeClassEntryHpValues(
        entries[entryIndex],
        descriptors
            .where((descriptor) => descriptor.entryIndex == entryIndex)
            .toList(),
      ),
  ];
}

CharacterClassEntryData _normalizeClassEntryHpValues(
  CharacterClassEntryData entry,
  List<HitPointLevelDescriptor> descriptors,
) {
  final values = entry.hpRolledValues;
  if (values == null || values.isEmpty || descriptors.isEmpty) {
    return entry.copyWith(hpRolledValues: null);
  }

  final normalized = <int>[];
  for (var index = 0;
      index < descriptors.length && index < values.length;
      index++) {
    normalized.add(normalizeHpGain(values[index], descriptors[index].hitDie));
  }

  while (normalized.isNotEmpty) {
    final lastIndex = normalized.length - 1;
    if (normalized[lastIndex] != descriptors[lastIndex].defaultGain) {
      break;
    }
    normalized.removeLast();
  }

  return entry.copyWith(
    hpRolledValues: normalized.isEmpty ? null : normalized,
  );
}

Map<String, int> baseHitDiceMaxFromCharacter(CharacterData character) {
  final result = <String, int>{};
  for (final entry
      in character.classEntries ?? const <CharacterClassEntryData>[]) {
    final hitDie = entry.classData?.hitDieValue;
    final level = entry.level ?? 0;
    if (hitDie == null || level <= 0) {
      continue;
    }
    final key = 'd$hitDie';
    result[key] = (result[key] ?? 0) + level;
  }
  if (result.isNotEmpty) {
    return _sortedNonNegativeMap(result);
  }

  final derived = character.derived?.hitDiceSummary;
  if (derived != null && derived.isNotEmpty) {
    return _sortedNonNegativeMap(derived);
  }

  return const <String, int>{};
}

Map<String, int> effectiveHitDiceMaxFromCharacter(CharacterData character) {
  return effectiveHitDiceMax(
    baseHitDiceMaxFromCharacter(character),
    character.hitDiceMaxOverrides,
  );
}

Map<String, int> effectiveHitDiceMax(
  Map<String, int> baseMax,
  Map<String, int>? overrides,
) {
  final result = <String, int>{..._sortedNonNegativeMap(baseMax)};
  for (final entry
      in overrides?.entries ?? const Iterable<MapEntry<String, int>>.empty()) {
    final key = entry.key.trim();
    if (key.isEmpty || !result.containsKey(key)) {
      continue;
    }
    result[key] = math.max(0, entry.value);
  }
  return _sortedNonNegativeMap(result);
}

Map<String, int> effectiveCurrentHitDice(
  Map<String, int>? current,
  Map<String, int> max,
) {
  final result = <String, int>{};
  final normalizedCurrent = current ?? const <String, int>{};
  for (final entry in _sortedNonNegativeMap(max).entries) {
    result[entry.key] = (normalizedCurrent[entry.key] ?? entry.value)
        .clamp(0, entry.value)
        .toInt();
  }
  return result;
}

Map<String, int>? normalizeCurrentHitDiceForSave(
  Map<String, int> current,
  Map<String, int> max,
) {
  final effectiveCurrent = effectiveCurrentHitDice(current, max);
  final normalizedMax = _sortedNonNegativeMap(max);
  final result = <String, int>{};
  for (final entry in effectiveCurrent.entries) {
    if (entry.value != normalizedMax[entry.key]) {
      result[entry.key] = entry.value;
    }
  }
  return result.isEmpty ? null : result;
}

Map<String, int>? normalizeHitDiceMaxOverridesForSave(
  Map<String, int> baseMax,
  Map<String, int> overrides,
) {
  final normalizedBase = _sortedNonNegativeMap(baseMax);
  final result = <String, int>{};
  for (final entry in overrides.entries) {
    final key = entry.key.trim();
    if (key.isEmpty || !normalizedBase.containsKey(key)) {
      continue;
    }
    final value = math.max(0, entry.value);
    if (value != normalizedBase[key]) {
      result[key] = value;
    }
  }
  return result.isEmpty ? null : _sortedNonNegativeMap(result);
}

int? evaluateHitPointExpression(String expression) {
  final normalized = expression.trim();
  if (normalized.isEmpty || !RegExp(r'^\d+([+-]\d+)*$').hasMatch(normalized)) {
    return null;
  }

  var result = 0;
  var currentNumber = 0;
  var operation = '+';

  for (var index = 0; index < normalized.length; index++) {
    final char = normalized[index];
    final digit = int.tryParse(char);
    if (digit != null) {
      currentNumber = currentNumber * 10 + digit;
    }

    if (char == '+' || char == '-' || index == normalized.length - 1) {
      if (operation == '+') {
        result += currentNumber;
      } else {
        result -= currentNumber;
      }
      operation = char;
      currentNumber = 0;
    }
  }

  return result;
}

Map<String, int> _sortedNonNegativeMap(Map<String, int> values) {
  final keys = values.keys.where((key) => key.trim().isNotEmpty).toList()
    ..sort();
  return {
    for (final key in keys) key.trim(): math.max(0, values[key] ?? 0),
  };
}
