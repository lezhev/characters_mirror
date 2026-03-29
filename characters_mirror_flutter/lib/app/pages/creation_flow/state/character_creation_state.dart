import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_creation_state.freezed.dart';
part 'character_creation_state.g.dart';

enum Step {
  introduction,
  race,
  classStep,
  background,
  attributes,
  personal,
  summary
}

extension CreationStepX on Step {
  String get routePath =>
      this == Step.introduction ? '/create' : '/create/$name';

  String get labelRu {
    switch (this) {
      case Step.introduction:
        return 'Вступление';
      case Step.race:
        return 'Раса';
      case Step.classStep:
        return 'Класс';
      case Step.background:
        return 'Предыстория';
      case Step.attributes:
        return 'Характеристики';
      case Step.personal:
        return 'Личное';
      case Step.summary:
        return 'Сводка';
    }
  }

  int get number => index + 1;

  Step? get next {
    final nextIndex = index + 1;
    return nextIndex < Step.values.length ? Step.values[nextIndex] : null;
  }

  Step? get previous {
    final previousIndex = index - 1;
    return previousIndex >= 0 ? Step.values[previousIndex] : null;
  }
}

@freezed
sealed class CharacterCreationState with _$CharacterCreationState {
  const factory CharacterCreationState({
    required CharacterData character,
    @Default([]) List<CharacterClassEntryData> classEntries,
    @Default([]) List<CharacterChoiceData> choices,
    CharacterSheetSnapshotData? snapshot,
    required Step step,
  }) = _CharacterCreationState;

  factory CharacterCreationState.initial() => CharacterCreationState(
        character: CharacterData(),
        step: Step.introduction,
      );
}

@Riverpod(keepAlive: true)
class CharacterCreation extends _$CharacterCreation {
  @override
  CharacterCreationState build() => CharacterCreationState.initial();

  void nextStep(BuildContext context) {
    goToStep(context, state.step.next ?? Step.summary);
  }

  void prevStep(BuildContext context) {
    final previous = state.step.previous;
    if (previous == null) return;
    goToStep(context, previous);
  }

  void goToStep(BuildContext context, Step step) {
    context.go(step.routePath);
    state = state.copyWith(step: step);
  }

  void syncRaceDraft({
    RaceData? selectedRace,
    SubraceData? selectedSubrace,
  }) {
    if (selectedRace == null) return;
    _updateCharacter(
      state.character.copyWith(
        race: selectedRace,
        subrace: selectedSubrace,
      ),
    );
  }

  void syncBackgroundDraft(BackgroundData? selectedBackground) {
    if (selectedBackground == null) return;
    _updateCharacter(
      state.character.copyWith(background: selectedBackground),
    );
  }

  void syncAttributesDraft(Map<String, int> attributes) {
    _updateCharacter(
      state.character.copyWith(baseAbilityScores: attributes),
    );
  }

  void syncPrimaryClassDraft({
    required ClassData? classData,
    SubclassData? subclass,
    List<ClassChoiceGroupView> choiceGroups = const [],
    Map<String, ClassChoiceOptionData> selectedOptions = const {},
    int level = 1,
  }) {
    if (classData == null) return;

    applyPrimaryClassSelection(
      classData: classData,
      subclass: subclass,
      level: level,
      choices: buildClassChoices(
        selectedOptions: selectedOptions,
        groups: choiceGroups,
      ),
    );
  }

  void setName(String? name) =>
      _updateCharacter(state.character.copyWith(name: _normalizeText(name)));

  void setAge(String? value) =>
      _updateCharacter(state.character.copyWith(age: _normalizeText(value)));

  void setHeight(String? value) =>
      _updateCharacter(state.character.copyWith(height: _normalizeText(value)));

  void setWeight(String? value) =>
      _updateCharacter(state.character.copyWith(weight: _normalizeText(value)));

  void setEyes(String? value) =>
      _updateCharacter(state.character.copyWith(eyes: _normalizeText(value)));

  void setSkin(String? value) =>
      _updateCharacter(state.character.copyWith(skin: _normalizeText(value)));

  void setHair(String? value) =>
      _updateCharacter(state.character.copyWith(hair: _normalizeText(value)));

  void setAppearance(String? value) => _updateCharacter(
        state.character.copyWith(appearance: _normalizeText(value)),
      );

  void setBackstory(String? value) => _updateCharacter(
        state.character.copyWith(backstory: _normalizeText(value)),
      );

  void setGoals(String? value) =>
      _updateCharacter(state.character.copyWith(goals: _normalizeText(value)));

  void setAlliesOrganizations(String? value) => _updateCharacter(
        state.character.copyWith(
          alliesOrganizations: _normalizeText(value),
        ),
      );

  void setPersonalityTraits(String? value) => _updateCharacter(
        state.character.copyWith(personalityTraits: _normalizeText(value)),
      );

