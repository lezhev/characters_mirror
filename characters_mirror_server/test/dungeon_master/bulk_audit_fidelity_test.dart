import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_server/src/dungeon_master/foundry_creature_importer.dart';
import 'package:characters_mirror_shared/dungeon_master.dart';
import 'package:test/test.dart';
import '../../tool/dm_bulk_audit/fidelity_checks.dart';

void main() {
  final source =
      jsonDecode(File('test/fixtures/foundry/Goblin.json').readAsStringSync())
          as Map<String, dynamic>;
  final parsed = FoundryCreatureImporter().parse(jsonEncode(source));
  Map<String, dynamic> normalized() =>
      jsonDecode(parsed.normalizedJson) as Map<String, dynamic>;
  test('audit detects an incorrect equipment-derived armor class', () {
    final json = normalized();
    json['combat']['armorClass'] = 16;
    expect(
        checkFidelity(source, NormalizedCreature.fromJson(json))
            .map((i) => i.field),
        contains('combat.armorClass.equipment'));
  });
  test('audit accepts a complete production document after serialization', () {
    expect(
        checkFidelity(source, NormalizedCreature.decode(parsed.normalizedJson)),
        isEmpty);
  });
  test('audit detects a missing item independently of importer diagnostics',
      () {
    final json = normalized();
    (json['items'] as List).removeLast();
    expect(
        checkFidelity(source, NormalizedCreature.fromJson(json))
            .map((i) => i.category),
        contains('item_loss'));
  });
  test('audit detects empty descriptions and corrupted structured resources',
      () {
    final json = normalized();
    json['items'][0]['description'] = '';
    json['resources']['legact']['max'] = 99;
    final issues = checkFidelity(source, NormalizedCreature.fromJson(json));
    expect(issues.map((i) => i.category), contains('html_conversion'));
    expect(issues.map((i) => i.field), contains('resources'));
  });
}
