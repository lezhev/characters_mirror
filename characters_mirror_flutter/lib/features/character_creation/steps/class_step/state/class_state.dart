import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/starting_equipment_selection_support.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'class_state.g.dart';
part 'class_state.freezed.dart';
part 'class_state/class_selection_operations.dart';
part 'class_state/class_choice_equipment_operations.dart';
part 'class_state/class_spell_skill_operations.dart';

@freezed
sealed class ClassStateModel with _$ClassStateModel {
  const factory ClassStateModel({
    @Default([]) List<ClassData> allClasses,
    ClassData? selectedClass,
    ClassStepView? stepView,
    SubclassData? selectedSubclass,
    @Default({}) Map<String, List<ClassChoiceOptionData>> selectedOptions,
    @Default([]) List<CharacterSkillSelectionData> selectedSkillSelections,
    @Default([]) List<CharacterSpellSelectionData> selectedSpellSelections,
    @Default([])
    List<CharacterStartingEquipmentSelectionData> startingEquipmentSelections,
    @Default(1) int selectedLevel,
  }) = _ClassStateModel;
}

@riverpod
class ClassState extends _$ClassState {
  static const _requestTimeout = Duration(seconds: 10);

  @override
  FutureOr<ClassStateModel> build() async {
    ref.keepAlive();

    final repository = ref.watch(classRepositoryProvider);
    final classes = await repository.getAll().timeout(_requestTimeout);
    classes.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
    final baseState = ClassStateModel(
      allClasses: classes,
      selectedLevel: 1,
    );

    final characterCreation = ref.read(characterCreationProvider);
    final entry = _resolvePrimaryEntry(
      characterCreation.character.classEntries ??
          const <CharacterClassEntryData>[],
    );
    final selectedClassId = entry?.classData?.id;
    if (selectedClassId == null) {
      return baseState;
    }

    final selectedClass = _findClassById(classes, selectedClassId);
    if (selectedClass == null) {
      return baseState;
    }

    return _loadClassSelection(
      current: baseState,
      classData: selectedClass,
      selectedSubclassId: entry?.subclass?.id,
      selectedLevel: entry?.level ?? 1,
      savedChoices:
          characterCreation.character.choices ?? const <CharacterChoiceData>[],
      savedSkillSelections: characterCreation.character.skillSelections ??
          const <CharacterSkillSelectionData>[],
      savedSpellSelections: characterCreation.character.spellSelections ??
          const <CharacterSpellSelectionData>[],
      savedEquipmentSelections:
          characterCreation.character.startingEquipmentSelections ??
              const <CharacterStartingEquipmentSelectionData>[],
    );
  }

  Future<ClassStateModel> _loadClassSelection({
    required ClassStateModel current,
    required ClassData classData,
    int? selectedSubclassId,
    int selectedLevel = 1,
    List<CharacterChoiceData> savedChoices = const [],
    List<CharacterSkillSelectionData> savedSkillSelections = const [],
    List<CharacterSpellSelectionData> savedSpellSelections = const [],
    List<CharacterStartingEquipmentSelectionData> savedEquipmentSelections =
        const [],
  }) async {
    final classId = classData.id;
    if (classId == null) {
      return current.copyWith(
        selectedClass: classData,
        stepView: null,
        selectedSubclass: null,
        selectedOptions: const {},
        selectedSkillSelections: const [],
        selectedSpellSelections: const [],
        startingEquipmentSelections: const [],
        selectedLevel: selectedLevel,
      );
    }

    final stepView = await ref
        .read(classRepositoryProvider)
        .getStepView(
          classId,
          selectedLevel: selectedLevel,
          isStartingClass: true,
          selectedSubclassId: selectedSubclassId,
        )
        .timeout(_requestTimeout);

    return current.copyWith(
      selectedClass: classData,
      stepView: stepView,
      selectedSubclass: _findSubclassById(
        stepView.subclassChoice?.subclasses,
        selectedSubclassId,
      ),
      selectedOptions: _restoreSelectedOptions(
        stepView.choiceGroups,
        savedChoices,
      ),
      selectedSkillSelections: _normalizeSkillSelections(
        savedSkillSelections,
        stepView.skillSelectionGroups,
      ),
      selectedSpellSelections: _normalizeSpellSelections(
        savedSpellSelections,
        stepView.spellSelectionGroups,
      ),
      startingEquipmentSelections: normalizeStartingEquipmentSelections(
        blocks: stepView.startingEquipmentBlocks ??
            const <StartingEquipmentBlockView>[],
        selections: savedEquipmentSelections,
        sourceType: ChoiceSourceType.classData,
        sourceId: classId,
      ),
      selectedLevel: selectedLevel,
    );
  }

