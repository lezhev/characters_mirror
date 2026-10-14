import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_server/src/dungeon_master/foundry_creature_importer.dart';
import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:test/test.dart';

Map<String, dynamic> actor() =>
    jsonDecode(File('test/fixtures/foundry/Goblin.json').readAsStringSync())
        as Map<String, dynamic>;

void main() {
  final importer = FoundryCreatureImporter();
  test(
      'official 2.1.0 legacy Actor schema preserves all goblin statistics and items',
      () {
    final source = actor();
    source['_stats']['systemVersion'] = '2.1.0';
    final result = importer.parse(jsonEncode(source));
    final json = jsonDecode(result.normalizedJson);
    expect(result.sourceVersion, '2.1.0');
    expect(json['combat']['armorClass'], 15);
    expect(json['combat']['hpMax'], 7);
    expect(json['combat']['initiativeBonus'], 2);
    expect(json['items'], hasLength(source['items'].length));
    expect(json['items'][0]['sourceSystem'], source['items'][0]['system']);
    expect(json['resources'], source['system']['resources']);
    expect(json['diagnostics'], isEmpty);
  });
  test(
      'compatible dnd5e 3.2.1 legacy items retain attack settings and damage modifiers',
      () {
    final source = actor();
    source['_stats']['systemVersion'] = '3.2.1';
    source['_stats']['coreVersion'] = '12.328';
    source['items'][0]['system'].remove('attackBonus');
    source['items'][0]['system']['attack'] = {'bonus': '2', 'flat': true};
    source['system']['traits']['dm'] = {
      'amount': {'fire': '-3'},
      'bypasses': ['mgc']
    };
    final result = importer.parse(jsonEncode(source));
    final json = jsonDecode(result.normalizedJson);
    expect(result.sourceVersion, '3.2.1');
    expect(json['combat']['armorClass'], 15);
    expect(json['items'][0]['attackBonus'], '2');
    expect(json['items'][0]['attackSettings'], {'bonus': '2', 'flat': true});
    expect(
        json['defenses']['damageModifiers'], source['system']['traits']['dm']);
    expect(json['diagnostics'], contains(contains('3.2.1')));
  });

  test('new activity schema cannot masquerade as compatible legacy 3.2.1', () {
    final source = actor();
    source['_stats']['systemVersion'] = '3.2.1';
    source['items'][0]['system']['activities'] = {
      'attack': {'type': 'attack'}
    };
    expect(
        () => importer.parse(jsonEncode(source)),
        throwsA(isA<DmCreatureException>()
            .having((e) => e.code, 'code', 'unsupported_format')
            .having((e) => e.message, 'message', contains('activities'))));
  });

  test(
      '5etools statblock is identified explicitly, without invented conversion',
      () {
    final raw = jsonEncode({
      'name': 'Fixture',
      'type': 'humanoid',
      'source': 'MM',
      'ac': [12],
      'hp': {'average': 10, 'formula': '2d8'},
      'str': 10,
      'cr': '1'
    });
    expect(
        () => importer.parse(raw),
        throwsA(isA<DmCreatureException>()
            .having((e) => e.code, 'code', 'unsupported_format')
            .having((e) => e.message, 'message', contains('5etools'))));
  });
}
