import '../characters_mirror_shared/lib/characters_mirror_shared.dart';

Map<String, String?> spellFeatureContractValues(
  Map<String, dynamic> character,
) {
  final values = <String, String?>{};
  for (final (key, level, healing, castLevel) in [
    ('cure_wounds', 1, true, null),
    ('cure_wounds', 1, true, 3),
    ('healing_word', 1, true, null),
    ('healing_cantrip', 0, true, null),
    ('non_healing', 1, false, null),
  ]) {
    final spell = <String, dynamic>{
      'referenceKey': key,
      'level': level,
      'isHealing': healing,
      'healingDice': key == 'healing_word' ? '1d4' : '1d8',
      'healingAddsCastingModifier': true,
      'healingScaling': {
        'mode': 'slotLevel',
        'scalingBySlotLevel': {'3': '3d8'},
      },
    };
    final context = spellPresentationContextForCharacter(
      character,
      'wisdom',
      castLevel: castLevel,
    );
    values['$key:${castLevel ?? level}'] = const SpellPresentationResolver()
        .resolve(spell, context: context)
        .highlights
        .where((h) => h.kind == SpellHighlightKind.healing)
        .firstOrNull
        ?.value;
  }
  return values;
}

const lifeSpellFeatureExpected = {
  'cure_wounds:1': '1к8 + 3 + 4',
  'cure_wounds:3': '3к8 + 5 + 4',
  'healing_word:1': '1к4 + 3 + 4',
  'healing_cantrip:0': '1к8 + 4',
  'non_healing:1': null,
};
