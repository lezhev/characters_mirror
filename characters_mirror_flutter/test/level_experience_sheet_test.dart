import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/level_up/presentation/level_experience_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'XP entry uses actual character level and permits milestone advancement',
      (tester) async {
    var started = false;
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: LevelExperienceSheet(
                character: CharacterData(
                    experience: 3000,
                    derived: CharacterDerivedData(totalLevel: 4)),
                onLevelUp: () => started = true))));
    expect(find.text('4 уровень'), findsOneWidget);
    expect(find.text('3000 / 6500 опыта'), findsOneWidget);
    expect(find.text('До следующего уровня: 3500 опыта'), findsOneWidget);
    await tester.tap(find.text('Повысить уровень'));
    expect(started, true);
    expect(find.text('Добавить уровень другого класса'), findsNothing);
  });
  testWidgets('maximum level has no overflowing next XP threshold',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: LevelExperienceSheet(
                character: CharacterData(
                    experience: 400000,
                    derived: CharacterDerivedData(totalLevel: 20)),
                onLevelUp: () {}))));
    expect(find.text('Максимальный уровень'), findsOneWidget);
    expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull);
    expect(tester.takeException(), isNull);
  });
}
