import 'package:characters_mirror_flutter/features/level_up/presentation/level_up_hp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'manual HP uses a centered compact input to the right of the result',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    int? roll = 5;
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: StatefulBuilder(
                builder: (_, setState) => LevelUpHp(
                    die: 8,
                    roll: roll,
                    constitution: 2,
                    oldMax: 9,
                    newMax: 9 + (roll ?? 0) + 2,
                    onRoll: (value) => setState(() => roll = value))))));
    await tester.tap(find.text('Ввести вручную'));
    await tester.pump();
    final field = find.byKey(const ValueKey('level-up-hp-roll'));
    final result = find.byKey(const ValueKey('level-up-hp-result'));
    expect(tester.getTopLeft(field).dx,
        greaterThan(tester.getBottomRight(result).dx));
    expect(find.descendant(of: result, matching: field), findsNothing);
    expect(
        tester.getCenter(field).dy,
        inInclusiveRange(
            tester.getTopLeft(result).dy, tester.getBottomRight(result).dy));
    final input = tester.widget<TextField>(
        find.descendant(of: field, matching: find.byType(TextField)));
    expect(input.textAlign, TextAlign.center);
    expect(input.decoration!.border, InputBorder.none);
    final fieldSize = tester.getSize(field);
    expect(fieldSize.width, fieldSize.height);
    expect(tester.getSize(result).height, fieldSize.height);
    await tester.enterText(field, '8');
    await tester.pump();
    expect(roll, 8);
    expect(find.text('8 от кости + 2 Телосложение = +10'), findsOneWidget);
    await tester.enterText(field, '9');
    await tester.pump();
    expect(roll, isNull);
    expect(tester.takeException(), isNull);
    for (final mode in ['Среднее', 'Бросить к8']) {
      await tester.tap(find.text(mode));
      await tester.pump();
      expect(tester.getSize(result).height, fieldSize.height);
    }
    await tester.tap(result);
    await tester.pump();
    expect(tester.getSize(result).height, fieldSize.height);
  });
  testWidgets(
      'virtual HP rolls from the result panel and rerolls from its asset icon',
      (tester) async {
    int? roll = 5;
    var rolls = 0;
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: StatefulBuilder(
      builder: (_, setState) => LevelUpHp(
          die: 8,
          roll: roll,
          constitution: 2,
          oldMax: 9,
          newMax: 9 + (roll ?? 0) + 2,
          onRoll: (value) => setState(() {
                roll = value;
                rolls++;
              })),
    ))));
    await tester.tap(find.text('Бросить к8'));
    await tester.pump();
    expect(roll, isNull);
    expect(find.widgetWithText(TextButton, 'Бросить к8'), findsNothing);
    final result = find.byKey(const ValueKey('level-up-hp-result'));
    expect(find.descendant(of: result, matching: find.text('Бросить к8')),
        findsOneWidget);
    await tester.tap(result);
    await tester.pump();
    expect(roll, inInclusiveRange(1, 8));
    expect(find.text('$roll от кости + 2 Телосложение = +${roll! + 2}'),
        findsOneWidget);
    final dice = find.byType(SvgPicture);
    expect(
        (tester.widget<SvgPicture>(dice).bytesLoader as SvgAssetLoader)
            .assetName,
        'assets/svg/dice.svg');
    final beforeReroll = rolls;
    await tester.tap(dice);
    await tester.pump();
    expect(rolls, beforeReroll + 1);
    expect(roll, inInclusiveRange(1, 8));
    await tester.tap(find.text('Среднее'));
    await tester.pump();
    expect(roll, 5);
    expect(find.byType(SvgPicture), findsNothing);
  });
}
