part of '../character_data_endpoint.dart';

String? _subclassSourceName(SubclassData? subclass) => feature_modifiers
    .subclassDisplayName(subclass?.subclassName, subclass?.name);

String _resourceStateKey(
  CharacterFeatureSourceType sourceType,
  int sourceId,
  String resourceKey,
) {
  return '${sourceType.name}:$sourceId:$resourceKey';
}

int _compareActiveFeatures(
  CharacterFeatureViewData a,
  CharacterFeatureViewData b,
) {
  final sourceCompare = _featureSourceOrder(a.sourceType)
      .compareTo(_featureSourceOrder(b.sourceType));
  if (sourceCompare != 0) {
    return sourceCompare;
  }

  final levelCompare = (a.level ?? 0).compareTo(b.level ?? 0);
  if (levelCompare != 0) {
    return levelCompare;
  }

  final nameCompare =
      (a.name ?? a.defaultName ?? '').compareTo(b.name ?? b.defaultName ?? '');
  if (nameCompare != 0) {
    return nameCompare;
  }

  return a.sourceId.compareTo(b.sourceId);
}

int _featureSourceOrder(CharacterFeatureSourceType sourceType) {
  switch (sourceType) {
    case CharacterFeatureSourceType.classFeature:
      return 0;
    case CharacterFeatureSourceType.subclassFeature:
      return 1;
    case CharacterFeatureSourceType.raceFeature:
      return 2;
    case CharacterFeatureSourceType.subraceFeature:
      return 3;
  }
}

int? _resolveHitDie(ClassData? classData) {
  if (classData == null) return null;
  return classData.hitDieValue;
}

Ability _abilityForSkill(Skill skill) {
  switch (skill) {
    case Skill.acrobatics:
    case Skill.sleightOfHand:
    case Skill.stealth:
      return Ability.dexterity;
    case Skill.animalHandling:
    case Skill.insight:
    case Skill.medicine:
    case Skill.perception:
    case Skill.survival:
      return Ability.wisdom;
    case Skill.arcana:
    case Skill.history:
    case Skill.investigation:
    case Skill.nature:
    case Skill.religion:
      return Ability.intelligence;
    case Skill.athletics:
      return Ability.strength;
    case Skill.deception:
    case Skill.intimidation:
    case Skill.performance:
    case Skill.persuasion:
      return Ability.charisma;
  }
}

void _applyFixedRaceBonuses(
  Map<String, int> scores,
  Map<String, int> bonuses,
) {
  bonuses.forEach((key, value) {
    scores[key] = (scores[key] ?? 10) + value;
  });
}

Map<String, int> _abilityBonusesFromRace(RaceData? race) {
  return {
    if (race?.strengthBonus != null)
      Ability.strength.name: race!.strengthBonus!,
    if (race?.dexterityBonus != null)
      Ability.dexterity.name: race!.dexterityBonus!,
    if (race?.constitutionBonus != null)
      Ability.constitution.name: race!.constitutionBonus!,
    if (race?.intelligenceBonus != null)
      Ability.intelligence.name: race!.intelligenceBonus!,
    if (race?.wisdomBonus != null) Ability.wisdom.name: race!.wisdomBonus!,
    if (race?.charismaBonus != null)
      Ability.charisma.name: race!.charismaBonus!,
  };
}

Map<String, int> _abilityBonusesFromSubrace(SubraceData? subrace) {
  return {
    if (subrace?.strengthBonus != null)
      Ability.strength.name: subrace!.strengthBonus!,
    if (subrace?.dexterityBonus != null)
      Ability.dexterity.name: subrace!.dexterityBonus!,
    if (subrace?.constitutionBonus != null)
      Ability.constitution.name: subrace!.constitutionBonus!,
    if (subrace?.intelligenceBonus != null)
      Ability.intelligence.name: subrace!.intelligenceBonus!,
    if (subrace?.wisdomBonus != null)
      Ability.wisdom.name: subrace!.wisdomBonus!,
    if (subrace?.charismaBonus != null)
      Ability.charisma.name: subrace!.charismaBonus!,
  };
}

int _compareCharacterChoices(CharacterChoiceData a, CharacterChoiceData b) {
  final groupCompare = (a.groupKey ?? '').compareTo(b.groupKey ?? '');
  if (groupCompare != 0) return groupCompare;

  final selectionCompare =
      (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0);
  if (selectionCompare != 0) return selectionCompare;

  return (a.id ?? '').compareTo(b.id ?? '');
}

