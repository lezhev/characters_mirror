import 'dart:io';
import 'dart:ui' as ui;

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/spell_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/spell_card.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/spell_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

const _capture = bool.fromEnvironment('SPELL_UI_SCREENSHOTS');

void main() {
  for (final dark in [false, true]) {
    for (final pools in ['standard', 'pact', 'mixed']) {
      testWidgets('$pools slots share level sections, dark=$dark, 320px/1.3',
          (tester) async {
        _narrow(tester);
        final semantics = tester.ensureSemantics();
        try {
          final boundary = GlobalKey();
          await _font(tester);
          var standardUpdates = 0;
          var pactUpdates = 0;
          await tester.pumpWidget(_host(
            dark: dark,
            boundary: boundary,
            child: SpellPageContent(
              character: _character(pools),
              onSlotCountChanged: (level, count) async {
                expect(level, 1);
                expect(count, 3);
                standardUpdates++;
              },
              onPactSlotCountChanged: (level, count) async {
                expect(level, 1);
                expect(count, 1);
                pactUpdates++;
              },
            ),
          ));
          await tester.pumpAndSettle();
          expect(find.text('Заговоры'), findsOneWidget);
          expect(find.text('Круг 0'), findsNothing);
          expect(find.text('Круг 1'), findsOneWidget);
          expect(find.text('Круг 2'), findsOneWidget);
          expect(find.textContaining('Магия договора'), findsNothing);
          expect(find.text('Общее заклинание'), findsOneWidget);
          final standard = find.byKey(const ValueKey('spell-slot-Круг 1-0'));
          final pact = find.byKey(const ValueKey('pact-slot-Круг 1-0'));
          if (pools != 'pact') {
            expect(standard, findsOneWidget);
            _slotStyle(tester, standard, BoxShape.circle,
                Theme.of(tester.element(standard)).colorScheme.primary);
            expect(find.bySemanticsLabel('Ячейка заклинания 1 круга, доступна'),
                findsNWidgets(4));
            expect(
                find.bySemanticsLabel(
                    'Ячейка заклинания 1 круга, использована'),
                findsOneWidget);
            await tester.tap(standard);
            await tester.pump();
            expect(standardUpdates, 1);
          } else {
            expect(standard, findsNothing);
          }
          if (pools != 'standard') {
            expect(pact, findsOneWidget);
            _slotStyle(tester, pact, BoxShape.rectangle,
                Theme.of(tester.element(pact)).colorScheme.secondary);
            expect(
                find.bySemanticsLabel(
                    'Ячейка магии договора 1 круга, доступна'),
                findsNWidgets(2));
            expect(
                find.bySemanticsLabel(
                    'Ячейка магии договора 1 круга, использована'),
                findsOneWidget);
            await tester.tap(pact);
            await tester.pump();
            expect(pactUpdates, 1);
          } else {
            expect(pact, findsNothing);
          }
          if (pools == 'mixed') {
            final row = find.byKey(const ValueKey('spell-slot-row-Круг 1'));
            expect(
                find.descendant(of: row, matching: standard), findsOneWidget);
          }
          final slots = pools == 'pact' ? pact : standard;
          expect(tester.getCenter(slots).dy,
              closeTo(tester.getCenter(find.text('Круг 1')).dy, 0.1));
          expect(find.byType(Tooltip), findsNothing);
          expect(tester.takeException(), isNull);
          if (_capture) {
            await _save(tester, boundary, '$pools-${dark ? 'dark' : 'light'}');
          }
        } finally {
          semantics.dispose();
        }
      });
    }
  }

  testWidgets('large mixed slot row stays on one line', (tester) async {
    _narrow(tester);
    final character = _character('mixed');
    await tester.pumpWidget(_host(
        child: SpellPageContent(
      character: character.copyWith(
          derived: character.derived!.copyWith(
        spellSlots: {1: 9},
        pactSlots: {1: 4},
      )),
    )));
    await tester.pumpAndSettle();
    expect(find.text('Круг 1'), findsOneWidget);
    expect(find.text('Общее заклинание'), findsOneWidget);
    final first = find.byKey(const ValueKey('spell-slot-Круг 1-0'));
    final last = find.byKey(const ValueKey('pact-slot-Круг 1-3'));
    expect(tester.getCenter(last).dy, closeTo(tester.getCenter(first).dy, 0.1));
    final row = find.byKey(const ValueKey('spell-slot-row-Круг 1'));
    expect(find.descendant(of: row, matching: first), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  for (final type in [
    DamageType.poison,
    DamageType.lightning,
    DamageType.fire
  ]) {
    testWidgets('$type uses existing SVG and accessible damage text',
        (tester) async {
      _narrow(tester);
      final semantics = tester.ensureSemantics();
      try {
        await tester.pumpWidget(_host(
            child: ListView(children: [
          SpellCard(spell: _damageSpell(type)),
          SpellCard(
              spell: _damageSpell(type).copyWith(referenceKey: 'another')),
        ])));
        await tester.pumpAndSettle();
        final icons = tester.widgetList<SvgPicture>(find.byType(SvgPicture));
        expect(icons, hasLength(2));
        for (final icon in icons) {
          expect((icon.bytesLoader as SvgAssetLoader).assetName,
              'assets/svg/damage_types/${type.name}.svg');
        }
        expect(find.text('1к12'), findsNWidgets(2));
        expect(find.textContaining('(яд)'), findsNothing);
        expect(find.textContaining('(электричество)'), findsNothing);
        expect(find.textContaining('(огонь)'), findsNothing);
        final damageLabel = switch (type) {
          DamageType.poison => 'Урон ядом',
          DamageType.lightning => 'Урон электричеством',
          _ => 'Урон огнём',
        };
        expect(find.bySemanticsLabel('$damageLabel: 1к12'), findsNWidgets(2));
        expect(find.byType(Tooltip), findsNothing);
        expect(tester.takeException(), isNull);
      } finally {
        semantics.dispose();
      }
    });
  }

  testWidgets('metadata restores only agreed icons; other highlights stay text',
      (tester) async {
    _narrow(tester);
    await tester.pumpWidget(_host(
        child: ListView(children: [
      SpellCard(
        spell: SpellData(
          name: 'Метаданные',
          castingTime: 'Действие',
          range: 'Существо в пределах дистанции заклинания',
          durationType: SpellDurationType.instantaneous,
          concentration: true,
          ritual: true,
          attackType: SpellAttackType.rangedSpell,
          savingThrowAbility: 'wisdom',
          targetType: SpellTargetType.singleCreature,
        ),
        trailing: const SizedBox.shrink(),
      ),
    ])));
    await tester.pumpAndSettle();
    expect(
        tester.widgetList<Icon>(find.byType(Icon)).map((i) => i.icon),
        unorderedEquals([
          Icons.bolt,
          Icons.swap_horiz,
          Icons.hourglass_empty,
          Icons.blur_on
        ]));
    expect(find.byType(RitualIcon), findsOneWidget);
    expect(find.text('Мгновенно'), findsOneWidget);
    expect(find.text('Концентрация'), findsOneWidget);
    expect(find.text('Ритуал'), findsOneWidget);
    expect(find.textContaining('Атака:'), findsOneWidget);
    expect(find.textContaining('Спасбросок:'), findsOneWidget);
    expect(find.textContaining('Цель:'), findsOneWidget);
    expect(find.byType(SvgPicture), findsNothing);
    expect(tester.takeException(), isNull);
  });
}

SpellData _damageSpell(DamageType type) => SpellData(
      referenceKey: 'damage',
      name: 'Ведьмин снаряд',
      level: 1,
      damageDice: '1d12',
      damageType: type,
      castingTime: 'Действие',
      range: '30 футов',
      duration: '1 минута',
      concentration: true,
    );

CharacterData _character(String pools) => CharacterData(
      currentSpellSlots: const {1: 4},
      currentPactSlots: const {1: 2},
      derived: CharacterDerivedData(
        spellSlots: pools == 'pact' ? {} : {1: 5},
        pactSlots: pools == 'standard' ? {} : {1: 3, 2: 2},
        resolvedSpells: [
          for (final level in [0, 1, 2])
            ResolvedCharacterSpellData(
              spellKey: 'spell_$level',
              spell: level == 1
                  ? _damageSpell(DamageType.lightning).copyWith(
                      referenceKey: 'spell_1', name: 'Общее заклинание')
                  : SpellData(
                      referenceKey: 'spell_$level',
                      name: 'Заклинание $level',
                      level: level),
              sources: [
                for (final name
                    in pools == 'mixed' ? ['Wizard', 'Warlock'] : [pools])
                  SpellSourceContextData(
                    sourceKey: 'class:$name',
                    label: name,
                    known: true,
                    prepared: true,
                    alwaysPrepared: false,
                    granted: false,
                    canUseSlots: true,
                  ),
              ],
            ),
        ],
      ),
    );

Widget _host({required Widget child, bool dark = false, GlobalKey? boundary}) =>
    RepaintBoundary(
      key: boundary,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _fixtureTheme(dark),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.3)),
          child: child!,
        ),
        home: Scaffold(
            body: Padding(padding: const EdgeInsets.all(12), child: child)),
      ),
    );

