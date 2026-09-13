import 'dart:io';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/feature_tag_localization.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/feature_tag_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FeatureTagSelectionGrid', () {
    testWidgets('toggles selected tags without check icons', (tester) async {
      var selectedTags = <FeatureTag>{FeatureTag.combat};

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return FeatureTagSelectionGrid(
                  tags: const [FeatureTag.combat, FeatureTag.reaction],
                  selectedTags: selectedTags,
                  onChanged: (next) {
                    setState(() {
                      selectedTags = next;
                    });
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsNothing);
      expect(find.byType(FilterChip), findsNothing);
      expect(selectedTags, contains(FeatureTag.combat));

      await tester.tap(find.byKey(const ValueKey('feature-tag-tile-combat')));
      await tester.pump();
      expect(selectedTags, isNot(contains(FeatureTag.combat)));

      await tester.tap(find.byKey(const ValueKey('feature-tag-tile-reaction')));
      await tester.pump();
      expect(selectedTags, contains(FeatureTag.reaction));
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('lays out adaptive columns from available width',
        (tester) async {
      expect(featureTagGridColumnCount(width: 240), 2);
      expect(featureTagGridColumnCount(width: 340), 3);
      expect(featureTagGridColumnCount(width: 460), 4);

      await _pumpGrid(tester, width: 240);
      _expectSameRow(tester, FeatureTag.action, FeatureTag.bonusAction);
      _expectLowerRow(tester, FeatureTag.reaction, FeatureTag.action);

      await _pumpGrid(tester, width: 340);
      _expectSameRow(tester, FeatureTag.action, FeatureTag.reaction);
      _expectLowerRow(tester, FeatureTag.passive, FeatureTag.action);

      await _pumpGrid(tester, width: 460);
      _expectSameRow(tester, FeatureTag.action, FeatureTag.passive);
      _expectLowerRow(tester, FeatureTag.resource, FeatureTag.action);
    });

    testWidgets('keeps long Russian labels within the tile', (tester) async {
      await _pumpGrid(
        tester,
        width: 104,
        tags: const [FeatureTag.bonusAction],
      );

      final text = tester.widget<Text>(find.text('Бонусное действие'));
      expect(text.maxLines, 2);
      expect(text.overflow, TextOverflow.ellipsis);
      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('feature tag metadata maps every enum to a renamed svg',
      (tester) async {
    for (final tag in FeatureTag.values) {
      final path = featureTagAssetPath(tag);

      expect(path, 'assets/svg/feature_tags/${tag.name}.svg');
      expect(File(path).existsSync(), isTrue);
    }
  });
}

Future<void> _pumpGrid(
  WidgetTester tester, {
  required double width,
  List<FeatureTag> tags = const [
    FeatureTag.action,
    FeatureTag.bonusAction,
    FeatureTag.reaction,
    FeatureTag.passive,
    FeatureTag.resource,
  ],
}) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: width,
            child: FeatureTagSelectionGrid(
              tags: tags,
              selectedTags: const {},
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    ),
  );
}

void _expectSameRow(
  WidgetTester tester,
  FeatureTag first,
  FeatureTag second,
) {
  expect(_tileTop(tester, first), _tileTop(tester, second));
}

void _expectLowerRow(
  WidgetTester tester,
  FeatureTag lower,
  FeatureTag upper,
) {
  expect(_tileTop(tester, lower), greaterThan(_tileTop(tester, upper)));
}

double _tileTop(WidgetTester tester, FeatureTag tag) {
  return tester
      .getTopLeft(find.byKey(ValueKey('feature-tag-tile-${tag.name}')))
      .dy;
}
