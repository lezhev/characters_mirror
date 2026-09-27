part of '../spell_page.dart';

double _spellCastButtonWidth(BuildContext context, String attackBonusLabel) {
  final textStyle =
      Theme.of(context).textTheme.labelLarge ?? const TextStyle(fontSize: 14);
  final textPainter = TextPainter(
    text: TextSpan(text: attackBonusLabel, style: textStyle),
    maxLines: 1,
    textDirection: Directionality.of(context),
  )..layout();

  const attackHorizontalPadding = 16.0;
  const iconHorizontalPadding = 20.0;
  const iconSize = 18.0;
  return math.max(
    textPainter.width + attackHorizontalPadding,
    iconSize + iconHorizontalPadding,
  );
}

String _spellSavingThrowMessage(SpellData spell, _SpellStats spellStats) {
  final ability = _savingThrowAbilityGenitiveLabel(spell.savingThrowAbility) ??
      'характеристики';
  return 'Цель должна пройти спасбросок $ability '
      'со сложностью ${spellStats.saveDcLabel}';
}

String? _savingThrowAbilityGenitiveLabel(String? value) {
  switch (_normalizedText(value)?.toLowerCase()) {
    case 'strength':
      return 'Силы';
    case 'dexterity':
      return 'Ловкости';
    case 'constitution':
      return 'Телосложения';
    case 'intelligence':
      return 'Интеллекта';
    case 'wisdom':
      return 'Мудрости';
    case 'charisma':
      return 'Харизмы';
  }
  return _normalizedText(value);
}

_SpellStats _spellStats(CharacterData character) {
  final ability = _spellcastingAbility(character);
  if (ability == null) {
    return const _SpellStats(
      saveDcLabel: '—',
      attackBonusLabel: '—',
    );
  }

  final proficiencyBonus = character.derived?.proficiencyBonus ?? 0;
  final abilityModifier = character.derived?.abilityModifiers?[ability] ??
      _abilityModifier(character.baseAbilityScores?[ability.name] ?? 10);
  final baseAttackBonus = proficiencyBonus + abilityModifier;
  final baseSaveDc = 8 + baseAttackBonus;
  final attackBonus = baseAttackBonus + (character.customSpellAttackBonus ?? 0);
  final saveDc = baseSaveDc + (character.customSpellSaveDcBonus ?? 0);

  return _SpellStats(
    saveDcLabel: '$saveDc',
    attackBonusLabel: _signedLabel(attackBonus),
    baseSaveDc: baseSaveDc,
    baseAttackBonus: baseAttackBonus,
    saveDcBonus: character.customSpellSaveDcBonus ?? 0,
    attackBonus: character.customSpellAttackBonus ?? 0,
    canRollSpellAttack: true,
  );
}

Map<int, List<_SpellEntry>> _spellEntriesByLevel(
  CharacterData character,
  _SpellPreparationState preparation,
) {
  final result = <int, List<_SpellEntry>>{};
  final seen = <String>{};
  final selections = [...?character.spellSelections]..sort(
      (left, right) =>
          (left.selectionIndex ?? 0).compareTo(right.selectionIndex ?? 0),
    );

  for (final selection in selections) {
    final spell = selection.spell;
    if (spell == null) {
      continue;
    }
    final key = spellKey(spell);
    if (key == null || !seen.add(key)) {
      continue;
    }
    final level = spell.level ?? 0;
    final isPrepared = preparation.preparedKeys.contains(key) ||
        preparation.alwaysPreparedKeys.contains(key);
    if (preparation.canPrepare && level > 0 && !isPrepared) {
      continue;
    }
    result.putIfAbsent(level, () => <_SpellEntry>[]).add(
          _SpellEntry(
            spell: spell,
            canPrepare: preparation.canPrepare && level > 0,
            isPrepared: isPrepared,
            isAlwaysPrepared: preparation.alwaysPreparedKeys.contains(key),
          ),
        );
  }

  return result;
}