ThemeData _fixtureTheme(bool dark) {
  final theme = dark ? darkTheme : lightTheme;
  return _capture
      ? theme.copyWith(
          textTheme: theme.textTheme.apply(fontFamily: 'VerificationUI'))
      : theme;
}

void _narrow(WidgetTester tester) {
  tester.view.physicalSize = const Size(320, 1300);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void _slotStyle(WidgetTester tester, Finder slot, BoxShape shape, Color color) {
  final boxes = tester.widgetList<DecoratedBox>(
      find.descendant(of: slot, matching: find.byType(DecoratedBox)));
  final decoration = boxes.first.decoration as BoxDecoration;
  expect(decoration.shape, shape);
  expect((decoration.border! as Border).top.color, color);
}

Future<void> _font(WidgetTester tester) async {
  if (!_capture) return;
  await tester.runAsync(() async {
    final loader = FontLoader('VerificationUI')
      ..addFont(File('C:/Windows/Fonts/segoeui.ttf')
          .readAsBytes()
          .then(ByteData.sublistView));
    await loader.load();
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });
}

Future<void> _save(WidgetTester tester, GlobalKey key, String name) async {
  await tester.runAsync(() async {
    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    await File('../.tmp/spell-ui-$name-320.png')
        .writeAsBytes(data!.buffer.asUint8List());
    image.dispose();
  });
}
