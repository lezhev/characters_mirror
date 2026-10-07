import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/choice_picker.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import 'package:characters_mirror_flutter/features/level_up/presentation/level_up_spells.dart';
import 'package:characters_mirror_flutter/features/level_up/application/level_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'level_up_controller_test.dart' as controller_test;

SpellData spell(int id, {int level = 1}) => SpellData(
    id: id,
    name: 'Spell $id',
    level: level,
    castingTime: '1 действие',
    range: '60 футов',
    duration: '1 минута',
    description: 'Full description $id');

LevelUpPreview preview(CharacterSpellSelectionKind kind,
        {bool replacement = false, int count = 1}) =>
    LevelUpPreview(
        before: CharacterData(spellSelections: [
          CharacterSpellSelectionData(
              id: 'old-selection',
              classEntry: CharacterClassEntryData(id: 'entry'),
              kind: CharacterSpellSelectionKind.knownSpell,
              spellId: 9,
              spell: spell(9)),
        ]),
        character: CharacterData(),
        classStep: ClassStepView(spellSelectionGroups: [
          ClassSpellSelectionGroupView(kind: kind, options: [
            spell(1,
                level:
                    kind == CharacterSpellSelectionKind.knownCantrip ? 0 : 1),
            spell(2, level: 2),
            spell(3, level: 2),
          ])
        ]),
        choiceGroups: [],
        missingDecisions: [],
        spellDelta: ClassSpellDeltaView(
            cantripsToAdd:
                !replacement && kind == CharacterSpellSelectionKind.knownCantrip
                    ? count
                    : 0,
            knownSpellsToAdd:
                !replacement && kind == CharacterSpellSelectionKind.knownSpell
                    ? count
                    : 0,
            spellbookSpellsToAdd: !replacement &&
                    kind == CharacterSpellSelectionKind.spellbookSpell
                ? count
                : 0,
            knownSpellReplacements: replacement ? 1 : 0));

LevelUpRequest request({List<LevelUpSpellChoice>? choices}) => LevelUpRequest(
    characterId: 1, expectedVersion: 1, classEntryId: 'entry', spells: choices);

Future<void> pumpSpells(WidgetTester tester, LevelUpPreview data,
        {LevelUpRequest? draft,
        required void Function(CharacterSpellSelectionKind, List<int>, String?)
            onChanged}) =>
    tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: LevelUpSpells(
                preview: data,
                request: draft ?? request(),
                onChanged: onChanged))));

Finder card(int id) => find.widgetWithText(Card, 'Spell $id');
Finder checkbox(int id) =>
    find.descendant(of: card(id), matching: find.byType(Checkbox));
Finder info(int id) =>
    find.descendant(of: card(id), matching: find.byIcon(Icons.info_outline));

