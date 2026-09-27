import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/combat_stat_settings_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('armor class settings shows and can remove equipped armor',
      (tester) async {
    var removedArmor = false;
    var removedShield = false;
    final savedArmor = CharacterEquipmentSelectionData(name: 'Кожаный доспех');
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () => showArmorClassSettingsSheet(
              context: context,
              character: CharacterData(
                equippedArmor: savedArmor,
                equippedShield: CharacterEquipmentSelectionData(name: 'Щит'),
              ),
              onSave: (_) async {},
              onUnequipArmor: () async => removedArmor = true,
              onUnequipShield: () async => removedShield = true,
            ),
            child: const Text('open'),
          ),
        ),
      ),
    ));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.text('Экипировано'), findsOneWidget);
    expect(find.text('Кожаный доспех'), findsOneWidget);
    expect(find.text('Щит'), findsNWidgets(2));
    expect(find.byTooltip('Снять доспех'), findsOneWidget);
    expect(find.byTooltip('Снять щит'), findsOneWidget);
    await tester.tap(find.byTooltip('Снять доспех'));
    await tester.pump();
    await tester.tap(find.byTooltip('Снять щит'));
    await tester.pump();
    expect(removedArmor, isTrue);
    expect(removedShield, isTrue);
    expect(find.widgetWithText(ListTile, 'Кожаный доспех'), findsNothing);
    expect(find.widgetWithText(ListTile, 'Щит'), findsNothing);
  });
}
