import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_proficiencies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('editor displays category and specific weapon as separate grants',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: CharacterProficienciesEditor(
              character: CharacterData(
                derived: CharacterDerivedData(
                  weaponTraining: const [WeaponCategory.simpleMelee],
                  weaponProficiencyKeys: const ['longsword'],
                ),
              ),
              tools: const [],
              weapons: [
                WeaponData(referenceKey: 'longsword', name: 'Длинный меч')
              ],
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    expect(find.text('Простое рукопашное оружие'), findsOneWidget);
    expect(find.text('Длинный меч'), findsOneWidget);
    expect(find.text('longsword'), findsNothing);
    expect(find.text('Добавить категорию оружия'), findsOneWidget);
    expect(find.text('Добавить конкретное оружие'), findsOneWidget);
  });

  testWidgets('removing a canonical language produces a removal override',
      (tester) async {
    CharacterData? saved;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: CharacterProficienciesEditor(
              character: CharacterData(
                derived:
                    CharacterDerivedData(languages: const [Language.common]),
              ),
              tools: const [],
              weapons: const [],
              onChanged: (value) => saved = value,
            ),
          ),
        ),
      ),
    );

    tester.widget<InputChip>(find.byType(InputChip).first).onDeleted!();
    await tester.pump();

    expect(saved?.manualLanguageOverrides?.removed, [Language.common]);
  });
}
