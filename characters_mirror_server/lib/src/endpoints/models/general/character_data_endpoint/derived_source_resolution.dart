part of '../character_data_endpoint.dart';

class _ResolvedDerivedSources {
  final List<ClassChoiceOptionData> classBackgroundOptions;
  final List<RaceChoiceOptionData> raceOptions;
  final List<ClassFeatureData> currentClassFeatures;
  final List<SubclassFeatureData> currentSubclassFeatures;
  final List<String> alwaysPreparedSpellKeys;

  const _ResolvedDerivedSources({
    required this.classBackgroundOptions,
    required this.raceOptions,
    required this.currentClassFeatures,
    required this.currentSubclassFeatures,
    required this.alwaysPreparedSpellKeys,
  });
}

class _CurrentRaceFeatures {
  final List<RaceFeatureData> raceFeatures;
  final List<RaceFeatureData> subraceFeatures;

  const _CurrentRaceFeatures({
    required this.raceFeatures,
    required this.subraceFeatures,
  });
}

class _ResolvedStartingEquipmentSources {
  final List<_StartingEquipmentSourceBlock> blocks;

  const _ResolvedStartingEquipmentSources({
    required this.blocks,
  });
}

class _StartingEquipmentSourceBlock {
  const _StartingEquipmentSourceBlock({
    required this.blockView,
  });

  final StartingEquipmentBlockView blockView;
}

class _GrantedEquipmentAccumulator {
  _GrantedEquipmentAccumulator({
    required this.catalogType,
    required this.referenceKey,
    required this.displayText,
    required this.quantity,
  });

  final EquipmentCatalogType catalogType;
  final String referenceKey;
  String displayText;
  int quantity;
}

class _ActiveFeatureResourceEffect {
  const _ActiveFeatureResourceEffect({
    required this.sourceType,
    required this.sourceId,
    required this.sourceClassLevel,
    required this.effect,
  });

  final CharacterFeatureSourceType sourceType;
  final int sourceId;
  final int sourceClassLevel;
  final FeatureResourceEffectData effect;
}

Future<_ResolvedDerivedSources> _resolveDerivedSources(
  Session session,
  CharacterData character,
  List<CharacterChoiceData> choices,
) async {
  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  final currentClassFeatures = <ClassFeatureData>[];
  final currentSubclassFeatures = <SubclassFeatureData>[];
  final classLevels = <int, int>{};
  final subclassLevels = <int, int>{};

  for (final entry in entries) {
    final level = entry.level ?? 0;
    final classId = entry.classData?.id;
    if (classId != null) {
      classLevels[classId] = max(classLevels[classId] ?? 0, level);
      currentClassFeatures.addAll(
        await ClassFeatureData.db.find(
          session,
          where: (t) => t.parentClassId.equals(classId) & (t.level <= level),
          orderBy: (t) => t.level,
          include: _classFeatureInclude(),
        ),
      );
    }

    final subclassId = entry.subclass?.id;
    if (subclassId != null) {
      subclassLevels[subclassId] = max(subclassLevels[subclassId] ?? 0, level);
      currentSubclassFeatures.addAll(
        await SubclassFeatureData.db.find(
          session,
          where: (t) =>
              t.parentSubclassId.equals(subclassId) & (t.level <= level),
          orderBy: (t) => t.level,
          include: _subclassFeatureInclude(),
        ),
      );
    }
  }

  final currentClassFeatureIds = {
    for (final feature in currentClassFeatures)
      if (feature.id != null) feature.id!,
  };
  final currentClassFeatureLevels = {
    for (final feature in currentClassFeatures)
      if (feature.id != null)
        feature.id!: classLevels[feature.parentClassId] ?? feature.level,
  };
  final currentSubclassFeatureIds = {
    for (final feature in currentSubclassFeatures)
      if (feature.id != null) feature.id!,
  };
  final currentSubclassFeatureLevels = {
    for (final feature in currentSubclassFeatures)
      if (feature.id != null)
        feature.id!: subclassLevels[feature.parentSubclassId] ?? feature.level,
  };
  final classSpellGrants = await ClassSpellGrantData.db.find(
    session,
    include: ClassSpellGrantData.include(
      spell: SpellData.include(),
    ),
    orderBy: (t) => t.grantedAtLevel,
  );
  final alwaysPreparedSpellKeys = _collectAlwaysPreparedSpellKeys(
    classSpellGrants,
    classLevels: classLevels,
    subclassLevels: subclassLevels,
    currentClassFeatureIds: currentClassFeatureIds,
    currentSubclassFeatureIds: currentSubclassFeatureIds,
    currentClassFeatureLevels: currentClassFeatureLevels,
    currentSubclassFeatureLevels: currentSubclassFeatureLevels,
  );

  final allGroups = await ClassChoiceGroupData.db.find(
    session,
    orderBy: (t) => t.id,
  );
  final relevantGroups = allGroups.where((group) {
    final groupLevel = group.level ?? 1;
    final byClass = group.sourceClassId != null &&
        (classLevels[group.sourceClassId!] ?? 0) >= groupLevel;
    final bySubclass = group.sourceSubclassId != null &&
        (subclassLevels[group.sourceSubclassId!] ?? 0) >= groupLevel;
    final byFeature = group.sourceFeatureId != null &&
        currentClassFeatureIds.contains(group.sourceFeatureId);
    final bySubclassFeature = group.sourceSubclassFeatureId != null &&
        currentSubclassFeatureIds.contains(group.sourceSubclassFeatureId);
    final byBackground = group.sourceBackgroundId != null &&
        group.sourceBackgroundId == character.background?.id;

    return byClass ||
        bySubclass ||
        byFeature ||
        bySubclassFeature ||
        byBackground;
  }).toList();

  final optionsByGroupKey = <String, Map<String, ClassChoiceOptionData>>{};
  for (final group in relevantGroups) {
    final groupId = group.id;
    if (groupId == null) continue;

    final options = await ClassChoiceOptionData.db.find(
      session,
      where: (t) => t.choiceGroupId.equals(groupId),
    );
    optionsByGroupKey[_classChoiceGroupKey(group)] = {
      for (final option in options)
        if (_normalizedTextOrNull(option.optionKey) != null)
          option.optionKey!.trim(): option,
    };
  }

  final classBackgroundOptions = <ClassChoiceOptionData>[];
  for (final choice in choices.where(_isClassOrBackgroundChoice)) {
    final groupKey = choice.groupKey;
    final optionKey = _normalizedTextOrNull(choice.optionKey);
    if (groupKey == null || optionKey == null) continue;

    final option = optionsByGroupKey[groupKey]?[optionKey];
    if (option != null) {
      classBackgroundOptions.add(option);
    }
  }

  return _ResolvedDerivedSources(
    classBackgroundOptions: classBackgroundOptions,
    raceOptions: _selectedRaceChoiceOptions(character, choices),
    currentClassFeatures: currentClassFeatures,
    currentSubclassFeatures: currentSubclassFeatures,
    alwaysPreparedSpellKeys: alwaysPreparedSpellKeys,
  );
}
