import 'package:characters_mirror_client/characters_mirror_client.dart';

List<CharacterChoiceData> buildGroupedChoices({
  required Map<String, List<ChoiceOptionData>> selectedOptions,
  required List<ChoiceGroupView> groups,
}) {
  final choices = <CharacterChoiceData>[];

  for (final groupView in groups) {
    final group = groupView.group;
    if (group == null) {
      continue;
    }

    final groupKey = group.referenceKey;
    final selected = selectedOptions[groupKey] ?? const <ChoiceOptionData>[];
    if (selected.isEmpty) {
      continue;
    }

    for (var index = 0; index < selected.length; index++) {
      final option = selected[index];
      choices.add(
        CharacterChoiceData(
          groupKey: groupKey,
          optionKey: option.optionKey,
          selectionIndex: index,
        ),
      );
    }
  }

  return choices;
}

Set<String> classChoiceGroupKeys(List<ChoiceGroupView> groups) {
  return {
    for (final groupView in groups)
      if (groupView.group != null) classChoiceGroupKey(groupView.group!),
  };
}

String classChoiceGroupKey(ChoiceGroupData group) => group.referenceKey;
