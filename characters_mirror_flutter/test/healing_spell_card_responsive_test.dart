import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/spell_card.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fixtures/representative_spells.dart';

void main() {
  for (final castLevel in [1, 3]) {
    for (final scale in [1.0, 1.3]) {
      testWidgets(
          'healing card and details fit 320px at level $castLevel, text scale $scale',
          (tester) async {
        tester.view.physicalSize = const Size(320, 900);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final spell =
            representativeSpells().firstWhere((s) => s.isHealing == true);
        final context =
            SpellPresentationContext(casterLevel: 7, castLevel: castLevel);
        final presentation = const SpellPresentationResolver()
            .resolve(spell.toJson(), context: context);
        final healing = presentation.collapsedHighlights
            .firstWhere((h) => h.kind == SpellHighlightKind.healing);

        await tester.pumpWidget(MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(scale)),
            child: child!,
          ),
          home: Scaffold(
            body: ListView(padding: const EdgeInsets.all(12), children: [
              SpellCard(
                spell: spell,
                presentationContext: context,
                trailing: const Icon(Icons.auto_awesome),
              ),
            ]),
          ),
        ));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        final healingText = healing.label == 'Лечение'
            ? healing.value
            : '${healing.label}: ${healing.value}';
        final icon = find.byKey(const ValueKey('spell-healing-icon'));
        final value = find.byWidgetPredicate((widget) =>
            widget is Text &&
            (widget.data == healing.value || widget.data == healingText));
        expect(icon, findsOneWidget);
        expect(value, findsOneWidget);
        expect(find.bySemanticsLabel('${healing.label}: ${healing.value}'),
            findsOneWidget);
        final cardBounds = tester.getRect(find.byType(SpellCard));
        expect(cardBounds.contains(tester.getTopLeft(icon)), isTrue);
        expect(cardBounds.contains(tester.getBottomRight(value)), isTrue);
        expect(find.byIcon(Icons.auto_awesome).hitTestable(), findsOneWidget);

        await tester.tap(find.text(spell.name!));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        final description = spellDescriptionText(spell.description)!;
        expect(find.text(description), findsOneWidget);
        final descriptionWidget = tester.widget<Text>(find.text(description));
        expect(descriptionWidget.maxLines, isNull);
        expect(descriptionWidget.overflow, isNot(TextOverflow.ellipsis));
        final dialogValue =
            find.descendant(of: find.byType(AlertDialog), matching: value);
        expect(dialogValue, findsOneWidget);
        expect(tester.widget<Text>(dialogValue).maxLines, isNull);
        await tester.tap(find.text('Закрыть'));
        await tester.pumpAndSettle();
        expect(find.byType(AlertDialog), findsNothing);
        expect(tester.takeException(), isNull);
      });
    }
  }
}
