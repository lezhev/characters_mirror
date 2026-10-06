import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/choice_group_presentation.dart';
import 'package:characters_mirror_flutter/core/ui/language_labels.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/choice_decision.dart';
import 'package:flutter/material.dart';

class CreationChoiceGroupCard extends StatelessWidget {
  const CreationChoiceGroupCard(
      {required this.groupView,
      required this.selectedOptions,
      required this.onToggleOption,
      required this.onIncrementOption,
      required this.onDecrementOption,
      required this.onClearGroup,
      this.showTitle = true,
      super.key});
  final ChoiceGroupView groupView;
  final List<ChoiceOptionData> selectedOptions;
  final void Function(ChoiceGroupData, ChoiceOptionData) onToggleOption;
  final void Function(ChoiceGroupData, ChoiceOptionData) onIncrementOption;
  final void Function(ChoiceGroupData, ChoiceOptionData) onDecrementOption;
  final void Function(ChoiceGroupData) onClearGroup;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    final group = groupView.group;
    if (group == null) return const SizedBox.shrink();
    final options = [
      for (final o in groupView.options ?? const <ChoiceOptionData>[])
        group.type == ChoiceType.language && o.grantedLanguages?.length == 1
            ? o.copyWith(name: languageLabel(o.grantedLanguages!.single))
            : o
    ];
    return ChoiceDecision(
        presentation: ChoiceGroupPresentation.fromView(
            groupView.copyWith(options: options),
            [for (final o in selectedOptions) o.optionKey]),
        context: ChoicePresentationContext.creation,
        showTitle: showTitle,
        onChanged: (keys) {
          if (keys.isEmpty) {
            onClearGroup(group);
            return;
          }
          final old = [for (final o in selectedOptions) o.optionKey];
          // Preserve existing persistence operations, including duplicate counts.
          for (final o in options) {
            final delta = old.where((key) => key == o.optionKey).length -
                keys.where((key) => key == o.optionKey).length;
            if (delta > 0 &&
                ((group.selectionCount ?? 1) != 1 ||
                    group.allowDuplicates == true)) {
              if (group.allowDuplicates == true) {
                for (var i = 0; i < delta; i++) {
                  onDecrementOption(group, o);
                }
              } else {
                onToggleOption(group, o);
              }
            }
          }
          for (final o in options) {
            final delta = keys.where((key) => key == o.optionKey).length -
                old.where((key) => key == o.optionKey).length;
            if (delta > 0) {
              if (group.allowDuplicates == true) {
                for (var i = 0; i < delta; i++) {
                  onIncrementOption(group, o);
                }
              } else {
                onToggleOption(group, o);
              }
            }
          }
        });
  }
}
