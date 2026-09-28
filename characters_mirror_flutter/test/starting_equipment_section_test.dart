import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/starting_equipment_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('selectable weapon cancel, choose, clear, choose and reload',
      (tester) async {
    final line = StartingEquipmentLineData(
      entryId: 3,
      kind: StartingEquipmentLineKind.weaponCategory,
      allowedWeaponCategories: [WeaponCategory.simpleMelee],
    );
    final option = StartingEquipmentOptionView(
      option: StartingEquipmentOptionData(entryId: 2),
      lines: [line],
    );
    final block = StartingEquipmentBlockView(
      block: StartingEquipmentBlockData(
        entryId: 1,
        kind: StartingEquipmentBlockKind.choice,
        selectionCount: 1,
      ),
      options: [option],
    );
    List<CharacterStartingEquipmentSelectionData> selections = [];
    late StateSetter rebuild;
    Widget build() => ProviderScope(
          overrides: [
            weaponCatalogProvider.overrideWith((ref) async => [
                  WeaponData(
                    referenceKey: 'club',
                    name: 'Дубинка',
                    category: WeaponCategory.simpleMelee,
                  ),
                ]),
            armorCatalogProvider.overrideWith((ref) async => []),
            itemCatalogProvider.overrideWith((ref) async => []),
            toolCatalogProvider.overrideWith((ref) async => []),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(builder: (context, setState) {
                rebuild = setState;
                return StartingEquipmentSection(
                  blocks: [block],
                  selections: selections,
                  onSelectOption: (_, selectedOption) => setState(() {
                    selections = [
                      CharacterStartingEquipmentSelectionData(
                        sourceType: ChoiceSourceType.classData,
                        sourceId: 1,
                        sourceEntryId: 1,
                        choiceOptionEntryId: selectedOption.option!.entryId,
                        isSelected: true,
                      ),
                    ];
                  }),
                  onSelectFixedBlock: (_) {},
                  onClearBlock: (_) => setState(() => selections = []),
                  onSetResolution: ({
                    required blockView,
                    required line,
                    required catalogType,
                    required referenceKey,
                  }) =>
                      setState(() {
                    selections = [
                      selections.single.copyWith(resolutions: [
                        CharacterStartingEquipmentResolutionData(
                          sourceLineEntryId: line.entryId,
                          catalogType: catalogType,
                          referenceKey: referenceKey,
                        ),
                      ]),
                    ];
                  }),
                );
              }),
            ),
          ),
        );

    await tester.pumpWidget(build());
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Любое простое рукопашное оружие'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Отмена'));
    await tester.pumpAndSettle();
    expect(selections, isEmpty);

    await tester.tap(find.textContaining('Любое простое рукопашное оружие'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Дубинка'));
    await tester.pumpAndSettle();
    expect(selections.single.resolutions!.single.referenceKey, 'club');
    expect(find.text('Дубинка'), findsOneWidget);

    await tester.tap(find.text('Дубинка'));
    await tester.pumpAndSettle();
    expect(selections, isEmpty);

    await tester.tap(find.textContaining('Любое простое рукопашное оружие'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Дубинка'));
    await tester.pumpAndSettle();
    selections = selections
        .map((value) => CharacterStartingEquipmentSelectionData.fromJson(
              value.toJson(),
            ))
        .toList();
    rebuild(() {});
    await tester.pumpAndSettle();
    expect(find.text('Дубинка'), findsOneWidget);
    expect(selections.single.resolutions!.single.referenceKey, 'club');
  });
}
