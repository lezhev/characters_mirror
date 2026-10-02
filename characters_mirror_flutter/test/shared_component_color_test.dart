import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/button.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/feature_tag_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget host(Widget child) => MaterialApp(
        theme: darkTheme,
        home: Scaffold(body: child),
      );

  group('Button colors', () {
    testWidgets('filled uses primary and onPrimary', (tester) async {
      await tester.pumpWidget(host(
        const Button.filled(title: 'Continue', onPressed: _noop),
      ));

      final button = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.byType(Button),
          matching: find.byType(AnimatedContainer),
        ),
      );
      expect(
          (button.decoration as BoxDecoration).color, darkColorScheme.primary);
      expect(tester.widget<Text>(find.text('Continue')).style?.color,
          darkColorScheme.onPrimary);
    });

    testWidgets('outlined uses neutral outline and foreground', (tester) async {
      await tester.pumpWidget(host(
        const Button.outlined(title: 'More', onPressed: _noop),
      ));

      final decoration = tester
          .widget<AnimatedContainer>(
            find.descendant(
              of: find.byType(Button),
              matching: find.byType(AnimatedContainer),
            ),
          )
          .decoration as BoxDecoration;
      expect(decoration.border, isA<Border>());
      expect((decoration.border! as Border).top.color,
          darkColorScheme.outlineVariant);
      expect(tester.widget<Text>(find.text('More')).style?.color,
          darkColorScheme.onSurface);
    });

    testWidgets('text is neutral by default and explicit override works',
        (tester) async {
      const override = Colors.purple;
      await tester.pumpWidget(host(
        const Column(
          children: [
            Button.text(title: 'Default', onPressed: _noop),
            Button.text(
              title: 'Override',
              onPressed: _noop,
              textColor: override,
            ),
          ],
        ),
      ));

      expect(tester.widget<Text>(find.text('Default')).style?.color,
          darkColorScheme.onSurfaceVariant);
      expect(tester.widget<Text>(find.text('Override')).style?.color, override);
    });

    testWidgets('explicit color override remains available', (tester) async {
      const override = Colors.purple;
      await tester.pumpWidget(host(
        const Button.outlined(
          title: 'Custom',
          onPressed: _noop,
          color: override,
        ),
      ));

      final decoration = tester
          .widget<AnimatedContainer>(
            find.descendant(
              of: find.byType(Button),
              matching: find.byType(AnimatedContainer),
            ),
          )
          .decoration as BoxDecoration;
      expect((decoration.border! as Border).top.color, override);
      expect(tester.widget<Text>(find.text('Custom')).style?.color, override);
    });
  });

  testWidgets('section header defaults to neutral title and divider override',
      (tester) async {
    const override = Colors.purple;
    await tester.pumpWidget(host(
      const Column(
        children: [
          AppSectionHeader(title: 'Default'),
          AppSectionHeader(title: 'Override', dividerColor: override),
        ],
      ),
    ));

    expect(tester.widget<Text>(find.text('Default')).style?.color,
        darkColorScheme.onSurface);
    final dividers = tester.widgetList<Container>(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.constraints?.maxWidth == double.infinity,
      ),
    );
    expect(dividers.map((divider) => divider.color),
        [darkColorScheme.outlineVariant, override]);
  });

  testWidgets('surface card uses semantic default and allows override',
      (tester) async {
    const override = Colors.purple;
    await tester.pumpWidget(host(
      const Column(
        children: [
          AppSurfaceCard(child: SizedBox(height: 8)),
          AppSurfaceCard(
            backgroundColor: override,
            child: SizedBox(height: 8),
          ),
        ],
      ),
    ));

    final containers = tester.widgetList<Container>(find.byType(Container));
    final backgrounds = containers
        .map((container) => container.decoration)
        .whereType<BoxDecoration>()
        .map((decoration) => decoration.color)
        .toList();
    expect(backgrounds,
        containsAll([darkColorScheme.surfaceContainerLow, override]));
  });

  testWidgets('selected feature tag retains primary state', (tester) async {
    await tester.pumpWidget(host(
      FeatureTagSelectionTile(
        tag: FeatureTag.combat,
        selected: true,
        onTap: _noop,
      ),
    ));

    final decoration = tester
        .widget<AnimatedContainer>(
          find.descendant(
            of: find.byType(FeatureTagSelectionTile),
            matching: find.byType(AnimatedContainer),
          ),
        )
        .decoration as BoxDecoration;
    expect(decoration.border, isA<Border>());
    expect((decoration.border! as Border).top.color, darkColorScheme.primary);
  });
}

void _noop() {}
