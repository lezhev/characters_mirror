// Shared input snapshots and PHB 2014 expectations for server/offline tests.
class ArmorClassCase {
  const ArmorClassCase(
    this.name,
    this.expected, {
    this.dexterity = 14,
    this.constitution = 16,
    this.wisdom = 14,
    this.defenses = const ['constitution'],
    this.armor,
    this.shield = false,
    this.customBonus = 0,
    this.featureBonus = 0,
    this.level = 1,
  });
  final String name;
  final int expected;
  final int dexterity;
  final int constitution;
  final int wisdom;
  final List<String> defenses;
  final String? armor;
  final bool shield;
  final int customBonus;
  final int featureBonus;
  final int level;
  Map<String, int> get scores => {
    'dexterity': dexterity,
    'constitution': constitution,
    'wisdom': wisdom,
  };
}

const armorClassCases = [
  ArmorClassCase('barbarian without equipment', 15),
  ArmorClassCase('barbarian shield allowed', 17, shield: true),
  ArmorClassCase('barbarian armor disables formula', 13, armor: 'leather'),
  ArmorClassCase('barbarian armor removed', 15),
  ArmorClassCase(
    'monk without equipment',
    15,
    dexterity: 16,
    defenses: ['wisdom'],
  ),
  ArmorClassCase(
    'monk armor disables formula',
    14,
    dexterity: 16,
    defenses: ['wisdom'],
    armor: 'leather',
  ),
  ArmorClassCase(
    'monk shield disables formula',
    15,
    dexterity: 16,
    wisdom: 20,
    defenses: ['wisdom'],
    shield: true,
  ),
  ArmorClassCase(
    'monk shield removed',
    18,
    dexterity: 16,
    wisdom: 20,
    defenses: ['wisdom'],
  ),
  ArmorClassCase(
    'multiclass takes best formula',
    17,
    wisdom: 20,
    defenses: ['constitution', 'wisdom'],
  ),
  ArmorClassCase(
    'multiclass shield disables only wisdom formula',
    17,
    wisdom: 20,
    defenses: ['constitution', 'wisdom'],
    shield: true,
  ),
  ArmorClassCase(
    'equipped heavy armor wins',
    18,
    defenses: ['constitution', 'wisdom'],
    armor: 'plate',
  ),
  ArmorClassCase('custom bonus unarmored', 19, customBonus: 4),
  ArmorClassCase('custom bonus armored', 22, armor: 'plate', customBonus: 4),
  ArmorClassCase(
    'feature bonus after formula and custom bonus',
    19,
    customBonus: 3,
    featureBonus: 1,
  ),
  ArmorClassCase(
    'feature bonus after armor and shield',
    21,
    armor: 'plate',
    shield: true,
    featureBonus: 1,
  ),
  ArmorClassCase('negative dexterity', 11, dexterity: 8, constitution: 14),
  ArmorClassCase(
    'negative secondary ability keeps normal formula',
    12,
    constitution: 8,
  ),
  ArmorClassCase('proficiency does not affect formula', 15, level: 9),
  ArmorClassCase('no active feature keeps normal formula', 12, defenses: []),
];
