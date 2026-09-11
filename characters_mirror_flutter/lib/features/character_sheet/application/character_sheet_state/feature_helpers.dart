part of '../character_sheet_state.dart';

List<CharacterFeatureViewData>? _updateDerivedFeatureViews(
  List<CharacterFeatureViewData>? features,
  CharacterFeatureSourceType sourceType,
  int sourceId, {
  required String? name,
  required String? description,
  required List<FeatureTag>? tags,
  required bool isCustomized,
}) {
  if (features == null) {
    return null;
  }

  return [
    for (final feature in features)
      if (feature.sourceType == sourceType && feature.sourceId == sourceId)
        feature.copyWith(
          name: name,
          description: description,
          tags: tags,
          isCustomized: isCustomized,
          resources: [
            for (final resource
                in feature.resources ?? const <CharacterResourceViewData>[])
              resource.copyWith(name: resource.name ?? name),
          ],
        )
      else
        feature,
  ];
}

List<CharacterFeatureViewData>? _updateDerivedFeatureResource(
  List<CharacterFeatureViewData>? features,
  CharacterFeatureSourceType sourceType,
  int sourceId, {
  required String resourceKey,
  required int current,
}) {
  if (features == null) {
    return null;
  }

  return [
    for (final feature in features)
      if (feature.sourceType == sourceType && feature.sourceId == sourceId)
        feature.copyWith(
          resources: [
            for (final resource
                in feature.resources ?? const <CharacterResourceViewData>[])
              if (resource.key == resourceKey)
                resource.copyWith(current: current)
              else
                resource,
          ],
        )
      else
        feature,
  ];
}

List<CharacterResourceStateData>? _updatedResourceStates(
  List<CharacterResourceStateData>? states,
  CharacterFeatureSourceType sourceType,
  int sourceId, {
  required String resourceKey,
  required int current,
  required int max,
}) {
  final updatedStates = [...?states]..removeWhere(
      (state) =>
          state.sourceType == sourceType &&
          state.sourceId == sourceId &&
          state.resourceKey == resourceKey,
    );
  if (current != max) {
    updatedStates.add(
      CharacterResourceStateData(
        sourceType: sourceType,
        sourceId: sourceId,
        resourceKey: resourceKey,
        current: current,
      ),
    );
  }
  updatedStates.sort((left, right) {
    final sourceCompare = left.sourceType.name.compareTo(right.sourceType.name);
    if (sourceCompare != 0) {
      return sourceCompare;
    }
    final idCompare = left.sourceId.compareTo(right.sourceId);
    if (idCompare != 0) {
      return idCompare;
    }
    return left.resourceKey.compareTo(right.resourceKey);
  });
  return updatedStates.isEmpty ? null : updatedStates;
}

bool _resourceShouldRestore(
  CharacterResourceViewData? resource,
  RestType restType,
) {
  if (resource == null) {
    return false;
  }

  switch (restType) {
    case RestType.shortRest:
      return resource.resetOn == RestType.shortRest;
    case RestType.longRest:
      return resource.resetOn == RestType.shortRest ||
          resource.resetOn == RestType.longRest;
    case RestType.dawn:
    case RestType.special:
      return false;
  }
}