List<int> _spellLevels(
  CharacterData character,
  Map<int, List<_SpellEntry>> spellsByLevel,
) {
  final levels = <int>{};
  for (final level in spellsByLevel.keys) {
    if (level > 0) {
      levels.add(level);
    }
  }
  for (final level in character.derived?.spellSlots?.keys ?? const <int>[]) {
    if (_slotCount(character, level) > 0) {
      levels.add(level);
    }
  }
  for (final level in character.derived?.pactSlots?.keys ?? const <int>[]) {
    if (_slotCount(character, level) > 0) {
      levels.add(level);
    }
  }
  return levels.toList()..sort();
}

int _slotCount(CharacterData character, int level) {
  return (character.derived?.spellSlots?[level] ?? 0) +
      (character.derived?.pactSlots?[level] ?? 0);
}

int _currentSlotCount(CharacterData character, int level) {
  final maxSlots = _slotCount(character, level);
  return (character.currentSpellSlots?[level] ?? maxSlots)
      .clamp(0, maxSlots)
      .toInt();
}

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}

Ability? _spellcastingAbility(CharacterData character) {
  final entries = [...?character.classEntries]
    ..sort((left, right) => (left.classOrder ?? 0).compareTo(
          right.classOrder ?? 0,
        ));

  for (final entry in entries) {
    final ability = entry.classData?.spellcastingAbilityValue;
    if (ability != null) {
      return ability;
    }
  }
  return null;
}

_SpellPreparationState _spellPreparationState(CharacterData character) {
  final alwaysPreparedKeys = {
    for (final key in character.derived?.alwaysPreparedSpellKeys ?? const [])
      if (_normalizedText(key) != null) _normalizedText(key)!,
  };
  final defaultPreparedKeys = {
    for (final selection
        in character.spellSelections ?? const <CharacterSpellSelectionData>[])
      if (selection.kind == CharacterSpellSelectionKind.preparedSpell &&
          _spellSelectionKey(selection) != null)
        _spellSelectionKey(selection)!,
  };
  final explicitPreparedKeys = character.preparedSpellKeys;
  final preparedKeys = explicitPreparedKeys == null
      ? defaultPreparedKeys
      : {
          for (final key in explicitPreparedKeys)
            if (_normalizedText(key) != null) _normalizedText(key)!,
        };

  return _SpellPreparationState(
    canPrepare: defaultPreparedKeys.isNotEmpty || explicitPreparedKeys != null,
    preparedKeys: preparedKeys,
    alwaysPreparedKeys: alwaysPreparedKeys,
  );
}

String? _spellSelectionKey(CharacterSpellSelectionData selection) {
  return _normalizedText(selection.spellKey) ?? spellKey(selection.spell);
}

_SpellManagementData _buildSpellManagementData(
  CharacterData character,
  List<SpellData> allSpells,
  List<ClassLevelData> classLevels,
) {
  final classIds = {
    for (final entry
        in character.classEntries ?? const <CharacterClassEntryData>[])
      if (entry.classData?.id != null) entry.classData!.id!,
  };
  final subclassIds = {
    for (final entry
        in character.classEntries ?? const <CharacterClassEntryData>[])
      if (entry.subclass?.id != null) entry.subclass!.id!,
  };
  final knownSpells = _knownSpells(character);
  final knownKeys = {
    for (final spell in knownSpells)
      if (spellKey(spell) != null) spellKey(spell)!,
  };
  final maxLevel = _maxAvailableSpellLevel(character);
  final availableSpells = [
    for (final spell in allSpells)
      if (_isSpellAvailableForCharacter(
            spell,
            classIds: classIds,
            subclassIds: subclassIds,
          ) &&
          (spell.level ?? 0) <= maxLevel)
        spell,
  ]..sort(_compareSpells);

  final preparedContexts = _preparedClassContexts(character, classLevels);
  final canPrepare = preparedContexts.isNotEmpty;
  final isWizard = preparedContexts.any((entry) {
    final name = entry.classData?.name?.trim().toLowerCase() ?? '';
    return name.contains('wizard') || name.contains('волшеб');
  });
  final preparedKeys = _effectivePreparedKeys(character);
  final spellByKey = <String, SpellData>{
    for (final spell in availableSpells)
      if (spellKey(spell) != null) spellKey(spell)!: spell,
    for (final spell in knownSpells)
      if (spellKey(spell) != null) spellKey(spell)!: spell,
  };
  final preparedSpells = [
    for (final key in preparedKeys)
      if (spellByKey[key] != null && (spellByKey[key]!.level ?? 0) > 0)
        spellByKey[key]!,
  ]..sort(_compareSpells);
  final preparationPool =
      (isWizard ? knownSpells : availableSpells).where((spell) {
    final key = spellKey(spell);
    return (spell.level ?? 0) > 0 && key != null && !preparedKeys.contains(key);
  }).toList()
        ..sort(_compareSpells);

  return _SpellManagementData(
    canPrepare: canPrepare,
    primaryClassDataId: _primarySpellClassId(character),
    knownSpells: knownSpells,
    learnableSpells: [
      for (final spell in availableSpells)
        if (spellKey(spell) != null && !knownKeys.contains(spellKey(spell)))
          spell,
    ],
    preparedSpells: preparedSpells,
    preparationSourceSpells: preparationPool,
    preparedCountLimit: _preparedSpellCountLimit(
      character,
      preparedContexts,
      classLevels,
    ),
  );
}

