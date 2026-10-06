import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/feature_tag_widgets.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/character_feature_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final expanded in [false, true]) {
    testWidgets(
        'reset is available only in the edit dialog, expanded=$expanded',
        (tester) async {
      var resets = 0;
      await _pumpCard(
        tester,
        resource: null,
        description: 'Custom description',
        isCustomized: true,
        onReset: () async => resets++,
        onSetResource: (_) async {},
      );
      if (expanded) {
        await tester.tap(find.byIcon(Icons.expand_more));
        await tester.pumpAndSettle();
      }

      expect(find.text('Вернуть всё как было'), findsNothing);
      expect(find.text('Вернуть значения по умолчанию'), findsNothing);
      await tester.tap(find.text('Feature'));
      await tester.pumpAndSettle();

      final resetButton = find.text('Вернуть значения по умолчанию');
      expect(resetButton, findsOneWidget);
      expect(find.text('Вернуть всё как было'), findsNothing);
      expect(find.byType(AlertDialog), findsOneWidget);
      await tester.tap(resetButton);
      await tester.pumpAndSettle();

      expect(resets, 1);
      expect(find.byType(AlertDialog), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  group('CharacterFeatureCard resource', () {
    testWidgets('shows compact resource summary while collapsed',
        (tester) async {
      final updates = <int>[];

      await _pumpCard(
        tester,
        resource: CharacterResourceViewData(
          key: 'main',
          name: 'Second Wind',
          kind: FeatureResourceKind.uses,
          current: 2,
          max: 3,
          resetOn: RestType.shortRest,
        ),
        onSetResource: (current) async => updates.add(current),
      );

      expect(find.byType(Card), findsNothing);
      expect(find.text('2/3'), findsOneWidget);
      expect(find.text('Использования'), findsNothing);
      expect(find.text('Короткий отдых'), findsNothing);
      expect(find.text('2 из 3'), findsNothing);
      expect(find.byTooltip('Потратить ресурс'), findsNothing);
      expect(find.byTooltip('Восстановить ресурс'), findsNothing);
    });

    testWidgets('shows expanded resource section with pill controls',
        (tester) async {
      final updates = <int>[];

      await _pumpCard(
        tester,
        resource: CharacterResourceViewData(
          key: 'main',
          name: 'Second Wind',
          kind: FeatureResourceKind.uses,
          current: 2,
          max: 3,
          resetOn: RestType.shortRest,
        ),
        onSetResource: (current) async => updates.add(current),
      );

      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pumpAndSettle();

      expect(find.text('Использования'), findsOneWidget);
      expect(find.text('Короткий отдых'), findsOneWidget);
      expect(find.text('2 из 3'), findsOneWidget);
      expect(find.byIcon(Icons.circle), findsNWidgets(2));
      expect(find.byIcon(Icons.circle_outlined), findsOneWidget);

      final spendButton = find.byTooltip('Потратить ресурс');
      final restoreButton = find.byTooltip('Восстановить ресурс');
      expect(tester.getSize(spendButton), const Size(44, 44));
      expect(tester.getSize(restoreButton), const Size(44, 44));

      await tester.tap(restoreButton);
      await tester.pump();

      expect(updates, [3]);
    });

    testWidgets('places the description before the resource section',
        (tester) async {
      await _pumpCard(
        tester,
        sourceName: 'Божественный домен Жизнь',
        level: 1,
        description: 'Описание особенности.',
        resource: CharacterResourceViewData(
          key: 'main',
          kind: FeatureResourceKind.uses,
          current: 1,
          max: 2,
          resetOn: RestType.longRest,
        ),
        onSetResource: (_) async {},
      );

      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pumpAndSettle();

      final sourceTop = tester
          .getTopLeft(find.text('Божественный домен Жизнь • Уровень 1'))
          .dy;
      final resourceTop = tester.getTopLeft(find.text('Использования')).dy;
      final descriptionTop =
          tester.getTopLeft(find.text('Описание особенности.')).dy;

      expect(resourceTop, greaterThan(sourceTop));
      expect(resourceTop, greaterThan(descriptionTop));
    });

    testWidgets('uses count without pips for large resources when expanded',
        (tester) async {
      await _pumpCard(
        tester,
        resource: CharacterResourceViewData(
          key: 'main',
          name: 'Lay on Hands',
          kind: FeatureResourceKind.points,
          current: 8,
          max: 10,
          resetOn: RestType.longRest,
        ),
        onSetResource: (_) async {},
      );

      expect(find.text('8/10'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pumpAndSettle();

      expect(find.text('8 из 10'), findsOneWidget);
      expect(find.byIcon(Icons.circle), findsNothing);
      expect(find.byIcon(Icons.circle_outlined), findsNothing);
    });

    testWidgets('omits collapsed resource summary when feature has no resource',
        (tester) async {
      await _pumpCard(
        tester,
        resource: null,
        onSetResource: (_) async {},
      );

      expect(find.text('Feature'), findsOneWidget);
      expect(find.textContaining('/'), findsNothing);
      expect(find.byTooltip('Потратить ресурс'), findsNothing);
    });

    testWidgets('renders resolved display properties in the expanded card',
        (tester) async {
      await _pumpCard(
        tester,
        resource: null,
        description: 'Feature description.',
        displayProperties: [
          FeatureDisplayPropertyView(
            key: 'healing',
            label: 'Лечение',
            value: '1к10 + 5',
          ),
        ],
        onSetResource: (_) async {},
      );

      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pumpAndSettle();

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is RichText &&
              widget.text.toPlainText().contains('Лечение: 1к10 + 5'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders persisted choices in the expanded card',
        (tester) async {
      await _pumpCard(
        tester,
        resource: null,
        selectedChoiceDetails: [
          SelectedFeatureChoiceView(
              groupKey: 'enemy',
              groupTitle: 'Выберите 1',
              optionKey: 'undead',
              name: 'Нежить',
              shortDescription: 'Enemy short text'),
          SelectedFeatureChoiceView(
              groupKey: 'language', optionKey: 'undercommon', name: 'Подземный')
        ],
        onSetResource: (_) async {},
      );

      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pumpAndSettle();

      expect(find.text('Нежить'), findsOneWidget);
      expect(find.text('Enemy short text'), findsOneWidget);
      expect(find.text('Выберите 1'), findsNothing);
      expect(find.text('Подземный'), findsOneWidget);
    });

    testWidgets('aligns collapsed feature titles to the left', (tester) async {
      await _pumpCard(
        tester,
        resource: null,
        onSetResource: (_) async {},
      );

      final cardLeft = tester.getTopLeft(find.byType(CharacterFeatureCard)).dx;
      final cardWidth = tester.getSize(find.byType(CharacterFeatureCard)).width;
      final titleLeft = tester.getTopLeft(find.text('Feature')).dx;

      expect(titleLeft, lessThan(cardLeft + cardWidth / 4));
    });

    testWidgets('shows feature tags as read-only icons when expanded',
        (tester) async {
      final semantics = tester.ensureSemantics();

      await _pumpCard(
        tester,
        resource: null,
        tags: const [FeatureTag.combat, FeatureTag.bonusAction],
        onSetResource: (_) async {},
      );

      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pumpAndSettle();

      expect(find.byType(Chip), findsNothing);
      expect(find.byType(FeatureTagIconWrap), findsOneWidget);
      expect(
        find.byKey(const ValueKey('feature-tag-icon-combat')),
        findsOneWidget,
      );
      expect(find.byTooltip('Боевая'), findsOneWidget);
      expect(find.bySemanticsLabel('Боевая'), findsOneWidget);
      expect(find.text('Боевая'), findsNothing);
      expect(find.text('Бонусное действие'), findsNothing);

      semantics.dispose();
    });
  });
}

Future<void> _pumpCard(
  WidgetTester tester, {
  required CharacterResourceViewData? resource,
  required Future<void> Function(int current) onSetResource,
  CharacterFeatureSourceType sourceType =
      CharacterFeatureSourceType.classFeature,
  String? sourceName,
  int? level,
  String? description,
  List<FeatureTag>? tags,
  List<FeatureDisplayPropertyView>? displayProperties,
  List<SelectedFeatureChoiceView>? selectedChoiceDetails,
  bool isCustomized = false,
  Future<void> Function()? onReset,
}) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: CharacterFeatureCard(
            feature: CharacterFeatureViewData(
              sourceType: sourceType,
              sourceId: 1,
              sourceName: sourceName,
              level: level,
              defaultName: 'Feature',
              name: 'Feature',
              description: description,
              shortDescription: description,
              isCustomized: isCustomized,
              defaultTags: tags,
              resources: resource == null ? null : [resource],
              displayProperties: displayProperties,
              selectedChoiceDetails: selectedChoiceDetails,
            ),
            onSave: ({name, description, tags}) async {},
            onReset: onReset ?? () async {},
            onSetResource: (_, current) => onSetResource(current),
          ),
        ),
      ),
    ),
  );
}
