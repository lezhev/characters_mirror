import 'package:characters_mirror_shared/characters_mirror_shared.dart'
    show subclassDisplayName;
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/background_step/application/background_icon_asset_path.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/summary_step/application/summary_overview_data.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SummaryOverview extends StatelessWidget {
  const SummaryOverview({
    required this.data,
    required this.onEdit,
    required this.onPortraitTap,
    super.key,
  });

  final SummaryOverviewData data;
  final ValueChanged<Step> onEdit;
  final VoidCallback onPortraitTap;

  @override
  Widget build(BuildContext context) {
    final classData = data.classEntry?.classData;
    final race = data.character.race;
    final background = data.character.background;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SummaryHeroCard(
          key: const ValueKey('summary-hero-card'),
          name: data.displayName,
          level: data.characterLevel,
          missingLabels:
              data.missingFields.map((field) => field.label).toList(),
          onMissingTap: () {
            final target = data.firstMissingStep;
            if (target != null) onEdit(target);
          },
          onPortraitTap: onPortraitTap,
        ),
        const Gap(20),
        SummaryEntityCard(
          key: const ValueKey('summary-class-card'),
          iconKey: 'class',
          title: 'Класс / Подкласс',
          value: classData?.name ?? 'Не выбрано',
          detail: _classDetail(data),
          detailIcon: data.subclassIsLocked ? Icons.lock_outline_rounded : null,
          isMissing: classData == null || data.subclassIsMissing,
          icon:
              classData?.imageURL == null ? Icons.auto_awesome_outlined : null,
          iconAssetPath: _assetPath('assets/svg/classes', classData?.imageURL),
          onTap: () => onEdit(Step.classStep),
        ),
        const Gap(12),
        SummaryEntityCard(
          key: const ValueKey('summary-race-card'),
          iconKey: 'race',
          title: 'Раса / Подраса',
          value: race?.name ?? 'Не выбрано',
          detail: _raceDetail(data),
          isMissing: race == null ||
              (data.hasSubraceOptions && data.character.subrace == null),
          icon: race?.imageURL == null ? Icons.pets_outlined : null,
          iconAssetPath: _assetPath('assets/svg/races', race?.imageURL),
          onTap: () => onEdit(Step.race),
        ),
        const Gap(12),
        SummaryEntityCard(
          key: const ValueKey('summary-background-card'),
          iconKey: 'background',
          title: 'Предыстория',
          value: background?.name ?? 'Не выбрано',
          detail: background == null ? 'Можно выбрать позже' : null,
          isMissing: background == null,
          icon: Icons.menu_book_outlined,
          iconAssetPath: background == null
              ? null
              : backgroundIconAssetPath(background.name),
          onTap: () => onEdit(Step.background),
        ),
        const Gap(12),
        SummaryAbilitiesCard(
          scores: data.abilityScores,
          hasAnyScore: data.hasAbilityScores,
          isComplete: data.hasCompleteAbilityScores,
          onTap: () => onEdit(Step.attributes),
        ),
      ],
    );
  }
}

class SummaryHeroCard extends StatelessWidget {
  const SummaryHeroCard({
    required this.name,
    required this.level,
    required this.missingLabels,
    required this.onMissingTap,
    required this.onPortraitTap,
    super.key,
  });

