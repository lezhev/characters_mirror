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

  testWidgets(
      'damage type picker uses two columns at intermediate width and saves selection',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(560, 780));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final drafts = <CharacterAttackData>[];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AttackDialog(
            attack: CharacterAttackData(name: 'Test Attack'),
            isCreating: false,
            onDraftChanged: (draft) async => drafts.add(draft),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Не указан').first);
    await tester.pumpAndSettle();

    expect(find.text('Тип урона'), findsOneWidget);
    final bludgeoning = find.byKey(const ValueKey('damage-type-bludgeoning'));
    final piercing = find.byKey(const ValueKey('damage-type-piercing'));
    final slashing = find.byKey(const ValueKey('damage-type-slashing'));
    final acid = find.byKey(const ValueKey('damage-type-acid'));
    final cold = find.byKey(const ValueKey('damage-type-cold'));
    final fire = find.byKey(const ValueKey('damage-type-fire'));
    expect(tester.getTopLeft(bludgeoning).dy, tester.getTopLeft(piercing).dy);
    expect(tester.getTopLeft(piercing).dy, tester.getTopLeft(slashing).dy);
    expect(tester.getTopLeft(acid).dy, tester.getTopLeft(cold).dy);
    expect(tester.getTopLeft(fire).dy, greaterThan(tester.getTopLeft(acid).dy));

    await tester.tap(acid);
    await tester.pump(characterSheetAutosaveDelay);
    await tester.pumpAndSettle();

    expect(drafts.last.damageType, DamageType.acid);
    expect(find.text('Кислота'), findsOneWidget);

    await tester.tap(find.text('Кислота'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Не указан').last);
    await tester.tap(find.text('Не указан').last);
    await tester.pump(characterSheetAutosaveDelay);
    await tester.pumpAndSettle();

    expect(drafts.last.damageType, isNull);
  });

  testWidgets('damage type picker uses five columns on a wide screen',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1000, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AttackDialog(
            attack: CharacterAttackData(name: 'Test Attack'),
            isCreating: false,
            onDraftChanged: (_) async {},
          ),
        ),
      ),
    );

    await tester.tap(find.text('Не указан').first);
    await tester.pumpAndSettle();

    final acid = find.byKey(const ValueKey('damage-type-acid'));
    final lightning = find.byKey(const ValueKey('damage-type-lightning'));
    final necrotic = find.byKey(const ValueKey('damage-type-necrotic'));
    expect(tester.getTopLeft(acid).dy, tester.getTopLeft(lightning).dy);
    expect(tester.getTopLeft(necrotic).dy,
        greaterThan(tester.getTopLeft(acid).dy));
  });
}
