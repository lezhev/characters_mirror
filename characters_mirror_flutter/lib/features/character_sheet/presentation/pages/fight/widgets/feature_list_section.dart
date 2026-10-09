import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/character_feature_card.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/spell_slot_recovery_actions.dart';
import 'package:flutter/material.dart';

class FeatureListSection extends StatelessWidget {
  const FeatureListSection({
    required this.activeFeatures,
    required this.visibleFeatures,
    required this.onOpenAllAbilities,
    required this.onSaveFeature,
    required this.onResetFeature,
    required this.onSetFeatureResource,
    required this.canRecoverFeatureResource,
    required this.onRecoverFeatureResource,
    this.characterId,
    super.key,
  });

  final List<CharacterFeatureViewData> activeFeatures;
  final int? characterId;
  final bool Function(
    CharacterFeatureViewData feature,
    CharacterResourceViewData resource,
  ) canRecoverFeatureResource;
  final Future<void> Function(
    CharacterFeatureViewData feature,
    CharacterResourceViewData resource,
  ) onRecoverFeatureResource;
  final List<CharacterFeatureViewData> visibleFeatures;
  final VoidCallback onOpenAllAbilities;
  final Future<void> Function(
    CharacterFeatureViewData feature, {
    String? name,
    String? description,
    List<FeatureTag>? tags,
  }) onSaveFeature;
  final Future<void> Function(CharacterFeatureViewData feature) onResetFeature;
  final Future<void> Function(
    CharacterFeatureViewData feature,
    String resourceKey,
    int current,
  ) onSetFeatureResource;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: 'Способности',
          showDivider: false,
          trailing: IconButton(
            onPressed: onOpenAllAbilities,
            icon: Icon(Icons.tune,
                size: 20,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: 12),
        if (activeFeatures.isEmpty)
          Text(
            'Способности появятся после выбора класса или расы.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        if (activeFeatures.isNotEmpty && visibleFeatures.isEmpty)
          Text(
            'Нет способностей по выбранным тегам.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        for (var index = 0; index < visibleFeatures.length; index++) ...[
          CharacterFeatureCard(
            feature: visibleFeatures[index],
            actions: characterId == null
                ? null
                : SpellSlotRecoveryActions(
                    characterId: characterId!, feature: visibleFeatures[index]),
            canSpendResource: (resource) => canRecoverFeatureResource(
              visibleFeatures[index],
              resource,
            ),
            onSpendResource: (resource) => onRecoverFeatureResource(
              visibleFeatures[index],
              resource,
            ),
            onSave: ({
              String? name,
              String? description,
              List<FeatureTag>? tags,
            }) {
              return onSaveFeature(
                visibleFeatures[index],
                name: name,
                description: description,
                tags: tags,
              );
            },
            onReset: () => onResetFeature(visibleFeatures[index]),
            onSetResource: (resourceKey, current) {
              return onSetFeatureResource(
                visibleFeatures[index],
                resourceKey,
                current,
              );
            },
          ),
          if (index < visibleFeatures.length - 1) const SizedBox(height: 8),
        ],
      ],
    );
  }
}
