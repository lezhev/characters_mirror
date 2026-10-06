part of '../character_data_endpoint.dart';

void _validateLevelUpRequest(LevelUpRequest request) {
  Rules.rangeInt('characterId', request.characterId, min: 1, max: 2147483647);
  Rules.rangeInt('expectedVersion', request.expectedVersion,
      min: 1, max: 2147483647);
  Rules.shortText('classEntryId', request.classEntryId);
  Rules.rangeInt('subclassId', request.subclassId, min: 1, max: 2147483647);
  Rules.smallCollection('choices', request.choices);
  for (final entry
      in request.choices?.entries ?? const <MapEntry<String, List<String>>>[]) {
    Rules.shortText('choices.groupKey', entry.key);
    Rules.smallCollection('choices.${entry.key}', entry.value);
    for (final key in entry.value) {
      Rules.shortText('choices.optionKey', key);
    }
  }
  Rules.smallCollection('spells', request.spells);
  for (final spell in request.spells ?? const <LevelUpSpellChoice>[]) {
    Rules.rangeInt('spells.spellId', spell.spellId, min: 1, max: 2147483647);
    Rules.shortText('spells.replacesSelectionId', spell.replacesSelectionId);
  }
}

Future<LevelUpPreview> _previewLevelUp(
    Session session, CharacterData before, LevelUpRequest request,
    {Transaction? transaction,
    required _CharacterResolveContext resolveContext}) async {
  if (before.version != request.expectedVersion) {
    throw InputValidationException('expectedVersion',
        'Персонаж изменился. Откройте повышение уровня заново.');
  }
  final entries = before.classEntries ?? const <CharacterClassEntryData>[];
  final entry = entries.where((e) => e.id == request.classEntryId).firstOrNull;
  if (entry == null || entry.classData?.id == null) {
    throw InputValidationException(
        'classEntryId', 'Unknown character class entry.');
  }
  final oldLevel = entry.level ?? 0;
  final totalLevel = before.derived?.totalLevel ?? oldLevel;
  if (oldLevel < 1 || oldLevel >= 20 || totalLevel >= 20) {
    throw InputValidationException('level',
        'Level-up requires a class level from 1 to 19 and total level below 20.');
  }
  final nextLevel = oldLevel + 1;
  final die = entry.classData!.hitDieValue ?? 8;
  Rules.rangeInt('hitDieRoll', request.hitDieRoll, min: 1, max: die);
  final scores = {
    for (final e in before.derived!.abilityScores!.entries) e.key.name: e.value
  };
  final endpoint = ClassDataEndpoint();
  final oldStep = await endpoint.getStepView(session, entry.classData!.id!,
      selectedLevel: oldLevel,
      selectedSubclassId: entry.subclass?.id,
      abilityScores: scores);
  final step = await endpoint.getStepView(session, entry.classData!.id!,
      selectedLevel: nextLevel,
      selectedSubclassId: request.subclassId ?? entry.subclass?.id,
      abilityScores: scores);
  SubclassData? subclass = entry.subclass;
  if (request.subclassId != null) {
    final requiredLevel = step.subclassChoice?.requiredLevel;
    if (subclass != null && subclass.id != request.subclassId ||
        requiredLevel != null && requiredLevel > nextLevel) {
      throw InputValidationException(
          'subclassId', 'Subclass cannot be changed or selected yet.');
    }
    subclass = step.subclassChoice?.subclasses
        ?.where((s) =>
            s.id == request.subclassId &&
            (s.levelRequired ?? requiredLevel ?? 1) <= nextLevel)
        .firstOrNull;
    if (subclass == null) {
      throw InputValidationException(
          'subclassId', 'Subclass is unavailable for this class.');
    }
  }
  final oldKeys = {
    for (final g in oldStep.choiceGroups ?? const <ChoiceGroupView>[])
      g.group?.referenceKey
  };
  final groups = [
    for (final g in step.choiceGroups ?? const <ChoiceGroupView>[])
      if (!oldKeys.contains(g.group?.referenceKey)) g
  ];
  final sorted = [...entries]
    ..sort((a, b) => (a.classOrder ?? 0).compareTo(b.classOrder ?? 0));
  final rolled = [
    for (var i = 0; i < oldLevel; i++)
      if (i < (entry.hpRolledValues?.length ?? 0))
        entry.hpRolledValues![i]
      else if (i == 0 && sorted.first.id == entry.id)
        die
      else
        die ~/ 2 + 1,
    request.hitDieRoll ?? die ~/ 2 + 1
  ];
  final nextEntry = entry.copyWith(
      level: nextLevel, subclass: subclass, hpRolledValues: rolled);
  var draft = before.copyWith(classEntries: [
    for (final e in entries)
      if (e.id == entry.id) nextEntry else e
  ]);
  draft = _addLevelUpChoices(draft, nextEntry, groups, request);
  final rows = step.progression ?? const <ClassLevelData>[];
  ClassLevelData rowAt(int level) {
    final available = rows.where((r) => r.level <= level).toList()
      ..sort((a, b) => b.level.compareTo(a.level));
    return (available.firstOrNull ??
            ClassLevelData(classDataId: entry.classData!.id!, level: level))
        .copyWith(level: level);
  }

  final delta = buildClassSpellDelta(
      effectiveSpellcastingClass(entry.classData!, subclass, nextLevel),
      rowAt(oldLevel),
      rowAt(nextLevel),
      abilityScores: scores);
  draft = await _addLevelUpSpells(
      session, draft, nextEntry, step, delta, request,
      transaction: transaction);
  var derived = await _buildDerivedData(session, draft,
      transaction: transaction, resolveContext: resolveContext);
  _validateLevelUpAsi(before, derived, groups, request);
  draft =
      _preserveLevelChangeResources(before, draft.copyWith(derived: derived));
  derived = await _buildDerivedData(session, draft,
      transaction: transaction, resolveContext: resolveContext);
  draft = draft.copyWith(derived: derived);
  final missing = _missingLevelUpChoices(groups, request);
  if (request.hitDieRoll == null) missing.add('Выберите результат кости хитов');
  final subclassLevel = step.subclassChoice?.requiredLevel;
  if (subclass == null &&
      subclassLevel != null &&
      subclassLevel > oldLevel &&
      subclassLevel <= nextLevel) {
    missing.add('Выберите подкласс');
  }
  for (final (kind, count) in _levelUpSpellCounts(delta)) {
    final selected = (request.spells ?? const <LevelUpSpellChoice>[])
        .where((s) => s.kind == kind && s.replacesSelectionId == null)
        .length;
    if (selected < count) {
      missing.add(
          'Выберите ${count - selected} ${kind == CharacterSpellSelectionKind.knownCantrip ? 'заговоров' : 'заклинаний'}');
    }
  }
  return LevelUpPreview(
      before: before,
      character: draft,
      classStep: step,
      choiceGroups: groups,
      spellDelta: delta,
      missingDecisions: missing);
}
