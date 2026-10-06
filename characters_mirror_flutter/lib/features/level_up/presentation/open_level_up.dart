import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'level_experience_sheet.dart';
import 'level_up_page.dart';
import 'level_up_picker.dart';

Future<void> openLevelExperience(BuildContext context, WidgetRef ref,
    int characterId, CharacterData character) async {
  final advance = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => LevelExperienceSheet(
          character: character,
          onLevelUp: () => Navigator.of(sheetContext).pop(true)));
  if (advance != true || !context.mounted) return;
  final controller =
      ref.read(characterSheetControllerProvider(characterId).notifier);
  try {
    final base = await controller.prepareLevelUp();
    if (!context.mounted) return;
    final entries = base.classEntries ?? const <CharacterClassEntryData>[];
    if (entries.isEmpty) throw StateError('У персонажа не выбран класс.');
    var entry = entries.first;
    if (entries.length > 1) {
      final selected =
          await Navigator.of(context).push<List<String>>(MaterialPageRoute(
              builder: (_) => LevelUpPicker(
                    title: 'Какой класс повысить',
                    maximum: 1,
                    minimum: 1,
                    options: [
                      for (final e in entries)
                        if (e.id != null)
                          LevelUpPickerOption(
                              key: e.id!,
                              name:
                                  '${e.classData?.name ?? 'Класс'} · ${e.level} уровень')
                    ],
                  )));
      if (selected == null || selected.isEmpty || !context.mounted) return;
      entry = entries.firstWhere((e) => e.id == selected.single);
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
