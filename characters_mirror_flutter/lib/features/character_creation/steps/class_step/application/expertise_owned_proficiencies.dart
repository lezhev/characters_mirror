import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/character_creation_choice_builder.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/application/expertise_choice_eligibility.dart';

List<ChoiceOptionData> resolveSelectedChoiceOptions({
  required Iterable<ChoiceGroupView> choiceGroups,
  Iterable<CharacterChoiceData> savedChoices = const [],
  Map<String, List<ChoiceOptionData>> draftSelections = const {},
}) {
  final result = <ChoiceOptionData>[];
  for (final groupView in choiceGroups) {
    final group = groupView.group;
    if (group == null) continue;
    final key = classChoiceGroupKey(group);
    final selectedKeys = <String>{
      ...?draftSelections[key]?.map((option) => option.optionKey.trim()),
      for (final choice in savedChoices)
        if (choice.groupKey == key) choice.optionKey?.trim() ?? '',
    };
    result.addAll(
      (groupView.options ?? const <ChoiceOptionData>[]).where(
        (option) => selectedKeys.contains(option.optionKey.trim()),
      ),
    );
  }
  return result;
}

({Set<Skill> skills, Set<String> toolKeys}) resolveExpertiseOwnedProficiencies({
  required CharacterData character,
  required BackgroundData? selectedBackground,
  required ClassData? selectedClass,
  required Iterable<CharacterSkillSelectionData> classSkillSelections,
  required Iterable<CharacterSkillSelectionData> backgroundSkillSelections,
  required Map<String, List<ChoiceOptionData>> selectedOptions,
  Iterable<ChoiceOptionData> otherSelectedOptions = const [],
  required String expertiseGroupKey,
}) {
  final skills = <Skill>{
    ...?character.race?.skillProficiencies,
    ...?character.subrace?.skillProficiencies,
    ...?selectedBackground?.skillProficiencies,
    ...?character.background?.skillProficiencies,
    for (final selection in [
      ...?character.skillSelections,
      ...classSkillSelections,
      ...backgroundSkillSelections,
    ])
      if (selection.skill != null) selection.skill!,
  };
  final toolKeys = <String>{
    ...?character.race?.toolProficiencyKeys,
    ...?character.subrace?.toolProficiencyKeys,
    ...?selectedBackground?.toolProficiencyKeys,
    ...?character.background?.toolProficiencyKeys,
    ...?selectedClass?.toolTrainingKeys,
    for (final entry in character.classEntries ?? const [])
      ...((entry.isStartingClass ?? false)
          ? entry.classData?.toolTrainingKeys ?? const <String>[]
          : entry.classData?.multiclassToolTrainingKeys ?? const <String>[]),
  };

  for (final entry in selectedOptions.entries) {
    if (entry.key == expertiseGroupKey) continue;
    for (final option in entry.value) {
      skills.addAll(option.grantedSkills ?? const <Skill>[]);
      toolKeys.addAll(option.grantedToolKeys ?? const <String>[]);
    }
  }
  for (final option in otherSelectedOptions) {
    skills.addAll(option.grantedSkills ?? const <Skill>[]);
    toolKeys.addAll(option.grantedToolKeys ?? const <String>[]);
  }

  final manualSkillOverrides = character.manualSkillProficiencyOverrides;
  if (manualSkillOverrides != null) {
    for (final state in manualSkillOverrides) {
      if (state.level == CharacterSkillProficiencyLevel.none) {
        skills.remove(state.skill);
      } else {
        skills.add(state.skill);
      }
    }
  } else if (character.manualSkillProficiencies != null) {
    skills
      ..clear()
      ..addAll([
        for (final state in character.manualSkillProficiencies!)
          if (state.level != CharacterSkillProficiencyLevel.none) state.skill,
      ]);
  }
  toolKeys
    ..removeAll(character.manualToolProficiencyOverrides?.removedKeys ?? [])
    ..addAll(character.manualToolProficiencyOverrides?.addedKeys ?? []);

  return (skills: skills, toolKeys: toolKeys);
}

Map<String, Set<String>> resolveExpertiseEligibleOptionKeys({
  required CharacterData character,
  required BackgroundData? selectedBackground,
  required ClassData? selectedClass,
  required Iterable<CharacterSkillSelectionData> classSkillSelections,
  required Iterable<CharacterSkillSelectionData> backgroundSkillSelections,
  required Map<String, List<ChoiceOptionData>> selectedOptions,
  Iterable<ChoiceOptionData> otherSelectedOptions = const [],
  required Iterable<ChoiceGroupView> choiceGroups,
}) {
  final result = <String, Set<String>>{};
  for (final groupView in choiceGroups) {
    final group = groupView.group;
    if (group?.type != ChoiceType.expertise) continue;
    final groupKey = classChoiceGroupKey(group!);
    final proficiencies = resolveExpertiseOwnedProficiencies(
      character: character,
      selectedBackground: selectedBackground,
      selectedClass: selectedClass,
      classSkillSelections: classSkillSelections,
      backgroundSkillSelections: backgroundSkillSelections,
      selectedOptions: selectedOptions,
      otherSelectedOptions: otherSelectedOptions,
      expertiseGroupKey: groupKey,
    );
    final eligibleView = filterExpertiseChoiceOptions(
      groupView,
      ownedSkills: proficiencies.skills,
      ownedToolKeys: proficiencies.toolKeys,
    );
    result[groupKey] = {
      for (final option in eligibleView.options ?? const <ChoiceOptionData>[])
        option.optionKey.trim(),
    };
  }
  return result;
}
