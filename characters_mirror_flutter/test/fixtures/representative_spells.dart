import 'package:characters_mirror_client/characters_mirror_client.dart';

List<SpellData> representativeSpells() {
  final cases = <SpellData>[
    SpellData(
        name: 'Урон, спасбросок и сфера',
        level: 3,
        damageDice: '8d6',
        damageType: DamageType.fire,
        savingThrowAbility: 'dexterity',
        areaOfEffectType: AreaOfEffectType.sphere,
        areaOfEffectSize: 20),
    SpellData(
        name: 'Атака заклинанием',
        attackType: SpellAttackType.rangedSpell,
        damageDice: '1d10'),
    SpellData(
        name: 'Лечение',
        level: 1,
        isHealing: true,
        healingDice: '1d8',
        targetType: SpellTargetType.touch),
    SpellData(
        name: 'Контроль',
        level: 2,
        savingThrowAbility: 'wisdom',
        conditions: [ConditionType.paralyzed]),
    SpellData(
        name: 'Концентрация',
        level: 1,
        concentration: true,
        duration: 'До 1 минуты'),
    SpellData(name: 'Ритуал', ritual: true, level: 1, duration: '10 минут'),
    SpellData(name: 'Утилитарное заклинание', level: 1),
    SpellData(
        name: 'Материальный компонент',
        materialDescription: r'Нить\nи кусочек ткани',
        requiresMaterial: true),
    SpellData(
        name: 'Расходуемые материалы',
        level: 1,
        materialCost: 10000,
        materialConsumed: true,
        materialDescription: 'Драгоценный камень'),
    SpellData(name: 'Несколько компонентов урона', level: 2, damageParts: [
      DamagePartData(formula: '1d6', damageType: DamageType.fire),
      DamagePartData(
          formula: '1d4',
          damageType: DamageType.cold,
          notes: 'При выполнении условия'),
    ]),
    SpellData(
        name: 'Заговор с ростом от уровня',
        damageDice: '1d10',
        damageScaling: SpellScalingData(
            mode: SpellScalingMode.casterLevel,
            scalingByCasterLevel: {5: '2d10', 11: '3d10'})),
    SpellData(
        name: 'Усиление ячейкой',
        level: 1,
        damageDice: '1d6',
        damageScaling: SpellScalingData(
            mode: SpellScalingMode.slotLevel, scalingBySlotLevel: {3: '3d6'})),
    SpellData(name: 'Спасбросок без урона', savingThrowAbility: 'constitution'),
    SpellData(
        name: 'Структурированная длительность',
        durationType: SpellDurationType.instantaneous),
    SpellData(
        name: 'Линия с размерами',
        areaOfEffectType: AreaOfEffectType.line,
        areaOfEffectSize: 60,
        areaOfEffectSecondarySize: 5,
        areaOfEffectHeight: 10),
    SpellData(
        name: 'Canonical attackType none',
        attackType: SpellAttackType.none,
        requiresAttackRoll: true),
    SpellData(
        name: 'Curated краткий текст',
        shortDescription: 'Кратко.',
        higherLevel: r'Первый уровень.\nВторой уровень.'),
    SpellData(
        name: 'Длинное описание',
        description:
            '${'Длинный русский текст правил заклинания. ' * 40}\\n\\nПоследний абзац.'),
  ];
  return [
    for (var i = 0; i < cases.length; i++)
      cases[i].copyWith(
          referenceKey: 'fixture_$i',
          description: cases[i].description ??
              r'Первый абзац правил.\n\nВторой абзац правил.',
          castingTime: '1 действие',
          range: 'Существо в пределах дистанции заклинания',
          requiresVerbal: true,
          requiresSomatic: true)
  ];
}
