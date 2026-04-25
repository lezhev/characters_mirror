import 'package:characters_mirror_client/characters_mirror_client.dart';

List<CharacterChoiceData> buildGroupedChoices({
  required Map<String, List<ClassChoiceOptionData>> selectedOptions,
  required List<ClassChoiceGroupView> groups,
}) {
  final choices = <CharacterChoiceData>[];

  for (final groupView in groups) {
    final group = groupView.group;
    if (group == null) {
      continue;
    }

    final sourceType = resolveChoiceSourceType(group);
    final groupKey = classChoiceGroupKey(group);
    final selected = selectedOptions[groupKey] ?? const <ClassChoiceOptionData>[];
    if (selected.isEmpty) {
      continue;
    }

    for (var index = 0; index < selected.length; index++) {
      final option = selected[index];
      choices.add(
        CharacterChoiceData(
          sourceType: sourceType,
          sourceId: resolveChoiceSourceId(group, sourceType),
          groupKey: groupKey,
          optionKey: option.optionKey,
          selectionIndex: index,
          selectedLanguage:
              _selectedLanguageForChoice(group.type, option),
          selectedText: option.name,
        ),
      );
    }
  }

  return choices;
}

Language? _selectedLanguageForChoice(
  ClassChoiceType? type,
  ClassChoiceOptionData option,
) {
  if (type != ClassChoiceType.language) {
    return null;
  }
  final languages = option.grantedLanguages ?? const <Language>[];
  return languages.length == 1 ? languages.single : null;
}

Set<String> classChoiceGroupKeys(List<ClassChoiceGroupView> groups) {
  return {
    for (final groupView in groups)
      if (groupView.group != null) classChoiceGroupKey(groupView.group!),
  };
}

String classChoiceGroupKey(ClassChoiceGroupData group) {
  return group.exclusiveKey?.trim().isNotEmpty == true
      ? group.exclusiveKey!
      : 'group_${group.id ?? group.name ?? safeEnumToken(group.type) ?? 'unknown'}';
}

ChoiceSourceType resolveChoiceSourceType(ClassChoiceGroupData group) {
  if (group.sourceSubclassFeatureId != null) {
    return ChoiceSourceType.subclassFeature;
  }
  if (group.sourceFeatureId != null) {
    return ChoiceSourceType.classFeature;
  }
  if (group.sourceSubclassId != null) {
    return ChoiceSourceType.subclass;
  }
  if (group.sourceBackgroundId != null) {
    return ChoiceSourceType.background;
  }
  if (group.sourceSubraceId != null) {
    return ChoiceSourceType.subrace;
  }
  if (group.sourceRaceId != null) {
    return ChoiceSourceType.race;
  }
  return ChoiceSourceType.classData;
}

int? resolveChoiceSourceId(
  ClassChoiceGroupData group,
  ChoiceSourceType sourceType,
) {
  switch (sourceType) {
    case ChoiceSourceType.race:
      return group.sourceRaceId;
    case ChoiceSourceType.subrace:
      return group.sourceSubraceId;
    case ChoiceSourceType.background:
      return group.sourceBackgroundId;
    case ChoiceSourceType.classData:
      return group.sourceClassId;
    case ChoiceSourceType.subclass:
      return group.sourceSubclassId;
    case ChoiceSourceType.classFeature:
      return group.sourceFeatureId;
    case ChoiceSourceType.subclassFeature:
      return group.sourceSubclassFeatureId;
  }
}

String? safeEnumToken(Object? value) {
  if (value == null) {
    return null;
  }
  final raw = value.toString();
  if (raw.trim().isEmpty) {
    return null;
  }
  final parts = raw.split('.');
  return parts.isEmpty ? raw : parts.last;
}
