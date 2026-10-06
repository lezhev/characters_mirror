import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character_spells/spell_selection_support.dart';
import 'package:characters_mirror_flutter/utils/calculate_max_hp_for_character.dart';

/// Projects the draft from the last confirmed preview, avoiding cumulative drift.
/// Catalog changes and final validation are still resolved by the server.
LevelUpPreview optimisticLevelUpPreview(LevelUpPreview confirmed,
    LevelUpRequest confirmedRequest, LevelUpRequest request) {
  final character = confirmed.character;
  final oldEntries =
      character.classEntries ?? const <CharacterClassEntryData>[];
  final target =
      oldEntries.where((e) => e.id == request.classEntryId).firstOrNull;
  final subclassChanged = request.subclassId != confirmedRequest.subclassId;
  final subclass = confirmed.classStep.subclassChoice?.subclasses
      ?.where((s) => s.id == request.subclassId)
      .firstOrNull;
  final groups = confirmed.choiceGroups
      .where((view) =>
          !subclassChanged ||
          (view.group?.sourceSubclassId == null &&
              view.group?.sourceSubclassFeatureId == null))
      .toList();
  final previousBonuses =
      _choiceAbilityBonuses(confirmed.choiceGroups, confirmedRequest);
  final bonuses = _choiceAbilityBonuses(groups, request);
  final scores = {...?character.derived?.abilityScores};
  final modifiers = {...?character.derived?.abilityModifiers};
  for (final ability in scores.keys) {
    scores[ability] = scores[ability]! -
        (previousBonuses[ability.name] ?? 0) +
        (bonuses[ability.name] ?? 0);
    modifiers[ability] = ((scores[ability]! - 10) / 2).floor();
  }
  final descriptors = hitPointLevelDescriptors(oldEntries);
  final entries = [
    for (var i = 0; i < oldEntries.length; i++)
      if (oldEntries[i].id != request.classEntryId)
        oldEntries[i]
      else
        () {
          final values = descriptors
              .where((d) => d.entryIndex == i)
              .map((d) => d.value)
              .toList();
          if (values.isNotEmpty) {
            values[values.length - 1] = request.hitDieRoll ??
                descriptors.lastWhere((d) => d.entryIndex == i).defaultGain;
          }
          return oldEntries[i].copyWith(
              hpRolledValues: values,
              subclass: subclassChanged ? subclass : oldEntries[i].subclass);
        }(),
  ];
  final entry =
      entries.where((e) => e.id == request.classEntryId).firstOrNull ?? target;
  final choices = [
    ...?confirmed.before.choices,
    for (final selection
        in request.choices?.entries ?? const <MapEntry<String, List<String>>>[])
      for (var i = 0; i < selection.value.length; i++)
        CharacterChoiceData(
            classEntry: entry,
            groupKey: selection.key,
            optionKey: selection.value[i],
            selectionIndex: i),
  ];
  final replacements = {
    for (final s in request.spells ?? const <LevelUpSpellChoice>[])
      if (s.replacesSelectionId != null) s.replacesSelectionId
  };
  final spellSelections = <CharacterSpellSelectionData>[
    for (final s in confirmed.before.spellSelections ??
        const <CharacterSpellSelectionData>[])
      if (!replacements.contains(s.id)) s,
  ];
  for (final choice in request.spells ?? const <LevelUpSpellChoice>[]) {
    final replaced = choice.replacesSelectionId == null
        ? null
        : confirmed.before.spellSelections
            ?.where((selection) =>
                selection.id == choice.replacesSelectionId &&
                selection.classEntry?.id == request.classEntryId &&
                selection.kind == CharacterSpellSelectionKind.knownSpell)
            .firstOrNull;
    final spell = confirmed.classStep.spellSelectionGroups
        ?.where((group) => group.kind == choice.kind)
        .expand((group) => group.options ?? const <SpellData>[])
        .where((option) => option.id == choice.spellId)
        .firstOrNull;
    spellSelections.add(CharacterSpellSelectionData(
      classEntry: entry,
      kind: choice.kind,
      spellId: choice.spellId,
      spellKey: spell?.referenceKey,
      spell: spell,
      selectionIndex: replaced?.selectionIndex ??
          (replaced == null
              ? nextSpellSelectionIndex(
                  spellSelections,
                  classEntry: entry,
                  classDataId: entry?.classData?.id,
                  kind: choice.kind,
                )
              : null),
    ));
  }
  var draft = character.copyWith(
      classEntries: entries,
      choices: choices,
      spellSelections: spellSelections,
      derived: character.derived
          ?.copyWith(abilityScores: scores, abilityModifiers: modifiers));
  if (target != null && draft.derived != null) {
    draft = draft.copyWith(
        derived:
            draft.derived!.copyWith(maxHp: calculateMaxHpForCharacter(draft)));
  }
  return confirmed.copyWith(
      character: draft,
      choiceGroups: groups,
      classStep: subclassChanged
          ? confirmed.classStep.copyWith(currentSubclassFeatures: [])
          : confirmed.classStep);
}

Map<String, int> _choiceAbilityBonuses(
    List<ChoiceGroupView> groups, LevelUpRequest request) {
  final result = <String, int>{};
  for (final view in groups) {
    for (final key
        in request.choices?[view.group?.referenceKey] ?? const <String>[]) {
      final option = view.options?.where((o) => o.optionKey == key).firstOrNull;
      for (final bonus in option?.grantedAbilityBonuses?.entries ??
          const <MapEntry<String, int>>[]) {
        result[bonus.key] = (result[bonus.key] ?? 0) + bonus.value;
      }
    }
  }
  return result;
}
