import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_proficiency_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('summary uses display labels instead of canonical keys', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CharacterProficiencySummary(
            character: CharacterData(
              derived: CharacterDerivedData(
                languages: const [Language.dwarvish],
                weaponProficiencyKeys: const ['battleaxe'],
                customLanguages: const ['River speech'],
              ),
              manualLanguageOverrides: CharacterLanguageOverridesData(
                custom: const ['River speech'],
              ),
            ),
            toolNames: const {},
            weaponNames: const {'battleaxe': 'Battleaxe'},
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Языки'), findsOneWidget);
    expect(find.textContaining('Дварфийский'), findsOneWidget);
    expect(find.textContaining('River speech'), findsOneWidget);
    expect(find.text('battleaxe'), findsNothing);
    expect(find.textContaining('Battleaxe'), findsOneWidget);
    expect(find.text('Инструменты'), findsNothing);
  });

  testWidgets('empty summary does not show empty categories', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CharacterProficiencySummary(
            character: CharacterData(),
            toolNames: const {},
            weaponNames: const {},
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Пока ничего не добавлено.'), findsOneWidget);
    expect(find.text('Языки'), findsNothing);
    expect(find.text('Инструменты'), findsNothing);
  });
}
