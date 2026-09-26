import 'dart:math' as math;

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_portrait/character_portrait.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_personal_editor.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_proficiencies_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_proficiency_summary.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/class_race_details_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/class_race_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:characters_mirror_flutter/features/character_portrait/presentation/widgets/character_portrait_editor.dart';

class CharacterPage extends ConsumerWidget {
  const CharacterPage({
    required this.characterId,
    super.key,
  });

  final int characterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterSheetControllerProvider(characterId));

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _CharacterPageErrorState(
        message: humanReadableError(error),
        onRetry: () => ref
            .read(characterSheetControllerProvider(characterId).notifier)
            .reload(),
      ),
      data: (character) {
        final toolNames = {
          for (final tool in ref.watch(toolCatalogProvider).valueOrNull ??
              const <ToolData>[])
            tool.referenceKey: tool.name,
        };
        final weaponNames = {
          for (final weapon in ref.watch(weaponCatalogProvider).valueOrNull ??
              const <WeaponData>[])
            if (weapon.referenceKey != null && weapon.name != null)
              weapon.referenceKey!: weapon.name!,
        };
        return Padding(
          padding: const EdgeInsets.all(12),
          child: PageSizeLimiter(
            child: ListView(
              children: [
                _PortraitBlock(
                  characterId: characterId,
                ),
                const SizedBox(height: 16),
                _ClassRaceSummaryBlock(
                  character: character,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => ClassRaceDetailsPage(
                          character: character,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                CharacterProficiencySummary(
                  character: character,
                  toolNames: toolNames,
                  weaponNames: weaponNames,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => CharacterProficienciesPage(
                          characterId: characterId,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                CharacterPersonalEditor(
                  character: character,
                  onChanged: ref
                      .read(
                        characterSheetControllerProvider(characterId).notifier,
                      )
                      .savePersonalInfo,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ClassRaceSummaryBlock extends StatelessWidget {
  const _ClassRaceSummaryBlock({
    required this.character,
    required this.onTap,
  });

  final CharacterData character;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Класс и раса',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    _SummaryLine(
                      value: classSummary(character.classEntries),
                    ),
                    const SizedBox(height: 4),
                    _SummaryLine(
                      value: raceSummary(character.race, character.subrace),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.chevron_right,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _CharacterPageErrorState extends StatelessWidget {
  const _CharacterPageErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onRetry,
              child: const Text('Попробовать снова'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PortraitBlock extends StatelessWidget {
  const _PortraitBlock({
    required this.characterId,
  });

  final int characterId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CharacterPortrait(
              characterId: characterId,
              size: 96,
              borderRadius: 12,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Портрет',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Изображение персонажа',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.tonalIcon(
                    onPressed: () {
                      _showPortraitEditor(
                        context,
                        characterId,
                      );
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Изменить'),
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

Future<void> _showPortraitEditor(
  BuildContext context,
  int characterId,
) {
  final screenSize = MediaQuery.sizeOf(context);

  return showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        child: SizedBox(
          width: math.min(640, screenSize.width - 48),
          height: math.min(640, screenSize.height - 96),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CharacterPortraitEditor(
              characterId: characterId,
              onUploaded: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ),
        ),
      );
    },
  );
}
