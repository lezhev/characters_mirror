import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/spell_slot_recovery_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('picker respects level budget and returns one selection',
      (tester) async {
    Map<int, int>? selected;
    await tester.pumpWidget(MaterialApp(
        home: Builder(
            builder: (context) => Scaffold(
                body: TextButton(
                    onPressed: () async {
                      selected = await showDialog<Map<int, int>>(
                          context: context,
                          builder: (_) => const SpellSlotRecoveryDialog(
                              title: 'Fixture',
                              options: {1: 2, 2: 2, 3: 1},
                              budget: 3));
                    },
                    child: const Text('Open'))))));
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Выбрано: 0 / 3'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('recovery-increase-1')));
    await tester.tap(find.byKey(const ValueKey('recovery-increase-2')));
    await tester.pump();
    expect(find.text('Выбрано: 3 / 3'), findsOneWidget);
    expect(
        tester
            .widget<IconButton>(
                find.byKey(const ValueKey('recovery-increase-1')))
            .onPressed,
        isNull);
    await tester.tap(find.byKey(const ValueKey('confirm-spell-slot-recovery')));
    await tester.pumpAndSettle();
    expect(selected, {1: 1, 2: 1});
  });
  testWidgets('single select never permits a second slot', (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
            body: SpellSlotRecoveryDialog(
                title: 'Fixture', options: {1: 2, 2: 1}, single: true))));
    await tester.tap(find.byKey(const ValueKey('recovery-increase-2')));
    await tester.pump();
    expect(find.text('Выбрано: 1 / 1'), findsOneWidget);
    expect(
        tester
            .widget<IconButton>(
                find.byKey(const ValueKey('recovery-increase-1')))
            .onPressed,
        isNull);
  });
}
