import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_mutation_stamper.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/character_model_extensions.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_proficiency_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/hit_points_calculator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_sheet_state.g.dart';

final characterRepositoryProvider = Provider<CharacterRepository>((ref) {
  return CharacterRepository();
});

final offlineCharacterRecordProvider =
    FutureProvider.autoDispose.family<OfflineCharacterRecord?, int>(
  (ref, characterId) {
    return ref.watch(characterRepositoryProvider).getOfflineRecord(characterId);
  },
);

final selectedFightFeatureTagsProvider =
    StateProvider.autoDispose.family<Set<FeatureTag>, int>((ref, characterId) {
  return {
    FeatureTag.combat,
    FeatureTag.defense,
  };
});

@riverpod
Future<CharacterData> characterSheet(Ref ref, int characterId) async {
  final repository = ref.watch(characterRepositoryProvider);
  return repository.getCharacter(characterId);
}

final characterSheetControllerProvider = AsyncNotifierProvider.autoDispose
    .family<CharacterSheetController, CharacterData, int>(
  CharacterSheetController.new,
);

class CharacterSheetController
    extends AutoDisposeFamilyAsyncNotifier<CharacterData, int> {
  late final CharacterRepository _repository;
  late final int _characterId;
  int _saveRevision = 0;

  @override
  Future<CharacterData> build(int characterId) async {
    _characterId = characterId;
    _repository = ref.watch(characterRepositoryProvider);
    return _repository.getCharacter(characterId);
  }

  Future<void> reload() async {
    state =
        await AsyncValue.guard(() => _repository.getCharacter(_characterId));
  }

  Future<void> addAttack(CharacterAttackData attack) async {
    final current = _requireCharacter();
    final attacks = [...?current.attacks, attack];
    await _saveCharacter(current.copyWith(attacks: attacks));
  }

  Future<void> updateAttack(int index, CharacterAttackData attack) async {
    final current = _requireCharacter();
    final attacks = [...?current.attacks];
    if (index < 0 || index >= attacks.length) {
      throw RangeError.index(index, attacks, 'index');
    }

    final previousAttack = attacks[index];
    attacks[index] = attack.copyWith(
      id: attack.id ?? previousAttack.id,
      updatedAt: attack.updatedAt ?? previousAttack.updatedAt,
    );
    await _saveCharacter(current.copyWith(attacks: attacks));
  }

  Future<void> deleteAttack(int index) async {
    final current = _requireCharacter();
    final attacks = [...?current.attacks];
    if (index < 0 || index >= attacks.length) {
      throw RangeError.index(index, attacks, 'index');
    }

    attacks.removeAt(index);
    await _saveCharacter(current.copyWith(attacks: attacks));
  }

  Future<void> saveEquipment(String? equipment) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(
        equipment: inventoryItemsFromText(
          equipment,
          previous: current.equipment,
        ),
      ),
    );
  }

  Future<void> saveHitPoints({
    required int currentHp,
    required int temporaryHp,
  }) async {
    final current = _requireCharacter();
    final hitPoints = normalizeHitPointsForSave(
      currentHp: currentHp,
      maxHp: current.derived?.maxHp ?? 0,
      temporaryHp: temporaryHp,
    );

    await _saveCharacter(
      current.copyWith(
        currentHp: hitPoints.currentHp,
        temporaryHp: hitPoints.temporaryHp,
        deathSaveSuccesses: hitPoints.currentHp == null || currentHp > 0
            ? null
            : current.deathSaveSuccesses,
        deathSaveFailures: hitPoints.currentHp == null || currentHp > 0
            ? null
            : current.deathSaveFailures,
      ),
    );
  }

  Future<void> saveDeathSavingThrows({
    required int successes,
    required int failures,
  }) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(
        deathSaveSuccesses: normalizeDeathSaveCountForSave(successes),
        deathSaveFailures: normalizeDeathSaveCountForSave(failures),
      ),
    );
  }

  Future<void> saveHitPointSettings({
    required List<CharacterClassEntryData> classEntries,
    required int hpPerLevelBonus,
    required int hpFlatBonus,
    required Map<String, int> currentHitDice,
    required Map<String, int> hitDiceMaxOverrides,
  }) async {
    final current = _requireCharacter();
    final normalizedEntries = normalizeHitPointClassEntries(classEntries);
    final baseHitDiceMax = baseHitDiceMaxFromCharacter(
      current.copyWith(classEntries: normalizedEntries),
    );
    final normalizedMaxOverrides = normalizeHitDiceMaxOverridesForSave(
      baseHitDiceMax,
      hitDiceMaxOverrides,
    );
    final effectiveMaxHitDice = effectiveHitDiceMax(
      baseHitDiceMax,
      normalizedMaxOverrides,
    );
    final normalizedCurrentHitDice = normalizeCurrentHitDiceForSave(
      currentHitDice,
      effectiveMaxHitDice,
    );

    final settingsCharacter = current.copyWith(
      classEntries: normalizedEntries,
      hpPerLevelBonus: hpPerLevelBonus == 0 ? null : hpPerLevelBonus,
      hpFlatBonus: hpFlatBonus == 0 ? null : hpFlatBonus,
      currentHitDice: normalizedCurrentHitDice,
      hitDiceMaxOverrides: normalizedMaxOverrides,
    );
    final nextMaxHp = calculateMaxHpForCharacter(settingsCharacter);
    final currentHp = current.currentHp ?? nextMaxHp;
    final hitPoints = normalizeHitPointsForSave(
      currentHp: currentHp,
      maxHp: nextMaxHp,
      temporaryHp: current.temporaryHp ?? 0,
    );

    await _saveCharacter(
      settingsCharacter.copyWith(
        currentHp: hitPoints.currentHp,
        temporaryHp: hitPoints.temporaryHp,
      ),
    );
  }

  Future<void> setCurrentSpellSlotsForLevel(int level, int available) async {
    final current = _requireCharacter();
    final maxSlots = _spellSlotCount(current, level);
    final normalizedAvailable = available.clamp(0, maxSlots).toInt();
    final currentSpellSlots = <int, int>{...?current.currentSpellSlots};
    if (maxSlots <= 0 || normalizedAvailable == maxSlots) {
      currentSpellSlots.remove(level);
    } else {
      currentSpellSlots[level] = normalizedAvailable;
    }

    await _saveCharacter(
      current.copyWith(
        currentSpellSlots: currentSpellSlots.isEmpty ? null : currentSpellSlots,
      ),
    );
  }

  Future<void> spendSpellSlot(int level) async {
    if (level <= 0) {
      return;
    }

    final current = _requireCharacter();
    final maxSlots = _spellSlotCount(current, level);
    final available = _currentSpellSlotCount(current, level);
    if (maxSlots <= 0 || available <= 0) {
      return;
    }

    await setCurrentSpellSlotsForLevel(level, available - 1);
  }

  Future<void> castSpell(SpellData spell) async {
    final current = _requireCharacter();
    final level = spell.level ?? 0;
    final currentSpellSlots = <int, int>{...?current.currentSpellSlots};

    if (level > 0) {
      final maxSlots = _spellSlotCount(current, level);
      final available = _currentSpellSlotCount(current, level);
      if (maxSlots <= 0 || available <= 0) {
        return;
      }

      final nextAvailable = available - 1;
      if (nextAvailable == maxSlots) {
        currentSpellSlots.remove(level);
      } else {
        currentSpellSlots[level] = nextAvailable;
      }
    }

    await _saveCharacter(
      current.copyWith(
        currentSpellSlots: currentSpellSlots.isEmpty ? null : currentSpellSlots,
        activeConcentrationSpellName: spell.concentration == true
            ? _spellName(spell)
            : current.activeConcentrationSpellName,
      ),
    );
  }

  Future<void> cancelConcentration() async {
    final current = _requireCharacter();
    if (_normalizedText(current.activeConcentrationSpellName) == null) {
      return;
    }

    await _saveCharacter(current.copyWith(activeConcentrationSpellName: null));
  }

  Future<void> setInspiration(bool value) async {
    final current = _requireCharacter();
    await _saveCharacter(current.copyWith(inspiration: value ? true : null));
  }

  Future<void> saveConditions({
    required List<ConditionType> activeConditions,
    int? exhaustionLevel,
  }) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(
        activeConditions: _normalizedActiveConditions(activeConditions),
        exhaustionLevel: _normalizedExhaustionLevel(exhaustionLevel),
      ),
    );
  }

  Future<void> removeCondition(ConditionType condition) async {
    final current = _requireCharacter();
    if (condition == ConditionType.exhaustion) {
      await _saveCharacter(current.copyWith(exhaustionLevel: null));
      return;
    }

    final activeConditions = [
      for (final activeCondition
          in current.activeConditions ?? const <ConditionType>[])
        if (activeCondition != condition) activeCondition,
    ];
    await _saveCharacter(
      current.copyWith(
        activeConditions: activeConditions.isEmpty ? null : activeConditions,
      ),
    );
  }

  Future<void> savePersonalInfo({
    String? name,
    String? age,
    String? height,
    String? weight,
    String? eyes,
    String? skin,
    String? hair,
    CharacterAlignment? alignmentValue,
    String? appearance,
    String? backstory,
    String? goals,
    String? alliesOrganizations,
    String? personalityTraits,
    String? ideals,
    String? bonds,
    String? flaws,
  }) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(
        name: _normalizedText(name),
        age: _normalizedText(age),
        height: _normalizedText(height),
        weight: _normalizedText(weight),
        eyes: _normalizedText(eyes),
        skin: _normalizedText(skin),
        hair: _normalizedText(hair),
        alignmentValue: alignmentValue,
        appearance: _normalizedText(appearance),
        backstory: _normalizedText(backstory),
        goals: _normalizedText(goals),
        alliesOrganizations: _normalizedText(alliesOrganizations),
        personalityTraits: _normalizedText(personalityTraits),
        ideals: _normalizedText(ideals),
        bonds: _normalizedText(bonds),
        flaws: _normalizedText(flaws),
      ),
    );
  }

  Future<void> addNote() async {}

  Future<void> updateNote(int index, String note) async {
    final current = _requireCharacter();
    final noteTexts = [...current.noteTexts];
    if (index < 0) {
      throw RangeError.index(index, noteTexts, 'index');
    }

    final normalized = _normalizedText(note);
    if (normalized == null) {
      if (index < noteTexts.length) {
        noteTexts.removeAt(index);
      } else {
        return;
      }
    } else {
      if (index < noteTexts.length) {
        noteTexts[index] = normalized;
      } else {
        noteTexts.add(normalized);
      }
    }

    await _saveCharacter(
      current.copyWith(
        notes: notesFromTexts(noteTexts, previous: current.notes),
      ),
    );
  }

  Future<void> deleteNote(int index) async {
    final current = _requireCharacter();
    final noteTexts = [...current.noteTexts];
    if (index < 0) {
      throw RangeError.index(index, noteTexts, 'index');
    }
    if (index >= noteTexts.length) {
      return;
    }

    noteTexts.removeAt(index);
    await _saveCharacter(
      current.copyWith(
        notes: notesFromTexts(noteTexts, previous: current.notes),
      ),
    );
  }

  Future<void> saveBaseAbilityScore(Ability ability, int? score) async {
    final current = _requireCharacter();
    final scores = <String, int>{...?current.baseAbilityScores};
    if (score == null) {
      scores.remove(ability.name);
    } else {
      scores[ability.name] = score;
    }

    await _saveCharacter(
      current.copyWith(
        baseAbilityScores: scores.isEmpty ? null : scores,
      ),
    );
  }

  Future<void> saveCustomAbilityBonus(Ability ability, int? bonus) async {
    final current = _requireCharacter();
    final bonuses = <String, int>{...?current.customAbilityBonuses};
    if (bonus == null || bonus == 0) {
      bonuses.remove(ability.name);
    } else {
      bonuses[ability.name] = bonus;
    }

    await _saveCharacter(
      current.copyWith(
        customAbilityBonuses: bonuses.isEmpty ? null : bonuses,
      ),
    );
  }

  Future<void> saveAbilityDetails({
    required Ability ability,
    required int? score,
    required int? customBonus,
    required bool savingThrowProficient,
  }) async {
    final current = _requireCharacter();
    final scores = <String, int>{...?current.baseAbilityScores};
    if (score == null) {
      scores.remove(ability.name);
    } else {
      scores[ability.name] = score;
    }

    final bonuses = <String, int>{...?current.customAbilityBonuses};
    if (customBonus == null || customBonus == 0) {
      bonuses.remove(ability.name);
    } else {
      bonuses[ability.name] = customBonus;
    }

    await _saveCharacter(
      current.copyWith(
        baseAbilityScores: scores.isEmpty ? null : scores,
        customAbilityBonuses: bonuses.isEmpty ? null : bonuses,
        manualSavingThrowProficiencies: buildManualSavingThrowProficiencies(
          character: current,
          ability: ability,
          proficient: savingThrowProficient,
        ),
      ),
    );
  }

  Future<void> saveSkillProficiency(
    Skill skill,
    CharacterSkillProficiencyLevel level,
  ) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(
        manualSkillProficiencies: buildManualSkillProficiencies(
          character: current,
          skill: skill,
          level: level,
        ),
      ),
    );
  }

  Future<void> saveSavingThrowProficiency(
    Ability ability,
    bool proficient,
  ) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(
        manualSavingThrowProficiencies: buildManualSavingThrowProficiencies(
          character: current,
          ability: ability,
          proficient: proficient,
        ),
      ),
    );
  }

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
    if (restoredKeys.isEmpty) {
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

    await _saveCharacter(
      character.copyWith(
        resourceStates: resourceStates.isEmpty ? null : resourceStates,
        derived: character.derived?.copyWith(activeFeatures: updatedFeatures),
      ),
    );
  }

  CharacterData _requireCharacter() {
    final current = state.valueOrNull;
    if (current == null) {
      throw StateError('Character sheet is not loaded yet.');
    }
    return current;
  }

  Future<void> _saveCharacter(CharacterData updated) async {
    final previous = _requireCharacter();
    final stamped = stampCharacterMutation(previous: previous, next: updated);
    final revision = ++_saveRevision;
    state = AsyncValue.data(stamped);

    try {
      final saved = await _repository.saveCharacter(stamped);
      if (revision == _saveRevision) {
        state = AsyncValue.data(saved);
        ref.invalidate(characterSheetProvider(_characterId));
        ref.invalidate(offlineCharacterRecordProvider(_characterId));
      }
    } catch (error, stackTrace) {
      if (revision == _saveRevision) {
        state = AsyncValue.data(previous);
      }
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}

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

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}

List<ConditionType>? _normalizedActiveConditions(
  List<ConditionType>? conditions,
) {
  final normalized = <ConditionType>[];
  for (final condition in conditions ?? const <ConditionType>[]) {
    if (condition == ConditionType.exhaustion ||
        normalized.contains(condition)) {
      continue;
    }
    normalized.add(condition);
  }
  return normalized.isEmpty ? null : normalized;
}

int? _normalizedExhaustionLevel(int? value) {
  if (value == null || value <= 0) {
    return null;
  }
  return value.clamp(1, 6).toInt();
}

String _spellName(SpellData spell) {
  return _normalizedText(spell.name) ??
      _normalizedText(spell.referenceKey) ??
      'Заклинание';
}

int _spellSlotCount(CharacterData character, int level) {
  return (character.derived?.spellSlots?[level] ?? 0) +
      (character.derived?.pactSlots?[level] ?? 0);
}

int _currentSpellSlotCount(CharacterData character, int level) {
  final maxSlots = _spellSlotCount(character, level);
  return (character.currentSpellSlots?[level] ?? maxSlots)
      .clamp(0, maxSlots)
      .toInt();
}
