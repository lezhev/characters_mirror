import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/character_creation_ability_scores.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';

class SummaryMissingField {
  const SummaryMissingField(this.label, this.step);

  final String label;
  final Step step;
}

class SummaryOverviewData {
  const SummaryOverviewData({
    required this.character,
    required this.classEntry,
    required this.characterLevel,
    required this.abilityScores,
    required this.hasCompleteAbilityScores,
    required this.subclassIsLocked,
    required this.subclassIsMissing,
    required this.hasSubraceOptions,
    required this.missingFields,
  });

  factory SummaryOverviewData.fromState({
    required CharacterCreationState state,
    required bool hasSubraceOptions,
  }) {
    final character = state.character;
    final entries = character.classEntries ?? const <CharacterClassEntryData>[];
    final classEntry =
        entries.where((entry) => entry.isStartingClass == true).firstOrNull ??
            entries.firstOrNull;
    final level = classEntry?.level ?? 1;
    final classData = classEntry?.classData;
    final subclassLevel = classData?.subclassChoiceLevel;
    final subclassIsLocked = classEntry?.subclass == null &&
        subclassLevel != null &&
        level < subclassLevel;
    final subclassIsMissing = classEntry?.subclass == null &&
        subclassLevel != null &&
        level >= subclassLevel;
    final choices = character.choices ?? const <CharacterChoiceData>[];
    final abilityScores = buildCharacterCreationAbilityScores(
      character,
      choices,
      choiceGroups: [
        ...state.raceChoiceGroups,
        ...state.classChoiceGroups,
        ...state.backgroundChoiceGroups,
      ],
    );
    final completeAbilityScores = Ability.values.every(
      (ability) => abilityScores.containsKey(ability.name),
    );

    final missingFields = <SummaryMissingField>[
      if (classData == null)
        const SummaryMissingField('Класс', Step.classStep)
      else if (subclassIsMissing)
        const SummaryMissingField('Подкласс', Step.classStep),
      if (character.race == null)
        const SummaryMissingField('Раса', Step.race)
      else if (hasSubraceOptions && character.subrace == null)
        const SummaryMissingField('Подраса', Step.race),
      if (character.background == null)
        const SummaryMissingField('Предыстория', Step.background),
      if (!completeAbilityScores)
        const SummaryMissingField('Характеристики', Step.attributes),
    ];

    return SummaryOverviewData(
      character: character,
      classEntry: classEntry,
      characterLevel: level,
      abilityScores: abilityScores,
      hasCompleteAbilityScores: completeAbilityScores,
      subclassIsLocked: subclassIsLocked,
      subclassIsMissing: subclassIsMissing,
      hasSubraceOptions: hasSubraceOptions,
      missingFields: missingFields,
    );
  }

  final CharacterData character;
  final CharacterClassEntryData? classEntry;
  final int characterLevel;
  final Map<String, int> abilityScores;
  final bool hasCompleteAbilityScores;
  final bool subclassIsLocked;
  final bool subclassIsMissing;
  final bool hasSubraceOptions;
  final List<SummaryMissingField> missingFields;

  bool get hasAbilityScores => abilityScores.isNotEmpty;

  String get displayName {
    final name = character.name?.trim();
    return name == null || name.isEmpty ? 'Новый персонаж' : name;
  }

  Step? get firstMissingStep => missingFields.firstOrNull?.step;
}
