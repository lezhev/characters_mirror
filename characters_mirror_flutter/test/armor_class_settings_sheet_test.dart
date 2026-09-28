import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/combat_stat_settings_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final (source, formula) in [
    ('Защита без доспехов', '10 + Ловкость (3) + Мудрость (5)'),
    ('Кожаный доспех', '11 + Ловкость (3)'),
  ]) {
    testWidgets('AC details show derived source and formula: $source',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ArmorClassSettingsSheet(
            character: CharacterData(
              derived: CharacterDerivedData(
                armorClass: 18,
                armorClassSource: source,
                armorClassFormula: formula,
              ),
            ),
            onSave: (_) async {},
          ),
        ),
      ));

      expect(find.text('Источник: $source'), findsOneWidget);
      expect(find.text('Расчёт: $formula'), findsOneWidget);
    });
  }
}
