import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'level_experience_sheet.dart';
import 'level_down_page.dart';
import 'level_up_page.dart';
import 'level_up_picker.dart';

enum _LevelExperienceAction { levelUp, levelDown }

Future<void> openLevelExperience(BuildContext context, WidgetRef ref,
    int characterId, CharacterData character) async {
  final action = await showModalBottomSheet<_LevelExperienceAction>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => LevelExperienceSheet(
          character: character,
          onLevelUp: () =>
              Navigator.of(sheetContext).pop(_LevelExperienceAction.levelUp),
          onLevelDown: () => Navigator.of(sheetContext)
              .pop(_LevelExperienceAction.levelDown)));
  if (action == null || !context.mounted) return;
  final controller =
      ref.read(characterSheetControllerProvider(characterId).notifier);
  try {
    final goingDown = action == _LevelExperienceAction.levelDown;
    final base = goingDown
        ? await controller.prepareLevelDown()
        : await controller.prepareLevelUp();
    if (!context.mounted) return;
    final entries = base.classEntries ?? const <CharacterClassEntryData>[];
    if (entries.isEmpty) throw StateError('У персонажа не выбран класс.');
    final eligibleEntries = entries
        .where((entry) =>
            entry.id != null && (!goingDown || (entry.level ?? 0) > 1))
        .toList();
    if (eligibleEntries.isEmpty) {
      if (goingDown) throw StateError('Нет классов выше 1-го уровня.');
      throw StateError('У персонажа не выбран класс.');
    }
    final entry = await _selectClassEntry(
      context,
      eligibleEntries,
      title: goingDown ? 'Какой класс понизить' : 'Какой класс повысить',
    );
    if (entry == null || !context.mounted) return;
    if (goingDown) {
      final saved = await Navigator.of(context).push<CharacterData>(
          MaterialPageRoute(
              builder: (_) => LevelDownPage(
                  request: LevelDownRequest(
                      characterId: base.id!,
                      expectedVersion: base.version!,
                      classEntryId: entry.id!))));
      if (saved != null && context.mounted) controller.acceptLevelDown(saved);
      return;
    }
    final saved = await Navigator.of(context).push<CharacterData>(
        MaterialPageRoute(
            builder: (_) => LevelUpPage(
                request: LevelUpRequest(
                    characterId: base.id!,
                    expectedVersion: base.version!,
                    classEntryId: entry.id!,
                    hitDieRoll:
                        (entry.classData?.hitDieValue ?? 8) ~/ 2 + 1))));
    if (saved != null && context.mounted) controller.acceptLevelUp(saved);
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(humanReadableError(error))));
    }
  }
}

Future<CharacterClassEntryData?> _selectClassEntry(
  BuildContext context,
  List<CharacterClassEntryData> entries, {
  required String title,
}) async {
  if (entries.length == 1) return entries.single;
  final selected =
      await Navigator.of(context).push<List<String>>(MaterialPageRoute(
          builder: (_) => LevelUpPicker(
                title: title,
                maximum: 1,
                minimum: 1,
                options: [
                  for (final entry in entries)
                    LevelUpPickerOption(
                        key: entry.id!,
                        name:
                            '${entry.classData?.name ?? 'Класс'} · ${entry.level} уровень')
                ],
              )));
  if (selected == null || selected.isEmpty) return null;
  return entries.firstWhere((entry) => entry.id == selected.single);
}