List<SpellData> _knownSpells(CharacterData character) {
  final seen = <String>{};
  final result = <SpellData>[];
  final selections = [...?character.spellSelections]..sort(
      (left, right) =>
          (left.selectionIndex ?? 0).compareTo(right.selectionIndex ?? 0),
    );
  for (final selection in selections) {
    final spell = selection.spell;
    final key = _spellSelectionKey(selection);
    if (spell == null || key == null || !seen.add(key)) {
      continue;
    }
    result.add(spell);
  }
  return result..sort(_compareSpells);
}

bool _isSpellAvailableForCharacter(
  SpellData spell, {
  required Set<int> classIds,
  required Set<int> subclassIds,
}) {
  return spell.availableForClassIds?.any(classIds.contains) == true ||
      spell.availableForSubclassIds?.any(subclassIds.contains) == true;
}

int _maxAvailableSpellLevel(CharacterData character) {
  final levels = [
    ...?character.derived?.spellSlots?.keys,
    ...?character.derived?.pactSlots?.keys,
  ];
  if (levels.isEmpty) {
    return 9;
  }
  return levels.reduce(math.max);
}

List<CharacterClassEntryData> _preparedClassContexts(
  CharacterData character,
  List<ClassLevelData> classLevels,
) {
  return [
    for (final entry
        in character.classEntries ?? const <CharacterClassEntryData>[])
      if (_classLevelForEntry(entry, classLevels)
              ?.preparedSpellFormula
              ?.trim()
              .isNotEmpty ==
          true)
        entry,
  ];
}

ClassLevelData? _classLevelForEntry(
  CharacterClassEntryData entry,
  List<ClassLevelData> classLevels,
) {
  final classId = entry.classData?.id;
  final level = entry.level ?? 1;
  if (classId == null) {
    return null;
  }
  for (final classLevel in classLevels) {
    if (classLevel.classDataId == classId && classLevel.level == level) {
      return classLevel;
    }
  }
  return null;
}

int? _preparedSpellCountLimit(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<ClassLevelData> classLevels,
) {
  var total = 0;
  for (final entry in entries) {
    final formula =
        _classLevelForEntry(entry, classLevels)?.preparedSpellFormula;
    final count = _preparedSpellCount(
      formula,
      character: character,
      classLevel: entry.level ?? 1,
    );
    if (count != null) {
      total += count;
    }
  }
  return total == 0 ? null : total;
}

int? _preparedSpellCount(
  String? formula, {
  required CharacterData character,
  required int classLevel,
}) {
  final normalizedFormula = formula?.trim().toLowerCase();
  if (normalizedFormula == null || normalizedFormula.isEmpty) {
    return null;
  }
  Ability? ability;
  for (final candidate in Ability.values) {
    if (normalizedFormula.contains('${candidate.name} modifier')) {
      ability = candidate;
      break;
    }
  }
  if (ability == null || !normalizedFormula.contains('level')) {
    return null;
  }
  final score = character.derived?.abilityScores?[ability] ??
      character.baseAbilityScores?[ability.name] ??
      10;
  final count = _abilityModifier(score) + classLevel;
  return count < 1 ? 1 : count;
}