Future<void> inspect(WidgetTester tester, int id) async {
  await tester.tap(info(id));
  await tester.pumpAndSettle();
  expect(find.text('Full description $id'), findsOneWidget);
  await tester.tap(find.text('Закрыть'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shared picker commits only confirmed results to level-up state',
      (tester) async {
    final data = preview(CharacterSpellSelectionKind.knownSpell, count: 2);
    final gateway = controller_test.FakeGateway();
    final controller = LevelUpController(gateway, request());
    addTearDown(controller.dispose);
    final refresh = controller.refresh();
    gateway.pending.single.complete(data);
    await refresh;
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: StatefulBuilder(
                builder: (context, setState) => LevelUpSpells(
                    preview: controller.state.preview!,
                    request: controller.state.request,
                    onChanged: (kind, ids, replaces) {
                      controller.chooseSpells(kind, ids,
                          replacesSelectionId: replaces);
                      gateway.pending.last.complete(data);
                      setState(() {});
                    })))));
    await tester.tap(find.text('Выбрать заклинания'));
    await tester.pumpAndSettle();
    final picker = tester.widget<ChoicePicker>(find.byType(ChoicePicker));
    expect(picker.minimum, 2);
    expect(picker.maximum, 2);
    final done = find.widgetWithText(FilledButton, 'Готово');
    expect(tester.widget<FilledButton>(done).onPressed, isNull);
    await tester.tap(find.text('Spell 1'));
    await tester.pump();
    expect(tester.widget<FilledButton>(done).onPressed, isNull);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(controller.state.request.spells, isNull);
    await tester.tap(find.text('Выбрать заклинания'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Spell 1'));
    await tester.pump();
    await tester.tap(find.text('Spell 2'));
    await tester.pump();
    expect(tester.widget<Checkbox>(checkbox(3)).onChanged, isNull);
    await tester.tap(done);
    await tester.pumpAndSettle();
    expect(controller.state.request.spells!.map((s) => s.spellId), [1, 2]);
    expect(
        controller.state.request.spells!.every((s) =>
            s.kind == CharacterSpellSelectionKind.knownSpell &&
            s.replacesSelectionId == null),
        isTrue);
    expect(find.text('Выбрано 2 / 2'), findsOneWidget);
    expect(find.text('Spell 1, Spell 2'), findsOneWidget);
  });

  testWidgets('spell decisions and new level share one outline',
      (tester) async {
    final base = preview(CharacterSpellSelectionKind.knownSpell);
    await pumpSpells(
        tester,
        base.copyWith(
            character: CharacterData(
                derived: CharacterDerivedData(spellSlots: {2: 2})),
            spellDelta: base.spellDelta.copyWith(knownSpellReplacements: 1)),
        onChanged: (_, __, ___) {});
    final block = find.byType(SheetOutlineCard);
    expect(block, findsOneWidget);
    for (final label in [
      'Заклинания',
      'Выбрать заклинания',
      'Заменить заклинание',
      'Доступны заклинания 2 уровня'
    ]) {
      expect(find.descendant(of: block, matching: find.text(label)),
          findsOneWidget);
    }
    expect(find.descendant(of: block, matching: find.byType(Divider)),
        findsNWidgets(3));
  });

  testWidgets('no spell events hides the block', (tester) async {
    await pumpSpells(
        tester, preview(CharacterSpellSelectionKind.knownSpell, count: 0),
        onChanged: (_, __, ___) {});
    expect(find.byType(SheetOutlineCard), findsNothing);
    expect(find.text('Заклинания'), findsNothing);
  });

  testWidgets('new level alone still renders a passive outline row',
      (tester) async {
    final base = preview(CharacterSpellSelectionKind.knownSpell, count: 0);
    await pumpSpells(
        tester,
        base.copyWith(
            character: CharacterData(
                derived: CharacterDerivedData(pactSlots: {2: 1}))),
        onChanged: (_, __, ___) {});
    expect(find.byType(SheetOutlineCard), findsOneWidget);
    expect(find.text('Доступны заклинания 2 уровня'), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsNothing);
  });

  for (final kind in [
    CharacterSpellSelectionKind.knownCantrip,
    CharacterSpellSelectionKind.knownSpell,
    CharacterSpellSelectionKind.spellbookSpell
  ]) {
    testWidgets('$kind uses spell cards and separates selection from details',
        (tester) async {
      List<int>? chosen;
      await pumpSpells(tester, preview(kind), onChanged: (k, ids, replaces) {
        expect(k, kind);
        expect(replaces, isNull);
        chosen = ids;
      });
      expect(find.byType(SheetOutlineCard), findsOneWidget);
      await tester
          .tap(find.text(kind == CharacterSpellSelectionKind.knownCantrip
              ? 'Выбрать заговоры'
              : kind == CharacterSpellSelectionKind.spellbookSpell
                  ? 'Добавить в книгу заклинаний'
                  : 'Выбрать заклинания'));
      await tester.pumpAndSettle();
      expect(find.byType(ChoicePicker), findsOneWidget);
      expect(card(1), findsOneWidget);
      expect(tester.getCenter(checkbox(1)).dx,
          lessThan(tester.getCenter(find.text('Spell 1')).dx));
      expect(tester.getCenter(info(1)).dx,
          greaterThan(tester.getCenter(find.text('Spell 1')).dx));
      expect(find.textContaining('60 футов'), findsWidgets);
      expect(find.text('Full description 1'), findsNothing);
      await inspect(tester, 1);
      expect(tester.widget<Checkbox>(checkbox(1)).value, false);
      await tester.tap(find.text('Spell 1'));
      await tester.pump();
      expect(tester.widget<Checkbox>(checkbox(1)).value, true);
      expect(find.byType(AlertDialog), findsNothing);
      await inspect(tester, 1);
      expect(tester.widget<Checkbox>(checkbox(1)).value, true);
      await tester.tap(checkbox(1));
      await tester.pump();
      expect(tester.widget<Checkbox>(checkbox(1)).value, false);
      await tester.tap(find.text('Spell 2'));
      await tester.pump();
      await tester.tap(find.text('Готово'));
      await tester.pumpAndSettle();
      expect(chosen, [2]);
    });
  }

  testWidgets(
      'full selection still allows inspecting an unselected spell and filtering',
      (tester) async {
    await pumpSpells(
        tester, preview(CharacterSpellSelectionKind.knownSpell, count: 2),
        onChanged: (_, __, ___) {});
    await tester.tap(find.text('Выбрать заклинания'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Spell 1'));
    await tester.tap(find.text('Spell 2'));
    await tester.pump();
    expect(tester.widget<Checkbox>(checkbox(3)).onChanged, isNull);
    await inspect(tester, 3);
    expect(find.text('Выбрано 2 / 2'), findsOneWidget);
    await tester.tap(find.widgetWithText(ChoiceChip, '2 уровень'));
    await tester.pump();
    expect(card(1), findsNothing);
    await tester.enterText(find.byType(TextField), 'Spell 3');
    await tester.pump();
    expect(card(2), findsNothing);
    expect(card(3), findsOneWidget);
  });

  testWidgets(
      'both replacement pickers use spell cards and preserve selection IDs',
      (tester) async {
    List<int>? chosen;
    String? replaced;
    await pumpSpells(tester,
        preview(CharacterSpellSelectionKind.knownSpell, replacement: true),
        onChanged: (_, ids, id) {
      chosen = ids;
      replaced = id;
    });
    await tester.tap(find.text('Заменить заклинание'));
    await tester.pumpAndSettle();
    expect(card(9), findsOneWidget);
    await inspect(tester, 9);
    await tester.tap(find.text('Spell 9'));
    await tester.pump();
    await tester.tap(find.text('Готово'));
    await tester.pumpAndSettle();
    expect(card(1), findsOneWidget);
    await inspect(tester, 1);
    await tester.tap(find.text('Spell 1'));
    await tester.pump();
    await tester.tap(find.text('Готово'));
    await tester.pumpAndSettle();
    expect(chosen, [1]);
    expect(replaced, 'old-selection');
  });

  testWidgets('hub draft spells show summaries and edit through the picker',
      (tester) async {
    final updates = <(List<int>, String?)>[];
    await pumpSpells(
        tester,
        preview(CharacterSpellSelectionKind.knownSpell, replacement: true)
            .copyWith(
                spellDelta: ClassSpellDeltaView(
                    cantripsToAdd: 0,
                    knownSpellsToAdd: 1,
                    spellbookSpellsToAdd: 0,
                    knownSpellReplacements: 1)),
        draft: request(choices: [
          LevelUpSpellChoice(
              kind: CharacterSpellSelectionKind.knownSpell, spellId: 1),
          LevelUpSpellChoice(
              kind: CharacterSpellSelectionKind.knownSpell,
              spellId: 2,
              replacesSelectionId: 'old-selection')
        ]),
        onChanged: (_, ids, replaces) => updates.add((ids, replaces)));
    expect(find.byType(Card), findsNothing);
    expect(find.text('Spell 1'), findsOneWidget);
    expect(find.text('Spell 9 → Spell 2'), findsOneWidget);
    expect(find.text('Выбрано 1 / 1'), findsOneWidget);
    expect(updates, isEmpty);
    await tester.tap(find.text('Выбрать заклинания'));
    await tester.pumpAndSettle();
    expect(tester.widget<Checkbox>(checkbox(1)).value, true);
    await tester.tap(find.text('Spell 3'));
    await tester.pump();
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(updates, isEmpty);
    expect(find.text('Spell 1'), findsOneWidget);
  });

  testWidgets('selection cards fit a narrow screen in the app theme',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
        theme: darkTheme,
        home: Scaffold(
            body: LevelUpSpells(
                preview: preview(CharacterSpellSelectionKind.knownSpell),
                request: request(),
                onChanged: (_, __, ___) {}))));
    await tester.tap(find.text('Выбрать заклинания'));
    await tester.pumpAndSettle();
    expect(card(1), findsOneWidget);
    expect(tester.takeException(), isNull);
    await inspect(tester, 1);
    expect(tester.takeException(), isNull);
  });
}
