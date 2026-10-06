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
    if (key == null) continue;
    final level = spell.level ?? 0;
    final isPrepared = preparation.preparedKeys.contains(key) ||
        preparation.alwaysPreparedKeys.contains(key);
    final sourceClass = selection.classEntry?.classData ??
        spellEntryForClass(character, selection.classDataId)?.classData;
    final explicitMode = sourceClass?.spellSelectionMode;
    final requiresPreparation =
        selection.kind == CharacterSpellSelectionKind.spellbookSpell ||
            selection.kind == CharacterSpellSelectionKind.preparedSpell ||
            explicitMode == ClassSpellSelectionMode.prepared ||
            explicitMode == ClassSpellSelectionMode.spellbook ||
            (explicitMode == null && preparation.canPrepare);
    if (requiresPreparation && level > 0 && !isPrepared) continue;
    if (!seen.add(key)) continue;
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
    final ability = spellcastingClassForEntry(entry)?.spellcastingAbilityValue;
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
    canPrepare: defaultPreparedKeys.isNotEmpty ||
        explicitPreparedKeys != null ||
        (character.classEntries?.any((entry) => {
                  ClassSpellSelectionMode.prepared,
                  ClassSpellSelectionMode.spellbook
                }.contains(entry.classData?.spellSelectionMode)) ??
            false),
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
  final poolByKey = <String, SpellData>{
    for (final entry in preparedContexts)
      for (final spell in preparationPoolForEntry(character, entry,
          _classLevelForEntry(entry, classLevels), availableSpells))
        if (spellKey(spell) != null && !preparedKeys.contains(spellKey(spell)))
          spellKey(spell)!: spell,
  };
  final preparationClassIds = <String, int?>{};
  for (final entry in preparedContexts) {
    for (final spell in preparationPoolForEntry(character, entry,
        _classLevelForEntry(entry, classLevels), availableSpells)) {
      final key = spellKey(spell);
      if (key != null) {
        preparationClassIds.putIfAbsent(key, () => entry.classData?.id);
      }
    }
  }
  final preparationPool = poolByKey.values.toList()..sort(_compareSpells);

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
    preparationClassIds: preparationClassIds,
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
      if ({ClassSpellSelectionMode.prepared, ClassSpellSelectionMode.spellbook}
          .contains(spellMode(spellcastingClassForEntry(entry),
              _classLevelForEntry(entry, classLevels))))
        entry,
  ];
}

ClassLevelData? _classLevelForEntry(
  CharacterClassEntryData entry,
  List<ClassLevelData> classLevels,
) {
  return spellLevelForEntry(entry, classLevels);
}

int? _preparedSpellCountLimit(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<ClassLevelData> classLevels,
) {
  var total = 0;
  for (final entry in entries) {
    final row = _classLevelForEntry(entry, classLevels);
    final scores = {
      for (final ability in Ability.values)
        ability.name: character.derived?.abilityScores?[ability] ??
            character.baseAbilityScores?[ability.name] ??
            10
    };
    final count = row == null ? null : preparedLimit(row, scores);
    if (count != null) {
      total += count;
    }
  }
  return total == 0 ? null : total;
}

int? _primarySpellClassId(CharacterData character) {
  final entries = [...?character.classEntries]
    ..sort((left, right) => (left.classOrder ?? 0).compareTo(
          right.classOrder ?? 0,
        ));
  for (final entry in entries) {
    if (spellcastingClassForEntry(entry)?.spellcastingAbilityValue != null &&
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
  CharacterData character,
  SpellData spell,
  int? classDataId, {
  ClassLevelData? classLevel,
}) {
  final next = [...?character.spellSelections];
  final selection = learnedSpellSelection(character, spell, classDataId,
      classLevel: classLevel);
  if (selection.spellKey != null &&
      !next.any(
          (item) => selectionIdentity(item) == selectionIdentity(selection))) {
    next.add(selection.copyWith(
      selectionIndex: nextSpellSelectionIndex(
        next,
        classEntry: selection.classEntry,
        classDataId: selection.classDataId,
        kind: selection.kind!,
      ),
    ));
  }
  return next;
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

class _SpellManagementCatalogs {
  const _SpellManagementCatalogs({
    required this.allSpells,
    required this.classLevels,
  });

  final List<SpellData> allSpells;
  final List<ClassLevelData> classLevels;
}

class _SpellManagementData {
  const _SpellManagementData({
    required this.canPrepare,
    required this.primaryClassDataId,
    required this.knownSpells,
    required this.learnableSpells,
    required this.preparedSpells,
    required this.preparationClassIds,
    required this.preparationSourceSpells,
    required this.preparedCountLimit,
  });

  final bool canPrepare;
  final int? primaryClassDataId;
  final List<SpellData> knownSpells;
  final List<SpellData> learnableSpells;
  final List<SpellData> preparedSpells;
  final Map<String, int?> preparationClassIds;
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
