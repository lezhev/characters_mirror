import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/conditional_choice_support.dart';
import 'expertise_owned_proficiencies.dart';
import '../state/class_state.dart';

CharacterData conditionalClassDraft(
        ClassStateModel data, CharacterData character) =>
    character.copyWith(
      classEntries: [
        CharacterClassEntryData(
            classData: data.selectedClass,
            subclass: data.selectedSubclass,
            level: data.selectedLevel,
            isStartingClass: true)
      ],
      spellSelections: data.selectedSpellSelections,
    );

Map<String, List<ChoiceOptionData>> conditionalClassSelections(
        ClassStateModel data,
        CharacterData character,
        Iterable<ChoiceGroupView> otherGroups) =>
    resolveConditionalChoiceSelections(
      character: conditionalClassDraft(data, character),
      groups: data.stepView?.choiceGroups ?? [],
      selections: data.selectedOptions,
      classFeatures: data.stepView?.currentLevelFeatures ?? [],
      subclassFeatures: data.stepView?.currentSubclassFeatures ?? [],
      otherOptions: resolveSelectedChoiceOptions(
          choiceGroups: otherGroups.toList(),
          savedChoices: character.choices ?? []),
    );
