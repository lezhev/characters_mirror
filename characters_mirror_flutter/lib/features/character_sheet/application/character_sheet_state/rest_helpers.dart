part of '../character_sheet_state.dart';

Map<String, int>? _restoredHitDiceForLongRest(CharacterData character) {
  final maxHitDice = effectiveHitDiceMaxFromCharacter(character);
  if (maxHitDice.isEmpty) {
    return null;
  }

  final currentHitDice = effectiveCurrentHitDice(
    character.currentHitDice,
    maxHitDice,
  );
  var remaining =
      maxHitDice.values.fold<int>(0, (sum, value) => sum + value) ~/ 2;
  if (remaining <= 0) {
    remaining = 1;
  }

  final restored = <String, int>{...currentHitDice};
  final keys = maxHitDice.keys.toList()
    ..sort((left, right) {
      final sizeCompare = _hitDieSize(right).compareTo(_hitDieSize(left));
      if (sizeCompare != 0) {
        return sizeCompare;
      }
      return left.compareTo(right);
    });

  for (final key in keys) {
    if (remaining <= 0) {
      break;
    }

    final max = maxHitDice[key] ?? 0;
    final current = restored[key] ?? max;
    final missing = max - current;
    if (missing <= 0) {
      continue;
    }

    final recovered = missing < remaining ? missing : remaining;
    restored[key] = current + recovered;
    remaining -= recovered;
  }

  return normalizeCurrentHitDiceForSave(restored, maxHitDice);
}

int _hitDieSize(String key) {
  final normalized = key.trim().toLowerCase();
  if (!normalized.startsWith('d')) {
    return 0;
  }
  return int.tryParse(normalized.substring(1)) ?? 0;
}

String _featureResourceKey(
  CharacterFeatureSourceType sourceType,
  int sourceId,
  String resourceKey,
) {
  return '${sourceType.name}:$sourceId:$resourceKey';
}

CharacterResourceViewData? _featureResource(
  CharacterFeatureViewData feature,
  String resourceKey,
) {
  for (final resource
      in feature.resources ?? const <CharacterResourceViewData>[]) {
    if (resource.key == resourceKey) {
      return resource;
    }
  }
  return null;
}

List<FeatureTag>? _normalizedFeatureTags(
  List<FeatureTag>? tags, {
  required bool preserveEmpty,
}) {
  if (tags == null) {
    return null;
  }

  final normalized = {...tags}.toList()
    ..sort((a, b) => a.name.compareTo(b.name));
  if (normalized.isEmpty && !preserveEmpty) {
    return null;
  }
  return normalized;
}

bool _featureTagsEqual(
  List<FeatureTag>? left,
  List<FeatureTag>? right, {
  required bool preserveEmpty,
}) {
  final normalizedLeft = _normalizedFeatureTags(
    left,
    preserveEmpty: preserveEmpty,
  );
  final normalizedRight = _normalizedFeatureTags(
    right,
    preserveEmpty: preserveEmpty,
  );
  if (normalizedLeft == null || normalizedRight == null) {
    return normalizedLeft == normalizedRight;
  }
  return listEquals(normalizedLeft, normalizedRight);
}
