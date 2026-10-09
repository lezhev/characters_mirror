import 'package:characters_mirror_flutter/core/character/feature_presentation.dart';
import 'package:characters_mirror_flutter/core/character/choice_group_presentation.dart';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import '../../character_creation/application/choice_option_eligibility.dart';

/// Keeps reference order; linked decisions and new resources belong to their
/// source feature, even when that feature was obtained at an earlier level.
List<FeaturePresentation> newLevelUpFeatures(
    LevelUpPreview preview, String entryId) {
  final oldEntry =
      preview.before.classEntries!.firstWhere((e) => e.id == entryId);
  final oldLevel = oldEntry.level ?? 1;
  final step = preview.classStep;
  final groups = levelUpDecisionGroups(preview);
  final views = stepFeatureViews(
      step.currentLevelFeatures,
      step.currentSubclassFeatures,
      step.currentLevelFeatureViews,
      step.currentSubclassFeatureViews);
  final oldKeys = {
    for (final v in views)
      if (v.classFeature != null && v.classFeature!.level <= oldLevel)
        v.classFeature!.referenceKey ?? 'class:${v.classFeature!.id}',
  };
  final oldSubclassKeys = {
    for (final v in views)
      if (v.subclassFeature != null &&
          v.subclassFeature!.parentSubclassId == oldEntry.subclass?.id &&
          v.subclassFeature!.level <= oldLevel)
        v.subclassFeature!.referenceKey ?? 'subclass:${v.subclassFeature!.id}',
  };
  final before = {
    for (final f in preview.before.derived?.activeFeatures ??
        const <CharacterFeatureViewData>[])
      if (_featureViewSourceKey(f) != null) _featureViewSourceKey(f): f
  };
  final after = {
    for (final f in preview.character.derived?.activeFeatures ??
        const <CharacterFeatureViewData>[])
      if (_featureViewSourceKey(f) != null) _featureViewSourceKey(f): f
  };
  final result = <FeaturePresentation>[];
  final seen = <String>{};
  for (final v in views) {
    var feature = FeaturePresentation.fromStep(v,
        groups: groups, sourceLevel: step.selectedLevel ?? oldLevel + 1);
    final key = v.classFeature?.referenceKey ??
        v.subclassFeature?.referenceKey ??
        feature.sourceKey;
    final isNew = v.classFeature != null
        ? feature.level > oldLevel && !oldKeys.contains(key)
        : !oldSubclassKeys.contains(key);
    final oldResourceKeys = {
      for (final r in before[feature.sourceKey]?.resources ??
          const <CharacterResourceViewData>[])
        r.key
    };
    final newResources = [
      for (final r in after[feature.sourceKey]?.resources ??
          (isNew ? feature.resources : const <CharacterResourceViewData>[]))
        if (!oldResourceKeys.contains(r.key)) r
    ];
    final subclassDecision = step.subclassChoice?.sourceFeatureId != null &&
        levelUpNeedsSubclass(preview, entryId) &&
        feature.sourceKey == 'class:${step.subclassChoice?.sourceFeatureId}';
    if (!isNew &&
        feature.choices.isEmpty &&
        newResources.isEmpty &&
        !subclassDecision) {
      continue;
    }
    if (key != null &&
        !seen.add('${v.classFeature == null ? 'subclass' : 'class'}:$key')) {
      continue;
    }
    final properties = feature.displayProperties.isNotEmpty
        ? feature.displayProperties
        : after[feature.sourceKey]?.displayProperties;
    feature = feature.withResources(newResources, properties: properties);
    result.add(feature);
  }
  // A capability can first appear on an existing feature outside the target
  // class step (for example another multiclass source). Keep its owning feature
  // instead of making the resource a standalone notice.
  for (final entry in after.entries) {
    if (result.any((f) => f.sourceKey == entry.key)) continue;
    final old = before[entry.key];
    if (old == null) continue;
    final oldKeys = {
      for (final r in old.resources ?? const <CharacterResourceViewData>[])
        r.key
    };
    final resources = [
      for (final r
          in entry.value.resources ?? const <CharacterResourceViewData>[])
        if (!oldKeys.contains(r.key)) r
    ];
    if (resources.isEmpty) continue;
    final feature = entry.value;
    result.add(FeaturePresentation(
        sourceKey: entry.key,
        name: feature.defaultName ?? feature.name ?? 'Новая возможность',
        level: feature.level ?? oldLevel,
        shortDescription: feature.shortDescription,
        displayProperties: feature.displayProperties ?? const [],
        resources: resources,
        choices: [
          for (final g in groups)
            if (choiceFeatureSourceKey(g.group!) == entry.key) g
        ]..sort((a, b) =>
            (a.group!.sortOrder ?? 0).compareTo(b.group!.sortOrder ?? 0))));
  }
  // Stable sort preserves reference order within a level, including class and
  // subclass features. Decisions never determine feature order.
  final order = {for (var i = 0; i < result.length; i++) result[i]: i};
  result.sort((a, b) {
    final level = a.level.compareTo(b.level);
    return level != 0 ? level : order[a]!.compareTo(order[b]!);
  });
  return result;
}

