import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/inventory/inventory_selection_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('recognized weapon offers attack editor and description',
      (tester) async {
    WeaponData? selectedWeapon;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: InventorySelectionActions(
          selectedText: 'Longsword',
          character: CharacterData(),
          weapons: [
            WeaponData(referenceKey: 'longsword', name: 'Longsword'),
          ],
          onAddWeapon: (weapon) async => selectedWeapon = weapon,
          onCreateManualAttack: (_) async {},
          onEquipArmor: (_) async {},
          onEquipShield: (_) async {},
          onUnequipArmor: () async {},
          onUnequipShield: () async {},
        ),
      ),
    ));

    expect(find.text('Добавить в атаки'), findsOneWidget);
    expect(find.text('Описание'), findsOneWidget);
    await tester.tap(find.text('Добавить в атаки'));
    expect(selectedWeapon?.referenceKey, 'longsword');
  });

  testWidgets('armor slot is selected from typed category', (tester) async {
    CharacterEquipmentSelectionData? armorSelection;
    CharacterEquipmentSelectionData? shieldSelection;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: InventorySelectionActions(
          selectedText: 'Shield',
          character: CharacterData(),
          armors: [
            ArmorData(
              referenceKey: 'shield',
              name: 'Shield',
              categoryValue: ArmorCategory.shield,
            ),
          ],
          onAddWeapon: (_) async {},
          onCreateManualAttack: (_) async {},
          onEquipArmor: (value) async => armorSelection = value,
          onEquipShield: (value) async => shieldSelection = value,
          onUnequipArmor: () async {},
          onUnequipShield: () async {},
        ),
      ),
    ));

    expect(find.text('Экипировать щит'), findsOneWidget);
    expect(find.text('Экипировать доспех'), findsNothing);
    await tester.tap(find.text('Экипировать щит'));
    expect(armorSelection, isNull);
    expect(shieldSelection?.referenceKey, 'shield');
  });

  testWidgets('armor with unknown category only offers details',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: InventorySelectionActions(
          selectedText: 'Uncategorized armor',
          character: CharacterData(),
          armors: [
            ArmorData(
              referenceKey: 'uncategorized_armor',
              name: 'Uncategorized armor',
            ),
          ],
          onAddWeapon: (_) async {},
          onCreateManualAttack: (_) async {},
          onEquipArmor: (_) async {},
          onEquipShield: (_) async {},
          onUnequipArmor: () async {},
          onUnequipShield: () async {},
        ),
      ),
    ));

    expect(find.text('Описание'), findsOneWidget);
    expect(find.text('Экипировать доспех'), findsNothing);
    expect(find.text('Экипировать щит'), findsNothing);
  });

  testWidgets(
      'tool only exposes details and unknown text exposes manual actions',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            InventorySelectionActions(
              selectedText: 'Thieves tools',
              character: CharacterData(),
              tools: [
                ToolData(referenceKey: 'thieves_tools', name: 'Thieves tools'),
              ],
              onAddWeapon: (_) async {},
              onCreateManualAttack: (_) async {},
              onEquipArmor: (_) async {},
              onEquipShield: (_) async {},
              onUnequipArmor: () async {},
              onUnequipShield: () async {},
            ),
            InventorySelectionActions(
              selectedText: 'Family ring',
              character: CharacterData(),
              onAddWeapon: (_) async {},
              onCreateManualAttack: (_) async {},
              onEquipArmor: (_) async {},
              onEquipShield: (_) async {},
              onUnequipArmor: () async {},
              onUnequipShield: () async {},
            ),
          ],
        ),
      ),
    ));

    expect(find.text('Описание'), findsOneWidget);
    expect(find.text('Добавить в атаки'), findsOneWidget);
    expect(find.text('Экипировать как доспех'), findsOneWidget);
    expect(find.text('Экипировать как щит'), findsOneWidget);
  });

  testWidgets('multi-line selection has no mechanical actions', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: InventorySelectionActions(
          selectedText: 'Chain mail\nShield',
          character: CharacterData(),
          onAddWeapon: (_) async {},
          onCreateManualAttack: (_) async {},
          onEquipArmor: (_) async {},
          onEquipShield: (_) async {},
          onUnequipArmor: () async {},
          onUnequipShield: () async {},
        ),
      ),
    ));

    expect(find.byType(OutlinedButton), findsNothing);
  });
}
