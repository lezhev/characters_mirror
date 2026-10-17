import 'dart:convert';
import 'dart:io';
import 'dart:ui' show ImageByteFormat;
import 'package:characters_mirror_shared/dungeon_master.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/application/statblock/dm_statblock.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/presentation/widgets/dm_statblock_item.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/presentation/widgets/dm_legendary_group.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/presentation/widgets/dm_magic_group.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'support/dm_statblock_harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadDmAuditFonts);
  final auditPath = Platform.environment['CM_DM_PRESENTATION_INPUT'];
  testWidgets('324 SRD creatures and 1935 items pass the rendered presentation',
      (tester) async {
    final audit = jsonDecode(
            (await tester.runAsync(() => File(auditPath!).readAsString()))!)
        as Map<String, dynamic>;
    final records = audit['records'] as List;
    expect(records, hasLength(324));
    var totalItems = 0, emptyDescriptions = 0;
    var casterRules = 0,
        legendaryRules = 0,
        magicCreatures = 0,
        relocatedResources = 0;
    final counts = <String, int>{};
    final spellModes = <String, int>{};
    for (final value in records) {
      final creature =
          NormalizedCreature.decode(value['normalizedJson'] as String);
      final actor =
          jsonDecode(value['rawJson'] as String) as Map<String, dynamic>;
      final before = jsonEncode(creature.toJson());
      final view = DmStatblock.fromCreature(creature, sourceActor: actor);
      expect(jsonEncode(creature.toJson()), before, reason: creature.name);
      for (final group in view.groups) {
        legendaryRules += group.legendary?.rules.length ?? 0;
        if (group.magic case final DmMagicView magic) {
          magicCreatures++;
          casterRules += magic.rules.length;
          relocatedResources += magic.resourceLabels.length;
          for (final spellGroup in magic.spells) {
            spellModes.update(spellGroup.id.split(':').first,
                (v) => v + spellGroup.items.length,
                ifAbsent: () => spellGroup.items.length);
          }
        }
      }
      final items = view.blocks.expand((b) => b.items).toList();
      expect(items, hasLength(creature.items.length), reason: creature.name);
      expect(items.map((i) => i.id).toSet(), hasLength(creature.items.length),
          reason: creature.name);
      expect(items.map((i) => i.name).toList()..sort(),
          creature.items.map((i) => i.name).toList()..sort(),
          reason: creature.name);
      for (final item in items) {
        counts.update(item.section.name, (v) => v + 1, ifAbsent: () => 1);
        if (item.description.isEmpty) emptyDescriptions++;
      }
      final renderedDescriptions = items.map((i) => i.description).toList()
        ..sort();
      expect(renderedDescriptions,
          creature.items.map((i) => i.description).toList()..sort(),
          reason: creature.name);
      await tester.pumpWidget(app(view));
      await tester.pump();
      final primary =
          view.groups.expand((g) => g.blocks).expand((b) => b.items).toList();
      expect(primary.map((i) => i.id).toList()..sort(),
          items.map((i) => i.id).toList()..sort(),
          reason: creature.name);
      await openRules(tester, view);
      for (final item in items) {
        final location = find.byKey(ValueKey(item.id));
        expect(location, findsOneWidget,
            reason: '${creature.name}: ${item.name}');
        expect(find.descendant(of: location, matching: find.text(item.name)),
            findsOneWidget);
        if (ruleItems(view).any((i) => i.id == item.id)) {
          expect(
              find.descendant(
                  of: location, matching: find.text(item.description)),
              findsOneWidget);
        } else {
          expect(tester.widget<DmStatblockItem>(location).item.description,
              item.description);
        }
      }
      expect(
          find.byWidgetPredicate((w) =>
              w is Divider &&
              w.key is ValueKey<String> &&
              (w.key! as ValueKey<String>).value.startsWith('group-divider-')),
          findsNWidgets(view.groups.length - 2),
          reason: creature.name);
      expect(find.text('СИЛ'), findsOneWidget);
      expect(
          find.descendant(
              of: find.byKey(const ValueKey('dm-stat-hp')),
              matching:
                  find.text('${actor['system']['attributes']['hp']['max']}')),
          findsOneWidget,
          reason: creature.name);
      expect(
          find.descendant(
              of: find.byKey(const ValueKey('dm-stat-ac')),
              matching: find.text('${creature.armorClass ?? '—'}')),
          findsOneWidget,
          reason: creature.name);
      for (var index = 0; index < 6; index++) {
        final key = ['str', 'dex', 'con', 'int', 'wis', 'cha'][index];
        final score = actor['system']['abilities'][key]['value'] as num;
        expect(view.abilities[index].score, '$score', reason: creature.name);
        final modifier = ((score - 10) / 2).floor();
        expect(view.abilities[index].modifier,
            modifier >= 0 ? '+$modifier' : '$modifier',
            reason: creature.name);
      }
      final lines = view.blocks.expand((b) => b.lines).map((l) => l.text);
      for (final key in ['legact', 'legres']) {
        final cap = actor['system']['resources'][key]['max'] as num;
        if (cap > 0) {
          expect(
              lines,
              contains(
                  '${key == 'legact' ? 'Действия (макс.)' : 'Легендарные сопротивления (макс.)'}: $cap'),
              reason: creature.name);
        }
      }
      expect(tester.takeException(), null, reason: creature.name);
      totalItems += items.length;
    }
    expect(totalItems, 1935);
    expect(emptyDescriptions, 0);
    final summary = {
      'creatures': records.length,
      'items': totalItems,
      'emptyDescriptions': emptyDescriptions,
      'groups': counts,
      'magicCreatures': magicCreatures,
      'linkedCasterRuleItems': casterRules,
      'linkedLegendaryRuleItems': legendaryRules,
      'relocatedResourceRows': relocatedResources,
      'spellModes': spellModes,
      'sourceChecksum': audit['sourceChecksum']
    };
    final output = Platform.environment['CM_DM_PRESENTATION_OUTPUT'];
    if (output != null) {
      await tester.runAsync(() => File(output)
          .writeAsString(const JsonEncoder.withIndent('  ').convert(summary)));
    }
    // ignore: avoid_print
    print(jsonEncode(summary));
  }, skip: auditPath == null);

  testWidgets(
      'real fixtures including Darathra and a feature-heavy SRD creature expand in both themes',
      (tester) async {
    final audit = jsonDecode(
            (await tester.runAsync(() => File(auditPath!).readAsString()))!)
        as Map<String, dynamic>;
    final records = audit['records'] as List;
    final many = records.reduce((a, b) =>
        (jsonDecode(a['normalizedJson'])['items'] as List).length >
                (jsonDecode(b['normalizedJson'])['items'] as List).length
            ? a
            : b);
    final examples = [...audit['fixtures'] as List, many];
    expect(examples.any((v) => v['name'] == 'Даратра Шендрел'), true,
        reason: 'The UX audit requires the real Darathra source fixture.');
    for (final value in examples) {
      final normalized =
          NormalizedCreature.decode(value['normalizedJson'] as String);
      final view = DmStatblock.fromCreature(normalized,
          sourceActor: jsonDecode(value['rawJson'] as String));
      if (normalized.name == 'Даратра Шендрел') {
        expect(view.proficiencySummary.any((l) => l.label == 'Навыки'), false);
        expect(
            view.proficiencySummary.any((l) => l.label == 'Спасброски'), true);
        expect(
            view.proficiencySummary.any((l) => l.label.contains('доп. бонус')),
            false);
      }
      if (normalized.name == 'Взрослый красный дракон') {
        final legendary = view.groups.singleWhere((g) => g.id == 'legendary');
        expect(legendary.blocks.expand((b) => b.items).map((i) => i.name),
            containsAll(['Легендарные действия', 'Легендарная устойчивость']));
        expect(
            view.blocks
                .where((b) => b.section == DmSection.resources)
                .expand((b) => b.lines),
            isEmpty);
        expect(
            view.blocks
                .where((b) => b.section == DmSection.lair)
                .expand((b) => b.items),
            hasLength(3));
        expect(legendary.legendary!.metrics.map((l) => l.value), ['3', '3']);
        expect(legendary.legendary!.periods, ['за раунд', 'в день']);
      }
      if (normalized.name == 'Маг') {
        final magic = view.groups.singleWhere((g) => g.id == 'spells').magic!;
        expect(magic.spells.expand((g) => g.items), hasLength(16));
        expect(magic.spells.map((g) => g.title), [
          'Заговоры',
          '1-й круг',
          '2-й круг',
          '3-й круг',
          '4-й круг',
          '5-й круг'
        ]);
        expect(magic.spells.map((g) => g.usage), [
          'Неограниченно',
          '4 ячейки',
          '3 ячейки',
          '3 ячейки',
          '3 ячейки',
          '1 ячейка'
        ]);
        expect(magic.spells.map((g) => g.items.length), [4, 4, 2, 3, 2, 1]);
        expect(magic.header.map((l) => l.text),
            ['Характеристика: ИНТ', 'СЛ заклинаний: 14', 'Бонус атаки: +6']);
        expect(
            magic.rules.single.description,
            normalized.items
                .singleWhere(
                    (i) => i.itemType == 'feat' && i.name == 'Заклинания')
                .description);
      }
      for (final width in [320.0, 380.0, 1100.0]) {
        for (final dark in [false, true]) {
          await tester.binding.setSurfaceSize(Size(width, 900));
          final boundary = GlobalKey();
          await tester.pumpWidget(app(view,
              theme: dark ? darkTheme : lightTheme, boundary: boundary));
          await tester.pumpAndSettle();
          expect(Theme.of(boundary.currentContext!).brightness,
              dark ? Brightness.dark : Brightness.light);
          expect(tester.takeException(), null, reason: normalized.name);
          final items = view.blocks.expand((b) => b.items);
          await openRules(tester, view);
          final item = items.firstWhere((i) => i.name == 'Укус',
              orElse: () => items.first);
          final title = find.descendant(
              of: find.byKey(ValueKey(item.id)),
              matching: find.text(item.name));
          await tester.ensureVisible(title);
          if (find.text(item.description).evaluate().isEmpty) {
            await tester.tap(title);
          }
          await tester.pumpAndSettle();
          expect(find.text(item.description), findsOneWidget,
              reason: normalized.name);
          expect(tester.takeException(), null, reason: normalized.name);
          final screenshots = Platform.environment['CM_DM_SCREENSHOTS'];
          if (screenshots != null && width == 380) {
            final render = boundary.currentContext!.findRenderObject()
                as RenderRepaintBoundary;
            await tester.runAsync(() async {
              final image = await render.toImage(pixelRatio: 1);
              final bytes = await image.toByteData(format: ImageByteFormat.png);
              final name =
                  '${value['origin']}-${examples.indexOf(value)}-${dark ? 'dark' : 'light'}';
              final file = File('$screenshots/$name.png');
              await file.parent.create(recursive: true);
              await file.writeAsBytes(bytes!.buffer.asUint8List());
              image.dispose();
            });
            tester
                .state<ScrollableState>(find.byType(Scrollable).first)
                .position
                .jumpTo(0);
            await tester.pumpAndSettle();
            await tester.runAsync(() async {
              final image = await render.toImage(pixelRatio: 1);
              final bytes = await image.toByteData(format: ImageByteFormat.png);
              final file = File(
                  '$screenshots/${value['origin']}-${examples.indexOf(value)}-${dark ? 'dark' : 'light'}-top.png');
              await file.writeAsBytes(bytes!.buffer.asUint8List());
              image.dispose();
            });
          }
          final controls = <String, DmItemView>{
            for (final block in view.blocks.where((b) => b.items.isNotEmpty))
              block.items.first.id: block.items.first,
            if (normalized.name == 'Взрослый красный дракон')
              for (final i in items.where((i) => {
                    'Укус',
                    'Огненное дыхание',
                    'Легендарные действия',
                    'Легендарная устойчивость',
                    'Логово: Гейзер магмы'
                  }.contains(i.name)))
                i.id: i,
            for (final i in items.where((i) => i.section == DmSection.spells))
              i.id: i,
          };
          for (final example in controls.values) {
            final tile = find.byKey(ValueKey(example.id));
            final title =
                find.descendant(of: tile, matching: find.text(example.name));
            final description = find.descendant(
                of: tile, matching: find.text(example.description));
            if (ruleItems(view).any((i) => i.id == example.id)) {
              expect(title, findsOneWidget);
              if (example.description.isNotEmpty) {
                expect(description, findsOneWidget);
              }
              continue;
            }
            await tester.ensureVisible(title);
            if (description.evaluate().isEmpty) await tester.tap(title);
            await tester.pumpAndSettle();
            if (example.description.isNotEmpty) {
              expect(description, findsOneWidget, reason: normalized.name);
            }
            expect(
                find.descendant(
                    of: tile, matching: find.text('Игровые параметры')),
                findsNothing);
            await tester.ensureVisible(title);
            await tester.tap(title);
            await tester.pumpAndSettle();
            expect(description, findsNothing, reason: normalized.name);
            expect(tester.takeException(), null, reason: normalized.name);
          }
        }
      }
    }
    await tester.binding.setSurfaceSize(null);
  }, skip: auditPath == null);

  testWidgets('Mage and Dragon composition screenshots in both themes',
      (tester) async {
    final audit = jsonDecode(
            (await tester.runAsync(() => File(auditPath!).readAsString()))!)
        as Map<String, dynamic>;
    final fixtures = audit['fixtures'] as List;
    for (final index in [1, 2]) {
      final value = fixtures[index];
      final view = DmStatblock.fromCreature(
          NormalizedCreature.decode(value['normalizedJson']),
          sourceActor: jsonDecode(value['rawJson']));
      final isMage = index == 1;
      final group = view.groups
          .singleWhere((g) => g.id == (isMage ? 'spells' : 'legendary'));
      for (final dark in [false, true]) {
        await tester.binding.setSurfaceSize(Size(780, isMage ? 1500 : 850));
        final boundary = GlobalKey();
        await tester.pumpWidget(app(view,
            theme: dark ? darkTheme : lightTheme,
            boundary: boundary,
            content: SheetOutlineCard(
                child: isMage
                    ? DmMagicGroup(magic: group.magic!)
                    : DmLegendaryGroup(group: group))));
        await tester.pumpAndSettle();
        expect(Theme.of(boundary.currentContext!).brightness,
            dark ? Brightness.dark : Brightness.light);
        expect(
            find.text(isMage ? 'Правила заклинателя' : 'Правила использования'),
            findsOneWidget);
        for (final expanded in [false, true]) {
          if (expanded) {
            final name = isMage ? 'Огненный снаряд' : 'Атака крыльями';
            await tester.tap(find.text(name));
            await tester.pumpAndSettle();
          }
          final render = boundary.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
          final screenshots = Platform.environment['CM_DM_SCREENSHOTS'];
          if (screenshots != null) {
            await tester.runAsync(() async {
              final image = await render.toImage(pixelRatio: 1);
              final bytes = await image.toByteData(format: ImageByteFormat.png);
              final file = File(
                  '$screenshots/${isMage ? 'mage-magic' : 'dragon-legendary'}-${dark ? 'dark' : 'light'}-${expanded ? 'expanded' : 'collapsed'}-780.png');
              await file.parent.create(recursive: true);
              await file.writeAsBytes(bytes!.buffer.asUint8List());
              image.dispose();
            });
          }
          expect(tester.takeException(), null);
        }
      }
    }
    await tester.binding.setSurfaceSize(null);
  }, skip: auditPath == null);
}
