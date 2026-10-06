import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/level_up/presentation/level_experience_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'XP entry offers text-only level-down below level-up and permits both actions',
      (tester) async {
    var started = false;
    var lowered = false;
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: LevelExperienceSheet(
                character: CharacterData(
                    experience: 3000,
                    derived: CharacterDerivedData(totalLevel: 4),
                    classEntries: [
                      CharacterClassEntryData(id: 'entry', level: 4),
                    ]),
                onLevelDown: () => lowered = true,
                onLevelUp: () => started = true))));
    expect(find.text('4 уровень'), findsOneWidget);
    expect(find.text('3000 / 6500 опыта'), findsOneWidget);
    expect(find.text('До следующего уровня: 3500 опыта'), findsOneWidget);
    expect(find.text('Понизить уровень'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Понизить уровень')).dy,
      greaterThan(tester.getTopLeft(find.text('Повысить уровень')).dy),
    );
    final levelDownFinder = find.widgetWithText(TextButton, 'Понизить уровень');
    final levelDown = tester.widget<TextButton>(levelDownFinder);
    final style = levelDown.style!;
    final errorColor =
        Theme.of(tester.element(levelDownFinder)).colorScheme.error;
    for (final states in <Set<WidgetState>>[
      {},
      {WidgetState.hovered},
      {WidgetState.focused},
      {WidgetState.pressed},
    ]) {
      expect(style.foregroundColor!.resolve(states), errorColor);
      expect(style.backgroundColor!.resolve(states), Colors.transparent);
      expect(style.overlayColor!.resolve(states), Colors.transparent);
      expect(style.side!.resolve(states), BorderSide.none);
      expect(style.elevation!.resolve(states), 0);
    }
    expect(style.splashFactory, NoSplash.splashFactory);
    await tester.tap(find.text('Понизить уровень'));
    expect(lowered, true);
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
    expect(
      tester
          .widget<FilledButton>(
              find.widgetWithText(FilledButton, 'Повысить уровень'))
          .onPressed,
      isNull,
    );
    expect(
      tester
          .widget<TextButton>(
              find.widgetWithText(TextButton, 'Понизить уровень'))
          .onPressed,
      isNull,
    );
    expect(tester.takeException(), isNull);
  });
}
