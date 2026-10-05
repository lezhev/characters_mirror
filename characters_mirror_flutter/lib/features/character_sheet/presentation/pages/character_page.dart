import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_class_race_summary.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_experience_summary.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_personal_summary.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_proficiencies_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_portrait_tile.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_proficiency_summary.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_personal_editor_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/class_race_details_page.dart';
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
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          child: PageSizeLimiter(
            child: ListView(
              children: [
                CharacterExperienceSummary(
                  character: character,
                  onTap: null,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 112,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CharacterPortraitTile(characterId: characterId),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CharacterClassRaceSummary(
                          character: character,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => ClassRaceDetailsPage(
                                character: character,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                CharacterProficiencySummary(
                  character: character,
                  toolNames: toolNames,
                  weaponNames: weaponNames,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => CharacterProficienciesPage(
                        characterId: characterId,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CharacterPersonalSummary(
                  character: character,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => CharacterPersonalEditorPage(
                        character: character,
                        onChanged: ref
                            .read(
                              characterSheetControllerProvider(characterId)
                                  .notifier,
                            )
                            .savePersonalInfo,
                      ),
                    ),
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
            Text(message, textAlign: TextAlign.center),
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