String? _featureViewSourceKey(CharacterFeatureViewData f) =>
    switch (f.sourceType) {
      CharacterFeatureSourceType.classFeature => 'class:${f.sourceId}',
      CharacterFeatureSourceType.subclassFeature => 'subclass:${f.sourceId}',
      _ => null,
    };

List<ChoiceGroupView> levelUpDecisionGroups(LevelUpPreview preview) {
  final alternatives = {
    for (final view in preview.choiceGroups)
      if (view.group?.type == ChoiceType.abilityIncrease &&
          view.group?.exclusiveKey != null)
        view.group!.exclusiveKey
  };
  return [
    for (final view in preview.choiceGroups)
      if (view.group != null &&
          !(view.group!.type == ChoiceType.feat &&
              alternatives.contains(view.group!.exclusiveKey)))
        view
  ];
}

bool levelUpNeedsSubclass(LevelUpPreview preview, String entryId) {
  final old = preview.before.classEntries!.firstWhere((e) => e.id == entryId);
  final next =
      preview.character.classEntries!.firstWhere((e) => e.id == entryId);
  final level = preview.classStep.subclassChoice?.requiredLevel;
  return old.subclass == null &&
      level != null &&
      level > (old.level ?? 0) &&
      level <= (next.level ?? 1);
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
  if (view.group?.progressionKey != null &&
      view.group?.allowDuplicates != true) {
    final otherGroups = {
      for (final group in preview.classStep.choiceGroups ?? <ChoiceGroupView>[])
        if (group.group?.progressionKey == view.group?.progressionKey &&
            group.group?.referenceKey != view.group?.referenceKey)
          group.group!.referenceKey
    };
    final owned = {
      for (final choice in c.choices ?? <CharacterChoiceData>[])
        if (otherGroups.contains(choice.groupKey)) choice.optionKey
    };
    view = view.copyWith(
        options:
            view.options?.where((o) => !owned.contains(o.optionKey)).toList());
  }
  final spellFacts = collectChoiceSpellFacts([
    for (final s in c.spellSelections ?? const <CharacterSpellSelectionData>[])
      if (s.spellKey != null && s.kind != null)
        ChoiceSpellSelectionFact(key: s.spellKey!, kind: s.kind!.name)
  ]);
  final context = ChoiceEligibilityContext(
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
    knownCantripKeys: {
      ...spellFacts.knownCantripKeys,
      ...knownChoiceCantripKeys(
        character: c.toJson(),
        otherGrantedCantripKeys: (preview.before.derived?.resolvedSpells ??
                <ResolvedCharacterSpellData>[])
            .where((s) => s.spell.level == 0)
            .map((s) => s.spellKey),
        otherFeatures: [
          ...?preview.classStep.currentLevelFeatures
              ?.where((f) => f.id != view.group?.sourceFeatureId)
              .map((f) => f.toJson()),
          ...?preview.classStep.currentSubclassFeatures
              ?.where((f) => f.id != view.group?.sourceSubclassFeatureId)
              .map((f) => f.toJson()),
        ],
        cantripReferenceKeys: choiceCantripCandidateKeys(
            (view.options ?? <ChoiceOptionData>[]).map((o) => o.toJson())),
      ),
    },
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
        if (s.groupKey != null && s.optionKey != null)
          encodeSelectedChoiceOptionKey(s.groupKey!, s.optionKey!)
    },
    skillKeys: {
      for (final s in c.derived?.skillProficiencyLevels ??
          const <CharacterSkillProficiencyState>[])
        if (s.level != CharacterSkillProficiencyLevel.none) s.skill.name
    },
    toolKeys: c.derived?.toolProficiencyKeys?.toSet() ?? {},
  );
  final group = view.group;
  if (group != null &&
      !choiceRequirementsEligibilityFromProtocol(
        (group.requirements ?? const <ChoiceRequirementData>[])
            .map((requirement) => requirement.toJson()),
        context,
      ).isEligible) {
    return view.copyWith(group: null);
  }
  return evaluateChoiceGroupEligibility(view, context);
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
