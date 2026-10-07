import 'package:characters_mirror_flutter/core/character/choice_group_presentation.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/subclass_decision.dart';
import 'level_up_feature_section.dart';
import 'level_up_asi_decision.dart';
import 'package:flutter/material.dart';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import '../application/level_up_controller.dart';
import '../application/level_up_overview.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_app_bar.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'level_up_hp.dart';
import 'level_up_choice_section.dart';
import 'level_up_spells.dart';
import 'level_up_class_header.dart';

class LevelUpHub extends StatelessWidget {
  const LevelUpHub(
      {super.key,
      required this.state,
      required this.onRoll,
      required this.onAbilityTap,
      required this.onChoice,
      required this.onSubclass,
      required this.onSpells,
      required this.onApply});
  final LevelUpFlowState state;
  final void Function(int?) onRoll;
  final void Function(String, Ability) onAbilityTap;
  final void Function(String, List<String>) onChoice;
  final void Function(int) onSubclass;
  final void Function(CharacterSpellSelectionKind, List<int>, String?) onSpells;
  final VoidCallback onApply;
  @override
  Widget build(BuildContext context) {
    final preview = state.preview!;
    final before = preview.before;
    final after = preview.character;
    final entry = before.classEntries!
        .firstWhere((e) => e.id == state.request.classEntryId);
    final nextEntry = after.classEntries!
        .firstWhere((e) => e.id == state.request.classEntryId);
    final theme = Theme.of(context);
    final newFeatures = newLevelUpFeatures(preview, state.request.classEntryId);
    final linkedGroupKeys = {
      for (final f in newFeatures)
        for (final g in f.choices) g.group!.referenceKey
    };
    final subclassFeatureId = preview.classStep.subclassChoice?.sourceFeatureId;
    final subclassFeatureKey = subclassFeatureId != null &&
            levelUpNeedsSubclass(preview, state.request.classEntryId)
        ? 'class:$subclassFeatureId'
        : null;
    final subclassComposed = subclassFeatureKey != null &&
        newFeatures.any((f) => f.sourceKey == subclassFeatureKey);
    return Scaffold(
      appBar: const PageSizeAppBar(
        title: Text('Повышение уровня'),
        maxWidth: 680,
      ),
      body: AbsorbPointer(
          absorbing: state.busy,
          child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            LevelUpClassHeader(
                                classData: entry.classData,
                                oldLevel: entry.level,
                                newLevel: nextEntry.level),
                            const SizedBox(height: 12),
                            LevelUpHp(
                                die: entry.classData?.hitDieValue ?? 8,
                                roll: state.request.hitDieRoll,
                                constitution: after.derived?.abilityModifiers?[
                                        Ability.constitution] ??
                                    0,
                                oldConstitution: before
                                            .derived?.abilityModifiers?[
                                        Ability.constitution] ??
                                    (((before.derived?.abilityScores?[
                                                        Ability.constitution] ??
                                                    10) -
                                                10) /
                                            2)
                                        .floor(),
                                oldLevel: before.derived?.totalLevel ?? 1,
                                perLevelBonus: before.hpPerLevelBonus ?? 0,
                                oldMax: before.derived?.maxHp ?? 0,
                                newMax: after.derived?.maxHp ?? 0,
                                onRoll: onRoll),
                            const SizedBox(height: 12),
                            if (before.derived?.proficiencyBonus !=
                                after.derived?.proficiencyBonus)
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Text(
                                      'Бонус мастерства ${signedLevelUpValue(before.derived?.proficiencyBonus ?? 2)} → ${signedLevelUpValue(after.derived?.proficiencyBonus ?? 2)}',
                                      style: theme.textTheme.titleSmall)),
                            if (newFeatures.isNotEmpty)
                              LevelUpFeatureSection(
                                  features: newFeatures,
                                  state: state,
                                  onChoice: onChoice,
                                  onAbilityTap: onAbilityTap,
                                  onSubclass: onSubclass,
                                  subclassFeatureKey: subclassFeatureKey),
                            if (levelUpNeedsSubclass(
                                    preview, state.request.classEntryId) &&
                                !subclassComposed)
                              SubclassDecision(
                                  subclasses: preview.classStep.subclassChoice
                                          ?.subclasses ??
                                      [],
                                  selectedId: nextEntry.subclass?.id,
                                  context: ChoicePresentationContext.levelUp,
                                  onChanged: (id) {
                                    if (id != null) onSubclass(id);
                                  }),
                            for (final view in levelUpDecisionGroups(preview))
                              if (!linkedGroupKeys
                                  .contains(view.group!.referenceKey))
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: view.group!.type ==
                                            ChoiceType.abilityIncrease
                                        ? LevelUpAsiDecision(
                                            view: view,
                                            state: state,
                                            onAbilityTap: onAbilityTap,
                                            onChoice: onChoice)
                                        : LevelUpChoiceSection(
                                            view: view,
                                            preview: preview,
                                            selected: state.request.choices?[
                                                    view.group!.referenceKey] ??
                                                [],
                                            onChanged: (keys) => onChoice(
                                                view.group!.referenceKey,
                                                keys))),
                            LevelUpSpells(
                                preview: preview,
                                request: state.request,
                                onChanged: onSpells),
                            if (state.error != null)
                              Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text(humanReadableError(state.error!),
                                      style: TextStyle(
                                          color: theme.colorScheme.error))),
                          ]))))),
      bottomNavigationBar: SafeArea(
        child: PageSizeLimiter(
          maxWidth: 680,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: FilledButton(
              key: const ValueKey('level-up-apply'),
              onPressed: state.canApply ? onApply : null,
              child: Text(
                'Повысить до ${after.derived?.totalLevel ?? nextEntry.level} уровня',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
