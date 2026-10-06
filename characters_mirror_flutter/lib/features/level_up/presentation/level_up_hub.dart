import 'package:flutter/material.dart';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import '../application/level_up_controller.dart';
import '../application/level_up_choices.dart';
import '../application/level_up_overview.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_app_bar.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import 'level_up_hp.dart';
import 'level_up_asi.dart';
import 'level_up_picker.dart';
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
    final featAlternatives = {
      for (final g in preview.choiceGroups)
        if (g.group!.type == ChoiceType.abilityIncrease &&
            g.group!.exclusiveKey != null)
          g.group!.exclusiveKey
    };
    final subclassLevel = preview.classStep.subclassChoice?.requiredLevel;
    final newFeatures = newLevelUpFeatures(preview, state.request.classEntryId);
    final featureData = <String, ({String name, String? description})>{};
    for (final feature in preview.classStep.currentLevelFeatures ??
        const <ClassFeatureData>[]) {
      final id = feature.id;
      if (id == null) continue;
      featureData['class:$id'] = (
        name: feature.name ?? 'Новая возможность',
        description: feature.shortDescription ?? feature.description,
      );
    }
    for (final feature in preview.classStep.currentSubclassFeatures ??
        const <SubclassFeatureData>[]) {
      final id = feature.id;
      if (id == null) continue;
      featureData['subclass:$id'] = (
        name: feature.name ?? 'Новая возможность подкласса',
        description: feature.shortDescription ?? feature.description,
      );
    }
    final linkedGroupsByFeature = <String, List<ChoiceGroupView>>{};
    final linkedFeatureKeyByGroup = <String, String>{};
    for (final view in preview.choiceGroups) {
      final group = view.group;
      if (group == null || group.type == ChoiceType.abilityIncrease) continue;
      final featureKey = _levelUpFeatureSourceKey(group);
      if (featureKey == null || !featureData.containsKey(featureKey)) continue;
      linkedGroupsByFeature.putIfAbsent(featureKey, () => []).add(view);
      linkedFeatureKeyByGroup[group.referenceKey] = featureKey;
    }
    final renderedLinkedFeatures = <String>{};
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
                            for (final level in newSpellLevels(preview))
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                      'Доступны заклинания $level уровня',
                                      style: theme.textTheme.titleSmall)),
                            if (entry.subclass == null &&
                                subclassLevel != null &&
                                subclassLevel > (entry.level ?? 0) &&
                                subclassLevel <= (nextEntry.level ?? 1))
                              ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: const Text('Подкласс'),
                                  subtitle: Text(
                                      nextEntry.subclass?.name ?? 'Выбрать'),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () async {
                                    final result = await Navigator.of(context)
                                        .push<List<String>>(MaterialPageRoute(
                                            builder: (_) => LevelUpPicker(
                                                  title: 'Подкласс',
                                                  maximum: 1,
                                                  minimum: 1,
                                                  selected:
                                                      nextEntry.subclass?.id ==
                                                              null
                                                          ? []
                                                          : [
                                                              '${nextEntry.subclass!.id}'
                                                            ],
                                                  options: [
                                                    for (final s in preview
                                                            .classStep
                                                            .subclassChoice
                                                            ?.subclasses ??
                                                        const <SubclassData>[])
                                                      if (s.id != null &&
                                                          (s.levelRequired ??
                                                                  subclassLevel) <=
                                                              (nextEntry
                                                                      .level ??
                                                                  1))
                                                        LevelUpPickerOption(
                                                            key: '${s.id}',
                                                            name: s.name ??
                                                                s
                                                                    .subclassName ??
                                                                'Подкласс',
                                                            description:
                                                                s.description)
                                                  ],
                                                )));
                                    if (result != null && result.isNotEmpty) {
                                      onSubclass(int.parse(result.single));
                                    }
                                  }),
                            for (final view in preview.choiceGroups)
                              if (view.group!.type ==
                                  ChoiceType.abilityIncrease)
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          LevelUpAsi(
                                              scores: before
                                                      .derived?.abilityScores ??
                                                  {},
                                              allocation: state.asi[view
                                                      .group!.referenceKey] ??
                                                  {},
                                              catalogSupportsAllocation:
                                                  asiOptionKeys(
                                                          view,
                                                          state.asi[view.group!
                                                                  .referenceKey] ??
                                                              {}) !=
                                                      null,
                                              onTap: (a) => onAbilityTap(
                                                  view.group!.referenceKey, a),
                                              onFeat: () async {
                                                final feats = preview
                                                    .choiceGroups
                                                    .where((g) =>
                                                        g.group!.type ==
                                                            ChoiceType.feat &&
                                                        g.group!.exclusiveKey !=
                                                            null &&
                                                        g.group!.exclusiveKey ==
                                                            view.group!
                                                                .exclusiveKey)
                                                    .toList();
                                                if (feats.isEmpty) {
                                                  await Navigator.of(context).push<void>(
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              Scaffold(
                                                                  appBar:
                                                                      const PageSizeAppBar(
                                                                    title: Text(
                                                                        'Черты'),
                                                                  ),
                                                                  body: const SafeArea(
                                                                      child: Center(
                                                                          child:
                                                                              Text('Нет доступных черт для этого класса'))))));
                                                  return;
                                                }
                                                final feat = feats.first;
                                                final keys =
                                                    await openLevelUpChoice(
                                                        context,
                                                        feat,
                                                        preview,
                                                        state.request.choices?[feat
                                                                .group!
                                                                .referenceKey] ??
                                                            []);
                                                if (keys != null) {
                                                  onChoice(
                                                      feat.group!.referenceKey,
                                                      keys);
                                                }
                                              }),
                                          for (final feat in preview
                                              .choiceGroups
                                              .where((g) =>
                                                  g.group!.type ==
                                                      ChoiceType.feat &&
                                                  g.group!.exclusiveKey !=
                                                      null &&
                                                  g.group!.exclusiveKey ==
                                                      view.group!.exclusiveKey))
                                            if (state
                                                    .request
                                                    .choices?[feat
                                                        .group!.referenceKey]
                                                    ?.isNotEmpty ==
                                                true)
                                              Text(
                                                  'Черта: ${feat.options?.where((o) => state.request.choices![feat.group!.referenceKey]!.contains(o.optionKey)).map((o) => o.name ?? o.optionKey).join(', ')}'),
                                        ]))
                              else if (linkedFeatureKeyByGroup.containsKey(view.group!.referenceKey) &&
                                  renderedLinkedFeatures.add(linkedFeatureKeyByGroup[
                                      view.group!.referenceKey]!))
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: _LevelUpFeatureChoiceCard(
                                        key: ValueKey(
                                            'level-up-feature-${linkedFeatureKeyByGroup[view.group!.referenceKey]}'),
                                        feature: featureData[linkedFeatureKeyByGroup[
                                            view.group!.referenceKey]!]!,
                                        groups: linkedGroupsByFeature[linkedFeatureKeyByGroup[
                                            view.group!.referenceKey]!]!,
                                        preview: preview,
                                        request: state.request,
                                        onChoice: onChoice))
                              else if (!linkedFeatureKeyByGroup
                                      .containsKey(view.group!.referenceKey) &&
                                  !(view.group!.type == ChoiceType.feat &&
                                      featAlternatives.contains(view.group!.exclusiveKey)))
                                Padding(padding: const EdgeInsets.only(bottom: 12), child: LevelUpChoiceSection(view: view, preview: preview, selected: state.request.choices?[view.group!.referenceKey] ?? [], onChanged: (keys) => onChoice(view.group!.referenceKey, keys))),
                            LevelUpSpells(
                                preview: preview,
                                request: state.request,
                                onChanged: onSpells),
                            for (final feature in newFeatures)
                              if (feature.sourceKey == null ||
                                  !renderedLinkedFeatures
                                      .contains(feature.sourceKey))
                                Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: SheetOutlineCard(
                                        padding: EdgeInsets.zero,
                                        child: ExpansionTile(
                                            title: Text(feature.name),
                                            childrenPadding:
                                                const EdgeInsets.fromLTRB(
                                                    16, 0, 16, 12),
                                            children: [
                                              if (feature.description != null)
                                                Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        feature.description!))
                                            ]))),
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

