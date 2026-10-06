import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/choice_group_presentation.dart';

enum LevelUpChoicePresentation { inline, picker }

Map<Ability, int> cycleAsi(
    Map<Ability, int> current, Ability ability, Map<Ability, int> scores) {
  final next = {...current};
  final old = next[ability] ?? 0;
  var value = (old + 1) % 3;
  if ((scores[ability] ?? 10) + value > 20) value = 0;
  final spent = current.values.fold<int>(0, (a, b) => a + b);
  if (spent - old + value > 2) return next;
  if (value == 0) {
    next.remove(ability);
  } else {
    next[ability] = value;
  }
  return next;
}

List<String>? asiOptionKeys(ChoiceGroupView view, Map<Ability, int> values) {
  final target = {
    for (final e in values.entries)
      if (e.value > 0) e.key.name: e.value
  };
  if (target.isEmpty) return [];
  final options = view.options ?? const <ChoiceOptionData>[];
  final limit = view.group?.selectionCount ?? 1;
  List<String>? search(Map<String, int> remaining, List<String> keys) {
    if (remaining.values.every((v) => v == 0)) return keys;
    if (keys.length >= limit) return null;
    for (final option in options) {
      final bonus = option.grantedAbilityBonuses;
      if (bonus == null || bonus.isEmpty || bonus.values.any((v) => v <= 0)) {
        continue;
      }
      if (view.group?.allowDuplicates != true &&
          keys.contains(option.optionKey)) {
        continue;
      }
      if (bonus.entries.any((e) => e.value > (remaining[e.key] ?? 0))) continue;
      final next = {...remaining};
      for (final e in bonus.entries) {
        next[e.key] = next[e.key]! - e.value;
      }
      final result = search(next, [...keys, option.optionKey]);
      if (result != null) return result;
    }
    return null;
  }

  return search(target, []);
}

LevelUpChoicePresentation choicePresentation(ChoiceGroupView view,
    {LevelUpChoicePresentation? override}) {
  if (override != null) return override;
  return choicePresentationMode(view) == ChoicePresentationMode.picker
      ? LevelUpChoicePresentation.picker
      : LevelUpChoicePresentation.inline;
}
