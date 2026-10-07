import 'spell_presentation.dart';
import 'spell_protocol_values.dart';
import '../feature_modifier_evaluator.dart';

class SpellDamagePart {
  const SpellDamagePart(
      {required this.formula, this.damageType, this.scaling, this.notes});
  final String formula;
  final String? damageType;
  final Map<String, dynamic>? scaling;
  final String? notes;
}

/// The protocol JSON boundary lets server and client use one pure resolver.
List<SpellDamagePart> effectiveSpellDamageParts(Map<String, dynamic> spell) {
  final parts = <SpellDamagePart>[
    for (final part in (spell['damageParts'] as List? ?? []).cast<Map>())
      if (_text(part['formula']) != null)
        SpellDamagePart(
            formula: _text(part['formula'])!,
            damageType: part['damageType'] as String?,
            scaling: (part['scaling'] as Map?)?.cast<String, dynamic>(),
            notes: spellDescriptionText(part['notes'] as String?)),
  ];
  if (parts.isNotEmpty) return parts;
  final formula = _text(spell['damageDice']);
  return formula == null
      ? []
      : [
          SpellDamagePart(
              formula: formula,
              damageType: spell['damageType'] as String?,
              scaling:
                  (spell['damageScaling'] as Map?)?.cast<String, dynamic>())
        ];
}

String scaledSpellFormula(String base, Map<String, dynamic>? scaling,
    SpellPresentationContext context) {
  if (scaling == null) return base;
  final mode = scaling['mode'];
  if (mode == 'slotLevel') {
    final values = spellProtocolIntMap<String>(scaling['scalingBySlotLevel']);
    // Slot maps are complete formulas at exact levels, never inferred increments.
    return _text(values[context.castLevel]) ?? base;
  }
  if (mode == 'casterLevel') {
    final values = spellProtocolIntMap<String>(scaling['scalingByCasterLevel']);
    final thresholds = values.keys
        .map((k) => int.tryParse('$k'))
        .whereType<int>()
        .where((k) => k <= context.casterLevel)
        .toList()
      ..sort();
    if (thresholds.isNotEmpty) {
      final key = thresholds.last;
      return _text(values[key]) ?? base;
    }
  }
  return base;
}

