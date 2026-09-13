import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/feature_tag_widgets.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/smooth_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('smooth switcher editable dialog updates displayed text',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: _SmoothSwitcherHarness(),
        ),
      ),
    );

    expect(find.text('Старый текст'), findsOneWidget);

    await tester.tap(find.text('Старый текст'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).last, 'Новый текст');
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    expect(find.text('Новый текст'), findsOneWidget);
  });

  testWidgets('ability dialog uses shared feature tag grid', (tester) async {
    List<FeatureTag>? savedTags;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SmoothSwitcher.ability(
            title: 'Способность',
            text: 'Описание',
            tags: const [FeatureTag.combat],
            isCustomized: false,
            onSave: ({title, text, tags}) async {
              savedTags = tags;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Способность'));
    await tester.pumpAndSettle();

    expect(find.byType(FeatureTagSelectionGrid), findsOneWidget);
    expect(find.byType(FilterChip), findsNothing);

    final combatTile = find.byKey(const ValueKey('feature-tag-tile-combat'));
    await tester.ensureVisible(combatTile);
    await tester.tap(combatTile);
    await tester.pump();

    final reactionTile = find.byKey(
      const ValueKey('feature-tag-tile-reaction'),
    );
    await tester.ensureVisible(reactionTile);
    await tester.tap(reactionTile);
    await tester.pump();

    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    expect(savedTags, const [FeatureTag.reaction]);
  });
}

class _SmoothSwitcherHarness extends StatefulWidget {
  const _SmoothSwitcherHarness();

  @override
  State<_SmoothSwitcherHarness> createState() => _SmoothSwitcherHarnessState();
}

class _SmoothSwitcherHarnessState extends State<_SmoothSwitcherHarness> {
  String text = 'Старый текст';

  @override
  Widget build(BuildContext context) {
    return SmoothSwitcher(
      title: 'Заголовок',
      text: text,
      editConfig: SmoothSwitcherEditConfig(
        onSave: ({String? title, String? text}) async {
          setState(() {
            this.text = text ?? this.text;
          });
        },
      ),
    );
  }
}