  StartingEquipmentOptionView? _selectedStartingEquipmentOption({
    required StartingEquipmentBlockView blockView,
    required List<CharacterStartingEquipmentSelectionData> selections,
  }) {
    final sourceEntryId = blockView.block?.entryId;
    if (sourceEntryId == null) {
      return null;
    }
    final selection = selections.firstWhere(
      (item) => item.sourceEntryId == sourceEntryId,
      orElse: () => CharacterStartingEquipmentSelectionData(),
    );
    final optionEntryId = selection.choiceOptionEntryId;
    if (optionEntryId == null) {
      return null;
    }
    for (final optionView
        in blockView.options ?? const <StartingEquipmentOptionView>[]) {
      if (optionView.option?.entryId == optionEntryId) {
        return optionView;
      }
    }
    return null;
  }

  Map<String, List<ClassChoiceOptionData>> _restoreSelectedOptions(
    List<ClassChoiceGroupView>? groups,
    List<CharacterChoiceData> savedChoices,
  ) {
    final optionsByGroupKey = _availableOptionsByGroup(groups);
    final restored = <String, List<ClassChoiceOptionData>>{};
    final sortedChoices = [
      ...savedChoices
    ]..sort((a, b) => (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0));

    for (final choice in sortedChoices) {
      if (!_isClassChoiceSource(choice.sourceType)) continue;

      final groupKey = choice.groupKey;
      final optionKey = choice.optionKey?.trim();
      if (groupKey == null || optionKey == null || optionKey.isEmpty) continue;

      final option = optionsByGroupKey[groupKey]?[optionKey];
      if (option == null) continue;

      restored.putIfAbsent(groupKey, () => <ClassChoiceOptionData>[]);
      restored[groupKey]!.add(option);
    }

    return _normalizeSelectedOptions(restored, groups);
  }

  List<CharacterSkillSelectionData> _normalizeSkillSelections(
    List<CharacterSkillSelectionData> selections,
    List<SkillSelectionGroupView>? groups,
  ) {
    final groupMap = {
      for (final group in groups ?? const <SkillSelectionGroupView>[])
        if (group.kind != null && group.classDataId != null)
          '${group.classDataId}:${group.kind!.name}': group,
    };
    final normalized = <CharacterSkillSelectionData>[];

    for (final entry in groupMap.entries) {
      final group = entry.value;
      final available = {
        for (final skill in group.options ?? const <Skill>[]) skill: skill,
      };
      final selected = [
        for (final selection in selections)
          if ('${selection.classDataId}:${selection.kind?.name}' == entry.key &&
              selection.skill != null &&
              available.containsKey(selection.skill))
            selection,
      ]..sort(
          (left, right) =>
              (left.selectionIndex ?? 0).compareTo(right.selectionIndex ?? 0),
        );

      final limit = group.selectionCount ?? 1;
      final seen = <Skill>{};
      for (final selection in selected) {
        if (seen.length >= limit) break;
        final skill = selection.skill;
        if (skill == null || seen.contains(skill)) continue;
        seen.add(skill);
        normalized.add(
          selection.copyWith(
            classDataId: group.classDataId,
            skill: available[skill],
            kind: group.kind,
            selectionIndex: seen.length - 1,
          ),
        );
      }
    }

    return normalized;
  }

  List<CharacterSpellSelectionData> _normalizeSpellSelections(
    List<CharacterSpellSelectionData> selections,
    List<ClassSpellSelectionGroupView>? groups,
  ) {
    final groupMap = {
      for (final group in groups ?? const <ClassSpellSelectionGroupView>[])
        if (group.kind != null && group.classDataId != null)
          '${group.classDataId}:${group.kind!.name}': group,
    };
    final normalized = <CharacterSpellSelectionData>[];

    for (final entry in groupMap.entries) {
      final group = entry.value;
      final available = {
        for (final spell in group.options ?? const <SpellData>[])
          if (_spellKey(spell) != null) _spellKey(spell)!: spell,
      };
      final selected = [
        for (final selection in selections)
          if ('${selection.classDataId}:${selection.kind?.name}' == entry.key &&
              _selectionSpellKey(selection) != null &&
              available.containsKey(_selectionSpellKey(selection)))
            selection,
      ]..sort(
          (left, right) =>
              (left.selectionIndex ?? 0).compareTo(right.selectionIndex ?? 0),
        );

      final limit = group.selectionCount ?? 1;
      for (var index = 0; index < selected.length && index < limit; index++) {
        final spell = available[_selectionSpellKey(selected[index])]!;
        normalized.add(
          selected[index].copyWith(
            spell: spell,
            spellId: spell.id,
            spellKey: _spellKey(spell),
            selectionIndex: index,
          ),
        );
      }
    }

    return normalized;
  }

