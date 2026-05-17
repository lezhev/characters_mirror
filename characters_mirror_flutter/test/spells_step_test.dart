import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/spells_step/spells_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('spell selector shows details dialog from info button',
      (tester) async {
    final group = ClassSpellSelectionGroupView(
      kind: CharacterSpellSelectionKind.preparedSpell,
      selectionCount: 2,
      classDataId: 1,
      classLevel: 1,
      options: [
        SpellData(
          referenceKey: 'bless',
          name: 'Bless',
          description: 'Вы благословляете до трёх существ на дистанции.',
          higherLevel: 'Когда вы накладываете это заклинание ячейкой 2 круга.',
          level: 1,
          schoolValue: SpellSchool.enchantment,
          castingTime: '1 действие',
          range: '30 футов',
          duration: 'Концентрация, до 1 минуты',
          concentration: true,
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ClassSpellSelectionSection(
            groups: [group],
            selections: const [],
            onToggleSpell: (_, __) {},
            onClearGroup: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('Подготовленные заклинания'), findsOneWidget);
    expect(find.text('Выбрано 0 из 2'), findsOneWidget);
    expect(find.text('Bless'), findsOneWidget);
    expect(find.text('Очарование'), findsNothing);

    await tester.tap(find.byTooltip('Информация'));
    await tester.pumpAndSettle();

    expect(find.text('Bless'), findsWidgets);
    expect(find.text('1 уровень'), findsOneWidget);
    expect(find.text('Очарование'), findsOneWidget);
    expect(find.text('1 действие'), findsOneWidget);
    expect(find.text('Концентрация'), findsOneWidget);
    expect(
      find.text('Вы благословляете до трёх существ на дистанции.'),
      findsOneWidget,
    );
    expect(find.text('На высоких уровнях'), findsOneWidget);
  });
}
