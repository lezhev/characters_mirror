import 'package:characters_mirror_flutter/core/ui/widgets/app_free_solo_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final options = [
    const AppFreeSoloOption<String>(value: 'longsword', label: 'Длинный меч'),
    const AppFreeSoloOption<String>(value: 'lute', label: 'Лютня'),
    const AppFreeSoloOption<String>(value: 'thieves_tools', label: 'Воровские инструменты'),
  ];

  Future<void> pumpAutocomplete(
    WidgetTester tester, {
    List<AppFreeSoloOption<String>>? availableOptions,
    Set<String> selectedValues = const {},
    List<String> existingCustomValues = const [],
    void Function(String value)? onAddCanonical,
    void Function(String value)? onAddCustom,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: AppFreeSoloAutocomplete<String>(
              options: availableOptions ?? options,
              isSelected: selectedValues.contains,
              existingCustomValues: existingCustomValues,
              onAddCanonical: onAddCanonical ?? (_) {},
              onAddCustom: onAddCustom ?? (_) {},
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('suggestions prioritize exact, then prefix, then contains',
      (tester) async {
    await pumpAutocomplete(tester);
    await tester.enterText(
      find.byKey(const ValueKey('app-free-solo-autocomplete-field')),
      'меч',
    );
    await tester.pumpAndSettle();

    expect(find.text('Длинный меч'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('app-free-solo-autocomplete-field')),
      'лют',
    );
    await tester.pumpAndSettle();
    expect(find.text('Лютня'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('app-free-solo-autocomplete-field')),
      'воровские ИНСТРУМЕНТЫ',
    );
    await tester.pumpAndSettle();
    expect(find.text('Воровские инструменты'), findsOneWidget);
  });

  testWidgets('Tab and ArrowRight accept only an available ghost completion',
      (tester) async {
    await pumpAutocomplete(tester);
    final field = find.byKey(
      const ValueKey('app-free-solo-autocomplete-field'),
    );
    await tester.enterText(field, 'Лют');
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    expect(tester.widget<TextField>(field).controller!.text, 'Лютня');

    await tester.enterText(field, 'Длинный');
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();
    expect(tester.widget<TextField>(field).controller!.text, 'Длинный меч');
  });

  testWidgets('Up and Down select suggestions and Escape closes them',
      (tester) async {
    String? added;
    await pumpAutocomplete(tester, onAddCanonical: (value) => added = value);
    final field = find.byKey(
      const ValueKey('app-free-solo-autocomplete-field'),
    );
    await tester.enterText(field, 'и');
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(added, isNotNull);

    await tester.enterText(field, 'лют');
    await tester.pumpAndSettle();
    expect(find.text('Лютня'), findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(find.text('Лютня'), findsNothing);
  });

  testWidgets('tap suggestion and exact text add canonical entries',
      (tester) async {
    final added = <String>[];
    await pumpAutocomplete(tester, onAddCanonical: added.add);
    final field = find.byKey(
      const ValueKey('app-free-solo-autocomplete-field'),
    );

    await tester.enterText(field, 'лют');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Лютня'));
    await tester.pumpAndSettle();
    expect(added, ['lute']);
    expect(tester.widget<TextField>(field).controller!.text, isEmpty);

    await tester.enterText(field, 'Воровские инструменты');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(added, ['lute', 'thieves_tools']);
  });

  testWidgets('partial text stays custom; plus uses the same add semantics',
      (tester) async {
    final canonical = <String>[];
    final custom = <String>[];
    await pumpAutocomplete(
      tester,
      onAddCanonical: canonical.add,
      onAddCustom: custom.add,
    );
    final field = find.byKey(
      const ValueKey('app-free-solo-autocomplete-field'),
    );

    await tester.enterText(field, 'Лют');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(canonical, isEmpty);
    expect(custom, ['Лют']);

    await tester.enterText(field, 'Домашний инструмент');
    await tester.tap(find.byKey(const ValueKey('app-free-solo-add')));
    await tester.pumpAndSettle();
    expect(custom, ['Лют', 'Домашний инструмент']);
    expect(tester.widget<TextField>(field).controller!.text, isEmpty);
  });

  testWidgets('selected canonical values and duplicate custom text are ignored',
      (tester) async {
    final canonical = <String>[];
    final custom = <String>[];
    await pumpAutocomplete(
      tester,
      selectedValues: const {'lute'},
      existingCustomValues: const ['Особый инструмент'],
      onAddCanonical: canonical.add,
      onAddCustom: custom.add,
    );
    final field = find.byKey(
      const ValueKey('app-free-solo-autocomplete-field'),
    );

    await tester.enterText(field, 'Лютня');
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('app-free-solo-option-lute')), findsNothing);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(canonical, isEmpty);
    expect(custom, isEmpty);

    await tester.enterText(field, ' особый ИНСТРУМЕНТ ');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(custom, isEmpty);
  });
}
