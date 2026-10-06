import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/choice_group_presentation.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_app_bar.dart';
import 'package:flutter/material.dart';
import '../application/level_up_controller.dart';
import '../application/level_up_choices.dart';
import 'level_up_asi.dart';
import 'level_up_choice_section.dart';

class LevelUpAsiDecision extends StatelessWidget {
  const LevelUpAsiDecision(
      {super.key,
      required this.view,
      required this.state,
      required this.onAbilityTap,
      required this.onChoice});
  final ChoiceGroupView view;
  final LevelUpFlowState state;
  final void Function(String, Ability) onAbilityTap;
  final void Function(String, List<String>) onChoice;
  @override
  Widget build(BuildContext context) {
    final preview = state.preview!;
    final before = preview.before;
    final presentation = ChoiceGroupPresentation.fromView(
        view, state.request.choices?[view.group!.referenceKey] ?? []);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(presentation.prompt(ChoicePresentationContext.levelUp)),
      LevelUpAsi(
          scores: before.derived?.abilityScores ?? {},
          allocation: state.asi[view.group!.referenceKey] ?? {},
          catalogSupportsAllocation:
              asiOptionKeys(view, state.asi[view.group!.referenceKey] ?? {}) !=
                  null,
          onTap: (a) => onAbilityTap(view.group!.referenceKey, a),
          onFeat: () async {
            final feats = preview.choiceGroups
                .where((g) =>
                    g.group!.type == ChoiceType.feat &&
                    g.group!.exclusiveKey != null &&
                    g.group!.exclusiveKey == view.group!.exclusiveKey)
                .toList();
            if (feats.isEmpty) {
              await Navigator.of(context).push<void>(MaterialPageRoute(
                  builder: (_) => Scaffold(
                      appBar: const PageSizeAppBar(
                        title: Text('Черты'),
                      ),
                      body: const SafeArea(
                          child: Center(
                              child: Text(
                                  'Нет доступных черт для этого класса'))))));
              return;
            }
            final feat = feats.first;
            final keys = await openLevelUpChoice(context, feat, preview,
                state.request.choices?[feat.group!.referenceKey] ?? []);
            if (keys != null) {
              onChoice(feat.group!.referenceKey, keys);
            }
          }),
      for (final feat in preview.choiceGroups.where((g) =>
          g.group!.type == ChoiceType.feat &&
          g.group!.exclusiveKey != null &&
          g.group!.exclusiveKey == view.group!.exclusiveKey))
        if (state.request.choices?[feat.group!.referenceKey]?.isNotEmpty ==
            true)
          Text(
              'Черта: ${feat.options?.where((o) => state.request.choices![feat.group!.referenceKey]!.contains(o.optionKey)).map((o) => o.name ?? o.optionKey).join(', ')}'),
    ]);
  }
}
