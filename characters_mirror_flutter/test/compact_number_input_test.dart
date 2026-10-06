import 'package:characters_mirror_flutter/core/ui/widgets/compact_number_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'compact input does not inherit an additional inner border from the theme',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        theme: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                errorBorder: OutlineInputBorder(),
                focusedErrorBorder: OutlineInputBorder(),
                disabledBorder: OutlineInputBorder())),
        home: Scaffold(
            body: CompactNumberInput(
                fieldKey: const ValueKey('number-input'),
                initialValue: '5',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (_) {}))));
    final field = find.byType(TextField);
    final decoration = tester.widget<TextField>(field).decoration!;
    for (final border in [
      decoration.border,
      decoration.enabledBorder,
      decoration.focusedBorder,
      decoration.errorBorder,
      decoration.focusedErrorBorder,
      decoration.disabledBorder
    ]) {
      expect(border, InputBorder.none);
    }
    expect(decoration.filled, false);
    expect(tester.widget<TextField>(field).textAlignVertical?.y, -0.2);
    await tester.tap(field);
    await tester.pump();
    final inputBox = find.byKey(const ValueKey('number-input'));
    expect(tester.getSize(inputBox).width, tester.getSize(inputBox).height);
    for (final value in ['7', '35', '88']) {
      await tester.enterText(field, value);
      await tester.pump();
      expect(
        tester.widget<EditableText>(find.byType(EditableText)).controller.text,
        value,
      );
    }
  });
}
