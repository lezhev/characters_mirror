import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/features/characters/presentation/widgets/character_tile/character_meta_chip.dart';
import 'package:characters_mirror_flutter/features/characters/presentation/widgets/character_tile/character_tile_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CharacterTile extends StatelessWidget {
  const CharacterTile({
    required this.character,
    required this.offlineRecord,
    required this.isDeleteArmed,
    required this.isDeleting,
    super.key,
    this.onTap,
    this.onDeleteIntent,
    this.onDeleteMenuDismissed,
    this.onDeleteConfirm,
  });

  final CharacterData character;
  final OfflineCharacterRecord? offlineRecord;
  final bool isDeleteArmed;
  final bool isDeleting;
  final VoidCallback? onTap;
  final VoidCallback? onDeleteIntent;
  final VoidCallback? onDeleteMenuDismissed;
  final VoidCallback? onDeleteConfirm;

  @override
  Widget build(BuildContext context) {
    final metadataItems = characterMetadataItems(character);

    return CharacterTileCard(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    'assets/svg/placeholder.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          characterName(character),
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Gap(8),
                      CharacterTileMenuButton(
                        isDeleteArmed: isDeleteArmed,
                        isDeleting: isDeleting,
                        onDeleteIntent: onDeleteIntent,
                        onMenuDismissed: onDeleteMenuDismissed,
                        onDeleteConfirm: onDeleteConfirm,
                      ),
                    ],
                  ),
                  const Gap(4),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      for (final item in metadataItems)
                        CharacterMetaChip(label: item),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterTileCard extends HookWidget {
  const CharacterTileCard({
    required this.child,
    super.key,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          splashColor:
              colorScheme.surfaceContainerHighest.withValues(alpha: 0.92),
          highlightColor: Colors.transparent,
          child: AppSurfaceCard(
            padding: EdgeInsets.zero,
            backgroundColor: colorScheme.surfaceContainerHighest,
            border: Border.all(
              color:
                  isHovered.value ? colorScheme.primary : colorScheme.outline,
              width: 1,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: 104,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.inversePrimary
                        .withValues(alpha: isHovered.value ? 0.2 : 0),
                    blurRadius: isHovered.value ? 4 : 0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

String characterName(CharacterData character) {
  final trimmed = character.name?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return 'Без имени';
  }
  return trimmed;
}

List<String> characterMetadataItems(CharacterData character) {
  final items = <String>[];
  final raceLabel = characterRaceSummary(character);
  if (raceLabel != null) {
    items.add(raceLabel);
  }

  items.addAll(characterClassSummaries(character));
  if (items.isEmpty) {
    items.add('Не заполнено');
  }

  return items;
}

List<String> characterClassSummaries(CharacterData character) {
  final indexedEntries = [...?character.classEntries].asMap().entries.toList();
  if (indexedEntries.isEmpty) {
    return const ['Класс не выбран'];
  }

  indexedEntries.sort((left, right) {
    final orderCompare =
        (left.value.classOrder ?? 0).compareTo(right.value.classOrder ?? 0);
    if (orderCompare != 0) {
      return orderCompare;
    }
    return left.key.compareTo(right.key);
  });

  return indexedEntries.map((item) {
    final entry = item.value;
    final className = entry.classData?.name?.trim();
    final displayName = (className == null || className.isEmpty)
        ? 'Неизвестный класс'
        : className;
    final level = entry.level ?? 0;
    return '$displayName $level';
  }).toList();
}

String? characterRaceSummary(CharacterData character) {
  final raceName = character.race?.name?.trim();
  if (raceName != null && raceName.isNotEmpty) {
    return raceName;
  }
  return null;
}
