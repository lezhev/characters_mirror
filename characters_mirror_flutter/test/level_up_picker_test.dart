import 'package:characters_mirror_flutter/features/level_up/presentation/level_up_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('a single choice can be changed without first clearing it',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: LevelUpPicker(title: 'Pick', maximum: 1, minimum: 1, selected: [
      'a'
    ], options: [
      LevelUpPickerOption(key: 'a', name: 'Alpha'),
      LevelUpPickerOption(key: 'b', name: 'Beta'),
    ])));
    await tester.tap(find.text('Beta'));
    await tester.pump();
    final beta = tester.widget<ListTile>(
        find.ancestor(of: find.text('Beta'), matching: find.byType(ListTile)));
    expect((beta.leading as Icon).icon, Icons.check_circle);
    expect(find.text('Выбрано 1 / 1'), findsOneWidget);
  });
}
