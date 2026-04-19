import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_personal_editor.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/class_race_details_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/class_race_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        return Padding(
          padding: const EdgeInsets.all(12),
          child: PageSizeLimiter(
            child: ListView(
              children: [
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