class SpellPresentationResolver {
  const SpellPresentationResolver();
  SpellPresentation resolve(Map<String, dynamic> spell,
      {SpellPresentationContext context = const SpellPresentationContext()}) {
    final highlights = <SpellHighlight>[];
    final upcast = (context.castLevel ?? 0) > (spell['level'] as int? ?? 0) &&
        (spell['level'] as int? ?? 0) > 0;
    final parts = effectiveSpellDamageParts(spell);
    if (parts.isNotEmpty) {
      final computedUpcast = parts.any((p) =>
          p.scaling?['mode'] == 'slotLevel' &&
          spellProtocolIntMap<String>(p.scaling?['scalingBySlotLevel'])
              .containsKey(context.castLevel));
      highlights.add(SpellHighlight(
          SpellHighlightKind.damage,
          upcast && !computedUpcast ? 'Урон (база)' : 'Урон',
          parts.map((p) {
            final formula =
                _dice(scaledSpellFormula(p.formula, p.scaling, context));
            final type = _damageTypes[p.damageType] ?? p.damageType;
            return '$formula${type == null ? '' : ' ($type)'}${p.notes == null ? '' : ' — ${p.notes}'}';
          }).join(parts.any((p) => p.notes != null) ? '; ' : ' + '),
          damageParts: List.unmodifiable(parts.map((p) => SpellDamageHighlight(
              formula: _dice(scaledSpellFormula(p.formula, p.scaling, context)),
              damageType: p.damageType,
              notes: p.notes)))));
    }
    final healing = _text(spell['healingDice']);
    final healingScaling =
        (spell['healingScaling'] as Map?)?.cast<String, dynamic>();
    if (spell['isHealing'] == true && healing != null) {
      final computedUpcast = healingScaling?['mode'] == 'slotLevel' &&
          spellProtocolIntMap<String>(healingScaling?['scalingBySlotLevel'])
              .containsKey(context.castLevel);
      var formula = _dice(scaledSpellFormula(healing, healingScaling, context));
      if (context.modifierContext case final modifierContext?) {
        final modifiers = evaluateFeatureModifiers(
          modifiers: context.featureModifiers
              .where((m) => m.target == FeatureModifierTarget.spellHealing),
          context: modifierContext,
          spellContext: FeatureModifierSpellContext(
            spellKey: spell['referenceKey'] as String?,
            castLevel: context.castLevel ?? spell['level'] as int? ?? 0,
          ),
        );
        final bonus = sumFeatureModifierValues(
                modifiers)[FeatureModifierTarget.spellHealing] ??
            0;
        if (bonus != 0) formula += bonus < 0 ? ' - ${-bonus}' : ' + $bonus';
      }
      if (spell['healingAddsCastingModifier'] == true) {
        formula += context.abilityModifier == null
            ? ' + модификатор'
            : context.abilityModifier! < 0
                ? ' - ${-context.abilityModifier!}'
                : ' + ${context.abilityModifier!}';
      }
      highlights.add(SpellHighlight(SpellHighlightKind.healing,
          upcast && !computedUpcast ? 'Лечение (база)' : 'Лечение', formula));
    }
    final attack = spell['attackType'] as String?;
    if ((attack != null && attack != 'none') ||
        (attack == null && spell['requiresAttackRoll'] == true)) {
      highlights.add(SpellHighlight(
          SpellHighlightKind.attack,
          'Атака',
          '${attack == 'meleeSpell' ? 'Ближняя' : attack == 'rangedSpell' ? 'Дальняя' : 'Заклинанием'}'
              '${context.attackBonus == null ? '' : ' ${_signed(context.attackBonus!)}'}'));
    }
    final save = normalizeSpellAbility(spell['savingThrowAbility'] as String?);
    if (save != null || spell['requiresSavingThrow'] == true) {
      highlights.add(SpellHighlight(
          SpellHighlightKind.save,
          'Спасбросок',
          '${_abilityLabels[save] ?? _text(spell['savingThrowAbility']) ?? 'Цели'}'
              '${context.saveDc == null ? '' : ' · СЛ ${context.saveDc}'}'));
    }
    for (final condition in spell['conditions'] as List? ?? []) {
      highlights.add(SpellHighlight(SpellHighlightKind.condition, 'Состояние',
          _conditions[condition] ?? '$condition'));
    }
    final target = spell['targetType'] as String?;
    if (target != null && target != 'none')
      highlights.add(SpellHighlight(
          SpellHighlightKind.target, 'Цель', _targets[target] ?? target));
    final area = spell['areaOfEffectType'] as String?;
    if (area != null && area != 'none') {
      final dimensions = _areaDimensions(spell);
      highlights.add(SpellHighlight(SpellHighlightKind.area, 'Область',
          '${_areas[area] ?? area}${dimensions.isEmpty ? '' : ' · $dimensions'}'));
    }
    // Stable generic ordering, with area before the less-specific target summary.
    highlights.sort((a, b) {
      final priority = _priority(a.kind).compareTo(_priority(b.kind));
      return priority != 0 ? priority : a.kind.index.compareTo(b.kind.index);
    });
    final notes = <String>{
      for (final p in parts)
        if (spellDescriptionText(p.scaling?['notes'] as String?) != null)
          spellDescriptionText(p.scaling?['notes'] as String?)!,
    };
    for (final note in notes) {
      highlights.add(
          SpellHighlight(SpellHighlightKind.scaling, 'Масштабирование', note));
    }
    final material =
        spellDescriptionText(spell['materialDescription'] as String?);
    return SpellPresentation(
        name: _text(spell['name']) ??
            _text(spell['referenceKey']) ??
            'Заклинание',
        level: spell['level'] as int? ?? 0,
        school:
            _schools[spell['schoolValue']] ?? spell['schoolValue'] as String?,
        metadata: [
          for (final field in ['castingTime', 'range', 'duration'])
            if (_text(spell[field]) != null) _text(spell[field])!,
          if (_text(spell['duration']) == null &&
              spell['durationType'] == 'instantaneous')
            'Мгновенно',
          if (spell['concentration'] == true) 'Концентрация',
          if (spell['ritual'] == true) 'Ритуал',
        ],
        components: [
          if (spell['requiresVerbal'] == true) 'V',
          if (spell['requiresSomatic'] == true) 'S',
          if (spell['requiresMaterial'] == true ||
              material != null ||
              spell['materialCost'] != null)
            'M'
        ],
        highlights: List.unmodifiable(highlights),
        description: spellDescriptionText(spell['description'] as String?),
        shortDescription:
            spellDescriptionText(spell['shortDescription'] as String?),
        higherLevel: spellDescriptionText(spell['higherLevel'] as String?),
        materialDescription: material,
        materialCost: spell['materialCost'] as int?,
        materialConsumed: spell['materialConsumed'] == true);
  }
}