int _compareSkillSelections(
  CharacterSkillSelectionData a,
  CharacterSkillSelectionData b,
) {
  final kindCompare = (a.kind?.name ?? '').compareTo(b.kind?.name ?? '');
  if (kindCompare != 0) return kindCompare;

  final classCompare = (a.classDataId ?? 0).compareTo(b.classDataId ?? 0);
  if (classCompare != 0) return classCompare;

  final backgroundCompare =
      (a.backgroundDataId ?? 0).compareTo(b.backgroundDataId ?? 0);
  if (backgroundCompare != 0) return backgroundCompare;

  final selectionCompare =
      (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0);
  if (selectionCompare != 0) return selectionCompare;

  final skillCompare = (a.skill?.name ?? '').compareTo(b.skill?.name ?? '');
  if (skillCompare != 0) return skillCompare;

  return (a.id ?? '').compareTo(b.id ?? '');
}

int _compareSpellSelections(
  CharacterSpellSelectionData a,
  CharacterSpellSelectionData b,
) {
  final classCompare = (a.classDataId ?? 0).compareTo(b.classDataId ?? 0);
  if (classCompare != 0) return classCompare;

  final kindCompare = (a.kind?.name ?? '').compareTo(b.kind?.name ?? '');
  if (kindCompare != 0) return kindCompare;

  final selectionCompare =
      (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0);
  if (selectionCompare != 0) return selectionCompare;

  final spellCompare = (a.spellKey ??
          a.spell?.referenceKey ??
          a.spell?.name ??
          '')
      .compareTo(b.spellKey ?? b.spell?.referenceKey ?? b.spell?.name ?? '');
  if (spellCompare != 0) return spellCompare;

  return (a.id ?? '').compareTo(b.id ?? '');
}

int _compareStartingEquipmentSelections(
  CharacterStartingEquipmentSelectionData a,
  CharacterStartingEquipmentSelectionData b,
) {
  final sourceEntryCompare =
      (a.sourceEntryId ?? 0).compareTo(b.sourceEntryId ?? 0);
  if (sourceEntryCompare != 0) {
    return sourceEntryCompare;
  }

  final selectionCompare =
      (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0);
  if (selectionCompare != 0) {
    return selectionCompare;
  }

  final optionCompare =
      (a.choiceOptionEntryId ?? 0).compareTo(b.choiceOptionEntryId ?? 0);
  if (optionCompare != 0) {
    return optionCompare;
  }

  return (a.id ?? '').compareTo(b.id ?? '');
}

int _compareStartingEquipmentResolutions(
  CharacterStartingEquipmentResolutionData a,
  CharacterStartingEquipmentResolutionData b,
) {
  final lineCompare =
      (a.sourceLineEntryId ?? 0).compareTo(b.sourceLineEntryId ?? 0);
  if (lineCompare != 0) {
    return lineCompare;
  }

  final typeCompare =
      (a.catalogType?.name ?? '').compareTo(b.catalogType?.name ?? '');
  if (typeCompare != 0) {
    return typeCompare;
  }

  final referenceCompare =
      (a.referenceKey ?? '').compareTo(b.referenceKey ?? '');
  if (referenceCompare != 0) {
    return referenceCompare;
  }

  return (a.id ?? '').compareTo(b.id ?? '');
}

CharacterRecordInclude _characterRecordInclude() {
  return CharacterRecord.include(
    race: _raceDataInclude(),
    subrace: _subraceDataInclude(),
    background: BackgroundData.include(),
  );
}

RaceDataInclude _raceDataInclude() {
  return RaceData.include(
    features: RaceFeatureData.includeList(
      include: _raceFeatureInclude(),
    ),
  );
}

SubraceDataInclude _subraceDataInclude() {
  return SubraceData.include(
    features: RaceFeatureData.includeList(
      include: _raceFeatureInclude(),
    ),
  );
}

RaceFeatureDataInclude _raceFeatureInclude() {
  return RaceFeatureData.include(
    resources: FeatureResourceDefinitionData.includeList(
      include: _featureResourceDefinitionInclude(),
    ),
    resourceEffects: FeatureResourceEffectData.includeList(),
    spellGrants: RaceFeatureSpellGrantData.includeList(
      include: RaceFeatureSpellGrantData.include(
        spell: SpellData.include(),
      ),
    ),
  );
}

ClassFeatureDataInclude _classFeatureInclude() {
  return ClassFeatureData.include(
    resources: FeatureResourceDefinitionData.includeList(
      include: _featureResourceDefinitionInclude(),
    ),
    resourceEffects: FeatureResourceEffectData.includeList(),
  );
}

SubclassFeatureDataInclude _subclassFeatureInclude() {
  return SubclassFeatureData.include(
    resources: FeatureResourceDefinitionData.includeList(
      include: _featureResourceDefinitionInclude(),
    ),
    resourceEffects: FeatureResourceEffectData.includeList(),
  );
}

FeatureResourceDefinitionDataInclude _featureResourceDefinitionInclude() {
  return FeatureResourceDefinitionData.include(
    progressionValues: FeatureResourceProgressionValueData.includeList(),
  );
}