String? _levelUpFeatureSourceKey(ChoiceGroupData group) {
  final classFeatureId = group.sourceFeatureId;
  if (classFeatureId != null) return 'class:$classFeatureId';
  final subclassFeatureId = group.sourceSubclassFeatureId;
  if (subclassFeatureId != null) return 'subclass:$subclassFeatureId';
  return null;
}

class _LevelUpFeatureChoiceCard extends StatelessWidget {
  const _LevelUpFeatureChoiceCard({
    super.key,
    required this.feature,
    required this.groups,
    required this.preview,
    required this.request,
    required this.onChoice,
  });

  final ({String name, String? description}) feature;
  final List<ChoiceGroupView> groups;
  final LevelUpPreview preview;
  final LevelUpRequest request;
  final void Function(String, List<String>) onChoice;

  @override
  Widget build(BuildContext context) {
    final description = feature.description?.trim();
    return SheetOutlineCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (description == null || description.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
              child: Text(
                feature.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          else
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(feature.name),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(description),
                ),
              ],
            ),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < groups.length; i++) ...[
                  if (i > 0) const Divider(height: 16),
                  LevelUpChoiceSection(
                    view: groups[i],
                    preview: preview,
                    selected:
                        request.choices?[groups[i].group!.referenceKey] ?? [],
                    showTitle: groups.length > 1 &&
                        groups[i].group!.name?.trim().toLowerCase() !=
                            feature.name.trim().toLowerCase(),
                    onChanged: (keys) =>
                        onChoice(groups[i].group!.referenceKey, keys),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