  String? _selectionSpellKey(CharacterSpellSelectionData selection) {
    return _normalizedText(
          selection.spellKey,
        ) ??
        _spellKey(selection.spell);
  }

  String? _spellKey(SpellData? spell) {
    return _normalizedText(spell?.referenceKey) ?? _normalizedText(spell?.name);
  }

  String? _normalizedText(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  bool _hasSpellSelectionGroups(List<ClassSpellSelectionGroupView>? groups) {
    return groups?.any(
          (group) => group.kind != null && (group.options?.isNotEmpty ?? false),
        ) ??
        false;
  }

  Map<String, List<ClassChoiceOptionData>> _normalizeSelectedOptions(
    Map<String, List<ClassChoiceOptionData>> selections,
    List<ClassChoiceGroupView>? groups,
  ) {
    final choiceGroups = {
      for (final groupView in groups ?? const <ClassChoiceGroupView>[])
        if (groupView.group != null)
          _groupKey(groupView.group!): groupView.group!,
    };
    final availableOptions = _availableOptionsByGroup(groups);
    final normalized = <String, List<ClassChoiceOptionData>>{};

    for (final entry in selections.entries) {
      final group = choiceGroups[entry.key];
      if (group == null) continue;

      final selectionCount = group.selectionCount ?? 1;
      final allowDuplicates = group.allowDuplicates == true;
      final canonicalOptions = availableOptions[entry.key] ?? const {};
      final selected = <ClassChoiceOptionData>[];
      final seen = <String>{};

      for (final option in entry.value) {
        final optionKey = option.optionKey?.trim();
        if (optionKey == null || optionKey.isEmpty) continue;

        final canonical = canonicalOptions[optionKey];
        if (canonical == null) continue;

        if (!allowDuplicates) {
          if (seen.contains(optionKey)) continue;
          seen.add(optionKey);
        }

        selected.add(canonical);
        if (selected.length >= selectionCount) break;
      }

      if (selected.isNotEmpty) {
        normalized[entry.key] = selected;
      }
    }

    return normalized;
  }

  Map<String, Map<String, ClassChoiceOptionData>> _availableOptionsByGroup(
    List<ClassChoiceGroupView>? groups,
  ) {
    final result = <String, Map<String, ClassChoiceOptionData>>{};

    for (final groupView in groups ?? const <ClassChoiceGroupView>[]) {
      final group = groupView.group;
      if (group == null) continue;

      result[_groupKey(group)] = {
        for (final option
            in groupView.options ?? const <ClassChoiceOptionData>[])
          if (option.optionKey?.trim().isNotEmpty == true)
            option.optionKey!.trim(): option,
      };
    }

    return result;
  }

  bool _isClassChoiceSource(ChoiceSourceType? sourceType) {
    switch (sourceType) {
      case ChoiceSourceType.classData:
      case ChoiceSourceType.subclass:
      case ChoiceSourceType.classFeature:
      case ChoiceSourceType.subclassFeature:
        return true;
      case ChoiceSourceType.race:
      case ChoiceSourceType.subrace:
      case ChoiceSourceType.background:
      case null:
        return false;
    }
  }

  CharacterClassEntryData? _resolvePrimaryEntry(
    List<CharacterClassEntryData> entries,
  ) {
    for (final entry in entries) {
      if (entry.isStartingClass == true) {
        return entry;
      }
    }
    if (entries.isEmpty) return null;
    final sorted = [...entries]
      ..sort((a, b) => (a.classOrder ?? 0).compareTo(b.classOrder ?? 0));
    return sorted.first;
  }

  ClassData? _findClassById(List<ClassData> classes, int? id) {
    if (id == null) return null;
    try {
      return classes.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }

  SubclassData? _findSubclassById(List<SubclassData>? subclasses, int? id) {
    if (id == null) return null;
    try {
      return (subclasses ?? const <SubclassData>[])
          .firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }

  String _groupKey(ClassChoiceGroupData group) => group.exclusiveKey
              ?.trim()
              .isNotEmpty ==
          true
      ? group.exclusiveKey!
      : 'group_${group.id ?? group.name ?? _safeEnumToken(group.type) ?? 'unknown'}';

  String? _safeEnumToken(Object? value) {
    if (value == null) return null;
    final raw = value.toString();
    if (raw.trim().isEmpty) return null;
    final parts = raw.split('.');
    return parts.isEmpty ? raw : parts.last;
  }
}
