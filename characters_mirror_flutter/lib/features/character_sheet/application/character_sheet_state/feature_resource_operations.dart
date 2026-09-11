// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of '../character_sheet_state.dart';

extension CharacterSheetControllerFeatureResources on CharacterSheetController {
  Future<void> saveFeatureOverride(
    CharacterFeatureViewData feature, {
    String? name,
    String? description,
    List<FeatureTag>? tags,
  }) async {
    final current = _requireCharacter();
    final normalizedName = _normalizedText(name);
    final normalizedDescription = _normalizedText(description);
    final defaultName = _normalizedText(feature.defaultName);
    final defaultDescription = _normalizedText(feature.defaultDescription);
    final normalizedTags = _normalizedFeatureTags(
      tags ?? feature.tags,
      preserveEmpty: true,
    );
    final defaultTags = _normalizedFeatureTags(
      feature.defaultTags,
      preserveEmpty: false,
    );
    final featureOverrides = [...?current.featureOverrides];
    final overrideIndex = featureOverrides.indexWhere(
      (item) =>
          item.sourceType == feature.sourceType &&
          item.sourceId == feature.sourceId,
    );
    final matchesDefault = normalizedName == defaultName &&
        normalizedDescription == defaultDescription &&
        _featureTagsEqual(
          normalizedTags,
          defaultTags,
          preserveEmpty: false,
        );

    if (matchesDefault) {
      if (overrideIndex >= 0) {
        featureOverrides.removeAt(overrideIndex);
      }
    } else {
      final override = CharacterFeatureOverrideData(
        sourceType: feature.sourceType,
        sourceId: feature.sourceId,
        name: normalizedName,
        description: normalizedDescription,
        tags: normalizedTags,
      );
      if (overrideIndex >= 0) {
        featureOverrides[overrideIndex] = override;
      } else {
        featureOverrides.add(override);
      }
    }

    final updatedFeatures = _updateDerivedFeatureViews(
      current.derived?.activeFeatures,
      feature.sourceType,
      feature.sourceId,
      name: matchesDefault ? feature.defaultName : normalizedName,
      description:
          matchesDefault ? feature.defaultDescription : normalizedDescription,
      tags: matchesDefault ? feature.defaultTags : normalizedTags,
      isCustomized: !matchesDefault,
    );

    await _saveCharacter(
      current.copyWith(
        featureOverrides: featureOverrides,
        derived: current.derived?.copyWith(activeFeatures: updatedFeatures),
      ),
    );
  }

  Future<void> resetFeatureOverride(CharacterFeatureViewData feature) async {
    final current = _requireCharacter();
    final featureOverrides = [...?current.featureOverrides]..removeWhere(
        (item) =>
            item.sourceType == feature.sourceType &&
            item.sourceId == feature.sourceId,
      );
    final updatedFeatures = _updateDerivedFeatureViews(
      current.derived?.activeFeatures,
      feature.sourceType,
      feature.sourceId,
      name: feature.defaultName,
      description: feature.defaultDescription,
      tags: feature.defaultTags,
      isCustomized: false,
    );

    await _saveCharacter(
      current.copyWith(
        featureOverrides: featureOverrides,
        derived: current.derived?.copyWith(activeFeatures: updatedFeatures),
      ),
    );
  }

  Future<void> setFeatureResource(
    CharacterFeatureViewData feature,
    String resourceKey,
    int current,
  ) async {
    final resource = _featureResource(feature, resourceKey);
    if (resource == null) {
      return;
    }
    if (resource.isUnlimited == true) {
      return;
    }

    final character = _requireCharacter();
    final normalizedCurrent = current.clamp(0, resource.max).toInt();
    final resourceStates = _updatedResourceStates(
      character.resourceStates,
      feature.sourceType,
      feature.sourceId,
      resourceKey: resourceKey,
      current: normalizedCurrent,
      max: resource.max,
    );
    final updatedFeatures = _updateDerivedFeatureResource(
      character.derived?.activeFeatures,
      feature.sourceType,
      feature.sourceId,
      resourceKey: resourceKey,
      current: normalizedCurrent,
    );

    await _saveCharacter(
      character.copyWith(
        resourceStates: resourceStates,
        derived: character.derived?.copyWith(activeFeatures: updatedFeatures),
      ),
    );
  }

  Future<void> spendFeatureResource(CharacterFeatureViewData feature) async {
    final resource = feature.resources?.firstOrNull;
    if (resource == null || resource.current <= 0) {
      return;
    }

    await setFeatureResource(feature, resource.key, resource.current - 1);
  }

  Future<void> restoreResources(RestType restType) async {
    final character = _requireCharacter();
    final activeFeatures =
        character.derived?.activeFeatures ?? const <CharacterFeatureViewData>[];
    final restoredKeys = {
      for (final feature in activeFeatures)
        for (final resource
            in feature.resources ?? const <CharacterResourceViewData>[])
          if (_resourceShouldRestore(resource, restType))
            _featureResourceKey(
                feature.sourceType, feature.sourceId, resource.key),
    };
    final isLongRest = restType == RestType.longRest;
    if (restoredKeys.isEmpty && !isLongRest) {
      return;
    }

    final resourceStates = [
      for (final state
          in character.resourceStates ?? const <CharacterResourceStateData>[])
        if (!restoredKeys.contains(
          _featureResourceKey(
            state.sourceType,
            state.sourceId,
            state.resourceKey,
          ),
        ))
          state,
    ];
    final updatedFeatures = [
      for (final feature in activeFeatures)
        feature.copyWith(
          resources: [
            for (final resource
                in feature.resources ?? const <CharacterResourceViewData>[])
              if (_resourceShouldRestore(resource, restType))
                resource.copyWith(current: resource.max)
              else
                resource,
          ],
        ),
    ];

    var updatedCharacter = character.copyWith(
      resourceStates: resourceStates.isEmpty ? null : resourceStates,
      derived: character.derived?.copyWith(activeFeatures: updatedFeatures),
    );

    if (isLongRest) {
      final maxHp = calculateMaxHpForCharacter(character);
      final restoredHitPoints = normalizeHitPointsForSave(
        currentHp: maxHp,
        maxHp: maxHp,
        temporaryHp: 0,
      );
      updatedCharacter = updatedCharacter.copyWith(
        currentHp: restoredHitPoints.currentHp,
        temporaryHp: restoredHitPoints.temporaryHp,
        deathSaveSuccesses: null,
        deathSaveFailures: null,
        currentSpellSlots: null,
        currentHitDice: _restoredHitDiceForLongRest(character),
      );
    }

    await _saveCharacter(updatedCharacter);
  }
}
