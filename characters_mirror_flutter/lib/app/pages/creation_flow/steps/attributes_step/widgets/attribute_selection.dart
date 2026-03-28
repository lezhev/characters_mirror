import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/common/selection_type.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/state/attribute_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/attribute_names_column.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/bonus_section.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/drag_box.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/drag_target_column.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/manual_input_column.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/purchace_column.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/roll_and_drag_box.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class AttributeSelection extends ConsumerWidget {
  const AttributeSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attributeStateProvider);
    final character = ref.watch(
      characterCreationProvider.select((value) => value.character),
    );
    final raceBonusRecommendation = _resolveRaceBonusRecommendation(character);
    final raceLabel = _buildRaceLabel(character);

    return Expanded(
      child: SingleChildScrollView(
        child: PageSizeLimiter(
          child: Column(
            children: [
              const Gap(8),
              _RaceBonusRecommendationCard(
                raceLabel: raceLabel,
                bonuses: raceBonusRecommendation,
              ),
              const Gap(16),
              _buildRemainingAttributesBlock(
                  state.selectionType, state.remainingValues),
              if (state.selectionType != SelectType.manual)
                PageSizeLimiter(
                  maxWidth: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (state.selectionType == SelectType.purchace)
                        Text(
                          state.purchacePoints.toString(),
                        ),
                      const Gap(40),
                      const Text('+1'),
                      const Gap(32),
                      const Text('+2'),
                      const Gap(20),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: PageSizeLimiter(
                  maxWidth: 400,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AttributeNamesColumn(),
                      const Spacer(),
                      _buildAssignedAttributesBlock(state.selectionType),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRemainingAttributesBlock(
      SelectType type, List<int?> remainingValues) {
    switch (type) {
      case SelectType.random:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(6, (i) => RollOrDragBox(index: i)),
          ),
        );
      case SelectType.defaultType:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: remainingValues.map((value) {
              return Draggable<int>(
                data: value!,
                feedback: Material(
                  color: Colors.transparent,
                  child: DragBox(value, isDragging: true),
                ),
                childWhenDragging: DragBox(value, isDragging: false),
                child: DragBox(value, isDragging: false),
              );
            }).toList(),
          ),
        );
      case SelectType.manual:
        return const SizedBox.shrink();
      case SelectType.purchace:
        return const SizedBox.shrink();
    }
  }

  Widget _buildAssignedAttributesBlock(SelectType type) {
    switch (type) {
      case SelectType.random:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DragTargetColumn(),
            const BounsSection.plusOne(),
            const BounsSection.plusTwo(),
          ],
        );
      case SelectType.defaultType:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DragTargetColumn(),
            const BounsSection.plusOne(),
            const BounsSection.plusTwo(),
          ],
        );
      case SelectType.manual:
        return const ManualInputColumn();
      case SelectType.purchace:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PurchaceColumn(),
            const BounsSection.plusOne(),
            const BounsSection.plusTwo(),
          ],
        );
    }
  }
}

class _RaceBonusRecommendationCard extends StatelessWidget {
  final String? raceLabel;
  final Map<Attribute, int> bonuses;

  const _RaceBonusRecommendationCard({
    required this.raceLabel,
    required this.bonuses,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasRecommendation = bonuses.isNotEmpty;

    return PageSizeLimiter(
      maxWidth: 560,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Рекомендация по расовым бонусам',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(8),
            if (hasRecommendation)
              Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text:
                          'Для ${raceLabel ?? 'выбранной расы'} по правилам лучше выбрать именно ',
                    ),
                    TextSpan(
                      text: _formatBonuses(bonuses),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const TextSpan(
                      text:
                          '. Это базовый вариант по правилам. Часто на практике вместо этого распределяют ',
                    ),
                    const TextSpan(
                      text: '+2 и +1',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const TextSpan(text: ' или '),
                    const TextSpan(
                      text: 'три раза по +1',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const TextSpan(
                      text:
                          ', но это уже более свободный вариант, а не основная рекомендация.',
                    ),
                  ],
                ),
              )
            else
              Text(
                'Сначала выбери расу, чтобы здесь появилась рекомендация по её бонусам к характеристикам.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }
}

Map<Attribute, int> _resolveRaceBonusRecommendation(CharacterData character) {
  final mergedBonuses = <String, int>{
    ...?character.race?.abilityBonuses,
    ...?character.subrace?.abilityBonuses,
  };

  final resolved = <Attribute, int>{};

  for (final entry in mergedBonuses.entries) {
    final attribute =
        Attribute.values.where((value) => value.name == entry.key);
    if (attribute.isEmpty) continue;
    resolved[attribute.first] = entry.value;
  }

  return resolved;
}

String? _buildRaceLabel(CharacterData character) {
  final parts = [
    character.race?.name?.trim(),
    character.subrace?.name?.trim(),
  ].whereType<String>().where((value) => value.isNotEmpty).toList();

  if (parts.isEmpty) return null;
  return parts.join(' / ');
}

String _formatBonuses(Map<Attribute, int> bonuses) {
  final entries = bonuses.entries.toList()
    ..sort((a, b) => Attribute.values.indexOf(a.key).compareTo(
          Attribute.values.indexOf(b.key),
        ));

  return entries
      .map((entry) =>
          '${entry.key.getTitle()} ${entry.value >= 0 ? '+' : ''}${entry.value}')
      .join(', ');
}
