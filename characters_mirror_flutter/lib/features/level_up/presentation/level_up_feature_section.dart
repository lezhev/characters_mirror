import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/choice_group_presentation.dart';
import 'package:characters_mirror_flutter/core/character/feature_presentation.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/feature_summary.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/subclass_decision.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import 'package:flutter/material.dart';
import '../application/level_up_controller.dart';
import 'level_up_asi_decision.dart';
import 'level_up_choice_section.dart';

class LevelUpFeatureSection extends StatelessWidget {
  const LevelUpFeatureSection(
      {super.key,
      required this.features,
      required this.state,
      required this.onChoice,
      required this.onAbilityTap,
      required this.onSubclass,
      this.subclassFeatureKey});
  final List<FeaturePresentation> features;
  final LevelUpFlowState state;
  final void Function(String, List<String>) onChoice;
  final void Function(String, Ability) onAbilityTap;
  final ValueChanged<int> onSubclass;
  final String? subclassFeatureKey;
  @override
  Widget build(BuildContext context) {
    final preview = state.preview!;
    final entry = preview.character.classEntries!
        .firstWhere((e) => e.id == state.request.classEntryId);
    return SheetOutlineCard(
        key: const ValueKey('level-up-features'),
        padding: EdgeInsets.zero,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          for (var i = 0; i < features.length; i++) ...[
            if (i > 0) const Divider(height: 1),
            Padding(
                key: ValueKey('level-up-feature-${features[i].sourceKey}'),
                padding: const EdgeInsets.all(16),
                child: FeatureSummary(
                    name: features[i].name,
                    shortDescription: features[i].shortDescription,
                    properties: features[i].displayProperties,
                    resources: features[i].resources,
                    children: [
                      for (final view in features[i].choices)
                        Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child:
                                view.group!.type == ChoiceType.abilityIncrease
                                    ? LevelUpAsiDecision(
                                        view: view,
                                        state: state,
                                        onAbilityTap: onAbilityTap,
                                        onChoice: onChoice)
                                    : LevelUpChoiceSection(
                                        view: view,
                                        preview: preview,
                                        showTitle: showChoiceGroupTitle(
                                            features[i].name, view.group!.name,
                                            type: view.group!.type,
                                            linkedGroupCount:
                                                features[i].choices.length),
                                        selected: state.request.choices?[
                                                view.group!.referenceKey] ??
                                            [],
                                        onChanged: (keys) => onChoice(
                                            view.group!.referenceKey, keys))),
                      if (features[i].sourceKey != null &&
                          features[i].sourceKey == subclassFeatureKey)
                        SubclassDecision(
                            subclasses:
                                preview.classStep.subclassChoice?.subclasses ??
                                    [],
                            selectedId: entry.subclass?.id,
                            context: ChoicePresentationContext.levelUp,
                            onChanged: (id) {
                              if (id != null) onSubclass(id);
                            }),
                    ])),
          ],
        ]));
  }
}