  final String name;
  final int level;
  final List<String> missingLabels;
  final VoidCallback onMissingTap;
  final VoidCallback onPortraitTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final portraitWidth = constraints.maxWidth < 300
            ? 88.0
            : constraints.maxWidth < 400
                ? 104.0
                : 136.0;
        final portraitHeight = portraitWidth * 1.42;
        return Material(
          color: colors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _PortraitPlaceholder(
                  width: portraitWidth,
                  height: portraitHeight,
                  onTap: onPortraitTap,
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        key: const ValueKey('summary-character-name'),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const Gap(8),
                      Divider(color: colors.outlineVariant, height: 1),
                      const Gap(8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primaryContainer,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'Уровень $level',
                          key: const ValueKey('summary-character-level'),
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: colors.onPrimaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      if (missingLabels.isNotEmpty) ...[
                        const Gap(8),
                        SummaryMissingInfoCard(
                          labels: missingLabels,
                          onTap: onMissingTap,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SummaryMissingInfoCard extends StatelessWidget {
  const SummaryMissingInfoCard({
    required this.labels,
    required this.onTap,
    super.key,
  });

  final List<String> labels;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.primaryContainer,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        key: const ValueKey('summary-missing-info'),
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  size: 17, color: colors.onPrimaryContainer),
              const Gap(6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Не выбрано: ${labels.join(', ')}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: colors.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Gap(4),
                    Text(
                      'Заполнить сейчас',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colors.onPrimaryContainer,
                          ),
                    ),
                  ],
                ),
              ),
              const Gap(4),
              Icon(Icons.chevron_right,
                  size: 18, color: colors.onPrimaryContainer),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryEntityCard extends StatelessWidget {
  const SummaryEntityCard({
    required this.title,
    required this.value,
    required this.iconKey,
    required this.isMissing,
    required this.onTap,
    this.detail,
    this.detailIcon,
    this.icon,
    this.iconAssetPath,
    super.key,
  });

  final String title;
  final String value;
  final String iconKey;
  final String? detail;
  final IconData? detailIcon;
  final bool isMissing;
  final IconData? icon;
  final String? iconAssetPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 6, 12, 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _SummaryIcon(
                key: ValueKey('summary-icon-$iconKey'),
                icon: icon,
                assetPath: iconAssetPath,
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                    ),
                    const Gap(3),
                    Text(
                      value,
                      key: ValueKey('summary-value-$title'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isMissing
                                ? colors.onSurfaceVariant
                                : colors.onSurface,
                          ),
                    ),
                    if (detail != null) ...[
                      const Gap(3),
                      Row(
                        children: [
                          if (detailIcon != null) ...[
                            Icon(
                              detailIcon,
                              key: ValueKey('summary-detail-icon-$title'),
                              size: 14,
                              color: colors.onSurfaceVariant,
                            ),
                            const Gap(4),
                          ],
                          Expanded(
                            child: Text(
                              detail!,
                              key: ValueKey('summary-detail-$title'),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: colors.onSurfaceVariant),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const Gap(8),
              Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryAbilitiesCard extends StatelessWidget {
  const SummaryAbilitiesCard({
    required this.scores,
    required this.hasAnyScore,
    required this.isComplete,
    required this.onTap,
    super.key,
  });

  final Map<String, int> scores;
  final bool hasAnyScore;
  final bool isComplete;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        key: const ValueKey('summary-attributes-card'),
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SummaryIcon(
                key: const ValueKey('summary-icon-attributes'),
                icon: Icons.casino_outlined,
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Характеристики',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                    ),
                    if (!hasAnyScore) ...[
                      const Gap(4),
                      Text(
                        'Не распределены',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: colors.onSurfaceVariant,
                                ),
                      ),
                      Text(
                        'Можно распределить позже',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                      ),
                    ] else ...[
                      const Gap(10),
                      _AbilityScoreGrid(scores: scores),
                      if (!isComplete) ...[
                        const Gap(4),
                        Text(
                          'Часть характеристик не распределена',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: colors.onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
              const Gap(8),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child:
                    Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AbilityScoreGrid extends StatelessWidget {
  const _AbilityScoreGrid({required this.scores});

  final Map<String, int> scores;

  static const _abilities = <(String, String)>[
    ('strength', 'СИЛ'),
    ('dexterity', 'ЛОВ'),
    ('constitution', 'ТЕЛ'),
    ('intelligence', 'ИНТ'),
    ('wisdom', 'МДР'),
    ('charisma', 'ХАР'),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const ValueKey('summary-ability-grid'),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _abilities.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 66,
        crossAxisSpacing: 6,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final (key, abbreviation) = _abilities[index];
        return _AbilityScoreCell(
          ability: key,
          abbreviation: abbreviation,
          score: scores[key]?.toString() ?? '—',
        );
      },
    );
  }
}

class _AbilityScoreCell extends StatelessWidget {
  const _AbilityScoreCell({
    required this.ability,
    required this.abbreviation,
    required this.score,
  });

  final String ability;
  final String abbreviation;
  final String score;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      key: ValueKey('summary-ability-cell-$ability'),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: colors.outlineVariant.withValues(alpha: 0.45)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            abbreviation,
            key: ValueKey('summary-ability-label-$ability'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant.withValues(alpha: 0.78),
                  fontWeight: FontWeight.w300,
                ),
          ),
          const SizedBox(height: 1),
          Expanded(
            child: Center(
              child: Text(
                score,
                key: ValueKey('summary-ability-score-$ability'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PortraitPlaceholder extends StatelessWidget {
  const _PortraitPlaceholder({
    required this.width,
    required this.height,
    required this.onTap,
  });

  final double width;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.surfaceContainer,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: const ValueKey('summary-portrait-placeholder'),
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.outlineVariant, width: 1.5),
          ),
          child: Center(
            child: Icon(
              Icons.person_outline_rounded,
              size: width * 0.62,
              color: colors.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryIcon extends StatelessWidget {
  const _SummaryIcon({this.icon, this.assetPath, super.key});

  final IconData? icon;
  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final foreground = colors.surfaceContainerLowest;
    final fallback = Icon(
      icon ?? Icons.auto_awesome_outlined,
      color: foreground,
      size: 52,
    );
    return Container(
      width: 84,
      height: 84,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: assetPath == null
          ? fallback
          : SvgPicture.asset(
              assetPath!,
              width: 78,
              height: 78,
              colorFilter: ColorFilter.mode(foreground, BlendMode.srcIn),
              placeholderBuilder: (_) => fallback,
              errorBuilder: (_, __, ___) => fallback,
            ),
    );
  }
}

String? _classDetail(SummaryOverviewData data) {
  final subclass = subclassDisplayName(
      data.classEntry?.subclass?.subclassName, data.classEntry?.subclass?.name);
  if (subclass != null && subclass.trim().isNotEmpty) return subclass;
  if (data.classEntry?.classData == null) return 'Можно выбрать позже';
  if (data.subclassIsLocked) return 'Подкласс откроется позже';
  if (data.subclassIsMissing) return 'Подкласс не выбран';
  return null;
}

String? _raceDetail(SummaryOverviewData data) {
  final subrace = data.character.subrace?.name;
  if (subrace != null && subrace.trim().isNotEmpty) return subrace;
  if (data.character.race == null) return 'Можно выбрать позже';
  if (data.hasSubraceOptions) return 'Подраса не выбрана';
  return null;
}

String? _assetPath(String directory, String? imageName) {
  final name = imageName?.trim();
  if (name == null || name.isEmpty) return null;
  return '$directory/$name.svg';
}
