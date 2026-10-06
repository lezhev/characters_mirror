import 'package:characters_mirror_flutter/core/character/choice_group_presentation.dart';
import 'package:flutter/material.dart';
import 'choice_picker.dart';

/// Shared decision row and option rendering; persistence stays with the caller.
class ChoiceDecision extends StatelessWidget {
  const ChoiceDecision(
      {super.key,
      required this.presentation,
      required this.context,
      required this.onChanged,
      this.showTitle = true,
      this.onOpenPicker});
  final ChoiceGroupPresentation presentation;
  final ChoicePresentationContext context;
  final ValueChanged<List<String>> onChanged;
  final bool showTitle;
  final VoidCallback? onOpenPicker;

  @override
  Widget build(BuildContext buildContext) {
    final p = presentation;
    final picker = p.mode == ChoicePresentationMode.picker;
    final header =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (showTitle)
        Text(p.title, style: Theme.of(buildContext).textTheme.titleMedium),
      Text(p.prompt(context),
          style: Theme.of(buildContext).textTheme.bodySmall),
      if (picker || p.selectedKeys.isNotEmpty) Text(p.selectionSummary),
    ]);
    if (picker) {
      return ListTile(
          contentPadding: EdgeInsets.zero,
          title: header,
          trailing: const Icon(Icons.chevron_right),
          onTap: onOpenPicker ??
              () async {
                final result = await Navigator.of(buildContext)
                    .push<List<String>>(MaterialPageRoute(
                        builder: (_) => ChoicePicker(
                                title: p.title,
                                minimum: context ==
                                        ChoicePresentationContext.creation
                                    ? 0
                                    : p.minimum,
                                maximum: p.maximum,
                                allowDuplicates: p.allowDuplicates,
                                selected: p.selectedKeys,
                                options: [
                                  for (final o in p.options)
                                    ChoicePickerOption(
                                        key: o.key,
                                        name: o.name,
                                        description: o.shortDescription,
                                        enabled: o.enabled,
                                        reason: o.reason)
                                ])));
                if (result != null) onChanged(result);
              });
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      header,
      for (final o in p.options)
        ListTile(
            key: ValueKey('choice-card-${o.key}'),
            contentPadding: EdgeInsets.zero,
            title: Text(o.name),
            subtitle: o.shortDescription == null && o.reason == null
                ? null
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        if (o.shortDescription?.isNotEmpty == true)
                          Text(o.shortDescription!),
                        if (o.reason != null) Text(o.reason!),
                      ]),
            leading: p.allowDuplicates
                ? null
                : Icon(o.selected
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked),
            onTap: p.allowDuplicates ||
                    (!o.selected &&
                        (!o.enabled ||
                            (p.maximum != 1 &&
                                p.selectedKeys.length >= p.maximum)))
                ? null
                : () {
                    if (o.selected) {
                      onChanged([...p.selectedKeys]..remove(o.key));
                    } else {
                      onChanged(p.maximum == 1
                          ? [o.key]
                          : [...p.selectedKeys, o.key]);
                    }
                  },
            trailing: !p.allowDuplicates
                ? null
                : Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                        key: ValueKey('choice-decrement-${o.key}'),
                        icon: const Icon(Icons.remove),
                        onPressed: o.count == 0
                            ? null
                            : () =>
                                onChanged([...p.selectedKeys]..remove(o.key))),
                    Text('${o.count}'),
                    IconButton(
                        key: ValueKey('choice-increment-${o.key}'),
                        icon: const Icon(Icons.add),
                        onPressed:
                            !o.enabled || p.selectedKeys.length >= p.maximum
                                ? null
                                : () => onChanged([...p.selectedKeys, o.key])),
                  ])),
      if (p.options.isEmpty)
        const Text('Нет доступных вариантов в данных класса'),
    ]);
  }
}
