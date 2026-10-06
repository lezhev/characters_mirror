import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/choice_group_presentation.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/choice_decision.dart';
import 'package:flutter/material.dart';
import '../application/level_up_choices.dart';
import '../application/level_up_overview.dart';
import 'level_up_picker.dart';

Future<List<String>?> openLevelUpChoice(BuildContext context,
    ChoiceGroupView view, LevelUpPreview preview, List<String> selected) {
  final p = ChoiceGroupPresentation.fromView(
      eligibleLevelUpGroup(view, preview), selected);
  return Navigator.of(context).push<List<String>>(MaterialPageRoute(
      builder: (_) => LevelUpPicker(
            title: p.title,
            maximum: p.maximum,
            minimum: p.minimum,
            allowDuplicates: p.allowDuplicates,
            selected: p.selectedKeys,
            options: [
              for (final o in p.options)
                LevelUpPickerOption(
                    key: o.key,
                    name: o.name,
                    description: o.shortDescription,
                    enabled: o.enabled,
                    reason: o.reason)
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
  final ValueChanged<List<String>> onChanged;
  final LevelUpChoicePresentation? presentation;
  final bool showTitle;
  @override
  Widget build(BuildContext context) => ChoiceDecision(
      presentation: ChoiceGroupPresentation.fromView(
          eligibleLevelUpGroup(view, preview), selected,
          mode: presentation == null
              ? null
              : presentation == LevelUpChoicePresentation.picker
                  ? ChoicePresentationMode.picker
                  : ChoicePresentationMode.inline),
      context: ChoicePresentationContext.levelUp,
      onChanged: onChanged,
      showTitle: showTitle);
}
