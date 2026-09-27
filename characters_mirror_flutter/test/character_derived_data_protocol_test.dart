import 'dart:convert';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('derived ability and skill maps round-trip with typed enum keys', () {
    final derived = CharacterDerivedData(
      abilityScores: const {Ability.strength: 18},
      abilityModifiers: const {Ability.strength: 4},
      savingThrowBonuses: const {Ability.dexterity: 5},
      skillBonuses: const {Skill.athletics: 8},
    );

    final protocolJson = jsonDecode(jsonEncode(derived.toJson()))
        as Map<String, dynamic>;
    final decoded = CharacterDerivedData.fromJson(protocolJson);

    expect(decoded.abilityScores, const {Ability.strength: 18});
    expect(decoded.abilityModifiers, const {Ability.strength: 4});
    expect(decoded.savingThrowBonuses, const {Ability.dexterity: 5});
    expect(decoded.skillBonuses, const {Skill.athletics: 8});
  });

  test('removed derived aggregates are ignored by the protocol model', () {
    final decoded = CharacterDerivedData.fromJson({
      'featureTags': ['combat'],
      'featIds': [12],
      'senses': ['darkvision 60'],
      'rebuiltAt': '2026-01-01T00:00:00.000Z',
    });

    expect(decoded.toJson().keys, isNot(contains('featureTags')));
    expect(decoded.toJson().keys, isNot(contains('featIds')));
    expect(decoded.toJson().keys, isNot(contains('senses')));
    expect(decoded.toJson().keys, isNot(contains('rebuiltAt')));
  });
}
