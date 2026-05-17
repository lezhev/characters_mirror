import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/helpers/sheet_autosave.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/attack_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('attack dialog adds and removes damage parts', (tester) async {
    final drafts = <CharacterAttackData>[];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AttackDialog(
            attack: CharacterAttackData(
              name: 'Test Attack',
              damage: '1d8',
              damageType: DamageType.slashing,
            ),
            isCreating: false,
            onDraftChanged: (draft) async {
              drafts.add(draft);
            },
          ),
        ),
      ),
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Формула').first,
      '4d6',
    );
    await tester.pump(characterSheetAutosaveDelay);

    expect(drafts.last.damage, '4d6');
    expect(drafts.last.damageParts, hasLength(1));

    await tester.tap(find.byTooltip('Добавить урон'));
    await tester.pump();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Формула').last,
      '4d6',
    );
    await tester.pump(characterSheetAutosaveDelay);

    expect(drafts.last.damageParts, hasLength(2));

    await tester.tap(find.byTooltip('Удалить урон').last);
    await tester.pump(characterSheetAutosaveDelay);

    expect(drafts.last.damageParts, hasLength(1));
  });

  testWidgets('attack dialog debounces text autosave', (tester) async {
    final drafts = <CharacterAttackData>[];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AttackDialog(
            attack: CharacterAttackData(name: 'Test Attack'),
            isCreating: false,
            onDraftChanged: (draft) async {
              drafts.add(draft);
            },
          ),
        ),
      ),
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Название'),
      'A',
    );
    await tester.pump(const Duration(milliseconds: 250));
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Название'),
      'Attack',
    );
    await tester.pump(const Duration(milliseconds: 250));

    expect(drafts, isEmpty);

    await tester.pump(characterSheetAutosaveDelay);

    expect(drafts, hasLength(1));
    expect(drafts.single.name, 'Attack');
  });
}