  void setIdeals(String? value) =>
      _updateCharacter(state.character.copyWith(ideals: _normalizeText(value)));

  void setBonds(String? value) =>
      _updateCharacter(state.character.copyWith(bonds: _normalizeText(value)));

  void setFlaws(String? value) =>
      _updateCharacter(state.character.copyWith(flaws: _normalizeText(value)));

  void setExperience(int? experience) =>
      _updateCharacter(state.character.copyWith(experience: experience));

  void setAlignment(CharacterAlignment? alignment) =>
      _updateCharacter(
        state.character.copyWith(
          alignmentValue: alignment,
        ),
      );

  void setRace(RaceData? race) =>
      _updateCharacter(state.character.copyWith(race: race));

  void setSubrace(SubraceData? subrace) =>
      _updateCharacter(state.character.copyWith(subrace: subrace));

  void setBackground(BackgroundData? background) =>
      _updateCharacter(state.character.copyWith(background: background));

  void setAttributes(Map<String, int> newAttributes) =>
      _updateCharacter(state.character.copyWith(baseAbilityScores: newAttributes));

  void setCurrentHp(int? value) =>
      _updateCharacter(state.character.copyWith(currentHp: value));

  void setTemporaryHp(int? value) =>
      _updateCharacter(state.character.copyWith(temporaryHp: value));

  void setInspiration(bool? value) =>
      _updateCharacter(state.character.copyWith(inspiration: value));

  void setNotes(String? notes) =>
      _updateCharacter(
        state.character.copyWith(notes: _normalizeText(notes)),
      );

  void setClassEntries(List<CharacterClassEntryData> entries) {
    state = state.copyWith(classEntries: entries);
  }

  void setChoices(List<CharacterChoiceData> choices) {
    state = state.copyWith(choices: choices);
  }

  void setSnapshot(CharacterSheetSnapshotData? snapshot) {
    state = state.copyWith(snapshot: snapshot);
  }

  void applyPrimaryClassSelection({
    required ClassData classData,
    SubclassData? subclass,
    int level = 1,
    List<CharacterChoiceData> choices = const [],
  }) {
    final entry = CharacterClassEntryData(
      characterId: state.character.id ?? 0,
      character: state.character.id == null ? null : state.character,
      classDataId: classData.id ?? 0,
      classData: classData,
      subclassId: subclass?.id,
      subclass: subclass,
      level: level,
      isStartingClass: true,
      classOrder: 0,
      hpMode: HitPointMode.fixed,
    );

    state = state.copyWith(
      classEntries: [entry],
      choices: choices,
    );
  }

  List<CharacterChoiceData> buildClassChoices({
    required Map<String, ClassChoiceOptionData> selectedOptions,
    required List<ClassChoiceGroupView> groups,
  }) {
    final choices = <CharacterChoiceData>[];
    final characterId = state.character.id ?? 0;

    for (final groupView in groups) {
      final group = groupView.group;
      if (group == null) continue;

      final groupKey = group.exclusiveKey?.trim().isNotEmpty == true
          ? group.exclusiveKey!
          : 'group_${group.id ?? group.name ?? _safeEnumToken(group.type) ?? 'unknown'}';
      final selected = selectedOptions[groupKey];
      if (selected == null) continue;

      choices.add(
        CharacterChoiceData(
          characterId: characterId,
          sourceType: _resolveChoiceSourceType(group),
          sourceId: group.id,
          groupKey: groupKey,
          optionKey: selected.optionKey,
          selectedText: selected.name,
        ),
      );
    }

    return choices;
  }

  CharacterBuildData toBuild() {
    return CharacterBuildData(
      character: state.character,
      classEntries: state.classEntries,
      choices: state.choices,
      snapshot: state.snapshot,
    );
  }

  void _updateCharacter(CharacterData updated) {
    state = state.copyWith(character: updated);
  }

  ChoiceSourceType _resolveChoiceSourceType(ClassChoiceGroupData group) {
    if (group.sourceFeatureId != null) return ChoiceSourceType.classFeature;
    if (group.sourceSubclassId != null) return ChoiceSourceType.subclass;
    if (group.sourceBackgroundId != null) return ChoiceSourceType.background;
    if (group.sourceSubraceId != null) return ChoiceSourceType.subrace;
    if (group.sourceRaceId != null) return ChoiceSourceType.race;
    return ChoiceSourceType.classData;
  }

  void reset() {
    state = CharacterCreationState.initial();
  }

  String? _normalizeText(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  String? _safeEnumToken(Object? value) {
    if (value == null) return null;
    final raw = value.toString();
    if (raw.trim().isEmpty) return null;
    final parts = raw.split('.');
    return parts.isEmpty ? raw : parts.last;
  }
}
