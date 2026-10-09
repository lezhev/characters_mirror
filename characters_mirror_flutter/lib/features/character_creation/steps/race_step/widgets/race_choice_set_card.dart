import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/language_labels.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_selector.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RaceChoiceSetCard extends ConsumerWidget {
  const RaceChoiceSetCard({
    required this.groupView,
    required this.selectedOptions,
    super.key,
  });

  final ChoiceGroupView groupView;
  final List<ChoiceOptionData> selectedOptions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = groupView.group;
    if (group == null) return const SizedBox.shrink();
    final options = [...?groupView.options]..sort(compareChoiceOptions);
    if (options.isEmpty) return const SizedBox.shrink();

    final selectedKeys = {
      for (final option in selectedOptions) option.optionKey,
    };
    if (group.type == ChoiceType.abilityIncrease) {
      final colorScheme = Theme.of(context).colorScheme;
      final textTheme = Theme.of(context).textTheme;
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(group.name ?? 'Бонусы к характеристикам',
                style: textTheme.titleSmall),
            if ((group.description ?? '').trim().isNotEmpty) ...[
              const Gap(6),
              Text(group.description!, style: textTheme.bodyMedium),
            ],
            const Gap(8),
            Text(
              'Этот выбор применяется на шаге характеристик.',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    final items = options.map((option) {
      final title = choiceOptionLabel(option);
      return CreationChoiceSelectorItem(
        id: option.optionKey,
        title: title,
        subtitle: option.description,
        isSelected: selectedKeys.contains(option.optionKey),
        onTap: () => ref
            .read(raceStateProvider.notifier)
            .toggleChoiceOption(group, option),
        onInfoTap: () => showChoiceOptionPlaceholderDialog(
          context: context,
          title: title,
          description: option.description,
        ),
      );
    }).toList();

    final pickCount = group.selectionCount ?? 1;
    if (pickCount <= 1) {
      return CreationChoiceSelector.single(
        title: group.name ?? 'Выбор',
        description: group.description,
        switchKey: group.referenceKey,
        autoScrollOnExpand: !_shouldDisableChoiceAutoScroll(group.type),
        items: items,
      );
    }
    return CreationChoiceSelector.multi(
      title: group.name ?? 'Выбор',
      description: group.description,
      switchKey: group.referenceKey,
      selectionLimit: pickCount,
      autoScrollOnExpand: !_shouldDisableChoiceAutoScroll(group.type),
      items: items,
    );
  }
}

bool _shouldDisableChoiceAutoScroll(ChoiceType? type) {
  return type == ChoiceType.language;
}

int compareChoiceOptions(ChoiceOptionData a, ChoiceOptionData b) {
  final sortCompare = (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0);
  if (sortCompare != 0) return sortCompare;
  return choiceOptionLabel(a).compareTo(choiceOptionLabel(b));
}

String choiceOptionLabel(ChoiceOptionData option) {
  final languages = option.grantedLanguages ?? const <Language>[];
  if (languages.length == 1) return languageLabel(languages.single);
  return option.name ?? option.optionKey;
}

String spellGrantLabel(RaceFeatureSpellGrantData grant) {
  final activation = grant.activation;
  final castAtSpellLevel =
      activation == null ? grant.castAtSpellLevel : activation.castAtSpellLevel;
  final freeCastsFormula = activation == null
      ? grant.freeCastsFormula
      : activation.freeCasts?.toString();
  final freeCastsPerRest =
      activation == null ? grant.freeCastsPerRest : activation.resetOn;
  final canAlsoCastWithSpellSlots = activation == null
      ? grant.canAlsoCastWithSpellSlots == true
      : activation.canUseStandardSlots || activation.canUsePactSlots;
  final parts = <String>[
    grant.spell?.name ?? 'Заклинание',
    if (castAtSpellLevel != null) 'ур. $castAtSpellLevel',
    if (freeCastsFormula?.trim().isNotEmpty == true)
      'бесплатно: $freeCastsFormula',
    if (freeCastsPerRest != null) 'за ${freeCastsPerRest.name}',
    if (canAlsoCastWithSpellSlots) 'можно через ячейки',
  ];
  return parts.join(' • ');
}
