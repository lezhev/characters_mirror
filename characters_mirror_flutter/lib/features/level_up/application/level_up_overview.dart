import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import '../../character_creation/application/choice_option_eligibility.dart';

List<({String name, String? description, String? sourceKey})>
    newLevelUpFeatures(LevelUpPreview preview, String entryId) {
  final oldEntry =
      preview.before.classEntries!.firstWhere((e) => e.id == entryId);
  final oldLevel = oldEntry.level ?? 1;
  final features =
      preview.classStep.currentLevelFeatures ?? const <ClassFeatureData>[];
  final oldKeys = {
    for (final f in features)
      if (f.level <= oldLevel) f.referenceKey ?? 'class:${f.id}'
  };
  final seen = <String>{...oldKeys};
  final notices = <({String name, String? description, String? sourceKey})>[];
  for (final f in features.where((f) => f.level > oldLevel)) {
    if (seen.add(f.referenceKey ?? 'class:${f.id}')) {
      notices.add((
        name: f.name ?? 'Новая возможность',
        description: f.shortDescription ?? f.description,
        sourceKey: f.id == null ? null : 'class:${f.id}'
      ));
    }
  }
  final subclassFeatures = preview.classStep.currentSubclassFeatures ??
      const <SubclassFeatureData>[];
  final oldSubclass = oldEntry.subclass?.id;
  final oldSubclassKeys = {
    for (final f in subclassFeatures)
      if (oldSubclass == f.parentSubclassId && f.level <= oldLevel)
        f.referenceKey ?? 'subclass:${f.id}'
  };
  for (final f in subclassFeatures) {
    if (oldSubclassKeys.add(f.referenceKey ?? 'subclass:${f.id}')) {
      notices.add((
        name: f.name ?? 'Новая возможность подкласса',
        description: f.shortDescription ?? f.description,
        sourceKey: f.id == null ? null : 'subclass:${f.id}'
      ));
    }
  }
  final oldFeatures = {
    for (final f in preview.before.derived?.activeFeatures ??
        const <CharacterFeatureViewData>[])
      (f.sourceType, f.sourceId): f,
  };
  for (final feature in preview.character.derived?.activeFeatures ??
      const <CharacterFeatureViewData>[]) {
    final old = oldFeatures[(feature.sourceType, feature.sourceId)];
    if (old == null) continue;
    final oldResourceKeys = {
      for (final r in old.resources ?? const <CharacterResourceViewData>[])
        r.key
    };
    for (final resource
        in feature.resources ?? const <CharacterResourceViewData>[]) {
      if (!oldResourceKeys.contains(resource.key)) {
        notices.add((
          name: resource.name ?? feature.name ?? 'Новая возможность',
          description: feature.description,
          sourceKey: switch (feature.sourceType) {
            CharacterFeatureSourceType.classFeature =>
              'class:${feature.sourceId}',
            CharacterFeatureSourceType.subclassFeature =>
              'subclass:${feature.sourceId}',
            _ => null,
          }
        ));
      }
    }
  }
  return notices;
}

List<int> newSpellLevels(LevelUpPreview preview) {
  Set<int> levels(CharacterData c) => {
        for (final e
            in {...?c.derived?.spellSlots, ...?c.derived?.pactSlots}.entries)
          if (e.value > 0) e.key
      };
  return levels(preview.character).difference(levels(preview.before)).toList()
    ..sort();
}

ChoiceGroupView eligibleLevelUpGroup(
    ChoiceGroupView view, LevelUpPreview preview) {
  final c = preview.character;
  final spellFacts = collectChoiceSpellFacts([
    for (final s in c.spellSelections ?? const <CharacterSpellSelectionData>[])
      if (s.spellKey != null && s.kind != null)
        ChoiceSpellSelectionFact(key: s.spellKey!, kind: s.kind!.name)
  ]);
  return evaluateChoiceGroupEligibility(
      view,
      ChoiceEligibilityContext(
        totalCharacterLevel: c.derived?.totalLevel ?? 1,
        classLevelsByReferenceKey: {
          for (final e in c.classEntries ?? const <CharacterClassEntryData>[])
            if (e.classData?.referenceKey != null)
              e.classData!.referenceKey!: e.level ?? 0
        },
        abilityScores: {
          for (final e in c.derived?.abilityScores?.entries ??
              const <MapEntry<Ability, int>>[])
            e.key.name: e.value
        },
        knownSpellKeys: spellFacts.knownSpellKeys,
        knownCantripKeys: spellFacts.knownCantripKeys,
        featureKeys: {
          ...?preview.classStep.currentLevelFeatures
              ?.map((f) => f.referenceKey)
              .whereType<String>(),
          ...?preview.classStep.currentSubclassFeatures
              ?.map((f) => f.referenceKey)
              .whereType<String>()
        },
        selectedChoiceOptionKeys: {
          for (final s in c.choices ?? const <CharacterChoiceData>[])
            '${s.groupKey}::${s.optionKey}'
        },
        skillKeys: {
          for (final s in c.derived?.skillProficiencyLevels ??
              const <CharacterSkillProficiencyState>[])
            if (s.level != CharacterSkillProficiencyLevel.none) s.skill.name
        },
        toolKeys: c.derived?.toolProficiencyKeys?.toSet() ?? {},
      ));
}

String signedLevelUpValue(int value) => value >= 0 ? '+$value' : '$value';

String levelUpHpCalculation(int roll, int constitution, int perLevelBonus) {
  final constitutionTerm =
      constitution < 0 ? '− ${constitution.abs()}' : '+ $constitution';
  final bonusTerm = perLevelBonus == 0
      ? ''
      : ' ${perLevelBonus < 0 ? '−' : '+'} ${perLevelBonus.abs()} бонус';
  return '$roll от кости $constitutionTerm Телосложение$bonusTerm = ${signedLevelUpValue(roll + constitution + perLevelBonus)}';
}