int? _primarySpellClassId(CharacterData character) {
  final entries = [...?character.classEntries]
    ..sort((left, right) => (left.classOrder ?? 0).compareTo(
          right.classOrder ?? 0,
        ));
  for (final entry in entries) {
    if (entry.classData?.spellcastingAbilityValue != null &&
        entry.classData?.id != null) {
      return entry.classData!.id;
    }
  }
  return entries.firstOrNull?.classData?.id;
}

Set<String> _effectivePreparedKeys(CharacterData character) {
  final explicit = character.preparedSpellKeys;
  if (explicit != null) {
    return {
      for (final key in explicit)
        if (_normalizedText(key) != null) _normalizedText(key)!,
    };
  }
  return {
    for (final selection
        in character.spellSelections ?? const <CharacterSpellSelectionData>[])
      if (selection.kind == CharacterSpellSelectionKind.preparedSpell &&
          _spellSelectionKey(selection) != null)
        _spellSelectionKey(selection)!,
  };
}

List<CharacterSpellSelectionData> _addSpellSelection(
  List<CharacterSpellSelectionData>? selections,
  SpellData spell,
  int? classDataId,
) {
  final key = spellKey(spell);
  final next = [...?selections];
  if (key == null ||
      next.any((selection) => _spellSelectionKey(selection) == key)) {
    return next;
  }
  next.add(
    CharacterSpellSelectionData(
      classDataId: classDataId,
      spell: spell,
      spellId: spell.id,
      spellKey: key,
      kind: (spell.level ?? 0) <= 0
          ? CharacterSpellSelectionKind.knownCantrip
          : CharacterSpellSelectionKind.knownSpell,
      selectionIndex: next.length,
    ),
  );
  return next;
}

bool _hasSpell(CharacterData character, String key) {
  return (character.spellSelections ?? const <CharacterSpellSelectionData>[])
      .any((selection) => _spellSelectionKey(selection) == key);
}

String _spellLevelLabel(SpellData spell) {
  final level = spell.level ?? 0;
  return level <= 0 ? 'Заговор' : 'Круг $level';
}

int _compareSpells(SpellData left, SpellData right) {
  final levelCompare = (left.level ?? 0).compareTo(right.level ?? 0);
  if (levelCompare != 0) {
    return levelCompare;
  }
  return spellName(left).compareTo(spellName(right));
}

int _abilityModifier(int score) => ((score - 10) / 2).floor();

String _signedLabel(int value) => value >= 0 ? '+$value' : '$value';

class _SpellEntry {
  const _SpellEntry({
    required this.spell,
    required this.canPrepare,
    required this.isPrepared,
    required this.isAlwaysPrepared,
  });

  final SpellData spell;
  final bool canPrepare;
  final bool isPrepared;
  final bool isAlwaysPrepared;
}

class _SpellPreparationState {
  const _SpellPreparationState({
    required this.canPrepare,
    required this.preparedKeys,
    required this.alwaysPreparedKeys,
  });

  final bool canPrepare;
  final Set<String> preparedKeys;
  final Set<String> alwaysPreparedKeys;
}

class _SpellManagementData {
  const _SpellManagementData({
    required this.canPrepare,
    required this.primaryClassDataId,
    required this.knownSpells,
    required this.learnableSpells,
    required this.preparedSpells,
    required this.preparationSourceSpells,
    required this.preparedCountLimit,
  });

  final bool canPrepare;
  final int? primaryClassDataId;
  final List<SpellData> knownSpells;
  final List<SpellData> learnableSpells;
  final List<SpellData> preparedSpells;
  final List<SpellData> preparationSourceSpells;
  final int? preparedCountLimit;
}

class _SpellStats {
  const _SpellStats({
    required this.saveDcLabel,
    required this.attackBonusLabel,
    this.baseSaveDc,
    this.baseAttackBonus,
    this.saveDcBonus = 0,
    this.attackBonus = 0,
    this.canRollSpellAttack = false,
  });

  final String saveDcLabel;
  final String attackBonusLabel;
  final int? baseSaveDc;
  final int? baseAttackBonus;
  final int saveDcBonus;
  final int attackBonus;
  final bool canRollSpellAttack;

  bool get canEdit => baseSaveDc != null && baseAttackBonus != null;
  int get finalSaveDc => (baseSaveDc ?? 0) + saveDcBonus;
  int get finalAttackBonus => (baseAttackBonus ?? 0) + attackBonus;
}
