import 'dart:io';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/application/statblock/dm_statblock.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/presentation/widgets/dm_statblock_item.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/presentation/widgets/dm_statblock_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Widget app(DmStatblock view,
        {ThemeData? theme,
        Widget? technical,
        Key? boundary,
        Widget? content}) =>
    MaterialApp(
        theme: _auditFontLoaded
            ? (theme ?? lightTheme).copyWith(
                textTheme: (theme ?? lightTheme)
                    .textTheme
                    .apply(fontFamily: 'DmAuditFont'))
            : theme ?? lightTheme,
        home: PageStorage(
            bucket: PageStorageBucket(),
            child: RepaintBoundary(
                key: boundary,
                child: Scaffold(
                    body: SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(children: [
                              content ?? DmStatblockView(statblock: view),
                              if (technical != null) technical,
                            ])))))));

bool _auditFontLoaded = false;

List<DmItemView> ruleItems(DmStatblock view) => [
      for (final group in view.groups)
        if (group.id == 'legendary') ...group.legendary!.rules,
      for (final group in view.groups) ...?group.magic?.rules,
    ];

Future<void> openRules(WidgetTester tester, DmStatblock view) async {
  final rules = ruleItems(view);
  for (final title in ['Правила использования', 'Правила заклинателя']) {
    final toggle = find.text(title);
    if (toggle.evaluate().isEmpty) continue;
    final parent =
        find.ancestor(of: toggle, matching: find.byType(DmStatblockItem)).first;
    if (!(tester.widget<DmStatblockItem>(parent).item.id == 'legendary-rules'
            ? rules.where((i) =>
                i.section == DmSection.legendary ||
                i.section == DmSection.legendaryResistance)
            : rules.where((i) =>
                i.section != DmSection.legendary &&
                i.section != DmSection.legendaryResistance))
        .any((i) => find.byKey(ValueKey(i.id)).evaluate().isNotEmpty)) {
      await tester.ensureVisible(toggle);
      await tester.tap(toggle);
      await tester.pumpAndSettle();
    }
  }
}

Future<void> loadDmAuditFonts() async {
  if (Platform.environment['CM_DM_SCREENSHOTS'] == null) return;
  final font = File(
      Platform.environment['CM_DM_AUDIT_FONT'] ?? 'C:/Windows/Fonts/arial.ttf');
  if (!await font.exists()) return;
  final loader = FontLoader('DmAuditFont')
    ..addFont(Future.value(ByteData.sublistView(await font.readAsBytes())));
  await loader.load();
  final icons = FontLoader('MaterialIcons')
    ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
  await icons.load();
  _auditFontLoaded = true;
}
