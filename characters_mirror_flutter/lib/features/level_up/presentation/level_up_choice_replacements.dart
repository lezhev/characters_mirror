import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/choice_picker.dart';
import 'package:flutter/material.dart';
import '../application/level_up_overview.dart';

class LevelUpChoiceReplacements extends StatelessWidget {
  const LevelUpChoiceReplacements(
      {super.key,
      required this.preview,
      required this.request,
      required this.onChanged,
      required this.onClear});
  final LevelUpPreview preview;
  final LevelUpRequest request;
  final ValueChanged<LevelUpChoiceReplacementData> onChanged;
  final ValueChanged<String> onClear;

  @override
  Widget build(BuildContext context) => Column(children: [
        for (final view in preview.choiceGroups)
          if ((view.group?.replacementsAllowed ?? 0) > 0 &&
              eligibleLevelUpGroup(view, preview).group != null)
            _row(context, view)
      ]);

  Widget _row(BuildContext context, ChoiceGroupView view) {
    final group = view.group!;
    final previousGroups = {
      for (final v in preview.classStep.choiceGroups ?? <ChoiceGroupView>[])
        if ((group.replacementProgressionKeys ??
                [if (group.progressionKey != null) group.progressionKey!])
            .contains(v.group?.progressionKey))
          v.group!.referenceKey: v
    };
    final previous = (preview.before.choices ?? <CharacterChoiceData>[])
        .where((c) =>
            (c.classEntry?.id == request.classEntryId ||
                c.classEntry == null) &&
            c.id != null &&
            previousGroups.containsKey(c.groupKey))
        .toList();
    if (previous.isEmpty) return const SizedBox.shrink();
    final selected =
        (request.choiceReplacements ?? <LevelUpChoiceReplacementData>[])
            .where((r) => r.groupKey == group.referenceKey)
            .toList();
    return Column(children: [
      ListTile(
          title: Text('Заменить · ${group.name ?? group.referenceKey}'),
          subtitle: Text('Необязательно · до ${group.replacementsAllowed}'),
          trailing: const Icon(Icons.chevron_right),
          onTap: selected.length >= group.replacementsAllowed!
              ? null
              : () async {
                  final old = await _pick(context, 'Что заменить', [
                    for (final c in previous)
                      if (!selected.any((r) => r.selectionId == c.id))
                        ChoicePickerOption(
                            key: c.id!,
                            name: previousGroups[c.groupKey]
                                    ?.options
                                    ?.where((o) => o.optionKey == c.optionKey)
                                    .firstOrNull
                                    ?.name ??
                                c.optionKey!)
                  ]);
                  if (old == null || old.isEmpty || !context.mounted) return;
                  final choice = previous.firstWhere((c) => c.id == old.single);
                  final owned = {
                    for (final c
                        in preview.character.choices ?? <CharacterChoiceData>[])
                      if ((c.classEntry?.id == request.classEntryId ||
                              c.classEntry == null) &&
                          previousGroups.containsKey(c.groupKey))
                        c.optionKey
                  };
                  final eligibility =
                      eligibleLevelUpGroup(view, preview).optionEligibility ??
                          [];
                  final options = (view.options ?? <ChoiceOptionData>[]).where(
                      (o) =>
                          !owned.contains(o.optionKey) &&
                          eligibility
                                  .where((e) => e.optionKey == o.optionKey)
                                  .firstOrNull
                                  ?.isEligible !=
                              false);
                  final next =
                      await _pick(context, group.name ?? group.referenceKey, [
                    for (final o in options)
                      ChoicePickerOption(
                          key: o.optionKey,
                          name: o.name ?? o.optionKey,
                          description: o.shortDescription)
                  ]);
                  if (next?.isNotEmpty == true) {
                    onChanged(LevelUpChoiceReplacementData(
                        groupKey: group.referenceKey,
                        selectionId: choice.id!,
                        optionKey: next!.single));
                  }
                }),
      for (final row in selected)
        ListTile(
            title: Text(row.optionKey),
            trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => onClear(row.selectionId)))
    ]);
  }

  Future<List<String>?> _pick(BuildContext context, String title,
          List<ChoicePickerOption> options) =>
      Navigator.of(context).push<List<String>>(MaterialPageRoute(
          builder: (_) => ChoicePicker(
              title: title, options: options, maximum: 1, minimum: 1)));
}