String _areaDimensions(Map<String, dynamic> spell) {
  final size = spell['areaOfEffectSize'] as int?;
  final width = spell['areaOfEffectSecondarySize'] as int?;
  final height = spell['areaOfEffectHeight'] as int?;
  final primary = switch (spell['areaOfEffectSizeKind']) {
    'radius' => 'радиус',
    'diameter' => 'диаметр',
    'edge' => 'ребро',
    'length' => 'длина',
    'side' => 'сторона',
    _ => null,
  };
  if (primary == null) {
    final values = [size, width, height].whereType<int>().join(' × ');
    return values.isEmpty ? '' : '$values фт.';
  }
  return [
    if (size != null) '$primary $size фт.',
    if (width != null) 'ширина $width фт.',
    if (height != null) 'высота $height фт.',
  ].join(', ');
}

int _priority(SpellHighlightKind kind) => switch (kind) {
      SpellHighlightKind.damage || SpellHighlightKind.healing => 0,
      SpellHighlightKind.attack || SpellHighlightKind.save => 1,
      SpellHighlightKind.condition => 2,
      SpellHighlightKind.area => 3,
      SpellHighlightKind.target => 4,
      SpellHighlightKind.scaling => 5,
    };
String? _text(dynamic value) =>
    value is String && value.trim().isNotEmpty ? value.trim() : null;
String _dice(String value) =>
    value.replaceAllMapped(RegExp(r'(\d+)[dD](\d+)'), (m) => '${m[1]}к${m[2]}');
String _signed(int value) => value >= 0 ? '+$value' : '$value';
String? normalizeSpellAbility(String? value) {
  final key = value?.trim().toLowerCase();
  for (final entry in _abilityAliases.entries) {
    if (entry.value.contains(key)) return entry.key;
  }
  return null;
}

const _abilityAliases = {
  'strength': ['strength', 'str', 'сила'],
  'dexterity': ['dexterity', 'dex', 'ловкость'],
  'constitution': ['constitution', 'con', 'телосложение'],
  'intelligence': ['intelligence', 'int', 'интеллект'],
  'wisdom': ['wisdom', 'wis', 'мудрость'],
  'charisma': ['charisma', 'cha', 'харизма'],
};
const _abilityLabels = {
  'strength': 'STR',
  'dexterity': 'DEX',
  'constitution': 'CON',
  'intelligence': 'INT',
  'wisdom': 'WIS',
  'charisma': 'CHA'
};
const _schools = {
  'abjuration': 'Ограждение',
  'conjuration': 'Вызов',
  'divination': 'Прорицание',
  'enchantment': 'Очарование',
  'evocation': 'Воплощение',
  'illusion': 'Иллюзия',
  'necromancy': 'Некромантия',
  'transmutation': 'Преобразование'
};
const _damageTypes = {
  'acid': 'кислота',
  'bludgeoning': 'дробящий',
  'cold': 'холод',
  'fire': 'огонь',
  'force': 'силовое поле',
  'lightning': 'электричество',
  'necrotic': 'некротический',
  'piercing': 'колющий',
  'poison': 'яд',
  'psychic': 'психический',
  'radiant': 'излучение',
  'slashing': 'рубящий',
  'thunder': 'звук'
};
const _areas = {
  'sphere': 'Сфера',
  'cone': 'Конус',
  'line': 'Линия',
  'cube': 'Куб',
  'cylinder': 'Цилиндр',
  'square': 'Квадрат',
  'circle': 'Круг',
  'radius': 'Радиус'
};
const _targets = {
  'self': 'На себя',
  'creature': 'Существо',
  'creatures': 'Существа',
  'singleCreature': 'Одно существо',
  'multipleCreatures': 'Несколько существ',
  'touch': 'Касание',
  'special': 'Особая',
  'object': 'Предмет',
  'point': 'Точка',
  'area': 'Область',
  'humanoid': 'Гуманоид'
};
const _conditions = {
  'paralyzed': 'Парализованный',
  'charmed': 'Очарованный',
  'frightened': 'Испуганный',
  'blinded': 'Ослеплённый',
  'deafened': 'Оглохший',
  'poisoned': 'Отравленный',
  'stunned': 'Ошеломлённый',
  'restrained': 'Опутанный',
  'prone': 'Сбитый с ног',
  'invisible': 'Невидимый',
  'incapacitated': 'Недееспособный',
  'unconscious': 'Бессознательный',
  'exhaustion': 'Истощение',
  'grappled': 'Схваченный',
  'petrified': 'Окаменевший'
};
