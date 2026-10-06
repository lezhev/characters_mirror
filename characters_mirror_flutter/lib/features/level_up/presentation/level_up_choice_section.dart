import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';
import '../application/level_up_choices.dart';
import '../application/level_up_overview.dart';
import 'level_up_picker.dart';

Future<List<String>?> openLevelUpChoice(BuildContext context,
    ChoiceGroupView view, LevelUpPreview preview, List<String> selected) {
  final eligible = eligibleLevelUpGroup(view, preview);
  return Navigator.of(context).push<List<String>>(MaterialPageRoute(
      builder: (_) => LevelUpPicker(
            title: view.group!.name ?? 'Выбор',
            maximum: view.group!.selectionCount ?? 1,
            minimum: view.group!.minimumSelectionCount ??
                view.group!.selectionCount ??
                1,
            allowDuplicates: view.group!.allowDuplicates == true,
            selected: selected,
            options: [
              for (final o in view.options ?? const <ChoiceOptionData>[])
                () {
                  final e = eligible.optionEligibility
                      ?.where((e) => e.optionKey == o.optionKey)
                      .firstOrNull;
                  return LevelUpPickerOption(
                      key: o.optionKey,
                      name: o.name ?? o.optionKey,
                      description: o.description,
                      enabled: e?.isEligible != false,
                      reason: e?.isEligible == false
                          ? 'Требования не выполнены'
                          : null);
                }()
            ],
          )));
}

class LevelUpChoiceSection extends StatelessWidget {
  const LevelUpChoiceSection(
      {super.key,
      required this.view,
      required this.preview,
      required this.selected,
      required this.onChanged,
      this.presentation,
      this.showTitle = true});
  final ChoiceGroupView view;
  final LevelUpPreview preview;
  final List<String> selected;
  final void Function(List<String>) onChanged;
  final LevelUpChoicePresentation? presentation;
  final bool showTitle;
  @override
  Widget build(BuildContext context) {
    final group = view.group!;
    final options = view.options ?? const <ChoiceOptionData>[];
    final eligible = eligibleLevelUpGroup(view, preview);
    final limit = group.selectionCount ?? 1;
    final names = selected
        .map((key) =>
            options.where((o) => o.optionKey == key).firstOrNull?.name ?? key)
        .join(', ');
    if (choicePresentation(view, override: presentation) ==
        LevelUpChoicePresentation.picker) {
      return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(showTitle
              ? group.name ?? 'Выбор'
              : selected.isEmpty
                  ? 'Выбрать $limit'
                  : names),
          subtitle: showTitle
              ? Text(selected.isEmpty ? 'Выбрать $limit' : names)
              : null,
          trailing: const Icon(Icons.chevron_right),
          onTap: () async {
            final result =
                await openLevelUpChoice(context, view, preview, selected);
            if (result != null) onChanged(result);
          });
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (showTitle)
        Text(group.name ?? 'Выбор',
            style: Theme.of(context).textTheme.titleMedium),
      if (limit > 1) Text('Выбрано ${selected.length} / $limit'),
      Wrap(spacing: 8, runSpacing: 4, children: [
        for (final option in options)
          Builder(builder: (_) {
            final e = eligible.optionEligibility
                ?.where((e) => e.optionKey == option.optionKey)
                .firstOrNull;
            final count =
                selected.where((key) => key == option.optionKey).length;
            if (group.allowDuplicates == true) {
              return Row(mainAxisSize: MainAxisSize.min, children: [
                Text(option.name ?? option.optionKey),
                IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: count == 0
                        ? null
                        : () {
                            final next = [...selected]
                              ..remove(option.optionKey);
                            onChanged(next);
                          }),
                Text('$count'),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed:
                        selected.length >= limit || e?.isEligible == false
                            ? null
                            : () => onChanged([...selected, option.optionKey])),
              ]);
            }
            return FilterChip(
                label: Text(option.name ?? option.optionKey),
                selected: count > 0,
                tooltip: e?.isEligible == false
                    ? 'Требования не выполнены'
                    : option.description,
                onSelected: e?.isEligible == false
                    ? null
                    : (picked) {
                        if (!picked) {
                          onChanged([...selected]..remove(option.optionKey));
                        } else if (limit == 1) {
                          onChanged([option.optionKey]);
                        } else if (selected.length < limit) {
                          onChanged([...selected, option.optionKey]);
                        }
                      });
          })
      ]),
      if (options.isEmpty)
        const Text('Нет доступных вариантов в данных класса'),
    ]);
  }
}
