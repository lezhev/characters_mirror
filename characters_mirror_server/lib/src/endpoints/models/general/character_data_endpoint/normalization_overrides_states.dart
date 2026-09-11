part of '../character_data_endpoint.dart';

List<CharacterFeatureOverrideData> _normalizedFeatureOverrides(
  List<CharacterFeatureOverrideData>? overrides,
) {
  final normalized = <CharacterFeatureOverrideData>[];

  for (final override in overrides ?? const <CharacterFeatureOverrideData>[]) {
    final name = _normalizedTextOrNull(override.name);
    final description = _normalizedTextOrNull(override.description);
    final tags = _normalizedFeatureTags(override.tags, preserveEmpty: true);
    if (name == null && description == null && tags == null) {
      continue;
    }

    final candidate = CharacterFeatureOverrideData(
      sourceType: override.sourceType,
      sourceId: override.sourceId,
      name: name,
      description: description,
      tags: tags,
    );

    final existingIndex = normalized.indexWhere(
      (item) =>
          item.sourceType == candidate.sourceType &&
          item.sourceId == candidate.sourceId,
    );
    if (existingIndex >= 0) {
      normalized[existingIndex] = candidate;
    } else {
      normalized.add(candidate);
    }
  }

  normalized.sort((a, b) {
    final sourceCompare = _featureSourceOrder(a.sourceType)
        .compareTo(_featureSourceOrder(b.sourceType));
    if (sourceCompare != 0) {
      return sourceCompare;
    }
    return a.sourceId.compareTo(b.sourceId);
  });
  return normalized;
}

List<CharacterResourceStateData> _normalizedResourceStates(
  List<CharacterResourceStateData>? states,
) {
  final normalized = <CharacterResourceStateData>[];

  for (final state in states ?? const <CharacterResourceStateData>[]) {
    if (state.current < 0) {
      continue;
    }
    final candidate = CharacterResourceStateData(
      sourceType: state.sourceType,
      sourceId: state.sourceId,
      resourceKey: _normalizedTextOrNull(state.resourceKey) ?? 'main',
      current: state.current,
    );
    final existingIndex = normalized.indexWhere(
      (item) =>
          item.sourceType == candidate.sourceType &&
          item.sourceId == candidate.sourceId &&
          item.resourceKey == candidate.resourceKey,
    );
    if (existingIndex >= 0) {
      normalized[existingIndex] = candidate;
    } else {
      normalized.add(candidate);
    }
  }

  normalized.sort((a, b) {
    final sourceCompare = _featureSourceOrder(a.sourceType)
        .compareTo(_featureSourceOrder(b.sourceType));
    if (sourceCompare != 0) {
      return sourceCompare;
    }
    final idCompare = a.sourceId.compareTo(b.sourceId);
    if (idCompare != 0) {
      return idCompare;
    }
    return a.resourceKey.compareTo(b.resourceKey);
  });
  return normalized;
}

bool _isMeaningfulFeatureOverride(
  CharacterFeatureOverrideData override,
  CharacterFeatureViewData? defaultFeature,
) {
  if (defaultFeature == null) {
    return false;
  }

  return _normalizedTextOrNull(override.name) !=
          _normalizedTextOrNull(defaultFeature.defaultName) ||
      _normalizedTextOrNull(override.description) !=
          _normalizedTextOrNull(defaultFeature.defaultDescription) ||
      !_featureTagsEqual(
        override.tags,
        defaultFeature.defaultTags,
        preserveEmpty: false,
      );
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
  if (normalizedLeft.length != normalizedRight.length) {
    return false;
  }
  for (var index = 0; index < normalizedLeft.length; index++) {
    if (normalizedLeft[index] != normalizedRight[index]) {
      return false;
    }
  }
  return true;
}

String _featureOverrideKey(
  CharacterFeatureSourceType sourceType,
  int sourceId,
) {
  return '${sourceType.name}:$sourceId';
}
