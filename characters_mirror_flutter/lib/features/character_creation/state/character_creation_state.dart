import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/character_creation_choice_builder.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/character_creation_choice_filters.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/character_creation_text_normalizer.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/starting_equipment_selection_support.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/state/background_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
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

  static Step? fromContext(BuildContext context) {
    return fromRoutePath(GoRouterState.of(context).matchedLocation);
  }

  static Step? fromRoutePath(String? routePath) {
    if (routePath == null) return null;

    for (final step in Step.values) {
      if (step.routePath == routePath) {
        return step;
      }
    }

    return null;
  }

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
    required Step step,
    @Default(0) int draftRevision,
  }) = _CharacterCreationState;

  factory CharacterCreationState.initial() => CharacterCreationState(
        character: CharacterData(
          classEntries: const [],
          choices: const [],
          startingEquipmentSelections: const [],
          useFlexibleAbilityBonuses: false,
        ),
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

  void syncStep(Step step) {
    if (state.step == step) return;
    state = state.copyWith(step: step);
  }

  void syncRaceDraft({
    RaceData? selectedRace,
    SubraceData? selectedSubrace,
    List<CharacterChoiceData> raceChoices = const [],
  }) {
    if (selectedRace == null) return;
    final raceChanged = state.character.race?.id != selectedRace.id;
    final subraceChanged = state.character.subrace?.id != selectedSubrace?.id;
    final currentChoices =
        state.character.choices ?? const <CharacterChoiceData>[];
    final updatedCharacter = state.character.copyWith(
      race: selectedRace,
      subrace: selectedSubrace,
    );
    final preservedChoices = raceChanged || subraceChanged
        ? withoutChoiceSources(
            currentChoices,
            const {
              ChoiceSourceType.race,
              ChoiceSourceType.subrace,
            },
          )
        : withoutChoiceGroups(
            currentChoices,
            racialNonAttributeChoiceGroups(updatedCharacter),
          );

    _updateCharacter(
      updatedCharacter.copyWith(
        choices: [...preservedChoices, ...raceChoices],
      ),
    );
  }

  void syncBackgroundDraft({
    required BackgroundData? selectedBackground,
    List<ClassChoiceGroupView> choiceGroups = const [],
    Map<String, List<ClassChoiceOptionData>> selectedOptions = const {},
    List<CharacterStartingEquipmentSelectionData> startingEquipmentSelections =
        const [],
  }) {
    if (selectedBackground == null) return;

    final backgroundChanged =
        state.character.background?.id != selectedBackground.id;
    final currentChoices =
        state.character.choices ?? const <CharacterChoiceData>[];
    final currentEquipmentSelections =
        state.character.startingEquipmentSelections ??
            const <CharacterStartingEquipmentSelectionData>[];
    final backgroundChoices = buildBackgroundChoices(
      selectedOptions: selectedOptions,
      groups: choiceGroups,
    );
    final preservedChoices = backgroundChanged
        ? withoutChoiceSources(
            currentChoices,
            const {ChoiceSourceType.background},
          )
        : withoutChoiceGroups(
            currentChoices,
            classChoiceGroupKeys(choiceGroups),
          );

    _updateCharacter(
      state.character.copyWith(
        background: selectedBackground,
        choices: [...preservedChoices, ...backgroundChoices],
        startingEquipmentSelections: replaceEquipmentSelectionsForSource(
          existingSelections: backgroundChanged
              ? currentEquipmentSelections
                  .where(
                    (selection) =>
                        selection.sourceType != ChoiceSourceType.background,
                  )
                  .toList()
              : currentEquipmentSelections,
          sourceType: ChoiceSourceType.background,
          replacementSelections: startingEquipmentSelections,
        ),
      ),
    );
  }

  void syncAttributesDraft(Map<String, int> attributes) {
    _updateCharacter(
      state.character.copyWith(baseAbilityScores: attributes),
    );
  }

  void syncRacialAttributeChoicesDraft(List<CharacterChoiceData> choices) {
    final preserved = withoutChoiceGroups(
      state.character.choices ?? const <CharacterChoiceData>[],
      racialAttributeChoiceGroups(state.character),
    );

    _updateCharacter(
      state.character.copyWith(
        choices: [...preserved, ...choices],
      ),
    );
  }

  void syncPrimaryClassDraft({
    required ClassData? classData,
    SubclassData? subclass,
    List<ClassChoiceGroupView> choiceGroups = const [],
    Map<String, List<ClassChoiceOptionData>> selectedOptions = const {},
    List<CharacterSpellSelectionData> spellSelections = const [],
    List<CharacterStartingEquipmentSelectionData> startingEquipmentSelections =
        const [],
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
      spellSelections: spellSelections,
      startingEquipmentSelections: startingEquipmentSelections,
    );
  }

  void setName(String? name) => _updateCharacter(
        state.character.copyWith(name: normalizeCharacterCreationText(name)),
      );

  void setAge(String? value) => _updateCharacter(
        state.character.copyWith(age: normalizeCharacterCreationText(value)),
      );

  void setHeight(String? value) => _updateCharacter(
        state.character.copyWith(height: normalizeCharacterCreationText(value)),
      );

  void setWeight(String? value) => _updateCharacter(
        state.character.copyWith(weight: normalizeCharacterCreationText(value)),
      );

  void setEyes(String? value) => _updateCharacter(
        state.character.copyWith(eyes: normalizeCharacterCreationText(value)),
      );

  void setSkin(String? value) => _updateCharacter(
        state.character.copyWith(skin: normalizeCharacterCreationText(value)),
      );

  void setHair(String? value) => _updateCharacter(
        state.character.copyWith(hair: normalizeCharacterCreationText(value)),
      );

  void setAppearance(String? value) => _updateCharacter(
        state.character.copyWith(
          appearance: normalizeCharacterCreationText(value),
        ),
      );

  void setBackstory(String? value) => _updateCharacter(
        state.character.copyWith(
          backstory: normalizeCharacterCreationText(value),
        ),
      );

  void setGoals(String? value) => _updateCharacter(
        state.character.copyWith(goals: normalizeCharacterCreationText(value)),
      );

  void setAlliesOrganizations(String? value) => _updateCharacter(
        state.character.copyWith(
          alliesOrganizations: normalizeCharacterCreationText(value),
        ),
      );

  void setPersonalityTraits(String? value) => _updateCharacter(
        state.character.copyWith(
          personalityTraits: normalizeCharacterCreationText(value),
        ),
      );

  void setIdeals(String? value) => _updateCharacter(
        state.character.copyWith(
          ideals: normalizeCharacterCreationText(value),
        ),
      );

  void setBonds(String? value) => _updateCharacter(
        state.character.copyWith(bonds: normalizeCharacterCreationText(value)),
      );

  void setFlaws(String? value) => _updateCharacter(
        state.character.copyWith(flaws: normalizeCharacterCreationText(value)),
      );

  void setExperience(int? experience) =>
      _updateCharacter(state.character.copyWith(experience: experience));

  void setAlignment(CharacterAlignment? alignment) => _updateCharacter(
        state.character.copyWith(
          alignmentValue: alignment,
        ),
      );

  void setRace(RaceData? race) => state = state.copyWith(
        character: state.character.copyWith(
          race: race,
          choices: state.character.race?.id != race?.id
              ? withoutChoiceSources(
                  state.character.choices ?? const <CharacterChoiceData>[],
                  const {
                    ChoiceSourceType.race,
                    ChoiceSourceType.subrace,
                  },
                )
              : state.character.choices,
        ),
      );

  void setSubrace(SubraceData? subrace) => state = state.copyWith(
        character: state.character.copyWith(
          subrace: subrace,
          choices: state.character.subrace?.id != subrace?.id
              ? withoutChoiceSources(
                  state.character.choices ?? const <CharacterChoiceData>[],
                  const {
                    ChoiceSourceType.race,
                    ChoiceSourceType.subrace,
                  },
                )
              : state.character.choices,
        ),
      );

  void setBackground(BackgroundData? background) =>
      _updateCharacter(state.character.copyWith(background: background));

  void setAttributes(Map<String, int> newAttributes) => _updateCharacter(
      state.character.copyWith(baseAbilityScores: newAttributes));

  void setCurrentHp(int? value) =>
      _updateCharacter(state.character.copyWith(currentHp: value));

  void setTemporaryHp(int? value) =>
      _updateCharacter(state.character.copyWith(temporaryHp: value));

  void setInspiration(bool? value) =>
      _updateCharacter(state.character.copyWith(inspiration: value));

  void setNotes(String? notes) => _updateCharacter(
        state.character.copyWith(
          notes: _singleNoteList(notes),
        ),
      );

  void setClassEntries(List<CharacterClassEntryData> entries) {
    _updateCharacter(
      state.character.copyWith(classEntries: entries),
    );
  }

  void setChoices(List<CharacterChoiceData> choices) {
    _updateCharacter(
      state.character.copyWith(choices: choices),
    );
  }

  void setDerived(CharacterDerivedData? derived) {
    _updateCharacter(
      state.character.copyWith(derived: derived),
    );
  }

  void setUseFlexibleAbilityBonuses(bool value) {
    _updateCharacter(
      state.character.copyWith(useFlexibleAbilityBonuses: value),
    );
  }

  void applyPrimaryClassSelection({
    required ClassData classData,
    SubclassData? subclass,
    int level = 1,
    List<CharacterChoiceData> choices = const [],
    List<CharacterSpellSelectionData> spellSelections = const [],
    List<CharacterStartingEquipmentSelectionData> startingEquipmentSelections =
        const [],
  }) {
    final entry = CharacterClassEntryData(
      classData: classData,
      subclass: subclass,
      level: level,
      isStartingClass: true,
      classOrder: 0,
      hpMode: HitPointMode.fixed,
    );

    final preserved = withoutChoiceSources(
      state.character.choices ?? const <CharacterChoiceData>[],
      const {
        ChoiceSourceType.classData,
        ChoiceSourceType.subclass,
        ChoiceSourceType.classFeature,
        ChoiceSourceType.subclassFeature,
      },
    );

    final linkedChoices = choices
        .map(
            (choice) => choice.copyWith(classEntry: choice.classEntry ?? entry))
        .toList();
    final preservedSpellSelections = [
      for (final selection in state.character.spellSelections ??
          const <CharacterSpellSelectionData>[])
        if (selection.classDataId != classData.id) selection,
    ];
    final linkedSpellSelections = [
      for (final selection in spellSelections)
        selection.copyWith(classEntry: selection.classEntry ?? entry),
    ];
    final currentEquipmentSelections =
        state.character.startingEquipmentSelections ??
            const <CharacterStartingEquipmentSelectionData>[];

    _updateCharacter(
      state.character.copyWith(
        classEntries: [entry],
        choices: [...preserved, ...linkedChoices],
        spellSelections: [
          ...preservedSpellSelections,
          ...linkedSpellSelections,
        ],
        startingEquipmentSelections: replaceEquipmentSelectionsForSource(
          existingSelections: currentEquipmentSelections,
          sourceType: ChoiceSourceType.classData,
          replacementSelections: startingEquipmentSelections,
        ),
      ),
    );
  }

  List<CharacterChoiceData> buildClassChoices({
    required Map<String, List<ClassChoiceOptionData>> selectedOptions,
    required List<ClassChoiceGroupView> groups,
  }) {
    return buildGroupedChoices(
      selectedOptions: selectedOptions,
      groups: groups,
    );
  }

  List<CharacterChoiceData> buildBackgroundChoices({
    required Map<String, List<ClassChoiceOptionData>> selectedOptions,
    required List<ClassChoiceGroupView> groups,
  }) {
    return buildGroupedChoices(
      selectedOptions: selectedOptions,
      groups: groups,
    );
  }

  void _updateCharacter(CharacterData updated) {
    state = state.copyWith(character: updated);
  }

  void reset() {
    state = CharacterCreationState.initial().copyWith(
      draftRevision: state.draftRevision + 1,
    );
    ref.invalidate(raceStateProvider);
    ref.invalidate(classStateProvider);
    ref.invalidate(backgroundStateProvider);
  }
}

List<CharacterNoteData>? _singleNoteList(String? value) {
  final normalized = normalizeCharacterCreationText(value);
  return normalized == null ? null : [CharacterNoteData(text: normalized)];
}
